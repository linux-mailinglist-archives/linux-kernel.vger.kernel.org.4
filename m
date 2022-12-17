Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C262764F974
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 15:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLQOkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 09:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiLQOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:40:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8951BFAEF;
        Sat, 17 Dec 2022 06:40:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22AAF60B08;
        Sat, 17 Dec 2022 14:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84E7FC433D2;
        Sat, 17 Dec 2022 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671288026;
        bh=UXq0LaLV5pMMCRNf/H09NW3TVCWbmGsCCuJphrbERCk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YORCZD2pHW0PyAnmhJBWeL0dutiZ1iOrVPIBbaMteRu8F6Qrd2Uqxx9ZxzTWCaJZ0
         MiYpAfR7ATaNCgfC0QZQ6vJugPeNfgeK1411HIhF8mRPuDL2NglHIu9A5QUKVoQB2h
         AORrhr3PoY4w/IvOv+6nJSZ8495qf/ctTbQ8xu0AopkBjYLE5HSxoIKB4sOKxr7ZKt
         YoShw8kXtSp97IwHIN/7t8AaHFoHkElVK9XCBJA+WURcjYtOb66Cxc/68AZ7n0BsJn
         MgPX0CFIjyt8DOOazDkv5WluP3k3udiKPhLuT3zQPrbbr9l8L3VPlh4XdxDPwyAmNh
         YdM2bRQMp/H9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70897E21EFC;
        Sat, 17 Dec 2022 14:40:26 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v6.2 release cycle.
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221216170348.GA21326@www.linux-watchdog.org>
References: <20221216170348.GA21326@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221216170348.GA21326@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.2-rc1
X-PR-Tracked-Commit-Id: 9ec0b7e06835b857f892feb2fe6121db1393425d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b611996ef270a88ebb350c82832c4d76913887e9
Message-Id: <167128802645.28535.10374071229454968762.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Dec 2022 14:40:26 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Eddie James <eajames@linux.ibm.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Runyang Chen <runyang.chen@mediatek.com>,
        Thomas Kastner <thomas.kastner@advantech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 18:03:48 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b611996ef270a88ebb350c82832c4d76913887e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
