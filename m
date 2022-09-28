Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85645EEA21
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiI1Xcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiI1Xcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:32:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF46EEE84;
        Wed, 28 Sep 2022 16:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B2560C24;
        Wed, 28 Sep 2022 23:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C096C433C1;
        Wed, 28 Sep 2022 23:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664407970;
        bh=MWoiXhLhJFZVdiOeuHhNkkStzztFn98ggkae+lCgZjU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l90/atfpJvrCbDjwGl3lXKhuh48AyX+7XJR06wBQeKoHurWepRx1wYK+JM6nols01
         SMTDu35qUAo8AJxpLMWV1dHoUN3HU63Vxpm4T+gk/b+NocDFjZGxsv3Xz5Gm4bMo7o
         EnllFqP+eP2sXSJcDMmowChcTcU2jI9XXHaOX/2IQuNJAuPr0wzLJAp36NhCNYMhCy
         xZltDy31WDbMuRp8QsElJbbVKQOkQx6b5Akl717gPt46UllsG4lsBaTeese7TdMeWa
         +o0s/H8gcbuQJ+DtDxbFEzHNGHrQyKLOlXwNU5AOSUNaTolO/3E4w3agBu3D/NoLKI
         aj7HP3KxoFd2A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220919102244.3537437-1-abel.vesa@linaro.org>
References: <20220919102244.3537437-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v6.1
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>
Date:   Wed, 28 Sep 2022 16:32:48 -0700
User-Agent: alot/0.10
Message-Id: <20220928233250.5C096C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2022-09-19 03:22:44)
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b8=
68:
>=20
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-6.1
>=20
> for you to fetch changes up to 67e16ac1fec475e64dcb8238f471c6fd154ef806:
>=20
>   clk: imx93: add SAI IPG clk (2022-09-19 13:06:45 +0300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
