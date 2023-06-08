Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF287727904
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjFHHoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjFHHnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:43:52 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8482B1BF9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:43:48 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-783f88ce557so113801241.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686210227; x=1688802227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJAXrDTd/Nz/J5muH2M5Mg9/zWBy269fM8uuL6rXc60=;
        b=DNPvf1GpogmxzgQvbWz98Sw8cq32qUMrFI5mTw675XCXzXY808txVThkEsqsrADeel
         F9nHLSSzDUyCasRGlwJSX1tNIXVd+1YibbRWCEnNHcT1edFxru9LzT0SLrcjT0XqJhgq
         2uuPMP/rkP/DseGIkYrv0+Ucp9yJhSlN8zNb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686210227; x=1688802227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJAXrDTd/Nz/J5muH2M5Mg9/zWBy269fM8uuL6rXc60=;
        b=gRomP7nJ0NzayVlN6Dow0iXN/i89IlsnYRoYR3VXrUX+qXwhTGhxtG/fOgkn6lEGbV
         YnBTtm+jeJ0bVOdZ6j70NUl2MUhxJf28VejCokmaQ1dQORWVpmahZAp68KagIhlJ/1HZ
         HrxnFNfKcv9xa4tf6Pj07xagUkUvdYp51GShBGaKImxsXrn4/7EGrnN/pnIw/XClmOZA
         FKk21Erw97B1CAz90QqKpqhYSObMRLa8rn5h7+r/rpK5t6bBzrFvgtjhKI3uI11OPg3o
         +pcB8B8/ta6Kw9Iy20bDeWgScQDXcDAhawYT2Zkqk6XD4+ge1h09SUG4Y0e8M3R29eu4
         qrfw==
X-Gm-Message-State: AC+VfDwPDT2jC/kS7jGrwHELYqyw3C5Bf1gOuu0Reh6VT/cS1V1bsZ8b
        WrDY0Hl74jug7zarOQfEuYAUBHzYIVi9DeADlu2u+w==
X-Google-Smtp-Source: ACHHUZ79ixQwfkYC9Zf7mdwRzABuK9h59tn/Zx8kcIDizpuVdiBvKBT6XWtWmV7VyQiZhvuYHK304MUdsNJzyBFAobA=
X-Received: by 2002:a05:6102:104:b0:43b:2a58:8eb5 with SMTP id
 z4-20020a056102010400b0043b2a588eb5mr1781203vsq.20.1686210227541; Thu, 08 Jun
 2023 00:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230607205714.510012-1-nfraprado@collabora.com> <20230607205714.510012-5-nfraprado@collabora.com>
In-Reply-To: <20230607205714.510012-5-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 8 Jun 2023 15:43:36 +0800
Message-ID: <CAGXv+5EgP+0fTDhdpnYDCVQAWtWqwKp=Xxh-pHc1137wHoywRQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] clk: mediatek: mt8183: Add CLK_VDEC_ACTIVE to vdec
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 4:57=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Add the CLK_VDEC_ACTIVE clock to the vdec clock driver. This clock is
> enabled by the VPU once it starts decoding.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
>
> Changes in v2:
> - Added CLK_IGNORE_UNUSED flag
>
>  drivers/clk/mediatek/clk-mt8183-vdec.c | 5 +++++
>  include/dt-bindings/clock/mt8183-clk.h | 3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8183-vdec.c b/drivers/clk/mediate=
k/clk-mt8183-vdec.c
> index 513b7956cbea..03c4f1acfdb8 100644
> --- a/drivers/clk/mediatek/clk-mt8183-vdec.c
> +++ b/drivers/clk/mediatek/clk-mt8183-vdec.c
> @@ -27,6 +27,10 @@ static const struct mtk_gate_regs vdec1_cg_regs =3D {
>         GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift,   \
>                 &mtk_clk_gate_ops_setclr_inv)
>
> +#define GATE_VDEC0(_id, _name, _parent, _shift)                \
> +       GATE_MTK_FLAGS(_id, _name, _parent, &vdec0_cg_regs, _shift,     \
> +               &mtk_clk_gate_ops_setclr, CLK_IGNORE_UNUSED)

I think what you want is a read-only gate clock only used for reading back
the status. The ops would only have .is_enabled.

ChenYu
