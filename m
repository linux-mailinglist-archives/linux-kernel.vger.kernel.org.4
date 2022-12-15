Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745CF64E0D8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiLOSa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiLOS3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:29:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906344D5CA;
        Thu, 15 Dec 2022 10:28:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ED76B81B0B;
        Thu, 15 Dec 2022 18:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17CEBC433F2;
        Thu, 15 Dec 2022 18:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128933;
        bh=cQAzEIvaQ4bGZ4cz3i/Uwnhd5yk4LNogwTN1klWJH68=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cVvV6ee9SgzTBWMenRthkzclDKDk2QtodeB5+ymrJv6XbMI+O+g30wQYPk7Ay9vvH
         vi2v3Yk5w2OzGwrTT6hlDC1fUjFo/hu0z9PXxTW3PBY6/lC5Z4zlIwIcceKte3WMEj
         ThFVyJRQ3XXHG7u638WgPNqmkkTmByONf1Ivdp0eSpEhHHuQI/hK1NhB4+vJfdzf85
         Osvo/mhmmFqYZ4GtdObefNp90nV1ejngHG61bDWq/rifAYf5Y5BBpdJURqv9I91gF2
         bVdeCz79tJNYbgzuB+Ns5020VOibR4sqMrSKiKC4kPXuEflwyeK9g3SSUVH+I4dBQp
         HdQNCEZcmO9yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 068BFC197B4;
        Thu, 15 Dec 2022 18:28:53 +0000 (UTC)
Subject: Re: [GIT PULL] More thermal control updates for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hu5P+xmLnwhTN1S1mXfUC0ZNzPdiuK_1Ebq29x8aa8Ug@mail.gmail.com>
References: <CAJZ5v0hu5P+xmLnwhTN1S1mXfUC0ZNzPdiuK_1Ebq29x8aa8Ug@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hu5P+xmLnwhTN1S1mXfUC0ZNzPdiuK_1Ebq29x8aa8Ug@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.2-rc1-2
X-PR-Tracked-Commit-Id: bd7bcc4f963c8898176ad864288959375154e038
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 601c1aa855a686643259c4a34e96ee692cdaf01f
Message-Id: <167112893302.20649.17355760380342337963.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Dec 2022 18:28:53 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

The pull request you sent on Thu, 15 Dec 2022 19:05:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/601c1aa855a686643259c4a34e96ee692cdaf01f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
