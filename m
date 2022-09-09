Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC725B2FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIIH1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiIIH1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:27:48 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE6B115CE5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:27:46 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id v6so850219ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=etwEkk2VMTsvKW/MD7eFPXx3btRLMMRGIwWTmP+5sC4=;
        b=IwzwnANBy9F7D/ttwPax+/1RWtgAwga7gpYygMnP4+LnIrKVv/IrYMcPvinhgbf9VF
         LZDKSJOpWU7b4WpiH/mERKjijFNbDUCvzAb4yJst9kh4OYpJwCqSUnsDBP/Jvnc603AD
         T5z/r5n1vQRCYne+fTc8BydhT1iZS8mz3ogW6AqIXNxQJ9KeblyHRCCbTmi472cY4B0n
         usbPPXpzJc3u651dKid1t4PDcjM0OegmRq5yJ/8iTa2lsRgXZgpWcRejElxDQt2hbQmt
         9P3SyOLqVEElZjd1T/TCWfTch04w91y5vcwE3J+ORCl4UQUrBiqv5UnFk9eebwBE/qxg
         fcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=etwEkk2VMTsvKW/MD7eFPXx3btRLMMRGIwWTmP+5sC4=;
        b=qqfDs4nLAGfFrXRxoQDTljHGDu5AjfN3jFpsYoRRUxNbE4sVFL8W4d4Y+yO1rfD2vE
         GtHCljxteQrayeFpbPzDwBO8eVUmj/dvIuoNVEYTvIUnEZNGgVRp7UB6FGCaW52s5T5c
         1gjrX9Jd85esZFzi685bxWBkdKOKoro974XU/E+H3MnL63L5aSoE2HW3auzXFMpi6DjH
         TbKG/fUPmd6LKC2lbCToFsVYoEeSfx9I4RUGEhioe6qLxyp59bXuqhJmkmCOeUZKs5cD
         X8HpkFLiSlm/NUC6DLvjUjn6TFEop78TGUijpPkrXSoGTX3X2MIfSyBxN5kGkxqMtfeE
         5f0w==
X-Gm-Message-State: ACgBeo0InthYd8/GwsKW1xoIhX2lYqLnZ7ViARLWNU/kzwyO4qBRcssO
        +e+cBaE37aPpjO5AvXcR56DUoA==
X-Google-Smtp-Source: AA6agR4LaOp4Oh1qeSJZZcIF0uXsXMXOP3ZzWqjc7Mgld08iz1U69hbOoV5YWs8UYnD4+0cl55OGug==
X-Received: by 2002:a2e:a370:0:b0:25e:502a:5308 with SMTP id i16-20020a2ea370000000b0025e502a5308mr3438370ljn.282.1662708465061;
        Fri, 09 Sep 2022 00:27:45 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f7-20020a05651c02c700b0025e42f8e771sm174577ljo.34.2022.09.09.00.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:27:44 -0700 (PDT)
Message-ID: <747079f8-cf39-a78c-6b8a-51a14991b5c9@linaro.org>
Date:   Fri, 9 Sep 2022 09:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] dt-bindings: gce: add gce header file for mt8188
Content-Language: en-US
To:     "elvis.wang" <elvis.wang@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220729084319.6880-1-Elvis.Wang@mediatek.com>
 <20220729084319.6880-3-Elvis.Wang@mediatek.com>
 <995fbb2b-2b34-d407-6bfd-4798de2251d7@linaro.org>
 <1f7ab756af6e27f5336e3caaefc3081f70bbc85b.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1f7ab756af6e27f5336e3caaefc3081f70bbc85b.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 08:46, elvis.wang wrote:
