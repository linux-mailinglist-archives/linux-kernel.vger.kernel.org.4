Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2032655ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 18:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiLXRhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 12:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLXRhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 12:37:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386ADB495;
        Sat, 24 Dec 2022 09:37:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 650AAB8016A;
        Sat, 24 Dec 2022 17:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE2EC433EF;
        Sat, 24 Dec 2022 17:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671903468;
        bh=nYcWuSjcESsZ5VXztzLbQ7LJL41H+JOcVMbwnylZLtg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I0oe+9V1xS1zeEMkIdc2aXawFTFIA/31l/cmCGZJvHg+mQAP97w/P+vTQ0yGyZ2Dx
         mPsYePJweuwyrz44F+JqAYl9K6Vvnlx7K7U5TMbOZDQQ7ZGAa3jeoL7i90Sj4VlQE1
         CXGK/8PJzpw3hRmZG/pTvbkGpD8Qw6UTzaV6q0A8QvuI27X4eRs2mgTQqG1rwIR54O
         dFf2iwhA25N62OG0W/1HAwrWVNmOuyQiVe8YsqkMDo8M/Uwa9ALxmKM8BKWlLOCUrX
         xjdx0aqODD0RuqhjeLh3TsPeoXgyCleLJDryf9paD+n0Rv/OMJMUHeD31gDfA7e6rh
         JcY+sioFWx60g==
Received: by mail-vs1-f41.google.com with SMTP id a66so7113933vsa.6;
        Sat, 24 Dec 2022 09:37:48 -0800 (PST)
X-Gm-Message-State: AFqh2kpHYMXCmyOZn68wL8ttc8Ku4GWR6uz6hQeKYGTkyC3uKK/oSzfv
        enNU/EHp2p9Wo9KOvBBINmMOUeS5PLLWXn2lRg==
X-Google-Smtp-Source: AMrXdXtKXEUztiMvfY6flDDIpwstBFgjPj+zjwH0rvgfz8ANqanfZUsuih29ncY94VFNBjWNBmT9Hf2nN/vuKoASosc=
X-Received: by 2002:a67:fb05:0:b0:3bf:754b:15c5 with SMTP id
 d5-20020a67fb05000000b003bf754b15c5mr1661989vsr.85.1671903467016; Sat, 24 Dec
 2022 09:37:47 -0800 (PST)
MIME-Version: 1.0
References: <20221219191038.1973807-1-robh@kernel.org> <87edsua5q4.fsf@balbi.sh>
 <CAL_JsqKgGWN93QJ=V34=X3hC2bgdcd3vwO0Mne-8z8HOfVDz-g@mail.gmail.com>
 <878riy9ztm.fsf@balbi.sh> <20221223235712.h54lggnjjuu3weol@synopsys.com>
In-Reply-To: <20221223235712.h54lggnjjuu3weol@synopsys.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 24 Dec 2022 11:37:35 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+gCi8g0jY2ic1tJebc_JijMU-GntWQg09q+X41O3=1RA@mail.gmail.com>
Message-ID: <CAL_Jsq+gCi8g0jY2ic1tJebc_JijMU-GntWQg09q+X41O3=1RA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains property
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 5:57 PM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>
> Hi,
>
> On Fri, Dec 23, 2022, Felipe Balbi wrote:
> >
> > Hi,
> >
> > Rob Herring <robh@kernel.org> writes:
> > >> > The Rockchip RK3399 DWC3 node has 'power-domain' property which isn't
> > >> > allowed by the schema:
> > >> >
> > >> > usb@fe900000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> > >> >
> > >> > Allow DWC3 nodes to have a single power-domains entry. We could instead
> > >> > move the power-domains property to the parent wrapper node, but the
> > >> > could be an ABI break (Linux shouldn't care). Also, we don't want to
> > >> > encourage the pattern of wrapper nodes just to define resources such as
> > >> > clocks, resets, power-domains, etc. when not necessary.
> > >> >
> > >> > Signed-off-by: Rob Herring <robh@kernel.org>
> > >> > ---
> > >> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 3 +++
> > >> >  1 file changed, 3 insertions(+)
> > >> >
> > >> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > >> > index 6d78048c4613..bcefd1c2410a 100644
> > >> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > >> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > >> > @@ -91,6 +91,9 @@ properties:
> > >> >          - usb2-phy
> > >> >          - usb3-phy
> > >> >
> > >> > +  power-domains:
> > >> > +    maxItems: 1
> > >>
> > >> AFAICT this can be incorrect. Also, you could have Cc the dwc3
> > >> maintainer to get comments.
>
> Felipe is correct. We have 2 power-domains: Core domain and PMU.

Power management unit? Performance management unit?

That doesn't change that the rk3399 is 1 and we're stuck with it. So I
can say 1 or 2 domains, or we add the 2nd domain when someone needs
it.

Rob
