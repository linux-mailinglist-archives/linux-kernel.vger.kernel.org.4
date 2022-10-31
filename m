Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5905961393A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiJaOpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiJaOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:45:29 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7F2101C2;
        Mon, 31 Oct 2022 07:45:27 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id y67so13024858oiy.1;
        Mon, 31 Oct 2022 07:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xn4+1msnko+9e0m7siIGlOveOVoLkD2d39pnfpxZtnk=;
        b=CJOoIchxNsImyVueKx/SxSeWH4UATCH6L3H5aHc3kyXwjNqVTlMU4C1kgQMMchbQHD
         Uve0bQiPJl2qyShFEhRgArNOnG8EvJsFKB75vf169v/0v9WF1EjwpImD/Vo9kU4R5h1W
         hbv5+ab96nyr2bQa4JOlpFlswpXUc+tbsoBO5JXvVVgKZ07E5YSy4GHjL+vGtjTnPWRY
         qi/cAC59+U70qzpv/hTw7FjZ0LGiTM9duqg/5bj1WOjZuGBf1eojRb8DNPghJPFh7T8i
         wzEEesxFuAKf8uxhOUwLr7+48shxcGTVrCVEdF2vFLqfwtiDw1zHmKftaHEFUl8rf3Ye
         uBwg==
X-Gm-Message-State: ACrzQf1FPaM6cQti6FUo3bvKCTM9M3wi/mA6FKHgU06gh/A0vt+goqpK
        9wFvDe1PmaaIhd4MlfBmmA==
X-Google-Smtp-Source: AMsMyM4H8uQmmu7Jy4YGGytjMaM+JUYHpTj+D7MDv3fs/PXmunvqTxXEzKVvGNE6N6YKT+YNFglZ8Q==
X-Received: by 2002:a05:6808:1a27:b0:354:55e5:9777 with SMTP id bk39-20020a0568081a2700b0035455e59777mr14919019oib.267.1667227526966;
        Mon, 31 Oct 2022 07:45:26 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p5-20020a056870830500b0013b92b3ac64sm3124401oae.3.2022.10.31.07.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:45:26 -0700 (PDT)
Received: (nullmailer pid 2860621 invoked by uid 1000);
        Mon, 31 Oct 2022 14:45:28 -0000
Date:   Mon, 31 Oct 2022 09:45:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Joel Peshkin <joel.peshkin@broadcom.com>, u-boot@lists.denx.de,
        Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH V3 1/2] dt-bindings: mtd: partitions: u-boot: allow
 dynamic subpartitions
Message-ID: <166722752391.2860511.4769510396769806358.robh@kernel.org>
References: <20221018154202.4634-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221018154202.4634-1-zajec5@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Oct 2022 17:42:01 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot partition may contain subpartitions. For example Broadcom
> includes environment data block in the middle of its U-Boot partition.
> 
> This allows describing Broadcom's U-Boot env data and will allow
> referencing its NVMEM cell in the future.
> 
> Reg: 118f3fbe517f4 ("dt-bindings: mtd: partitions: support label/name only partition")
> Ref: dd638202dfb65 ("dt-bindings: mtd: partitions: add additional example for qcom,smem-part")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V3: Add this patch as pre-requirement for u-boot,env.yaml & brcm,env
> ---
>  .../devicetree/bindings/mtd/partitions/u-boot.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Applied, thanks!
