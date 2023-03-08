Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33456B1388
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCHVFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCHVFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:05:49 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06879AFC5;
        Wed,  8 Mar 2023 13:05:48 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-176d93cd0daso142674fac.4;
        Wed, 08 Mar 2023 13:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678309548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeQp6dKSczEGqXYWcLnOyHbInXrv8V5R99QgTmD64v8=;
        b=DiMQ5JdbLewZrdcDkRy8KCqSIOVWea/yrDqEKNRc81aavB8T/5lMbCUK1RTXJBoOpC
         QrEf4c8Rx83ekWofNfUPIb8OsZuzjE+SwX83+80rhowl1eoDAtfwvQmfiWdmoiav9opL
         +/AgnOZb0nB3ONlLEigA/B6AdtufdrolMbu9zDoxCTK33fu+omZflAn5WVuBvJmbAtxq
         5/11ZVO3R8vMnZNZU8u3EBS60ddD6o6W94CeXlk7/hqHkd6f6e6VDNopSdoMiOX0PTGn
         MCQbr8kDFqS0K3RV/oH6T0RsNH+hQCSi0QGilT2Tz58zc1w1J1TJ+Oc/p+Z+Iw90t+4N
         lrZA==
X-Gm-Message-State: AO0yUKWUQCFBf6Z4bQ4QYP0Hsak40KiGNkwOXSRUgg+3oAyzW2WIWtzW
        lxGHsRO31sHJ1hkTm1rwHA==
X-Google-Smtp-Source: AK7set9dVdsYtXev0xuuroPAn21gVWk1G0tiJ6YTdGRV5oxphr0u0DE/s7Nv9KPM78TWMAoVKrrv0w==
X-Received: by 2002:a05:6870:20e:b0:163:595e:3655 with SMTP id j14-20020a056870020e00b00163595e3655mr11805478oad.12.1678309547895;
        Wed, 08 Mar 2023 13:05:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ds38-20020a0568705b2600b00172ac40356csm6650113oab.50.2023.03.08.13.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:05:47 -0800 (PST)
Received: (nullmailer pid 3802779 invoked by uid 1000);
        Wed, 08 Mar 2023 21:05:46 -0000
Date:   Wed, 8 Mar 2023 15:05:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     DENG Qingfang <dqfext@gmail.com>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        erkin.bozoglu@xeront.com, Linus Walleij <linus.walleij@linaro.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH 14/20] dt-bindings: pinctrl: mediatek: fix naming
 inconsistency
Message-ID: <167830954579.3802526.13749539102063089321.robh@kernel.org>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-15-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303002850.51858-15-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Mar 2023 03:28:43 +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Some schemas include "MediaTek", some "Mediatek". Rename all to "MediaTek"
> to address the naming inconsistency.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml  | 4 ++--
>  .../devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  | 2 +-
>  .../devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml  | 4 ++--
>  .../devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml  | 2 +-
>  .../devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml  | 2 +-
>  .../devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  | 2 +-
>  .../devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml  | 2 +-
>  .../devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml  | 4 ++--
>  .../devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml  | 4 ++--
>  .../devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml  | 4 ++--
>  .../devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  | 2 +-
>  11 files changed, 16 insertions(+), 16 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

