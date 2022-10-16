Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F39600406
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 00:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJPW6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 18:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiJPW6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 18:58:20 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6512132B9B;
        Sun, 16 Oct 2022 15:58:19 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id j188so10488728oih.4;
        Sun, 16 Oct 2022 15:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMcEKLfXHC8WJ/8bltP/oPm7ijzPBMVfJNcHQbbtBk4=;
        b=5NWGXJBh6bSFE9QNAb26hhjiJ4OJcCbGGGddDk4pgstJKttKTf3J2akzmgrNhkLN/0
         YRCUF2nJa4w0lpPLg2Uk9B1AYRZubYdJezj+Fo63ft2ZujvISRGD+0vPQQtxDGyyU13B
         iFCTDYNASznxaIkmOZmZx+i0okl6Z/R7ikuR8knWIzMriePvfM8G5bOACSrMB8It3Znc
         U4QYzlbFZTL6K5OUt/ITpK6TQLflRXVwg5IYUbuafEpUcuLQzuYI4Eha8tTGNzVllrQo
         Z0f3XnNS8aP95vOR5ayhUd9HYRo8LhxzQccMJm+g4UkmJAw0qOlDy9nfli2y60s60zg3
         i7yw==
X-Gm-Message-State: ACrzQf3HqnUjTbwz16uTIv88z3M3XfjbyPtpSiMRXYZS3SABTGAB8kyI
        rTeiunL2VhaFr8y4k58HqA==
X-Google-Smtp-Source: AMsMyM47PgOfX4a6lPlMXQ+9FQITCwnpDl6EyT85QPDJkXmddUdx8FkDK8hCRY5jZJ8NHfKlLhEdZg==
X-Received: by 2002:a05:6808:1305:b0:355:13bc:288c with SMTP id y5-20020a056808130500b0035513bc288cmr3763809oiv.213.1665961098459;
        Sun, 16 Oct 2022 15:58:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 52-20020a9d0bb7000000b006619f38a686sm4099451oth.56.2022.10.16.15.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 15:58:17 -0700 (PDT)
Received: (nullmailer pid 3904623 invoked by uid 1000);
        Sun, 16 Oct 2022 22:58:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>
In-Reply-To: <20221014221025.7372-2-quic_molvera@quicinc.com>
References: <20221014221025.7372-1-quic_molvera@quicinc.com> <20221014221025.7372-2-quic_molvera@quicinc.com>
Message-Id: <166596080219.3896198.11795282837604799595.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and QRU1000 pinctrl bindings
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

On Fri, 14 Oct 2022 15:10:24 -0700, Melody Olvera wrote:
> Add documentation details for device tree bindings for QDU1000 and QRU1000
> TLMM devices.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../pinctrl/qcom,qdu1000-pinctrl.yaml         | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.example.dts:23.26-59.11: Warning (unit_address_format): /example-0/pinctrl@03000000: unit name should not have leading 0s
Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.example.dtb:0:0: /example-0/pinctrl@03000000: failed to match any schema with compatible: ['qcom,qdu1000-pinctrl']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

