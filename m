Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5B701210
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 00:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbjELWOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 18:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbjELWOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 18:14:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2C030D1;
        Fri, 12 May 2023 15:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EF0D634FA;
        Fri, 12 May 2023 22:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13C3AC433D2;
        Fri, 12 May 2023 22:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683929650;
        bh=OzaPbwHbEHyVHDM48cNTRPjjxoLJH+DKUek4pcg2/gY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BgOJammtyBqOBQDK/EkJG4nYr7KTzg/SOulPxWYKDkDTMmS2sfsB6EPcm6ltX6Gib
         IF7dZAb2N/fhABghJsyBGZdNCZzkB5zFRlXrBdjtbdAgvylSo+6ZPUnUxMtgR5EtYK
         Khh/FwPtdGnPSB2W1XeYasmnLLm1LyXqESbu3r3sGoMSPox31j4ByXpsG9ci8DRVD8
         vPuv55aX4T+PvuDrzIpyzxARf20X21UUGjkZkY4pP+QpbrlO487P2opSS5DgNJ3JO3
         0Spc9Vv7UNkd51oy6lHDZpf3F9X4oaRBLzqIyx8Syg1yKUQB1jrlpu/cxi6xx1cTo5
         vkgpPOltE/+aQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC2A0E26D20;
        Fri, 12 May 2023 22:14:09 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mv21PgfmG7N=mV33QMsAmF4eeV=A77sXrPLNSbMR=79FQ@mail.gmail.com>
References: <CAH2r5mv21PgfmG7N=mV33QMsAmF4eeV=A77sXrPLNSbMR=79FQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mv21PgfmG7N=mV33QMsAmF4eeV=A77sXrPLNSbMR=79FQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc1-smb3-client-fixes
X-PR-Tracked-Commit-Id: d39fc592ef8ae9a89c5e85c8d9f760937a57d5ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd88f147cb121c9c748ca0d4c5155a96e9d81e58
Message-Id: <168392964996.28473.12333015860903558034.pr-tracker-bot@kernel.org>
Date:   Fri, 12 May 2023 22:14:09 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 May 2023 14:21:05 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc1-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd88f147cb121c9c748ca0d4c5155a96e9d81e58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
