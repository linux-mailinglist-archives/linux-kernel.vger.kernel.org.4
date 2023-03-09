Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A357E6B3239
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCIXr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjCIXry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:47:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B2B10B1CF;
        Thu,  9 Mar 2023 15:47:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E374BB820C6;
        Thu,  9 Mar 2023 23:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A80C433D2;
        Thu,  9 Mar 2023 23:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678405670;
        bh=NQ0z0vWRZKFSOsNta5bZXQwrrn+JWpr6q/3op/tZXNg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KW0qaj+KdPT2EaWE5uLTvMsecdNBQIGz46H7UdCdVjDFKIb/RC/8X/LvZsIJTkbVP
         +imQ8wEZlv7TgHnR2B8J0eH9OLup1A91rJAE7An5kjloxS15rX23HoHQEluuNQAqN7
         pWzaMkSCxk7vRCl2nmTAT/EJ2C+4dMEjM1H76mCfQv15kmsQNAND6135yZseXe6ynt
         3RyPKTbfdhjIKG8PfYPB4Cii18HOmTHGSOO9Snd/cwNcGvjVB1E+KS9PpwDtTJmU3w
         TCw6BUC8Y7UJQdo1/uXNxjjTxyEc6InZGRWBe68H212c3pRU6f6i9LNpkVbI0eb/Hy
         1Cf+KucTYznSA==
Message-ID: <ec1fb4d134181a1b1859bcb884dcd494.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b94ee1d2-b224-f9d5-3f3c-0096634f4c93@loongson.cn>
References: <20230307115022.12846-2-zhuyinbo@loongson.cn> <202303082037.QPfBP64A-lkp@intel.com> <b94ee1d2-b224-f9d5-3f3c-0096634f4c93@loongson.cn>
Subject: Re: [PATCH v13 2/2] clk: clk-loongson2: add clock controller driver support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinbo <zhuyinbo@loongson.cn>
Date:   Thu, 09 Mar 2023 15:47:46 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting zhuyinbo (2023-03-08 18:58:02)
>=20
> =E5=9C=A8 2023/3/8 =E4=B8=8B=E5=8D=888:16, kernel test robot =E5=86=99=E9=
=81=93:
> > Hi Yinbo,
> >
[...]
> >
> >     drivers/clk/clk-loongson2.c: In function 'loongson2_calc_pll_rate':
> >>> drivers/clk/clk-loongson2.c:79:15: error: implicit declaration of fun=
ction 'readq'; did you mean 'readl'? [-Werror=3Dimplicit-function-declarati=
on]
> >        79 |         val =3D readq(loongson2_pll_base + offset);
> >           |               ^~~~~
> >           |               readl
> >     cc1: some warnings being treated as errors
>=20
> The CONFIG_64BIT not enabled in your config file, I will add a depend on =

> "CONFIG_64BIT" in my clock driver to fix this compile error.

Do you need to use readq() here? Can you read two 32-bit registers with
readl() and put them together for a 64-bit number?
