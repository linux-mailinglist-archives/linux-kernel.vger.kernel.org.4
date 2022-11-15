Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B86C62969A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbiKOLBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbiKOLAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:00:51 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495641401B;
        Tue, 15 Nov 2022 03:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668510013; x=1700046013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X614lCvRsx/z2rfXeRkDFM2miVmY6jybPGRgrOYbBHg=;
  b=EGdTs/gHEvGBwZ4Grv7WCE4GSamBUOTXe1qLhM9Uw9FbRuui4kpr7nYO
   IFJOIjtzXvIUNxvgs7T5MRN6fF7tPrzbcJfHGdnIeImhidNtvdv+eX9Lc
   9+fD5aUB6xVFZpRUD3nO7QiYpKzjVxpvv4qeqAY1naPH/ElbwwTorGnyv
   w3BH7h8vbiIP8Ff35mUyzUutLXPUQRMZj6lu3aAGAHN2DzQgDy8DzuDc4
   Y/ywxadHe0IIrzR1DwQ1xQZ61P8xWv0PHmMOIJ9okSO60WM/N4VOc1bWg
   RGhd9QaVZVWlyFTn985E2xzMKwFR676I2wOceWGAwDPBgKARDNDSpVtgm
   g==;
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="189029819"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2022 04:00:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 15 Nov 2022 04:00:10 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 15 Nov 2022 04:00:08 -0700
Date:   Tue, 15 Nov 2022 10:59:51 +0000
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
Subject: Re: [PATCH 1/3] riscv: Kconfig: Enable cpufreq kconfig menu
Message-ID: <Y3NxJ0FpDQMhP05+@wendy>
References: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221115105135.1180490-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221115105135.1180490-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:51:33AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Enable cpufreq kconfig menu for RISC-V.

Yes, please. It was on my todo list to dig this one out and un-archive
it on patchwork:
https://lore.kernel.org/linux-riscv/20220718180713.451507-1-mail@conchuod.ie/

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fa78595a6089..ce905454a3bf 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -691,6 +691,8 @@ menu "CPU Power Management"
>  
>  source "drivers/cpuidle/Kconfig"
>  
> +source "drivers/cpufreq/Kconfig"
> +
>  endmenu # "CPU Power Management"
>  
>  source "arch/riscv/kvm/Kconfig"
> -- 
> 2.25.1
> 
