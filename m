Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284C1676858
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjAUTXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUTXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:23:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C07B29421;
        Sat, 21 Jan 2023 11:23:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBAC460B5E;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 496C0C433EF;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674329018;
        bh=IEUTqqp31kzOXGdQOF7tNaY8o4Pz2V38eNN8+IG/d5Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Riyeds5uRDpfZ4Ek2if6jha47fDIFqbrje/2yMEnRj5z90HI7oHKEk3dOR0WpB1qA
         553Kn1IVJB1uFl+uE8V9Mt6j4G8VsXo50Iy6q92/lK+f2iJyulnFfoiyST4faBNL4W
         HQVTNUCJHlg4+gvXSTET35slB/GX7TM1zppTWHCZTatXXzJMinZs+O4rC02sM5AsZ6
         iOjdityiD+L9VzTEBaxgijpvAQISUAiMVV7Pb3U19tNTudLPYefdYy3mNQoQSjJAzR
         hKI1NWwG/qjb4bJ30lOuAzsOMQXClBr1wXRL5FxM4zvlRcxIOw+TuVKv9f4NERcM8L
         9SbzBQjHmTjoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DEFAC395DC;
        Sat, 21 Jan 2023 19:23:38 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8wEsNOa9JR4cdPK@kroah.com>
References: <Y8wEsNOa9JR4cdPK@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8wEsNOa9JR4cdPK@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc5
X-PR-Tracked-Commit-Id: 14ff7460bb58662d86aa50298943cc7d25532e28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e67da28898e9e219176412f2fd2f415dece474ab
Message-Id: <167432901818.17568.9091683897555061133.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Jan 2023 19:23:38 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Jan 2023 16:28:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e67da28898e9e219176412f2fd2f415dece474ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
