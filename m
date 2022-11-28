Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC32863B20E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiK1TSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiK1TR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:17:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DA82B19B;
        Mon, 28 Nov 2022 11:17:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50CA7613C5;
        Mon, 28 Nov 2022 19:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C69AC433C1;
        Mon, 28 Nov 2022 19:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669663046;
        bh=yQ5hUODoRr61GX9YNtGAbFsGAu4JgPpjVKyNBXT2dv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHmRlT6l6Yh89J+B8WGGzv5ffbu+yVFvvTvPOH9WA2H2STmDJH4mDCFnBh7xpBOSl
         YeDHWPZqA8pxuA7+iERraR5QzXvzXksTwrEdEI+b/ZxL+5VBf1fNPqYifMWC1eiGW4
         Wh6YTnYrdb0jHSJb+IPHoQVAZoC3GpUIZp9BDZZtDSDWZ4yef2Dnqck2g7DWdmEx4S
         1q7feEwvdQYF0rNiVe1Wv1+7DH2JWGTmYowGgEvUuKzNASv37lKOZMzaljEK505QNT
         al1ldUrGp4LVLUzomidYtjs0rK80pd2p8M0bxIOug/TshSo2Z5KXNLf78JbfyejUk0
         55I/1sT5SRmhA==
Date:   Mon, 28 Nov 2022 19:17:21 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     heiko@sntech.de, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com, guoren@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: riscv: fix single letter canonical order
Message-ID: <Y4UJQYgCpnZJji9o@spud>
References: <Y4T5BZTRZWqXpV2A@spud>
 <mhng-eebb4b54-4332-40f8-8c6d-cb239d3ce924@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-eebb4b54-4332-40f8-8c6d-cb239d3ce924@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:12:17AM -0800, Palmer Dabbelt wrote:
> On Mon, 28 Nov 2022 10:08:05 PST (-0800), Conor Dooley wrote:
> > On Mon, Nov 28, 2022 at 09:41:03AM -0800, Palmer Dabbelt wrote:
> > > On Thu, 24 Nov 2022 05:42:20 PST (-0800), heiko@sntech.de wrote:
> > > > Am Donnerstag, 24. November 2022, 14:04:41 CET schrieb Conor Dooley:
> > > > > I used the wikipedia table for ordering extensions when updating the
> > > > > pattern here in foo.
> > > >
> > > > 	    ^ foo? :-)
> > > >
> > > > > Unfortunately that table did not match canonical order, as defined by
> > > > > the RISC-V ISA Manual, which defines extension ordering in (what is
> > > > > currently) Table 41, "Standard ISA extension names". Fix things up by
> > > > > re-sorting v (vector) and adding p (packed-simd) & j (dynamic
> > > > > languages). The e (reduced integer) and g (general) extensions are still
> > > > > intentionally left out.
> > > > >
> > > > > Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
> > > > > Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
> > > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > >
> > > > So I have compared the new pattern to the isa manual,
> > > > and it looks like the order checks out, so
> > > 
> > > Which ISA manual?
> > 
> > For me, isa manual is the above github repo.
> 
> Which commit, though?

mutt won't let me paste a clown face emoticon.

> > > There have been many mutually incompatible ISA string
> > > encoding rules, at least one of them was a change to the extension ordering.
> > > It's not entirely clear what the right answer is here, as we can't really
> > > parse ISA strings without also knowing the version of the ISA manual we're
> > > meant to parse them against.  Maybe we just accept everything?
> > 
> > I don't think accepting everything is the right thing to do. A minimal
> > amount of validation is still needed here, but I think we can deprecate
> > the DT property entirely & make it optional if a new-and-improved way of
> > encoding the in DT is used.
> 
> Sorry, by "everything" I meant "everything that's even been allowed by the
> ISA manual".  Just accetping anything would be bad ;)
> 
> > > IMO it's time to just stop using the ISA string.  It's not a stable
> > > interface, trying to treat it as such just leads to headaches.  We should
> > > just come up with some DT-specific way of encoding whatever HW features are
> > > in question.  Sure it'll be a bit of work to write that all down in the DT
> > > bindings, but it's going to be way less work than trying to keep around all
> > > this ISA string parsing code.
> > 
> > I'm a glutton for punishment, I'll try and come up with some sort of
> > other way to encode this information in DT that requires less parsing
> > and validation. As I said on IRC, something that more resembles:
> > if (of_property_wahtever("riscv,isa-foo")) { do_enable_foo() }
> 
> That seems way simpler to me, thanks!  We'll still need to support whatever
> was here as a legacy format, but at least we won't need to add a bunch of
> new stuff to it -- that's where the parsing starts to get really
> complicated.

Yah, and "deprecated" in dt-schema doesn't actually do anything at the
moment other than let humans know not to use something. Just gonna have
to do some sort of "feature-wise AND" between the existing things we
parse from the isa string & whatever riscv,isa-foo stuff later on.

> FWIW, there's a similar dicussion going on in GCC land right now.
> 
> > > I know I've said the opposite before, but there's just been way too many
> > > breakages here to assume they're going to stop.
> > 
> > :upside_down_face:
> > 
> > Either way, I think these two patches are worth taking in the mean time.
> 
> Yep, just as long as it doesn't break any of the strings that were valid
> according to previous versions of the ISA manual I'm fine with it.

I don't think so. I had been looking around for a supposed order for
where to actually put H, which had been dropped - and the only place I
recall seeing that was Wikipedia - which now seems like an awful
decision since the order there looks kinda off anything I see in dozen
or so spec PDFs I have downloaded. But that's where I got the K & V
ordering from that I now think is wrong (and doesn't match any PDF I
have). The other changes relax rules and add letters so they should be
okay too.

> > > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > >
> > > > > ---
> > > > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > > index e80c967a4fa4..b7462ea2dbe4 100644
> > > > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > > @@ -80,7 +80,7 @@ properties:
> > > > >        insensitive, letters in the riscv,isa string must be all
> > > > >        lowercase to simplify parsing.
> > > > >      $ref: "/schemas/types.yaml#/definitions/string"
> > > > > -    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
> > > > > +    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
> > > > >
> > > > >    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
> > > > >    timebase-frequency: false
> > > > >
