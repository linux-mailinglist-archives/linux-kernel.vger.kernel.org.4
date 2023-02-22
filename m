Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC8B69FE77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjBVW06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjBVW05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:26:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6502007D;
        Wed, 22 Feb 2023 14:26:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FB95615C1;
        Wed, 22 Feb 2023 22:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 098AAC433D2;
        Wed, 22 Feb 2023 22:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677104815;
        bh=tODS6YIS+fbzOUespAdoE8trpFu1mTM23laVvhnpvWc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ETDxMvToWldflhac/Lg5g4+W0qQ5HXtDpVb1qM9XeSQJ2195SeEUBWRzY5cJv8W7L
         brMapdG060FR8rvq9Ua1lPW+M1u9B6Kpdi+jBcqrstQl9Apx0NK0qhuK0wqkCOVoOG
         KtjTTJBThF72BkM/zQMQNojr/05h/fp+nFh/cmIFyvy8H6mzZgtRDjwmPWnDoA3wlY
         2bWypmOKs2p7c9rD6j4D1tXj8N390tuNGczKmkjSQRa5uQB2Be05MpZWf5AZvPbVDJ
         dxKvspIg+3tfNtZE9dYrpBN2eBEK5Xw5ypiVWn6o+fz6OWcFwkHc3PyYo6HUE39DZT
         Fod9q3wJ4ON6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED234C43157;
        Wed, 22 Feb 2023 22:26:54 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mv+jJK0AhCEo-gx_5cBcyk0RSHvrQv9irWisoVPnbV3jQ@mail.gmail.com>
References: <CAH2r5mv+jJK0AhCEo-gx_5cBcyk0RSHvrQv9irWisoVPnbV3jQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mv+jJK0AhCEo-gx_5cBcyk0RSHvrQv9irWisoVPnbV3jQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.3-rc-ksmbd-fixes
X-PR-Tracked-Commit-Id: d3ca9f7aeba793d74361d88a8800b2f205c9236b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25ac8c12ff7886e3d9b99feb85c53302a3cc5556
Message-Id: <167710481496.21044.12712583419174453992.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 22:26:54 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 22:15:59 -0600:

> git://git.samba.org/ksmbd.git tags/6.3-rc-ksmbd-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25ac8c12ff7886e3d9b99feb85c53302a3cc5556

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
