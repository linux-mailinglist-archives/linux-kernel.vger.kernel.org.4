Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322D2734D45
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjFSIMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjFSIMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:12:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C134510C0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:12:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso843323e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687162321; x=1689754321;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7MkhTrJ9T0aYR/ypFkdnmXuhMMz/1JRUzQsSC4Yvkus=;
        b=QqpRxf01ABUbLt9+xVQ3DYAogIXvxBukHbzT6IO53gGfL4sXz89QnCXsA4BQY6ATjo
         NXnaf5Q2nMHwWBBEnEbEmkGhZhz1Jv3hT7ruF7NMRH4a6Pog+dmN2F42LyFTOgeLgpYP
         a5h8C1UdGdURjlRfKyVGfqmPMWtCJuugRJkPuKWLpercaCab02f4au3k3lMCTdHuZPGb
         4W2PoL4PibmES9QwScb4v9zyQFv2Rgp+9A3AhZr6+ANPcupRTblgtrmrcSys+afehYE6
         wNCyGNgA6DTAOfv3vU1Lr1Q5GIvD6YPRJCA01yhTOg3CeV/RtBKSbr2f3XbfahWo9PSJ
         gY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162321; x=1689754321;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MkhTrJ9T0aYR/ypFkdnmXuhMMz/1JRUzQsSC4Yvkus=;
        b=l0e7547zKn3RXuYHoTEkIvuNbC14k4DHqeoNgh+qHajMPCkHmKcFDUjnzkMtCie39Q
         UmDK2DAjaeHkd4yJgylgswhhu28DQrfx1c0CcVynn4WZPbOMsqYq4buPa3TARpo7zHTk
         nDiMb4BrwCMYtbXz67rfenUb0A9RJz26ak3Zk6Su6q3M6WOt6Ur9UmW9/s4JhunV0DES
         RZEfqTiivZw1PNtQmrDPM9w0edsCUG7A89ZoFL6Dt+GdumyseqH9RnJ1ayr5nL0F7pKd
         r3bOJz0wVkZD2X4B8jW6zXHcli9TozfSTkCszmwduZamypqDc2LvbYpSK4kwvIl7zWwB
         H+kg==
X-Gm-Message-State: AC+VfDzYqyrsbSL39V+32CzCp/UBcUe6SADreHCYmyeDR0sgk51jaZLF
        gkT99KuMW+zuPt+93P/yl90hkg==
X-Google-Smtp-Source: ACHHUZ5BIZqOUn6vxe0wdzVkKVSgdsXpn+O7ruN3luGwb786xYDYZQ8vIqdtm3NH41FBRZ9bhCjOGw==
X-Received: by 2002:a19:2d17:0:b0:4f8:55dd:e726 with SMTP id k23-20020a192d17000000b004f855dde726mr4514984lfj.12.1687162321068;
        Mon, 19 Jun 2023 01:12:01 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d4e04000000b003113943bb66sm3327084wrt.110.2023.06.19.01.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 01:12:00 -0700 (PDT)
Message-ID: <59a2a835-346d-22b1-ba5c-820b5b3b347e@linaro.org>
Date:   Mon, 19 Jun 2023 10:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/7] arm64: dts: qcom: sm8450-hdk: correct FSA4480 port
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
 <20230618114442.140185-2-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230618114442.140185-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 18/06/2023 13:44, Krzysztof Kozlowski wrote:
> FSA4480 has only one port according to bindings:
> 
>    sm8450-hdk.dtb: typec-mux@42: 'port' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index d7975b3cf064..e5cbea92e07a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -518,16 +518,9 @@ typec-mux@42 {
>   		mode-switch;
>   		orientation-switch;
>   
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> -
> -				fsa4480_sbu_mux: endpoint {
> -					remote-endpoint = <&pmic_glink_sbu>;
> -				};
> +		port {
> +			fsa4480_sbu_mux: endpoint {
> +				remote-endpoint = <&pmic_glink_sbu>;
>   			};
>   		};
>   	};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
