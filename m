Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8528606D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJUBmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJUBmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:42:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6F71A913C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 18:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA4BCB82A0F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C42FC433D6;
        Fri, 21 Oct 2022 01:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666316531;
        bh=XNx9+rvlsGEvlRUJaG20yjcV1nz98bS0gb/5ud1kOEg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LrhhaKWnqku9Tbi7mpYVl2q/ySbd5beYjRzpZxVPJAzHMlcOAb0VZ8ZKhTG/Sk9XF
         4iJhdAO9SovwM4JOoRelGFVi3PdrCWy9/Kc8m8s7KZHUvHHVUSnj4Ghq/57vcB9mUs
         lSBPMyfjrBGNsAT4s10tBG+WZiDWVrxWmRXnVByHvbuu4QRmzfN+6r3Zx13L6rFNmR
         v+LvnUZ07Fas+XAuvZsAEQ7GBEpfuY9mHTsAaNETuMA8Cgt9XrmzLFr2RGq+MNUFDr
         1czlAQU6d6u/FlSaHUIfgikDsEX/5hhcmMVucszDsSBBpjFYTpvKy1CcRtZ1OOdykj
         IJ+gM494Drbcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71A91E270E3;
        Fri, 21 Oct 2022 01:42:11 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.1-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzqUzVrUMtmXT1AQAkjec6DziLkuLriKZJVXb6aTWkhXQ@mail.gmail.com>
References: <CAPM=9tzqUzVrUMtmXT1AQAkjec6DziLkuLriKZJVXb6aTWkhXQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzqUzVrUMtmXT1AQAkjec6DziLkuLriKZJVXb6aTWkhXQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-10-21
X-PR-Tracked-Commit-Id: cbc543c59e8e7c8bc8604d6ac3e18a029e3d5118
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e35184f321518acadb681928a016da21a9a20c13
Message-Id: <166631653145.12255.14877763131527807255.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Oct 2022 01:42:11 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 10:37:33 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-10-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e35184f321518acadb681928a016da21a9a20c13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
