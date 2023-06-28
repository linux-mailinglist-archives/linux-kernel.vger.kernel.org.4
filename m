Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37136740FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjF1LJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjF1LIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:08:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8008C211C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:08:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so3242e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687950531; x=1690542531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZEEvwL/mGWHXhkyWVXKsnRaFccZ9iXGZJdLXdIu2mA=;
        b=XVYyUVPNzAR/B4+bNh3iyg7gIIJ014NDMa5e3ydex6dgL1a9Hm6l9NDM1hayy55neX
         aK8iELU3gUbG2Vpf/ZD6FzNvyW2gjlBmfx0WdhuT8X/kA6Wpw7+nwfMVzwHmkpZUJsvI
         XCNYmvxX1IrrpRPSxvFTf8fOo63FgiZK12/LU74jc0jbg9JrpR+mUA+EDerxNVpW7GpO
         n8DZ81r8aLJRE1rhD8xGW2du7F27u+SSkX7KMI3X6U36Im6ARMARMYxKnDKa9d3mwchC
         m8+S1ka9L5HpKmghhEY7AEiE4kB385NcktqrPpYGOLd9FAXjX2hdyrZ4VQL4qWe8Gxj3
         ZTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687950531; x=1690542531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZEEvwL/mGWHXhkyWVXKsnRaFccZ9iXGZJdLXdIu2mA=;
        b=QnMm7blJFNICV/OX/lqzjTXITW8uNkd+NrcgYESKdf8SM6RWo5zaK1T9FehwqmNmVZ
         vSQtN3lpjNtx4QtKBGCgEldMrFbuSu8kDVKDU+ad+vdudNpmckp+aPV1daVl/UkJB2GV
         3zTVcVFZ/Xyrb6kUv7sEKL+w21GgkpLogzixSIA8tN4PRaelJ2LlSRzE65kDgwP8vprx
         1/11GxW31ICNQpDrNHkjfIUyfSPAUT/yOfT8bPC4WeQ7Vg+yZKGEq5KA2t1oefr9w3l3
         NNGLYb6mO7uNvkSmJESpNfX/QuqUqQF0Ko+f7nOBHJDIKYEUhcVNoMKAu6SHQgtXWBFY
         /u8w==
X-Gm-Message-State: AC+VfDw7Nj6l8oz9KbaQz6tQcBrdEoebrCKv/e5RKpzWx3stJOP5xTkK
        tVkbrd67WJVWv3fdlQbmsumSuJcDUeZBUx6odWc=
X-Google-Smtp-Source: ACHHUZ6clyblrgBU+QGha+veEQGjoOpgvFjicxCWlS+zdHrZkC0EKJ660ba8bRhh3X/ZlSQlQmjbtQ==
X-Received: by 2002:a19:500f:0:b0:4f8:6533:3341 with SMTP id e15-20020a19500f000000b004f865333341mr18264863lfb.20.1687950530699;
        Wed, 28 Jun 2023 04:08:50 -0700 (PDT)
Received: from [192.168.1.101] (abyj233.neoplus.adsl.tpnet.pl. [83.9.29.233])
        by smtp.gmail.com with ESMTPSA id k7-20020ac24567000000b004fb2244563csm1529190lfm.216.2023.06.28.04.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 04:08:50 -0700 (PDT)
Message-ID: <a2497c05-1aa5-1a75-5ae1-f8fc0551e04a@linaro.org>
Date:   Wed, 28 Jun 2023 13:08:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 5/5] clk: qcom: gcc-qdu1000: Update the RCGs ops
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
 <20230628092837.3090801-6-quic_imrashai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230628092837.3090801-6-quic_imrashai@quicinc.com>
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

