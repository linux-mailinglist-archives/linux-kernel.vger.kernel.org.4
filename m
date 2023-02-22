Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95D869FC01
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjBVTX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBVTXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:23:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A2425BB5;
        Wed, 22 Feb 2023 11:23:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id ky4so11213428plb.3;
        Wed, 22 Feb 2023 11:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVtjYpIHV+F/G/ingVBx6jIgdgl5yssi4YLW8OGrNiA=;
        b=Wt+l673/i3AK1CpL3q4jfsYpc3ydKtCRNrHD2smWCOsHsu5pupRfRz7HJMK0U+Tb3K
         lgzkSxW+pHPeUSZlRTAP4UV0FNjS0LpoGlhh8rBgyxvEq650mnRvew+w1SywqPvYVWXL
         m8qpqJ8IWXwYn/v8dwPT//KDjwHBkWsCrrSwT9KkwLM+Pa6FhS5r2feCF990izO8ETx6
         nN0+w9BqZGQk6jwSyl6Op+beVOSH0Xvu687zcHwKxZBt+cEktTmiaZu8G5K6ICbeG5xf
         7AVFCKwyQfMy/Gzt0oRFK2PVrPrJTZRqG73OkzzU6wfl1M9udY5yVoQsh3HhJzIG+tWG
         vMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVtjYpIHV+F/G/ingVBx6jIgdgl5yssi4YLW8OGrNiA=;
        b=cMjZjr7tY0SCxIaz8+NtqTyuphAiSF71PyQPDv8eF0E0OVCJuxPADEmNOI83VSTjyL
         ouNJ7u7vVmXCBp6qYLCt/SpyoZGuyKFRD3qWj50gxJXmEbf2qCWTkeFMEXZ/hbH4vF9G
         fH8ftWm4MPeh2mAFFAFPPsRy5kNJrPdNmg5vwSFTkibLHHFW33hPMSdO+df0ydhwTGx2
         C8bSEbtDsWD4TWSwd6vfI8YonwEc4177u48CyM+pe3LafISvoByFXKPPj6N5otkjroKE
         on0W0R2P0lZEpqoPWkxTnKgXpl6kzyJ2KMtZno7lGNwa4JRPQHoi5uRv4nSzNJO+fQQl
         L/yw==
X-Gm-Message-State: AO0yUKXaG1uIiPcGWCjbZUzpKWKsEpDvNxicOy9Y3X/E/gtpbApw2v4+
        AoZmqTDSSdxAYP2N/46dGXc=
X-Google-Smtp-Source: AK7set++t4HMlPjsHBal6OrZkgceAwcAsao9C0R9qlSCKk167SCs4r8F+dflc7N1eroggJ4F5U/TGw==
X-Received: by 2002:a17:90b:224b:b0:234:6a1:635d with SMTP id hk11-20020a17090b224b00b0023406a1635dmr12313564pjb.49.1677093833790;
        Wed, 22 Feb 2023 11:23:53 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y15-20020a17090ad70f00b00233e7f0e7dfsm4771111pju.4.2023.02.22.11.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 11:23:53 -0800 (PST)
Message-ID: <e07d4ef6-881a-bac7-9895-5ec50bcb585d@gmail.com>
Date:   Wed, 22 Feb 2023 11:23:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 04/16] thermal/hwmon: Do not set no_hwmon before
 calling thermal_add_hwmon_sysfs()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Brown <broonie@kernel.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-5-daniel.lezcano@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230221180710.2781027-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 10:06, Daniel Lezcano wrote:
> The thermal->tzp->no_hwmon parameter is only used when calling
> thermal_zone_device_register().
> 
> Setting it to 'false' before calling thermal_add_hwmon_sysfs() has no
> effect.
> 
> Remove the call and again prevent the drivers to access the thermal
> internals.
> 
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se> #R-Car
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com> #Broadcom
-- 
Florian

