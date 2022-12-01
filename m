Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DBE63ECD8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiLAJro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiLAJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:47:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E757F95811;
        Thu,  1 Dec 2022 01:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669888042; x=1701424042;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5NYuN+BzXmQAr/s+n6tb6voFA7hyYqYwVUY14IxMTOA=;
  b=ND5afuaGstoP6Jmcrqw9bwcUec3IntI/mDb/FTB81EJYkSi2ZiiUyk1a
   AyBYxI8y5xLua471VvRqb2qczECcpp+vuaWOX/HsbWIjdhQSAWYnEPIOI
   POhC+zX42z/3XE0V9O2Ta1bJ8uFeuSmZjAaqn0MnbSjShdKAPa2K7L21J
   a/lYIgW+MHFgA2ACVOK4b46lP4Vucdru4zHERqj7jFj9A3SRgaivuaJDx
   hGdA0JOtuVI62dFvpW+ZbR1QbZfHWeXRggmICWQ4/zRifwoUpPZm1xzAq
   qHgerkx2ngL7owTMg6mK5m/Jg+0AVZ+NVdlq88vgSzyzLxWlBqf+BF8Nw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="313270696"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="313270696"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 01:47:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="750731939"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="750731939"
Received: from akoroglu-mobl.ger.corp.intel.com ([10.251.212.165])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 01:47:13 -0800
Date:   Thu, 1 Dec 2022 11:47:11 +0200 (EET)
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
Subject: Re: [PATCH v6 tty-next 3/4] serial: 8250_pci1xxxx: Add RS485 support
 to quad-uart driver
In-Reply-To: <20221201045146.1055913-4-kumaravel.thiagarajan@microchip.com>
Message-ID: <b9d2c851-7b16-b0a0-3475-c5ab17a563e@linux.intel.com>
References: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com> <20221201045146.1055913-4-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-265971391-1669888038=:1757"
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

--8323329-265971391-1669888038=:1757
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 1 Dec 2022, Kumaravel Thiagarajan wrote:

> pci1xxxx uart supports RS485 mode of operation in the hardware with
> auto-direction control with configurable delay for releasing RTS after
> the transmission. This patch adds support for the RS485 mode.
> 
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> Changes in v6:
> - Modified datatype of delay_in_baud_periods to u64 to avoid overflows
> 
> Changes in v5:
> - Removed unnecessary assignments
> - Corrected styling issues in comments
> 
> Changes in v4:
> - No Change
> 
> Changes in v3:
> - Remove flags sanitization in driver which is taken care in core
> 
> Changes in v2:
> - move pci1xxxx_rs485_config to a separate patch with
>   pci1xxxx_rs485_supported.
> ---
>  drivers/tty/serial/8250/8250_pci1xxxx.c | 49 +++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index d5037e76b636..7585066d6baf 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -145,6 +145,53 @@ static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
>  	       port->membase + UART_BAUD_CLK_DIVISOR_REG);
>  }
>  
> +static int pci1xxxx_rs485_config(struct uart_port *port,
> +				 struct ktermios *termios,
> +				 struct serial_rs485 *rs485)
> +{
> +	u32 clock_div = readl(port->membase + UART_BAUD_CLK_DIVISOR_REG);

Maybe move this into the block where it's needed?

> +	u64 delay_in_baud_periods;
> +	u32 baud_period_in_ns;
> +	u32 data = 0;

data seems a bit too generic name for a variable? At minimum I'd suggest 
using cfg or mode_cfg (I couldn't guess where ADCL comes from, perhaps it
has some component which would make the variable name better).

> +
> +	/*
> +	 * pci1xxxx's uart hardware supports only RTS delay after
> +	 * Tx and in units of bit times to a maximum of 15
> +	 */
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		data = ADCL_CFG_EN | ADCL_CFG_PIN_SEL;
> +
> +		if (!(rs485->flags & SER_RS485_RTS_ON_SEND))
> +			data |= ADCL_CFG_POL_SEL;
> +
> +		if (rs485->delay_rts_after_send) {
> +			baud_period_in_ns =
> +				FIELD_GET(BAUD_CLOCK_DIV_INT_MSK, clock_div) *
> +				UART_BIT_SAMPLE_CNT;
> +			delay_in_baud_periods =
> +				rs485->delay_rts_after_send * NSEC_PER_MSEC /
> +				baud_period_in_ns;
> +			delay_in_baud_periods =
> +				min_t(u64, delay_in_baud_periods,
> +				      FIELD_MAX(ADCL_CFG_RTS_DELAY_MASK));
> +			data |= FIELD_PREP(ADCL_CFG_RTS_DELAY_MASK,
> +					   delay_in_baud_periods);
> +			rs485->delay_rts_after_send =
> +				baud_period_in_ns * delay_in_baud_periods /
> +				NSEC_PER_MSEC;
> +		}
> +	}
> +	writel(data, port->membase + ADCL_CFG_REG);
> +	return 0;
> +}
> +
> +static const struct serial_rs485 pci1xxxx_rs485_supported = {
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
> +		 SER_RS485_RTS_AFTER_SEND,
> +	.delay_rts_after_send = 1,
> +	/* Delay RTS before send is not supported */
> +};
> +
>  static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
>  			  struct uart_8250_port *port, int port_idx)
>  {
> @@ -155,6 +202,8 @@ static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
>  	port->port.set_termios = serial8250_do_set_termios;
>  	port->port.get_divisor = pci1xxxx_get_divisor;
>  	port->port.set_divisor = pci1xxxx_set_divisor;
> +	port->port.rs485_config = pci1xxxx_rs485_config;
> +	port->port.rs485_supported = pci1xxxx_rs485_supported;
>  
>  	ret = serial8250_pci_setup_port(priv->pdev, port, 0, port_idx * 256, 0);
>  	if (ret < 0)
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-265971391-1669888038=:1757--
