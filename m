Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E6873CD40
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 00:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFXWUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 18:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFXWUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 18:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2265D10D3;
        Sat, 24 Jun 2023 15:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9454B60AEF;
        Sat, 24 Jun 2023 22:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE685C433CD;
        Sat, 24 Jun 2023 22:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687645221;
        bh=AjbhNxblEDmcYrvQoOY4V25zBqB9CQbFi35ZnsUhK8g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ja80yzVHpRyIlh8NqN9wvyzGPM68soNfpYdRu/VI5IZ7eKAoa0OwTTM9I93VJsheE
         +G7uu2WlJ66cL+aPmrBBrzNXRNvQda7JOt5Qbfij+CRHGBprPQp/Iyg5WoVPbhCC4D
         8QleB8E2EV+VlStUg6oX6dFxliB00k+LlIUAQtfHM8zz9AIcedRBlnTOSwzNLzS5tr
         0h6fGDC+lRO3rTQ+W0MzEGncSw5zSoyuQm7Mn9IP61yTVG2yBVzPlJHtpbCSN7hMhg
         e0XMVGSwgec/bjvsLUzmHoe63tYMAuE7g2kZMKFTm9oNlCYthrDvh4tBlVm31nYdym
         pNltXuDXiU34g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFED7C395C7;
        Sat, 24 Jun 2023 22:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] revert "s390/net: lcs: use IS_ENABLED() for kconfig
 detection"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168764522084.22804.1672183152551891631.git-patchwork-notify@kernel.org>
Date:   Sat, 24 Jun 2023 22:20:20 +0000
References: <20230622155409.27311-1-rdunlap@infradead.org>
In-Reply-To: <20230622155409.27311-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, wintera@linux.ibm.com,
        wenjia@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 08:54:09 -0700 you wrote:
> The referenced patch is causing build errors when ETHERNET=y and
> FDDI=m. While we work out the preferred patch(es), revert this patch
> to make the pain go away.
> 
> Fixes: 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: lore.kernel.org/r/202306202129.pl0AqK8G-lkp@intel.com
> Cc: Alexandra Winter <wintera@linux.ibm.com>
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - revert "s390/net: lcs: use IS_ENABLED() for kconfig detection"
    https://git.kernel.org/netdev/net-next/c/6a11af7c21da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


