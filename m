Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74CE72C9B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFLPUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239753AbjFLPT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:19:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1E710C7;
        Mon, 12 Jun 2023 08:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E2161E4F;
        Mon, 12 Jun 2023 15:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F79DC433D2;
        Mon, 12 Jun 2023 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686583190;
        bh=2Q20y0Ssx+Qnm5l9jPWYn3Pa7yN/CQx6/2ZtlgetIYg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h67fcwz+ADhIo8Ww/uLQxiifaD81QYQYZR7hnm8BUFb0IMRitWiYAQmsWJdH99em0
         yatrjqAyaUpkLKyV1uY5IKIZhzW3t08h2o8oblkIl5QWbZi2mp9cxeXfXAmZp6Ajh3
         G04KaGsTY3cSG9TE3jSb/cOr3tQzlekHFuOkbuZaeJbXgNFR2okRX24Oo0HxFCW8Wm
         B/ByDO9+RET9IUVOJersCfr1r83wp2uUXxzpa8p/ned6mEe8Ti9MoLytRxsQACFh3A
         RxWlLhUgfhRDFB9yO7FIlD6ZHe2HFIZAjGoTrOlsMEpeAzM7uN6VrJDWYn1y3DTfhW
         ZNO4NI0M+IFmw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f63a2e1c5fso5308548e87.2;
        Mon, 12 Jun 2023 08:19:49 -0700 (PDT)
X-Gm-Message-State: AC+VfDxA+EwP9YNmSg+ERie3caW3/8vJrVt8B9sZt8FvtHPSgyWsEHuk
        G+x+pOO9dC/vqHpPSgh3j2WYM2HnpU1ct8uuDw==
X-Google-Smtp-Source: ACHHUZ7YxJzSB669feL0VIOCXTzs7RUFULvVqeaRA4EK8WzrSV1+iAUrw39mOzvDWBX7fX2GbkgV+5Vu7419NCtE+ZQ=
X-Received: by 2002:a2e:a408:0:b0:2ad:d949:dd39 with SMTP id
 p8-20020a2ea408000000b002add949dd39mr3431947ljn.29.1686583188085; Mon, 12 Jun
 2023 08:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <1681366162-4949-1-git-send-email-xinlei.lee@mediatek.com> <1681366162-4949-2-git-send-email-xinlei.lee@mediatek.com>
In-Reply-To: <1681366162-4949-2-git-send-email-xinlei.lee@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 12 Jun 2023 23:19:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9H9qbPC411rRZrvwEC3dLEvz5m=tn=CysWCZErtyKdnw@mail.gmail.com>
Message-ID: <CAAOTY_9H9qbPC411rRZrvwEC3dLEvz5m=tn=CysWCZErtyKdnw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: display: mediatek: dsi: Add compatible
 for MediaTek MT8188
To:     xinlei.lee@mediatek.com
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, shuijing.li@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<xinlei.lee@mediatek.com> =E6=96=BC 2023=E5=B9=B44=E6=9C=8813=E6=97=A5 =E9=
=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:09=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Xinlei Lee <xinlei.lee@mediatek.com>
>
> Add dt-binding documentation of dsi for MediaTek MT8188 SoC.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.yaml       | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dsi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.=
yaml
> index 4707b60238b0..13fa76299254 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yam=
l
> @@ -29,6 +29,7 @@ properties:
>        - mediatek,mt8173-dsi
>        - mediatek,mt8183-dsi
>        - mediatek,mt8186-dsi
> +      - mediatek,mt8188-dsi
>
>    reg:
>      maxItems: 1
> --
> 2.18.0
>
