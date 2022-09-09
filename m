Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1056B5B3EB1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiIISQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIISQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC7D10B7D1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69D346209E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 18:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBCE0C433C1;
        Fri,  9 Sep 2022 18:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662747402;
        bh=5vn2SZ6NmhST1Cdl+gEYfZObODfeu6TdrFg8LopNSxc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BtDOSin7qIBwbvoyw6P7it+h+jq60+f2AdxVT+QhOkOb+t+8Sfthv5y4YBHLwhOeQ
         RYHpIrF+H1vmghX9LHueAyzvaiiEKoiIJXHnuWYJE01/2rtEJsxOw3Ujz2lYoAM3fQ
         yd671APqQYvTrEvXBPmEaI5uvrrqYVzU3OphF7cBOAB/7PMXmT0a9U3lUAQ6bSPJAt
         fcew0twx0bKWw/+CGXK0hx1vEKlb69QPnFI5PRvg8EHPiaTHjZRFJIWEZAdkvMGrcf
         s/tbvVK/uKuBPhK8+yc8u4vJPDeX3XWk8ikcHvpQS08En/w7kBeb6vhCxfkrXHo3zl
         y9JvlNntbyZQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBFABE1CABD;
        Fri,  9 Sep 2022 18:16:42 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.0-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87mtb8encn.fsf@mpe.ellerman.id.au>
References: <87mtb8encn.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87mtb8encn.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.0-5
X-PR-Tracked-Commit-Id: a66de5283e16602b74658289360505ceeb308c90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fc1171d34deff70bf3a8338adab8ce46138aae3
Message-Id: <166274740276.9705.16925014852610275397.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Sep 2022 18:16:42 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 09 Sep 2022 22:36:24 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.0-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fc1171d34deff70bf3a8338adab8ce46138aae3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
