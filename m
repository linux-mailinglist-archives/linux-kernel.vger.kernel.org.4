Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8682A74563A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjGCHkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGCHkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:40:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F079C1;
        Mon,  3 Jul 2023 00:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DFA460D2B;
        Mon,  3 Jul 2023 07:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBA7C433C7;
        Mon,  3 Jul 2023 07:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688370000;
        bh=2Fuonf3inGH6Anz8QQf5AfqCEcy/ALYXqeeLCq68Olc=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=Px9Kb2FMUtGc2uRE1HnA39rxVKAwOwfN31jg5IVAujwpq+pRCxOHXIdrhlHuKMioh
         WjK0nGaGY2hhkmPoCA7jZ2klY+Qe5zjJ2baSrWvwLISdZZxobINgyi91P6nf8WzkqR
         vcI3bWYIrhJY+4M3ROkt16glLaER6CoarhPoxSMEze/FzqEqhSpfGRFgbyiGG7BMPe
         LpTzamyELTy6mNeaCG9ljiRg9kVoxBRSlCdBEu/yXZz6wczs4ScN5V4bMsLgXwzkR9
         PCktpxjDZZT6pKwxkUfmYkzKll4V8kQB2/Y/nYsRwco0vWPo7W+3dnXCSWIXht5mh1
         1gEEt8IGCChjw==
Message-ID: <0624919df393575c25c454b14ca790e5.mripard@kernel.org>
Date:   Mon, 03 Jul 2023 07:39:57 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Frank Oltmanns" <frank@oltmanns.dev>
Subject: Re: [PATCH v3 7/8] clk: sunxi-ng: div: Support finding closest rate
In-Reply-To: <20230702-pll-mipi_set_rate_parent-v3-7-46dcb8aa9cbc@oltmanns.dev>
References: <20230702-pll-mipi_set_rate_parent-v3-7-46dcb8aa9cbc@oltmanns.dev>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        "Andre Przywara" <andre.przywara@arm.com>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Maxime Ripard" <maxime@cerno.tech>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Roman Beranek" <me@crly.cz>,
        "Samuel Holland" <samuel@sholland.org>,
        "Stephen Boyd" <sboyd@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2023 19:55:26 +0200, Frank Oltmanns wrote:
> Add initalization macros for divisor clocks with mux
> (SUNXI_CCU_M_WITH_MUX) to support finding the closest rate. This clock
> type requires the appropriate flags to be set in the .common structure
> (for the mux part of the clock) and the .div part.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
