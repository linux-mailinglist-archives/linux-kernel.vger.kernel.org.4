Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3205965B268
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjABMxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjABMxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:53:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488DB20B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:53:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0224620F5A;
        Mon,  2 Jan 2023 12:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672664017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E4QhXZVmmD8wL0jF3Q8OYcYm5TROTGzPGcEFmr+eGjQ=;
        b=ETRpXyklwX6Br0hnq2VRqP0SJ70tzUXTVDAtbYsm+apwt0qdY+3GHsi+ZvAGb+NSbiXWpP
        4MgVRS7KK2ro6sd9RbZ7L+mr0Meyu+Z5ybt2jN3dSOlSLNJ97lR123Ecd3OMuNLvLzRoqf
        fHovIUaMcO+JEiVvP2z3LV1yd2xs5xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672664017;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E4QhXZVmmD8wL0jF3Q8OYcYm5TROTGzPGcEFmr+eGjQ=;
        b=igiZtoG/BoEMxudSH1PvBtP+PZsSpe1F1mPTKdp10TwqzVpelj9yIKOcFqenoeh+AfsEQ5
        F2vbHNlctmvggrAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E294313427;
        Mon,  2 Jan 2023 12:53:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Z9EN9DTsmN3HQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 12:53:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6B5DBA073E; Mon,  2 Jan 2023 13:53:36 +0100 (CET)
Date:   Mon, 2 Jan 2023 13:53:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tanmay Bhushan <007047221b@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: Initialize newblock variable COVERITY: 1530250
Message-ID: <20230102125336.2lziahed5tub4yf2@quack3>
References: <bf7ba34700b1e96a27a031316e811be4d2accfbd.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7ba34700b1e96a27a031316e811be4d2accfbd.camel@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-12-22 19:57:00, Tanmay Bhushan wrote:
> From 21f30c35ba12c939da0990a8527790408276aaee Mon Sep 17 00:00:00 2001
> From: Tanmay Bhushan <007047221b@gmail.com>
> Date: Mon, 26 Dec 2022 18:54:13 +0100
> Subject: [PATCH] udf: Initialize newblock variable COVERITY: 1530250
> 
> When getting newblock the variable returned is not initialized.
> Coverity informs this as a high risk impact because variable may
> contain an arbitrary value left from earlier computations. Newblock
> is initialized to avoid this issue.
> 
> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>

Thanks for the fix. Somehow the patch is corrupted so I couldn't apply it.
I had also other people send me this fix (which I've applied) so no need to
resend this particular patch but it would be good to fix your setup so that
you can send valid patches... Thanks!

									Honza

> ---
>  fs/udf/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 1d7c2a812fc1..71bc4de38ad2 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -684,7 +684,7 @@ static sector_t inode_getblk(struct inode *inode,
> sector_t block,
>  	struct kernel_lb_addr eloc, tmpeloc;
>  	int c = 1;
>  	loff_t lbcount = 0, b_off = 0;
> -	udf_pblk_t newblocknum, newblock;
> +	udf_pblk_t newblocknum, newblock = 0;
>  	sector_t offset = 0;
>  	int8_t etype;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
> -- 
> 2.34.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
