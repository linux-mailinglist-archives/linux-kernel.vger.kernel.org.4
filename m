Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F205A6521F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiLTOE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiLTOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:04:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E981B1CA;
        Tue, 20 Dec 2022 06:04:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64F3BB8120C;
        Tue, 20 Dec 2022 14:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4CCC433F0;
        Tue, 20 Dec 2022 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671545086;
        bh=W7Nt9CNlbNQTRtOJ+Ou9FJetWciHdrJoIDblv/IyaxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W8gBo7DlbzbFGiVxqKnDzbddmVtiUu8dnjSgUzI+ahxBpvXYwtq03/lVGFBHCkM8x
         Ew23AGP8R8/4yhwY8AIc5canf3OnsMpb4HGycC52evWSth/oto9lNDQJ6e+AbJOX9T
         XfLpWRg1nYU5Z5/eq2q9D5RbS9eV7/Vh6p9b9xcuqXTGg+QabVGlY2L61Oh0p91p0U
         KH+n6D2u3hlI8nCxMzVSf86uWUY883tQ8XWBGTPnUXI9Q30chZOUDV9+nKFa2oKUH9
         gjbghHg0obc79L6a5B6sy7484gqrRy61FQQeVbtczHNUN6ljhmoQRKa7fnxG3VKUk/
         j5XjgQ312VTRA==
Received: by mail-vs1-f51.google.com with SMTP id c184so11851618vsc.3;
        Tue, 20 Dec 2022 06:04:45 -0800 (PST)
X-Gm-Message-State: ANoB5pm3II7IV3cR9RmoHWJu9oogeU57F3ijFyAHjCLn1pm/qWlZVXxk
        delVgLPOuaG+MJdbPKPgbIEVc5sT/an0mEfv8w==
X-Google-Smtp-Source: AA0mqf4hj49Vys16ZOKgDVRoRCT4+rE3ssmiSoKl4jx+LV2S2QRh6yunp4wCQEs0sr9wyCLBw8uplqiATyBk5IpMnAk=
X-Received: by 2002:a67:af07:0:b0:3b1:1713:ba12 with SMTP id
 v7-20020a67af07000000b003b11713ba12mr18042140vsl.6.1671545084970; Tue, 20 Dec
 2022 06:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20221219191038.1973807-1-robh@kernel.org> <87edsua5q4.fsf@balbi.sh>
In-Reply-To: <87edsua5q4.fsf@balbi.sh>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Dec 2022 08:04:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKgGWN93QJ=V34=X3hC2bgdcd3vwO0Mne-8z8HOfVDz-g@mail.gmail.com>
Message-ID: <CAL_JsqKgGWN93QJ=V34=X3hC2bgdcd3vwO0Mne-8z8HOfVDz-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains property
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 1:34 AM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> Rob Herring <robh@kernel.org> writes:
>
> > The Rockchip RK3399 DWC3 node has 'power-domain' property which isn't
> > allowed by the schema:
> >
> > usb@fe900000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> >
> > Allow DWC3 nodes to have a single power-domains entry. We could instead
> > move the power-domains property to the parent wrapper node, but the
> > could be an ABI break (Linux shouldn't care). Also, we don't want to
> > encourage the pattern of wrapper nodes just to define resources such as
> > clocks, resets, power-domains, etc. when not necessary.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > index 6d78048c4613..bcefd1c2410a 100644
> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > @@ -91,6 +91,9 @@ properties:
> >          - usb2-phy
> >          - usb3-phy
> >
> > +  power-domains:
> > +    maxItems: 1
>
> AFAICT this can be incorrect. Also, you could have Cc the dwc3
> maintainer to get comments.

When we have a user with more and know what each one is, then we can
extend it. All the other users (upstream), put 'power-domains' in the
wrapper node. But this is what we need now for RK3399.

I used get_maintainers.pl. If that's the wrong output, fix it please.

Rob
