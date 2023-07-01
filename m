Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123367446B0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 07:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjGAFFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 01:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjGAFFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 01:05:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8125A44B7;
        Fri, 30 Jun 2023 22:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1631060F31;
        Sat,  1 Jul 2023 05:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E0DFC433C7;
        Sat,  1 Jul 2023 05:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688187898;
        bh=4LWOhASE8+HGVu8i8O4N4EliCDL8lrFffN6puZLpAxs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jla41Fk6USFMFMOAxpL68YvBg8s48uB7181Pk3pwDdwe0gIg8f2qMR8B9e4LzuQqF
         EP9jFuokOPclCJ7ciVrFmrh7t99p8fPdJ21usaUVcVNA8BmFggMqFWfK4bZAwAh2o8
         bl2gBcVKmx3elXjdt6D43/HfxPIFKsuLEpVOqEL3BOnzKVkzW8zdS7QBYxt+og+VbK
         DpK6C+bW3/ooU/wxBwNGv3FgCMLm/i+qUf+A73nOGv7TcV10yZwhBZGYaM4VVW/u3k
         GUk85r95nfqqxlGtkom8lOKZmgA3pCLEoO1pEQ1uiFGuPhIQ3vUfPqXfJDnZUp05Qz
         wLKLf+51AaK5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68EBAE5381B;
        Sat,  1 Jul 2023 05:04:58 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msFa0AjapQV_+bPf+upCNnCxppVgqkcDQP9GTh8o5bgdw@mail.gmail.com>
References: <CAH2r5msFa0AjapQV_+bPf+upCNnCxppVgqkcDQP9GTh8o5bgdw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msFa0AjapQV_+bPf+upCNnCxppVgqkcDQP9GTh8o5bgdw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc-smb3-client-fixes-part1
X-PR-Tracked-Commit-Id: 61986a58bc6abbb1aea26e52bd269f49e5bacf19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a507db1d8fdc39802415e4d2ef6d1aecd67927fa
Message-Id: <168818789842.30776.10169180339933392249.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Jul 2023 05:04:58 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Jun 2023 23:20:39 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc-smb3-client-fixes-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a507db1d8fdc39802415e4d2ef6d1aecd67927fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
