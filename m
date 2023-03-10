Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B826B4AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjCJP1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbjCJP0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:26:54 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C33114ACEB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:15:57 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bo22so5595190pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678461319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1FUSLMud1/EUO2NdxXWv5FFRYsGvYVv9Bj/E6FNg3XM=;
        b=KSYL0HeBee6gC3Ooo5RDvQ/NDo7NPFYFWoexV+6YlpPeBL6uPGEaAhIssTKs8/hOmj
         FEVHYrXZGi8/E6F/NRYAnX4IewU6GMRlWIQwRv/urg11l/hIiEaX4Ao4OMblkslH3T+g
         xtctco4x3tmMfWf15OmHVER+prZt8kcCIpGvAOlTc9cteSgE5YuzbfHtkckPXTqKJ6Ow
         VnezORrkqdvYUpUqdLCt5jFhQQOE0vOl3hALjZlWpMR2RnVm0WIBN0/oFOylw1QTGxWV
         diKo5pC9r3aWeEY9FQw/EKIxzy1GWafAFOAJi3rLsbPd/L3h1qk388sZHtIPBfR4A0z4
         dDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678461319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FUSLMud1/EUO2NdxXWv5FFRYsGvYVv9Bj/E6FNg3XM=;
        b=3Y4ChGw+fSLMM8s0QWxE4JT86NbjoHiLGQpaFrOzAXL3IdSABrHItLAKm+Pg9tQFrq
         1Y6ceG3iTDnfHVmc09iwGeqk6ZDm8nnLhAF1+h1g269J5YaaG3ZLNzWkOt8XUe5Ty4Ox
         gYyHA/7+6slN1/Tg3k7koskUKuiA9Y6mtDhHGfAwNBHd5V+PYY2UTLpbVt2PjPnmZt3t
         ibOWfkegh9hxR8J6UwVQddkKBX1cdouWoX967BrIPLj74n74ICje5g1CCtwEs39btdM3
         Am5axZimuv77KtzhqlbQK4Ejz3/j8JdETPWU/7vYQrTU09LJdqVd/Rb8lju//mJRoMHn
         8ciQ==
X-Gm-Message-State: AO0yUKX1PdWo9H59x8JYYySK7cprczkcYqnIpd3nK0ETVNi5bK6WwO3t
        /nQDgqarKMyMYLrzXCBBbr+EJ4BdISTZYZ+dkB3X6g==
X-Google-Smtp-Source: AK7set8Y8SU2ADi3YJHj/fTmISh50U8e7aW35JZfQM4zz8PalMuTuLly1fUEosqA7lI1e3N8DnOnGTzVYF7XqEfZhTI=
X-Received: by 2002:a17:90b:1283:b0:234:925b:7d61 with SMTP id
 fw3-20020a17090b128300b00234925b7d61mr9645464pjb.9.1678461319609; Fri, 10 Mar
 2023 07:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20230203-evk-board-support-v2-0-6ec7cdb10ccf@baylibre.com> <20230203-evk-board-support-v2-2-6ec7cdb10ccf@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v2-2-6ec7cdb10ccf@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Mar 2023 16:14:43 +0100
Message-ID: <CAPDyKFp-2H_7G4bOjYHpXBHe2=8VTEwF3w6HmrPsOwKaZ+auiA@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] dt-bindings: mmc: mediatek,mtk-sd: add mt8365
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, Alexandre Bailon <abailon@baylibre.com>,
        devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 at 14:18, Alexandre Mergnat <amergnat@baylibre.com> wrote:
>
> Add binding description for mediatek,mt8365-mmc
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 7a649ebc688c..46eefdd19a2c 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -34,6 +34,7 @@ properties:
>                - mediatek,mt8188-mmc
>                - mediatek,mt8192-mmc
>                - mediatek,mt8195-mmc
> +              - mediatek,mt8365-mmc
>            - const: mediatek,mt8183-mmc
>
>    reg:
>
> --
> b4 0.10.1
