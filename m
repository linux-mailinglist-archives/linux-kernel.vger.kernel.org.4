Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4001270009F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbjELGgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbjELGgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:36:07 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDBF900E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:35:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso17485899a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683873345; x=1686465345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTgXqw1DQiVxfPuVhpWdkrrVopkfZHC/fCmNPR7iEmw=;
        b=ijv3t4S3+ROAAhh3+bMTEFjg8ZUs0YTiAc26pykuzAxOzjR650GGOHIszIsTKdv7e5
         edv36KAU1FW9cjS/WYMJE0jPX7q5yM8aQ9L5YFjmhZdf8/6CFq66g92PZpppWqtwz5Pt
         eXDtMApIONch2DReTW+6j82CFZUFBjejQLutd92NFxkn8yWuqUdqFE2loxb/zZR6bpwn
         iZ52Rcj9yFx3f1+Q3dDVYZMbRS1RHIsO2liVGRLBHX/MVUkU1dqa3yk+/uCta83fxNRZ
         LxfDrwse6A/Fmx4Y7mOm29/3hUb09AOOVTuVSBfRCY4CwU9CvV6C1XmZNV85Wtit0aYS
         1FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683873345; x=1686465345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTgXqw1DQiVxfPuVhpWdkrrVopkfZHC/fCmNPR7iEmw=;
        b=MFRmwajFa5Ms/Y4Q89FeTI3EEX9NnPRB9ibyDFtwv/jCxElJB0n+gZFdqowzKJt/Rw
         cXpELP0f/EYJqBsnupyFGxNj9Ce3gRNP062+ibwJCnanNn6OYswcE6xjkDDSKBITWn5G
         6KBM9tDUF72zvwFoW1w9AtRedsuafZZmbjmone0lW9Ba3Wf+71dkYRJhAN0pu/I9PCnf
         NXAud4fHTgJClMnop/SPsIc8DfieDwNPOYYuHD8HDBDgVd3l+aqclLpM93DT/8cCn68g
         Jyj5smOUyZiHgUrbihLkPbDhJY2cejOjJI67UWkzfc/aeOlSuQEqwMmmv/AVN8A9TLXE
         R4RQ==
X-Gm-Message-State: AC+VfDxeY2RiNJJPSCDVbLKZvSd/Bv3WsgNXuVWfp9ifQid5kq8L2Y/g
        0mLUaRy0wxSUUM6eLdQqV7tEcw==
X-Google-Smtp-Source: ACHHUZ73iH41QdZJrSGj6lKTg012fYOj2ZUG7b/uT7YMwaVbxaR4Hzc92pN9p2zKO81JafHjkbcmUw==
X-Received: by 2002:aa7:cf16:0:b0:50b:f654:8846 with SMTP id a22-20020aa7cf16000000b0050bf6548846mr18432311edy.19.1683873345196;
        Thu, 11 May 2023 23:35:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id d16-20020a056402001000b0050dfd7de30dsm1100820edu.94.2023.05.11.23.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 23:35:44 -0700 (PDT)
Message-ID: <2fb8c88a-dab5-791b-eefe-c983decad5e8@linaro.org>
Date:   Fri, 12 May 2023 08:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 5/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-6-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512022036.97987-6-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 04:20, Xingyu Wu wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> Add documentation to describe StarFive System Controller Registers.
> 
> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

You made significant changes. Explain them in changelog here and drop
the tag.

> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 67 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> new file mode 100644
> index 000000000000..26dc99cb0c89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 SoC system controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +description: |
> +  The StarFive JH7110 SoC system controller provides register information such
> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: starfive,jh7110-sys-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - enum:
> +              - starfive,jh7110-aon-syscon
> +              - starfive,jh7110-stg-syscon
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-controller:
> +    $ref: /schemas/clock/starfive,jh7110-pll.yaml#
> +    type: object
> +
> +  "#power-domain-cells":
> +    const: 1

Add it to the existing examples.

This part confuses me... why aon appeared here?  Why power-controller
disappeared? I don't think that Rob or me proposed any of this.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: starfive,jh7110-aon-syscon
> +    then:
> +      required:
> +        - "#power-domain-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@10240000 {
> +        compatible = "starfive,jh7110-stg-syscon", "syscon";
> +        reg = <0x10240000 0x1000>;
> +    };
> +
> +    syscon@13030000 {
> +        compatible = "starfive,jh7110-sys-syscon", "syscon", "simple-mfd";
> +        reg = <0x13030000 0x1000>;

Why simple-mfd? You do not have any children here.



Best regards,
Krzysztof

