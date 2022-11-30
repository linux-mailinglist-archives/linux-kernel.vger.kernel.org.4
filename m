Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1052063D943
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiK3PWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiK3PWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:22:44 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4325F1DA5E;
        Wed, 30 Nov 2022 07:22:42 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so11419429otb.1;
        Wed, 30 Nov 2022 07:22:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPaJ5QKuqa6JT5D+gY9tfaRaUFIibFo858rAr7vgvks=;
        b=uw700WLkWANAVMvAxnKdPzGYlw/mEipvoGxgOwsst9wY8I2yQo4rmxVYu4FCXPKVI+
         6nJVFJjYKSn9zFdA/IM2eRmgVCAOW640FmIM7Y0ofu6f3Jd0tXhOUp1bA6kgXnd8GTMt
         Zp0nl/VsPuChHjQQQizDoo4K4aNXmR9GYLYxF4KGplZSTsZm7+EKAJKmgMZqWmhMzdsA
         0rwVv5r2auBSFwRgN5dbGsTw4+qwte4XKWecPS1EhBuWvz6czsnq4lq0TqRq0fWJcrn7
         NmCvf57S10VE0zmbSqPMzk1TWYI5m2rAgGNw5SidUXvRVGB5qb6CRqJSttzYFLo3FX1d
         a/OQ==
X-Gm-Message-State: ANoB5plF2SuwkUbhYXgb8cFYPzKH0iffPUJNhtymqI53xXKPnbYuhP7x
        LBQse6e/Vi8dBslHOtUX5scyOYVzjQ==
X-Google-Smtp-Source: AA0mqf7dVbk+/jtsj/44vjUhHrvULs52JnWmrmOJCkOc/Gmn2xkA8Fwx/65Db1wL3k47Y4ManV1BRA==
X-Received: by 2002:a05:6830:1c7:b0:663:d3ce:ca26 with SMTP id r7-20020a05683001c700b00663d3ceca26mr21656129ota.67.1669821761469;
        Wed, 30 Nov 2022 07:22:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p186-20020aca5bc3000000b00359a9663053sm748103oib.4.2022.11.30.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:22:41 -0800 (PST)
Received: (nullmailer pid 2190680 invoked by uid 1000);
        Wed, 30 Nov 2022 15:22:40 -0000
Date:   Wed, 30 Nov 2022 09:22:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-gpio@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Teng <andy.teng@mediatek.com>, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 3/7] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Add MT6795
Message-ID: <166982175979.2190622.1334007053392502335.robh@kernel.org>
References: <20221118113028.145348-1-y.oudjana@protonmail.com>
 <20221118113028.145348-4-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118113028.145348-4-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Nov 2022 14:30:24 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Combine MT6795 pin controller document into MT6779 one. In the
> process, amend the example with comments and additional pinctrl
> nodes from the MT6795 example, replace the current interrupts
> property description with the one from the MT6795 document since
> it makes more sense and define its items using conditionals
> as they now vary between variants. Also use conditionals to define
> valid values for the drive-strength property as well as items of
> the interrupts property for each variant since they are different
> on MT6795.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  78 +++++-
>  .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 227 ------------------
>  2 files changed, 73 insertions(+), 232 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
