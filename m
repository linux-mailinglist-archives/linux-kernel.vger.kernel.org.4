Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137BA73B906
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjFWNrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjFWNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:47:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D729F2713
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:46:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b466744368so11491151fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687528013; x=1690120013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVPFiTXiHN5JMTEeha1FIlf9pYQ0Aa0NYaPk7qaQspM=;
        b=Zs4Yo59/1MG72R0gt1GaekHcvCbVMvsosSU3+tLSUSwMLg1obNJQ7Uofshn21qRYyL
         hv9X81xB5jjjqgi3txeh5VRKzKo4R81RBs7xA6hu9m/6jcatoArsJ8bSX9H301hQPDIf
         qk8CHs++V39y7HsS7QeJteIcO8+00hdbtwVRh3L100BFC8IfZMIxaRkY68Fquc4ivUWH
         bduPlItYGmxwv5XD3sSlNygieOYU1BUNOb/7HRdySZz9N1ASoysNPLK/G3Qr+vOPDGmi
         G6cvDerHywGYVbQx7TlqQkd8lvY3ko5hmXk8nZ4+HhA7QNTxhx6N9+FVKh0cIBKSM6iY
         4A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687528013; x=1690120013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVPFiTXiHN5JMTEeha1FIlf9pYQ0Aa0NYaPk7qaQspM=;
        b=Aj3oUEK563UoXSdWn6ydGhmkKYK2Uz+7swvhTxs41seN2CghqnU9D2QhT99oZZzU/G
         MoYAmbPtXXj24XFM3AIGGTrW0+hCF3XyUCVVG5eDCT0hL/iapWd4g87pG53+ZA4HUO4s
         zIcg3EWkPItOxlp14tfy3Ebuqe7lOrspzPV29TsjWXT2uWeQMh6YuTGMUNbcusp8XW9s
         ASNZewuwDwpK5uoN+uIiAqrBqEaEoiDoD2cYfla7dAF3j+MQwnB1Efwxp8tVf3MHMNJh
         9cxOF7IxM2eQj9iqF3KuhmVuymyBy37J+stb1+np/4/sKnK0jHi3tfZEmGAkro8OC/OP
         fzgQ==
X-Gm-Message-State: AC+VfDyTFPdGTPqv1SzGAD7HWu6ddNkDdN7KmpdWqKlcy1CEdYu8ztH+
        VK3lYw/hOStbODgstWf+xJ2aw8ERZTVzu3iuJcw=
X-Google-Smtp-Source: ACHHUZ7nGCmwqqAJ+fPnypsOoPzK5m+s/lljI1cFEAxrGS67vTPHz9BzVNflq/NqyVkt/DiE+QTPhg==
X-Received: by 2002:a2e:2d02:0:b0:2b1:ea3d:2625 with SMTP id t2-20020a2e2d02000000b002b1ea3d2625mr14334435ljt.31.1687528013444;
        Fri, 23 Jun 2023 06:46:53 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id z6-20020a2e9646000000b002b47a15a2eesm1743320ljh.45.2023.06.23.06.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 06:46:53 -0700 (PDT)
Message-ID: <ac1b0200-23a8-43d8-3f63-1ad49f08da10@linaro.org>
Date:   Fri, 23 Jun 2023 15:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] interconnect: qcom: sm8450: add enable_mask for
 bcm nodes
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
 <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-2-709474b151cc@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-2-709474b151cc@linaro.org>
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

On 23.06.2023 14:50, Neil Armstrong wrote:
> Set the proper enable_mask to nodes requiring such value
> to be used instead of a bandwidth when voting.
> 
> The masks were copied from the downstream implementation at [1].
> 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-5.10/-/blob/KERNEL.PLATFORM.1.0.r2-05600-WAIPIOLE.0/drivers/interconnect/qcom/waipio.c
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/interconnect/qcom/sm8450.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
> index 2d7a8e7b85ec..e64c214b4020 100644
> --- a/drivers/interconnect/qcom/sm8450.c
> +++ b/drivers/interconnect/qcom/sm8450.c
> @@ -1337,6 +1337,7 @@ static struct qcom_icc_node qns_mem_noc_sf_disp = {
>  
>  static struct qcom_icc_bcm bcm_acv = {
>  	.name = "ACV",
> +	.enable_mask = 0x8,
>  	.num_nodes = 1,
>  	.nodes = { &ebi },
>  };
> @@ -1349,6 +1350,7 @@ static struct qcom_icc_bcm bcm_ce0 = {
>  
>  static struct qcom_icc_bcm bcm_cn0 = {
>  	.name = "CN0",
> +	.enable_mask = 0x1,
>  	.keepalive = true,
>  	.num_nodes = 55,
>  	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie,
> @@ -1383,6 +1385,7 @@ static struct qcom_icc_bcm bcm_cn0 = {
>  
>  static struct qcom_icc_bcm bcm_co0 = {
>  	.name = "CO0",
> +	.enable_mask = 0x1,
>  	.num_nodes = 2,
>  	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
>  };
> @@ -1403,6 +1406,7 @@ static struct qcom_icc_bcm bcm_mm0 = {
>  
>  static struct qcom_icc_bcm bcm_mm1 = {
>  	.name = "MM1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 12,
>  	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
>  		   &qnm_camnoc_sf, &qnm_mdp,
> @@ -1445,6 +1449,7 @@ static struct qcom_icc_bcm bcm_sh0 = {
>  
>  static struct qcom_icc_bcm bcm_sh1 = {
>  	.name = "SH1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 7,
>  	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
>  		   &qnm_nsp_gemnoc, &qnm_pcie,
> @@ -1461,6 +1466,7 @@ static struct qcom_icc_bcm bcm_sn0 = {
>  
>  static struct qcom_icc_bcm bcm_sn1 = {
>  	.name = "SN1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 4,
>  	.nodes = { &qhm_gic, &qxm_pimem,
>  		   &xm_gic, &qns_gemnoc_gc },
> @@ -1492,6 +1498,7 @@ static struct qcom_icc_bcm bcm_sn7 = {
>  
>  static struct qcom_icc_bcm bcm_acv_disp = {
>  	.name = "ACV",
> +	.enable_mask = 0x1,
>  	.num_nodes = 1,
>  	.nodes = { &ebi_disp },
>  };
> @@ -1510,6 +1517,7 @@ static struct qcom_icc_bcm bcm_mm0_disp = {
>  
>  static struct qcom_icc_bcm bcm_mm1_disp = {
>  	.name = "MM1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 3,
>  	.nodes = { &qnm_mdp_disp, &qnm_rot_disp,
>  		   &qns_mem_noc_sf_disp },
> @@ -1523,6 +1531,7 @@ static struct qcom_icc_bcm bcm_sh0_disp = {
>  
>  static struct qcom_icc_bcm bcm_sh1_disp = {
>  	.name = "SH1",
> +	.enable_mask = 0x1,
>  	.num_nodes = 1,
>  	.nodes = { &qnm_pcie_disp },
>  };
> 
