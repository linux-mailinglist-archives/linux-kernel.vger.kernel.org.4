Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B05E70948A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjESKNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjESKNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:13:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94494E47
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:13:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d3e5e5980so99399b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684491192; x=1687083192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSr7GdXWAJku5Kok/w8KozBJgW/7oVgHlXu4LnQYU4U=;
        b=AMYwSYKjD74G4Sw9tPc/nRaoL17u7EvGnGODVSfNhloK/SPeeqRD/GT1KCyKJg2Omz
         eGIQemeDf5Tp/uGNuMICegZqzEvI2IThIZt23UyHiXLNXV69Epl/EyfBbJ5fGMEgJxpe
         fykU5WMP1StVgRHUrIxCeuIn5oCBg9YwwY7o4Du9FeZ39gRWPwa5HOVux9DCdi5GNv4F
         WXQ29NIgBQ9H/ufW3/IzAYS/FLw8jbcxsgS+HYQJK6wt+CNNQQUjGu6kYBrwq1UVCig0
         knv/dg9Ia25SXp88Ykh7NRtrRs3uKAwAyQM6R6ILcu8prQ3Q7mO3Il08Xh7dAF2g+GcN
         B1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684491192; x=1687083192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSr7GdXWAJku5Kok/w8KozBJgW/7oVgHlXu4LnQYU4U=;
        b=IIzt/cXAak5727RrPEMzymlpofm6YhXE56yvUTxc3zwyCv/awYa/MtHC12oiADnPzU
         PtQpwnUteCziZi2XyM6wt+DxoJhUdqyBBTxqMj810hjW1AiO+JibpyFsLPlRunWbuTDM
         2rJGzu/Zc6n349R4QM/SngAsjqS4fY/8MK/QckJQ348rF4osRvmSU+WqvStYmsxFQNBp
         oKugFOyWNXPn0aUiguM6+cjwJlzbpnx1Z0iuoRELaY77VQWMQqRsk03MdiUwv5WwClgw
         qQTwBQshWwgCEzWf86m9yWXJE4GLwM3aBVATmg0rEsDO/nlQMO/QCnbEgAgHKBTJpZIl
         SX/w==
X-Gm-Message-State: AC+VfDxJ9gVSsChQzC+YCJYxEKzOhYdXEFk79OPGzw7tstA5KmjqqnW5
        sLF32Y/GTqaU+Vm6dWsEIIIo+A==
X-Google-Smtp-Source: ACHHUZ5kIqy1tdfgOlJbIVGQKOPxbA7vVEAaQIQrUfkKpzzN8ZCX1hfQmxBOMBUcHovpjekE6/JZTg==
X-Received: by 2002:a05:6a20:3d09:b0:104:a096:6ac7 with SMTP id y9-20020a056a203d0900b00104a0966ac7mr1962172pzi.34.1684491192074;
        Fri, 19 May 2023 03:13:12 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:d309:883d:817e:8e91:be39? ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b0064d35776709sm732016pfn.78.2023.05.19.03.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 03:13:11 -0700 (PDT)
Message-ID: <8e3c745a-2e37-2927-7dbf-e23a777702f3@linaro.org>
Date:   Fri, 19 May 2023 15:43:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
 <20230519085122.15758-5-quic_kbajaj@quicinc.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230519085122.15758-5-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/23 2:21 PM, Komal Bajaj wrote:
> Add sdhci node for emmc in qdu1000-idp.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> index 9e9fd4b8023e..b2526e991548 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -451,3 +451,14 @@
>   &uart7 {
>   	status = "okay";
>   };
> +
> +&sdhc_1 {
> +	status = "okay";
> +
> +	pinctrl-0 = <&sdc1_on_state>;
> +	pinctrl-1 = <&sdc1_off_state>;
> +	pinctrl-names = "default", "sleep";
> +
> +	vmmc-supply = <&vreg_l10a_2p95>;
> +	vqmmc-supply = <&vreg_l7a_1p8>;
> +};

Again, please follow alphabetical order for adding new node entries.

Also, we have been placing 'status = .. ' entry at the end for new .dts 
(or .dts entry), but if that is the format used across this board dts
I am ok with the same.

Thanks,
Bhupesh
