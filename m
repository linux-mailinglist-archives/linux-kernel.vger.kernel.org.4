Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A917D6777D0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjAWJvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjAWJvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:51:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5D722007;
        Mon, 23 Jan 2023 01:51:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1BF160E01;
        Mon, 23 Jan 2023 09:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19F0C433EF;
        Mon, 23 Jan 2023 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674467488;
        bh=I1TFqfaAYrE67AWuhwWFFkrdbPVOTogsIu0uGhqZTMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUjTYbl3HSo04F7350eYhPO++nuP3ClQEi4/mYv1LTVeS1HcAahmC6f3QiKxhUSK0
         cLhlfWr9Tgcf8Fn8o9sDFM23S4fteDSwKEB7WdAOV2uJCMLLeH4TuKVCzlUPB6zwq+
         mmhUIZWAHUv1EUx8mlzjIDzcy0s4w25PHrPB6w+0=
Date:   Mon, 23 Jan 2023 10:51:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Li Chen <me@linux.beauty>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH 10/15] serial: ambarella: add support for Ambarella
 uart_port
Message-ID: <Y85YncUCtRyVnpvt@kroah.com>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-11-lchen@ambarella.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123073305.149940-11-lchen@ambarella.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 03:32:25PM +0800, Li Chen wrote:
> This driver add support for Ambarella's uart, which
> can be used for console and etc.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> Change-Id: Ie68af7ad2187e21853e58d52cd97fd7145303730
> ---
>  MAINTAINERS                         |    1 +
>  drivers/tty/serial/Kconfig          |   16 +
>  drivers/tty/serial/Makefile         |    1 +
>  drivers/tty/serial/ambarella_uart.c | 1581 +++++++++++++++++++++++++++
>  drivers/tty/serial/ambarella_uart.h |  120 ++

Why do you need a .h file for a single .c file?  They should all be in
one file please.

Also, no change-id, you know this...

thanks,

greg k-h
