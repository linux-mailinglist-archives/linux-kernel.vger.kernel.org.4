Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F152625633
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiKKJGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiKKJGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:06:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A5355BA;
        Fri, 11 Nov 2022 01:06:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z14so5607582wrn.7;
        Fri, 11 Nov 2022 01:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5exqSysqc7YHZXiStWHpWi8OBaqisnDZY31klCw8FDo=;
        b=NbF4F7dz0fofp/f43N2ow0yB/tAABhFhEVMbbwLgVZndPW6oTtV6gh8DOaaOdIMNpr
         pUOTcRj3CvL1AdR8JZuB99ujecuBtJ/0wC3FCevUUbOlsrb6GjYi0pwQ7U1C9Adl230+
         TC3VqpN8as2xq9K+IrPNrIK7gjV5l9lzxIovFesk8zAlRozMYMOAjZL3I8Dm/Xzthw5H
         5q6nDg32nXx7vzbKn9gemP0SoTYg834FtwkZsYAt4vNRFBGVl5jJ2qEFSA+Xxk+Tl/qM
         slYN6velNyNjsYR4fTMHFjipz+SUcKPpPUxRODiJrTHBOiMN8YOyTTKMaKorzvVte4lo
         aLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5exqSysqc7YHZXiStWHpWi8OBaqisnDZY31klCw8FDo=;
        b=ZC3bFFHd3PWM3gavBO5pyBIPkMTX0+MOLAKO3jVIiS8iy0GWrF7rTES3LIMC7RKvS5
         dCb88voMvMSZqHauS6J3wZz4/+zDuczj2s0WD0YzBUs2IaaRQrbvex0zOuEclrzTrWf6
         qCrPb9qow1fA0pMcN2N8sK4LjiUBMNWqDixzeqd5Dl2+qFgD3gACwn+u/Bwx6hoCNS+q
         RsNE12n9gGDdRV2u8ZJX/9wEvS12dMA+AbceXtAVt9SwdOEBvPUpYVGTk23CORLz6Um2
         xP6cTAD+GCDgRXROc4nI/uNmnAGZwbMKJGI2B9xDdcDhjOvYCThc95fUa5bmE+GbfLvP
         TuDQ==
X-Gm-Message-State: ANoB5plCYFUDK6D7ELJfSt3Dsyw8h2A3koh+HY10yDylZRRISDuAT5BH
        on9AeqdznxUQU6vHTD+hLqo=
X-Google-Smtp-Source: AA0mqf7NqydisRfGc/xHd5/cqwAgF58CN4sU4/ZLqyyjDVsYUbAuedLMEKJjiAC5d/zeN5+rhpPjnA==
X-Received: by 2002:a5d:6a12:0:b0:22e:3664:ffce with SMTP id m18-20020a5d6a12000000b0022e3664ffcemr664681wru.131.1668157565241;
        Fri, 11 Nov 2022 01:06:05 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c430700b003cf6a55d8e8sm2202375wme.7.2022.11.11.01.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 01:06:03 -0800 (PST)
Message-ID: <68e4f061-af72-fe13-2a49-f62a9c542685@gmail.com>
Date:   Fri, 11 Nov 2022 10:06:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC v3 06/11] arm64: dts: mt7986: add i2c node
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221106085034.12582-1-linux@fw-web.de>
 <20221106085034.12582-7-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221106085034.12582-7-linux@fw-web.de>
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



On 06/11/2022 09:50, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add i2c Node to mt7986 devicetree.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index 32c26b239ae6..a1a788db113a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -261,6 +261,20 @@ uart2: serial@11004000 {
>   			status = "disabled";
>   		};
>   
> +		i2c0: i2c@11008000 {
> +			compatible = "mediatek,mt7986-i2c";
> +			reg = <0 0x11008000 0 0x90>,
> +			      <0 0x10217080 0 0x80>;
> +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-div = <5>;
> +			clocks = <&infracfg CLK_INFRA_I2C0_CK>,
> +				 <&infracfg CLK_INFRA_AP_DMA_CK>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>   		ssusb: usb@11200000 {
>   			compatible = "mediatek,mt7986-xhci",
>   				     "mediatek,mtk-xhci";
