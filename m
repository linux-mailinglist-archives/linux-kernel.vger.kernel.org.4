Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBB07133A5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjE0JWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjE0JWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:22:37 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C855CE56;
        Sat, 27 May 2023 02:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685179334; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RmElqzQP3UoSHLQ5aLggZo4XqTAM5gRHTtRk+TzHI9xLJGMo8+L780UKXzzt/kssO5
    XYUvohdj9HnOeromgMoyFyrla1ix1SPuALC7uanrbbrm7YT/skn7HezHIAD0rhvZ/P8Q
    VleS4V6ygBYmlJzamDppLsGd9Fpt17/2LCKmHcJaRXf41fzV7StsZlsOx248cyTHt+wy
    9WogF9yENQ+RsaK+PQ8VhK61Df+KE2OCQC7ko0rINPAEMXGRpK3RQ9tjzyCypKnKHZSO
    PyVa6FY+IJMchIhMRTk+sAjQSXk2cHZKrnxLtEwXZKFr5Oo95+nipU8/PRa3IW2Z9i46
    nV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685179334;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0mv/6sZ5x60Zkllf63JZEA+fDY4btmNRQkEJ+4wCjlc=;
    b=sQs9bEmcWRYfHv32mjcgWnkkLC/ZJWnsij+N8KdqmrJcmKiaLvZd9RVy14hYrJunLS
    k5uADU3ebYwTclrNph2TwTES0ri4GimEaVUg0vdgmGBxi2Rv2isXtAJDrTwNG0zONx4w
    7aKhEUhb3R2KjaTDLui5YRQNDGfQDt0XeFRLcqqcOeNYa/SVoPxc/yQE5BjhJkGXGt9+
    BwbaScgsDnn4VmyR+EOwXaRp52XjGmLZ6m+S3lher1LJk6Fqx+EPwbu0XK3kn457AmW1
    O8ENCVp0Hl9pQ1KNRji0M9Jbinipe8Zf94vgPvjBTF9J/IsP+fFR2rmTZKSgM6y93mvQ
    BFxg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685179334;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0mv/6sZ5x60Zkllf63JZEA+fDY4btmNRQkEJ+4wCjlc=;
    b=gHbO5fjsJ9CicUSKRUE5vHq7cZ4TYXXM27sDezE/I2AXI3vD9LrCaIb+J7p44WznDz
    ezN9lJnLlr8LZHz5/Out4yUD3M0OrqobBk2fdwk74kJa0RCpMCe0PyyYwlPNeEo2FbBx
    4HxkO0ttgoRi2FO0gFn6pSgM2WtNb+sQTeXl0d5KSpki0m0ICg4y1001RwDZ5YHg6WWT
    97uELw0ljlTqE58qQLu0bVx9esTwRfDP/Aqtmjd1bfjCPiPKckqMWcJy36B8rBmn9P7u
    MTPRsz2bM8c7czFtfLg5BbsaM9KCBJe5XUjfyG8jB6HAo9OeE9GnvZjRz7HP+jcGxRgg
    mDAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685179334;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0mv/6sZ5x60Zkllf63JZEA+fDY4btmNRQkEJ+4wCjlc=;
    b=EfJaKL3e11ZSVK5PIeRHv76ZOlm6CJDLoRgkf9ZVs3RSJhtOdh2mV+6qZGTqIivazn
    2aip1IBpPjqR+AS4E7Dg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8p+F1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4R9MEccW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 27 May 2023 11:22:14 +0200 (CEST)
Date:   Sat, 27 May 2023 11:22:07 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 7/8] arm64: dts: qcom: msm8916: Define regulator
 constraints next to usage
Message-ID: <ZHHLv-kW56GRJ1_0@gerhold.net>
References: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
 <20230510-msm8916-regulators-v1-7-54d4960a05fc@gerhold.net>
 <9f474fe8-523c-3668-540a-a8fc04ed64a6@linaro.org>
 <ZHBV-mBPhoqy8yvs@gerhold.net>
 <02543b3b-a94d-fd3a-7b28-3e55f4414137@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02543b3b-a94d-fd3a-7b28-3e55f4414137@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 11:11:44PM +0200, Konrad Dybcio wrote:
