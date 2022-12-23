Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1847654E34
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiLWJOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbiLWJOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:14:05 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B98D36D44
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:14:04 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p36so6314818lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ce317vF268IfvnfP9+p1VVXhxTBGucn4dlvIXgjdsZU=;
        b=lbcLMP6Q0HWuQk3H+EUrd087gzWF425/OhsFFMYt4hGdRdOUV6SaUQNRZLuSlCTujO
         4GhCLyhanmjjP2Avp9EBcI7tdkVUqbMns1YcHUeZZEVO3t/91c+NG5QX2mYaXiPXSqt1
         In8EMzGzBFt0nWOOEL18D5yOD07DhJbYXiDNwDDJI91NsAq1escZVkv258nOteTgh2EV
         WBngyAjP6aDsDZ2mGOcKEJcbKVcwv/BRrncxVuk1dke6OFxey+G+LocDd65zE9x+HdxI
         BLWI/m/D1joMjV8cCnpDB4tcKcMr+vJ4GBS/OabCU148XwTIv7YP110nGkDBoLgUzzy4
         1B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ce317vF268IfvnfP9+p1VVXhxTBGucn4dlvIXgjdsZU=;
        b=Sjw/UtMvbjQUxg+IPBC6jcmKh2s8aYpybT5TXDSac8FSK/aXdUmCvtl/BASY9aELgd
         UKGUFYwSxhTxucJyQbr1hT1fhSPNJ+SL7noDrrsX+SndGwOSB7TxWOlFdlDvTgWAEK6C
         NnDgn/6g92AGkuzLTC4lMugmL1cUyrPADo/ItIpNMcwDQTYdM1YRnhW7QxhO2dhRGksr
         IT6Jz60flqA+8vFrSpn7ejEPfdHh45QgDnHuzSrYEH5L/yndp0RKCUKKbl12kP2TDkF4
         rFUHXhOAdrgq5lSb3AcOpGq4UswsKsls3IwYDKwFYBHw8DxwCALfbAoAa9t0CprhruHw
         Fm6w==
X-Gm-Message-State: AFqh2kpsfrZnwTKh2e0SvkbJJQuagBRGqM68DQC771IRGkcTq6zZ5NnV
        UNrBFD2F8sjvO5wavVBMHii5aw==
X-Google-Smtp-Source: AMrXdXuvuxfOoh7btFzaHq0D7UEX6Vdsw/DhoOg+jC0H2+ELHxHS4cMpuHtdiGRPa7224JaeRiKhkw==
X-Received: by 2002:a05:6512:70a:b0:4c0:4214:cd2c with SMTP id b10-20020a056512070a00b004c04214cd2cmr2211602lfs.43.1671786842930;
        Fri, 23 Dec 2022 01:14:02 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512315000b0049876c1bb24sm440414lfi.225.2022.12.23.01.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 01:14:02 -0800 (PST)
Message-ID: <9b435fb2-9ba9-e985-e132-e10f793ca659@linaro.org>
Date:   Fri, 23 Dec 2022 10:14:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sc7280: audioreach: Add CGCR reset
 property
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        konrad.dybcio@linaro.org
References: <1671702170-24781-1-git-send-email-quic_srivasam@quicinc.com>
 <1671702170-24781-6-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1671702170-24781-6-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 10:42, Srinivasa Rao Mandadapu wrote:
> Add CGCR register reset property for both RX and TX soundwire
> slave devices.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
> This patch depends on:
>     -- https://lore.kernel.org/linux-clk/1671618061-6329-1-git-send-email-quic_srivasam@quicinc.com/
> 
>  .../arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> index a750f05..ce5d69e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -217,3 +217,12 @@
>  		};
>  	};
>  };
> +
> +&swr0 {
> +	resets = <&lpasscc LPASS_AUDIO_SWR_RX_CGCR>;
> +};
> +
> +&swr1 {

Why here not in SoC DTSI?

> +	resets = <&lpasscc LPASS_AUDIO_SWR_TX_CGCR>;
> +};
> +

Are you adding stray new lines?

Best regards,
Krzysztof

