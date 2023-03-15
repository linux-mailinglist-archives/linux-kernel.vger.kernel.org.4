Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC60D6BA430
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCOAol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCOAoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2240F8;
        Tue, 14 Mar 2023 17:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C58261A94;
        Wed, 15 Mar 2023 00:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF863C433D2;
        Wed, 15 Mar 2023 00:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678841078;
        bh=vNnYsNCqxczLQsXu+8zqK557WLqg/3NcVlt99CW8bq0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uLXY6Iv5P/MrBF3/Lum142VSReVfGzwFUSs+Zf2O2kZsVgw7HR5iE0W+DPczjPzRN
         L0ids3fySDZxbpldDdr2m/TcJrzqRu0cOKmOFSLxjTy1rIm7ZcMAMZDZRLbjrZHTqW
         M+JBN//qC0txJ37VOntTx6j2RDh3vzkitnEbjjY/BbfXZzfcCXXB35ejmqUOlAkdDP
         BltCojmR/mU3JNtGDoM78pC9t4oPDPfq301EV1eGeXfcJ1pZW+XuiRCWgnEWZvlrUv
         lf1ghCimC2g0R7A9nfFeCeweU2bxkMh1UtgULer/NAXNQU7ikB2fdAEtaGflFHUcQX
         DE7w3pHRNKRGQ==
Message-ID: <9832bfd49eb83257a6a62620023773c1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230131083227.10990-1-clement.leger@bootlin.com>
References: <20230131083227.10990-1-clement.leger@bootlin.com>
Subject: Re: [PATCH v2] clk: add missing of_node_put() in "assigned-clocks" property parsing
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Date:   Tue, 14 Mar 2023 17:44:35 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cl=C3=A9ment L=C3=A9ger (2023-01-31 00:32:27)
> When returning from of_parse_phandle_with_args(), the np member of the
> of_phandle_args structure should be put after usage. Add missing
> of_node_put() calls in both __set_clk_parents() and __set_clk_rates().
>=20
> Fixes: 86be408bfbd8 ("clk: Support for clock parents and rates assigned f=
rom device tree")
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> ---

Does this series from a year ago help[1]?

[1] https://lore.kernel.org/all/20220623121857.886-1-nuno.sa@analog.com/

Nobody reviewed it, but if you can then I can probably apply it.
