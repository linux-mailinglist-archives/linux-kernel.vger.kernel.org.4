Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F9270A07C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjESUU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjESUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA367FE;
        Fri, 19 May 2023 13:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41B8E6578B;
        Fri, 19 May 2023 20:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E1F3C433D2;
        Fri, 19 May 2023 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684527620;
        bh=N3VANGUb4aHSfCOqfO6QrYJYArpb3F+YiYYG3POd9tk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QyHDdOas0TjGGseC8ggyxvcA3+jg5eeE24+V/cNGrFWVcBOzLF32wE7ywf5IHWPg4
         AWuyCNcpNA68+gabexMd8cn4oVNVf8T68AWUet95zoFYVz7i+FGGRsCYRWXViwQUfc
         rXiQV7YVXrS3sGOWZImXM/w3HTxrJGLJiHTdem1EXp1jQxh/C/dyxMQjUo6J//j514
         M2rNEGE+4A8YLcuIxmv/OeUCFOAwQzjYJM3e1ha7ZpgdJ772gMvWz24eB4f6X1ryJg
         Q2xEBgQB0I+m/n29sn6GQ4HBLd4lVSK73OCqd2LLqh6j/eGCzMRmgnda9P/9ujRBpq
         PvrbqJ1spChtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8277EC3959E;
        Fri, 19 May 2023 20:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btqca: make sure to handle byte order for
 soc_id
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168452762053.10748.12822242658004808633.git-patchwork-notify@kernel.org>
Date:   Fri, 19 May 2023 20:20:20 +0000
References: <20230510-btqca-byte-order-v1-1-82e6a371c5aa@fairphone.com>
In-Reply-To: <20230510-btqca-byte-order-v1-1-82e6a371c5aa@fairphone.com>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        gubbaven@codeaurora.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, johan.hedberg@intel.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        simon.horman@corigine.com
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 May 2023 11:27:21 +0200 you wrote:
> The field soc_id in struct qca_btsoc_version is __le32 so we need to
> convert it to host byteorder before using.
> 
> Reported-by: Simon Horman <simon.horman@corigine.com>
> Fixes: 059924fdf6c1 ("Bluetooth: btqca: Use NVM files based on SoC ID for WCN3991")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btqca: make sure to handle byte order for soc_id
    https://git.kernel.org/bluetooth/bluetooth-next/c/0f1e103dc579

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


