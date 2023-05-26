Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41603711E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjEZCg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjEZCgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F1DFB;
        Thu, 25 May 2023 19:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4232C64C5F;
        Fri, 26 May 2023 02:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A42B3C433EF;
        Fri, 26 May 2023 02:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685068579;
        bh=K3hZ8CQi1y6GXkMphFUapo7ngb3OqQQIhijVqngHzOE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WGxk1ekN9WAtFSuWXw8AW680mbisvmI4D0RPimR842p2Uo3N/o5syjSaeEbCvXFKR
         UCymLulwQVzak4q2ewGrcV4u3Zf9vVTmwez/2ish7a/cm1uI7C+SHBs6svaSzI0ljW
         s2II0WjkkglmYSM+WyCpaRExilUzTPvGgD9fAlyoOy5fJGfYVxVNYSuwSO29TDRLpn
         DrrRLR05VrPPHwws4bsT0U6UybeGZ5tJ5XkWHGquBPOT+TonLvCfCgLlRS1oeDIZkm
         d8+me8RlqwYHAFU1M1Z80/4WXnxbUFaOZJi0U0oqkJsfoQti+LgN1nQBcKiC+CAXV8
         vOPhKdtAmbrjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9265FC4166F;
        Fri, 26 May 2023 02:36:19 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 client fixes and move of cifs and ksmbd to under
 "smb" directory
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muUoXaeFdq=HUnEvjrppaD2e0_HUZOkgcHDSk_MmZOUag@mail.gmail.com>
References: <CAH2r5muUoXaeFdq=HUnEvjrppaD2e0_HUZOkgcHDSk_MmZOUag@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muUoXaeFdq=HUnEvjrppaD2e0_HUZOkgcHDSk_MmZOUag@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc3-smb3-client-fixes
X-PR-Tracked-Commit-Id: ab6cacf833ba337b41700ee193d2c8936f1d049e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d85b27b0cc6b5cf54567c5ad913a247a71583ce
Message-Id: <168506857958.15599.7149868953053411979.pr-tracker-bot@kernel.org>
Date:   Fri, 26 May 2023 02:36:19 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 May 2023 18:38:11 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc3-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d85b27b0cc6b5cf54567c5ad913a247a71583ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
