Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F169C5F59FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiJESmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiJESlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:41:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB648168C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7EEB6179F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 18:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24B4FC43470;
        Wed,  5 Oct 2022 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664995219;
        bh=LhbRFeyFaX/+4BT/SlXteYAq0z66nTU2ybYUbzhkJAA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zf7d4ejsHMhKyDoTa2Jzs47V8eN/le7E37Fbb5MuYjCJYtK0FgUu9p+eQRzalxzxc
         5J0Bkwop56K2JZRixY5c8ZgZSPBQ0BOgo7OGrleGWr/xoc3UKearHQiRmPAXKqT0OA
         8ZJplLezQ2jHpf/yvzZk7qkle8qN8C+JxsPeLJbAoiayjAYvVJNbIueNbl5VtjKE2h
         YxDc7ePGTd+Ghok3oRTHYbnb8s2iqWw3CmKfKMwqhVmM3jR2kwVuEei8MhBBjPgq0h
         9EfsuEbRpA0cAWTaSnFK3Pa9+Vd4pbjXvKHZH/zBXBSwt7NpUU3vNjRJ/QNt1B8P9v
         DCj/OsdZ6zvfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11881E45BE7;
        Wed,  5 Oct 2022 18:40:19 +0000 (UTC)
Subject: Re: [GIT PULL] PCMCIA odd cleanups and fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzrF7i/lva5JRpxK@owl.dominikbrodowski.net>
References: <YzrF7i/lva5JRpxK@owl.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzrF7i/lva5JRpxK@owl.dominikbrodowski.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.1
X-PR-Tracked-Commit-Id: 15e74c6c1ce2d388e967f32cdaa83ca034fa6452
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebcfaeeceaf1d60de48f0b3c17b057d54ef790e9
Message-Id: <166499521906.1673.8797004345881911038.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Oct 2022 18:40:19 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Oct 2022 13:22:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebcfaeeceaf1d60de48f0b3c17b057d54ef790e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
