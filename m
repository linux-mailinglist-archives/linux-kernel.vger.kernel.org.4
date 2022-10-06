Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722A35F5EAE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 04:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJFCTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 22:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJFCS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:18:57 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDA76B646;
        Wed,  5 Oct 2022 19:18:54 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so506266oop.9;
        Wed, 05 Oct 2022 19:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFOpkqjZufkAK5FiEiN5bkXOo99mfhA/7lKBcTpwlOc=;
        b=q4VMKB9p2V8G9l+fgaF19vNq4UggxbJM6jYTCCkw5cGPvYC8jMph0hATiHKRzNT+q5
         qhFLe+oWJP9ZYs0l6sgMb9GHfx4TMkHNqLYJyKgAUJWVyF4TE5w6rRB8PVf3JOKSg09s
         mXumGsNRPNYU/R7oL0VRskCLgDF+iliJhUG4BB39qHayzt9egalBOF3V+YlgkxA2sJD1
         AhhQC66I6YBBip4AcDQzbxS5Ojn8oBXcWB9VOXfMc1/gWJB3mRozfo9FSW9QVa7a+7Ez
         ZxhJgJbp5Sly3KJo2vSoX8bym2QXgNXSf+6fRQx/i/qApVhoPWBONpy7a7NHLfK6mdRK
         bwbg==
X-Gm-Message-State: ACrzQf0IaOq8xQtmqlYmeYnbxC7PWjcZvZ9N1U2LFp86LaZl8Z5eVkDy
        4HLs+XhsYgdfab5IrYqp7Q==
X-Google-Smtp-Source: AMsMyM5K45MEbTKQlz/Q1cezYVFkM+sEQu9vC1IWWlda1XBr7rmBeSLUr2PlRAmZl67PFm7x9o9TeA==
X-Received: by 2002:a9d:6c13:0:b0:660:e595:c723 with SMTP id f19-20020a9d6c13000000b00660e595c723mr1015983otq.2.1665022733713;
        Wed, 05 Oct 2022 19:18:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e19-20020a4ad253000000b0044df311eee1sm3930650oos.33.2022.10.05.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 19:18:53 -0700 (PDT)
Received: (nullmailer pid 565678 invoked by uid 1000);
        Thu, 06 Oct 2022 02:18:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221005174343.24240-6-y.oudjana@protonmail.com>
References: <20221005174343.24240-1-y.oudjana@protonmail.com> <20221005174343.24240-6-y.oudjana@protonmail.com>
Message-Id: <166502256683.562283.5162543675574392467.robh@kernel.org>
Subject: Re: [PATCH v2 05/10] dt-bindings: pinctrl: mediatek,pinctrl-mt6795: Fix interrupt count
Date:   Wed, 05 Oct 2022 21:18:50 -0500
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

On Wed, 05 Oct 2022 20:43:38 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> The document currently states a maximum of 1 interrupt, but the DT
> has 2 specified causing a dtbs_check error. Change the limit to 2
> to pass the check and add a minimum limit.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml   | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.example.dtb: pinctrl@10005000: interrupts: [[0, 153, 4]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

