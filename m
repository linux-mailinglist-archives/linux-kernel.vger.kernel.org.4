Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49786736382
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjFTGTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFTGT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:19:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A7C6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:19:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso2491409e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687241965; x=1689833965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oO29vTyH00u9Cnemrj5+OqL3rJnNJVkGd7KyzUdckJc=;
        b=hhdBu0W0qX/0/mlBgaMXaWbidX+xQtAYl6qYY+nmVWaza8SKXp8lBxfRt5xhYLWeKs
         PhgczPVyujwWmSC3ENjjPyOBy68r7jBItGsyQJfBSfKe1Z0p1sFMZFGhHgKMtOcOPlRY
         L1u/Ip5qIvpvReKWaCRb250l26d6M5goqG8H4r9Sk+OnFl/2OuvTszgDkCGu3VqqyLBI
         ZNEdyBYQ+amc3AxWZ9rzjXyTNWYbUQj2yzg/P3fX3AUn2tgMr40B0JdBvQ0FX1amZZim
         UgZgYdaInNdGZ4WUU/IFcmKxqEWecp5ryF3B2ms5whBegxaZQ91ilzhe5laJK9Ri9jro
         aSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687241965; x=1689833965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oO29vTyH00u9Cnemrj5+OqL3rJnNJVkGd7KyzUdckJc=;
        b=aJZb/S8T/OR+9LG5yoqZjctxhsECs4AqbJRqMEf1FJJXPlupKndelVnsQ3Ee2y2yCz
         PvV+WM6fATPNjLzR0C/rYRO/Mq2PDuFAAzmbDtDhdgrLZKRyH9u9Nkv5+fdWz7wtiGjc
         +sse3Zb63DwpJKIEXlKbolID50f8/5XGZg20fvOiNj0POZ2XphorGjlxgAZoY7bNqBLy
         TZ4+BBv5L5UtmBsYnYDpz76scIOK1CS+eMsJOvsXLh450yddZ4OEorEMHmP/AeqP4yry
         NDIbnideuTZsgfl7KhGHkqQ3cQUbG8eUS93sDOWJhEejSK1iYYNSuFG2g3x454uALPO3
         1LHQ==
X-Gm-Message-State: AC+VfDz5H8YlNJUdFDDAYic/CxiFzCBlcWFxnLKtZy/SWBI4Hs2BiiJP
        9NU6+bC6tfJmWPG+G2SY/AEYnw==
X-Google-Smtp-Source: ACHHUZ7usY0XPsrJHRsdCyO8q/9zfJ/EGU8VDFSPYhYiP4eZgWJnkQnPQtutOJF8jpavCoGfWRglig==
X-Received: by 2002:a19:6909:0:b0:4f8:6d54:72fb with SMTP id e9-20020a196909000000b004f86d5472fbmr2856355lfc.62.1687241965041;
        Mon, 19 Jun 2023 23:19:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d54c7000000b0031270cf1904sm1181896wrv.59.2023.06.19.23.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 23:19:24 -0700 (PDT)
Message-ID: <c020531e-c56e-7606-1846-5ca7332de96f@linaro.org>
Date:   Tue, 20 Jun 2023 08:19:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv3 2/2] arm64: dts: rockchip: add dts for Firefly Station
 P2 aka rk3568-roc-pc
To:     Furkan Kardame <f.kardame@manjaro.org>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, broonie@kernel.org, deller@gmx.de,
        dsterba@suse.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230619184856.23066-1-f.kardame@manjaro.org>
 <20230619184856.23066-3-f.kardame@manjaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230619184856.23066-3-f.kardame@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 20:48, Furkan Kardame wrote:
> Add dts for Firefly Station P2.
> Working IO:
> * eMMC
> * HDMI
> * LAN
> * LED
> * SD Card
> * UART
> * USB2
> * USB3
...

> +	};
> +
> +	hdmi-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +			remote-endpoint = <&hdmi_out_con>;

Missing indentation.

...

> +
> +	vcc3v3_lcd0_n: vcc3v3-lcd0-n-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_lcd0_n";
> +		regulator-boot-on;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;

How do you turn this regulator off in suspend?

> +		};
> +	};
> +
> +	vcc3v3_lcd1_n: vcc3v3-lcd1-n-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_lcd1_n";
> +		regulator-boot-on;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;

Same question here.

> +		};
> +	};
> +};



Best regards,
Krzysztof

