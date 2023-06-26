Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BBC73E153
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjFZN7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjFZN7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:59:37 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693EC1990;
        Mon, 26 Jun 2023 06:59:06 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-78362f57500so22532439f.3;
        Mon, 26 Jun 2023 06:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787940; x=1690379940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7arvl2nBBD5MstmpqoXDL1oSTmykovk9ay3oSDEsgug=;
        b=dozEU0O3YCd+c9Huqvu2YpHjkie8l1wO1iDsxbjHz93vA3sLC4JF2GoeXyEqAAJF1p
         Ao/o59sxJJf9vO9gMP6LGf6+nDxu8IOBpTzfptrbFk5g8Q4cjHGLerIq4mCWQYPQZJEj
         G365nEcy+b0jD2ZHJLtimM6O0cdTCgz+DUdgwb6GdAz5r2eYIA8lvJtlRMgurrvIeQlT
         sixj1t6euhqZBAfZ3Ld9wvPnsvOowhOZafe4vObuFpJhuChMyf+i+7p4MSezZueh1W+v
         buCLZ0ac2RlNqjRMLBXB+hqyjssZGfkMHSlNLB/fFF/nVUaAXf1NsSHPntOt2VHGIHuL
         ouaw==
X-Gm-Message-State: AC+VfDzcfLXfEG4kNE0za3A9mcVwVeCVVSWAg0/U5vIudrMpHuYEEYDI
        dIhBEUujzaJqyt+I7sOnQfmnS74xRQ==
X-Google-Smtp-Source: ACHHUZ4Dq6Kj4OVVjRedrWE2k0g0MD5IUWH7/vW1EM89UG+RgV5C4A4eanJhgKS3G0bH/Su3I5qiUg==
X-Received: by 2002:a5d:8f96:0:b0:780:c8a1:f86d with SMTP id l22-20020a5d8f96000000b00780c8a1f86dmr15362864iol.11.1687787939947;
        Mon, 26 Jun 2023 06:58:59 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r23-20020a5d96d7000000b00760e7a343c1sm2221814iol.30.2023.06.26.06.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 06:58:59 -0700 (PDT)
Received: (nullmailer pid 3121044 invoked by uid 1000);
        Mon, 26 Jun 2023 13:58:57 -0000
Date:   Mon, 26 Jun 2023 07:58:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     pavel@ucw.cz, lee@kernel.org, thierry.reding@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        u.kleine-koenig@pengutronix.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Message-ID: <20230626135857.GA3118929-robh@kernel.org>
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-2-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621185949.2068-2-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:59:45AM -0700, Anjelique Melendez wrote:
> Add binding for the Qualcomm Programmable Boot Sequencer device.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  .../bindings/soc/qcom/qcom-pbs.yaml           | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
> new file mode 100644
> index 000000000000..0a89c334f95c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom-pbs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. PBS
> +
> +maintainers:
> +  - Anjelique Melendez <quic_amelende@quicinc.com>
> +
> +description: |
> +  Qualcomm PBS (programmable boot sequencer) supports triggering sequences
> +  for clients upon request.
> +
> +properties:
> +  compatible:
> +    const: qcom,pbs
> +
> +  reg:
> +    description: |
> +      Base address of the PBS peripheral.
> +    maxItems: 1
> +
> +required:
> + - compatible
> + - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      qcom,pbs@7400 {
> +        compatible = "qcom,pbs";
> +        reg = <0x7400>;
> +      };

Why do you need a child node for this? Is there more than 1 instance in 
a PMIC? Every sub-function of a PMIC doesn't have to have a DT node.

Rob
