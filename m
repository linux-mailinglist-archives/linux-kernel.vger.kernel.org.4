Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DB46BF120
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCQSye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQSyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:54:32 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93112CD3;
        Fri, 17 Mar 2023 11:54:24 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id h83so2708618iof.8;
        Fri, 17 Mar 2023 11:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079264;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyLucB1xL+1vc2RV0T+QNi7TBtYGDGWJEgpm3w+KqpU=;
        b=5CZCBZIYq7cKqePWfoJkuY18A9SgyLRZ1Jv/omv594o3OloiArUjP0nQTFloUImEj3
         FJ5IGsIlveZ9BBLaj5h4DicosgmSAZlOEut8JEnVmQkWgobrjHZnMHfsjAWmEZhhgQel
         f7KWpkcpzW7/xzk2/yYglTMTxWc/VGdqU1Lf0xF2QXIeGL6sqZsRxbXtjZkmEwMUysb9
         l+r2wQTc5h1W3gFMxvlg5EMokwjJXfIOweezAEQZoVN2uAnByGjkyb1V4FqnTLeZ1BKC
         qCG6IF13LzZZYMo+voIPoLk8i4X2NFIUS/yTwpHFYlHrdlwqx3v3ks6kEQhze36glCsS
         URsQ==
X-Gm-Message-State: AO0yUKWxSxsYeZy1gclkiV76rVxN+uvqZUzkyWBfkAnCNe9vN9+0HaGL
        U4Gub39NZ1PzkLHaSsc8uQ==
X-Google-Smtp-Source: AK7set+wcpKW5FmDTI0cZ5Jkv0NRz0W+MCzCQm+ULGDgyswQddsNZTLzEMsj6SEX3DmzVA0ilsBmPg==
X-Received: by 2002:a5e:d80f:0:b0:752:ef43:8da with SMTP id l15-20020a5ed80f000000b00752ef4308damr334756iok.10.1679079263829;
        Fri, 17 Mar 2023 11:54:23 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id c94-20020a029667000000b0040494ffed75sm899447jai.33.2023.03.17.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 11:54:23 -0700 (PDT)
Received: (nullmailer pid 2618778 invoked by uid 1000);
        Fri, 17 Mar 2023 18:54:21 -0000
Date:   Fri, 17 Mar 2023 13:54:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        erkin.bozoglu@xeront.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Sean Wang <sean.wang@kernel.org>, linux-gpio@vger.kernel.org,
        Andy Teng <andy.teng@mediatek.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        linux-mips@vger.kernel.org,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 07/21] dt-bindings: pinctrl: ralink: drop quotes from
 referred schemas
Message-ID: <167907925996.2618688.10329209180959235548.robh@kernel.org>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
 <20230313205921.35342-8-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313205921.35342-8-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 23:59:07 +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Drop the quotes from the referred schemas.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml      | 2 +-
>  .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml      | 2 +-
>  .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml      | 2 +-
>  .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml      | 2 +-
>  .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml      | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

