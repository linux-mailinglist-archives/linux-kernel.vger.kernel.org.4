Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47532601099
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJQN5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJQN5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:57:19 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F98541BE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3CTsJGe8bY+pItCw50sxDPAN3XWBgWvK9oJXOucHAFs=;
  b=A/FsqbGEadvZ1Eb67IUcQh0wB2/etHEDRdXTFlPvkfEvdSxdZnxqbSBd
   /UJJl76usnPX9lLzoZHc/OfmkNCRlZegijgQIr+dZ74VoiDy/mpf+xOAG
   0I7Sc0vphFdsmJUvuM81u2zQb22ZUu8QCBSIH4M8a5w8uVFdu75BA7u9b
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,191,1661810400"; 
   d="scan'208";a="65537852"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 15:57:17 +0200
Date:   Mon, 17 Oct 2022 15:57:16 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deepak R Varma <drv@mailo.com>
cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: Re: [PATCH 3/4] staging: r8188eu: remove {} for single statement
 blocks
In-Reply-To: <478d652b9f467d47685c1af72a876f34dd92710f.1666011479.git.drv@mailo.com>
Message-ID: <alpine.DEB.2.22.394.2210171556290.16433@hadrien>
References: <cover.1666011479.git.drv@mailo.com> <478d652b9f467d47685c1af72a876f34dd92710f.1666011479.git.drv@mailo.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2022, Deepak R Varma wrote:

> As per the Linux kernel coding-style guidelines, there is no need to
> use {} for single statement blocks. Address following checkpatch script
> complaint:
> 	WARNING: braces {} are not necessary for single statement blocks

It's nice to say something like "Problem identified using checkpatch".
But putting the verbatim checkpatch message that says what you just said
doesn't seem necessary.

julia

>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index 427da7e8ba4c..290affe50d0b 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -655,9 +655,8 @@ void *scdb_findEntry(struct adapter *priv, unsigned char *ip_addr)
>  	hash = __nat25_network_hash(network_addr);
>  	db = priv->nethash[hash];
>  	while (db) {
> -		if (!memcmp(db->networkAddr, network_addr, MAX_NETWORK_ADDR_LEN)) {
> +		if (!memcmp(db->networkAddr, network_addr, MAX_NETWORK_ADDR_LEN))
>  			return (void *)db;
> -		}
>
>  		db = db->next_hash;
>  	}
> --
> 2.30.2
>
>
>
>
>
