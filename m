Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081F8625F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiKKQXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiKKQX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:23:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA7B2AC5;
        Fri, 11 Nov 2022 08:23:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACE5162046;
        Fri, 11 Nov 2022 16:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF7FC433D6;
        Fri, 11 Nov 2022 16:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668183805;
        bh=/tPA7ws0rLIZu0fygMvLYm3y96ea/yW/c/ek6jeQqb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsFyIBzSZF1YnRUxRIJTc8+CwEyDSgbWFO8jpkHQvrFY8xJnJWQ/rvtEnsYE18jKl
         R1IWfFyyyJ/bo5UEENCKFMpbUQafQqPvvU0uyjRBX3LCXd7TkXnAlTWNWjTupwvFjQ
         DCMLeW0yIeQaVycvKi+uuUsE4uYJNgBrMXu/QN1E1YVvtmB1H3HE8XQu43ely22Ozt
         cB1HtuHK0cW0FKLbsJNO4cgVJKR8Sb+LFrDKC/XPFgzUkow90lI3/fky5Ts2P+aeJ7
         jcYD5mn2KsE0661bYGwEPIEVvGE4mzw/RDZUObzNu8YnxuLxEljw18ezSEmK2RCFbb
         S2ytULmDZk3sw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1otWnw-0003he-Jq; Fri, 11 Nov 2022 17:22:57 +0100
Date:   Fri, 11 Nov 2022 17:22:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] arm64: dts: qcom: sc8280xp-crd: enable NVMe SSD
Message-ID: <Y2524KFw1izDx3pG@hovoldconsulting.com>
References: <20221110103558.12690-1-johan+linaro@kernel.org>
 <20221110103558.12690-5-johan+linaro@kernel.org>
 <d3aead5b-413a-e929-1b33-7956fa117d4d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3aead5b-413a-e929-1b33-7956fa117d4d@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 12:06:45PM +0100, Konrad Dybcio wrote:
> On 10/11/2022 11:35, Johan Hovold wrote:
> > Enable the NVMe SSD connected to PCIe2.
> >
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 63 +++++++++++++++++++++++
> >   1 file changed, 63 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > +	pcie2a_default: pcie2a-default-state {
> 
> Aren't they going to be identical for all boards anyway? Maybe there
> could be some commonization..

We had that discussion and decided that keeping the pinconfig in the dts
is the right thing to do.

And even if the clkreq pin will be the same for all boards that's not
necessarily the case for the other two.

> > +		clkreq-n-pins {
> > +			pins = "gpio142";
> > +			function = "pcie2a_clkreq";
> > +			drive-strength = <2>;
> > +			bias-pull-up;
> > +		};
> > +
> > +		perst-n-pins {
> > +			pins = "gpio143";
> > +			function = "gpio";
> > +			drive-strength = <2>;
> > +			bias-pull-down;
> > +		};
> > +
> > +		wake-n-pins {
> > +		       pins = "gpio145";
> > +		       function = "gpio";
> > +		       drive-strength = <2>;
> > +		       bias-pull-up;
> > +	       };
> > +	};
> > +
> >   	qup0_i2c4_default: qup0-i2c4-default-state {
> >   		pins = "gpio171", "gpio172";
> >   		function = "qup4";

Johan
