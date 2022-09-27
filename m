Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0895C5EC134
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiI0L0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiI0LZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:25:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF4374BB8;
        Tue, 27 Sep 2022 04:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664277829; x=1695813829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n2HPdcc3mpaZRYQIKMMPJJTcYN9hCCX4WnYqtare8TQ=;
  b=x+vnEDu+xvyJUb7YGpLMFOEz5NeXmCQegBPObn0M6/TGczT7MuF08sdM
   yBWnNRgP08Fm0z4z4UvVzFjG3sAv9GSUwYIvLAHCBOP9d72QX0KhpRbNk
   +41EaD3XdL5yL5xqpcXOECGsoGMPwemPh8Aa27VNcHgPeo3L4c91FlWxB
   mnrT/0AYZDc1iYXKG8/QgpEPfrjI8a4enQqczaaG9/xEoq2vkaGSy0h0u
   JvTY2OSwVEDkXT0asuCO0m4p8O7K8zVt3aodMdDzRpfCVF54ZSYtWfNtl
   W3k7LLf9Xl0Bfslt8TRKq/lL2vieXUTf5EWkeKzz55OIRU0AUbuW7t8T1
   w==;
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="192656218"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Sep 2022 04:23:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 27 Sep 2022 04:23:11 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 27 Sep 2022 04:23:08 -0700
Date:   Tue, 27 Sep 2022 12:22:38 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/11] New PolarFire SoC devkit devicetrees & 22.09
 reference design updates
Message-ID: <YzLc/v68wW93CaLq@wendy>
References: <20220927111922.3602838-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220927111922.3602838-1-conor.dooley@microchip.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 12:19:12PM +0100, Conor Dooley wrote:
> Resending with an extra patch making some more memory map changes that
> are to be introduced in the v2022.10 reference design. Since the
> v2022.10 and v2022.09 reference designs both indepedently break
> backwards compat, v2022.09 is not compatible with <= v2022.05 and
> v2022.10 is not compatible with v2022.09, I am doing the jump directly
> to v2022.10 rather than putting an intermediate step at v2022.09.
> 
> I did not drop Krzysztof's Ack on patch 1 as s/09/10 has no impact on
> the correctness of the binding.

I had already applied v5, but I am going to apply this version instead.
I will send a PR once the v2022.10 reference design has been released on
the PolarFire SoC GitHub.

Thanks,
Conor.

> 
> --8<---
> Hey all,
> 
> Some 6.1 targeted changes here.
> Firstly, two new dev kits (one first-party & one from Aries Embedded).
> They've been sitting in our vendor tree, so are being sent where they
> belong.
> 
> Secondly, another release of our reference design for the Icicle kit
> is due in September. Usually these do not really change much for the
> devicetree, but this time around a pair of changes impact the memory
> map.
> 
> The first of these is adding dma-ranges to the pcie controller. The
> controller had some issues to begin with & with the current reference
> design (v2022.05) would not work with mainline Linux nor has it since
> reference design v2021.08. A combination of the property, a change
> to the FPGA design & a small fix to the driver will get it working
> with mainline again. The other non-backwards compatible change to the
> reference design is moves of the peripherals instantiated in the
> fabric. Currently they are fairly spread out & a common complaint has
> been that this leaves little room in the fic3 section of the memory map
> for custom peripherals without removing the existing ones.
> 
> This series depends on [0] so as not to add dtbs_check warnings. The
> fabric clock support is added by [1].
> 
> Thanks,
> Conor.
> 
> Changes since v5:
> - swap v2022.09 for v2022.10 in the binding
> - add a patch with the v2022.10 memory map changes
> 
> Changes since v4:
> - fix the incompatible interrupts on m100pfsevp
> 
> Changes since v3:
> - add an extra patch reducing the fic3 clock rate
> 
> Changes since v2:
> - drop the sd & emmc versions of the aries devicetree
> - remove a extra newline
> 
> Changes since v1:
> - made the polarberry part of an enum in patch 1
> 
> 0 - https://lore.kernel.org/linux-gpio/20220825143522.3102546-1-conor.dooley@microchip.com/
> 1 - https://lore.kernel.org/linux-clk/20220824093342.187844-1-conor.dooley@microchip.com/
> 
> Conor Dooley (9):
>   dt-bindings: riscv: microchip: document icicle reference design
>   dt-bindings: riscv: microchip: document the aries m100pfsevp
>   riscv: dts: microchip: add pci dma ranges for the icicle kit
>   riscv: dts: microchip: move the mpfs' pci node to -fabric.dtsi
>   riscv: dts: microchip: icicle: update pci address properties
>   riscv: dts: microchip: icicle: re-jig fabric peripheral addresses
>   riscv: dts: microchip: reduce the fic3 clock rate
>   riscv: dts: microchip: add a devicetree for aries' m100pfsevp
>   riscv: dts: microchip: update memory configuration for v2022.10
> 
> Shravan Chippa (1):
>   dt-bindings: riscv: microchip: document the sev kit
> 
> Vattipalli Praveen (1):
>   riscv: dts: microchip: add sevkit device tree
> 
>  .../devicetree/bindings/riscv/microchip.yaml  |  20 +-
>  arch/riscv/boot/dts/microchip/Makefile        |   2 +
>  .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |  43 ++++-
>  .../boot/dts/microchip/mpfs-icicle-kit.dts    |  18 +-
>  .../dts/microchip/mpfs-m100pfs-fabric.dtsi    |  45 +++++
>  .../boot/dts/microchip/mpfs-m100pfsevp.dts    | 179 ++++++++++++++++++
>  .../dts/microchip/mpfs-polarberry-fabric.dtsi |  29 +++
>  .../dts/microchip/mpfs-sev-kit-fabric.dtsi    |  45 +++++
>  .../riscv/boot/dts/microchip/mpfs-sev-kit.dts | 145 ++++++++++++++
>  arch/riscv/boot/dts/microchip/mpfs.dtsi       |  30 ---
>  10 files changed, 511 insertions(+), 45 deletions(-)
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-m100pfsevp.dts
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts
> 
> -- 
> 2.37.3
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
