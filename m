Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95337659A97
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiL3Qew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiL3Qej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:34:39 -0500
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF521C40D;
        Fri, 30 Dec 2022 08:34:39 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id o8so11532037ilq.6;
        Fri, 30 Dec 2022 08:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YUQ13UNlMnnU+RdBOzrUXm3dMsngq/6hNGyj9q9MZiw=;
        b=MqngqLelLySO6dK/awJ4Fg4u4I58fNcQgs1TdoBAMkIZM/UI7BjLCewQz7dYyyu6hN
         BAkHjNKtIeBR5DU/ASGzb2Fsu3j23HvcsJvtQc3eDhWFSNFBm/XwRXN68eUMEAw93tUV
         WipdaFKc1RzGc9jkWdZKIQhdDcEOo6e5wGAk+s8zL9oxncMBq3umTBgBCIyHmEIQXpYf
         DYwXOoX5zKTiqnqtNt8xR+2Q0hE3b+STWSdPtXw1EFVMJQjawYP9TPx66T07M1lsHVxk
         t3sceYR3P4KowyXnXXK84/pWlkgk2r3f+0hA3mh3bjneFJ1Hfk8xWkfa8znf3l+75eK/
         XhmQ==
X-Gm-Message-State: AFqh2koimuh/PKl58p3gUe/WS1nXhlZknBizOB5j5pdTyKfYeGbD2srF
        r2Jq4ln92oRN23xZ7D9Kxg==
X-Google-Smtp-Source: AMrXdXuqzf/p/KUX/Q6NKkpnki1GkGA1OTlRSftkvhspmWMJCquaB27tfx1TAffdn4xlh0Cred4a0g==
X-Received: by 2002:a92:504:0:b0:30c:323c:f7d1 with SMTP id q4-20020a920504000000b0030c323cf7d1mr1707763ile.15.1672418078764;
        Fri, 30 Dec 2022 08:34:38 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o3-20020a92c683000000b00302f7654187sm6670218ilg.72.2022.12.30.08.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 08:34:38 -0800 (PST)
Received: (nullmailer pid 1935053 invoked by uid 1000);
        Fri, 30 Dec 2022 16:34:28 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-staging@lists.linux.dev, Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Osipenko <digetx@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221229133205.981397-3-luca.ceresoli@bootlin.com>
References: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
 <20221229133205.981397-3-luca.ceresoli@bootlin.com>
Message-Id: <167241769230.1925726.8527129486424295727.robh@kernel.org>
Subject: Re: [PATCH v3 02/21] dt-bindings: display: tegra: vi: add 'vip'
 property and example
Date:   Fri, 30 Dec 2022 10:34:28 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Dec 2022 14:31:46 +0100, Luca Ceresoli wrote:
> The Tegra20 VI peripheral can receive parallel input from the VIP parallel
> input module. Add it to the allowed properties and augment the existing
> nvidia,tegra20-vi example to show a 'vip' property.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changed in v3 (suggested by Rob Herring):
>  - drop 'endpoint', unneeded as there's no extra properties in the
>    endpoints
> 
> Changed in v2 (suggested by Krzysztof Kozlowski):
>  - rename "i2c3" -> "ic2"
>  - add review tag
> ---
>  .../display/tegra/nvidia,tegra20-vi.yaml      | 64 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 65 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.example.dtb: vi@54080000: vip: Unevaluated properties are not allowed ('channel@0' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.example.dtb: vi@54080000: vip: 'ports' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.example.dtb: vip: Unevaluated properties are not allowed ('channel@0' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.example.dtb: vip: 'ports' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221229133205.981397-3-luca.ceresoli@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

