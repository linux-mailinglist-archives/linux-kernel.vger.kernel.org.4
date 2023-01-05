Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BE965E714
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjAEIvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjAEIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:51:19 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4CCC4D;
        Thu,  5 Jan 2023 00:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672908678; x=1704444678;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=MdpIx0ME+Xfwg6tq/OLwhK9h6Pxxj28cKiqlNMlnOkE=;
  b=NRba8lE6qjElCAhAfyd/l7wt1ZqsX7HXEKd87qcQMwbkZVjmPtrBzf0a
   hlyhHwcmbZw2ncJdTUDmKF4OFHVs12Vp/YmOlSsHFWHzEfo3PEB1Eh3y7
   13QG2HFyHA/O9x3sfXp4T0qb2b9JraZi0nXeHcOTx7TwN8BXNH2oO7z/v
   c5KyTY5jqDQ1Jt9msM8K0kgMpQNlwUBuOtsOuHpd+rWm1k8zzh2h04lmz
   P17q6WBT8GD7/oDZWNiD0ez1mI/hdZeTO38lsbabvoB2rcAAZgX9VdGww
   tsxay9DN+6hASWEcdVBt8zCS9coCol3XhiCjAP//Womwz8cd1tzoWYq9s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="319860922"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="319860922"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 00:51:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="655496263"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="655496263"
Received: from khaunx-mobl1.ger.corp.intel.com ([10.252.35.181])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 00:51:12 -0800
Date:   Thu, 5 Jan 2023 10:51:10 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oliver Neukum <oneukum@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 07/10] tty: Convert ->dtr_rts() to take bool argument
In-Reply-To: <09043f30-c516-e173-3836-5e5dd5f5c472@kernel.org>
Message-ID: <2cb9b67e-9bb-4fb2-e974-17050457d3@linux.intel.com>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com> <20230104151531.73994-8-ilpo.jarvinen@linux.intel.com> <09043f30-c516-e173-3836-5e5dd5f5c472@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1066211675-1672908637=:1832"
Content-ID: <4fbbebce-aab4-fa64-6a79-6d25c81fe3c@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1066211675-1672908637=:1832
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <207e8c25-d560-4d87-27a8-5f9cb52ce14@linux.intel.com>

On Thu, 5 Jan 2023, Jiri Slaby wrote:

> On 04. 01. 23, 16:15, Ilpo Järvinen wrote:
> > Convert the raise/on parameter in ->dtr_rts() to bool through the
> > callchain. The parameter is used like bool. In USB serial, there
> > remains a few implicit bool -> larger type conversions because some
> > devices use u8 in their control messages.
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> ...
> > --- a/drivers/char/pcmcia/synclink_cs.c
> > +++ b/drivers/char/pcmcia/synclink_cs.c
> > @@ -378,7 +378,7 @@ static void async_mode(MGSLPC_INFO *info);
> >   static void tx_timeout(struct timer_list *t);
> >     static bool carrier_raised(struct tty_port *port);
> > -static void dtr_rts(struct tty_port *port, int onoff);
> > +static void dtr_rts(struct tty_port *port, bool onoff);
> 
> Not anything for this patch, but having this dubbed "onoff" instead of "on"
> makes it really confusing.
> 
> > --- a/drivers/mmc/core/sdio_uart.c
> > +++ b/drivers/mmc/core/sdio_uart.c
> > @@ -548,14 +548,14 @@ static bool uart_carrier_raised(struct tty_port
> > *tport)
> >    *	adjusted during an open, close and hangup.
> >    */
> >   -static void uart_dtr_rts(struct tty_port *tport, int onoff)
> > +static void uart_dtr_rts(struct tty_port *tport, bool onoff)
> >   {
> >   	struct sdio_uart_port *port =
> >   			container_of(tport, struct sdio_uart_port, port);
> >   	int ret = sdio_uart_claim_func(port);
> >   	if (ret)
> >   		return;
> > -	if (onoff == 0)
> > +	if (!onoff)
> >   		sdio_uart_clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
> >   	else
> >   		sdio_uart_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
> 
> Especially here. What does "!onoff" mean? If it were:
> 
> if (on)
>   sdio_uart_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
> else
>   sdio_uart_clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
> 
> it would be a lot more clear.
> 
> > --- a/drivers/tty/amiserial.c
> > +++ b/drivers/tty/amiserial.c
> > @@ -1459,7 +1459,7 @@ static bool amiga_carrier_raised(struct tty_port
> > *port)
> >   	return !(ciab.pra & SER_DCD);
> >   }
> >   -static void amiga_dtr_rts(struct tty_port *port, int raise)
> > +static void amiga_dtr_rts(struct tty_port *port, bool raise)
> 
> Or "raise". That makes sense too and we call it as such in
> tty_port_operations:
> 
> > --- a/include/linux/tty_port.h
> > +++ b/include/linux/tty_port.h
> ...
> > @@ -32,7 +32,7 @@ struct tty_struct;
> >    */
> >   struct tty_port_operations {
> >   	bool (*carrier_raised)(struct tty_port *port);
> > -	void (*dtr_rts)(struct tty_port *port, int raise);
> > +	void (*dtr_rts)(struct tty_port *port, bool raise);
> >   	void (*shutdown)(struct tty_port *port);
> >   	int (*activate)(struct tty_port *port, struct tty_struct *tty);
> >   	void (*destruct)(struct tty_port *port);
> 
> Care to fix that up too?

Sure. I noticed they were inconsistent but it didn't feel like changing 
the name "while at it" would be good as this is long already. I think I'll 
make another patch out of the name changes.

-- 
 i.
--8323329-1066211675-1672908637=:1832--
