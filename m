Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05C73097E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbjFNU5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbjFNU5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:57:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E561A19B5;
        Wed, 14 Jun 2023 13:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F6536290C;
        Wed, 14 Jun 2023 20:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1B7C433C0;
        Wed, 14 Jun 2023 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686776257;
        bh=yaH6eux2dd5ZPnp/0Ms+wfN/I0bYz4osjzUcd1uhhsA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WdP3bRM7h6mE2P5SUdWjJ7izyhAZasB7CVc+o7LNWnKMjN7SEgQF97ZuwGmM2/mcb
         Ecjr952eQlCLEdgVHAECC+ciObZoF1JqUVa0J4YD4Sj8Eku61Y30a7aDbnoEeZcHXR
         3TKxo5NSQSFk5Mo2HgGnd/MpNxhUYz5HDDz+1C4gLepSEtL1xzMF1Z9P4KETUxh77Y
         bkQ6uelAgxR6mzqD6YPF4whoO7eQ2vuy3CqtNioIRsk0MvZGY/v6jqxeyxb13Ho5v+
         G2ioGROyaD6EwnylVeOWJNhcbdH2dqY7CMYqEBAICoKYP1HFbK/rYul8M8m4V0ycId
         5VAg4+600iU4g==
Message-ID: <43b404203c07f3b00877b43abdd66311.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230614121059.42888-1-abel.vesa@linaro.org>
References: <20230614121059.42888-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v6.5
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>
Date:   Wed, 14 Jun 2023 13:57:35 -0700
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

Quoting Abel Vesa (2023-06-14 05:10:59)
> The following changes since commit ac9a78681b921877518763ba0e89202254349d=
1b:
>=20
>   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-6.5
>=20
> for you to fetch changes up to 878b02d5f3b56cb090dbe2c70c89273be144087f:
>=20
>   clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe() (=
2023-06-12 12:20:02 +0300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
