Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F93A6F0C72
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245165AbjD0TUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244742AbjD0TUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:20:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBCE4EE7;
        Thu, 27 Apr 2023 12:20:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C503163F1B;
        Thu, 27 Apr 2023 19:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34E71C433D2;
        Thu, 27 Apr 2023 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682623205;
        bh=xvAPSbARQu1wmmjiWLCXhU5vuVqC14K5IVzTomfYpD0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O8mZsXWqG0DqJIpu2rQJwIcmd+7/QqXjCWzp0/IkHhaj/bHRLVz649LBkN+ZL2DlM
         sgHBDQoQ72kRUBm2vEHMcpX6sZM472d/+hK6fT0w55PSBE+1QrmrKyAdQ8owyNFjbX
         WTCZUUn7JVjHnbZMtEQMh01f5B+C09PlsPp6gD1rNoC+3uYtqxK4BBVzVUsfN76kly
         npdz+Kt7vaUT0JsrxJx2cHlE7lwyu+YegjUhNEKquvCuLJmc/OAGEOI7nJBXBbl9O4
         jnDuOwCDanE1O6oiOAD5GAJwvSvMhPhpJacoLjXeG0Qcj0BCOBLJ9lC/rwnJal3OlS
         sB3JLllT9QzuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F1FEE5FFC8;
        Thu, 27 Apr 2023 19:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver updates for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEqEgbLPb-ItUfdE@kroah.com>
References: <ZEqEgbLPb-ItUfdE@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEqEgbLPb-ItUfdE@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.4-rc1
X-PR-Tracked-Commit-Id: 8f40fc0808137c157dd408d2632e63bfca2aecdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4010e62b5b684d7a6090f3f9c69f8a5be31910e5
Message-Id: <168262320509.21394.14809357309480022544.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 19:20:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 16:19:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4010e62b5b684d7a6090f3f9c69f8a5be31910e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
