Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF0E671993
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjARKtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjARKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:47:54 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EACF8765E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:53:24 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o17-20020a05600c511100b003db021ef437so1057148wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Q41RJO+h6k6168ZraYXL447AhJRg2Xc99d/LkAs2QQ=;
        b=zZExUtYo13Lftddlf2ihuNmYpS0Nyd8EwbRqQrir7eyUpvzVLcrs5c8Ghb7UfQhjnX
         DBaD13z+/BdA5f+AUtyVBM5b7vQX9ijTuUM2SgnkDlFVSYAdYTaAI6ZFU0gy2Le4j/Xw
         jZXoupP5fVegQtzuFzfA8jA5ka/RTxJABF9Q7Q5e2AIe3oeTUjASzmfx3IdZbFJGiuS1
         xpvviT7mPv4LTdZZokHfqh2WXzoHWsDYNLAokkhmsRXByX6aImvhL1eEukwXojX8KUdu
         PFPTZHLtKJo22/f/lL5ryjXZkH5vrSm5jzwJvv4JAOJI7o2RuUKiTYHiyK3GzSXZCN6F
         vYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Q41RJO+h6k6168ZraYXL447AhJRg2Xc99d/LkAs2QQ=;
        b=wYLEBnpVzPcUmfENYDfAm5DTxnfieTd4/X3hpiLx7bx5uFqDLDUXnJKYf1Qkh53OQC
         Xad31SRExzXzPpizCaWxHIKBmoFZCgbdtqzq2cOkw9/vzIT9w8LGG1LRK8KPqDlhS7ef
         RGluNKpvFy/14PuXJnHJdA3qcddDhbkVucpj1Cr1eLZJiOO4r7Z98qg/arkf9Bykaspn
         M4JQPbBPAzoIXGDQACZq4eQeOxMABNzvRWyNIzs7Meh5CCiZP39vg/bxBksqhlSoSQrM
         GKxU6kT/Er0GwYGy/Fdiz0nEm571eF2Q89BkKQIVJwGL4xbpIbTsyqhMQK+C8eOu8bUD
         Cf3Q==
X-Gm-Message-State: AFqh2kqAinB+YAP1bwxb+IGHffjjzVr4AIyIZrdDJyvTA3O5J2uOVhvC
        0bykit2+ztnc1jfwI8Hk8VpnGg==
X-Google-Smtp-Source: AMrXdXucG64+L7me1kWC4dE8dfpb4nk5JzCJtlsAOZgJwOTPPQqnllak5CBIbFFnecncg6lqmMPlHw==
X-Received: by 2002:a05:600c:331d:b0:3d3:591a:bfda with SMTP id q29-20020a05600c331d00b003d3591abfdamr14722922wmp.27.1674035602762;
        Wed, 18 Jan 2023 01:53:22 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f3-20020adfdb43000000b00236883f2f5csm31401173wrj.94.2023.01.18.01.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 01:53:22 -0800 (PST)
Message-ID: <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
Date:   Wed, 18 Jan 2023 10:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
Content-Language: en-US
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, christophe.jaillet@wanadoo.fr
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/01/2023 19:02, Daniel Lezcano wrote:
> Recently sent as a RFC, the thermal ACPI for generic trip points is a set of
> functions to fill the generic trip points structure which will become the
> standard structure for the thermal framework and its users.
> 
> Different Intel drivers and the ACPI thermal driver are using the ACPI tables to
> get the thermal zone information. As those are getting the same information,
> providing this set of ACPI function with the generic trip points will
> consolidate the code.
> 
> Also, the Intel PCH and the Intel 34xx drivers are converted to use the generic
> trip points relying on the ACPI generic trip point parsing functions.
> 
> These changes have been tested on a Thinkpad Lenovo x280 with the PCH and
> INT34xx drivers. No regression have been observed, the trip points remain the
> same for what is described on this system.

Are we ok with this series ?

Sorry for insisting but I would like to go forward with the generic 
thermal trip work. There are more patches pending depending on this series.

Thanks
   -- Daniel

> Changelog:
>   - V5:
>     - Fixed GTSH unit conversion, deciK -> milli C
> 
>   - V4:
>     - Fixed Kconfig option dependency, select THERMAL_ACPI if ACPI is set
>       only for the PCH driver
> 
>   - V3:
>     - Took into account Rafael's comments
>     - Used a silence option THERMAL_ACPI in order to stay consistent
>       with THERMAL_OF. It is up to the API user to select the option.
> 
>   - V2:
>     - Fix the thermal ACPI patch where the thermal_acpi.c was not included in
>       the series
>     - Provide a couple of users of this API which could have been tested on a
>       real system
> 
> Daniel Lezcano (3):
>    thermal/acpi: Add ACPI trip point routines
>    thermal/drivers/intel: Use generic trip points for intel_pch
>    thermal/drivers/intel: Use generic trip points int340x
> 
>   drivers/thermal/Kconfig                       |   4 +
>   drivers/thermal/Makefile                      |   1 +
>   drivers/thermal/intel/Kconfig                 |   1 +
>   drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
>   .../int340x_thermal/int340x_thermal_zone.c    | 177 ++++-----------
>   .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
>   drivers/thermal/intel/intel_pch_thermal.c     |  88 ++------
>   drivers/thermal/thermal_acpi.c                | 210 ++++++++++++++++++
>   include/linux/thermal.h                       |   8 +
>   9 files changed, 286 insertions(+), 214 deletions(-)
>   create mode 100644 drivers/thermal/thermal_acpi.c
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

