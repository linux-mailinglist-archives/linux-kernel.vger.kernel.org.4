Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36445714397
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjE2FIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjE2FIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:08:17 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E59B83;
        Sun, 28 May 2023 22:08:13 -0700 (PDT)
Received: from sophie-lab.localnet ([172.16.0.254])
        (user=kaima@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 34T4t7pt020146-34T4t7pu020146
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 May 2023 12:55:07 +0800
From:   Kai Ma <kaima@hust.edu.cn>
To:     Stephen Boyd <sboyd@kernel.org>, NXP Linux Team <linux-imx@nxp.com>
Cc:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH] clk: imx: clk-imxrt1050: fix memory leak in
 imxrt1050_clocks_probe
Date:   Mon, 29 May 2023 12:55:07 +0800
Message-ID: <22043583.EfDdHjke4D@sophie-lab>
In-Reply-To: <ZGX/PjYBVGuECcPg@linaro.org>
References: <20230418113451.151312-1-kaima@hust.edu.cn> <ZGX/PjYBVGuECcPg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7679923.EvYhyI6sBW";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-FEAS-AUTH-USER: kaima@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7679923.EvYhyI6sBW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Kai Ma <kaima@hust.edu.cn>
Date: Mon, 29 May 2023 12:55:07 +0800
Message-ID: <22043583.EfDdHjke4D@sophie-lab>
In-Reply-To: <ZGX/PjYBVGuECcPg@linaro.org>
MIME-Version: 1.0

On Thursday, May 18, 2023 6:34:38 PM CST Abel Vesa wrote:
> On 23-04-18 11:34:51, Kai Ma wrote:
> > Use devm_of_iomap() instead of of_iomap() to automatically
> > handle the unused ioremap region. If any error occurs, regions allocated by
> > kzalloc() will leak, but using devm_kzalloc() instead will automatically
> > free the memory using devm_kfree().
> > 
> > Also, fix error handling of hws by adding unregister_hws label, which
> > unregisters remaining hws when iomap failed.
> > 
> > Fixes: 7154b046d8f3 ("clk: imx: Add initial support for i.MXRT1050 clock driver")
> > Signed-off-by: Kai Ma <kaima@hust.edu.cn>
> 
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> 
> Stephen, can you apply this through clk-fixes?
> 

Thanks for your review, I am glad to let you know that I am a student at a
university and we collaborate to contribute to the Linux kernel. Here we
have some similar patches for clk. Could you please take care of them?

[1] https://lore.kernel.org/linux-arm-kernel/DU0PR04MB9417B63DE97D4A2A77B4176C88969@DU0PR04MB9417.eurprd04.prod.outlook.com/T/
[2] https://lore.kernel.org/linux-arm-kernel/20230503070607.2462-1-lyx2022@hust.edu.cn/T/
[3] https://lore.kernel.org/linux-arm-kernel/dc0f2863-d5d5-5102-eb8e-ceea92c03fda@oss.nxp.com/
[4] https://lore.kernel.org/linux-arm-kernel/9a2ab7ec-07ee-255f-a143-9b6c8df7c1e2@gmail.com/

Thank you very much!

Regards,
Kai Ma

--nextPart7679923.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEOL4x3UcITzqVpkF5dHxtpLztq4UFAmR0MCsACgkQdHxtpLzt
q4UphAgAnrurl7BzADxMZ3h8kBcriFp9uk4EAUxcpokix8jD7dp9y6SBJsckqVTG
KWGX5guMpVJ44+vClDOJVcT+odTlO5/I2f+ckamSCp2xdTFPZ/TEjpZTfbHI2csL
rXD/h/5dbZ4MjGbngWrkq+teS6LqMYuofyosEV9wBpe85bMpfqy1ti5wGQJH2Kzg
0BSyGYi6obWDsPu05HLaBiwVQY5EJJX3ss7QW0ErtQOajGbRTqW3A+SUluUrvFUg
7uRNmox67KDcgkA07BFWZ/IkrFsv/4E3DLR98B9oOq/DTqHEGz+g9pB7T14PhR2u
PTyXpcPtzqGoTaTzjcs22grJt2TsGw==
=CDQ6
-----END PGP SIGNATURE-----

--nextPart7679923.EvYhyI6sBW--



