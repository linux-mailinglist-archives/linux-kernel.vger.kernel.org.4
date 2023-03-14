Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434876B9A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjCNPqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjCNPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:45:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF59ACBB7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678808716; x=1710344716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cITCE+UZwPbzaQ7OACY7EnfTGg/YE+v1wZg0atOm8DQ=;
  b=as64fbpqeZwUNzFecoM/Vbscau5dGjsyT5cA1UDXHtyJKfKxrS5yE9+l
   OhRKyGzWV7IBfRuk+N04Ud3vIGvfMkl999K4zAF5ap15IDp70Oq2RzY6v
   Hva1ECK671fKQdD/dZ0LUXfkpUO04eDKMrKl/rt1eOQjlGmsinH3m4geH
   r3thCMOI5PykZv3uxrsgY5OxysJ2inyEHGUnS28haRdhHJ5eMlk2ojB0J
   aLcFWYa6+ZWr8OUpX6vadv1uuyFrJ6VDcoRueCRys84YTuL5bFDcu6vI1
   Nzw40vnI+fRNYNuTkJNzdxnS5SlOlKUfWSw8hBMZk5PhNruxOyBv7gOdw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="334948163"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="334948163"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="711565462"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="711565462"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.140.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:44:47 -0700
Date:   Tue, 14 Mar 2023 08:44:45 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Kloudifold <cloudifold.3125@gmail.com>
Cc:     teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
Message-ID: <ZBCWbcJfX/Gh7hU9@aschofie-mobl2>
References: <ZA+K6OdPe21k8F2k@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA+K6OdPe21k8F2k@CloudiRingWorld>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 04:43:20AM +0800, Kloudifold wrote:
> The sm750 driver had some functions named in CamelCase,
> which violates the kernel's naming convention.
> In this patch, I rename these functions to snake case,
> which is the expected style.
> 
> This v2 patch was prompted by an error reported by the
> Linux test robot, which detected the compile error.
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/

The tags from lkp go with your tag below - 

  Reported-by: kernel test robot <lkp@intel.com>
  Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
> Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
> ---

Your next changelog, will look something like this:

Changes in v3:
- Add this changelog (Philipp)
- Move lkp tags and link to the correct location in commit log (Alison)
- Update the commit msg (Philip)
- Update the commit log (Bagas, Julia)

Changes in v2:
- Use new function names in call sites (LKP)



Khadaji,
Did you see the compile errors?  What was the deal with that?
Thanks,
Alison


>  drivers/staging/sm750fb/sm750.c        | 22 +++++++++++-----------
>  drivers/staging/sm750fb/sm750_cursor.c | 14 +++++++-------
>  drivers/staging/sm750fb/sm750_cursor.h | 12 ++++++------
>  3 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index effc7fcc3..9ddcd7b7d 100644
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
> +				        fbcursor->image.dx - info->var.xoffset,
> +				        fbcursor->image.dy - info->var.yoffset);
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
> 2.39.2
> 
> 