> On 26.05.2023 08:47, Stephan Gerhold wrote:
> > On Fri, May 26, 2023 at 01:35:06AM +0200, Konrad Dybcio wrote:
> >> On 17.05.2023 20:48, Stephan Gerhold wrote:
> >>> Right now each MSM8916 device has a huge block of regulator constraints
> >>> with allowed voltages for each regulator. For lack of better
> >>> documentation these voltages are often copied as-is from the vendor
> >>> device tree, without much extra thought.
> >>>
> >>> Unfortunately, the voltages in the vendor device trees are often
> >>> misleading or even wrong, e.g. because:
> >>>
> >>>  - There is a large voltage range allowed and the actual voltage is
> >>>    only set somewhere hidden in some messy vendor driver. This is often
> >>>    the case for pm8916_{l14,l15,l16} because they have a broad range of
> >>>    1.8-3.3V by default.
> >>>
> >>>  - The voltage is actually wrong but thanks to the voltage constraints
> >>>    in the RPM firmware it still ends up applying the correct voltage.
> >>>
> >>> To have proper regulator constraints it is important to review them in
> >>> context of the usage. The current setup in the MSM8916 device trees
> >>> makes this quite hard because each device duplicates the standard
> >>> voltages for components of the SoC and mixes those with minor
> >>> device-specific additions and dummy voltages for completely unused
> >>> regulators.
> >>>
> >>> The actual usage of the regulators for the SoC components is in
> >>> msm8916-pm8916.dtsi, so it can and should also define the related
> >>> voltage constraints. These are not board-specific but defined in the
> >>> APQ8016E/PM8916 Device Specification. The board DT can then focus on
> >>> describing the actual board-specific regulators, which makes it much
> >>> easier to review and spot potential mistakes there.
> >>>
> >>> Note that this commit does not make any functional change. All used
> >>> regulators still have the same regulator constraints as before. Unused
> >>> regulators do not have regulator constraints anymore because most of
> >>> these were too broad or even entirely wrong. They should be added back
> >>> with proper voltage constraints when there is an actual usage.
> >>>
> >>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> >>> ---
> >> I'm a bit torn between saying "this is very nice already" and "we should
> >> probably override each regulator individually" like so:
> >>
> >> &pm8916_l17 {
> >> 	[...]
> >> }
> >>
> >> to minimize mistakes..
> >>
> >> Not sure what to make of it, I see Bjorn already applied this, so I guess
> >> I'm just leaving some potential ideas for the future here.
> > 
> > Sorry, could you elaborate a bit on what changes you would make exactly?
> Assigning the voltage ranges through direct reference to each individual
> regulator, instead of overwriting them through referencing the
> pm8916_rpm_regulators label and (essentially) redefining them.
> > 
> > The way it works in this patch is that regulators that are used by the
> > SoC are defined in msm8916-pm8916.dtsi. All other (board-specific)
> > regulators must be defined together with proper voltages in the board DT.
> > 
> > What kind of mistake are you thinking of?
> Fat fingers, mostly
> 
> So suppose your device needs a different voltage on L18, so you do
> 
> &pm8916_rpm_regulators {
> 	l19 { //fat fingers burn devices
> 		regulator-min-microvolt = <12341234>;
> 		regulator-max-microvolt = <43143144>;
> 	};
> };
> 
> DTC will happily eat that
> 
> since we use labels, one would have to fatfinger twice, like so:
> &pm8916_rpm_regulators {
> 	pm8916_l19: l19 { //this was still supposed to be l18
> 
> as these two combinations will trigger a build error
> 
> &pm8916_rpm_regulators {
> 	pm8916_l19: l18 { //duplicate label vs actual l19
> 
> ---
> 
> &pm8916_rpm_regulators {
> 	pm8916_l18: l19 { //duplicate label vs actual l18
> 

Yeah I was also a bit torn between (pre-)defining labels for all
regulators vs the approach I chose in this patch. However, thinking
about it some more I realized that having the pre-defined labels
makes it far too easy to make another fairly hidden mistake:

Let's assume we would define labels for all regulators in
msm8916-pm8916.dtsi. That is, even for board-specific regulators
we add:

	/* ... */
	pm8916_l10: l10 {};
	/* ... */
	pm8916_l14: l14 {};
	pm8916:l15: l15 {};
	pm8916_l16: l16 {};
	/* ... */

Now someone new to device porting thinks "c'mon, gettin' camera workin'
can't be *that* hard". They look at downstream and quickly define a
device tree node with the necessary regulators:

	camera@1a {
		compatible = "sony,imx214";
		reg = <0x1a>;
		vddo-supply = <&pm8916_l10>;
		vdda-supply = <&pm8916_l16>;
		vddd-supply = <&pm8916_l2>;
		/* ... */
	};

They build this successfully and try to run it. Perhaps it even works
somewhat but it's quite dangerous: They did not define any voltage
constraints for l10 and l16! In this case, the regulator core does not
allow *changing* the regulator voltage, but it still allows
*enabling*/disabling the regulator with "who knows what RPM uses as
default voltage". They might even submit it upstream and reviewers
assume the voltages are already defined somewhere.

This cannot happen with my patch. The labels for the board-specific
regulators are not defined anywhere, so they would immediately get a
build error. They would probably look for examples how to define the
additional regulators. For pm8916_l16 they find examples like:

	&pm8916_rpm_regulators {
		pm8916_l16: l16 {
			regulator-min-microvolt = <1800000>;
			regulator-max-microvolt = <1800000>;
		};
	};

They copy this into their own board DT but (hopefully) wonder "Is this
actually the correct voltage for my case?". They look closer at the
downstream camera setup and see that vdda/l16 actually needs 2.7V.

For each additional regulator they need to actively add something and
think about the changes before it will build successfully.

I believe that in this case being unaware of additional required changes
is far more likely than making "fat finger" mistakes. Regulators is
simply something one needs to be careful about. Even if we add
fail-safes for regulator name typos, you could just as easily have typos
in the specified voltages. I always look twice before testing regulator
changes and would hope this applies to most people. :)

Thanks,
Stephan
