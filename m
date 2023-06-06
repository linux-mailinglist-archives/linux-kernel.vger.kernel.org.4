Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1E2724511
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbjFFN7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjFFN7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:59:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A58210CC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:59:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30af0aa4812so5385535f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686059974; x=1688651974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tSLIBOkc8AT3ecozvTP01c4tDm7xKenl/SZU7EiNLBM=;
        b=ZElHMU2eHbQorA8SEksHZGZB6pSzWIHr4CQl1Gv7JRjgnkWuri5p2co1ZR+Gag4h1V
         aYAQEhIAd/TAJDVHyR7u4S7lX5hfqJlPD5H6455N16jbtTlWkU3Kky8oZ4+CtgeHABnr
         G+nGLUrLX82SFoyzVX04Jm/RguqzG3PpO/KBW2vw7QiBMvjkEurhW0LGzGo+WRBT9J4L
         Pzf/Tce1UEU3vP1rQUgeWw33JoDNZebAS7O/mDAcPYD6KOJUOyV6FPciw4Tft/4v/LT0
         rSFXFlstWyr2Y4TnW7Pd6c2B3TYg/LiB67H3tFzTDx7ymTsgpEzKsxJ1vWzG/w0qxUs6
         AjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686059974; x=1688651974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSLIBOkc8AT3ecozvTP01c4tDm7xKenl/SZU7EiNLBM=;
        b=FFL9ORRbrS3PctP1Z+gLWbAnfvsuKMlBbERVUPytefRuljtvh1l8h9NI06/LMiFdC/
         V1U6Un1lPO2zSWZp3cHFpH5E4kzd0K7uUBmMCPg6Kgh6YfY1RmkeBWVQkKcHeIjCMxVq
         8yewuTFJIpDqwBuSpB3EJiLYVo2a/JaNaWtnf+jQj47GLUUseNaTvfmQxOyb0AmjsPkt
         pgzsOdUrDEsz2U24ry52eND85g1WIiLVNSPz3n3J+AlXfUUe710JfYlNiVE+g9RLU8sv
         UcbHYum2g0BiDfIi09e2hYePzSP2Letk368DQWOljiklFhdGySGot8mOmVTD/Y/nF3dx
         D+jQ==
X-Gm-Message-State: AC+VfDz9zKxDnR7qIBmHz6sSE/uCAmDkZSwRwfwLuTrU17IvcH9fINaf
        qeZj34z3rfLUXe3RBQsJf0UBkA==
X-Google-Smtp-Source: ACHHUZ5QcrIk/sG7EBlfot3tzH/HEAB3ctiWzutPWmL77jqVYxFiOWDX1sdw4eI4ZiPy7xpCxRh+1Q==
X-Received: by 2002:a5d:5088:0:b0:309:4cd5:76f8 with SMTP id a8-20020a5d5088000000b003094cd576f8mr1986798wrt.2.1686059974630;
        Tue, 06 Jun 2023 06:59:34 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d504e000000b00300aee6c9cesm12757402wrt.20.2023.06.06.06.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 06:59:34 -0700 (PDT)
Message-ID: <fa5147f8-26e2-c4e6-ff3e-ba7b22027a81@baylibre.com>
Date:   Tue, 6 Jun 2023 15:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 2/7] iommu/mediatek: Fix two IOMMU share pagetable
 issue
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
References: <20230602090227.7264-1-yong.wu@mediatek.com>
 <20230602090227.7264-3-yong.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230602090227.7264-3-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2023 11:02, Yong Wu wrote:
> Prepare for mt8188 to fix a two IOMMU HWs share pagetable issue.
> 
> We have two MM IOMMU HWs in mt8188, one is VPP-IOMMU, the other is
> VDO-IOMMU. The 2 MM IOMMU HWs share pagetable don't work in this case:
>   a) VPP-IOMMU probe firstly.
>   b) VDO-IOMMU probe.
>   c) The master for VDO-IOMMU probe (means frstdata is vpp-iommu).
>   d) The master in another domain probe. No matter it is vdo or vpp.
> Then it still create a new pagetable in step d). The problem is
> "frstdata->bank[0]->m4u_dom" was not initialized. Then when d) enter, it
> still create a new one.
> 
> In this patch, we create a new variable "share_dom" for this share
> pgtable case, it should be helpful for readable. and put all the share
> pgtable logic in the mtk_iommu_domain_finalise.
> 
> In mt8195, the master of VPP-IOMMU probes before than VDO-IOMMU
> from its dtsi node sequence, we don't see this issue in it. Prepare for
> mt8188.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

