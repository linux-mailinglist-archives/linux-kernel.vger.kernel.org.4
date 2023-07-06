Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F0E74A176
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjGFPtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjGFPtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:49:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEBB1FCA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4D6B60B9C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C17C433C7;
        Thu,  6 Jul 2023 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688658521;
        bh=ASn250ABHz65GgKATAAVAm7VbjKnew/NYaiW0XJGgR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fdwpRLyaAoUXbPtt2cwMuBx0Fk4XYI+3C0Pdrdp/56s3hcGHyP6jKvY+RSKTo/gvx
         lMMAXKaWnw8qF8TCXTS98T7eQEKbcJ/OfLmtcTKmYpNnatg0vH+MTXNJ0YQ2GhGUBF
         suLU5pdR2CIEvHgqdb2UPeA+P7SKHcWNGDYSHn3+JQg+ux700ldwyN8E2+tAKnMpSx
         LFz0MP4cAkAesct/r8y1a7JLnNq2q3G5pD39GEIVYeRohPYjCw/sa631tuHXmvDjR8
         sAqMqEhmyx9niLRjbtPW1XIH0mXecJ/FSZklgBoS3bWtD9KezsRX6mnSsU6ClBq9zX
         DZKYPJwXs9LEw==
Date:   Thu, 6 Jul 2023 08:48:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] net: emaclite: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230706084840.223b5926@kernel.org>
In-Reply-To: <20230706120850.11026-1-frank.li@vivo.com>
References: <20230706120850.11026-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jul 2023 20:08:47 +0800 Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.

## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

