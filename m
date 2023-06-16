Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE2F732FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345644AbjFPLWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345635AbjFPLWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:22:39 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3BC1FC3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:22:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f85966b0f2so197984e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686914555; x=1689506555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ql6KdpxxWlkmrh/2/nInGs3HpHc0ASRyDnxtKPcI0ow=;
        b=y3VN8BaIgQG+4+L5o2CHhMIMg21cn8rkC89rXLFB955XR0Q92mYmL5k0tzCGgM4sip
         FM+AhEEZmOupj4PRFB618RxK4+If6HNL2xeEUffDuIKT08wqR4puq1/AN7HMy7TG7YXW
         AgeOKUuDWbsXKUSWP2vh/qNlsk8zr6GvhlEx9vAKY5zhaGVeE27uRttASkh4KGgESo06
         v3sSbHTif8NhQ6VJ+2eAsEtnxo8t7W5faHjlCX1dtT8+tbBsx8QWLn3ma8GomQdhH2ZF
         F41eASDwIb2G3Jyhg2UIpWO2BHtUPMY+vhijsPqmYPWmF8alsPSHWHDXgBCYSFgVigIA
         Vh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686914555; x=1689506555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ql6KdpxxWlkmrh/2/nInGs3HpHc0ASRyDnxtKPcI0ow=;
        b=PkWp+ngaS+DgqjuD4AMJ+mR7fTrycC0E5raTZ/l5o2QIGKsKoXFUg417loDOGiE08N
         ytAAelxkpKssvg6P5ENHF2EixBhU7SIuAwI001HnpEoAme+qnia+SMiYxm5pl6LWDBSS
         M2VJQRHOlfxPeIbho9Nn7O2/hSQOc7HPrsuGSJi3POlyQpDVdZmUw/ibVmYdwme48NvT
         w821IZn2QtY8TTQzFGs9H0iOyExk3QVjeAynFW9pmun0lGk7V7pFQSLeb33tMo8i8qgy
         6kt3PE/0MCpc6iZfHLZWOo1Prp0kJqebVTy0OqvtUm9BPDjMZ+3ocgVtwGxnmspszt2l
         Z9EQ==
X-Gm-Message-State: AC+VfDwNb1atgkhaSwNwEHjXsr+DKQzZL4wVB/+bzvy5xZNkdlnxPHaA
        pBmTcSFi0m0L3Vyy5HGAaZmPNA==
X-Google-Smtp-Source: ACHHUZ5RvqFBOpS+dPwo5XByM43qpi+nC8NsoBsXjrBatg65Vsqqez2ePLViPaeuxjYfRJn7ejyl5g==
X-Received: by 2002:a05:6512:556:b0:4f8:4a86:3d82 with SMTP id h22-20020a056512055600b004f84a863d82mr1103262lfl.51.1686914555389;
        Fri, 16 Jun 2023 04:22:35 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l17-20020ac25551000000b004f81e273f5dsm794721lfk.77.2023.06.16.04.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 04:22:35 -0700 (PDT)
Message-ID: <0c0c4b77-81f0-501b-1957-0bccba7686f8@linaro.org>
Date:   Fri, 16 Jun 2023 13:22:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] clk: qcom: gcc-qdu1000: Update GCC clocks and add
 support for GDSCs
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230616104941.921555-1-quic_imrashai@quicinc.com>
 <20230616104941.921555-3-quic_imrashai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230616104941.921555-3-quic_imrashai@quicinc.com>
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

On 16.06.2023 12:49, Imran Shaik wrote:
> Update the GCC clocks and add support for GDSCs for QDU1000 and
> QRU1000 SoCs. While at it, fix the PCIe pipe clock handling and
> add support for v2 variant.
Too much for a single change. If somebody wants to bisect an issue, they
would have to edit chunks of this patch.

