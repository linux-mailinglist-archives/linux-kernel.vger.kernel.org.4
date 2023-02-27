Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575606A49A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjB0SYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjB0SYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:24:37 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA9F2529A;
        Mon, 27 Feb 2023 10:24:12 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso4090748ota.1;
        Mon, 27 Feb 2023 10:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhnGImxv7cGC3B2casLCXu7ICg34WHUc91lJ659LFQM=;
        b=OzLArPWraK5rwEf48vrWxEIpzuIJUoC3fE9ACQ3f7U910kgP0nuOQ7FyBuMuP5C/JQ
         MqQAj0X8lwnsF+F5QcWNNyZOHAxbeO+ySc1+3yFsrKen3ok+nIeFsbnZ3d9GKoQURZ9k
         BpJFPeRw/kHh5v7ijboedgY484HmJVfbonCVSQLPxfScq63vltadIZI4mK03q8frlm1V
         zmhR8qxGvmT0ddKBVwdNcmpQo8pHf22PPC/SFl1uD305mAA2Aw9DYqsm8WwPzSYYgcGX
         vANov9FWmwpfMm7xAXh6hpR/3aT1+CLslkohsQtIhUZzbMoWw3b5ody0RlamajZYxfco
         i8NQ==
X-Gm-Message-State: AO0yUKU+LTq6zlqc4C4AZz+N8foQcBRwODX284rbvzSRM7L4MlrxT9lH
        Ei1ZJqeQ4oNJMGH8jJmg+Dny1pVbUg==
X-Google-Smtp-Source: AK7set/GbJ8fGfciQoa6HmnxTEXgUSxJ3CGER8Umk+DoFZ/iiDwdsjaBin8Np3hXBmvf2jLJ6sh7qA==
X-Received: by 2002:a05:6830:4412:b0:68d:3fc8:7c07 with SMTP id q18-20020a056830441200b0068d3fc87c07mr5220636otv.2.1677522252115;
        Mon, 27 Feb 2023 10:24:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w11-20020a9d70cb000000b0068bb3a9e2b9sm2809887otj.77.2023.02.27.10.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:24:11 -0800 (PST)
Received: (nullmailer pid 602994 invoked by uid 1000);
        Mon, 27 Feb 2023 18:24:10 -0000
Date:   Mon, 27 Feb 2023 12:24:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Daniel Santos <daniel.santos@pobox.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        erkin.bozoglu@xeront.com, Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-mips@vger.kernel.org, Landen Chao <Landen.Chao@mediatek.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [RFC PATCH 14/16] dt-bindings: pinctrl: mediatek: mt8192: rename
 to mediatek,mt8192-pinctrl
Message-ID: <167752224966.602691.10587841319375401284.robh@kernel.org>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
 <20230222183932.33267-15-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230222183932.33267-15-arinc.unal@arinc9.com>
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


On Wed, 22 Feb 2023 21:39:30 +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Rename pinctrl-mt8192.yaml to mediatek,mt8192-pinctrl.yaml to be on par
> with the compatible string and other mediatek dt-binding schemas.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../{pinctrl-mt8192.yaml => mediatek,mt8192-pinctrl.yaml}       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/pinctrl/{pinctrl-mt8192.yaml => mediatek,mt8192-pinctrl.yaml} (98%)
> 

Acked-by: Rob Herring <robh@kernel.org>

