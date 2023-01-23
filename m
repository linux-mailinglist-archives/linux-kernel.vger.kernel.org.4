Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9E67806B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjAWPs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjAWPsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:48:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C2113D65
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:48:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 51A0E1F45F;
        Mon, 23 Jan 2023 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674488920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUq9w2dqmuL0qMORpAYZy39hI9AaqwGW+gw2Knrac/g=;
        b=mh2heP4pusvjTQfq1xEXcDaTYc9z6p0EvPUxp6SS1nn6E2rK5FIjJiSraDeh/Vy1SoilcD
        C/YSJhkI6DPfSsUIYd+1GOXXEuR7kf4YA2IGi1C8PYvb6v0XIwjflVUsJfRszFM0LXKxZD
        IKQd7iqF5r/ozZREjtSPX8w1IpqG4jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674488920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUq9w2dqmuL0qMORpAYZy39hI9AaqwGW+gw2Knrac/g=;
        b=XfkEo2OJvnEd8vVfQr+3Ktc5v0N4VUEWvSjsL3DNXHkXxsfdWQvzawwdFQFaSL7htoLVsI
        OaPsP9kXTWKDwHBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 445E71357F;
        Mon, 23 Jan 2023 15:48:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WWWWEFiszmNjYQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 23 Jan 2023 15:48:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B9793A06B5; Mon, 23 Jan 2023 16:48:39 +0100 (CET)
Date:   Mon, 23 Jan 2023 16:48:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Diederik de Haas <didi.debian@cknow.org>
Cc:     Jan Kara <jack@suse.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udf: Fix full name of the GPL
Message-ID: <20230123154839.k3d6maptnxvb3fw3@quack3>
References: <20230122191603.59359-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230122191603.59359-1-didi.debian@cknow.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 22-01-23 20:16:03, Diederik de Haas wrote:
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>  fs/udf/ecma_167.h | 2 +-
>  fs/udf/osta_udf.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks. I've added the patch to my tree.

								Honza

> 
> diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
> index de17a97e8667..4ddc8b62d30f 100644
> --- a/fs/udf/ecma_167.h
> +++ b/fs/udf/ecma_167.h
> @@ -18,7 +18,7 @@
>   *    derived from this software without specific prior written permission.
>   *
>   * Alternatively, this software may be distributed under the terms of the
> - * GNU Public License ("GPL").
> + * GNU General Public License ("GPL").
>   *
>   * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
>   * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> diff --git a/fs/udf/osta_udf.h b/fs/udf/osta_udf.h
> index 157de0ec0cd5..660818f7b850 100644
> --- a/fs/udf/osta_udf.h
> +++ b/fs/udf/osta_udf.h
> @@ -18,7 +18,7 @@
>   *    derived from this software without specific prior written permission.
>   *
>   * Alternatively, this software may be distributed under the terms of the
> - * GNU Public License ("GPL").
> + * GNU General Public License ("GPL").
>   *
>   * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
>   * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> -- 
> 2.39.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
