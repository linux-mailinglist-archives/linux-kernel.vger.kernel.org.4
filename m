Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246BE704E63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjEPM5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjEPM5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:57:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14696182
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:57:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965d2749e2eso2143520566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684241809; x=1686833809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OQUP3t1jhv5FR7sMFGoLjqrDUypem+tZjlihV1PEPdA=;
        b=rElzHPfQT/0ky66F7WOrYDbG7pvQcSJJp8+61HTe1THh4uByQT+CdhHbcYUoZWwzkE
         GZOqhJ4gaaQTPUYQqJd4Q3OR7nB02LcCasxlcr2beWFnIQcZdCZZeg97yGbWdgqDzhcM
         9pjxENGSrAEER0JlgcFuZgQnTtXyF/I0YOK7S/FOLAnUbznRQ9yKv2j3XyuoRHbzgoqi
         VcL1l2TS87YpOHbLPB0MONuWgRLFjFFMSFL3xh4cpIgyVjTUxUE+RG5o7YVhrXtX2czL
         sKIv2BoR+Be2AvZ0RFT/lqCnJGsRX7UHXUBl5Vu90lzUWeonp4S8t4rXFBtKqvFd2YEz
         Ah0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241809; x=1686833809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQUP3t1jhv5FR7sMFGoLjqrDUypem+tZjlihV1PEPdA=;
        b=IO4HwZMB/depcRXjFfWANr5pleT8sgwsLk39y5kqUa2gujhe0nmo98XY7ETXrJBbym
         4lWQbINxT6M1w8awBiQ4M82rKXqChteDDNcc4tOVvlSjlyl7qkB1aFMbAq+31YEscfbS
         YKwqLPfAd0Kc+khk1GrwhWPmNi3JjFxyvSSnUBX9SLF2E3cuqIo9zvQub91UoCbyFcb7
         SlqG1xqZjSwEwkCjagmkighmGxpdqCuH6b5YzFV6m1lNiNbLsFNG4o/XwLNtCKauSKu4
         a7qB3vfaIyS6cLOwLxYPXkNQDNpBPrNu0oMaGkWGHORBGb+Mvdtqvlsvuar8O4mFebhJ
         uGmQ==
X-Gm-Message-State: AC+VfDy0JSHW2iPA/NOBDVRMNNahyEGU/V4Npz1gFk3QBmClf8fjnHkD
        HlkhzyT2N3DP9IsFrcuPI6gyhA==
X-Google-Smtp-Source: ACHHUZ6oNVjTv0Nm20mqSIq4KfzxntkBT+hq6L9ST6wpYu+KvPTiRFW4lblE200qZgGgVd23W98xHA==
X-Received: by 2002:a17:906:eec9:b0:94f:73db:b390 with SMTP id wu9-20020a170906eec900b0094f73dbb390mr29959608ejb.65.1684241809277;
        Tue, 16 May 2023 05:56:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id u18-20020a170906069200b00967004187b8sm10843538ejb.36.2023.05.16.05.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 05:56:48 -0700 (PDT)
Message-ID: <1853f049-4f00-b7f0-973a-2c4e7b0b2634@linaro.org>
Date:   Tue, 16 May 2023 14:56:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add mediatek mipi csi driver v
 0.5
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     robh@kernel.org, chunkuang.hu@kernel.org,
        linux-mediatek@lists.infradead.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
 <20230515090551.1251389-2-jstephan@baylibre.com>
 <ab9aa30f-82d7-1d14-5561-e19ff10af0b0@linaro.org>
 <4yppinkucchwnwtnnpbqdn4bejmntjq3q6mx6es55f2pwyce3c@qdhdks47lpyt>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4yppinkucchwnwtnnpbqdn4bejmntjq3q6mx6es55f2pwyce3c@qdhdks47lpyt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 11:41, Julien Stephan wrote:
> On Tue, May 16, 2023 at 10:07:47AM +0200, Krzysztof Kozlowski wrote:
>> On 15/05/2023 11:05, Julien Stephan wrote:
>>> From: Florian Sylvestre <fsylvestre@baylibre.com>
>>>
>>> This adds the bindings, for the MIPI CD-PHY module v 0.5 embedded in
>>> some Mediatek soc, such as the mt8365
>>>
>>> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
>>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>>
>> What are the changes? IOW: changelog here or in cover letter.
>>
> Hi Krzysztof,
> I added a changelog in the cover letter, but I will try to be more
> descritpive next time. Changes from v1 are mainly style issues fixed
> (mostly from your first review)

What do you mean by "in cover letter"? There is no cover letter.

> 
>> Subject: you have some multiple spaces.
>>
>> Subject: drop driver. Bindings are not for drivers.
>>
>>> ---
>>>  .../phy/mediatek,phy-mipi-csi-0-5.yaml        | 62 +++++++++++++++++++
>>>  MAINTAINERS                                   |  6 ++
>>>  2 files changed, 68 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml b/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
>>> new file mode 100644
>>> index 000000000000..5aa8c0b41cdf
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
>>> @@ -0,0 +1,62 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-Only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/phy/mediatek,phy-mipi-csi-0-5.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Mediatek Sensor Interface MIPI CSI CD-PHY
>>> +
>>> +maintainers:
>>> +  - Julien Stephan <jstephan@baylibre.com>
>>> +  - Andy Hsieh <andy.hsieh@mediatek.com>
>>> +
>>> +description:
>>> +  The SENINF CD-PHY is a set of CD-PHY connected to the SENINF CSI-2
>>> +  receivers. The number of PHYs depends on the SoC model.
>>> +  Depending on the soc model, each PHYs can support CDPHY or DPHY only
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - mediatek,phy-mipi-csi-0-5
>>
>> SoC based compatibles. 0-5 is odd.
>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  '#phy-cells':
>>> +    const: 0
>>> +
>>> +  mediatek,is_cdphy:
>>
>> No underscores in node names.
>>
>>> +    description:
>>> +      Specify if the current phy support CDPHY configuration
>>
>> Why this cannot be implied from compatible? Add specific compatibles.
>>
>>
> This cannot be implied by compatible because the number of phys depends
> on the soc and each phy can be either D-PHY only or CD-PHY capable.
> For example mt8365 has 2 phy: CSI0 and CSI1. CSI1 is DPHY only and CSI0 is CD-PHY

So it is SoC specific so why it cannot be implied by compatible? I don't
understand. You will have SoC specific compatibles, right? or you just
ignored my comments here?

>>

Best regards,
Krzysztof

