Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074C1633945
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiKVKCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiKVKCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:02:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A012DA8E;
        Tue, 22 Nov 2022 02:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669111315; x=1700647315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nI5iY1nxbWlYz33Yi+nw014DiITr3L9p7axhfuv7szo=;
  b=q4hHsfcWcmDNgaEdR0kGoTN0NV3LfJmssCr9536wRP83qfcI8mQxtQL9
   Nj/ds2zh/SRZ2nrQ0XGKOe3vVljYeCqj8Mtta7NKCFKltg1j+2wVcg9ao
   PAXuaXwAty0+r8KMuwoLyYTY26i7iEPlRljj/+0aFkVqNFx/vwFvvIoEj
   WpIckktAUPwAgMU+ZwGwEYrbShEk6umxA4lgwuBZhY4AxspaA1ieUbSQZ
   yH9IrL7rCsnI+N2GhpKS8dqqjNPEm/KqHgkPqeEIb+y4+PjH6ODcEUDbV
   B745OLsDL1C8IbDSoxPyZE0sFITaCAgY4ZlXlOM8ZTYanDWbDBhznsagS
   g==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="184644758"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2022 03:01:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 22 Nov 2022 03:01:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 22 Nov 2022 03:01:48 -0700
Date:   Tue, 22 Nov 2022 10:01:30 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] dt-bindings: sifive,ccache0: Support StarFive
 JH7110 SoC
Message-ID: <Y3yd+tfFl4yvXOx6@wendy>
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-5-hal.feng@starfivetech.com>
 <Y3duiJguYE6VrVLP@spud>
 <Y3dvCPP1g0LzzHFO@spud>
 <a5193e23-efe1-fa65-15de-d53b80b87d63@starfivetech.com>
 <Y3yRTuo69JUsfLqk@wendy>
 <0f9e423e-37c0-a838-bf25-f9b6784a31d0@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0f9e423e-37c0-a838-bf25-f9b6784a31d0@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 05:55:57PM +0800, Hal Feng wrote:
> On Tue, 22 Nov 2022 09:07:26 +0000, Conor Dooley wrote:
> > On Tue, Nov 22, 2022 at 04:40:23PM +0800, Hal Feng wrote:
> > > On Fri, 18 Nov 2022 19:39:52 +0800, Conor Dooley wrote:
> > > > On Fri, Nov 18, 2022 at 11:37:50AM +0000, Conor Dooley wrote:
> > > > > On Fri, Nov 18, 2022 at 09:17:10AM +0800, Hal Feng wrote:
> > > > > > From: Emil Renner Berthing <kernel@esmil.dk>
> > > > > > 
> > > > > > This cache controller is also used on the StarFive JH7110 SoC.
> > > > > 
> > > > > "... and configured identically to that of the FU740"?
> > > > > Anyways,
> > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > 
> > > > Actually, after looking at the next patch - why can you not fall back to
> > > > the fu740 one since you appear to have the same configuration as it?
> > > 
> > > Right, I will drop this patch and use "sifive,fu740-c000-ccache" as
> > > compatible in dts.
> > 
> > Uh, that's not quite what I was suggesting. Rather than using that one
> > in isolation, you can do the following in your dt:
> > "starfive,jh7110-ccache", "sifive,fu740-c000-ccache"
> > 
> > And then in the driver we need to make no changes - unless down the line
> > we find some sort of issue that requires special handling etc. There's
> > no harm in having a "starfive,jh7110-ccache" IMO.
> 
> Just like what microchip did as blow?
> 
> Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml:
> properties:
>   compatible:
>     oneOf:
>       - items:
>           - enum:
>               - sifive,ccache0
>               - sifive,fu540-c000-ccache
>               - sifive,fu740-c000-ccache
>               - starfive,jh7110-ccache
>           - const: cache
>       - items:
>           - const: microchip,mpfs-ccache
>           - const: sifive,fu540-c000-ccache
>           - const: cache

No, I don't think this is correct either. You'd do something like:

>       - items:
>           - const: starfive,jh7110-ccache
>           - const: sifive,fu740-c000-ccache
>           - const: cache

And then the driver needs no changes.
Thanks,
Conor.

