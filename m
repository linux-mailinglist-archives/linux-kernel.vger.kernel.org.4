Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF135659C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 22:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiL3VVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 16:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3VVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:21:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1813888;
        Fri, 30 Dec 2022 13:21:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 974C322973;
        Fri, 30 Dec 2022 21:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672435288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wlBSsCHI8Y8ekxGXzYTjXplCXibXdCePaRgFTF2MDPo=;
        b=2r9XrxLFJS/XsipHRoPMMVpjJot9zBH3zUBYjIKxZEyrMSlBHWSKNvZSFQPUiEwbndwKyL
        AvOETQYc5vTsIx6XwPhcRQ308k27HNCP4xYzYQnFOgVkMxqvzCMBqX7raLYTRRETglzTK8
        jr6XR35v+klOVA1ohBEhla7NCnB+WC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672435288;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wlBSsCHI8Y8ekxGXzYTjXplCXibXdCePaRgFTF2MDPo=;
        b=4AW81eS2xgDlH5LwQ7PSEOs1jvQKg+aim7vp+ecM/EpQgUKtcjwaq7TnC0yG1lvR8bo1fl
        5L7pBAxOLEu+acBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 722F013638;
        Fri, 30 Dec 2022 21:21:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FJwfG1hWr2PyLQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 30 Dec 2022 21:21:28 +0000
Message-ID: <6cf8cccc-0c73-1937-1ede-e3cf4b91aa40@suse.cz>
Date:   Fri, 30 Dec 2022 22:21:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: linux-next: Tree for Dec 30
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Joel Stanley <joel@jms.id.au>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20221230103016.ebcjz7lky7wfkz6h@pengutronix.de>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221230103016.ebcjz7lky7wfkz6h@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/22 11:30, Uwe Kleine-König wrote:
>  - In various files below mm/ between
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 	???
> 
>    and
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git for-next
> 	???

That's weird, because slab.git for-next is still exactly what was merged to
6.2-rc1, so when I try to merge it to master I just get "Already up to date."

>    I didn't feel confident to fix this conflict correctly and skipped merging the slab tree.

Nothing is lost then, but maybe it indicates some issue with your approach?
(didn't try to replicate it in full)

>  - In various files belwo mm/ between
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 	???
> 
>    and
> 
> 	git://git.infradead.org/users/willy/pagecache.git for-next
> 	???
> 
>    As above I didn't even try to fix these up and skipped merging the folio tree
> 
> Best regards
> Uwe
> 

