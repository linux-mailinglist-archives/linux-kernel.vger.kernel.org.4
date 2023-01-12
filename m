Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4B666EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbjALKCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjALKAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:00:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004536338;
        Thu, 12 Jan 2023 01:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673517587; x=1705053587;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oIV2dTHN9s8ehW+g1hEbVndTxm7Mu3+RjFEWQXYtaTg=;
  b=LVocnUAmoO/pv5EUeF37lScxeJw9LrcrNtf5Kuh7WkHAVw77grryJLIe
   952ALYazGkGCiphNkM064+uB7KI8OkPgQvQmCOKTbLsS35w5jXvEfOqyQ
   QRt/TVwTX93nRYaemD+fhHQfOMoyigTfKEb/eqUSVON4m6ytSiP7241lz
   h3OXq7qPct3cAwH67LGc8mb8cibS/C8rzx/tsOdNnh3MGPaQJXzEk6Gz2
   221grizPa3O0hi/1gFucJ/H3fDKEiVvUSMRiZ3BtrZv1xQyD1b6LYRTR5
   lsN1av3qCUlUc64+b6EAZsYa3v62M8FvIHpzkp3yW3NlcR+XLTw0oZNT/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303363452"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="303363452"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:59:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="800155083"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="800155083"
Received: from vbucoci-mobl1.ger.corp.intel.com ([10.252.52.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:59:46 -0800
Date:   Thu, 12 Jan 2023 11:59:43 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/11] tty: vt: saner names for more scroll variables
In-Reply-To: <20230112080136.4929-10-jirislaby@kernel.org>
Message-ID: <f48acfdd-779d-2f6-27a5-39168e6f4ac0@linux.intel.com>
References: <20230112080136.4929-1-jirislaby@kernel.org> <20230112080136.4929-10-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1577497597-1673517587=:1665"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1577497597-1673517587=:1665
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jan 2023, Jiri Slaby (SUSE) wrote:

> Rename more variables (t, b, s, d) -> (top, bottom, src, dst) to make
> them more obvious.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/vt/vt.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 7cda18b7ee3d..165c81211bdc 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -420,21 +420,22 @@ static void juggle_array(u32 **array, unsigned int size, unsigned int nr)
>  	}
>  }
>  
> -static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
> -			     enum con_scroll dir, unsigned int nr)
> +static void vc_uniscr_scroll(struct vc_data *vc, unsigned int top,
> +			     unsigned int bottom, enum con_scroll dir,
> +			     unsigned int nr)
>  {
>  	u32 **uni_lines = vc->vc_uni_lines;
> -	unsigned int size = b - t;
> +	unsigned int size = bottom - top;
>  
>  	if (!uni_lines)
>  		return;
>  
>  	if (dir == SM_DOWN) {
>  		juggle_array(&uni_lines[top], size, size - nr);
> -		vc_uniscr_clear_lines(vc, t, nr);
> +		vc_uniscr_clear_lines(vc, top, nr);
>  	} else {
>  		juggle_array(&uni_lines[top], size, nr);
> -		vc_uniscr_clear_lines(vc, b - nr, nr);
> +		vc_uniscr_clear_lines(vc, bottom - nr, nr);
>  	}
>  }
>  
> @@ -556,27 +557,30 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
>  	}
>  }
>  
> -static void con_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
> -		enum con_scroll dir, unsigned int nr)
> +static void con_scroll(struct vc_data *vc, unsigned int top,
> +		       unsigned int bottom, enum con_scroll dir,
> +		       unsigned int nr)
>  {
> -	u16 *clear, *d, *s;
> +	u16 *clear, *dst, *src;
>  
> -	if (t + nr >= b)
> -		nr = b - t - 1;
> -	if (b > vc->vc_rows || t >= b || nr < 1)
> +	if (top + nr >= bottom)
> +		nr = bottom - top - 1;
> +	if (bottom > vc->vc_rows || top >= bottom || nr < 1)
>  		return;
> -	vc_uniscr_scroll(vc, t, b, dir, nr);
> -	if (con_is_visible(vc) && vc->vc_sw->con_scroll(vc, t, b, dir, nr))
> +
> +	vc_uniscr_scroll(vc, top, bottom, dir, nr);
> +	if (con_is_visible(vc) &&
> +			vc->vc_sw->con_scroll(vc, top, bottom, dir, nr))

I'd keep this on one line.

>  		return;
>  
> -	s = clear = (u16 *)(vc->vc_origin + vc->vc_size_row * t);
> -	d = (u16 *)(vc->vc_origin + vc->vc_size_row * (t + nr));
> +	src = clear = (u16 *)(vc->vc_origin + vc->vc_size_row * top);
> +	dst = (u16 *)(vc->vc_origin + vc->vc_size_row * (top + nr));
>  
>  	if (dir == SM_UP) {
> -		clear = s + (b - t - nr) * vc->vc_cols;
> -		swap(s, d);
> +		clear = src + (bottom - top - nr) * vc->vc_cols;
> +		swap(src, dst);
>  	}
> -	scr_memmovew(d, s, (b - t - nr) * vc->vc_size_row);
> +	scr_memmovew(dst, src, (bottom - top - nr) * vc->vc_size_row);
>  	scr_memsetw(clear, vc->vc_video_erase_char, vc->vc_size_row * nr);
>  }
>  
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1577497597-1673517587=:1665--
