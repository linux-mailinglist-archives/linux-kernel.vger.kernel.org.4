Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384AC65B3FC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbjABPP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjABPPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:15:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558978FE2;
        Mon,  2 Jan 2023 07:15:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC490B80D88;
        Mon,  2 Jan 2023 15:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D4CC433EF;
        Mon,  2 Jan 2023 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672672526;
        bh=oxCW599LST6T4o2njIXp4aRopvq/E+iXD7F8cgvQeWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbO+Hks1ANgEtHQKyCHJrU6GMFz+1Ks6EG1Fc9bq/V/LqnuVjXnVTu2CVUZH3bi2R
         jOs/xAKqrY3O2JANgHCKIPl7sKFY2Pnq0NEO7+RPnVjcREslwS9GLsma8THUHkkdFc
         V0Xu8vlkBItt1cDpnVoJh3KdYVh4KlFwUcnP1X3pnPFHkUfRzoAwNxEZHHdJwK9+Sa
         FwalYD4RrwI7MWBcZ1SnH70Ir4V4Xc6lRoG/HOTRAZMSGpXFYHE6GmIEANSAfd4Wgv
         Gfj9dRKDZEnIYJdjde57S9ZEUUBL4rAVdZwBKpcF92RTxm5jqgposrLdJLMWyJ2r8k
         E5UOXjTrUdeqw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCMXO-0007tM-UP; Mon, 02 Jan 2023 16:15:43 +0100
Date:   Mon, 2 Jan 2023 16:15:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sc8280xp: disable sound nodes
Message-ID: <Y7L1HkPRwzuliUjR@hovoldconsulting.com>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-3-johan+linaro@kernel.org>
 <82ac16e1-6c8a-b050-d627-535b4562a422@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ac16e1-6c8a-b050-d627-535b4562a422@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 01:29:38PM +0100, Krzysztof Kozlowski wrote:
> On 02/01/2023 11:50, Johan Hovold wrote:
> > The sound nodes in the SoC dtsi should be disabled by default.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index ed1e2bee86ee..c1ce2d7b3675 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -1733,6 +1733,8 @@ rxmacro: rxmacro@3200000 {
> >  
> >  			pinctrl-names = "default";
> >  			pinctrl-0 = <&rx_swr_default>;
> > +
> > +			status = "disabled";
> 
> There is no reason this should be disabled by default. No external (per
> board) configuration is needed and by default SoC components should be
> enabled if they do not need anything from the board.

This node is one of the nodes for which driver support is not yet in
place so that's one reason for at least disabling it temporarily.

Since all other pinconfig lives in the board dts, if we decide to move
also the sound pinconfig then then that may be a second.

Johan
