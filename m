Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2310A6A49AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjB0SY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjB0SYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:24:55 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F2124C8E;
        Mon, 27 Feb 2023 10:24:25 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id v1-20020a9d6041000000b0068d4a8a8d2dso4053602otj.12;
        Mon, 27 Feb 2023 10:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBRobdlQ8YA7xmWGDg5XN98xb2FG1Y6yDjdmnPMXjHs=;
        b=pLrOWdKcX7YlXHrTnoZ5o0aNIBMDAycs+RCGhFtRUTYu0oDrWihDtErqvWdl9lrQ1P
         eEemMJDWnCfGb58ubnDdrwrpc5KeCY0ZR1yzMsb9z7RCgvE1udwYS354Z/N2OxTE0ZkL
         YBE0WQ2sDLBa/WRUJu5lAZRqJu4FzHYNXadnpUUKmALJ5XfBc+5utaOLCGuJoads+avz
         vHKBCgWx3fywMYMpCiZRNFPG/HZAljpyt7kp4649L5TpYay4qktyyyaCGGmeXqL7YyyG
         DuPDuPL369luKkor8731NYSm1EHUI1dK/Hs1q1U6QPMQrAiuJDbHPrN5fPJKZxC2oWB5
         id+w==
X-Gm-Message-State: AO0yUKXRRvlYazS/rI3rLuEYa4RDbbcX99v8Zuo1W68mT23hGAIvFgSu
        ZmOH6AYpl1HIQDZ612nOGOiERU3jPA==
X-Google-Smtp-Source: AK7set+Ys4nnlOS3/X7NRt+FPf7ir4AayFIQQPwQKAmmm9O8i1Mg3oL2w21eYgZx40eoXJYpxKqXUw==
X-Received: by 2002:a9d:367:0:b0:693:c7e4:dd4b with SMTP id 94-20020a9d0367000000b00693c7e4dd4bmr11433543otv.6.1677522264892;
        Mon, 27 Feb 2023 10:24:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j3-20020a9d1783000000b00690d0daa17esm2880309otj.3.2023.02.27.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:24:24 -0800 (PST)
Received: (nullmailer pid 605232 invoked by uid 1000);
        Mon, 27 Feb 2023 18:24:23 -0000
Date:   Mon, 27 Feb 2023 12:24:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        erkin.bozoglu@xeront.com,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        William Dean <williamsukatube@gmail.com>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [RFC PATCH 15/16] dt-bindings: pinctrl: mediatek: mt8195: rename
 to mediatek,mt8195-pinctrl
Message-ID: <167752226279.605012.9223812860970122515.robh@kernel.org>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
 <20230222183932.33267-16-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230222183932.33267-16-arinc.unal@arinc9.com>
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


On Wed, 22 Feb 2023 21:39:31 +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Rename pinctrl-mt8195.yaml to mediatek,mt8195-pinctrl.yaml to be on par
> with the compatible string and other mediatek dt-binding schemas.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../{pinctrl-mt8195.yaml => mediatek,mt8195-pinctrl.yaml}       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/pinctrl/{pinctrl-mt8195.yaml => mediatek,mt8195-pinctrl.yaml} (99%)
> 

Acked-by: Rob Herring <robh@kernel.org>

