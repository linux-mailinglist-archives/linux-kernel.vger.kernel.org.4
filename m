Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34235EEB0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiI2BiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI2BiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:38:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B27C98D25;
        Wed, 28 Sep 2022 18:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D819760D57;
        Thu, 29 Sep 2022 01:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36271C433D6;
        Thu, 29 Sep 2022 01:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664415478;
        bh=VlBFjL1h2RX0jw3gnLXgEmHQCSQY82x2vWGxBe8mZmk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Oko98EOuLTQn8x7VN7SI0nZdrxoh3cA3TsRMvoCop5lkyqfqp9sphMy9EG9Rw8JHj
         bfHiQEddtk/2cbTe4m9ej1+sb1XPQZQ2OHQIt33TFJTYSRg2oKd0z4wSToCD0VLou2
         1fzdvr+x/NNzF5j8zV3V7BANXXpLZQ9X9E1omId2QkfoRAQBBofhpb7ZZrnaskAj70
         xbkrj5QGIXS6il1X6N+yXLlkRvEH6gmUlf/jFMdxKRDJdn2hjn8r6DvY88U71+6GnS
         tPxvfDs88C+qDRNcQJKtljm5FCetJJ29Pry5KlJdjosth+E+wi9nQYZGE3IRqeNGz+
         Vap5ZpFLLMTMQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YxJL6re6XuCPGlta@linaro.org>
References: <20220830033137.4149542-1-peng.fan@oss.nxp.com> <20220830033137.4149542-3-peng.fan@oss.nxp.com> <YxJL6re6XuCPGlta@linaro.org>
Subject: Re: [PATCH V3 2/8] clk: imx93: drop of_match_ptr
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, kernel test robot <lkp@intel.com>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date:   Wed, 28 Sep 2022 18:37:56 -0700
User-Agent: alot/0.10
Message-Id: <20220929013758.36271C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2022-09-02 11:31:06)
> On 22-08-30 11:31:31, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >=20
> > There is build warning when CONFIG_OF is not selected.
> > >> drivers/clk/imx/clk-imx93.c:324:34: warning: 'imx93_clk_of_match'
> > >> defined but not used [-Wunused-const-variable=3D]
> >      324 | static const struct of_device_id imx93_clk_of_match[] =3D {
> >          |                                  ^~~~~~~~~~~~~~~~~~
> >=20
> > The driver only support DT table, no sense to use of_match_ptr.
> >=20
> > Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
>=20
> Stephen will you pick this patch?

Ok. Got it for fixes.
