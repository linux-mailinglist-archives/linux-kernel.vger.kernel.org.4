Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21D46BCE39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCPLbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCPLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:30:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB41B78B6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:30:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fd5so6227882edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1678966220;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2JOuQzwqPqnVTHtexnIieX/uzPPfKaQ/EtLsmuRNPY=;
        b=wEuIlQaBp1mArH+Y85FTKfcfr9jTXL8b1ew+f6fbClm4S50XK5OStHwN+NAtiZQyq8
         RxQLNHZdwY+clwyU9lUuPHQyshCTHvez9LR6jAOGwP1yL3BE5ngx3I3o2dbz6fgA78Yn
         /fhNv2eRsDdOjKDoSPzoW6FhC3D3ri/WjrBDiiBYfjWvxUEZoTFSqurF47cRfKM+bw+F
         iBKOJAOP0YmjtDxLRtT/kdvW+0ppN7NOtD+1a4LOtE3vIPcV0hBE1GcnBlfEEV8aQDnF
         4IYVU1TwF9UWrsii2m2WE9HrRt1eEtwFJJQigUXj6cepWbmLGOTJO+tlnmNSh8SxSrPY
         vc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678966220;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i2JOuQzwqPqnVTHtexnIieX/uzPPfKaQ/EtLsmuRNPY=;
        b=yf0Bx2D5fYKhwM4w3XKIXcrdXLW6bN51TDVxm2bSqpPXiIts9jYVDkIqIIVwDGBe+o
         GMr2rZdmN3gEKOqPlmj+cKxLZY7dS64TGIlDmAk3RL/p3aDn/JAXkTwJMmuf76+jb+ZM
         bYgZ3jpSar53lD/QOCwV7FekUmA5Tjd1SUePYrnEklfzbH1Ab6y7Bp7/X+A3rAViSG9p
         SqHVLQpRhVmV23yYMC/Tz+S5w+BkEbCkzjsdNSgrmrgK6QYXw094UvOsmkjs5zdTNzrr
         GkO076rQtAggMxlS2qWKvZKPXnRPb3T9G/Ef78hoObZbbkeLr1gmaq+1MeowcwubpOtE
         T3nA==
X-Gm-Message-State: AO0yUKWNBJ2WnzqTI5uGM0f/ahumgwjYAPGw3EP2cw638X7O07VCaOcY
        DrEeisVN57v4H2BVL+zy1aui/w==
X-Google-Smtp-Source: AK7set/WfYXD1YVfk8MD+y7JVr0O8hSlyPUbWsLyDwG268F16rhnJHJyi9Y0/q0WTIu0PWV5ZnKzMA==
X-Received: by 2002:aa7:c1c4:0:b0:4fb:b0:ede8 with SMTP id d4-20020aa7c1c4000000b004fb00b0ede8mr6020946edp.31.1678966219885;
        Thu, 16 Mar 2023 04:30:19 -0700 (PDT)
Received: from localhost (2a02-8388-6582-fe80-0000-0000-0000-000b.cable.dynamic.v6.surfer.at. [2a02:8388:6582:fe80::b])
        by smtp.gmail.com with ESMTPSA id i23-20020a1709064ed700b008b95c1fe636sm3683486ejv.207.2023.03.16.04.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 04:30:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 16 Mar 2023 12:30:18 +0100
Message-Id: <CR7RUOV6ZJQ7.2YYTPLWZ8BOXO@otso>
Cc:     "Marijn Suijten" <marijn.suijten@somainline.org>,
        "Rob Herring" <robh@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sm6350: Add GPU nodes
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
 <20230315-topic-lagoon_gpu-v1-4-a74cbec4ecfc@linaro.org>
In-Reply-To: <20230315-topic-lagoon_gpu-v1-4-a74cbec4ecfc@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Mar 16, 2023 at 12:16 PM CET, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@somainline.org>
>
> Add Adreno, GPU SMMU and GMU nodes to hook up everything that
> the A619 needs to function properly.
>
> Co-developed-by: Luca Weiss <luca.weiss@fairphone.com>

