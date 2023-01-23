Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DB86775BB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 08:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjAWHil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 02:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjAWHi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:38:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEA37AA4;
        Sun, 22 Jan 2023 23:38:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3CB83369B;
        Mon, 23 Jan 2023 07:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674459504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJTRdzMZSDnp/JSiCAt8M0GL/TKb+LyjENNLymEDP/w=;
        b=Na7D44v841g/Ky2mHNzrWP1QDynHWozepDotcv0n8nplDWoBCwccNjg78siACkfAZbswXY
        qxnuxk/pRCImkjZTs4PTpALPZDggY67IwrUEPd0a+/L74kClCA3XCwH1e0Ctnr7WXeIRau
        HfPtgarZjkhJH9CwMYMZlsTQXma9rJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674459504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJTRdzMZSDnp/JSiCAt8M0GL/TKb+LyjENNLymEDP/w=;
        b=WAYy9aLooM/mkSZCYoGcVKGgdtKytfnKUKJ8B7EQQmBkI/p/NbfIOnYxR7zx+IdGcsIO6G
        KysYabn/2e/phNBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88C21134F5;
        Mon, 23 Jan 2023 07:38:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X6hjIHA5zmNUOgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 23 Jan 2023 07:38:24 +0000
Message-ID: <1537758c-a795-0285-2974-c759d5eb76c3@suse.de>
Date:   Mon, 23 Jan 2023 08:38:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] paride: Mark PARIDE as deprecated, point to PATA_PARPORT
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230122075710.GA4046@lst.de>
 <20230122181415.21031-1-linux@zary.sk>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230122181415.21031-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/23 19:14, Ondrej Zary wrote:
> Add Kconfig and runtime deprecation warnings to PARIDE, pointing users
> to PATA_PARPORT.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>
> ---
>   drivers/block/Kconfig         | 4 +++-
>   drivers/block/paride/paride.c | 2 ++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

