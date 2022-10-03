Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD26B5F312E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJCNZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJCNZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:25:03 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6E620BC6;
        Mon,  3 Oct 2022 06:24:57 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id c22-20020a4a4f16000000b00474a44441c8so6736492oob.7;
        Mon, 03 Oct 2022 06:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4o9FP01Wkr4A9XE1+7DHtHpJ4sgE+1LxGHWKgV35Jek=;
        b=4WkZhRzJ3+mEZU069vYs4uf8pLpvaRwiUszS1CXFdggXeARy7VsA/AOexcaft4GP8z
         Ia0pZfHJUng/ac5Ebjkbpg/kYIlYsOkswDU4YigTZ9VKJRAWDkc9FGMnI+cGjcKwtC3s
         oMtBsQbrKwTkUnNy8z9wtdFsvAdyVfF9f28udht/nZCUbQIc1GJ8CcAoB6Xx3edHurlC
         4LHnjWGJLZwu2o2IdqZwa1YCi5EeDpd86DzoArF1WIXJdh4+z3EhiD2fUlySmMXkagZh
         nyAfE6SeAZXgLlfb9LYsiNzYHi9I7FqBddVLyZOC0l9DnHL/2avAPrxRjah/RWd9cvgC
         Hitg==
X-Gm-Message-State: ACrzQf2pvcL8iKblCjiIrNfc2HiA6mhrmIjNc/btbrB2AI+exza7tn6w
        GRbBmt4E0w2TfLAmYQtZNNKZrsrhMg==
X-Google-Smtp-Source: AMsMyM69T2VOp2Bi+KS3zdLXeZhG51kRLAqo/gqlkrKU4t/wfW5DmgV3hQhlVm5QLlq4rntBlR7eJw==
X-Received: by 2002:a05:6830:612:b0:655:de80:d048 with SMTP id w18-20020a056830061200b00655de80d048mr8202765oti.168.1664803496323;
        Mon, 03 Oct 2022 06:24:56 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o64-20020aca4143000000b00342ded07a75sm2445443oia.18.2022.10.03.06.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:24:56 -0700 (PDT)
Received: (nullmailer pid 1863805 invoked by uid 1000);
        Mon, 03 Oct 2022 13:24:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-mmc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20221001030641.29354-3-quic_molvera@quicinc.com>
References: <20221001030641.29354-1-quic_molvera@quicinc.com> <20221001030641.29354-3-quic_molvera@quicinc.com>
Message-Id: <166479587535.1659013.8594790600534201114.robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs and boards
Date:   Mon, 03 Oct 2022 08:24:48 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 20:06:38 -0700, Melody Olvera wrote:
> Document the QDU1000 and QRU1000 SoC bindings and the boards that use
> them.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/qcom.yaml:725:18: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/qcom.example.dts'
Documentation/devicetree/bindings/arm/qcom.yaml:725:18: mapping values are not allowed in this context
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/arm/qcom.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/arm/qcom.yaml:725:18: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom.yaml: ignoring, error parsing file
make: *** [Makefile:1420: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

