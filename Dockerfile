FROM mcr.microsoft.com/dotnet/core/sdk:3.1.409-focal as tools
RUN dotnet tool install --tool-path /tools dotnet-trace
RUN dotnet tool install --tool-path /tools dotnet-dump
RUN dotnet tool install --tool-path /tools dotnet-counters

FROM mcr.microsoft.com/dotnet/core/runtime:3.1.9-focal AS runtime
RUN adduser --system --disabled-password sitecore

COPY --from=tools /tools /tools
RUN chmod -R 777 /tools
USER sitecore
ENV PATH="/tools:${PATH}"
WORKDIR /data