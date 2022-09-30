Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763055F1538
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiI3VvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiI3VvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:51:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1901E3186;
        Fri, 30 Sep 2022 14:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 978B3B82A3C;
        Fri, 30 Sep 2022 21:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447E8C433D6;
        Fri, 30 Sep 2022 21:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664574660;
        bh=fvyFnmHKELqxHSrmR8MjQ68WiziwCTvAMOoEJvu6BZg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RLvrw7JQn0xk9T1JE7Vqp0Ci8p/bkk7veggaxJwduuaai7hN3/i0RFWQGizndAPd4
         2Oal6O5JwbglDheb/tkPFOBXgwrtnAu9K8Jc/eEHnfiGLSpbcA6taoh8z0M/qcMmDD
         MOFICPWOh5rI5tDwMzuMWo4VtO5yrWzmm45FlprwPvub7XyZjrc+7fiLuILWJqwxrc
         VPPBcQisaXTioIlJ6BOVZSjymUTJEnTMnNQpPSEiI8xXyWCIBUPqJljuhEg/jlADeB
         SsUMb6Wl2p5WrvfbpDs1uNyavL93PUiyLBhgakNQvU1Knc5w5b/bwc5iZ7Bgaaa+nu
         rPc4sTmGQ2nbQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220623115719.52683-1-andriy.shevchenko@linux.intel.com>
References: <20220623115719.52683-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/3] clk: Remove never used devm_of_clk_del_provider()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Sep 2022 14:50:58 -0700
User-Agent: alot/0.10
Message-Id: <20220930215100.447E8C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2022-06-23 04:57:17)
> For the entire history of the devm_of_clk_del_provider) existence
> (since 2017) it was never used. Remove it for good.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied to clk-next
