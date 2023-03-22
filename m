Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1073C6C5AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCVXtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVXtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:49:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D712F2386A;
        Wed, 22 Mar 2023 16:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02726B81E98;
        Wed, 22 Mar 2023 23:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6C2C433EF;
        Wed, 22 Mar 2023 23:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679528957;
        bh=4e2XnzVD64xxw0K3LkJydIgTL5u8SOHIr+8q/XXU+cY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SQHWi+M9SksMIcwSwW7vQk2ilND7txWs1TQERx+M9MLFfOxkbkRwcYMY1Quf3fszz
         A9VzaLlXafrRLkseMo5Enbic1gJ4NIg16mxt6OINxPaLzLTvJcb03OgwL0EcKSpY+y
         xFWE73Yv65DknBcyHr+7+seStGRE0erx5o7HZDkoW4AcAle7CBOQ/nkUjfMiqCHbI1
         wSC4swco5gKd2WaMoA3KZ7dYaTj4vQNi4IzCndBKtW8d6h3zd3ws9T8cazIcKs5tym
         6A3Zif8XPxBSbAyIS7igO1XqC++zSWZpmZbYPO6yXENKVYtGj72zR7rqdmQWdLFCYP
         K4Luha7MPrWnA==
Message-ID: <003f436e96aa480f02ee5147f428f389.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230322173549.3972106-1-robh@kernel.org>
References: <20230322173549.3972106-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Drop unneeded quotes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Date:   Wed, 22 Mar 2023 16:49:15 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2023-03-22 10:35:48)
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
