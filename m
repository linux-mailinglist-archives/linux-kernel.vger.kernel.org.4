Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DAA6A4540
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjB0Oxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjB0Oxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:53:47 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4A55FC7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:53:45 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id bh1so6941415plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l5VT3ghgOZyVF+1GKbNcLlSESdSRebrFv96yTN2Vgpo=;
        b=Gq9LOqIDm1nkIlqoP1xyZ+r1d2RvDdRtUzQhuQgfroW5tY/m3hOqXxShZVsKKZLPsU
         /LABK70GXsyzF7YIUCNsgsAgnhpjHLdlwGTQFRoBFUQa4+cPKoqfMQmOnbkakyyc7NVP
         SdchPzpYyukrQeT5euY8wqJZf4aTHsh4ud4UscR0jPqQtT/oGlQVsLBbSityTaeZiZRP
         gaOjUL8Ih6fKPTfCQ7t6Zoka8/OMmXy5e1qQoxM8v2EpddQoiVrzWKyqZUo582dapBE4
         EeUifUFmTWFu7+S+FBFt1EOnCo6INjP35xPjDxDQCR84mKzvdtqthNzXZW/C1hn1zZ03
         sB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5VT3ghgOZyVF+1GKbNcLlSESdSRebrFv96yTN2Vgpo=;
        b=1ie4b/pxXIrPAAjq4JmSKQ12X0kUfnRDmrFMKj+0g9ThmKsJGDqV6sb25klQurBIqH
         lV6KtRWqSXJzhvw/DEYfewfMfEvnDuhB/To9NOKtLbstcyHc49gtvfBnML/MvTSWujbL
         Gzbr0T+j0Q3b7SH9hqtzaVO3bOVHrLIzWtxmoY8DwcgqFe7rwSFPiPJizWVXQl9SWG7V
         mXZyLF4MKRu9JofxeTqEE+VM94M+IcnKp03RJnNKa4kEbShXEo2HxnpdrV65kTp7DwQ9
         Z+QZvlaG2igs5m1CwFdL/JXoLc3/z9CiuPyeufE3FuHhrenpHXUv+enVAM9RAfw6cv/u
         xwDA==
X-Gm-Message-State: AO0yUKVjrrwkTqUYGl4ttZO6YdnZwJTdmTJnBb5TKtTNdAjWzHJCFOZG
        kMKycvdVgU1KC0CAkWNDF/93dhOOXGV3wT+eIjJIPg==
X-Google-Smtp-Source: AK7set+HTQu+x6c+i9QU4xI8526XGkvjGx9J6AmsgWbznB6SWWwRXE1fCT+1oSICb0P/XsJ0ryjzSBBrZzu1uNj4Yhc=
X-Received: by 2002:a17:903:40c2:b0:19a:b502:4280 with SMTP id
 t2-20020a17090340c200b0019ab5024280mr4788629pld.3.1677509624962; Mon, 27 Feb
 2023 06:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <CAPDyKFqJxrLh+pgQ-u_Lwxv4_TsH--rga049GBTqKAa_M14_yw@mail.gmail.com> <ca9bed19-9809-9443-7ca1-1d11984ded55@starfivetech.com>
