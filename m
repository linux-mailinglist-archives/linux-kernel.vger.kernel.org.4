Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE5B64239A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiLEHby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLEHbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:31:51 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE010071
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:31:49 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id n1so12527793ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 23:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a64rVG9Ar18ZQniQlMUt+8pfp4eItxEV9w2eYv/pKNY=;
        b=NMAXZbjHwIbXkRNbg6BrJIBwvsV6jrLt7CDPT075W1TEEoNSVbA04pL3R/u2BeeBMg
         L+oM2LahFuGws4kT5G+DWaz4N57J9hUSu0YfHCRr0S9Vf2KZmOJ8VJWZFxDxDeUK9XKe
         bCwIQeLCHITtSEZDVqo7KXns+H/Zh373Exvp6+fKUunKH1Z4aO6d8g1dZMkkzwjHex7m
         03DNVJA3NozFKwSimo1AxF8Qsda7FsdOD5zT2tYHf6Ck7pWG/QDfJn0sssIF9qcjFFaJ
         3ap7iGSLvGjJ1DVZinCNVPrJODfYSCvAHUJgIAANwdkbNmdAcDgBcpajiwAgrrOdBx4r
         9qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a64rVG9Ar18ZQniQlMUt+8pfp4eItxEV9w2eYv/pKNY=;
        b=b8M/gh+4q1NYGjW4fHiCxavt8kvAujSabVUAqPP40PJd8BPNl8pbvsSggr7wLH2mF2
         Sh0ZNzlw9QXvnHThijlP+W7WgaFiUn/pa2GhadCPCfBW3Rl++OfFUg/YzsaCyvbbtlCs
         Id7nEPqWgnm7jyIXTAzqrPZhjXTW/hkFUfKHAXVIfqdJjzNUJJDjgxP6VKNCJIJ+hwil
         ThdIE2nKECLxEr7o/LlYeh9B+OLeoLQY1fEx6SbIBuGYKGeQAFOt6+lb7WRfMfrZ32jq
         mfjtnDxo9EyHvRcdd4mwn65R5vifUbYvCHof/fo7f/8IRo1qjFbju3qtp6Sfw6qn2cko
         P64w==
X-Gm-Message-State: ANoB5plkaIeve7hyiwHo8WsXMbmq/WiylwzoJC2lhupzlfdeU7b1pJxv
        UDZBOvFMRpwYfotNJnRUPCOpdQ==
X-Google-Smtp-Source: AA0mqf61RwmMr3Y0QNaJx5XXdo1MjWnCyAQRndhzxJQdgVe9ziURWBuFDT3vMwcHECqWUYRbgIGdPA==
X-Received: by 2002:a2e:c52:0:b0:277:9bf:9411 with SMTP id o18-20020a2e0c52000000b0027709bf9411mr18528188ljd.504.1670225508159;
        Sun, 04 Dec 2022 23:31:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k8-20020a05651210c800b004acff58a951sm2022349lfg.133.2022.12.04.23.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 23:31:47 -0800 (PST)
Message-ID: <380178d3-7248-4200-d9db-2fd8584eb386@linaro.org>
Date:   Mon, 5 Dec 2022 08:31:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: usb: samsung,exynos-xhci: support
 Samsung Exynos xHCI Controller
Content-Language: en-US
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Artur Bujdoso <artur.bujdoso@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221201021941epcas2p4a536a9eb029a990fcb9f27f2b4668d07@epcas2p4.samsung.com>
 <1669860811-171746-2-git-send-email-dh10.jung@samsung.com>
 <e140fdfd-4d8b-7214-d264-0503e6fcc498@linaro.org>
 <20221205020634.GA54922@ubuntu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205020634.GA54922@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 03:06, Jung Daehwan wrote:
> On Thu, Dec 01, 2022 at 09:59:06AM +0100, Krzysztof Kozlowski wrote:
>> On 01/12/2022 03:13, Daehwan Jung wrote:
>>> Add the Samsung Exynos xHCI Controller bindings with DT schema format.
>>>
>>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
>>> ---
>>>  .../bindings/usb/samsung,exynos-xhci.yaml     | 25 +++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
>>> new file mode 100644
>>> index 000000000000..c5dde53b6491
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
>>> @@ -0,0 +1,25 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: https://protect2.fireeye.com/v1/url?k=7899b46f-19e45c17-78983f20-74fe485fffb1-728a1b33a5d009dd&q=1&e=bdc50247-e986-43da-a15e-03ac6c3a25e8&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fusb%2Fsamsung%2Cexynos-xhci.yaml%23
>>> +$schema: https://protect2.fireeye.com/v1/url?k=ea1282f0-8b6f6a88-ea1309bf-74fe485fffb1-536f21757c62f28b&q=1&e=bdc50247-e986-43da-a15e-03ac6c3a25e8&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>>> +
>>> +title: Samsung Exynos xHCI
>>> +
>>> +maintainers:
>>> +  - Daehwan Jung <dh10.jung@samsung.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: samsung,exynos-xhci
>>> +
>>> +required:
>>> +  - compatible
>>> +
>>> +additionalProperties: false
>>> +
>>
>> These do not look like complete bindings... What type of device has no
>> resources at all, just compatible?
>>
>> Best regards,
>> Krzysztof
>>
>>
> 
> It gets resources from dwc->xhci_resources as you can see
> dwc3_host_init(usb/dwc3/host.c). I think it doesn't need to get another resource.

You refer to driver, but we talk about hardware. Not driver. Your
hardware has no resources, so this does not look like complete binding.

Best regards,
Krzysztof

