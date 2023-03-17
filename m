Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F2D6BE8D9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCQMI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCQMIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:08:54 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE11AA704
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:08:43 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id v196so5335961ybe.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679054922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjGy87pNKsb6y2cBmiWPHVqOZpmYwx0L2pBm6FPlioo=;
        b=7xIEFhptaAK8MOSW/KceXs42/aS/R0TPdFaNQBFbHxeQNT2G2qEOR4ut2cSERK9jRZ
         a31SiWJWCrHhbWBSFreq5X1iFizZEjZIcOJN+YYW1HNqxhVoxWc3Oq3GN9JU+fYgnddF
         qnfVMZqZAv4hbcZMsDyxVdUrqqBBGy70R3UjRhmOvH4+slSl21MUEjenmsaa5U61vRxF
         Zv2O4FMnSrfyIQa/juBUsKyNJolMwS3SKIThkxNHc4NYapqXToXNBT1I6nI6uo8OZ2zv
         ePcBmKUaLc8odWHqfX9mEGfcoYyPxySm3bow7Jz4wqAKGl/pzkvwNRednOiExEgaW0Yd
         Mmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679054922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjGy87pNKsb6y2cBmiWPHVqOZpmYwx0L2pBm6FPlioo=;
        b=mcSqyauz9EAin7SVDchy09Dbvlq9pBqPHM46cMx+lY3/4+6HVOf8fY6ni1oZgb9xuW
         uyqq4KdBGQk08E54VwyOsUS1kgIkw1PB4pNXfvUY2oADlk2FACQLrwyVXibHvXZGDePx
         jiliDEpOi2O8xMkmtXBBaGZVvUcMWjlpz3r4whbfenCRivHJIV1kxKX5PcSNKwZOCXhT
         omv034RRFM3xrlhxLhHuNk3v6hVdNIrlzhjgC9b1Ds7ACA8/H+2a4ssXcsSttB/mFbuz
         CEyjd04lmyiRQ5KcJVIeWmZwyAXdceDVLczbaY+NC6BK703/bAgsHIEFgZ50UMgUwmZb
         YbaQ==
X-Gm-Message-State: AO0yUKWfbbR4vUv2jIzdMRUMpZI917nO/cb/hQRF2W9KRIX+b0HPToK/
        s8qdAG1lc0s31D48PbQ5YsBdaBpVY5EgpoA0LUBJFG3FyCUehuv+KZ8=
X-Google-Smtp-Source: AK7set/61F0QRhWRgg7+EjPAdnt8sqw4F2reO2/4CNJsbOeWAawezoBi8JybRiyvSSaD/Go45y0C6kZXjlKT4HS18yY=
X-Received: by 2002:a5b:bc7:0:b0:b3b:6452:6a0d with SMTP id
 c7-20020a5b0bc7000000b00b3b64526a0dmr10618375ybr.1.1679054922495; Fri, 17 Mar
 2023 05:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230306-ccorr-binding-fix-v2-0-4822939a837d@baylibre.com> <008996c3-074c-b443-73f2-c14f0fdf8e4e@gmail.com>
In-Reply-To: <008996c3-074c-b443-73f2-c14f0fdf8e4e@gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 17 Mar 2023 13:08:31 +0100
Message-ID: <CAFGrd9rAH4LmuZ915+sNbUcriOWU8hNXZWr94_BEjzey5YbBRw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: display: mediatek: Fix the duplicated fallback
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

This version is outdated.
Here the last one:
https://lore.kernel.org/all/20230306-ccorr-binding-fix-v5-0-6c56aaecc3b1@ba=
ylibre.com/

Regards,
Alex

Le ven. 17 mars 2023 =C3=A0 12:25, Matthias Brugger
<matthias.bgg@gmail.com> a =C3=A9crit :
>
>
>
> On 06/03/2023 17:15, Alexandre Mergnat wrote:
> > The item which have the mediatek,mt8192-disp-ccorr const compatible alr=
eady
> > exist above. Remove duplicated fallback.
> >
> > Fixes: 137272ef1b0f ("dt-bindings: display: mediatek: Fix the fallback =
for mediatek,mt8186-disp-ccorr")
>
> We can argue if dt-binding patches should have a fixes tag at all. Given =
the
> fact that there are so many warnings still around, I don't see any value =
add to
> backport these to stable kernel.
>
> That said, this is defenitely no fix, as it's only a code clean-up. No wa=
rning,
> no bug, no functional error fixed here :)
>
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> > ---
> > Fix MTK color correction binding
> >
> > The fallback compatible has been duplicated in the 137272ef1b0f commit.
> >
> > To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > To: Philipp Zabel <p.zabel@pengutronix.de>
> > To: David Airlie <airlied@gmail.com>
> > To: Daniel Vetter <daniel@ffwll.ch>
> > To: Rob Herring <robh+dt@kernel.org>
> > To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > To: Matthias Brugger <matthias.bgg@gmail.com>
> > To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com=
>
> > To: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > ---
> > Changes in v2:
> > - Fix commit title.
> > - Link to v1: https://lore.kernel.org/r/20230306-ccorr-binding-fix-v1-0=
-177d81d60c69@baylibre.com
> > ---
> >   Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yam=
l | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediate=
k,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,=
ccorr.yaml
> > index b04820c95b22..3aaf44719786 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr=
.yaml
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr=
.yaml
> > @@ -29,9 +29,6 @@ properties:
> >             - enum:
> >                 - mediatek,mt8188-disp-ccorr
> >                 - mediatek,mt8195-disp-ccorr
> > -          - const: mediatek,mt8192-disp-ccorr
> > -      - items:
> > -          - enum:
> >                 - mediatek,mt8186-disp-ccorr
>
> Please sort compatibles, that will allow for easier reading once we add m=
ore to
> the file.
>
> Regards,
> Matthias
>
> >             - const: mediatek,mt8192-disp-ccorr
> >
> >
> > ---
> > base-commit: add072536971d7ce891fde3cdbf68c55e7cfa95a
> > change-id: 20230306-ccorr-binding-fix-718c6d725088
> >
> > Best regards,
