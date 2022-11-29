Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C6F63C06D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiK2MzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbiK2MzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:55:07 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB7C61517
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:55:06 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id s196so12923864pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QgBSalTxeyU/L1VicCBC3Zk4McvknVBPub5NGVaaxho=;
        b=Bp+DEBKGs64ElSYn9C9YFF/Rp8hsCLQydOSCcpJ4ejzaw88N30CtZFqxNi4yZeU/SY
         9KFoPwSM6jFFBC9iiYTuZQimpFcR6BXa4XNJZWEbEkr5LArJVCoVAGpXKNODGEvI/PVT
         AJ1yWfAOyNjxNYsSCt/LBxOyDce7sHII0EV33UDfrbhLUMZEChGi2+H5BlG8WC9MWmby
         2qhoEwYVUmElxpGgvnRF6bVBwLYO6ICpoHfLQojV4RUajOEUVLigp6++lPN0E60aBkgm
         ev5uezNidJ5Xo2XAk9zGek3/ZQvKO6aNXzUwajeR8XKrvJhAoxs1ewqXy1KBcBjszxd9
         /PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgBSalTxeyU/L1VicCBC3Zk4McvknVBPub5NGVaaxho=;
        b=mqAqp+bh5NCoU+fvICMdqDQykI47l9DxY6VAB0pJloNPJCrQN5WH3nDdmMxqrUZy4+
         uH3UGWUd3q+ENaRjKCVtVCXW+mnmK4NzRHHobAv44RZtpmXMdXyA2xKNINlc02IquW6S
         gpuf24NgZs8mrcGdopWtl5N+39kwkpBNIGkrsQT3RKHfBeMK5uWGXaaj6BWfypxScLte
         xj46EUn6Icw3FqwaPJnpZm/psI7PatjTx6FSuIjX8u+wJWyh+cQjGmYipN0B6h4TiTNi
         wa89W9UbAQd2MBurPACk7gIYyAdC8H+GTZchBFqBR3gralX/bSd1ucWxaje3GnpYi68X
         QvXg==
X-Gm-Message-State: ANoB5pncyKgC0ZChEXldhLqLM+xzQmNu06JIpslSSRBxlDFIGeJjJevV
        ++UrXTHivyIkoysivU073D93/aQwE71IvPBnx2kuuw==
X-Google-Smtp-Source: AA0mqf6SlKWFhBmu2MGDSnGuCrmVC4f/goYJ3ifIVCmVo1FUNvczGrhnk3Y2f7DfHkYUZ7h8jyMs2+f4ms5kF4Z9tpk=
X-Received: by 2002:a65:4688:0:b0:477:7aee:a464 with SMTP id
 h8-20020a654688000000b004777aeea464mr35902018pgr.595.1669726505363; Tue, 29
 Nov 2022 04:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20221126102520.2824574-1-yebin@huaweicloud.com>
In-Reply-To: <20221126102520.2824574-1-yebin@huaweicloud.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:54:29 +0100
Message-ID: <CAPDyKFq4mhaK+TWwSNyC6c6xrqoBd2UEsNG25oUg-oeZHp4DNQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: refactor debugfs code
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     wsa+renesas@sang-engineering.com, kvalo@kernel.org,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, yebin10@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Nov 2022 at 11:04, Ye Bin <yebin@huaweicloud.com> wrote:
>
> From: Ye Bin <yebin10@huawei.com>
>
> Now, CONFIG_DEBUG_FS is scattered in various functions, to make code
> clean centralized processing CONFIG_DEBUG_FS in mmc debugfs module.
>
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/bus.c  |  4 ----
>  drivers/mmc/core/core.h | 15 +++++++++++++++
>  drivers/mmc/core/host.c |  4 ----
>  3 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index d8762fa3d5cd..36679f4e9acc 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -359,9 +359,7 @@ int mmc_add_card(struct mmc_card *card)
>                         uhs_bus_speed_mode, type, card->rca);
>         }
>
> -#ifdef CONFIG_DEBUG_FS
>         mmc_add_card_debugfs(card);
> -#endif
>         card->dev.of_node = mmc_of_find_child_device(card->host, 0);
>
>         device_enable_async_suspend(&card->dev);
> @@ -383,9 +381,7 @@ void mmc_remove_card(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
>
> -#ifdef CONFIG_DEBUG_FS
>         mmc_remove_card_debugfs(card);
> -#endif
>
>         if (mmc_card_present(card)) {
>                 if (mmc_host_is_spi(card->host)) {
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index f5f3f623ea49..37091a6589ed 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -86,11 +86,26 @@ int mmc_attach_sdio(struct mmc_host *host);
>  extern bool use_spi_crc;
>
>  /* Debugfs information for hosts and cards */
> +#ifdef CONFIG_DEBUG_FS
>  void mmc_add_host_debugfs(struct mmc_host *host);
>  void mmc_remove_host_debugfs(struct mmc_host *host);
>
>  void mmc_add_card_debugfs(struct mmc_card *card);
>  void mmc_remove_card_debugfs(struct mmc_card *card);
> +#else
> +static inline void mmc_add_host_debugfs(struct mmc_host *host)
> +{
> +}
> +static inline void mmc_remove_host_debugfs(struct mmc_host *host)
> +{
> +}
> +static inline void mmc_add_card_debugfs(struct mmc_card *card)
> +{
> +}
> +static inline void mmc_remove_card_debugfs(struct mmc_card *card)
> +{
> +}
> +#endif
>
>  int mmc_execute_tuning(struct mmc_card *card);
>  int mmc_hs200_to_hs400(struct mmc_card *card);
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 5457c8aeeea1..d17eda753b7e 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -629,9 +629,7 @@ int mmc_add_host(struct mmc_host *host)
>
>         led_trigger_register_simple(dev_name(&host->class_dev), &host->led);
>
> -#ifdef CONFIG_DEBUG_FS
>         mmc_add_host_debugfs(host);
> -#endif
>
>         mmc_start_host(host);
>         return 0;
> @@ -651,9 +649,7 @@ void mmc_remove_host(struct mmc_host *host)
>  {
>         mmc_stop_host(host);
>
> -#ifdef CONFIG_DEBUG_FS
>         mmc_remove_host_debugfs(host);
> -#endif
>
>         device_del(&host->class_dev);
>
> --
> 2.31.1
>
