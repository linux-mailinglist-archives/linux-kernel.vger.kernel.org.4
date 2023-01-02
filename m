Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C792165B485
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjABP6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:58:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C679712E;
        Mon,  2 Jan 2023 07:58:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 558D961015;
        Mon,  2 Jan 2023 15:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C32C433EF;
        Mon,  2 Jan 2023 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672675096;
        bh=Tn8CE4Z5S/X7P04a19+R8hhIyimSiUh/dShOcnmOjxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hy5Vf2lgSzExLkHQsDeA5ukKGa+WhU23EmNxrouqIxoNrsPTafX+41cdtGYRSTEHN
         ke6E9IIABzM1bCMXyIJEV1kN9jJzSzkq36Rj8H2lj14FkkrZahA6hmnEsiunTPfq6v
         7Cp+MizPsaR7w+khhXSCHW8D9wq06B2qKR3bNdAIo78Yo4aR+Xnz+m0BY5IpFnFprH
         36q4XrSzy8upJlTlOKlejhhdGzZiGrXP8MU9ZlStlouKHWtQgJ++Dh+XuqLjptBEnD
         GyDyU9y+JNF1ieHDZwiVHXxlsA8EzpQx2rwtgnCJt70smP8FT8D7KNLJMiGFxj+O3+
         xOflAH4KzbDxw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCNCn-0008Pz-Fj; Mon, 02 Jan 2023 16:58:30 +0100
Date:   Mon, 2 Jan 2023 16:58:29 +0100
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
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sc8280xp-x13s: disable soundcard
Message-ID: <Y7L/JbUICN0OQhaK@hovoldconsulting.com>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-2-johan+linaro@kernel.org>
 <fc42801a-55d9-90b9-f7f0-48657ec7a373@linaro.org>
 <Y7LzJ+RRzDNRf3jR@hovoldconsulting.com>
 <81e3994e-49d9-ea5b-b055-cbcc737a6e37@linaro.org>
 <Y7L3OTs/u8FsH8o2@hovoldconsulting.com>
 <8bd6487a-3ae7-f7c1-e478-1effd68700d3@linaro.org>
 <Y7L6t3p57uTCECRy@hovoldconsulting.com>
 <5de95075-ca62-3cae-ce07-d263ea3aa264@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5de95075-ca62-3cae-ce07-d263ea3aa264@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 04:46:40PM +0100, Krzysztof Kozlowski wrote:
> On 02/01/2023 16:39, Johan Hovold wrote:
> >>>>>>>  	wcd_tx: wcd9380-tx@0,3 {
> >>>>>>>  		compatible = "sdw20217010d00";
> >>>>>>> @@ -781,6 +787,8 @@ &vamacro {
> >>>>>>>  	pinctrl-names = "default";
> >>>>>>>  	vdd-micb-supply = <&vreg_s10b>;
> >>>>>>>  	qcom,dmic-sample-rate = <600000>;
> >>>>>>> +
> >>>>>>> +	status = "disabled";
> >>>>>>
> >>>>>> That's a double disable.
> >>>>>
> >>>>> Yes, that's on purpose. We're temporarily disabling these nodes instead
> >>>>> of reverting the series which should not have been merged.
> >>>>
> >>>> I don't get why disabling something twice is anyhow related to
> >>>> "temporarily disable". One disable is enough for temporary or permanent
> >>>> disables.
> >>>
> >>> It clearly shows that this was done on purpose and indicates which
> >>> properties need to be changed to "okay" once we have actual support.
> >>
> >> No, it shows nothing clearly as from time to time we got duplicated
> >> properties and it's a simply mistake. The double disable without any
> >> comment looks like mistake, not intentional code.
> > 
> > It's not a mistake. It's intentional. And I don't want to spend hours on
> > this because of someone else's cock-up.
> 
> To you it looks intentional, but for the reader of DTS which has
> disabled node in DTSI and in DTS - so in two places - it looks like a
> pure bug. Just because you know the reason behind the change does not
> make the code readable.

Calling a (temporary) redundant property a 'pure bug' seems like a bit
of stretch, and it has nothing to do with readability.

> >>>>>
> >>>>> Once we have driver support, these properties will be updated again.
> >>>>
> >>>> Linux kernel is not the only consumer of DTS, thus having or not having
> >>>> the support in the kernel is not reason to disable pieces of it.
> >>>> Assuming the DTS is correct, of course, because maybe that's the problem?
> >>>
> >>> Okay, let's revert these sound dts changes then until we have support.
> >>> We have no idea if the dts changes are correct as sound still depends
> >>> on out-of-tree hacks.
> >>>
> >>> People are using -next for development and I don't want to see them
> >>> toast their speakers because we failed get the dependencies merged
> >>> before merging the dts changes which is how we normally do this.
> >>
> >> If the error is in DTS, yeah, revert or disable is a way. But if the
> >> issue is in the incomplete or broken Linux drivers, then these should be
> >> changed, e.g. intentionally fail probing, skip new devices, drop new
> >> compatible etc.
> > 
> > And how long does it take for that to propagate and isn't the response
> > just going go to be "well then fix the driver".
> > 
> > I think you're just being unreasonable here.
> 
> I did not propose to fix the driver. I proposed to fail the driver's
> probe or remove the compatible from it.
> 
> Such change propagate the same speed as DTS change.

But the DTS changes are in Bjorn branch and Bjorn and I discussed it and
decided to disable them temporarily instead of reverting.

Now you're asking me to figure out all the dependent driver and patch
them individually. And this may not reach next before the DTS changes
do.

> > If Bjorn could rebase his tree, he could simply drop these for now as
> > sound support was clearly not ready. Since that isn't the case we need
> > to at least try to be constructive and figure out a reasonable
> > alternative. While "Linux isn't the only consumer" is a true statement,
> > it really is not relevant just because there are some dts changes in
> > Bjorn's tree which should not be there.
> 
> The SC8280XP audio DTS looks in general correct, except some style
> issues, redundant properties and never tested against DT bindings.
> Therefore it looks as accurate and more-or-less correct representation
> of the hardware, unless you have some more details on this.

Only that the drivers fail to probe in multiple ways, some which may
require updating the bindings to address. There's also an indication
that some further driver support is needed for proper speaker
protection. That really should be in place before we enable this.

Johan