> Hello Krzysztof,
> 
> On Tue, 2022-08-02 at 10:08 +0200, Krzysztof Kozlowski wrote:
>> On 29/07/2022 10:43, Elvis Wang wrote:
>>> Add gce header file to define the gce subsys id, hardware event id
>>> and
>>> constant for mt8188.
>>>
>>> Signed-off-by: Elvis Wang <Elvis.Wang@mediatek.com>
>>> ---
>>>  include/dt-bindings/gce/mt8188-gce.h | 1079
>>> ++++++++++++++++++++++++++
>>>  1 file changed, 1079 insertions(+)
>>>  create mode 100644 include/dt-bindings/gce/mt8188-gce.h
>>>
>>> diff --git a/include/dt-bindings/gce/mt8188-gce.h b/include/dt-
>>> bindings/gce/mt8188-gce.h
>>> new file mode 100644
>>> index 000000000000..b15e965fe671
>>> --- /dev/null
>>> +++ b/include/dt-bindings/gce/mt8188-gce.h
>>
>> Use vendor in filename, so mediatek,mt8188-gce.h
> 
> yes, mediatek,mt8188-gce.h as filename would be better, will change in
> next version.
> 
>>
>>> @@ -0,0 +1,1079 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>
>> Dual license.
> 
> ok, will use /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */ in
> next version. Also ask if it is possible to use BSD-3-CLause?

Please use GPL-2.0 OR BSD-2-Clause.

>>
>>> +
>>> +/* GCE thread priority */
>>> +#define CMDQ_THR_PRIO_LOWEST	0
>>> +#define CMDQ_THR_PRIO_1		1
>>> +#define CMDQ_THR_PRIO_2		2
>>> +#define CMDQ_THR_PRIO_3		3
>>> +#define CMDQ_THR_PRIO_4		4
>>> +#define CMDQ_THR_PRIO_5		5
>>> +#define CMDQ_THR_PRIO_6		6
>>> +#define CMDQ_THR_PRIO_HIGHEST	7
>>> +
>>> +/* CPR count in 32bit register */
>>> +#define GCE_CPR_COUNT		1312
>>
>> No register values in the bindings.
> 
> Those thread priority will be referenced in the device node and
> congfigured to the hw when trigger hw work.

Using something in DTS does not mean you have to encode it in bindings.
Bindings describe the DTS, not the hardware programming model.

> 
>>
>>
>>
>>> +
>>> +/* GCE subsys table */
>>> +#define SUBSYS_1400XXXX		0
>>> +#define SUBSYS_1401XXXX		1
>>> +#define SUBSYS_1402XXXX		2
>>> +#define SUBSYS_1c00XXXX		3
>>> +#define SUBSYS_1c01XXXX		4
>>> +#define SUBSYS_1c02XXXX		5
>>> +#define SUBSYS_1c10XXXX		6
>>> +#define SUBSYS_1c11XXXX		7
>>> +#define SUBSYS_1c12XXXX		8
>>> +#define SUBSYS_14f0XXXX		9
>>> +#define SUBSYS_14f1XXXX		10
>>> +#define SUBSYS_14f2XXXX		11
>>> +#define SUBSYS_1800XXXX		12
>>> +#define SUBSYS_1801XXXX		13
>>> +#define SUBSYS_1802XXXX		14
>>> +#define SUBSYS_1803XXXX		15
>>> +#define SUBSYS_1032XXXX		16
>>> +#define SUBSYS_1033XXXX		17
>>> +#define SUBSYS_1600XXXX		18
>>> +#define SUBSYS_1601XXXX		19
>>> +#define SUBSYS_14e0XXXX		20
>>> +#define SUBSYS_1c20XXXX		21
>>> +#define SUBSYS_1c30XXXX		22
>>> +#define SUBSYS_1c40XXXX		23
>>> +#define SUBSYS_1c50XXXX		24
>>> +#define SUBSYS_1c60XXXX		25
>>> +#define SUBSYS_NO_SUPPORT	99
>>> +
>>> +/* GCE General Purpose Register (GPR) support
>>> + * Leave note for scenario usage here
>>> + */
>>> +/* GCE: write mask */
>>> +#define GCE_GPR_R00		0x00
>>> +#define GCE_GPR_R01		0x01
>>
>> No. These are no bindings. Do not embed device programming model into
>> bindings header. I'll stop review.
> 
> This GCE_GPR define is an attribute of hw, and different hw versions
> may have different gpr number.

It does not matter that different devices have different programming
model. The bindings are not a place for it.

Best regards,
Krzysztof
