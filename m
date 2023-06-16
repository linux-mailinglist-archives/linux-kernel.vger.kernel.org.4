Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CD5733211
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjFPNVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFPNVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:21:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEA630C5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:21:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98377c5d53eso97909966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686921670; x=1689513670;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SI6dl8UqSr36BkzgDyYr2xy1n3KiQ9Y+vgjSNSYf4ZU=;
        b=UL3epjgrjoqFMfoQARineB80MJ8F7lbZYLcXrJ4j9jcginPg8UqtTIyJEvbrgGztL9
         hhRFtpUwvGBOo9IrlWFqFzB/Uk1P1lIDC0y1cSXvdnjjO3vxMGYG8L7LLAviSO+VmRaR
         z91M6nr2tifNidHQnvY1Qt2bhYvVx2aqLkkI0d88hLlYnDVofosTDHbJcNkm++n4ZUVs
         mig0UGtelrQBcT1HOd01+yakZUEYc1C4RIy4WkfeFnCfE3WCrKY9H+CcGBkLhdM1bz3u
         rp6tWbHy/yQLwSrSTr+tq6vQybcuXXJf5JT6t1X5pv9qjT9xnW/duCEDF2p+hr8KghrN
         UVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686921670; x=1689513670;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SI6dl8UqSr36BkzgDyYr2xy1n3KiQ9Y+vgjSNSYf4ZU=;
        b=lCKABoDclFJxYxKKuTXRnH0dj3LPjmL15XB3FCW+btIUaVSXBSbaZq7zAJDOklptNx
         BO2/R8Ejt7pdvNZWNo+YCwF4Qzaowlq/BaZsOhVZFI4pwxmWMweoTSEpGZY8Secdeg4C
         /6R9sVpZyUUzH9BALInxXyhsIX1PndDd+wWooY2kLhQ4qBptyIuXqpCjBFsqG7atGqAC
         dQgSaME9WOwD2ICnKKug2rQTv7VG4IlIxIYzDVUOKC50l59kHe8kPlve9aQo9WNdoftE
         Wn4xBEwsyCTuBjED+kCNsQnIqbS3nKLi20Jkc4L+WGXmYE4otrDwGzbp/tC1uL2aLrX9
         +nmg==
X-Gm-Message-State: AC+VfDySnOzdBiriU2wQMXt+FZgcTm+rDe6I4F+QDUbGLVMv0FzXf3en
        1I9zFe2Vrp6sbr5vFfOpKB+zbQ==
X-Google-Smtp-Source: ACHHUZ5pzFujAPq2eOgIWzR0/4GJkk2JE7bT8npv7ypXkPUIxMHwvcY5Xdq8K8WjxbBqF+S1gs6l0g==
X-Received: by 2002:a17:907:1c19:b0:973:e5d9:d6ff with SMTP id nc25-20020a1709071c1900b00973e5d9d6ffmr1863776ejc.66.1686921670119;
        Fri, 16 Jun 2023 06:21:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w26-20020a17090652da00b00982d0563b11sm1402426ejn.197.2023.06.16.06.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 06:21:09 -0700 (PDT)
Message-ID: <a06dbb80-c9b2-3a57-cbc5-b18432b4029a@linaro.org>
Date:   Fri, 16 Jun 2023 15:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding doc
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gaurav.jain@nxp.com,
        linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
 <20230616181144.646500-2-pankaj.gupta@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230616181144.646500-2-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 20:11, Pankaj Gupta wrote:
> The NXP i.MX Message Unit enables two processing elements
> to communicate & co-ordinate with each other. This driver
> is used to communicate between Application Core and
> NXP HSM IPs like NXP EdgeLock Enclave etc.
> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>

I don't see reply to Daniel's concerns.

I don't see improvements here based on the previous review you received.
It seems you just ignored everything, right?

Limited review follows up because binding is not in the shape for
upstream. Do some internal reviews prior sending it.

> ---
>  .../bindings/arm/freescale/fsl,ele_mu.yaml    | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
> new file mode 100644
> index 000000000000..29e309a88899
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml

