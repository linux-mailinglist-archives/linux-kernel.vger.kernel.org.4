Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7EE5F7BE9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJGRA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJGRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:00:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F3B48C82;
        Fri,  7 Oct 2022 10:00:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDA5D61DC3;
        Fri,  7 Oct 2022 17:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1C12C433D6;
        Fri,  7 Oct 2022 17:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665162007;
        bh=SC2a3JVItge5TlMNxCwk6LePOtjoCGZXyocybFuyczs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RGYOFvIzPS3IkWj4mQ1yjibGoVDoU+5bjXw/RGxcKuQ7xQ+5W0JF9LUnRTL1tA3sB
         hoLJKPhAwOLEuJWIXfrga3ZOPaYeB7G/tqnY0PpC9NrfDNIKCX2SonZxDuCdEdVmgw
         CsZrSQY08RsFF+eYmPOSGgFSyRcsBLbKyMhyZLgYEdg9CDVveGp/S4Al+/P2gr5aDb
         Xx+FSnGVIU9TvTwdl13z7ICyLVVftPDFGckTv9BR3zdPS5wYMk4VWkjvg6hbkDzgSw
         XThXIUYrRr7ORjSA3FEjbRY9waykFOB6Bm2CBjiACTPWAz0mRtWGhbctbD9LA0NmOY
         RIdSf9VsMSMzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F841E2A05C;
        Fri,  7 Oct 2022 17:00:07 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtx9gsG01JDMWakP0o-76rzyX_YKzbgVdZZwboaVVDF3g@mail.gmail.com>
References: <CAH2r5mtx9gsG01JDMWakP0o-76rzyX_YKzbgVdZZwboaVVDF3g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtx9gsG01JDMWakP0o-76rzyX_YKzbgVdZZwboaVVDF3g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.1-rc-ksmbd-fixes
X-PR-Tracked-Commit-Id: f5ba1cdaf5eb380e148183bda06d4844b457d095
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f4b9beeb9cf46c4b172fca06de5bd6831108641
Message-Id: <166516200762.22254.17760102843865160723.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 17:00:07 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Oct 2022 18:53:02 -0500:

> git://git.samba.org/ksmbd.git tags/6.1-rc-ksmbd-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f4b9beeb9cf46c4b172fca06de5bd6831108641

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
