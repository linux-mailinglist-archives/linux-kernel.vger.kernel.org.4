Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07C68B5BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBFGoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBFGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:44:28 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40BF12F13
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 22:44:24 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id k4so11633941vsc.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 22:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KuU/DpvV8tboBaa0OaWBw3UwBG4/bh7i27N9royWm64=;
        b=l5Xim1zBtv1SrbUsDmWy6/X1uLiBvvH2spNeSVGGUXYUZ4DxVzhTA4p0q+Cpk8vOu3
         hRUt2flmtPdUSE+804mV5qcIGvWL/dFdcfMM1E3yQ+hLZEiarHGOveYBr622/qZe76KS
         MM6Z3FXugMKR27UPPjVi9iS4joPJWaA5qHhx9teF33T+3ZRERhekJcMJyco8jRqONfBe
         an1Zi+m9XY1AShwYpUZyB0m8SWCU/T4KO84RMNpax2ESXuyx1Vx8iyVAX0C4bZv7cN0R
         GCjR3QvKB5oOv5R4Ry3RZtDD1I5lw3CutraOzg3WPhvDVldJynIPIMjDOLQW33qsLr11
         R67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuU/DpvV8tboBaa0OaWBw3UwBG4/bh7i27N9royWm64=;
        b=LX4XXdaXJhAM7IkyyowWkRF4xXy0ph2YwbieIwbqpJcuDSOog6p/UBhP5m53MZ3JbO
         vWMTN+oTEgvcI1rQaYRI+txMIlLEZ1zbxZBjN9s0FSfoiE0ed5EYcWMGwaeYRss2svTQ
         GvZh/64z+qBUa72tCD8XIE9TEia+iCvgZNQqlTiSXWQbLzyDL7wJ/oDfQKb53IzxhlBm
         mCqy3CVM2+FPWkYI5xnYzEAZCUobIwtQxS2amBD2pAlgRoAkvYFt1JDvIQ2JbXI7gCyA
         kpxeRZN5xo7BMk4WhQ9GY1N/EakDakBK8TVeWQKlXIjtjCYP1L1gVnbtNXzCm2YDMRGA
         xW3A==
X-Gm-Message-State: AO0yUKVypPau8mlC1XThqTL7zpxFtAsFhAUToIVPXkMSQwYKx6lJoX62
        V8M9xthfU2dIJ6dc+kAdhlQSEMT52bbAAo6lfxXxoRH7lp8UH2MW
X-Google-Smtp-Source: AK7set8O4VvDlje1/HLrov8hmyhqxxwvVapB6q7Jwgi1M+TzCibhdIh7FUcfjQgQLsXBWspXlWFe1Q3oEcCyohMPdR4=
X-Received: by 2002:a67:fd93:0:b0:3f0:ce1c:4d5e with SMTP id
 k19-20020a67fd93000000b003f0ce1c4d5emr2771504vsq.62.1675665863580; Sun, 05
 Feb 2023 22:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
 <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com>
 <Y9zFzW2yj7uMI0XR@jade> <CAFA6WYOp-NQxvqOmemiW2D5Au549f-u4LJA7XEK2aJgMiXRUYg@mail.gmail.com>
 <Y9zoMJcbrKIvbDdh@jade>
In-Reply-To: <Y9zoMJcbrKIvbDdh@jade>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 6 Feb 2023 12:14:12 +0530
Message-ID: <CAFA6WYPLeN5tUY8JA=J9T3XVNfq5jAQ62i=qSk-6eesM-9_K=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
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

