Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FDC6C0182
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCSMT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCSMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:19:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3C215CAA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:19:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t5so35472edd.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679228389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkW9yYShKyhPgZwZHe04L+u1EHErHafgr+Lv/oT1Nrs=;
        b=Wjp4bMgpX09kQOMY65tynzOZrudfiPiWlTF4mKbnfFExy0bjiKjMqP06U07NQ6F5EW
         NUufqqkqnvSP4nuouSRkb9Dz/0olEERiaMrjgXL/oHOpWhFotQh9s/wtDghBbMpgtzMZ
         jLGHbe94fnsy+0gG30lyeYi0w6iSnYAAsHwCOtWM5TBV9FpZNLKzL6jfmAQHGw7LRzl1
         /JNxL6f3vyHH2MObrvym8yzWYrORAjAvJQW6XE+gZbjoE2BBFLNvbUaKDhCSNdfpF4YF
         KFkBXSbYgpSDhrzkgAok5ep2JxavqJ04+PnK1vooJLpaC0nj5lCe8aHNkCjGTMrwc1Y3
         QMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679228389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkW9yYShKyhPgZwZHe04L+u1EHErHafgr+Lv/oT1Nrs=;
        b=hXUBDJtFj9//PP5hEShM8szLr2igf3MgR/kyIQbyhz257dpZTAmBe4G8GR2GF0eWlY
         BUrUVoNlbJvZnEoNM82399dlEPxdVd+0JKUeQDNAhm1TPLRYmkwaSDuU15W/Cyzywq3j
         eWiViHvi+IUTiS4P9RJBzuvVoyqQ4pltjnLyiZqvTI3xXiwywmtFJwVChi0r6IrsdzAC
         w7orKC/HlZhX8O6tjR17PVF1FaV2o9u4iZXUZOIdf/pu3Od+SQj0rAa+YU8U9VFTjI67
         H229P4bFso0+Y2xRRXq/KiWnYmRSye6SOdCyKLMZb8C5/1ARUtA+DYr6svLpqza7VCBo
         lpTw==
X-Gm-Message-State: AO0yUKU8Yk6fAOSAshXrFTWIMr0LWc0Zalchiy3I50p+Kt7d1PRKdVzt
        /SjxPaxWZcr0cSq+H1ceALhrPA==
X-Google-Smtp-Source: AK7set9y5oC5PJn3CKLtdsyKS6tXuqCeSXG7y/nobmgBG7n5X9r+yejEzKHVCkXB5WA9CHxGZ7vHSA==
X-Received: by 2002:a05:6402:4cf:b0:4fb:223a:76e7 with SMTP id n15-20020a05640204cf00b004fb223a76e7mr9372378edw.18.1679228389594;
        Sun, 19 Mar 2023 05:19:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id s30-20020a50ab1e000000b004c5d1a15bd5sm3435919edc.69.2023.03.19.05.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:19:49 -0700 (PDT)
Message-ID: <10a850be-b04e-90db-cacb-127ac7698d97@linaro.org>
Date:   Sun, 19 Mar 2023 13:19:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V4 1/6] dt-bindings: usb: usbmisc-imx: convert to DT
 schema
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20230317123708.337286-1-peng.fan@oss.nxp.com>
 <20230317123708.337286-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317123708.337286-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 13:37, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 


> +  '#index-cells':
> +    const: 1
> +    description: Cells used to describe usb controller index.
> +    deprecated: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usbmisc@2184800 {
> +        #index-cells = <1>;
> +        compatible = "fsl,imx6q-usbmisc";
> +        reg = <0x02184800 0x200>;

If there is going to be resend, put compatible first, reg second. Then rest.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

