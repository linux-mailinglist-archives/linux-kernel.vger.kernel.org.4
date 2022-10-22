Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB2E609062
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 01:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJVXJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 19:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJVXJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 19:09:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58EDD73FF;
        Sat, 22 Oct 2022 16:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9574C60B5A;
        Sat, 22 Oct 2022 23:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1CC1C433D7;
        Sat, 22 Oct 2022 23:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666480140;
        bh=cz8/25HdrJuSpWBSh/ESrWOVq1qtgiL4RiTz4cHPWnk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aCD4w6gUj2vPotDBeUSnVDJeaJlzFFB28gLxEM3jFZBLdWATaMUScyW/CyqzUYxl7
         zcPH8LQA0cGl33EiJnnWqz0Z+IdqlEXrcP+hpidIe4RQt1l+PMKTGgOMLpanmsgNfp
         /QORsPOgXlIg96NtUL3BidwUK4fgr9iybfCWtl346BikAgJ8NkonuL0MP8inMU/PwU
         4CdDv93ME0uGuN8S+cIcREOnZKUBIhZMNHbK5ImZtYE7Esx3skSjHmJKyia8b+seoo
         9HNLg9/gDK3MPB49zxeNa520JnCYIVcDFDiDVZrwhjJgONgfAsfX/D3k96tS/Fy0zv
         T2WaRFnRkZF3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7354E270E1;
        Sat, 22 Oct 2022 23:08:59 +0000 (UTC)
Subject: Re: [GIT PULL for v6.1-rc2] media updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221021220748.144ffe20@sal.lan>
References: <20221021220748.144ffe20@sal.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221021220748.144ffe20@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.1-2
X-PR-Tracked-Commit-Id: d67614f276c1499ad939fa5c1aadd35498cc6b34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3272eb1ace32627d0ba1d20373fae246f46770ca
Message-Id: <166648013987.24083.16214942280384848222.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Oct 2022 23:08:59 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 22:07:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3272eb1ace32627d0ba1d20373fae246f46770ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
