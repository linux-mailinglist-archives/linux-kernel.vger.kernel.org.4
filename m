Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B573568D53B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjBGLPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBGLPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:15:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8F24EFA;
        Tue,  7 Feb 2023 03:15:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE11D6131F;
        Tue,  7 Feb 2023 11:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29046C433EF;
        Tue,  7 Feb 2023 11:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675768535;
        bh=zpfS5ZRX3k0O75MjZxoCoF2L/bPP8+dq0m4PA9fXSrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKSvnUbIyCdY2ldGpZSRbX0QkgAGzNyqjFavHEI0C0VEgDkkIxxnL11fgtnG7VdPe
         5XQKE7InKJufIqUL8EKXz71OSNeTHZl7DsaM2gO42giI39xpRzRmk3sPOUgoBjr5MG
         EuhkLhqsxd+UJ1v7cYwCXaVNfsdevoi9CtNq2LhXphNwJ+ncyEkJTdjdM4c2Egf2fy
         2HVhMdDYWAhDUndFAS9F1JSYA+bcaLA8obGT347Zy+Pgmryd4kMORV3jKqASZhRsss
         4/TNwVln/HVT+MwwdQ/3Awk3oG+o9bdmCpNXtSuWl8Up7CL4VtEhkzeyXpI7xuSu5K
         FfMsqksuMCGSQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pPLxH-0001eV-LF; Tue, 07 Feb 2023 12:16:08 +0100
Date:   Tue, 7 Feb 2023 12:16:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 7/8] arm64: dts: qcom: sm8550: Add USB PHYs and
 controller nodes
Message-ID: <Y+Iy9/82q9eWMMbn@hovoldconsulting.com>
References: <20230202132511.3983095-1-abel.vesa@linaro.org>
 <20230202132511.3983095-8-abel.vesa@linaro.org>
 <Y9zoD/eVG8zjMYNx@hovoldconsulting.com>
 <Y+Iv/s7V5PYkRI8D@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Iv/s7V5PYkRI8D@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:03:26PM +0200, Abel Vesa wrote:
> On 23-02-03 11:55:11, Johan Hovold wrote:
> > On Thu, Feb 02, 2023 at 03:25:10PM +0200, Abel Vesa wrote:
> > > Add USB host controller and PHY nodes.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > > 
> > > Changes since v3:
> > >  * none
> > > 
> > > Changes since v2:
> > >  * none
> > > 
> > > NOTE: This patch has been already merged. It is here only to provide
> > > context for the rest of the patchset. There is a change with respect to
> > > the clocks, but that will be sent as a separate/individual fix patch.
> > 
> > I believe it was because of the 'phy' and 'common' resets, which have
> > been switched below.
> 
> No, the resets haven't been switched, at least not compared to the
> already merged version.

The resets were wrong in the merged version just as they are below. I've
already sent a fix here:

	https://lore.kernel.org/lkml/20230123101607.2413-1-johan+linaro@kernel.org/
 
> > > +		usb_dp_qmpphy: phy@88e8000 {
> > > +			compatible = "qcom,sm8550-qmp-usb3-dp-phy";
> > > +			reg = <0x0 0x088e8000 0x0 0x3000>;
> > > +
> > > +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> > > +				 <&rpmhcc RPMH_CXO_CLK>,
> > > +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> > > +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> > > +			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
> > > +
> > > +			power-domains = <&gcc USB3_PHY_GDSC>;
> > > +
> > > +			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> > > +				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
> > > +			reset-names = "phy", "common";

Johan
