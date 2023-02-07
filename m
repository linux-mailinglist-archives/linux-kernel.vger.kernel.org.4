Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344A768CC86
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBGCU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGCU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:20:26 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFE52E0DF;
        Mon,  6 Feb 2023 18:20:25 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id az37so7145431vkb.2;
        Mon, 06 Feb 2023 18:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wf3HC2mlTdYNjd8GEebr8jn/i1yT97naYl2GNc8cIpw=;
        b=fDbMhgcTUax1lMtfUv5HFNSNsKlkRHVb+vbt8C59aMZUeizW7edZItdvc6QL4BgzWP
         FE/PhFiF4Ia1aiYiVzcFoNputMS3oRD3uLcWM/cmWPcuScjX37tWvdb1lcpQRf/SO3nt
         tUhIr1btt37D7Pi9Z8zQU8fdlb2Z2shjEqhW9hMIK8YzC7Gy6EFBtDEIJA7GhAyXc1JI
         S2DPCt2S34hatLhyxxsm03xNK6WCRjbrckvElXGvoOiNabOaY+RYNTgHZ0AdhKmrjuDJ
         IYEUwzdMGsPTZ/KuoQMqb226viydounwE6iTXI5JDjAMUTM8m8rrXLh+a5ZBz6S3/RrZ
         1FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wf3HC2mlTdYNjd8GEebr8jn/i1yT97naYl2GNc8cIpw=;
        b=GeNW+xy5sD8b+ggimqXWNElZUVckjKNVu5u0+FEl6bmI9C9oLSXb5F01HQ2CWUElY6
         SmuxpL1jY5KZBDdrbPIOa0UmDl/8ZrsgAzugq4ZnBsomGVNh4MmAiL/wjPIbUgcjSfi/
         9wpOVyJp1rZjbF+uOEz2lL0A5IlQHkPpJvYnCkVII+rPKmmXM3FzIuFXPMLtEA3chBxj
         H1d42yDfOxst19HPu8IEqYDZoAGHvbHszB38/U/J8FUaD86uHWlQMEOQJKPHwtLHDX7g
         Eg0vAfWbsfwFmnmZTOXZ3QI+gY51GHNSa54b/xN/lTiYCO7WGDZgtPaUCuUIyA4uWhXb
         hUgw==
X-Gm-Message-State: AO0yUKW0paRcCjYroNYtCRDjo26tYLsDJNEmHe3j/wL47rB8n7m2BwnQ
        vEOQYb2TrieNPJVggsWVolfB2v2qHkGaznQsc3g=
X-Google-Smtp-Source: AK7set/PDj9CS876HmB5BRlrj9RiObdimv/HVqL18k7r0C6xw11U1nGIcvIBhlQ07DbVRP2L1dNn6xRhu1bG8SZne04=
X-Received: by 2002:a1f:9c08:0:b0:3ea:78fc:6dd8 with SMTP id
 f8-20020a1f9c08000000b003ea78fc6dd8mr147481vke.21.1675736424702; Mon, 06 Feb
 2023 18:20:24 -0800 (PST)
MIME-Version: 1.0
References: <20230118084025.2898404-1-chunyan.zhang@unisoc.com> <41fd5c2a-9fc5-8af8-b66e-45bb83b24179@linaro.org>
In-Reply-To: <41fd5c2a-9fc5-8af8-b66e-45bb83b24179@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 7 Feb 2023 10:19:48 +0800
Message-ID: <CAAfSe-v3VW_sE4FwjURoOapMXrGavOK0hzeU-84-U_6xfhYbQQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: Add support for Unisoc's UMS512
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
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

On Thu, 19 Jan 2023 at 19:40, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/01/2023 09:40, Chunyan Zhang wrote:
> > Add basic support for Unisoc's UMS512, with this patch,
> > the board ums512-1h10 can run into console.
> >

[snip]

> > +             ap-apb {
>
> Non-unit-address nodes cannot be mixed with unit address ones. Something
> is wrong here.

To make sure I understand correctly, did you mean non-unit-address
nodes shouldn't be the parent of unit-address nodes?

Does that mean the bus node should have a unique base address like:
        ap-apb@70000000 {
        ...

Thanks,
Chunyan

>
> > +                     compatible = "simple-bus";
> > +                     #address-cells = <2>;
> > +                     #size-cells = <2>;
> > +                     ranges;
> > +
> > +                     sdio0: sdio@71100000 {
> > +                             compatible = "sprd,sdhci-r11";
> > +                             reg = <0 0x71100000 0 0x1000>;
> > +                             interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> > +                             clock-names = "sdio", "enable";
> > +                             clocks = <&ap_clk CLK_SDIO0_2X>,
> > +                                      <&apapb_gate CLK_SDIO0_EB>;
> > +                             assigned-clocks = <&ap_clk CLK_SDIO0_2X>;
> > +                             assigned-clock-parents = <&pll1 CLK_RPLL>;
> > +                             status = "disabled";
> > +                     };
