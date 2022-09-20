Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0B95BE021
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiITIc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiITIb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:31:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D438522BD4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:31:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g3so2956772wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JevgRfzZajHh1ivJNGDpznKCTFD71WO98dSUBcXwKkQ=;
        b=RX0Sh3F73nodOtMqcJB/O8rzrlHYjazqjbR0QpQCoECZr75KPLgR4sOLNwcFXQ/mb2
         ocYdGlBdFq5gxdrmtwLlgKJx7CPj7DCcjt7O90xgAeId7bZD2NqxAGBNIZBI63+B6Gm6
         5Mv/XsAAnBPMlXwZ4NvzJ/2+k7GfxdLo+hIDkr2yBCndqzhFwr1cQuxn8yiHHfbzVa70
         p+hFmiJrEY5C8ExPWVKJuvCBr59i9oD+Iv1TBWW8n1ri7b1R1I3LAy3v1Dt5abozJCzL
         pYzUesSsyGvIT93+sGO9TQ8kl2wz9sMUIw0OTLC20i7B2/Tlq7dQJjmaaYs84HSyGQLA
         0x2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JevgRfzZajHh1ivJNGDpznKCTFD71WO98dSUBcXwKkQ=;
        b=TLX3GKhU8QZ5avLvsnWues2WNLFOZGhdywrMRyy3sK6j4FgQJS7YUXXTSIjmMy+3Js
         P9OiPyS6e86OUhudMyZkvTjKjC9SwTbSB+mYQ1D9oRmJuXu1MEJAqV1HbSNnuF0o63io
         P7MoRx2lYvRhyJvSVzwYnUijZmA1IiF2EoOltvC217K19HrZ6RFbAIyo9PvSK2L6pc7e
         tR/DAC5oUUE0Yhr4s07eJr2ztZkq9EjjS5HB0gwZb72OzEjFrx/tdzJMsj7am6ir5ajS
         VBD2+EWsQKLesXfdY0efs4IB0WLE7NlpUcw22BmAyaR+RNC3pv9tNZjEm72bnUypHZ8D
         1b/A==
X-Gm-Message-State: ACrzQf2ABkgwtOfb4vP4P4bO495lE+fUe3aV+2dK+Iz3INjCp0rbWd+i
        jtpHiCKydXJ2ksf4quD2fX/eEQ==
X-Google-Smtp-Source: AMsMyM74xfiWSJJs+Nvny1x9cNy0Hheub/jdfRKhfI5KVZk44pOGzg1LeUSMI5Exgk7YsBAOw7rzgg==
X-Received: by 2002:a5d:6388:0:b0:228:c792:aabe with SMTP id p8-20020a5d6388000000b00228c792aabemr13008936wru.689.1663662681325;
        Tue, 20 Sep 2022 01:31:21 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m19-20020a05600c3b1300b003a319b67f64sm2272271wms.0.2022.09.20.01.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:31:20 -0700 (PDT)
Message-ID: <66e00dce-d9fe-efc6-1121-8e7f4001d655@linaro.org>
Date:   Tue, 20 Sep 2022 10:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND] dt-bindings: timer: Add compatible for MediaTek
 MT8188
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220818124602.20394-1-johnson.wang@mediatek.com>
 <4a7e5e729f85c112a235e6bdd8bd337f90eabbf5.camel@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4a7e5e729f85c112a235e6bdd8bd337f90eabbf5.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 07:20, Johnson Wang wrote:
> On Thu, 2022-08-18 at 20:46 +0800, Johnson Wang wrote:
>> Add dt-binding documentation of timer for MediaTek MT8188 SoC
>> platform.
>>
>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-
>> timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-
>> timer.txt
>> index f1c848af91d3..8bbb6e94508b 100644
>> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> @@ -25,6 +25,7 @@ Required properties:
>>   	For those SoCs that use SYST
>>   	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
>>   	* "mediatek,mt8186-timer" for MT8186 compatible timers (SYST)
>> +	* "mediatek,mt8188-timer" for MT8188 compatible timers (SYST)
>>   	* "mediatek,mt8192-timer" for MT8192 compatible timers (SYST)
>>   	* "mediatek,mt8195-timer" for MT8195 compatible timers (SYST)
>>   	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
> 
> Hi Daniel,
> 
> Just a gentle ping on this.
> Could you please review this patch and give us some suggestion?


I've applied the patch

Thanks

   -- D.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
