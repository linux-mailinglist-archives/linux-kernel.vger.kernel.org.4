Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ABA5FF279
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJNQql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJNQqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:46:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F28211E46B;
        Fri, 14 Oct 2022 09:46:38 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s196so3476707pgs.3;
        Fri, 14 Oct 2022 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lz9w4iTtt8VD0pnGuSpcxv01lLWgKdls9jQI3u/cJVU=;
        b=YQRZg7ylX38gOy7LKdvCrTSm9oFdeFDGd0Xij4RxwzL0ecgSKg40kNAmatIs5yfwZV
         nXbrs3sM02YGmZ6jHV+/15BP98e45vDRYl/sM+3MLvYjhmFlJA6pOKaZFrh7j+8beANm
         yHnwlj0XohANnG2Lb1Rxxou9IHa/nzJtN6LlbN1gSOipa+scrRhw920tiwlsDlleqIN5
         vwZGuWjjpHgLS9DZ70Nmm/4czGT2KCJCSW/3pskeC5P55uAD+e2cfgLuCLAQwZu6oj7F
         RBiJdfRzwFRauSB52rp37qhnppNpTcnPWxBeCTjxD2c37bY0rT2f+b/FPdHb3L/f1rw0
         nTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz9w4iTtt8VD0pnGuSpcxv01lLWgKdls9jQI3u/cJVU=;
        b=kYLgYG2JbQFCUaLLHantBmGt2DAyXvMydQ+VpLJYKBPdnwqEtVPS1NHUZGvEoCNOl6
         tT6G4i2hfsOU4SkU/8E4b/7O78Lzka5WCAqALdPP95TsH11buMOfctB5aYfd0y/TKPf6
         BkNw9BWs2LDxNipj78lYqkW5RDmAegxrWyJwpNk9piEabABBgM1C+XkhHJUyM8yQjzr/
         YEyZRuquGy7yzMw/hQfy/kLoxScbew9uS40T5H64RgJaEGeWJUqdc3krknpCYi28W2Qs
         Diq7z/mxpxu7NVOVGrfSZx5N6n7op1S+OHb/O45nrsIB4G3tduNc3yCgCR01XD6ktSFP
         zqGQ==
X-Gm-Message-State: ACrzQf3vyYWdUwiLim1d/xYRckaYM6CNzTF8XZhmRnUmz6SFpwZ1G0Ra
        drUR/TjCR/ZP66epbAAVGg8=
X-Google-Smtp-Source: AMsMyM6QVHntIHzZcjcTu7mS9KR6yMVgRd9YU9txRkHoQcGcebgSfqyGhkXCfRnTkqBoEAjG+nZdIA==
X-Received: by 2002:a63:1917:0:b0:43c:1471:52b7 with SMTP id z23-20020a631917000000b0043c147152b7mr5295980pgl.522.1665765998174;
        Fri, 14 Oct 2022 09:46:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b0017f7b6e970esm1976920plg.146.2022.10.14.09.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 09:46:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 14 Oct 2022 09:46:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        allen-kh.cheng@mediatek.com, seiya.wang@mediatek.com,
        tinghan.shen@mediatek.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT6795
Message-ID: <20221014164637.GA150807@roeck-us.net>
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
 <20221005113517.70628-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005113517.70628-5-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 01:35:16PM +0200, AngeloGioacchino Del Regno wrote:
> Add the mediatek,mt6795-wdt compatible.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index f43b5af92d40..54dfe7941d53 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -23,6 +23,7 @@ properties:
>            - enum:
>                - mediatek,mt2712-wdt
>                - mediatek,mt6589-wdt
> +              - mediatek,mt6795-wdt
>                - mediatek,mt7986-wdt
>                - mediatek,mt8183-wdt
>                - mediatek,mt8186-wdt
