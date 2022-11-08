Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028AF620F57
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiKHLm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiKHLm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:42:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E32EF5F;
        Tue,  8 Nov 2022 03:42:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w14so20517364wru.8;
        Tue, 08 Nov 2022 03:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKWZw8f3KDA3uN1tbZ06k0BAsz8ZmwlT0FyHTdt1NpE=;
        b=bbFVf4ehELM6Sf47QyuVf6xwC/JS0r6QsJ2HCw/mb0bmmhjKAQDLzV+8W8KaTmtdaU
         WlhROl2mLDodTdp8k93NPp0C+tuU9C1p0oSgUftsOydJiR7kiHjx6bIb9aQuOzTd6laf
         64svrr+CMLf2ylsIPBGZaow3hOQYAIzaKQ0CBFJ1RQrEHYQlje7zUUfRZKm0yu4w98Gn
         FZlfkRhXLjlBnaG08+d4Te61Gg26jLIfN/jY3V1Q7STY9CNL3VhqP2biRHrms8kbCmWc
         2V1/swCWsWbdno/JJuso3OkZOXQ9RNC2gTKl7JWM2Z3Y8B0lxar994olPJQz3r5XZgw9
         7Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKWZw8f3KDA3uN1tbZ06k0BAsz8ZmwlT0FyHTdt1NpE=;
        b=7y4YYeLFN/CSOd++e921ZDDvso7NKfZuvsmwm8hhV2zvqpYt1M6dCZBRo9+PKbEV7R
         m2nbtb/z1urayYIOVgAvE3wFSKWmTZgsCWygUEPGIdkdP8MIO5qcGg0gjXh525tfV+LN
         zxqNZj9sCmXo1mB2HN82trYv4ZwmepG6FYELWjVy1DN6GghuaIcDN2NVO5mUE5WnjorO
         TzCJjVc0+GBG+FPWZNnafI/cCHot2dWcg+2WOcba4vsqHkwhelYNc/NraZEPRueFCdx6
         JVAQH4U7OVnUu5xNjqeBazrbunrOjV2dlxf2cQWqMgb71GVL5ZItlUm6TenO5XmHVmSN
         VE/A==
X-Gm-Message-State: ACrzQf0+Qf1ZL8ERECGdv+sj4WEXQd6zc7xdJQpn1EKD99/IsWQCZTGG
        O3kqYuICjeXk1zG1kiGbctU=
X-Google-Smtp-Source: AMsMyM5nUdlHaDGjmApV1ZGe5XmH3xwHTqd1fvJFnS1APUmgka76olr6JYvnDs2PnV9JeIF2IMEadg==
X-Received: by 2002:a5d:538c:0:b0:236:a6a5:9cfe with SMTP id d12-20020a5d538c000000b00236a6a59cfemr33267919wrv.121.1667907744110;
        Tue, 08 Nov 2022 03:42:24 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k4-20020adfe3c4000000b0022ccae2fa62sm10188253wrm.22.2022.11.08.03.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 03:42:22 -0800 (PST)
Message-ID: <552e9d45-715a-62dc-09bf-58d565b62837@gmail.com>
Date:   Tue, 8 Nov 2022 12:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-13-pierre.gondois@arm.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 12/23] arm64: dts: Update cache properties for mediatek
In-Reply-To: <20221107155825.1644604-13-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2022 16:57, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> The 'cache-unified' property should be present if one of the
> properties for unified cache is present ('cache-size', ...).
> 
> Update the Device Trees accordingly.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Applied, thanks,
Matthias

> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 3 +++
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 3 +++
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 3 +++
>   3 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 64693c17af9e..c326aeb33a10 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -198,16 +198,19 @@ cluster_off_b: cluster-off-b {
>   
>   		l2_0: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   			next-level-cache = <&l3_0>;
>   		};
>   
>   		l2_1: l2-cache1 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   			next-level-cache = <&l3_0>;
>   		};
>   
>   		l3_0: l3-cache {
>   			compatible = "cache";
> +			cache-level = <3>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 6b20376191a7..424fc89cc6f7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -169,16 +169,19 @@ core3 {
>   
>   		l2_0: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   			next-level-cache = <&l3_0>;
>   		};
>   
>   		l2_1: l2-cache1 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   			next-level-cache = <&l3_0>;
>   		};
>   
>   		l3_0: l3-cache {
>   			compatible = "cache";
> +			cache-level = <3>;
>   		};
>   
>   		idle-states {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 905d1a90b406..cb74905cfbb8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -213,16 +213,19 @@ cluster_off_b: cluster-off-b {
>   
>   		l2_0: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   			next-level-cache = <&l3_0>;
>   		};
>   
>   		l2_1: l2-cache1 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   			next-level-cache = <&l3_0>;
>   		};
>   
>   		l3_0: l3-cache {
>   			compatible = "cache";
> +			cache-level = <3>;
>   		};
>   	};
>   
