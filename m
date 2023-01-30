Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D1C68058D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjA3FVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjA3FVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:21:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FC423C61;
        Sun, 29 Jan 2023 21:21:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AADD560C77;
        Mon, 30 Jan 2023 05:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A33C433D2;
        Mon, 30 Jan 2023 05:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675056089;
        bh=FbiJ6RL+WQXmFZ01J8Am5NvuTrx0i7k5QLYkMzYhrPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nof9ZExQOENHxZgbH0ZXmtKVzO3WQmTHXcAIB3SLwZznjXh1wQSCQkysA9iiQ9DrU
         Q4fMbtr/5EWR9EJU8CTOZ1UGJYI9s6C6W/4l81lifs3SfpxPJnldqsz9ZxcX/GRnCU
         cvJWAq7R0R/Mu3EA+adMppZ15IJqpkm5wg+gdtvA=
Date:   Mon, 30 Jan 2023 06:21:25 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: don't enable
 receiver/transmitter before rx/tx dma ready
Message-ID: <Y9dT1fLxl/5n8wjZ@kroah.com>
References: <20221128050208.28086-1-sherry.sun@nxp.com>
 <AS8PR04MB8404F38D6586B532A80A0FA592D39@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8404F38D6586B532A80A0FA592D39@AS8PR04MB8404.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 03:02:21AM +0000, Sherry Sun wrote:
> Gentle ping...

This is not in my queue anywhere, sorry, it must have fallen off.  Can
you please resend?

thanks,

greg k-h
