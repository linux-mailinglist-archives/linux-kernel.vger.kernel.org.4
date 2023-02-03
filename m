Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436756893D6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjBCJdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjBCJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:33:49 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5665564B0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:33:47 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id v81so2278480vkv.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 01:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3UedE5bXLP8vsupdvzX88Qy04XdQPfSUK++6UDSBsRE=;
        b=Nf1aWJOJyqgYYdFf7aidxLZSy/NbEMxfQq4ShbXS/yJnRmni437LjVxV/zQHe+s6eU
         GZbmZ4ctm1eDLw3ks5lM6QBTw8lPtmUX9vP3BSXxGoyAN1RlAW2X8DbSlpQ87FLFsv9x
         zwfnPuyFoafOalwYH0jfqd/vDI1sBxV1H4QP25u+2ST5W22YHKgp6fTXEiym9m/0/EN+
         gYTMxP+TKudElG2XEdvNtPbXkm448WnY1Yce5Y892W22+i+nSrDv6pm/pkxV5Rjg0Y8G
         cQKWZA2a06UrnVioodXu4FIuromOcKIYbZV68BN0nJxh1NIYbnZOQw/YRt8znhl0WvwL
         mS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UedE5bXLP8vsupdvzX88Qy04XdQPfSUK++6UDSBsRE=;
        b=qtrcfHyA62ZpXg1ezhi/y3Ow7sZzWrGBrc6OuYeDUWSio3xwA0cbIk6+75kx1VqOcF
         JStJhkZSP/MZQegWcH2pxSLFc/VsO41f2eAfpSFed2EEHXHVwT4LZxe4SWHfXMiEkkLo
         PhXulqc1HmxA2owDmpLicn8zm98tmDEZtbnQF+k3Cze3pbbnpjeSoSKMUebl7Xc/JZDi
         2rYq5MfE9k1aGzs4qvB3SiJvakwpFJMe5oLH8kMk4aNL2bVOeUfjjok9barI7w1ccdnR
         dwJTNu80hDj4vqUxX3xbSqj8Ijb10lKRBkx5ozKlALzD+j5Gi+RCs1N38LW25E4j+DSu
         efiQ==
X-Gm-Message-State: AO0yUKWqmaCAf7UHbpI0bdE8n7wqgpB/FY5Y3RZGmpUJV5yxdEplnkov
        ck+s9LyASQ60E0DeHiq6Rhnaq8ShKoslNvzIGiqmhQJbRUUmxg==
X-Google-Smtp-Source: AK7set8ITAwCcFJGfPrZakSpNdI59sRlJP52aSqoXobL2GNemAuJxqhCsaEhiHVjxzRPPz2s6pWmglIHjjEc+1Rwwb8=
X-Received: by 2002:a05:6122:216b:b0:3ea:78fc:6dce with SMTP id
 j11-20020a056122216b00b003ea78fc6dcemr1397995vkr.0.1675416826875; Fri, 03 Feb
 2023 01:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
 <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com> <Y9zFzW2yj7uMI0XR@jade>
In-Reply-To: <Y9zFzW2yj7uMI0XR@jade>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 3 Feb 2023 15:03:34 +0530
Message-ID: <CAFA6WYOp-NQxvqOmemiW2D5Au549f-u4LJA7XEK2aJgMiXRUYg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
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

Hi Jens,

On Fri, 3 Feb 2023 at 13:59, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Sumit,
>
> On Thu, Feb 02, 2023 at 05:35:49PM +0530, Sumit Garg wrote:
> > Hi Masahisa,
> >
> > On Thu, 26 Jan 2023 at 18:52, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > This RFC series introduces the op-tee based EFI Runtime Variable
> > > Service.
> > >
> > > The eMMC device is typically owned by the non-secure world(linux in
> > > this case). There is an existing solution utilizing eMMC RPMB partition
> > > for EFI Variables, it is implemented by interacting with
> > > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > > and tee-supplicant. The last piece is the tee-based variable access
> > > driver to interact with OP-TEE and StandaloneMM.
> > >
> >
> > After an overall look at the APIs, following are some initial comments:
> > - Is there any reason to have the edk2 specific StandaloneMM stack in
> > Linux to communicate with OP-TEE pseudo TA?
> > - I think the OP-TEE pseudo TA should be able to expose a rather
> > generic invoke commands such as:
> >      TEE_EFI_GET_VARIABLE
> >      TEE_EFI_GET_NEXT_VARIABLE
> >      TEE_EFI_SET_VARIABLE
> >   So it should no longer be tied to StMM stack and other TEE
> > implementations can re-use the abstracted interface to communicate
> > with its corresponding secure storage TA.
>
> In the current setup we have the following layers in the kernel:
> 1. efivar_operations
> 2. MM
> 3. PTA_STMM
> 4. OP-TEE MSG
>
> and in the secure world:
> S1. internal to StMM
> S2. MM interface to StMM
> S3. PTA_STMM
> S4. OP-TEE MSG
>
> If I understand you correctly you'd like to see this instead:
> Kernel:
> 1. efivar_operations
> 2. PTA_EFIVAR
> 4. OP-TEE MSG
>
> Since we still have the MM interface with StMM we'd have this in the secure
> world:
> S1. internal to StMM
> S2. MM interface to StMM
> S3. PTA_EFIVAR
> S4. OP-TEE MSG
>
> At S3 we'd have to convert between EFIVAR and MM messages. The
> difference is that we're moving the EFIVAR <-> MM conversion from the
> non-secure world into the secure world. We're still using OP-TEE
> specific communication at the fourth layer. So we're only moving problem
> around, I'd rather avoid growing the OP-TEE part in the secure world.
>

If you look carefully, we are essentially defining an ABI towards the
secure world. The approach in this patch-set adds the MM interface as
a redundant ABI layer which makes it complex to maintain. Now think
about if every TEE implementation would propose such a complex ABI. It
looks like a maintenance nightmare to me.

The concerns you are highlighting about OP-TEE size, I think those are
implementation details which can be simplified later but once you have
defined an ABI then you are stuck with its maintainability.

-Sumit

> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > > Masahisa Kojima (2):
> > >   efi: expose efivar generic ops register function
> > >   tee: Add op-tee helper functions for variable access
> > >
> > >  drivers/firmware/efi/efi.c           |  12 +
> > >  drivers/tee/optee/Kconfig            |  10 +
> > >  drivers/tee/optee/Makefile           |   1 +
> > >  drivers/tee/optee/mm_communication.h | 249 +++++++++++
> > >  drivers/tee/optee/optee_private.h    |   5 +-
> > >  drivers/tee/optee/optee_stmm_efi.c   | 598 +++++++++++++++++++++++++++
> > >  drivers/tee/tee_core.c               |  23 ++
> > >  include/linux/efi.h                  |   4 +
> > >  include/linux/tee_drv.h              |  23 ++
> > >  9 files changed, 924 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/tee/optee/mm_communication.h
> > >  create mode 100644 drivers/tee/optee/optee_stmm_efi.c
> > >
> > > --
> > > 2.30.2
> > >
