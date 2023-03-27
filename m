Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF76D6CA8FF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjC0Pa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjC0Pa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:30:26 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646FA126;
        Mon, 27 Mar 2023 08:30:23 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id l39-20020a9d1b2a000000b006a121324abdso3160893otl.7;
        Mon, 27 Mar 2023 08:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679931022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyK2fUsSPD/ZhKF2aRPOTaEqWirYfYdqwsIGEX2UYRY=;
        b=wqJc3AamYZ6QNJO/LpTwJdTDEmfJK6bJBraBw+wsxZt7iuyB1ZMjk42dfERUlgTJ8m
         yBfmcvDozxx8O9kWJmMcjsVlot7203jD1nsktdNKd6ZlZWn1syXbHwVQBCHlwi6o0VyW
         HwVBhOU0WTBK/kgfoP32htWYtW9XXzOD9Q2EhWxzDF+hx+ZCVE1XzwYYJhVz2rn7Gd/5
         fgDrqRBzgki7nhJvQm89t6l57Pb39wURUhgw4HsnuQis4Cy8t/yNY/Jmb9/xU2vCvS9p
         qlnpmFJsWIEGx8G01KKQwQgN1RQKJ8u0mjsRVnfQvivPZRSff0nxPYEZmfdeLLcTmeZO
         yitg==
X-Gm-Message-State: AO0yUKWSEpjbToTvBxHXolvFa5K5KD+I8X8R3W8MSnA130R2f3gyhglW
        7JJkxTNXEeyF9Vcbjo6oiw==
X-Google-Smtp-Source: AK7set/gGvswDR9Qi8QEAjTtwuOiAplRhNhucwkwiCcY/K2JNpIB9iD2QrPd5kmkGr8CtufM0mCkUA==
X-Received: by 2002:a9d:6642:0:b0:690:a6b3:a2f6 with SMTP id q2-20020a9d6642000000b00690a6b3a2f6mr6294603otm.0.1679931022551;
        Mon, 27 Mar 2023 08:30:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j15-20020a9d7f0f000000b0069fb32837a9sm4748248otq.42.2023.03.27.08.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:30:22 -0700 (PDT)
Received: (nullmailer pid 3908955 invoked by uid 1000);
        Mon, 27 Mar 2023 15:30:21 -0000
Date:   Mon, 27 Mar 2023 10:30:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-sunxi@lists.linux.dev, Conor Dooley <conor@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        kernel@collabora.com, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 01/10] dt-bindings: serial: snps-dw-apb-uart: Switch
 dma-names order
Message-ID: <167993102075.3908904.11641161105077047331.robh@kernel.org>
References: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
 <20230321215624.78383-2-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321215624.78383-2-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Mar 2023 23:56:15 +0200, Cristian Ciocaltea wrote:
> Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
> dma-names properties") documented dma-names property to handle Allwinner
> D1 dtbs_check warnings, but relies on the rx->tx ordering, which is the
> reverse of what a different board expects:
> 
>   rk3326-odroid-go2.dtb: serial@ff030000: dma-names:0: 'rx' was expected
> 
> A quick and incomplete check shows the inconsistency is present in many
> other DTS files:
> 
> $ git grep -A10 snps,dw-apb-uart | grep dma-names | sort -u
> arch/arm64/boot/dts/rockchip/px30.dtsi-         dma-names = "tx", "rx";
> arch/arm64/boot/dts/rockchip/rk3328.dtsi-       dma-names = "tx", "rx";
> arch/arm64/boot/dts/rockchip/rk3588s.dtsi-      dma-names = "tx", "rx";
> arch/arm/boot/dts/rk3066a.dtsi-                 dma-names = "tx", "rx";
> arch/arm/boot/dts/rk3128.dtsi-                  dma-names = "tx", "rx";
> arch/arm/boot/dts/rk3288.dtsi-                  dma-names = "tx", "rx";
> arch/arm/boot/dts/rv1126.dtsi-                  dma-names = "tx", "rx";
> arch/arm/boot/dts/socfpga.dtsi-                 dma-names = "tx", "rx";
> arch/arm/boot/dts/sun6i-a31.dtsi-               dma-names = "rx", "tx";
> arch/arm/boot/dts/sun8i-a23-a33.dtsi-           dma-names = "rx", "tx";
> arch/arm/boot/dts/sun8i-v3s.dtsi-               dma-names = "rx", "tx";
> arch/arm/boot/dts/sunxi-h3-h5.dtsi-             dma-names = "rx", "tx";
> arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dma-names = "rx", "tx";
> 
> The initial proposed solution was to allow a flexible dma-names order in
> the binding, due to potential ABI breakage concerns after fixing the DTS
> files. But luckily the Allwinner boards are not really affected, since
> all of them are using a shared DMA channel for rx and tx:
> 
> $ git grep -A10 snps,dw-apb-uart | grep 'sun.*dmas' | sort -u
> arch/arm/boot/dts/sun6i-a31.dtsi-       dmas = <&dma 10>, <&dma 10>;
> arch/arm/boot/dts/sun6i-a31.dtsi-       dmas = <&dma 22>, <&dma 22>;
> arch/arm/boot/dts/sun6i-a31.dtsi-       dmas = <&dma 6>, <&dma 6>;
> arch/arm/boot/dts/sun6i-a31.dtsi-       dmas = <&dma 7>, <&dma 7>;
> arch/arm/boot/dts/sun6i-a31.dtsi-       dmas = <&dma 8>, <&dma 8>;
> arch/arm/boot/dts/sun6i-a31.dtsi-       dmas = <&dma 9>, <&dma 9>;
> arch/arm/boot/dts/sun8i-a23-a33.dtsi-   dmas = <&dma 10>, <&dma 10>;
> arch/arm/boot/dts/sun8i-a23-a33.dtsi-   dmas = <&dma 6>, <&dma 6>;
> arch/arm/boot/dts/sun8i-a23-a33.dtsi-   dmas = <&dma 7>, <&dma 7>;
> arch/arm/boot/dts/sun8i-a23-a33.dtsi-   dmas = <&dma 8>, <&dma 8>;
> arch/arm/boot/dts/sun8i-a23-a33.dtsi-   dmas = <&dma 9>, <&dma 9>;
> arch/arm/boot/dts/sun8i-v3s.dtsi-       dmas = <&dma 6>, <&dma 6>;
> arch/arm/boot/dts/sun8i-v3s.dtsi-       dmas = <&dma 7>, <&dma 7>;
> arch/arm/boot/dts/sun8i-v3s.dtsi-       dmas = <&dma 8>, <&dma 8>;
> arch/arm/boot/dts/sunxi-h3-h5.dtsi-     dmas = <&dma 6>, <&dma 6>;
> arch/arm/boot/dts/sunxi-h3-h5.dtsi-     dmas = <&dma 7>, <&dma 7>;
> arch/arm/boot/dts/sunxi-h3-h5.dtsi-     dmas = <&dma 8>, <&dma 8>;
> arch/arm/boot/dts/sunxi-h3-h5.dtsi-     dmas = <&dma 9>, <&dma 9>;
> arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dmas = <&dma 14>, <&dma 14>;
> arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dmas = <&dma 15>, <&dma 15>;
> arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dmas = <&dma 16>, <&dma 16>;
> arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dmas = <&dma 17>, <&dma 17>;
> arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dmas = <&dma 18>, <&dma 18>;
> arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi-  dmas = <&dma 19>, <&dma 19>;
> 
> Switch dma-names order to tx->rx as the first step in fixing the
> inconsistency. The remaining DTS fixes will be handled by separate
> patches.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

