Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2106298D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKOM2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiKOM16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:27:58 -0500
X-Greylist: delayed 226 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 04:27:56 PST
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78A62B2;
        Tue, 15 Nov 2022 04:27:56 -0800 (PST)
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-07.nifty.com with ESMTP id 2AFCC95C005878;
        Tue, 15 Nov 2022 21:12:09 +0900
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2AFCBsd6032518;
        Tue, 15 Nov 2022 21:11:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2AFCBsd6032518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668514314;
        bh=SILR+3RX69mfNk2t722qTqGIc2KmPfUyWI4eu5WGZ+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Knfk25rUglHqvKrLlgLNNkYYEnsQ1qOODx9fHFc9GX7mTAEX3gYXmaqDWyG5grH3D
         pf1EuCkNmnLJjIb+vRhH26zPiijqflJejULiTPbk9+RRPTWIsxlVxUQtycFsIlpB4e
         DrezOv/cECw2Y89OFj+zv159/MeFV/KJVrxauUxi0Qnb0JRv0gkCSmVnte/ckP9wK/
         wpgc67wdLTMeZ550A1muZqgaKI2gbmoAN+H7LAZvEBj6gORNMQpbRsn2qwP4cM/T1I
         KBSiTp31mYVukwSNkrA1uJfsCvcSILb7VeKwlioAlRueG1j/5DPJzH/u28hy3uUD+J
         VO+ez1rduQ4Eg==
X-Nifty-SrcIP: [209.85.167.173]
Received: by mail-oi1-f173.google.com with SMTP id s206so14652828oie.3;
        Tue, 15 Nov 2022 04:11:54 -0800 (PST)
X-Gm-Message-State: ANoB5pn+2dy1ml0a3agrNegvQ0/+x6ZQUyyKPRvwOESN2p4+WmJ+HQBj
        4iBnSQuCvWOMOULVf+AK/oN0/qXe5pij4xQOMzI=
X-Google-Smtp-Source: AA0mqf6hSSCkhlyoX/XbOrOi9iVXeMLvUxTqq2OONNj3JX3htcEvVpprVrUJn8DLxADbyRiWma56cuFWop0k9aui/gg=
X-Received: by 2002:aca:ded4:0:b0:354:28ae:23b3 with SMTP id
 v203-20020acaded4000000b0035428ae23b3mr675884oig.287.1668514313381; Tue, 15
 Nov 2022 04:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20221114205939.27994-1-afd@ti.com> <Y3N7bLuSTKJYPcIC@smile.fi.intel.com>
In-Reply-To: <Y3N7bLuSTKJYPcIC@smile.fi.intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 15 Nov 2022 21:11:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNARqFpQCEDmjmXciT2URcRNA9j-cqmXjuh_ifLEtQx=auw@mail.gmail.com>
Message-ID: <CAK7LNARqFpQCEDmjmXciT2URcRNA9j-cqmXjuh_ifLEtQx=auw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Cleanup DT Overlay intermediate files as appropriate
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Davis <afd@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 8:43 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 14, 2022 at 02:59:39PM -0600, Andrew Davis wrote:
> > %.dtbo.o and %.dtbo.S files are used to build-in DT Overlay. They should
> > should not be removed by Make or the kernel will be needlessly rebuilt.
> >
> > These should be removed by "clean" and ignored by git like other
> > intermediate files.
>
> Fixes: 941214a512d8 ("kbuild: Allow DTB overlays to built into .dtbo.S files")
>
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> > Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Andrew Davis <afd@ti.com>

Acked-by: Masahiro Yamada <masahiroy@kernel.org>


-- 
Best Regards
Masahiro Yamada
