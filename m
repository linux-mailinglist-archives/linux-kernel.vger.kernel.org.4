Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB83648903
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiLITfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLITfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:35:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF0ACB04;
        Fri,  9 Dec 2022 11:35:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F581B828D5;
        Fri,  9 Dec 2022 19:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B18EC433F2;
        Fri,  9 Dec 2022 19:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670614533;
        bh=v2LTIozCIJDxxtrquMlOETLKuG0+ICdqDDcLSw5pjlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0dy/WrkYoO7DEJNumDLdv+N0M0NN+t9HA8QsUhTK4lHH9GHXkCyGevjf26e6pwSi
         A9I1ymbF0br0lhBgU9bMOiR5CEfFVB5oftI6thMjldwSykMPGG+s3P9BF3FGScFIvi
         vEWtkiN566SQQi9Yn4IS/kuAZzy+mRAGRA3m97NN645Cghs3f0gj07xkRj1Ji4O6FF
         QUYILJ4st9xbtIxCK0WYJjliMIjhuH85X6wWQd1OjXQEhSwOMSbWmAG2QkZ/oJpeo4
         sz/rOjRxVWfo40P9plTvmWuSi8lFWyDs39Tq427WNAFARztpah/gxT7Eu+ZD8fQsGV
         lMhqCy4P8ENwA==
Date:   Fri, 9 Dec 2022 11:35:31 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ufs: qcom: Add reg-names property for ICE
Message-ID: <Y5OOA2+OuwgZ1i7B@sol.localdomain>
References: <20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com>
 <24fa41d2-87d1-be19-af44-337784b0f0a4@linaro.org>
 <COXDTKRPPU1J.373YHYKBQIN38@otso>
 <a527720e-d4d9-6c90-f991-a5b123c4559b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a527720e-d4d9-6c90-f991-a5b123c4559b@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 04:19:20PM +0100, Krzysztof Kozlowski wrote:
> On 09/12/2022 16:11, Luca Weiss wrote:
> > On Fri Dec 9, 2022 at 4:05 PM CET, Krzysztof Kozlowski wrote:
> >> On 09/12/2022 15:29, Luca Weiss wrote:
> >>> The code in ufs-qcom-ice.c needs the ICE reg to be named "ice". Add this
> >>> in the bindings so the existing dts can validate successfully.
> >>>
> >>> Also sm8450 is using ICE since commit 276ee34a40c1 ("arm64: dts: qcom:
> >>> sm8450: add Inline Crypto Engine registers and clock") so move the
> >>> compatible to the correct if.
> >>>
> >>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>> ---
> >>> (no cover subject)
> >>>
> >>> The only remaining validation issues I see is the following on sc8280xp-crd.dtb
> >>> and sa8540p-ride.dtb:
> >>>
> >>>   Unevaluated properties are not allowed ('required-opps', 'dma-coherent' were unexpected)
> >>>
> >>> Maybe someone who knows something about this can handle this?
> >>>
> >>> And the patch adding qcom,sm6115-ufshc hasn't been applied yet.
> >>> ---
> >>>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 8 +++++++-
> >>>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> >>> index f2d6298d926c..58a2fb2c83c3 100644
> >>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> >>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> >>> @@ -102,7 +102,6 @@ allOf:
> >>>                - qcom,sc8280xp-ufshc
> >>>                - qcom,sm8250-ufshc
> >>>                - qcom,sm8350-ufshc
> >>> -              - qcom,sm8450-ufshc
> >>>      then:
> >>>        properties:
> >>>          clocks:
> >>> @@ -130,6 +129,7 @@ allOf:
> >>>                - qcom,sdm845-ufshc
> >>>                - qcom,sm6350-ufshc
> >>>                - qcom,sm8150-ufshc
> >>> +              - qcom,sm8450-ufshc
> >>>      then:
> >>>        properties:
> >>>          clocks:
> >>> @@ -149,6 +149,12 @@ allOf:
> >>>          reg:
> >>>            minItems: 2
> >>>            maxItems: 2
> >>> +        reg-names:
> >>
> >> There are no reg-names in top-level, so it's surprising to see its
> >> customized here. It seems no one ever documented that usage...
> > 
> > From what I can tell, from driver side all devices not using ICE don't
> > need reg-names, only the "ice" reg is referenced by name in the driver.
> > 
> > I didn't add it top-level because with only one reg I think we're not
> > supposed to use reg-names, right?
> 
> And you still won't need to use. Yet property should be rather described
> in top-level which also will unify the items here (so no different
> 2-item reg-names in variants).
> 
> Just add it to top-level with minItems: 1 and per variant customize:
> 1. maxItems: 1
> 2. minItems: 2 + required
> 
> The "required" is a bit questionable... this was never added by Eric to
> the bindings. Driver support and DTS were added completely skipping
> bindings...
> 

Sorry about that.  At the time
(https://lore.kernel.org/linux-scsi/20200722051143.GU388985@builder.lan/T/#t)
I didn't know there was a Documentation file that should have been updated.

The UFS core assumes that the reg at index 0 is the UFS standard registers.
It is not referenced by name.

ufs-qcom already had an optional reg at index 1.  I needed to add another
optional reg.  So I made the regs at index 1 and later be optional named regs:
dev_ref_clk_ctrl_mem and ice.  That seemed better than hardcoding the indices.

Is it causing a problem that the UFS standard reg at index 0 is being mixed with
named regs in the same list?

- Eric
