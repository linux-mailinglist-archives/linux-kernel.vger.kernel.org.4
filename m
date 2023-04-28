Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8AC6F0FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344704AbjD1Aux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344294AbjD1Aut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B522711;
        Thu, 27 Apr 2023 17:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7CC864080;
        Fri, 28 Apr 2023 00:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2852EC433EF;
        Fri, 28 Apr 2023 00:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682643047;
        bh=FFF2m9P1CQjKVnVHl4aB4ROJYypofTuO2nyZ5DJ1kxY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fST3sjn7C8QuKBICYVU4ogM2Tf4QdE1iEju0dI4KlrjLcNBv3RwNzgjTHNNCqSC3H
         OC1FoQkh4wxV+JFh2fqidv11nmXlzdLGVDduZLxBvMu45Gvp/npnH1SW2uXN+/pSVF
         cdudwH3fuj0ipJ/o0M6wTJs1geF10pdbeOhA6p0Wvlfzc1Ai5JG+bfauf1NX/K0ybO
         eKyQqB9MfJZe21zZo1i8cChbFtq8lgYECfjqoM69qX9Q2XdYueIM/9iOfEeMfPL8TQ
         FAs7W39EwR7FPFM+zX/jurtuk9MeQtaP7gJgm3CRBf5WcJLmfQw23eV4Wm3HC5suQP
         hhy9oD/lExjew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16079C39562;
        Fri, 28 Apr 2023 00:50:47 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230426093500.GA6891@alpha.franken.de>
References: <20230426093500.GA6891@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230426093500.GA6891@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.4
X-PR-Tracked-Commit-Id: 46e614cc91f7bd6f7872e434e6bcfda44454aac3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91ec4b0d11fe115581ce2835300558802ce55e6c
Message-Id: <168264304708.17833.8395063233236399822.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 00:50:47 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Apr 2023 11:35:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91ec4b0d11fe115581ce2835300558802ce55e6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
