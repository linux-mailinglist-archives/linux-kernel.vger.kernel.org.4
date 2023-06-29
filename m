Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139F5742AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjF2RA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjF2RAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7A62D4C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43C11615BA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9CC0C433C8;
        Thu, 29 Jun 2023 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688058022;
        bh=jifAkiBI/CrBj7P6QISEb1V2H4847hk3VBaJlkypxpk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Vn5A+otrMbqMupmDMTMqYAELkkn1oIKIVpnsazAHwMTuYOP7YzXczusCng4dHoqXM
         OmA4H6Sc5bQ5NssO4Gz1Woj0jn3Y72TwgXp+bIkVupD5ghwBDOlQ3RNwqzWj9al0Op
         C8h9FPufZSIklQv0HHNbAL10wGE56aU31kEsBLyhBIsS/DW18RWxod262Lo2SAQE5k
         YJe3qzf3KTucSDlV9k9VQv0ZAu/ndCK0Ak/2ZLW/7kw0zQTvVMo12MK2Kpkz5fOH7/
         qPpc+EPBbI+2Xj12IjBGLc0oSxp1rh2hI1vmLVdmROt7bppz0wnSRxOXIQgNB+CTBt
         AjQmeKrXlqnqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B4CBC43158;
        Thu, 29 Jun 2023 17:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168805802256.17171.1706510206505722006.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jun 2023 17:00:22 +0000
References: <ZJt7LKzjdz8+dClx@tobhe.de>
In-Reply-To: <ZJt7LKzjdz8+dClx@tobhe.de>
To:     Tobias Heider <me@tobhe.de>
Cc:     siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, netdev@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jun 2023 02:13:32 +0200 you wrote:
> Fixes a bug where on the M1 mac mini initramfs-tools fails to
> include the necessary firmware into the initrd.
> 
> Signed-off-by: Tobias Heider <me@tobhe.de>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
    https://git.kernel.org/netdev/net/c/046f753da614

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


