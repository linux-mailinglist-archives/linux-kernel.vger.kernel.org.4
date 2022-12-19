Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AAA65151A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiLSVvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLSVvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:51:31 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08A36306;
        Mon, 19 Dec 2022 13:51:29 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j4so15844500lfk.0;
        Mon, 19 Dec 2022 13:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YpyHMvBi47xap8b8pdoC+5U4ffS+1ERoafLFlXosTRE=;
        b=YdEUetwqEwCJ1mgRm6RZF5b7XBxE4GFs+IRWlH7ep/wZJhcQpakIaGnU/JRGzFCYHh
         au8TtIYyNd9MlBe0FTrt8ozKO71rlqLcGjE5Y1H1H2hXY7CF9SWhNm8IHNof7zo5wnzJ
         W+xxuhMJ8bfxQPKY6J838VEMWEvrSiSmDVJYxUp62dr6grKER8sYEhAcNK2iVCiICmko
         iT4SfsrDjntcIcF5oao2sR4gg4qiuyZYpBqg54X85+wr7oe4TvNkMW9bLle3g5YvzrDA
         cFp1XS5dOHkh8bQHFHCznHUSlEOrctqRG0JOy/tipoX6W+j2/dBAHf8KXB7fyQQhLMWA
         gw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpyHMvBi47xap8b8pdoC+5U4ffS+1ERoafLFlXosTRE=;
        b=xaxOMS01ca/uF9uXTDW6h4JFQ4g/2V8L/I4JLOVvijZR76KMhKycxNK1wU4H/A7fOa
         pk1YFv1XwNXqCLTYURAJe87kEpeoeSThf4ckqr4G3a2Nqz7jDSNTVlrYAvJJTnaJzrkx
         imvBjPwNFWb8GAwTbjX/cgVgx/655rVIuTeNNKDUL7Wlo8U7p1uMHos2nacyqUxOmsvg
         PP2KP1V/Pmw/sMbBkdpY4U61PG+/lFiuBFkXXekyCHffK7utZEP/atkNzmBmTRGC4HA5
         N1cEe7CzyR3MtJwLyuKo0Tqm9YQNOkPG/YRyLc185Ko00tyWiqw4GeUxSNlZ9SXRxwaq
         5/7w==
X-Gm-Message-State: ANoB5plVWbkjlHP8l48tbWPziO6LxSRo9ecn3QjCtxEda8DNIhnDYW4I
        R82W6yAEnF7mn8f3AcKpvIw6GASSQPCy17R6yk8=
X-Google-Smtp-Source: AA0mqf5nPiDYG7LgLKyj3PFuCrFegQFpXo67fz4SzFvfJh5xZyLdWOOuEGSf5MGn4+PiPdgTJz77vBFrJts1m6ESHkk=
X-Received: by 2002:a05:6512:3f0f:b0:4b5:1034:41b1 with SMTP id
 y15-20020a0565123f0f00b004b5103441b1mr23828971lfa.198.1671486687752; Mon, 19
 Dec 2022 13:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20221216094350.1121354-1-neeraj.sanjaykale@nxp.com>
 <85D2AE3F-97A5-4C88-8FC4-1684F3FD4438@holtmann.org> <CABBYNZLWFNWp=StPQ0=8hQe8bUoJzwSvCBk7Ybd=2oe=NROCgQ@mail.gmail.com>
 <5742801D-881A-45BC-A8A7-28D694179D8E@holtmann.org>
