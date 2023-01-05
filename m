Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5814865EF97
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjAEPCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjAEPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:02:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671F4FCE1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:02:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso2277516pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Woholkq4tbWZOCvL5MlgF6N+F+liG0Lx4w+ScCVbbIE=;
        b=JECYtY7R70n+T3jxQEnqPzICsy0aX1nXmy2pfCicKpY46UUasuZfg+BPJvlqTH6BGq
         YFJktz/FERYRxxr56I6tIPdElSvRzKYIhxJvY5O0ebqxNq2gNBp2ywRCX20FZq6E2Cq3
         rl35odF4mskjzkLUkAobQRko3XhWyN9la0DVtl3lQRZTkhAe63mRuUUzGjX+lPM4HUeI
         i5RImEJIOVg5xii8Tg+QGxm3c+4JlPVGsMC6BGwxQ/dJwEOufamN4WSFvc022Xaqt8y7
         92SgRYv6aNZLSE42kd2rpSmMHE0IOC5xqLPXc1255JeyG5PZY3tQtXi8BmHmYN+m31fZ
         2guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Woholkq4tbWZOCvL5MlgF6N+F+liG0Lx4w+ScCVbbIE=;
        b=ivZi4ipafEzc9v6i6120ILu2wWP09BtiW7v4T147Ik753JmKR1LV98jncy4noSPzY8
         KCWePGTHe6EgNwHQA70+vZ/CpBUnDyiZsqq4a+jUh+2Ggmq7qsaA2cJClIoPjzD2OT9V
         jqKO9TnVFcyrKxze7OOZG7HgW2EUe8uR/sf00Gw2G/q11eqtsXVOiLQRaWM6yDUqe/84
         DmfQ5rca44zYDn6NxD5LlLHKMGbUIzJfmsQNflbl0efVwi6fmoSIWeOnUz5MFISSpSxW
         /BkGbCLdoPrvyAKRnePY6I5Q8w4pgYiGysj19SLJHZsK8aCcENhXIzA/L/utZ6MiXeNj
         A5Mw==
X-Gm-Message-State: AFqh2krXDtJ9qVgQtGenqnxhBMwvl/7rzvke4adrtuHXuwcAxo0+ibxH
        QNPL3C5OSmxc87NblO3DFKWOAMuG0TvPD7rZA1jGCA==
X-Google-Smtp-Source: AMrXdXsSuoJY57l9ZlEQV1F0I5f0cCXSdjGeaPBKURvWWyh75lyJSyq7EXTCiPZGjgKztlHHX0kkV/YFtsZD7ZE52TE=
X-Received: by 2002:a17:90a:c083:b0:226:6c53:fc27 with SMTP id
 o3-20020a17090ac08300b002266c53fc27mr1171333pjs.202.1672930928112; Thu, 05
 Jan 2023 07:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20230105134622.254560-1-arnd@kernel.org> <20230105134622.254560-22-arnd@kernel.org>
In-Reply-To: <20230105134622.254560-22-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jan 2023 16:01:31 +0100
Message-ID: <CAPDyKFoNrtZSDm2Ry+7_74uGLqz8KpbtEC0Z6WNxv7G9JruKtA@mail.gmail.com>
Subject: Re: [PATCH 21/27] mmc: remove tmio_mmc driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Ian Molton <spyro@f2s.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2023 at 14:47, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> With the TMIO MFD support gone, the corresponding MMC host driver can
> be removed as well. The remaining tmio_mmc_core module however is still
> used by both the Renesas and Socionext host drivers.
>
> Cc: Ian Molton <spyro@f2s.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I intend to pick this up via my mmc tree, just awaiting an ack from Wolfram.

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig    |   8 --
>  drivers/mmc/host/Makefile   |   1 -
>  drivers/mmc/host/tmio_mmc.c | 227 ------------------------------------
>  3 files changed, 236 deletions(-)
>  delete mode 100644 drivers/mmc/host/tmio_mmc.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f0456ad4b597..e1b88b51cc80 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -655,14 +655,6 @@ config MMC_SDHCI_SPRD
>  config MMC_TMIO_CORE
>         tristate
>
> -config MMC_TMIO
> -       tristate "Toshiba Mobile IO Controller (TMIO) MMC/SD function support"
> -       depends on MFD_TMIO || MFD_ASIC3 || COMPILE_TEST
> -       select MMC_TMIO_CORE
> -       help
> -         This provides support for the SD/MMC cell found in TC6393XB,
> -         T7L66XB and also HTC ASIC3
> -
>  config MMC_SDHI
>         tristate "Renesas SDHI SD/SDIO controller support"
>         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 063d87764966..b498c17cd124 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -35,7 +35,6 @@ obj-$(CONFIG_MMC_DAVINCI)       += davinci_mmc.o
>  obj-$(CONFIG_MMC_SPI)          += mmc_spi.o
>  obj-$(CONFIG_MMC_SPI)          += of_mmc_spi.o
>  obj-$(CONFIG_MMC_SDRICOH_CS)   += sdricoh_cs.o
> -obj-$(CONFIG_MMC_TMIO)         += tmio_mmc.o
>  obj-$(CONFIG_MMC_TMIO_CORE)    += tmio_mmc_core.o
>  obj-$(CONFIG_MMC_SDHI)         += renesas_sdhi_core.o
>  obj-$(CONFIG_MMC_SDHI_SYS_DMAC)                += renesas_sdhi_sys_dmac.o
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> deleted file mode 100644
> index 53a2ad9a24b8..000000000000
> --
> 2.39.0
>
