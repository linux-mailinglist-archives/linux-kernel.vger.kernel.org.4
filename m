Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B387E6C86A7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCXURu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjCXURo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:17:44 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE61A492;
        Fri, 24 Mar 2023 13:17:44 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso2874473fac.12;
        Fri, 24 Mar 2023 13:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679689063;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rD9ciGos0y1USWhzdKNkN2kvhX/eHHj65sd31Nex8kI=;
        b=vjVtEG1/Z/IU8witbXJTpxHih4P8MTg2EenDJPRwMe6K/d1zYTa4sRuYQoNyoHgeHk
         /euFTybBUIZzf2R+qIXeA1NUcaru4kDFg+50zxSR/YrJq8WXrmq1fjDG6RNU4BEPyFZh
         PdIfogsCOMmo+hBuSzyd+fktQeWKCQJ2slco9uDdlB8yQbEV9bGkgEZWsh9IuVCqqyxI
         ohgOtIu9FmpuwjoAOZ+1PULrTfepdVxisNvYdX+6L3FaxtJNLMtfLeOwd387Q/mLbxW9
         UnfGC5HlHtJ5L9wHedSa9GuqyvRpbA+YpDBRry5purtDQCN5ieENswQmuFyoqKL6UWCx
         dhcA==
X-Gm-Message-State: AO0yUKWl3pOIL8RxLEXhA47PiKmALxofnTVSTvgUb2tLQUPRQQ+jmGSX
        eAD5sXzus1+JE7MHVnM60A==
X-Google-Smtp-Source: AKy350YRjeIimHIYr90YlV9pYo+xOiJ1OCn0DJBrYzmXor5TZIEr43uhwVrUpYoFvJ1/d8kL7Etyzg==
X-Received: by 2002:a05:6870:c589:b0:17e:456:aa58 with SMTP id ba9-20020a056870c58900b0017e0456aa58mr2780756oab.56.1679689063607;
        Fri, 24 Mar 2023 13:17:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p186-20020acad8c3000000b0038694b7dc09sm8585406oig.55.2023.03.24.13.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:17:43 -0700 (PDT)
Received: (nullmailer pid 2436318 invoked by uid 1000);
        Fri, 24 Mar 2023 20:17:41 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-media@vger.kernel.org, Sean Young <sean@mess.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Ravi Kumar V <kumarrav@codeaurora.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthew Lear <matthew.lear@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230324170214.3470675-2-f.fainelli@gmail.com>
References: <20230324170214.3470675-1-f.fainelli@gmail.com>
 <20230324170214.3470675-2-f.fainelli@gmail.com>
Message-Id: <167968860307.2423872.12655275819676074243.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: media: gpio-ir-receiver: Document
 wakeup-souce property
Date:   Fri, 24 Mar 2023 15:17:41 -0500
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Mar 2023 10:02:13 -0700, Florian Fainelli wrote:
> The GPIO IR receiver can be used as a wake-up source for the system,
> document that.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml:27:6: [warning] wrong indentation: expected 4 but found 5 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230324170214.3470675-2-f.fainelli@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

