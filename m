Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5337627DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiKNMYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiKNMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:24:40 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7002182F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:24:39 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k67so11224929vsk.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jseDXg+bfKp9LA8sgvsVkV393Se7NwCYuZDEZ/MV0GY=;
        b=Dhl14eH0HkdFXG7lsJUSPG2LyOCPf2jM54eKcSPqAG1d3jeFQRhIihhAFnNCvR6rlM
         Ewd1Rd+Q2KQ/1Ys1sdZNSb6zVL8xds5yO2sTnjpVHH6YHeScThrqQkLRh8zEzFp0VtIW
         Rcyl70wf2LtQnlpXbm3FJOw4pkwqAaS9M1xsi3egMPHsPw30ICIevCRk+aA2oOzwHPPQ
         Q0w0970PGr1v3opaGDQU5gkAy8aHx+gCkMzJkzqOCZEgvg+boyI8aR/QbI2kdrXEtk30
         pGCg4iMv2wY7LZboOZiguXXgPS783vefsxjkaWbkjtpfv9FJareAKFfKpbzPz6NXyLek
         0zdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jseDXg+bfKp9LA8sgvsVkV393Se7NwCYuZDEZ/MV0GY=;
        b=FFXN2/mNk/vL+znB0jPZVphNOoIt82U2Du9X8xAmawbY96rHUiYyluZRVKJePylYtU
         mCREsjqfqq3xB0BeRo+oaC2nQKKxCrsNinV8W8TiysqIlHlBaCe9gDVP3KbKYHyM3QTf
         wZa6ZyjWAqlAF6OaxDhdx6JrQKTFsq+APz4sOYeAppIuFzptouINkNV5OLIVOK7mm8mw
         5nWxMNBmE8j63C3phRiMczx8O82So/po7PbeULM7DiL/LgKv5B8mCPAOIvuQqoouyZ2K
         i0iQKuFvpsTeQXKf9PyozWy7NGPAJpuhYuKYc4/LFY/+TUQciHcYnH91vFSttAHFubO4
         o2iQ==
X-Gm-Message-State: ANoB5plCzaJO8pugPBM/xBsVlOew0rVUOfYLgIDPotlJ6haddtFRCAWe
        qCUTfOIC5/CZ/74IBel5HGnELYcpeK6/hzSEBhp0kLaWXqA=
X-Google-Smtp-Source: AA0mqf7LqmPTOFN/Y8WkTSdzCAB667YYC/i5XC95xOIVYt7t6fiF6JJKoRi25YSbSWj2mvqEHYfmbfUjgZA2RK7RBY0=
X-Received: by 2002:a67:ce13:0:b0:3a7:769c:6dee with SMTP id
 s19-20020a67ce13000000b003a7769c6deemr5816436vsl.13.1668428678482; Mon, 14
 Nov 2022 04:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com> <20221112151835.39059-7-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221112151835.39059-7-aidanmacdonald.0x0@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 14 Nov 2022 13:24:27 +0100
Message-ID: <CAMRc=McQCrYEo729k9cnH_bB0Vt5BSB1OHg0tsA3rBL51EdUKA@mail.gmail.com>
Subject: Re: [PATCH 06/18] mfd: max77650: Remove useless type_invert flag
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lee@kernel.org, mani@kernel.org, cristian.ciocaltea@gmail.com,
        wens@csie.org, tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, mazziesaccount@gmail.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, jernej.skrabec@gmail.com,
        samuel@sholland.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 4:19 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The type_invert flag does nothing when type_in_mask is set, and
> it's part of deprecated functionality in regmap-irq. Remove it.
>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/max77650.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mfd/max77650.c b/drivers/mfd/max77650.c
> index 777485a33bc0..3c07fcdd9d07 100644
> --- a/drivers/mfd/max77650.c
> +++ b/drivers/mfd/max77650.c
> @@ -138,7 +138,6 @@ static const struct regmap_irq_chip max77650_irq_chip = {
>         .status_base            = MAX77650_REG_INT_GLBL,
>         .mask_base              = MAX77650_REG_INTM_GLBL,
>         .type_in_mask           = true,
> -       .type_invert            = true,
>         .init_ack_masked        = true,
>         .clear_on_unmask        = true,
>  };
> --
> 2.38.1
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
