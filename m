Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DBC68BB05
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjBFLMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBFLMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:12:03 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CF21A487
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:12:02 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id d66so12202332vsd.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5h+VQeJ1pnYHOHcXWQBZLCmmfa0OvP133fn8gP4oZo=;
        b=gxphReKAofgw0QYoSuMpjcdQshT8iAyhE35zYA3DPKIH4Z/BK2Gt3gNzhaZJq8f365
         AwBt4eTMt3LHkoXR+GSn0Mb16WE62+ygDr3RpnteUZU3aiyqTz2YTQHd5mbK3JFVC9wN
         9VLM2BkCtLy5K7PUfXkkmWzkBuloTMwsUz5l+OhEx+PBhp6KGDMnYweCFQ6M8OG/XCuV
         z4ZOBNrrPbbIIrYXmsuq0UQzPf09L0mPaw8qYguW0e5dCiyc/u7WMrF/RERErRZEiZLT
         Xz8Ra09P0FYylogiQyb1Stpim5cotPs6ZZCEsyqJISxqnAxj0hKIWIld6Pk5cDZUkpz3
         ahPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5h+VQeJ1pnYHOHcXWQBZLCmmfa0OvP133fn8gP4oZo=;
        b=oqsOX2n9i+GeyLQIWRj+/NvVNmyFjyaU8vxXfDESDy1iCz/xcPA8WXVdSsIxxnNqqX
         9eCG8TErDyceNpVdVtDroeg8JH8NQfqQbJ01fLFQROH1nFSqQTGPEg3q9T1X4R2FW0ip
         q7JFJFHQKvbMgweBjaOJJYFp+ppYO20pDX7VdEdRgJ3/3J1nWiYU8yZeHkR/TOUt427e
         KMEGRxm9u/CwpbwFJZKjgNS4HDe1FAdV5/ahkEMvTIwu/9itgfK6u6ZOFaAltAcRsMoX
         I1I63tDaLBpcRECjQSOqjYXiHRErMloisvfIkHpPMiVoAYpDeYNpQPA7yoWkyIgye/F8
         J22w==
X-Gm-Message-State: AO0yUKVo3ZO9Im6iA1NssJ6EXOsHGXkgAaeY16tQU+XNpdKBlFUZBwc/
        ecHvaG04W35OMZHaXoHZgizLsWis0v5/VtRE2HbbNwRHicS4K17L
X-Google-Smtp-Source: AK7set+cBpICaCUb+7zfaNasE/ApYh308g5ms075HCZfZwYhTxkm++QgF++DAGRSPJM9q7D2REivNihqGn+r2mTNahY=
X-Received: by 2002:a67:ebc1:0:b0:3d0:d172:3a02 with SMTP id
 y1-20020a67ebc1000000b003d0d1723a02mr2866093vso.41.1675681921068; Mon, 06 Feb
 2023 03:12:01 -0800 (PST)
MIME-Version: 1.0
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
 <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com>
 <Y9zFzW2yj7uMI0XR@jade> <CAFA6WYOp-NQxvqOmemiW2D5Au549f-u4LJA7XEK2aJgMiXRUYg@mail.gmail.com>
 <Y9zoMJcbrKIvbDdh@jade> <CAFA6WYPLeN5tUY8JA=J9T3XVNfq5jAQ62i=qSk-6eesM-9_K=Q@mail.gmail.com>
 <CAMj1kXGg3wwhJFRjAGEP2fDLcbHpiuHuiaW2y+oVgjwULqVTZg@mail.gmail.com>
In-Reply-To: <CAMj1kXGg3wwhJFRjAGEP2fDLcbHpiuHuiaW2y+oVgjwULqVTZg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 6 Feb 2023 16:41:47 +0530
Message-ID: <CAFA6WYO5r66VqdczFH4HC1O=DuuauQBohr80zPLA86rnHgC48Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ard for the detailed background information.

