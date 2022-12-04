Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E90E641A9E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 04:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLDDcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 22:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiLDDcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 22:32:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E22A1AD8F
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 19:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=8ju922wpXC0TWqn+6AUV15dak+yx2fZCAhLDesJYuww=; b=n3BnjNprpk8ZGkT+C38MBfZdct
        hTUtXg8iBvEF21Cj9bfPr3PXT0jV45RcI65cF9l1ktXzDy8giR9XOvbZQ4SnspZ2b7fnuFbkQbgmE
        WK0QhHCeqqzpcTfvaDLrsaBWYoVvxBrXct+R3zPXThTr7YfGO0+wo0cGZLlKt6axRcdUVsl8kZ9MC
        9H+3uSBfXpZiWtRcskGqa2gIADnlxF1lZDZbBM5AK9VDyzp9je7798P0u6X34hTXM2/Td7S22t/Nl
        H7YD1Kq2Y5u/yAoW5mivJLhQ6OE1IYHfVnkl9MPrNB8Pxk9lkaiuYL363hJsuGlBZB8i0V6vNcBKi
        HSX9bQsw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p1fjb-006I5W-PD; Sun, 04 Dec 2022 03:32:07 +0000
Message-ID: <1716b73b-77f4-da8e-801f-7521872697bb@infradead.org>
Date:   Sat, 3 Dec 2022 19:32:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: PATCH [1/2] gamecube/wii: graphic quantization registers driver
 (GQR)
Content-Language: en-US
To:     Zopolis0 <creatorsmithmdt@gmail.com>, linux-kernel@vger.kernel.org
References: <CAEYL+X_X7OsP3BQ3poK4n+DWEOxAais6d9At9nz2TzLFV2HinA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAEYL+X_X7OsP3BQ3poK4n+DWEOxAais6d9At9nz2TzLFV2HinA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 12/3/22 19:06, Zopolis0 wrote:
> ----NOT PART OF PATCH----
> I'm sending this to the open mailing list because get_maintainer.pl
> couldn't come up with anything better.
> 

MAINTAINTERS file:

CHAR and MISC DRIVERS
M:	Arnd Bergmann <arnd@arndb.de>
M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
S:	Supported
F:	drivers/char/
F:	drivers/misc/


> Anyways, just upstreaming
> https://github.com/Zopolis4/gc-linux/commit/e6829693235dda1c494737e28542de2711ce0055,
> with the second fix to come.
> 
> I've left the commits intact, as they were already signed off. If
> there were bug fixes, I would have sent them as an additional patch,
> which I will probably do for the other patches to upstream.

Please read Documentation/process/submitting-patches.rst.
Search for "Signed-off-by:".

Most relevant:

Any further SoBs (Signed-off-by:'s) following the author's SoB are from
people handling and transporting the patch, but were not involved in its
development. SoB chains should reflect the **real** route a patch took
as it was propagated to the maintainers and ultimately to Linus, with
the first SoB entry signalling primary authorship of a single author.

and

The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery path.


and lastly, gmail has (apparently) munged the whitespace in the patch
so that it is awful... or it was never done correctly if gmail didn't
munge it.

> These patches don't depend on any other patches that need to be
> upstreamed, unlike many of the other gc-linux patches.
> ----NOT PART OF PATCH----
> 
> From 7c625cb05dd90f29ce310c598dc84a195ca52b9f Mon Sep 17 00:00:00 2001
> From: Albert Herranz <albert_herranz@yahoo.es>
> Date: Thu, 22 Jan 2009 20:31:39 +0100
> Subject: [PATCH 1/2] gamecube/wii: graphic quantization registers driver (GQR)
> 
> Add support for accessing the Graphic Quantization Registers of the
> Nintendo GameCube and Wii video game consoles PowerPC processor via
> the proc filesystem.
> 
> The Graphic Quantization Registers can be used to influence how the
> psql* and psqst* instructions operate.
> 
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> ---
>  drivers/misc/Kconfig   |   9 +++
>  drivers/misc/Makefile  |   1 +
>  drivers/misc/gcn-gqr.c | 129 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+)
>  create mode 100644 drivers/misc/gcn-gqr.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 358ad56f6524..83525024c5ee 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -57,6 +57,15 @@ config DUMMY_IRQ
>     The sole purpose of this module is to help with debugging of systems on
>     which spurious IRQs would happen on disabled IRQ vector.
> 
> +config GAMECUBE_GQR
> + tristate "Nintendo GameCube/Wii Graphic Quantization Registers (GQR)"
> + depends on GAMECUBE_COMMON
> + help
> +          This option enables device driver support for the Gekko/Broadway
> +   processors' Graphic Quantization Registers.
> +   These registers are used with the psql and psqst instructions.
> +   The registers will appear in /proc/sys/gqr.
> +
>  config IBM_ASM
>   tristate "Device driver for IBM RSA service processor"
>   depends on X86 && PCI && INPUT
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index ac9b3e757ba1..cebdac81a336 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_SENSORS_TSL2550) += tsl2550.o
>  obj-$(CONFIG_DS1682) += ds1682.o
>  obj-$(CONFIG_C2PORT) += c2port/
>  obj-$(CONFIG_HMC6352) += hmc6352.o
> +obj-$(CONFIG_GAMECUBE_GQR) += gcn-gqr.o
>  obj-y += eeprom/
>  obj-y += cb710/
>  obj-$(CONFIG_VMWARE_BALLOON) += vmw_balloon.o
> diff --git a/drivers/misc/gcn-gqr.c b/drivers/misc/gcn-gqr.c
> new file mode 100644
> index 000000000000..66482653f8ef
> --- /dev/null
> +++ b/drivers/misc/gcn-gqr.c
> @@ -0,0 +1,129 @@
> +/*
> + * drivers/misc/gcn-gqr.c
> + *
> + * Nintendo GameCube GQR driver
> + * Copyright (C) 2004-2009 The GameCube Linux Team
> + * Copyright (C) 2004 Todd Jeffreys <todd@voidpointer.org>
> + * Copyright (C) 2007,2008,2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */

Preferably just use an SPDX-License-Identifier line above.

-- 
~Randy