On Fri, 3 Feb 2023 at 16:25, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Fri, Feb 03, 2023 at 03:03:34PM +0530, Sumit Garg wrote:
> > Hi Jens,
> >
> > On Fri, 3 Feb 2023 at 13:59, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, Feb 02, 2023 at 05:35:49PM +0530, Sumit Garg wrote:
> > > > Hi Masahisa,
> > > >
> > > > On Thu, 26 Jan 2023 at 18:52, Masahisa Kojima
> > > > <masahisa.kojima@linaro.org> wrote:
> > > > >
> > > > > This RFC series introduces the op-tee based EFI Runtime Variable
> > > > > Service.
> > > > >
> > > > > The eMMC device is typically owned by the non-secure world(linux in
> > > > > this case). There is an existing solution utilizing eMMC RPMB partition
> > > > > for EFI Variables, it is implemented by interacting with
> > > > > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > > > > and tee-supplicant. The last piece is the tee-based variable access
> > > > > driver to interact with OP-TEE and StandaloneMM.
> > > > >
> > > >
> > > > After an overall look at the APIs, following are some initial comments:
> > > > - Is there any reason to have the edk2 specific StandaloneMM stack in
> > > > Linux to communicate with OP-TEE pseudo TA?
> > > > - I think the OP-TEE pseudo TA should be able to expose a rather
> > > > generic invoke commands such as:
> > > >      TEE_EFI_GET_VARIABLE
> > > >      TEE_EFI_GET_NEXT_VARIABLE
> > > >      TEE_EFI_SET_VARIABLE
> > > >   So it should no longer be tied to StMM stack and other TEE
> > > > implementations can re-use the abstracted interface to communicate
> > > > with its corresponding secure storage TA.
> > >
> > > In the current setup we have the following layers in the kernel:
> > > 1. efivar_operations
> > > 2. MM
> > > 3. PTA_STMM
> > > 4. OP-TEE MSG
> > >
> > > and in the secure world:
> > > S1. internal to StMM
> > > S2. MM interface to StMM
> > > S3. PTA_STMM
> > > S4. OP-TEE MSG
> > >
> > > If I understand you correctly you'd like to see this instead:
> > > Kernel:
> > > 1. efivar_operations
> > > 2. PTA_EFIVAR
> > > 4. OP-TEE MSG
> > >
> > > Since we still have the MM interface with StMM we'd have this in the secure
> > > world:
> > > S1. internal to StMM
> > > S2. MM interface to StMM
> > > S3. PTA_EFIVAR
> > > S4. OP-TEE MSG
> > >
> > > At S3 we'd have to convert between EFIVAR and MM messages. The
> > > difference is that we're moving the EFIVAR <-> MM conversion from the
> > > non-secure world into the secure world. We're still using OP-TEE
> > > specific communication at the fourth layer. So we're only moving problem
> > > around, I'd rather avoid growing the OP-TEE part in the secure world.
> > >
> >
> > If you look carefully, we are essentially defining an ABI towards the
> > secure world. The approach in this patch-set adds the MM interface as
> > a redundant ABI layer which makes it complex to maintain. Now think
> > about if every TEE implementation would propose such a complex ABI. It
> > looks like a maintenance nightmare to me.
> >
> > The concerns you are highlighting about OP-TEE size, I think those are
> > implementation details which can be simplified later but once you have
> > defined an ABI then you are stuck with its maintainability.
>
> You have a point, but keep in mind that it's StMM that matters here.
> StMM uses the MM protocol. It was originially using raw SMCs as a
> conduit, but with the need for OP-TEE accessing RPMB that's not usable.
> So instead we use OP-TEE MSG as a conduit. Seen from that perspective
> we're only resuing something established instead of inventing something
> new.

Aren't we already adding PTA_STMM?

Isn't the StMM specific to Arm as you already mentioned it was
designed to specifically use raw SMCs? So if in future AMD TEE wants
to implement EFI services, can we suggest they reuse the MM interface?

I am not sure why we need to redirect EFI variables via MM interface
communication buffers rather than directly using the TEE shared memory
approach.

Ard,

Since you have better insights into how EFI runtime services have to
be implemented, can you share your opinion here? It may be something I
am missing here.

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > > Cheers,
> > > Jens
> > >
> > > >
> > > > -Sumit
> > > >
> > > > > Masahisa Kojima (2):
> > > > >   efi: expose efivar generic ops register function
> > > > >   tee: Add op-tee helper functions for variable access
> > > > >
> > > > >  drivers/firmware/efi/efi.c           |  12 +
> > > > >  drivers/tee/optee/Kconfig            |  10 +
> > > > >  drivers/tee/optee/Makefile           |   1 +
> > > > >  drivers/tee/optee/mm_communication.h | 249 +++++++++++
> > > > >  drivers/tee/optee/optee_private.h    |   5 +-
> > > > >  drivers/tee/optee/optee_stmm_efi.c   | 598 +++++++++++++++++++++++++++
> > > > >  drivers/tee/tee_core.c               |  23 ++
> > > > >  include/linux/efi.h                  |   4 +
> > > > >  include/linux/tee_drv.h              |  23 ++
> > > > >  9 files changed, 924 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 drivers/tee/optee/mm_communication.h
> > > > >  create mode 100644 drivers/tee/optee/optee_stmm_efi.c
> > > > >
> > > > > --
> > > > > 2.30.2
> > > > >
