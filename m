Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2377103ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbjEYEOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbjEYENu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:13:50 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E3E19BF;
        Wed, 24 May 2023 21:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+SDsDM67S7jI6MDcb4/zJ0Dy2DliXC9rdUryB69scS4=; b=uZmtjvL9a2E/46iakQOaoBqZwi
        P0eRe7JxmuY23Y5ZaAMMzz9qItS4vtc8roJXwDyJW4hFxYq1K7N63UdzspK2PxVmv/NSxmsjxWXoU
        Vlac2E/BZQtEW1e92g0wozHcSQ92xu/BNEnqXZ93YLqZYaROZAMmLLnsNWobl3UcuSqo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:37602 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q22HQ-0001lN-JB; Thu, 25 May 2023 00:08:49 -0400
Date:   Thu, 25 May 2023 00:08:48 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20230525000848.6669e1cff93082144a5a8397@hugovil.com>
In-Reply-To: <20230517141348.3792842-1-hugo@hugovil.com>
References: <20230517141348.3792842-1-hugo@hugovil.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH] serial: sc16is7xx: improve comments about variants
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 10:13:49 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Replace 740/750/760 with generic terms like 74x/75x/76x to account for
> variants like 741, 752 and 762.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 5bd98e4316f5..00054bb49780 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -223,7 +223,7 @@
>   * trigger levels. Trigger levels from 4 characters to 60 characters are
>   * available with a granularity of four.
>   *
> - * When the trigger level setting in TLR is zero, the SC16IS740/750/760 uses the
> + * When the trigger level setting in TLR is zero, the SC16IS74x/75x/76x uses the
>   * trigger level setting defined in FCR. If TLR has non-zero trigger level value
>   * the trigger level defined in FCR is discarded. This applies to both transmit
>   * FIFO and receive FIFO trigger level setting.
> @@ -234,7 +234,7 @@
>  #define SC16IS7XX_TLR_TX_TRIGGER(words)	((((words) / 4) & 0x0f) << 0)
>  #define SC16IS7XX_TLR_RX_TRIGGER(words)	((((words) / 4) & 0x0f) << 4)
>  
> -/* IOControl register bits (Only 750/760) */
> +/* IOControl register bits (Only 75x/76x) */
>  #define SC16IS7XX_IOCONTROL_LATCH_BIT	(1 << 0) /* Enable input latching */
>  #define SC16IS7XX_IOCONTROL_MODEM_BIT	(1 << 1) /* Enable GPIO[7:4] as modem pins */
>  #define SC16IS7XX_IOCONTROL_SRESET_BIT	(1 << 3) /* Software Reset */
> @@ -248,9 +248,9 @@
>  #define SC16IS7XX_EFCR_RTS_INVERT_BIT	(1 << 5) /* RTS output inversion */
>  #define SC16IS7XX_EFCR_IRDA_MODE_BIT	(1 << 7) /* IrDA mode
>  						  * 0 = rate upto 115.2 kbit/s
> -						  *   - Only 750/760
> +						  *   - Only 75x/76x
>  						  * 1 = rate upto 1.152 Mbit/s
> -						  *   - Only 760
> +						  *   - Only 76x
>  						  */
>  
>  /* EFR register bits */
> -- 
> 2.30.2

This patch is now integrated in the following series:
https://lkml.org/lkml/2023/5/25/7
 
