Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C456939A9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 20:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBLTer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 14:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBLTep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 14:34:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6F310245;
        Sun, 12 Feb 2023 11:34:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AE0660DC0;
        Sun, 12 Feb 2023 19:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3145C433EF;
        Sun, 12 Feb 2023 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676230483;
        bh=0qFH/1c82I3Dd7quTmccfPrGYx7NXRc56IZp6bDNb1E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QTUzfFlM8vmYuECt0ISV9nO0mCRnmTWAn0r2+dhuD8Q3AVuG1xiwtOnBCITSrqAZt
         BueXRO4o9ntv6vOUodJIzlOexXheYPbTC9+DPc+8KTQ6D2HJXveavynkp/lIMbYtYb
         okE7/YmIYLfadR0Jh/44TE5xDMYuaHW/UqUNM7OmYfdsp+MVII2Rorg24Do/EJRl8P
         MUJr67NXtD/FfeRV+FtU4c2CI6aPoY5mL/I90me1k9gP1KAnEKMMTGV+TW9xa9DXOA
         fhGDvMRuDGmwFtnA7C2l2tU5ltmGfwMJ2luul8vDrSoD01cewJtTW9j0h2gmMjchQ1
         loA2ApGnTCBqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F3A5E55F00;
        Sun, 12 Feb 2023 19:34:43 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.2-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y+jGPeHQov5f+pXH@kroah.com>
References: <Y+jGPeHQov5f+pXH@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y+jGPeHQov5f+pXH@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc8
X-PR-Tracked-Commit-Id: 303e724d7b1e1a0a93daf0b1ab5f7c4f53543b34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2bca0ebf775453bb3c6b9c2149fb4712621493a
Message-Id: <167623048364.930.12526095906953786985.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Feb 2023 19:34:43 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Feb 2023 11:58:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.2-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2bca0ebf775453bb3c6b9c2149fb4712621493a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