Konrad
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-qdu1000.c | 162 ++++++++++++++++++++++-----------
>  1 file changed, 110 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
> index 5051769ad90c..5d8125c0eacc 100644
> --- a/drivers/clk/qcom/gcc-qdu1000.c
> +++ b/drivers/clk/qcom/gcc-qdu1000.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <linux/clk-provider.h>
> @@ -17,6 +17,7 @@
>  #include "clk-regmap-divider.h"
>  #include "clk-regmap-mux.h"
>  #include "clk-regmap-phy-mux.h"
> +#include "gdsc.h"
>  #include "reset.h"
>  
>  enum {
> @@ -370,16 +371,6 @@ static const struct clk_parent_data gcc_parent_data_6[] = {
>  	{ .index = DT_TCXO_IDX },
>  };
>  
> -static const struct parent_map gcc_parent_map_7[] = {
> -	{ P_PCIE_0_PIPE_CLK, 0 },
> -	{ P_BI_TCXO, 2 },
> -};
> -
> -static const struct clk_parent_data gcc_parent_data_7[] = {
> -	{ .index = DT_PCIE_0_PIPE_CLK_IDX },
> -	{ .index = DT_TCXO_IDX },
> -};
> -
>  static const struct parent_map gcc_parent_map_8[] = {
>  	{ P_BI_TCXO, 0 },
>  	{ P_GCC_GPLL0_OUT_MAIN, 1 },
> @@ -439,16 +430,15 @@ static struct clk_regmap_mux gcc_pcie_0_phy_aux_clk_src = {
>  	},
>  };
>  
> -static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
> +static struct clk_regmap_phy_mux gcc_pcie_0_pipe_clk_src = {
>  	.reg = 0x9d064,
> -	.shift = 0,
> -	.width = 2,
> -	.parent_map = gcc_parent_map_7,
>  	.clkr = {
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_pcie_0_pipe_clk_src",
> -			.parent_data = gcc_parent_data_7,
> -			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
> +			.parent_data = &(const struct clk_parent_data){
> +				.index = DT_PCIE_0_PIPE_CLK_IDX,
> +			},
> +			.num_parents = 1,
>  			.ops = &clk_regmap_phy_mux_ops,
>  		},
>  	},
> @@ -485,7 +475,7 @@ static struct clk_rcg2 gcc_aggre_noc_ecpri_dma_clk_src = {
>  		.name = "gcc_aggre_noc_ecpri_dma_clk_src",
>  		.parent_data = gcc_parent_data_4,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -505,7 +495,7 @@ static struct clk_rcg2 gcc_aggre_noc_ecpri_gsi_clk_src = {
>  		.name = "gcc_aggre_noc_ecpri_gsi_clk_src",
>  		.parent_data = gcc_parent_data_5,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -524,7 +514,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
>  		.name = "gcc_gp1_clk_src",
>  		.parent_data = gcc_parent_data_1,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -538,7 +528,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
>  		.name = "gcc_gp2_clk_src",
>  		.parent_data = gcc_parent_data_1,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -552,7 +542,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
>  		.name = "gcc_gp3_clk_src",
>  		.parent_data = gcc_parent_data_1,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -571,7 +561,7 @@ static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
>  		.name = "gcc_pcie_0_aux_clk_src",
>  		.parent_data = gcc_parent_data_3,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -591,7 +581,7 @@ static struct clk_rcg2 gcc_pcie_0_phy_rchng_clk_src = {
>  		.name = "gcc_pcie_0_phy_rchng_clk_src",
>  		.parent_data = gcc_parent_data_0,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -610,7 +600,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
>  		.name = "gcc_pdm2_clk_src",
>  		.parent_data = gcc_parent_data_0,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -632,7 +622,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s0_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
> @@ -648,7 +638,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s1_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
> @@ -664,7 +654,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s2_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
> @@ -680,7 +670,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s3_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
> @@ -696,7 +686,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s4_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
> @@ -717,7 +707,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s5_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
> @@ -733,7 +723,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s6_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s6_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
> @@ -749,7 +739,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s7_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s7_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
> @@ -765,7 +755,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s0_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
> @@ -781,7 +771,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s1_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
> @@ -797,7 +787,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s2_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
> @@ -813,7 +803,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s3_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
> @@ -829,7 +819,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s4_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
> @@ -845,7 +835,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s5_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
> @@ -861,7 +851,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s6_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s6_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
> @@ -877,7 +867,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s7_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s7_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
> @@ -913,7 +903,7 @@ static struct clk_rcg2 gcc_sdcc5_apps_clk_src = {
>  		.name = "gcc_sdcc5_apps_clk_src",
>  		.parent_data = gcc_parent_data_8,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
>  
> @@ -932,7 +922,7 @@ static struct clk_rcg2 gcc_sdcc5_ice_core_clk_src = {
>  		.name = "gcc_sdcc5_ice_core_clk_src",
>  		.parent_data = gcc_parent_data_2,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
>  
> @@ -946,7 +936,7 @@ static struct clk_rcg2 gcc_sm_bus_xo_clk_src = {
>  		.name = "gcc_sm_bus_xo_clk_src",
>  		.parent_data = gcc_parent_data_2,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -965,7 +955,7 @@ static struct clk_rcg2 gcc_tsc_clk_src = {
>  		.name = "gcc_tsc_clk_src",
>  		.parent_data = gcc_parent_data_9,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_9),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -985,7 +975,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
>  		.name = "gcc_usb30_prim_master_clk_src",
>  		.parent_data = gcc_parent_data_0,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -999,7 +989,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
>  		.name = "gcc_usb30_prim_mock_utmi_clk_src",
>  		.parent_data = gcc_parent_data_0,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -1013,7 +1003,7 @@ static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
>  		.name = "gcc_usb3_prim_phy_aux_clk_src",
>  		.parent_data = gcc_parent_data_3,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -1142,6 +1132,26 @@ static struct clk_branch gcc_ddrss_ecpri_dma_clk = {
>  	},
>  };
>  
> +static struct clk_branch gcc_ddrss_ecpri_gsi_clk = {
> +	.halt_reg = 0x54298,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.hwcg_reg = 0x54298,
> +	.hwcg_bit = 1,
> +	.clkr = {
> +		.enable_reg = 0x54298,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_ddrss_ecpri_gsi_clk",
> +			.parent_hws = (const struct clk_hw*[]) {
> +				&gcc_aggre_noc_ecpri_gsi_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_aon_ops,
> +		},
> +	},
> +};
> +
>  static struct clk_branch gcc_ecpri_ahb_clk = {
>  	.halt_reg = 0x3a008,
>  	.halt_check = BRANCH_HALT_VOTED,
> @@ -1458,14 +1468,13 @@ static struct clk_branch gcc_pcie_0_cfg_ahb_clk = {
>  
>  static struct clk_branch gcc_pcie_0_clkref_en = {
>  	.halt_reg = 0x9c004,
> -	.halt_bit = 31,
>  	.halt_check = BRANCH_HALT_ENABLE,
>  	.clkr = {
>  		.enable_reg = 0x9c004,
>  		.enable_mask = BIT(0),
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_pcie_0_clkref_en",
> -			.ops = &clk_branch_ops,
> +			.ops = &clk_branch2_ops,
>  		},
>  	},
>  };
> @@ -2285,14 +2294,13 @@ static struct clk_branch gcc_tsc_etu_clk = {
>  
>  static struct clk_branch gcc_usb2_clkref_en = {
>  	.halt_reg = 0x9c008,
> -	.halt_bit = 31,
>  	.halt_check = BRANCH_HALT_ENABLE,
>  	.clkr = {
>  		.enable_reg = 0x9c008,
>  		.enable_mask = BIT(0),
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_usb2_clkref_en",
> -			.ops = &clk_branch_ops,
> +			.ops = &clk_branch2_ops,
>  		},
>  	},
>  };
> @@ -2402,6 +2410,39 @@ static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
>  	},
>  };
>  
> +static struct gdsc pcie_0_gdsc = {
> +	.gdscr = 0x9d004,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "gcc_pcie_0_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc pcie_0_phy_gdsc = {
> +	.gdscr = 0x7c004,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0x2,
> +	.pd = {
> +		.name = "gcc_pcie_0_phy_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc usb30_prim_gdsc = {
> +	.gdscr = 0x49004,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "gcc_usb30_prim_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
>  static struct clk_regmap *gcc_qdu1000_clocks[] = {
>  	[GCC_AGGRE_NOC_ECPRI_DMA_CLK] = &gcc_aggre_noc_ecpri_dma_clk.clkr,
>  	[GCC_AGGRE_NOC_ECPRI_DMA_CLK_SRC] = &gcc_aggre_noc_ecpri_dma_clk_src.clkr,
> @@ -2534,6 +2575,14 @@ static struct clk_regmap *gcc_qdu1000_clocks[] = {
>  	[GCC_AGGRE_NOC_ECPRI_GSI_CLK] = &gcc_aggre_noc_ecpri_gsi_clk.clkr,
>  	[GCC_PCIE_0_PHY_AUX_CLK_SRC] = &gcc_pcie_0_phy_aux_clk_src.clkr,
>  	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
> +	[GCC_GPLL1_OUT_EVEN] = &gcc_gpll1_out_even.clkr,
> +	[GCC_DDRSS_ECPRI_GSI_CLK] = NULL,
> +};
> +
> +static struct gdsc *gcc_qdu1000_gdscs[] = {
> +	[PCIE_0_GDSC] = &pcie_0_gdsc,
> +	[PCIE_0_PHY_GDSC] = &pcie_0_phy_gdsc,
> +	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
>  };
>  
>  static const struct qcom_reset_map gcc_qdu1000_resets[] = {
> @@ -2597,10 +2646,13 @@ static const struct qcom_cc_desc gcc_qdu1000_desc = {
>  	.num_clks = ARRAY_SIZE(gcc_qdu1000_clocks),
>  	.resets = gcc_qdu1000_resets,
>  	.num_resets = ARRAY_SIZE(gcc_qdu1000_resets),
> +	.gdscs = gcc_qdu1000_gdscs,
> +	.num_gdscs = ARRAY_SIZE(gcc_qdu1000_gdscs),
>  };
>  
>  static const struct of_device_id gcc_qdu1000_match_table[] = {
>  	{ .compatible = "qcom,qdu1000-gcc" },
> +	{ .compatible = "qcom,qdu1000-gcc-v2" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, gcc_qdu1000_match_table);
> @@ -2617,6 +2669,12 @@ static int gcc_qdu1000_probe(struct platform_device *pdev)
>  	/* Update FORCE_MEM_CORE_ON for gcc_pcie_0_mstr_axi_clk */
>  	regmap_update_bits(regmap, 0x9d024, BIT(14), BIT(14));
>  
> +	if (of_device_is_compatible(pdev->dev.of_node, "qcom,qdu1000-gcc-v2")) {
> +		gcc_qdu1000_clocks[GCC_DDRSS_ECPRI_GSI_CLK] = &gcc_ddrss_ecpri_gsi_clk.clkr;
> +		gcc_pcie_0_clkref_en.halt_check = BRANCH_HALT_DELAY;
> +		gcc_usb2_clkref_en.halt_check = BRANCH_HALT_DELAY;
> +	}
> +
>  	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
>  				       ARRAY_SIZE(gcc_dfs_clocks));
>  	if (ret)
