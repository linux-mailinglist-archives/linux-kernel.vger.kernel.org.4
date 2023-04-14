Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150776E2A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDNSiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjDNSh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:37:59 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AA1558E;
        Fri, 14 Apr 2023 11:37:58 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id cd20so6278639oib.0;
        Fri, 14 Apr 2023 11:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681497478; x=1684089478;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M3HtHA0gVZkFMXo90iAJK1D4kK0Vnqrx23dVYZa9s6Q=;
        b=JZGCmxt8PtlqewG3aGvovTtQcjfuCPSNgttzvc8aLI6d5BsOIz8VCYU+EP35+z9aBK
         KpBrB4w6QdfK+9ux5zuqXaSkr+WtN6vdoUn6N3uyX7hLd/1Yd9RS+kh99qNAhoL6+3pS
         Eg89fS0reCP6CkV+FXjUZOdlqkAIScYjVNInFPYhm+YsCK6/Gh/qM4AVqSPYFfPgtl3B
         ogEb1KMXPPY1VYTd3OHF4Dr5DCAW3Cj+N9WXqvVKODOWnrBfcdb/T+My0OFXARZcEpiq
         OAjkL/pgzDgjtqLBUnJoMqpPQ911ANCq8V6ToSVCWb2saAyiXsrWKPUQCjbXcr+85IM+
         gEnA==
X-Gm-Message-State: AAQBX9c90GsYQDuDBjcwkdbVLZ8MrQJYU9w/tcVcCdJz3CktKl0APMNg
        ze99BTjsNODzgMYZqmKLUg==
X-Google-Smtp-Source: AKy350aOPgK8kpqO4eMGv1waB/ROvTGlRtF8RlxNVHmhkcDxYzOjt+oaUAnaLIndFYo7Rze9I1Uajg==
X-Received: by 2002:aca:190c:0:b0:388:f4de:1ed7 with SMTP id l12-20020aca190c000000b00388f4de1ed7mr3023405oii.1.1681497477774;
        Fri, 14 Apr 2023 11:37:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bg15-20020a056808178f00b003896f132821sm1937199oib.41.2023.04.14.11.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:37:57 -0700 (PDT)
Received: (nullmailer pid 105415 invoked by uid 1000);
        Fri, 14 Apr 2023 18:37:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Cc:     upstream@semihalf.com, robh+dt@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        alsa-devel@alsa-project.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, perex@perex.cz, nuno.sa@analog.com,
        tiwai@suse.com, lgirdwood@gmail.com, dinguyen@kernel.org
In-Reply-To: <20230414140203.707729-5-pan@semihalf.com>
References: <20230414140203.707729-1-pan@semihalf.com>
 <20230414140203.707729-5-pan@semihalf.com>
Message-Id: <168149743096.103906.17176550514603692086.robh@kernel.org>
Subject: Re: [PATCH 4/9] dt-bindings: ASoC: Add it68051
Date:   Fri, 14 Apr 2023 13:37:55 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Apr 2023 16:01:58 +0200, Paweł Anikiel wrote:
> Add binding for it68051 device.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  .../bindings/sound/ite,it68051.yaml           | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ite,it68051.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ite,it68051.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230414140203.707729-5-pan@semihalf.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

