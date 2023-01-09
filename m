Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6614A6622C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbjAIKPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbjAIKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:14:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C4219294
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:14:06 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z5so6552300wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKCQUhm58zZMU1+N1NXsPah3RLRpFdffVr/EsdddpFY=;
        b=ckhYgBdaOObPp08TPqTFL7LDtCo3mvVO9nMROdG6iaHdh7Vmnz+KDmLvzMC3j+kXqr
         bGl+hEV9Vx4GS9/U9JSTG38wjjZS3JttcgkWmogv3YYYCCKi3whX1IYfr7TPfQ3i9z4U
         spe6stZTjC0IBRevcS/vLdR7NaZieS06dmJGsGI5YkG6Y+c84xvSw+T4dGP4pPavoLsx
         vGRs7/m3UY8IhY/GTbaxsj2wDAPgGwFYxQrniEZsOZfksv0JiPdgBBOJYGI82gm8E+lb
         HrQYOGsO7jVo9Oo9WMIT1YWSzGaQ7tSBLuEPOSLtk6jA6oS1LRDQ9jW3wxsSSouptbLx
         4j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKCQUhm58zZMU1+N1NXsPah3RLRpFdffVr/EsdddpFY=;
        b=K4JdXEgBUafplWq5FzIXBHcbTwfTPxX9PGePPwGIZrCT511hl8bR2qFMVsPbDgY1OS
         VLzhOiTDUl3KI2TKmQUrzpyTWE8b+TSSq+xYUPN4hnU6fwtU+SWrK4d9ZsKKSrHRkCFk
         dpKoefdKbg5REccP4eIqaqmubmDEKUr2KLib4mdryRDccnwxDWA6DRfrDTJz0dcDJYxC
         4WsN/l6Uqie5KEL2xf34fTnpGOA+9MsJWhqn82pRJm611VGIDq2B7BOWQ8fgCR4fAVk1
         YjcLUtkVkmTxH56K8jmUzeiGoNXOtNnYs9Bp/kA1dZTs2VLVMhZ6xfq3r+LNHcUM/8G1
         UbSw==
X-Gm-Message-State: AFqh2krr19RY4FZ6AR6pc210YGATbcaZpcn29nv0dF3fqsIXkkw8JwQP
        omjmqqGoEYVs5ynfRqfpk/dRDA==
X-Google-Smtp-Source: AMrXdXuppLG6yXIDwCzTHlmZxEUSt0/iBt0iREIXO/zIq2DPIPPsNImJeAsr6RgHanJAh5qw2Be6nA==
X-Received: by 2002:a5d:6b4e:0:b0:2ba:e1d9:37e7 with SMTP id x14-20020a5d6b4e000000b002bae1d937e7mr6995164wrw.18.1673259245274;
        Mon, 09 Jan 2023 02:14:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d55c5000000b002a6f329203esm8232130wrw.61.2023.01.09.02.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 02:14:04 -0800 (PST)
Message-ID: <3aa83ec3-228d-1add-5e4b-c100340b127e@linaro.org>
Date:   Mon, 9 Jan 2023 11:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings usb: typec: rt1718s: Add binding for
 Richtek RT1718S
Content-Language: en-US
To:     gene_chen@richtek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1673256674-25165-1-git-send-email-gene_chen@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1673256674-25165-1-git-send-email-gene_chen@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 10:31, gene_chen@richtek.com wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 

Subject: drop second, redundant "binding for".

> Add binding for Richtek RT1718s
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  .../devicetree/bindings/usb/richtek,rt1718s.yaml   | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1718s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1718s.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1718s.yaml
> new file mode 100644
> index 00000000..7797fc6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/richtek,rt1718s.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/richtek,rt1718s.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from both.

> +
> +title: Richtek RT1718S Type-C Port Switch and Power Delivery controller
> +
> +maintainers:
> +  - Gene Chen <gene_chen@richtek.com>
> +
> +description: |
> +  The RT1718S is a USB Type-C controller that complies with the latest
> +  USB Type-C and PD standards. It does the USB Type-C detection including attach
> +  and orientation. It integrates the physical layer of the USB BMC power
> +  delivery protocol to allow up to 100W of power. The BMC PD block enables full
> +  support for alternative interfaces of the Type-C specification.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rt1718s
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  wakeup-source:
> +    description: enable IRQ remote wakeup, see power/wakeup-source.txt

Drop description, you are copying generic description.

> +    type: boolean

Drop. Just wakeup-soource: true

> +
> +  connector:
> +    type: object
> +    $ref: ../connector/usb-connector.yaml#

Full path, so /schemas/usb/connector ....

> +    description:
> +      Properties for usb c connector.

That's not accurate description. Everything in properties is a property,
so no need to say that properties are properties.

Actually this looks the same as existing rt1711, so please do not
duplicate stuff. Especially, do not duplicate mistakes...

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - connector
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/usb/pd.h>
> +    i2c0 {

i2c

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rt1718s@43 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Best regards,
Krzysztof

