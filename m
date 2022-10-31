Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF19613205
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJaI4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJaI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:56:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03347CE37
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:56:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a13so16489609edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtvgExSXmepQtdrqHIZul+dYO79vk5qNCOM8KdJOFIQ=;
        b=KHI6SRPVSMWfZtRUmnZPqGypwl0WZULHv29q2PexONdIeAha8cux/h9jMOoORSNRvI
         W/QUB2Hf8t3p3C65GXJ6Znt79eC2jWfMcRAH6fkDr/CwR56rKoTEsvmZDnWYeCIjW7gU
         pP+h+kcIArJ0/1nQrrLU8XDhF4SojMVawO+bDNTnPKhelNpXPqPuWNsExguaP5NgQZm8
         zRuSnVuMrN1M2hipiRUtja3MU5mM9D/eHY5qQMOObgoIWrOGjYnuze+fhzr14CEg2bP3
         xy13hiZ1HeefGjiqSuDfpFGZckDDDnGNs/z4SaA77K7UHvFU2iWMExwbA7M2e0vOCYas
         OwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dtvgExSXmepQtdrqHIZul+dYO79vk5qNCOM8KdJOFIQ=;
        b=S6XVsn1lQWp3FUOVWnyb5pcF4yd45ldI20QcPsgtNZvBf2o4iPiMzqfA/CBe762M6f
         nOX1zmqgJxASWJxAv6Xb7Cs4135KmZKfP4VEokJ2UsE3CS0/jRgbmRafwZLLvgYfFduQ
         oxfTH0HVzC9WtyEFzmnC1S/FD3Pbpav6KE9r6cuNLwEA6AxZPcvbi4vd2DvCfyBeWImn
         4DqWlzCcyQctHX49QOOhNbp4OIzD8sDgoAiNEQSaMXYMIePNRHN23YFzv+EYAoHsijiR
         i7yfwOr8aX1G6yqZjACkORIrTS3qYtwIGk1JRUrlBjRR85czJDqisZ5euIkZIqdJvoTp
         /spA==
X-Gm-Message-State: ACrzQf1PjrObaDmqMEOMQXF5fb6wLmXF85HBECkSXtB3fqeA4D7i4lwd
        A6L/gWExP/GX9kjFQehRpdYX/g==
X-Google-Smtp-Source: AMsMyM5By2pxB2aLOtKu+C8JgxF+coDN320xPl7ypCiZtXuV+DDTuqhB/n+dZwqullsn+JXr6QkxqA==
X-Received: by 2002:aa7:cd12:0:b0:463:69ac:a5d3 with SMTP id b18-20020aa7cd12000000b0046369aca5d3mr2915187edw.269.1667206581548;
        Mon, 31 Oct 2022 01:56:21 -0700 (PDT)
Received: from localhost (31-151-115-246.dynamic.upc.nl. [31.151.115.246])
        by smtp.gmail.com with ESMTPSA id bm6-20020a0564020b0600b00461a6997c5dsm2966444edb.83.2022.10.31.01.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 01:56:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 Oct 2022 09:56:20 +0100
Message-Id: <CNZZEPIA4LGS.EFHSXO9SRUSH@otso>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@somainline.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Martin Botka" <martin.botka@somainline.org>,
        "Jami Kettunen" <jami.kettunen@somainline.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Luca Weiss" <luca@z3ntu.xyz>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] arm64: dts: qcom: sm6350: Add pinctrl for SDHCI 2
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Marijn Suijten" <marijn.suijten@somainline.org>,
        <phone-devel@vger.kernel.org>
X-Mailer: aerc 0.12.0
References: <20221030073232.22726-1-marijn.suijten@somainline.org>
 <20221030073232.22726-3-marijn.suijten@somainline.org>
In-Reply-To: <20221030073232.22726-3-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Oct 30, 2022 at 8:32 AM CET, Marijn Suijten wrote:
> Use the generic pin functions specifically for sdc2.
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sm7225-fairphone-fp4

Regards
Luca

> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 44 ++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/q=
com/sm6350.dtsi
> index a3ae765d9781..b98b881ebe7e 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1074,6 +1074,10 @@ sdhc_2: mmc@8804000 {
>  					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_SDCC_2 0>;
>  			interconnect-names =3D "sdhc-ddr", "cpu-sdhc";
> =20
> +			pinctrl-0 =3D <&sdc2_on_state>;
> +			pinctrl-1 =3D <&sdc2_off_state>;
> +			pinctrl-names =3D "default", "sleep";
> +
>  			qcom,dll-config =3D <0x0007642c>;
>  			qcom,ddr-config =3D <0x80040868>;
>  			power-domains =3D <&rpmhpd SM6350_CX>;
> @@ -1316,6 +1320,46 @@ tlmm: pinctrl@f100000 {
>  			#interrupt-cells =3D <2>;
>  			gpio-ranges =3D <&tlmm 0 0 157>;
> =20
> +			sdc2_off_state: sdc2-off-state {
> +				clk-pins {
> +					pins =3D "sdc2_clk";
> +					drive-strength =3D <2>;
> +					bias-disable;
> +				};
> +
> +				cmd-pins {
> +					pins =3D "sdc2_cmd";
> +					drive-strength =3D <2>;
> +					bias-pull-up;
> +				};
> +
> +				data-pins {
> +					pins =3D "sdc2_data";
> +					drive-strength =3D <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			sdc2_on_state: sdc2-on-state {
> +				clk-pins {
> +					pins =3D "sdc2_clk";
> +					drive-strength =3D <16>;
> +					bias-disable;
> +				};
> +
> +				cmd-pins {
> +					pins =3D "sdc2_cmd";
> +					drive-strength =3D <10>;
> +					bias-pull-up;
> +				};
> +
> +				data-pins {
> +					pins =3D "sdc2_data";
> +					drive-strength =3D <10>;
> +					bias-pull-up;
> +				};
> +			};
> +
>  			qup_uart9_default: qup-uart9-default-state {
>  				pins =3D "gpio25", "gpio26";
>  				function =3D "qup13_f2";
> --=20
> 2.38.1

