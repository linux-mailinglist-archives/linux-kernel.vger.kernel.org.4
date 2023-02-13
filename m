Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39725694276
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBMKN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBMKNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:13:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C7D15C8D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:13:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B5391FDB8;
        Mon, 13 Feb 2023 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1676283186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPuO2OxMrxF2mjArnp245A5L2ydvAazDghhHafveqME=;
        b=VMFIEcUdTVpvrfCs7T4/y1EvECHW3B0qVC/s/BkpvmXcB73b7zjcWlY8wOWnwhgDHtafg1
        xGv5YQ/ncbWKiJDDv9maA4PuQQWpCo/j+Xr25u8qGve1gbZB35QD0p0S8KQoPAU/kFl+bK
        1sostywQ1aOhgnv3vpItWUSmcdkL1GE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1676283186;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPuO2OxMrxF2mjArnp245A5L2ydvAazDghhHafveqME=;
        b=3lJBM12yQP1lzu/of8hmrqtpe/U6gpRaDEHKob007/c8RCwiBTM5US8OyGenWYwO1ajC66
        SR3CXnrwdzbeqkBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C72A138E6;
        Mon, 13 Feb 2023 10:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yFBEIjIN6mPLcwAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 13 Feb 2023 10:13:06 +0000
Date:   Mon, 13 Feb 2023 11:13:05 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ivan Rubinov <linuxkernelpatch8234@riseup.net>, kbusch@kernel.org,
        axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
Message-ID: <20230213101305.fgs6ke2jyhj3j7q6@carbon.lan>
References: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
 <20230213060850.GB13968@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213060850.GB13968@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 07:08:50AM +0100, Christoph Hellwig wrote:
> I've already applied a patch from Daniel Wagner for this device,
> but thanks for sending it in!

This patch also add NVME_QUIRK_IGNORE_DEV_SUBNQN. Is it necessary?
