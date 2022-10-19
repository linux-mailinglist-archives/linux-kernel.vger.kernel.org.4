Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E739C604AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiJSPIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiJSPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:08:08 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2883B94A;
        Wed, 19 Oct 2022 08:00:04 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id s3so11803230qtn.12;
        Wed, 19 Oct 2022 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cdn1en3TCL697wD1YaDBcq9FxSMHwz0hFmIkA7fa/ok=;
        b=RDgWmV3rs9DT8G5fm/e9+KmXGAXq3ODB053Ojsc8i2vNeP54Ocoy1LQoRsly0Q/lLV
         /wdK/UYar+cupAV7w7HMVGPpf4BZJAQ3ZFV0Lh2NtsZumli6rKlo/gYTXdd4XqwCbNWA
         dQRmL89p/5VAplc0sBQ4khbBUTsiMCDrquYIj7vfQ1kQpHm5xWgMSxNzL6PKD0xECsm0
         hXbVe3zi1Yui3vjH/j9jUtpv9rBHNRVDk65v1CdFCNiH18fyaUcy7DqktAXSGVL2dbrS
         Nf+Okkyn3Hqg1XU2PxMR4SXzcc2W5F+xFugK3GDOJZ3Kq/c01/eI/GT7UsVL45UJ9EXq
         kuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cdn1en3TCL697wD1YaDBcq9FxSMHwz0hFmIkA7fa/ok=;
        b=ztvfrAa5lrpl1aym5teUNJ+nEdcAr8O24u6WToRRGGumnVIAw0Lzo+X2mdfZmYTXUu
         lmG1M5NPz7Cy2JDWt+Y8/F/GnoQzMrABvopkCN8vrS03CbNYBT4TpDm1KMn6gjT4FUHF
         lw2aIFQa7Pni/z3bmgcSzEQKJOWJk71jCN70PNDcL0cVqTbg9eGHyqeIsF1Ic5fdKjpo
         Y3EvPfWbL87Cckbsq5GH6LfrnlQ9mZXeL7nw5j0LK8tFdwILmxhsHrRLcjviBe8wbwTa
         669Pk8+/davOYlgD9XMowxBpjeJJuL4o51GbR99S1YUIz5Zo/IuLn59czg6fyuOJxpTl
         wDlA==
X-Gm-Message-State: ACrzQf2/8cn5ec4wwFJiBmoTrjw5F96479//P/vBrZZdchZTBGTvp2Fc
        ylITUSLp0Lacuebx7Xf43K0=
X-Google-Smtp-Source: AMsMyM7b7RKtw6fYMcmP3GJf8fJkEJDD8E+4RaxLnqAleHS83boBJkoUTEnja4ZGTYnD7XNSrAtrxA==
X-Received: by 2002:ac8:5981:0:b0:39c:e03e:86ed with SMTP id e1-20020ac85981000000b0039ce03e86edmr6886233qte.503.1666191593368;
        Wed, 19 Oct 2022 07:59:53 -0700 (PDT)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id x27-20020a05620a0b5b00b006ecdfcf9d81sm4920276qkg.84.2022.10.19.07.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:59:52 -0700 (PDT)
Date:   Wed, 19 Oct 2022 10:59:45 -0400
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 19/44] serial: liteuart: Use uart_xmit_advance()
Message-ID: <Y1AQ4S6csWiVGS0f@glsvmlin.ini.cmu.edu>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-20-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019091151.6692-20-ilpo.jarvinen@linux.intel.com>
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

On Wed, Oct 19, 2022 at 12:11:26PM +0300, Ilpo Järvinen wrote:
> Take advantage of the new uart_xmit_advance() helper.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/liteuart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 4c0604325ee9..062812fe1b09 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -136,8 +136,7 @@ static void liteuart_start_tx(struct uart_port *port)
>  	} else if (!uart_circ_empty(xmit)) {
>  		while (xmit->head != xmit->tail) {
>  			ch = xmit->buf[xmit->tail];
> -			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -			port->icount.tx++;
> +			uart_xmit_advance(port, 1);

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--Gabriel

>  			liteuart_putchar(port, ch);
>  		}
>  	}
> -- 
> 2.30.2
> 
