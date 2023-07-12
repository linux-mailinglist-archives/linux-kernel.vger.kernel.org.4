Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959DF7506FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjGLLtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjGLLtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:49:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB843212D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so1472519a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689162501; x=1691754501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0bqqbnM1vgDHL4/44kvm6PkazY/QumMJkjW1vAAr6k=;
        b=fBm0+QsqoMQJ2GVY6BROKP/9+appv6LnzytHflrEjt1WEsk9yjwyEugEeO6R+mfsiE
         QwuLZZhzv3qU1mY9xvDFDgAB69vJvDWk0f1fBsSzKgVEKz1GXKbSsrpStisdQ+Sf030j
         qYrAQrsE4RG0owCp5UaLOFXxm0TYZzF54ryoPAkrgXCPdjb9IhhUf6v4emNvEdN+yh0x
         ltZouG3eNA4dXbM97im675FZFTjws+bGPLDYS3Yrp3eiUlvAj8fCH3LnTPuRWcrq+FpC
         z6+6w66Cd1ynF/NqsOBhYMGcuH9+Wi5B9tzubuUDDgoIEu2zg2cZ0HzbVdQDoanlCTuV
         PClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162501; x=1691754501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0bqqbnM1vgDHL4/44kvm6PkazY/QumMJkjW1vAAr6k=;
        b=W3l6n+99ngeNQS8FmuauLjhdD471Hk50tBeYLx1rUJmLPnEHcNjJpWZbBmmk/458h/
         VASYbfA8rvx93CdyELuhB8bNDn9gAsoagbDahdmarEc+1gtkiWUYgZxf1pvgP5pbU3Lf
         q2pTV73YL3uDfDdw8EdBKt59mz7v3f0eBWcPuyIUgNzlS8G3SEgz0ai5VFKjy4aaTH4Z
         IvbrV4Kf8rs/mrYgcnj+mB3HaarbCtBpAVgTbLi6RATc8lpRXLqq3OIGdiTUlwoEx4pI
         Ma+y8oPx9xnLypi6tuYqmj3nznLHszup1BYdUVxf6GADmXWQ2/Q+9tY5fuGU4DesDxZx
         C/hQ==
X-Gm-Message-State: ABy/qLbzMPqDqC1wAzbFR3XvV9F8eGG0XvY/F/Z8+lDTbP0lSQO7Wzgp
        W5QM+uIUYUIKVoNljzEe1yhJ/A==
X-Google-Smtp-Source: APBJJlFQeZHKAi2oBkRMSAzPMEDSRrsxv9NhvgIUeOOAkRmLUgBAxAXBv0sRJvJUaA9FbKHwlb2a6A==
X-Received: by 2002:a05:6402:358c:b0:51e:443a:25df with SMTP id y12-20020a056402358c00b0051e443a25dfmr2043522edc.19.1689162501273;
        Wed, 12 Jul 2023 04:48:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x19-20020aa7dad3000000b0051e28d315a2sm2637235eds.78.2023.07.12.04.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 04:48:20 -0700 (PDT)
Message-ID: <0ce7d468-c0f5-e29f-d4cc-3bdcfcc2bff4@linaro.org>
Date:   Wed, 12 Jul 2023 13:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] dt-bindings: gnss: u-blox: add "reset-gpios" binding
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230712113731.3306-1-wsa+renesas@sang-engineering.com>
 <20230712113731.3306-3-wsa+renesas@sang-engineering.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712113731.3306-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 13:37, Wolfram Sang wrote:
> Needed to enable this chip on a Renesas KingFisher board. Description
> copied over from the Mediatek driver which already supports it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
> index 4835a280b3bf..8f6992b97ca6 100644
> --- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
> +++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
> @@ -41,6 +41,12 @@ properties:
>      description: >
>        Backup voltage regulator
>  
> +  reset-gpios:
> +    maxItems: 1
> +    description: >
> +      An optional reset line, with names such as RESET or NRESET.
> +      If the line is active low it should be flagged with GPIO_ACTIVE_LOW.
> +
>  required:
>    - compatible
>    - vcc-supply
> @@ -54,5 +60,6 @@ examples:
>              compatible = "u-blox,neo-8";
>              v-bckp-supply = <&gnss_v_bckp_reg>;
>              vcc-supply = <&gnss_vcc_reg>;
> +            reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;

This should complain with errors, because of missing header for the
defines, so usual disclaimer:

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Best regards,
Krzysztof

