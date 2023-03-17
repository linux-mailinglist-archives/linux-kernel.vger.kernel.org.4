Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB406BF15A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCQTCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCQTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:02:02 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D313E627;
        Fri, 17 Mar 2023 12:01:29 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id f14so2726529iow.5;
        Fri, 17 Mar 2023 12:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hausnTGLlOHjc8Fdut9IKn0OVwp99DQN23/o2T+IGnc=;
        b=koM+8zp4NNKtjpYvZf7uvsbRHY2p0xxvHnA0whEHk6dYlgBkw079CqbcsS9uqcb6SH
         FicCveBYKa3Owgloz/X+2XNeFkZCQx09Vah0/TdqddDYumWPpc91gPEAgGTm1poQ18JL
         HQnCgSsj2o/pydtXA6xo2eHSpjtGgOeEHGE5+pkd2CV6sSigs0/cXvdIq9SvB0uQrOG9
         a/TnaKeYsVWrp6MvfvDbvAf9pxwY+a8JZ8XtKom+fwmOAWpm+ZHQH0lmXHMugn90KJw/
         33TsP37uqfEtjzJiA7QmptftQPzZARA87ns1YFNDj5pKSP4pZG9GeUxwXoa4yhp4xTK6
         AITA==
X-Gm-Message-State: AO0yUKUtF8GDMUnpaDNcE3vwy3gE9jVVdDQVtVyw0Wzv2pAfDr+hOic0
        y4QME35U5rlYMzej5PpN4Q==
X-Google-Smtp-Source: AK7set8U8PM+qrUQSQCk4AmaPkBl+fmPXywWuSb+jlUOH/8ur/NXvspfLHl/XWrcjpTAi2EX8iGqTA==
X-Received: by 2002:a05:6602:3141:b0:74c:9cc4:ac0 with SMTP id m1-20020a056602314100b0074c9cc40ac0mr322616ioy.14.1679079684558;
        Fri, 17 Mar 2023 12:01:24 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id c30-20020a02331e000000b003afc548c3cdsm894444jae.166.2023.03.17.12.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:01:24 -0700 (PDT)
Received: (nullmailer pid 2628580 invoked by uid 1000);
        Fri, 17 Mar 2023 19:01:21 -0000
Date:   Fri, 17 Mar 2023 14:01:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Andy Teng <andy.teng@mediatek.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        William Dean <williamsukatube@gmail.com>,
        erkin.bozoglu@xeront.com, Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-arm-kernel@lists.infradead.org,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-gpio@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>, devicetree@vger.kernel.org,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        DENG Qingfang <dqfext@gmail.com>
Subject: Re: [PATCH v2 18/21] dt-bindings: pinctrl: mediatek: mt7986: fix
 patternProperties regex
Message-ID: <167907968135.2628491.8364762627311552014.robh@kernel.org>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
 <20230313205921.35342-19-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313205921.35342-19-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 23:59:18 +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Set second level patternProperties to '^.*mux.*$' and '^.*conf.*$' on
> mediatek,mt7986-pinctrl.yaml to be on par with other schemas.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

