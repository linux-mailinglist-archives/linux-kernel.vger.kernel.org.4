Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7905B67C2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjAZCT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjAZCT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:19:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CC4366AF;
        Wed, 25 Jan 2023 18:19:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5581B6171A;
        Thu, 26 Jan 2023 02:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B96C433EF;
        Thu, 26 Jan 2023 02:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674699565;
        bh=FzfcYhdvhhqXC92MQNxZiIt7bbyHYk0TCSvJiiZVLdw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HRCpRnhYRh0Ijd+5XIEqo+S33nWqvMqLgd3dDfR7mU+YdX6Pcu+3Ti3v4mCuTiCSa
         KCw7wEuYAQ62X1xP7/lQyOhQ//VBVWyTwiLGktbpInwYkZrcVSFShKSPfb/M7jSbw5
         Gzs0c+QNuPqnYHOps9TLa7wVvDEpuce0XLaqEFlrV1cXkqpV6YRnK2PIjqzZgwa0xk
         ips1BFWC0FLMc4Use//2QtU2aDpPFrJeYUFsBRSyGS2p53YIpuKheC0EUcVwOpPYbT
         mpwqLYL+0XJ+CbYAhhdTQDvAvKRcH86VdSCnBgd0oqL0FHyAJzjJLeCI6q9O1kWUTI
         krFHMVomsXrxg==
Message-ID: <2b3a32bd490dbb55cbcd2cfdc5abffa3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ae9acd210c1566b4bd72b09df4430bcad4a36c9b.1674401764.git.daniel@makrotopia.org>
References: <cover.1674401764.git.daniel@makrotopia.org> <ae9acd210c1566b4bd72b09df4430bcad4a36c9b.1674401764.git.daniel@makrotopia.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: clock: Add apmixedsys/topckgen compatibles for MT7981
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Wed, 25 Jan 2023 18:19:23 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Golle (2023-01-22 07:42:27)
> Add compatible string for MT7981 to existing bindings
> at mediatek,apmixedsys.yaml and mediatek,topckgen.yaml.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Applied to clk-next
