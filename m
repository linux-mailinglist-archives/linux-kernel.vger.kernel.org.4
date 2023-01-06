Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E64166009A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjAFMxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjAFMxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:53:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C247459E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 04:53:30 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id z5so126598wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcJg6BDA8nzuhkvqqR+ghB+11JZg54hPFOLhhkXj+aU=;
        b=QevOxHQwIMvnsAfGP3CJ4r1T9bgcLZcIWzRbnGJk5fZ6unLTlRCkMjPY7ZHsmTjJAU
         8TBdxscc7cl2GHmQwH+kGdV3EXZI1pkIGSzHSqyq6BiTrFikAzT5DGP37mVtrG5Ae9Z0
         Hgj9B7OjFj3/zNZLhyGLrRGnUT3SryU1QEt5IRdpj3GohS62VdcTTVJgiBpFF1YeiLXZ
         qWU60uQlEAYogZOar5yB8Q4n6m1AKjieEsOIUBsLaE+EMUIUJrZP375MgdjfY55pyLME
         PBf1ynbX7yZL+QbI7hA8bmOsCnlFUrKGQ2MvbG7vpHTs1a1sWxf5THmDat0a8PEbvkeq
         KHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcJg6BDA8nzuhkvqqR+ghB+11JZg54hPFOLhhkXj+aU=;
        b=PqPwP/lUYCjupS75fd/zWcuvSE7G4s3Qr5wdPTqsbZ0vAuXxeveeCxMP2JNH7zvhCh
         MRHBXjIJ8ODtl7rEdU9HzHsuJEHolaYQgIMbJqJjxh/75ZMRnMdCPZsOUX/lHMMTBqil
         0JX4LfV/gzFT6kZSJYXsq9OyWfiYh93Z3X4OVhwV/+JIrspsgzHkYcaTtpPAY/ZQZOA5
         VM0ybQiu7yd3F3No8MxKb5ufMDqnS32OoJod49h5Z4p0DXoLL6pfxqESGdqVxiYvkYLx
         y0XO1IoD8A8M4P9+95fF+4AKDPqzbLCrERWLK1aNa0HsLELIFW1HMBZ4x4OfugH/mEhK
         wBpw==
X-Gm-Message-State: AFqh2kr3dvXOEjC00Nl1Rzv9RaZLt1O9idqSkuFVO/S5+3Hm/aGUlO86
        dsSSpT3+qOZVFJcrbwotReiX6A==
X-Google-Smtp-Source: AMrXdXvgBLNB5W4D1FlJ5z4o5cLiyPP6xqIEofHKlEDngWvT+cZcKlpy1EaW2soVnTj6J+5sZX2GzA==
X-Received: by 2002:a5d:6e82:0:b0:2a1:602d:fd5 with SMTP id k2-20020a5d6e82000000b002a1602d0fd5mr7389047wrz.46.1673009609243;
        Fri, 06 Jan 2023 04:53:29 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d44c9000000b0023c8026841csm1099900wrr.23.2023.01.06.04.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:53:28 -0800 (PST)
Message-ID: <ee653e82-0b7f-f672-7a13-d80134239263@linaro.org>
Date:   Fri, 6 Jan 2023 13:53:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 4/4] arm64: dts: imx93: Add CPU thermal zone
Content-Language: en-US
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-imx@nxp.com
References: <20230105101748.6714-1-alice.guo@oss.nxp.com>
 <20230105101748.6714-5-alice.guo@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230105101748.6714-5-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 11:17, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Add CPU thermal zone and attach it to the TMU which monitors the CPU
> temperature.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 48 ++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 6808321ed809..60306f3c5e7f 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/fsl,imx93-power.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  #include "imx93-pinfunc.h"
>  
> @@ -116,6 +117,38 @@
>  		interrupt-parent = <&gic>;
>  	};
>  
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +
> +			thermal-sensors = <&tmu 0>;
> +
> +			trips {
> +				cpu_alert: cpu-alert {
> +					temperature = <80000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit: cpu-crit {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +		};

Wrong indentation.

Best regards,
Krzysztof

