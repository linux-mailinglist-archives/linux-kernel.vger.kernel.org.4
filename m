Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40ED6440F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 11:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiLFKHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 05:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiLFKG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 05:06:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412F230F70;
        Tue,  6 Dec 2022 01:57:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E28D2B818E1;
        Tue,  6 Dec 2022 09:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B61C433C1;
        Tue,  6 Dec 2022 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670320609;
        bh=H4M/+p7AkJ/i6ORamRR1po4sDDc3p/wTeEVuAunv+9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ja6ECJdGE0y7qkbILuEeOYDwyaeyhKoITYR4QfZwUlHu2ON/5zDL8k0QgGa06UiXK
         IjIFFgene1o3lkGrmu+ONTuSNB5V/FNRP3ujN2RI8AVDM91aVSnoFP0rhnIBZG3G3G
         SOlOTjp/G5FwIShX9WSSjZikSAAHgL9VOuQLzb+VU3HOFWJlkLSkZ80qeI4p4c+G+w
         zajPUQTlekWnMRwZ35kLKm+DMKfl/7ElvavxqktpdjzZ7ohuX199wlmYHmE9o7R63h
         HMVZYjHACzD9nxLr8NAMI/0vN5SSVV303THnGrbDcI4RIYnxfoCI7cSB+1dbUJFeYN
         HPFWN/VzHQKPg==
Date:   Tue, 6 Dec 2022 09:56:43 +0000
From:   Will Deacon <will@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, patches@linaro.org,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: arm-smmu: Allow 3 power domains on
 SM6375 MMU500
Message-ID: <20221206095642.GA317@willie-the-truck>
References: <20221115152727.9736-1-konrad.dybcio@linaro.org>
 <20221115152727.9736-2-konrad.dybcio@linaro.org>
 <20221118133855.GB4046@willie-the-truck>
 <20221205205640.kawreo3yyeh2meci@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205205640.kawreo3yyeh2meci@builder.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Mon, Dec 05, 2022 at 02:56:40PM -0600, Bjorn Andersson wrote:
> On Fri, Nov 18, 2022 at 01:38:56PM +0000, Will Deacon wrote:
> > On Tue, Nov 15, 2022 at 04:27:19PM +0100, Konrad Dybcio wrote:
> > > The SMMU on SM6375 requires 3 power domains to be active. Add an
> > > appropriate description of that.
> > > 
> > > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > ---
> > >  .../devicetree/bindings/iommu/arm,smmu.yaml   | 23 ++++++++++++++++++-
> > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > Let me know if you'd like me to take this one via the Arm SMMU tree.
> > 
> 
> Yes, please pick this through the SMMU tree.

I've already sent my pull request for 6.2, so this will have to wait until
6.3 now (unless somebody else takes it in the meantime).

Will
