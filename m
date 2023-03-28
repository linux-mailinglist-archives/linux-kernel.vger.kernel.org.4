Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2326CC9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjC1SXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC1SXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:23:50 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7590E1736
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1680027808; bh=Zhkb52UN4pGmOgfIInyrCcAMDrh46P0XG+aPDtokb5Q=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=hk0/8TUt4RGEGszjChE1b9tACwVvqxkdd36F4bUKVl1koivoH7ZAAyIjf0OBusLbg
         3nvR/roBtlqWE5lfoJTUyQdemwqNEEeyN5TK4qkuAlSisTQXvT5HNNb5AusyWdVVPR
         IUifgGmd/az6/ehDslyyM2ssFNRM4KpC2Jcim9O0=
Received: by b221-6.in.mailobj.net [192.168.90.26] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Tue, 28 Mar 2023 20:23:28 +0200 (CEST)
X-EA-Auth: vSezUHgXhoJQdfC2bzp9VLgj31jApqprS7Ch5L3kM4I+hH1Tg7vk9I1bi02/R+4ieIExgTRHteZIq4j9f9YMsNOxiVV5kKZV
Date:   Tue, 28 Mar 2023 23:53:22 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Kloudifold <cloudifold.3125@gmail.com>
Cc:     outreachy@lists.linux.dev, teddy.wang@siliconmotion.com,
        sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        alison.schofield@intel.com
Subject: Re: [PATCH v5] staging: sm750: Rename sm750_hw_cursor_* functions to
 snake_case
Message-ID: <ZCMwmpEoe4qCuxMz@ubun2204.myguest.virtualbox.org>
References: <ZCLMAJ5APrFRMCWu@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCLMAJ5APrFRMCWu@CloudiRingWorld>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 07:16:54PM +0800, Kloudifold wrote:

Hi Kloudifold,

> sm750 driver has sm750_hw_cursor_* functions, which are named in

As mentioned earlier, the driver name "sm750" is not required here. You can
simply start the line with "The driver ...".

> camelcase. Rename them to snake case to follow the function naming
> convention.
> 
> - sm750_hw_cursor_setSize  => sm750_hw_cursor_set_size
> - sm750_hw_cursor_setPos   => sm750_hw_cursor_set_pos
> - sm750_hw_cursor_setColor => sm750_hw_cursor_set_color
> - sm750_hw_cursor_setData  => sm750_hw_cursor_set_data
> - sm750_hw_cursor_setData2 => sm750_hw_cursor_set_data2
> 
> Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
> 
> ---
> Changes in v5:
> - Include missed recipients in v4, no functional change to the code

I still do not see the full maintainer list on this patch. If I do the
following:
	$ perl scripts/get_maintainer.pl --separator , --nokeywords --nogit --nogit-fallback --norolestats drivers/staging/sm750fb/sm750.c

I get the following list:
Sudip Mukherjee <sudipm.mukherjee@gmail.com>,Teddy Wang <teddy.wang@siliconmotion.com>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-fbdev@vger.kernel.org,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org

You are still missing these mailing list in your to list: linux-fbdev@vger.kernel.org,devel@driverdev.osuosl.org

Are you doing anything different to get the maintainer list? What?

Thank you,
Deepak.

> 
> Changes in v4:
> - Update the commit msg (Deepak)
> - Use tabs replace 8 spaces
> 
> This v4 patch was prompted by 2 errors, 2 warnings and 1 checks reported
> by the scripts/checkpatch.pl, which detected the style problem.
> 
> Changes in v3:
> - Add this changelog (Philipp)
> - Move lkp tags and link to the correct location in commit log (Alison)
> - Update the commit msg (Philip)
> - Update the commit log (Bagas, Julia)
> 
> Changes in v2:
> - Use new function names in call sites (LKP)
> 
> This v2 patch was prompted by an error reported by the Linux test
> robot, which detected the compile error.
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
> ---
>  drivers/staging/sm750fb/sm750.c        | 22 +++++++++++-----------
>  drivers/staging/sm750fb/sm750_cursor.c | 14 +++++++-------
>  drivers/staging/sm750fb/sm750_cursor.h | 12 ++++++------
>  3 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index effc7fcc3..5d7249e82 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -121,14 +121,14 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  
>  	sm750_hw_cursor_disable(cursor);
>  	if (fbcursor->set & FB_CUR_SETSIZE)
> -		sm750_hw_cursor_setSize(cursor,
> -					fbcursor->image.width,
> -					fbcursor->image.height);
> +		sm750_hw_cursor_set_size(cursor,
> +					 fbcursor->image.width,
> +					 fbcursor->image.height);
>  
>  	if (fbcursor->set & FB_CUR_SETPOS)
> -		sm750_hw_cursor_setPos(cursor,
> -				       fbcursor->image.dx - info->var.xoffset,
> -				       fbcursor->image.dy - info->var.yoffset);
> +		sm750_hw_cursor_set_pos(cursor,
> +					fbcursor->image.dx - info->var.xoffset,
> +					fbcursor->image.dy - info->var.yoffset);
>  
>  	if (fbcursor->set & FB_CUR_SETCMAP) {
>  		/* get the 16bit color of kernel means */
> @@ -142,14 +142,14 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  		     ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
>  		     ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
>  
> -		sm750_hw_cursor_setColor(cursor, fg, bg);
> +		sm750_hw_cursor_set_color(cursor, fg, bg);
>  	}
>  
>  	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
> -		sm750_hw_cursor_setData(cursor,
> -					fbcursor->rop,
> -					fbcursor->image.data,
> -					fbcursor->mask);
> +		sm750_hw_cursor_set_data(cursor,
> +					 fbcursor->rop,
> +					 fbcursor->image.data,
> +					 fbcursor->mask);
>  	}
>  
>  	if (fbcursor->enable)
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
>  #endif
> -- 
> 2.40.0
> 
> 


