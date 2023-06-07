Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2732725536
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbjFGHQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjFGHQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:16:00 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B9DE62;
        Wed,  7 Jun 2023 00:15:59 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-77797beb42dso160211839f.2;
        Wed, 07 Jun 2023 00:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686122159; x=1688714159;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WN0LwwbnyJgDu1njwGhpTrm7cgIrH6XMSJ7383SAvpU=;
        b=F8kjs7ru0KzKeiZRzlNy9PtMGIz12w+nWl/ix7kwyGTfTdF3eHE3MONai5jgh1f5/S
         r7jRHS5ScTf78Bh+NODFvZHd7AMtx39gINLtfUXGfzcNjvQ8QGSYpjr92kTs8DJFQM6l
         EhRJT8BOxJmzM4ZAponEbuuXneAxpQrtaizt86qcD5jDGiiQXMhDfBE+LW/2aLtjd9/s
         wRGkcA9wBjeMeeiNsyDLt6VLTlaZRjpB1zi6TCQyi1JuAvS6PRgD4+zhMsZ0PV5Lqr0A
         euFdrlqI7WPFu5o9V1SOb1yjUSvBfNs3akN4a4IdtqXhG2F+h5kcookiRhKJIRLCqgga
         KnlA==
X-Gm-Message-State: AC+VfDzCBZpMHS8TQQ27OtRxX3JD9TkRivq1YGddNHo2BrDME/IDhCmj
        DJwcbFMga86hIJsQX+vmdQ==
X-Google-Smtp-Source: ACHHUZ6xKL81YYTu7AlmFDegrMRVLuXp0zLtAjHhlTwkvAEuS0iMElMEV0IQYbqqBXZAFPHbCYkqrg==
X-Received: by 2002:a6b:e31a:0:b0:777:b409:fb67 with SMTP id u26-20020a6be31a000000b00777b409fb67mr5369669ioc.4.1686122158656;
        Wed, 07 Jun 2023 00:15:58 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id el11-20020a0566384d8b00b0040bb600eb81sm3411663jab.149.2023.06.07.00.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:15:58 -0700 (PDT)
Received: (nullmailer pid 2033408 invoked by uid 1000);
        Wed, 07 Jun 2023 07:15:55 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Singo Chang <singo.chang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Nancy Lin <nancy.lin@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, Fei Shao <fshao@google.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
In-Reply-To: <20230607061121.6732-2-shawn.sung@mediatek.com>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
 <20230607061121.6732-2-shawn.sung@mediatek.com>
Message-Id: <168612215587.2033253.1998545929244911622.robh@kernel.org>
Subject: Re: [PATCH v1 1/6] dt-bindings: display/mediatek: mt8188: Add
 documentations for VDOSYS1
Date:   Wed, 07 Jun 2023 01:15:55 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Jun 2023 14:11:16 +0800, Hsiao Chien Sung wrote:
> Add device tree documentations for MT8188 VDOSYS1.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml |  1 +
>  .../display/mediatek/mediatek,ethdr.yaml      |  5 +-
>  .../display/mediatek/mediatek,mdp-rdma.yaml   |  5 +-
>  .../display/mediatek/mediatek,merge.yaml      |  1 +
>  .../display/mediatek/mediatek,padding.yaml    | 80 +++++++++++++++++++
>  5 files changed, 90 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml:28:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml:26:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,padding.example.dts:19:18: fatal error: dt-bindings/clock/mt8188-clk.h: No such file or directory
   19 |         #include <dt-bindings/clock/mt8188-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/display/mediatek/mediatek,padding.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230607061121.6732-2-shawn.sung@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

