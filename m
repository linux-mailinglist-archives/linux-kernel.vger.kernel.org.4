Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72221669363
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbjAMJzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240834AbjAMJy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:54:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D735BBE;
        Fri, 13 Jan 2023 01:50:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9932061136;
        Fri, 13 Jan 2023 09:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4509C433D2;
        Fri, 13 Jan 2023 09:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673603453;
        bh=NYX/34PPDvETDVkL0+RT3Jnvul+RxVMdywKfKz+QCKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MclVWFbXvTmpZ0EstEsimrOPF2g0T52j4hpbGpu9LICWLKXHpXv/BokGXhfvZB2rs
         uaIfD3+YecOr2Sk/3ioTBf6xvVEdfAb2kpnEQ8lFpUcVlwaxyHA4wJmwDJ//sM0Yxm
         +xyKWo/albG2N9OOux+Y+w8yGELShyEhFIXP+nH9e0QtwTOspqs5HFC5bXZpAMMcw3
         k5+ZUZOstIsBj7mKTn71fSE17R0TfS0yPY38Y+7uLWvZ4ydqp3IiP5RAlfZ15A8nzF
         3yC8IOS7iKsauiXZKRDTXWxrwQUSjZ8tAfLG50Lcv+f2pqLq0OYNd5axoU140OTSXY
         aIesdkWCsTBuA==
Date:   Fri, 13 Jan 2023 09:50:47 +0000
From:   Will Deacon <will@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
Message-ID: <20230113095046.GB12235@willie-the-truck>
References: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
 <e2cc612a-7b1f-6c18-7d5b-1403fac77a99@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2cc612a-7b1f-6c18-7d5b-1403fac77a99@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 02:53:20PM +0100, Krzysztof Kozlowski wrote:
> On 22/12/2022 10:23, Krzysztof Kozlowski wrote:
> > Disallow clocks for variants other than:
> > 1. SMMUs with platform-specific compatibles which list explicit clocks
> >    and clock-names,
> > 2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
> >    variable clocks on different implementations.
> > 
> > This requires such variants with platform-specific compatible, to
> > explicitly list the clocks or omit them, making the binding more
> > constraint.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> 
> Will, Robin, Joerg,
> 
> Anyone willing to pick up this patch?

Sure, I'll do an SMMU bindings pass shortly for 6.3

Will
