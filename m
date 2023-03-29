Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5396CD018
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjC2Ch3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjC2ChW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:37:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120FE3C0A;
        Tue, 28 Mar 2023 19:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4560B61A3E;
        Wed, 29 Mar 2023 02:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD5DC433D2;
        Wed, 29 Mar 2023 02:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680057424;
        bh=/Y5YFDSx2LxKCmUpzFpoRSyWCNh+V7l5W8aVaCnh2Z0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rhjfm1uYEtAh8WDyplKSrlUXi5YulYizvYwCW+KnLLpLAD/amVOZOy7vM8DHr17//
         Wr9p3T0qk8NTeXuG8y4WqIaDfhT0QMKQy2/fXniiNjtUzX/y3pwoCvNhat3Co8rFem
         qFtbJpIVKu3+N9qVbrjY70HmEBaPQBliR79p70lrrUgL3owdAXsoqBuqjLdsQHPLcu
         h9MU8m8n1kUzhKzbbtoUZVh6vhkHg+8LvB0UDwCSETgf8uI1mYUQJQIF9S3+QOPIPe
         doqg1sEB3FxhSycqUBsd/oFzQD90JtaGLmrxx0u823whGKX23SJebLMoErhB0CfPgL
         g5wZlL9GQODcg==
Message-ID: <5eca9d8145d2d5ede1a9edbc50b3ee05.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230312161512.2715500-11-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de> <20230312161512.2715500-11-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 10/30] clk: fixed-rate: Convert to platform remove callback returning void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 19:37:02 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-12 09:14:52)
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Applied to clk-next
