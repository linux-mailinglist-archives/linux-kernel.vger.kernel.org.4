Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96121745CE9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGCNMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjGCNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:12:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A2EE66
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:12:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so42621085e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688389952; x=1690981952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKzjbaIgnIombKyMIib7qqY3jsIUiwxCqbvrBlGncK4=;
        b=ERoVkEkfHI7aOWSjWlRDt4sDjlGc3pbfjEIR1Xi0onXASTGgBQ3ZGsr+uH1Yt9XsHY
         7XhjhHrcmLWCSrKKqb0XMVOA1G0dG0tTsm6RCQnbbM5SJdMrcr3UM0mUxCVt5GC5UJo1
         skTUo1es3siZ7aRH2XbGV78uXJwyF2cLFa6pbRQNmhDrEe3HEIl5mQ86KmmFUpx5wbVW
         3fiPQaV7h+gIeJDNAnqWkrELmPW9N+G7/i51DlwEYly1YvN32zEffOW6C0xmAv4x6iUe
         hJozW7DqgmDoNYvyT67jT7v3v3NWy5I8HzERc9p8z0RthvjCbv2MSMnTQNMGIFShBOKS
         P+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688389952; x=1690981952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKzjbaIgnIombKyMIib7qqY3jsIUiwxCqbvrBlGncK4=;
        b=c6Qf2XtSPJEMwXyUKW0H3mgm6zAVhA03HeNnW4jbHR0wpJC6JIZYWZX1Wnvi7Yc0/K
         JloTZLohCalLRaZOcUPyu0Bt4Lqq/eIwhj65zXhvHIPfg1TMQWKsTslMCPnsu5pLlICY
         BiFXU4embSeJseb1KW0IvaKDROBq9OBIBg4hJaVR+sjE5HcSFh6qoKuksjA8ynearawl
         UMevBCZ5v9oT+jT5ucPftRWQc7avNRyca0zI0l0PZDVhoCMbEqj9IA2m9SE+UQ0wIIgL
         r0Pkhz+BDzdEovorinDDPaWrr+6GRLCI3+G6kMyxKGLzNPs5TNu2I1PvoGpuTLIPyYIr
         F+cg==
X-Gm-Message-State: AC+VfDywOBirMRgp4IEW+lEaqtFKwLn2+UJzdxvF7EguKIQtxi6v+HAR
        c4CgNZiR6IO8UOIIqaiVY1bwzg==
X-Google-Smtp-Source: ACHHUZ4vQVWQg5VnD+c85J+p/WSP+uTvOOXNZORtq5LfjCclTzh2iyZKnqMpyx6VkF9lyaMOIspoHw==
X-Received: by 2002:a1c:6a1a:0:b0:3fa:98c3:7dbd with SMTP id f26-20020a1c6a1a000000b003fa98c37dbdmr7712700wmc.41.1688389952033;
        Mon, 03 Jul 2023 06:12:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u3-20020a7bc043000000b003fbdd5d0758sm904403wmc.22.2023.07.03.06.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 06:12:31 -0700 (PDT)
Message-ID: <992f74b3-373c-14d2-12cc-85ada068d54b@linaro.org>
Date:   Mon, 3 Jul 2023 15:12:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] arm64: dts: add support for C3 power domain
 controller
Content-Language: en-US
To:     =Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230703093142.2028500-1-xianwei.zhao@amlogic.com>
 <20230703093142.2028500-4-xianwei.zhao@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230703093142.2028500-4-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 11:31, =Xianwei Zhao wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Enable power domain controller for Amlogic C3 SoC
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> index 60ad4f3eef9d..826c51b1aff6 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -47,6 +47,16 @@ xtal: xtal-clk {
>  		#clock-cells = <0>;
>  	};
>  
> +	sm: secure-monitor {
> +		compatible = "amlogic,meson-gxbb-sm";
> +
> +		pwrc: power-controller {
> +			compatible = "amlogic,c3-pwrc";
> +			#power-domain-cells = <1>;
> +			status = "okay";

Why do you need it? okay is by default.

Best regards,
Krzysztof

