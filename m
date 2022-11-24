Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61FD637E66
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKXRjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKXRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:39:30 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD8913BB7E;
        Thu, 24 Nov 2022 09:39:29 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id i85so1605700ioa.5;
        Thu, 24 Nov 2022 09:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0GLwdcfSpgYBI95DK63dY10m+S/8U3G80dlLwAaJS1E=;
        b=j2Tc5HUiIwwrCO+WFJlU5FtAqXW+fAmpjV+z5l5lF3roG7ANG5/XJZlTUOWvDKIVqC
         +ph1ZYxqkCL5Wqjnzw4aG8mt704p4TBsTgr4eY6wr/XAJ/0Hg5EGPJiho2wN/gPAmQMr
         2IahsiDXbR45qiTdn6/9Zridwnjiiwk16wsvLSqyXF4l/gNGXIGlHA3W8qsUoHkfZzdI
         DrRdBo632GUcv3UmHhdTy23xTLNMGkWwP74jmLScjLW/+ovumhpZzk08YEblbVjjAvir
         eyUlI97F447lJeCOGvhUjZIG7cVbJykN77i/5ui5ISYlXfs9HxcWfsIjlEvudEwA5ySa
         knfw==
X-Gm-Message-State: ANoB5pmNbeZcil2pZKcJY2TqvLpWESXIk+ZjtOFh61d8QI5jnLVRlJTf
        8wLNnyNo2JiExRSSG2sf8ZtEatKnzA==
X-Google-Smtp-Source: AA0mqf5pSesE/J+jnKbYtU3YqoaZQ8dvLsye+hFxgO5pJNyGoDotoKDjVEe5AY3b5mttiWxyksnXjw==
X-Received: by 2002:a02:b71a:0:b0:375:b185:d7c9 with SMTP id g26-20020a02b71a000000b00375b185d7c9mr6476734jam.193.1669311568608;
        Thu, 24 Nov 2022 09:39:28 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n5-20020a056e021ba500b003027f923d29sm577684ili.39.2022.11.24.09.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:39:28 -0800 (PST)
Received: (nullmailer pid 4182346 invoked by uid 1000);
        Thu, 24 Nov 2022 17:39:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        linux-pm@vger.kernel.org
In-Reply-To: <20221124112232.1704144-2-abel.vesa@linaro.org>
References: <20221124112232.1704144-1-abel.vesa@linaro.org>
 <20221124112232.1704144-2-abel.vesa@linaro.org>
Message-Id: <166930150237.3946703.8509828614365674896.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: Add schema for SM8550
Date:   Thu, 24 Nov 2022 11:39:27 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2022 13:22:30 +0200, Abel Vesa wrote:
> Add dedicated schema file for SM8500. This allows better constraining
> of reg property, depending on the type of the NOC node. Also allows
> better constraining of the clocks property. All of the above while
> keeping the file itself comprehensible.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../interconnect/qcom,sm8550-rpmh.yaml        | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.example.dts:18:18: fatal error: dt-bindings/clock/qcom,gcc-sm8550.h: No such file or directory
   18 |         #include <dt-bindings/clock/qcom,gcc-sm8550.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221124112232.1704144-2-abel.vesa@linaro.org

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

