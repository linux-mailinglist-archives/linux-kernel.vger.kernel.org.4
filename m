Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E422A60363F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJRWwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiJRWwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:52:00 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2204EC588E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:51:56 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a18so9702253qko.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbDAWEmF6WZvYVu7+QMW3DQ4eG7rUNMLg4kSaZK8JKU=;
        b=K6zX4bskLkjPFBzNJ6O+gWZoF/mHEoqGQpMp91aaM/vP37caJcSfvXTy0C1jQnFFfJ
         LIAxbZz3GRZgTaSvb5P3E9jHFN2NcSVhSUR19IghNidPgONLy+N9Ypk8GVVRMimrKlM4
         szAnFCsX8HJDN3V8Y/t8WTntibynMsLMhrSOfajLK+gCeRtVnHMuHXqzx0639Bl7V8T2
         FjBLqNT85x3Bw/cXV3QevZ6V85SBdt4njn2DlwN2X+Np9gkCxWKrJK596X5eTHBvtT11
         PGX0KwLDCvc8UynFFc4he6QH6NDR7F6bpxazIEKatk9QNkDG2UsbC4YZsyoI3s0yF/+k
         GFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbDAWEmF6WZvYVu7+QMW3DQ4eG7rUNMLg4kSaZK8JKU=;
        b=CVPbRgG6SK6Cm3k0q9aYIrb3kUqUXKLhE1AIQQvBcCLhwNnQgPgDLx7pcpMB2xGTkx
         nKBdeD7Cjw+bh1MfFt9V/ukSr4WpWvviRBm/o61nvFKIBdEqAULVK2LxFNBMHkufUzv4
         FenBZsHKg3AsLtEVhUtPkZrnHtdJ6GUYp+GdaPgzxN9ezLri03W9g9SavRIoEtkPo58d
         t87XwkZeEY9r3DJr3J0yL05KlKpRqQG3wriV/ZAyBGd7eqQt4OhjpgoojvE126RY5xEO
         xseTFaAnCY9W45q9qDhxb5GCEAfUFKqVzF4SgGdG2ytHoAk42SX0neJ+cSqs/jFmmVms
         4CzQ==
X-Gm-Message-State: ACrzQf0wZhRpK9RBZgBHOd0gCVzPcuedtlWW1Yhlv+uYPkct2eG+XIZu
        uXMeVxdHovHxX+mKzwGSSuWO7Q==
X-Google-Smtp-Source: AMsMyM7h0XuAp+G/vidJNPRve4OM5DJP4j58wpYTxPaKb1LTQMhwgKA6pfYogIOBEi4yjUBlY3znxg==
X-Received: by 2002:ae9:f116:0:b0:6e9:e5d7:587d with SMTP id k22-20020ae9f116000000b006e9e5d7587dmr3598106qkg.304.1666133515272;
        Tue, 18 Oct 2022 15:51:55 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id t6-20020a05620a450600b006e8f8ca8287sm3276654qkp.120.2022.10.18.15.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 15:51:54 -0700 (PDT)
Message-ID: <9e03801c-dea8-1029-4ba1-fa0d6144b0d7@linaro.org>
Date:   Tue, 18 Oct 2022 18:51:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [EXT] Re: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: convert
 to DT schema
Content-Language: en-US
To:     Xu Yang <xu.yang_2@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
 <20221014095148.2063669-2-peng.fan@oss.nxp.com>
 <359bc301-fed6-80eb-6945-caeb7fbb319d@linaro.org>
 <PAXPR04MB87840FFD365C5C044D54B55F8C299@PAXPR04MB8784.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB87840FFD365C5C044D54B55F8C299@PAXPR04MB8784.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2022 23:17, Xu Yang wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Saturday, October 15, 2022 10:53 PM
>> To: Peng Fan (OSS) <peng.fan@oss.nxp.com>; gregkh@linuxfoundation.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org; s.hauer@pengutronix.de; Xu Yang <xu.yang_2@nxp.com>
>> Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; linux-usb@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Jun Li <jun.li@nxp.com>;
>> Peng Fan <peng.fan@nxp.com>
>> Subject: [EXT] Re: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: convert to DT schema
>>
>> Caution: EXT Email
>>
>> On 14/10/2022 05:51, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Convert usbmisc-imx to DT schema format.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  .../devicetree/bindings/usb/fsl,usbmisc.yaml  | 52 +++++++++++++++++++
>>>  .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
>>>  2 files changed, 52 insertions(+), 18 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
>> b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
>>> new file mode 100644
>>> index 000000000000..c83ffb6729b5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
>>> @@ -0,0 +1,52 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id:
>> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fusb%2Ffsl%2Cusbmi
>> sc.yaml%23&amp;data=05%7C01%7Cxu.yang_2%40nxp.com%7C24e82b830d9f47018ff408daaebcf83d%7C686ea1d3bc2b4c6
>> fa92cd99c5c301635%7C0%7C0%7C638014423898086337%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=gNwMbGsiuMS1zgvbgATYAY70gv2nIhX%2F
>> 16IxiSYBf3s%3D&amp;reserved=0
>>> +$schema: https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-
>> schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cxu.yang_2%40nxp.com%7C24e82b830d9f47018ff408daaebcf83d%7C68
>> 6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638014423898242035%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
>> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=jJUP5aKNkfkAefhNQL9almV
>> Gqzn8cTNyjcRlZMOZwRk%3D&amp;reserved=0
>>> +
>>> +title: Freescale i.MX non-core registers
>>
>> You sent v2 before we finished this topic. Is it correct? Even if TXT
>> had such title, let's don't keep the wrong name.
>>
>> If it is non-core registers, why it is in USB? Why it is an usb-misc device?
> 
> The chipidea's doc has a more clear explanation about core and non-core
> registers as follow:
> 
> "There are two kinds of registers in the USB module: USB core registers
> and USB non-core registers. USB core registers are used to control USB
> core functions, and more independent of USB features. Each USB controller
> core has its own core registers. USB non-core registers are additional 
> to USB core registers, and more dependent on USB features. i.MX series
> products vary in non-core registers."
> 
> So we have named it like this. 

"Freescale i.MX non-core registers" implies this hardware is about i.MX
registers. i.MX like for all SoCs.

What you wrote now, about USB registers - quite different.

However if you describe here registers, not some device, usually it's
place is not USB...

And actually all devices are bunch of registers, right? So everything
should be called registers?

Name is poor choice, so please find more appropriate one matching real
purpose of this block.


Best regards,
Krzysztof

