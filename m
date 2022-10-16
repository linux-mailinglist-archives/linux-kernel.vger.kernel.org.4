Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D0600413
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 00:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJPW6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 18:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJPW6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 18:58:25 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5253532D8D;
        Sun, 16 Oct 2022 15:58:24 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id w196so10473562oiw.8;
        Sun, 16 Oct 2022 15:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbWnEAg2SsNDRgsWcVmOmhtdqCGa97ZPW4mtEP7xswI=;
        b=Z7wCrbACL8CIrlNvIBRAmaajuDRPNPs9+vpaZDUUxco8asE0BBnwzM4tKU0KHZ/VS6
         Qs0ebR0aeDyHB/DQIiPCcMdxq/zrLtphIwCJFgfgtnqRsTl9yK2Dz0x/iLczY0lfGV0l
         CF/nMyPzAQap5gxW35MYPW+mnTPLNgYph0V7X48hc4kFUkrjVojw9sNDbQ/idhb+EUI4
         YjWgfCB+955KYSZO+bnctDj2NQA522gc5Qjr9aXrHtZkt3gz2Su5H9mG6wMEI2qjYhcQ
         ftAC7j3xZucBoYj4PV+sUAxoMHKqp+O29yDjUEnWoHS5jpuT6x2m4R9DSy+g1AOjQkHR
         wcPA==
X-Gm-Message-State: ACrzQf0nSSlbhvBB+jXDusjHyL4YYu9rcPs0zX7cwjEbTIEMQZyF8j37
        J4L82brwdwpL/bA1FmRNwg==
X-Google-Smtp-Source: AMsMyM5DZEcLmoIsH9mR3NcXBcaWogJ6YxxwoyjU1pdlK/LhDADAEonvdWGthzXuvxjU3uP3KayFtQ==
X-Received: by 2002:a05:6808:2107:b0:354:6fd3:af02 with SMTP id r7-20020a056808210700b003546fd3af02mr3738887oiw.176.1665961103599;
        Sun, 16 Oct 2022 15:58:23 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bh19-20020a056808181300b0035468f2d410sm3662748oib.55.2022.10.16.15.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 15:58:23 -0700 (PDT)
Received: (nullmailer pid 3904630 invoked by uid 1000);
        Sun, 16 Oct 2022 22:58:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
        Tom Rix <trix@redhat.com>, linux-input@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        llvm@lists.linux.dev, Bjorn Andersson <andersson@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221015172915.1436236-2-caleb@connolly.tech>
References: <20221015172915.1436236-1-caleb@connolly.tech> <20221015172915.1436236-2-caleb@connolly.tech>
Message-Id: <166596080545.3896335.8438401170127513761.robh@kernel.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: input: document Qualcomm PMI8998 haptics driver
Date:   Sun, 16 Oct 2022 17:58:18 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Oct 2022 17:30:35 +0000, Caleb Connolly wrote:
> Add bindings for qcom PMIC PMI8998 haptics driver.
> 
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  .../bindings/input/qcom,pmi8998-haptics.yaml  | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/qcom,pmi8998-haptics.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/qcom,pmi8998-haptics.example.dtb: haptics@c000: 'qcom,wave-play-rate-us' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/qcom,pmi8998-haptics.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

