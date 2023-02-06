Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A64868C728
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjBFT72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjBFT7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:59:24 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08A02A157;
        Mon,  6 Feb 2023 11:59:22 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id v15so3522524oie.9;
        Mon, 06 Feb 2023 11:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kfUXbuBiDM9nMlhtgfoicYGOlCIHH58e/8hdvSE8jJ4=;
        b=S7dMYRD1lNWt0tCYpZU7VzLUrf7DcuoLtzYbL3RWwRcRf8EKrRhWNFac2kRyQW94BY
         DOqAtA4DqvhkwDVGAV8UM+UDXtAgcxD0OB2lRjpagZtgHKUsi+0C+qf/kVrp4hMKROml
         2Eye+CfwNyPbcyJhJLuVHvsdHRAASNy4dzqKEHu6djIbd6MZO4RfXE1kJSJNmh+3nUYv
         vgbUDbIdd0f8Uy7hjT0eUojiS9oXhN+eLY6jTsuMFoVP2Amp8xtDWOUKJt36OX598atx
         GDUtiyxcHZKcx3sLw0sVyusc3NM8tzavMCmcDdPTiPkSFCJmo93161Q6RIKZ+L4DShOp
         yt0g==
X-Gm-Message-State: AO0yUKXb4DsI5aLai1zabEJ7JYKHI5vBD/ibZ+41YFfWNPza+DlJBapa
        fNEbKP/jvZ0Qe0tCaRznQQ==
X-Google-Smtp-Source: AK7set/6Imd/3QnF67lbWtxRUQQuY9+VZu9NFwfZLt5/o89SdZ4M12nskxoufA3QrLtMbKAI2XInqA==
X-Received: by 2002:a05:6808:4296:b0:364:e9af:f254 with SMTP id dq22-20020a056808429600b00364e9aff254mr254470oib.49.1675713560836;
        Mon, 06 Feb 2023 11:59:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l5-20020a056808020500b0037834b1a20bsm4678259oie.0.2023.02.06.11.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:59:20 -0800 (PST)
Received: (nullmailer pid 1217213 invoked by uid 1000);
        Mon, 06 Feb 2023 19:59:19 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20230206153449.596326-3-jbrunet@baylibre.com>
References: <20230206153449.596326-1-jbrunet@baylibre.com>
 <20230206153449.596326-3-jbrunet@baylibre.com>
Message-Id: <167571334291.1212116.1869881432057405431.robh@kernel.org>
Subject: Re: [PATCH v2 2/7] ASoC: dt-bindings: meson: convert axg tdm
 formatters to schema
Date:   Mon, 06 Feb 2023 13:59:19 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Feb 2023 16:34:44 +0100, Jerome Brunet wrote:
> Convert the DT binding documentation for the Amlogic tdm formatters to
> schema.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../sound/amlogic,axg-tdm-formatters.txt      | 36 --------
>  .../sound/amlogic,axg-tdm-formatters.yaml     | 88 +++++++++++++++++++
>  2 files changed, 88 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/sound/component-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.example.dtb: audio-controller@500: False schema does not allow {'compatible': ['amlogic,g12a-tdmout'], 'reg': [[1280, 64]], 'resets': [[4294967295, 12]], 'clocks': [[4294967295, 35], [4294967295, 127], [4294967295, 120], [4294967295, 134], [4294967295, 134]], 'clock-names': ['pclk', 'sclk', 'sclk_sel', 'lrclk', 'lrclk_sel'], '$nodename': ['audio-controller@500']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230206153449.596326-3-jbrunet@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

