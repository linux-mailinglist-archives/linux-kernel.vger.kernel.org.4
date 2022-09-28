Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC335EEA46
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiI1XnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiI1XnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF91F08AA;
        Wed, 28 Sep 2022 16:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48FB5601B5;
        Wed, 28 Sep 2022 23:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E92FC433C1;
        Wed, 28 Sep 2022 23:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664408579;
        bh=NaykREuRBBPpeJBtk+CLEf+97EYWNNqVH6121J8EZRU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=icHtNeOeVcY5Yyr5KbjX9VLE0HNZ2i7DK6Dy+oxCiJ2djz0wE5TpZcuIY7aOjQ7Vi
         pMB8yuEn76VpWmpoLW7YVtZ7N0QW2GDGC4+cOCDRzn18/ndV4dSGPTHZhm+EggPPG/
         LYVjJVADbPIeoYq7MIhLaxMt0td+aiH2D/Wj61x05bdE8RMedtDf4cjVZiGNBSUrK7
         nEcmb9blSuNfrUsaX9lK07fzijbgvihR981s9uVPC9UfLQBb4ZKAWRWpVnqC0LIN8E
         Yns159I2ZDPy2qQrLrQcYI4kMFOJemittcoD7SmoPQVEGCDvHXR2siVjwDwvywypDa
         QWqmgZJDL9YFw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220928200122.3963509-1-jernej.skrabec@gmail.com>
References: <20220928200122.3963509-1-jernej.skrabec@gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: h6: Fix default PLL GPU rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, r.stratiienko@gmail.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, samuel@sholland.org,
        wens@csie.org
Date:   Wed, 28 Sep 2022 16:42:56 -0700
User-Agent: alot/0.10
Message-Id: <20220928234259.9E92FC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jernej Skrabec (2022-09-28 13:01:22)
> In commit 4167ac8a657e ("clk: sunxi-ng: sun50i: h6: Modify GPU clock
> configuration to support DFS") divider M0 was forced to be 1 in order to
> support DFS. However, that left N as it is, at high value of 36. On
> boards without devfreq enabled (all of them in kernel 6.0), this
> effectively sets GPU frequency to 864 MHz. This is about 100 MHz above
> maximum supported frequency.
>=20
> In order to fix this, let's set N to 18 (register value 17). That way
> default frequency of 432 MHz is preserved.
>=20
> Fixes: 4167ac8a657e ("clk: sunxi-ng: sun50i: h6: Modify GPU clock configu=
ration to support DFS")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---

Applied to clk-fixes
