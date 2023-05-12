Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9787000A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbjELGhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240070AbjELGg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:36:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCBFA24C
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:36:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so16824823a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683873401; x=1686465401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fHMOSAlolDJzGPoektY7MZE9dXHoLFYx7cEk41VbQNo=;
        b=Xr7f+3Oug1zfWQ0ZKMKvoULx0EYQbGRf/8rpU+HQJU7rTaam/SMRpcZkqrZY5+RVwQ
         Av24pr7xVKoCbRxkBjRqHbJ7PG1DorYp1SIjptyMLeXLmwPDRgyGYxdohEuVMwiwbpWA
         FBXyJNdKanHXVUrNxP1cBhE62XMQ2Vy+i98fuXZ0UQ2a+ewfqSTmzqlgOlCpKQsA/81a
         kCDT1Vdv/mzDS0yvPzD6kVyRCHQeNqjb2jo3qD1phKN9i9L0LzUk04B5t5i0gBVglxbp
         B6pslcmEQn1B7+tnW/QEoJoY8trkNLb6AzBagwmrpfckHvld82d2Z0eQ9J05O7PuV4Rt
         Xr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683873401; x=1686465401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHMOSAlolDJzGPoektY7MZE9dXHoLFYx7cEk41VbQNo=;
        b=AvGF2BK7BxnIxbxgSzxiSFc5SnGUxigz/o7o4701StIgWgHdAARa/PIuZ02VUaTPjc
         oq1Jhz0Tkvu9R6B9xNFSmXYnQSKZklG1DjX6tjsW4b+nOpMlE0gcVQqcXCklENN4b1ty
         Pnpi3gJQdu4HOueVCqEP2KjtdKytWC3eIHeq30j87Omb0n89ei9IKMl32OYFpZzZsS7T
         IOocAUJSAIvHAIc/zu7bTAVowxSPwM+BPoJTG44VswKdwqjqVEvvGKXGEpPP7AzutavW
         /lhYQvqtkdWkzNPGzswow2GxcK9sP72pfwl1D1EWVjQ69aq+wLcYwgz2UEklWPaxmjNQ
         tTdw==
X-Gm-Message-State: AC+VfDxQuqadrno4Hnnm+g5I5FTkzWeUXSDHZjJIir2HTEb7efQPKuFl
        cFpzUkBPo3J4//3F3w7KSq2BAw==
X-Google-Smtp-Source: ACHHUZ7gC5BEhT5G+mMuFNLabNgMWzL4lmE+SVW1OOiywba73Vfx8aP3OiCsgtB5gUphas7SISEpGA==
X-Received: by 2002:a17:906:fe0c:b0:961:78c2:1d27 with SMTP id wy12-20020a170906fe0c00b0096178c21d27mr20465597ejb.19.1683873401620;
        Thu, 11 May 2023 23:36:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id y13-20020a170906070d00b0093313f4fc3csm5038979ejb.70.2023.05.11.23.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 23:36:41 -0700 (PDT)
Message-ID: <3bb6c544-0b21-4728-683d-70db0f80394f@linaro.org>
Date:   Fri, 12 May 2023 08:36:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 6/7] riscv: dts: starfive: jh7110: Add syscon nodes
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-7-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512022036.97987-7-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 04:20, Xingyu Wu wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> Add stg_syscon/sys_syscon/aon_syscon nodes for JH7110 Soc.
> 
> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 4c5fdb905da8..fa27fd4169a8 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -353,6 +353,11 @@ i2c2: i2c@10050000 {
>  			status = "disabled";
>  		};
>  
> +		stg_syscon: syscon@10240000 {
> +			compatible = "starfive,jh7110-stg-syscon", "syscon";
> +			reg = <0x0 0x10240000 0x0 0x1000>;
> +		};
> +
>  		uart3: serial@12000000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x0 0x12000000 0x0 0x10000>;
> @@ -457,6 +462,11 @@ syscrg: clock-controller@13020000 {
>  			#reset-cells = <1>;
>  		};
>  
> +		sys_syscon: syscon@13030000 {
> +			compatible = "starfive,jh7110-sys-syscon", "syscon", "simple-mfd";
> +			reg = <0x0 0x13030000 0x0 0x1000>;

No children, drop the simple-mfd. Or your binding is incorrect or your
DTS is incomplete (you mentioned clock-controller). DTS should be complete.

Best regards,
Krzysztof

