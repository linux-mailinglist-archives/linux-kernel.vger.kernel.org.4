Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5C67DF56
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjA0Ifn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjA0Ifl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:35:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590D4279B9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:35:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q10so4260863wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1MXSY3rxyZv7oYRMbdKewaRZvNjQ1La+QB0aVR9VI0=;
        b=qZ38EvBg8VptNiykWvMC1NbBDCBX9WyCSEFOzQAY+ivi/UGuMHCwxHziwMNyWRoqcN
         I0pmEdko6WdIMiq/1euNkB1XtVr3IpzVoQJDyKFlLXz3zo5f4ILHWShDLe7OhV7KKLUU
         AfmEHvybUrHuURy+ijAZuWfr3y1y7mzKsrxqJOC+fq8cV96TPstx8mTN8WOuUOFLMD/L
         gCN3JP4aMfjnLGUg6mO+WldxooZc60hX3V181kbox5KMOctnpT8yQ0TzUGs7UrGlmCXF
         /thfkpy67egEt5xNZHmyVQW886BoHqQP1sHvTvb9+8rszdS9xa+p0A77P2Iq8G86q8Fr
         QkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1MXSY3rxyZv7oYRMbdKewaRZvNjQ1La+QB0aVR9VI0=;
        b=sEQYbTQKMgDOwjx469PrAAGCLPeIOiO7hbpfoEuncdR1ixgUR8Xm1btHrX1MoFQxyJ
         aopsENFW6GeQxpkefkmN5xqFzQerl0PR6DfvVw+Nb0ffifvkfudaCb6y0p2nYQhiSs6b
         ap/uwsPUGOc++G08TZqNQ7mEBlyjc1RajhKYebqtVqXQu0kugzdpV6O1vJG8H3O41QjH
         YjC3149IGgmcibDgtxIOoV5m4jXt/jxfW4KxSonVjANag4eJ8X1JwFzx68FfglcKQNYq
         OfRzCk3gTUEGTNZ0qY4Vu5qRAs17afzyIE/seO0aH2r7eZwgwWOfbfJCRfuUn8rRegkz
         sXtg==
X-Gm-Message-State: AO0yUKU2Fcu6VDHX4ItQy65IWHKXQx7gvkNY9q8lKfE8cOPfLqFEpC/u
        +Api/ApHfrV2Fgq0qw9VG30o9Q==
X-Google-Smtp-Source: AK7set8UJconY9qQeUcYAj0kv3Je4yBu9+zs5tJNmqzZ5c/NiYihoCwdZ1htlgeVPjVVQG7skh6hCA==
X-Received: by 2002:adf:ce02:0:b0:2bf:cff4:1d68 with SMTP id p2-20020adfce02000000b002bfcff41d68mr2176069wrn.0.1674808536878;
        Fri, 27 Jan 2023 00:35:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d4346000000b002bc84c55758sm3927558wrr.63.2023.01.27.00.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 00:35:36 -0800 (PST)
Message-ID: <6393b234-b3b7-6de1-ffff-2c8f1cec4fef@linaro.org>
Date:   Fri, 27 Jan 2023 09:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/2] dt-bindings: fsi: Document the IBM I2C Responder
 virtual FSI master
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230126213123.884125-1-eajames@linux.ibm.com>
 <20230126213123.884125-2-eajames@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126213123.884125-2-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 22:31, Eddie James wrote:
> The I2C Responder translates I2C commands to CFAM or SCOM operations,
> effectively implementing an FSI master.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../bindings/fsi/ibm,i2cr-fsi-master.yaml     | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

