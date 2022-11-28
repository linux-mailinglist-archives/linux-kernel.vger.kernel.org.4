Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED863B612
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiK1Xl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiK1XlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:41:22 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED14D13DC0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:41:20 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a16so11642881pfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQvlx+1Mw3aNuJTA2b+/LRz8ikSIvWj9nKVnNpG8ijo=;
        b=uV0AGKeAUIsWOqhlt5UuZ8kTLBjmmuQI+QG30kdN2Vvo7an9ynfTxtYC3V9hOTue1Z
         mTHRDJJHY9e244Rn8QR+HFYm19V0lKYZ4AkO2PDJpMncIo9ykS666xf4rHkQpTMsDoUm
         mlpG5zo8yMsfnh5jz8+b7gd36tTCeu+akBDTlPERR1Ggs4ld1vY1DEkCiuz6lzn2zxkQ
         G5yFedaJyIhbk6DBeE6wobCcd+d+ku8l4GzO6/MUzL+ReIvlbnRV+14NbjvyUhERptyJ
         LFx1gl5mXs2HSLN5yJBSCyf1/1YIAib3iqije43C9hJUNANDG6wIdYfHZTeWOSP+BH5T
         aYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQvlx+1Mw3aNuJTA2b+/LRz8ikSIvWj9nKVnNpG8ijo=;
        b=47jm5Bq5f4tPqu2jl65kXzlaMkQf/I8HwN0cLHNS0h3i9p75XixFPlg/3xWZtwy7qo
         e1TnQj1cwfBcm+KM+Sr6o2CJUffryHU7UtkgMr8YzNI7zgro8J5Vbt+4lo9crioJ+26r
         x2jLO82D5oWFHKiuT/EIhNPEoaTkvWazSReDG7h623ACMQ9/cRmA5Eo8jiRoxhMBtCb1
         9et1Ny9nZywefuAEx5xJk+vkPan7tHffTegtg/35settjL1mJ9mGH0l0FlNBRxmr71dr
         3YC1X64osAMskXkxwQObyCDlecAh0pyAqBPuZhJy1olsTUAWbwU2rfA3mWBGGsvDjah7
         t2kQ==
X-Gm-Message-State: ANoB5pm1Eu72vtDc0PxsMQlbrqZkZLYy0pgevk1iepeKYzUNxjM4ite6
        4vKnv90IGWMpUBWzNInTPErscg==
X-Google-Smtp-Source: AA0mqf7iqQc7XiA9Gtrgo5HG5Kpi2s1j0qBOVrnj75f4/YdH7FPftm9bTLLH6l19kQQt4C3qgHk7qg==
X-Received: by 2002:a63:e411:0:b0:45f:b2a7:2659 with SMTP id a17-20020a63e411000000b0045fb2a72659mr30146688pgi.132.1669678880217;
        Mon, 28 Nov 2022 15:41:20 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z13-20020a170903018d00b0018853416bbcsm9484405plg.7.2022.11.28.15.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:41:19 -0800 (PST)
Date:   Mon, 28 Nov 2022 15:41:19 -0800 (PST)
X-Google-Original-Date: Mon, 28 Nov 2022 15:41:11 PST (-0800)
Subject:     Re: [PATCH 2/2] dt-bindings: riscv: fix single letter canonical order
In-Reply-To: <Y4UJQYgCpnZJji9o@spud>
CC:     heiko@sntech.de, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com, guoren@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-8141aa74-17c6-4692-a658-b5e4faad0c14@palmer-ri-x1c9a>
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

