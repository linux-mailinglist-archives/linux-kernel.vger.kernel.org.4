Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672A86E1731
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDMWKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMWKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:10:43 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463CF5B94;
        Thu, 13 Apr 2023 15:10:42 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id w19-20020a9d6393000000b006a43ff0f57cso284011otk.5;
        Thu, 13 Apr 2023 15:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681423841; x=1684015841;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lRp3R38DBKAcqbpi94w/GTvCXxHuUsnausWd76BTI1U=;
        b=UN6UwvZkjOjrA88j7L0yPc3yRYGUHmAiRWiNeXftrJtSYPICGXvNl5guYblv4gTTMB
         N62xLqfm4rJTdiy8YLQwM2SUNY7b1UOzRgAZ6Gk4xu5nQcSRuSh2UaSNwIqP8sN6WK1q
         D/jcTjjdQy6fA1hIz0h8/9LtDC1eFCVc8+FVlkowxrxj7WD/SajtFI/bo2m+a/g1CES0
         25dWDPfbN7tUYOsh+4L7vSjmhHhQyKitbAaDb1cxroEvhpEEfAS30Tp/jHtPJSBXvRVm
         eu5+YyubrFPocPqD6zHwxyvmoOCmw4fwcLwCgdXLCckWNCJDdYrEoCZsrRfpypxP3LTx
         nrkw==
X-Gm-Message-State: AAQBX9elzzQ9i/LFtnyI/lvcUlL+bwq5dwY1Hys4rjALv62nRxKvv43x
        cNss5jBnnW4Ep8Pb7wrUYg==
X-Google-Smtp-Source: AKy350ZAzbcV4/iy+uq4icNQ2bGCh482u4+kBTuRDzDJQecVOG+iosYX31G661fQh9U/8yN2fS8p1w==
X-Received: by 2002:a05:6830:2093:b0:6a1:7b61:1fd0 with SMTP id y19-20020a056830209300b006a17b611fd0mr2107949otq.3.1681423841458;
        Thu, 13 Apr 2023 15:10:41 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r13-20020a9d7ccd000000b006a13dd5c8a2sm1142743otn.5.2023.04.13.15.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 15:10:40 -0700 (PDT)
Received: (nullmailer pid 1934874 invoked by uid 1000);
        Thu, 13 Apr 2023 22:10:40 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
In-Reply-To: <20230413173150.71387-2-sebastian.reichel@collabora.com>
References: <20230413173150.71387-1-sebastian.reichel@collabora.com>
 <20230413173150.71387-2-sebastian.reichel@collabora.com>
Message-Id: <168142378979.1933846.311921453118296427.robh@kernel.org>
Subject: Re: [PATCHv4 1/3] dt-bindings: usb: Add RK3588 OHCI
Date:   Thu, 13 Apr 2023 17:10:40 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Apr 2023 19:31:48 +0200, Sebastian Reichel wrote:
> Add compatible for RK3588 OHCI. As far as I know it's fully
> compatible with generic-ohci.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/usb/generic-ohci.yaml    | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/generic-ohci.example.dtb: usb@1c14400: clocks: [[4294967295, 6], [4294967295, 2]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230413173150.71387-2-sebastian.reichel@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

