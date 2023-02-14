Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFBD695616
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjBNBrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjBNBr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:47:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF44F1ABCB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:47:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89B03B819C8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C9DC433EF;
        Tue, 14 Feb 2023 01:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676339242;
        bh=rZbOO6fi0qlXqZxxlVYOUHBpebE6n/8vf1D0V3jhIio=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NxGQLaDQsJz5BGuW145xpgLE6yRpq0gVjihbwsIaQ3GsdlWssEwzEMgWi5VwDO7Jh
         L3P1q9lZfdzfsGOl4g+s7gnWWcImHUjv1RiLnouPs2eU1KOKZgJPGDktqPJ/EoGkqQ
         5ygtYf9pNC1LTELSgKWe8iAd9dnctp4g/HiT6X22az1rX0NXCgjV0Gy4h+J+8DI4MK
         MlOgPDkMCNnSNqglHl3xSS7WBAtklYOWXfoWC2RXYoS323RxntwEYVCsHVonecZZkj
         EAIqTvsrIhEUwQlv0II5TDx2Zioz4Wn4C/l5rTQOqsCx0WMtlixsxNN6pDykvO/0cO
         c+koKE99z5HjA==
Message-ID: <8de864c2-c055-584b-f3d2-9240d0115785@kernel.org>
Date:   Tue, 14 Feb 2023 09:47:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [f2fs-dev] [PATCH] f2fs: synchronize atomic write aborts
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
References: <20230209181819.2333522-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230209181819.2333522-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/10 2:18, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> To fix a race condition between atomic write aborts, I use the inode
> lock and make COW inode to be re-usable thoroughout the whole
> atomic file inode lifetime.
> 
> Reported-by: syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
