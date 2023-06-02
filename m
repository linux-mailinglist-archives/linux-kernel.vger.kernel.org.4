Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335327205A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjFBPOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjFBPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:14:27 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28929E6A;
        Fri,  2 Jun 2023 08:14:04 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33d31ab00bdso6054245ab.3;
        Fri, 02 Jun 2023 08:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685718843; x=1688310843;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lNz7EHfJCZ4aAXNJupCemelGLErGlUkCq/uI3p2KECg=;
        b=mGN6DKD2642hDOuCB9yKNkoQk5RNghflHBRSJDvQzRhDkg9NxsE9W0cCK19ZY5UJ+e
         6Tu7528QeY41jsNGUHO0ARre4Ll4bH26sMsV668R61aD/Q1CktPvvipFlBqwHVtM1EEk
         VBS87jDbbjaMT5Bz+0z+1rpijHMOhG7LVcRI9eWFPQHhuQuyrSWr0aSYyu1352uFVR//
         CVhOsVaWQFmWVcmipiNxfi2V7KeawiAne2Ep/lj/TfLSONZqHSoDEy98VuT0SA1WH949
         Yj0iwHrehFYU1N+CswdnUkfyvEcpTg1sMmPKNcmBksoxd8BLJHdtYaSY2g6L31jONGnm
         WnVw==
X-Gm-Message-State: AC+VfDzBJ78m7SP0A7ZpD9eEsCHK2C6IAmCB6XV3fSHsVTVuScwae4Rv
        I4NNZ0M8BbAwmpgzBGOgEFWykFJGew==
X-Google-Smtp-Source: ACHHUZ5hifGlPbShyifnNwL6jsL1rlCdiGUoMjSlMjkQA5lNYQz6/XQU9zNiJLKcr2k7S4Myxlx1xQ==
X-Received: by 2002:a92:d1c3:0:b0:33b:6f65:2dd0 with SMTP id u3-20020a92d1c3000000b0033b6f652dd0mr9427113ilg.29.1685718843212;
        Fri, 02 Jun 2023 08:14:03 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l11-20020a92290b000000b003351835c53fsm357919ilg.19.2023.06.02.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:14:02 -0700 (PDT)
Received: (nullmailer pid 1767457 invoked by uid 1000);
        Fri, 02 Jun 2023 15:14:00 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     dmitry.torokhov@gmail.com, jikos@kernel.org, conor+dt@kernel.org,
        linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        hsinyi@google.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, dianders@chromium.org
In-Reply-To: <20230602140948.2138668-2-yangcong5@huaqin.corp-partner.google.com>
References: <20230602140948.2138668-1-yangcong5@huaqin.corp-partner.google.com>
 <20230602140948.2138668-2-yangcong5@huaqin.corp-partner.google.com>
Message-Id: <168571884052.1767438.8020984972654545636.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: Add ilitek 9882T
 touchscreen chip
Date:   Fri, 02 Jun 2023 09:14:00 -0600
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


On Fri, 02 Jun 2023 22:09:47 +0800, Cong Yang wrote:
> Add an ilitek touch screen chip ili9882t.
> 
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../bindings/input/elan,ekth6915.yaml         | 36 ++++++++++++++-----
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/input/elan,ekth6915.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/elan,ekth6915.yaml: properties:required: ['compatible', 'reg', 'interrupts', 'vcc33-supply'] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/elan,ekth6915.yaml: properties: 'required' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/elan,ekth6915.yaml: ignoring, error in schema: properties: required
Documentation/devicetree/bindings/input/elan,ekth6915.example.dtb: /example-0/i2c/touchscreen@10: failed to match any schema with compatible: ['elan,ekth6915']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230602140948.2138668-2-yangcong5@huaqin.corp-partner.google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

