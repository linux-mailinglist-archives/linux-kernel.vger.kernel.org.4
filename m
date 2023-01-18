Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54D671896
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjARKJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjARKGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:06:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0746169B37
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:11:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE1772100B;
        Wed, 18 Jan 2023 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674033107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=la4u3WiqNGgqLUtctuhYAtr33HCJU+/I+S10BLm4PPc=;
        b=O7S/CVOFTWYiA8k6/35NOCFBGDaxvc1jSO8BKF+G3vDuf0/+Pdm0UT41LCYNzXcKhXqrZG
        jFdMAbv3bkk2YbDIP0uK3qqGI39aomDfnVJUBPw2TD+TEt0lBYWG9XVbpixDESuO5HljM0
        of4IJ3Qk0N9nzLLVoyrOBUut577kjnE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25BF4139D2;
        Wed, 18 Jan 2023 09:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NFTfBtO3x2NbLwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 18 Jan 2023 09:11:47 +0000
Date:   Wed, 18 Jan 2023 10:11:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 3/3] mm: add vmstat statistics for madvise_[cold|pageout]
Message-ID: <Y8e30ujUGLwDfes8@dhcp22.suse.cz>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <20230117231632.2734737-3-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117231632.2734737-3-minchan@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-01-23 15:16:32, Minchan Kim wrote:
> madvise LRU manipulation APIs need to scan address ranges to find
> present pages at page table and provides advice hints for them.
> 
> Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> shows the proactive reclaim efficiency so this patch addes those
> two statistics in vmstat.

Please describe the usecase for those new counters.
-- 
Michal Hocko
SUSE Labs
