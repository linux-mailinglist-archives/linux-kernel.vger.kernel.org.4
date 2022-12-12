Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C15664A600
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiLLReY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiLLRdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:33:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ECD13D53
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:33:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 087C961199
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69814C4339B;
        Mon, 12 Dec 2022 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670866403;
        bh=4IdvSE6sC7hTUkB6MGNbbavyzSbUlUZU8vsHdURc1XU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LjXDSwnyNPn37MNA6NQmziUv0YG77R6TwAAnxv4KIKxaK/kG7DKE+hnyfST0EimnK
         GTXjHulZL7b/f5eyy1RxzBLHhjMjNpajnN2qTfjMKW9j6yaDo21wtmQx1lfiUtMPCX
         LOMog1GUnBjzTvkMozYoqGdCXcmGfsurZFYB+VfMKxntzv+S+BRRm0UVNLFUJsxyKh
         JnMc/TxoN0WikbMGuzsYKxxf8gKmd2IA0NEoJPy2R2ZxmYI9xgAPgf8YBb26I1XpNV
         XUM3l8KHIHN088WoWC8cJAyDgSLgH5nP8Fm0mfNk/S2hw1HDGsC6oR3mkMWhVBCvLR
         r7esgIWvgk6AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57F3EC00448;
        Mon, 12 Dec 2022 17:33:23 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8f81dbc0-da85-dff7-4a88-c0c4639649c1@suse.cz>
References: <8f81dbc0-da85-dff7-4a88-c0c4639649c1@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8f81dbc0-da85-dff7-4a88-c0c4639649c1@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.2-rc1
X-PR-Tracked-Commit-Id: dc19745ad0e46c1a069540973e376cff0130443c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 893660b0e1c8d127960ae921f55983b435664e15
Message-Id: <167086640335.22610.15239338618462713087.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 17:33:23 +0000
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Feng Tang <feng.tang@intel.com>,
        Dennis Zhou <dennis@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Dec 2022 16:32:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/893660b0e1c8d127960ae921f55983b435664e15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
