Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C559638AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKYNKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKYNKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:10:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBA9DEEF;
        Fri, 25 Nov 2022 05:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669381800; x=1700917800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nHHNQkkTSvWPra268e5xRIEmlNkhUo8hFOPoiAYY6nA=;
  b=V0vjAnHw9kc2Ez6uAdTYKYENLiUw6bfdmElaP44/ZD15zuqkUqHpCunf
   NUkhlPq3Ds2rdHortTCqP/DJQCUNAPQ9/ESt6zFZj1Zr7080O6a+aeQTV
   +TtbFNAd/G59p4LOq6XVqGrfSsleDgMmfa/jfFIfUyftuF+rPIQeLUg7R
   KE8JgK2yMohxHyGMZiNO5vD77SwaS7fPMaNsmjLvl+ZtPNJhWjUXwx0wf
   ITkjC0qfbapgek0j2pL8fQgRn7albpo/t8Ws0Z5YyxV01MHA+UUqrXxxA
   qVT1Z4OVHCodAr9Zhiqjvm5l98MzwwpQUqNSpLTcR5XQz7f6mW5GdnrWm
   w==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="190541512"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 06:09:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 06:09:59 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 25 Nov 2022 06:09:57 -0700
Date:   Fri, 25 Nov 2022 13:09:39 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <apatel@ventanamicro.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: timer: Add bindings for the RISC-V
 timer device
Message-ID: <Y4C+kwLdMYkkrm/2@wendy>
References: <20221125112105.427045-1-apatel@ventanamicro.com>
 <20221125112105.427045-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221125112105.427045-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Anup,

For the future, could you please CC me on all patches in a series that I
have previously reviewed?

On Fri, Nov 25, 2022 at 04:51:04PM +0530, Anup Patel wrote:
> We add DT bindings for a separate RISC-V timer DT node which can
> be used to describe implementation specific behaviour (such as
> timer interrupt not triggered during non-retentive suspend).
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../bindings/timer/riscv,timer.yaml           | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/riscv,timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/riscv,timer.yaml b/Documentation/devicetree/bindings/timer/riscv,timer.yaml
> new file mode 100644
> index 000000000000..cf53dfff90bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/riscv,timer.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/riscv,timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V timer
> +
> +maintainers:
> +  - Anup Patel <anup@brainfault.org>
> +
> +description: |+
> +  RISC-V platforms always have a RISC-V timer device for the supervisor-mode
> +  based on the time CSR defined by the RISC-V privileged specification. The
> +  timer interrupts of this device are configured using the RISC-V SBI Time
> +  extension or the RISC-V Sstc extension.
> +
> +  The clock frequency of RISC-V timer device is specified via the
> +  "timebase-frequency" DT property of "/cpus" DT node which is described
> +  in Documentation/devicetree/bindings/riscv/cpus.yaml
> +
> +properties:
> +  compatible:
> +    enum:
> +      - riscv,timer
> +
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 4096   # Should be enough?
> +
> +  riscv,timer-cant-wake-cpu:
> +    type: boolean
> +    description:
> +      If present, the timer interrupt can't wake up the CPU from
> +      suspend/idle state.

I'm really not sure about this... I would be inclined to think that if
someone does not specify then we should assume that they took the
scroogiest view of the spec and so do not get events during suspend.

I suppose you could then argue that their DT is wrong & it's their fault
though. Plus the existing platforms behave this way & we avoid having to
retrofit stuff here.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - interrupts-extended
> +
> +examples:
> +  - |
> +    timer {
> +      compatible = "riscv,timer";
> +      interrupts-extended = <&cpu1intc 5>,
> +                            <&cpu2intc 5>,
> +                            <&cpu3intc 5>,
> +                            <&cpu4intc 5>;
> +    };
> +...
> -- 
> 2.34.1
> 
