Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD9867873A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjAWUHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjAWUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:06:58 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9F55270;
        Mon, 23 Jan 2023 12:06:48 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id x7so10980812qtv.13;
        Mon, 23 Jan 2023 12:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TSakBrNxghirXLfLJZH6VvdIGUAJ1Ds+wOxPUUvA+Y=;
        b=EEBqgKN2oUh3EYEH+6SEwk2FtiHESLX1RrrTvfWFVCY1qbL3trl6J9MO7xhnaMGCcc
         sPNjRdYK34UCF7+xAdezBuLE3kilKrKQvqor/YYmqF+Uwi1t3AU0Ora8+liiG/X2cH2L
         uMgmt0rIKSXv7gjUqX8yS6vbY2qhgZFhVAi0SFrQ6rq3J6TrmqKZpMvCwimrtYqklDLe
         JCQTuSxE4hZvykQCdimy0jAWiSQWB2SRqREEehnBv7AmUJqtnG6jY8KBOuJzs26RgVOt
         WFPmxZRv+bDzsa/VUbADoL0gRtfcjPRlR4ZScmRjDABnNgBjmLwxwoGPohugo7wDKWOV
         BGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TSakBrNxghirXLfLJZH6VvdIGUAJ1Ds+wOxPUUvA+Y=;
        b=ZCb5rpT8SAR81Fk0Uz9lod6C2E7sbzF1W4DtOSsOuDflPu2zonU2PawpMxfQHf5trJ
         T5rraHogx/VlrrAylwPfcmuVU9NFK1yGBREhKWxQ+ccQUQqm7zYRKm2PQFkymyYflqyo
         tgAZOTdc/iOCV46nZU/zLnlDuISP3g7tl/3WjqufbM5YQX5zwAvf0qiA/pP2hMma697W
         4Dp1eCKQRjzgxtvhqfntPiydsypYSh39YJgvA9JWOH0XD1bgeQbH2OFpCyHfWnbzV0lB
         qneMfFJAeCY+5qynbR1pbQW53tu3aQoLnhOhxzDRDwe2NRTEfWjAOybz81MGFE1A3vjh
         Mr8Q==
X-Gm-Message-State: AFqh2kow2o94ltFZH7mn9b2Jxl/1h0xF4lVXWIdw8Dft16B2dKIUNKWX
        uMn3kAttTjPUqALa1c2j4M8=
X-Google-Smtp-Source: AMrXdXtaxVV4afC/qjhg8s+YOdgYHD6KctqdBiUSdcl6Iv41L78W4z9tJVuna8ts11e0n4WF/PHewA==
X-Received: by 2002:ac8:718d:0:b0:3b0:11a1:3140 with SMTP id w13-20020ac8718d000000b003b011a13140mr33941440qto.43.1674504407207;
        Mon, 23 Jan 2023 12:06:47 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id cg5-20020a05622a408500b003b6382f66b1sm11163331qtb.29.2023.01.23.12.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:06:46 -0800 (PST)
Date:   Mon, 23 Jan 2023 15:06:44 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v1 1/1] serial: liteuart: Remove a copy of UART id in
 private structure
Message-ID: <Y87o1Mk8eHoPG1zA@errol.ini.cmu.edu>
References: <20230123192604.81452-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123192604.81452-1-andriy.shevchenko@linux.intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:26:04PM +0200, Andy Shevchenko wrote:
> The struct liteuart_port keeps tracking of UART ID which is also
> saved in the struct uart_port as line member. Drop the former one
> and use the latter everywhere.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Depends on
> https://lore.kernel.org/linux-serial/20230123191741.79751-1-andriy.shevchenko@linux.intel.com/
> 
>  drivers/tty/serial/liteuart.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 562892395570..80de3a42b67b 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -46,7 +46,6 @@
>  struct liteuart_port {
>  	struct uart_port port;
>  	struct timer_list timer;
> -	u32 id;
>  	u8 irq_reg;
>  };
>  
> @@ -314,7 +313,6 @@ static int liteuart_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	uart->id = dev_id;
>  	/* values not from device tree */
>  	port->dev = &pdev->dev;
>  	port->iotype = UPIO_MEM;
> @@ -334,7 +332,7 @@ static int liteuart_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_erase_id:
> -	xa_erase(&liteuart_array, uart->id);
> +	xa_erase(&liteuart_array, dev_id);
>  
>  	return ret;
>  }
> @@ -342,10 +340,10 @@ static int liteuart_probe(struct platform_device *pdev)
>  static int liteuart_remove(struct platform_device *pdev)
>  {
>  	struct uart_port *port = platform_get_drvdata(pdev);
> -	struct liteuart_port *uart = to_liteuart_port(port);
> +	unsigned int line = port->line;
>  
>  	uart_remove_one_port(&liteuart_driver, port);
> -	xa_erase(&liteuart_array, uart->id);
> +	xa_erase(&liteuart_array, line);
>  
>  	return 0;
>  }

Nice, thanks!

Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>

> -- 
> 2.39.0
> 
