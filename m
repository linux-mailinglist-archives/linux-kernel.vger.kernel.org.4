Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D86B7325AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbjFPDKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbjFPDKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449ED2D40;
        Thu, 15 Jun 2023 20:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC0056268C;
        Fri, 16 Jun 2023 03:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5D08C433C9;
        Fri, 16 Jun 2023 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686885017;
        bh=TnzTtFWw5IJ94FWe5qRmJupS56VK5HKdScy8PgqdyY0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KQLuH2SAvMWUzjzB3diaG8ACdumvwvbRrkyZ9+rjpWeZc/gUGz7TOvdpE7GsdgIbq
         I2FoUm0n8ivmhA+jd2kIjwG425zvuLs5BSxoa65R5z68/5MAH1huRS89e6NPKrF5P3
         fFUBqe0QljX1p0NPrKuqP7tdHxlA+fwUnZmrjuVu1ELTrmxrOeOi0MVsuXrLiy06l/
         zroSfqQgZ1vRg9g4BVpvJgs921cvdS76Zo+5kty8clcBG4OjiijqgQeCvKDodaTrBe
         evZiaH2n8uuqJuVVlZADfFBnf5HnsMHEah0mEKZs+zg3ojm6WNuToi/5aV6pBwBL1x
         MfoJfzP6Rtveg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C288BC64458;
        Fri, 16 Jun 2023 03:10:17 +0000 (UTC)
Subject: Re: [GIT PULL for v6.4-rc7] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230615121721.1f901ebb@sal.lan>
References: <20230615121721.1f901ebb@sal.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230615121721.1f901ebb@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-6
X-PR-Tracked-Commit-Id: ec21a38df77a5aefbd2f70c48127003b6f259cf3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c926a55f650ce58eae33cda504d50ac1837d53fd
Message-Id: <168688501779.31465.3699955042361078322.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 03:10:17 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Jun 2023 12:17:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.4-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c926a55f650ce58eae33cda504d50ac1837d53fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
