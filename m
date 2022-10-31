Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0DE613873
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiJaNxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiJaNxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:53:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6DF2C4;
        Mon, 31 Oct 2022 06:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AB8D60FFA;
        Mon, 31 Oct 2022 13:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDAAC433D6;
        Mon, 31 Oct 2022 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667224427;
        bh=pTy7t7Q8QOwX1bSA4Jd5z2ewZ2NvD0qcR1QWYdy44rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AECja8WxEAHVraIRg2PtlfXZEnzCsq0KVf/wn77pDT1Afy9ppuHT1z9uGvIljxogY
         C73SyMCwEW6Gl/L3Hk4jnxvi9MO/RohHWhUQM1Walr0v3pzqaPiQ4gCnyS9M1qaOMO
         sFY3ouaKCFc2OcHQlbfxFwcEWStGCg0k88IhobOqX6Ql3aiUPL4vkrFY95ypFu4yEI
         RjuVfVrbPSdzMg6Svb1iVdi1P2DC1zEwyEsfBX47ZYXjYVVrqA6LrGfMFcjJyVLjM4
         CN96eUnPeEinFXSjhC3zcNBNG63JBJVh9Acdj4leaX5pgGM/2ryAvH2GUAkbSwJGcE
         0Ro5UfrXJDr7Q==
Date:   Mon, 31 Oct 2022 13:53:40 +0000
From:   Lee Jones <lee@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: mt6397: add binding for MT6357
Message-ID: <Y1/TZEMBF3OI+XSa@google.com>
References: <20221005-mt6357-support-v3-0-7e0bd7c315b2@baylibre.com>
 <20221005-mt6357-support-v3-1-7e0bd7c315b2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221005-mt6357-support-v3-1-7e0bd7c315b2@baylibre.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022, Alexandre Mergnat wrote:

> From: Fabien Parent <fparent@baylibre.com>
> 
> Add binding documentation for the MT6357 PMIC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
