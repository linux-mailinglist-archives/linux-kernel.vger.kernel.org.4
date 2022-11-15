Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25C3629DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiKOPhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKOPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:37:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C9A1135;
        Tue, 15 Nov 2022 07:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668526648; x=1700062648;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QQLyJI4VfQejyW/sYeJBUJDP5XIRKK9OrKTVrzJrIYQ=;
  b=Wsg2pOFen0kGVHsCYG+pufOCWcCEODRUQwNSqXFrMgtgUltRvgRmrS6D
   LZsHxc/N+qJtGULnSXrQjDMJEMWtmNJfE8HldqfeuLIthsG1slArlNVqq
   SbpyJZXK8nVpMj7hJFgG92ZGnMP2uLaGQAy6Q+P/C3wGzUfGv0AT4ImW6
   HzLaQ/Iu5/fTTeI2TY0GY+wnLCM3RLRKq4DREhDl0ZkSwXGdANz1rVdOf
   ZYFCJTbMluZREcoigsrRLKbPb/cpdWt8n/NcWGYVksiEOMcXH7g0j5Ey7
   jNP5/mHOEjwOawPskQsPr2FK9pdS7zmYWa7GDDZQqSd0zlr3aIKTGmpYw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313429239"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="313429239"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:37:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="883998050"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="883998050"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 07:37:24 -0800
Date:   Tue, 15 Nov 2022 17:37:22 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 03/14] serial: liteuart: remove unused uart_ops
 stubs
In-Reply-To: <20221112212125.448824-4-gsomlo@gmail.com>
Message-ID: <db1a5445-b22e-bcf2-e323-8f36392b9340@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-4-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-967172777-1668526648=:2268"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-967172777-1668526648=:2268
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 12 Nov 2022, Gabriel Somlo wrote:

> Remove stub uart_ops methods that are not called unconditionally
> from serial_core. Document stubs that are expected to be present.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 1497d4cdc221..90f6280c5452 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -122,6 +122,7 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
>  
>  static void liteuart_stop_tx(struct uart_port *port)
>  {
> +	/* not used in LiteUART, but called unconditionally from serial_core */
>  }
>  
>  static void liteuart_start_tx(struct uart_port *port)
> @@ -154,11 +155,6 @@ static void liteuart_stop_rx(struct uart_port *port)
>  	del_timer(&uart->timer);
>  }
>  
> -static void liteuart_break_ctl(struct uart_port *port, int break_state)
> -{
> -	/* LiteUART doesn't support sending break signal */
> -}
> -
>  static int liteuart_startup(struct uart_port *port)
>  {
>  	struct liteuart_port *uart = to_liteuart_port(port);
> @@ -197,15 +193,6 @@ static const char *liteuart_type(struct uart_port *port)
>  	return "liteuart";
>  }
>  
> -static void liteuart_release_port(struct uart_port *port)
> -{
> -}
> -
> -static int liteuart_request_port(struct uart_port *port)
> -{
> -	return 0;
> -}
> -
>  static void liteuart_config_port(struct uart_port *port, int flags)
>  {
>  	/*
> @@ -232,13 +219,10 @@ static const struct uart_ops liteuart_ops = {
>  	.stop_tx	= liteuart_stop_tx,
>  	.start_tx	= liteuart_start_tx,
>  	.stop_rx	= liteuart_stop_rx,
> -	.break_ctl	= liteuart_break_ctl,
>  	.startup	= liteuart_startup,
>  	.shutdown	= liteuart_shutdown,
>  	.set_termios	= liteuart_set_termios,
>  	.type		= liteuart_type,
> -	.release_port	= liteuart_release_port,
> -	.request_port	= liteuart_request_port,
>  	.config_port	= liteuart_config_port,
>  	.verify_port	= liteuart_verify_port,
>  };
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-967172777-1668526648=:2268--
