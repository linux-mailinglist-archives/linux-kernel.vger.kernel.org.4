Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988636AC4FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCFP3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCFP3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:29:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B202022DF9;
        Mon,  6 Mar 2023 07:28:48 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326EFXOl029637;
        Mon, 6 Mar 2023 15:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gj/5qssEk3LgrGAJ6YpdyJPq7RIt01JbXP10LSwuQfs=;
 b=m8R58hh+iUKa7w2pd1lXGeOW+pa4/BA6YO8+JfDYd4WvnepU01cMJ5I0HxWioswKpQYf
 SLAXyYgytzxyahaoIsn5D73VXwnHeA81QFFmtg6vk2ebW0A8QOewu44CKUVZNxfxTDvU
 uLDPVsJ5yBLvKRVcGrALF6F1lDOuMOaozWdlLVZZbEaopmDFRgLXUR9fmYLJ/S534aUN
 SljOJRXh4fFI0aslGkBtXQgvDMpDEQ6C+IvBX9gb9vsVa1sIXOTrXXt9snbMzg9oVOlU
 +Ae/FUNMvMornXSZOm498OtoTIO6qReIpjZxC9hpsWL+PCtRLCqa7Vv1UVF6qkOult6G PA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p417jw3uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 15:28:14 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326FSDnQ007388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 15:28:13 GMT
Received: from [10.216.63.59] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 07:28:09 -0800
Message-ID: <8f3c6bea-ee49-dc0e-7491-19714b97255a@quicinc.com>
Date:   Mon, 6 Mar 2023 20:58:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 0/6] Add basic Minidump kernel driver support
Content-Language: en-US
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i9Ag_dKQwXO2KWgJhTZgOwgdkuXVBBVb
X-Proofpoint-ORIG-GUID: i9Ag_dKQwXO2KWgJhTZgOwgdkuXVBBVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly review reminder..

-Mukesh

On 2/21/2023 4:55 PM, Mukesh Ojha wrote:
> Minidump is a best effort mechanism to collect useful and predefined data
> for first level of debugging on end user devices running on Qualcomm SoCs.
> It is built on the premise that System on Chip (SoC) or subsystem part of
> SoC crashes, due to a range of hardware and software bugs. Hence, the
> ability to collect accurate data is only a best-effort. The data collected
> could be invalid or corrupted, data collection itself could fail, and so on.
> 
> Qualcomm devices in engineering mode provides a mechanism for generating
> full system ramdumps for post mortem debugging. But in some cases it's
> however not feasible to capture the entire content of RAM. The minidump
> mechanism provides the means for selecting which snippets should be
> included in the ramdump.
> 
> The core of minidump feature is part of Qualcomm's boot firmware code.
> It initializes shared memory (SMEM), which is a part of DDR and
> allocates a small section of SMEM to minidump table i.e also called
> global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
> their own table of segments to be included in the minidump and all get
> their reference from G-ToC. Each segment/region has some details like
> name, physical address and it's size etc. and it could be anywhere
> scattered in the DDR.
> 
> Existing upstream Qualcomm remoteproc driver[1] already supports minidump
> feature for remoteproc instances like ADSP, MODEM, ... where predefined
> selective segments of subsystem region can be dumped as part of
> coredump collection which generates smaller size artifacts compared to
> complete coredump of subsystem on crash.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/remoteproc/qcom_common.c#n142
> 
> In addition to managing and querying the APSS minidump description,
> the Linux driver maintains a ELF header in a segment. This segment
> gets updated with section/program header whenever a new entry gets
> registered.
> 
> Patch 1/6 is very trivial change.
> Patch 2/6 moves the minidump specific data structure and macro to
>   qcom_minidump.h so that (3/6) minidump driver can use.
> Patch 3/6 implements qualcomm minidump kernel driver and exports
>   symbol which other minidump kernel client can use.
> Patch 4/6 enables the qualcomm minidump driver.
> Patch 5/6 Use the exported symbol from minidump driver in qcom_common
>   for querying minidump descriptor for a subsystem.
> Patch 6/6 Register pstore region with minidump.
> 
> Testing of the patches has been done on sm8450 target with the help
> of out of tree patch which helps to set the download mode and storage
> type(on which dump will be saved) for which i will send separate series.
> 
> Mukesh Ojha (6):
>    remoteproc: qcom: Expand MD_* as MINIDUMP_*
>    remoteproc: qcom: Move minidump specific data to qcom_minidump.h
>    soc: qcom: Add Qualcomm minidump kernel driver
>    arm64: defconfig: Enable Qualcomm minidump driver
>    remoterproc: qcom: refactor to leverage exported minidump symbol
>    pstore/ram: Register context with minidump
> 
>   arch/arm64/configs/defconfig     |   1 +
>   drivers/remoteproc/qcom_common.c |  75 +-----
>   drivers/soc/qcom/Kconfig         |  14 ++
>   drivers/soc/qcom/Makefile        |   1 +
>   drivers/soc/qcom/qcom_minidump.c | 490 +++++++++++++++++++++++++++++++++++++++++
>   fs/pstore/ram.c                  |  77 ++++++
>   include/soc/qcom/minidump.h      |  40 ++++
>   include/soc/qcom/qcom_minidump.h |  88 +++++++
>   8 files changed, 717 insertions(+), 69 deletions(-)
>   create mode 100644 drivers/soc/qcom/qcom_minidump.c
>   create mode 100644 include/soc/qcom/minidump.h
>   create mode 100644 include/soc/qcom/qcom_minidump.h
> 
