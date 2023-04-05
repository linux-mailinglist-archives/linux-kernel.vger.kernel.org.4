Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EBD6D8607
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjDESc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjDEScY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:32:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA11A10E6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:32:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r29so37102489wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680719541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2WvIYrTnKSSwYFbqQbh2QUiuKuHXaFjFbgHn4TTUZw=;
        b=NmYvdDE6YuUvfzdXcWpDcL1pUxI6SzxixRO5b5hg97oym4B6zvxcGIp1LLisTP5ndG
         Gx/qN6WvFu82/Qttg5rTF8/CN0z6T2ZIxQ0JByU/eE5odppxYR6GRfUHHmlMi+oSf568
         ZtDkhPQwLrZEuYANs6anGhpvPVjDc9wlAXTBeZojw06neT50PN5BGm4Ipm3ZiQ/YYi+Q
         g5YrtVO85abwV4AKBILJ9Yt8sPshqCOI65iKPAwRSjyMDKYbxqvyMRpgiQKgRVJPjVwr
         6ZwKt67GV2efB2Ao2mncUqfaKhP0Rdgh7CCHpvEd9jrdzXicAwVwpEB629ps1xtF1OdX
         t5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680719541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2WvIYrTnKSSwYFbqQbh2QUiuKuHXaFjFbgHn4TTUZw=;
        b=fMBZprpMfo1DW0p2CSjba4jGwEo+BMFPeaOd4yLLoYQZQmgjw2Q0JVHnEpC4Pqx8LA
         iySodNg/YN34tstlZeHn8AXpRJwqIElZiV+BKtKkQSh4LXKB8Eb9jO+tUsRx3wedh0Fo
         9EZdnZAfZV0sg7bntObP/x3gh08vmNCdPirLKabM7qYYGc4RmGn0DUnHj7EV+CYMg3N2
         HaJEaTUqVVxu0Y7FdseSN0lVS5QDhTej+7KhG0TnqthZHRHgqRH1+On5yU0RwWV5xnvB
         YNpQ+MnigZf1FsBZvnZ825/yFSVaYnGGYGECOcmXCuTuGBsYn5FJVMz9igusUiiX7/lY
         ysig==
X-Gm-Message-State: AAQBX9e3uqbYCe565YBHmimDZp42gOzLFI8ySiAlG3vx9ZlYNRIhsi/b
        lpgDl1RhNrxzfYILoCQ+pXhszw==
X-Google-Smtp-Source: AKy350ZxabPesATfDIB1W2CzsiR0amy27LOAm4Qv1zMDVO4+Zh/pIl+T7/SQdFgGuIIKtWjakoUE7A==
X-Received: by 2002:adf:e643:0:b0:2ce:9f35:b645 with SMTP id b3-20020adfe643000000b002ce9f35b645mr4920966wrn.20.1680719541175;
        Wed, 05 Apr 2023 11:32:21 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6630:ee96:3710:24c8? ([2a05:6e02:1041:c10:6630:ee96:3710:24c8])
        by smtp.googlemail.com with ESMTPSA id v8-20020a5d4a48000000b002c557f82e27sm15533566wrs.99.2023.04.05.11.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 11:32:20 -0700 (PDT)
Message-ID: <3e64e6b2-7c3f-d149-2f7d-6c41be4c4d14@linaro.org>
Date:   Wed, 5 Apr 2023 20:32:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] thermal for v6.4-rc1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yang Li <yang.lee@linux.alibaba.com>
References: <ab323c72-61f9-9ac6-48ce-366f62e82091@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ab323c72-61f9-9ac6-48ce-366f62e82091@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

just a gentle reminder because more material will come in the next days

Thanks

   -- Daniel


