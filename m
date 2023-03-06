Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DD96AB6C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCFHIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCFHIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:08:09 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2109683C5;
        Sun,  5 Mar 2023 23:08:08 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id s13so5721334uac.8;
        Sun, 05 Mar 2023 23:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678086487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nPMxN+7aE/eDgv+4Gb5i0j4P3VUwS4IPF/CTWOVkNGM=;
        b=fRqNtYdlEv5fZLps4+majz9AHPvYvaic55g6HWsHiSVAZEXMVAJDabsuU/LqlyVeP/
         hsEtEHVTr4KYsp2ukX7V8C9wftrW2ezKkjejJ5zYnIx6EUXhmzSak6cc9zbDLVuWGw+w
         aYMUl45VSDS2yK43KQQjQcFOfHZWmS/YRhegzgj57/aok9eNxJ5HPmsqLQo9HC2Lprfv
         hBmZ7qGyCA/ozA609V2Wfu/bpUH7KIB5VIJiSZLZFCCmwNaAaf+ZxUEWkiaMdfxDeVwo
         Gruje/oXyYq09WgSjdXJ7q4KzSNywnN4UvI+/Mei7XCB6X6aUzDRWwVYOoVzt+VC6pl6
         FXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678086487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPMxN+7aE/eDgv+4Gb5i0j4P3VUwS4IPF/CTWOVkNGM=;
        b=UAIs0hGXDFALvUFTcRPwtQ53kSEiKsb4tQZ7ttpgJrrx62YhF8n1vuy9UcNvhyCxWo
         cQOwRBDYrKuJOdLbG7JmOrJRRg+7GzjAFN+PmNx+H+354x4D5rRmkODR9xt9T2nhW9Q1
         uN+K8vD9yo7FLAqfptsYgXBLgcU1zq/HS42rs4+MUNkCnO6TmrbhegZ2di8/WXvJq4mI
         lvoPggAQwzL+qFFMY8GGIl9oF00fZcXky0GwoBl+bbdbPVeTWlnNvy7zOKNJye+ZpEoP
         zkgue7yatrqRRc/uHVym68bPagiQ20BJERVj/QhPR1WoF0ncZQepNFWaCKFoHTbKl8Oc
         AOTg==
X-Gm-Message-State: AO0yUKUFquDoIQAQcGoZlt0Fz55v/KLHZ3cROUqEUviTOwUw/P78wOZk
        zKB+N/jmE6B6T+abrYzZkkY8wf75PPBJg373kds=
X-Google-Smtp-Source: AK7set9TZcmB2GVYH/FuARKwCQ91BhrjHIj87pIyDTLjCNWkpaFUIFsb0UDJvdVN9GedqoFrpAIpEhchJ1R+9EV49oc=
X-Received: by 2002:a1f:38d6:0:b0:401:a4bf:210d with SMTP id
 f205-20020a1f38d6000000b00401a4bf210dmr6044664vka.1.1678086487119; Sun, 05
 Mar 2023 23:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20230306060446.414986-1-chunyan.zhang@unisoc.com> <fecb3d5c-86b7-f052-6cba-f92b45714665@linaro.org>
In-Reply-To: <fecb3d5c-86b7-f052-6cba-f92b45714665@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 6 Mar 2023 15:07:31 +0800
Message-ID: <CAAfSe-tE1kTZCUeC6bPQLrxDR1WEASatc8VXr1G5x_RhzGm6Yw@mail.gmail.com>
Subject: Re: [PATCH V3] arm64: dts: sprd: Add support for Unisoc's UMS512
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, 6 Mar 2023 at 14:43, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/03/2023 07:04, Chunyan Zhang wrote:
> > Add basic support for Unisoc's UMS512, with this patch,
> > the board ums512-1h10 can run into console.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> > Changes since V2:
> > * Removed redundant gpio.h from ums512-1h10.dts
> >
> > Changes since v1:
> > * Addressed comments:
> >   - Removed earlycon bootargs;
> >   - Moved up gic reg as second property;
> >   - Moved two sdio nodes under to the apb bus node;
> >   - Renamed node name of all fixed clocks;
> >   - Fixed warnings reported by dtbs_check.
>
> Please always mention  under --- why you do not send a binding for new
> board compatible.

Ok, I will address.

>
> > ---
> >  arch/arm64/boot/dts/sprd/Makefile        |   3 +-
> >  arch/arm64/boot/dts/sprd/ums512-1h10.dts |  61 ++
> >  arch/arm64/boot/dts/sprd/ums512.dtsi     | 911 +++++++++++++++++++++++
> >  3 files changed, 974 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/boot/dts/sprd/ums512-1h10.dts
> >  create mode 100644 arch/arm64/boot/dts/sprd/ums512.dtsi
> >
>
> (...)
>                 };
> > +
> > +             apb@70000000 {
> > +                     compatible = "simple-bus";
> > +                     #address-cells = <1>;
> > +                     #size-cells = <1>;
> > +                     ranges = <0 0x0 0x70000000 0x10000000>;
> > +
> > +                     uart0: serial@0 {
> > +                             compatible = "sprd,ums512-uart",
> > +                                          "sprd,sc9836-uart";
> > +                             reg = <0x0 0x100>;
> > +                             interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> > +                             clocks = <&ext_26m>;
> > +                             status = "disabled";
> > +                     };
> > +
> > +                     uart1: serial@100000 {
> > +                             compatible = "sprd,ums512-uart",
> > +                                          "sprd,sc9836-uart";
> > +                             reg = <0x100000 0x100>;
> > +                             interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> > +                             clocks = <&ext_26m>;
> > +                             status = "disabled";
> > +                     };
> > +
> > +                     sdio0: sdio@1100000 {
>
> Isn't the node name required to be "mmc"?

Yes, I agree.

>
> > +                             compatible = "sprd,sdhci-r11";
> > +                             reg = <0x1100000 0x1000>;
> > +                             interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> > +                             clock-names = "sdio", "enable";
> > +                             clocks = <&ap_clk CLK_SDIO0_2X>,
> > +                                      <&apapb_gate CLK_SDIO0_EB>;
> > +                             assigned-clocks = <&ap_clk CLK_SDIO0_2X>;
> > +                             assigned-clock-parents = <&pll1 CLK_RPLL>;
> > +                             status = "disabled";
> > +                     };
> > +
> > +                     sdio3: sdio@1400000 {
>
> Same problem.

Thanks for the review,
Chunyan
