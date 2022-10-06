Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC95F6E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiJFTaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiJFT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:29:59 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E72CDE8;
        Thu,  6 Oct 2022 12:29:57 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-131ea99262dso3335005fac.9;
        Thu, 06 Oct 2022 12:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySIVfsaxNA1ijAI7bATHRfKRS7AcLI7DST7iNvCc2ro=;
        b=6WAkoBbyxj1zlTJCBxNdjgCJUyvcm3v6WZokS4X1B2yXH+ESQxBt+lOS8xQoVvtZrI
         dEQmLKlRXp4Te776ooL8pk+XDtMZbzFVCsmis2qaIAVinn0vEP1Vmm/Mry6Ie3D4HVCL
         3ekTnj5VU3JdIgcvIEfJi6gVwgyXf/q1NbnR/vloSq3y2bIREOBOwE17cL9i9t50vZqZ
         IfjJN1UJ48wpbWRQognXFTvmtNlUtVi8i2ua2USzsbpjw++6AMwc3CKKlAuu7tMStxIV
         rlpA3QB4C0YdVdIxxGL/QJdP1kOhSuOH66PT93eUW2MLz/LxDw0serrSVMSTO0YV/BuS
         t1uA==
X-Gm-Message-State: ACrzQf0ZmsIppFtUNxUhR2cn8s3FHTcxxKp5ehf9b2gdyTFRSc2pP20K
        +dnGGR5rpO2rzMS2/5mBBg==
X-Google-Smtp-Source: AMsMyM4/iv7myuy0Nn8kCe3Et5vu7Cu1CfGYnJEilG1xPRLoHrvgqYBZoN4qRCc43LPwkI6oA1Oltg==
X-Received: by 2002:a05:6870:b422:b0:131:d458:2d21 with SMTP id x34-20020a056870b42200b00131d4582d21mr756756oap.24.1665084596364;
        Thu, 06 Oct 2022 12:29:56 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id q65-20020acac044000000b00342fc99c5cbsm6147248oif.54.2022.10.06.12.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:29:55 -0700 (PDT)
Received: (nullmailer pid 58541 invoked by uid 1000);
        Thu, 06 Oct 2022 19:29:53 -0000
Date:   Thu, 6 Oct 2022 14:29:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Teng <andy.teng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 08/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Document MT6765 pin controller
Message-ID: <166508455748.57937.1260917394101293139.robh@kernel.org>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
 <20221005174343.24240-9-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005174343.24240-9-y.oudjana@protonmail.com>
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

On Wed, 05 Oct 2022 20:43:41 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> The MT6765 pin controller has had a driver for a while, but DT
> bindings were never documented for it.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
