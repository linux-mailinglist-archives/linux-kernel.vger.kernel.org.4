Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7366064A9CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiLLVwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiLLVvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:51:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24891A21B;
        Mon, 12 Dec 2022 13:51:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F27AB80E7E;
        Mon, 12 Dec 2022 21:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 425E2C43398;
        Mon, 12 Dec 2022 21:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670881895;
        bh=1bdEEAE7l0+6/7HzoDXdqyJ37o8BHR2uGkVS1LSpcSM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Szcxgk6umBd5yDx57ogrOyTsf8Z/zgpohQPg+p4rYx4p6O1eI9iwVZqVT+tsfR2m9
         fj71SRLo8Z5mbSlxNo6Cg3ISDqxYhzSVN6l7LRp3dKHJX6P6smEsIip4TODllo4Nwz
         p8j29btkBJm6xFEupg7JhHPW4sn2FxogcaJt6Vw4QDTmcqpP83m4B+Ppzy7hgeudfs
         0JRrwZnV9/U/ow+er6em5vfXiTvp5uxg4ef6mDxYV5GoJ790BXGkAb5U9ySMqA5aea
         36r40RH/1HrzkLrHLwqlG5+mBITKeELn0TU0QPL7HUQs6GCIaos37d8Usz8MIzqvvK
         aUBKpBtubMUqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A8ADC00448;
        Mon, 12 Dec 2022 21:51:35 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI and PNP updates for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jVU0jbU6KmQNQ7hUZp=kA+CP7fVibRnb1qCVjHRH2Xow@mail.gmail.com>
References: <CAJZ5v0jVU0jbU6KmQNQ7hUZp=kA+CP7fVibRnb1qCVjHRH2Xow@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jVU0jbU6KmQNQ7hUZp=kA+CP7fVibRnb1qCVjHRH2Xow@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.2-rc1
X-PR-Tracked-Commit-Id: bee74dcbd3908291f4bfff3c81a52d52dcd48814
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 456ed864fd907d5f5484c7c4795da212537842fe
Message-Id: <167088189517.24990.4948443203680839319.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 21:51:35 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 17:54:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/456ed864fd907d5f5484c7c4795da212537842fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
