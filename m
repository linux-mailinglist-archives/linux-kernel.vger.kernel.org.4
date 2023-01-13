Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B46669E68
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjAMQnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjAMQm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:42:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78656C2A;
        Fri, 13 Jan 2023 08:41:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11E51622A1;
        Fri, 13 Jan 2023 16:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73003C433EF;
        Fri, 13 Jan 2023 16:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673628067;
        bh=8Jw6Zv7U7Hupx+S3ky3vCOoTqNVlIE3ZV7MNpwQC72Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t2fnuGskN5JweDBEfFO50xxUCO2F2hLRS+kcHpj/eU5isFbtnGFIVwcaPFLZtq3qr
         hLGignOxf4pQVmkYBvmjI1Rwt2MofOdVeJMCBzg4Rim1xZIWN8wbag6vPW/wVBKEND
         DjJVP40u7EHDwCAicgT/suGJIsBCOkh/y11PaYyVl3KYAH5Y+heNu+GLpMJ1Cm88l+
         51FUTAiel0ZxacYFkT8B8qlNvGQVNf8mrN7fErg4il8xsfVBmGhLXa6eIDBrYXvqOT
         3bVSGXfpwwtQH1y8vrw/C4a+sRhuI1mJm3Y5ARnXPdmP0m7uRfLpFbQLRDui8e00cw
         Tp03XCLcFX8qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 610FDC395C7;
        Fri, 13 Jan 2023 16:41:07 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877cxqs8pt.fsf@meer.lwn.net>
References: <877cxqs8pt.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877cxqs8pt.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.2-fixes
X-PR-Tracked-Commit-Id: a33ae832bf3f2ac33e2e44b99f76130d3be848c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40d92fc4fa81a93b4659b98512dcb9d0ccd94cfd
Message-Id: <167362806738.11257.4202660184587676173.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Jan 2023 16:41:07 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Jan 2023 09:25:02 -0700:

> git://git.lwn.net/linux.git tags/docs-6.2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40d92fc4fa81a93b4659b98512dcb9d0ccd94cfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
