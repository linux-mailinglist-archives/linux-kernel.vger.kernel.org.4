Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA48362C66C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiKPRcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiKPRcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:32:46 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336AE4874A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:32:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g12so30711534lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfYVD9gPVLglWCAThpjQvlhgg1g4QFqwAOyUtYlY9+Y=;
        b=aABRGrqOlt+N50NvL7oAJONVLzdplb7kI++G5BQz2QYpZFZ79RnUICDwAusv7BbV4N
         eI44mi5+9s8YMiAGhy2m5rQiSGNsb5PamtjrtEjo3qYSvgguRO/tsUIoYJHFUspOp8uo
         36YcaoQytNKBpnDgcndnWp8QS532xpxlKgXCD7JZX2DiuXq/36zz8+9Ya5iW1jtHBjtJ
         klsPID5h46Xj6HvqFxCRzskZtPVUhMRTdtaqJvIuBKpR9OjGkeBIHV/6OuglYkoQcase
         IfaD2HUQ/ntUfavVdKNimTZFokOssIbpBAwvoD3+qc01srrCewlbH7yAlffF3SBdlZb0
         GN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfYVD9gPVLglWCAThpjQvlhgg1g4QFqwAOyUtYlY9+Y=;
        b=OAAL4aMrmBX6eTVenmS21n3jUQfcrbaBI021Wx+y1f0m+my298n5gtSDLtcqVgf8FK
         2LK/C0SHhCDpSVIr7Lo0C8t9XHgmRV9Pr2SYDw4bM1xJH1K86sd5eaCmEvZpgwyOFSY2
         tYlS7XJ69UrnIVf1UjPDLBLPt1f7tncJF/X32q/7TKg5m2lQiR8vyYDn7VwS7uXjBcMF
         WxSa39v8bXWeQO126pthG40XtWweW3gHnGhNGt8b98y4JleTJj1h9u4aFsXMyt9I9W5E
         4k+u0thTNFThGs4k28Qv2NMCGYPX8THNIPYGLc77tZsYDQUSf8ZrAJ9U54NW0LhyOI4I
         S0cA==
X-Gm-Message-State: ANoB5plc4n4en3mGkJPihhJVMISqllbH1aDa9h2nW1NVjB+v6y+Jdam9
        5+CEnHXklIilp4VnH1yjQAZgSg==
X-Google-Smtp-Source: AA0mqf4sMXMi/GteutFIyr5f3fQ+qBHM363f9Silru1a9PHSWU19h24dDWIdg1KcCE65vihZWUmv8Q==
X-Received: by 2002:ac2:47ee:0:b0:4b0:8df6:9043 with SMTP id b14-20020ac247ee000000b004b08df69043mr8600587lfp.517.1668619962546;
        Wed, 16 Nov 2022 09:32:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k12-20020ac257cc000000b004998d9ccb62sm115059lfo.99.2022.11.16.09.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 09:32:41 -0800 (PST)
Message-ID: <282345e7-fa89-87b2-309d-15d0b0350900@linaro.org>
Date:   Wed, 16 Nov 2022 18:32:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SM8550 interconnect provider
 driver
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20221116114526.2679041-1-abel.vesa@linaro.org>
 <20221116114526.2679041-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116114526.2679041-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 12:45, Abel Vesa wrote:
> Add driver for the Qualcomm interconnect buses found in SM8550 based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Thank you for your patch. There is something to discuss/improve.



