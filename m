Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281C571958D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjFAI2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjFAI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:28:01 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C90F1B7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:27:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so567163e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685608073; x=1688200073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsfcfGESGOogETw3T5X2wpY9BTZmmJqhcoXtEqtASKo=;
        b=UUxlvr8zvGFQEIwD5uk8jlu5LtcGJ3NVIIM7Vpk2DLiHlLZ0cXc717j2o3HapQdtdQ
         dbS3E5pksCjCwhyMtdiK4zf1bLVsrKO3LCr+HNNF675CGwSFzQTlsZY6lGTZx6uBKsyk
         tBsCrCznJk5Ywfc1EG8BwKWiDBLmG2Y1Iq5Vv6Ml9sYwpahBxfTEdAi5WVExu7HgmYNi
         Oho2iREeb+irx/EXDkQYZEfIWVgxKiVccw3INeBPXEVGIB7E6JV9mfQmyPk6a1hjspAm
         BGox/eRQDUs1tKCWpcmObPv32ZreSl5kmXJjw6+k2Ca6+voETStaCp13NFU1VHQin4Vu
         vlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608073; x=1688200073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsfcfGESGOogETw3T5X2wpY9BTZmmJqhcoXtEqtASKo=;
        b=GbqLzPtSEMUp+xytk7B2/GDkWVnjEb6wz5ZaZcRnzqR+DUe2fTGn3DNw4jKe7hYMBg
         huQFlD1zSjK7HHxq0505LNn2ezY2tnCO1SMPLoYvT0dl6CMf4YZnmCcGRxfucreuhJ7P
         ia2+S1ZoKHHksx3vgLeLsT7fGX9nMmNDld2Dlv2pua26F7iTHqwkKlFWqquQEYcIA/d6
         0ghYo92P0n0mqeRpUWf5Sgh/UzD1OyJVLjd9u4+WQM5XjqxGCxEX/9u3lRx+2BZzBYaj
         EPJMm24+GmPOSyeZKZbaVXGCVjmTICiJvfm+pO75UUu7rFPd4irxjnUYjO7vwPO15mfq
         hRiQ==
X-Gm-Message-State: AC+VfDwHaH8RW3JoazfuXceN5q5QJuDbPhtl2s7q/qSRTC5X3bh+RaQt
        ax8phzfTJxouye+Q3St/lUfjYg==
X-Google-Smtp-Source: ACHHUZ5tYw/+FcRpUECgAitYh/zC9TCY6uDCLqNVK14Gvoiqu/LnI5iFdPakDoYcpGjlOWGGit0p/w==
X-Received: by 2002:ac2:518e:0:b0:4f4:b864:1da0 with SMTP id u14-20020ac2518e000000b004f4b8641da0mr844057lfi.15.1685608071525;
        Thu, 01 Jun 2023 01:27:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id e18-20020ac25472000000b004efee5841b9sm990576lfn.290.2023.06.01.01.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 01:27:51 -0700 (PDT)
Message-ID: <4f4a4ec8-9dad-312f-0859-7469c8c25477@linaro.org>
Date:   Thu, 1 Jun 2023 10:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: qdu1000: Add SDHCI pin
 configuration to DTSI
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601065805.18079-1-quic_kbajaj@quicinc.com>
 <20230601065805.18079-4-quic_kbajaj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601065805.18079-4-quic_kbajaj@quicinc.com>
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



On 1.06.2023 08:58, Komal Bajaj wrote:
> Add required pins for SDHCI, so that the interface can work reliably.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 50 +++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index 6df07334f1d3..9f615f3368c2 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -1147,6 +1147,56 @@
>  				pins = "gpio31";
>  				function = "gpio";
>  			};
> +
> +			sdc_on_state: sdc-on-state {
> +				clk-pins {
> +					pins = "sdc1_clk";
> +					drive-strength = <16>;
> +					bias-disable;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc1_cmd";
> +					drive-strength = <10>;
> +					bias-pull-up;
> +				};
> +
> +				data-pins {
> +					pins = "sdc1_data";
> +					drive-strength = <10>;
> +					bias-pull-up;
> +				};
> +
> +				rclk-pins {
> +					pins = "sdc1_rclk";
> +					bias-pull-down;
> +				};
> +			};
> +
> +			sdc_off_state: sdc-off-state {
> +				clk-pins {
> +					pins = "sdc1_clk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc1_cmd";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +
> +				data-pins {
> +					pins = "sdc1_data";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +
> +				rclk-pins {
> +					pins = "sdc1_rclk";
> +					bias-pull-down;
> +				};
> +			};
>  		};
> 
>  		apps_smmu: iommu@15000000 {
> --
> 2.17.1
> 
