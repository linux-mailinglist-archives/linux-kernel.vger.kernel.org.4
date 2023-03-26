Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7D86C974A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 19:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjCZRvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 13:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjCZRvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 13:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67F65B84;
        Sun, 26 Mar 2023 10:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C87960ECB;
        Sun, 26 Mar 2023 17:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99C48C433D2;
        Sun, 26 Mar 2023 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679853062;
        bh=r75p1lizF8uPxPmQL14R/v6cGSWlH7/feaZV4k0fNBQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BuckitZZ/hSegRy/IXjRPTu7t+Rxrx6RaqQfhzRuCLp1obm7Ha6oSs6jnAWb/xFfG
         jvQ5f/hfW+O4aULQuFuQGBxK29xlLTMl8oQGq6Vg3tNetrJ0eUQ+H4Gw3M8eHvG91i
         TSyWKhi6U92oSg27KG39FFi7SUi7tf13cYekfDEmelgSNBe5PTGPP+7kNNu+y4ESMw
         I/f8pmtjIaqxxEGemrdB3dm0+LslGAj2s9Dmz6pcisE9YU/wVt3afqEVhkb7dy9SLG
         2P6khTuoFWu899tXkWbQNas6RqFfgx9ObgXBMuocdT5bHvVdq2cC3GLo3SgRm1b3pu
         GYF+NUQT1BA/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 880A1E43EFD;
        Sun, 26 Mar 2023 17:51:02 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver fixes for 6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZCBKbHwjnh5iyw2D@kroah.com>
References: <ZCBKbHwjnh5iyw2D@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZCBKbHwjnh5iyw2D@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.3-rc4
X-PR-Tracked-Commit-Id: 5021383242ada277a38bd052a4c12ed4707faccb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35
Message-Id: <167985306254.16586.8278171257724022763.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Mar 2023 17:51:02 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Mar 2023 15:36:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
