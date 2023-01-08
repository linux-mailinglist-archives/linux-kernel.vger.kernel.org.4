Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62EC661670
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 17:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjAHQMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 11:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAHQMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:12:43 -0500
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578D0BF7B;
        Sun,  8 Jan 2023 08:12:42 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id a9so3120514ilp.6;
        Sun, 08 Jan 2023 08:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8teZpMX/AWs2QjpEv7wY4LEscb/0Ty8X89Zcw0g9hMo=;
        b=p+EbRUKQ40qLz4pw8awoWrRZMiHh0R4FiXzS6MMChCb1g3BqYVzxKFNrLC7fXliVJG
         4d/+gBdgtW091MqJKyfcUEC5eEmb5rhW7VNzgVhmkG8aPjGo2YWv7qx/+2K8KKw7mL/7
         shUfLkPT3BO+VcwhYFwvPUqwftAbMfhvn4x0bsTlI+Ecq8fX+jNCY5u/kDFstFXwQazJ
         llRtP08iunQTpa8HBFWbQ6E3Qwn+9b0CFhQeUF6lGIOYTVOF6JE7im3nGvsZnfzXMor5
         K7ZJJ3vpKZc8pTakWJwPpEgJ5UYlTR/hfI/fc4zpM8xNA9LrNN2do3liboRcabwaBTIT
         0BEw==
X-Gm-Message-State: AFqh2kqhB0WQSVom/fIuuBsJBzQn+D8v8UMWCbHbxVt09JIuNCSo3Pl1
        5/SWJTBjOgHmpQuSCUuDkw==
X-Google-Smtp-Source: AMrXdXsh+wyp9brmOLk34MsmhoE7Wlfr0vPk0Zn2lLvmB4mnY8HkCOuW9t0+sRpCZ9pXGyjy/n+wVg==
X-Received: by 2002:a92:d1c1:0:b0:30d:899f:aed4 with SMTP id u1-20020a92d1c1000000b0030d899faed4mr6807116ilg.21.1673194361376;
        Sun, 08 Jan 2023 08:12:41 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8066:75:6f93:38f8:6103:1af0])
        by smtp.gmail.com with ESMTPSA id e10-20020a026d4a000000b0038ac4923addsm2051103jaf.53.2023.01.08.08.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 08:12:40 -0800 (PST)
Received: (nullmailer pid 10414 invoked by uid 1000);
        Sun, 08 Jan 2023 16:12:37 -0000
Date:   Sun, 8 Jan 2023 10:12:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 2/2] dt-bindings: soc: qcom: eud: Fix identation issues
 in the example
Message-ID: <20230108161237.GA7662-robh@kernel.org>
References: <20230104091922.3959602-1-bhupesh.sharma@linaro.org>
 <20230104091922.3959602-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104091922.3959602-3-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 02:49:22PM +0530, Bhupesh Sharma wrote:
> As noted by Konrad while reviewing [1], the example
> node in the EUD yaml documentation has identation
> issues.

I don't see any indentation changes...

> 
> So fix them.
> 
> [1]. https://lore.kernel.org/linux-arm-msm/20221231131945.3286639-1-bhupesh.sharma@linaro.org
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> index c98aab209bc5d..385ebd7cbbf0c 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> @@ -55,9 +55,10 @@ additionalProperties: false
>  examples:
>    - |
>      eud@88e0000 {
> -           compatible = "qcom,sc7280-eud","qcom,eud";
> -           reg = <0x88e0000 0x2000>,
> -                 <0x88e2000 0x1000>;
> +           compatible = "qcom,sc7280-eud", "qcom,eud";
> +           reg = <0 0x88e0000 0 0x2000>,
> +                 <0 0x88e2000 0 0x1000>;
> +
>             ports {
>                     #address-cells = <1>;
>                     #size-cells = <0>;
> @@ -67,6 +68,7 @@ examples:
>                                     remote-endpoint = <&usb2_role_switch>;
>                             };
>                     };
> +
>                     port@1 {
>                             reg = <1>;
>                             eud_con: endpoint {
> -- 
> 2.38.1
> 
> 
