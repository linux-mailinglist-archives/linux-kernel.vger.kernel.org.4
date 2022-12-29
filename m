Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2372F6591C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiL2UpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiL2UoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:44:16 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C439B15731;
        Thu, 29 Dec 2022 12:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1672346588;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8QGE3H6HUAez0GfC25LkzeuSNeAMMalWPYUYYnz225A=;
    b=LDo/68IAE7J0UqYZCI9gfFTGsYjYdFMrvwgqvvJj7jbHoVi5ir+da7X+6v9ptO5bef
    HY8ZVCN7/wuJ2wnR+iZMjWWjerh5ntH7yw6Xp8hmH6FRV9/H+UAmECKkmMEjQ3TVwXhG
    8ocfD7XEJdTwZMJgPJK3rXJwXdczxGK4SYyIoBaEJp8qRJ9haH2Q+ifo2BcglYSMOe3g
    vST2f5xiIkkBEV0KpcilPZFi8aJ0UHdmjlE12amVrQ9KAHzfp5FrKFAP1JkKz9pxmsAo
    ThodkWB/0r2Yxxsj8gthvXABij5vsPsXKG6q+P1QRI9JEnXTe9cIrwBB+5XQlbKNCLq6
    41ig==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWyvDI"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349yBTKh8Xon
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 29 Dec 2022 21:43:08 +0100 (CET)
Date:   Thu, 29 Dec 2022 21:43:01 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add qcom,dp-manual-pullup
 description
Message-ID: <Y6371UEjOK4qZ9hh@gerhold.net>
References: <20221229183410.683584-1-bryan.odonoghue@linaro.org>
 <20221229183410.683584-2-bryan.odonoghue@linaro.org>
 <Y63jBu38L/5cQ75S@gerhold.net>
 <d1cd6d30-2142-765b-c201-4d6662576665@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1cd6d30-2142-765b-c201-4d6662576665@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 07:48:46PM +0000, Bryan O'Donoghue wrote:
> On 29/12/2022 18:57, Stephan Gerhold wrote:
> > AFAIK it is not possible to route VBUS directly to the controller on
> > these SoCs so this property would likely be added to the SoC dtsi
> > (i.e. msm8916.dtsi and msm8939.dtsi) and used by all boards.
> 
> So db410c signals the SoC via GPIO 121 / USB_HS_ID
> 
> https://fccid.io/2AFQA-DB410C/Schematics/Schematics-2816094.pdf
> 
> Which causes ULPI_MISC_A_VBUSVLDEXT to be updated depending on the state
> VBUS.
> 

Correct. If I'm reading the DB410c schematic correctly the USB_HS_ID on
DB410c is actually derived from VBUS on the micro USB port (and not the
ID pin of the port as one would normally expect).

> But not ULPI_MISC_A_VBUSVLDEXTSEL this is the additional register that
> downstream updates when "VBUS is not routed to the controller"

AFAICT ULPI_MISC_A_VBUSVLDEXTSEL is set in qcom_usb_hs_phy_set_mode() if
the USB controller enables device mode? (And disabled again in host mode.)

> 
> I don't have a bit-level description of these registers at the moment so,
> I'm guessing that ULPI_MISC_A_VBUSVLDEXTSEL *is* being updated.
> 
> The reason for that is if I just set ULPI_MISC_A_VBUSVLDEXT then as a device
> a host never sees my SoC via the internal USB hub.
> 
> In other words, for me at any rate I need to see both
> 
> - ULPI_MISC_A_VBUSVLDEXT
> - ULPI_MISC_A_VBUSVLDEXTSEL
> 
> to get the pullup to work and hence the Hub/Host to detect the 8939.
> 

The bit-level description of this register in the public APQ8016E TRM
[1] is not very useful (page 1957):

VBUSVLDEXTSEL = "External VBUS valid select"
VBUSVLDEXT = "External VBUS valid indicator"

But I think VBUSVLDEXTSEL basically means "Use external VBUS state from
VBUSVLDEXT instead of internal detection". And VBUSVLDEXT then contains
the actual VBUS state.

The VBUS state is then probably used somewhere inside the USB controller
or PHY to enable necessary USB protocol things such as enabling this "DP
pull-up" (to be fair I have no idea how the USB protocol really works :)).

[1]: https://developer.qualcomm.com/download/sd410/snapdragon-410e-technical-reference-manual.pdf

> > This means we could just bind this behavior to the existing SoC-specific
> > compatible (i.e. of_device_is_compatible(..., "qcom,usb-hs-phy-msm8916"))
> > and avoid having an extra property.
> > 
> > Thoughts?
> 
> So. I'm OOO at the moment and didn't bring my db410c but TBH to me I don't
> see why we do this whole dance with the pullup on/off with VBUS.
> 
> The right thing to do is to run an experiment statically setting
> 
> - ULPI_MISC_A_VBUSVLDEXT
> - ULPI_MISC_A_VBUSVLDEXTSEL
> 
> On/off at power on/off respectively on
> 
> - db410c
> - My reference where I already know it works
> 
> I'm not really seeing the utility of - partially waggling one of two
> registers with VBUS.
> 
> Why not just push the pullup on with power-on and off with power-off..
> 

I don't feel qualified to comment on this. I'd just follow the
suggestion from the docs here to make VBUSVLDEXT effectively represent
the result of the external VBUS detection (see APQ8016E TRM [1] section
6.4.5.3.3 Software control for SESS_VALID, page 1927).

DB410c and other devices with USB hub are obviously a bit special, but
I think it works correctly for DB410c at the moment because its USB_HS_ID
GPIO basically indicates the incoming VBUS on the micro USB port.

There might be some funky design where it is completely impossible to
detect the incoming VBUS. In that case we have no choice but to force
the detected VBUS state on permanently.

Thanks,
Stephan

[1]: https://developer.qualcomm.com/download/sd410/snapdragon-410e-technical-reference-manual.pdf
