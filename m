Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4645A65B22F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjABMjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjABMjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:39:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FFE6423;
        Mon,  2 Jan 2023 04:39:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20EDB33EFB;
        Mon,  2 Jan 2023 12:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672663182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vh8oOl8B0pDGWo7uaAANPYMniQThtt1/t22YPdxLRZ8=;
        b=rWOzyuzwuXZfEhGt9KseWFo3TRq+B/tEKBKORemtlGILCT0rS4ZAg13TDk5yLR8R4+B//d
        YwrXXvul6qDegdBBQ0ewx+KLhc5XU/kIsxnnKxFcvPE5qREKnAom/DLmQudhBCac429nZt
        JRTKxSRgHfS0XTV4E7AfZTj4YeX+QAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672663182;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vh8oOl8B0pDGWo7uaAANPYMniQThtt1/t22YPdxLRZ8=;
        b=ZQhWvBU7lh5chH5WXGZOBlJ/iEp9ADl1u0CPSYpdXxyEeseTcTVZVlJNnzyxMgfCGiiXsM
        J/Afjst8IXQKJlAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 136B713427;
        Mon,  2 Jan 2023 12:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JFG0BI7QsmNHFgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 12:39:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9BB04A073E; Mon,  2 Jan 2023 13:39:41 +0100 (CET)
Date:   Mon, 2 Jan 2023 13:39:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jan Kara <jack@suse.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] udf: Fix spelling mistake "lenght" -> "length"
Message-ID: <20230102123941.xumwslcekp5zo65a@quack3>
References: <20221230231452.5821-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230231452.5821-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-12-22 23:14:52, Colin Ian King wrote:
> There is a spelling mistake in a udf_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks! I've merged the patch to my tree.

								Honza

> ---
>  fs/udf/directory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> index a4c91905b033..18a1514871fe 100644
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -34,7 +34,7 @@ static int udf_verify_fi(struct udf_fileident_iter *iter)
>  	len = udf_dir_entry_len(&iter->fi);
>  	if (le16_to_cpu(iter->fi.lengthOfImpUse) & 3) {
>  		udf_err(iter->dir->i_sb,
> -			"directory (ino %lu) has entry at pos %llu with unaligned lenght of impUse field\n",
> +			"directory (ino %lu) has entry at pos %llu with unaligned length of impUse field\n",
>  			iter->dir->i_ino, (unsigned long long)iter->pos);
>  		return -EFSCORRUPTED;
>  	}
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
