Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B206B03E6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjCHKUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCHKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:20:04 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F8CB6904
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:19:52 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p16so9455082wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678270791;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G4UJgGFQCS60gORPfb5jvTB3Shrb24okB1uJeflKS5k=;
        b=rDJ4byQT3witJT9ZpPhCyHyo9ZLtMksrdgop8eMSuszhsVm9l4uBcMPeHlvF9/GZec
         zuwCcXbOmWnq/4+QzWU5APE09TpRla/gNSwzIhAOrw5Thp5gqDJSRorBRpf3WWk4246B
         SXAnwtDCbdhEpNZ8is/EC9hoUL5k/JycTWvxWq6AFdkNajaD550LUs7+ZD4mm7lc7S32
         haydniXzm79mTP2Q6g22ZYPywTaEXkI0r3L8fJPI2fhxvUMW3vHww676+h/KknFglLNA
         0/+kx9OH6Zn98xi4Doj5lDLEh79XM8hExjE7kYVtDTl1G6QdzQeJVLfNK7EjqEr++WXu
         QsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678270791;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4UJgGFQCS60gORPfb5jvTB3Shrb24okB1uJeflKS5k=;
        b=gNWqpyru54I5T0AkPiHWpBoykihNCVnC1yXYY1CGD4k6dPwpgd1TxpNf9cOKyNTV1V
         YK/KUn+WZh4/fDxM4sbrKkPxPz42Sv/aZF0/5ka3iKqzZtayR/Hmc3Ze/xQpnEt6qtVa
         bSZ6EW2YhcGSY6Pwm2ZY4bAhOhxvwCuWdqrZCCvZqHwDBzmVfqHy+CCO2suAk4yCBV+N
         WjvH8qcwT5sgvVF5ja/ooPztBRRN3IO3UoHftZxB385TABYeyF2AlKiQMm+Gn6Gmus2a
         XwhVGkijZUs8wsjscHCeeufkYHcWGOMMIIZhOqkdM2E91ZFN2sKJmctPXkxpPEp8Ci6f
         0UFw==
X-Gm-Message-State: AO0yUKVwXyjegNUTHuSt1E+zcCeP6yHXUQjRi4s7M/QlXdov6iQC1BIH
        LYQbhFTt7DjQhihJZzgOSfvYl7l/DAsMybM1OrWmQg==
X-Google-Smtp-Source: AK7set/7Sj5FknQ9VK7WSO6K4KMSl0TwOhDpSOJnz+PtLu/v4CeRNTRrTwqrgnKmiP0c/I5P2+cV+Q==
X-Received: by 2002:a05:600c:a04:b0:3e0:1a9:b1d7 with SMTP id z4-20020a05600c0a0400b003e001a9b1d7mr16026746wmp.19.1678270791153;
        Wed, 08 Mar 2023 02:19:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b029:83b9:1fb8:7c34? ([2a01:e0a:982:cbb0:b029:83b9:1fb8:7c34])
        by smtp.gmail.com with ESMTPSA id h6-20020a1ccc06000000b003e118684d56sm19780278wmb.45.2023.03.08.02.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:19:50 -0800 (PST)
Message-ID: <811092b8-a83c-cd00-c965-1f7552d423eb@linaro.org>
Date:   Wed, 8 Mar 2023 11:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: Mark UFS controller as cache
 coherent
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308054630.7202-1-manivannan.sadhasivam@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230308054630.7202-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 06:46, Manivannan Sadhasivam wrote:
> The UFS controller on SM8550 supports cache coherency, hence add the
> "dma-coherent" property to mark it as such.
> 
> Fixes: 35cf1aaab169 ("arm64: dts: qcom: sm8550: Add UFS host controller and phy nodes")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index ff4d342c0725..5315e24fa525 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1905,6 +1905,7 @@ ufs_mem_hc: ufs@1d84000 {
>   			required-opps = <&rpmhpd_opp_nom>;
>   
>   			iommus = <&apps_smmu 0x60 0x0>;
> +			dma-coherent;
>   
>   			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
>   					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
