Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036E56B52EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjCJVjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjCJVjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:39:08 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E2CEABB6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=n7LpUb4SbtnQ/1uvOiki2E3c5r7Yfb2jhJ053NwsPOQ=;
  b=qAB5mPKnFq8MmEkupkqXG/j1if7qzV9CA7vklZxHOll9CseqS4AClfSI
   AyA/DlDvuC69ii5DR4UD4J1fXIo6AaMHmWMOMaDiAh2mHslmjv6DjnAvY
   2gFvLIC2fxP1Sv/LYcltTAYnnEHck1zM3/PmY0tIQglU/oF/J3yOl7dCd
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,250,1673910000"; 
   d="scan'208";a="96598191"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 22:39:04 +0100
Date:   Fri, 10 Mar 2023 22:39:04 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Kloudifold <cloudifold.3125@gmail.com>
cc:     teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750: Rename camel case functions in
 sm750_cursor.*
In-Reply-To: <ZAuiDTDT8dmBcRoH@CloudiRingWorld>
Message-ID: <alpine.DEB.2.22.394.2303102236190.3199@hadrien>
References: <ZAuiDTDT8dmBcRoH@CloudiRingWorld>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You don't need the filename in the subject.

On Sat, 11 Mar 2023, Kloudifold wrote:

> This patch fixes the "CHECK: Avoid CamelCase" reported by
> checkpatch.pl by renaming camel case functions.
>
> Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_cursor.c | 14 +++++++-------
>  drivers/staging/sm750fb/sm750_cursor.h | 12 ++++++------
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
> index 43e6f52c2..ff643e33f 100644
> --- a/drivers/staging/sm750fb/sm750_cursor.c
> +++ b/drivers/staging/sm750fb/sm750_cursor.c
> @@ -58,13 +58,13 @@ void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
>  	poke32(HWC_ADDRESS, 0);
>  }
>
> -void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h)
> +void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h)
>  {
>  	cursor->w = w;
>  	cursor->h = h;
>  }
>
> -void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
> +void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y)
>  {
>  	u32 reg;
>
> @@ -73,7 +73,7 @@ void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
>  	poke32(HWC_LOCATION, reg);
>  }
>
> -void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
> +void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg)
>  {
>  	u32 reg = (fg << HWC_COLOR_12_2_RGB565_SHIFT) &
>  		HWC_COLOR_12_2_RGB565_MASK;
> @@ -82,8 +82,8 @@ void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
>  	poke32(HWC_COLOR_3, 0xffe0);
>  }
>
> -void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
> -			     const u8 *pcol, const u8 *pmsk)
> +void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
> +			      const u8 *pcol, const u8 *pmsk)

The indentation of the second line looks random.  It's not a multiple of
the tabs, and it doesn't line up with the right side of the (.  So there
doesn't seem to be any need to change it for this patch.

>  {
>  	int i, j, count, pitch, offset;
>  	u8 color, mask, opr;
> @@ -132,8 +132,8 @@ void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
>  	}
>  }
>
> -void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
> -			      const u8 *pcol, const u8 *pmsk)
> +void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
> +			       const u8 *pcol, const u8 *pmsk)

Likewise.

>  {
>  	int i, j, count, pitch, offset;
>  	u8 color, mask;
> diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
> index b59643dd6..88fa02f63 100644
> --- a/drivers/staging/sm750fb/sm750_cursor.h
> +++ b/drivers/staging/sm750fb/sm750_cursor.h
> @@ -5,11 +5,11 @@
>  /* hw_cursor_xxx works for voyager,718 and 750 */
>  void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
>  void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
> -void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h);
> -void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y);
> -void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
> -void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
> -			     const u8 *data, const u8 *mask);
> -void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
> +void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h);
> +void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
> +void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg);
> +void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
>  			      const u8 *data, const u8 *mask);
> +void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
> +			       const u8 *data, const u8 *mask);

Likewise.

julia

>  #endif
> --
> 2.39.2
>
>
>
