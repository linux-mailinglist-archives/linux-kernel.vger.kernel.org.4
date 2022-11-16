Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4396D62BCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiKPL4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiKPLzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:55:45 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1424AF11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:46:51 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ft34so43342634ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGh6LEw9sD5U1ZV9P+A40VyRZW/b0s7lkJhlbNsJWyg=;
        b=tZydqGulJDpbofkvCx9ifk/cC0D8/C+Fu15MacnEuX0mdETX8lAC3SF6p0xtEqoJlL
         WU42q1qwx3G1rKm6dQITYgp1ZE6UISGQVP3xfhkPly+9f2CyYiwMp6n2OmQAwq6Jt3gE
         aiwcUOzlxFJ13JUymym54LLuupcXfvr8Yr8yqaOuzKfgI6TASPO1AZQKgjbsK0SZ9zpl
         42Q+xU2WdlD86p3L4OGF1MAIvWRwmXLNyAq/8wo+Io/74a+0RVU6Cm3tK+PEWl7wSp9y
         xMsj3a+9Sj3GlWyPbPug6sdIdBG9xnNgth2dkIbo1HIlWxuWO3s/8y+UORJu0LiyZEQq
         gYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UGh6LEw9sD5U1ZV9P+A40VyRZW/b0s7lkJhlbNsJWyg=;
        b=SRzPwLqD/U7dCm9pkDqfh33PPIBKeBtuu2F70Hx/nt3BtSo09uP/QmlwBYEAzMekzJ
         4CfubkjF4I7S5fWwPQP6y0tWfq4NtTK45ZFUjaCCA9GWwYBEqoUg6doQiJpYqtBwPUJ8
         qqIaNEFxnGQTuhGUALl78XR/GtefkB/e0ngJqbeb3vyy3rDjSlRhdkAtiZ2LT3lnBHgf
         CDhPZYE9ey7UrSWoFp77bmsKS0sA73A2Xil17cuy+7rB9es3fF4v8Mp0rydv9xA6lyYg
         H7gc28xPRlbwxFm40wHWm/zF8OCXyGlkixfLKURKYsaRE95yhyjpz9buWmXouc+CMtFs
         xAvw==
X-Gm-Message-State: ANoB5plpwC04vZgE0mwZMj9dau/ltGyXMfSOmiOQZAY0xoepsbPWphB3
        HtghHh8+fhaEmTdF/1uRhzAI/Q==
X-Google-Smtp-Source: AA0mqf4TLWE3qa0twFDb2mzsNtdutyTOUdBepJumOUQKoCYkEeueUI5CbVEuzzmyZJ9+U4hvCuZAjg==
X-Received: by 2002:a17:907:7659:b0:7a0:3125:f1e5 with SMTP id kj25-20020a170907765900b007a03125f1e5mr17056326ejc.314.1668599210470;
        Wed, 16 Nov 2022 03:46:50 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id bf28-20020a0564021a5c00b004643f1524f3sm7373522edb.44.2022.11.16.03.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:46:50 -0800 (PST)
Message-ID: <b8404a1e-9171-0b64-f879-beac62bac92c@linaro.org>
Date:   Wed, 16 Nov 2022 12:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8550-mtp: enable adsp, cdsp &
 mdss
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221115-topic-sm8550-upstream-dts-remoteproc-v1-0-379eec11d841@linaro.org>
 <20221115-topic-sm8550-upstream-dts-remoteproc-v1-3-379eec11d841@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221115-topic-sm8550-upstream-dts-remoteproc-v1-3-379eec11d841@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 11:43, Neil Armstrong wrote:
> Add the aDSP, cDSP and MPSS firmware and "Devicetree" firmware paths
> for the SM8550 MTP platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> index d4c8d5b2497e..be06e25409c3 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> @@ -376,6 +376,24 @@ &qupv3_id_0 {
>   	status = "okay";
>   };
>   
> +&remoteproc_adsp {
> +	status = "okay";
> +	firmware-name = "qcom/sm8550/adsp.mbn";
> +	qcom,dtb-firmware-name = "qcom/sm8550/adsp_dtb.mbn";
status should go last. I missed that in the review of the patchset 
introducing this DTS, please fix it over there as well.

Konrad
> +};
> +
> +&remoteproc_cdsp {
> +	status = "okay";
> +	firmware-name = "qcom/sm8550/cdsp.mbn";
> +	qcom,dtb-firmware-name = "qcom/sm8550/cdsp_dtb.mbn";
> +};
> +
> +&remoteproc_mpss {
> +	status = "okay";
> +	firmware-name = "qcom/sm8550/modem.mbn";
> +	qcom,dtb-firmware-name = "qcom/sm8550/modem_dtb.mbn";
> +};
> +
>   &sdhc_2 {
>   	status = "okay";
>   
> 
