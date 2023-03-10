Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEBB6B32B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 01:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjCJAUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 19:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCJAUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ADFF4B65;
        Thu,  9 Mar 2023 16:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8288F61D14;
        Fri, 10 Mar 2023 00:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E57C6C4339B;
        Fri, 10 Mar 2023 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678407617;
        bh=1erPvfc/QLqM7MHKi9s/IDbH6aDGxqpQ3SXGGXtIkzY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DTCdywgRUvz7XUGCHBe8YJgPy2QXRtbI1vOZHhAmRfb/p3OlKxdjSa8jgyIt5Xq1+
         XgbV7lEhpTVkdKvbdxZdFwEenTY9uNeFwCkldMxcH9vIHndvsD3Bz2YwVU9jmnlg/E
         SMtHsoqeVp/mPa6jw6eUCaEUnKAPIwLA642AsovmN+TcOm4ZpD+/sPlNlIdbFeAHeI
         lLpr4N7KC53te9bOwRhu6Tw3ExZASm72RWESy3ALxMF02vpu6cNXzCIqmtK1uuo9aj
         Ol0rv704p76UT5Nw1PgScUU0rpZ7ZLob1IAm34vmO1U+A1VJRH/nyfWS7LajdWlsno
         Fwfd9xilNbi7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA70BE61B60;
        Fri, 10 Mar 2023 00:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btsdio:  fix use after free bug in btsdio_remove
 due to race condition
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167840761782.25154.7899078093044397807.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Mar 2023 00:20:17 +0000
References: <20230308164501.2734985-1-zyytlz.wz@163.com>
In-Reply-To: <20230308164501.2734985-1-zyytlz.wz@163.com>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  9 Mar 2023 00:45:01 +0800 you wrote:
> In btsdio_probe, the data->work is bound with btsdio_work. It will be
> started in btsdio_send_frame.
> 
> If the btsdio_remove runs with a unfinished work, there may be a race
> condition that hdev is freed but used in btsdio_work. Fix it by
> canceling the work before do cleanup in btsdio_remove.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
    https://git.kernel.org/bluetooth/bluetooth-next/c/61115bb7574e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