> +static struct qcom_icc_node * const config_noc_nodes[] = {
> +	[MASTER_CNOC_CFG] = &qsm_cfg,
> +	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
> +	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
> +	[SLAVE_APPSS] = &qhs_apss,
> +	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
> +	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
> +	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
> +	[SLAVE_RBCPR_MMCX_CFG] = &qhs_cpr_mmcx,
> +	[SLAVE_RBCPR_MXA_CFG] = &qhs_cpr_mxa,
> +	[SLAVE_RBCPR_MXC_CFG] = &qhs_cpr_mxc,
> +	[SLAVE_CPR_NSPCX] = &qhs_cpr_nspcx,
> +	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
> +	[SLAVE_CX_RDPM] = &qhs_cx_rdpm,
> +	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
> +	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
> +	[SLAVE_I2C] = &qhs_i2c,
> +	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
> +	[SLAVE_IPA_CFG] = &qhs_ipa,
> +	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
> +	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
> +	[SLAVE_MX_RDPM] = &qhs_mx_rdpm,
> +	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
> +	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
> +	[SLAVE_PDM] = &qhs_pdm,
> +	[SLAVE_PIMEM_CFG] = &qhs_pimem_cfg,
> +	[SLAVE_PRNG] = &qhs_prng,
> +	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
> +	[SLAVE_QSPI_0] = &qhs_qspi,
> +	[SLAVE_QUP_1] = &qhs_qup1,
> +	[SLAVE_QUP_2] = &qhs_qup2,
> +	[SLAVE_SDCC_2] = &qhs_sdc2,
> +	[SLAVE_SDCC_4] = &qhs_sdc4,
> +	[SLAVE_SPSS_CFG] = &qhs_spss_cfg,
> +	[SLAVE_TCSR] = &qhs_tcsr,
> +	[SLAVE_TLMM] = &qhs_tlmm,
> +	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
> +	[SLAVE_USB3_0] = &qhs_usb3_0,
> +	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
> +	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
> +	[SLAVE_LPASS_QTB_CFG] = &qss_lpass_qtb_cfg,
> +	[SLAVE_CNOC_MNOC_CFG] = &qss_mnoc_cfg,
> +	[SLAVE_NSP_QTB_CFG] = &qss_nsp_qtb_cfg,
> +	[SLAVE_PCIE_ANOC_CFG] = &qss_pcie_anoc_cfg,
> +	[SLAVE_QDSS_STM] = &xs_qdss_stm,
> +	[SLAVE_TCU] = &xs_sys_tcu_cfg,
> +};
> +
> +static struct qcom_icc_desc sm8550_config_noc = {
> +	.nodes = config_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(config_noc_nodes),
> +	.bcms = config_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(config_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *cnoc_main_bcms[] = {

Const pointers. Also in several other places as well.

> +	&bcm_cn0,
> +};
> +
> +static struct qcom_icc_node *cnoc_main_nodes[] = {
> +	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
> +	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
> +	[SLAVE_AOSS] = &qhs_aoss,
> +	[SLAVE_TME_CFG] = &qhs_tme_cfg,
> +	[SLAVE_CNOC_CFG] = &qss_cfg,
> +	[SLAVE_DDRSS_CFG] = &qss_ddrss_cfg,
> +	[SLAVE_BOOT_IMEM] = &qxs_boot_imem,
> +	[SLAVE_IMEM] = &qxs_imem,
> +	[SLAVE_PCIE_0] = &xs_pcie_0,
> +	[SLAVE_PCIE_1] = &xs_pcie_1,
> +};
> +
> +static struct qcom_icc_desc sm8550_cnoc_main = {

This should be const.

> +	.nodes = cnoc_main_nodes,
> +	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
> +	.bcms = cnoc_main_bcms,
> +	.num_bcms = ARRAY_SIZE(cnoc_main_bcms),
> +};
> +
> +static struct qcom_icc_bcm *gem_noc_bcms[] = {
> +	&bcm_sh0,
> +	&bcm_sh1,
> +	&bcm_sh0_disp,
> +	&bcm_sh1_disp,
> +	&bcm_sh0_cam_ife_0,
> +	&bcm_sh1_cam_ife_0,
> +	&bcm_sh0_cam_ife_1,
> +	&bcm_sh1_cam_ife_1,
> +	&bcm_sh0_cam_ife_2,
> +	&bcm_sh1_cam_ife_2,
> +};
> +
> +static struct qcom_icc_node *gem_noc_nodes[] = {
> +	[MASTER_GPU_TCU] = &alm_gpu_tcu,
> +	[MASTER_SYS_TCU] = &alm_sys_tcu,
> +	[MASTER_APPSS_PROC] = &chm_apps,
> +	[MASTER_GFX3D] = &qnm_gpu,
> +	[MASTER_LPASS_GEM_NOC] = &qnm_lpass_gemnoc,
> +	[MASTER_MSS_PROC] = &qnm_mdsp,
> +	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
> +	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
> +	[MASTER_COMPUTE_NOC] = &qnm_nsp_gemnoc,
> +	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
> +	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
> +	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
> +	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
> +	[SLAVE_LLCC] = &qns_llcc,
> +	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
> +	[MASTER_MNOC_HF_MEM_NOC_DISP] = &qnm_mnoc_hf_disp,
> +	[MASTER_ANOC_PCIE_GEM_NOC_DISP] = &qnm_pcie_disp,
> +	[SLAVE_LLCC_DISP] = &qns_llcc_disp,
> +	[MASTER_MNOC_HF_MEM_NOC_CAM_IFE_0] = &qnm_mnoc_hf_cam_ife_0,
> +	[MASTER_MNOC_SF_MEM_NOC_CAM_IFE_0] = &qnm_mnoc_sf_cam_ife_0,
> +	[MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_0] = &qnm_pcie_cam_ife_0,
> +	[SLAVE_LLCC_CAM_IFE_0] = &qns_llcc_cam_ife_0,
> +	[MASTER_MNOC_HF_MEM_NOC_CAM_IFE_1] = &qnm_mnoc_hf_cam_ife_1,
> +	[MASTER_MNOC_SF_MEM_NOC_CAM_IFE_1] = &qnm_mnoc_sf_cam_ife_1,
> +	[MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_1] = &qnm_pcie_cam_ife_1,
> +	[SLAVE_LLCC_CAM_IFE_1] = &qns_llcc_cam_ife_1,
> +	[MASTER_MNOC_HF_MEM_NOC_CAM_IFE_2] = &qnm_mnoc_hf_cam_ife_2,
> +	[MASTER_MNOC_SF_MEM_NOC_CAM_IFE_2] = &qnm_mnoc_sf_cam_ife_2,
> +	[MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_2] = &qnm_pcie_cam_ife_2,
> +	[SLAVE_LLCC_CAM_IFE_2] = &qns_llcc_cam_ife_2,
> +};
> +
> +static struct qcom_icc_desc sm8550_gem_noc = {

Const... and so on - multiple places.

> +	.nodes = gem_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
> +	.bcms = gem_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
> +};
> +
> +static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
> +	[MASTER_LPIAON_NOC] = &qnm_lpiaon_noc,
> +	[SLAVE_LPASS_GEM_NOC] = &qns_lpass_ag_noc_gemnoc,
> +};
> +
> +static const struct qcom_icc_desc sm8550_lpass_ag_noc = {
> +	.nodes = lpass_ag_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
> +	.bcms = lpass_ag_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const lpass_lpiaon_noc_bcms[] = {
> +	&bcm_lp0,
> +};
> +
> +static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
> +	[MASTER_LPASS_LPINOC] = &qnm_lpass_lpinoc,
> +	[SLAVE_LPIAON_NOC_LPASS_AG_NOC] = &qns_lpass_aggnoc,
> +};
> +
> +static const struct qcom_icc_desc sm8550_lpass_lpiaon_noc = {
> +	.nodes = lpass_lpiaon_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
> +	.bcms = lpass_lpiaon_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(lpass_lpiaon_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const lpass_lpicx_noc_bcms[] = {
> +};
> +
> +static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
> +	[MASTER_LPASS_PROC] = &qxm_lpinoc_dsp_axim,
> +	[SLAVE_LPICX_NOC_LPIAON_NOC] = &qns_lpi_aon_noc,
> +};
> +
> +static const struct qcom_icc_desc sm8550_lpass_lpicx_noc = {
> +	.nodes = lpass_lpicx_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
> +	.bcms = lpass_lpicx_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(lpass_lpicx_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const mc_virt_bcms[] = {
> +	&bcm_acv,
> +	&bcm_mc0,
> +	&bcm_acv_disp,
> +	&bcm_mc0_disp,
> +	&bcm_acv_cam_ife_0,
> +	&bcm_mc0_cam_ife_0,
> +	&bcm_acv_cam_ife_1,
> +	&bcm_mc0_cam_ife_1,
> +	&bcm_acv_cam_ife_2,
> +	&bcm_mc0_cam_ife_2,
> +};
> +
> +static struct qcom_icc_node * const mc_virt_nodes[] = {
> +	[MASTER_LLCC] = &llcc_mc,
> +	[SLAVE_EBI1] = &ebi,
> +	[MASTER_LLCC_DISP] = &llcc_mc_disp,
> +	[SLAVE_EBI1_DISP] = &ebi_disp,
> +	[MASTER_LLCC_CAM_IFE_0] = &llcc_mc_cam_ife_0,
> +	[SLAVE_EBI1_CAM_IFE_0] = &ebi_cam_ife_0,
> +	[MASTER_LLCC_CAM_IFE_1] = &llcc_mc_cam_ife_1,
> +	[SLAVE_EBI1_CAM_IFE_1] = &ebi_cam_ife_1,
> +	[MASTER_LLCC_CAM_IFE_2] = &llcc_mc_cam_ife_2,
> +	[SLAVE_EBI1_CAM_IFE_2] = &ebi_cam_ife_2,
> +};
> +
> +static const struct qcom_icc_desc sm8550_mc_virt = {
> +	.nodes = mc_virt_nodes,
> +	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
> +	.bcms = mc_virt_bcms,
> +	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
> +};
> +
> +static struct qcom_icc_bcm *mmss_noc_bcms[] = {
> +	&bcm_mm0,
> +	&bcm_mm1,
> +	&bcm_mm0_disp,
> +	&bcm_mm0_cam_ife_0,
> +	&bcm_mm1_cam_ife_0,
> +	&bcm_mm0_cam_ife_1,
> +	&bcm_mm1_cam_ife_1,
> +	&bcm_mm0_cam_ife_2,
> +	&bcm_mm1_cam_ife_2,
> +};
> +
> +static struct qcom_icc_node * const mmss_noc_nodes[] = {
> +	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
> +	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
> +	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
> +	[MASTER_MDP] = &qnm_mdp,
> +	[MASTER_CDSP_HCP] = &qnm_vapss_hcp,
> +	[MASTER_VIDEO] = &qnm_video,
> +	[MASTER_VIDEO_CV_PROC] = &qnm_video_cv_cpu,
> +	[MASTER_VIDEO_PROC] = &qnm_video_cvp,
> +	[MASTER_VIDEO_V_PROC] = &qnm_video_v_cpu,
> +	[MASTER_CNOC_MNOC_CFG] = &qsm_mnoc_cfg,
> +	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
> +	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
> +	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
> +	[MASTER_MDP_DISP] = &qnm_mdp_disp,
> +	[SLAVE_MNOC_HF_MEM_NOC_DISP] = &qns_mem_noc_hf_disp,
> +	[MASTER_CAMNOC_HF_CAM_IFE_0] = &qnm_camnoc_hf_cam_ife_0,
> +	[MASTER_CAMNOC_ICP_CAM_IFE_0] = &qnm_camnoc_icp_cam_ife_0,
> +	[MASTER_CAMNOC_SF_CAM_IFE_0] = &qnm_camnoc_sf_cam_ife_0,
> +	[SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_0] = &qns_mem_noc_hf_cam_ife_0,
> +	[SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0] = &qns_mem_noc_sf_cam_ife_0,
> +	[MASTER_CAMNOC_HF_CAM_IFE_1] = &qnm_camnoc_hf_cam_ife_1,
> +	[MASTER_CAMNOC_ICP_CAM_IFE_1] = &qnm_camnoc_icp_cam_ife_1,
> +	[MASTER_CAMNOC_SF_CAM_IFE_1] = &qnm_camnoc_sf_cam_ife_1,
> +	[SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_1] = &qns_mem_noc_hf_cam_ife_1,
> +	[SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1] = &qns_mem_noc_sf_cam_ife_1,
> +	[MASTER_CAMNOC_HF_CAM_IFE_2] = &qnm_camnoc_hf_cam_ife_2,
> +	[MASTER_CAMNOC_ICP_CAM_IFE_2] = &qnm_camnoc_icp_cam_ife_2,
> +	[MASTER_CAMNOC_SF_CAM_IFE_2] = &qnm_camnoc_sf_cam_ife_2,
> +	[SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_2] = &qns_mem_noc_hf_cam_ife_2,
> +	[SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2] = &qns_mem_noc_sf_cam_ife_2,
> +};
> +
> +static const struct qcom_icc_desc sm8550_mmss_noc = {
> +	.nodes = mmss_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
> +	.bcms = mmss_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const nsp_noc_bcms[] = {
> +	&bcm_co0,
> +};
> +
> +static struct qcom_icc_node * const nsp_noc_nodes[] = {
> +	[MASTER_CDSP_PROC] = &qxm_nsp,
> +	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
> +};
> +
> +static const struct qcom_icc_desc sm8550_nsp_noc = {
> +	.nodes = nsp_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
> +	.bcms = nsp_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
> +	&bcm_sn7,
> +};
> +
> +static struct qcom_icc_node * const pcie_anoc_nodes[] = {
> +	[MASTER_PCIE_ANOC_CFG] = &qsm_pcie_anoc_cfg,
> +	[MASTER_PCIE_0] = &xm_pcie3_0,
> +	[MASTER_PCIE_1] = &xm_pcie3_1,
> +	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
> +	[SLAVE_SERVICE_PCIE_ANOC] = &srvc_pcie_aggre_noc,
> +};
> +
> +static const struct qcom_icc_desc sm8550_pcie_anoc = {
> +	.nodes = pcie_anoc_nodes,
> +	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
> +	.bcms = pcie_anoc_bcms,
> +	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const system_noc_bcms[] = {
> +	&bcm_sn0,
> +	&bcm_sn1,
> +	&bcm_sn2,
> +	&bcm_sn3,
> +};
> +
> +static struct qcom_icc_node * const system_noc_nodes[] = {
> +	[MASTER_GIC_AHB] = &qhm_gic,
> +	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
> +	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
> +	[MASTER_GIC] = &xm_gic,
> +	[SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
> +	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
> +};
> +
> +static const struct qcom_icc_desc sm8550_system_noc = {
> +	.nodes = system_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(system_noc_nodes),
> +	.bcms = system_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(system_noc_bcms),
> +};
> +
> +static int qnoc_probe(struct platform_device *pdev)
> +{
> +	const struct qcom_icc_desc *desc;
> +	struct icc_onecell_data *data;
> +	struct icc_provider *provider;
> +	struct qcom_icc_node * const *qnodes;
> +	struct qcom_icc_provider *qp;
> +	struct icc_node *node;
> +	size_t num_nodes, i;
> +	int ret;
> +
> +	desc = device_get_match_data(&pdev->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	qnodes = desc->nodes;
> +	num_nodes = desc->num_nodes;
> +
> +	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
> +	if (!qp)
> +		return -ENOMEM;
> +
> +	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	provider = &qp->provider;
> +	provider->dev = &pdev->dev;
> +	provider->set = qcom_icc_set;
> +	provider->pre_aggregate = qcom_icc_pre_aggregate;
> +	provider->aggregate = qcom_icc_aggregate;
> +	provider->xlate_extended = qcom_icc_xlate_extended;
> +	INIT_LIST_HEAD(&provider->nodes);
> +	provider->data = data;
> +
> +	qp->dev = &pdev->dev;
> +	qp->bcms = desc->bcms;
> +	qp->num_bcms = desc->num_bcms;
> +
> +	qp->voter = of_bcm_voter_get(qp->dev, NULL);
> +	if (IS_ERR(qp->voter))
> +		return PTR_ERR(qp->voter);
> +
> +	ret = icc_provider_add(provider);
> +	if (ret) {
> +		dev_err(&pdev->dev, "error adding interconnect provider\n");

return dev_err_probe().

> +		return ret;
> +	}
> +

Best regards,
Krzysztof

