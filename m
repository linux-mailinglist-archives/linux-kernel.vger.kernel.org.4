Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F275687807
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjBBI5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjBBI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:57:40 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7492A790AF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:57:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o36so818640wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMiqUodml6uBOLajfZK6hc14FkG0GweLDtekS4XSxl0=;
        b=tG+xBN5Ejl7wU+JxdQXLH7IUd4en7sOPdSp1l6XzoC77o9VA4zCb/zf0HtVhXelPt6
         KR/7Wj/G6ejyvPtdEKd0OeZ8ZoHtM+kqKekS02afzNglfro8r6gIG2rZGVfA5lIZqPP3
         ZTgx+lzzOHeOH6WfDH7OXhONdD+OCpebDSfJAnJrg0PGo9jn375awJTi9FcQUWaiZsEJ
         EhhpOrK+CeMOvapWaCez9xOUEQFkhTB06xRdw6H5UZUUq/Hr6kgyN0JTPln2M47PFPMc
         FL92uvovQ19axKkHOJwbifSib92Cq0G2tBsg/mxFdzB953Fan3q68OUnFHa2KdkGc2mB
         ByDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMiqUodml6uBOLajfZK6hc14FkG0GweLDtekS4XSxl0=;
        b=atoRS80lTAlLW9h0wXFEv+IPl5NkE+zL+Jnp3DdHY0+Hkv+7NcgJMeboF+qMyvc2qg
         nUNCxzYTCH3RoWxgygfpbf1AGkwC6JpWEnpjp2+Cgo0SMPkKvlhSijTyM3msvlv0JNiK
         pPHqlQktOArbyI2mFfZbcU8fTGc068b3S7xMTX6w2S/E49o8eDvT84wKSFQOWCBdZQwf
         tY0MpgK5CHoGOMXxgFKwfg0X8pHgPgvnHdb7o9Pu7w8kd2lwNmthObzXLZxxsdZqiI7Y
         Hkwk8CxBYo/4AqUqHj3hvoqa7+IEDC02IXP2WcsR/kK2ic7JUfTsqfNd6ksG5FsxUdQW
         pOKg==
X-Gm-Message-State: AO0yUKXnU4CiTUmIvuFZHK4rYDNyw/0CGNrD2UUmsirgKyapzAa5lPkR
        OIR8j09YlP1aXnYEzZLIYNGEAQ==
X-Google-Smtp-Source: AK7set9lWEW3d6A+NKvJN5QuCV0g6pCrziUQhEsGu/uZbaYXw7aieUCyeaBUlrgTMYcQhdApt+AFSg==
X-Received: by 2002:a7b:c3c6:0:b0:3da:22a6:7b6b with SMTP id t6-20020a7bc3c6000000b003da22a67b6bmr5172403wmj.13.1675328256059;
        Thu, 02 Feb 2023 00:57:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u1-20020a05600c00c100b003a3442f1229sm4059403wmm.29.2023.02.02.00.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 00:57:35 -0800 (PST)
Message-ID: <b0f55494-3a17-4d87-7b8f-5b078503cb53@linaro.org>
Date:   Thu, 2 Feb 2023 09:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
 i2C driver
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
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

On 01/02/2023 11:33, Ryan Chen wrote:
> AST2600 support new register set for I2C controller, add bindings document
> to support driver of i2c new register mode controller.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../bindings/i2c/aspeed,i2c-ast2600.yaml      | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> new file mode 100644
> index 000000000000..b7d7bc303e77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/aspeed,i2c-ast2600.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AST2600 I2C Controller on the AST26XX SoCs Device Tree Bindings
> +
> +maintainers:
> +  - Ryan Chen <ryan_chen@aspeedtech.com>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-i2c

NAK. It's already there. Please do not waste our time in submitting
duplicated drivers.

Best regards,
Krzysztof

