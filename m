Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABAD6F9123
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjEFKar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjEFKao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:30:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EAAA5C1
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 03:30:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94f910ea993so420469566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683369041; x=1685961041;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=om5rBZjpQmGylRwHMCWGL04Qa98XCtT0ijIQXJtCbpg=;
        b=Uof1PVeZ2PigSWjj/RuJh5B4jduLV1JTD2KLBJycgqsGK7m73CXn7eW88cHN4mC4Cr
         dM4fQk0G5Ec0ZCl0qChvoy9Ai19Cm1VOFCegoZJK+wMQH2kQWdKNc6Bnb+r/KKDehW6t
         qjRQfr3KSEzSZTExdnDOw9rRBTNb2OM6di47nseWiQMNk/tobd7o6VupZpsJmHLYPGZH
         2qKRbnuxnkdgdDu3bu/svnaDlpe9jmOUeoXvEORdl9DayjnLdl/x5AeTZj915Svij+f6
         rlVCVKnhXxZCzpK16zdCCsxGeNOWyrn1hNK+H1SVTLKOXbUlvPu0tzQAThDmY23Td5sc
         ZT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683369041; x=1685961041;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=om5rBZjpQmGylRwHMCWGL04Qa98XCtT0ijIQXJtCbpg=;
        b=gH5+5uH1WUnnL98MVef49mLh1r+ZhuAzmp7YhkQ301k6mtsdzdfjPUrgQ/jGjbY4hi
         aczCtG0Sx+vI7apcv34SeKYak5wFQgtqPUsXf7HaexpYBPRc/lVPBXTMR3Zfm0TEUBZy
         OCt4C+Ci0V2Gl5+0OG5d+edBiATdrs3fhu0Txr3gq328eRsdvLzxSqafdCvopLTW9bmm
         QueR9CSVPCEDDAeReP6ll9nASJm77UXj5ttWHP2SFE75AMWpryc8XF0XUshXgmu2PmDU
         NYcVAZAVqDqqOxqQRSq8N5trLycAtMPaIMkNIfTKKgdh2lXgTx5q5jcJWYTsxg6Z+0iP
         Ahkw==
X-Gm-Message-State: AC+VfDwKKJiJpMYm2VDznFzQLLeqyZP9ZGuNuYM72PivDvjkRTfHm9WV
        F1bbDO9JyOUwi6S+mQ+GYHqL9w==
X-Google-Smtp-Source: ACHHUZ4as+xxLviDsQOX+GTc5E7TjPcuUmqsob35yRWQz41AIc++JNtv+eFKhD3MleB3Q6677/6v3w==
X-Received: by 2002:a17:907:2d88:b0:878:711d:9310 with SMTP id gt8-20020a1709072d8800b00878711d9310mr4364603ejc.1.1683369041240;
        Sat, 06 May 2023 03:30:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:efe5:7c03:a10a:7a40? ([2a02:810d:15c0:828:efe5:7c03:a10a:7a40])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0094bb4c75695sm2123565ejb.194.2023.05.06.03.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 03:30:40 -0700 (PDT)
Message-ID: <0503436c-e3ea-7c28-e6d5-39fcd8c53d4d@linaro.org>
Date:   Sat, 6 May 2023 12:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] doc: dt-binding: cdns-salvo-phy: add property
 usb2-disconnect-threshold-microvolt
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, fushi.peng@nxp.com
References: <20230505185247.1854677-1-Frank.Li@nxp.com>
 <20230505185247.1854677-2-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505185247.1854677-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 20:52, Frank Li wrote:
> Add usb2-disconnect-threshold-microvolt property to address fake USB
> disconnection issue during enumeration or suspend state for difference
> platform.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching). Two prefixes got wrong... It's not doc but it
is dt-bindings.

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml b/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
> index 3a07285b5470..3c7f5b3f9211 100644
> --- a/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
> @@ -31,6 +31,13 @@ properties:
>    "#phy-cells":
>      const: 0
>  
> +  usb2-disconnect-threshold-microvolt:
> +    description: The microvolt threshold value utilized for detecting
> +      USB disconnection event.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Drop ref. Add vendor prefix.

> +    enum: [575, 610, 645]
> +    default: 575
> +
>  required:
>    - compatible
>    - reg

Best regards,
Krzysztof

