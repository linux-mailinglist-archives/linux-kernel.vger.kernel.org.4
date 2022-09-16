Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208CF5BADC5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiIPND6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIPND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:03:56 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF6C9E89F;
        Fri, 16 Sep 2022 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663333434; x=1694869434;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X+f+brxdhEtU2bA0SXyEx650isaGDTLs/vUcZ2C9k2A=;
  b=iPaLDcb7M1linfQ/QzFBKkR/VukHJm8uTr7qLmm/BbrS/pz6DUzTE6XH
   VnOOdkncdt0LGZhucUZGp+u1dUax00UGhINUS6Z5hfeb0XZ1HAsx9ucbI
   IBtI/ba1GOlXZ8gcPo4Jr9flSQ7siINy27XSqIx0SyqA5Oc7fPLMae2ur
   X3JHTEJmdNg1qCXQguEu0ybhRIaw9aQnlpxkJDXX5phaRl5i3M49V29Na
   TB1ILezZmDMjMaD9AISZmnO4lR43chemJxxE83Ih6TlT+411wOZ2c4hOf
   hcHgQu2RotsX9vOfYXVoE2PA84JGfGlGSM4TSWxQKIVchure3olpuC2nE
   w==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654552800"; 
   d="scan'208";a="26227510"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Sep 2022 15:03:51 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 16 Sep 2022 15:03:50 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 16 Sep 2022 15:03:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663333431; x=1694869431;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=X+f+brxdhEtU2bA0SXyEx650isaGDTLs/vUcZ2C9k2A=;
  b=EEsDRvbVrLlH+CVoDdjDiKxZBlEuJFxK5SRUzRBXHVzSxkfCZk7x+WPR
   e0E73IO/GdKyNun9nMjHaMhcexcOU+qg1NyLT58EXjSWOERdaYzgTA7cE
   d3D5si7nv3ljp7Q/U/9W+wtmgyyH4f4hqh4rQlBSgppz+2HkUk7i+OOHe
   1M88eZMGUVWEosbgOJFk2oy71/ZVuM0/iE2tK7JzDIfFmr/yEReM+oVz5
   YI4IhyXhSC3xe3YCuM7aTxe3Hx+zdNuUkDGfm1UAgTHu/QMc3q+QSRIVe
   KZNLNYfVtLEyQeISrmeQxPeoBwLnFHUXAq3KBB1rHhFxW2EXDwmukGjyH
   A==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654552800"; 
   d="scan'208";a="26227509"
Subject: Re: Re: [PATCH 1/2] dt-bindings: firmware: imx: sync with SCFW kit v1.13.0
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Sep 2022 15:03:51 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4A07A280056;
        Fri, 16 Sep 2022 15:03:50 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Viorel Suman <viorel.suman@oss.nxp.com>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viorel Suman <viorel.suman@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Fri, 16 Sep 2022 15:03:47 +0200
Message-ID: <24402933.EfDdHjke4D@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220916110936.jmxgjps5zrcndjxn@fsr-ub1664-116>
References: <20220915181805.424670-1-viorel.suman@oss.nxp.com> <5993734.44csPzL39Z@steina-w> <20220916110936.jmxgjps5zrcndjxn@fsr-ub1664-116>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viorel,

added missing CC.

Am Freitag, 16. September 2022, 13:09:36 CEST schrieb Viorel Suman:
> On 22-09-16 08:30:46, Alexander Stein wrote:
> > Am Donnerstag, 15. September 2022, 20:18:04 CEST schrieb Viorel Suman 
(OSS):
> > > From: Viorel Suman <viorel.suman@nxp.com>
> > > 
> > > Sync defines with the latest available SCFW kit version 1.13.0,
> > > may be found at the address below:
> > > 
> > > https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.
> > > 0&ap pType=license
> > > 
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > > ---
> > > 
> > >  include/dt-bindings/firmware/imx/rsrc.h | 299 ++++++++++++++++--------
> > >  1 file changed, 203 insertions(+), 96 deletions(-)
> > 
> > This is not bisectable and breaks compilation, as this patch removes
> > symbols which are still used in drivers/clk/imx/clk-imx8qm-rsrc.c
> > (addressed in 2nd patch). IMHO this series should be squashed into one
> > patch.
> 
> Hi Alexander,
> 
> Thank you for review, you are right. Is sending a squashed v2 the usual
> approach in such case or shall I hope that the maintainer will squash them
> before push ? Just want to avoid unnecessary noise.

AFAIK maintainers will not squash patches. This is something you will need to 
do yourself. So sending a v2 seems right.
Also please keep all the other recipients on CC.

Best regards,
Alexander