In-Reply-To: <ca9bed19-9809-9443-7ca1-1d11984ded55@starfivetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Feb 2023 15:53:08 +0100
Message-ID: <CAPDyKFpwFq26Tqa-5k7SbQ7Zgk3-AQSrjo7ZSJt6uo6QJR3+5Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] StarFive's SDIO/eMMC driver support
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 at 08:47, William Qiu <william.qiu@starfivetech.com> wrote:
>
>
>
> On 2023/2/15 20:37, Ulf Hansson wrote:
> > On Wed, 15 Feb 2023 at 12:32, William Qiu <william.qiu@starfivetech.com> wrote:
> >>
> >> Hi,
> >>
> >> This patchset adds initial rudimentary support for the StarFive
> >> designware mobile storage host controller driver. And this driver will
> >> be used in StarFive's VisionFive 2 board. The main purpose of adding
> >> this driver is to accommodate the ultra-high speed mode of eMMC.
> >>
> >> The last patch should be applied after the patchset [1]:
> >> [1] https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/
> >>
> >> Changes v3->v4:
> >> - Added documentation to describe StarFive System Controller Registers.
> >> - Added aon_syscon and stg_syscon node.
> >> - Fixed some checkpatch errors/warnings.
> >>
> >> Changes v2->v3:
> >> - Wraped commit message according to Linux coding style.
> >> - Rephrased the description of the patches.
> >> - Changed the description of syscon regsiter.
> >> - Dropped redundant properties.
> >>
> >> Changes v1->v2:
> >> - Renamed the dt-binding 'starfive,jh7110-sdio.yaml' to 'starfive,jh7110-mmc.yaml'.
> >> - Changed the type of 'starfive,syscon' and modify its description.
> >> - Deleted unused head files like '#include <linux/gpio.h>'.
> >> - Added comment for the 'rise_point' and 'fall_point'.
> >> - Changed the API 'num_caps' to 'common_caps'.
> >> - Changed the node name 'sys_syscon' to 'syscon'.
> >> - Changed the node name 'sdio' to 'mmc'.
> >>
> >> The patch series is based on v6.1.
> >>
> >> William Qiu (4):
> >>   dt-bindings: mmc: Add StarFive MMC module
> >>   mmc: starfive: Add sdio/emmc driver support
> >>   riscv: dts: starfive: Add mmc node
> >>   dt-bindings: syscon: Add StarFive syscon doc
> >>
> >>  .../bindings/mmc/starfive,jh7110-mmc.yaml     |  77 ++++++++
> >>  .../bindings/soc/starfive/jh7110-syscon.yaml  |  51 +++++
> >>  MAINTAINERS                                   |  11 ++
> >>  .../jh7110-starfive-visionfive-2.dtsi         |  23 +++
> >>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  47 +++++
> >>  drivers/mmc/host/Kconfig                      |  10 +
> >>  drivers/mmc/host/Makefile                     |   1 +
> >>  drivers/mmc/host/dw_mmc-starfive.c            | 186 ++++++++++++++++++
> >>  8 files changed, 406 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> >>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >>  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
> >>
> >
> > I have dropped the v3 patches and applied patch1 and patch2 from the
> > v4 series instead, for my next branch, thanks!
> >
> > Kind regards
> > Uffe
>
> Hi Uffe,
>
> Sorry to bother you.But I found a bug that in drivers/mmc/host/dw_mmc-starfive.c:
>
>     47 static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
>     48                                              u32 opcode)
>     49 {
>     50         static const int grade  = MAX_DELAY_CHAIN;
>     51         struct dw_mci *host = slot->host;
>     52         struct starfive_priv *priv = host->priv;
>     53         int rise_point = -1, fall_point = -1;
>     54         int err, prev_err;
>     55         int i;
>     56         bool found = 0;
>     57         u32 regval;
>     58
>     59         /*
>     60          * Use grade as the max delay chain, and use the rise_point and
>     61          * fall_point to ensure the best sampling point of a data input
>     62          * signals.
>     63          */
>     64         for (i = 0; i < grade; i++) {
>     65                 regval = i << priv->syscon_shift;
>     66                 err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
>     67                                                 priv->syscon_mask, regval);
>     68                 if (err)
>     69                         return err;
>     70                 mci_writel(host, RINTSTS, ALL_INT_CLR);
>     71
>     72                 err = mmc_send_tuning(slot->mmc, opcode, NULL);
>     73                 if (!err)
>     74                         found = 1;
>     75
>     76                 if (i > 0) {
> --> 77                         if (err && !prev_err)
>
> prev_err was never initialized to zero.
>
> So I'm here to ask for your suggestion, should I send a new version
> to fix it or send you a patch with a fixes tag?

Please send a new incremental patch on top. I will queue it up as a
fix for v6.3-rc[n].

Kind regards
Uffe
