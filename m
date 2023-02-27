Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4816A498A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjB0SW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjB0SW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:22:26 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D531024C8E;
        Mon, 27 Feb 2023 10:22:24 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-172a623ad9aso8275679fac.13;
        Mon, 27 Feb 2023 10:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZb7Mmg4r/Ou83sIwjBpzD29kSEyxiaGz1gGE/U0X0c=;
        b=pnydPoPmMLcaft4FpHTYEZVQyyzJhAibsSpDnxbYpNFkMQGU9Vl++7fstS9PoecYEp
         RTpcElbRyjhWg540Cw/f6UoSU9uSZrXCowIar9I7YEWwp73nOTJI8FbHelaXwSJMEnNx
         d9UIEQ02w+yvBnio7i9Lm/NZMr1u7QsqnDfzb9HQd+wWQ42bvtjg4mGfslzBafWIEzXB
         hMGk31cEcoyoDRxkMYULXBN0o07h4s2AoA06yIArJHn7XyrYpcft5CWaZHMVqGbw3BeI
         hc/N0ziytEnoyS0Fyc97CLTQ2UCaptswaO/0kA92XbxOmJEJG2RLmRL2iHr5acK5hm/R
         YbTg==
X-Gm-Message-State: AO0yUKV+f4zadj+jRB36cBa4buXTVPW1ZuhwvhWWtqk3zoiViogzBs8d
        q/qT7lN+x0ftLo+AGs0R4w==
X-Google-Smtp-Source: AK7set9uOX6VKlcSXFwpXBebth0qSdciLFGEC7y3xDECB+S+bSftgJmahYyBxIo/9OFbzMZ+yuHZNg==
X-Received: by 2002:a05:6870:d688:b0:172:8986:be34 with SMTP id z8-20020a056870d68800b001728986be34mr7284010oap.49.1677522144002;
        Mon, 27 Feb 2023 10:22:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id do11-20020a0568300e0b00b0068bcef4f543sm2885393otb.21.2023.02.27.10.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:22:23 -0800 (PST)
Received: (nullmailer pid 583536 invoked by uid 1000);
        Mon, 27 Feb 2023 18:22:22 -0000
Date:   Mon, 27 Feb 2023 12:22:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Daniel Santos <daniel.santos@pobox.com>,
        DENG Qingfang <dqfext@gmail.com>, devicetree@vger.kernel.org,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        erkin.bozoglu@xeront.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>
Subject: Re: [RFC PATCH 12/16] dt-bindings: pinctrl: mediatek: mt6795: rename
 to mediatek,mt6795-pinctrl
Message-ID: <167752214197.583308.8702991633165881328.robh@kernel.org>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
 <20230222183932.33267-13-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230222183932.33267-13-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Feb 2023 21:39:28 +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Rename mediatek,pinctrl-mt6795.yaml to mediatek,mt6795-pinctrl.yaml to be
> on par with the compatible string and other mediatek dt-binding schemas.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  ...ediatek,pinctrl-mt6795.yaml => mediatek,mt6795-pinctrl.yaml} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/pinctrl/{mediatek,pinctrl-mt6795.yaml => mediatek,mt6795-pinctrl.yaml} (98%)
> 

Acked-by: Rob Herring <robh@kernel.org>

