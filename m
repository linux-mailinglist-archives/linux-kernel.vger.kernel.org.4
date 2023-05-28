Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2606571375D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 03:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjE1BMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 21:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1BMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 21:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47757D8
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 18:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B856D60D57
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 01:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B9EFC433D2;
        Sun, 28 May 2023 01:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685236354;
        bh=jDUk00N23htJgTCus2ggznr7zHYOBahre42lfiwSgxM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qTkXBfZeqtBfPuEaxeqB1Ybwm8Yw4Lu8mDAhMePguj1umXdXyOX0I7g3xHDQP9uQ6
         JUhJXeFl79P4XjJ9AO1ZACpNsvco8mDHlKRmR71HcoNxZmo9yp791HAODI1ynsGFOY
         gP7yP+NrW9gl8sCEbpTJbt5DKp8/T49jNHPOh3k3rUrYr7ZTBQlXVBkM12DS9Ija7o
         bVLmx3WjuXkshoT6rc2Uwxrv1SpYVkR/gk9SxlVJZn5RXn2Lr7voukKE5JWwrtCzOV
         U/L8HqpbYhQ+gxpAM94nuW3AeKwrmYvqU2rhKhqSksagTXOpMDdQiVNM1fJUaY/TOT
         DP+M2XNafbt4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0649BC4166F;
        Sun, 28 May 2023 01:12:34 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.4-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87a5xptira.fsf@mail.lhotse>
References: <87a5xptira.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a5xptira.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.4-3
X-PR-Tracked-Commit-Id: 358e526a1648cdd773ba169da5867874ae2408e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 416839029e3858f61dc7dd346559c03e74ed8380
Message-Id: <168523635401.7029.2615898149537862363.pr-tracker-bot@kernel.org>
Date:   Sun, 28 May 2023 01:12:34 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 May 2023 10:14:01 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/416839029e3858f61dc7dd346559c03e74ed8380

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
