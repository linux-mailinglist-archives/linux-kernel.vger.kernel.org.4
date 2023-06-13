Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D14A72D6D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbjFMBXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFMBXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:23:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C52E9;
        Mon, 12 Jun 2023 18:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69A9562F8E;
        Tue, 13 Jun 2023 01:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CC6C433D2;
        Tue, 13 Jun 2023 01:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686619392;
        bh=hKVJVDxjlBzmnqNXqltTTn6L+7UePw7y1G1OQMpeork=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Y+Qr/P0UKw8OmwUv2E+Fzwjlhg9IdjtQxe/SkIWcIJ4rr1gK1Evafpdre034v1g3V
         4OHQX3XkHg9hLeph8bQmLcNhtTvHehpF3tLBs/u0nV4598qBWCcG2ZWJv840sQW6mO
         oVziNbOOOAMWdm9ilQzhWmgL7i8EPmwLlhTzPtXz7YIxobeHjElfouDLwjy6IALjvL
         CCn+fRW0UoMLYIWyS1B9AdNQmNYKF2S0npS8mu8f6VyhDmftdHgV1arKLcjdTojEck
         gD6KBBu3Me5Omcjyj7rhyh0xhttgNkqwyf8E/5ApO3GUaOk2YajekJ8H98J3kFutUr
         8yuwQnKAHNgwQ==
Message-ID: <f948816e5c27de2f72b17b2593c8c7bf.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230525075011.7032-2-runyang.chen@mediatek.com>
References: <20230525075011.7032-1-runyang.chen@mediatek.com> <20230525075011.7032-2-runyang.chen@mediatek.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: reset: mt8188: add thermal reset control bit
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Runyang Chen <runyang.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Runyang Chen <runyang.chen@mediatek.com>
Date:   Mon, 12 Jun 2023 18:23:10 -0700
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

Quoting Runyang Chen (2023-05-25 00:50:10)
> To support reset of infra_ao, add the index of infra_ao reset of thermal
> for MT8188.
>=20
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied to clk-next