On 01/04/2023 21:04, Daniel Lezcano wrote:
> The following changes since commit 
> 2b6db9efa50799fa75ce609f24b355f29504bd9a:
> 
>    Merge branch 'thermal-core' into thermal (2023-03-08 14:03:56 +0100)
> 
> are available in the Git repository at:
> 
> 
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
> tags/thermal-v6.4-rc1-1
> 
> for you to fetch changes up to 0c492be4002b7411a1587b429e68e0cf3f562488:
> 
>    thermal/drivers/ti: Use fixed update interval (2023-04-01 20:51:45 
> +0200)
> 
> ----------------------------------------------------------------
> - Add more thermal zone device encapsulation: prevent setting
>    structure field directly, access the sensor device instead the
>    thermal zone's device for trace, relocate the traces in
>    drivers/thermal (Daniel Lezcano)
> 
> - Use the generic trip point for the i.MX and remove the get_trip_temp
>    ops (Daniel Lezcano)
> 
> - Use the devm_platform_ioremap_resource() in the Hisilicon driver
>    (Yang Li)
> 
> - Remove R-Car H3 ES1.* handling as public has only access to the ES2
>    version and the upstream support for the ES1 has been shutdown 
> (Wolfram Sang)
> 
> - Add a delay after initializing the bank in order to let the time to
>    the hardware to initialze itself before reading the temperature
>    (Amjad Ouled-Ameur)
> 
> - Add MT8365 support (Amjad Ouled-Ameur)
> 
> ----------------------------------------------------------------
> Amjad Ouled-Ameur (1):
>        thermal/drivers/mediatek: Add delay after thermal banks 
> initialization
> 
> Daniel Lezcano (6):
>        thermal/drivers/imx: Remove get_trip_temp ops
>        thermal/drivers/imx: Use the thermal framework for the trip point
>        thermal/core: Relocate the traces definition in thermal directory
>        thermal/drivers/db8500: Use driver dev instead of tz->device
>        thermal/drivers/stm: Don't set no_hwmon to false
>        thermal/drivers/ti: Use fixed update interval
> 
> Fabien Parent (2):
>        dt-bindings: thermal: mediatek: Add binding documentation for 
> MT8365 SoC
>        thermal/drivers/mediatek: Add support for MT8365 SoC
> 
> Markus Schneider-Pargmann (1):
>        thermal/drivers/mediatek: Control buffer enablement tweaks
> 
> Wolfram Sang (1):
>        thermal/drivers/rcar_gen3_thermal: Remove R-Car H3 ES1.* handling
> 
> Yang Li (1):
>        thermal/drivers/hisi: Use devm_platform_ioremap_resource()
> 
>   .../bindings/thermal/mediatek-thermal.txt          |   1 +
>   drivers/thermal/Makefile                           |   3 +-
>   drivers/thermal/cpufreq_cooling.c                  |   2 +-
>   drivers/thermal/db8500_thermal.c                   |   7 +-
>   drivers/thermal/devfreq_cooling.c                  |   2 +-
>   drivers/thermal/gov_fair_share.c                   |   2 +-
>   drivers/thermal/gov_power_allocator.c              |   2 +-
>   drivers/thermal/gov_step_wise.c                    |   2 +-
>   drivers/thermal/hisi_thermal.c                     |   4 +-
>   drivers/thermal/imx_thermal.c                      |  19 ++--
>   drivers/thermal/mediatek/auxadc_thermal.c          | 107 
> +++++++++++++++++----
>   drivers/thermal/rcar_gen3_thermal.c                |  52 +---------
>   drivers/thermal/st/stm_thermal.c                   |   1 -
>   drivers/thermal/thermal_core.c                     |   2 +-
>   drivers/thermal/thermal_helpers.c                  |   3 +-
>   .../thermal.h => drivers/thermal/thermal_trace.h   |   6 ++
>   .../thermal/thermal_trace_ipa.h                    |   6 ++
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   8 +-
>   18 files changed, 131 insertions(+), 98 deletions(-)
>   rename include/trace/events/thermal.h => 
> drivers/thermal/thermal_trace.h (97%)
>   rename include/trace/events/thermal_power_allocator.h => 
> drivers/thermal/thermal_trace_ipa.h (96%)
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

