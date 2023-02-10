Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6824E69207A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjBJOGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjBJOGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:06:20 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A450B6D47
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:06:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id c26so11346055ejz.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C84/0iEsdS/Ah8zV8cW8b6xnMEQGwqyDnz0IHNRwxD4=;
        b=LptNiSGFmvY0/qCTeQhV/hLeFslQ9zJIhRnqPjjlxQYg914PSqWtNG/bvtgWErOR7U
         /5gsUCFM9mwAIzbVKCagSISEpBuXHgmZuxsaHFACfBedDq75WoJdFYONhqGB+3WAsVOd
         4T4wcEkNfzCo+yqctzAnbr+6M83hKe9qY9y2rdSGmSXvm35MwMCv716L/e8Zrwyu7cjg
         Xl6qR9hVCpamGCaKZNo+D3Jt+tf0jzPcWATNl4tbDx+ijIEacKWgudUUX96/7KQ0vsyN
         1wksJtWZH1N/jpidjXYgd2WcaBNJG+s1JYRCPCP7pJ5XUQ/gYxcoCAAYBNDW+iuB2MjJ
         dRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C84/0iEsdS/Ah8zV8cW8b6xnMEQGwqyDnz0IHNRwxD4=;
        b=JtLjc3nvFcpqEwhdqYNoIPEyh1mmJyNJx5PP9snyX8eFTrIFyY0x6E2BpZCyYUfJat
         PgiyUWL7L/2zN93EunYftUNFqPR6apUpMANsxlwDMfNyTCTOJ/QemNWg4PcjzD5UN7Pj
         L4VN/VcSnwQ4m5K8rUAugVVc+3V90EiKyCFyyzpBSkPH5Vc9RQ7iY/XNseETAGEVj8ur
         CRrIftiBInuIt7FjCI/bLZh1+HgWSnX4Ea9sp7eiadfUSJgMSFblcmCuanyu07SC9DzT
         zknKvoPsSSXTUDNPYsvwbDMYSWcAU/q2HVY08mLEINy0S0qZqXuryW9kyrvsMsnX6Ugs
         Z60A==
X-Gm-Message-State: AO0yUKWb5wdzgkG1biVg+Cx6kcuyGVWDeqGUTEBL+35M7k+Y7VFDf9kk
        37zwD78drkNDXd90EezvzA0SXg==
X-Google-Smtp-Source: AK7set9EKHy19EA9gCXPxfSM91T49eokdUAjpyCvDc6i2Cyg6vRFysSAuBD5wjrh6nM+JhwcSmL6Iw==
X-Received: by 2002:a17:906:ecb0:b0:84d:4325:7f7a with SMTP id qh16-20020a170906ecb000b0084d43257f7amr15275528ejb.65.1676037965157;
        Fri, 10 Feb 2023 06:06:05 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id i3-20020a170906698300b00878775876c5sm2413756ejr.73.2023.02.10.06.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 06:06:04 -0800 (PST)
Message-ID: <16e6a11e-e6ba-966d-1011-1085527b84c7@linaro.org>
Date:   Fri, 10 Feb 2023 15:06:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/4] arm64: defconfig: Enable DisplayPort on SC8280XP
 laptops
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230209011325.2603663-1-quic_bjorande@quicinc.com>
 <20230209011325.2603663-5-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230209011325.2603663-5-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.02.2023 02:13, Bjorn Andersson wrote:
> The QCOM_PMIC_GLINK implements the parts of a TCPM necessary for
> negotiating DP altmode and the TYPEC_MUX_GPIO_SBU driver is used for
> controlling connection and orientation switching of the SBU lanes in the
> USB-C connector  Enable these to enable USB Type-C DisplayPort on
> SC8280XP laptops.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> - None
> 
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 695c4e44d241..edafb5c4b9a1 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -972,6 +972,7 @@ CONFIG_TYPEC_TPS6598X=m
>  CONFIG_TYPEC_HD3SS3220=m
>  CONFIG_TYPEC_UCSI=m
>  CONFIG_UCSI_CCG=m
> +CONFIG_TYPEC_MUX_GPIO_SBU=m
>  CONFIG_MMC=y
>  CONFIG_MMC_BLOCK_MINORS=32
>  CONFIG_MMC_ARMMMCI=y
> @@ -1207,6 +1208,7 @@ CONFIG_QCOM_CPR=y
>  CONFIG_QCOM_GENI_SE=y
>  CONFIG_QCOM_LLCC=m
>  CONFIG_QCOM_OCMEM=m
> +CONFIG_QCOM_PMIC_GLINK=m
>  CONFIG_QCOM_RMTFS_MEM=m
>  CONFIG_QCOM_RPMH=y
>  CONFIG_QCOM_RPMHPD=y
