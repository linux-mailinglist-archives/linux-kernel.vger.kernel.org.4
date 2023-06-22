Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8FA73A37D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjFVOrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjFVOq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:46:59 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD9212C;
        Thu, 22 Jun 2023 07:46:31 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3420b22365fso33473465ab.1;
        Thu, 22 Jun 2023 07:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687445190; x=1690037190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMBFysAIHtFf8K9nvyV9q2jbJEw4yuc6x8Rv0sjnvNI=;
        b=jbe1P46BTir007qo3wcuGXiAV8f6xIuhVP3RTffNrdpYnTJV+FgjiwXpyTP8mW6D74
         ivRvuAGlYjgsIkXqF7AlpS009+zXSAt3adPYOeV36xxdGL0taY/Wv8BcK5oToNWx3Dx6
         nZP27M9CWaAHmuuHSV1fAqOSdU1eN3LS59SvLc2zlDEKm2hnA3VYcwkpmWN1N7fVtYbq
         LXEBgnRHIcnjOv8HT8vRsti+lunMPJP1mMH6mnRY4qkL/l18vDMijFaNmjyzg0zyb7ts
         Yp0Rw5z24wgLbTw1Eaq7Ysp0kPvR7vbL6cd2ggYLL63r0jmzTz17o902IK35hCyE1j+s
         fyAg==
X-Gm-Message-State: AC+VfDwA1Y5s2gzsa35qWHgajIBk4Mn3+bJNKxMC7PrnqUpsJ5ASZEcq
        Ljo3Glp+SBo+ACrwNxh1JA==
X-Google-Smtp-Source: ACHHUZ5T5ZwrQRIEi6+5DfyEG/ByZLrf2TzL/S8CzsTEPJIpIhLW1p4vaatqGIe+MUsMU+lOLlZ3HQ==
X-Received: by 2002:a05:6e02:5c5:b0:339:f011:77f5 with SMTP id l5-20020a056e0205c500b00339f01177f5mr18727841ils.12.1687445190529;
        Thu, 22 Jun 2023 07:46:30 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m10-20020a92d70a000000b0034221d8a8dbsm2030492iln.71.2023.06.22.07.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:46:29 -0700 (PDT)
Received: (nullmailer pid 1678247 invoked by uid 1000);
        Thu, 22 Jun 2023 14:46:27 -0000
Date:   Thu, 22 Jun 2023 08:46:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/6] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
Message-ID: <20230622144627.GA1672260-robh@kernel.org>
References: <cover.1687414716.git.quic_varada@quicinc.com>
 <4f4136a91b24d3ad35fa12bd19fe14b83da9affe.1687414716.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f4136a91b24d3ad35fa12bd19fe14b83da9affe.1687414716.git.quic_varada@quicinc.com>
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

On Thu, Jun 22, 2023 at 11:52:09AM +0530, Varadarajan Narayanan wrote:
> Document the M31 USB2 phy present in IPQ5332.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v1:
> 	Rename qcom,m31.yaml -> qcom,ipq5332-usb-hsphy.yaml
> 	Drop default binding "m31,usb-hsphy"
> 	Add clock
> 	Remove 'oneOf' from compatible
> 	Remove 'qscratch' region from register space as it is not needed
> 	Remove reset-names
> 	Fix the example definition
> ---
>  .../bindings/phy/qcom,ipq5332-usb-hsphy.yaml       | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> new file mode 100644
> index 0000000..ab2e945
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,ipq5332-usb-hsphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: M31 (https://www.m31tech.com) USB PHY

Put the URL in 'description'.

> +
> +maintainers:
> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
> +  - Varadarajan Narayanan <quic_varada@quicinc.org>

.org? It's .com everywhere else.

> +
> +description:
> +  USB M31 PHY found in Qualcomm IPQ5018, IPQ5332 SoCs.

Where's the IPQ5018 compatible?

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,ipq5332-usb-hsphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    maxItems: 1
> +    contains:

'contains' is not appropriate here. Drop.
> +      items:
> +        - const: cfg_ahb

Don't need both items list and maxItems. Really, you don't need 
'clock-names' at all because there is only 1 clock.

> +
> +  resets:
> +    maxItems: 1
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> +    usbphy0: ipq5332-hsphy@7b000 {

Drop unused labels.

> +    	compatible = "qcom,ipq5332-usb-hsphy";
> +    	reg = <0x0007b000 0x12c>;
> +
> +    	clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> +    	clock-names = "cfg_ahb";
> +
> +    	resets = <&gcc GCC_QUSB2_0_PHY_BCR>;

Whitespace errors in here.

> +    };
> +
> -- 
> 2.7.4
> 
