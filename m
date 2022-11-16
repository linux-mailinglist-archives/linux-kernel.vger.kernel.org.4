Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477D662CDFB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiKPWpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiKPWoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:44:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DD062F4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:44:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j15so32592700wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRxksnFA86+EN227UVABkfWLW0/VetsRVg3/grhnVYQ=;
        b=tAuxEW+h+XIdry5tJCylxmmKwcdk3lrynLVXVNyDNl9biFUIwCoujPerXSHCCjgFM2
         M2qinH76hgn6+T697Cwbulu/QxBGdUieOqawYbVX1lD860bdFQCmfb1t1soRIJ1Xl7xk
         sm4qPqULVaeqUDobhQaGHtN6NK5foYsISBpTvpDLwx6521DkgySeGiNpMlK8cRdWZFoo
         xs3LKyW6D8EVSO1Ts4yTGB9dPklE5iWNZ935Fkt/7loSaxtejgMVeUIF/AqYfc+Pp2sn
         Q91HMxkLDy9o7BCVsqqrWoUh/ZpJujpcAgr+43XuT7h4RRi2sRNwO9ZR/z1Vd8RAGAbI
         9/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRxksnFA86+EN227UVABkfWLW0/VetsRVg3/grhnVYQ=;
        b=K1S9GeQMWZti1o3o6obhzHYNVcWzgpxSROp8QH519ZtMq+NH+5RqyQCZNUwJPquOZK
         w098ol79f+Tp/3YAxmBxHy+JDiseRmSBrTmDq5rXzpTCjRwhjAjCU+kM2G4ZCSNskjhr
         CVatQDSTA/P4vbq3u61LucuvoEpYEbQStN/GmSt+noA1x1Ox/KinMl0GKqvzXATXyI+A
         PXt9PAWz6C/izBeJUGp22vVj7b7pmmCz5442w6qi15sQrrh6APsVC1V6TNIdrhj8u2Pc
         r0Mk+yS7Qd4CRjdDMEIczCkKpFto8v87T/LnlQoLHBNz4nxb4D+YZGdFAypB5Y2OP+uk
         lLmg==
X-Gm-Message-State: ANoB5plZPnkZuzk+JUKq+3tNRZAOPVpucv0ey3GE7tBlaboOJeUuP0lk
        1wneL7uU0sWPflD3l5A5UQHpuQa+v0669Q==
X-Google-Smtp-Source: AA0mqf7MSFvQaTYnmCJP6JzGSmABB2sfc4sCIDg8p0Pjg7/qmy8fVBGg4A8E2yUQsr6MbZaLd3ig/g==
X-Received: by 2002:a5d:52c6:0:b0:236:754e:f8b4 with SMTP id r6-20020a5d52c6000000b00236754ef8b4mr14939207wrv.478.1668638668347;
        Wed, 16 Nov 2022 14:44:28 -0800 (PST)
Received: from [192.168.22.132] ([167.98.215.174])
        by smtp.googlemail.com with ESMTPSA id t8-20020adff048000000b002238ea5750csm19765783wro.72.2022.11.16.14.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 14:44:27 -0800 (PST)
Message-ID: <aba64f1d-043e-4dc5-f70a-e8a6ab99fabf@linaro.org>
Date:   Wed, 16 Nov 2022 22:44:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/5] dt-bindings: nvmem: add YAML schema for the sl28
 vpd layout
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
References: <20221114085659.847611-1-miquel.raynal@bootlin.com>
 <20221114085659.847611-4-miquel.raynal@bootlin.com>
 <20221116205203.GA846642-robh@kernel.org> <20221116222812.45dbbcf9@xps-13>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221116222812.45dbbcf9@xps-13>
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



On 16/11/2022 21:28, Miquel Raynal wrote:
> Hi Rob, Srinivas,
> 
> robh@kernel.org wrote on Wed, 16 Nov 2022 14:52:03 -0600:
> 
>> On Mon, Nov 14, 2022 at 09:56:57AM +0100, Miquel Raynal wrote:
>>> From: Michael Walle <michael@walle.cc>
>>>
>>> Add a schema for the NVMEM layout on Kontron's sl28 boards.
>>>
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> ---
>>>   .../nvmem/layouts/kontron,sl28-vpd.yaml       | 62 +++++++++++++++++++
>>>   .../bindings/nvmem/layouts/nvmem-layout.yaml  |  3 +
>>>   2 files changed, 65 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
>>> new file mode 100644
>>> index 000000000000..fef795e79c36
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
>>> @@ -0,0 +1,62 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/nvmem/layouts/kontron,sl28-vpd.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: NVMEM layout of the Kontron SMARC-sAL28 vital product data
>>> +
>>> +maintainers:
>>> +  - Michael Walle <michael@walle.cc>
>>> +
>>> +description:
>>> +  The vital product data (VPD) of the sl28 boards contains a serial
>>> +  number and a base MAC address. The actual MAC addresses for the
>>> +  on-board ethernet devices are derived from this base MAC address by
>>> +  adding an offset.
>>> +
>>> +select: false
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: kontron,sl28-vpd
>>> +
>>> +  serial-number:
>>> +    type: object
>>
>>         additionalProperties: false
> 
> Right, I missed that one.
> 
>> With that,
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Thanks for all the reviews!
> 
> Srinivas, would you add the above property while applying or do you
> prefer me to send a v5?

Applied the series after adding the property.

--srini
> 
> Thanks,
> Miquèl
