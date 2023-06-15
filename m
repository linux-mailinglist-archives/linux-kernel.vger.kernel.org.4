Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50384731F97
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFOSAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjFOSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634B3294A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD1A96223A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4720AC433A9;
        Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686852023;
        bh=aIpA+No+IYUS2eydROUU+J8tzkLnv1Uz23da1C/W8o0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NOS5PxqmElCq3Muy5StRWkIBjKjYbP+cCm+hpf7CEkWk93Ne14kunxeI4RTHp79Qs
         4/8CiAUEC5ZlBO2Vq4m49qJU+FTseEIwbVZ3Ize1ZMxVzAetSX8HiutFcvEf/my5nA
         fpi56MPy6RGq6tPO4LtTL7NzWXaUr+XKP/rBrRIB3nrYhVWFcfwDPijB/H6OK4YNG1
         1WM9tJkspH4eo9170WxqHyB0a41FCW0WwwLmhnoQ0a/TsUCgjo57hpD37H4I5bXIci
         XDNat3IIHP2Fx+847dxsBrSIAAbmoOQfukAtYTG9MKrY74GwG1oJ2QDBNG/gnfsCNg
         uDGqp8jnXaunw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 199BCC3274B;
        Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: enable nowait async buffered writes
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168685202310.7502.1450479349588433609.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 18:00:23 +0000
References: <20230613072912.52249-1-frank.li@vivo.com>
In-Reply-To: <20230613072912.52249-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, luhongfei@vivo.com
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 13 Jun 2023 15:29:11 +0800 you wrote:
> This adds the async buffered write support to f2fs,
> the following is the relevant test data.
> 
> iodepth      | 1    | 2    | 4    | 8    | 16   |
> before(M/s)  | 1012 | 1133 | 894  | 981  | 866  |
> after(M/s)   | 1488 | 1896 | 2081 | 2188 | 2207 |
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: enable nowait async buffered writes
    https://git.kernel.org/jaegeuk/f2fs/c/d61812691182

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