No underscores, filename based on compatibles.

> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,ele_mu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX EdgeLock Enclave MUAP driver

Drop driver.

> +
> +maintainers:
> +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> +
> +description: |
> +
> +  NXP i.MX EdgeLock Enclave Message Unit Driver.
> +  The Messaging Unit module enables two processing elements within the SoC to
> +  communicate and coordinate by passing messages (e.g., data, status and control)
> +  through its interfaces.
> +
> +  The NXP i.MX EdgeLock Enclave Message Unit (ELE-MUAP) is specifically targeted
> +  for use between application core and Edgelocke Enclave. It allows to send
> +  messages to the EL Enclave using a shared mailbox.
> +
> +  The messages must follow the protocol defined.
> +
> +                                     Non-Secure           +   Secure
> +                                                          |
> +                                                          |
> +                   +---------+      +-------------+       |
> +                   | ele_mu.c+<---->+imx-mailbox.c|       |
> +                   |         |      |  mailbox.c  +<-->+------+    +------+
> +                   +---+-----+      +-------------+    | MU X +<-->+ ELE |
> +                       |                               +------+    +------+
> +                       +----------------+                 |
> +                       |                |                 |
> +                       v                v                 |
> +                   logical           logical              |
> +                   receiver          waiter               |
> +                      +                 +                 |
> +                      |                 |                 |
> +                      |                 |                 |
> +                      |            +----+------+          |
> +                      |            |           |          |
> +                      |            |           |          |
> +               device_ctx     device_ctx     device_ctx   |
> +                                                          |
> +                 User 0        User 1       User Y        |
> +                 +------+      +------+     +------+      |
> +                 |misc.c|      |misc.c|     |misc.c|      |
> +  kernel space   +------+      +------+     +------+      |
> +                                                          |
> +  +------------------------------------------------------ |
> +                     |             |           |          |
> +  userspace     /dev/ele_muXch0    |           |          |
> +                           /dev/ele_muXch1     |          |
> +                                         /dev/ele_muXchY  |
> +                                                          |
> +
> +  When a user sends a command to the ELE, it registers its device_ctx as
> +  waiter of a response from ELE.
> +
> +  A user can be registered as receiver of command from the ELE.
> +  Create char devices in /dev as channels of the form /dev/ele_muXchY with X
> +  the id of the driver and Y for each users. It allows to send and receive
> +  messages to the NXP EdgeLock Enclave IP on NXP SoC, where current possible
> +  value, i.e., supported SoC(s) are imx8ulp, imx93.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx-ele
> +      - fsl,imx93-ele
> +
> +  mboxes:
> +    description:
> +      A list of phandles of TX MU channels followed by a list of phandles of
> +      RX MU channels. The number of expected tx and rx channels is 1 TX, and
> +      1 RX channels. All MU channels must be within the same MU instance.
> +      Cross instances are not allowed. The MU instance to be used is S4MUAP
> +      for imx8ulp & imx93. Users need to ensure that used MU instance does not
> +      conflict with other execution environments.
> +    items:
> +      - description: TX0 MU channel
> +      - description: RX0 MU channel
> +
> +  mbox-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  fsl,ele_mu_did:

No underscores. Drop all properties not related to hardware.


> +    description:
> +      Owner of message-unit, is identified via Domain ID or did.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3, 4, 5, 6, 7]

That's not the syntax you can find. Open example-schema and rewrite your
bindings.


> +
> +examples:
> +  - |
> +    ele_mu: ele_mu {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +      compatible = "fsl,imx93-ele";
> +      mbox-names = "tx", "rx";
> +      mboxes = <&s4muap 2 0
> +                &s4muap 3 0>;
> +      fsl,ele_mu_id = <1>;
> +      fsl,ele_max_users = <4>;
> +      fsl,cmd_tag = /bits/ 8 <0x17>;
> +      fsl,rsp_tag = /bits/ 8 <0xe1>;
> +    };

Best regards,
Krzysztof

