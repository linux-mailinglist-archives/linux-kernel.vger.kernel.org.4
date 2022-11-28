Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0769B63B12F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiK1SXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiK1SXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:23:24 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA66B2FC28
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:12:18 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b21so10950367plc.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OP9R6sfRe+GRr5VjWYq7UtgNchRJxMgVwsC3oAFeqSA=;
        b=PU3/oajwd78PxFP7qumjgRFH2MSpQd4KcOMNpx1bl85dkBdGPkQDCnaVCfOBzmhsKj
         wgmzXi7M3tp/yfk3vZCEN1aftjFzPipiDFl3Z9XRBBkDDd1hyK7iUzgK2998LOWob1Xe
         HSpTAflJcfJZjFnEFrLANJrswU3RzqJ9gP0GD7lhwTPsjW3Mjf/r05DiCwuXJC+arA4b
         rGgLEI4f0hNs8PhxKSFo68xvT1vvnlNOzFEO4pktFVtt/ZqgVR8puu27Ir6D035RgFi/
         wNYzhyYikWsO86bbVQsvA9UYA7DS+71KOf1Eet0Qymk2svIkRcL3JEWexULRbQaOIzGs
         L5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP9R6sfRe+GRr5VjWYq7UtgNchRJxMgVwsC3oAFeqSA=;
        b=a6Fly2Hfa5dBu/YJUsDK+BixXja5FNx1NEH2/DB2jWj7fZHnmIUbyp1eRNbfC2VVv+
         kTOKm1EaE7ClwPX8ZTWM8EjH0NConnFkMVKak4T6qNM9uiK09fKJGo9Js7TCh+SIhOmp
         mgAZ7pmI/RmM19FgE3JTo5+oZv6NDWIbm4L4QuiU3rj3omr29ir5ZHgr56ADHPC2KmAd
         KwjbW0GGrA+RC3TPdlybJUOgF1XUaSf+XdXwPDNaYVhQohDk7toddD7LVFG973f88bij
         Rjq73msb/4tutyRV7fgbs6kczeRAR2HoUizatqMADMDfdWNWJcvJQXQdTqgb8cLBsOc/
         6ltA==
X-Gm-Message-State: ANoB5pn5RuVUnv+UnCrWHJN5gnYTHm75JS94gG3UzchvadrUsxO24cxc
        AeATAUVUIs2lQUclmqBz4ULo3A==
X-Google-Smtp-Source: AA0mqf7zWi8jdRqBKcQrDpigRd9uwvgVceoUXvtZlypvTH89tZ2VJ9/6AaGzv7ZfZKgvenHDfaZvEQ==
X-Received: by 2002:a17:90a:5aa2:b0:218:e3ea:e6b3 with SMTP id n31-20020a17090a5aa200b00218e3eae6b3mr27898252pji.42.1669659138124;
        Mon, 28 Nov 2022 10:12:18 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a0d5000b00218d894fac3sm9996448pju.3.2022.11.28.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 10:12:17 -0800 (PST)
Date:   Mon, 28 Nov 2022 10:12:17 -0800 (PST)
X-Google-Original-Date: Mon, 28 Nov 2022 10:12:09 PST (-0800)
Subject:     Re: [PATCH 2/2] dt-bindings: riscv: fix single letter canonical order
In-Reply-To: <Y4T5BZTRZWqXpV2A@spud>
CC:     heiko@sntech.de, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com, guoren@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-eebb4b54-4332-40f8-8c6d-cb239d3ce924@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 10:08:05 PST (-0800), Conor Dooley wrote:
> On Mon, Nov 28, 2022 at 09:41:03AM -0800, Palmer Dabbelt wrote:
>> On Thu, 24 Nov 2022 05:42:20 PST (-0800), heiko@sntech.de wrote:
>> > Am Donnerstag, 24. November 2022, 14:04:41 CET schrieb Conor Dooley:
>> > > I used the wikipedia table for ordering extensions when updating the
>> > > pattern here in foo.
>> >
>> > 	    ^ foo? :-)
>> >
>> > > Unfortunately that table did not match canonical order, as defined by
>> > > the RISC-V ISA Manual, which defines extension ordering in (what is
>> > > currently) Table 41, "Standard ISA extension names". Fix things up by
>> > > re-sorting v (vector) and adding p (packed-simd) & j (dynamic
>> > > languages). The e (reduced integer) and g (general) extensions are still
>> > > intentionally left out.
>> > >
>> > > Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
>> > > Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
>> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> >
>> > So I have compared the new pattern to the isa manual,
>> > and it looks like the order checks out, so
>>
>> Which ISA manual?
>
> For me, isa manual is the above github repo.

Which commit, though?

>
>> There have been many mutually incompatible ISA string
>> encoding rules, at least one of them was a change to the extension ordering.
>> It's not entirely clear what the right answer is here, as we can't really
>> parse ISA strings without also knowing the version of the ISA manual we're
>> meant to parse them against.  Maybe we just accept everything?
>
> I don't think accepting everything is the right thing to do. A minimal
> amount of validation is still needed here, but I think we can deprecate
> the DT property entirely & make it optional if a new-and-improved way of
> encoding the in DT is used.

Sorry, by "everything" I meant "everything that's even been allowed by 
the ISA manual".  Just accetping anything would be bad ;)

>> IMO it's time to just stop using the ISA string.  It's not a stable
>> interface, trying to treat it as such just leads to headaches.  We should
>> just come up with some DT-specific way of encoding whatever HW features are
>> in question.  Sure it'll be a bit of work to write that all down in the DT
>> bindings, but it's going to be way less work than trying to keep around all
>> this ISA string parsing code.
>
> I'm a glutton for punishment, I'll try and come up with some sort of
> other way to encode this information in DT that requires less parsing
> and validation. As I said on IRC, something that more resembles:
> if (of_property_wahtever("riscv,isa-foo")) { do_enable_foo() }

That seems way simpler to me, thanks!  We'll still need to support 
whatever was here as a legacy format, but at least we won't need to add 
a bunch of new stuff to it -- that's where the parsing starts to get 
really complicated.

FWIW, there's a similar dicussion going on in GCC land right now.

>> I know I've said the opposite before, but there's just been way too many
>> breakages here to assume they're going to stop.
>
> :upside_down_face:
>
> Either way, I think these two patches are worth taking in the mean time.

Yep, just as long as it doesn't break any of the strings that were valid 
according to previous versions of the ISA manual I'm fine with it.

>> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> >
>> > > ---
>> > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> > > index e80c967a4fa4..b7462ea2dbe4 100644
>> > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>> > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> > > @@ -80,7 +80,7 @@ properties:
>> > >        insensitive, letters in the riscv,isa string must be all
>> > >        lowercase to simplify parsing.
>> > >      $ref: "/schemas/types.yaml#/definitions/string"
>> > > -    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
>> > > +    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
>> > >
>> > >    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
>> > >    timebase-frequency: false
>> > >
