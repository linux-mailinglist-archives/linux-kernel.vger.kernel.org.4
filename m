Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEAC690EA3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBIQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBIQvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:51:25 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE946310B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:51:23 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id iz19so2108768plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 08:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFqj+biyDpY9pXqvmkLkzDhno/QTWqjT+mpxmEuFlIE=;
        b=VDTA9tS4LubStVk5KAn8x5cPGoOp99eJz0Kygp3vdTQUGkoiRVuoIS7n9bY8qwL85b
         rjwClE3hOwhV3Of1ekxPfOGBgY5HAqnTT+dM/8+tL0bXG6nJurzutM+JzB9Rn6VyUnEV
         GwSFt5EGOT2WL6Ibb7gaLwB85VqyWQnig8hDaaeXqkLPTTwOmAdcXirHzFpYCrDxtz75
         Bx0weyxL/oQVROo7My9Uxt8p7vvNM9uVFU2UVdz9cdJyTibKGf2ZvKkJiCtheffJdCMT
         IC82A+fCcrwt85502UiQ+XNLw2e+eXNbVDC6A08p023lu6BAWviul2X62bRmJpnUNXM8
         +pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFqj+biyDpY9pXqvmkLkzDhno/QTWqjT+mpxmEuFlIE=;
        b=lgTcI2ISrhqX4qyqwluGQCDfq0MAgfSd505N5dr0qRAzgRG2FA9aB7DnL8G0maFvth
         MGNLRMrSZx7tqclN+KD2pvfpO4U8jAAkb5MZrFtZvGle72UizPFQcv3T//JsoQrHquA+
         VL7KG1O4uyTOgiYCwKCoxwFt8Qj2lw7eXcBlyNdEe+CTxCxUOOPTDnIwqIeJmvGCyjZ/
         zevW+s9qPdesXSBLwo6GoNnWAz2Bdj6jiN0x7pMeB5fZiZNcq2mfwErho7zw3WhWJ0Nq
         mNGPfe+3tMcdgYzb2V/HmoWUw+MurIFh5vrspyXZeEfcy9/M3EmudnrTzp9ooqC97yDg
         /LBw==
X-Gm-Message-State: AO0yUKV8JUn9zfGtU4RngMvAfScZwnVFovmuaT1I5iTMpG1gZbMQoBN7
        qbAALBx/LPaiclWUwFiIl701Ig==
X-Google-Smtp-Source: AK7set9dXtbFLqR0SLyd6Rfiqg0GWw0+da8IB1XBCGr+lJRziUoT47+K2T9x09vL9nopKJoJT5bMlA==
X-Received: by 2002:a17:90b:1c86:b0:22c:792:d342 with SMTP id oo6-20020a17090b1c8600b0022c0792d342mr13638710pjb.26.1675961483220;
        Thu, 09 Feb 2023 08:51:23 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id jw14-20020a17090b464e00b002338ff973d4sm101213pjb.11.2023.02.09.08.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:51:22 -0800 (PST)
Date:   Thu, 09 Feb 2023 08:51:22 -0800 (PST)
X-Google-Original-Date: Thu, 09 Feb 2023 08:51:16 PST (-0800)
Subject:     RE: [PATCH v2 4/6] dt-bindings: Add RISC-V misaligned access performance
In-Reply-To: <4bd24def02014939a87eb8430ba0070d@AcuMS.aculab.com>
CC:     robh@kernel.org, evan@rivosinc.com,
        Conor Dooley <conor@kernel.org>,
        Vineet Gupta <vineetg@rivosinc.com>, heiko@sntech.de,
        slewis@rivosinc.com, aou@eecs.berkeley.edu,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     David.Laight@ACULAB.COM
Message-ID: <mhng-8736b349-e27a-4372-81ca-3a25d2ec1e94@palmer-ri-x1c9>
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

