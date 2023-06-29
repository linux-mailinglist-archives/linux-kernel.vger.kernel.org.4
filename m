Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8902F742F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjF2UxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjF2UwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFBD3596
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F08861632
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E805CC433C8;
        Thu, 29 Jun 2023 20:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688071901;
        bh=S+8oy+0iP7e/6AywiYlWZaTUhB1pPs1lBGTpr8qz924=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zunj31tGZLJiCLR27wcFsDrv6Ol0PT1xI3MVtGcNu98v04kfLxLoN4qaxsfKVO6qd
         1yRG5XvYNJzJJ5V362A4n/e2pisbaJJc3JdtP/T5wS6L68u6vWL6aNj2DddedYScqM
         IFVGOO6BqBUzlcNy8hMxQoKJRQ/x438hl0cTtwkAm/pD3aH1wVZmMP5j45x/wXuA+3
         QnXqQG/BRkn8Dfy7+Ns0NwkkInawnhwA1q9GSvWtLnKN7ILGTW56PvSCQi+Y5k7uEh
         4j9/M5lu7sNf0z8CP87c00sotz59DuM19EXfEakNsHOVVpZZn1utb9HvlG4U+I/MnG
         lavJDwWtwd7AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6441C40C5E;
        Thu, 29 Jun 2023 20:51:41 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230629200223.GC14388@redhat.com>
References: <20230629200223.GC14388@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230629200223.GC14388@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.5
X-PR-Tracked-Commit-Id: fc4ea4229c2b2dca0bffc12eee6973e353c20086
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a37714f96d5746268dc09bdd400a215f180ba9b
Message-Id: <168807190187.21634.2773454197775271152.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 20:51:41 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Jun 2023 15:02:23 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a37714f96d5746268dc09bdd400a215f180ba9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
