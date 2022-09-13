Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F505B6D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiIMMWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIMMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:22:48 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35142E9E1;
        Tue, 13 Sep 2022 05:22:47 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1278624b7c4so31613198fac.5;
        Tue, 13 Sep 2022 05:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=a0ZVYyUwvTe813ooNV90an8PWT+uoOIk2MYh2XBCvjI=;
        b=cF/eensKt5zrs41u19MKXa3GjIPdcAOjzuYEOyIa40cIAjBvV3qX1U5gmb6TNXxQG2
         JMh8z70ywIMXV9H+gPrRJ2YNTDcFjSItfG51e5Hf+V2e8UNoPi7bveaC7BnLAiAzC3Og
         vbeKc9g5Fm9AuVCANYvunTrauVlcwDQBQ4RN/tYPPMqJz+9eXNvLgjWV174Xk/VOB3+2
         uSISIENdW9JsZJW3YU9JKRZ1ELjnpNfqDuAPZmkZkYQnFnC5jsJrp7OpAuDwD0rB5aoR
         Jz3VW9VYXcrhlmD8nMRkhzzF3L30SFffOhWLeAzD6vhKLeIW2ob2HVOWmBw64b3tz9es
         x8Gg==
X-Gm-Message-State: ACgBeo0ms2qgUnWG0If1V4QbPMhkzj6+4vw7mvGYlxt487+HUsuV6wMa
        jR+LHvQyPgwMjGIXJav5qOhnI0nFNg==
X-Google-Smtp-Source: AA6agR7rteQhoOLOheqYGn7D2Ke/H99a0cHFsJHdvziHEj4xR8930T8vMLed/dz/mzlsuo+PmWxykQ==
X-Received: by 2002:a05:6808:2029:b0:34f:f1c3:9493 with SMTP id q41-20020a056808202900b0034ff1c39493mr535621oiw.215.1663071767071;
        Tue, 13 Sep 2022 05:22:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b11-20020a056870d1cb00b001276cea2320sm6922454oac.58.2022.09.13.05.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 05:22:46 -0700 (PDT)
Received: (nullmailer pid 3429879 invoked by uid 1000);
        Tue, 13 Sep 2022 12:22:45 -0000
Date:   Tue, 13 Sep 2022 07:22:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: mfd: qcom,tcsr: drop simple-mfd from
 IPQ6018
Message-ID: <20220913122245.GA3429823-robh@kernel.org>
References: <20220909091056.128949-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909091056.128949-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 09 Sep 2022 11:10:56 +0200, Krzysztof Kozlowski wrote:
> Commit 7677ed11e9fa ("dt-bindings: mfd: qcom,tcsr: Convert to dtschema")
> converted bindings to DT schema literally - including the
> qcom,tcsr-ipq6018 expecting syscon and simple-mfd.  Such configuration
> is not used in DTS and there is no actual need of it.  The TCSR block is
> purely configuration block and should not have children.  Any child
> device should be simply moved outside of TCSR syscon block.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2
> ================
> 1. Rebase on current MFD changes.
> 2. Split from the series. Nothing depends on it, AFAIK.
> v2: https://lore.kernel.org/all/20220817145901.865977-2-krzysztof.kozlowski@linaro.org/
> ---
>  .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 46 +++++++++----------
>  1 file changed, 21 insertions(+), 25 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
