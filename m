Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4027394E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjFVBvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFVBvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:51:07 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB8D10D2;
        Wed, 21 Jun 2023 18:51:07 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-341d62e78d3so30477615ab.3;
        Wed, 21 Jun 2023 18:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398666; x=1689990666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq1ENgepBlp0mPUx1MFk9e+JFejzz2BH+QBOgxDDQfM=;
        b=fMpHjAhckAm9+2JJakLCvjaEtgpSK/WAE2r+nCi+NeXXv02V7ob1CA/2unjtXWv6OX
         BuY+Ootw692qu+L1u/ahJMmhURVyEiZhu/4fTVQ5V1tDGzkviMniBTsLWraY5stFYBJn
         qYd/HX+qQC1EoQmapIaswMJQqfl96Gwb+E9bYHhXiAxUBlUQ4fDpx63+FI8el/supZlm
         TRL5lCd5pP6qfMEJObeGVOsL1ahG+eb1sd5k8BowiAzg1o06sbzyFuiDPHBWX+S4rnnO
         vXidyd7Rz/2fxwFFq6YrV9+qiEnzxitPh+As5ePjIQlJ/ACtuZuVM35xAtoQEfNuFLMy
         JebQ==
X-Gm-Message-State: AC+VfDxkmTk+BGNbsl34idjsm9yoPUXnCnqX2T40PSSob0SHpv35d0jV
        9OjCzlPgCJQWmc1W2/Vtww==
X-Google-Smtp-Source: ACHHUZ7V0MbDp5bngrHcOwo2f+hetLBQ/eR1lDweuJphcSDdwc2Xc9JDpGKLsSIcOLt5l2829t2Svg==
X-Received: by 2002:a92:dc0a:0:b0:340:4e87:9947 with SMTP id t10-20020a92dc0a000000b003404e879947mr15448720iln.9.1687398666267;
        Wed, 21 Jun 2023 18:51:06 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j25-20020a02cb19000000b0042890b8c2bbsm101312jap.50.2023.06.21.18.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:51:05 -0700 (PDT)
Received: (nullmailer pid 41286 invoked by uid 1000);
        Thu, 22 Jun 2023 01:51:03 -0000
Date:   Wed, 21 Jun 2023 19:51:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     will@kernel.org, robdclark@gmail.com,
        linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org,
        robin.murphy@arm.com, agross@kernel.org, iommu@lists.linux.dev,
        dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        joro@8bytes.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] dt-bindings: iommu: qcom,iommu: Add QSMMUv2 and
 MSM8976 compatibles
Message-ID: <168739866325.41226.10001696049187967541.robh@kernel.org>
References: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
 <20230620095127.96600-6-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620095127.96600-6-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2023 11:51:26 +0200, AngeloGioacchino Del Regno wrote:
> Add compatible string "qcom,msm-iommu-v2" for the inner node,
> along with "qcom,msm8976-iommu" as a first user of it and
> "qcom,msm-iommu-v2-ns" and "qcom,msm-iommu-v2-sec" for the context
> bank nodes to support Qualcomm's secure fw "SMMU v2" implementation.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/iommu/qcom,iommu.yaml   | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