On Wed, 08 Feb 2023 04:45:10 PST (-0800), David.Laight@ACULAB.COM wrote:
> From: Rob Herring
>> Sent: 07 February 2023 17:06
>>
>> On Mon, Feb 06, 2023 at 12:14:53PM -0800, Evan Green wrote:
>> > From: Palmer Dabbelt <palmer@rivosinc.com>
>> >
>> > This key allows device trees to specify the performance of misaligned
>> > accesses to main memory regions from each CPU in the system.
>> >
>> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> > Signed-off-by: Evan Green <evan@rivosinc.com>
>> > ---
>> >
>> > (no changes since v1)
>> >
>> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 15 +++++++++++++++
>> >  1 file changed, 15 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml
>> b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> > index c6720764e765..2c09bd6f2927 100644
>> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> > @@ -85,6 +85,21 @@ properties:
>> >      $ref: "/schemas/types.yaml#/definitions/string"
>> >      pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
>> >
>> > +  riscv,misaligned-access-performance:
>> > +    description:
>> > +      Identifies the performance of misaligned memory accesses to main memory
>> > +      regions.  There are three flavors of unaligned access performance: "emulated"
>> > +      means that misaligned accesses are emulated via software and thus
>> > +      extremely slow, "slow" means that misaligned accesses are supported by
>> > +      hardware but still slower that aligned accesses sequences, and "fast"
>> > +      means that misaligned accesses are as fast or faster than the
>> > +      cooresponding aligned accesses sequences.
>> > +    $ref: "/schemas/types.yaml#/definitions/string"
>> > +    enum:
>> > +      - emulated
>> > +      - slow
>> > +      - fast
>>
>> I don't think this belongs in DT. (I'm not sure about a userspace
>> interface either.)

[Kind of answered below.]

>> Can't this be tested and determined at runtime? Do misaligned accesses
>> and compare the performance. We already do this for things like memcpy
>> or crypto implementation selection.

We've had a history of broken firmware emulation of misaligned accesses 
wreaking havoc.  We don't run into concrete bugs there because we avoid 
misaligned accesses as much as possible in the kernel, but I'd be 
worried that we'd trigger a lot of these when probing for misaligned 
accesses.

> There is also an long discussion about misaligned accesses
> for loooongarch.
>
> Basically if you want to run a common kernel (and userspace)
> you have to default to compiling everything with -mno-stict-align
> so that the compiler generates byte accesses for anything
> marked 'packed' (etc).
>
> Run-time tests can optimise some hot-spots.
>
> In any case 'slow' is probably pointless - unless the accesses
> take more than 1 or 2 extra cycles.

[Also below.]

> Oh, and you really never, ever want to emulate them.

Unfortunately we're kind of stuck with this one: the specs used to 
require that misaligned accesses were supported and thus there's a bunch 
of firmwares that emulate them (and various misaligned accesses spread 
around, though they're kind of a mess).  The specs no longer require 
this support, but just dropping it from firmware will break binaries.

There's been some vague plans to dig out of this, but it'd require some 
sort of firmware interface additions in order to turn off the emulation 
and that's going to take a while.  As it stands we've got a bunch of 
users that just want to know when they can emit misaligned accesses.

> Technically misaligned reads on (some) x86-64 cpu are slower
> than aligned ones, but the difference is marginal.
> I've measured two 64bit misaligned reads every clock.
> But it is consistently slower by much less than one clock
> per cache line.

The "fast" case is explicitly written to catch that flavor of 
implementation.

The "slow" one is a bit vaguer, but the general idea is to catch 
implementations that end up with some sort of pipeline flush on 
misaligned accesses.  We've got a lot of very small in-order processors 
in RISC-V land, and while I haven't gotten around to benchmarking them 
all my guess is that the spec requirement for support ended up with some 
simple implementations.

FWIW: I checked the c906 RTL and it's setting some exception-related 
info on misaligned accesses, but I'd need to actually benchmark on to 
know for sure and they're kind of a headache to deal with.

>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
