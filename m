Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA286B9754
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjCNOKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjCNOKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:10:32 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B606B943;
        Tue, 14 Mar 2023 07:10:25 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id bp11so3289177ilb.3;
        Tue, 14 Mar 2023 07:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678803025;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jb3jd9QxsRsLJ8mV/izIiGcWUXWwUUz8ucCbW5sEHYY=;
        b=JmmXWhSqx0TTEF7PLiModP37qDnagAAZpl700vdVuIagZCqrjt8i6cWCElmKHNb8ZN
         C/y0MVWzIR2N1FieTVVaeMc/W1IeiQ11YTXFBl4Ik7U5CK79VHrJEfgHx/JMG3RJRR4a
         Mt26R+cGruV+KIHTmlTRsAn/GAYCkWQXfTl9qUTypKJvqSadcieifQCuybQ/MjDOuYYI
         I2UzpRO3W0uvuma4z0Owuc2SrU7ZGih2IHor+fAEp9Wp6Jd256DjY5o/Z5vorPbf23ph
         Am37iHLx/mAlLOCRHMQONXL2X4Rd6TOGX5o91FAjbMHA3yaDGuVidZpjggwa6X5vXOS7
         Cgnw==
X-Gm-Message-State: AO0yUKVBbbUwzu4U1cnrtOWhfzHw7ejCHalFKSiBLkxWIYG/ULdatSAO
        AplulVB2OWlLrSGWF8rHmw==
X-Google-Smtp-Source: AK7set/C7amwGFeHRUFPDzlExsB01ebv5mvmuf1x3ysE5SdsiW2XBUuzF4UQBXDhcxObt4XEamwj3g==
X-Received: by 2002:a92:d6d2:0:b0:317:980d:970 with SMTP id z18-20020a92d6d2000000b00317980d0970mr2268506ilp.7.1678803025065;
        Tue, 14 Mar 2023 07:10:25 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id o8-20020a056e02102800b00317f477b039sm845734ilj.4.2023.03.14.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 07:10:24 -0700 (PDT)
Received: (nullmailer pid 83787 invoked by uid 1000);
        Tue, 14 Mar 2023 14:10:19 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Sean Wang <sean.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        erkin.bozoglu@xeront.com, linux-gpio@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Andy Teng <andy.teng@mediatek.com>,
        William Dean <williamsukatube@gmail.com>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        DENG Qingfang <dqfext@gmail.com>
In-Reply-To: <20230313205921.35342-16-arinc.unal@arinc9.com>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
 <20230313205921.35342-16-arinc.unal@arinc9.com>
Message-Id: <167880254685.25972.15349420182231511267.robh@kernel.org>
Subject: Re: [PATCH v2 15/21] dt-bindings: pinctrl: {mediatek,ralink}: fix
 formatting
Date:   Tue, 14 Mar 2023 09:10:19 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 23:59:15 +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Change the style of description properties to plain style where there's no
> need to preserve the line endings, and vice versa.
> 
> Fit the schemas to 80 columns for each line.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../pinctrl/mediatek,mt65xx-pinctrl.yaml      | 22 +++---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 33 +++++----
>  .../pinctrl/mediatek,mt6795-pinctrl.yaml      | 33 +++++----
>  .../pinctrl/mediatek,mt7620-pinctrl.yaml      |  2 +-
>  .../pinctrl/mediatek,mt7621-pinctrl.yaml      |  2 +-
>  .../pinctrl/mediatek,mt7622-pinctrl.yaml      | 26 +++----
>  .../pinctrl/mediatek,mt7981-pinctrl.yaml      | 33 +++++----
>  .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 68 ++++++++---------
>  .../pinctrl/mediatek,mt8183-pinctrl.yaml      | 26 ++++---
>  .../pinctrl/mediatek,mt8186-pinctrl.yaml      | 47 ++++++------
>  .../pinctrl/mediatek,mt8188-pinctrl.yaml      | 74 ++++++++++---------
>  .../pinctrl/mediatek,mt8192-pinctrl.yaml      | 47 ++++++------
>  .../pinctrl/mediatek,mt8195-pinctrl.yaml      | 41 +++++-----
>  .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 28 +++----
>  .../pinctrl/ralink,rt2880-pinctrl.yaml        |  2 +-
>  .../pinctrl/ralink,rt305x-pinctrl.yaml        |  2 +-
>  .../pinctrl/ralink,rt3883-pinctrl.yaml        |  2 +-
>  17 files changed, 254 insertions(+), 234 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml:103:16: [warning] wrong indentation: expected 14 but found 15 (indentation)
./Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml:113:16: [warning] wrong indentation: expected 14 but found 15 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230313205921.35342-16-arinc.unal@arinc9.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

