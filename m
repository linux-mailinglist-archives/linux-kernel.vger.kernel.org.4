Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391CF6BE441
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjCQIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCQIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:47:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41E425E29
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:47:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eg48so17368977edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1679042837;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnJ/BVy4SBZ8eH5OPmRpFFL8LrOC5KW/6id1E1a0ulI=;
        b=an+ZRTybvHjMbEESndLf3cwEK4vIcpejteU+3+UR8UkDibRo6Sk8/oRtIElrLZxKNo
         Cmgis6c4lGP9OWXs+GPd6Jf1qRFNGJThCyOV6cAHa/x7kFKIZtTF7E+eUVpRmn7ASLBe
         /UILF2TjBpmO2vWQnBjgxrovViZK2pKeGQK3h9ABNjRK2TAA3SQ6wwKT/Gl7Ss8RoMIC
         +Ano9T7n/OJoGy+SlK6oNvKrRZEV0juvsuJ7srqXYHll0KmbZgLrBYRk91aOoL9SxvyM
         cS/r0KOHBwAF2al/3k+l1Cl8CL99NWUt64/KF1nQBm+HhKGAwBB+xB5+HPb2ATI8f4ZX
         mFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679042837;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CnJ/BVy4SBZ8eH5OPmRpFFL8LrOC5KW/6id1E1a0ulI=;
        b=ovqtUj6XUFLTlm3l/rSC9trID0J2cfRDiyUEEdtpKVl7IPpy61rE8AcQkABTlEgep7
         QgT4XWSLRMepyi412ducYgbnUuKsV5s9usNpDqTxQssPlQduwASv6+yKk6pmN1Z9gz4e
         2FgjNOt4oYZdJ+OptkrJvCxauFoZWReQHWFLOIhawBQmeZuLOgWSPbdAJgnBudJLcnxk
         XnNj5WFcPLGw5R8US7lcG7A03vEKfwsbTqlc25WQrEPKhVC85NQXpBj1y5TKbD9iKqAf
         LhpRpsj4Zz6CyWv8lXZpUBHkqj6zk08jRvLoNQcyl8wFrLXagkbW2oj8h6GN6PD5l3uk
         opeA==
X-Gm-Message-State: AO0yUKXQj6un3FE/x1tW/1Ism+mkvjGXHrrZnau62orgG8qWDcpkGle+
        Bbqumyhomhyju0J78yiq9WJrIw==
X-Google-Smtp-Source: AK7set9MnDT1ldk25flR6fAwdCE+sqx5UVOMd+osCs/jxOJ7gvi9sokgU4kqzSLwEeCr53Tgbj8VNQ==
X-Received: by 2002:a17:907:1b17:b0:930:9385:ce51 with SMTP id mp23-20020a1709071b1700b009309385ce51mr5720966ejc.68.1679042836927;
        Fri, 17 Mar 2023 01:47:16 -0700 (PDT)
Received: from localhost (2a02-8388-6582-fe80-0000-0000-0000-000b.cable.dynamic.v6.surfer.at. [2a02:8388:6582:fe80::b])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906088d00b0092707833d08sm707626eje.70.2023.03.17.01.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:47:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 17 Mar 2023 09:47:15 +0100
Message-Id: <CR8J0E9M2SFJ.3B3W26OYPWP2N@otso>
Cc:     "Marijn Suijten" <marijn.suijten@somainline.org>,
        "Rob Herring" <robh@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sm6350: Add GPUCC node
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: aerc 0.14.0
References: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
 <20230315-topic-lagoon_gpu-v1-2-a74cbec4ecfc@linaro.org>
In-Reply-To: <20230315-topic-lagoon_gpu-v1-2-a74cbec4ecfc@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Mar 16, 2023 at 12:16 PM CET, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@somainline.org>
>
> Add and configure a node for the GPU clock controller.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/q=
com/sm6350.dtsi
> index c46bb6dab6a1..523c7edfa4b3 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -5,6 +5,7 @@
>   */
> =20
>  #include <dt-bindings/clock/qcom,gcc-sm6350.h>
> +#include <dt-bindings/clock/qcom,gpucc-sm6350.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,sm6350-camcc.h>
>  #include <dt-bindings/dma/qcom-gpi.h>
> @@ -1125,6 +1126,20 @@ compute-cb@5 {
>  			};
>  		};
> =20
> +		gpucc: clock-controller@3d90000 {
> +			compatible =3D "qcom,sm6350-gpucc";
> +			reg =3D <0 0x03d90000 0 0x9000>;
> +			clocks =3D <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_GPU_GPLL0_CLK>,
> +				 <&gcc GCC_GPU_GPLL0_DIV_CLK>;
> +			clock-names =3D "bi_tcxo",
> +				      "gcc_gpu_gpll0_clk",
> +				      "gcc_gpu_gpll0_div_clk";
> +			#clock-cells =3D <1>;
> +			#reset-cells =3D <1>;
> +			#power-domain-cells =3D <1>;
> +		};
> +
>  		mpss: remoteproc@4080000 {
>  			compatible =3D "qcom,sm6350-mpss-pas";
>  			reg =3D <0x0 0x04080000 0x0 0x4040>;
>
> --=20
> 2.39.2

