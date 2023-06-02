Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04671FD84
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjFBJTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjFBJST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:18:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80861E5E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:17:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so2356541e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685697449; x=1688289449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wjb4y9f/OAblmhtUQxR2kzYBl3YoolTkNzcf3IrEYtY=;
        b=PekzTB4NEY2nA9GPUJVIBcKeoQpV+aIEe2nmErsgiefDoj5ypbOd5+i40Prt5AoBe+
         XfaBDNPpYu+LNX2YcHUnR0hv+g/YROhYw/V6jjmQuNYOF7ytCz5ke45oumzljt3p0phL
         0Xm5ZoUjq5cbmeLsQ4ePpoEsAcziXxnkng8Un6QMi3fuThIXraxZtUWyRpOBnHPILUpr
         3GjRlgfrT9/aklNsN1Lyrgv9rHsUDxUrqpZmZlnUrHhnHEQV9A2d6YoFWmtVrnqpA0LS
         lAaeeKBbSVeKCCkB0NFBK1saaOAZJ50dp124wG3nM/KTjd4MPZ110pBsWuCEfXeCR9Xa
         NdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685697449; x=1688289449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wjb4y9f/OAblmhtUQxR2kzYBl3YoolTkNzcf3IrEYtY=;
        b=GV1NHapFROoThrF7HvdCIaXvUKY1nAanurQLzQLGEvTnv9+tMsLUfARtnzAAEASQgg
         CmMcmv7IkG7z0c4VOLyjcbgFtM+xQSKveWdRc87zOntP6l75qoQ1B39LHnRj0D/KgKgL
         QbnfUDIDhOcFPKxaRMfL+Tl3T1SUdV3u/GKtk2sUsBrZjwvMpqXgBLoSfohqCqLOu/fg
         B27okf5V0o+FGxHPWjH9zbyLAfTy7xo6v33fQ78BGIEu6IdYhT8eYsO/RE10eKNvp0SN
         35Lo3Lfr1Fo14e9JTkcCLOE4dbzCy22jHzqLubzfu4MkURjkruGZ8Nn8bL4MpGnn/SHK
         25oA==
X-Gm-Message-State: AC+VfDywbO6Bjkrpq/HIqn7zTYFCb4IuyCjmnrFNvZ5L4UEmMTw5OTVA
        WuOptt9dBwMsy32hNwfLO/oiDw==
X-Google-Smtp-Source: ACHHUZ4d9PtFuny6rQdn1Vgtvd/NuLyoJXiaApszdFajTfmb8wElIAA9bAtFoXQfDWguF0DecsIfmA==
X-Received: by 2002:ac2:4a74:0:b0:4f4:26d8:3668 with SMTP id q20-20020ac24a74000000b004f426d83668mr1457320lfp.25.1685697448598;
        Fri, 02 Jun 2023 02:17:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:548f:8f7e:a3c2:888a? ([2a05:6e02:1041:c10:548f:8f7e:a3c2:888a])
        by smtp.googlemail.com with ESMTPSA id l18-20020a05600c1d1200b003f61177faffsm12498463wms.0.2023.06.02.02.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:17:28 -0700 (PDT)
Message-ID: <5d810151-3a3b-51af-bbc1-0ee45668bcc4@linaro.org>
Date:   Fri, 2 Jun 2023 11:17:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/6] thermal/drivers/mediatek/lvts_thermal: Don't leave
 threshold zeroed
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230504004852.627049-1-nfraprado@collabora.com>
 <20230504004852.627049-6-nfraprado@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230504004852.627049-6-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 02:48, Nícolas F. R. A. Prado wrote:
> The thermal framework might leave the low threshold unset if there
> aren't any lower trip points. This leaves the register zeroed, which
> translates to a very high temperature for the low threshold. The
> interrupt for this threshold is then immediately triggered, and the
> state machine gets stuck, preventing any other temperature monitoring
> interrupts to ever trigger.
> 
> (The same happens by not setting the Cold or Hot to Normal thresholds
> when using those)
> 
> Set the unused threshold to a valid low value. This value was chosen so
> that for any valid golden temperature read from the efuse, when the
> value is converted to raw and back again to milliCelsius, the result
> doesn't underflow.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Added this commit
> 
>   drivers/thermal/mediatek/lvts_thermal.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index efd1e938e1c2..951a4cb75ef6 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -82,6 +82,8 @@
>   #define LVTS_HW_SHUTDOWN_MT8195		105000
>   #define LVTS_HW_SHUTDOWN_MT8192		105000
>   
> +#define LVTS_MINIUM_THRESHOLD		20000

MINIMUM

So if the thermal zone reaches 20°C, the interrupt fires, the set_trips 
sets again 20°C but the interrupt won't fire until the temperature goes 
above 20°C and then crosses the temperature low threshold the way down 
again?

>   static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
>   static int coeff_b = LVTS_COEFF_B;
>   
> @@ -309,6 +311,11 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
>   		pr_debug("%s: Setting low limit temperature interrupt: %d\n",
>   			 thermal_zone_device_type(tz), low);
>   		writel(raw_low, LVTS_OFFSETL(base));
> +	} else {
> +		pr_debug("%s: Setting low limit temperature to minimum\n",
> +			 thermal_zone_device_type(tz));
> +		raw_low = lvts_temp_to_raw(LVTS_MINIUM_THRESHOLD);
> +		writel(raw_low, LVTS_OFFSETL(base));

That's duplicate code:

u32 raw_low = lvts_temp_to_raw(low != -INT_MAX ? low : 
LVTS_MINIMUM_THRESHOLD);

And then the condition in the code goes away:
         if (low != -INT_MAX) {
	}

>   	}
>   
>   	/*

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

