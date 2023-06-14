Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF4715911
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjE3Ixk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjE3Ixh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:53:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FAEB2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:53:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f7bf29550so650459666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685436814; x=1688028814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkTcWNYD5ZcE8WdcBB1u4fV2IrJSxoZ/lN/xy0mTpWo=;
        b=CxFKiHCCMaH3DClgncsh5rdeISf7tERzqDmbmGkyXXW3Q5pmhcf5SERhzBNkTceWpM
         qWRSAJwz531v0d77LlXVaaEnNAZgVz7kEEid0/0IxItVGUZ4fVa+LX1gaojIceJTzd3i
         9/O7CV7ZylyRtj5iGGdwtQzDZNHSNc1FgexlCYQ2mC+tALhr5HWsXvhp/0ekEXRg5q3+
         gnPRkWB6J8ianlNr6myaSPWJEqAcWA06DdDE8rKDCJ/KTHBJ8yfiCIgG3OcgkBYgfpH8
         XrpuqWaLAuaGTWCffJYQTowFg5GTsVA8YiHJ4GRNAl/TLbw6fs18i0fpwv6/IQTrhUZ5
         Yyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685436814; x=1688028814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkTcWNYD5ZcE8WdcBB1u4fV2IrJSxoZ/lN/xy0mTpWo=;
        b=VlP64AtOAXyOl8UJmVEUjpEBnthGFVfGOcJ7n71TFlo3OcrlBu/wQ1Rw7va3O2cN9s
         33HHt79SoRpAksyHAr21iLyxh759tAcaRcPCKt1YGrxfEoRZg98ReVAjXy18/DyB3AKs
         6fJ/nK+MCN+tnOGhXQa+Vpo+1as1Gr8TR+w+aAzMPFdA1MIQihaGWiyWdbBf5LM7yh5Q
         HjdtvJ4iOh3ZOgn6ltQnt3zOXAtfuyzeNqQxo7j052sdzpawI4OEZCyxw07SaooVlpK7
         QC+QEASEVXUVOJ3uITPZmEYfg2KCh9O+814leYAE1eJLbq+Vb3rLxNaNMGrI3NMXjbuq
         /A2Q==
X-Gm-Message-State: AC+VfDy5dZJK2HLz9PpyRIKQwm9T1W2eU2mRq+4PZ/sMssdCcaiks5sQ
        M75JnmxWNwnnNxLYr9/LxVevGQ==
X-Google-Smtp-Source: ACHHUZ63WjWbwgnXPezm+l9Xip+xs9E7Z+W7Fn0pGUcjRvJEy4l7Bq/C37W3jgbRzSCB5OkYArW00Q==
X-Received: by 2002:a17:907:a02:b0:96a:411a:1cc4 with SMTP id bb2-20020a1709070a0200b0096a411a1cc4mr1614333ejc.66.1685436814552;
        Tue, 30 May 2023 01:53:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id ja20-20020a170907989400b0096f89c8a2f7sm7091772ejc.90.2023.05.30.01.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 01:53:34 -0700 (PDT)
Message-ID: <10074d67-394b-3ddb-8bd1-fc051bdb7f79@linaro.org>
Date:   Tue, 30 May 2023 10:53:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add mediatek mipi csi driver v
 0.5
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>,
        Julien Stephan <jstephan@baylibre.com>
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
 <1853f049-4f00-b7f0-973a-2c4e7b0b2634@linaro.org>
 <7h353w2oug.fsf@baylibre.com>
 <fbf1b0a6-f45d-69a0-5de6-8269567e15b3@linaro.org>
 <7hwn18yndq.fsf@baylibre.com>
 <c63ebd7e-8658-9cdd-4fc4-ade9c94dfa64@linaro.org>
 <7hcz2snpnw.fsf@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7hcz2snpnw.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 21:15, Kevin Hilman wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> On 16/05/2023 23:31, Kevin Hilman wrote:
>>
>>>> Third is to use versioned IP blocks.
>>>>
>>>> The second case also would work, if it is applicable to you (you really
>>>> have fallback matching all devices). Third solution depends on your
>>>> versioning and Rob expressed dislike about it many times.
>>>>
>>>> We had many discussions on mailing lists, thus simplifying the review -
>>>> I recommend the first choice. For a better recommendation you should say
>>>> a bit more about the block in different SoCs.
>>>
>>> I'll try to say a bit more about the PHY block, but in fact, it's not
>>> just about differences between SoCs. On the same SoC, 2 different PHYs
>>> may have different features/capabilities.
>>>
>>> For example, on MT8365, There are 2 PHYs: CSI0 and CSI1.  CSI0 can
>>> function as a C-PHY or a D-PHY, but CSI1 can only function as D-PHY
>>> (used as the example in the binding patch[1].)  On another related SoC,
>>> there are 3 PHYs, where CSI0 is C-D but CSI1 & CSI2 are only D.
>>>
>>> So that's why it seems (at least to me) that while we need SoC
>>> compatible, it's not enough.  We also need properties to describe
>>> PHY-specific features (e.g. C-D PHY)
>>
>> I recall the same or very similar case... It bugs me now, but
>> unfortunately I cannot find it.
>>
>>>
>>> Of course, we could rely only on SoC-specific compatibles describe this.
>>> But then driver will need an SoC-specific table with the number of PHYs
>>> and per-PHY features for each SoC encoded in the driver.  Since the
>>> driver otherwise doesn't (and shouldn't, IMHO) need to know how many
>>> PHYs are on each SoC, I suggested to Julien that perhaps the additional
>>> propery was the better solution.
>>
>> Phys were modeled as separate device instances, so you would need
>> difference in compatible to figure out which phy is it.
>>
>> Other way could be to create device for all phys and use phy-cells=1.
>> Whether it makes sense, depends on the actual datasheet - maybe the
>> split phy per device is artificial? There is one PHY block with two
>> address ranges for each PHY - CSI0 and CSI1 - but it is actually one
>> block? You should carefully check this because once design is chosen,
>> you won't be able to go back to other and it might be a problem (e.g.
>> there is some top-level block for powering on all CSI instances).
> 
> We're pretty sure these are multiple instances of the IP block as they
> can operate completely independently. 
> 
>>>
>>> To me it seems redundant to have the driver encode PHYs-per-SoC info,
>>> when the per-SoC DT is going to have the same info, so my suggestion was
>>> to simplify the driver and have this kind of hardware description in the
>>> DT, and keep the driver simple, but we are definitely open to learning
>>> the "right way" of doing this.
>>
>> The property then is reasonable. It should not be bool, though, because
>> it does not scale. There can be next block which supports only D-PHY on
>> CSI0 and C-PHY on CSI1? Maybe some enum or list, depending on possible
>> configurations.
> 
> OK, looks like include/dt-bindings/phy/phy.y already has
> 
>   #define PHY_TYPE_DPHY		10
>   #define PHY_TYPE_CPHY		11
> 
> we'll add a PHY_TYPE_CDPHY and use that.   Sound reasonable?

Yes. Currently it is usually used as phy-cells argument (after the phy
number/lane/ID), but cdns,phy-type and intel,phy-mode use it directly as
property in provider. In both cases they have a bit different meaning
than yours. You want to list all supported modes or narrow/restrict
them. Maybe hisilicon,fixed-mode fits your purpose?

Best regards,
Krzysztof

