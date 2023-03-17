Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4D6BE4AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjCQJBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjCQJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:00:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFACB7182
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:59:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so17592350edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679043561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BpkLCLMxsQQ5zA0IK7LMtaOGnKaPKAwAcMkZQbS+ecQ=;
        b=pHbbCuGA73Mk/5ARt0wjvlbfuD2U2p8YzBghmxGyOdaN1JNoHewvpvgFn1ZBgKiz0X
         9dLD2nTcp321vivUCuNFoOtFep8Y8qhtbfOWUfJ0QOgjI8jhg+ubkiTTkgvQHTXLyLdL
         txqylu8tsHvYkw9YRgn6S2zhcDAAc+Gmp3kkxwc6XsHw3xR9jQrevpjlD9zNBhycviCW
         DTqaQ7jwAUnLd9Ya7Q9AT2JOBqnOg3HFYC20kG8GV9Im5KhlLOBAa3GQLRrpuRdRcAYX
         qjbJG6UgCroi8P8LZtsXaQpKWgzP7W+hyKY4euRp7N2+28vHYw6j8IAHA5buT9Zgo9On
         J7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpkLCLMxsQQ5zA0IK7LMtaOGnKaPKAwAcMkZQbS+ecQ=;
        b=h7HwGDnc266urw5R70aVb0fV/xxhAoLNK+sZ9iZbwRkMOWYvx0vRm7SYFh3PipID+B
         AAyb9kR2vDrdVm5HVDzI8DaDoyDVUzJ4cHTJCS7nbtRZezRTPgBynw6mk4DEwZogT49t
         9MoFpO8HGsb0UeaXo9hcekovSx3ee5qqqLqrtAzWlPSsE5dynLfBG3wcKHUoiilox0xM
         /F3CauUU2xIZq6wR/SloyOyHte9yFDJkCgGanyhhEFbl3DxFEEde6meyYJf3UIOs7rYO
         JD27ac3UsuoCVGYn0n4Wq+18hkUrsWK9sMRINlVFkB6zQCGMfr6lpqhltwpclldqpDlu
         /QBw==
X-Gm-Message-State: AO0yUKU0lpj/ZW/zIjoEHhdMUAX1DBr7SAbJcudiXgG+pKzFRx+4xzqg
        66JODUymGMy8IT3YmKjdLo0dlQ==
X-Google-Smtp-Source: AK7set9i+hpbTfIEJCzFJx6UJzlGdk6rfTOxfYznJbRKglHBbeQKiDgDqUCtziNFxDe/kvzbG7mqbA==
X-Received: by 2002:a17:906:e0a:b0:92b:846d:8928 with SMTP id l10-20020a1709060e0a00b0092b846d8928mr12685839eji.65.1679043560906;
        Fri, 17 Mar 2023 01:59:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id k15-20020a50ce4f000000b004bef1187754sm747872edj.95.2023.03.17.01.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:59:20 -0700 (PDT)
Message-ID: <265d30c5-93a7-7e60-32f2-ec15f91af5b9@linaro.org>
Date:   Fri, 17 Mar 2023 09:59:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v9 1/7] dt-bindings: mediatek: mt8188: Add binding for MM
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
        jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com
References: <20230317085541.20447-1-yong.wu@mediatek.com>
 <20230317085541.20447-2-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317085541.20447-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 09:55, Yong Wu wrote:
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
>    IOMMU(VDO)          IOMMU(VPP)
>       |                   |
>  SMI_COMMON_VDO      SMI_COMMON_VPP
>  ---------------     ----------------
>   |     |    ...      |     |    ...
> larb0 larb2  ...    larb1 larb3  ...
> 
> We also have an IOMMU that is for infra master like PCIe.
> And infra master don't have the larb and ports.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |  12 +-
>  .../memory/mediatek,mt8188-memory-port.h      | 489 ++++++++++++++++++
>  2 files changed, 500 insertions(+), 1 deletion(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

