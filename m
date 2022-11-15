Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D10A629BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiKOOV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiKOOVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:21:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166AD27DF3;
        Tue, 15 Nov 2022 06:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668522076; x=1700058076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T9xa+wT894O/BNbmmhpsL2DaZVMB3Ufsjex3WlA9okU=;
  b=PB1c9Q61uvE/R55Ki6QzGk8oaxQifuUxScPWT2pDen4UoAkcnCzAbiyW
   /ggqzoGX1aId+fX0y60k8EhrLLKRHPCNpmJDKVBB1X5N3O1HGOGDwKV0Z
   iiidPkvvmxT2ryV8mNvdte1NRjJfdG7wUwC3C/KPcnLdIG07c5l+gsx/4
   TenXQjtBTFGNf1dCJWXU1X+mTOmfV5+jfwejlzuVrKL9LKAO7h+Ik/tLC
   Rp1jAT+B5tFCmgeFOZxNXKvxv185RQKDLrtuDXCQi11FQjKz87wwKrAfO
   uw4At0jH7CalJ4catIoWwAYUEICchOSvs0KeBHiukDzjUHTmVfUM8H2H3
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="123510930"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2022 07:21:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 15 Nov 2022 07:21:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 15 Nov 2022 07:21:13 -0700
Date:   Tue, 15 Nov 2022 14:20:56 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 0/3] RZ/Five: Enable ADC/CANFD/I2C/OPP/Thermal Zones/TSU
Message-ID: <Y3OgSAnst0qt5WSk@wendy>
References: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:51:32AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi All,
> 
> This patch series aims to enable support for below blocks
> on RZ/Five SoC/SMARC EVK:
> - ADC
> - CANFD
> - I2C
> - OPP
> - Thermal Zones
> - TSU
> 
> Note, patches apply on top of [0].
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/log/?h=renesas-riscv-dt-for-v6.2
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (3):
>   riscv: Kconfig: Enable cpufreq kconfig menu
>   riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable
>     ADC/OPP/Thermal Zones/TSU
>   riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C

I know ~nothing about your SoC so idk if the values are correct, but I
did give it a go earlier to see if it did anything warning wise. Seeing
that it didn't cause any I am curious - how come these didn't land in
the original dts? Just waiting for driver stuff to land to support it?

Anyway, no new warnings which is what I care about - I suppose that
makes it an acked-by?
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Can include that tag if you like. Either way, nice to see some of the
/delete-node/s etc being removed.

Thanks,
Conor.

> 
>  arch/riscv/Kconfig                            |  2 ++
>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |  2 ++
>  .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 11 --------
>  arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 27 -------------------
>  4 files changed, 4 insertions(+), 38 deletions(-)
> 
> -- 
> 2.25.1
> 
