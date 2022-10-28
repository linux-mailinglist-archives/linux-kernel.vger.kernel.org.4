Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45903611A35
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJ1Sfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJ1Sfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:35:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F336E2D2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666982128; x=1698518128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e6tXyHXcx1wINDytML2ECkyfhcbu00FuKqs+1j13wTc=;
  b=MdCYzAZ3cnPChGilIhryR3Dtvbdl9ynRpxBG+mrDAspVAYiBW7UOi7LX
   qH97aw1iltp5uH/rTOKWEtSbyKC9t9BLqqgxUATsULbi3qpJHX6zNkDus
   2UCKfnv9uP0Dr+Ua7i3PzMZHCs8eab/dnnACb+k4YSqz4ItWGVmKi8ENu
   BWa4kFFXolU6uw/VgG7fo3+EEUL1XEyggsSmN9OS4XtbRaKKtA0o9fdQj
   z9GSfFLLW3n/oq0inLJOc+caqIzCtxfCghXBFzQLjENT316L12YunEH71
   B7xP6Uv+Kh81/NOMV3NkmVVrOyjCsCO9oU1bz3II3qbheufS4Mbv9fh5N
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="310260051"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="310260051"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 11:35:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="758174577"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="758174577"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.175.207])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 11:35:17 -0700
Date:   Fri, 28 Oct 2022 11:35:15 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     UMWARI JOVIAL <umwarijovial@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] WARNING: Possible repeated word: 'very'
Message-ID: <Y1wg4y6k1fe/TF0d@aschofie-mobl2>
References: <20221028051420.GA30073@rdm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028051420.GA30073@rdm>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 08:14:20AM +0300, UMWARI JOVIAL wrote:
> i used checkpatch.pl script to identify the above
> Repetition of the same word in one sentence same line
> 
> Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>

This is my (not yet automated) response:

You are sending patches to the Outreachy list, in a way
that makes me suspect you have overlooked the Outreachy
Project Contribution Information.

Please review:
https://www.outreachy.org/outreachy-december-2022-internship-round/communities/linux-kernel/  (only accepted applicants can see this link)

https://lore.kernel.org/outreachy/Y0D+dzbjRtuc0KT4@aschofie-mobl2/

Alison

> ---
>  drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
> index 090345bad223..30a0276b8b58 100644
> --- a/drivers/staging/rtl8712/rtl871x_xmit.c
> +++ b/drivers/staging/rtl8712/rtl871x_xmit.c
> @@ -766,7 +766,7 @@ void r8712_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
>   * If we turn on USE_RXTHREAD, then, no need for critical section.
>   * Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
>   *
> - * Must be very very cautious...
> + * Must be very cautious...
>   *
>   */
>  struct xmit_frame *r8712_alloc_xmitframe(struct xmit_priv *pxmitpriv)
> -- 
> 2.25.1
> 
> 
