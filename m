Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7045363EBFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiLAJHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLAJHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:07:11 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AF4DF7D;
        Thu,  1 Dec 2022 01:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669885629; x=1701421629;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3LFOvef9mHe/uLUNJV3kfSw98lBKxTyDZwvxR5zCcZI=;
  b=XdIGggRbMkpzRD/EXzp+54i7Dbob/TirST4j4sH4ASIpJNnLEPGsW6Gi
   xfLDMStgmeVTmu6KlHqRgBq+/+0ZYEAeooLnlh9jkAM62GVz9bhxWBKJe
   u1k1P+D1TMA2qwsUnkLeTR2C6mI+UW1Sc1UfY/j6mhmU6z4OH80nn1CEh
   2R18Wo6wDO8RbL1MhBwmoKG6tvLG3pjx5Esnb7JYoSbELYh5Hwzeivcm5
   0n7R0ZWk6/VduT3Fd4iVXb+iYU3hFLWWr+E4rGGOeXH2h854Mynfpiae5
   +IQxKVbzEx9nP2rANPC0WGasf2KzlqjLedIupUNcEEPUKncFy/EEMlWY6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="377797266"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="377797266"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 01:07:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="889653371"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="889653371"
Received: from akoroglu-mobl.ger.corp.intel.com ([10.251.212.165])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 01:06:56 -0800
Date:   Thu, 1 Dec 2022 11:06:53 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        macro@orcam.me.uk, jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v6 tty-next 1/4] serial: 8250_pci: Add serial8250_pci_setup_port
 definition in 8250_pcilib.c
In-Reply-To: <20221201045146.1055913-2-kumaravel.thiagarajan@microchip.com>
Message-ID: <1189f5af-aaac-f4c8-b928-cda183e7f90@linux.intel.com>
References: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com> <20221201045146.1055913-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1285920352-1669885620=:1757"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1285920352-1669885620=:1757
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 1 Dec 2022, Kumaravel Thiagarajan wrote:

> Move implementation of setup_port API to serial8250_pci_setup_port
> 
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> Changes in v6:
> - Made this patch first patch of the patch series
> 
> Changes in v5:
> - This is the new patch added in v5 version of this patchset
> - Moved implementation of setup_port from 8250_pci.c to 8250_pcilib.c
> 
> ---

> diff --git a/drivers/tty/serial/8250/8250_pcilib.h b/drivers/tty/serial/8250/8250_pcilib.h
> new file mode 100644
> index 000000000000..41ef01d5c3c5
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_pcilib.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * 8250 PCI library header file.
> + *
> + * Copyright (C) 2001 Russell King, All Rights Reserved.
> + */

You shouldn't depend on .c file having things included for you. So 
please add these:

#include "8250.h"

struct pci_dev;

Other than that,
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


> +
> +int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port, u8 bar,
> +		   unsigned int offset, int regshift);


-- 
 i.

--8323329-1285920352-1669885620=:1757--
