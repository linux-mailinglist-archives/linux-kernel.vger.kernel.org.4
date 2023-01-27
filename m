Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1A67E870
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjA0Oi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjA0OiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:38:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B948A13DD1;
        Fri, 27 Jan 2023 06:38:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53DEE61CBD;
        Fri, 27 Jan 2023 14:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39A1C433D2;
        Fri, 27 Jan 2023 14:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674830296;
        bh=bTSW7NmUsG8tgCcNy2Sa9snhAmKGyq9mToBUWqqSejs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPljhGE8A8JrC03p17PQpzYPtj3u75TC2O/cCxPLGk7/Pmz5E/ImwxNSE8X1ldeAo
         tTr7Y5V6jtLpeG/wzh6dpC6F4GtN0gucg5gzrvT7JOmJ++JYoUyGHXibvBBnZqorVM
         hB9wqE7Vg9ddwFl+Ux8p5/6zmkVBUM0MMt36rd2+Yg5qcg/OsOFCTEIGxMX8F8SfEf
         y36NhgZyoLpyXnJixgHK1oB/FMExUaFyk3A7kqqZKO1LrmDjqJA/SSBRw51/tNYBY9
         5jPeHU6lRheS1fMNKS8pl8HJeTIyXFJz8MzJhdNhcfsqkRB9gOjLofn8lhEOsvOcZM
         mHWz3+n54xWzw==
Date:   Fri, 27 Jan 2023 14:38:08 +0000
From:   Lee Jones <lee@kernel.org>
To:     Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, linus.walleij@linaro.org, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        chunfeng.yun@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        andrew@lunn.ch, gtk3@inbox.ru, sean.wang@mediatek.com,
        zhiyong.tao@mediatek.com
Subject: Re: [PATCH v8 3/9] dt-bindings: mfd: syscon: Add mt8365-syscfg
Message-ID: <Y9Ph0E09GycQ20J4@google.com>
References: <20230123163833.1007181-1-bero@baylibre.com>
 <20230123163833.1007181-4-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230123163833.1007181-4-bero@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023, Bernhard Rosenkränzer wrote:

> Document Mediatek mt8365-syscfg
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
