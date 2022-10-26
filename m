Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF2C60DCF1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJZITo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiJZITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:19:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E56B1DF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:19:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t15so5538668edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sMtqbHlLZFpW7omrjtZXOBYfjn0MC+C+YnFrrsHdRjs=;
        b=liFfOeY4hx0N4zrjBJD02ke1SJWVcrMthhaYNWmGXRub08CZSFDvJYeLsQd6GzQgqN
         lKo1GDeIZRO+YrpUSOETHKq1DYlhwE94QNYBhsk0PAmcpFO7kIrCFx2XoeM5ldtsbsdq
         CXxOCH7yTKPiun+V8cBiY8DHsNSTsV4rpWTurmFF0ZXsJAMGxSMsIHViF5ZY3D0zSxK4
         4sP/5VwE5aKZ1r85tftPnMXqCuzY8+c7e2pKSoN18xmZKbKV6mqAPakOWvwaeotOf7tJ
         sDOx6nzr9dN/mDxbiViCuFaHHXHaxAvYIVPVvG2C/OKujJeE8PRRng8Wxp11WDolUH+A
         J4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMtqbHlLZFpW7omrjtZXOBYfjn0MC+C+YnFrrsHdRjs=;
        b=n+U8Keh9gB5femF6kyYGPXKpTdkUSucSTisEyfjJ7QOskXYw5q4JC1yglZsnIRW3/P
         ew5UgCCNcokqi/8M7qZPSLYoD8YyOwpTFF0zUHq0ILtW9Sp3HeU+Ii08WaClOQfBsHuz
         r0ZsOeIRJUBACEaK43TpGSV4Umzf8ZFRX4c7/CUaLz4bCLqEonlTaYZWvLc0MUx8AKNM
         tdKxMCRbNqcduYIU/m5zyVBDEFZQ5EJsZiXrai628yyYoajP6y1DIdenbZv8awELhKQX
         yWq6l5Ja5hreHyEe4nwSjMGqQYsXXVnhM9cP4wa/UkTSRAnWTbvNHOnGxCbOFRSQB+n3
         uU8w==
X-Gm-Message-State: ACrzQf2QbTBHPRXj9yNGpl/9uROcTFuCD+4I4NvBjHLX4VpwbaMWJykS
        3FFYMdlx7wAD1YA2tNptv3laO6Fx7uw3BdNn6u36CQ==
X-Google-Smtp-Source: AMsMyM7SH3F529rlWhEoTHUIMUwS3tzdmcSUpPN3lQbCjmXF4Hv1H8UlF/bAfXad6TZ8Tt1UPReSD16WbYO5i6r8Nwc=
X-Received: by 2002:aa7:d385:0:b0:461:8cd3:b38b with SMTP id
 x5-20020aa7d385000000b004618cd3b38bmr18885323edq.172.1666772373091; Wed, 26
 Oct 2022 01:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221021181016.14740-1-ansuelsmth@gmail.com> <CACRpkdbfvr1pkVb3XhBZLnmn7vy3XyzavwVjW_VmFKTdh3LABQ@mail.gmail.com>
 <63531543.050a0220.b6bf5.284d@mx.google.com> <CACRpkdbOQq9hUT=d1QBDMmgLaJ1wZ=hd44ciMnjFVgpLCnK8Wg@mail.gmail.com>
 <6357240c.170a0220.999b2.23d6@mx.google.com>
In-Reply-To: <6357240c.170a0220.999b2.23d6@mx.google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Oct 2022 10:19:21 +0200
Message-ID: <CACRpkdb4iqazgVerHCPU0VqZKYoB5kJeDSaL+ek67L=2Txem-A@mail.gmail.com>
Subject: Re: [PATCH] ARM: mach-qcom: fix support for ipq806x
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 1:47 AM Christian Marangi <ansuelsmth@gmail.com> wrote:

> bad news... yesterday I tested this binding and it's problematic. It
> does work and the router correctly boot...

That's actually partly good news :D

> problem is that SMEM is
> broken with such configuration... I assume with this binding, by the
> system view ram starts from 0x42000000 instead of 0x40000000 and this
> cause SMEM to fail probe with the error "SBL didn't init SMEM".

We need to fix this.

> This is the location of SMEM entry in ram
>
>                 smem: smem@41000000 {
>                         compatible = "qcom,smem";
>                         reg = <0x41000000 0x200000>;
>                         no-map;
>
>                         hwlocks = <&sfpb_mutex 3>;
>                 };
(...)
> Wonder if you have other ideas about this.

So the problem is that the resource is outside of the system RAM?

I don't understand why that triggers it since this is per definition not
system RAM, it is SMEM after all. And it is no different in esssence
from any memory mapped IO or other things that are outside of
the system RAM.

The SMEM node is special since it is created without children thanks
to the hack in drivers/of/platform.c.

Then the driver in drivers/soc/qcom/smem.c
contains things like this:

        rmem = of_reserved_mem_lookup(pdev->dev.of_node);
        if (rmem) {
                smem->regions[0].aux_base = rmem->base;
                smem->regions[0].size = rmem->size;
        } else {
                /*
                 * Fall back to the memory-region reference, if we're not a
                 * reserved-memory node.
                 */
                ret = qcom_smem_resolve_mem(smem, "memory-region",
&smem->regions[0]);
                if (ret)
                        return ret;
        }

However it is treated as memory-mapped IO later:

        for (i = 1; i < num_regions; i++) {
                smem->regions[i].virt_base = devm_ioremap_wc(&pdev->dev,

smem->regions[i].aux_base,

smem->regions[i].size);
                if (!smem->regions[i].virt_base) {
                        dev_err(&pdev->dev, "failed to remap %pa\n",
&smem->regions[i].aux_base);
                        return -ENOMEM;
                }
        }

As a first hack I would check:

1. Is it the of_reserved_mem_lookup() or qcom_smem_resolve_smem() stuff
   in drivers/soc/qcom/smem.c that is failing?

If yes then:

2. Add a fallback path just using of_iomap(node) for aux_base and size
  with some comment like /* smem is outside of the main memory map */
  and see if that works.

Yours,
Linus Walleij
