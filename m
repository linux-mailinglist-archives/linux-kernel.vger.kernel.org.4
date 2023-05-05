Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69FA6F80CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjEEKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEEKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:33:16 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56561248E;
        Fri,  5 May 2023 03:33:14 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6a5ec0d8d8aso957549a34.2;
        Fri, 05 May 2023 03:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683282794; x=1685874794;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nWRIpuovVIMEpYtjLpD/cnXdXD4NVVRLvuPXNC9ShqY=;
        b=hn3y8tzkXgaxW5ECuPqcWxJm9ySnHyWMiaAAtvLVGMWQyTM1Bz5ous8eqDEpzrDnAF
         PaXGlOhh843H+F6j5BPiSMg5lX5QDXeAZKijgIRVYt+Dl9S4ScNhvK5xaup8V8DUrqHL
         bwM5tjspOsQoVM0aK4T8cjX9UQJVTP8k8WkFp4GP61d75Fe+6hyg01RaBxhPoqIDpx12
         WwNMC3Jl4rB14HV3G0CefMYKIRFRUW8Eidu/JUyzdofpyr4sL8j5hai+CRa2L91ETqXa
         ot7EG8K6Or6E/9ElC9H8BLXp4R061lf014/CXlIuCX9y2+oR2r2iaXHDqCIS6kGjZaYY
         rpWg==
X-Gm-Message-State: AC+VfDxECcckNRWngtcnYk5VYKg2R4vrrOiNCwiSvQFDT6tl88RtrdLV
        WVC+/zWPVqEJToBl2Z9rsA==
X-Google-Smtp-Source: ACHHUZ63qjBpdDEoG+mkzHnRevLEIiM6flJK5carhmNlA3y2k9Zu7wt+fPTh+MCRNzjtFYiJtxM+mw==
X-Received: by 2002:a9d:62c6:0:b0:6a9:73f0:4b1d with SMTP id z6-20020a9d62c6000000b006a973f04b1dmr486853otk.32.1683282793972;
        Fri, 05 May 2023 03:33:13 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f3-20020a9d7b43000000b006a65fface3esm624037oto.64.2023.05.05.03.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 03:33:13 -0700 (PDT)
Received: (nullmailer pid 2152116 invoked by uid 1000);
        Fri, 05 May 2023 10:33:12 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, srinivas.kandagatla@linaro.org,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org
In-Reply-To: <20230505091906.1820081-1-peng.fan@oss.nxp.com>
References: <20230505091906.1820081-1-peng.fan@oss.nxp.com>
Message-Id: <168328279233.2152093.17111412703321602955.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: nvmem: add nvmem-cell-cells property
Date:   Fri, 05 May 2023 05:33:12 -0500
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


On Fri, 05 May 2023 17:19:06 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The driver has been using this property, so add it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/nvmem/nvmem.yaml:71:10: [warning] wrong indentation: expected 8 but found 9 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230505091906.1820081-1-peng.fan@oss.nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

