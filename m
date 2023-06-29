Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEF6742B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjF2RfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjF2Rel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:34:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA035A1;
        Thu, 29 Jun 2023 10:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76594615C1;
        Thu, 29 Jun 2023 17:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC415C433C8;
        Thu, 29 Jun 2023 17:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688060079;
        bh=jGjORUlUum0dLuRw0KbyNgBepCIsaEuN+vnElMzsqck=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YkHSUmSGqjEJCuNJNcIA+TfJiUy8YeA/2DASIC5T8p8SDUdqNDdPhmGq97asgcMgl
         C+o4D6JE+vLArHY3uBBiOyvtkxsZA5D4rjmpjQQ6kjE+yIXu7sj9epkN94wWIuItfg
         MLKrhhTiTIJWGV3Ycp4nxWtFTBQKgx5vGTRrQG5ifQjJ82SnQjEl+bYIhDsrmi+5Ut
         nisdxKcKvQr4joZdogGwJgrlPUlwlaNQfSMFK40u9KA8ArR8JmWsvsRP4eGNdPeWBi
         mkikag+s8bg/IbNV7sTM0CIJWrfoLeUBsHTkOGUKLZMI3c2U2XbJpgj9fA0GBZJ4aG
         XGqMKU09Rs28g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAF3CC43158;
        Thu, 29 Jun 2023 17:34:39 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627034511.166918-1-linux@roeck-us.net>
References: <20230627034511.166918-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627034511.166918-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.5
X-PR-Tracked-Commit-Id: 90fc660e8479c5da5bb99a4fb3e0d266fa041b15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acd1d46b0ddec686d4170b2205bc08c88d5d4d74
Message-Id: <168806007982.7356.2802670719175943162.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 17:34:39 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 20:45:11 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acd1d46b0ddec686d4170b2205bc08c88d5d4d74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
