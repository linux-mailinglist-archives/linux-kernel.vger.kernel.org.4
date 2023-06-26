Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8972C73E688
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjFZReO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjFZReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C66610FD;
        Mon, 26 Jun 2023 10:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 879B160F16;
        Mon, 26 Jun 2023 17:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9B85C433C8;
        Mon, 26 Jun 2023 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687800841;
        bh=UAfqoGFtyEOI3tiyFiAmzFxw4vT/3sv5Hco1RpUXPWU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PsJ6Oals4BabomhtKPzrFZoew0itjpx79tqhq9C57j1QlFO1nYd1UxXxRTsThZ+w9
         x7PRWZJ9QDNIYxWawNXZKVsvMB1SMSK9u58reLZ7EWtAjJhUilkWKSakZ8CcyLNo/2
         AXaOC7yV0HOK+GIhsCQALJ0lar1r1KkDFwt5rictMQAOHASQH6agu9N/st4Cg8yV8W
         o3TkH6q75NZJfs3rGS9xlMEMWMqwFWHwerXiq9ePseGWMJ4L5PTl/dSgB2ylPwiocQ
         eRpX6WjSbmPyimq9S2TmNCT699Y7PYZUiF6ThnUN18uzq60Jhil8DEDD2lrCc0mYnm
         3rtq+boK/K6vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6E1CC43170;
        Mon, 26 Jun 2023 17:34:01 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJWlqGlx6LymL7lO@tuxmaker.boeblingen.de.ibm.com>
References: <ZJWlqGlx6LymL7lO@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJWlqGlx6LymL7lO@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.4-4
X-PR-Tracked-Commit-Id: ad3d770b83afffd10abf624ec80c408254343a20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d9a9bf07ed9b09af3696997f02a557b428be092
Message-Id: <168780084180.11860.7305433038926992545.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 17:34:01 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Jun 2023 16:01:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.4-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d9a9bf07ed9b09af3696997f02a557b428be092

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
