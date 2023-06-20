Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1D73629E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjFTETm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFTETj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:19:39 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DE510C1;
        Mon, 19 Jun 2023 21:19:37 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-34220bb6a80so12188805ab.0;
        Mon, 19 Jun 2023 21:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687234776; x=1689826776;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sh29mDazIKPfkU+LPfbBtHYj2+YZmyOLjiHNSQfuOnE=;
        b=d8IU6iGYpf68F0AyqL/zaP42yvjPJ1enpS07TluxUVMgl14x/axopG1nWaa5XleYVI
         FExL6Y4IQ689FYORQfibx0hiZ+ZHJIPWm4o+iSegmWti/T4bNSpd0/TOfMJmnyUokLzt
         6AEaJujFxE3WmQnd9cttchBvd6bM0OR1CG+YYD30glWH4ZG6VnF/mLCwRpf28vkL+K+B
         +xSR4AxkFOAc18Z1k/KfUqR384Fot17X/41yuV2nB15BrcFijbU+GVg6rsxYOvlcZ/7f
         uiPNj81mIZqkEdtcnK4WK0F+gJkFeO2bgD4aORC/KxCmt0i9IbOBvducvBvk8t8bRTQb
         Knlw==
X-Gm-Message-State: AC+VfDx4alYcDoYwyURqkM/NIJ/eZzPZAgBG1scFsRH7A8Wj3v1AtGkt
        x8qan8JuTOQDyZ5TP29ciw==
X-Google-Smtp-Source: ACHHUZ7lkmVnePBOGOiBhlULsO0AhX4yF7u5ETMb83OMXNvfopi0mxO6T6Jwan14AyiFgT35Dgwi2A==
X-Received: by 2002:a92:c6c4:0:b0:341:c983:295 with SMTP id v4-20020a92c6c4000000b00341c9830295mr7576192ilm.21.1687234776309;
        Mon, 19 Jun 2023 21:19:36 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l12-20020a02a88c000000b004267c5b61d3sm400266jam.97.2023.06.19.21.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 21:19:35 -0700 (PDT)
Received: (nullmailer pid 2419560 invoked by uid 1000);
        Tue, 20 Jun 2023 04:19:32 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230620031111.3776-2-yuji2.ishikawa@toshiba.co.jp>
References: <20230620031111.3776-1-yuji2.ishikawa@toshiba.co.jp>
 <20230620031111.3776-2-yuji2.ishikawa@toshiba.co.jp>
Message-Id: <168723477296.2419503.15109926967268215697.robh@kernel.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Date:   Mon, 19 Jun 2023 22:19:32 -0600
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


On Tue, 20 Jun 2023 12:11:07 +0900, Yuji Ishikawa wrote:
> Adds the Device Tree binding documentation that allows to describe
> the Video Input Interface found in Toshiba Visconti SoCs.
> 
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
> Changelog v2:
> - no change
> 
> Changelog v3:
> - no change
> 
> Changelog v4:
> - fix style problems at the v3 patch
> - remove "index" member
> - update example
> 
> Changelog v5:
> - no change
> 
> Changelog v6:
> - add register definition of BUS-IF and MPU
> 
>  .../bindings/media/toshiba,visconti-viif.yaml | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml: title: 'Toshiba Visconti5 SoC Video Input Interface Device Tree Bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230620031111.3776-2-yuji2.ishikawa@toshiba.co.jp

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