On Mon, 6 Feb 2023 at 14:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 6 Feb 2023 at 07:44, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Fri, 3 Feb 2023 at 16:25, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> ..
> > > StMM uses the MM protocol. It was originially using raw SMCs as a
> > > conduit, but with the need for OP-TEE accessing RPMB that's not usable.
> > > So instead we use OP-TEE MSG as a conduit. Seen from that perspective
> > > we're only resuing something established instead of inventing something
> > > new.
> >
> > Aren't we already adding PTA_STMM?
> >
> > Isn't the StMM specific to Arm as you already mentioned it was
> > designed to specifically use raw SMCs? So if in future AMD TEE wants
> > to implement EFI services, can we suggest they reuse the MM interface?
> >
> > I am not sure why we need to redirect EFI variables via MM interface
> > communication buffers rather than directly using the TEE shared memory
> > approach.
> >
> > Ard,
> >
> > Since you have better insights into how EFI runtime services have to
> > be implemented, can you share your opinion here? It may be something I
> > am missing here.
> >
>
> Hello Sumit,
>
> I'm not sure I understand what you are asking me here. Allow me to
> reiterate, apologies if I am stating the obvious:
>
> The EFI spec describes how the OS should expose the EFI runtime
> services, but this is difficult to implement when access to the
> underlying storage requires arbitration between accesses by the OS
> itself and accesses made by the firmware.

Agree.

>
> On systems where this issue is absent, the EFI runtime service
> implementation for the variable services are very thin wrappers around
> calls into standalone MM, which are not standardized, but are also not
> ARM specific (standalone MM is being used on other architectures as
> well, and 'classic' SMM uses the same protocol but dispatches the call
> into the secure/SMM world in a different way)
>

Thanks for the clarification. So wouldn't it be better to have the
standalone MM API reside here: drivers/firmware/efi/ and it should be
exposed instead of efivars ops? As you mention below that there is
nothing OP-TEE specific in there.

> On systems where arbitration is needed, the standalone MM payload
> needs to call back up into the OS to request access to the flash
> storage. OP-TEE is a suitable vehicle for this, as it already does the
> same thing for other reasons, and is already set up to dispatch SMC
> calls that are taken to S-EL1.

Agree.

>
> All of his is uncharted territory as far as the EFI spec is concerned,
> as it occurs inside the StMM pseudo-API call, which itself normally
> occurs inside the EFI runtime service call. Given that we cannot use
> the latter (as the firmware does not provide a working get/setvariable
> at OS runtime [0]), we need to provide some plumbing to call the StMM
> pseudo-API directly, and expose it as an alternative efivars
> implementation. (Note that this should mean that other implementations
> of the StMM pseudo-API that do not require this arbitration may
> potentially be accessed in the same way, although I don't see a reason
> to use it like that.)
>
> If I am understanding you correctly, your question is whether OP-TEE
> should expose the StMM pseudo-API in the usual way as well, and make
> the OS rely on the usual discovery mechanisms etc to bind to it?

No, I am trying to understand and generalize how an EFI runtime
service ABI would look like among Linux kernel and a TEE. As you may
be aware there are multiple TEE implementations and OP-TEE is one of
them. So we should try to have a generic TEE client driver [1] rather
than every other TEE implementation coming up with its own driver.

>
> If that is indeed your question: what purpose would that serve,
> exactly?

> In principle, the OS piece that implements efivars on top of
> the StMM pseudo-API should not be specific to any TEE implementation
> or API, and I think the fact that OP-TEE is the provider in this case
> is an implementation detail.

Yeah as I said above we should abstract the StMM pieces out of an
OP-TEE driver and then the driver can be a generic TEE client driver
which is just providing the underline vehicle (invoke commands and
StMM buffer passing) as you described above.

>
> If you feel that OP-TEE should not expose this interface directly to
> begin with, and rely on some marshalling layer to expose the StMM
> pseudo-API on top of its ordinary exposed API, that is really an
> OP-TEE internal matter (which I think is what you discussed with Jens
> up in the thread?) Since StMM calls are defined in terms of SMC
> instructions + arguments, this would require more code inside OP-TEE
> to translate access to an API that it already exposes directly as
> well, so I'm not sure what the gain would be.

No I am not against OP-TEE exposing StMM stuff but rather the StMM
stuff (buffer allocation etc.) being bundled into OP-TEE client
driver.

>
> The thing to remember is that, even though the wrappers are very thin,
> it is fundamentally the StMM API that is being exposed, not the EFI
> runtime services API, and so whether or not a use case may materialize
> that wants to expose a different API via efivars is out of scope here,
> even if they are roughly shaped like get/setvariable.
>

Okay I get your point. If we want the StMM API to be exposed then I
think the EFI subsystem is the suitable place for that.

[1] Although there can be minor differences allowed based on TEE
implementation ID. You can consider it analogous to how we use
multiple DT compatibles for a generic platform driver.

-Sumit
