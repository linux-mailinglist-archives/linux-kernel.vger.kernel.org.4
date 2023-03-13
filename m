Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976406B804A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjCMSVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjCMSUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:20:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B437E895;
        Mon, 13 Mar 2023 11:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4AC3B811C0;
        Mon, 13 Mar 2023 18:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71836C433EF;
        Mon, 13 Mar 2023 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678731612;
        bh=6mE6I10ijdS2pLyZ46aJfSHGHWnV7dgiadJxsxtZNlA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=p/SfYdH9t2KyzleMlFvkqV+sImfOkNmz8QwyaFSXo3IH34/U1VYMZET+sHRLHBrV5
         L4bSaqXX49Fuzo45nYasaB5qiB/5bMG2eV+5r7SL/Ci7RcevHa1qpr2YUM7FZfP0Sa
         hesFFfMW2E50qvSu8qf2dUgDmvXpEWV1sr8KZylcF41cQFroWYjd6OYm7i4kcPFNxm
         kU2057fBWL3UynWmMVI3ZRHSkFNTXTP/yKYsVAHob4b/bbO8nGdbb0GihPfoTGiR4u
         qrJdhj6VpdjsfCDIbd/SUyDvwMyYo5z7qo8MgxjI4eslTle0NERrUGmeSkfRPot/iM
         BpAEFkiQ/jJ5g==
Message-ID: <61eee19400e9a45ce9543bfd92a27eaa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c03e47f7-bb26-0114-b300-357634b0e581@kernel.org>
References: <20230307115022.12846-2-zhuyinbo@loongson.cn> <202303082037.QPfBP64A-lkp@intel.com> <b94ee1d2-b224-f9d5-3f3c-0096634f4c93@loongson.cn> <ec1fb4d134181a1b1859bcb884dcd494.sboyd@kernel.org> <c03e47f7-bb26-0114-b300-357634b0e581@kernel.org>
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
Date:   Mon, 13 Mar 2023 11:20:10 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-03-10 00:42:47)
> On 10/03/2023 00:47, Stephen Boyd wrote:
> > Quoting zhuyinbo (2023-03-08 18:58:02)
> >>
> >> =E5=9C=A8 2023/3/8 =E4=B8=8B=E5=8D=888:16, kernel test robot =E5=86=99=
=E9=81=93:
> >>> Hi Yinbo,
> >>>
> > [...]
> >>>
> >>>     drivers/clk/clk-loongson2.c: In function 'loongson2_calc_pll_rate=
':
> >>>>> drivers/clk/clk-loongson2.c:79:15: error: implicit declaration of f=
unction 'readq'; did you mean 'readl'? [-Werror=3Dimplicit-function-declara=
tion]
> >>>        79 |         val =3D readq(loongson2_pll_base + offset);
> >>>           |               ^~~~~
> >>>           |               readl
> >>>     cc1: some warnings being treated as errors
> >>
> >> The CONFIG_64BIT not enabled in your config file, I will add a depend =
on=20
> >> "CONFIG_64BIT" in my clock driver to fix this compile error.
> >=20
> > Do you need to use readq() here? Can you read two 32-bit registers with
> > readl() and put them together for a 64-bit number?
>=20
> If the platform supports 64-bit reads and these are actually one
> register, then readq makes sense - code is more readable, smaller, more
> efficient.
>=20

Please read the section in Documentation/driver-api/device-io.rst about
hi_lo_readq() and <linux/io-64-nonatomic-lo-hi.h>. We shouldn't need to
restrict the driver to CONFIG_64BIT. Instead, include one of these
header files to get the IO access primitives.
