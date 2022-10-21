Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB76D6081F5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJUXDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJUXDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:03:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB012A56A3;
        Fri, 21 Oct 2022 16:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B8DFB82D88;
        Fri, 21 Oct 2022 23:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 020BFC433D6;
        Fri, 21 Oct 2022 23:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666393419;
        bh=MIvPmywfOr/h6WWp0BR+/BQKQ/bykOKRxtc3thcQ8dk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ojFdOU/2ogC3dnS68VsqWWNjtrVxP2reUXrxBaGrEHaqbwusQwGT9VAygMt4Voacz
         qxZi9+k78+AYGnmg80TmIhpp+2Zcd2pnscgtlQgQNcVRr9XYrZBZNw54SdOFZyQbPv
         80RULe2uIDID8Bv2o2yh5afPQmkr5iXf/5bx1OB1LzyPLlHcC7eBIJbgBG0G0zOCun
         b9DuMFiqUGePVfbu4qBXdUx/9kKvtEvlAs/tZGrRXaCV2K+Ss0XH01QUsQuw37U6Ya
         Zr8b3aKQZLGg8n8zBbI2Y09rvNhP1zTB4ElPrSTmieDQtI9DES+MMhfeoKPXkeY1WD
         L8zWQ+JvYCimw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E33A8E270DF;
        Fri, 21 Oct 2022 23:03:38 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvjQ5cnR0dc0oSRpF0Ck7cMyQRX2mng56UXZjHJ=JhMmQ@mail.gmail.com>
References: <CAH2r5mvjQ5cnR0dc0oSRpF0Ck7cMyQRX2mng56UXZjHJ=JhMmQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvjQ5cnR0dc0oSRpF0Ck7cMyQRX2mng56UXZjHJ=JhMmQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc1-smb3-fixes
X-PR-Tracked-Commit-Id: 73b1b8d25e39a1478b3792a7075f43e053ee62c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd8e963412c8e676fc73ae456f311cdcabe8642d
Message-Id: <166639341892.3847.16905330611520015117.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 23:03:38 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 09:40:07 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc1-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd8e963412c8e676fc73ae456f311cdcabe8642d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
