Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FF3627F33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbiKNM4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbiKNM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:56:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2494A27FEC;
        Mon, 14 Nov 2022 04:56:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA840B80EBD;
        Mon, 14 Nov 2022 12:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BCCC433D7;
        Mon, 14 Nov 2022 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668430584;
        bh=2D2gQfZ06yOvJUXC9oWEx/vkQjZiEDRDwKv9ey449SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+08jDKCi1InaKWpdvju0i+QzkvW28vhnPlL0DjgU6CeXo95YDNBZo3est930MVpg
         dhpr/qhJyhdvXGDTfdpnp3RXlq78yCxiBQrSXYYEwHtDn1bdDeg0huYKNJr6ItIH7h
         N3xLYLP4ZNF8xjQUs190xPK97RMET1KVtZWsmY5ecO+zEJ/oX+0hK7Ytf6eS98IiqM
         +LsOsCJloheDX1DTlPTb5sI1qjOxV2R+zDuJeSjr/Y1LNEetsCHGvha9BFYMayMnrm
         gKfz+t9HHQaeDBYAEY0ZCnfwpm/85S8vgM6lPV6t0rGvgwrupUSHsx+IqiyXEa9Biy
         9JBF2s9ggcZBw==
Date:   Mon, 14 Nov 2022 12:56:18 +0000
From:   Will Deacon <will@kernel.org>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] dt-bindings: iommu: arm-smmu: Add binding for
 sm6125
Message-ID: <20221114125616.GC30263@willie-the-truck>
References: <20210612094606.89576-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612094606.89576-1-martin.botka@somainline.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 11:46:04AM +0200, Martin Botka wrote:
> This patch adds binding for sm6125 SoC
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
> Changes in V2:
> Add commit description
> Changes in V3:
> None
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 9d27aa5111d4..26d7ca86e519 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -37,6 +37,7 @@ properties:
>                - qcom,sc7280-smmu-500
>                - qcom,sc8180x-smmu-500
>                - qcom,sdm845-smmu-500
> +              - qcom,sm6125-smmu-500
>                - qcom,sm8150-smmu-500
>                - qcom,sm8250-smmu-500
>                - qcom,sm8350-smmu-500

Neither this patch nor the subsequent driver patch apply. Please can you
send a v4 based on v6.1-rc1?

Thanks,

Will
