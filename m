Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5BF622B1D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKIMHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKIMHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:07:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A1C2CDED;
        Wed,  9 Nov 2022 04:07:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 957F7B81E1F;
        Wed,  9 Nov 2022 12:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25BAC433C1;
        Wed,  9 Nov 2022 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667995632;
        bh=EcGvod2J7G0EVeowczE6d3P4Q6057Dkap40V5xBec00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zhKNOILCuudrEnFWLLop6f5k4YkSkLQ82UcZOVQ58SS6C4kIHy+JSor41RVjo7lHi
         152dPz1nRbJWOBqqjcmDGsf+TtU7tFs8OaSPtlFovWOJ8Vvrb6hBnUIyU5LkujaiH5
         TynH0AUHYF+1G+HNQeGX98y1RwieMqf6c1UFiIXg=
Date:   Wed, 9 Nov 2022 13:07:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@sifive.com,
        florent@enjoy-digital.fr
Subject: Re: [PATCH v1 1/3] serial: liteuart: cosmetic changes
Message-ID: <Y2uX7GJYOmaGvRR2@kroah.com>
References: <20221107171500.2537938-1-gsomlo@gmail.com>
 <20221107171500.2537938-2-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107171500.2537938-2-gsomlo@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 12:14:58PM -0500, Gabriel Somlo wrote:
> Make some cosmetic/stylistic (non-functional) improvements:
> 
> 1. Use a DRV_NAME macro to avoid hard-coding "liteuart" in multiple
> locations throughout the source file
> 
> 2. Use bit numbers instead of magic constants for event flags
> 
> 3. Remove stub uart_ops methods that are not called unconditionally
> from serial_core; Document stubs that are required by serial_core
> 
> 4. Don't set unused port->regshift and port->iobase fields gratuitously
> during probe()
> 
> 5. Improve coding style in liteuart_init()

When you list different things you do in a single patch, that means you
should break this up into individual patches.

Please do that here, this should be at least 5 patches.



> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 38 +++++++++--------------------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 4c0604325ee9..4b9cca249828 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -18,6 +18,8 @@
>  #include <linux/tty_flip.h>
>  #include <linux/xarray.h>
>  
> +#define DRV_NAME "liteuart"

Just use KBUILD_MODNAME please.

thanks,

greg k-h
