Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546E6743191
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjF3AXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjF3AXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:23:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD822D78
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89A126167E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9553C433C0;
        Fri, 30 Jun 2023 00:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688084593;
        bh=4D80tJAtN1aaG+JPSSDIV/UPKKZefMl3hzH2wq2ZLEQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gsNj7MbFL+buphbRQTuTjLuh2PKUf3yhWOYkQV8TQD0btV6FOwa8tu5SzaIsEK2/R
         UrJCxb9p4+cJn4z1zv2GJL/vIHug0vSSGMlQWfon+HTqeYQy8V8nMJjbkKkUACv8q9
         hIZVFro69TT5R9mQVR0cW0/wYPtSqv3Z6DVjLPOiTzlLm7L2QWg6FBR32rU3nB8Vmc
         zwk3aS4gsFqLxGpWpA5lwzOXVjxlMfeGVqHX9su0VHpiYATjQRdtxrVKWLKOEa01Zn
         gXeubc2zRC3MbaD9L9hnwCyUBO9HOhGUqfr9CBwMWcm2QtreFdjV3eYM5Oc5KkFAS7
         bWO7aAzGmDy4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5E9CE5381B;
        Fri, 30 Jun 2023 00:23:12 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1c39c9b0-ec37-f910-2b09-cedf7acf6e91@suse.cz>
References: <1c39c9b0-ec37-f910-2b09-cedf7acf6e91@suse.cz>
X-PR-Tracked-List-Id: <patches.lists.linux.dev>
X-PR-Tracked-Message-Id: <1c39c9b0-ec37-f910-2b09-cedf7acf6e91@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.5
X-PR-Tracked-Commit-Id: 7bc162d5cc4de5c33c5570dba2719a01506a9fd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 632f54b4d60bfe0701f43d0bc387928de6e3dcfb
Message-Id: <168808459286.18676.11809401059160966086.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 00:23:12 +0000
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
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Sterba <dsterba@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 09:37:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/632f54b4d60bfe0701f43d0bc387928de6e3dcfb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
