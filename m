Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5841A72DC31
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbjFMISr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbjFMISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:18:44 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DFF10D4;
        Tue, 13 Jun 2023 01:18:43 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-33e4e59da95so31618745ab.2;
        Tue, 13 Jun 2023 01:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644322; x=1689236322;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=010p2ncU2TBgCsruZkeKniXPWi4eQfnyzfwG0p9gV9w=;
        b=iFOAJpEgEnPObmFpZCI3RJ4nSRLIvYNWaGRO23YEeJmrfW6Dpz9DkYPZxJte/KeBUS
         NAQywMOLH17BfL9dtuHiOaIR2HDi5o+EdcdqW42tXcbCqswO4YVi7iB+TIv8OqTOM9bW
         eXmXixITCU/A/zQtTmt1YK8cWrMuGq17oCWskNvq000bHYH6g0CK2Ew/l1j4PXrEOFgj
         JLn9tZkaItdG44eM2MSrQFRljNVlOuRmWujkJ/CpN9IDON0kiwgQy889hXjtd0gwfbx7
         vqpsfC3GgDJzQFWnJFVx48r0ByLP7J3DWAejqwbGeIPOi+c2/cFzHx9pHeNB/ELmUR6c
         XQTA==
X-Gm-Message-State: AC+VfDyy8E3SkKXtp1j+QbdKCthgsPp+XSXxuIKYcN6bNpZWFzr/FfGq
        GM4Pdb9tO1NzgDzKY+SW1Njb45liww==
X-Google-Smtp-Source: ACHHUZ6QsqxrghT6d28iWxDrcHSOU63o6gg5G445ZZmZG6s4h2X9zZ0e3xyrzWicLvehiYy2E3Qlmg==
X-Received: by 2002:a92:cecc:0:b0:33b:795d:717b with SMTP id z12-20020a92cecc000000b0033b795d717bmr10196473ilq.16.1686644322608;
        Tue, 13 Jun 2023 01:18:42 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t8-20020a05663801e800b0041f4d47722csm3334464jaq.126.2023.06.13.01.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 01:18:42 -0700 (PDT)
Received: (nullmailer pid 969728 invoked by uid 1000);
        Tue, 13 Jun 2023 08:18:40 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v3-1-22c9973012b6@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v3-1-22c9973012b6@linaro.org>
Message-Id: <168664432034.969644.602446309099124440.robh@kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: connector: usb-connector: add a
 gpio used to determine the Type-C port plug orientation
Date:   Tue, 13 Jun 2023 02:18:40 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Jun 2023 09:55:54 +0200, Neil Armstrong wrote:
> On some platforms, the Type-C plug orientation is given on a GPIO line.
> 
> Document this optional Type-C connector property, and take the
> assumption an active level represents an inverted/flipped orientation.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/connector/usb-connector.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml: $defs:qcom-pmic-mpp-state:properties:qcom,paired: [{'description': 'Indicates that the pin should be operating in paired mode.'}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230601-topic-sm8550-upstream-type-c-v3-1-22c9973012b6@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

