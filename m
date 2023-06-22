Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7311739DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjFVJuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjFVJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:50:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA84C03;
        Thu, 22 Jun 2023 02:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 149196172C;
        Thu, 22 Jun 2023 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64D1EC433CA;
        Thu, 22 Jun 2023 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687426820;
        bh=ufbnZe7Ld3Hls25KBbaJXsFu1DmFhGZkThJF6gd87qg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gmOsq1+56Z4wMtvgA5JrZEWiEamF2NBoR4nLHBQexWVc1iTNtfvFW1sNcj4NvL7gC
         FPQ0YW7iMjZTZR9Q8f6/W3vKQC6kNaOrif0eDZ59MAp5e6lCLw/8+hEPDDPDz7ZV46
         u9s5JqgmMFit/pVW2FBw0Moa5m6UCbgyhBcK6FPfgFJAfM8abGM2JSkvE+4j3xVQrO
         5piZCdzWdjCjQD+zLRedRK8wvkviVEovl8E2u1ZXVflfXLnec6QudzEY35g7NqSnGt
         WxXWRL524bTqInCxcN/2LXC8VWW5ijU4PlFxTqe8Od1pNtuFGaCjlIZLMenGsI+lni
         zzTgq+VMphouw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FBC9C691EF;
        Thu, 22 Jun 2023 09:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wwan: iosm: Convert single instance struct member to
 flexible array
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168742682025.2644.13888689959448952935.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 09:40:20 +0000
References: <20230620194234.never.023-kees@kernel.org>
In-Reply-To: <20230620194234.never.023-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     m.chetan.kumar@intel.com, flokli@flokli.de, bagasdotme@gmail.com,
        linuxwwan@intel.com, loic.poulain@linaro.org,
        ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, gustavoars@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 Jun 2023 12:42:38 -0700 you wrote:
> struct mux_adth actually ends with multiple struct mux_adth_dg members.
> This is seen both in the comments about the member:
> 
> /**
>  * struct mux_adth - Structure of the Aggregated Datagram Table Header.
>  ...
>  * @dg:		datagramm table with variable length
>  */
> 
> [...]

Here is the summary with links:
  - net: wwan: iosm: Convert single instance struct member to flexible array
    https://git.kernel.org/netdev/net/c/dec24b3b3394

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


