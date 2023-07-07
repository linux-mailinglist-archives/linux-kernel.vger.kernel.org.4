Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E260474B339
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjGGOok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGGOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:44:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A85C1FD7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:44:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31B5221E84;
        Fri,  7 Jul 2023 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688741073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVMmLaENPaM0JjXRiuX3xuMS8784Ru8KYNLD4w1UHB4=;
        b=gY16RP7UTDxhFJM2hnrjCGu6gLgj1ACcLbJSPiViO60JctutlSt7kRGD6KBsq9dt4yCgTX
        7Bjq2+UxfpV0ghSg/FJHi/C5r5ezI9TzDz3CcxXimErfiEl1gNhX9lpFEcozGWkxexZ8Wa
        eZ/jBuMEYFz7xH24+i+Pq8BGdrpViZY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10997139E0;
        Fri,  7 Jul 2023 14:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K9bHAdEkqGTRfQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 07 Jul 2023 14:44:33 +0000
Date:   Fri, 7 Jul 2023 16:44:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, david@redhat.com,
        yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH 0/2] zram: objects charge to mem_cgroup
Message-ID: <ZKgk0HfuuxsyBBXI@dhcp22.suse.cz>
References: <20230707044613.1169103-1-hezhongkun.hzk@bytedance.com>
 <ZKfFVfZovt4PnMsy@dhcp22.suse.cz>
 <CACSyD1M9rSadO7xb8-H0dU2-xtrZnJMBgqEMTSHhE6M5vFgC-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1M9rSadO7xb8-H0dU2-xtrZnJMBgqEMTSHhE6M5vFgC-Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-07-23 22:25:48, 贺中坤 wrote:
> > Please state the objective you are trying to achieve by this patchset.
> > It is always good to summarize the previous discussion and mention what
> > is done differently or how previous review feedback has been addressed
> > but the overall idea/purpose should be always explicit.
> >
> > Please elaborate more about both.
> >
> 
> Thanks for your reply.
> objective：
> the compressed memory of zram charge to the cgroup of the user.

Why do we want/need that?

> summarize the previous discussion:
> [1] As I can see, Michal's concern is that the charges are going to fail
> and swapout would fail.
> 
> The indirect use of zram is in the context of PF_MEMALLOC, so
> the charge must be successful.

No, this was not my concern. Please read through that more carefully. My
concern was that the hard limit reclaim would fail. PF_MEMALLOC will not
help in that case as this is not a global reclaim path.

Also let's assume you allow swapout charges to succeed similar to
PF_MEMALLOC. That would mean breaching the limit in an unbounded way,
no?
-- 
Michal Hocko
SUSE Labs
