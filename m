Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C38601C73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJQWas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiJQWa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A3219282;
        Mon, 17 Oct 2022 15:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F3D6128D;
        Mon, 17 Oct 2022 22:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E6CC433D6;
        Mon, 17 Oct 2022 22:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666045790;
        bh=o9CVNWd49B0uPG9CroMhov7CzALKXLQZhU8hnC2X5Gk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CrW/x9BxfBywHF1VJRZmtjIKJ3ONVWBBqWy5KztLFr4mLYH22246ObCWm5D107irc
         eIWhjh/X+/3u2lNmyKiL1NeCv9McZI6OxkZdofWnapdDBWxw70GG2J1zUNqwQSKpOf
         qwfPkxnQb6h5cbOuPh58hj59cQPr/zZg9k5+KKnC5ea9nXlKzyVc5xpmQLBb51kywV
         6gq48ZKDuoKlMElfNKi1+hT1U7NRG+FSqxKo48Tv5LBVDj1o7bla2DCT1OAQ5+Uf6v
         6SWqaESiYC5a0XBpLql3mUIWB3jXtV9jvEROTd0aO8qbrKPsMb2OSpv14XVpKdn7cV
         1dkPSebigJRaw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221003203103.2705007-1-sboyd@kernel.org>
References: <20221003203103.2705007-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: xilinx: Drop duplicate depends on COMMON_CLK
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 17 Oct 2022 15:29:49 -0700
User-Agent: alot/0.10
Message-Id: <20221017222950.D4E6CC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-10-03 13:31:03)
> This entire Kconfig file is only included within the if COMMON_CLK
> section of the drivers/clk/Kconfig file. That makes the depends on
> COMMON_CLK here redundant. Remove it.
>=20
> Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
