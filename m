Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C636B9A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCNPwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCNPwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:52:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F1AB3713
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:52:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so12262854edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678809122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYIpQBLdwPc6gKjUmGEA5s6ReqUwSq2hqFUeM5rzOMM=;
        b=MElNr5ac6DZENP4bIdXUnxxnFRTiCCpsM0pfISnhOSZk/ontRmuKehe1b2blycmOzG
         Cjd5fXYI/B4MobMpWlfeItv7EfEpFUBhKONrfUoYxqoYVZhlmoYfnfIMSyPtdoQyoQ7d
         eVSb+e+6Hdg5mZiNbC7DzU/TvBs0Ue9QcjsbEUIg5dmnn1zW8AvrkPkHpr8XD6P96wSo
         8sUwUeyuqx0HMyRDuAKAA8L9HgZIn98c4XSzC/UGIfK/A1hxLLrYKPXoOKUPDTYTIehS
         ZNlqydne3ShMwRpPTMyRMKGwnQZWmBBA7Ok09bdLNsFQOewQ0WQyJyEDql20zQ/brilR
         J/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678809122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYIpQBLdwPc6gKjUmGEA5s6ReqUwSq2hqFUeM5rzOMM=;
        b=YWCvl82Cell5Zu3a4vbtYzW6KdXcKmH6O9djgoA7cxAXjhnnzVTF8kmLUhJQcOi7+i
         npbNutoJYioIDazh5RjtmBuH4rFrsrl8nSsNpTrtbC2ff4Ysl72BxCongdmZ53AzP6fR
         ol3aI6Azx5Wm8k89PSDTR9hyrDvNI4z07ud1QWHngtxcdIN8SiNcDX6POX7Z5g8xB3+g
         yO3wHQF0Ws/Tp2LcrbFKN0d2Sy3aHUJJXj0HBRvfr8QMBFoH4GpVaccVWeIprnWWpyTo
         fbHFDji+tcnDl3EU6UL0Scxz2aevMODgfv1Jxjgpj20xBLi94NxCVf0X2sLmADhbciHc
         Jrnw==
X-Gm-Message-State: AO0yUKWT4nB1ndMKAdV1tWCh5JpCEFIL+dwnVJtCHLmmKh7QBSsPEla3
        oeeDSKoc8wMIdD3Iu2hJXElUBg==
X-Google-Smtp-Source: AK7set+U4XUbooucF/dDjekfDi7yZIhNFgJAuxmyC5clGg0B41Sd5Pjm71N42E9+zNpHKm7VQUeesw==
X-Received: by 2002:a17:906:1114:b0:91f:9024:bbab with SMTP id h20-20020a170906111400b0091f9024bbabmr2594280eja.23.1678809122409;
        Tue, 14 Mar 2023 08:52:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090651cc00b008e938e98046sm1303273ejk.223.2023.03.14.08.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 08:52:01 -0700 (PDT)
Message-ID: <5d074e6b-7fe1-ab7f-8690-cfb1bead6927@linaro.org>
Date:   Tue, 14 Mar 2023 16:52:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net-next V7] dt-bindings: net: xlnx,axi-ethernet: convert
 bindings document to yaml
Content-Language: en-US
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     michal.simek@xilinx.com, radhey.shyam.pandey@xilinx.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anirudha.sarangi@amd.com, harini.katakam@amd.com, git@amd.com
References: <20230308061223.1358637-1-sarath.babu.naidu.gaddam@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308061223.1358637-1-sarath.babu.naidu.gaddam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 07:12, Sarath Babu Naidu Gaddam wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> 
> Convert the bindings document for Xilinx AXI Ethernet Subsystem
> from txt to yaml. No changes to existing binding description.
> 

(...)

> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,axi-ethernet-1.00.a
> +      - xlnx,axi-ethernet-1.01.a
> +      - xlnx,axi-ethernet-2.01.a
> +
> +  reg:
> +    description:
> +      Address and length of the IO space, as well as the address
> +      and length of the AXI DMA controller IO space, unless
> +      axistream-connected is specified, in which case the reg
> +      attribute of the node referenced by it is used.

Did you test it with axistream-connected? The schema and description
feel contradictory and tests would point the issue.

> +    maxItems: 2
> +
> +  interrupts:
> +    items:
> +      - description: Ethernet core interrupt
> +      - description: Tx DMA interrupt
> +      - description: Rx DMA interrupt
> +    description:
> +      Ethernet core interrupt is optional. If axistream-connected property is
> +      present DMA node should contains TX/RX DMA interrupts else DMA interrupt
> +      resources are mentioned on ethernet node.
> +    minItems: 1
> +
> +  phy-handle: true
> +
> +  xlnx,rxmem:
> +    description:
> +      Set to allocated memory buffer for Rx/Tx in the hardware.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  phy-mode:
> +    items:
> +      - description: MII
> +      - description: GMII
> +      - description: RGMII
> +      - description: SGMII
> +      - description: 1000BaseX

I have doubts you tested it... Since when this is a list? How does it
exactly work and what do you want to show here?

connection type is enum.


> +    minItems: 1
> +
> +  xlnx,phy-type:
> +    description:
> +      Do not use, but still accepted in preference to phy-mode.
> +    deprecated: true
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  xlnx,txcsum:
> +    description:
> +      TX checksum offload. 0 or empty for disabling TX checksum offload,
> +      1 to enable partial TX checksum offload and 2 to enable full TX
> +      checksum offload.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +
> +  xlnx,rxcsum:
> +    description:
> +      RX checksum offload. 0 or empty for disabling RX checksum offload,
> +      1 to enable partial RX checksum offload and 2 to enable full RX
> +      checksum offload.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +
> +  xlnx,switch-x-sgmii:
> +    type: boolean
> +    description:
> +      Indicate the Ethernet core is configured to support both 1000BaseX and
> +      SGMII modes. If set, the phy-mode should be set to match the mode
> +      selected on core reset (i.e. by the basex_or_sgmii core input line).
> +
> +  clocks:
> +    items:
> +      - description: Clock for AXI register slave interface.
> +      - description: AXI4-Stream clock for TXD RXD TXC and RXS interfaces.
> +      - description: Ethernet reference clock, used by signal delay primitives
> +                     and transceivers.
> +      - description: MGT reference clock (used by optional internal PCS/PMA PHY)
> +
> +  clock-names:
> +    items:
> +      - const: s_axi_lite_clk
> +      - const: axis_clk
> +      - const: ref_clk
> +      - const: mgt_clk
> +
> +  axistream-connected:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle of AXI DMA controller which contains the resources
> +      used by this device. If this is specified, the DMA-related resources
> +      from that device (DMA registers and DMA TX/RX interrupts) rather than
> +      this one will be used.
> +
> +  mdio:
> +    type: object
> +
> +  pcs-handle:

maxItems: 1

> +    description: Phandle to the internal PCS/PMA PHY in SGMII or 1000Base-X
> +      modes, where "pcs-handle" should be used to point to the PCS/PMA PHY,
> +      and "phy-handle" should point to an external PHY if exists.

Best regards,
Krzysztof

