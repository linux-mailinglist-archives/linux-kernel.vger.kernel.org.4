Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B966402C8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiLBI7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiLBI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:59:31 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BCF30F62
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:57:56 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg10so3064042wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hrXh1n7+q7fL8fZ+N+AYxQ6Gttv4U1Iv+7uPHyHolo8=;
        b=U3zLU6MZH0G4eEg0jylYeVarVdA0Vp1QAGYYAUzAbngRNP9p9NEf0CJ6ph59Z5vpek
         coZOw6/yF0T05gempG5PoG1gQTl3iISvll/LJ3Ff1ERdgJquIMMlV3txt3CBzVls2vkf
         LvEQapbfpfLWydAb4VuFINZ/Whn/5gCtfiyVuI8jbNzqNLSVUqcU+k4e2ELeYKhj0yrd
         kuBFNzqnLqueFlzR19IK9bwGjAbbq7nI3eSZ7WQt4y+5QQA3mizcjYE8P/xsPzIfJII1
         j+bZlPv0LpmdRjM29qA6oOJEhiNKQ1Bw321ykzly8Lb+wdaqxsFKbeApYdgz8WYC1LqC
         iT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrXh1n7+q7fL8fZ+N+AYxQ6Gttv4U1Iv+7uPHyHolo8=;
        b=BlA6TzuHvHxarPO0Y4uXZ3yJ8iGo3TYokiPmMU0TLFIunObVV8QnpUeHbWzlL7I4IH
         5bhGQdbHwbQNA9q1GQSRSlYQzXhG97GG0B8rp5UxXkvseeJhqItaoRUDjANeguWzYVRo
         riN84ZSfQP/+V3RKRey/vQkv1nTSun0bcyud249UozAGdJfHQ6V8eZa27Sbxxjk9PegG
         AWBum/VbZ9hwfYl1SiSwqhfZhuw/uDwqYrWZGgIf5iUvOzGV6Gf4uUtnUDe+CRss44CR
         GAShm69HFCxz/eCgWM/dGanzAqGTVtbzH/UnUm5RL3NO6K+3YifMOXORM+ciruPphxMN
         DzbA==
X-Gm-Message-State: ANoB5pkNo3iS3PFQtm+waSdhQuKg1somVYoaZ8r5zIoxH0nxcCqcQ6oZ
        JTmbUR34n4gX7JiyQ7i0Qb6kGg==
X-Google-Smtp-Source: AA0mqf67e2AGKPOEYoS8HO7Jo5+4Ow9tYZY+3J1lJSldilOVMktuVrZk3AiNzzSwU9R64H0rupfNLw==
X-Received: by 2002:a7b:cb91:0:b0:3c6:cb54:ef66 with SMTP id m17-20020a7bcb91000000b003c6cb54ef66mr41088554wmi.90.1669971474508;
        Fri, 02 Dec 2022 00:57:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c6e:eb0:b551:55ee? ([2a01:e0a:982:cbb0:c6e:eb0:b551:55ee])
        by smtp.gmail.com with ESMTPSA id o37-20020a05600c512500b003cf5ec79bf9sm9035533wms.40.2022.12.02.00.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 00:57:54 -0800 (PST)
Message-ID: <600437c7-3ccd-dfce-8fb8-826a608cc06e@linaro.org>
Date:   Fri, 2 Dec 2022 09:57:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 4/7] arm64: dts: Add DT node for the VIPNano-QI on the
 A311D
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
 <20221201103026.53234-5-tomeu.vizoso@collabora.com>
 <CAFBinCC8kQ-7v+PCZgsqo2kGzsOi5jT6ekmjvb_D2j5tBmHNoA@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCC8kQ-7v+PCZgsqo2kGzsOi5jT6ekmjvb_D2j5tBmHNoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 23:33, Martin Blumenstingl wrote:
> On Thu, Dec 1, 2022 at 11:31 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> [...]
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> index 45947c1031c4..61c8461df614 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> @@ -11,6 +11,7 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
>>   #include <dt-bindings/thermal/thermal.h>
>> +#include <dt-bindings/power/meson-g12a-power.h>
> We could now remove the meson-g12a-power include from
> arch/arm64/boot/dts/amlogic/meson-g12.dtsi
> I'm not sure if we have any "rule" about this though, so I'm curious
> to hear what others think.

Actually you're right, Tomeu please remove this include
and remove the:
	power-domains = <&pwrc PWRC_G12A_NNA_ID>;

and move it as:

&npu {
	power-domains = <&pwrc PWRC_G12A_NNA_ID>;
};

into arch/arm64/boot/dts/amlogic/meson-g12b.dtsi

and while you're at it, please add:
&npu {
	power-domains = <&pwrc PWRC_SM1_NNA_ID>;
};

into arch/arm64/boot/dts/amlogic/meson-sm1.dtsi

It's ok to do all this in a single patch.

> 
> 
> Best regards,
> Martin

(PS: Don't forget Philipp's Acked-by on patch 1 for next version)

Thanks,
Neil
