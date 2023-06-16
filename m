Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B8E732FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343908AbjFPLXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbjFPLXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:23:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7621FE2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:23:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so716085e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686914591; x=1689506591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8WHc3nJ6Q4te75hHJCk/uzmC6+xV1DsZK/1FeWzSDbc=;
        b=c91ctZGuDRUP6FcEoy5sOo0C/whPbBfhILxAMqxfyU+JBMJ5DoZDY+Ovb1GnVyekKY
         yr8AQb6w2PVNybTcome/gFVxIG6oNtRdF4mogotg3sPU9pmGrNRUCGSgm+oOF/PZ6EfW
         l40CnMZEcpmCwZhV1tWEw6i6e/GAfpen4wPc01PICfX/4hmmEQjndrco2CD4FU17VE+0
         xn6Ucunm+PpILEZFi/cBXYp55OeWuz21Pp1pEw8F6HiIWbm10g8codWKI6aMek62YhGK
         wAimpt0p/yK7kc8ClZ8NzhrGtFME3iab+bKFkUH0KfrP9tdao8KpJGJsAXvGN4cO/P8R
         xnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686914591; x=1689506591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WHc3nJ6Q4te75hHJCk/uzmC6+xV1DsZK/1FeWzSDbc=;
        b=FJbzgEbC6PrU7jGJ9tj4MqwQU7r2dTowDyoXx4l+W1h5bB6kDDuQiUFxh61BZdVOqM
         bLt0D058x+5OcIAe1i4LBh5sQHOkY56PBH/RjZsaKOF5TGXJRz7wpPInwNhdT+Bsj4Hp
         i8jw4F5CydUZEDZlkNENAKyzJoGxmoZd3EAq7RZ2gNSasDykn8emsgTNY6HnPO3y1J4Z
         UPFB68+QWo8kIkEgQGDcC2yseBo/oi8cZuDUUrbPacQP9BXfmg5nz2mEj6rPj5ron+JI
         KDprP9O/nCojvf/CMjUS01ArsS+Uzm7KlaRmferCtJRXaHcoyNNbHG3q4REw0g++2aHb
         oN5g==
X-Gm-Message-State: AC+VfDxL/qH6HhfIUGKuhDMkur4Uop7N2jBB4z4UaWA1mzn3+Hz8AoHH
        w9GDlrpxbz3GYSdu874UYTYyIg==
X-Google-Smtp-Source: ACHHUZ6awyEvnGFChhFqKgs9fhbBVU065M8WVyZ4TFNpMPceGcMb9gSm/7q65IYS4g1sniEBdXDvQA==
X-Received: by 2002:ac2:5b05:0:b0:4f7:69ca:4e71 with SMTP id v5-20020ac25b05000000b004f769ca4e71mr1002332lfn.34.1686914590968;
        Fri, 16 Jun 2023 04:23:10 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l3-20020ac24a83000000b004a6f66eed7fsm2997995lfp.165.2023.06.16.04.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 04:23:10 -0700 (PDT)
Message-ID: <eb26c448-b30c-fca7-2366-21948832dc12@linaro.org>
Date:   Fri, 16 Jun 2023 13:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RESEND v6 1/8] arm64: dts: qcom: sc7280: Modify lpasscc node
 name
Content-Language: en-US
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        andersson@kernel.org, broonie@kernel.org, agross@kernel.org
Cc:     robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, judyhsiao@chromium.org,
        quic_visr@quicinc.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20230616103534.4031331-1-quic_mohs@quicinc.com>
 <20230616103534.4031331-2-quic_mohs@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230616103534.4031331-2-quic_mohs@quicinc.com>
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

On 16.06.2023 12:35, Mohammad Rafi Shaik wrote:
> From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> 
> Modify lpasscc clock controller node name to generic name,
> that is from lpasscc to clock-controller.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 2f5e73da8b6d..36f9edabb9d7 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2258,7 +2258,7 @@ tcsr_2: syscon@1fc0000 {
>  			reg = <0 0x01fc0000 0 0x30000>;
>  		};
>  
> -		lpasscc: lpasscc@3000000 {
> +		lpasscc: clock-controller@3000000 {
>  			compatible = "qcom,sc7280-lpasscc";
>  			reg = <0 0x03000000 0 0x40>,
>  			      <0 0x03c04000 0 0x4>;
