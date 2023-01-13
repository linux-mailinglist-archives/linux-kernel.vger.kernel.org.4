Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2A5668FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbjAMIAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240800AbjAMH7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:59:45 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285FE6B5BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:59:31 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so18175121wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pXn/Sqn27pQ2/tPlS+9ov/6xbhT2AAHAgRbkg7kFwAQ=;
        b=tPKn2xm1/gh4Sij1f8jwVleMt42338WsI75gttRBU1JgFNfgYU0r/MAm8PW2q+BPN0
         NnN7QANVH84FpsyRzfINaFG6a1otwdl4AghMsMY54//2IrapjIYqXjF9xqXeMtNeYlEW
         04Qjo/fHRhBt/qXR892YiB10RCu3gSa9gnoXBJ/bMSIJFujFVt46HjN1NFtYmTQRV1il
         MP0pmSdzZfwvDneRERS2di6XylPDSJSJOJ0Ot9bSv6SANQLmRqGekffVJP5HWP1gTIJq
         S//ZPvM2koyrnUiLQCYEEEXrX5Q7M1x1xQMh/UHv74qkUeWiio+ad1wa46DsvmA4KdbQ
         qYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXn/Sqn27pQ2/tPlS+9ov/6xbhT2AAHAgRbkg7kFwAQ=;
        b=uUM/3uLjUFC5fexzgr5k07WNQl8wrREHmIP+MdxCHHbRlXgsnfCnYqqeLDuwEaxGmO
         +XDuaLdbIsiBR7fhC3y89eT4qBgsOb77t/y4q5ruiaogN1rl3w7gkF8Jrufs+AU/M4PJ
         BcCtm0z618xB9zDNcgr7LPCfLfmzsKhTxIG9zdks33JeDjejYKtcpMKmB8WK+P3UerEW
         7o7gsIcu+8TxfjzwDjRgmv3WPJxJTHj51i3pgY09WQMqit6s8AiglgxRvVK3l7FzNauf
         RvmRZzfXBLY4Ycwsbg+i289JmqZd46Vvt26WR/FsyQTr3zpIAtLemq4/XKqk9eaV6/5k
         cXhQ==
X-Gm-Message-State: AFqh2kozPa/sJXLIb1rZq4QhAXEbmo6hcdJNXSAZNdxbAfFzqjwuwnbX
        0/y95NuskVyNXKXE5VPeXtrDkA==
X-Google-Smtp-Source: AMrXdXs74AoIWMIyEUQ5IhW/LhJ6G7INvXg/qItiXrZhlEqQHD7ZDRpWY+gedk41wh7L5Z+K27n72g==
X-Received: by 2002:a05:600c:1819:b0:3cf:8d51:fae1 with SMTP id n25-20020a05600c181900b003cf8d51fae1mr57508264wmp.0.1673596769675;
        Thu, 12 Jan 2023 23:59:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb? ([2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb])
        by smtp.gmail.com with ESMTPSA id hg9-20020a05600c538900b003cfa622a18asm28029637wmb.3.2023.01.12.23.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 23:59:29 -0800 (PST)
Message-ID: <916dec5f-5798-047f-37b9-ea4ced426838@linaro.org>
Date:   Fri, 13 Jan 2023 08:59:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 5/6] arm64: dts: meson-g12a: Fix internal Ethernet PHY
 unit name
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
 <20230111211350.1461860-6-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230111211350.1461860-6-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/01/2023 22:13, Martin Blumenstingl wrote:
> Documentation/devicetree/bindings/net/ethernet-phy.yaml defines that the
> node name for Ethernet PHYs should match the following pattern:
>    ^ethernet-phy(@[a-f0-9]+)?$
> 
> Replace the underscore with a hyphen to adhere to this binding.
> 
> Fixes: 280c17df8fbf ("arm64: dts: meson: g12a: add mdio multiplexer")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> changes from v1 -> v2:
> - new patch
> 
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 9dbd50820b1c..c95cf3afc666 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -1694,7 +1694,7 @@ int_mdio: mdio@1 {
>   					#address-cells = <1>;
>   					#size-cells = <0>;
>   
> -					internal_ephy: ethernet_phy@8 {
> +					internal_ephy: ethernet-phy@8 {
>   						compatible = "ethernet-phy-id0180.3301",
>   							     "ethernet-phy-ieee802.3-c22";
>   						interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
