Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25C65EC1D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiI0Lsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiI0LsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:48:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61740151007;
        Tue, 27 Sep 2022 04:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664279292; x=1695815292;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fM3Yu7/yrQUbiGGpZnte266XhPsFG/ADys9QBPFheYI=;
  b=QYuDQdQVxtIQd9zIV1A99FDRFbhVha8PN+Z6K8opJOlsbdQnalgn7Gf6
   sMe4uqJGctVxtmC9nj5+i1AdCcW/fvkSqYsUeXA86k4LVbC1eiY7x0jEE
   sPPGZxkQT8iHmDYfxxgNUdMdHSYrPdFBe/QaN9oC5IUSVBJxejnavpVfX
   oZu84nUFd863PfoqATK5GZHBU7meAhWB6xupuIMwtelhtcJQk/8ORIFGg
   4FiZezV6bMtZjRRZJIFXkMO57VVoB2kIA2avtpxrSVbwxAwkEUX7Khnp0
   h4FWH5oILn3uliD/oKf/7C1x4ZQer2gCNm10AmvtVY3vY7NzqlY0Etgg8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="281663940"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="281663940"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 04:48:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="710531293"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="710531293"
Received: from aksaxena-mobl2.ger.corp.intel.com ([10.252.60.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 04:48:07 -0700
Date:   Tue, 27 Sep 2022 14:48:06 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] tty: serial: use FIELD_GET() in lqasc_tx_ready()
In-Reply-To: <20220927111819.18516-2-jslaby@suse.cz>
Message-ID: <773a8f87-c938-a956-ec16-94c9c34c92de@linux.intel.com>
References: <20220927111819.18516-1-jslaby@suse.cz> <20220927111819.18516-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-750726696-1664279289=:2334"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-750726696-1664279289=:2334
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 27 Sep 2022, Jiri Slaby wrote:

> FIELD_GET() can do the job smarter and more readable. We don't even need
> ASCFSTAT_TXFREEOFF. So switch to the former and remove the latter.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> ---
>  drivers/tty/serial/lantiq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index ba9739af30ed..c892f3c7d1ab 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -8,6 +8,7 @@
>   * Copyright (C) 2010 Thomas Langer, <thomas.langer@lantiq.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/console.h>
>  #include <linux/device.h>
> @@ -93,7 +94,6 @@
>  #define ASCFSTAT_RXFFLMASK	0x003F
>  #define ASCFSTAT_TXFFLMASK	0x3F00
>  #define ASCFSTAT_TXFREEMASK	0x3F000000
> -#define ASCFSTAT_TXFREEOFF	24
>  
>  static void lqasc_tx_chars(struct uart_port *port);
>  static struct ltq_uart_port *lqasc_port[MAXPORTS];
> @@ -143,7 +143,7 @@ static bool lqasc_tx_ready(struct uart_port *port)
>  {
>  	u32 fstat = __raw_readl(port->membase + LTQ_ASC_FSTAT);
>  
> -	return (fstat & ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;
> +	return FIELD_GET(ASCFSTAT_TXFREEMASK, fstat);
>  }
>  
>  static void
> 

--8323329-750726696-1664279289=:2334--
