Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD77433CC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjF3Ezv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 00:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjF3Ezo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:55:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997E4268F;
        Thu, 29 Jun 2023 21:55:42 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U4f3rK026286;
        Fri, 30 Jun 2023 04:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=b+w3SPUDkVDyUR0+2E+FFbXQu9m8vqG3ceTEzOxJgus=;
 b=hLD4dPDX6DQ1aO+TXkgPIMrd9o4r5xMqmi0yw9tVvKDxUX/W30SYHbRp7sjL7zMWT92C
 YybWqrYLY+K9sEmXL58ogb3yQaLsGwMT3btquKtOlNBao0p8QfEPBtNt44Enak5ZaJv/
 8MnpgVMCvMEvPemUPZxHGmeRHV7MHELNiNpS8YeVzqr/A9GrDZbGVrwKdlA/PR7pX1/w
 C3Z/q3SyjEnZLR1i1WgPmfIdx556IJ/OAjzMR/6atgVyxsBck54KaE8/UGrVD3tK9Nrc
 cNr24U3b6OXXHaKDRrB4jqdmxIYIToNuNtEYW3g1HCRoFR9Ee6pCHuN99mTYvFmYtH2p pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh0aajub1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 04:55:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U4tHZi019826
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 04:55:17 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Thu, 29 Jun 2023 21:55:10 -0700
Date:   Fri, 30 Jun 2023 10:25:06 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 11/21] soc: qcom: Register pstore frontend region with
 minidump
Message-ID: <99c98f22-69f7-4a6a-acc9-6a6a6bdb2031@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-12-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1687955688-20809-12-git-send-email-quic_mojha@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zgTbR1O443Va8HNnMKw7yS4Z709NUWth
X-Proofpoint-ORIG-GUID: zgTbR1O443Va8HNnMKw7yS4Z709NUWth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 impostorscore=0 mlxlogscore=863
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306300041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:04:38PM +0530, Mukesh Ojha wrote:
> +static int qcom_ramoops_md_region_register(struct device *dev, struct qcom_minidump_region **zone,
> +					   const char *name, phys_addr_t phys_addr,
> +					   unsigned long size)
> +{
> +	struct qcom_minidump_region *md_region;
> +	int ret;
> +
> +	if (!size)
> +		return 0;
> +
> +	md_region = devm_kzalloc(dev, sizeof(*md_region), GFP_KERNEL);
> +	if (!md_region)
> +		return -ENOMEM;
> +
> +	strscpy(md_region->name, name, sizeof(md_region->name));
> +	md_region->phys_addr = phys_addr;
> +	md_region->virt_addr = phys_to_virt(phys_addr);
> +	md_region->size = size;
> +	*zone = md_region;
> +	ret = qcom_minidump_region_register(md_region);
> +	if (ret)
> +		dev_err(dev, "failed to add %s in minidump: err: %d\n", name, ret);
> +
> +	return ret;
> +}
> +
> +static int qcom_ramoops_minidump_register(struct qcom_ramoops_dd *qcom_rdd)
> +{
> +	struct ramoops_platform_data *pdata = &qcom_rdd->qcom_ramoops_pdata;
> +	char name[MAX_NAME_LENGTH];
> +	size_t zone_sz;
> +	phys_addr_t phys_addr;
> +	int ret = 0;
> +	int i;
> +
> +	phys_addr = pdata->mem_address;
> +	for (i = 0; i < qcom_rdd->max_dump_cnt; i++) {
> +		scnprintf(name, sizeof(name), "KDMSG%d", i);
> +		ret = qcom_ramoops_md_region_register(qcom_rdd->dev,
> +			&qcom_rdd->dmesg_region[i], name, phys_addr,
> +			pdata->record_size);
> +		if (ret)
> +			return ret;
> +
> +		phys_addr += pdata->record_size;
> +	}
> +
> +	ret = qcom_ramoops_md_region_register(qcom_rdd->dev,
> +			&qcom_rdd->console_region, "KCONSOLE", phys_addr,
> +			pdata->console_size);
> +	if (ret)
> +		return ret;
> +
> +	phys_addr += pdata->console_size;
> +
> +	ret = qcom_ramoops_md_region_register(qcom_rdd->dev,
> +			&qcom_rdd->pmsg_region, "KPMSG", phys_addr,
> +			pdata->pmsg_size);
> +	if (ret)
> +		return ret;
> +
> +	phys_addr += pdata->pmsg_size;
> +
> +	zone_sz =  pdata->ftrace_size / qcom_rdd->max_ftrace_cnt;
> +	for (i = 0; i < qcom_rdd->max_ftrace_cnt; i++) {
> +		ret = qcom_ramoops_md_region_register(qcom_rdd->dev,
> +			&qcom_rdd->ftrace_region[i], "KFTRACE", phys_addr,
> +			zone_sz);
> +		if (ret)
> +			return ret;
> +
> +		phys_addr += zone_sz;
> +	}
> +
> +	return ret;
> +}

This may be the least of your worries, but plan to fix the error
handling in this function. The probe expects this function to self clean
when returning error.

Thanks,
Pavan