On 28.06.2023 11:28, Imran Shaik wrote:
> Update the SDCC clock RCG ops to floor_ops to avoid overclocking issues
> and remaining RCGs to shared_ops to park them at safe clock(XO) during
> disable.
> 
> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Changes since v1:
>  - Newly added
> 
>  drivers/clk/qcom/gcc-qdu1000.c | 62 +++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
> index 718c34dca6e8..de35cdc93732 100644
> --- a/drivers/clk/qcom/gcc-qdu1000.c
> +++ b/drivers/clk/qcom/gcc-qdu1000.c
> @@ -475,7 +475,7 @@ static struct clk_rcg2 gcc_aggre_noc_ecpri_dma_clk_src = {
>  		.name = "gcc_aggre_noc_ecpri_dma_clk_src",
>  		.parent_data = gcc_parent_data_4,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -495,7 +495,7 @@ static struct clk_rcg2 gcc_aggre_noc_ecpri_gsi_clk_src = {
>  		.name = "gcc_aggre_noc_ecpri_gsi_clk_src",
>  		.parent_data = gcc_parent_data_5,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -514,7 +514,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
>  		.name = "gcc_gp1_clk_src",
>  		.parent_data = gcc_parent_data_1,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -528,7 +528,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
>  		.name = "gcc_gp2_clk_src",
>  		.parent_data = gcc_parent_data_1,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -542,7 +542,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
>  		.name = "gcc_gp3_clk_src",
>  		.parent_data = gcc_parent_data_1,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -561,7 +561,7 @@ static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
>  		.name = "gcc_pcie_0_aux_clk_src",
>  		.parent_data = gcc_parent_data_3,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -581,7 +581,7 @@ static struct clk_rcg2 gcc_pcie_0_phy_rchng_clk_src = {
>  		.name = "gcc_pcie_0_phy_rchng_clk_src",
>  		.parent_data = gcc_parent_data_0,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -600,7 +600,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
>  		.name = "gcc_pdm2_clk_src",
>  		.parent_data = gcc_parent_data_0,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -622,7 +622,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s0_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
> @@ -638,7 +638,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s1_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
> @@ -654,7 +654,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s2_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
> @@ -670,7 +670,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s3_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
> @@ -686,7 +686,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s4_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
> @@ -707,7 +707,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s5_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
> @@ -723,7 +723,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s6_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s6_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
> @@ -739,7 +739,7 @@ static struct clk_init_data gcc_qupv3_wrap0_s7_clk_src_init = {
>  	.name = "gcc_qupv3_wrap0_s7_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
> @@ -755,7 +755,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s0_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
> @@ -771,7 +771,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s1_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
> @@ -787,7 +787,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s2_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
> @@ -803,7 +803,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s3_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
> @@ -819,7 +819,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s4_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
> @@ -835,7 +835,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s5_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
> @@ -851,7 +851,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s6_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s6_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
> @@ -867,7 +867,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s7_clk_src_init = {
>  	.name = "gcc_qupv3_wrap1_s7_clk_src",
>  	.parent_data = gcc_parent_data_0,
>  	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -	.ops = &clk_rcg2_ops,
> +	.ops = &clk_rcg2_shared_ops,
>  };
>  
>  static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
> @@ -903,7 +903,7 @@ static struct clk_rcg2 gcc_sdcc5_apps_clk_src = {
>  		.name = "gcc_sdcc5_apps_clk_src",
>  		.parent_data = gcc_parent_data_8,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
>  
> @@ -922,7 +922,7 @@ static struct clk_rcg2 gcc_sdcc5_ice_core_clk_src = {
>  		.name = "gcc_sdcc5_ice_core_clk_src",
>  		.parent_data = gcc_parent_data_2,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
>  
> @@ -936,7 +936,7 @@ static struct clk_rcg2 gcc_sm_bus_xo_clk_src = {
>  		.name = "gcc_sm_bus_xo_clk_src",
>  		.parent_data = gcc_parent_data_2,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -955,7 +955,7 @@ static struct clk_rcg2 gcc_tsc_clk_src = {
>  		.name = "gcc_tsc_clk_src",
>  		.parent_data = gcc_parent_data_9,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_9),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -975,7 +975,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
>  		.name = "gcc_usb30_prim_master_clk_src",
>  		.parent_data = gcc_parent_data_0,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -989,7 +989,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
>  		.name = "gcc_usb30_prim_mock_utmi_clk_src",
>  		.parent_data = gcc_parent_data_0,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
> @@ -1003,7 +1003,7 @@ static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
>  		.name = "gcc_usb3_prim_phy_aux_clk_src",
>  		.parent_data = gcc_parent_data_3,
>  		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_shared_ops,
>  	},
>  };
>  
