Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB65FE069
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiJMSJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiJMSIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1F3160EDA;
        Thu, 13 Oct 2022 11:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E10356194A;
        Thu, 13 Oct 2022 18:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FD0BC433D6;
        Thu, 13 Oct 2022 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665684015;
        bh=iqd+0wKdSoxapJMe/zP/C6J5LQt/EdnYeEbMixztd+s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pn6/Qs5QRe6KYIsgE605CFxvz07+3SCjk/QQKy1GQjohcWWksPeGD0GNohFsfPsy8
         dFv99qZdO7di9aUzPFFT+p7pdE/LSbonAOybQPI9gV5WlM99YnwRUBe0y8618vVJ7/
         FQJdGN6nPSddPxdOKebGuXoAWay0S9DjvX8cW6tAT7UWfRJSw049oGaHWt44T515Wh
         unH8kfBgePyFLCdF8FUgbRmCPMz80P1dfk1bdxwjh3J3cXA4ZOcg6sUtt+nRODgcra
         9CcKUmsDcheSgODGix2/StRbOMCobOpkG6+Y3hB50JFpvq8o8wlBEHdBHVdxwdypfB
         gNKg+0BbNzA8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39ED6E29F30;
        Thu, 13 Oct 2022 18:00:15 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pmevism5.fsf@meer.lwn.net>
References: <87pmevism5.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pmevism5.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.1-2
X-PR-Tracked-Commit-Id: 877d95dcfd0a56102d4b97a9691115f5fb5e9ea3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2b220ef93ea34ff6ce48fec382689cf02099f39
Message-Id: <166568401523.7515.10351019015327844274.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Oct 2022 18:00:15 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Oct 2022 10:41:06 -0600:

> git://git.lwn.net/linux.git tags/docs-6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2b220ef93ea34ff6ce48fec382689cf02099f39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
