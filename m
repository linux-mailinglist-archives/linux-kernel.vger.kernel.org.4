Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B45A5F153A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiI3VvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiI3VvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991311116FA;
        Fri, 30 Sep 2022 14:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D6EEB82A43;
        Fri, 30 Sep 2022 21:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D389C43470;
        Fri, 30 Sep 2022 21:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664574668;
        bh=3tpoejLOIkWsztKs5fhhgkAnTRQrpJkyyxgs9Gx7Cr0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EjSmOo71JwWk33A45mno0MCQXa7nuTkqJXuARosGrqS8RZhbiTFP9YynsIAU0D7p6
         OcJTbdfqo/Po1znXtMrUG4V0Uxn7rgh7Eke7OiYT9PdhPkwLaA3xYNdPaPixdK8CpO
         0Uxvnoh8251CfV+pLneBPpdgh3ZzWyR1rXNOeKjVZRUBpDqP4eB2B0odLqCImFQ54c
         jxIMhUfqglZ6OEjSCOxz3eYNLVs0wr8QFlJE+EUvWfsHJ7y8VdkviXP3GSHh5lDEea
         40UCyTytn8kX+95adlzYKFsV8HTnldozAv5dQLqR4XfL1kJFyFg5FE2ypnhg1o2MYX
         2iNzB/TIS98jQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220623115719.52683-2-andriy.shevchenko@linux.intel.com>
References: <20220623115719.52683-1-andriy.shevchenko@linux.intel.com> <20220623115719.52683-2-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/3] clkdev: Remove never used devm_clk_release_clkdev()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Sep 2022 14:51:06 -0700
User-Agent: alot/0.10
Message-Id: <20220930215108.9D389C43470@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2022-06-23 04:57:18)
> For the entire history of the devm_clk_release_clkdev() existence
> (since 2018) it was never used. Remove it for good.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied to clk-next
