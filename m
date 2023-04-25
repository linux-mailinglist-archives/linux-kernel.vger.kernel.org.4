Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87D36EE747
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjDYSBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjDYSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079551544D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC6B663085
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A02BC433EF;
        Tue, 25 Apr 2023 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682445652;
        bh=M9pAhuahiTNPkvbxKGZnGZi9vU8lxLyAKaGr/9FbSdY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ECXJt4B1bFfnsyTOLPNlVrwdUbZ8h9wCHFIlR+B0ixkxjZlSH2cjjETiN27WTVRlB
         J+AnV+2hYqvrdMofPRxLYhTHQ6pgEhcQoQNb9AJ4FRfbwnd6LI5DmDEKGrzfzaoSYv
         grZT83LhwnFKRXlz7CvIl/QZ94Jgwn4Tmk113zZ2DSojjOPBzMfHkYTj6VAg5pwvjy
         GWkqco76XwQ6Lislv30+BeUAi5dLtdUd+sC3/CBrxCLq5B0/4grB6ZpyvHozLEQtCN
         GsJs5nLxqVoRxJeTXp2Q7sJo0F3seJY2Cf897pMHibwI1Cp+SvPTCTv/EFGJxneceU
         15jekKinFDFVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 369CAE5FFC5;
        Tue, 25 Apr 2023 18:00:52 +0000 (UTC)
Subject: Re: [GIT PULL] RAS updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424133230.GBZEaE7j5O76K4PIdK@fat_crate.local>
References: <20230424133230.GBZEaE7j5O76K4PIdK@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424133230.GBZEaE7j5O76K4PIdK@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.4_rc1
X-PR-Tracked-Commit-Id: 4c1cdec319b9aadb65737c3eb1f5cb74bd6aa156
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3464152e541b08fdc3c60664c01a28f8844a655
Message-Id: <168244565221.10431.11309142846343733989.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 18:00:52 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 15:32:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.4_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3464152e541b08fdc3c60664c01a28f8844a655

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
