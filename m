Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56606BC6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCPHOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCPHN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:13:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1CDADC02
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:13:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z21so3772911edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678950807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQqBxhsFpqht9TV3ODi4eqp1h6oGT5RNGJVf78eU7ys=;
        b=mXgg3KF+U8HsBWs12EmYyC6aiUPvUi7w/0p0EKveStEcm9drVh0Cf6U0LfVL7OqLob
         kt2FJzKBcNkqUeqU0dHEOF+3i+XSk2uHNpV6wDStGtdCQErJXcR5szdPH6XXhCHH5yRP
         po2rbgpMC2XZQfDs3eH5ZgBvgNHaeLc1LyRirGHNP0JnNyDRXPhhZMtveGK48JDDGsZi
         HX6/nHEpiEDYk39mYh57xydK+y/k/rsK+aMCbECpuLTPzJ3NAWbHxnEA0NlkbPA0GRJI
         Jc9PEGtJTxme5EFHzumoWle8qBBTaPc+kOSroopXECWK0bubelFQK1eDdLNAhM1Kj4GR
         3F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678950807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQqBxhsFpqht9TV3ODi4eqp1h6oGT5RNGJVf78eU7ys=;
        b=t7PahlWj1vMkVwqzygjek0cCkaOH6F8guspdeRHMUw6amRSvhcHdXcw1JLmOLze5SU
         VyXvvOkOjSAp840h19/1JlYP5o+hrTJiJCIK2y8OkQ3/DTPxKgALpbtZejxXI+9OeFey
         SkmYaXnjf4W7uFMaw0zMTrQtd+ML7TMLoCCHAKo3G7w3vL0+W6wVX8dh2meqW3Mv/h8Z
         mwjyKt74uA8v5mOigHwPZM01eO3fLVMHttVzTKZ8QnbXJpakc9Gsbhw6eCgdA7kAIz5+
         h1OKlwKnhtq88F4OUUDE60mksUKF83UY30ucbuFS7b+gll979nmME2x5IMMBMvxt+nZq
         fY7A==
X-Gm-Message-State: AO0yUKX87EwM3oQb64JpLzDpbHg4DwJQYhqMH5grNOt2JZa7VYwupURo
        TrNa6q3VAtCOM3FBXLtwcqOaPg==
X-Google-Smtp-Source: AK7set+9y57Tbht/OlWaMi3QKo2qNZTFOC475LQrmWPsM5KyA5oghAoT+UaS5gVbwxz/UHpbpizsLg==
X-Received: by 2002:a17:907:20c1:b0:930:604d:5891 with SMTP id qq1-20020a17090720c100b00930604d5891mr1177542ejb.37.1678950807103;
        Thu, 16 Mar 2023 00:13:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id md21-20020a170906ae9500b0092b546b57casm3417008ejb.195.2023.03.16.00.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:13:26 -0700 (PDT)
Message-ID: <d4831176-c6f1-5a9b-3086-23d82f1f05a6@linaro.org>
Date:   Thu, 16 Mar 2023 08:13:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net-next 01/11] dt-bindings: net: snps,dwmac: Update
 interrupt-names
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        linux@armlinux.org.uk, veekhee@apple.com,
        tee.min.tan@linux.intel.com, mohammad.athari.ismail@intel.com,
        jonathanh@nvidia.com, ruppala@nvidia.com, bmasney@redhat.com,
        andrey.konovalov@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ncai@quicinc.com,
        jsuraj@qti.qualcomm.com, hisunil@quicinc.com
References: <20230313165620.128463-1-ahalaney@redhat.com>
 <20230313165620.128463-2-ahalaney@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230313165620.128463-2-ahalaney@redhat.com>
Content-Type: text/plain; charset=UTF-8
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

On 13/03/2023 17:56, Andrew Halaney wrote:
> From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> 
> As commit fc191af1bb0d ("net: stmmac: platform: Fix misleading
> interrupt error msg") noted, not every stmmac based platform
> makes use of the 'eth_wake_irq' or 'eth_lpi' interrupts.
> 
> So, update the 'interrupt-names' inside 'snps,dwmac' YAML
> bindings to reflect the same.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> 
> I picked this up from:
> 	https://lore.kernel.org/netdev/20220929060405.2445745-2-bhupesh.sharma@linaro.org/
> No changes other than collecting the Acked-by.
> 
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 16b7d2904696..52ce14a4bea7 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -105,8 +105,8 @@ properties:
>      minItems: 1
>      items:
>        - const: macirq
> -      - const: eth_wake_irq
> -      - const: eth_lpi
> +      - enum: [eth_wake_irq, eth_lpi]
> +      - enum: [eth_wake_irq, eth_lpi]

I acked it before but this is not correct. This should be:
+      - enum: [eth_wake_irq, eth_lpi]
+      - enum: eth_lpi


Best regards,
Krzysztof

