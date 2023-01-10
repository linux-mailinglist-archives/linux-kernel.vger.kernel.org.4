Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAAE663F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbjAJLPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbjAJLOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:14:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E2032E8D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:13:07 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id co23so11347059wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dPzlC0gssROAhnqzZY5hj9pGncF4W4g/2QwhGd4H5k=;
        b=TbF+kNaV+9eHtx7+cv4tGFPH19N+VCYsRoOpfm5n50+Qf0Ja+oJO+zYilk9xHX3TyF
         EIBAPAH3iyYTQSEQNR7fU6agCDTW6L9vadX8JMmYqsD2uAk67DWDR6NbVb5E7ZxVswVv
         Ig4G5fK5TFKUR90Ftx18X2XBaSmtxxqsfuCOOXYDvWQ4zvv/fsMRmny2/2/mmVzk5njF
         ctEWDNLqO6edbMDEixSY6k+mIqGkwzviD8CZvURIwmgv8NJYCr9shBXdighXa5l8a/v9
         edw1gtDlliBu8NdkiWWdE/OzCsVOPSN5rAUwVL7ARFLjx1lrXHsFTYSTQvbV19AB6aFw
         0Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dPzlC0gssROAhnqzZY5hj9pGncF4W4g/2QwhGd4H5k=;
        b=dESJ9NDk3x8GvLO9o6SJlksutyAohFHyvK/hEM87W44cSLL6oI0lWbwxSS3YRpXWuD
         ToF5xUqHSEOP/IAM0Y5PcCGZN2quDOnNLe5XMu7qqdN3i62zxVYcADUXqSCIs8796qcM
         0jIhkJdpWHv7cuiUdqjCKWp/YBVjm3C4h8wlpGXUrP5mX8xhTE+PaVYvFXKYn01HX6TO
         /tO08zT0KVzapxS9i4/agGr3I6GZm24MCWO77q0aClW0Vcur54zhP5bvjCmRwgMv7k2b
         qAb1xLGVExAE6qi5WFWAyDiL4pwHOySHZsm6HqUp8mB757mR4qW4BSXsB2CtJ+nsumW1
         a66w==
X-Gm-Message-State: AFqh2kq20NIbNzmPZFHKcHFClah5mIYdZVlBxTvhdinmt5a4+yqzXWYj
        Kumy3++DkHWBxQKx0Iww01mOFQ==
X-Google-Smtp-Source: AMrXdXsdisWhO2Djpc11s083LkXrNT9w2qqpFyq11vMLjuyN4iVqo2PMBU6yFlvX96QA1ifG0yEsiQ==
X-Received: by 2002:a5d:5408:0:b0:242:51ae:e9ca with SMTP id g8-20020a5d5408000000b0024251aee9camr43600701wrv.35.1673349185627;
        Tue, 10 Jan 2023 03:13:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcd91000000b002b6bcc0b64dsm9741892wrj.4.2023.01.10.03.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 03:13:05 -0800 (PST)
Message-ID: <0e43f226-4599-d6b1-fd2e-b61ddbb44464@linaro.org>
Date:   Tue, 10 Jan 2023 12:13:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: sc7280: audioreach: Update
 lpass_tlmm node
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        konrad.dybcio@linaro.org, mka@chromium.org
References: <1672925875-2107-1-git-send-email-quic_srivasam@quicinc.com>
 <1672925875-2107-6-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1672925875-2107-6-git-send-email-quic_srivasam@quicinc.com>
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

On 05/01/2023 14:37, Srinivasa Rao Mandadapu wrote:
> Update lpass_tlmm clock properties, as different clock sources
> are required in ADSP enabled platforms
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  .../arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index 8c55753..7583c3c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -169,3 +169,12 @@
>  		#sound-dai-cells = <1>;
>  	};
>  };
> +
> +&lpass_tlmm {

I don't think order of nodes is kept anymore...

> +	clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +		 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +
> +	clock-names = "core", "audio";
> +	reg = <0 0x033c0000 0x0 0x20000>,
> +	      <0 0x03550000 0x0 0xa100>;
> +};

Best regards,
Krzysztof

