Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1127A65B3F3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbjABPOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjABPOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:14:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACC9C05;
        Mon,  2 Jan 2023 07:14:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 87D025C228;
        Mon,  2 Jan 2023 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672672453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lVb30ysuSqkubuaZ/v0LpSOwkrc62XCDm7CmyzbF9LA=;
        b=N4LN2Rg5AeTwhfiasZnJYxrKN3+cn9fv2ZEWw1CeeYdsYWQCqLx4Nq5oObVEccMYX6ZPNC
        Y57UIE1hD8EnZvNweZ7V//wvpPwl9x/Ic5nmm6RDL+SjN92LBQ73wpv9bJTVTjHJpvYf6R
        JGLIY0BU/3RLGnoHSw5EKYL3fKSPRPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672672453;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lVb30ysuSqkubuaZ/v0LpSOwkrc62XCDm7CmyzbF9LA=;
        b=bQglcq0GBgrnIPXpWk6Q8ZdutYipdLVY8JXxH1o7DNUYbHIpJ3esq/KdSRVJM/R2Nf318A
        UjknlqIAIpH7VIBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B19413427;
        Mon,  2 Jan 2023 15:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oWcWGsX0smNNYgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 15:14:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8A873A073E; Mon,  2 Jan 2023 16:14:11 +0100 (CET)
Date:   Mon, 2 Jan 2023 16:14:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: Re: [PATCH RESEND v2 02/10] block, bfq: remove unsed parameter
 reason in bfq_bfqq_is_slow
Message-ID: <20230102151411.4lhfygpckczyqtp7@quack3>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
 <20221222191641.1643117-3-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222191641.1643117-3-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-12-22 03:16:33, Kemeng Shi wrote:
> Parameter reason is never used, just remove it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 1220c41fc767..5a6d9e8c329d 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4066,8 +4066,7 @@ static void __bfq_bfqq_recalc_budget(struct bfq_data *bfqd,
>   * function to evaluate the I/O speed of a process.
>   */
>  static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
> -				 bool compensate, enum bfqq_expiration reason,
> -				 unsigned long *delta_ms)
> +				 bool compensate, unsigned long *delta_ms)
>  {
>  	ktime_t delta_ktime;
>  	u32 delta_usecs;
> @@ -4263,7 +4262,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
>  	/*
>  	 * Check whether the process is slow (see bfq_bfqq_is_slow).
>  	 */
> -	slow = bfq_bfqq_is_slow(bfqd, bfqq, compensate, reason, &delta);
> +	slow = bfq_bfqq_is_slow(bfqd, bfqq, compensate, &delta);
>  
>  	/*
>  	 * As above explained, charge slow (typically seeky) and
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
