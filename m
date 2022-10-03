Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9AE5F3942
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJCWoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiJCWoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:44:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E0258DFC;
        Mon,  3 Oct 2022 15:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 204C8B81168;
        Mon,  3 Oct 2022 22:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E01A3C43141;
        Mon,  3 Oct 2022 22:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664837045;
        bh=Fb/GKQhGHXzGPg6zfEEDq3122h1fYGa/WfLD17sq02A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CmrKOJC57tSDrchvIQqs1l4puHUBbSxzzTKb+VWH5hfUH8iAqnPHrOFSboXfaj67I
         MqD4w3IB4aetInpOtEGD37feWtrlm6dZYmyTrKkok/dnDm4fX1HP4TD05Mi616l+io
         NTEPTRfWoBmvoMO2fNHn0cNZMllZF2vCOTecAkdtYxruwMY+gxo4ghJoejAlcvKRsZ
         aBkAmBQWqp+boAbfuaz6UzUpvrhe/cbaCocylQh6JvBWc9U7Kecfx3wVzeyU/n4E+D
         pnrY2qJQkwWLaI2ppRVbsUN7V1uzksfOf8pVO6P6bJ0teUpDMROjZ4SgntCBDBv9SG
         vsMfG0mnTHJDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC0A1E4D03B;
        Mon,  3 Oct 2022 22:44:05 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iD8M=qYc32EY96vYSmjTaEz=M357PVvATSQvryrzh0Gw@mail.gmail.com>
References: <CAJZ5v0iD8M=qYc32EY96vYSmjTaEz=M357PVvATSQvryrzh0Gw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iD8M=qYc32EY96vYSmjTaEz=M357PVvATSQvryrzh0Gw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.1-rc1
X-PR-Tracked-Commit-Id: 2e70ea7fb9873e642982f166bf9aaa4a6206fbec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5088ee7251e5106a4efa9588a73866eb4b4154e
Message-Id: <166483704583.27150.13930332052495405734.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Oct 2022 22:44:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Oct 2022 21:57:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5088ee7251e5106a4efa9588a73866eb4b4154e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
