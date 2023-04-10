Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007806DC9A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDJQ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDJQ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA1F1BF0;
        Mon, 10 Apr 2023 09:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C94B460EE9;
        Mon, 10 Apr 2023 16:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00A4C433D2;
        Mon, 10 Apr 2023 16:59:32 +0000 (UTC)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Yong Wu <yong.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add MT8365 SMI driver support
Date:   Mon, 10 Apr 2023 18:59:26 +0200
Message-Id: <168114590173.12295.2225877177937084104.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407-smi-driver-v2-0-8da6683cdb5c@baylibre.com>
References: <20230407-smi-driver-v2-0-8da6683cdb5c@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Apr 2023 11:13:50 +0200, Alexandre Mergnat wrote:
> This serie add MT8365 SMI common driver support, to be bisectable and
> avoid issue with the DTS change. This driver change and the related
> change in the DTS should be applied in the right order (driver first).
> 
> Here the related DTS change: [1]
> 
> Also add the SMI common and LARB bindings for MT8365 support,
> I kept the Matthias Brugger reviewed-by from the previous series [3] [4].
> 
> [...]

Applied, thanks! It's late, so it might miss current cycle.

With corrected order of patches (I don't know why you decided to reorder
bindings with driver. Bindings should be before its usage).


[1/3] memory: mtk-smi: mt8365: Add SMI Support
      https://git.kernel.org/krzk/linux-mem-ctrl/c/3ec0e1ea4770e40575bfb2bb4e9ebbbaa3c80d3f
[2/3] dt-bindings: memory-controllers: mediatek,smi-common: add mt8365
      https://git.kernel.org/krzk/linux-mem-ctrl/c/67025255ee8b1ec496b01f74e8c298d211bc7a82
[3/3] dt-bindings: memory-controllers: mediatek,smi-larb: add mt8365
      https://git.kernel.org/krzk/linux-mem-ctrl/c/4ad9a801a3597ccfd406c911638aca2c61e57bdf

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
