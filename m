Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD0A636D09
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKWW02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiKWW0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:26:25 -0500
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DF514E6C0;
        Wed, 23 Nov 2022 14:26:24 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id q21so133619iod.4;
        Wed, 23 Nov 2022 14:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md22OrgObOx6DJr1ojJ7e+OLdIlThpqngt384PGuCOQ=;
        b=JEzoc13ZQO/3bTFZBY/TBBoDw/UmT5dr9mDRMHT2oq8vDcsJp/EEofKAAlw/IC092s
         DmPMLCn0cKKycp7m/St+aeqHnui0Mtpd3Af1Qrn2euvKsQnZOyKkZ8QuScSC+kAriPqF
         1AoOE0+rQBpS05yvY3uCe59fKYFC3qS3m0t230dEUF7fh5TZxtKxH2Jnz9FozznK/meI
         xrWwMdxlFl2FCOG8kegNjnhwwJ7dT1fiNH0euNLPwDIqfRt6aE42yIB9fSr6brbc8gDk
         cm28CLLrSACbNYOzSWxo9a5wxLzKymf9ZjwRUuKMuPzxbKHtlUZXk5pnoUH4AyF81rLN
         y89w==
X-Gm-Message-State: ANoB5pmIsfydoF7m+uLTRp99Vwz1VGdSR7rT84UrKGQKQcDKjsZ20HFd
        fgw1IvilK/TFJM+icVDB4w==
X-Google-Smtp-Source: AA0mqf5kzl4MXkOhcYULiC7EDYSS0a6ABHItbyx+DROc/VOx1kAqziBldZZSdsDen3xapJ9BYjl7LA==
X-Received: by 2002:a05:6638:296:b0:363:79c4:b889 with SMTP id c22-20020a056638029600b0036379c4b889mr4970556jaq.292.1669242383774;
        Wed, 23 Nov 2022 14:26:23 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u29-20020a02b1dd000000b003880914948fsm556036jah.6.2022.11.23.14.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:26:23 -0800 (PST)
Received: (nullmailer pid 2616920 invoked by uid 1000);
        Wed, 23 Nov 2022 22:26:24 -0000
Date:   Wed, 23 Nov 2022 16:26:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Hal Feng <hal.feng@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] dt-bindings: sifive,ccache0: Support StarFive
 JH7110 SoC
Message-ID: <20221123222624.GA2611087-robh@kernel.org>
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-5-hal.feng@starfivetech.com>
 <Y3duiJguYE6VrVLP@spud>
 <Y3dvCPP1g0LzzHFO@spud>
 <a5193e23-efe1-fa65-15de-d53b80b87d63@starfivetech.com>
 <Y3yRTuo69JUsfLqk@wendy>
 <0f9e423e-37c0-a838-bf25-f9b6784a31d0@starfivetech.com>
 <Y3yd+tfFl4yvXOx6@wendy>
 <b57bdf1c-19f4-3d70-7618-16817669abc5@starfivetech.com>
 <CAJM55Z-aQfvUZXNtaorAk4acpbbVsj-f-8TQn6uZXQosD=MORA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z-aQfvUZXNtaorAk4acpbbVsj-f-8TQn6uZXQosD=MORA@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:35:28AM +0100, Emil Renner Berthing wrote:
> On Tue, 22 Nov 2022 at 11:16, Hal Feng <hal.feng@starfivetech.com> wrote:
> >
> > On Tue, 22 Nov 2022 10:01:30 +0000, Conor Dooley wrote:
> > > On Tue, Nov 22, 2022 at 05:55:57PM +0800, Hal Feng wrote:
> > > > On Tue, 22 Nov 2022 09:07:26 +0000, Conor Dooley wrote:
> > > > > On Tue, Nov 22, 2022 at 04:40:23PM +0800, Hal Feng wrote:
> > > > > > On Fri, 18 Nov 2022 19:39:52 +0800, Conor Dooley wrote:
> > > > > > > On Fri, Nov 18, 2022 at 11:37:50AM +0000, Conor Dooley wrote:
> > > > > > > > On Fri, Nov 18, 2022 at 09:17:10AM +0800, Hal Feng wrote:
> > > > > > > > > From: Emil Renner Berthing <kernel@esmil.dk>
> > > > > > > > >
> > > > > > > > > This cache controller is also used on the StarFive JH7110 SoC.
> > > > > > > >
> > > > > > > > "... and configured identically to that of the FU740"?
> > > > > > > > Anyways,
> > > > > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > > >
> > > > > > > Actually, after looking at the next patch - why can you not fall back to
> > > > > > > the fu740 one since you appear to have the same configuration as it?
> > > > > >
> > > > > > Right, I will drop this patch and use "sifive,fu740-c000-ccache" as
> > > > > > compatible in dts.
> > > > >
> > > > > Uh, that's not quite what I was suggesting. Rather than using that one
> > > > > in isolation, you can do the following in your dt:
> > > > > "starfive,jh7110-ccache", "sifive,fu740-c000-ccache"
> > > > >
> > > > > And then in the driver we need to make no changes - unless down the line
> > > > > we find some sort of issue that requires special handling etc. There's
> > > > > no harm in having a "starfive,jh7110-ccache" IMO.
> > > >
> > > > Just like what microchip did as blow?
> >
> > below
> >
> > > >
> > > > Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml:
> > > > properties:
> > > >   compatible:
> > > >     oneOf:
> > > >       - items:
> > > >           - enum:
> > > >               - sifive,ccache0
> > > >               - sifive,fu540-c000-ccache
> > > >               - sifive,fu740-c000-ccache
> > > >               - starfive,jh7110-ccache
> > > >           - const: cache
> > > >       - items:
> > > >           - const: microchip,mpfs-ccache
> > > >           - const: sifive,fu540-c000-ccache
> > > >           - const: cache
> > >
> > > No, I don't think this is correct either. You'd do something like:
> > >
> > > >       - items:
> > > >           - const: starfive,jh7110-ccache
> > > >           - const: sifive,fu740-c000-ccache
> 
> For the record I don't think the line above should be there. The
> fu7400-c000 is a specific tapeout and pretending the JH7110 is that
> tapeout is not right. Especially when there is already the
> "sifive,ccache0" string for the generic IP.

All it really says is that this h/w will work with any client (OS) 
that understands 'sifive,fu740-c000-ccache'. Maybe 'sifive,ccache0' is 
sufficient too, IDK.

Rob
