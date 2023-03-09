Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5251C6B21B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjCIKlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCIKkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:40:40 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAC77C3E4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:39:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bw19so1340508wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678358355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqPGgd3BFdJ5Z3N2xYuAK2cKJFro8IMB7DoFRyNGYm4=;
        b=cyuWrije1J+G0kpt9rtg9Zl9sy2vZ6FM3iuAuq3aa6xpiGzEf2lm0y2C8jOCJlsWeJ
         EWmWc+ptmmIZ9VpxZoDLI1gR53mm2YZY+lWHHX9DnYPngQ1jRmg6Jeu657tZGxz2jX6N
         YsoLVo8eGy3iUnDoOpwdsva1cuCV/u8EvWap4XFofYLdq6F3rlwtUXKWVPAevmo9lZVA
         HDTeFqtX5+kZHYiMCjYQZiL2O9EhJWAWwx+6m0tXDA025+3xrVorFWwpWXEzFQ6EFYpQ
         qC2bZ8Hc50FwsaxXuDrl5qnMSJlJexrK54vU2rtvMh2yoUkAcNaGANtYbeaPWwZlJBxe
         G4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqPGgd3BFdJ5Z3N2xYuAK2cKJFro8IMB7DoFRyNGYm4=;
        b=FWHXqr5eutkz22E+kLJmmJ28PUtINXhSol2CD55w4uHIByuTkZ3oOcQyR6ZXxyipo6
         CQSF/H/lKzNJmcNRxWGnOYSqJDNmD19jVFwFPpPg9zTJgZfTgmAIXb6E16edCd8YFk0P
         I33NxVsmFIEviGDUBjF2kuTVOUSxqLZXTHGxyQ1hvJ4Io+6NsIMo2Q5iAXJit8i+WXDk
         wzr/E2srBr3ORon2HaJUsaISd2F2OHr9bPkIzPS5QaU0RYWdWcRFY/NmF9ohJJKUEbH/
         BbQaPYIlt2hpzxJYtaYdMuQLAs8SJf+vOscxgP1nKNlDqfiu42x13UKh505wZx0iXe66
         R70w==
X-Gm-Message-State: AO0yUKXyGIzyj5b024HQYhJgrrCGi5qa1SR0UPiFkVKe3AvX6G+3ZULI
        LIwb8913KZHLAe1MQy/ZQQXVDA==
X-Google-Smtp-Source: AK7set/FRRRB0+8uQ1yztBz2VteqoM/5ZDzGzNq25bY2dg07fWy53EiQjle/35Q0iTayjTBe36Tw7Q==
X-Received: by 2002:a5d:4a43:0:b0:2cd:ceab:df1a with SMTP id v3-20020a5d4a43000000b002cdceabdf1amr14687125wrs.32.1678358354769;
        Thu, 09 Mar 2023 02:39:14 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:fbda:65f5:e873:7527? ([2a05:6e02:1041:c10:fbda:65f5:e873:7527])
        by smtp.googlemail.com with ESMTPSA id s1-20020a5d5101000000b002c559405a1csm17580482wrt.20.2023.03.09.02.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:39:14 -0800 (PST)
Message-ID: <e5959cb5-af8c-9410-9530-b3e19e9b647a@linaro.org>
Date:   Thu, 9 Mar 2023 11:39:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] dt-bindings: thermal: mediatek: Add AP domain to LVTS
 thermal controllers for mt8195
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, bchihi@baylibre.com
Cc:     angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230307154524.118541-1-bchihi@baylibre.com>
 <20230307154524.118541-2-bchihi@baylibre.com>
 <CAGXv+5FUrWEF4SZ6DKjoF8Oai--JGFffzQ3_DyzQrUrThVEQ7Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAGXv+5FUrWEF4SZ6DKjoF8Oai--JGFffzQ3_DyzQrUrThVEQ7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 05:40, Chen-Yu Tsai wrote:
> On Wed, Mar 8, 2023 at 12:46 AM <bchihi@baylibre.com> wrote:
>>
>> From: Balsam CHIHI <bchihi@baylibre.com>
>>
>> Add AP Domain to LVTS thermal controllers dt-binding definition for mt8195.
>>
>> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
>> ---
>>   include/dt-bindings/thermal/mediatek,lvts-thermal.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
>> index c09398920468..8fa5a46675c4 100644
>> --- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
>> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
>> @@ -16,4 +16,14 @@
>>   #define MT8195_MCU_LITTLE_CPU2  6
>>   #define MT8195_MCU_LITTLE_CPU3  7
>>
>> +#define MT8195_AP_VPU0  8
> 
> Can't this start from 0? This is a different hardware block. The index
> namespace is separate. Same question for MT8192.

The ID is used to differentiate the thermal zone identifier in the 
device tree from the driver.

+		vpu0-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_ap MT8195_AP_VPU0>;
+
+			trips {
+				vpu0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};

If MT8195_AP_VPU0 is 0, then the code won't be able to differentiate 
MT8195_AP_VPU0 and MT8195_MCU_BIG_CPU0

The LVTS driver will call devm_thermal_of_zone_register() with the 
sensor id. If MT8195_MCU_BIG_CPU0 and MT8195_AP_VPU0 have the same id, 
then at the moment of registering the MT8195_AP_VPU0, the underlying OF 
thermal framework code will use MT8195_MCU_BIG_CPU0 description instead 
because it will be the first to be find in the DT.

If MT8195_AP_VPU0 is described in DT before, then the same will happen 
when registering MT8195_MCU_BIG_CPU0, MT8195_AP_VPU0 will be registered 
instead.

IOW all ids must be different.

The namespace is already described by the macro name AFAICS, so whatever 
the values, we see only the macro names and those IDs are private the 
kernel implementation.

If the numbering is really important, may be something like:

#define MT8195_MCU_BIG_CPU0     00
#define MT8195_MCU_BIG_CPU1     01
#define MT8195_MCU_BIG_CPU2     02
#define MT8195_MCU_BIG_CPU3     03
#define MT8195_MCU_LITTLE_CPU0  04
#define MT8195_MCU_LITTLE_CPU1  05
#define MT8195_MCU_LITTLE_CPU2  06
#define MT8195_MCU_LITTLE_CPU3  07

#define MT8195_AP_VPU1  10
#define MT8195_AP_GPU0  11
#define MT8195_AP_GPU1  12
#define MT8195_AP_VDEC  13
#define MT8195_AP_IMG   14
#define MT8195_AP_INFRA 15
#define MT8195_AP_CAM0  16
#define MT8195_AP_CAM1  17

But I would suggest considering this change as a separate patch after 
the AP domain is added.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

