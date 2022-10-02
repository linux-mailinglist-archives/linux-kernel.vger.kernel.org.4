Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3445F23ED
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJBPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 11:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJBPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 11:47:11 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52BA20F75
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 08:47:09 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p202so6581826iod.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+gVLOM9oJ/Z3Z9VbAgGHKohagg2/0xc8CE20DVhCLbE=;
        b=BVzl67o7Y6uc2hxlLW04rVhRrrQSNLpciDc+i2g9BJQ63+MrpeVfvuuMzYGt52hKyU
         jSMvtruVsBmxwcXXn8RkY9ph/y8IFLB+cYmjN7etCjGVtlzUAeoLrRjTjoNtWwnW/CJL
         tW7LKTbGiWqgKXPDBmYQClcw7idoz/QghZbWZwHZ55ISkZsJZQLfWCQgRSAFTUWjCsLP
         0fmh5Fnw5A8Rvl/LNpiYvp2bCsKMpU7Uf2wz66lRQheWgn53Pcd5wl+APs4rmC+Wa2yy
         OcYeW64affyJEaeHy1JD/pjmV0ZESlUaTmBzzpat5TKBkdxRV0NV2S9FRzHRMX077AxL
         O42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+gVLOM9oJ/Z3Z9VbAgGHKohagg2/0xc8CE20DVhCLbE=;
        b=lATs+nSXX7j/IpEvWPMrAqBaYsKjvTqV/GEY/TlkPkLRPIgGndHL2/U7UHKUznDHFb
         NlBIChDhTNa/yg9d91GQhubPDMf7ma64zS3RuwKNuiOiXNf8mm1xpbFZ2goMForYGKRp
         Rz2ZURqpIbVXuT7wPLS5W70csfD1KPTDMCX0QXL1gCpr2Id1VpKbziTzCmET1+038IT2
         VDMNfPaBCDSbUL3mlsb7uGcgEzQjYL0mkv6wO9KET/1cENL4frDzcVgU7zlI35GAkZXt
         JoMoH5sqloPs8ke2e39MpTOYNg7aGOYaK9yH1jQyWFS2IvD+BEKZKNFd75aM9Ur2xyie
         bgZQ==
X-Gm-Message-State: ACrzQf05vSZfBiCxa5eYocxMT13v99zSupdKSdiZmx+PtiU2802Amxse
        ssSDHyaGH32cFKXlh7U+dERBS+cCXJDrdC7ThVKPg4ZX8YhIpA==
X-Google-Smtp-Source: AMsMyM5b1qdKvGwcEMGT7MTks/vKVuIv6ar145mFaD7twLts3fWJAwLK48pgwsCbZxhHXBXtxL804YkvIoD/zU3vPw4=
X-Received: by 2002:a05:6638:f11:b0:35a:1398:968d with SMTP id
 h17-20020a0566380f1100b0035a1398968dmr8855947jas.23.1664725629220; Sun, 02
 Oct 2022 08:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <CANAwSgSf=JZ_JiK1Gh5EYR30KQ5Yh-w3GsxzcFVweKHPi7KuLg@mail.gmail.com>
 <20220930152531.5910-1-amadeus@jmu.edu.cn>
In-Reply-To: <20220930152531.5910-1-amadeus@jmu.edu.cn>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 2 Oct 2022 21:16:52 +0530
Message-ID: <CANAwSgQp-kJxC2iP-abQuzGwDyz-NE8pLBT-3eE9F48t6JgaFg@mail.gmail.com>
Subject: Re: [PATCH 0/1] Re: [PATCH-next v1] arm64: dts: rockchip: Enable NVM
 Express PCIe controller on rock3a
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     heiko@sntech.de, robh+dt@kernel.org, michael.riesch@wolfvision.net,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chukun,

On Fri, 30 Sept 2022 at 20:55, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Hi Anand,
>
> > No, It's not working on my board.
> > If you check the driver code it requires *data-line* and *num-lanes
> > from the dts.
>
> I have successfully tested NVME hard drives on my board. See
> below for the patch, looking forward to your testing.
>
> root@rock3a:~# lspci
> 0000:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd \
>              RK3568 Remote Signal Processor (rev 01)
> 0000:01:00.0 Network controller: MEDIATEK Corp. MT7921 \
>              802.11ax PCI Express Wireless Network Adapter
> 0002:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd \
>              RK3568 Remote Signal Processor (rev 01)
> 0002:01:00.0 Non-Volatile memory controller: Sandisk Corp \
>              PC SN520 NVMe SSD (rev 01)
>
> Patch:
>

Thanks this patch works for me.

I would prefer the regulators would get enabled/disabled by the core drivers
like it's done in rk3399 PCIe drivers.

$ lspci
0000:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3568 Remote
Signal Processor (rev 01)
0000:01:00.0 Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
0002:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3568 Remote
Signal Processor (rev 01)
0002:01:00.0 Non-Volatile memory controller: Micron/Crucial Technology
P2 NVMe PCIe SSD (rev 01)

> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -67,6 +67,37 @@ vcc12v_dcin: vcc12v-dcin-regulator {
>                 regulator-boot-on;
>         };
>
> +       pcie30_avdd0v9: pcie30-avdd0v9-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "pcie30_avdd0v9";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <900000>;
> +               regulator-max-microvolt = <900000>;
> +               vin-supply = <&vcc3v3_sys>;
> +       };
> +
> +       pcie30_avdd1v8: pcie30-avdd1v8-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "pcie30_avdd1v8";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               vin-supply = <&vcc3v3_sys>;
> +       };
> +
> +       /* pi6c pcie clock generator */
> +       vcc3v3_pi6c_03: vcc3v3-pi6c-03-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc3v3_pi6c_03";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               vin-supply = <&vcc5v0_sys>;
> +       };
> +
>         vcc3v3_pcie: vcc3v3-pcie-regulator {
>                 compatible = "regulator-fixed";
>                 enable-active-high;
> @@ -546,6 +577,19 @@ &pcie2x1 {
>         status = "okay";
>  };
>
> +&pcie30phy {
Please add the following field as per the device tree binding
 # Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
            data-lanes = <0 1>;
> +       phy-supply = <&vcc3v3_pi6c_03>;
> +       status = "okay";
> +};
> +
> +&pcie3x2 {
Please add the following field as per the device tree binding
# Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
            num-lanes = <2>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pcie30x2m1_pins>;
> +       reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
> +       vpcie3v3-supply = <&vcc3v3_pcie>;
> +       status = "okay";
> +};
> +
>  &pinctrl {
>         cam {
>                 vcc_cam_en: vcc_cam_en {
> --
> 2.25.1
>
> Thanks,
> Chukun

Thanks
-Anand
