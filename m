Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071FE68C982
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBFWfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBFWfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:35:51 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAE017155;
        Mon,  6 Feb 2023 14:35:50 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id x10so7782009qtr.2;
        Mon, 06 Feb 2023 14:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmjD169NoXW3IkhaYFwz0SB6QUlkP+qjUZED7C6ZRTc=;
        b=ckgvtNbLHKE7zGp1hQQH2crONIjnVmrKh4uTLOwFVE59nzmNDXe2hY25Vy/SdS2hxO
         Dcps1DCCnhUR6uMUpbZAgd3e8d74QAybhTkzqbpGiY5KlAx4PxrkThbrKvdJQ9X6eFLI
         kYsBUj99TpNEuneLGJ33lau5G8cp9/7SsRvgWGqTGoFXEUGKo5+YBpVCCQROO1xtG8u+
         IoFe7ysj9JZNW2YtseYYgAOdEL5ZywEYqUMstLjxqHmT9iCp6KwTE5cTR2LZ6ZJxFCca
         sEIMEsh7SzKMoJb7WcrXJsAGFp3TzRG35VTOXk4ujeNHnd5JE2e3IbbQn8hYhVvvZmss
         dC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmjD169NoXW3IkhaYFwz0SB6QUlkP+qjUZED7C6ZRTc=;
        b=KaVe6UZfRSXprKunuHah/GXNnF3JKbuMTghzpYrDYdxTaqQGDKB0zKQsksz0En/TI1
         uzAruNpkhUlyK8Xjp/DDIyeKhxSn+7k/qcfh2DaPLcxfksG2kU6L9Ztx79jJupy8p98l
         3SI6NfnBCPrfXKfjU59nBjFSXg44w1OCwRe7IlUtiFpvWy9d9dgaHr9bY+oq1Op8k6Wi
         rmMoZl7dsMpcLs1EWP0wW2UICGHpQDW6Qi0NsXWWj7jccpl7RwcMxEQYtWMgw/k1MC4z
         qNtTukrqeJiXJa1pvIpdPqzCXq9c4nxoxuBNT1q3Rsvp+VNECy7em4Somk1rjTz8fEQT
         1rSA==
X-Gm-Message-State: AO0yUKW/xjQ3YUsdXYB/oSJqNJEEkSLAzxkbiipL6iNW6Qr7z8EGVrzh
        2hxXT5s5zj8mRc2eVXB9QSgrb8TLsLpxNg==
X-Google-Smtp-Source: AK7set+ds+mN/qWC4EpstrsfpJCHNe3e6+CXlaF5Nlwbm9/55WoErDc4Bw+yRg3MwF1VPLdJ7uZRmQ==
X-Received: by 2002:a05:622a:1753:b0:3b6:43ae:d5a3 with SMTP id l19-20020a05622a175300b003b643aed5a3mr1958776qtk.26.1675722949351;
        Mon, 06 Feb 2023 14:35:49 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 16-20020a05620a041000b007201df7ff47sm8274920qkp.45.2023.02.06.14.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 14:35:48 -0800 (PST)
Message-ID: <6f276332-54fb-b814-1b64-4e8aa7960eb6@gmail.com>
Date:   Mon, 6 Feb 2023 14:35:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: Remove core header inclusion from drivers
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/23 07:34, Daniel Lezcano wrote:
> As the name states "thermal_core.h" is the header file for the core
> components of the thermal framework.
> 
> Too many drivers are including it. Hopefully the recent cleanups
> helped to self encapsulate the code a bit more and prevented the
> drivers to need this header.
> 
> Remove this inclusion in every place where it is possible.
> 
> Some other drivers did a confusion with the core header and the one
> exported in linux/thermal.h. They include the former instead of the
> latter. The changes also fix this.
> 
> The tegra/soctherm driver still remains as it uses an internal
> function which need to be replaced.
> 
> The Intel HFI driver uses the netlink internal framework core and
> should be changed to prevent to deal with the internals.
> 
> No functional changes
> 
> [ Applies to thermal/linux-next or linux-pm/linux-next ]
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

>   drivers/thermal/broadcom/bcm2835_thermal.c  | 1 -

Acked-by: Florian Fainelli <f.fainelli@gmail.com> # bcm2835_thermal.c
-- 
Florian

