Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3096000B9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJPPeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJPPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:34:21 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E838A3B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:34:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o2so5350673qkk.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/HzaPuqNEIzv1PWmvD8WAnk/Y18nRQCpGE1l2eqH9ws=;
        b=cgmcMRxhVutyoZcVTfiJ9EOzfMYm69fP9mG0tNU5Vj9SWYd6wQ/BrVP0hjEHPnYuy7
         JybJDhxk9NjW4fA0UlweoG8ATmrTiTcZXuJYoLvZKLPpmwzYUyrWDX6VXc1/g1OvH6Hd
         NJkVG4XSnY6xWOSUaIqXqJi3fzC5kC7M4AeUqixo4r/e+OKsjaSfvlOyDWnbkYWa1NhK
         5Kf6ROPybvnEG1rAvVEXkace8tL+zgEphETag3XOiVpYTicT8HTpS4Fj9M0uKJ7yqex+
         BqKX4owVWKL5PhvPd5FnqpkRDFq3oGSGSxKXWZxpEX1CblEQuDCWnCA/jG9jMQjsNmA4
         LwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HzaPuqNEIzv1PWmvD8WAnk/Y18nRQCpGE1l2eqH9ws=;
        b=z7pP+5Q5IWqFDt4EvKKhpVRj14+PXE1yKnruOCKwlRxGujCMOv0q9aRA9HGKWnXaeg
         gR4xvW57NLsBv9ci6nqitrIUouTG/AUmRD2Pk7NieoUDWNg6chRgqv8pzoW/IbKiKr+n
         mXoxQ7y1OnXjL+DwL9k2sSeWMXbF5JSRef5mnhcDPkQEgYH7gBcH+pqxnPYVoGOLmZBp
         kbdsfs9yRUvGjZvIFnpnF9qDROgSNbVZt7iZAIEu+atIUbo4kzU5380ue3IUcHq3h7be
         k9iGyFNPBjbBno+RIpHC95+ZItjU6PnfjZw/l05q2uzEw006kZv0ySzE1rbTg+MnKnTf
         d4WA==
X-Gm-Message-State: ACrzQf10NhNbZPvFFXOJjj4/lbLFa+8jbCR9p5yt8hGbhovznLhkzLqM
        YbDmf+XCPV/uxJaYQVUKyMAUOw==
X-Google-Smtp-Source: AMsMyM4u3CYE3ChHbdxdMXGxFHg+maC17Gk9XqoktcgBmxSXQeYMvpMNCexAD8IGCLH39CBN2uVplg==
X-Received: by 2002:a05:620a:40d5:b0:6ee:e3f8:20d2 with SMTP id g21-20020a05620a40d500b006eee3f820d2mr1077035qko.14.1665934457113;
        Sun, 16 Oct 2022 08:34:17 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9b13:d679:7b5b:6921? ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006b61b2cb1d2sm7465845qkp.46.2022.10.16.08.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 08:34:16 -0700 (PDT)
Message-ID: <199bed73-676b-850f-fe1e-f144e1b2f314@linaro.org>
Date:   Sun, 16 Oct 2022 11:34:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V7 2/7] dt-bindings: remoteproc: imx_rproc: support
 i.MX8QM
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
References: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
 <20221014031037.1070424-3-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014031037.1070424-3-peng.fan@oss.nxp.com>
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

On 13/10/2022 23:10, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX8QM compatible
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index 70322e57b6ff..64e783234e38 100644
> --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> @@ -23,6 +23,7 @@ properties:
>        - fsl,imx8mp-cm7
>        - fsl,imx8mq-cm4
>        - fsl,imx8qxp-cm4
> +      - fsl,imx8qm-cm4

Keep alphabetical order.

>  

Best regards,
Krzysztof

