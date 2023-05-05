Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355216F83FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjEEN1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjEEN1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:27:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA03203C9;
        Fri,  5 May 2023 06:27:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so3389714a12.1;
        Fri, 05 May 2023 06:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683293239; x=1685885239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJVTeItn3/q+rs4Fp3PPs4uhLe3EOiwtZ3p5vx2OZsc=;
        b=pW1eSFQtUOf4qd5Tqc4nNA0Lxc0orupxla+piV27edUUubj0zCl0YBkqsHBTbF1tz/
         shZdBzRzJe/A/ESNBMVAqzGsJu/AzM2GR7Vme5pGfkRQ33GFyXbqkfr05hDtF3lluygb
         ob7DwNWNnLG1srjhhp2cOse/kn/5/0QBVA/eFLxiMKNFwzbiJYDT+3WpcqvXcBxuTODL
         m01ijHjxSezLk8GFHifw9arl0IJDzEWpb1C+SCMXboqI3V4VctTKfd4WAkkgPn+4ipKV
         FHoUO3GseDFID+qZdDBuoxD78K+IAzlmeAvEnGsCIzaBUyzFyLSG884H+VKhqF8UIylS
         LQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683293239; x=1685885239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJVTeItn3/q+rs4Fp3PPs4uhLe3EOiwtZ3p5vx2OZsc=;
        b=eeJeBWSrXRD3XWcfKfEIY4xzVK00BnfIbtUx7b0+FxBkTjACrIWO4LL/cDyze9hC1U
         gHkpS0YSD2LRiGiKfWo2NFNllVZ8Jk17gneIz0dUMvUxeelt7RjGvBFwEVLwBgc5VMhX
         kV6/NQdpqZ6jb2lNVb3xI/OneVp/C9rKMF8XMHaFhd06pktpPGwz2qhBHuQlM3lfwnpe
         dH+YZgnO4gJbEXY6CDm1Y8aNCRZNBPZHgEcrWnZR2IOQpsJAafwtqMUQj3rBMT3SLh29
         HMt/nwBfUx8gum80LmfBCPwHOeo/XWnJZsXGRo/TZ9O/NozcagQZvjcly3M7vgE05MIM
         QafA==
X-Gm-Message-State: AC+VfDxOzunShWJdV+4OfdGG3YEUGTEv9v66RX+0qun7MveGSqmk/Txi
        jI+6jP5sAyEsYk0hN/qcKo2pXvFLqh3MXokwZ7U=
X-Google-Smtp-Source: ACHHUZ4j4o+3ks7gqO0Cc3az7qvWANuOL9pmgjp9OgEvccsoElcFtMR8UppD8ccMx0iGR4Z540YQjU8jVHujZAMcF4c=
X-Received: by 2002:a17:907:3e05:b0:94e:988d:acc5 with SMTP id
 hp5-20020a1709073e0500b0094e988dacc5mr1256436ejc.46.1683293238964; Fri, 05
 May 2023 06:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230505074701.1030980-1-bigunclemax@gmail.com> <20230505105805.548d1a1b@donnerap.cambridge.arm.com>
In-Reply-To: <20230505105805.548d1a1b@donnerap.cambridge.arm.com>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Fri, 5 May 2023 17:27:07 +0400
Message-ID: <CALHCpMi8=t1bMceTOfZjh7aKEQcEEpfeG4wi9pB=5o34Ca+N3w@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Add SPI0 controller node
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     robh+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

> From a quick glance at the manuals, it
> looks like there are not quite the same, though: the D1/R528/T113s
> mentions a SPI_SAMP_DL register @0x28, whereas the older IP has a SPI_CCR
> register @0x24 - which is not mentioned in the newer manuals. The driver
> relies on that clock control register, so it wouldn't really work
> reliably, if that register is not there.

Thank you for pointing this out. I missed this difference.
I actually have a board with T113 SoC, and it looks like writing to
SPI_CCR@0x24 does nothing.
And it doesn't affect access to connected SPI NOR flash (read\write
operations are fine).
But I completely agree with you that this difference should be handled
by the spi driver.
