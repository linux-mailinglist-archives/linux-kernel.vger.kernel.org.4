Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0371FD71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjFBJSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjFBJRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:17:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7A2E78
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:16:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f6067a9029so2243186e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685697399; x=1688289399;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVgMS8fxopahOqdIa05rZeNNbguZGl7Ffbb2hoJaYUE=;
        b=ScSjDqg0+cOcixvAYGlgfc5hjZSLgp+iBgADFSrarMZnjP8zOdNqUohwYtjWYAkKhc
         ZHZybucDPhpiI9KFSp7ZfbmsAGqvA6iQSBTqYRhxe8ObSMUg5eQBSYkpxinSXdhgCKq2
         BJeKMiFW4WO18gYdktGQuC5caImYV6g/jAkDq4QX6wCjOj8LUYx8cXbgmYfXvv7swdyX
         U24qdzk61vha79AODSOq1MHVcTAmeCHgKnOCfZGBzaBeWb16uLnZGfn99OpJDmfqiH3A
         InM13Z5NJ4q94HcVzICY0jIfbUUNXp/z40BCMjuhujXBYbQmflFwOkfG5tRaZd2R66Du
         tJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685697399; x=1688289399;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVgMS8fxopahOqdIa05rZeNNbguZGl7Ffbb2hoJaYUE=;
        b=AfNNV22GyPZpQkRVKR3U9Q/aR66fhtxkGqF9AwytTSO+6hzDLBEVSZ7XoZuyjBUkan
         41Q5/UgWqhKnwP98e0VvpAyM9SmcgqNjbeob+a/ulP8O2DX/8/diDhOxY2j92FbgFtgZ
         3hU5m5uZ0P+c24eUqpQ1Yfgf8j2s03eCeXre6Sl3Qzj77hBUbpx9b2HOul179mBvLbqi
         6eOiZVzuPsJGzErAqwdpkhalU5MoNJjtugF7dAA8K7aIrKiYQ7VTnTGSplYiWR6o4ZRs
         tanKcN806voWrl2uwO+5vWV+btML3y1M8joU96Er3Ol0m8jGpx+CTc6QaXu2cgOjud1O
         Vziw==
X-Gm-Message-State: AC+VfDwKOl3t5qOUy51KOWWyNnfq6B7Y1nh9CYhOIlP7ykQyYN/0CPwt
        cEBpVD43TkhBSC51so3u5d/PDQ==
X-Google-Smtp-Source: ACHHUZ40jVcQEsIDBtmmCS2XY1vea+XIHH1kpqNgoxIKs6hOOcqLewca5pyBo/kH5PnuJz6SybHkbQ==
X-Received: by 2002:ac2:4d13:0:b0:4f3:7c24:1029 with SMTP id r19-20020ac24d13000000b004f37c241029mr1354467lfi.60.1685697399310;
        Fri, 02 Jun 2023 02:16:39 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id d28-20020ac2545c000000b004f266537ad7sm101199lfn.34.2023.06.02.02.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:16:38 -0700 (PDT)
Message-ID: <52e16dae-153d-f1ef-53ca-bb637bde58b6@linaro.org>
Date:   Fri, 2 Jun 2023 11:16:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC 5/7] arm64: dts: qcom: sm8550: add ports subnodes in
 usb/dp qmpphy node
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v1-5-d4d97b4d8bab@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v1-5-d4d97b4d8bab@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 16:07, Neil Armstrong wrote:
> Add the USB3+DP Combo QMP PHY port subnodes in the SM8550 SoC DTSI
> to avoid duplication in the devices DTs.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index b41b3981b3ce..ca2280041f83 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2838,6 +2838,32 @@ usb_dp_qmpphy: phy@88e8000 {
>  			#phy-cells = <1>;
>  
>  			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					usb_dp_qmpphy_out: endpoint {
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					usb_dp_qmpphy_usb_ss_in: endpoint {
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					usb_dp_qmpphy_dp_in: endpoint {
> +					};
> +				};
> +			};
>  		};
>  
>  		usb_1: usb@a6f8800 {
> 
