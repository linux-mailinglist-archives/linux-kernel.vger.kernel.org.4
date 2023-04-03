Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2541E6D4159
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjDCJy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjDCJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:54:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1712826AE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:53:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w9so114926608edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680515630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJlrdDbF9+4E4VB54zkQelJria6H4TDQP9yMZcAgHLg=;
        b=oCGbWw21DqLjWGRThvdqExQX1aM36eMkLTFG0IRkiJSHh1Ifh6zq0c7Lm1E5lEXkrd
         GjMSeirGrQkQi6Wl/ykRryRlCeIKTf7xt4v5rSlDW6+rRANWCpNLE1hUcqSuGMk+QNz2
         cFhTbrssxOzG/pM9oLemV/vjGoxTb6Lu4axMMrbuMNaBOLb4sh5qRBPMUcEtaQ19SgAJ
         XDXM2P2B0MnRQhtlZF6Nu2uJ8/IdPtNKuXXZ8SnI3Rk3FENQGGVx6cG5te3EfKXp/daG
         nWFgfZSlZUK7/k3mtT5rrpQ8mdFR8sL88d+7WkjW5hj2IYLfWrfIzmTNErOfYDgheEOr
         s3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJlrdDbF9+4E4VB54zkQelJria6H4TDQP9yMZcAgHLg=;
        b=x2djExhkFCvH5IRNJsVxZKCyo3DlANpBRVJTDqCu2SdB1HNBDhIE5kTIdSUpRtD1vP
         37hnLWQAUxoHiQeCWi1HiKkqiTqNVEs8LZVIiScYvTJT+OCJH06sCihD5rrPlTnO44+M
         HWsIGPkoDEVROQhQWg2zz14HhOMFHwgQMtuIMm/3dZ9L3BBPJFzHgAD+znJmcNjbKgaF
         NK0B/GhSCcJQuz0cZHWuLF41PpSW7CYTxEXu/Qe9U5FDCE8jSzKApGj+gtlNeTriJ6kQ
         WZ/r8KB4wXd2mzd0Oq/I2ujPcbi5elFfo+Hz5NaKFl/2ZrMi0RbV5bH53fhy/0nDShN6
         EaKQ==
X-Gm-Message-State: AAQBX9feskz21cr2KbxgPEeCT2fS0XziSmhW8r+dQNx9pDk72wJr55Sg
        dOQdedOGZ5ClFZXq4md4diIuuw==
X-Google-Smtp-Source: AKy350a0a1bWE0yN8qnslUgf71yktHZaBm3SnfLl9tiApjHozALcTanZo2RJWIL/xhh3Ze7qTXYG6Q==
X-Received: by 2002:a17:907:d10:b0:925:6bcb:4796 with SMTP id gn16-20020a1709070d1000b009256bcb4796mr20077828ejc.38.1680515630517;
        Mon, 03 Apr 2023 02:53:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id u13-20020a1709063b8d00b0093e261cc8bcsm4337535ejf.58.2023.04.03.02.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:53:50 -0700 (PDT)
Message-ID: <c86d2388-609c-528e-b250-90bd85b97264@linaro.org>
Date:   Mon, 3 Apr 2023 11:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/9] media: dt-bindings: cadence-csi2rx: Convert to DT
 schema
Content-Language: en-US
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230331121826.96973-1-jack.zhu@starfivetech.com>
 <20230331121826.96973-4-jack.zhu@starfivetech.com>
 <0aa3a039-daf3-7e05-6da9-258335a5ca20@linaro.org>
 <9c132e62-7830-90bf-2c3e-1568a54eb6ec@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9c132e62-7830-90bf-2c3e-1568a54eb6ec@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 11:48, Jack Zhu wrote:
> 
> 
> On 2023/4/1 4:12, Krzysztof Kozlowski wrote:
>> On 31/03/2023 14:18, Jack Zhu wrote:
>>> Convert DT bindings document for Cadence MIPI-CSI2 RX controller
>>> to DT schema format.
>>>
>>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>>> ---
>>>  .../devicetree/bindings/media/cdns,csi2rx.txt | 100 ----------
>>>  .../bindings/media/cdns,csi2rx.yaml           | 174 ++++++++++++++++++
>>>  MAINTAINERS                                   |   1 +
>>>  3 files changed, 175 insertions(+), 100 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>>>  create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt b/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>>> deleted file mode 100644
>>> index 6b02a0657ad9..000000000000
>>> --- a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>>> +++ /dev/null
>>> @@ -1,100 +0,0 @@
>>> -Cadence MIPI-CSI2 RX controller
>>> -===============================
>>> -
>>> -The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
>>> -lanes in input, and 4 different pixel streams in output.
>>> -
>>> -Required properties:
>>> -  - compatible: must be set to "cdns,csi2rx" and an SoC-specific compatible
>>
>>
>> ...
>>
>>> +$id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Cadence MIPI-CSI2 RX controller
>>> +
>>> +maintainers:
>>> +  - Maxime Ripard <mripard@kernel.org>
>>> +
>>> +description:
>>> +  The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
>>> +  lanes in input, and 4 different pixel streams in output.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: cdns,csi2rx
>>
>> That's not equivalent conversion and your commit msg does no mention any
>> drops in compatibles.
>>
> The equivalent conversion refers to 'an SoC-specific compatible'?

Yes.

> I'm not sure that, is it enough to add a description (drop an 'SoC-specific compatible')
> to my next version commit message?

Original binding did not allow csi2rx compatible alone. Your binding
here allows it, thus it is not simple conversion.

I think patch 5 should be squashed here - with proper explanation.
Usually new compatibles should not be messed with conversion, but this
conversion on its own does not make much sense.



Best regards,
Krzysztof

