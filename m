Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932BB61D8B4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 09:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKEIWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKEIWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 04:22:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012E52D1F7;
        Sat,  5 Nov 2022 01:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A56D4B8163F;
        Sat,  5 Nov 2022 08:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98FEC433D6;
        Sat,  5 Nov 2022 08:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667636529;
        bh=SMC1dL1Js2wRKiy0XoIJ+GtllHqHaiTFR8/cOi/1+rU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qN1OE9OKweftndn3J9Q+GHm8Kf/4fkYBA9eMys+iVdCOcBzb1vLozmHoT04Xo+Mf+
         TARYxkucJPr8SPi1Ug5LqbbY1QCKklIUSTrNislvKgYsyiZ3eMMxBFJ8MubfBtaJQZ
         zZiqTQRC2X5vGbRjIr1kecIp8yWnp5spGkg5awB0=
Date:   Sat, 5 Nov 2022 09:22:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/3] USB: core: export usb_cache_string()
Message-ID: <Y2YdLkJKOE0ddiJa@kroah.com>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-2-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104171604.24052-2-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 02:16:02AM +0900, Vincent Mailhol wrote:
> usb_cache_string() can also be useful for the drivers so export it.
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/usb/core/message.c | 1 +
>  drivers/usb/core/usb.h     | 1 -
>  include/linux/usb.h        | 1 +
>  3 files changed, 2 insertions(+), 1 deletion(-)

No, sorry, NAK on this, see my comments on patch 2/3.

thanks,

greg k-h
