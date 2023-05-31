Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848E571787C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjEaHnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjEaHnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:43:25 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C5E93
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:43:24 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-62615694bb9so19949496d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685519003; x=1688111003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hCCJrsaz/NjGrHJ94qpM3huv+xsF2o6fZiZu7/z8AY=;
        b=VgW5pvZ3wqpWZIFiq2dd7Bfobqfflrkuq1mJb47cnl5/aQQxXhGgkRBV+EjtQexHxd
         lJZWjBXAxCLvKTbwl27X2FfjdySA+Jwm64MC+9lvyp1mBq4kYsmUet2vBoCNCscQBHV0
         XZoYE0Gq4tiQumSoLTu79fhV4aTBeW4GO+O1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519003; x=1688111003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hCCJrsaz/NjGrHJ94qpM3huv+xsF2o6fZiZu7/z8AY=;
        b=HYW1Se4Sl2OUMdPaxNwQ9trytKrBgQDfN6YQ9yZj5R0xt+SncoyimD4nq8sFyLf6Ul
         L8TGII+mma/92fM2ZdbQ3MPA7w8FUFuiYODW9GAsa/jUeWk6G/BE/ZReiDegz2XJ6acG
         g6PXZjv4ZMgatzxkxOMZQThWFdgJ79bu2pOulYPM3ZBMlkrEjPLPj4OEhuSS17/c9Ws0
         E/nq+lz+1Uw6/8PXmerSJlOPOkeczk7vPTlvWfItAe5waX4Pvb07qbJdm52vA51su5yD
         zsxvJUwNnQsm1vy6rdM9DyjvD4mK/dN/7nonVJOQ6qLHegu9Frmh9Ds2/PrrjL0+s2hY
         F/Lg==
X-Gm-Message-State: AC+VfDxkrL22KwKU4GNACU1ryCrPx7c+/tvKTAEXz4JrUUV9lI0vL+Pv
        +IAtJfKXyaojklRuA2OwXb9XrwJtJwe4XIlNukAj+pEBYwnIdpZV
X-Google-Smtp-Source: ACHHUZ55CaO/7pKYADZLoW2cfgMbio+kJB5f8rUaty9cLHbxEhYWcWalPWE0GNlEOIgz74JZcSTB8c25FAlzJvkwUKw=
X-Received: by 2002:a05:6214:528d:b0:625:7802:f36d with SMTP id
 kj13-20020a056214528d00b006257802f36dmr4655699qvb.24.1685519003409; Wed, 31
 May 2023 00:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230306080659.15261-1-jason-jh.lin@mediatek.com> <20230306080659.15261-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20230306080659.15261-3-jason-jh.lin@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 31 May 2023 15:43:12 +0800
Message-ID: <CAGXv+5EPktjMABhtWf9dL-25dAe=Mf4=BSMmE+=4m2WisDXXFQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] soc: mediatek: remove DDP_DOMPONENT_DITHER from enum
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Mon, Mar 6, 2023 at 4:07=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@mediatek.=
com> wrote:
>
> After mmsys and drm change DITHER enum to DDP_COMPONENT_DITHER0,
> mmsys header can remove the useless DDP_COMPONENT_DITHER enum.
>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

CK didn't pick up this patch. Since the other patch already got picked up
in v6.4-rc1, could you merge this for v6.5?


Thanks
ChenYu


> ---
>  include/linux/soc/mediatek/mtk-mmsys.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index dc2963a0a0f7..8eb5846985b4 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -27,8 +27,7 @@ enum mtk_ddp_comp_id {
>         DDP_COMPONENT_CCORR,
>         DDP_COMPONENT_COLOR0,
>         DDP_COMPONENT_COLOR1,
> -       DDP_COMPONENT_DITHER,
> -       DDP_COMPONENT_DITHER0 =3D DDP_COMPONENT_DITHER,
> +       DDP_COMPONENT_DITHER0,
>         DDP_COMPONENT_DITHER1,
>         DDP_COMPONENT_DP_INTF0,
>         DDP_COMPONENT_DP_INTF1,
> --
> 2.18.0
>
