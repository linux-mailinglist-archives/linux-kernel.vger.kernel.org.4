Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8A0625E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiKKPQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiKKPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:16:06 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58A182925
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:15:10 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id c1so8753149lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRAjIuLoncT0vEXyiExqrXHcMSWWFyEsoVTWxa7wrjQ=;
        b=VooUbudepaF45w3v4t4PxOXKNDYYJVbbA889yqHMYqDjly7l77F5QvaKC3Fe8KhnUm
         xH4DYeB4MGrss0aYVKvWR/zsLqB/UvGKI3YeL1+LRNyNdVWZYDLY3y9jlDUbA68/uDSX
         dmodidVdgpXggmbMozE/UP/aviSe8FrGmmY6p+y4JdR/FJnxjDjARGls2zUagYey8vdE
         Ddi0CoLsmw6fC9khw+48f9aWbV2bfN9q/i2ECM1h6kiGmR7q5u/Lg2NmhlDw1JoKPz/M
         SWZSeESMbBi0qouM+B5raOHCyJCUhxXyVUlnNxp1Ke7umUX/WBADgsP9DflskoGhRNU+
         lmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRAjIuLoncT0vEXyiExqrXHcMSWWFyEsoVTWxa7wrjQ=;
        b=OiwbpgaETv5qrXBgEe8qpEiGLcf04FJ97WSAu4rnlK7f0dpX60cbgQwIjfD1ebpFIN
         wt+c7c4IKZ//AtzvagDzMYTsTgKXvONIRuRuIa0WUf1RCivdN4Dk7q7GbF5Y0MM1KZMg
         aqMVk/Oj/Dd/95LtTiSBa2mQnpa+FK4900sUv39ENPF5dq9ieaZMJkQhtHYyd6bl3lDE
         ZWSdXJDB0f7SSugM5caQRpB8G5ik3OU/5FUJ8shhipELgYxHMTPrDOj6zwEYikjAdau3
         qD3taqe4M+GfZNM6aBBIFlWTcwZxnw3JMn+LavX2nc6n+aOWrgk66d5YpiPY4Wnh2oRK
         HKAA==
X-Gm-Message-State: ANoB5pl11YJJgJ9pMFceYjn5jITGCjTC9CuAVDQTWzgHOLLoGza20q0R
        KoMszHjS7GcWEAEJoVZ60oDxtw==
X-Google-Smtp-Source: AA0mqf5eFnO/NW4E0B9uFn8MaAK6MY7CZ4uQOrf4pWm5EW76tiocHA3B99AUojMIyPzOB9CwhlyMEg==
X-Received: by 2002:a05:6512:c11:b0:4b1:b061:4815 with SMTP id z17-20020a0565120c1100b004b1b0614815mr861148lfu.18.1668179708865;
        Fri, 11 Nov 2022 07:15:08 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id z39-20020a0565120c2700b00498fbec3f8asm370379lfu.129.2022.11.11.07.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 07:15:08 -0800 (PST)
Message-ID: <6530db84-9bc0-91df-2719-e44fa8d6fb36@linaro.org>
Date:   Fri, 11 Nov 2022 16:15:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/14] dt-bindings: phy: qcom,qmp-usb3-dp: rename current
 bindings
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-2-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111092457.10546-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 10:24, Johan Hovold wrote:
> The current QMP USB3-DP PHY bindings are based on the original MSM8996
> binding which provided multiple PHYs per IP block and these in turn were
> described by child nodes.
> 
> The QMP USB3-DP PHY block provides a single multi-protocol PHY and
> even if some resources are only used by either the USB or DP part of the
> device there is no real benefit in describing these resources in child
> nodes.
> 
> The original MSM8996 binding also ended up describing the individual
> register blocks as belonging to either the wrapper node or the PHY child
> nodes.
> 
> This is an unnecessary level of detail which has lead to problems when
> later IP blocks using different register layouts have been forced to fit
> the original mould rather than updating the binding. The bindings are
> arguable also incomplete as they only the describe register blocks used
> by the current Linux drivers (e.g. does not include the PCS_LANE
> registers).
> 
> In preparation for adding new bindings for SC8280XP which further
> bindings can be based on, rename the current schema file after SC7180,
> which was the first supported platform, and add a reference to the
> SC8280XP bindings.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  ...3-dp-phy.yaml => qcom,sc7180-qmp-usb3-dp-phy.yaml} | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/phy/{qcom,qmp-usb3-dp-phy.yaml => qcom,sc7180-qmp-usb3-dp-phy.yaml} (92%)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
> similarity index 92%
> rename from Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> rename to Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
> index 97a7ecafbf85..50b1fce530d5 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
> @@ -2,10 +2,17 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/phy/qcom,qmp-usb3-dp-phy.yaml#"
> +$id: "http://devicetree.org/schemas/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml#"
>  $schema: "http://devicetree.org/meta-schemas/core.yaml#"

Since you are touching one line here, maybe let's drop the quotes from
both of them?

In any case:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

