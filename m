Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FA467C2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjAZCyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAZCyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:54:33 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E61464693;
        Wed, 25 Jan 2023 18:54:32 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id 39-20020a9d032a000000b006884aad0b15so317767otv.12;
        Wed, 25 Jan 2023 18:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gkg4m8Fn/qWaJ7omruIhOwEotiV4rXwbLhcUjKCCMzw=;
        b=AQSyYCvxlpIBqLa9ZlKiNaqjP+9cJmXSmRoZX5GP8fFALr5uosZZ+VWfN56rUrRTaY
         zKvs6wUbi4RZ9ZP+aKYNyb9uz7Ii++7tUhhVsabb4nB10E5o/+lBtk3pzJpYXefSLur+
         QZ5WwgFDnf3gfHVBvrbeA2TU1o81RdMwe/th7wuix3BxBBguSsI7VIGsAuEWVMlIbfPM
         SJcXK1SCR3airHQOZ3vX/wghZTQjnY/fWk4cd1L8m4+qKMXjAaYz7HiJadSPjOKZvPOE
         Eb09XWdUDI56nni466H/O3jkSa0FcrWl3PuDYW8qubR7MGK9JG5s3bh2M7AL/Y2ebFmM
         jS3g==
X-Gm-Message-State: AO0yUKXjfXoRDjkIR9mr3QiHfw6bCPtmNhi+3KG7iS5h7U9sMEn5FlpW
        Nby78M58ku5fKzRjIvIoEg==
X-Google-Smtp-Source: AK7set86SPNqPrcFJwwaeA568aXOJ3XuUP4mCd1z5pmrdeDE8ZQGLEVSMT0DauoVVHTdiqUSsubMWw==
X-Received: by 2002:a9d:4eb:0:b0:670:8676:76ee with SMTP id 98-20020a9d04eb000000b00670867676eemr372140otm.36.1674701671194;
        Wed, 25 Jan 2023 18:54:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a9d4689000000b006864a6f2bfdsm2922802ote.31.2023.01.25.18.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 18:54:30 -0800 (PST)
Received: (nullmailer pid 75017 invoked by uid 1000);
        Thu, 26 Jan 2023 02:54:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cormier <jcormier@criticallink.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org
In-Reply-To: <20230125-tfp410_i2c-v1-1-66a4d4e390b7@criticallink.com>
References: <20230125-tfp410_i2c-v1-0-66a4d4e390b7@criticallink.com>
 <20230125-tfp410_i2c-v1-1-66a4d4e390b7@criticallink.com>
Message-Id: <167470157895.71717.17977330339403047408.robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: display: bridge: tfp410: Add tfp410 i2c example
Date:   Wed, 25 Jan 2023 20:54:29 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Jan 2023 16:09:09 -0500, Jonathan Cormier wrote:
> Add a i2c example with HDMI connector
> 
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> ---
>  .../bindings/display/bridge/ti,tfp410.yaml         | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/bridge/ti,tfp410.example.dts:77.37-79.19: ERROR (duplicate_label): /example-1/i2c/tfp410@38/ports/port@0/endpoint: Duplicate label 'tfp410_in' on /example-1/i2c/tfp410@38/ports/port@0/endpoint and /example-0/encoder/ports/port@0/endpoint
Documentation/devicetree/bindings/display/bridge/ti,tfp410.example.dts:84.38-86.19: ERROR (duplicate_label): /example-1/i2c/tfp410@38/ports/port@1/endpoint: Duplicate label 'tfp410_out' on /example-1/i2c/tfp410@38/ports/port@1/endpoint and /example-0/encoder/ports/port@1/endpoint
ERROR: Input tree has errors, aborting (use -f to force output)
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/display/bridge/ti,tfp410.example.dtb] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230125-tfp410_i2c-v1-1-66a4d4e390b7@criticallink.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

