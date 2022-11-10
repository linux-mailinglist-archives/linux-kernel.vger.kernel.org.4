Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A1162436F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiKJNmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiKJNmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:42:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2101269DC1;
        Thu, 10 Nov 2022 05:42:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEE69616C9;
        Thu, 10 Nov 2022 13:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C29CC4314D;
        Thu, 10 Nov 2022 13:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668087758;
        bh=4U7C9niDGrmfi8IMDATi6BtcBIfDiuOKvkxBiJpdV3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SX98KqeYKns7KGfDa8dTp6G5wayF8iiATI9dVap4Wgzf6d34aTkI97ttMf366XE+1
         R2U/r9UCn8XAghsEFSpznVYcqr8O4mENHj6OsaLq+Fq6HN0VtBRF5F87Flp3fz7U9W
         nvj7W8/tSmA7L4xJk7dnUI98uInsIF93sAvIZzyrmOw4EtrC/VyKLAoiFVV/YaO0TE
         juhdMKkkNBetHZgQdRAht04cUd+m9+wVS6uPEhlXh6VGR8enutToxoBG4kAhDSNlp5
         DlWpLWUfxIYQqAAL+Tvyjtd7LpIsGuKzn/xSnrb8o9O8thutGRnRZK09gfgNgN9+Eq
         peEprHo4LiCow==
Received: by mail-ot1-f41.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so1118986oti.5;
        Thu, 10 Nov 2022 05:42:38 -0800 (PST)
X-Gm-Message-State: ANoB5pnWBy9BAXxk20tFsEN0BY67gjVYDapT6gIM593tu48kJBuI7gk4
        OuMo+lFTvPK3Y89J5tQEN928W1r5MFyLCw97qQ==
X-Google-Smtp-Source: AA0mqf4gARCZUERKvwgaAfgdC1LEqRRi5pu66mk1Uqd2ev+ik8AG7xmvItT3O8MQpM0VXWbeKoELJNlYq11nhVFHllU=
X-Received: by 2002:a9d:58c3:0:b0:66d:2f7d:2a68 with SMTP id
 s3-20020a9d58c3000000b0066d2f7d2a68mr4817252oth.40.1668087757150; Thu, 10 Nov
 2022 05:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20220927152704.12018-1-jason-jh.lin@mediatek.com>
 <20220927152704.12018-7-jason-jh.lin@mediatek.com> <30278e0f-88ec-069b-3469-56b3fb795702@gmail.com>
In-Reply-To: <30278e0f-88ec-069b-3469-56b3fb795702@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 10 Nov 2022 21:42:25 +0800
X-Gmail-Original-Message-ID: <CAAOTY__vvjKASUJAGOvL=-WnAq-ji7sfyEEY7j49ty0P7Svvdw@mail.gmail.com>
Message-ID: <CAAOTY__vvjKASUJAGOvL=-WnAq-ji7sfyEEY7j49ty0P7Svvdw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] soc: mediatek: remove DDP_DOMPONENT_DITHER from enum
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2022=E5=B9=B411=E6=9C=
=889=E6=97=A5 =E9=80=B1=E4=B8=89 =E6=99=9A=E4=B8=8A7:25=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
>
>
> On 27/09/2022 17:27, Jason-JH.Lin wrote:
> > After mmsys and drm change DITHER enum to DDP_COMPONENT_DITHER0,
> > mmsys header can remove the useless DDP_COMPONENT_DITHER enum.
> >
> > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> Chun-Kuan, I understand you will take this patch through your tree as it =
depends
> on DRM changes. We can also sync so that I take it once you merged the re=
st of
> the series. Having vdosys1 series around maybe that's better to avoid mer=
ge
> problems.

Hi, Matthias:

I do not hurry to merge patches. To prevent merge conflict, let's
merge step by step.
The drm patches depend on binding document patch, so I would wait for
binding document merged.
After drm patch merged, you could merge this patch.

vdosys1 patches depend on vdosys0 patches, so just let it around.

Regards,
Chun-Kuang.

>
> Regards,
> Matthias
>
> > ---
> >   include/linux/soc/mediatek/mtk-mmsys.h | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc=
/mediatek/mtk-mmsys.h
> > index d2b02bb43768..16ac0e5847f0 100644
> > --- a/include/linux/soc/mediatek/mtk-mmsys.h
> > +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> > @@ -16,8 +16,7 @@ enum mtk_ddp_comp_id {
> >       DDP_COMPONENT_CCORR,
> >       DDP_COMPONENT_COLOR0,
> >       DDP_COMPONENT_COLOR1,
> > -     DDP_COMPONENT_DITHER,
> > -     DDP_COMPONENT_DITHER0 =3D DDP_COMPONENT_DITHER,
> > +     DDP_COMPONENT_DITHER0,
> >       DDP_COMPONENT_DITHER1,
> >       DDP_COMPONENT_DP_INTF0,
> >       DDP_COMPONENT_DP_INTF1,
