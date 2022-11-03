Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B99E61878B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiKCScm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiKCScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:32:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F02180E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19F52B80B03
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 18:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C32E9C433D6;
        Thu,  3 Nov 2022 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667500292;
        bh=2NyA4ERgTsQNrECcBYv8TSkJKybWzWdNA4MPIH0N2G4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IoCAnSJnLuvF8NAMTfZIrgj+qKcQaiKHeE2VyVTg2JXvDEwiCKwqEK7QvK1ITuOM8
         B+AK+hcsj5pmqKNQTHvKb62isswoPTZ78bUyXeJHmFqMTKxbjc/5qS5OiCVoEz5od/
         SnKoZqkYTdzvQoveh6JTFL6CEG56LzVQcALb1R7oKSAwdRQnHhUI36CYhiBN1ynfu5
         cG4jaPkd4Cc0aF99sOBeqCP12DHICviyvuLkC71MDPL2l3pAEuHxU9R3mxwOS6W+gv
         5RSReckjTDI1RYlCuT2W0QXh/xKlyJq+LJOKDvpzHl/ahL2tb+qoT18dfQpfyLfYRr
         S/vsSE2w0U7DA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1237C41621;
        Thu,  3 Nov 2022 18:31:32 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o7tossaa.fsf@mpe.ellerman.id.au>
References: <87o7tossaa.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87o7tossaa.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-4
X-PR-Tracked-Commit-Id: 02a771c9a68a9f08cce4ec5e324fb1bc4dce7202
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d74039149e0062e4ed25738d6e3e06970a38809
Message-Id: <166750029271.3912.5527083554346380023.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Nov 2022 18:31:32 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        schwab@linux-m68k.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 03 Nov 2022 13:09:17 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d74039149e0062e4ed25738d6e3e06970a38809

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
