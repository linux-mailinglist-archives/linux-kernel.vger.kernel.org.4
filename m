Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5976423F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiLEICT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiLEICL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:02:11 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFE911A08
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:02:10 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g7so17290854lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CcCDj57UFV8AOgeIIEXmIr/HacEY+Xon6hm/uEb2Iw=;
        b=T2SohTom6VZvnIBEh9HWjjtMZ9prz4defo/HP8ip8yOsNK9mMYKFY8kFZETKyfLjQc
         Pcp8kYWVFy6CmdFWoVffYTxsDz6b1gYVD+r6aT7rzdOxdcPIc8D9uMuwt9+VO1lhrFAb
         eRO3qtevmOXHxID0+43u61JRsIUFj1QYwrGFupePXAtf1RLlj2HfV6mBO2rR2XSs4Ney
         1S5ZxtJqr7dHmTELHmA3UFNZqmCgMGLepChf7rgz2zvdx4YfxXT/vVp4iCOXoJcM50ij
         vXOsm3lq/e9Lkmlo2e9rFAcFfmedMgxu7MMOgtahOo2uicpucQWiMZAgzCbbBDzq0j27
         8ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CcCDj57UFV8AOgeIIEXmIr/HacEY+Xon6hm/uEb2Iw=;
        b=6lJDysIdg+4K8lnGdcj6Nf4h1n54j16qIqHNOP+jW8vPIM6kUV8QQR9mDyf+VKNCRq
         cWkQKPWCpzrjGdifYBFcb+sU+PMdP/O/+fRQ8IEvd0wVbEPidQchS/7ogJ+gVvFAUekn
         JOCZti2OZJ6KJfQxB9jatzzoJ4BjXlNkPHxzORK1NNJrO36+sN6Fmg4GcsD7stqkXejR
         3Ur/Y/wWgm/IssnbO67uIbReepME89TF9pTJz0yMnFWGwWR16S9hBQoqQHlwNDTrRJPr
         4K3neA9B2bxjF/2t8RhjFgUdvRmOTlgTUYsRHIvqK2fY2Mu8EYgZUfvy0+EG/kDp8RUw
         u6XA==
X-Gm-Message-State: ANoB5pmXoygMMgGXBW0qzMnD5ba6T6WHxVYZl3jXvQTBl/9RO9MxwZ7F
        oUQSdT4C34NNyH9I91ADYNKAdg==
X-Google-Smtp-Source: AA0mqf6rcyJ9HdefnKnN3HJp9ifP7SDABcqQ9EiIrU1NrL/Hw7qUE+ACeCzA59JAadk4ppmz2rZnpQ==
X-Received: by 2002:a05:6512:3f82:b0:4b4:11e4:65db with SMTP id x2-20020a0565123f8200b004b411e465dbmr19798365lfa.240.1670227328307;
        Mon, 05 Dec 2022 00:02:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d23-20020a056512369700b004b55ef84338sm902252lfs.305.2022.12.05.00.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 00:02:07 -0800 (PST)
Message-ID: <a7b83352-b024-3431-7c85-f150255cf76e@linaro.org>
Date:   Mon, 5 Dec 2022 09:02:06 +0100
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
 <380178d3-7248-4200-d9db-2fd8584eb386@linaro.org>
 <20221205074804.GF54922@ubuntu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205074804.GF54922@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 08:48, Jung Daehwan wrote:
> On Mon, Dec 05, 2022 at 08:31:46AM +0100, Krzysztof Kozlowski wrote:
>> On 05/12/2022 03:06, Jung Daehwan wrote:
>>> On Thu, Dec 01, 2022 at 09:59:06AM +0100, Krzysztof Kozlowski wrote:
>>>> On 01/12/2022 03:13, Daehwan Jung wrote:
>>>>> Add the Samsung Exynos xHCI Controller bindings with DT schema format.
>>>>>
>>>>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
>>>>> ---
>>>>>  .../bindings/usb/samsung,exynos-xhci.yaml     | 25 +++++++++++++++++++
>>>>>  1 file changed, 25 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..c5dde53b6491
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/usb/samsung,exynos-xhci.yaml
>>>>> @@ -0,0 +1,25 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: https://protect2.fireeye.com/v1/url?k=7899b46f-19e45c17-78983f20-74fe485fffb1-728a1b33a5d009dd&q=1&e=bdc50247-e986-43da-a15e-03ac6c3a25e8&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fusb%2Fsamsung%2Cexynos-xhci.yaml%23
>>>>> +$schema: https://protect2.fireeye.com/v1/url?k=ea1282f0-8b6f6a88-ea1309bf-74fe485fffb1-536f21757c62f28b&q=1&e=bdc50247-e986-43da-a15e-03ac6c3a25e8&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>>>>> +
>>>>> +title: Samsung Exynos xHCI
>>>>> +
>>>>> +maintainers:
>>>>> +  - Daehwan Jung <dh10.jung@samsung.com>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: samsung,exynos-xhci
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>
>>>> These do not look like complete bindings... What type of device has no
>>>> resources at all, just compatible?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>>
>>>
>>> It gets resources from dwc->xhci_resources as you can see
>>> dwc3_host_init(usb/dwc3/host.c). I think it doesn't need to get another resource.
>>
>> You refer to driver, but we talk about hardware. Not driver. Your
>> hardware has no resources, so this does not look like complete binding.
>>
>> Best regards,
>> Krzysztof
>>
>>
> 
> It actually doesn't get new resources but shares resources of dwc3 driver.
> You mean it's not complete binding without resources? Is it okay if I
> add description about it? If not, could you suggest a good way?

No, description is not okay, because I doubt that your device does not
have IO space, clocks, interrupts and phys.

Therefore description changes nothing - binding still does not describe
the hardware. How to proceed? Write binding for a real hardware, not
wakelock-Android-driver-override.

Best regards,
Krzysztof

