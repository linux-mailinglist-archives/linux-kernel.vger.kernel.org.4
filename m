Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8B67350F8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjFSJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjFSJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:55:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79436113
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:55:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f76a4c211dso4038272e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687168515; x=1689760515;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKxFvYb3cZYxLB7ZQPgBnTAZnmzpCCcSgHS68RMnZc8=;
        b=wH6OW839MZqfHt7yxmw/3y4XDO4pTh/dNOtvBAi85DmaChS2uPFj12uoQiW4wGJRAC
         Y+dHwJLDm9vEAcUzYftPE2iNCq3MoDI496/wMgPc/6aa04cdqDOKJLya8n5FsayHbg/7
         uT5A+6n+U14rCuYERdGCoP96lbOqW2F43UD9dO2U5DOSxJbtJxlXU70riv//iIwBhhOP
         hCF9Zh6AyzpGhvR/YYW0GIOy93SqtyIA2P5THbTeA32UCAoJDn05KJzYPW+RDYKsclVr
         vZgZubx6xut8/oae1Zk/taJJEg0HWGb2i7bnEZnzE1ljzT0eJXV62o7RS0yOgf6Ci8aA
         JmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687168515; x=1689760515;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKxFvYb3cZYxLB7ZQPgBnTAZnmzpCCcSgHS68RMnZc8=;
        b=hV0gsB4jAoNyH2EehF7fzJydRLTQDFcbXQmSc+xsQ+e2puBm+aBNqrFd1k1RRzu6fV
         WV4pj1eg9KuwJceIqU2aUUHpao+P+dJTI2Zu+an1RPFoNNqss2KwSDSQmb43Og2yVRHI
         jsW331wdpA/L07q4ti6VymBnpLrrRHYXrqH1Nb94on8I6b1k82lflQgzRnJU/1E/XJUh
         9E06QwnqvVh2y3pdxet3czUcOJ8t+scBYX7ZnV82OnMHpK6+wxcWX0V8S5A+jD4/Y5xE
         oGbUzQyKXX0udMbUOo6wp07SZJKrghr0S6x3FNxrvWMSseAK9tYGL5QptBXWFXTvrLAz
         adTw==
X-Gm-Message-State: AC+VfDxZxIZD3HHF72GT/dF+/xJaLA3sGA/5Z66lRp6n8zCmpf2haJzY
        /caT7uGGYk9FVVO8CNPVcza3Juot3bzx2nCpbm4=
X-Google-Smtp-Source: ACHHUZ44o4fS06waGDlHtGse3+ziDgT9HAbqyNh5AapgIwJwzD4q+/XZqo1hQL8sOVMPec+8yFp06g==
X-Received: by 2002:a05:6512:3285:b0:4f8:585e:5e51 with SMTP id p5-20020a056512328500b004f8585e5e51mr5022093lfe.5.1687168514616;
        Mon, 19 Jun 2023 02:55:14 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id r11-20020ac25a4b000000b004f391a2028dsm4207221lfn.265.2023.06.19.02.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 02:55:14 -0700 (PDT)
Message-ID: <f4801649-6968-7e62-01b1-7aa517a5d2f3@linaro.org>
Date:   Mon, 19 Jun 2023 11:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-0-66663c0aa592@linaro.org>
 <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-2-66663c0aa592@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 2/2] interconnect: qcom: sm8550: add enable_mask for bcm
 nodes
In-Reply-To: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-2-66663c0aa592@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 19.06.2023 10:24, Neil Armstrong wrote:
> Set the proper enable_mask to needs requiring such value
> to be used instead of a bandwidth when voting.
> 
> The masks were copied from the downstream implementation at [1].
> 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r1-rel/drivers/interconnect/qcom/kalama.c
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
The values match downstream, so:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Since you're already touching this code, may I turn your interest to:

1. Adding enable_mask-s to 8450 and 8775

2. Porting https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/d5edeca085f4

3. Adding the default perf settings for 8450 and 8550

Konrad

