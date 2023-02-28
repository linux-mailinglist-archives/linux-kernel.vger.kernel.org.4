Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1B76A5B28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjB1O4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjB1O4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:56:48 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673332739;
        Tue, 28 Feb 2023 06:56:18 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-172afa7bee2so11165064fac.6;
        Tue, 28 Feb 2023 06:56:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5ioO1pIepGfs4SqLPVfsMcAuwOTg1zSb7b6ZK0A88s=;
        b=xxiLTvcVJrRMs1BXs2iFukcpwSTxWnBi3Tbj9VVd8HL0Fm2JAqr949DPKJ6vl15GCk
         zWsRiQMrv+kuE4UTIeB5wao7F3hrBAn1VZQhp1h7xM/AKh7Ufyaq87qs83ynrkyHCahX
         wKDoK6gGzDEmawN4KAP1vAZDjHF2hrkxkR0pOk+mxQhkgsr+uIWEniF64NIMPnbIvFwm
         eNFf+WCUhkYRS/LrWuPB9K+NN7J7rT5RQCiLkl3S2oa1eYTpuzaVOGdXEMzdIGKTeeDD
         voSdT0Y2o2WZB6zwWO+oC0rmYrpALYYnPlkK7UYy6ILrCnc9MTurYoV2UKRsxMkuD+HA
         jLnQ==
X-Gm-Message-State: AO0yUKUTh5+Bgn9vGNSBVffAwwaVZY8VQ/tzN0BeJ6gZBOi3glrFayy+
        FOvaejA5oFt2mtxfycRspQ==
X-Google-Smtp-Source: AK7set+W45Qn/7/1YbmF3TWAhYItsVzxA7GfCwF6t4mgcwhbvhEsNDIOss2JQCOTYam578+VvcvXBw==
X-Received: by 2002:a05:6870:8a2c:b0:172:7236:a5c0 with SMTP id p44-20020a0568708a2c00b001727236a5c0mr1663030oaq.13.1677596177578;
        Tue, 28 Feb 2023 06:56:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w11-20020a9d70cb000000b0068bb3a9e2b9sm3696943otj.77.2023.02.28.06.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:56:17 -0800 (PST)
Received: (nullmailer pid 3231849 invoked by uid 1000);
        Tue, 28 Feb 2023 14:56:16 -0000
Date:   Tue, 28 Feb 2023 08:56:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     David.Laight@aculab.com, evan@rivosinc.com,
        Conor Dooley <conor@kernel.org>,
        Vineet Gupta <vineetg@rivosinc.com>, heiko@sntech.de,
        slewis@rivosinc.com, aou@eecs.berkeley.edu,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/6] dt-bindings: Add RISC-V misaligned access
 performance
Message-ID: <20230228145616.GA3205994-robh@kernel.org>
References: <4bd24def02014939a87eb8430ba0070d@AcuMS.aculab.com>
 <mhng-8736b349-e27a-4372-81ca-3a25d2ec1e94@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-8736b349-e27a-4372-81ca-3a25d2ec1e94@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 08:51:22AM -0800, Palmer Dabbelt wrote:
> On Wed, 08 Feb 2023 04:45:10 PST (-0800), David.Laight@ACULAB.COM wrote:
> > From: Rob Herring
> > > Sent: 07 February 2023 17:06
> > > 
> > > On Mon, Feb 06, 2023 at 12:14:53PM -0800, Evan Green wrote:
> > > > From: Palmer Dabbelt <palmer@rivosinc.com>
> > > >
> > > > This key allows device trees to specify the performance of misaligned
> > > > accesses to main memory regions from each CPU in the system.
> > > >
> > > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > index c6720764e765..2c09bd6f2927 100644
> > > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > @@ -85,6 +85,21 @@ properties:
> > > >      $ref: "/schemas/types.yaml#/definitions/string"
> > > >      pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
> > > >
> > > > +  riscv,misaligned-access-performance:
> > > > +    description:
> > > > +      Identifies the performance of misaligned memory accesses to main memory
> > > > +      regions.  There are three flavors of unaligned access performance: "emulated"
> > > > +      means that misaligned accesses are emulated via software and thus
> > > > +      extremely slow, "slow" means that misaligned accesses are supported by
> > > > +      hardware but still slower that aligned accesses sequences, and "fast"
> > > > +      means that misaligned accesses are as fast or faster than the
> > > > +      cooresponding aligned accesses sequences.
> > > > +    $ref: "/schemas/types.yaml#/definitions/string"
> > > > +    enum:
> > > > +      - emulated
> > > > +      - slow
> > > > +      - fast
> > > 
> > > I don't think this belongs in DT. (I'm not sure about a userspace
> > > interface either.)
> 
> [Kind of answered below.]
> 
> > > Can't this be tested and determined at runtime? Do misaligned accesses
> > > and compare the performance. We already do this for things like memcpy
> > > or crypto implementation selection.
> 
> We've had a history of broken firmware emulation of misaligned accesses
> wreaking havoc.  We don't run into concrete bugs there because we avoid
> misaligned accesses as much as possible in the kernel, but I'd be worried
> that we'd trigger a lot of these when probing for misaligned accesses.

Then how do you distinguish between emulated and working vs. emulated 
and broken? Sounds like the kernel running things would motivate fixing 
firmware. :) If not, then broken platforms can disable the check with a 
kernel command line flag. 

> 
> > There is also an long discussion about misaligned accesses
> > for loooongarch.
> > 
> > Basically if you want to run a common kernel (and userspace)
> > you have to default to compiling everything with -mno-stict-align
> > so that the compiler generates byte accesses for anything
> > marked 'packed' (etc).
> > 
> > Run-time tests can optimise some hot-spots.
> > 
> > In any case 'slow' is probably pointless - unless the accesses
> > take more than 1 or 2 extra cycles.
> 
> [Also below.]
> 
> > Oh, and you really never, ever want to emulate them.
> 
> Unfortunately we're kind of stuck with this one: the specs used to require
> that misaligned accesses were supported and thus there's a bunch of
> firmwares that emulate them (and various misaligned accesses spread around,
> though they're kind of a mess).  The specs no longer require this support,
> but just dropping it from firmware will break binaries.
> 
> There's been some vague plans to dig out of this, but it'd require some sort
> of firmware interface additions in order to turn off the emulation and
> that's going to take a while.  As it stands we've got a bunch of users that
> just want to know when they can emit misaligned accesses.
> 
> > Technically misaligned reads on (some) x86-64 cpu are slower
> > than aligned ones, but the difference is marginal.
> > I've measured two 64bit misaligned reads every clock.
> > But it is consistently slower by much less than one clock
> > per cache line.
> 
> The "fast" case is explicitly written to catch that flavor of
> implementation.
> 
> The "slow" one is a bit vaguer, but the general idea is to catch
> implementations that end up with some sort of pipeline flush on misaligned
> accesses.  We've got a lot of very small in-order processors in RISC-V land,
> and while I haven't gotten around to benchmarking them all my guess is that
> the spec requirement for support ended up with some simple implementations.

If userspace wants to get into microarchitecture level optimizations, it 
should just look at the CPU model. IOW, use the CPU compatible to infer 
things rather than continuously adding properties in an adhoc manor 
trying to parameterize everything.

Rob
