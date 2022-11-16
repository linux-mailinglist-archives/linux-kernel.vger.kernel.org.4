Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC962BF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiKPNaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiKPN35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:29:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847137662;
        Wed, 16 Nov 2022 05:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668605394; x=1700141394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pW7nWcHcRlPbZUbml/VKsh4NmRLOoeC1fsUj+ROfVX4=;
  b=uc1+qfxyST4945nnvTWVfoprV5eIQkN+zZ8D/f+7n+Kbwz5MmDlvgB3Q
   hjEpD+NVPq96rEOyXxmRoPhjBuuadoyOG3sU8Vd8czmvPEKGEdUNUmu0l
   tkbjHbprntPfKlPFRogphnECUgtu5uvPN7/bfNiI1olDpvQfEMV1jZltB
   lJY9fPCxe2m8lVB7tgTeqMt9ipt8KBA2/2SRCeeB649YgL9PIlCA9FnJt
   fvhPuBvLlki/RLqxgnzzomFWMiemp5WFWp+2SKwOJG92bFI4Y5j+dRhsv
   S0TYT1VkNKZ5FC1f3jjGv/1Ad+QJdheXXvIOqDdFXhT0zAljH62h/FG3z
   A==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="187259614"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2022 06:29:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 16 Nov 2022 06:29:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 16 Nov 2022 06:29:50 -0700
Date:   Wed, 16 Nov 2022 13:29:33 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <apatel@ventanamicro.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller
 bindings
Message-ID: <Y3TlvSG0tmZSl8/2@wendy>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-5-apatel@ventanamicro.com>
 <Y3EDuaW0zQSSfiQ/@spud>
 <CAK9=C2WDQCnVnxKR6SFspdwope2KffyASLJDF_Ygo_417ekJ5w@mail.gmail.com>
 <Y3QT5Vy3RnIXobHz@spud>
 <3037b4f9-268d-df03-380c-393a5d01f3ba@linaro.org>
 <CAK9=C2UpiM=UC27Bgm+QqSc=27g__QLL3y-wMVJGjO-N-XKThw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK9=C2UpiM=UC27Bgm+QqSc=27g__QLL3y-wMVJGjO-N-XKThw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 04:04:45PM +0530, Anup Patel wrote:
> On Wed, Nov 16, 2022 at 2:30 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 15/11/2022 23:34, Conor Dooley wrote:
> > > On Mon, Nov 14, 2022 at 05:59:00PM +0530, Anup Patel wrote:
> > >> On Sun, Nov 13, 2022 at 8:18 PM Conor Dooley <conor@kernel.org> wrote:
> > >
> > >>> Also, the file name says "riscv,imsic", the description says "IMSIC" but
> > >>> you've used "imsics" in the compatible. Is this a typo, or a plural?
> > >>
> > >> Yes, the file name should be consistent. I will update the file name.
> > >
> > > Is there a reason why the compatible is plural when all of the other
> > > mentions etc do not have an "s"? It really did look like a typo to me.
> > >
> > > It's the "incoming MSI controller", so I am unsure as to where the "s"
> > > actually even comes from. Why not just use "riscv,imsic"?
> >
> > Yep, should be rather consistent with all others, and IMSIC stands for
> > Integrated Circuit?
> 
> This is intentionally plural because even though we have one
> IMSIC per-CPU, Linux (and various OSes) expect one DT node
> as MSI controller targeting all CPUs.

Even still, calling it "riscv,imsic" would seem fair to me given the
multiple regs make the distinct regions clear.

I think I must have missed the bit at the end of the description though:

+  The device tree of a RISC-V platform will have one IMSIC device tree node
+  for each privilege level (machine or supervisor) which collectively describe
+  IMSIC interrupt files at that privilege level across CPUs (or HARTs).

Perhaps, for eejits like me, that paragraph should become paragraph 3
instead of hiding it below the register layout etc?

Anyways, existing name seems fine to me then w/ the filename update &
increased prominence of the many-controllers-in-one statement.

Maybe the devicetree gods think differently!

> The plural compatible string "riscv,imsics" was chosen based
> on consensus on RISC-V AIA Task Group meetings.

btw, I see the following in the example:

+      reg = <0x28000000 0x2000>, /* Group0 IMSICs */
+            <0x29000000 0x2000>; /* Group1 IMSICs */

And in the property:
+  reg:
+    minItems: 1
+    maxItems: 128
+    description:
+      Base address of each IMSIC group.

It would appear that the comment there conflicts with the description of
the reg property itself & it's that lack of consistency me confused (:
Should the comments be in the singular form?

Thanks,
Conor.

