Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716806BB575
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjCOODR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjCOODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:03:14 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027C623C62
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lqJvBi858bb2oCsrQI9F4clr12DZvtkfiaPExOH0Vyg=;
  b=WiB95KWSAXw+EhwqHlXKEmCTvbkFFCxsAfeEnRL3vTuAhBcBM+oveVif
   CBAnocox3Uzk3lI/nT/69bKHYHsHP39GmWyKjE+Uxh2xfYCs3JBVFr9lc
   Nv6rGbsjiAGzTuw4Qx1HAIux1muUfA3J3vyc5MyyWspOYvfgIzYg+krzF
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,262,1673910000"; 
   d="scan'208";a="97372769"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 15:03:10 +0100
Date:   Wed, 15 Mar 2023 15:03:11 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        martyn@welchs.me.uk, manohar.vanga@gmail.com, zoo868e@gmail.com,
        jerrykang026@gmail.com, cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/2] staging: vme_user: add space around operators
In-Reply-To: <078be1ba242950f31d0aa13fe9815d92fe96468b.1678888612.git.eng.mennamahmoud.mm@gmail.com>
Message-ID: <3cb654df-c08-881-f1c-52364ce2ad2b@inria.fr>
References: <078be1ba242950f31d0aa13fe9815d92fe96468b.1678888612.git.eng.mennamahmoud.mm@gmail.com>
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



On Wed, 15 Mar 2023, Menna Mahmoud wrote:

> add a space before and after the operator, for readability.

add -> Add
That is, start the sentence with a capital letter.

>
> Reported By checkpatch script:

By -> by
No need for capital letters in the middle of a sentence, unless you are
referring to a proper noun (name of someone or something).

julia

> " CHECK: spaces preferred around that '+', '<<' and '>>' ".
>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
> change in v2:
>         edit commit message
> ---
> change in v3:
>         edit commit message
> ---
>  drivers/staging/vme_user/vme_tsi148.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
> index 482049cfc664..bfa604043355 100644
> --- a/drivers/staging/vme_user/vme_tsi148.c
> +++ b/drivers/staging/vme_user/vme_tsi148.c
> @@ -737,7 +737,7 @@ static int tsi148_alloc_resource(struct vme_master_resource *image,
>  		return 0;
>
>  	if (!image->bus_resource.name) {
> -		image->bus_resource.name = kmalloc(VMENAMSIZ+3, GFP_ATOMIC);
> +		image->bus_resource.name = kmalloc(VMENAMSIZ + 3, GFP_ATOMIC);
>  		if (!image->bus_resource.name) {
>  			retval = -ENOMEM;
>  			goto err_name;
> @@ -983,7 +983,7 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
>  		goto err_aspace;
>  	}
>
> -	temp_ctl &= ~(3<<4);
> +	temp_ctl &= ~(3 << 4);
>  	if (cycle & VME_SUPER)
>  		temp_ctl |= TSI148_LCSR_OTAT_SUP;
>  	if (cycle & VME_PROG)
> @@ -2187,14 +2187,14 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
>
>  	/* Ensure that the CR/CSR is configured at the correct offset */
>  	cbar = ioread32be(bridge->base + TSI148_CBAR);
> -	cbar = (cbar & TSI148_CRCSR_CBAR_M)>>3;
> +	cbar = (cbar & TSI148_CRCSR_CBAR_M) >> 3;
>
>  	vstat = tsi148_slot_get(tsi148_bridge);
>
>  	if (cbar != vstat) {
>  		cbar = vstat;
>  		dev_info(tsi148_bridge->parent, "Setting CR/CSR offset\n");
> -		iowrite32be(cbar<<3, bridge->base + TSI148_CBAR);
> +		iowrite32be(cbar << 3, bridge->base + TSI148_CBAR);
>  	}
>  	dev_info(tsi148_bridge->parent, "CR/CSR Offset: %d\n", cbar);
>
> --
> 2.34.1
>
>
>
