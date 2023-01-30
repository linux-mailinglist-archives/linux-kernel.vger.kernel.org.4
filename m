Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E534B681C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjA3VGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjA3VF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:05:59 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAFA49006;
        Mon, 30 Jan 2023 13:05:37 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1631b928691so16791574fac.11;
        Mon, 30 Jan 2023 13:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bDd1jgGPleNHLSh/W4VrKXbMGb3ktlbueVN9qKBZG4=;
        b=2nOABbYcEvw1N/2dIe0umGsl1eCE9s7+ZKKIp91bZVvt0cDk9mR8vGCjMlGV7Djs/V
         akIoYsgQYLmAaYO5KifjBaarV+0zFT6nxzo7eRYXREgxMR9Utmle9OUZ+5x6dXd5bk39
         b7pqUdyas+rFpB7TIy0wbnE9cdPZsxH6GGytpmfsVmOioQZtnMJXE6pqNfWfKDCEDwex
         xKJ8BHzx/UsPXHi04yHxdQ1and5TWOEJkhvFJ9QJMlDyrjrRIDCLlnhrEMvvzUXl7+gm
         7i8OM8z6CInUpbQYS9MrU/xMJnb/bjjKTEbGAtIPW2z/09ee95zayu7WnPAqfLmV676D
         iSdQ==
X-Gm-Message-State: AO0yUKWZzMZFDyHuaVFVJLRe5yGyRq6jL7O2kPrO0yNUk/t5WeBeZOQ8
        d0VETRrgoRF7bSPsoZ/FFQ==
X-Google-Smtp-Source: AK7set8W5VSaITyoezV5/0tyHz+aNDmkc87eJvP+VEyOzUsiTylWRDvv7advZGMcm8ohCJ5LGJO+dQ==
X-Received: by 2002:a05:6870:8089:b0:163:1f0b:d84c with SMTP id q9-20020a056870808900b001631f0bd84cmr6115127oab.1.1675112732231;
        Mon, 30 Jan 2023 13:05:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870e0c700b001636786f7absm4811365oab.43.2023.01.30.13.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:05:31 -0800 (PST)
Received: (nullmailer pid 3351739 invoked by uid 1000);
        Mon, 30 Jan 2023 21:05:30 -0000
Date:   Mon, 30 Jan 2023 15:05:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM
 interface
Message-ID: <20230130210530.GA3339716-robh@kernel.org>
References: <20230127184650.756795-1-luzmaximilian@gmail.com>
 <20230127184650.756795-4-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127184650.756795-4-luzmaximilian@gmail.com>
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

On Fri, Jan 27, 2023 at 07:46:49PM +0100, Maximilian Luz wrote:
> Add bindings for the Qualcomm Secure Execution Environment interface
> (QSEECOM).
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
> 
> Changes in v2:
>  - Replaces uefisecapp bindings.
>  - Fix various dt-checker complaints.
> 
> ---
>  .../bindings/firmware/qcom,qseecom.yaml       | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml b/Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml
> new file mode 100644
> index 000000000000..540a604f81bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/qcom,qseecom.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/qcom,qseecom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Secure Execution Environment Communication Interface
> +
> +maintainers:
> +  - Maximilian Luz <luzmaximilian@gmail.com>
> +
> +description: |
> +  QSEECOM provides an interface to Qualcomm's Secure Execution Environment
> +  (SEE) running in the Trust Zone via SCM calls. In particular, it allows

SCM is SMCCC or something else?

> +  communication with secure applications running therein.
> +
> +  Applications running in this environment can, for example, include
> +  'uefisecapp', which is required for accessing UEFI variables on certain
> +  systems as these cannot be accessed directly.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,qseecom-sc8280xp
> +      - const: qcom,qseecom
> +
> +  qcom,scm:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description:
> +      A phandle pointing to the QCOM SCM device (see ./qcom,scm.yaml).
> +
> +required:
> +  - compatible
> +  - qcom,scm
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +        scm {
> +            compatible = "qcom,scm-sc8280xp", "qcom,scm";
> +        };
> +        qseecom {
> +            compatible = "qcom,qseecom-sc8280xp", "qcom,qseecom";
> +            qcom,scm = <&scm>;

Why do you need this in DT? If you already know you have a firmware 
interface (via "qcom,scm"), then query the firmware to see if the SEE is 
there.

Rob
