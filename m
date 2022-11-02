Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F9B616E9B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiKBU0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:26:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DF65FA4;
        Wed,  2 Nov 2022 13:26:24 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F4EE66028C5;
        Wed,  2 Nov 2022 20:26:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667420783;
        bh=SiBvjEqjOQ8graHul0d5aAHZ7lbj/evLfaj1eQjt2V0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ng3Sf5zbd8v3RnHNOf/X0A1C+ftRd/MMRqo1nP2oAWf6OzA4V3bw/09s+fPXFQRK/
         kbE9nwOVpOLLWW3DyqS6q2HwBULZxVeU87MjVUptsIXrTGul1AcA3L9vqMKRCaMXgw
         ufzaZbtGUVM84QHrSF7F9vq0iW5iT8Xvg1xzWd5h6Vs/p2Vb2fXDjGwl4MMAtZJ19H
         Q+39kLTE/n3s94hMo0HtnJhjdNyfW7LUe5nAnLu8zpYOeFInwKzDUg3fV+aVatKGlg
         GlJr+fCH10ywr4UhwTw4rMoHh0kvepd2Xg9hK2xGzrtUHeUfoGvqo5AK7Nx5H8GXZM
         22vaTblxzOGdA==
Date:   Wed, 2 Nov 2022 16:26:17 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 5/7] dt-bindings: watchdog: mediatek: Convert mtk-wdt
 to json-schema
Message-ID: <20221102202617.ailu6xc5qfstnl6c@notapiano>
References: <20221101090116.27130-1-allen-kh.cheng@mediatek.com>
 <20221101090116.27130-6-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101090116.27130-6-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 05:01:14PM +0800, Allen-KH Cheng wrote:
[..]
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
[..]
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        watchdog: watchdog@10007000 {

You could drop this label since it's not used in the example.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> +            compatible = "mediatek,mt8183-wdt";
> +            reg = <0 0x10007000 0 0x100>;
> +            interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
> +            mediatek,disable-extrst;
> +            timeout-sec = <10>;
> +            #reset-cells = <1>;
> +        };
> +    };
[..]
