Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820CA6CD014
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjC2Cg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjC2Cgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:36:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A3230F2;
        Tue, 28 Mar 2023 19:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62F72B81F90;
        Wed, 29 Mar 2023 02:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017A0C4339B;
        Wed, 29 Mar 2023 02:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680057395;
        bh=YpHtIARkehke6gSfoZyTb5VLm+8gKcPsW/49rHbeS4g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kDiJew8wThZPl1sWkPb6TTlAES5qzHo4JoZWqaDRy8rFpmN8MWvBDH3birWB+oguU
         gQ1UAhRrN9ladyAz7+aoIzYTffa0lXXSgpXv730D2K0pJHlyBRwKICo9N9qrFFDEvz
         D6dpKJjuAd26HGaOwCNnPpHLv6fPZXsEWNqIQEEBjizaf1Bm7hz6vNPwrxt1Vd8PtJ
         OQ8KYWfpaQYlYr5zUv2ONUuHYfGoB4G6RiDbNDx5VF2iv+bh4bqsXQTEkD8y8+2Dym
         OkGSqTL1oyRyEzo/99wFZ2pVzDnfpLH/3KVITy7xBhEjNexQeKr7uo103BF68XtrQL
         fH+qnWP8uZ1XQ==
Message-ID: <f71e80aaa0f3dca6c6fc4f2c42b986f7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230312161512.2715500-9-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de> <20230312161512.2715500-9-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 08/30] clk: fixed-factor: Convert to platform remove callback returning void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 19:36:32 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-12 09:14:50)
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
