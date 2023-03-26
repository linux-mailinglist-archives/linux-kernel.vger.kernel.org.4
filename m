Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2656C9338
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjCZI4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 04:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjCZI4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 04:56:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BB75B87
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:56:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h8so24130538ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679820966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qd0F9PxYYxTCFQnk4TxK5as5OvW8GeFP90xOUu8RRGk=;
        b=ZfjIYCae3Q9sfcIVnSf3QdvIo1mE8i84rjsoOleieZB/PtHHv0lbP/uIZpa0rWQLli
         qXM0Hz8ZLNarBFoX6E0oKbdfbFL5hFo2zt/9pW9vSRZv5X/WFccxLyPeMyYlXLUmj7YS
         lvGbsepure0AbF6ISSWaJ8w0ixn1m8E1ZxXKJ43hP+7U5at7/oPKBE+pKX17uZI0S/12
         woRFKBvNLizzX9gr1lYe8csx3XBREmvl1X2lVMWYguKs560Fqb/yUh4d25LexsZq7R/z
         Wu3k5WIWMbI2uCkhj+hb6KQYIadSg0nqVk1olAcQHDqgkvJoNw4aWUolD49oyyLvbGMb
         WWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679820966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qd0F9PxYYxTCFQnk4TxK5as5OvW8GeFP90xOUu8RRGk=;
        b=RJJu9j323f3t1knF8S8QP2CjV2gRcCsKcqTycqG9MLfNaN2oH5wfAwbKIACiyFqI3U
         BAXdRODWNjiRX16e8C+IbU8SZcDKUVphv1QHLAo0N2+/KQLze/y3lpukL2L1e+KrVvaj
         yOwDcwlyXPE16FO82tghqIa0y1BnD5Yxl3S6nCO0VEEDqU4HO0SlOPNOBNxe3jLYYhed
         I/t7uhviEwNDDrEAbS6Dusy19fmGOJhER6JkDa7orQLdyDIkkBuRDdJp/KPTJY2892vY
         s9l6iiOFFrJ+VKRQRYYmKgbdX4eVvbcDnT9FCf27C2c4z24TK8FJ3MXPaB84An1oHNX7
         sG4w==
X-Gm-Message-State: AAQBX9c5fQNK/v95hB8BAXPNEITeTwpfyX+z+FsC0Ov47lFyrytDcIzG
        tKhEo7uq1g4Kaa4xrhZyqshN4A==
X-Google-Smtp-Source: AKy350b+qeYiT7Ih1u4tB2eokW8Ma8O21951mdgEfX+TyL22KuL/H3hg/Bmho8Pnz0MsFSw0/NDuLw==
X-Received: by 2002:a05:6402:12cc:b0:4f9:f07d:a978 with SMTP id k12-20020a05640212cc00b004f9f07da978mr8662696edx.5.1679820966129;
        Sun, 26 Mar 2023 01:56:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id r12-20020a50c00c000000b00501d2f10d19sm8780009edb.20.2023.03.26.01.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 01:56:05 -0700 (PDT)
Message-ID: <35879793-b677-a901-3f4c-6dc7d3c017ee@linaro.org>
Date:   Sun, 26 Mar 2023 10:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] dts: arm64: qcom: sdm845: add SLPI remoteproc
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230325135114.21688-1-me@dylanvanassche.be>
 <20230325135114.21688-2-me@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325135114.21688-2-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 14:51, Dylan Van Assche wrote:
> Add the SLPI remoteproc to the SDM845 Qualcomm SoC which is responsible
> for exposing the sensors connected to the SoC. The SLPI communicates
> over GLink edge 'dsps' and is similar to other DSPs e.g. ADSP or CDSP.
> This patch allows the SLPI to boot and expose itself over QRTR as
> service 400.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 37 ++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 2f32179c7d1b..8dcfe6293762 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3311,6 +3311,43 @@ glink-edge {
>  			};
>  		};
>  
> +		slpi_pas: remoteproc@5c00000 {
> +			compatible = "qcom,sdm845-slpi-pas";
> +			reg = <0 0x5c00000 0 0x4000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 494 IRQ_TYPE_EDGE_RISING>,
> +						<&slpi_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +						<&slpi_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +						<&slpi_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +						<&slpi_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready",
> +						"handover", "stop-ack";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +
> +			qcom,qmp = <&aoss_qmp>;
> +
> +			power-domains = <&rpmhpd SDM845_CX>,
> +					<&rpmhpd SDM845_MX>;
> +			power-domain-names = "lcx", "lmx";
> +
> +			memory-region = <&slpi_mem>;
> +
> +			qcom,smem-states = <&slpi_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts = <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>;
> +				label = "dsps";
> +				qcom,remote-pid = <3>;
> +				mboxes = <&apss_shared 24>;
> +			};
> +		};
> +
> +

Do not add double blank lines. Same in other patchsets.

Best regards,
Krzysztof

