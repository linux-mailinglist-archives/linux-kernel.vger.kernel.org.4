Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420D872EB61
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbjFMTAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjFMTAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DCCB5;
        Tue, 13 Jun 2023 12:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C3C06395B;
        Tue, 13 Jun 2023 19:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793D3C433D9;
        Tue, 13 Jun 2023 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686682809;
        bh=xflKTnoTI1+MRXCExF65lua3fB1e2LwdehB7LUsa7qE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hbEvy+OkXGj2iksMc5SPPOCkI1AGdSX7WwQifM9ZkyPOwSbPLYolL704C0wY+aFKK
         ifZKJzHuFVlW8IewurDd/cc2501TnzSX2OHhyZSiQm6Q5Wdn22fwAhuCob0TkGZ1ps
         BUonwWPrXbXTHSpxxj2I2qJnJtF/7rhf2smFFi1jlwckyzCHhFINExhZ0ub0tdJwW7
         uxR/FkhX/n7ZXlkfEVoe5AKIb8+YzA4A067ku5FHdn18pnUWzrKZMugk568TFu0Ify
         MW/UxNYPV966ZczdUPKzHpZQkjDKrrQHW9xyGZDlzInKTMTv1G10uCGQil0VTafsHq
         NoaFeRNgQ0gQA==
Message-ID: <9b4ca44aeaa784946f5e25e7ec23954f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230613131631.270192-1-m.szyprowski@samsung.com>
References: <CGME20230613131644eucas1p2b232fef36f6ae621827674c775a6e070@eucas1p2.samsung.com> <20230613131631.270192-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH] clk: Fix best_parent_rate after moving code into a separate function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 13 Jun 2023 12:00:07 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marek Szyprowski (2023-06-13 06:16:31)
> best_parent_rate entry is still being used in the code and needs to be
> always updated regardless of the CLK_SET_RATE_NO_REPARENT flag.
>=20
> Fixes: 1b4e99fda73f ("clk: Move no reparent case into a separate function=
")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Applied to clk-next
