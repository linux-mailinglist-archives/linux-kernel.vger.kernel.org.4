Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778DF6F9ACE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 20:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjEGSMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 14:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjEGSMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 14:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B94F40D8
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 11:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4CC160C7B
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 18:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47812C433EF;
        Sun,  7 May 2023 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683483128;
        bh=pWAUzt2feTbrd5Kv1nWhCWPD6M4S4u0omqyLGio+KH4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l5tIFa/HjzexV5p61YcP4oIeO0MnHblBWvIWcnyo3LakuyqX9sVofO9nc85df6iSM
         J2qeux9jSrHmQonHGZqMOJQJuqXOxdTQmiKE354/NQ7wUvMJ3cBAb3/c28tDmwSYN3
         yfyVIV5vJ5Dc2iXPVK06K4L0jaXENv1iTTKWS0uM4kx6dyN3Cxq5IoUf7PR6hufUOg
         Mdd6miow/HBq5afChDMEWMTlTeVI2srM9yf7Ow0DJtb9OlegNIdlZhldRzTC+LQ4hD
         fFD9NG/IoapbPlIjbniwnEA+AzJm4ySuX+oQtqOzsUofHG6BDzZ1Z4Pl1lkXs3USl5
         YOazQFkb0wq+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34D8AC395FD;
        Sun,  7 May 2023 18:12:08 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY2CgTjCG-mxdmvkPZPz1XTB8Mm7PW+8WsNx6_dEY5bsnA@mail.gmail.com>
References: <CABb+yY2CgTjCG-mxdmvkPZPz1XTB8Mm7PW+8WsNx6_dEY5bsnA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY2CgTjCG-mxdmvkPZPz1XTB8Mm7PW+8WsNx6_dEY5bsnA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v6.4
X-PR-Tracked-Commit-Id: d396133dced4cbaa52581d0e9c4aea8e04b8db10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c1094e47ef10be267a982fb1c69dbb80aa4f257
Message-Id: <168348312821.16669.11718841246635602703.pr-tracker-bot@kernel.org>
Date:   Sun, 07 May 2023 18:12:08 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 May 2023 10:52:50 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c1094e47ef10be267a982fb1c69dbb80aa4f257

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
