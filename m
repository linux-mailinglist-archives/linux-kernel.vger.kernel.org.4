Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AB461DB3A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKEOwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEOwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:52:18 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A60FAF8;
        Sat,  5 Nov 2022 07:52:16 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-13bef14ea06so8454995fac.3;
        Sat, 05 Nov 2022 07:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PcwwgX98pioZqmpF7IpPJDYkENxYcijXYjHPqyIhZNk=;
        b=nr64UzSq6N9gHeBgs0HzkwVtYzRdu53HgbULVNodQ7xJkKeS+yS/KlzNAxZSpEcavl
         1oL26fkfI0ySRiJPs7tJAHcxfeQxoW7dwIsL55ijDwZsTTd1I0ekqDXfC+n+S3gFl/F1
         HOKn7SHouALr72EVLKeMj7Eyuoim9P1ua96TGeN7JUyN2EZvZR9Qe1EvOvC6INpHLgYI
         WJM6Gmc6Fhlw7LvRIpx2m4yugSKXJ8yuiywektZs2ScGM6QVWKZvauEY64atEhgUOP7n
         lftmTr8VVI4kDNf7tWso1//vMx6VkT6lJhwrXn9yVWOa0W+oUt5QwBDckVtFBtPxWTbl
         aIpQ==
X-Gm-Message-State: ANoB5pk6kDDtZaNuYc6pjihbVb0wMlJ2PxC8YNaiZbXVUdHBRYuBLSeO
        M0rXJ3MHQ+WOHi6yG5NUEg==
X-Google-Smtp-Source: AMsMyM4kYNdfuRTk0occtw+rgiRZ+CP73DXZYUn56GnB9f+gvwg8Zo+icy0yvtW6pg+iyM+ep7Dv3Q==
X-Received: by 2002:a05:6870:82a4:b0:140:78f6:c954 with SMTP id q36-20020a05687082a400b0014078f6c954mr4581995oae.16.1667659935742;
        Sat, 05 Nov 2022 07:52:15 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d9-20020a4a3c09000000b0049bd96ec131sm677216ooa.8.2022.11.05.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 07:52:14 -0700 (PDT)
Received: (nullmailer pid 27957 invoked by uid 1000);
        Sat, 05 Nov 2022 14:52:16 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Sam Shih <sam.shih@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>
In-Reply-To: <20221105084905.9596-2-linux@fw-web.de>
References: <20221105084905.9596-1-linux@fw-web.de>
 <20221105084905.9596-2-linux@fw-web.de>
Message-Id: <166765939131.4158830.8416727494529058690.robh@kernel.org>
Subject: Re: [PATCH v1 1/4] dt-bindings: pinctrl: mt7986: add generic
 bias-pull* support
Date:   Sat, 05 Nov 2022 09:52:16 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 05 Nov 2022 09:49:02 +0100, Frank Wunderlich wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> Since the bias-pull-{up,down} attribute already defines in pinctrl driver
> of mediatek MT7986 SoC, this patch updates bindings to support mediatek
> common bias-pull* function.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 50 +++++++++++++++++--
>  1 file changed, 47 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.example.dtb: pinctrl@1001f000: mmc0-pins:mux:groups:0: 'emmc_51' is not one of ['emmc', 'emmc_rst']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