On Mon, 28 Nov 2022 11:17:21 PST (-0800), Conor Dooley wrote:
> On Mon, Nov 28, 2022 at 10:12:17AM -0800, Palmer Dabbelt wrote:
>> On Mon, 28 Nov 2022 10:08:05 PST (-0800), Conor Dooley wrote:
>> > On Mon, Nov 28, 2022 at 09:41:03AM -0800, Palmer Dabbelt wrote:
>> > > On Thu, 24 Nov 2022 05:42:20 PST (-0800), heiko@sntech.de wrote:
>> > > > Am Donnerstag, 24. November 2022, 14:04:41 CET schrieb Conor Dooley:
>> > > > > I used the wikipedia table for ordering extensions when updating the
>> > > > > pattern here in foo.
>> > > >
>> > > > 	    ^ foo? :-)
>> > > >
>> > > > > Unfortunately that table did not match canonical order, as defined by
>> > > > > the RISC-V ISA Manual, which defines extension ordering in (what is
>> > > > > currently) Table 41, "Standard ISA extension names". Fix things up by
>> > > > > re-sorting v (vector) and adding p (packed-simd) & j (dynamic
>> > > > > languages). The e (reduced integer) and g (general) extensions are still
>> > > > > intentionally left out.
>> > > > >
>> > > > > Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
>> > > > > Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
>> > > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> > > >
>> > > > So I have compared the new pattern to the isa manual,
>> > > > and it looks like the order checks out, so
>> > >
>> > > Which ISA manual?
>> >
>> > For me, isa manual is the above github repo.
>>
>> Which commit, though?
>
> mutt won't let me paste a clown face emoticon.
>
>> > > There have been many mutually incompatible ISA string
>> > > encoding rules, at least one of them was a change to the extension ordering.
>> > > It's not entirely clear what the right answer is here, as we can't really
>> > > parse ISA strings without also knowing the version of the ISA manual we're
>> > > meant to parse them against.  Maybe we just accept everything?
>> >
>> > I don't think accepting everything is the right thing to do. A minimal
>> > amount of validation is still needed here, but I think we can deprecate
>> > the DT property entirely & make it optional if a new-and-improved way of
>> > encoding the in DT is used.
>>
>> Sorry, by "everything" I meant "everything that's even been allowed by the
>> ISA manual".  Just accetping anything would be bad ;)
>>
>> > > IMO it's time to just stop using the ISA string.  It's not a stable
>> > > interface, trying to treat it as such just leads to headaches.  We should
>> > > just come up with some DT-specific way of encoding whatever HW features are
>> > > in question.  Sure it'll be a bit of work to write that all down in the DT
>> > > bindings, but it's going to be way less work than trying to keep around all
>> > > this ISA string parsing code.
>> >
>> > I'm a glutton for punishment, I'll try and come up with some sort of
>> > other way to encode this information in DT that requires less parsing
>> > and validation. As I said on IRC, something that more resembles:
>> > if (of_property_wahtever("riscv,isa-foo")) { do_enable_foo() }
>>
>> That seems way simpler to me, thanks!  We'll still need to support whatever
>> was here as a legacy format, but at least we won't need to add a bunch of
>> new stuff to it -- that's where the parsing starts to get really
>> complicated.
>
> Yah, and "deprecated" in dt-schema doesn't actually do anything at the
> moment other than let humans know not to use something. Just gonna have
> to do some sort of "feature-wise AND" between the existing things we
> parse from the isa string & whatever riscv,isa-foo stuff later on.

I suppose this is more of a Rob question, but could we just make the DT 
bindings match the current ISA manual's rules and then have the kernel's 
"riscv,isa" string parser accept more orderings to remain compatible?

Sort of a API vs ABI stability question, but for DTB and bindngs.

>> FWIW, there's a similar dicussion going on in GCC land right now.
>>
>> > > I know I've said the opposite before, but there's just been way too many
>> > > breakages here to assume they're going to stop.
>> >
>> > :upside_down_face:
>> >
>> > Either way, I think these two patches are worth taking in the mean time.
>>
>> Yep, just as long as it doesn't break any of the strings that were valid
>> according to previous versions of the ISA manual I'm fine with it.
>
> I don't think so. I had been looking around for a supposed order for
> where to actually put H, which had been dropped - and the only place I
> recall seeing that was Wikipedia - which now seems like an awful
> decision since the order there looks kinda off anything I see in dozen
> or so spec PDFs I have downloaded. But that's where I got the K & V
> ordering from that I now think is wrong (and doesn't match any PDF I
> have). The other changes relax rules and add letters so they should be
> okay too.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

as it sounds like there aren't even any fixed rules, so I guess none of 
this even matters?

>
>> > > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>> > > >
>> > > > > ---
>> > > > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
>> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > > >
>> > > > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> > > > > index e80c967a4fa4..b7462ea2dbe4 100644
>> > > > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>> > > > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> > > > > @@ -80,7 +80,7 @@ properties:
>> > > > >        insensitive, letters in the riscv,isa string must be all
>> > > > >        lowercase to simplify parsing.
>> > > > >      $ref: "/schemas/types.yaml#/definitions/string"
>> > > > > -    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
>> > > > > +    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
>> > > > >
>> > > > >    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
>> > > > >    timebase-frequency: false
>> > > > >
