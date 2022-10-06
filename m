Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ABF5F6E17
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiJFTTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiJFTSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:18:45 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C83DC1DA0;
        Thu,  6 Oct 2022 12:18:45 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id s192so3141874oie.3;
        Thu, 06 Oct 2022 12:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQkts9CNxdGnPqsZmG5kji7cxN91mZuegt3zYk6RMWA=;
        b=AmOq/VJHEJW+BB0VSeks3aSvTHhFpN8U+CiUbwOvd81L0J8A6Fcj+6H5UhjJFB40Ft
         xy8uDlP0hCyBll+IV04T2AeBLSJsJ5dv4P5fEkfJyr1tTWAc/JpnMxolW/38YWZM09mC
         IILqWqYMi2zyyjqg9NoCup5clNLS30AGU9UtLD3/mTGCvxkd6spaGfxAmjy5rBN07DEM
         rOc5mZF6V7se5v6jgZgNs3OXk/0hwsUaaHBBwakJfK0chXJy8GOMtU4Y95mJdGwrnl4L
         VqAS/wPt/heWRxHbprmo2F0/PDsCHSV1ZFCEEBCD0JYBcLFu4oCtyfak+Yk+1Knr/HuS
         b40w==
X-Gm-Message-State: ACrzQf36P/nyfxcVr9O3mIPreb6PzCHA1rNZj2vqyyvCA3MF6LtD2sNv
        8noJm8UZXQr30ZtBRmwQpg==
X-Google-Smtp-Source: AMsMyM6ypf9p+1I9VTj+vf0h/kRsTUojNGHIiIUFRRCgojLkuZMfvn0DQT8twZAsW2xqs7Tp2rzWZQ==
X-Received: by 2002:a05:6808:1281:b0:350:7aad:9f4c with SMTP id a1-20020a056808128100b003507aad9f4cmr595892oiw.21.1665083924329;
        Thu, 06 Oct 2022 12:18:44 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id r41-20020a05687017a900b00132f141ef2dsm179838oae.56.2022.10.06.12.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:18:43 -0700 (PDT)
Received: (nullmailer pid 49467 invoked by uid 1000);
        Thu, 06 Oct 2022 19:18:42 -0000
Date:   Thu, 6 Oct 2022 14:18:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, Andy Teng <andy.teng@mediatek.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Add MT6797
Message-ID: <166508392222.49416.1999405507084139523.robh@kernel.org>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
 <20221005174343.24240-5-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005174343.24240-5-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2022 20:43:37 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Combine MT6797 pin controller document into MT6779 one. reg and
> reg-names property constraints are set using conditionals.
> A conditional is also used to make interrupt-related properties
> required on the MT6779 pin controller only, since the MT6797
> controller doesn't support interrupts (or not yet, at least).
> drive-strength and slew-rate properties which weren't described
> in the MT6779 document before are brought in from the MT6797 one.
> Both pin controllers share a common driver core so they should
> both support these properties.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  87 ++++++---
>  .../pinctrl/mediatek,mt6797-pinctrl.yaml      | 176 ------------------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 67 insertions(+), 198 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
