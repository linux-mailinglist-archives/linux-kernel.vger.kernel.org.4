Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9376CBA62
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjC1JWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjC1JWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:22:15 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9DA5272
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:22:13 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i7so14208950ybt.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679995333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfEbC+QvlmYRFEpM334dDDmHLZzT53TFZ7pAp7zhwe4=;
        b=O+6rpHUxMrocg+PNRSUNrl09ruDw8nFucVYoEuKiSkUoYU+rAaaZhtmXvt6TdGkwNP
         M1b8yBJvevc5Zt7Jyzawt3sUx2+8btHWzfMFZYbqpV5ujpvuCnm6uUn66khGbaDrI4/b
         BnOZaXOaZ1QBeFNUU7FRBwi2CjsBQzbK8g1XLS5nhmorHOweLMGd0v+/YX2qMdHObYeV
         flOhgDotNum9SI+7uxyc4MfExqnGRtrmIxceFdg59KEnFajy5Cv80DUd+NdLRx8k3RA4
         7LEesg4hoH8OgLFhlxClH+aKYg8loDZNrIsxSLEo9AIGjCJ+YOTdQbIxwY0yUZUkHLT6
         Rexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfEbC+QvlmYRFEpM334dDDmHLZzT53TFZ7pAp7zhwe4=;
        b=AQlpprOp0N4Q3cLjJUKYDlIzYVI2eYtjsXiYv2wrL6l321H3wvUOhcLiLCA/TUXmNb
         S2neth90GlW1Vz1+fUALG7eCJEzinSfAECBiOJ2Tz9+nqm3sMXXOS+ZtcLeLMh7Lvf3u
         KFPsId8dIeOc71vGxbubsBROAVba2AMfXUHzJTO7tLiPl6fMhVUTAr+/J98RqmlPjKmQ
         iKunBe5WmUV2LMAps8FuibvEdz0sSnflZO4dqgy7xW2oI6Ok6OrTAjteVArGDqYs491q
         rxgvo/BQZyiZ1A7cyQNYiz/tf9dLfS3+7tbg+0ySOVPq8hgHWwsOBER5llpPZ23PO72F
         EVbw==
X-Gm-Message-State: AAQBX9cCX5NVxpGoIULeTL4YkP50PF6SnCz7GrXACxgOl7aLfjPVtuYB
        i3jdXGMIRWjuXtd4M/oJK9V4+703f6SRukasH6vv4A==
X-Google-Smtp-Source: AKy350auimLGCr8ILoBzGItiYAiR4pgO8LPEdWrnD1Vk5Z4GVtmW4pyg+5kEg5lZTH5zOTSGFwsCl8xX2CPkdVQT06U=
X-Received: by 2002:a25:a2c3:0:b0:b78:1b26:a642 with SMTP id
 c3-20020a25a2c3000000b00b781b26a642mr6658558ybn.1.1679995333140; Tue, 28 Mar
 2023 02:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230324094205.33266-1-angelogioacchino.delregno@collabora.com> <20230324094205.33266-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230324094205.33266-4-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 28 Mar 2023 11:22:02 +0200
Message-ID: <CAFGrd9pjm97+Et-auw2rh4nWUJAcqXzy2cix42QJRx4UHNzq2g@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] soc: mediatek: pwrap: Add kerneldoc for struct pwrap_slv_type
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, flora.fu@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 24 mars 2023 =C3=A0 10:42, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> a =C3=A9crit :
>
> In preparation for adding new members with name abbreviations describe
> the struct pwrap_slv_type with kerneldoc to enhance human readability.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/=
mtk-pmic-wrap.c
> index 5c500be48f7c..a33a1b1820cb 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1218,11 +1218,17 @@ struct pwrap_slv_regops {
>         int (*pwrap_write)(struct pmic_wrapper *wrp, u32 adr, u32 wdata);
>  };
>
> +/**
> + * struct pwrap_slv_type - PMIC device wrapper definitions
> + * @dew_regs:      Device Wrapper (DeW) register offsets
> + * @type:          PMIC Type (model)
> + * @regops:        Register R/W ops
> + * @caps:          Capability flags for the target device
> + */
>  struct pwrap_slv_type {
>         const u32 *dew_regs;
>         enum pmic_type type;
>         const struct pwrap_slv_regops *regops;
> -       /* Flags indicating the capability for the target slave */
>         u32 caps;
>  };

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Regards,
Alexandre
