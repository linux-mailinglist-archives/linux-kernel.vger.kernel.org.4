Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10463611A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJ1TEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJ1TEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:04:43 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4687212772;
        Fri, 28 Oct 2022 12:04:41 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id t10so7098857oib.5;
        Fri, 28 Oct 2022 12:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuXR+AMIaexq1rNS0igofnWkpIe+w6Cyd+LJdGYf1aE=;
        b=3tXk/WFUFHs2MpxOFOzbOR94hk0rNj8HdNAjhIKRfN5eSmFmIG1qStqQ1bl0Frj3rM
         bKeaV3lkVZdmIZSU2dgxdlHcXKzMrISonrSfkup8y5Kc3DJ0VaNQA1R5nuOMhvcqqIjJ
         rMNxRVrAhXLXIwjTy+CdFTsS+8HO6oy+w759WNOBQ2EofvLL7IkNLWYAY+MpshG/zj3g
         XpENJvWHiGte+AR9WtPjnd66vP6ZqmAlm4Jd807T0kQp2lgwJB3iQe3YqgNg2DHFTulu
         qRHb29nLlBcmEzVwiNWh3JFq7+nX1TFKrQBT+0oukYLhutNl7zbp2s/AX5uV63T/W/Bu
         VzrA==
X-Gm-Message-State: ACrzQf2Vd8MEX/7pYnMdIAFVEopuxGb/hRhcbKOPDQO+9X6eYF8NoKn4
        CFpfMOnmzyXilfyT1x56jL+SlNMUyw==
X-Google-Smtp-Source: AMsMyM7A9oX8dlbTLmm8qWnrYjEsJijL0O5QjYpX6UoNvlc4jXnM+R7TBFa3nuLjwYYAuT3jvsADMw==
X-Received: by 2002:a05:6808:1486:b0:355:3cb7:b51 with SMTP id e6-20020a056808148600b003553cb70b51mr490281oiw.19.1666983878062;
        Fri, 28 Oct 2022 12:04:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w17-20020a056830111100b00661abb66319sm1973125otq.37.2022.10.28.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:04:37 -0700 (PDT)
Received: (nullmailer pid 2098124 invoked by uid 1000);
        Fri, 28 Oct 2022 19:04:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Andy Teng <andy.teng@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20221028153505.23741-8-y.oudjana@protonmail.com>
References: <20221028153505.23741-1-y.oudjana@protonmail.com> <20221028153505.23741-8-y.oudjana@protonmail.com>
Message-Id: <166698381170.2093641.13406532790494149895.robh@kernel.org>
Subject: Re: [PATCH v4 07/13] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Pull pinctrl node changes from MT6795 document
Date:   Fri, 28 Oct 2022 14:04:38 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 18:34:59 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> mediatek,pinctrl-mt6795.yaml has different node name patterns which match
> bindings of other MediaTek pin controllers, ref for pinmux-node.yaml which
> has a description of the pinmux property, as well as some additional
> descriptions for some pin configuration properties. Pull those changes
> into mediatek,mt6779-pinctrl.yaml in preparation to combine the MT6795
> document into it.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 30 +++++++++++++++----
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dtb: pinctrl@10005000: 'mmc0-0' does not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

