Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C3972C405
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjFLM0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjFLM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:26:45 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C767C113;
        Mon, 12 Jun 2023 05:26:42 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-77807e43b7cso285208939f.1;
        Mon, 12 Jun 2023 05:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686572802; x=1689164802;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=afhnT+300FfZkYOidp9N/Sw5yxdKK9IOWNs44Y93bLU=;
        b=ZjLRm/FHiN9csZbtchauwfgZh6yDFDE51ieCkhAcoa3ze8IiZTexeZCK7Sroefi4uz
         LH6HFZrCL19iqJVZe/5IxXQ960y7Q8fyRt9Gum60Y7GXlNH3b/yFI8pidDxUYU8lsC2K
         83so6wfscjTPHNdfRa+/I9D7yhathumPaHMPu74NJ15DhzYN/4n+V7BM2t99EV2fhp59
         V4sIPTSTZLeKEHbNE0z+0kAJ0ru1KDQpRLNTdDMrkINvnlbm4DGb4wSYVW0s19ta5qQJ
         7Am0poH7CVUsmSEvhkosMAjHJQdjpQN5WPyEx66Xmq75naVjgS0rgkDvqc9u/ku8pxsh
         O0ig==
X-Gm-Message-State: AC+VfDyuQoX/vXkccoJSlFJFka+24cpTZfNaEYkKoL0dgonnHreVisA2
        pexbmOqGVGgg5ofL1HzyLAsCV767cQ==
X-Google-Smtp-Source: ACHHUZ7uB1cxJbWE6gfQCKWQayRPVguaF2In8F9NJzERrvmVFGkoow/Pp6V+OhOTY0JTkGm4jeBx2w==
X-Received: by 2002:a6b:4401:0:b0:774:94e1:3aee with SMTP id r1-20020a6b4401000000b0077494e13aeemr7970492ioa.6.1686572801974;
        Mon, 12 Jun 2023 05:26:41 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m12-20020a056638224c00b00418a5e0e93esm2723243jas.162.2023.06.12.05.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:26:41 -0700 (PDT)
Received: (nullmailer pid 4044374 invoked by uid 1000);
        Mon, 12 Jun 2023 12:26:39 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
In-Reply-To: <20230612113059.247275-3-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-3-linux@rasmusvillemoes.dk>
Message-Id: <168657279982.4044345.9896354759743085279.robh@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: rtc: Move isil,isl12022 from
 trivial-rtc.yaml into own schema file
Date:   Mon, 12 Jun 2023 06:26:39 -0600
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


On Mon, 12 Jun 2023 13:30:52 +0200, Rasmus Villemoes wrote:
> Move the isil,isl12022 RTC bindings from trivial-rtc.yaml into its own
> intersil,isl12022.yaml file, in preparation for adding more bindings.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  .../bindings/rtc/intersil,isl12022.yaml       | 42 +++++++++++++++++++
>  .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
>  2 files changed, 42 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 62, in <module>
    ret |= check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 31, in check_doc
    for error in sorted(dtschema.DTValidator.iter_schema_errors(testtree), key=lambda e: e.linecol):
  File "/usr/local/lib/python3.10/dist-packages/dtschema/lib.py", line 736, in iter_schema_errors
    cls.annotate_error(error, meta_schema, error.schema_path)
  File "/usr/local/lib/python3.10/dist-packages/dtschema/lib.py", line 712, in annotate_error
    schema = schema[p]
KeyError: 'type'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230612113059.247275-3-linux@rasmusvillemoes.dk

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

