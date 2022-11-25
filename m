Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3813763873C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKYKTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKYKTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:19:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C71F218B4;
        Fri, 25 Nov 2022 02:19:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD79F62349;
        Fri, 25 Nov 2022 10:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09032C433D6;
        Fri, 25 Nov 2022 10:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669371579;
        bh=wi1wajl/uQaonaWjdH3x87mG1xWYis5sdgMpB1P6VBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4cr9iHDICE9SsxDGL/9CiVT1UOVGyWQ4OQfzc+Y5O0XoADgHg6A6o5tSPOviuUe/
         RtfoTfYzYOBLh9WP92bGkdT9oFeBV3ADNNPARQE3tRORxYrx8+on/dXoJBeyC6BaBg
         OPuYLTHQ1ZLCpieJH8qgkI49PaeYVplOEGBy2MVuVDSWcXmiu+qy4Arkwn4lxHGwwX
         7THM2IgwOy6+d95VPW5rnD1cQ8ZTE9g8xyuuLFKTX04zis9ZLF+5L/dC63PafAhgZe
         4+/EDF205WIZuHosU4jl7HIvWPKWT1U+jEpVPdfuLH+x9W54L1mcUdMHnEHSDOlfIi
         XQPR8It5XbCrA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oyVnd-0002Wq-KI; Fri, 25 Nov 2022 11:19:14 +0100
Date:   Fri, 25 Nov 2022 11:19:13 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] dt-bindings: phy: qcom,qmp-usb3-dp: Add
 sm6350 compatible
Message-ID: <Y4CWoT52Q8jnm/dF@hovoldconsulting.com>
References: <20221125092749.46073-1-luca.weiss@fairphone.com>
 <Y4CP9fwhDXsLu57Q@hovoldconsulting.com>
 <COLABNHBQ1DG.1PB8SDY3FW1YY@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <COLABNHBQ1DG.1PB8SDY3FW1YY@otso>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 10:55:31AM +0100, Luca Weiss wrote:
> Hi Johan,
> 
> On Fri Nov 25, 2022 at 10:50 AM CET, Johan Hovold wrote:
> > On Fri, Nov 25, 2022 at 10:27:47AM +0100, Luca Weiss wrote:
> > > Add the compatible describing the combo phy found on SM6350.
> > > 
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > > @Johan Hovold, I've sent this v2 as RFC because there are several things
> > > where I have questions on how it should be done.
> > > 
> > > In this patch, you can see there's cfg_ahb (&xo_board) and power-domains
> > > is not set. In msm-4.19 &gcc_usb30_prim_gdsc is only used in the
> > > ssusb@a600000 node, or should I also add it to qmpphy?
> >
> > Yeah, you may need to add a platform specific section of the clocks,
> > which appear to be different, even if I'm not sure they are currently
> > described correctly (xo_board as cfg_ahb and "QLINK" as ref). How are
> > they named in the vendor's dts?
> 
> This is the msm-4.19 dts:
> https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/lagoon-usb.dtsi#354

		clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
			<&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>,
			<&rpmhcc RPMH_QLINK_CLK>,
			<&gcc GCC_USB3_PRIM_CLKREF_CLK>,
			<&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
		clock-names = "aux_clk", "pipe_clk", "ref_clk_src",
				"ref_clk", "com_aux_clk";

So it looks like you don't need update the binding for the clocks as the
above matches sc8280xp:

	aux
	ref
	com_aux
	usb3_pipe

Parent clocks (ref_clk_src) should not be included in the binding, but
rather be handled by the clock driver. For example, see:

	https://lore.kernel.org/all/20221121085058.31213-4-johan+linaro@kernel.org/
	https://lore.kernel.org/all/20221115152956.21677-1-quic_shazhuss@quicinc.com/

> > >  .../bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml          | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > index 6f31693d9868..3e39e3e0504d 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> > > @@ -17,16 +17,18 @@ properties:
> > >    compatible:
> > >      enum:
> > >        - qcom,sc8280xp-qmp-usb43dp-phy
> > > +      - qcom,sm6350-qmp-usb3-dp-phy
> > >  
> > >    reg:
> > >      maxItems: 1
> > >  
> > >    clocks:
> > > -    maxItems: 4
> > > +    maxItems: 5
> > >  
> > >    clock-names:
> > >      items:
> > >        - const: aux
> > > +      - const: cfg_ahb
> > >        - const: ref
> > >        - const: com_aux
> > >        - const: usb3_pipe
> >
> > So this would need to be moved to an allOf: construct at the end with
> > one section each for sc8280xp and sm6350.
> 
> Ack.

So no need to change this it seems.

Johan
