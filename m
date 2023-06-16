Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F52732989
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242614AbjFPIK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjFPIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489F42965;
        Fri, 16 Jun 2023 01:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91BA061E90;
        Fri, 16 Jun 2023 08:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3F50C433C9;
        Fri, 16 Jun 2023 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686903020;
        bh=rDiQIeucbPgkCAlc+8wcWwStmLWvape2wbhKI1y9/9U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U2+s70IKODe14P1cEtfhYn4e2x67GQIUbfvoNDute5161yJULjWNGAArb9i9LfBie
         +63op26gnJWArVbzikq7bY9T0fvRdvVi53WVaRM/AU6SJCJ3oNR7TUNbsx2UFoaE/E
         nhCkpLx2g9gkXpNbmX+A38gwZIc4twmwQAmjdJ4FkZt9pF1b5e/UzGqDspGpZGarK8
         tAoW/5C0m65d3enrSwQ8fzEy9pwMgxkCxTugm+szl3f3Q/EtJ/BG8+SW7UQejlwAjG
         keVXIbrOpgGY+ef+UgZ3qwK4GtqwkMyFr9y7NydoRKN8Hbyu2I2Lmk/7b6IJ/8g2uz
         pQ2YEbfA0GBLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B23CDE49BBF;
        Fri, 16 Jun 2023 08:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] s390/net: lcs: use IS_ENABLED() for kconfig detection
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168690302072.8823.785077843270614259.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Jun 2023 08:10:20 +0000
References: <20230615222152.13250-1-rdunlap@infradead.org>
In-Reply-To: <20230615222152.13250-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, wintera@linux.ibm.com,
        wenjia@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Jun 2023 15:21:52 -0700 you wrote:
> When CONFIG_ETHERNET=m or CONFIG_FDDI=m, lcs.s has build errors or
> warnings:
> 
> ../drivers/s390/net/lcs.c:40:2: error: #error Cannot compile lcs.c without some net devices switched on.
>    40 | #error Cannot compile lcs.c without some net devices switched on.
> ../drivers/s390/net/lcs.c: In function 'lcs_startlan_auto':
> ../drivers/s390/net/lcs.c:1601:13: warning: unused variable 'rc' [-Wunused-variable]
>  1601 |         int rc;
> 
> [...]

Here is the summary with links:
  - s390/net: lcs: use IS_ENABLED() for kconfig detection
    https://git.kernel.org/netdev/net-next/c/128272336120

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


