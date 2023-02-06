Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE268C830
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBFVC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBFVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:02:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B198A24CBB;
        Mon,  6 Feb 2023 13:02:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E87F60FD7;
        Mon,  6 Feb 2023 21:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D186C433EF;
        Mon,  6 Feb 2023 21:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675717360;
        bh=EFRCzFpjkHfDn0Vt4RI0YMMBe/BYikr6pWN8qSbSd3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A++NswBZxlfPBvKJSGQcHkAEBFVQFYqQmZ77aEVzm/9tSD4+24bj3UpeiSNUnIZbm
         Ok3XwzktHKG/nZrKwC7N6k+l/JvsWDX37feMpCG5KzEE5M4g3u/gw750pfAowRaEp9
         +BRCPoQtHWKJT196WhOKXHMXLbw9bDabyHefysZiikP+lRgA/Q2WdO79DTxQxxX0nu
         osn48FXPdzjJR0eGrcTOPmjPuX+lmtY6nn8V8Rvk/3qQdva9lSnTIaCg+DrJqswbu/
         2aa3iKVjOGCQlS2zhnTZh+Exj8/nf2NzkGzlThR6P0uR8yQbJapON49DkZpViiXDE2
         XAvRLJ9+45vlg==
Date:   Mon, 6 Feb 2023 13:04:55 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8450: Add IMEM and PIL info
 region
Message-ID: <20230206210455.xgrvtvknkor4nllx@ripper>
References: <1675443891-31709-1-git-send-email-quic_mojha@quicinc.com>
 <1675443891-31709-2-git-send-email-quic_mojha@quicinc.com>
 <cc30f686-dec7-db85-cf0d-c6c685a623ce@linaro.org>
 <d1dc0c9b-eab2-0287-d0a2-ead44ecee5ce@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1dc0c9b-eab2-0287-d0a2-ead44ecee5ce@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 08:06:13PM +0530, Mukesh Ojha wrote:
> 
> 
> On 2/4/2023 3:07 AM, Konrad Dybcio wrote:
> > 
> > 
> > On 3.02.2023 18:04, Mukesh Ojha wrote:
> > > Add a simple-mfd representing IMEM on SM8450 and define the PIL
> > > relocation info region, so that post mortem tools will be able
> > > to locate the loaded remoteprocs.
> > > 
> > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > ---
> >  From XBL:
> > 
> > 0x14680000, 0x0002A000, "IMEM Base"
> > 
> > Is there anything in that wider address range that would interest
> > us? I recall Alex once dug into that when diving into IPA, but
> > I can not recall the conclusion..
> Spec-wise, yes IPA do own these 0x146A8000 - 0x146AA000 .
> But, not sure what they use it for.
> 

The DT should not reflect the organization structure. Let's see if Alex
have any input on this.

Thanks,
Bjorn

> -Mukesh
> > 
> > Konrad
> > >   arch/arm64/boot/dts/qcom/sm8450.dtsi | 15 +++++++++++++++
> > >   1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > index 5704750..474ea1b 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > @@ -3536,6 +3536,21 @@
> > >   			};
> > >   		};
> > > +		sram@146aa000 {
> > > +			compatible = "qcom,sm8450-imem", "syscon", "simple-mfd";
> > > +			reg = <0 0x146aa000 0 0x1000>;
> > > +
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +
> > > +			ranges = <0 0 0x146aa000 0x1000>;
> > > +
> > > +			pil-reloc@94c {
> > > +				compatible = "qcom,pil-reloc-info";
> > > +				reg = <0x94c 0xc8>;
> > > +			};
> > > +		};
> > > +
> > >   		apps_rsc: rsc@17a00000 {
> > >   			label = "apps_rsc";
> > >   			compatible = "qcom,rpmh-rsc";
