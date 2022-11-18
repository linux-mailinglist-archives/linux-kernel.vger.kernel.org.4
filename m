Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D011162F66F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241641AbiKRNjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242172AbiKRNjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:39:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C5B91507;
        Fri, 18 Nov 2022 05:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68CEEB823C1;
        Fri, 18 Nov 2022 13:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B03C433C1;
        Fri, 18 Nov 2022 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668778743;
        bh=HRUKLVHLfVR3bag7itC0ot8FpX0rB1IDAEuPUNc1mv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmA+1Dwr363MWkHzHw7zScpU9AHs07WYlR7VixpOq/+4Ze4oQyedQtkwOPZ/LzemA
         zQAJ9Zm7HwpDmk47fdwBjbAjsWhD+2t+pCeU2mJI+NypaFXBOX8e21WbCQDxLQQ/ek
         Svi1WeBBhXuqBP+Q1alHn8WWRDYnwEBSZBjdkrtS3Tu/AMAis4p8DCO1VEmE2NIqMT
         YiGDFqIh+p8blZWwrfh+BQAMtxQ9kpr47Vt0wO+33a0YGmuunGnO06EHIxG7J2M1JJ
         VA9GURRmNFs/StIX93u19cg/jBPBNItrvlfaL90pF3EfqiFbHG7mg90WTGXNflJY0w
         7rmIa4PCEg0HQ==
Date:   Fri, 18 Nov 2022 13:38:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        patches@linaro.org, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: arm-smmu: Allow 3 power domains on
 SM6375 MMU500
Message-ID: <20221118133855.GB4046@willie-the-truck>
References: <20221115152727.9736-1-konrad.dybcio@linaro.org>
 <20221115152727.9736-2-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115152727.9736-2-konrad.dybcio@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 04:27:19PM +0100, Konrad Dybcio wrote:
> The SMMU on SM6375 requires 3 power domains to be active. Add an
> appropriate description of that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Acked-by: Will Deacon <will@kernel.org>

Let me know if you'd like me to take this one via the Arm SMMU tree.

Will
