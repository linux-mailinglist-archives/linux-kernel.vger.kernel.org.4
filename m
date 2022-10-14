Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542615FF436
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiJNTov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiJNTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:44:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C262B63AF;
        Fri, 14 Oct 2022 12:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5441F61C17;
        Fri, 14 Oct 2022 19:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB812C433D7;
        Fri, 14 Oct 2022 19:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665776680;
        bh=GQkd96jNNvfl1ikbCy8X1+0Val6lXUJdpAYKLYQO7ss=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ro8INgSkE/5R43nOWKOTjonHRmbigz2E7SlZHF74Qr9koobyDa7agMDXpIK1CF9DW
         r0w6dlWFVL9Q9OYQXsYJaX+vrdMlqIJAmO5VARJRedLS1QwQTJOrihZZFCVzCpffoR
         XH1aN1tkhX33GbQ/VDYiXJVOW01HmwQdThedk+DuWgdpLA2XxncxE5mp5/uLZzPNyG
         1sUcl1h7WjV8AkhN9uJhFJH/J4j5KguuYDA+GDnYDg7TTv+lMM4WkXnUjt4u97DwCT
         LnqUDDvt0y2i89KXzrO0C3cCms06PO7yAfWjP++JvLKhoeg1S4g2Q4NSMPGXL9n8Vt
         mw2FpbG40ae9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A686BE270EF;
        Fri, 14 Oct 2022 19:44:40 +0000 (UTC)
Subject: Re: [GIT PULL] Final MM updates for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221013230302.96f2869cd26026b36e8ecd40@linux-foundation.org>
References: <20221013230302.96f2869cd26026b36e8ecd40@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20221013230302.96f2869cd26026b36e8ecd40@linux-foundation.org>
X-PR-Tracked-Remote: https://lkml.kernel.org/r/20221004210029.7412fcfd@canb.auug.org.au Thanks.
X-PR-Tracked-Commit-Id: ef6e06b2ef87077104d1145a0fd452ff8dbbc4b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e714bf1713b4b096d20ec75c13880b7086964bd
Message-Id: <166577668067.9115.14819083431667495194.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Oct 2022 19:44:40 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Oct 2022 23:03:02 -0700:

> https://lkml.kernel.org/r/20221004210029.7412fcfd@canb.auug.org.au Thanks.

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e714bf1713b4b096d20ec75c13880b7086964bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
