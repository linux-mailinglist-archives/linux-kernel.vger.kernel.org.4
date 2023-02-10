Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D1B6929AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjBJV5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjBJV5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:57:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F157396F;
        Fri, 10 Feb 2023 13:57:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38B3EB825BC;
        Fri, 10 Feb 2023 21:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B890EC4339B;
        Fri, 10 Feb 2023 21:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676066246;
        bh=hnQh5543wMiPI0jpSwWTkI7uyxgph4jyeJKNCqsiyyw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hIdhpupPSGRrECklW5Lk9+/EMEhu5Qrp9nnZ22qUd77xCyuZBVmCJFHxL285KhjFx
         KelNYlLe/OcLGG0d08BAeEe8aWUf7DNeVLBXpDPZTSA8xylGvhZ0aP3+inP3RKHxFn
         B9+u1EQV2a1LTRjskQjkR479L1zCJpVZ79+jjXPdo7rK0cEOxr0qBfyGooMoD2tPUe
         zwiEpchNfEPlBKFy3n64IHU75NN5IfaRueHV5X7ID2ySRw7yYGy3dPYuCZvd0tqKcE
         Z4RL34GX1WYmXNaOdn+bZAAcwXgG8dTn0TZ7zCC1fVZk6W+d3SQtrgevHsq1QIP93Q
         QJOZ9rVCWiY8Q==
Message-ID: <3be3461c3bca1f07a94103856b407eb4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230203102529.2662598-1-abel.vesa@linaro.org>
References: <20230203102529.2662598-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v6.3
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>
Date:   Fri, 10 Feb 2023 13:57:24 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2023-02-03 02:25:29)
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71=
c2:
>=20
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-6.3
>=20
> for you to fetch changes up to 4e197ee880c24ecb63f7fe17449b3653bc64b03c:
>=20
>   clk: imx6ul: add ethernet refclock mux support (2023-01-31 14:45:17 +02=
00)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
