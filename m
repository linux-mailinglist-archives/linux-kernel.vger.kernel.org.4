Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7AA5B6995
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiIMIb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiIMIbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:31:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FF132AA6;
        Tue, 13 Sep 2022 01:31:21 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D80ns0023483;
        Tue, 13 Sep 2022 08:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TU6BQUuqCvOJ10JNmm8vLsxkhWtaa3UDrD+q5dYDSa4=;
 b=b4kJoTc7gVSLoAzBrFCsG+rDv78LbxIsXJNMilQ+7YtkptqyFJVtMHTiyc1Z6IZBfTie
 hAFtQhB1Oj69AEdy5iokMt+dATGatcKhJS9XgamBYw30+B55qR/o/pgcRnLwnWytjFLg
 XL5Ml/nlVP5BHkCRnnVNqZrCahOCpfIAw/gGjiQyBYYvV8Bnxto5JlS6n8O1YEHxc2NS
 lEI/Jwm82x38+mjPOcmyhBZw8soo31p+PfmZvWufMINqb3P2iTdDH8VF3hdhw0pMg5Kr
 rcsMl0bn2wmNm8f4HRiAzKy2No++6mlIxcAYE1/QpKoSIq//ufsqcox1ugrZBbom2crl 9Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk636qn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 08:31:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D8VEBf001673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 08:31:14 GMT
Received: from [10.239.132.50] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 01:31:11 -0700
Message-ID: <d47faa55-9b3e-022a-c074-080ddbe0658b@quicinc.com>
Date:   Tue, 13 Sep 2022 16:30:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] interconnect: qcom: Add the missing MODULE_LICENSE
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220913062721.5986-1-quic_hyiwei@quicinc.com>
 <YyAscuyA1pKmEDH1@leoy-huanghe.lan>
From:   Huang Yiwei <quic_hyiwei@quicinc.com>
In-Reply-To: <YyAscuyA1pKmEDH1@leoy-huanghe.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kZ0qYjRfOzWM_JtfJj3mPj59HAaMiCKR
X-Proofpoint-ORIG-GUID: kZ0qYjRfOzWM_JtfJj3mPj59HAaMiCKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_03,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=836 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209130038
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 9/13/2022 Tue 15:08, Leo Yan wrote:
> Hi Yiwei,
> 
> On Tue, Sep 13, 2022 at 02:27:21PM +0800, Huang Yiwei wrote:
>> Since icc-common.c can be compiled as module, add the missing
>> MODULE_LICENSE to avoid compile errors.
> 
> Just curious how you can enable config INTERCONNECT_QCOM as "m"
> (module)?
> 
> I checked the config INTERCONNECT_QCOM which is dependent on
> INTERCONNECT, and INTERCONNECT has below dependency:
> 
>    - DRM_TEGRA [=n] && HAS_IOMEM [=y] && (ARCH_TEGRA [=y] || ARM && COMPILE_TEST [=n]) && COMMON_CLK [=y] && DRM [=m] && OF [=y]
>    - TEGRA_MC [=n] && MEMORY [=y] && (ARCH_TEGRA [=y] || COMPILE_TEST [=n] && COMMON_CLK [=y])
> 
> Seems to me, it's impossible to enable INTERCONNECT as "m" because the
> dependency ARCH_TEGRA/OF/COMMON_CLK cannot be configured as "m".
> 
> Thanks,
> Leo
> 
Found the problem, INTERCONNECT_QCOM is modified to tristate internally
so we can compile it as a module, and the new added icc-common.c uses
INTERCONNECT_QCOM config to compile, then cause the problem. So shall we
change INTERCONNECT_QCOM config to tristate?

Thanks,
Yiwei
