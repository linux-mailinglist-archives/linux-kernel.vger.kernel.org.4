Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4121A6CB01E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjC0Uqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjC0Uqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:46:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42B22727;
        Mon, 27 Mar 2023 13:46:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eg48so41297079edb.13;
        Mon, 27 Mar 2023 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679950003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5VGGE40NcbEq8mDa+XnKTY8jKSu6LE7xtzGaY9kskM=;
        b=aY9n6MwEOjFxlplG/AmL1AhqIv6DAGPlesKsrSMZUOQfrazRbBVuLvn/maeIs9IH2S
         i1/4kALdIGyCdVYjF58Gmh/aZMsqpQa9ap/Awf9qSknI9le2GH+39R89RPlTFovdUaeD
         2n5eWhISNQsl73Zg7uh9pKQTVvFGP92WlUjlrwDaxO6rCLBmawXNB7SiPwyrJXWsCwJv
         Sv9YiJMkxpFyr3Kc8rgdHIQtzRZu3FvDzcAU7ktuas5gkar71JxZHt0bGmFxY4aKlPaI
         5jyNtYd6DM/ay/JufXUfyjF+12zA2R8QLofrVAL5DDFdcUQEdIRRxQedl1rnJY6jkSj0
         Nqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5VGGE40NcbEq8mDa+XnKTY8jKSu6LE7xtzGaY9kskM=;
        b=s5So6MQPtah+kKr2QuySn7ujdweuD915DUKr93vJpPqNX5vEjBIo/UcoaYn1zR1anA
         ++VhIc3pKHu5VsePD7NYWlSEoS4hA5DvexLh+F4gyvv9aeUeCRpq/UGkMeXd336xSovX
         wYcHVmtR+dUWqHtwymDTiZX+H73DV/Fe0di0ds9Ar51pXyqpHZ0dGGoflztpTltgVMmD
         Zb07+XNi32U1QI4pFZYgeWGxmppF5Cauk/Fuff4LrRbfGpImnTJWuKV+kwhVvmALymX6
         kdesy2Lx0yGqVxexUKjTGuEsIu3xyRMopSzPv+HKnAzti0e0imNMx9MJNJXH/5fjeBJC
         85Eg==
X-Gm-Message-State: AAQBX9cv0v/UATSWSt4T2GDPuT00R4xMuQpB0Fj+qfAuq9ilzUi750R5
        PJyQFZLRNezjcR8tDUjFPgU=
X-Google-Smtp-Source: AKy350aK9Y63itdv4ewgSBQo+2OgFfKBT+Q+is5SeV+AA/eMwqp0tLtQc6vcwjQ/bGUVRwPpC2Gc3w==
X-Received: by 2002:a17:906:4d0f:b0:8b2:8876:6a3c with SMTP id r15-20020a1709064d0f00b008b288766a3cmr12973366eju.29.1679950002716;
        Mon, 27 Mar 2023 13:46:42 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906504300b00930c6c01c9esm14694983ejk.143.2023.03.27.13.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:46:42 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?ISO-8859-1?Q?Andr=E1s_Szemz=F6?= <szemzo.andras@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>,
        Fabien Poussin <fabien.poussin@gmail.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH v2 0/4] ARM: dts: sunxi: Add MangoPi MQ-R board support
Date:   Mon, 27 Mar 2023 22:46:40 +0200
Message-ID: <2673156.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230320005249.13403-1-andre.przywara@arm.com>
References: <20230320005249.13403-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 20. marec 2023 ob 01:52:45 CEST je Andre Przywara napisal(a):
> Hi,
> 
> this is v2, mostly acknowledging the fact that there is an Allwinner D1s
> version of the board as well, thus splitting the board .dts into a
> shared .dtsi and a stub .dts for the ARM version. I don't have the RISC-V
> version, so cannot provide (nor test) this .dts file, but creation should
> be easy, being based on the shared board .dtsi file.
> Since the D1/D1s .dts files are now merged, this patch set should compile
> cleanly now.
> 
> ======================================
> 
> The MangoPi MQ-R-T113 is a small SBC with the Allwinner T113-s3 SoC.
> That is a very close relative to the Allwinner D1/D1s SoCs, but with
> Arm Cortex-A7 cores, and 128 MB of SIP co-packaged DDR3 DRAM.
> 
> This series introduces the missing T113-s .dtsi, which builds on top of
> the D1/D1s .dtsi, but adds the ARM specific peripherals, like the CPU
> cores, the arch timer, the GIC and the PMU.
> This requires to add a symlink to the RISC-V DT directory in patch 1/4,
> to be able to easily reference the base .dtsi from other architecture
> directories.
> Since there are versions of the MQ-R boards with the Allwinner D1s,
> there is shared .dtsi describing the board peripherals, plus a small
> stub .dts to tie together all bits for the actual board.
> 
> Cheers,
> Andre
> 
> Changelog v1 ... v2:
> - rebase on top of v6.3-rc3 (including now merged D1/D1s .dtsi files)
> - refine board naming, stating both RISC-V and ARM versions
> - move board .dts into a shared .dtsi (to cover RISC-V version)
> - fix 5V regulator node name
> 
> Andre Przywara (4):
>   dts: add riscv include prefix link
>   ARM: dts: sunxi: add Allwinner T113-s SoC .dtsi
>   dt-bindings: arm: sunxi: document MangoPi MQ-R board names
>   ARM: dts: sunxi: add MangoPi MQ-R-T113 board
> 
>  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
>  .../devicetree/bindings/riscv/sunxi.yaml      |   5 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/sun8i-t113s-mangopi-mq-r-t113.dts     |  35 +++++
>  arch/arm/boot/dts/sun8i-t113s.dtsi            |  59 ++++++++
>  .../boot/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi | 126 ++++++++++++++++++
>  scripts/dtc/include-prefixes/riscv            |   1 +
>  7 files changed, 232 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r-t113.dts
>  create mode 100644 arch/arm/boot/dts/sun8i-t113s.dtsi
>  create mode 100644 arch/arm/boot/dts/sunxi-d1s-t113-mangopi-mq-r.dtsi
>  create mode 120000 scripts/dtc/include-prefixes/riscv

Merged, thanks!

Best regards,
Jernej



