Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C531A70F762
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbjEXNLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjEXNLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:11:18 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2785B0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:11:15 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-561bd0d31c1so9147717b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684933874; x=1687525874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qW2u6I6RYUNopnlrFB7gtJl5jP7+ZzIFNaPpKmw05Tc=;
        b=VVpAOranraFZ/GBN5m9dQ0Zy60H/r900dYnJXds6ci0uYUkRdmKcMCMOKix66CHlbp
         kw6ZjYRhEzkoxuoiA9HUihJBx/teSolUdpyhpn4PdxCVpVsSgWdtlbvglsOL041JXr4R
         ccOH+ACHKZTB2d6wi+RKVtCHV4oVrLw338UtdYhpjnkV1VElBy38+xf3DHK7LqCN4FBd
         hQW5owghfvpRoBSt24Or3vwP3BGgDr4NdhSqFola3yDfxecmoKC+UZJsbTaPHJwXSSaU
         1c5igEHAL8HH0OYrcgkVaWxlCDmQntzu62k2wDxKwv2ddei5G0emU3aBCCTlwU35E51+
         epZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684933874; x=1687525874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qW2u6I6RYUNopnlrFB7gtJl5jP7+ZzIFNaPpKmw05Tc=;
        b=Wuit2qSnl9oKRaRqYaSkmJTB8BcdyhTzSzhtrOkENeTmgO1OCeQnOYV9irD+vyojoT
         KABNewMj9pdIACueS5fP3uSfU5VF7KXd6Q2KHYttdaYXt4FnrmP5GcUmNZkrCbqBDxHx
         gJviSFw/hxT3sDmJ29sDedXW3NjclrDjDZxmI3aXGBXNgN8pDUggDqGDtmgj3yHqc0sO
         2We1wdv0HbPJkWG6AXv//iOUgVrAuGfs4yQ6vszOH64pxrfopiuvNkSwGLVwHjbYIX/m
         4FeiC4Vfbsdc2P5PRGzBJVxmU7+o5efUA8Ycb0mHfS/a7/QolstJN0KfzmnQARWDIbzC
         O2eg==
X-Gm-Message-State: AC+VfDwkfce8Okn5SV60rDo9I6s1maQB0sN4167qvgexGPFrWXbEWS/I
        nRLjORPYtqLkEQ0APOmdzjHI0NA6+Eg8J2RyTIXVZg==
X-Google-Smtp-Source: ACHHUZ6+P1BwpFUsi48OyI1RaL/LudEbRVIKuQit7bvwqfM/kmM7oikCGATS8qA16J+xn+w1MPC3kluXzs4iZ/m75dw=
X-Received: by 2002:a0d:d788:0:b0:55d:c333:26c4 with SMTP id
 z130-20020a0dd788000000b0055dc33326c4mr17405985ywd.0.1684933874685; Wed, 24
 May 2023 06:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230509194455.1791890-1-f.fainelli@gmail.com>
In-Reply-To: <20230509194455.1791890-1-f.fainelli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 May 2023 15:10:38 +0200
Message-ID: <CAPDyKFouDf9OUvN5SsucQ1VnGoM2wmziB6xrP-kdjLJ13uU41w@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Suppress empty whitespaces in prints
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bean Huo <beanhuo@micron.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 at 21:45, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> If the device is not read-only, then we will be printing an empty
> whitespace before the newline, fix that.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 00c33edb9fb9..761876e5012a 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2502,9 +2502,9 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>
>         string_get_size((u64)size, 512, STRING_UNITS_2,
>                         cap_str, sizeof(cap_str));
> -       pr_info("%s: %s %s %s %s\n",
> +       pr_info("%s: %s %s %s%s\n",
>                 md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
> -               cap_str, md->read_only ? "(ro)" : "");
> +               cap_str, md->read_only ? " (ro)" : "");
>
>         /* used in ->open, must be set before add_disk: */
>         if (area_type == MMC_BLK_DATA_AREA_MAIN)
> --
> 2.34.1
>
