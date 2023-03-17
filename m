Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E1F6BF150
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCQTAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCQTAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:00:14 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADCA4615A;
        Fri, 17 Mar 2023 11:59:54 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id j6so3238776ilr.7;
        Fri, 17 Mar 2023 11:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANZh5FVCjvF16sd3G9zxyt5eWxexgG6oO1Kf4AezwW8=;
        b=yEp5I/s3mJ/ABcThYSdlC3ia5ZphpBIjQr8cSzv/qv2mlSsHvOWCrB+/MdvRREYIyl
         uqQPYCiSGD4hrxUIbAufOuSuYgiHNAj9q55EAgAic5Kb2m0SPaOKrIoLbx4i576E7rrY
         qjhPlxsdkLY9mtWxIHqi3dxQHN9CjtWx4JbuwnJ78aB8gBaP0oZxGrtQKTk+kAjUURYn
         CTAaj4K+buAraUtJrldg11qczv5Brz0qQFbIOtBu0b7eL52jVLvfOLsW2TBpUuRCvhfW
         tZLeWwJ8LPE8fDiuxaCDFyKDVuBKR3ZVJw9E/Q97B4yvNt1T6nSA/WKuU0mYUM13KbA0
         pC2w==
X-Gm-Message-State: AO0yUKWTlA91FkVC4LmnFY/i/4wstc5ho7PC538McuQgY2mAndME3HHi
        7ciPFWlRwx31c5g2xJHAgA==
X-Google-Smtp-Source: AK7set+aXnqkmCfAm3za+DE70LQRrIMDKlnshGxxrmIx09sohdWzXMIhjJ/t8AMPq6Da0l/bE+DU3A==
X-Received: by 2002:a92:2a05:0:b0:315:6e7f:f429 with SMTP id r5-20020a922a05000000b003156e7ff429mr290232ile.9.1679079576949;
        Fri, 17 Mar 2023 11:59:36 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id d26-20020a02605a000000b004038a45ad89sm901332jaf.85.2023.03.17.11.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 11:59:36 -0700 (PDT)
Received: (nullmailer pid 2626268 invoked by uid 1000);
        Fri, 17 Mar 2023 18:59:34 -0000
Date:   Fri, 17 Mar 2023 13:59:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Landen Chao <Landen.Chao@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Teng <andy.teng@mediatek.com>, erkin.bozoglu@xeront.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        Hui Liu <hui.liu@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        DENG Qingfang <dqfext@gmail.com>
Subject: Re: [PATCH v2 17/21] dt-bindings: pinctrl: mediatek: drop quotes
 from referred schemas
Message-ID: <167907957429.2626207.6635066229575871567.robh@kernel.org>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
 <20230313205921.35342-18-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313205921.35342-18-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 23:59:17 +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Drop the quotes from the referred schemas.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml           | 4 ++--
>  .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml           | 4 ++--
>  .../bindings/pinctrl/mediatek,mt6795-pinctrl.yaml           | 4 ++--
>  .../bindings/pinctrl/mediatek,mt7622-pinctrl.yaml           | 6 +++---
>  .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml           | 6 +++---
>  .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml           | 4 ++--
>  .../bindings/pinctrl/mediatek,mt8186-pinctrl.yaml           | 2 +-
>  .../bindings/pinctrl/mediatek,mt8188-pinctrl.yaml           | 2 +-
>  .../bindings/pinctrl/mediatek,mt8192-pinctrl.yaml           | 4 ++--
>  .../bindings/pinctrl/mediatek,mt8195-pinctrl.yaml           | 4 ++--
>  10 files changed, 20 insertions(+), 20 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

