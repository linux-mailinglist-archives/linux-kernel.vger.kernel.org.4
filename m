Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112EC6A3405
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBZUk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjBZUkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:40:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BA98A59;
        Sun, 26 Feb 2023 12:40:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0B7D9CE0EE8;
        Sun, 26 Feb 2023 20:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97AC4C4339E;
        Sun, 26 Feb 2023 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677444013;
        bh=NswbH32jMAiSwh/5yF45jnnr6v0H9XhHaCfbJEljK5A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jRUMBXnUDEvOso7YMfunXGC6CYm0OMsUMUTXU7SltF3xB6Lm8BHmh6lDw6NY2YEDX
         l3nAj/gS7pViFeq1C0zayP2iX5yR43H9KYyTLbelqTDcmRncuC0H71moDELf9Py6Fi
         TL4HnDlMrxM2874Xc4Q/xb3CQ4+NTEqo0uarnpJE5jzT6iXBgQixkVqktaskEin3FW
         sGaUBshDQ4a2HenB3Wqq2WiXKSlOnzghvpWJD+o8ZfvVZWu2wVdQDHKi5eY1Cdygd2
         wFqooPxVOKJCMC3W4T0ActTqGrk6Sp4LDJcWUtd4JKiPa9PnHmbBPnnLr/F2fCgHKD
         /MTgIX/ZYJ7gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84AE3E4D010;
        Sun, 26 Feb 2023 20:40:13 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230226171505.298995-1-andersson@kernel.org>
References: <20230226171505.298995-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230226171505.298995-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.3
X-PR-Tracked-Commit-Id: fb80ef67e8ff6a00d3faad4cb348dafdb8eccfd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc38a46de76e15d20bea5768e99af17b65a9caeb
Message-Id: <167744401353.16333.7378259706406093561.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Feb 2023 20:40:13 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Feb 2023 09:15:05 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc38a46de76e15d20bea5768e99af17b65a9caeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