>  drivers/interconnect/qcom/sm8550.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
> index d823ba988ef6..0864ed285375 100644
> --- a/drivers/interconnect/qcom/sm8550.c
> +++ b/drivers/interconnect/qcom/sm8550.c
> @@ -1473,6 +1473,7 @@ static struct qcom_icc_node qns_mem_noc_sf_cam_ife_2 = {
>  
>  static struct qcom_icc_bcm bcm_acv = {
>  	.name = "ACV",
> +	.enable_mask = 0x8,
>  	.num_nodes = 1,
>  	.nodes = { &ebi },
>  };
> @@ -1485,6 +1486,7 @@ static struct qcom_icc_bcm bcm_ce0 = {
>  
>  static struct qcom_icc_bcm bcm_cn0 = {
>  	.name = "CN0",
> +	.enable_mask = 0x1,
>  	.keepalive = true,
>  	.num_nodes = 54,
>  	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
> @@ -1524,6 +1526,7 @@ static struct qcom_icc_bcm bcm_cn1 = {
>  
>  static struct qcom_icc_bcm bcm_co0 = {
>  	.name = "CO0",
> +	.enable_mask = 0x1,
>  	.num_nodes = 2,
>  	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
>  };
> @@ -1549,6 +1552,7 @@ static struct qcom_icc_bcm bcm_mm0 = {
>  
>  static struct qcom_icc_bcm bcm_mm1 = {
>  	.name = "MM1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 8,
>  	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
>  		   &qnm_camnoc_sf, &qnm_vapss_hcp,
> @@ -1589,6 +1593,7 @@ static struct qcom_icc_bcm bcm_sh0 = {
>  
>  static struct qcom_icc_bcm bcm_sh1 = {
>  	.name = "SH1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 13,
>  	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
>  		   &chm_apps, &qnm_gpu,
> @@ -1608,6 +1613,7 @@ static struct qcom_icc_bcm bcm_sn0 = {
>  
>  static struct qcom_icc_bcm bcm_sn1 = {
>  	.name = "SN1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 3,
>  	.nodes = { &qhm_gic, &xm_gic,
>  		   &qns_gemnoc_gc },
> @@ -1633,6 +1639,7 @@ static struct qcom_icc_bcm bcm_sn7 = {
>  
>  static struct qcom_icc_bcm bcm_acv_disp = {
>  	.name = "ACV",
> +	.enable_mask = 0x1,
>  	.num_nodes = 1,
>  	.nodes = { &ebi_disp },
>  };
> @@ -1657,12 +1664,14 @@ static struct qcom_icc_bcm bcm_sh0_disp = {
>  
>  static struct qcom_icc_bcm bcm_sh1_disp = {
>  	.name = "SH1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 2,
>  	.nodes = { &qnm_mnoc_hf_disp, &qnm_pcie_disp },
>  };
>  
>  static struct qcom_icc_bcm bcm_acv_cam_ife_0 = {
>  	.name = "ACV",
> +	.enable_mask = 0x0,
>  	.num_nodes = 1,
>  	.nodes = { &ebi_cam_ife_0 },
>  };
> @@ -1681,6 +1690,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_0 = {
>  
>  static struct qcom_icc_bcm bcm_mm1_cam_ife_0 = {
>  	.name = "MM1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 4,
>  	.nodes = { &qnm_camnoc_hf_cam_ife_0, &qnm_camnoc_icp_cam_ife_0,
>  		   &qnm_camnoc_sf_cam_ife_0, &qns_mem_noc_sf_cam_ife_0 },
> @@ -1694,6 +1704,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_0 = {
>  
>  static struct qcom_icc_bcm bcm_sh1_cam_ife_0 = {
>  	.name = "SH1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 3,
>  	.nodes = { &qnm_mnoc_hf_cam_ife_0, &qnm_mnoc_sf_cam_ife_0,
>  		   &qnm_pcie_cam_ife_0 },
> @@ -1701,6 +1712,7 @@ static struct qcom_icc_bcm bcm_sh1_cam_ife_0 = {
>  
>  static struct qcom_icc_bcm bcm_acv_cam_ife_1 = {
>  	.name = "ACV",
> +	.enable_mask = 0x0,
>  	.num_nodes = 1,
>  	.nodes = { &ebi_cam_ife_1 },
>  };
> @@ -1719,6 +1731,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_1 = {
>  
>  static struct qcom_icc_bcm bcm_mm1_cam_ife_1 = {
>  	.name = "MM1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 4,
>  	.nodes = { &qnm_camnoc_hf_cam_ife_1, &qnm_camnoc_icp_cam_ife_1,
>  		   &qnm_camnoc_sf_cam_ife_1, &qns_mem_noc_sf_cam_ife_1 },
> @@ -1732,6 +1745,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_1 = {
>  
>  static struct qcom_icc_bcm bcm_sh1_cam_ife_1 = {
>  	.name = "SH1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 3,
>  	.nodes = { &qnm_mnoc_hf_cam_ife_1, &qnm_mnoc_sf_cam_ife_1,
>  		   &qnm_pcie_cam_ife_1 },
> @@ -1739,6 +1753,7 @@ static struct qcom_icc_bcm bcm_sh1_cam_ife_1 = {
>  
>  static struct qcom_icc_bcm bcm_acv_cam_ife_2 = {
>  	.name = "ACV",
> +	.enable_mask = 0x0,
>  	.num_nodes = 1,
>  	.nodes = { &ebi_cam_ife_2 },
>  };
> @@ -1757,6 +1772,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_2 = {
>  
>  static struct qcom_icc_bcm bcm_mm1_cam_ife_2 = {
>  	.name = "MM1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 4,
>  	.nodes = { &qnm_camnoc_hf_cam_ife_2, &qnm_camnoc_icp_cam_ife_2,
>  		   &qnm_camnoc_sf_cam_ife_2, &qns_mem_noc_sf_cam_ife_2 },
> @@ -1770,6 +1786,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_2 = {
>  
>  static struct qcom_icc_bcm bcm_sh1_cam_ife_2 = {
>  	.name = "SH1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 3,
>  	.nodes = { &qnm_mnoc_hf_cam_ife_2, &qnm_mnoc_sf_cam_ife_2,
>  		   &qnm_pcie_cam_ife_2 },
> 
