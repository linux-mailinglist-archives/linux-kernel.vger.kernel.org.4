Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BBF6A8890
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCBSeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjCBSeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:34:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98414ECDD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6598761632
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 18:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB7DFC433EF;
        Thu,  2 Mar 2023 18:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677782047;
        bh=6gVVes2X4miBd/NtX5/hnM44N7puNWeSEgOTa/4bpl0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gs/ARr2G+j4YwDz+hISinJ7Suz9EcIPi9AlDZp/+4WBf1L2FchiLDvRtU3p/CvHHo
         O7aqxY8ZSnPZW76cd8sTdeBLHmXqtEzDEr6nf/YD608G+LHj+maox2zBEWzwhm/31I
         U4Aa3uaIPsVTt3yULjvR7/jAe2LAN5WST4JZ6RGQ2+DWLGPahlzQkzAW4xgzdL92pi
         D1UQBrhLMe/gf7C5h5PVDJ5ktOa3sSmHWpIqo4cdUA6/WxH0g2OCNjgXtFZCXCjEkv
         AQXBnc3W0US5zs0tsX7N3qTdpCGGfJTdzga7/3OGXACc5rnb6sRKsrFL5LZjtnDJMb
         N0jmGbi7qT5ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B997AC43161;
        Thu,  2 Mar 2023 18:34:07 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230302123413.211900-1-ojeda@kernel.org>
References: <20230302123413.211900-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230302123413.211900-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-6.3
X-PR-Tracked-Commit-Id: ddf75a86aba2cfb7ec4497e8692b60c8c8fe0ee7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6972633c58fd13c02dcaabcb6be380a98feda9fa
Message-Id: <167778204775.4243.6618689601764667351.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Mar 2023 18:34:07 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  2 Mar 2023 13:34:13 +0100:

> https://github.com/ojeda/linux.git tags/auxdisplay-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6972633c58fd13c02dcaabcb6be380a98feda9fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
