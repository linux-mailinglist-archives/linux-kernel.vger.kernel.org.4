Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A56B709F66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjESStw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjESStq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78409E5D;
        Fri, 19 May 2023 11:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 039BD65A90;
        Fri, 19 May 2023 18:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68217C433D2;
        Fri, 19 May 2023 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684522174;
        bh=ejwhx00uTPJugLsBDdRTaOpyPPkvr2Aw6jZKRp5dkG8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZH2EF2s8bNUSRfZF550jMqS06JekyY+CoIFW6T1sKbvV3nN8e39wWTFv0YA2+L2CK
         DchF3sPk/yx3KqwWtrwptH3JoJaPz7zHRlg+y5UJ39R92Jg/6DzUAPduAJvN9vwsBJ
         eipupLTalxyxmV2zEk1rlboTdsEZx/H1oqI4mpFij0bp7uRg81P1RWiKwEN98vxgwd
         VvyOSHUIqtoVOIUkqsRCoqAyAk4YXTKVwDYJaZOmK2nqr/xUYWRUfLTT9cpNJReyyu
         j/Rm3SnrRz7pMb8feYva5tfN48i6dNcwjYkMyhsYCL8EO5iH5UoIsEcdk9MMmKLtVe
         bDdUWRW770ngA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55A02C3959E;
        Fri, 19 May 2023 18:49:34 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g9RmqJm=bpc9SQryYo4r+9Ctj7_aXQcfFRWTS3=xs6qw@mail.gmail.com>
References: <CAJZ5v0g9RmqJm=bpc9SQryYo4r+9Ctj7_aXQcfFRWTS3=xs6qw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g9RmqJm=bpc9SQryYo4r+9Ctj7_aXQcfFRWTS3=xs6qw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.4-rc3
X-PR-Tracked-Commit-Id: 71a485624c4cbb144169852d7bb8ca8c0667d7a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c83063298b206dc806a7f1e8724336e4962daeed
Message-Id: <168452217434.776.6796756536506541239.pr-tracker-bot@kernel.org>
Date:   Fri, 19 May 2023 18:49:34 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 May 2023 17:28:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c83063298b206dc806a7f1e8724336e4962daeed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
