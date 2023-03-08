Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2A26B049A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCHKgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCHKfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:35:55 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A822D366B3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:35:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a25so63996887edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678271720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1eqhJeejf+RQmERnpGqMGzgAI9CUz2kwB1CbIir0tP8=;
        b=ykMZOphQFA1DVSYvYk/K0/T3ZpYXYSMOYsUgSrev8ZzdS3BDpmr6OP1+nrm/d9U+2D
         I5/FuOppgiSp2DjICE5b3FChw++7ies1Gq/GWCNV51wX+V+S0v6g2BXiARRFYDE+gsP0
         6UgUE+Lip0yiSKrmlbSVXOttgUEZT6sLjjomSOtbLNvG2bNW33V25PcdEAAshy3tifHu
         8TJbyP7cbB44nb7R5r7J+GouRiMHGaTeMR0OnAFaW+uf+gBlx4FN82TKlljm4f8VhB9N
         YJ+7gBv8ezagrTk0R/nVw56gIAjc1k78sWaghur2EITACXeGtXmft1RZpnuufSjaWzgA
         kGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eqhJeejf+RQmERnpGqMGzgAI9CUz2kwB1CbIir0tP8=;
        b=dTFZgBnz8ZBseGQPi+YuwfrvuEljWOnQaat3LlhwoVuln23gZo1lbsfhhhUjmYwuLg
         JggXKg2vP/U67yU2BgSq4DeZCrKPHnU0y8I7mmsPMsUYzppMc/WG6kBYis9woNEQPpkd
         snfjedJS/C8yTzYVta21HnoghIA8gwqurSmsJtjipwJR7CtT23RxYnMNzg3t7t+kXB+4
         V9jvW4mMaiYIbCissyhno1crYySvo5/SqwJz8DzqsKYuGnzhLRN5OG6VzrlCQv20LL2g
         bO8wK1T8XP84JmCHZU86RfmspOyYfFQljeLS0jB2Jg755SgqmVbgeu9tqxmieDM/bFOq
         FIvw==
X-Gm-Message-State: AO0yUKVmN2jXTiP3jPsv1XZEIM50wI2+nsQX782ihTBOl28a5yUP/Sgy
        gJzb68+SxUCYesOxlMgn6FgCcA==
X-Google-Smtp-Source: AK7set85h3HEkM1KFOIkaPrFIqwjm1PNUWaPYN8WE8M5LcYma/+vDI3oDsZBOeitBKuc8tC5KN/j0A==
X-Received: by 2002:a05:6402:383:b0:4ad:1e35:771f with SMTP id o3-20020a056402038300b004ad1e35771fmr15484678edv.35.1678271720773;
        Wed, 08 Mar 2023 02:35:20 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id k17-20020a170906a39100b008b17fe9ac6csm7397482ejz.178.2023.03.08.02.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:35:20 -0800 (PST)
Message-ID: <388e2274-d46a-68a4-3e85-5bd597085041@linaro.org>
Date:   Wed, 8 Mar 2023 11:35:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 1/7] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com,
        youlin.pei@mediatek.com
References: <20230307080555.14399-1-yong.wu@mediatek.com>
 <20230307080555.14399-2-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230307080555.14399-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 09:05, Yong Wu wrote:
> From: "Chengci.Xu" <chengci.xu@mediatek.com>
> 
> Add descriptions for mt8188 IOMMU which also use ARM Short-Descriptor
> translation table format.
> 
> In mt8188, there are two smi-common HW and IOMMU, one is for vdo(video
> output), the other is for vpp(video processing pipe). They connects
> with different smi-larbs, then some setting(larbid_remap) is different.
> Differentiate them with the compatible string.
> 
> Something like this:
> 
>   IOMMU(VDO)          IOMMU(VPP)
>       |                   |
> SMI_COMMON_VDO      SMI_COMMON_VPP
> 
> ---------------     ----------------
>   |     |    ...      |     |    ...
> larb0 larb2  ...    larb1 larb3  ...
> 
> We also have an IOMMU that is for infra master like PCIe.
> And infra master don't have the larb and ports.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Indeed, I missed broken checkpatch/DCO chain.

NAK. Please fix the chain.

Best regards,
Krzysztof

