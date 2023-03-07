Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0305E6AF701
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCGUzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjCGUzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:55:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FE3A80C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:55:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so17841220pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 12:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678222546;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PO0KQCxzIVJEU61zfS2DoDmuDuWz5uR1jN4Ijq9LhZo=;
        b=lpHxnwwPK15OkkFaTvNUoMCaaJEJi5c9/PYeQlJ2jMiPjoPkgwrepzfmkgtyO8O+HT
         wu3juAerU/L8cjIvUiZtQspVCHC1d+932kvi9FW+xS58qaCCsLdpwmai+bjXxQUdzCBk
         l5mlHFpS9jE3/r4xQTsIA2O/p/CuMHJIkcb3A1pOHy9/Eybrn33WBmaDgDf4G3UIfr1c
         iefB4omy/roI6W5ox5wVdjkHqU98G/aw2ZD5T4ZB2CVf1Z6vufEQTV3jCShu28V1PcbC
         KCwAXE2IWqbcaM7JP5Wtn8oVYsGG0J89eG+an5RJcAvSARQQ+1X9OB8PkFV4ARWVOREC
         56Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222546;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PO0KQCxzIVJEU61zfS2DoDmuDuWz5uR1jN4Ijq9LhZo=;
        b=cfgAKFmMsdlpxgDQpxQUN/Qbw0JZom5gydm9mbSxLlRBulR3PAnli7G1k8NCtYKqBU
         vuOwAypVboBFgklS34//LhWNhsg8f9bXxwjxZ5Cg35o4r4JyIMyWo34trAlSZnPLuIDF
         pzIJrlTZH7ZewxnV7I/a31rNvb2AKYF7hpFmqr+eJnHuAVRo4+4VVREyftm5coHxMB8b
         jHvn+eBMOXauk07nT/NTv4tf59sxK/7wBwt2OUr6oeO737+gfcDoBMkH734QvswIDFkX
         VlsUjjzlNqYPfvo1beVzhtNRqxDpXURAFvCYNNmbOqNavwczUmcVoJEMi5nf0RI0o1ko
         QC7Q==
X-Gm-Message-State: AO0yUKWwYBbDsvxQt7ZMdyHhKTxiBoNC1FYd+mO7qubBpdJx5TUpGRte
        hXFqu0FM37BpNIVayfgYILk1taJSMqcUFZLM2Ew=
X-Google-Smtp-Source: AK7set8dzNL26UJcqtdZJRUN5setrL9jyj2OiCFQRqVQnRmvelN4BI2oq+p+jIfWk57Ieeg5LqLM/Q==
X-Received: by 2002:a17:902:bc42:b0:19e:6a4c:9fa0 with SMTP id t2-20020a170902bc4200b0019e6a4c9fa0mr14126770plz.49.1678222546093;
        Tue, 07 Mar 2023 12:55:46 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b0019c2cf1554csm8814373plc.13.2023.03.07.12.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 12:55:45 -0800 (PST)
Date:   Tue, 07 Mar 2023 12:55:45 -0800 (PST)
X-Google-Original-Date: Tue, 07 Mar 2023 12:54:38 PST (-0800)
Subject:     Re: [PATCH v2 3/3] riscv: dts: allwinner: d1: Add crypto engine node
In-Reply-To: <20221231220146.646-4-samuel@sholland.org>
CC:     clabbe.montjoie@gmail.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, wens@csie.org, jernej.skrabec@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        samuel@sholland.org, aou@eecs.berkeley.edu,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     samuel@sholland.org
Message-ID: <mhng-0ef61e01-7731-4c5f-9487-e4ab8553b87c@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2022 14:01:45 PST (-0800), samuel@sholland.org wrote:
> D1 contains a crypto engine which is supported by the sun8i-ce driver.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> Changes in v2:
>  - New patch for v2
>
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index dff363a3c934..b30b4b1465f6 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -378,6 +378,18 @@ sid: efuse@3006000 {
>  			#size-cells = <1>;
>  		};
>
> +		crypto: crypto@3040000 {
> +			compatible = "allwinner,sun20i-d1-crypto";
> +			reg = <0x3040000 0x800>;
> +			interrupts = <SOC_PERIPHERAL_IRQ(52) IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_CE>,
> +				 <&ccu CLK_CE>,
> +				 <&ccu CLK_MBUS_CE>,
> +				 <&rtc CLK_IOSC>;
> +			clock-names = "bus", "mod", "ram", "trng";
> +			resets = <&ccu RST_BUS_CE>;
> +		};
> +
>  		mbus: dram-controller@3102000 {
>  			compatible = "allwinner,sun20i-d1-mbus";
>  			reg = <0x3102000 0x1000>,

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
