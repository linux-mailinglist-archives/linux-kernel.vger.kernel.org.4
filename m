Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A712630FA4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 18:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiKSROz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 12:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiKSROu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 12:14:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE23C13FA1;
        Sat, 19 Nov 2022 09:14:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6912560B97;
        Sat, 19 Nov 2022 17:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9E61C433C1;
        Sat, 19 Nov 2022 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668878087;
        bh=NhqpdXk51RksqlQ0L/UxzSZ1YonXm79XkajXvU6qdvY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aUdEtrmhwaOeaiAcjMmv8L4v33UL6GY1Bk4ddgVT7HSgpexO1hav9Xmdoh2RGybiB
         WHPiAmP+F3HuOlrKI6AUQQVhSIgDJrDviYBkaUBrOvfF2LcwDRDGnYDFIIyHTIKZLM
         4D7NJh9mJ2+na+VGxeBwDnXtnNmkuOQAXfAwT2of2FoMeOiB0T8enEzaEA0/xeqfX3
         /Ook5FSHw0zPpHMQxrN5BvAg4312K7Jy0f+XkNVIGgi7d7moAcZe1Ydr7ao/se7HGt
         Hx6D8ZwLOxC2fdHX0RDgcgFcDt6HGlUvo5S4bYXydn0ufBq4Fq1A1lkoDTZlpuMV4J
         NZIktHDpw75DQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8782C395F6;
        Sat, 19 Nov 2022 17:14:47 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvp4qcfELt+W9khm=LH3TjyPDY7fhhMSA06cJdQfEQ23Q@mail.gmail.com>
References: <CAH2r5mvp4qcfELt+W9khm=LH3TjyPDY7fhhMSA06cJdQfEQ23Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvp4qcfELt+W9khm=LH3TjyPDY7fhhMSA06cJdQfEQ23Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc5-smb3-fixes
X-PR-Tracked-Commit-Id: a51e5d293dd1c2e7bf6f7be788466cd9b5d280fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 926028aaa3827554096d42ffb0c2973bc7f5e80f
Message-Id: <166887808775.22538.1578216928097388970.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Nov 2022 17:14:47 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Nov 2022 23:02:22 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.1-rc5-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/926028aaa3827554096d42ffb0c2973bc7f5e80f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
