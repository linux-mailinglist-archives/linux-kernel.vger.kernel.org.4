Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2B74BEF0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjGHTSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjGHTSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:18:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE85DB
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 12:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EA496068A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 19:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90089C433C7;
        Sat,  8 Jul 2023 19:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688843915;
        bh=kOhZCU0dKd2VqO/DiSU3QXSi1Bpj8F5itcj0kNknutk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vabfjp6iHFXSTBjFqiGnZBH9heLFq6L0uwgOJmct0NorcB7N1DZzr/tvqtqxki3wu
         nvtvjceDvD51sxAww3oRPAx5zmelmW+4ibyrIRhcn+vsmM4vyxbS4n5SyBVtoZvpOH
         aDalI1HNXlMMS6CaayPtNi4enejuwaJkH6Ez+YGLjr/2oKJ0jYFPY1kQAsAc7hLfNb
         +Qac7e2Ja82wMaxXWb0+BvxQcwvUWMEi/eU+9m0+wxZEAWl2rjI9YTCwTeTjDLXIfb
         aSlk1gumTSdiqXzi1NqUrGyhokd7ZaypWFmDS2nWJTM2u5f3OIQDLHgiHaL9tuPS0P
         s5z4KuIm4C3LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DD86C4167B;
        Sat,  8 Jul 2023 19:18:35 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v6.5-rc1-fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202307071111.63B0BFB323@keescook>
References: <202307071111.63B0BFB323@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202307071111.63B0BFB323@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.5-rc1-fixes
X-PR-Tracked-Commit-Id: 01f23c5f1526f5b6ff744887aa511b9e69d4401b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fc3b8f082cc2f5faa6eae315b938bc5e79c332e
Message-Id: <168884391551.19389.3081153215458827403.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jul 2023 19:18:35 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Jul 2023 11:12:28 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.5-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fc3b8f082cc2f5faa6eae315b938bc5e79c332e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
