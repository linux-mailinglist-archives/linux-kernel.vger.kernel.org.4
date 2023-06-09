Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB17729A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjFIMlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjFIMlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:41:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA1C1A2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:41:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b203891b2cso18861581fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686314473; x=1688906473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAbk5K5T7EimIImnFE4kZxayLfuVA86dV2h+g48YHm8=;
        b=wYw/zG/6yf5TloEjQGKFZj4Xmm78ziBJ1uCXesppIT9VereP2CeQ+Jl5ahKzJiuJ7e
         wBCZJ6w3DndVFgC2/MOBy5vHDR5/1twEMEIJbE9lKTna8lfU1amPfGDyMuxaLkbEpitk
         v9Xe+zJ5RMHzg+PjcopKrgDb0d7yTPKp+aMLus50vu3awc+DV7+03xfg3tWGIMgBfqwt
         5CyiymjCZPixxbPNSMx1gMPz2c9Sgc9yrspj/q/Qz1ZRZzpeH20Gp2M3gWkhKjXs4hhP
         Gx5FCWvroU7gyXvEAv4t1CmAl8LovyGl0lUJGi2KCaLlONNHUjTuXVfpKqWaUS0nBVmY
         f32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686314473; x=1688906473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAbk5K5T7EimIImnFE4kZxayLfuVA86dV2h+g48YHm8=;
        b=R1yb5MMA/IwYwiuI5PxUMJZi6nZZQ8CIF5aMUqdAA1Nv3wZvvM4DqMgajevaVCh6l0
         ra8727GioEv8a+mFPVUoqk7j4OKfhEtGF7p1wBF9Q5w0bljOxBZI7NkI00+hdAvugYDh
         19RzJgGiKaY72exkcJHKNoefQewW/mSDNbuTvT3F+HsKE9RwLtTS+dNRLZZ7wjd5Abzk
         Yl1t+R0DUlAq2vukN+Rfo7KQ7V6VnpdA/EWi3HB4zSKKED+mweYKFnN0BiH3GYUsC9og
         Poh4pXiS/7Xl0X3n7NrNjSCclCAKEw5nrYX84vzBx2fGJHY9rhIpmx1E23Yxb0wHyevh
         Pneg==
X-Gm-Message-State: AC+VfDyuD1hzuQLbQ3HAd2X9NMDlqfN5o0RBar1tCV232NfoNFfUI6Ey
        /9dSCDzgGX8+WTiTkgrAYRZPxw==
X-Google-Smtp-Source: ACHHUZ5okdIhfZ1lUdCz754l/opk34vtezEoVF1Q6tWPVmnYuJJTAEO+2ROflh8eu+31rfndM/6GOg==
X-Received: by 2002:a2e:b0e7:0:b0:2af:1844:6fdb with SMTP id h7-20020a2eb0e7000000b002af18446fdbmr907329ljl.5.1686314472624;
        Fri, 09 Jun 2023 05:41:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id d7-20020a2e96c7000000b002b1ad0e7357sm379857ljj.51.2023.06.09.05.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 05:41:12 -0700 (PDT)
Message-ID: <dbb847c4-1043-081b-f28b-ea57fe5cad2d@linaro.org>
Date:   Fri, 9 Jun 2023 14:41:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:PCIE ENDPOINT DRIVER FOR QUALCOMM" 
        <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1686311249-6857-1-git-send-email-quic_krichai@quicinc.com>
 <1686311249-6857-2-git-send-email-quic_krichai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1686311249-6857-2-git-send-email-quic_krichai@quicinc.com>
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



On 9.06.2023 13:47, Krishna chaitanya chundru wrote:
> Some platforms may not boot if a device driver doesn't initialize
> the interconnect path. Mostly it is handled by the bootloader but
> we have starting to see cases where bootloader simply ignores them.
> 
> Add the "pcie-mem" interconnect path as a required property to the
> bindings.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
Hi, only patches 1 and 2 made it to both me and linux-arm-msm.

Consider using b4 (https://b4.docs.kernel.org/en/latest/index.html) to
avoid this.

>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index b3c22eb..656e362 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -70,6 +70,13 @@ properties:
>      description: GPIO used as WAKE# output signal
>      maxItems: 1
>  
> +  interconnects:
> +    maxItems: 1
> +
> +  interconnect-names:
> +    items:
> +      - const: pcie-mem
> +
>    resets:
>      maxItems: 1
>  
> @@ -97,6 +104,8 @@ required:
>    - interrupts
>    - interrupt-names
>    - reset-gpios
> +  - interconnects
> +  - interconnect-names
>    - resets
>    - reset-names
>    - power-domains
> @@ -194,6 +203,8 @@ examples:
>          interrupt-names = "global", "doorbell";
>          reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
>          wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> +	interconnects = <&system_noc MASTER_PCIE_0 &mc_virt SLAVE_EBI1>;
> +	interconnect-names = "pci-mem";
The indentation is off and my brain compiler says that it will not compile
without including some headers.

Konrad
>          resets = <&gcc GCC_PCIE_BCR>;
>          reset-names = "core";
>          power-domains = <&gcc PCIE_GDSC>;
