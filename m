Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F9E6B41AE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCJNzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjCJNzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:55:08 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA28010F448;
        Fri, 10 Mar 2023 05:55:05 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id e26-20020a9d6e1a000000b00694274b5d3aso2949282otr.5;
        Fri, 10 Mar 2023 05:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678456505;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1cES9JR6anob8B/1PeJEqQZqZDCXMpYC1azdrACVsv4=;
        b=444C6Pa8l7fJvzbmB8IWYVPgs0mcMMD3dxI3sj+4oGVi41ss6ONPyYOxzDHWA80bJ3
         9ZNSnuo2487Gx+BsOTH58B9vnJNYszTmSRWWPtWzqNXcIpRHdgRis8+QcWGYLv4uFvY+
         ACdf/4h09MUyzxyh3W1C/ibd5mS9Gm4Q4qyf4EyOqQxXPeYDeH7HhYMStYv2TmJwIsfi
         U7J49huWfrFN7PVwNaLSn5Iit7XZR0hHBeWR5Z3MgTTpkvIKkxYUNf7Y2CpzczjyThSs
         jkmGkYr/Z0EFd6pEyda5wkMZxnr0mlj3+9MPWndwqu+wW3y4BbctQ25HC6K+0ibQ6Hvz
         Is0Q==
X-Gm-Message-State: AO0yUKX0XLs1TZkQ9eafmLySEJzxG/EosGn3pEa8fb2xfKK576dxmKzL
        54bMKnAMPy0nE3qacCszKg==
X-Google-Smtp-Source: AK7set91xSxVmm1bc6gMoW8m16OBii5leH8D61yMBfeyo5aP3CIP/5w8GRmTKk8N52oHN6eErOu9Yw==
X-Received: by 2002:a9d:62d:0:b0:693:bfc4:3eaf with SMTP id 42-20020a9d062d000000b00693bfc43eafmr11511281otn.26.1678456504945;
        Fri, 10 Mar 2023 05:55:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x31-20020a056830409f00b0068bcf7995aesm50856ott.64.2023.03.10.05.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 05:55:04 -0800 (PST)
Received: (nullmailer pid 1177459 invoked by uid 1000);
        Fri, 10 Mar 2023 13:55:03 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        changhuang.liang@starfivetech.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Todor Tomov <todor.too@gmail.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
In-Reply-To: <20230310120553.60586-3-jack.zhu@starfivetech.com>
References: <20230310120553.60586-1-jack.zhu@starfivetech.com>
 <20230310120553.60586-3-jack.zhu@starfivetech.com>
Message-Id: <167845582304.1165699.16322398900784780057.robh@kernel.org>
Subject: Re: [PATCH v2 2/6] media: dt-bindings: cadence-csi2rx: Convert to
 DT schema
Date:   Fri, 10 Mar 2023 07:55:03 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Mar 2023 20:05:49 +0800, Jack Zhu wrote:
> Convert DT bindings document for Cadence MIPI-CSI2 RX controller
> to DT schema format and add new properties.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---
>  .../devicetree/bindings/media/cdns,csi2rx.txt | 100 -----------
>  .../bindings/media/cdns,csi2rx.yaml           | 163 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 164 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>  create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/cdns,csi2rx.example.dts:18.30-58.11: Warning (unit_address_format): /example-0/csi@0d060000: unit name should not have leading 0s

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230310120553.60586-3-jack.zhu@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

