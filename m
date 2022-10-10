Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499D55FA6F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJJVYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiJJVX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D547963F;
        Mon, 10 Oct 2022 14:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C79A61038;
        Mon, 10 Oct 2022 21:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B22BBC4314A;
        Mon, 10 Oct 2022 21:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665437034;
        bh=9F4xgaLFFkiKM7cAS4yInqrFSlouvjNdy68G5gLv85Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sNkUvREJAVJWZ1+52x9qnTnF4lbLOIVBx8QvVYs+MugY8S3X9X/3WjDx33AYvkWwI
         cMdhUMlV9rkjb+YC7af79/tbHxY770iz+c6nnMe3D7K8NmK3T8oH2I0SiAV6mZ4E0U
         Wanj8xnZvajhh9YHz09W29pQQz8MIhdhwg5gdd6PvMSvRai6MimlRooP9a6ralVUJF
         pyuItyMIcf24m/RHE0a6RdE/OHjFkojwvpKXzBev8o/+HMUM21uB9z6CXqNqBxTQJW
         Q4DYuCDgWfDKXQF1z5bxI38rZ6yUPbGmNRcNPd57wYmPqJoV5iy9T58OXZcj5glUOM
         1tsIQhn9iqGFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BBFBE2A05F;
        Mon, 10 Oct 2022 21:23:54 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f16e5bde-0560-9306-be82-d5a825485fb1@linux-m68k.org>
References: <f16e5bde-0560-9306-be82-d5a825485fb1@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f16e5bde-0560-9306-be82-d5a825485fb1@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.1
X-PR-Tracked-Commit-Id: 404b7577cee2dc302ae259604b163cabd9bfd4f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34fdd22c8fd9c5ebda999b5bb1bfe25f293bd030
Message-Id: <166543703463.28157.10735213495494881799.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 21:23:54 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Oct 2022 10:04:11 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34fdd22c8fd9c5ebda999b5bb1bfe25f293bd030

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
