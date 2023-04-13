Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F2B6E1740
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDMWVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjDMWVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2791D26BE;
        Thu, 13 Apr 2023 15:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3CE26097C;
        Thu, 13 Apr 2023 22:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C3C8C4339B;
        Thu, 13 Apr 2023 22:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681424477;
        bh=0rrr7OdSB9qE/D5AdQXC5z3zw4NJw/nKCU+KXyu3Z/M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VE+wT2xQPlVha5tPRejIf99t3E8olk45TWRwgDSArwzo9t9JTFWgW7wb3BQJBvzUs
         QBy5DC8UMtLnZvuFse3IIoS0g6V5Gu5YyJXyJhBiNAFLX9x29j+jU5XDP4u3EToJKl
         OuJLM+Sq69QJIg+VD48taOb6pflL2lKvQjpHXK8OHDtL7A2BLeD3aAUAbR3b5pfmeA
         zr1t6T0Y/om80ck3W3ClMs1FXBAL6Ig8hbBLlIYCL8Fpu3csAk6YA/0DcAujrOCeMa
         E1GMWFvdr0j4CK2yyEmFzxvuBxuSvk/cUpVu6QtyAFyAlfauIoRLXmcG653z4awlC/
         m/D2voeavzR5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE692E29F3B;
        Thu, 13 Apr 2023 22:21:16 +0000 (UTC)
Subject: Re: [GIT PULL] Pin control fix for AMD laptops
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZsoGihp-cVVKTMPFBPBj_7_ScaYJZFU6jZNugucyx3qg@mail.gmail.com>
References: <CACRpkdZsoGihp-cVVKTMPFBPBj_7_ScaYJZFU6jZNugucyx3qg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZsoGihp-cVVKTMPFBPBj_7_ScaYJZFU6jZNugucyx3qg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.3-3
X-PR-Tracked-Commit-Id: 534e465845ebfb4a97eb5459d3931a0b35e3b9a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 531f27ad5e3a85128a9668c9063c58fc35d4e89b
Message-Id: <168142447696.24378.12217055712296399050.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Apr 2023 22:21:16 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Apr 2023 22:09:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/531f27ad5e3a85128a9668c9063c58fc35d4e89b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