In-Reply-To: <5742801D-881A-45BC-A8A7-28D694179D8E@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 19 Dec 2022 13:51:16 -0800
Message-ID: <CABBYNZKZ+uenPGQiLmkJLYPOW66fZ=AihimAiv_tFpA0ab5QyA@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: Add hci_nxp to hci_uart module to support
 NXP BT chipsets
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Mon, Dec 19, 2022 at 3:42 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> >>> Add hci_nxp to the hci_uart module which adds support for the NXP BT
> >>> chips. This driver has Power Save feature that will put the NXP bluetooth
> >>> chip into sleep state, whenever there is no activity for certain duration
> >>> of time (2000ms), and will be woken up when any activity is to be
> >>> initiated.
> >>>
> >>> The Power Save feature can be configured with the following set
> >>> of commands (optional):
> >>> hcitool -i hci0 cmd 3F 23 02 00 00    (enable Power Save)
> >>> hcitool -i hci0 cmd 3F 23 03 00 00    (disable Power Save)
> >>> where,
> >>> OGF = 0x3F (vendor specific command)
> >>> OCF = 0x23 (command to set Power Save state)
> >>> arg[0] = 0x02 (disable Power Save)
> >>> arg[0] = 0x03 (enable Power Save)
> >>> arg[1,2,...] = XX (don't care)
> >>>
> >>> The sleep/wake-up source can be configured with the following set
> >>> of commands (optional):
> >>> hcitool -i hci0 cmd 3F 53 03 14 01 FF    (set UART break method)
> >>> hcitool -i hci0 cmd 3F 53 03 14 00 FF    (set UART DSR method)
> >>> where,
> >>> OGF = 0x3F (vendor specific command)
> >>> OCF = 0x53 (command to set sleep and wake-up source)
> >>> arg[0] = 0x00 (Chip to host method NONE)
> >>> arg[0] = 0x01 (Chip to host method UART DTR)
> >>> arg[0] = 0x02 (Chip to host method UART BREAK)
> >>> arg[0] = 0x03 (Chip to host method GPIO)
> >>> arg[1] = 0x14 (Chip to host GPIO[20] if arg[0] is 0x03, else 0xFF)
> >>> arg[2] = 0x00 (Host to chip method UART DSR)
> >>> arg[2] = 0x01 (Host to chip method UART BREAK)
> >>> arg[3] = 0xXX (Reserved for future use)
> >>>
> >>> By default, the hci_nxp sets power save enable, chip to host wake-up
> >>> source as GPIO and host to chip sleep and wake-up source as UART
> >>> break during driver initialization, by sending the respective
> >>> commands to the chip.
> >>>
> >>> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> >>> ---
> >>> v2: Changed the subject/summary lines and added more details in the
> >>> description. (Paul Menzel)
> >>> v3: Made internal functions static, optimized the code, added few
> >>> comments. (Sherry Sun)
> >>> v4: Reworked entire code to send vendor commands cmd23 and cmd53 by
> >>> using __hci_cmd_sync. (Luiz Augusto von Dentz)
> >>> v5: Used hci_command_hdr and combined OGF+OCF into a single opcode.
> >>> (Luiz Augusto von Dentz)
> >>> ---
> >>> MAINTAINERS                   |   6 +
> >>> drivers/bluetooth/Kconfig     |  10 +
> >>> drivers/bluetooth/Makefile    |   1 +
> >>> drivers/bluetooth/hci_ldisc.c |   6 +
> >>> drivers/bluetooth/hci_nxp.c   | 592 ++++++++++++++++++++++++++++++++++
> >>> drivers/bluetooth/hci_nxp.h   |  94 ++++++
> >>> drivers/bluetooth/hci_uart.h  |   8 +-
> >>> 7 files changed, 716 insertions(+), 1 deletion(-)
> >>> create mode 100644 drivers/bluetooth/hci_nxp.c
> >>> create mode 100644 drivers/bluetooth/hci_nxp.h
> >>
> >> so this is a clear NAK. Add this as serdev driver and not hook further into the
> >> mess that is the HCI line discipline.
> >
> > I wonder if we should make it more clear somehow, perhaps include a
> > text on the likes of BT_HCIUART that is deprecated and new drivers
> > shall use BT_HCIUART_SERDEV instead.
>
> not even that. They need to be separate drivers. A long time ago I posted
> the skeleton for btuart.ko and bt3wire.ko and that is where this has to go.

Perhaps if you can resend these changes, at least I couldn't find them
in the archives.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
