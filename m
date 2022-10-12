Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBB35FC647
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJLNT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJLNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:19:48 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1F162C7;
        Wed, 12 Oct 2022 06:19:40 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-134072c15c1so16181526fac.2;
        Wed, 12 Oct 2022 06:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHbkoBjQM3cnHgeuFNh4CLJQpR2gyMYlo/zWXCKAPu8=;
        b=mA284yT9su6vAE0X7cBgYnjcC+QdjCy6005CZObAo/M7EI43IFlUbfwYZy4bd5I7Q4
         uvadVUDsg00pPwVX4P4qvOaO5s3RWPy/RHATJRYlE1i0LkE6LVWbNF0TK8PgeDg5Dn21
         6iS9+iRNzMcn4tXgSJ4Kl1iGvkeakRMoaXhi7pCU3HAl7/riMFISal4QAI7Xu8bSMstr
         WM85JouC+rKXYIBsEyxO0tq+vVHBumiv27uS8C+yaAxIbgxnQQafIPFuuX9HLT/jGGA4
         9Mfqcr09KbfIul6EgQUTEgYuhr0+TF/V6hqP2ucc/5OuzPHu9nVf90iXr65Qf56V0VZ6
         PSFg==
X-Gm-Message-State: ACrzQf10/mOFnsj3ZDwOp/uU5o956acNUH2wKP0qa6oNcWyPsbBPsPW3
        CGe2igVWFd/YyT3GB7wY0w==
X-Google-Smtp-Source: AMsMyM6pWmlDqANOqRxlJk0ps4RQ7CWJkauLGFTwb5K5BiMbI6+BceXPvi6XGB6cNc2hfI/VVxxo5Q==
X-Received: by 2002:a05:6870:6586:b0:132:62a5:a663 with SMTP id fp6-20020a056870658600b0013262a5a663mr2247606oab.229.1665580779562;
        Wed, 12 Oct 2022 06:19:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r16-20020a4a9650000000b00448a3ecdc9dsm972657ooi.22.2022.10.12.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 06:19:39 -0700 (PDT)
Received: (nullmailer pid 1941574 invoked by uid 1000);
        Wed, 12 Oct 2022 13:19:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Puranjay Mohan <p-mohan@ti.com>,
        srk@ti.com, Suman Anna <s-anna@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, nm@ti.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, vigneshr@ti.com
In-Reply-To: <20221012114429.2341215-2-danishanwar@ti.com>
References: <20221012114429.2341215-1-danishanwar@ti.com> <20221012114429.2341215-2-danishanwar@ti.com>
Message-Id: <166558063092.1936865.1773120279875751081.robh@kernel.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: remoteproc: Add PRU consumer bindings
Date:   Wed, 12 Oct 2022 08:19:39 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 17:14:25 +0530, MD Danish Anwar wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> Add a YAML binding document for PRU consumers. The binding includes
> all the common properties that can be used by different PRU consumer
> or application nodes and supported by the PRU remoteproc driver.
> These are used to configure the PRU hardware for specific user
> applications.
> 
> The application nodes themselves should define their own bindings.
> 
> Co-developed-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  .../bindings/remoteproc/ti,pru-consumer.yaml  | 132 ++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.example.dtb:0:0: /example-0/icssg2-eth: failed to match any schema with compatible: ['ti,am654-icssg-prueth']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

