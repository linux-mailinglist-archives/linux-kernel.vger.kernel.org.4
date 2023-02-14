Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D756961F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjBNLHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjBNLHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:07:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02498274B1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:06:17 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bk16so15189622wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xC/enc1+3dAC9F4VSPgmL5u2+R8Ob6BnSNDwUJ8Loeg=;
        b=TcoMKfo65P2Mq7SCSI6eeLVdPQcV+nJHhEPLTCiP3wm8OeQqW8rmBlwqFzWFCUr0nS
         OPRJdZALmLtqlz2zlcUF4AwLJV9ONSspsSm+g5qdAZlKcTjBNSA3rPuRxG8mT9/CGRvN
         TXX3Dmy+qcpbzhFhUtURNL+Tm6hDN+2nrZ+EwB9ZfT4zSmY2bUW7Hu1JjaEq4JwW2HFs
         jNyVHwIY3p0XG47+aT3leIMCp3bQ8MLwYWEar+xTTP28R8fkx9dzkxzcpArTxZ/NBnvL
         TpSpyjxDeke7tTEBu+rqge0LC8SAdxMPvKh9xEYFuJGckjVfM/qm84RH2XMmgP4d64gn
         /ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xC/enc1+3dAC9F4VSPgmL5u2+R8Ob6BnSNDwUJ8Loeg=;
        b=hd0nO+axVFc9x0BPNnWwXvBEe2U/MT0lfGFOpwhLfDinn0bm1On4ExKTrrvbL+8RoF
         irGkjOdRQJPiCWb2bMENsCUqUK77oeYUHCNDllLX8r5GGE0koE4zyNR8osN7YpAdYl3F
         3yh2mYO62cvmbVasBAfxi7P2ESOHFZRvrKFfoxLdZ4KhkSavH1lYfdE2fLFekAsWzUTb
         yTcPrDKrx6vtsHij7I0Q1wcV+gAnNmu+tFrSlH6qOziBbZ/OpSodwZMp70CEI5fYkpKy
         PGFqCUrIZrItecF469y1tXLixdK6MtioGmHLaO/pHwucNxiUmVUKY+gKz6AbNz/hLzOU
         e3FQ==
X-Gm-Message-State: AO0yUKXBCkid3yGr9hN5idm941/IgExuXvyTYOe2uCGBkv8/r4JBJmLo
        DRRnvTp+KWKN9IipvZp70d6zgg==
X-Google-Smtp-Source: AK7set8lRW1LYIFVwoC+aZJuCc67pPRHEMEIC1jSo50Pg5xuxW3UPvpIAzwCwYJ5D9LFvEW9vWb0Yg==
X-Received: by 2002:a5d:4b41:0:b0:2c5:5298:893f with SMTP id w1-20020a5d4b41000000b002c55298893fmr2069989wrs.43.1676372773772;
        Tue, 14 Feb 2023 03:06:13 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q9-20020a5d6589000000b002c559405a1csm4498870wru.20.2023.02.14.03.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:06:13 -0800 (PST)
Message-ID: <c16693a0-d28f-b83f-e2b9-6e4451b68d7c@linaro.org>
Date:   Tue, 14 Feb 2023 12:06:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 05/16] dt-bindings: interrupt-controller: apple,aic2:
 Add apple,t8112-aic compatible
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
 <20230202-asahi-t8112-dt-v2-5-22926a283d92@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v2-5-22926a283d92@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 12:03, Janne Grunau wrote:
> The Apple M2 SoC uses AICv2 and is compatible with the existing driver.
> Add its per-SoC compatible.
> Since multi-die versions of the M2 are not expected decrease
> '#interrupt-cells' to 3 for apple,t8112-aic. This is seamlessly handled
> inside the driver.
> 

Thank you for your patch. There is something to discuss/improve.

>  
> -      The 2nd cell contains the die ID.
> +      The 2nd cell contains the die ID (only present on apple,t6000-aic).
>  
>        The next cell contains the interrupt number.
>          - HW IRQs: interrupt number
> @@ -110,6 +113,20 @@ additionalProperties: false
>  allOf:
>    - $ref: /schemas/interrupt-controller.yaml#
>  
> +if:

This should be under "allOf" (as next entry so "  - if:").

> +  properties:
> +    compatible:
> +      contains:
> +        const: apple,t8112-aic
> +then:
> +  properties:
> +    '#interrupt-cells':
> +      const: 3
> +else:
> +  properties:
> +    '#interrupt-cells':
> +      const: 4
> +
>  examples:
>    - |
>      soc {
> 

Best regards,
Krzysztof

