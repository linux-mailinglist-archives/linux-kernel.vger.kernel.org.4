Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544FF64286C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiLEM1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiLEM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:27:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27216387;
        Mon,  5 Dec 2022 04:27:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FDD06106C;
        Mon,  5 Dec 2022 12:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECA0C433C1;
        Mon,  5 Dec 2022 12:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670243249;
        bh=L1YNfHSIuiHZcP1HrrM4bGQckMyCRA5hADfzIoelQ1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4MaHDrLLhmwj4rM/09fVzStptvEpYtFiMqZ/aP3/kT2Y2cydTBinXwR2w6/nu49H
         zMMPwDyoORkUuzkBaQqEVTD15DN4VmVQ+R/DBtYrzNUD2IeJcwNiLzJM9lTgkgShnM
         NuaBK6PPHJBBq6e4M7K0/9bXQufQOM91FuIK/Qcn2X1kzfiAJ4+0cRY+icosb1wOLQ
         pQ5Pp+d7CHCc4LRiGROqJXGjXF7kFdZPtNb/9WetY21wJk2n4CuwkT2xf9sSsAO/ho
         Z7xX/JTdGbjjV0R4G3fEjyRuMaOSgGA63zCUH1tE4f6vTExKzVzjgrRlAOqCTMWFHW
         C3TvNZ2pFv3Zg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p2AZK-0000Tp-88; Mon, 05 Dec 2022 13:27:34 +0100
Date:   Mon, 5 Dec 2022 13:27:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ufs: qcom: allow 'dma-coherent' property
Message-ID: <Y43jtpHqlyiIEZ0S@hovoldconsulting.com>
References: <20221205100837.29212-1-johan+linaro@kernel.org>
 <20221205100837.29212-2-johan+linaro@kernel.org>
 <20221205115906.GA20192@thinkpad>
 <Y43e9KRDsTCS5VI4@hovoldconsulting.com>
 <20221205122018.GC20192@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205122018.GC20192@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 05:50:18PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Dec 05, 2022 at 01:07:16PM +0100, Johan Hovold wrote:
> > On Mon, Dec 05, 2022 at 05:29:06PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Dec 05, 2022 at 11:08:36AM +0100, Johan Hovold wrote:
> > > > UFS controllers may be cache coherent and must be marked as such in the
> > > > devicetree to avoid data corruption.
> > > > 
> > > > This is specifically needed on recent Qualcomm platforms like SC8280XP.
> > > > 
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > > > index f2d6298d926c..1f1d286749c0 100644
> > > > --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > > > +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > > > @@ -44,6 +44,8 @@ properties:
> > > >      minItems: 8
> > > >      maxItems: 11
> > > >  
> > > > +  dma-coherent: true
> > > > +
> > > 
> > > This property is not applicable to all SoCs. So setting true here will make it
> > > valid for all.
> > 
> > Yes, it would be a valid, but it will only be added to the DTs of SoCs
> > that actually require it. No need to re-encode the dtsi in the binding.
> > 
> 
> But if you make a property valid in the binding then it implies that anyone
> could add it to DTS which is wrong. You should make this property valid for
> SoCs that actually support it.

No, it's not wrong.

Note that the binding only requires 'compatible' and 'regs', all other
properties are optional, and you could, for example, add a
'reset' property to a node for a device which does not have a reset
without the DT validation failing.

It's the devicetree which is supposed to describe hardware, you don't
have to encode it also in the binding.

Johan
