Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF319659665
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiL3Inz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiL3Inw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:43:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B4918E36;
        Fri, 30 Dec 2022 00:43:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5FBB61A0D;
        Fri, 30 Dec 2022 08:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D86AC433D2;
        Fri, 30 Dec 2022 08:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672389830;
        bh=oxPX55GSzrEg4Xut6zu5HPxj2Ni8vtV2mF93cd30lns=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=roDK69SfgitggRUmVYhS1zUe2p+s9s47eId7r7uDqmn66uyeyQS7KtAAgRa1c8/OO
         Wl26PgoSJLBGjFFLhssXINx0Wz7ZM5ueJIvqltcGObsUGXUCLeDATQZn7lxDWsOdhu
         qhtYL+x7ynbWQj5eCAE63YIAXkN7PQWC13jfG0fTgWagj0LhwbtzLAL/cBDw1YnLtg
         Y+6jYrOa7UTTB3JkKQIpoV76+3fBhJc/JEa0BO/xvlpmBq+T4Z/54tou5W/e1VO/f8
         qN+nan6MDluay6Hl3ME4LQmmYow8WdR5YalsUzIl8eCJe/e9PQ2fMenyJqIwmJe4ro
         guFTz/dtfpyeQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Johan Jonker <jbx6244@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains
 property
In-Reply-To: <CAL_Jsq+gCi8g0jY2ic1tJebc_JijMU-GntWQg09q+X41O3=1RA@mail.gmail.com>
References: <20221219191038.1973807-1-robh@kernel.org>
 <87edsua5q4.fsf@balbi.sh>
 <CAL_JsqKgGWN93QJ=V34=X3hC2bgdcd3vwO0Mne-8z8HOfVDz-g@mail.gmail.com>
 <878riy9ztm.fsf@balbi.sh> <20221223235712.h54lggnjjuu3weol@synopsys.com>
 <CAL_Jsq+gCi8g0jY2ic1tJebc_JijMU-GntWQg09q+X41O3=1RA@mail.gmail.com>
Date:   Fri, 30 Dec 2022 10:43:44 +0200
Message-ID: <87o7rlffi7.fsf@balbi.sh>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Rob Herring <robh@kernel.org> writes:
> On Fri, Dec 23, 2022 at 5:57 PM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>> > Rob Herring <robh@kernel.org> writes:
>> > >> > The Rockchip RK3399 DWC3 node has 'power-domain' property which isn't
>> > >> > allowed by the schema:
>> > >> >
>> > >> > usb@fe900000: Unevaluated properties are not allowed ('power-domains' was unexpected)
>> > >> >
>> > >> > Allow DWC3 nodes to have a single power-domains entry. We could instead
>> > >> > move the power-domains property to the parent wrapper node, but the
>> > >> > could be an ABI break (Linux shouldn't care). Also, we don't want to
>> > >> > encourage the pattern of wrapper nodes just to define resources such as
>> > >> > clocks, resets, power-domains, etc. when not necessary.
>> > >> >
>> > >> > Signed-off-by: Rob Herring <robh@kernel.org>
>> > >> > ---
>> > >> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 3 +++
>> > >> >  1 file changed, 3 insertions(+)
>> > >> >
>> > >> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> > >> > index 6d78048c4613..bcefd1c2410a 100644
>> > >> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> > >> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> > >> > @@ -91,6 +91,9 @@ properties:
>> > >> >          - usb2-phy
>> > >> >          - usb3-phy
>> > >> >
>> > >> > +  power-domains:
>> > >> > +    maxItems: 1
>> > >>
>> > >> AFAICT this can be incorrect. Also, you could have Cc the dwc3
>> > >> maintainer to get comments.
>>
>> Felipe is correct. We have 2 power-domains: Core domain and PMU.
>
> Power management unit? Performance management unit?
>
> That doesn't change that the rk3399 is 1 and we're stuck with it. So I
> can say 1 or 2 domains, or we add the 2nd domain when someone needs
> it.

Isn't the snps,dwc3.yaml document supposed to document dwc3's view of
the world? In that case, dwc3 expects 2 power domains. It just so
happens that in rk3399 they are fed from the same power supply, but
dwc3' still thinks there are two of them. No?

It's a similar situation when you have multiple clock domains with the
same parent clock.

-- 
balbi
