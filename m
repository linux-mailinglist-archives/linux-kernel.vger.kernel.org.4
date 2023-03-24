Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9842E6C8929
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCXXSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjCXXR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031561ABD7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93DAF62D07
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 058EFC433EF;
        Fri, 24 Mar 2023 23:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679699878;
        bh=YmXZvTX3a9RksjyogmVk3UHGVjX2yueTOTwg7xVEE44=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f6EZp5XWTJrZfWMVb3zgPAgl/HUI+BUUwa6ekensjT8BGDXe+tfDwrur1Y4xWS3QK
         reD+qYaBoM5JDZJirY9Gw5/uuowkVWgEDDUat+pSBZjBm2djHMs0GT2PhbmG41Tjvv
         SknDq5KubB/9Pui/CIkPcFbn8Cv6+QuZGscOVPm0/BetWDFMo/oSjXpwCzPtXqRTH7
         4IzCPnqD5wBXGvnGO/1F2bHny4xAoqpWvjgYf2NOQSB5JnQElP6U88lT/1mq87gjYm
         4Lrd92UYvndXannMXYsw0X4kJIpOTLhFV/l8E+WgXZD5agD9KrEfQuSynAzrguCnMQ
         gE36jZIRA2KZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E808DC41612;
        Fri, 24 Mar 2023 23:17:57 +0000 (UTC)
Subject: Re: [PULL] drm-fixes for 6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZB4QlRqxz93s/Pgp@phenom.ffwll.local>
References: <ZB4QlRqxz93s/Pgp@phenom.ffwll.local>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <ZB4QlRqxz93s/Pgp@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-03-24
X-PR-Tracked-Commit-Id: 08570b7c8db6d9185deccf5bcda773bd6f17172f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37154c19dd79966009befdcf2b499099e3cbbe9c
Message-Id: <167969987794.13977.13493727092643599930.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 23:17:57 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 22:05:25 +0100:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-03-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37154c19dd79966009befdcf2b499099e3cbbe9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
