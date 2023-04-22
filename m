Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576336EBA74
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 18:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjDVQrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 12:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjDVQrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 12:47:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD4E1FEE;
        Sat, 22 Apr 2023 09:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD44560916;
        Sat, 22 Apr 2023 16:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 214BEC433D2;
        Sat, 22 Apr 2023 16:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682182024;
        bh=XSpzGpQ3klSZx/WTwiv/0NELnBqkZLCQeaHFXF1pvcc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iCsPWaDwWXlKC8yhiws9jwtFboVdiNjsmBnhF3JxGTk4v1B7f2h9rxETs5tHGG0/f
         waoz0g6WshgQp5o+LqpefmOedtDf0HCMHtnj1pYC9Dg5t7/8o5u8mxrbM2EXMvdvoR
         k1QK37S0RDsKkeK9bZeYXofxYd8eH2MZVK8odPV0KK7GPsI+QUxKEDSB3/dsp+KBU+
         HZUhSa6RqhySAEpT1UIFmmCP2jD1ZQq/RqiS0FtZiz3n5kg57ZnDogyiW/n+a0P61n
         1+Ykp9ujZQniI2QnvgOYwq118a1Qpmraxd6pN1nezflK6VNAFjaJBZYuDf2VWofpuz
         bXwQHiE7XDlJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04F6EE270DA;
        Sat, 22 Apr 2023 16:47:04 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mu1-3LwONaQGR5B9XSWTupdvK9SSSk3Pm-V5bGZdFeCqQ@mail.gmail.com>
References: <CAH2r5mu1-3LwONaQGR5B9XSWTupdvK9SSSk3Pm-V5bGZdFeCqQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mu1-3LwONaQGR5B9XSWTupdvK9SSSk3Pm-V5bGZdFeCqQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc7-smb3-client-fixes
X-PR-Tracked-Commit-Id: 023fc150a39ffe656da3e459ad801eb1c7fdfad9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84ebdb8e0d9ca261d73677f345814505af172ae0
Message-Id: <168218202401.21238.3378744505789997926.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Apr 2023 16:47:04 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 21:43:50 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc7-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84ebdb8e0d9ca261d73677f345814505af172ae0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
