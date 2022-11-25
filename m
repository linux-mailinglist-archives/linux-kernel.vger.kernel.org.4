Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E527638B20
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiKYNZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiKYNZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:25:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33CC41987;
        Fri, 25 Nov 2022 05:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669382716; x=1700918716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PlRGf5S5JExBVvpK167qlrreMpp4yW3JD4H5Kt6/TWw=;
  b=cmuqZwNh9XSTBvkb2fi9PBkgN29tdOxGiXOtd/D38avFAKx/sIvM3hU+
   jNWDME7kmI49tD/xX290Egim/71rVRKnZ1FM2qBVxo3kws5X22NC2NMX/
   t2f90OedayFZdJbIDHEIn+OY9/aSQhXkQqlIer2zXIhMClyNBTsNhXEzl
   VdU+kbcAxdDJjK5wrWtTAmMRvmCVfJ0Zil6IRRKJZCe9APGB2a0XlOZuc
   XnoBQSryEezYTgo6al7bckCyV3n65Z3lBnHLH8ePbHnmKSJQm3Uknz92S
   MV9DDob0jZ8xVrFQs159SiHLYWvkOLYiKCoAO46nWi+5WsZePUW0hpwxn
   w==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="188665806"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 06:25:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 06:25:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 25 Nov 2022 06:25:10 -0700
Date:   Fri, 25 Nov 2022 13:24:52 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 6/7] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
Message-ID: <Y4DCJJnpSG07/vIb@wendy>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <70d1bfde-f57f-1741-08d3-23e362793595@linaro.org>
 <CA+V-a8s2awLp=YvbhA1Ohe500Oh1easLUcG9V4_FWov7Pf2i6g@mail.gmail.com>
 <9b0f8312-2caa-b9f3-edf3-1b720532f559@linaro.org>
 <Y4C0Jn1hl81ZCxOt@wendy>
 <CA+V-a8u_R9X10AQ2dV9ieDGx7OJPhLRW3ENAoRP2fqVQTVodPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+V-a8u_R9X10AQ2dV9ieDGx7OJPhLRW3ENAoRP2fqVQTVodPw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 12:51:34PM +0000, Lad, Prabhakar wrote:
> Hi Conor,
> 
> On Fri, Nov 25, 2022 at 12:25 PM Conor Dooley
> <conor.dooley@microchip.com> wrote:
> >
> > On Fri, Nov 25, 2022 at 01:12:18PM +0100, Krzysztof Kozlowski wrote:
> > > On 25/11/2022 11:34, Lad, Prabhakar wrote:
> > > >>> +/* Device, Non-bufferable */
> > > >>> +#define AX45MP_PMACFG_MTYP_DEV_NON_BUF                       (0 << 2)
> > > >>> +/* Device, bufferable */
> > > >>> +#define AX45MP_PMACFG_MTYP_DEV_BUF                   (1 << 2)
> > > >>> +/* Memory, Non-cacheable, Non-bufferable */
> > > >>> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF     (2 << 2)
> > > >>> +/* Memory, Non-cacheable, Bufferable */
> > > >>> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF         (3 << 2)
> > > >>
> > > >> What are all these? They don't look like flags, because 3 = 1 | 2...
> > > >> they don't look like constants, because we do not use shifts in
> > > >> constants. Are these some register values? I also do not see the header
> > > >> being used in the code, so why having a bindings header if it is not
> > > >> used (DTS is not usage...)?
> > > >>
> > > > These are register bit values for the MTYP[5:2] field. The DTS example
> > > > in the binding doc (above) uses these macros. I haven't included the
> > > > DTS/I patches with this patchset yet do think I should?
> > >
> > > Then why storing it as bindings? Bindings headers describe the interface
> > > implemented by drivers and used by DTS, but this is not implemented by
> > > drivers.
> >
> > IIUC, some of these properties are non-discoverable attributes of the
> > cache controller. I see two things that could be done here that are
> > "better" than #defining bits:
> > - add an RZ/Five specific compatible and use match data to set the
> >   attributes which is only possible if the pma-regions are set on a
> >   per SoC basis
> > - make pma-regions into a child node, in which andestech,non-cacheable
> >   andestech,non-bufferable etc are properties of the child node
> >
> For now the only way to get DMA working without IOCP is to have
> AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF. But for future purposes I have
> introduced the other available flags.
> 
> So maybe for now we could just have this flag
> andestech,mem-non-cacheable-bufferable in the binding doc.
> 
>     cache-controller@2010000 {
>         reg = <0x13400000 0x100000>;
>         compatible = "andestech,ax45mp-cache", "cache";
>         interrupts = <508 IRQ_TYPE_LEVEL_HIGH>;
>         cache-line-size = <64>;
>         cache-level = <2>;
>         cache-sets = <1024>;
>         cache-size = <262144>;
>         cache-unified;
>         andestech,pma-region@0x58000000 {
>             reg = <0x58000000 0x08000000>;
>             andestech,mem-non-cacheable-bufferable;

Yah, that's about what I would expect - except splitting the properties
up. I think split up makes more sense from a property description point
of view, rather than needing some sort of
oneOf:
  - non-cacheable-bufferable
  - cacheable-non-bufferable
  - non-cacheable-non-bufferable


>         };
>         andestech,pma-region@0xdeadbeef {
>             reg = <0xdeadbeef 0x08000000>;
>             andestech,mem-non-cacheable-bufferable;
>         };
>         ....
>     };

