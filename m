Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1C35BB42D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiIPV6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIPV62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:58:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CD76A4B9;
        Fri, 16 Sep 2022 14:58:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 71D2120E99;
        Fri, 16 Sep 2022 21:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663365505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wum9Ujr+n+NSRWSc3YvmOrBab3fvi3nUmbflY+j/WKM=;
        b=0QyIPgPNBCpaAsebZfrbNMluy1rerJWNpNoze7OFhtjXU++h3Tdx88cOwQgnPlczRghFOL
        ngxviVPAR1zxZLo81ffu5e05bx+ka8VjTKk6n1uPFDeSts+buLl2NVcTriWS4GEQ95wVwL
        /xBC/oyOaH1hJGGZ6qO0h+casAj3bS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663365505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wum9Ujr+n+NSRWSc3YvmOrBab3fvi3nUmbflY+j/WKM=;
        b=CeevbAqMyyQS4F3pDfTVwEDD53S2oQRQKv/yvkx9qPj+2uzKS4n5gdb4ZBTdxIRSC2rxvU
        VaUungjxR+WWusBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63F8E1346B;
        Fri, 16 Sep 2022 21:58:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TFWBGIHxJGMPbQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Sep 2022 21:58:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DCC40A0682; Fri, 16 Sep 2022 23:58:24 +0200 (CEST)
Date:   Fri, 16 Sep 2022 23:58:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Li Jinlin <lijinlin3@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block/blk-rq-qos: delete useless enmu RQ_QOS_IOPRIO
Message-ID: <20220916215824.kfxvesl3l6tjqciw@quack3>
References: <20220916023241.32926-1-lijinlin3@huawei.com>
 <f2b8a99d-f6bd-4581-c651-d5b62d6cff21@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b8a99d-f6bd-4581-c651-d5b62d6cff21@acm.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-09-22 07:12:23, Bart Van Assche wrote:
> On 9/15/22 19:32, Li Jinlin wrote:
> > Since blk-ioprio handing was converted from a rqos policy to a direct call,
> > RQ_QOS_IOPRIO is not used anymore, just delete it.
> 
> (+Jan Kara)

Thanks! The patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> Jan, please Cc me on future blk-ioprio patches - I just noticed that I was
> not Cc-ed on commit 82b74cac2849 ("blk-ioprio: Convert from rqos policy to
> direct call").

Well, you were on CC of the whole patchset which this patch was part of - see
[1]. So maybe you've missed it among other patches.

[1] https://lore.kernel.org/all/20220623074450.30550-1-jack@suse.cz/

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
