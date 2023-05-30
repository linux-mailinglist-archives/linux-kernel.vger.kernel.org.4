Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD924716341
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjE3OK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjE3OKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEC7103
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4A666256E
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24C75C433A0;
        Tue, 30 May 2023 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685455819;
        bh=qcLv/FgVD7AAf3cdMqQEQgmO2VyqLadH10kDSL+4bNw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kavKj+0cftaMaesUSYZEqRiqpAoR5ezFC747j5prkqtYXR5OnXI9JNQMS1mRGeGLM
         x6/2w5WX6Ri98bMeWS1EKtd/xSqGfMbJXkCa2ibpQ0VYGBzro67SLgXITgiSI/z5nM
         wi1oUdZqJRhGzGFs8J3SzqB0llDfDJ5uYMp9whRlAy6zM5HJ9oeI08AHeUIZs1L5qZ
         nFJWFY3LB40SgmL0Zrzbz+RTBRD7qBKalebeLvSCq1r1hH9+Zm5U/+ZKTDBM985BY8
         pcgEc5rf+Z/5dwhwrbu/UMfQC2Wu95R9Ef1uIOHMkVM4Gi4oaPXildrWbsjLl11vF9
         62DT5rbaybeCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DE4EE52C0F;
        Tue, 30 May 2023 14:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net-next] net: fec: remove last_bdp from
 fec_enet_txq_xmit_frame()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168545581905.24863.4673558963981900636.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 14:10:19 +0000
References: <20230529022615.669589-1-wei.fang@nxp.com>
In-Reply-To: <20230529022615.669589-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
        simon.horman@corigine.com, netdev@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 May 2023 10:26:15 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The last_bdp is initialized to bdp, and both last_bdp and bdp are
> not changed. That is to say that last_bdp and bdp are always equal.
> So bdp can be used directly.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> [...]

Here is the summary with links:
  - [V2,net-next] net: fec: remove last_bdp from fec_enet_txq_xmit_frame()
    https://git.kernel.org/netdev/net-next/c/bc638eabfed9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


