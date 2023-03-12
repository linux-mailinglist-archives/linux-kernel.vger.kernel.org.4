Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1ED6B68C8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCLR0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCLR0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:26:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FEA366A0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:26:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g17so12913786lfv.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678641974;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JtCwiValjsr2h1P8SRv71t+eIe5q6n+42gVTAnSj95M=;
        b=BZlXc5TTIHdFq+jyFOtq1eQfmMuC7wVue+MHQHKrD0lz7CK9+bBibOic1ztD3oGNfB
         v9c0UZGB0GE3G6rhQyAKqhieLFwAJT2TXVRQuG/YLKr5K6+hx86q+6Pu+otW8oGj7or4
         F+nSW1Ay3GSG9zBeNZjhurI0cS2E8VP8MoVtp68WT0sDtgv/G55Nvv7VeeMeQDUEw9YU
         o3ECKiyeMll1IeiMQsKCCCcZwS+54fY7Gz+JPQtvmnEwZYqLnaKBFC4UGspaGf3klk8P
         fQXfPNcwbPZ9+rb+H6oj96ODGmnRlefysyYcfL9j2lqfSQ6MwtFimsvRzzM5WwQMdJbd
         rwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678641974;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtCwiValjsr2h1P8SRv71t+eIe5q6n+42gVTAnSj95M=;
        b=YiwN+i8+fTSpb6PnCm3DNkwmT3DsmHKLcL1C8J5A48Nf9hNVtpbMp+hsEnxnEqVw62
         Yd5fQTFftENJqcLZPgDRWSb6A1t7sr8e+bPdgFT0ntfsAerXwz44TBbMzEWRnL0w5e7G
         yFQEX/7tmk0aaf/iGDhQNauSSHYyi6YQ8qPTkdL0VIgrPbeXRHnnrPIWGK0/5nAfC8rr
         is5rn/cFNvsc91f3HlZ6I7Yws5J6aUJ8ORp86CVzNh2XikFiSN+I1rpV6A/AztYpEkpm
         dMCVMTrtco2F/FSvw3MG/HM3rbumCXLRQ9urXNNMROojY8eo1YXxGJXHc6/7Kdywnk9j
         ciMQ==
X-Gm-Message-State: AO0yUKULLUwh4EW99XzowyNCKNL6UMnLnv7+8T+KLU1ZTCIaL76KQ0zU
        rdaEr+Wb403NkcmGJFdD1n54p7VLIwzoxcqC
X-Google-Smtp-Source: AK7set9fwXB18RQrTwwyt3q3TDTvrC9U1L4Sp+xb5Bup1aVkDliCVL6Sgo+06w+x7ZPpep2pc/i1Uw==
X-Received: by 2002:a05:6512:3b20:b0:4de:56a6:236b with SMTP id f32-20020a0565123b2000b004de56a6236bmr2434418lfv.28.1678641974177;
        Sun, 12 Mar 2023 10:26:14 -0700 (PDT)
Received: from letter7.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id o12-20020a056512050c00b004dd7ddc696esm701353lfb.293.2023.03.12.10.26.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:26:13 -0700 (PDT)
Message-ID: <640e0b35.050a0220.628c.19cb@mx.google.com>
Date:   Sun, 12 Mar 2023 10:26:13 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <f34ba6e5-4a8d-0812-c334-ea47de7b1d21@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: exynos-dw-mshc-common: add exynos78xx
 variants
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for letting me know.
> 
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

OK, at least its codified somewhere. Still, this results in the opposite
effect: DTBs written for one SoC, using compatibles from other SoCs just
because "they are the same anyway". And doing this properly, well, results
in essentially duplicate compatibles.

And "fallback compatibles" won't solve this case anyway, as there is no
common compatible that denotes "Exynos7 DW-MMC that has the bug".

>>> That's non-bisectable change (also breaking other users of DTS), so you
>>> need to explain in commit msg rationale - devices were never compatible
>>> and using exynos7 does not work in certain cases.

Probably it makes sense to put this patch after the actual implementation,
so that git bisect always gives a working setup.

> BTW, this rationale was only example - you need to come with something real.

Pretty much the only thing that is broken are SDIO cards, because they run
very short transfers (below the DMA threshold) over the data lines. That's
exactly what I stated.

