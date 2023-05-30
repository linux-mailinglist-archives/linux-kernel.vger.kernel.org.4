Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB557162FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjE3OEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjE3OEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:04:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A52EA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:04:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f683e8855so649589466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685455446; x=1688047446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAaRAHBvmn5TiFi21og9H3c8Ufuxifop3fwjLkOCVes=;
        b=Aek8BtY/hryhXWGyso4A1d8LRPMyM1i6oQXslgfxRZnF8cAliqg5ePF4ytNdN3E+o6
         WmS0KpTrdb3r9/kUbqLGU09/wzgYaICG31s/pkSXtBRptvvmnm0O3TN+lcBEOJfNyQJw
         Jyo2qk66nTv4MIvWjps71q6cdC0XZ5627vivMGlIpQg4f2iwaUCKoZOPqxJSEA+cUqme
         7SLaLmXWpBAVoIJTMzfnNHlWJ7YVzvolgK82JIQUgFSaHUaikPkTgbkYT3r1izuzCR9C
         75Yr1WaVTrV4AvNAMD1ft0m7sL8mFg0r8vukhZyV6EL86xe1Oxzd2StmJY2OC4/ZSeUv
         gjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685455446; x=1688047446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAaRAHBvmn5TiFi21og9H3c8Ufuxifop3fwjLkOCVes=;
        b=ThbxJV/owEcFmPFttwr1ZaP2sjfyVdYvylHrDEuSkQ9ujhg/fVNmxEOLrG83Vz7SMT
         hFMESJdP8KQvD0u+VqZB8kycZskFRgZSzRwrYc4NfsPTnJRKwKbMAfrdex5xnbE5y/GW
         60YUaYvZXgpcMDlt5hWVpaJp92TUXA3b21Rv5+CBLlJ7uce/JwK1dLTSNJty3OY+syur
         Mg9OSBpOiBWQTyqct4Z1HPkfJHKHJujltV2M/eG5x57SLETiZq88a2X9z40FaGS8YMCq
         8dR6cyim2BnQdYQ/rpPUzRtlvsd5Vizmaf6do2ArMfeww1wYDfRO+nBJXzACxr9rb9rV
         dD+Q==
X-Gm-Message-State: AC+VfDyZmR/RLl0p4vAuyDL58Yd3qxl8XyPBKMDGeMi0GgP9XNHEgO+/
        fhMKxVzJj7mXjELGrJSnQJpUGw==
X-Google-Smtp-Source: ACHHUZ5eqKSA0S3xLv0PuDvXBu0UeK4GkplmqjpmtXOP8+/T/kVFZMGqkpaNHjXSCThrWsX2lB2TYQ==
X-Received: by 2002:a17:907:724b:b0:958:4c75:705e with SMTP id ds11-20020a170907724b00b009584c75705emr2423155ejc.17.1685455446007;
        Tue, 30 May 2023 07:04:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id x15-20020a170906148f00b00969f13d886fsm7439467ejc.71.2023.05.30.07.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 07:04:05 -0700 (PDT)
Message-ID: <1cce5a11-f182-04b0-0aa3-ed27614a564d@linaro.org>
Date:   Tue, 30 May 2023 16:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] dt-bindings: net: pse-pd: Update regex pattern for
 ethernet-pse nodes
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
References: <20230530083713.2527380-1-o.rempel@pengutronix.de>
 <20230530083713.2527380-2-o.rempel@pengutronix.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530083713.2527380-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 10:37, Oleksij Rempel wrote:
> This patch modifies the regex pattern for the $nodename property in the

Please do not use "This commit/patch", but imperative mood. See longer
explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> device tree bindings documentation for PSE-PD controllers. The updated
> pattern allows for additional node names, including those with a hyphen
> followed by a hexadecimal digit.
> 
> Before this change, the pattern ^ethernet-pse(@.*)?$ only allowed for
> node names like "ethernet-pse" or "ethernet-pse@1". With the new pattern
> node names like "ethernet-pse-1" are now also valid.

This part is duplicating first paragraph. What you should have here is
answer to why we need it.

> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/net/pse-pd/pse-controller.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> index b110abb42597..3548efc2191c 100644
> --- a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> @@ -16,7 +16,7 @@ maintainers:
>  
>  properties:
>    $nodename:
> -    pattern: "^ethernet-pse(@.*)?$"
> +    pattern: "^ethernet-pse(@[0-9a-f]+|-([0-9a-f]+))?$"

No need for inner ()

Let's make -N suffix only decimal, as discussed here:
https://lore.kernel.org/all/20221123024153.GB1026269-robh@kernel.org/

I will send a patch for other files.

>  
>    "#pse-cells":
>      description:

Best regards,
Krzysztof

