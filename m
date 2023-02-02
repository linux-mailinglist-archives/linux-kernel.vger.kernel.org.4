Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98838687CD8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjBBMGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBBMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:06:05 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89937234F1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 04:06:01 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id h9so329632uag.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 04:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ytxRAshprvyFCBudhqHORVmawIffFaRJ+dlWBaaA+o=;
        b=O66/XOEGazdWOVaUcnQl0W2QsbEnheXrp/65bqmRYhZWZCjOeICKbyj9kQ/3CjFWOh
         SYcQ1Az9Y5U7NMnQHBO90eomYQO2Kwlux1tcgtUyV5KuCZfiTLIfEg7NPwII9x+c0h24
         BypAZt53xhfw7FZ05qDwNZGOvDaU068ws2Dg1NLeDtpAkjMsVInlG1UqQUkyDL828KhG
         XsgEcSikVWUKPnasbJ0d8ZtVzqTAHPjlUS7KoubbGEL5Tlcg2j15BGNaYDLy+aQpC0Al
         uaCcPSgSl61Zaz5CGYSCAr3mh1c0mkzuost7ZG3SxZLAalFrLNBBR2uSH9l6sJeDbZY7
         LfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ytxRAshprvyFCBudhqHORVmawIffFaRJ+dlWBaaA+o=;
        b=QKbm+FimQRMd0xSNIl1YHwQGFy7Jb2OxAA2iVXrOn4+d9Hj9R9HSrfC/heBSahf28W
         708E7F5LFEtVJtsushXkevDZARh5Xiwiq7KilQN1VC2nlNNoJ7h4opye6whVpqtWKEaK
         54ujSSA/TRdD49qftEdUCe2Rf7TxDsiNuZQTn0EBZ0E+qyDVbHVvgC0rBiIemUtHccOz
         soZ1BWIOjkcv7H1vYq5tZmn2cm8P/irHxKuINMpIjwzJ90qJ2L1HTeLcrcNADi6+32au
         OFHB4ZJXL0gFdp+zFxrCd+OkALYbCbUppt7S9f5Ro4qogvm9lp8Q/OV16K0t/Eh4qY2J
         RKRw==
X-Gm-Message-State: AO0yUKVTk+y/04oYz0TVnsmt+HWzPpIo7wbAiq7OqtZx4Ew8oZR610Ak
        c26ycNEOctSz2qeggzONZrs5ehS1zGwC8LSsBMR05Q==
X-Google-Smtp-Source: AK7set+KAUf8LqpJWUkznZ7VPDV1gTKOPSsqydCQ8Qj0oMEe3q3tMw9daLqMoSgK9In6FtIQG3TF8aClDm8hqJgtmfU=
X-Received: by 2002:a9f:3dc2:0:b0:5d6:e7f7:2fac with SMTP id
 e2-20020a9f3dc2000000b005d6e7f72facmr937329uaj.30.1675339560387; Thu, 02 Feb
 2023 04:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
In-Reply-To: <20230126132120.1661-1-masahisa.kojima@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 2 Feb 2023 17:35:49 +0530
Message-ID: <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
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

Hi Masahisa,

On Thu, 26 Jan 2023 at 18:52, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This RFC series introduces the op-tee based EFI Runtime Variable
> Service.
>
> The eMMC device is typically owned by the non-secure world(linux in
> this case). There is an existing solution utilizing eMMC RPMB partition
> for EFI Variables, it is implemented by interacting with
> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> and tee-supplicant. The last piece is the tee-based variable access
> driver to interact with OP-TEE and StandaloneMM.
>

After an overall look at the APIs, following are some initial comments:
- Is there any reason to have the edk2 specific StandaloneMM stack in
Linux to communicate with OP-TEE pseudo TA?
- I think the OP-TEE pseudo TA should be able to expose a rather
generic invoke commands such as:
     TEE_EFI_GET_VARIABLE
     TEE_EFI_GET_NEXT_VARIABLE
     TEE_EFI_SET_VARIABLE
  So it should no longer be tied to StMM stack and other TEE
implementations can re-use the abstracted interface to communicate
with its corresponding secure storage TA.

-Sumit

> Masahisa Kojima (2):
>   efi: expose efivar generic ops register function
>   tee: Add op-tee helper functions for variable access
>
>  drivers/firmware/efi/efi.c           |  12 +
>  drivers/tee/optee/Kconfig            |  10 +
>  drivers/tee/optee/Makefile           |   1 +
>  drivers/tee/optee/mm_communication.h | 249 +++++++++++
>  drivers/tee/optee/optee_private.h    |   5 +-
>  drivers/tee/optee/optee_stmm_efi.c   | 598 +++++++++++++++++++++++++++
>  drivers/tee/tee_core.c               |  23 ++
>  include/linux/efi.h                  |   4 +
>  include/linux/tee_drv.h              |  23 ++
>  9 files changed, 924 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/tee/optee/mm_communication.h
>  create mode 100644 drivers/tee/optee/optee_stmm_efi.c
>
> --
> 2.30.2
>
