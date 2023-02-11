Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0859F692F47
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBKHx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKHx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:53:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB45F8A57
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 23:53:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bk16so7314934wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 23:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdyJlJsLe7UYj3HkIh5IqELvu3xeVrpcZYgePszZnTM=;
        b=GLB3/AzmYk9r6d1M8HG+Xa6zUYiLBVeTfksz30BKXtFLjMOZAJt3SBE6RyR0tbn5MS
         DD4H3wi9V/SDQuDV3tGPPSl8qpypTSQsfCfK9egDFUGuj9TX5Bg/7M3aEj2dHPApTycE
         iVMMPBpYzZd0VtnU+lA9CnOYU9IA+UskmGMUMP/allk6UxbMwLl0hBxkiWxnQmmDhNk0
         Bz8WSmwAI5ueU77V8JEpyzEs5FhACjZuwfsvwtP+cMXV+L1AwI+vifHHRly2zvJG0jsk
         5IC2zBZPyhqDHEfyrpQvPJ1em2+wFTVJbqpatXgKrf7ezzHV/rk2Pm3qw34jJSH51cPz
         XCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdyJlJsLe7UYj3HkIh5IqELvu3xeVrpcZYgePszZnTM=;
        b=G4zbSrLTbOxA2F8Pso2WvqkGg7sBORodQROqkm7+V/95mKmJ7uWce2X/z7Q1NIQSIW
         kyLxauPBktTTCmMVPWkPx9ejSmh4xSG6AQCVAp2Boj7D2TiUKlLLhUaDJu3XQzywSytN
         ZQeF+G7nIrkUNa3z/ZNGR/6hJrE2uoSrUTGalM/CSGnO7buGuBFkCAr17+hSjouxwpZw
         OT6iN+dkbocKatyTUczre3TeNAnK/KXIKYmvhJMT9+0B/ai0GHsMEpOsIEv5JzVnZizR
         O74MWF4VD0mx2N6podfT31bA7zn0fBbcXK5tbCTnCDA1TvyGsvv+5mBVR7ubA+7WzvAB
         SpeQ==
X-Gm-Message-State: AO0yUKVWsNk6a1YaEKJjMH6MN/HkObhgHJuZTKk+egxasGSB0rAP8QU5
        DfpLIv3/g8ygW/hd5UNKsvyLng==
X-Google-Smtp-Source: AK7set8ejeEopWyNZYhHew3TugHJmthNV0eduJzyC9rqBpPCVupmvHmzId1Mb4lViYTHg0iv3ePIXA==
X-Received: by 2002:a05:6000:8:b0:2bf:b5e4:cd63 with SMTP id h8-20020a056000000800b002bfb5e4cd63mr15123447wrx.8.1676102003159;
        Fri, 10 Feb 2023 23:53:23 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q4-20020a05600000c400b002c54737e908sm3787502wrx.91.2023.02.10.23.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 23:53:22 -0800 (PST)
Message-ID: <9a121d43-b6d9-fe99-1e4c-498dac2e6b17@linaro.org>
Date:   Sat, 11 Feb 2023 08:53:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] thermal: Remove core header inclusion from drivers
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "open list:THERMAL DRIVER FOR AMLOGIC SOCS" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
 <20230211021023.GA13306@ranerica-svr.sc.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230211021023.GA13306@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 03:10, Ricardo Neri wrote:
> On Mon, Feb 06, 2023 at 04:34:29PM +0100, Daniel Lezcano wrote:
>> As the name states "thermal_core.h" is the header file for the core
>> components of the thermal framework.
>>
>> Too many drivers are including it. Hopefully the recent cleanups
>> helped to self encapsulate the code a bit more and prevented the
>> drivers to need this header.
>>
>> Remove this inclusion in every place where it is possible.
>>
>> Some other drivers did a confusion with the core header and the one
>> exported in linux/thermal.h. They include the former instead of the
>> latter. The changes also fix this.
>>
>> The tegra/soctherm driver still remains as it uses an internal
>> function which need to be replaced.
>>
>> The Intel HFI driver uses the netlink internal framework core and
>> should be changed to prevent to deal with the internals.
> 
> I don't see any of the thermal netlink functionality exposed. Is
> there any work in progress?

commit bd30cdfd9bd73b68e4977ce7c5540aa7b14c25cd
Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

     thermal: intel: hfi: Notify user space for HFI events


> FWIW, Acked-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Thanks!

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

