Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372026A2332
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBXUkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBXUkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:40:07 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C4688CA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:40:05 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso228447wmp.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4VW0bY+tQ7qBRlij6Z6ZybJZXsOXPEM+BJQisL7ELM=;
        b=bbrlDa4mtUzHqegyfEVIVZQfs9f0LmN65sxaO5y+Apiv0NYTjRLpFcpZcEfcgn3IT9
         8wA+gDsQrhMGkocBqqLq1LziS6c80kOIBtYkvbiOSsvID8cuYLxO6bKh3ygeEinaDkuN
         fC0FrUyk44MZcxvyQaBy/g04zin1cTIG5gwVPXyKskAxLozHkgTBdycxuNFCzTHb7EBI
         624RENZQLScNpZRsqoqVBJr+GRxmqj2YW3xPwtH2JXaxrFKlYV9iezv6+EVss8msQl9a
         UjoS5MaouDrHf5CCl5j9rlHAUNDzCNddyDNDZSC6X+s/f1oEWmo9DG1gkr+d2YCOTaTo
         3ArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4VW0bY+tQ7qBRlij6Z6ZybJZXsOXPEM+BJQisL7ELM=;
        b=YYOMJ6XkmIBkT4L87xvyPECVtolUSRcvdHylmdB7VMP+2g5tzZSomvyuwAVdADU5kZ
         ffBqB0qRYxquPxUa5BjwfqBFLUTaTT2gFz97b3YPm/3V7HwGq1MMOQvI8cRO9Oxd0uZZ
         yU0ktE+FoM8YtqpozBnYWEmZD/UqCsaHM85IbLNvk2qr56OAO95mhJm7YT+T4R6utrgC
         C+3eYQq23X2dOV/S6LmAU+Zdac174yIbz7pf0uMy61lUeYo3e9bu9DLjHL1iNXgUMlnF
         XVMAUxsKdWKviPquiDqDPlgqVEyLnEcwHMIzLn4pBQ1paTkF6R22BE0EKOHsFvPD+ALO
         8yIw==
X-Gm-Message-State: AO0yUKXYwmIyWGiIdOguiGI2SLTAd8drrCdRVpJWld212wGrvgJvWDMO
        GLgURTKB8Pe/eKrAuEJb/sRnaQ==
X-Google-Smtp-Source: AK7set/qAqp6ILt2LJTVZ+bGyUxAFsmDCHB6nEHqZqLawSg2nP62iNB+CY5Z/OfaWEW/Vv868hE1Bw==
X-Received: by 2002:a05:600c:a4c:b0:3ea:e582:48dd with SMTP id c12-20020a05600c0a4c00b003eae58248ddmr3883537wmq.34.1677271204353;
        Fri, 24 Feb 2023 12:40:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d50cb000000b002c8ed82c56csm183015wrt.116.2023.02.24.12.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 12:40:03 -0800 (PST)
Message-ID: <b50ab99f-e307-3a66-9198-85a71b012e5e@linaro.org>
Date:   Fri, 24 Feb 2023 21:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/2] dt-bindings: PCI: dwc: Add snps,skip-wait-link-up
To:     Sajid Dalvi <sdalvi@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel-team@android.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230224195749.818282-1-sdalvi@google.com>
 <20230224195749.818282-2-sdalvi@google.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230224195749.818282-2-sdalvi@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 20:57, Sajid Dalvi wrote:
> When the Root Complex is probed, the default behavior is to spin in a loop
> waiting for the link to come up. In some systems the link is not brought up
> during probe, but later in the context of an end-point turning on.
> This property will allow the loop to be skipped.
> 
> Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> ---

Thank you for your patch. There is something to discuss/improve.

>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 1a83f0f65f19..0b8950a73b7e 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -197,6 +197,14 @@ properties:
>        - contains:
>            const: msi
>  
> +  snps,skip-wait-link-up:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      When the Root Complex is probed, the default behavior is to spin in a
> +      loop waiting for the link to come up. In some systems the link is not
> +      brought up during probe, but later in the context of an end-point turning
> +      on. This property will allow the loop to be skipped.

I fail to see how probe behavior is related to properties of hardware.
You describe OS behavior, not hardware. This does not look like
belonging to DT.


Best regards,
Krzysztof

