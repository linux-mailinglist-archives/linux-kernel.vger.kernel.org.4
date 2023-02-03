Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F92968A22C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjBCSp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjBCSpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:45:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBEC9D59D;
        Fri,  3 Feb 2023 10:45:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E56E61FCC;
        Fri,  3 Feb 2023 18:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13B5EC4339C;
        Fri,  3 Feb 2023 18:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675449917;
        bh=ykX6ZQiBmOKmiR2+55NILGaqptYs0bs05t54KLmifkw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A5s2oOpQ4TyxyHW3MhIqsCwqFEMi84cZNbCW66Ore0qr7R8dqrRFyEIqq4jrftcfu
         b5vy5ZCdGlC9WdmKNKfL5hwJGFU8+uk81M2E3BH1QkwcD2ej+Ott0PvG69R8mW3P2o
         nVQcolpwtlyJig8lY5BqGNAoOhm/d7Ok52yZuH1zZ+bvp6pfJan9DAcM/V8eyMwmAB
         wod+T/t2jVN73SbC+n7mTFgA+tUK4PZACaJOtPojPIwvJHkRlHHUf3GI7B59sOiUs+
         ul3rp5tVaNioT+L30TQ9iUPfAAR7vMNF2vHGwEpIsPfK/J+/aZhktPZFmPU/kY/NWE
         dGOOnnMJ6iKsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01964E270C4;
        Fri,  3 Feb 2023 18:45:17 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fix for 6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230203181313.452449-1-idryomov@gmail.com>
References: <20230203181313.452449-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230203181313.452449-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.2-rc7
X-PR-Tracked-Commit-Id: a68e564adcaa69b0930809fb64d9d5f7d9c32ba9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b753a909f426f2789d9db6f357c3d59180a9354
Message-Id: <167544991700.32203.2575132313753824824.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Feb 2023 18:45:17 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  3 Feb 2023 19:13:13 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b753a909f426f2789d9db6f357c3d59180a9354

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
