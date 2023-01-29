Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A627867FC6C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 03:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjA2CnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 21:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjA2CnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 21:43:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D3276A9;
        Sat, 28 Jan 2023 18:42:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BAFF60C70;
        Sun, 29 Jan 2023 02:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD91C433A1;
        Sun, 29 Jan 2023 02:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674960175;
        bh=eLjMMpuPC+msCk8tJokSDBn8qk6r0ihX0UPlPEdZoaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dDkj/RkiTABi/evFeqEhGLVjK5k0aLdPX2t9ZcRikgbdYq7Cqo/dvjRnNAalj6mmF
         9RGxEs4Q6yznwG0Pa5PvDKqgwW32NGtmiBPDoVqR9GhxAZqFUiJ6281Ua2pULHs1Y5
         3fG+G3povprQqgm7lRrS/v+lIn82T8gyj+cN8f8oUDNlMxam6Px9GmwzIe8yNj9etO
         DX+7JRJy42z9fNt4g6bM/Bwh1/pFpIVbgWqqK996pUlf63nSfpDiXpoRFRODW3KqSx
         5w8vsoMlm4g5aBgNy6yssxlkZ3AWNdcDzyLeccNQIrTcFMDEZ3hG7EdCl0dQ8uMPDg
         Fgg0YV7oYQ22A==
Received: by mail-lj1-f173.google.com with SMTP id t12so9499682lji.13;
        Sat, 28 Jan 2023 18:42:55 -0800 (PST)
X-Gm-Message-State: AO0yUKX8lMofHvOiT5jr+RzNT+Rvjd4USVzZpbZ8aZqJ4s3iK9uvkcOi
        WSPU5wjfzSMfNdlyWOiNLMWKdZ6fpY1e9NuH2A==
X-Google-Smtp-Source: AK7set8aEKszNvVH3ydOBmwpXEYphtTde4TFpUS74w2l17hiB5Fp963hu02r5xyQBUTx/v1BLaq47isJzUKHIoZViTg=
X-Received: by 2002:a2e:3c0a:0:b0:28d:bb26:1902 with SMTP id
 j10-20020a2e3c0a000000b0028dbb261902mr1460711lja.22.1674960173614; Sat, 28
 Jan 2023 18:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20230118091829.755-1-allen-kh.cheng@mediatek.com> <20230118091829.755-9-allen-kh.cheng@mediatek.com>
In-Reply-To: <20230118091829.755-9-allen-kh.cheng@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 29 Jan 2023 10:42:41 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-he6yeunyTjNU8wT0T=Uc3yxDx+unFm8NJ4HHqHyTv9A@mail.gmail.com>
Message-ID: <CAAOTY_-he6yeunyTjNU8wT0T=Uc3yxDx+unFm8NJ4HHqHyTv9A@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] dt-bindings: display: mediatek: Fix the fallback
 for mediatek,mt8186-disp-ccorr
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Allen:

Allen-KH Cheng <allen-kh.cheng@mediatek.com> =E6=96=BC 2023=E5=B9=B41=E6=9C=
=8818=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:18=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> The mt8186-disp-ccorr is not fully compatible with the mt8183-disp-ccorr
> implementation. It causes a crash when system resumes if it binds to the
> device.
>
> We should use mt8192-disp-ccorr as fallback of mt8186-disp-ccorr.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: 8a26ea19d4dc ("dt-bindings: display: mediatek: add MT8186 SoC bind=
ing")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,cc=
orr.yaml
> index 63fb02014a56..117e3db43f84 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.y=
aml
> @@ -32,7 +32,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8186-disp-ccorr
> -          - const: mediatek,mt8183-disp-ccorr
> +          - const: mediatek,mt8192-disp-ccorr
>
>    reg:
>      maxItems: 1
> --
> 2.18.0
>
