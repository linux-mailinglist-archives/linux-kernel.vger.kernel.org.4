Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61767CE59
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjAZOib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjAZOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:38:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6806180;
        Thu, 26 Jan 2023 06:38:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58C52B81D15;
        Thu, 26 Jan 2023 14:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819EEC433D2;
        Thu, 26 Jan 2023 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674743906;
        bh=J6kTUDHhp3UX3SKN+nHetWZA+yyFDNmaZMGXaU/Kwxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYTqRKSW62JnHa+QPvCzuJ7D2W5Sd7w+SS+Gc0kWhW6sBEwV0WEY2ZuHBR5v2yJqW
         gOTg417S8mg4dOOPMkiJ26ELSOjpVxezlY05fYHilegIrMTy6n/ONSO4VdXuJnQFvO
         0SVTvHTgCwbRdcR4w7ZNDUiO1wsuOz9YZRme9IUOTMQds93NFLeJSiCYsDN6yw/DBi
         uxPg6UxNhAGKostehxnl/tu8sS8gzTLppGnOWRvt4QQVO+51Aj4ddhEkv7JfT6SAG5
         wngRELtMSbB/qu8QwRM3+FhYlIuT7B3E6jv0iwh5yF5ytRm8YliUnKog2E4Tkrr5il
         Pyu2Yp1gItPMg==
Date:   Thu, 26 Jan 2023 14:38:18 +0000
From:   Lee Jones <lee@kernel.org>
To:     Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, linus.walleij@linaro.org, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        chunfeng.yun@mediatek.com, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com
Subject: Re: [PATCH v9 3/9] dt-bindings: mfd: syscon: Add mt8365-syscfg
Message-ID: <Y9KQWp1942TDjV1P@google.com>
References: <20230125143503.1015424-1-bero@baylibre.com>
 <20230125143503.1015424-4-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230125143503.1015424-4-bero@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023, Bernhard Rosenkränzer wrote:

> Document Mediatek mt8365-syscfg
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
