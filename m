Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A819870265F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbjEOHuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjEOHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9189C
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BB9E613F1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D611EC4339B;
        Mon, 15 May 2023 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684137019;
        bh=GNWCcuczZlCdf5xkDE12wCv0ynHcKr9sQgZDRwQdZ1I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qnnV2NVPRlT72CCYkq6PqlsuZuFC5XyS1mKMpcQJ/SoAe1lL1MJ6tSjlzpJPtWa9W
         yPsLDH8Uh7zA39ihnBFD+DEMvt3rK/7nBJX34+eM5QZ4pxEgjekFlbLALgwfAqZf5p
         Fw0MVrS3oThPvROkkr3ggpXiDcbCnwKTBnAVGpIMjZPYonRwpsN7BbkDv2NYv7MeEt
         aWjlTQGQQM4puMynqIiYIHXlmZeqxr6MAjmMwrSmN70mc7O5qAxwyBrwOeCtEgQjIQ
         ViRKwMwRUdJUjqHLRsnYsJtMf4HbSyu7m8ij+B8+pp0iCVQRw9iyQ+DhTpNXgk5JZq
         MWwU5s0sT427A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C009EC41672;
        Mon, 15 May 2023 07:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] virtio_net: Fix error unwinding of XDP initialization
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168413701978.26935.8394779439623011528.git-patchwork-notify@kernel.org>
Date:   Mon, 15 May 2023 07:50:19 +0000
References: <20230512151812.1806-1-feliu@nvidia.com>
In-Reply-To: <20230512151812.1806-1-feliu@nvidia.com>
To:     Feng Liu <feliu@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
        simon.horman@corigine.com, bodong@nvidia.com, jiri@nvidia.com,
        witu@nvidia.com
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
by David S. Miller <davem@davemloft.net>:

On Fri, 12 May 2023 11:18:12 -0400 you wrote:
> When initializing XDP in virtnet_open(), some rq xdp initialization
> may hit an error causing net device open failed. However, previous
> rqs have already initialized XDP and enabled NAPI, which is not the
> expected behavior. Need to roll back the previous rq initialization
> to avoid leaks in error unwinding of init code.
> 
> Also extract helper functions of disable and enable queue pairs.
> Use newly introduced disable helper function in error unwinding and
> virtnet_close. Use enable helper function in virtnet_open.
> 
> [...]

Here is the summary with links:
  - [net,v6] virtio_net: Fix error unwinding of XDP initialization
    https://git.kernel.org/netdev/net/c/5306623a9826

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


