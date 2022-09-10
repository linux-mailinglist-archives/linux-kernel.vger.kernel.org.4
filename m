Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231615B470D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIJOyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIJOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:54:01 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F8843E42;
        Sat, 10 Sep 2022 07:53:57 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1279948d93dso11436622fac.10;
        Sat, 10 Sep 2022 07:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=85ahIlvo8IWoFxRTWFFF8AdVN61dvRZSed2EwF8yXgA=;
        b=Me5looYt1KHtSnJ0a58pVR+U/ZXf0kUU6rcJVY7ZG9+o9AT+T1gzDWhFLCbpzS2GM/
         I9CNZjidJO6r+lYWK0jIYxKlXOjUH/djQsnQ70EmJkV8x+1frdgXRk/e59EqIGVbkpGT
         VWQS2ynVuccYlMr086DFBY+9DuQ0oDMhK/IDgKT0JaVblQNzwjv1GfdHyTYryEH/XHcN
         q9kPKFo5kBmJK/kb/W+bNLxVKreu4yFG2cURiL+wY31xxScaLNHTiix2i9hiG31X/S+W
         w/PboYpNV7KBOngr16XX7V+OerKmeJHZCCRmqG7wO8J1umA/i0kq1q6rrQPFMslvXEBM
         Ncsg==
X-Gm-Message-State: ACgBeo1+AZafWpWtv5IHwoIkw2Zbyw5WTydjwFC1Hr05WDxpeQXZwkNl
        D89c1+8bxrcUPgie7u1qHw==
X-Google-Smtp-Source: AA6agR6kT6NFsonaHXPp4wpmeYYYkkqwuksA7+CErrbYE2vW+nLoubjG+79eHSGEFoGioIpoRwr0qw==
X-Received: by 2002:a05:6870:58a6:b0:127:86d4:6707 with SMTP id be38-20020a05687058a600b0012786d46707mr7387223oab.88.1662821636301;
        Sat, 10 Sep 2022 07:53:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l2-20020a056808020200b00344f28a7a4csm1251362oie.22.2022.09.10.07.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 07:53:55 -0700 (PDT)
Received: (nullmailer pid 34694 invoked by uid 1000);
        Sat, 10 Sep 2022 14:53:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
In-Reply-To: <20220909165959.5899-2-hugues.fruchet@foss.st.com>
References: <20220909165959.5899-1-hugues.fruchet@foss.st.com> <20220909165959.5899-2-hugues.fruchet@foss.st.com>
Subject: Re: [PATCH 1/5] dt-bindings: media: add bindings for dcmipp driver
Date:   Sat, 10 Sep 2022 09:53:55 -0500
Message-Id: <1662821635.155935.34693.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022 18:59:55 +0200, Hugues Fruchet wrote:
> From: Alain Volmat <alain.volmat@foss.st.com>
> 
> Add the yaml binding for the DCMIPP driver.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  .../bindings/media/st,stm32-dcmipp.yaml       | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/st,stm32-dcmipp.example.dtb: dcmipp@5a000000: port:endpoint: Unevaluated properties are not allowed ('pclk-max-frequency' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

