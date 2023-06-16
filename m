Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A10733831
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjFPSeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjFPSeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5671FD5;
        Fri, 16 Jun 2023 11:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDBF9623D5;
        Fri, 16 Jun 2023 18:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257A3C433C0;
        Fri, 16 Jun 2023 18:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686940446;
        bh=UmQb6FNQc3kZycxaRrEf208LD6H0d3VHH/7wjn/eZgs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sSoW856XRyhhdpubOu3eCtjd9oQuJCLRRSOTHJ64BN7eYjN110eUBx5J29lBoRd6v
         VdB7I6tExsuxllymfO3U9Z8/PTbOP34HVvgN5JJqS7sB77KgUrmZfzXWkHA5cLqFXQ
         63Wl7L4yiHa3u7Hw1du1K5igyEh2uvZXsvhKOfu8a+BTc4OH2cCswgcZZLrP23DH/Y
         QtZSmuhMbDgzrtCN8u8IIfOh7P1Xbym/QN+md+32n2KnvCbmDZ6wboNmch1SckcLB6
         fxaHWx+Ns4yZGnRwnVJWmkE4qpjUQLCFpsUMON+lAhPy8/x73cR8gqaMLwnENSAYyw
         hBL9QTb9Hza+A==
Message-ID: <6f5220ef3ec3c05f32b5d6085d2e8adf.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230615213154.1753313-1-robh@kernel.org>
References: <20230615213154.1753313-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Remove last usage of "binding" or "schema" in titles
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
To:     - <devicetree-spec@vger.kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        =?utf-8?q?Fern=C3=A1ndez?= Rojas <noltari@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Suman Anna <s-anna@ti.com>
Date:   Fri, 16 Jun 2023 11:34:03 -0700
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

Quoting Rob Herring (2023-06-15 14:31:54)
> The Devicetree bindings document does not have to say in the title that
> it is a "Devicetree binding", but instead just describe the hardware.
>=20
> Most of these have been fixed already, so fix the handful that snuck in.
> With this, a meta-schema check can be enabled to catch these
> automatically.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
