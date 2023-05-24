Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C4A70F010
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbjEXIBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjEXIBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:01:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBDA91
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:00:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so529847e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684915257; x=1687507257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1+ovc/h6HHm5K3ppCH6c5uT2zNs0vtdsXb0+GipOrPg=;
        b=O2/d5IL3zHME9MSCziPyj7UBJhKmvM21lTkHLHYK55gTpKg60tcTVqraAfs/2EsSpn
         K95OsJXwY9BNa0+afuvxDkq4L3t+PT6VZVhiO2RUAbRHZZTNF5lBA+je7fJmgTWPLOSw
         9aKwStXpz8kkpQ4oSfBrG5ySVjjxDixIBjt5eGwPazeoiCn71+LZbkfbcxtc96hsiqXG
         Vnq/zDV8RZfkwoO+wu/7bTp3JePJdXk7fmbdPD95ZcPjP2WQ6tx9DqfSFxG1T/tiyK4H
         QbAl6O4aQ/uFW/+4qKkprcobFuStTiWmX/CC1AQAZ1ogKVDKhIABLaAhpYQTh97GGmxS
         ctjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684915257; x=1687507257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+ovc/h6HHm5K3ppCH6c5uT2zNs0vtdsXb0+GipOrPg=;
        b=gqyitL68HlkWuMuzac0IAEEzXXR2ACTWEIJLegdYqLtLPGkwvzJNroXfttAFzxP9U5
         n85KSvNzdkQVLgoaAq14GJhaDRIhHlbCDClsRZ0V5JzuI5v4VdYo6EIkVgS+S382gdS6
         2sts1zLQe6+VnJ0v53TFKjvadY7dfmCz23HU51DJMtbdiE4+M5vxa1xV2PHUdmI4iBVb
         pSMiOOzRIJT5pIH+RTLoNE3W08m6x0ZXfaOAB05/7wU6kZkz1qOrMfTcMoWGzjXIGbT8
         lMxbFUrwgxTckWgHnyPrpiym9uyuAv1eyxtizuJP1c5v9vPPkM45RzDTs3Vz/VQ/kSZC
         S6Ag==
X-Gm-Message-State: AC+VfDwWI1W7YPnSJuayGA0LCMam9irgH2XdwfAz4Fdv0icz6AGTV4la
        pqzH1ebts2JafwXnxIV9D5881TI28TxdMxeMHQ/ehQ==
X-Google-Smtp-Source: ACHHUZ6qX64hknkppsjmHLHtGjB1ohA1Iafob0vGrHOTZim/HK4NkAwkAun0Khp3XithZZDXl5wHp5/vsABPtXRrOvw=
X-Received: by 2002:a19:7619:0:b0:4ed:d4ac:1e17 with SMTP id
 c25-20020a197619000000b004edd4ac1e17mr5466977lff.49.1684915257449; Wed, 24
 May 2023 01:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230523090607.1433-1-masahisa.kojima@linaro.org> <CAFA6WYOOEwd=jWk1LEaj9K2GkjfV+kfPYOfwPkJVoWXJKGoQXA@mail.gmail.com>
In-Reply-To: <CAFA6WYOOEwd=jWk1LEaj9K2GkjfV+kfPYOfwPkJVoWXJKGoQXA@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 24 May 2023 11:00:21 +0300
Message-ID: <CAC_iWjKxXrEgpqgnpt8g0ummdb1mFbwgMVTSVqfRTNbXOwhz2w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] introduce tee-based EFI Runtime Variable Service
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Wed, 24 May 2023 at 10:56, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 23 May 2023 at 14:36, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > This series introduces the tee based EFI Runtime Variable Service.
> >
> > The eMMC device is typically owned by the non-secure world(linux in
> > this case). There is an existing solution utilizing eMMC RPMB partition
> > for EFI Variables, it is implemented by interacting with
> > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > and tee-supplicant. The last piece is the tee-based variable access
> > driver to interact with OP-TEE and StandaloneMM.
> >
> > Changelog:
> > v3 -> v4:
> > - replace the reference from EDK2 to PI Specification
> > - remove EDK2 source code reference comments
> > - prepare nonblocking variant of set_variable, it just returns
> >   EFI_UNSUPPORTED
> > - remove redundant buffer size check
> > - argument name change in mm_communicate
> > - function interface changes in setup_mm_hdr to remove (void **) cast
>
> I don't have detailed insights into how EFI spec mandates StandaloneMM
> should be implemented. But utilizing OP-TEE as the underlying
> transport here looks fine to me. FWIW,
>
> For the series:
> Acked-by: Sumit Garg <sumit.garg@linaro.org>

Thanks!

 FWIW the PI spec describes some of the functionality and how that
should be accessed.
There's a EFI_MM_COMMUNICATION_PROTOCOL which is not used here.
Instead the entry point is via an SMC to op-tee and the payload
adheres to what the PI spec describes in its EFI_MM_COMMUNICATE_HEADER

Regards
/Ilias
>
> -Sumit
>
> >
> > v2 -> v3:
> > - add CONFIG_EFI dependency to TEE_STMM_EFI
> > - add missing return code check for tee_client_invoke_func()
> > - directly call efivars_register/unregister from tee_stmm_efi.c
> >
> > rfc v1 -> v2:
> > - split patch into three patches, one for drivers/tee,
> >   one for include/linux/efi.h, and one for the driver/firmware/efi/stmm
> > - context/session management into probe() and remove() same as other tee
> > client driver
> > - StMM variable driver is moved from driver/tee/optee to driver/firmware/efi
> > - use "tee" prefix instead of "optee" in driver/firmware/efi/stmm/tee_stmm_efi.c,
> >   this file does not contain op-tee specific code, abstracted by tee layer and
> >   StMM variable driver will work on other tee implementation.
> > - PTA_STMM_CMD_COMMUNICATE -> PTA_STMM_CMD_COMMUNICATE
> > - implement query_variable_store() but currently not used
> > - no use of TEEC_SUCCESS, it is defined in driver/tee/optee/optee_private.h.
> >   Other tee client drivers use 0 instead of using TEEC_SUCCESS
> > - remove TEEC_ERROR_EXCESS_DATA status, it is referred just to output
> > error message
> >
> > Masahisa Kojima (3):
> >   efi: expose efivar generic ops register function
> >   efi: Add EFI_ACCESS_DENIED status code
> >   efi: Add tee-based EFI variable driver
> >
> >  drivers/firmware/efi/Kconfig                 |  15 +
> >  drivers/firmware/efi/Makefile                |   1 +
> >  drivers/firmware/efi/efi.c                   |  12 +
> >  drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
> >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 637 +++++++++++++++++++
> >  include/linux/efi.h                          |   4 +
> >  6 files changed, 905 insertions(+)
> >  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
> >  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
> >
> > --
> > 2.30.2
> >
