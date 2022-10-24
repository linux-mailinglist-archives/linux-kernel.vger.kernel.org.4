Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED1160BBC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiJXVLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiJXVLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:11:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6373A2D038F;
        Mon, 24 Oct 2022 12:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D728B817B0;
        Mon, 24 Oct 2022 12:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E0DC433D6;
        Mon, 24 Oct 2022 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666615874;
        bh=4cT1AgEscL+bDejuGY6uubW9ABwIZGuR4hZ++Wp8v4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kq3W0qANSUbPg7Xp/RRLV7VbWyzUd4fFQfb2glXmct6bX6PIhetoQgY85xKNVeA+J
         G6jvtiH0AxGM35AE0jkcMeu8B3ip0EwROrkAQfDl6VVWPpT19T544nwG7qFVCop0VI
         HDNSyETZfrbbhPwwU7JyS7whFHvKU4rqL4Qy4qZsH6Z9upRjNew40drv8HnH1wbgMW
         I/bZPHsz9Gi23tSc8LlxSOnHWY6O4v9KT3nTwLO3zW6yfkolKWKQwH4wnwT3LBcdsn
         W+D1mLFp2BV/5+TXP/f9FolibKs2KNirfCEyZNpHUj20JdWj8iYfZvGEUe+miHsp/n
         ip4jPJQHClUqA==
Date:   Mon, 24 Oct 2022 13:51:07 +0100
From:   Lee Jones <lee@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: mfd: mt6397: add binding for MT6357
Message-ID: <Y1aKOxGTNAsb2vgz@google.com>
References: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
 <20221005-mt6357-support-v2-1-f17ba2d2d0a9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221005-mt6357-support-v2-1-f17ba2d2d0a9@baylibre.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2022, Alexandre Mergnat wrote:

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
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 0088442efca1..518986c44880 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -21,6 +21,7 @@ Required properties:
>  compatible:
>  	"mediatek,mt6323" for PMIC MT6323
>  	"mediatek,mt6331" for PMIC MT6331 and MT6332
> +	"mediatek,mt6357" for PMIC MT6357
>  	"mediatek,mt6358" for PMIC MT6358 and MT6366
>  	"mediatek,mt6359" for PMIC MT6359
>  	"mediatek,mt6397" for PMIC MT6397

Let me know when it's safe to merge this.

-- 
Lee Jones [李琼斯]
