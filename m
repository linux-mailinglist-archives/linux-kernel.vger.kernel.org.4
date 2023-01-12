Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6FE666D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbjALIyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbjALIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:53:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D70F7B;
        Thu, 12 Jan 2023 00:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673513532; x=1705049532;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0V9ZZYfoOE+9IEyNDcb5v4QxwPNBdvhkz+Go9Fwdhgs=;
  b=borM9DL4KxciGw270fSjq62aOrVUWqElrmgv6bpvxfJioREAhK7mq54o
   iZMFpfcnCbAlCD4xaoZTV5/16/01Mn8gQbJRImhkCi0HBneJTlOWujp6J
   CQdMJVJZuV6984QfGX2EOmGuY5hEqcKW1X+1i1i/Nv27oA0+sDse/lp0F
   KDhbtuitSPQdfT4a1oU2xQIeRm0slsA2NNa4fQyKQunFL8l5nXiWy+8lU
   m0AZ7Rg98JjqITgcgHPrx9G+BAdrrQIgdWVtj/N7JPWBE+NQv55qvWLKR
   CXHy89MnhNchpjpeuAzX+1GzKd+0uzYavhOeYaXl2Sg1dfw1xPHz+jSVp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409889447"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="409889447"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:52:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="903101379"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="903101379"
Received: from vbucoci-mobl1.ger.corp.intel.com ([10.252.52.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:52:10 -0800
Date:   Thu, 12 Jan 2023 10:52:08 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/11] tty: vt: remove char32_t typedef
In-Reply-To: <20230112080136.4929-5-jirislaby@kernel.org>
Message-ID: <afbdfd8a-5c2d-ca6d-9a9d-a377ddac57e@linux.intel.com>
References: <20230112080136.4929-1-jirislaby@kernel.org> <20230112080136.4929-5-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1105813883-1673513532=:1665"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1105813883-1673513532=:1665
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jan 2023, Jiri Slaby (SUSE) wrote:

> It boils down to uint32_t, so use u32 directly, instead. This makes the
> code more obvious.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/vt/vt.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 3ae0212f1aa7..86c18522231b 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -316,14 +316,12 @@ void schedule_console_callback(void)
>   * Code to manage unicode-based screen buffers
>   */
>  
> -typedef uint32_t char32_t;
> -
>  /*
>   * Our screen buffer is preceded by an array of line pointers so that
>   * scrolling only implies some pointer shuffling.
>   */
>  struct uni_screen {
> -	char32_t *lines[0];
> +	u32 *lines[0];
>  };
>  
>  static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
> @@ -360,7 +358,7 @@ static void vc_uniscr_set(struct vc_data *vc, struct uni_screen *new_uniscr)
>  	vc->vc_uni_screen = new_uniscr;
>  }
>  
> -static void vc_uniscr_putc(struct vc_data *vc, char32_t uc)
> +static void vc_uniscr_putc(struct vc_data *vc, u32 uc)
>  {
>  	struct uni_screen *uniscr = vc->vc_uni_screen;
>  
> @@ -373,7 +371,7 @@ static void vc_uniscr_insert(struct vc_data *vc, unsigned int nr)
>  	struct uni_screen *uniscr = vc->vc_uni_screen;
>  
>  	if (uniscr) {
> -		char32_t *ln = uniscr->lines[vc->state.y];
> +		u32 *ln = uniscr->lines[vc->state.y];
>  		unsigned int x = vc->state.x, cols = vc->vc_cols;
>  
>  		memmove(&ln[x + nr], &ln[x], (cols - x - nr) * sizeof(*ln));
> @@ -386,7 +384,7 @@ static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
>  	struct uni_screen *uniscr = vc->vc_uni_screen;
>  
>  	if (uniscr) {
> -		char32_t *ln = uniscr->lines[vc->state.y];
> +		u32 *ln = uniscr->lines[vc->state.y];
>  		unsigned int x = vc->state.x, cols = vc->vc_cols;
>  
>  		memcpy(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
> @@ -400,7 +398,7 @@ static void vc_uniscr_clear_line(struct vc_data *vc, unsigned int x,
>  	struct uni_screen *uniscr = vc->vc_uni_screen;
>  
>  	if (uniscr) {
> -		char32_t *ln = uniscr->lines[vc->state.y];
> +		u32 *ln = uniscr->lines[vc->state.y];
>  
>  		memset32(&ln[x], ' ', nr);
>  	}
> @@ -435,7 +433,7 @@ static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>  			d = sz - nr;
>  		}
>  		for (i = 0; i < gcd(d, sz); i++) {
> -			char32_t *tmp = uniscr->lines[t + i];
> +			u32 *tmp = uniscr->lines[t + i];
>  			j = i;
>  			while (1) {
>  				k = j + d;
> @@ -466,8 +464,8 @@ static void vc_uniscr_copy_area(struct uni_screen *dst,
>  		return;
>  
>  	while (src_top_row < src_bot_row) {
> -		char32_t *src_line = src->lines[src_top_row];
> -		char32_t *dst_line = dst->lines[dst_row];
> +		u32 *src_line = src->lines[src_top_row];
> +		u32 *dst_line = dst->lines[dst_row];
>  
>  		memcpy(dst_line, src_line, src_cols * sizeof(*src_line));
>  		if (dst_cols - src_cols)
> @@ -476,7 +474,7 @@ static void vc_uniscr_copy_area(struct uni_screen *dst,
>  		dst_row++;
>  	}
>  	while (dst_row < dst_rows) {
> -		char32_t *dst_line = dst->lines[dst_row];
> +		u32 *dst_line = dst->lines[dst_row];
>  
>  		memset32(dst_line, ' ', dst_cols);
>  		dst_row++;
> @@ -516,7 +514,7 @@ int vc_uniscr_check(struct vc_data *vc)
>  	p = (unsigned short *)vc->vc_origin;
>  	mask = vc->vc_hi_font_mask | 0xff;
>  	for (y = 0; y < vc->vc_rows; y++) {
> -		char32_t *line = uniscr->lines[y];
> +		u32 *line = uniscr->lines[y];
>  		for (x = 0; x < vc->vc_cols; x++) {
>  			u16 glyph = scr_readw(p++) & mask;
>  			line[x] = inverse_translate(vc, glyph, true);
> @@ -550,7 +548,7 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
>  		 */
>  		row = (pos - vc->vc_origin) / vc->vc_size_row;
>  		col = ((pos - vc->vc_origin) % vc->vc_size_row) / 2;
> -		memcpy(dest, &uniscr->lines[row][col], nr * sizeof(char32_t));
> +		memcpy(dest, &uniscr->lines[row][col], nr * sizeof(u32));
>  	} else {
>  		/*
>  		 * Scrollback is active. For now let's simply backtranslate
> @@ -560,7 +558,7 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
>  		 */
>  		u16 *p = (u16 *)pos;
>  		int mask = vc->vc_hi_font_mask | 0xff;
> -		char32_t *uni_buf = dest;
> +		u32 *uni_buf = dest;
>  		while (nr--) {
>  			u16 glyph = scr_readw(p++) & mask;
>  			*uni_buf++ = inverse_translate(vc, glyph, true);
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1105813883-1673513532=:1665--
