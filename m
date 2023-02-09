Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6F9690412
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBIJpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBIJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:45:36 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF762782
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:45:34 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id y8so1565603vsq.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kXhHlY1h7nocfeF1bOOwlqa9GLmp058pSwMc5Nw8eCs=;
        b=AVQtBu6a+GAA0YuBWAkZuoZ1RiMhYbu91H+uxx6jbo4OyTg1oInL7ybjONKCA9fYgV
         tXH2621Wu1HMYvV00UxmOK9/0ti5yO/2O700FMrMeyTsHiUghbsmknayRo6UceHPmf2F
         MS4KjYawZ5imA3BDzv/iFFibjSN2z+XaxLaXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXhHlY1h7nocfeF1bOOwlqa9GLmp058pSwMc5Nw8eCs=;
        b=XMYim2DAu8PvzkQZp7qXsd/Li7bxXpaYCLdDB7U48HzsNvzb+yW2ti9BqjLdRuZ3XX
         kkLltuOd3Q7LxLnJjyumZYjN7TxTVUWm/V6SNATvqg9by7IKX0/py/sXcSppXrddC72r
         w97x0qgMupK8JpVJNzDCV9nPpWHgkKe4+Qecy6XY+Vk88wCvzgQH9SpwQIXvjynSBr+d
         iblYs++p8NpLnR/GWSZi9nC13cjYIRKeRA+u1G2FbN9HydDZK1zFENJsDKtG40DJc+xn
         uRqhQmnAUfwyCryzi6+HdvQAe2hyliszch9G9vRp1hJ/wdGq9V8AqS9FO1Z6ZetYCbUk
         AhZg==
X-Gm-Message-State: AO0yUKUZWLZBv/4apJfMwbM5Uouw0FpDjETuvQJ7FzFeZVJn/IoR6DYm
        kzc7kVzT2eePEDJfLn9QWyaeRaZSXvNkJHbHfkCw8A==
X-Google-Smtp-Source: AK7set9hqvzMQiDk15uKKV/k2E6K/8sc6RF0LbaAJ63u86p8XV6MRsIUixqUkVvQiR03JwtLvsvHt9Z3UruyeBFDCFU=
X-Received: by 2002:a67:1904:0:b0:3e8:d5a8:3fbe with SMTP id
 4-20020a671904000000b003e8d5a83fbemr2433227vsz.9.1675935933578; Thu, 09 Feb
 2023 01:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
 <20230208103709.116896-6-angelogioacchino.delregno@collabora.com>
 <CAGXv+5FZqrGzzG8FrmLVzMd7=a23ZJPYGSy5yhYWgH+BFHNmxw@mail.gmail.com> <7784f5a2-3cfc-9999-0ad6-cb9cfc1f2822@collabora.com>
In-Reply-To: <7784f5a2-3cfc-9999-0ad6-cb9cfc1f2822@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 9 Feb 2023 17:45:22 +0800
Message-ID: <CAGXv+5EhDGuzoBA9ZV2=3PVZ209eFq+wOOcTGVvG+gmOnf5txQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: gpu: mali-bifrost: Add a compatible for
 MediaTek MT8186
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, tomeu.vizoso@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, steven.price@arm.com,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
        alyssa.rosenzweig@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        Fei Shao <fshao@chromium.org>, Nick Fan <Nick.Fan@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 5:20 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 09/02/23 09:49, Chen-Yu Tsai ha scritto:
> > On Wed, Feb 8, 2023 at 6:37 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Get GPU support on MT8186 by adding its compatible.
> >
> > I'd skip MT8186 for now. We have to work out some binning details for the
> > OPP, in particular how to deal with both Panfrost (or Mali) and SVS adding
> > the OPP table. We were just looking at the Mali driver today.
> >
>
> Dealing with binning is fairly easy... I have something already done for
> that one, but I'm not sure that it would be the best option.
> My solution makes use of opp-supported-hw by "standard means", but perhaps
> let's have a separated conversation about it?
>
> I don't think that skipping this would give any benefit though, because
> that is only adding a compatible and whatever binning support would have
> to be generic and 99% not bound to any mediatek specific compatible.

The binning is related to voltage range, not maximum OPP. So it's more
like fast/slow example in Documentation/devicetree/bindings/opp/opp-v2.yaml
or the opp/allwinner,sun50i-h6-operating-points.yaml, minus the efuse node.

The downstream DT currently looks like this:

opp-950000000 {
        opp-hz = /bits/ 64 <950000000>;

/* This is Mali specific; ignore
        opp-hz-real = /bits/ 64 <950000000>,
                      /bits/ 64 <950000000>;
*/
        opp-microvolt = <900000>, <1000000>;
        opp-microvolt-bin4 = <875000>, <975000>;
        opp-microvolt-bin5 = <850000>, <950000>;
};


ChenYu
