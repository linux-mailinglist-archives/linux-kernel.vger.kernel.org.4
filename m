Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF781710BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbjEYMRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjEYMRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:17:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5B1A9;
        Thu, 25 May 2023 05:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685017029; x=1716553029;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bQ1iL6BsiW9BxzNcM756bUoMHD0bKrBZjPW4yVwoXCU=;
  b=dgFfOhPQlNaO5yv7W8H9G0lYcOqEgFOV8SIrUHAWz+dqGQtX+WKYGzsf
   4dydSYz+lEVipxpesrTk43+OLNZPTnYl76sqLSyV8Vjev/I4kRTor0prq
   Wc2ZSYtN/4lXZBVEWFeKui0RdPaOXYVIBexpK3WuO7kPI6dY+ZEO9Q21Y
   CEX+Ailz1yv2zjS6+wNIfYU819vGHqc+zjI5NIAQr7YKoHSasO5coonVS
   c7Y2uEUkmVEuAhjOUkK82OfH6WIvE9UaNpJ5RDfJ45A+YDwp8jAB9ymFe
   MIL6oBQB7l0X4vIjDkHxivjf9ZCWc01E5bM4jy9mV8I3uUTLoTD6MYXp0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="357096183"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="357096183"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 05:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="1034963147"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="1034963147"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.249.40.17])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 05:17:04 -0700
Date:   Thu, 25 May 2023 15:17:02 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        jringle@gridpoint.com, tomasz.mon@camlingroup.com,
        l.perczak@camlintechnologies.com,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 10/11] serial: sc16is7xx: add call to get rs485 DT
 flags and properties
In-Reply-To: <20230525040324.3773741-11-hugo@hugovil.com>
Message-ID: <986e2042-6c1d-b87a-ef9-d89a61bc8c@linux.intel.com>
References: <20230525040324.3773741-1-hugo@hugovil.com> <20230525040324.3773741-11-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2137940837-1685017028=:1738"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2137940837-1685017028=:1738
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 25 May 2023, Hugo Villeneuve wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add call to uart_get_rs485_mode() to probe for RS485 flags and
> properties from device tree.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index c2cfd057ed9a..03d00b144304 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1511,6 +1511,10 @@ static int sc16is7xx_probe(struct device *dev,
>  			goto out_ports;
>  		}
>  
> +		ret = uart_get_rs485_mode(&s->p[i].port);
> +		if (ret)
> +			goto out_ports;
> +
>  		/* Disable all interrupts */
>  		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_IER_REG, 0);
>  		/* Disable TX/RX */
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2137940837-1685017028=:1738--
