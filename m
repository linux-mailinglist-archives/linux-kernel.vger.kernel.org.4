Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7626A899E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCBTjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCBTja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:39:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74965193EF;
        Thu,  2 Mar 2023 11:39:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1427BB8136A;
        Thu,  2 Mar 2023 19:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A759EC433D2;
        Thu,  2 Mar 2023 19:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677785950;
        bh=6JwMPUWd00//r4UeQvZqh9mQS5U5zy8fqsW8CNRhtfk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YOkspzMtkNDvZfhZU2PqlsY3teOh+zpEWv6rJUdRl3SPY7qnk+O6DxqR7+jravHIa
         C0dOAUYYLU5yNum+R+MTNR92mVirsyndT91xouUjM35+PpibJB1tMsaBhcBWUn2j18
         ZrXSen4tWkpBYM8QzTgu7EXizxGIG5XZnTMT8d7HkKGgVLB854c/UuMWuNrjMF0xD0
         VRTz2+omD5/40s7AFAz9Wa6X5+eTBnPUd4P/LoWBkCtvGogf9Joafx5qdLx10ZSbAD
         cGMB2mGRxAS/eb7VaR/x1DVhN1KNI++k7PqcMWf82J90NJGNDJE02SBv72wyaa4Vun
         sUb6senWiQMgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93D15C43161;
        Thu,  2 Mar 2023 19:39:10 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v6.3 release cycle.
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230302162537.GA3071@www.linux-watchdog.org>
References: <20230302162537.GA3071@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230302162537.GA3071@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.3-rc1
X-PR-Tracked-Commit-Id: cf3be7e82b129ed34f811f116f2b113f6299d449
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9a01e1238cf5b477ec6aa54855356e518998991
Message-Id: <167778595059.8121.3076175281513742141.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Mar 2023 19:39:10 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Andrej Picej <andrej.picej@norik.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Chen Jun <chenjun102@huawei.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        George Cherian <george.cherian@marvell.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Li Hua <hucool.lihua@huawei.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Primoz Fiser <primoz.fiser@norik.com>,
        Robert Marko <robert.marko@sartura.hr>,
        ruanjinjie <ruanjinjie@huawei.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Thomas =?i so-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Mar 2023 17:25:37 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9a01e1238cf5b477ec6aa54855356e518998991

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
