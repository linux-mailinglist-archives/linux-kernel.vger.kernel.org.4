Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A566E7A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjDSNAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjDSM7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:59:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F74E6E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:59:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fw30so28647405ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681909190; x=1684501190;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWlUn9RPj7oCAxkFLPu/uGMxJCHc+uj0uh1OGsMgd2A=;
        b=NONTovJtvVwSovoyEbCQLG2Hnfjn2EKIijpUx/opxeHuZQIh0l+pmhIMxQIIEHV6LY
         EmzPUCP1NAWwKFiOUPFrA+NteqQISZcKVfTWnWEkJhyH2GuO/w2awano/WSPmIEPvKlg
         g+VLGyRNUnx79rcRgQmv+le+jfsSonHtFyTZkswU3BWP+QyLDjPsYiUJtOWZgJEi05FY
         vv13H4uvADdfeysxjwb/AslfM7RNSqCpzgiBrhGjXkyvEHPne0m59a6J1R+kULnkSM44
         ydPOlpKFCjs98Oq6fC42GCBchyjvEWJLCpsLma3UdRWmf0z44qYWNhMaH6YBVSaP5jyK
         6jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681909190; x=1684501190;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWlUn9RPj7oCAxkFLPu/uGMxJCHc+uj0uh1OGsMgd2A=;
        b=WFdH3HlNoirw983HuennxTvgfdNeNDFNcLhg8YICUlm/Xo6othITIArP/UAwHHxH8e
         xvN2css6UtDcKkvVh4Btyn2M5w8ZxeIc+JpXfav80UsB/q4V1skyI7IlDdr5j2W0oc9J
         vx37ooSSfCXcBnvq6XRXKFl6SxkpEdRKTMTTY/X6k/wBGGz0etoUFK34wbiwqoyVOt/A
         rqd7xUydIGeiyDYyyyYe3dYpnbNuePFxoTW2+gAkWYZfMfVdNCNiWQ1ogvVMJB424CPF
         turNPWDn6EUUkgPD8lNupqDOH31EVPFa2Xsx9sj05CDp8S20GpFl5RA7aVyqsNSooEjF
         u0GQ==
X-Gm-Message-State: AAQBX9cHTHb4xRzqEVhlfER3/GhxONvPIxbPb2OI0iEZQ3TX6T5PTdBV
        6lFZ2F/skO6r70yEwEWfJ6bDmQ==
X-Google-Smtp-Source: AKy350aGL+TUGbX3K8u+nRSnoaUvQaVNHNMps2pSOnBdgFfQfjsgDKY7qXVlcxXCbP4z4quLlkGHcQ==
X-Received: by 2002:a17:906:1317:b0:94a:6953:602d with SMTP id w23-20020a170906131700b0094a6953602dmr14580537ejb.37.1681909190375;
        Wed, 19 Apr 2023 05:59:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b7d8:d88b:1fac:c802? ([2a02:810d:15c0:828:b7d8:d88b:1fac:c802])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709064e5100b009534bfdac27sm934220ejw.137.2023.04.19.05.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 05:59:49 -0700 (PDT)
Message-ID: <6eacac77-b8dd-3651-0a37-7373a07adcb5@linaro.org>
Date:   Wed, 19 Apr 2023 14:59:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/7] doc: device tree binding addition for ele MU
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
References: <20230419175538.855493-1-pankaj.gupta@nxp.com>
 <20230419175538.855493-2-pankaj.gupta@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419175538.855493-2-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 19:55, Pankaj Gupta wrote:
> Documentation update with addition of new device tree
> for NXP ele-mu (Edgelock Enclave Message Unit), driver.


Your patchset is sent with wrong clock. Fix your system because now it
goes before all other patchsets...

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.


> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,ele_mu.yaml    | 139 ++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
> new file mode 100644
> index 000000000000..8c4cc32f62ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml

Underscores are not allowed.

> @@ -0,0 +1,139 @@
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

Drop stray blank line

> +  NXP i.MX EdgeLock Enclave Message Unit Driver.

Drop driver and rephrase it to describe hardware.

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
> +      List of <&phandle type channel> - 4 channels for TX, 4 channels for RX,
> +      1 channel for TXDB
> +    maxItems: 9
> +
> +  mbox-names:
> +    items:
> +      - const: tx
> +      - const: rx

This does not make sense. You have 9 items, not two. Unless you want
some customization.

> +
> +  fsl,ele_mu_did:

Underscores are not allowed.

> +    description:
> +      Owner of message-unit, is identified via Domain ID or did.
> +    allOf:

That's not how they this is written. Drop allOf. Please start from
example-schema.

Anyway, half of the properties here do not look like hardware
properties. You need to explain why these are board specific.

> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +
> +  fsl,ele_mu_id:
> +    description:
> +      Identifier to the message-unit among the multiple message-unit that exists on SoC.
> +      It is used to create the channels, default to 2
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3]
> +
> +  fsl,ele_max_users:
> +    description:
> +      Number of misclleneous devices to be created, default to 4
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
> +
> +  fsl,cmd_tag:
> +    description:
> +      Tag in message header for commands on this MU, default to 0x17

Don't repeat constraints in free form text. Use default:

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8
> +      - enum: [0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e]
> +
> +  fsl,rsp_tag:
> +    description:
> +      Tag in message header for responses on this MU, default to 0xe1
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8
> +      - enum: [0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8]
> +
> +required:
> +  - compatible
> +  - mboxes
> +  - mbox-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ele_mu: ele_mu {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Also, underscores are not allowed iin node names.

> +      compatible = "fsl,imx93-ele";
> +      mbox-names = "tx", "rx";
> +      mboxes = <&s4muap 2 0
> +          &s4muap 3 0>;

Fix indentation and number of items. These should be separate phandles,
not one phandle.

> +
> +      fsl,ele_mu_id = <1>;
> +      fsl,ele_max_users = <4>;
> +      fsl,cmd_tag = /bits/ 8 <0x17>;
> +      fsl,rsp_tag = /bits/ 8 <0xe1>;
> +    };

Best regards,
Krzysztof

