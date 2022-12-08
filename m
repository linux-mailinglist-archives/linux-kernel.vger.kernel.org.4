Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2708E646AF6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiLHIrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLHIrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:47:31 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CBE2F67A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:46:30 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id b9so823565ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oeN4tbC8QYcjeXtnRCV0L0VBx1w71ZeUSLmAb6QYLH4=;
        b=qH4NqlWKo3zt47ik7YIU7kmdLYYcvVcO6GSKeDJl6/FJDRKqjaKiZ20t70P3vsf5en
         um9WTdmrMn0KhBo63A72CPiffEesD3chqRklTOKElHTQ4s2trN/3Zm/GF/By4MdxhqXm
         vTax0XL5x02hgxffuacSJPfnFtYy1DvGMzk6aVd3SLy/vM3Z4lW1GnG1m1FEag5ta2Bt
         tN2HRl85CSq/83+XNMmD1hS0qu5Fx0fsLwFanA2YLaQTzAro8a+h4HLCDwuHXsVqFNcQ
         sVBatq/pAHSSUMeH0R140l91GO9ceAMmsmEfvL/YNTrKlK3EX3zbBaPSvJRI4gFdX93x
         Gtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeN4tbC8QYcjeXtnRCV0L0VBx1w71ZeUSLmAb6QYLH4=;
        b=ygwjyHkOYm2vYAnvJp0CsZ2fzPTCMVMxUkxkXa48h/NwreE78DNpcZuUauCOBHD+2+
         ROjcqBuxl0usVqFaAWdqtFhqWHqR6y5fV4H1ClSE6bgfdg7keHzE00efPgd9ZgeWuOb7
         TpGnSQ4pzuvaASn+xZNMLk68I1itM1S8r5G5jvcsJfXBmWa6ICqcWnNMI5noCGD1H0Gt
         sDssLN/kFZ0uz2cHaL8A1/NP8iO0gx1Vc4tf1sLdbbcgLAjS7sEjzDlWZCDcojAulfHU
         4RnPzd9Krc48bNiAkyTVgauzdUk8VYxd0RszAIojDJyYzpJQ19ze1lXTU5OywX7uGfeg
         bmlw==
X-Gm-Message-State: ANoB5plk9HX6+2CPATNFwKVXBbavmK77S3HFSdIwiTTUj8HoXCsfYSTq
        FHhCzD6VyeUnRBFRElwkA90IWg==
X-Google-Smtp-Source: AA0mqf4oyc9MWULxVZ5mmTZx6NmoFsEfusvnFxRcT6pk965wUtiV7p7TVZN0HGcgHbu3gYT4dV3T2A==
X-Received: by 2002:a05:651c:50f:b0:279:dbb8:4549 with SMTP id o15-20020a05651c050f00b00279dbb84549mr8910987ljp.79.1670489188855;
        Thu, 08 Dec 2022 00:46:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m18-20020a194352000000b004b55ca53543sm2169721lfj.233.2022.12.08.00.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:46:28 -0800 (PST)
Message-ID: <d5f58e82-2644-3e16-f27a-de72ed8ab74d@linaro.org>
Date:   Thu, 8 Dec 2022 09:46:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 7/9] dt-bindings: spi: mtk-snfi: Add read latch latency
 property
Content-Language: en-US
To:     =?UTF-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "richard@nod.at" <richard@nod.at>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <Benliang.Zhao@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
 <20221205065756.26875-8-xiangsheng.hou@mediatek.com>
 <ce449a0c-efcc-0ac1-fb8e-c2b4148a5bc1@collabora.com>
 <a8f706b37f5decf91bfa9a9ac8cf04be4346dd85.camel@mediatek.com>
 <9992c9a5-059a-9396-32ce-7ed63cd12a96@collabora.com>
 <e2ccf42f94152ccacad3a2eaec234ae0566474ec.camel@mediatek.com>
 <b877af37-462e-c923-41c0-09c370062700@collabora.com>
 <97408c484927b6520ec79b23220496d628156e5f.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <97408c484927b6520ec79b23220496d628156e5f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 02:15, Xiangsheng Hou (侯祥胜) wrote:
>>>
>>> There have two rx related timing properties in spi-peripheral-
>>> props.
>>> The rx-sample-delay-ns have been used in Mediatek snfi driver to
>>> adjust
>>> controller sample delay.
>>> However another spi-rx-delay-us is in microseconds. Take 52MHz for
>>> example, the clock cycle will be 19.23ns which lower than 1us. This
>>> may
>>> not easy to by one clock cycle.
>>>
>>
>> I agree, but nothing prevents you from adding your own property for
>> that.
>>
>> I propose "mediatek,rx-latch-latency-ns" or "mediatek,rx-latency-ns", 
>> so that
>> we can specify the delay in nanoseconds: in that case, when we
>> specify 19ns,
>> the driver will safely round that resulting in 52MHz == 19.23ns =>
>> 19ns valid.
> 
> Will be fixed in next series.

I am fine with this approach, but after explanations I was also fine
with clock cycles as unit. It's still quite specific unit and I think
several timings on buses are clock-cycle dependent, not time dependent.

Best regards,
Krzysztof

