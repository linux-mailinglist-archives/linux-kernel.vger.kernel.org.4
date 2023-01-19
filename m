Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B64674C16
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjATFXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjATFXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:23:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4207518D7;
        Thu, 19 Jan 2023 21:13:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9937BB82524;
        Thu, 19 Jan 2023 15:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E37C433EF;
        Thu, 19 Jan 2023 15:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674140665;
        bh=id1+Re7X1vZT7tf0fhU3RkTT29VB9Fy5VaB/3VxY2c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zGy0mfkQ4pC05tDv2oJBgoWZUkSAfQeXr4s6CreswKd7xfsDxUuWuBMf+YCtAr0Oo
         reUgUPh700pR39JJ1RzyzPRiugZfWArCsDMLUnZwcuecpt79uhSf/2sfWJS4fWy1Gy
         o0hsg7BapGLADsJMVSHNG/3MLiFz7QJC0miYaXKY=
Date:   Thu, 19 Jan 2023 16:04:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        macro@orcam.me.uk, andriy.shevchenko@linux.intel.com,
        cang1@live.co.uk, colin.i.king@gmail.com,
        phil.edworthy@renesas.com, biju.das.jz@bp.renesas.com,
        geert+renesas@glider.be, lukas@wunner.de,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v10 tty-next 0/4] serial: 8250_pci1xxxx: Add driver for
 the pci1xxxx's quad-uart function
Message-ID: <Y8lb9utGeeD02JJp@kroah.com>
References: <20221217191507.2359029-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217191507.2359029-1-kumaravel.thiagarajan@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 12:45:03AM +0530, Kumaravel Thiagarajan wrote:
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
> downstream ports. Quad-uart is one of the functions in the multi-function
> endpoint. This patch adds device driver for the quad-uart function and
> enumerates between 1 to 4 instances of uarts based on the PCIe subsystem
> device ID.
> 
> The changes from v1->v2->v3->v4->v5->v6->v7->v8->v9->v10 are mentioned in
> each patch in the patchset.
> 
> Thanks to Andy Shevchenko, Ilpo Jarvinen, Chritophe JAILLET, Geert
> Uytterhoeven, Greg KH, Jiri Slaby for their review comments.
> 
> Kumaravel Thiagarajan (4):
>   serial: 8250_pci: Add serial8250_pci_setup_port definition in
>     8250_pcilib.c
>   serial: 8250_pci1xxxx: Add driver for quad-uart support
>   serial: 8250_pci1xxxx: Add RS485 support to quad-uart driver
>   serial: 8250_pci1xxxx: Add power management functions to quad-uart
>     driver

This doesn't apply to my tree anymore.  Can you rebase it against
Linus's latest, or linux-next and resend?

thanks,

greg k-h
