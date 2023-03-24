Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2BF6C871F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjCXUyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjCXUym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C769D65AE;
        Fri, 24 Mar 2023 13:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 634DD62C64;
        Fri, 24 Mar 2023 20:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C710BC4339C;
        Fri, 24 Mar 2023 20:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679691280;
        bh=kC1E+4w7gcKWS4ITvOHDyUouZi8LK2u7KzOSq7QvCjk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sSsv8zO5zGumBoFNhfeePPtcG1cs4nuVkZvc9+htdP0Bf/nF7ojCNj5IfBeOsq8IL
         jetB5kLp6LNArY0GJoMVMIwJSKCMalAX/4mftDJJwge+K+JD+v0ipZsWUEXGURJO4x
         4KZaArqOw8rEJNIkHWrkkZvbX1vqkw22pNOyYYaEfjiWn8r+j4dLzmBtpvyhfT5IMK
         JyKIJXDazvamQC3a14X6aiMzIEzZCYGedK7kfSr8TP/xPLDBUbpJ9+Be4+Zko03z69
         UztWqmXMUtMNsAYo9mGLWPtL7ri+L0Lj/9lR1Tn+Pw8W+H1w8e/a4tW5pIa6ZcFUHI
         8hQ5xO+wR2zMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A858EE2A039;
        Fri, 24 Mar 2023 20:54:40 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i6K644j=JzU+uDcreEzv6KxFHav_MHw1TZvQNzvyoU1w@mail.gmail.com>
References: <CAJZ5v0i6K644j=JzU+uDcreEzv6KxFHav_MHw1TZvQNzvyoU1w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i6K644j=JzU+uDcreEzv6KxFHav_MHw1TZvQNzvyoU1w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc4
X-PR-Tracked-Commit-Id: 8dbfa057b3f8e8402f639c0bf5fcbc4e43a8b3da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1868d192d8f504f88e61a8e83164fce6e6b7190c
Message-Id: <167969128068.10856.2883256084558800635.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 20:54:40 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 17:31:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1868d192d8f504f88e61a8e83164fce6e6b7190c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