I believe my signoff is missing here since I'm Co-developed-by:

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 140 +++++++++++++++++++++++++++++=
++++++
>  1 file changed, 140 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/q=
com/sm6350.dtsi
> index 60b68d305e53..e967d06b0ad4 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1138,6 +1138,74 @@ compute-cb@5 {
>  			};
>  		};
> =20
> +		gpu: gpu@3d00000 {
> +			compatible =3D "qcom,adreno-619.0", "qcom,adreno";
> +			reg =3D <0 0x03d00000 0 0x40000>,
> +			      <0 0x03d9e000 0 0x1000>;
> +			reg-names =3D "kgsl_3d0_reg_memory",
> +				    "cx_mem";
> +			interrupts =3D <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			iommus =3D <&adreno_smmu 0>;
> +			operating-points-v2 =3D <&gpu_opp_table>;
> +			qcom,gmu =3D <&gmu>;
> +			nvmem-cells =3D <&gpu_speed_bin>;
> +			nvmem-cell-names =3D "speed_bin";
> +
> +			status =3D "disabled";
> +
> +			zap-shader {
> +				memory-region =3D <&pil_gpu_mem>;
> +			};
> +
> +			gpu_opp_table: opp-table {
> +				compatible =3D "operating-points-v2";
> +
> +				opp-850000000 {
> +					opp-hz =3D /bits/ 64 <850000000>;
> +					opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +					opp-supported-hw =3D <0x02>;
> +				};
> +
> +				opp-800000000 {
> +					opp-hz =3D /bits/ 64 <800000000>;
> +					opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO>;
> +					opp-supported-hw =3D <0x04>;
> +				};
> +
> +				opp-650000000 {
> +					opp-hz =3D /bits/ 64 <650000000>;
> +					opp-level =3D <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					opp-supported-hw =3D <0x08>;
> +				};
> +
> +				opp-565000000 {
> +					opp-hz =3D /bits/ 64 <565000000>;
> +					opp-level =3D <RPMH_REGULATOR_LEVEL_NOM>;
> +					opp-supported-hw =3D <0x10>;
> +				};
> +
> +				opp-430000000 {
> +					opp-hz =3D /bits/ 64 <430000000>;
> +					opp-level =3D <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					opp-supported-hw =3D <0xff>;
> +				};
> +
> +				opp-355000000 {
> +					opp-hz =3D /bits/ 64 <355000000>;
> +					opp-level =3D <RPMH_REGULATOR_LEVEL_SVS>;
> +					opp-supported-hw =3D <0xff>;
> +				};
> +
> +				opp-253000000 {
> +					opp-hz =3D /bits/ 64 <253000000>;
> +					opp-level =3D <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					opp-supported-hw =3D <0xff>;
> +				};
> +			};
> +		};
> +
> +
>  		gpucc: clock-controller@3d90000 {
>  			compatible =3D "qcom,sm6350-gpucc";
>  			reg =3D <0 0x03d90000 0 0x9000>;
> @@ -1152,6 +1220,78 @@ gpucc: clock-controller@3d90000 {
>  			#power-domain-cells =3D <1>;
>  		};
> =20
> +		adreno_smmu: iommu@3d40000 {
> +			compatible =3D "qcom,sm6350-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-=
v2";
> +			reg =3D <0 0x03d40000 0 0x10000>;
> +			#iommu-cells =3D <1>;
> +			#global-interrupts =3D <2>;
> +			interrupts =3D <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks =3D <&gpucc GPU_CC_AHB_CLK>,
> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
> +			clock-names =3D "ahb",
> +				      "bus",
> +				      "iface";
> +
> +			power-domains =3D <&gpucc GPU_CX_GDSC>;
> +		};
> +
> +		gmu: gmu@3d6a000 {
> +			compatible =3D "qcom,adreno-gmu-619.0", "qcom,adreno-gmu";
> +			reg =3D <0 0x03d6a000 0 0x31000>,
> +			      <0 0x0b290000 0 0x10000>,
> +			      <0 0x0b490000 0 0x10000>;
> +			reg-names =3D "gmu",
> +				    "gmu_pdc",
> +				    "gmu_pdc_seq";
> +
> +			interrupts =3D <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "hfi",
> +					  "gmu";
> +
> +			clocks =3D <&gpucc GPU_CC_AHB_CLK>,
> +				 <&gpucc GPU_CC_CX_GMU_CLK>,
> +				 <&gpucc GPU_CC_CXO_CLK>,
> +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
> +			clock-names =3D "ahb",
> +				      "gmu",
> +				      "cxo",
> +				      "axi",
> +				      "memnoc";
> +
> +			power-domains =3D <&gpucc GPU_CX_GDSC>,
> +					<&gpucc GPU_GX_GDSC>;
> +			power-domain-names =3D "cx",
> +					     "gx";
> +
> +			iommus =3D <&adreno_smmu 5>;
> +
> +			operating-points-v2 =3D <&gmu_opp_table>;
> +
> +			status =3D "disabled";
> +
> +			gmu_opp_table: opp-table {
> +				compatible =3D "operating-points-v2";
> +
> +				opp-200000000 {
> +					opp-hz =3D /bits/ 64 <200000000>;
> +					opp-level =3D <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> +				};
> +			};
> +		};
> +
>  		mpss: remoteproc@4080000 {
>  			compatible =3D "qcom,sm6350-mpss-pas";
>  			reg =3D <0x0 0x04080000 0x0 0x4040>;
>
> --=20
> 2.39.2

