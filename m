Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E5969FC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjBVTpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjBVTpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:45:17 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839502449D;
        Wed, 22 Feb 2023 11:45:16 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id x10so34189940edd.13;
        Wed, 22 Feb 2023 11:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZyTcMEKJ9V1BAkPuHQaR9dBpfaKfinikOJsJhpQNlo=;
        b=LIgR5phheK+5ztU4clqEzLpVVXUc/0e9BZYVUxzRRMP8n7tGj3lw0MQCEuuquWAilN
         yttdRVJ9PP4j2hmdQxdFHOUvWhQhkGDWZwaAriEWTOPg1k9ICGek9QQPHyaYB305UhMQ
         ZT5zLelRdkDeJW5N9QVhF2YQ66+BDu4x4zoeawHyBFdlUNd/iRiFCZ9yrknu7SD95lfR
         Z4Ss52X72ImVt8kn5qjreMiRZESn80wR8AcKKJKrcYlFV1/I+c6LG+QUPdogPODKT3SK
         X5lWLNnhVkw0PeAmUXz3jMAKVtx5eGTHy9wYjVpRf7tuEthaNeO184Dh4pB3KLzTsf8s
         2Ccg==
X-Gm-Message-State: AO0yUKWY//BlrMqcrREqBLWXWXaVSI4IacJB0X0U78qCUosAqci90qWx
        6Zp0rp7Hp4WUcZTj0O03A84cII5Pi9IaaLgcS1E=
X-Google-Smtp-Source: AK7set/jqWeJZTCiiF1y9dAOCJaEhJtoPYUWZ+aAB9xKwl3KlfYKCZE9ZFATC4CbmkPF4+FL7V2jQA253hmi+X9+1tQ=
X-Received: by 2002:a50:9f6a:0:b0:4ae:e548:1c6 with SMTP id
 b97-20020a509f6a000000b004aee54801c6mr4413581edf.6.1677095114951; Wed, 22 Feb
 2023 11:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org> <20230221180710.2781027-9-daniel.lezcano@linaro.org>
In-Reply-To: <20230221180710.2781027-9-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Feb 2023 20:45:03 +0100
Message-ID: <CAJZ5v0jNBtvbTreQWXa7ssBJzFbnQOSDBx0hVEP7rPnTZvUsNw@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] thermal: Add a thermal zone id accessor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 7:08 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> In order to get the thermal zone id but without directly accessing the
> thermal zone device structure, add an accessor.
>
> Use the accessor from the hwmon_scmi
>
> No functional change intented.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/hwmon/scmi-hwmon.c     | 2 +-
>  drivers/thermal/thermal_core.c | 6 ++++++
>  include/linux/thermal.h        | 2 ++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index 046ac157749d..6681478ea41c 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -220,7 +220,7 @@ static int scmi_thermal_sensor_register(struct device *dev,
>                         sensor->name);
>         } else {
>                 dev_dbg(dev, "Sensor '%s' attached to thermal zone ID:%d\n",
> -                       sensor->name, tzd->id);
> +                       sensor->name, thermal_zone_device_get_id(tzd));
>         }
>
>         return 0;
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9fa12147fead..73b7a060f768 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1384,6 +1384,12 @@ void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_priv);
>
> +int thermal_zone_device_get_id(struct thermal_zone_device *tzd)
> +{
> +       return tzd->id;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_device_get_id);
> +
>  /**
>   * thermal_zone_device_unregister - removes the registered thermal zone device
>   * @tz: the thermal zone device to remove
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 7dbb5712434c..321aa3c71f58 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -367,6 +367,8 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
>
>  void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
>
> +int thermal_zone_device_get_id(struct thermal_zone_device *tzd);
> +
>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
>                                      struct thermal_cooling_device *,
>                                      unsigned long, unsigned long,
> --
> 2.34.1
>
