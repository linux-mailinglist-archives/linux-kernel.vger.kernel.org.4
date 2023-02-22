Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D48169F095
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjBVIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjBVIoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:44:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2BF311C2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:44:53 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t15so7025245wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ja0PIExg7QtVH8CkMZQt+gow5bQ/IjTXAb1rvOQO5SE=;
        b=n3aTRm08QWqkCXP6vWRdaQXRkdjlZsw1/FZSbNhF5J2z38ZrYuFSqUuDpdsxR6Rl9U
         4ln0hp9gHLzfu91SseG8N2Fmmmdd0uoRNqJl8LrmS2mYCSGPUvdqjwL/Un1kbTjwYUdQ
         ckCovcEjCdsmNVQVuB23xCWDuQASxGOCB9x2KFWxyEvqxOOmnyRMzuPoigQJ/bCBbycD
         7o30YI4FgReuJWZuSjZImRX2Pb+DYHPg2ENcUAd5nuEAgz72e3jtG1/5wIZrqiNmzaTO
         LULu8Ai4TeFabQ+clEZqlOhMdlsh+5rzg+uu95PBNi5J8p5ad/1pG2JhIDSv/E0V4ChW
         q0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja0PIExg7QtVH8CkMZQt+gow5bQ/IjTXAb1rvOQO5SE=;
        b=qXbsM4pkeeFRD6e8sYRJ4bJNbnyh52NYHI+lesSrIPvXwPPyeVt1G9mtl686PCXFaU
         x47vmnlS/RWuGbrl//esMx05MMOwsxfIaNn1Qnl3EP9H4spfcuLyMV4iSFur9ZaZQsZh
         7g7b3x6xIUA0cM3Jbq4/4hJLdNt+c7vHKirl8NrN4rfKhWYk3br/Gbwxtbb99rNqp9uu
         kHlqWidlXUs8ZeAQVjF8uGvCzju1RrmL31W1okmyZXncuYIxrSJgWkahDOr34Qd0N0RQ
         ES/73vaNSaQOlufkx8EpFV0kMl2N9YEYtwMsD4GHhvknS2np1B0fMS60YHA5TgLp+OxD
         rK3Q==
X-Gm-Message-State: AO0yUKX4n53iVs7MfBVvxeimodxjQNrjHUJKuau33Hk/K5ysPjT7GPH7
        9Ra/7cmRu549EUgWvVBwWD91gw==
X-Google-Smtp-Source: AK7set/INtiIeiEqLq31GfS7NEouC9iSfOFGLmINDVsTxUJtiLClf3hIlMhSpnkMFZiPKAEgx/xM/w==
X-Received: by 2002:adf:fe07:0:b0:2c3:f0ed:4beb with SMTP id n7-20020adffe07000000b002c3f0ed4bebmr4635634wrr.70.1677055492115;
        Wed, 22 Feb 2023 00:44:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a5-20020a05600c224500b003dc1a525f22sm4428625wmm.25.2023.02.22.00.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 00:44:51 -0800 (PST)
Message-ID: <ef019382-61a8-c663-773b-21791413889d@linaro.org>
Date:   Wed, 22 Feb 2023 09:44:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 2/3] dt-bindings: net: bluetooth: Add NXP bluetooth
 support
Content-Language: en-US
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        alok.a.tiwari@oracle.com, hdanton@sina.com,
        ilpo.jarvinen@linux.intel.com, leon@kernel.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-serial@vger.kernel.org, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
References: <20230221162541.3039992-1-neeraj.sanjaykale@nxp.com>
 <20230221162541.3039992-3-neeraj.sanjaykale@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221162541.3039992-3-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 17:25, Neeraj Sanjay Kale wrote:
> Add binding document for NXP bluetooth chipsets attached over UART.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Resolved dt_binding_check errors. (Rob Herring)
> v2: Modified description, added specific compatibility devices, corrected indentations. (Krzysztof Kozlowski)
> v3: Modified description, renamed file (Krzysztof Kozlowski)
> v4: Resolved dt_binding_check errors, corrected indentation. (Rob
> Herring, Krzysztof Kozlowski)
> ---
>  .../bindings/net/bluetooth/nxp,w8987-bt.yaml  | 38 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp,w8987-bt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,w8987-bt.yaml
> new file mode 100644
> index 000000000000..de361ce4ab73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,w8987-bt.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth/nxp,w8987-bt.yaml#

I think list of compatibles changed... now they are nxp,88w8987-bt, so
shouldn't the filename be "nxp,88w8987-bt.yaml"?

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP Bluetooth chips
> +
> +description:
> +  This binding describes UART-attached NXP bluetooth chips.
> +  These chips are dual-radio chips supporting WiFi and Bluetooth.
> +  The bluetooth works on standard H4 protocol over 4-wire UART.
> +  The RTS and CTS lines are used during FW download.
> +  To enable power save mode, the host asserts break signal
> +  over UART-TX line to put the chip into power save state.
> +  De-asserting break wakes-up the BT chip.
> +
> +maintainers:
> +  - Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,88w8987-bt
> +      - nxp,88w8997-bt
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    uart2 {

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

