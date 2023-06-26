Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1473EC00
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjFZUmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFZUmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:42:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B512412C;
        Mon, 26 Jun 2023 13:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF4560F59;
        Mon, 26 Jun 2023 20:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74434C433C8;
        Mon, 26 Jun 2023 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687812134;
        bh=gOj1k9JojrNwRP9mT37pNzDg/rLxVjtZQAF51Mcy+ew=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kn0aopctOVfmLUS9K0QnhWSG70BVPy1jSGhOy24BBgYtctIho+//6ZpNbZJ32NrIp
         BdrBuF6qQckboalLHd1ZqruaYaMQTE9fUKoLJQk5E62wTNA/O/z0TycdbC7jwhVegh
         z3IVe0Wk4e5weRLv12TpAtDn6OJ8CKx1HkpRIyLlOcni3MxZEanL916yc+R0/l5Zmv
         Gaim8qQFNVQiRAL+8YrgV3xdFA+fkGfe91/KtenF/jxYIKr96KcusTJ3739jToydhG
         FKbHcCYvBxkfvbYhQvJDzBXkOWf+6aX/dmSpXd4OehrABm5kSDtpcixtNsnZ7SAhJg
         BSeJ68E92KRTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 530F4C395E0;
        Mon, 26 Jun 2023 20:42:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_conn: Use kmemdup() to replace kzalloc +
 memcpy
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168781213432.29844.16837505476926129837.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Jun 2023 20:42:14 +0000
References: <20230625084513.6319-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230625084513.6319-1-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        abaci@linux.alibaba.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 25 Jun 2023 16:45:13 +0800 you wrote:
> Use kmemdup rather than duplicating its implementation.
> 
> ./net/bluetooth/hci_conn.c:1880:7-14: WARNING opportunity for kmemdup.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5597
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: Use kmemdup() to replace kzalloc + memcpy
    https://git.kernel.org/bluetooth/bluetooth-next/c/f1a9a7cc825f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


