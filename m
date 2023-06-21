Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFEA73902F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjFUThG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjFUThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:37:04 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469E81726;
        Wed, 21 Jun 2023 12:37:03 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-77e3f25446bso104462839f.1;
        Wed, 21 Jun 2023 12:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376222; x=1689968222;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yXwTNcT3p5TlhcI5K0peTsLgCwCNEi2f6S+CEMJ2sTo=;
        b=j4P99z3bcxv6rjRgStscMh+spK8HpN4FARSzKG+kEp/zJ3gVdH6zgUhT5nZEqndXEp
         TSgc76dJVliW5FrFgpqJV8QUOcjpfCQZXhK/GKjUXNj5Qbrf4wdi/LnFuWRmbqIoWz1x
         5tzE4sHJDYeYYgdBrDQOtb81SRI5Hl6lOpPtae40kY1R+aIjnsRgHbJe7rrNCAkYxV63
         eksMlftmZVVzcfkBC769wenM/5bkFksXDBVAaiCPnLA2ACVnGtoek0NMT/3iz2VEQmZX
         eKSUNORV/+XhnJbCRv+zXGd+txcPIHa4glocXa5yLAqlmuq+krfUN40eoLGAS4QnXloq
         buVw==
X-Gm-Message-State: AC+VfDxmy1fuod8G9WCfZeIMtmm+jvYnlyNQyYBsmZ718eHY19Mm0uOr
        UEV+8pfBFJAdxWo7UPZJ6g==
X-Google-Smtp-Source: ACHHUZ7pZNivx0IhDNQ9nDhjzEyELHZSbzYnnRqjMifeP5v8EyJiXJcFjsNioffrMb2HtT/wGPcrgA==
X-Received: by 2002:a05:6602:1613:b0:780:ba85:f475 with SMTP id x19-20020a056602161300b00780ba85f475mr1696474iow.3.1687376221384;
        Wed, 21 Jun 2023 12:37:01 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id dq35-20020a0566384d2300b0040fad79ac08sm1526742jab.89.2023.06.21.12.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:37:00 -0700 (PDT)
Received: (nullmailer pid 3403581 invoked by uid 1000);
        Wed, 21 Jun 2023 19:36:57 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        thierry.reding@gmail.com, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, lee@kernel.org, pavel@ucw.cz,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, agross@kernel.org,
        u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, conor+dt@kernel.org
In-Reply-To: <20230621185949.2068-2-quic_amelende@quicinc.com>
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-2-quic_amelende@quicinc.com>
Message-Id: <168737621686.3403500.14671930652655583051.robh@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Date:   Wed, 21 Jun 2023 13:36:57 -0600
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


On Wed, 21 Jun 2023 11:59:45 -0700, Anjelique Melendez wrote:
> Add binding for the Qualcomm Programmable Boot Sequencer device.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  .../bindings/soc/qcom/qcom-pbs.yaml           | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml:26:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230621185949.2068-2-quic_amelende@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

