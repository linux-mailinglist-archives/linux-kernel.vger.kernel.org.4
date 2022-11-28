Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5737863AB99
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiK1Ow4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiK1Owy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:52:54 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54B81EEE1;
        Mon, 28 Nov 2022 06:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669647173; x=1701183173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vhgp5H+xO8Wpgp3xe6RQ0CkwZcxSWEbiNdhdyI++Qsc=;
  b=InTULldFRVcihdTsPtxB3hpvgP2fYEs6WOlvXFiGcl8q5IB24rRm3NG3
   dOGWijDIvonZ0bgf11I5Ymyt37IGiHfCSDdfp3xra/m6dzs8svx3iaSDh
   0JpiwzOJKU36SUkLxzQNlIkE2SVo7Er91o46k9KQeRpOBz6cnD2pZFfgb
   FCKg/dWZ+ElWOZZN9v6rj50R7Xw0V1fI58+yMtkslOm2Hg3GM9KHGCGy2
   Izyrp6KJyUqHnwHZHaRO3jWuzMpwE83Ks1hx5EBr5Qbn4sjU6dwvltiTg
   ShPGq5O1jbWIFSZd8wpv67Cr8tENwXB6/cqSOoHsNzLOAd9N8XcC1ngF3
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="188967612"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2022 07:52:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 28 Nov 2022 07:52:52 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 28 Nov 2022 07:52:50 -0700
Date:   Mon, 28 Nov 2022 14:52:32 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Icenowy Zheng <uwu@icenowy.me>
CC:     Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 6/9] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
Message-ID: <Y4TLMLKDG5SVNoJ7@wendy>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-7-jszhang@kernel.org>
 <Y4OcngDlw/4Szt7g@spud>
 <3ad94a3fc3558da2da80d238d26f29e2c42db5c1.camel@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ad94a3fc3558da2da80d238d26f29e2c42db5c1.camel@icenowy.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 05:52:51PM +0800, Icenowy Zheng wrote:
> 在 2022-11-27星期日的 17:21 +0000，Conor Dooley写道：
> > +CC Icenowy
> > 
> > On Sun, Nov 27, 2022 at 09:24:45PM +0800, Jisheng Zhang wrote:
> > > Add a baisc dtsi for the bouffalolab bl808 SoC.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 74

> > > +               plic: interrupt-controller@e0000000 {
> > > +                       compatible = "thead,c900-plic";
> > 
> > Hmm, @Icenowy - should this use your new open-c906-plic compatible
> > from
> > 20221121041757.418645-4-uwu@icenowy.me ?
> 
> I am against using openc906-plic.
> 
> Maybe I will add "thead,c906-plic", "thead,c900-plic" as an valid
> compatible, as there seems to be few options related to PLIC/CLINT for
> C906/C910 (at least as the open document of them say).

You two know this a lot better than I do, I'll leave it up to you two to
sort out :) Either way, we need something changed here to satisfy the
bindings.

> > As is, dtbs_check gives a:
> > bl808-sipeed-m1s-dock.dtb: interrupt-controller@e0000000: compatible:
> > 'oneOf' conditional failed, one must be fixed:
> >         ['thead,c900-plic'] is too short
> > 
> > > +                       reg = <0xe0000000 0x4000000>;
> > > +                       interrupts-extended = <&cpu0_intc
> > > 0xffffffff>,
> > > +                                             <&cpu0_intc 9>;
> > > +                       interrupt-controller;
> > > +                       #address-cells = <0>;
> > > +                       #interrupt-cells = <2>;
> > > +                       riscv,ndev = <64>;
> > > +               };
> > > +       };
> > > +};

