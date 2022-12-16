Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2764F313
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 22:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiLPVTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 16:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPVTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:19:22 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918A2DF1;
        Fri, 16 Dec 2022 13:19:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id c1so5322749lfi.7;
        Fri, 16 Dec 2022 13:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aHl3ThJVXcxIPvZSfmGmQodnvR4tXTxSwW1ZUdG5N74=;
        b=SMNvDKLNLzLK6LLxhJDL7Pfpyzt5kRltr0KG4HKyy0xtJD1fLg4wzKg3LpeKPtncC9
         PijOpg0fRnRAn63XaiNtBqXD61IqoXXigl5Uoiusx2bdVjv5DKpkMipRMwA33B4hACGW
         WrLs76H8f7cv4OxZgiUTkUqhp+BQ7Q81bB4v7IP6mZWRVN6L+Gx1FaFnD1fJQvb1oG5B
         55+TqQeEyAQ69aAXccNywHHeF81iF7CbEC8BqQVLmod4yH9D8W1NRyHXGw30oopJejPF
         mXNp/1F4HZiM68fQYIrEDME7fRf43iYNUBmu3hJCEymfDW5+CB+AbCQfYB4itSXotAeU
         EqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHl3ThJVXcxIPvZSfmGmQodnvR4tXTxSwW1ZUdG5N74=;
        b=I0ZQse01esx1yJOyCO79XPGiX5XlLX+/ESifBpZq3ULGeo4Ad4sQi4IWZSJ+z/dJ7O
         8TP0l2jGTqC7cZd1bKX2Lx1etXRtQ1iewEY4MjvXq9raDzXCy4njleu7bv+Uo2Tc+TQZ
         ZJ4Naz1cpmQpD2IU3vHAvbmDXItpyLgslmRf/fMhVbDqm127NDbZ6tsfXIc9s8JEGC/8
         r3gaThXN7QA67j96j2Vf2CEaemV54kFceaOtg0Ze92cxmRLOI6GGzWlFdqyVTyC2oEj5
         ePV8+q+or56zg/DGSboh7GiIQj9GmeM7Y5U596oIe4o8HjEIHqNFQttt1S5Ds3AR2koN
         olIg==
X-Gm-Message-State: ANoB5pnCnfPC0tq86LvshwBE19gbknEDcXpFhxPQFckFlHNWTwP5EQJw
        m/qkwz3UnagQEh4K/gix7NoDMTsTWHP26q0zgx/0XZUpbImlSQ==
X-Google-Smtp-Source: AA0mqf6c0u2NpLrZd4SGv9ca8CXIDbPk5w6xxG9psTSF/BZe6rzjJ13Jyz2uAu2HUAmSxtwTYCmyGazKxp+4k9Vb0OQ=
X-Received: by 2002:a05:6512:22c4:b0:4b5:6528:fe68 with SMTP id
 g4-20020a05651222c400b004b56528fe68mr7525225lfu.251.1671225559410; Fri, 16
 Dec 2022 13:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20221216094350.1121354-1-neeraj.sanjaykale@nxp.com> <85D2AE3F-97A5-4C88-8FC4-1684F3FD4438@holtmann.org>
In-Reply-To: <85D2AE3F-97A5-4C88-8FC4-1684F3FD4438@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 16 Dec 2022 13:19:07 -0800
Message-ID: <CABBYNZLWFNWp=StPQ0=8hQe8bUoJzwSvCBk7Ybd=2oe=NROCgQ@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: Add hci_nxp to hci_uart module to support
 NXP BT chipsets
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
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

On Fri, Dec 16, 2022 at 12:15 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Neeraj,
>
> > Add hci_nxp to the hci_uart module which adds support for the NXP BT
> > chips. This driver has Power Save feature that will put the NXP bluetooth
> > chip into sleep state, whenever there is no activity for certain duration
> > of time (2000ms), and will be woken up when any activity is to be
> > initiated.
> >
> > The Power Save feature can be configured with the following set
> > of commands (optional):
> > hcitool -i hci0 cmd 3F 23 02 00 00    (enable Power Save)
> > hcitool -i hci0 cmd 3F 23 03 00 00    (disable Power Save)
> > where,
> > OGF = 0x3F (vendor specific command)
> > OCF = 0x23 (command to set Power Save state)
> > arg[0] = 0x02 (disable Power Save)
> > arg[0] = 0x03 (enable Power Save)
> > arg[1,2,...] = XX (don't care)
> >
> > The sleep/wake-up source can be configured with the following set
> > of commands (optional):
> > hcitool -i hci0 cmd 3F 53 03 14 01 FF    (set UART break method)
> > hcitool -i hci0 cmd 3F 53 03 14 00 FF    (set UART DSR method)
> > where,
> > OGF = 0x3F (vendor specific command)
> > OCF = 0x53 (command to set sleep and wake-up source)
> > arg[0] = 0x00 (Chip to host method NONE)
> > arg[0] = 0x01 (Chip to host method UART DTR)
> > arg[0] = 0x02 (Chip to host method UART BREAK)
> > arg[0] = 0x03 (Chip to host method GPIO)
> > arg[1] = 0x14 (Chip to host GPIO[20] if arg[0] is 0x03, else 0xFF)
> > arg[2] = 0x00 (Host to chip method UART DSR)
> > arg[2] = 0x01 (Host to chip method UART BREAK)
> > arg[3] = 0xXX (Reserved for future use)
> >
> > By default, the hci_nxp sets power save enable, chip to host wake-up
> > source as GPIO and host to chip sleep and wake-up source as UART
> > break during driver initialization, by sending the respective
> > commands to the chip.
> >
> > Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> > ---
> > v2: Changed the subject/summary lines and added more details in the
> > description. (Paul Menzel)
> > v3: Made internal functions static, optimized the code, added few
> > comments. (Sherry Sun)
> > v4: Reworked entire code to send vendor commands cmd23 and cmd53 by
> > using __hci_cmd_sync. (Luiz Augusto von Dentz)
> > v5: Used hci_command_hdr and combined OGF+OCF into a single opcode.
> > (Luiz Augusto von Dentz)
> > ---
> > MAINTAINERS                   |   6 +
> > drivers/bluetooth/Kconfig     |  10 +
> > drivers/bluetooth/Makefile    |   1 +
> > drivers/bluetooth/hci_ldisc.c |   6 +
> > drivers/bluetooth/hci_nxp.c   | 592 ++++++++++++++++++++++++++++++++++
> > drivers/bluetooth/hci_nxp.h   |  94 ++++++
> > drivers/bluetooth/hci_uart.h  |   8 +-
> > 7 files changed, 716 insertions(+), 1 deletion(-)
> > create mode 100644 drivers/bluetooth/hci_nxp.c
> > create mode 100644 drivers/bluetooth/hci_nxp.h
>
> so this is a clear NAK. Add this as serdev driver and not hook further into the
> mess that is the HCI line discipline.

I wonder if we should make it more clear somehow, perhaps include a
text on the likes of BT_HCIUART that is deprecated and new drivers
shall use BT_HCIUART_SERDEV instead.


-- 
Luiz Augusto von Dentz
