Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37DF706CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjEQPby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjEQPbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:31:52 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE75A5CB;
        Wed, 17 May 2023 08:31:08 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6ab028260f8so678991a34.3;
        Wed, 17 May 2023 08:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684337300; x=1686929300;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RASfi4C6iFM4Ndi70/5KgD6n2tXBLGdQMzw0G7ZIRkw=;
        b=dunsjc9L5CsoEMW/CWcQzfUR3o8LeC4bWBU3NtQgDT/fVS2/Qm/tyJyzJhO2mglGtF
         /WMG1BT2h0mqOyMnYXUzj+gdCtCyrydqdr06nzYx+inpYsdWAvMwDoXf30msuzA1Danw
         Ss3UI34DEZsUOTfDuqTXNpvAbkxYLa4yEBRluulXXPtM63T7SPIyagBpZDjX0pm7aWtG
         Pp++dz2ThXO0D8Kw290sIvRu0iXsqrhyrqMa5eG0JlebzAUt7feC3eIr2yVy8JsFL0A2
         rLYQBB+3lQhuwsaVeAJBkdvtLpUKG/hjfJX6oJyxghQryMN1l85I3LSyCGHHvh8KJk18
         Cb1g==
X-Gm-Message-State: AC+VfDx1pZGoalrdUeaQc6PihEVAsxCBPdY2o0qQSDkMua2IG9/tpGc1
        1fDF49JliTdfcVFQlRazyA==
X-Google-Smtp-Source: ACHHUZ6ijD9N5SseCCQ1cWe5HZUVSbftXF5bMVUuAmhW+DgCGKOm3XkKpKsWZ5OlaP5anPyYkVoUGA==
X-Received: by 2002:a05:6830:14c9:b0:6ab:840:c498 with SMTP id t9-20020a05683014c900b006ab0840c498mr15482515otq.33.1684337300240;
        Wed, 17 May 2023 08:28:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id di10-20020a0568303a0a00b006a5db4474c8sm13400347otb.33.2023.05.17.08.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:28:19 -0700 (PDT)
Received: (nullmailer pid 894363 invoked by uid 1000);
        Wed, 17 May 2023 15:28:17 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     khilman@baylibre.com, linux-mediatek@lists.infradead.org,
        tzimmermann@suse.de, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, matthias.bgg@gmail.com,
        nbelin@baylibre.com, linux-arm-kernel@lists.infradead.org,
        airlied@gmail.com, maarten.lankhorst@linux.intel.com,
        linaro-mm-sig@lists.linaro.org, krzysztof.kozlowski+dt@linaro.org,
        daniel@ffwll.ch, conor+dt@kernel.org, christian.koenig@amd.com,
        mripard@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bero@baylibre.com,
        dri-devel@lists.freedesktop.org, jstephan@baylibre.com,
        sumit.semwal@linaro.org, angelogioacchino.delregno@collabora.com
In-Reply-To: <20230517145237.295461-8-abailon@baylibre.com>
References: <20230517145237.295461-1-abailon@baylibre.com>
 <20230517145237.295461-8-abailon@baylibre.com>
Message-Id: <168433729744.894347.3314650002007733913.robh@kernel.org>
Subject: Re: [PATCH 7/7] dt-bindings: Add bidings for mtk,apu-drm
Date:   Wed, 17 May 2023 10:28:17 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 May 2023 16:52:37 +0200, Alexandre Bailon wrote:
> This adds the device tree bindings for the APU DRM driver.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Reviewed-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../devicetree/bindings/gpu/mtk,apu-drm.yaml  | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
./Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/gpu/mtk,apu-drm.yaml#
Documentation/devicetree/bindings/gpu/mtk,apu-drm.example.dts:18.15-22.11: Warning (unit_address_vs_reg): /example-0/apu@0: node has a unit name, but no reg or ranges property
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/mtk,apu-drm.example.dtb: apu@0: remoteproc: [[4294967295, 4294967295]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230517145237.295461-8-abailon@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

