Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66091726982
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjFGTJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFGTJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:09:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6DC1FCC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:09:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso5970115e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686164943; x=1688756943;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIB5Ez5/1zBL2wNPD4WgzbQ/0M0sdqjHOgDZ8J5dSvM=;
        b=VdFAJtCLm+jUSR4aAxpLHLWbbFunpa2036Ss5uTS8Faf++8xMxEtm2XmjIKqT8sy4h
         pDlzrwMepskf82EvzfInp/CueXdX9pcl67N3GZDqH+q+ed1CnpqvdFJyCBxRpFpwTh3d
         rmVtBu4kFTBNDdgtTCjLH0ahjca4odKTFL7uPWbM5sUXudxM4U6B9C/ASZHxM/RGcay6
         VEVgB/0VYaRMlDcKskZJSngefhIxYrBtRa+TO4+2ZOSeC1U7FCUmvjnmqRqpEQPhSWU0
         2STruIBEzukUN3YKPEacvFISXSoGJrUBlJLWHhyJNUJ7tLSqjzS1O3ZySFAdK9ilLw0d
         t0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686164943; x=1688756943;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIB5Ez5/1zBL2wNPD4WgzbQ/0M0sdqjHOgDZ8J5dSvM=;
        b=jkxLXvS9OSR7JGfMEeqJhxMAJFb4XzaXYTht+MaS672zGarpBDfguRbwHjMdtW+sJB
         Tl3jZT7RQ9Qtr2HgXHbSIrySi2E8LTNbcTHTfQFEeYYy4zAaCsJu0c2vtnbG9YaXBYr2
         5xv03XYnOuWq1E4s2wWuLwT8jzr61o5ZDPnqfN/7E1blx2WFBySR6/l4FIolRHWWKk3w
         yByldjshSJANC8jp6UFbwtT+DANh8+6z8iL81Z5GWYxfxL0ZAuRMlH+9+twE1L0NQPLB
         mqMY2wyhI8Hdow94Pj706duc1WP3M0gx4NmKn4Vv0BweEglWOavw2BFf9LYgDM6VZcC6
         QaOw==
X-Gm-Message-State: AC+VfDwstqC/YMXNwhxtyH87XO6Q2RIP3HPE/m3dQ8PMqp+FVthH/Ti2
        ttikEMWgnzpE3m3BpMdOcJr/FA==
X-Google-Smtp-Source: ACHHUZ710ZCReHCFhPP1TIIATmB/KflMtrDahZqphOkAf/9lJrhLsazyy74FGBr3u7yhOEKpAf7yiA==
X-Received: by 2002:a05:6512:61:b0:4f4:b10a:349f with SMTP id i1-20020a056512006100b004f4b10a349fmr2306981lfo.34.1686164943627;
        Wed, 07 Jun 2023 12:09:03 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id c7-20020a197607000000b004f38411f148sm1896781lff.84.2023.06.07.12.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 12:09:03 -0700 (PDT)
Message-ID: <594582c6-6b20-7a44-a833-834c6e5eb9c6@linaro.org>
Date:   Wed, 7 Jun 2023 21:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v12 4/5] arm64: dts: qcom: ipq9574: Add LDO regulator node
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1686045347.git.quic_varada@quicinc.com>
 <1e795c18d6e19dbb5eebee357dddeb5022033825.1686045347.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1e795c18d6e19dbb5eebee357dddeb5022033825.1686045347.git.quic_varada@quicinc.com>
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



On 7.06.2023 12:48, Varadarajan Narayanan wrote:
> Add LDO regulator node
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v10:
> 	- Add LDO regulator node
> ---
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 2b3ed8d..42d45e1 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -45,6 +45,13 @@
>  			regulator-min-microvolt = <725000>;
>  			regulator-max-microvolt = <1075000>;
>  		};
> +
> +		mp5496_l2: l2 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-boot-on;
> +			regulator-always-on;
Nit: since it looks like you'll need to send another revision,
if you switched the order of the last two properties, it'd make
a nice reverse-Christmas-tree

Konrad
> +		};
>  	};
>  };
>  
