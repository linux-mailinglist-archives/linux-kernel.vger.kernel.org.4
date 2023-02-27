Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC18A6A3F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjB0KQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjB0KQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:16:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D71F4AF;
        Mon, 27 Feb 2023 02:16:09 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R3t6k2018345;
        Mon, 27 Feb 2023 10:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9ULn6APhFpkbMZSaCjTHDmlWvN7u9qNdvH9HjL1FNu4=;
 b=bW/LDKdmCo1j8lSZjGLc1NqcWknH78lsZejNherre/HNcgSm5rqP8pMY6mbHjOFQhgRb
 +PAEZMC1xH09uX+nKW2Wli3CcgZ+utnEFvbmL3OXcW1qeYPiByHahDWdmzbxAi6fsdYf
 joIMoidw0PqQycOb6LjtPz01fQM5qlyqu8Q7c0ZpPPXNt3TECdxBR6GWaT3KDi+5yDgn
 MVW/6eP9V+s/VTCiQOsscsW9IsQT3xX/LVtYZIpFOSAIlJGNmqDq94WKDzvLM+y0Wqz/
 b2dOYQVz+TfH73ouBeMKpVysYXmCBK3Tdvc5lkOjicmOMU32omyyGNNyUsVOq33iMMFq hg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ny9a0vre7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:15:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31RAFi26009729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:15:44 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Feb
 2023 02:15:40 -0800
Message-ID: <14b11c3c-353c-50f9-f9a4-837fc5d06fa4@quicinc.com>
Date:   Mon, 27 Feb 2023 15:45:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 0/6] Add basic Minidump kernel driver support
To:     Brian Masney <bmasney@redhat.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
 <Y/deHzijzvuvCJ2M@x1> <47542dbb-8cf3-6eae-a38e-910d38bd960b@quicinc.com>
 <Y/kKn9tnvSQ2Pacn@x1>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <Y/kKn9tnvSQ2Pacn@x1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KBHzKjGxe0aLYMo37AVUS3Ff5TaxFmUa
X-Proofpoint-GUID: KBHzKjGxe0aLYMo37AVUS3Ff5TaxFmUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270080
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/2023 12:36 AM, Brian Masney wrote:
> Hi Mukesh,
> 
> On Fri, Feb 24, 2023 at 04:10:42PM +0530, Mukesh Ojha wrote:
>> On 2/23/2023 6:07 PM, Brian Masney wrote:
>>> I'd like to test this series plus your series that sets the multiple
>>> download modes.
>>
>> Sure, you are welcome, but for that you need a device running with Qualcomm
>> SoC and if it has a upstream support.
> 
> I will be testing this series on a sa8540p (QDrive3 Automotive
> Development Board), which has the sc8280xp SoC with good upstream
> support. This is also the same board that I have a reliable way to
> make the board crash due to a known firmware bug.
> 


Can you try below patch to just select minidump download mode and make 
the device crash ?

--------------------------------------->8-------------------------------
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi 
b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0d02599..bd8e1a8 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -280,6 +280,7 @@
         firmware {
                 scm: scm {
                         compatible = "qcom,scm-sc8280xp", "qcom,scm";
+                       qcom,dload-mode = <&tcsr 0x13000>;
                 };
         };

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index cdbfe54..e1539a2 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -20,7 +20,7 @@

  #include "qcom_scm.h"

-static bool download_mode = 
IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
+static bool download_mode = true;
  module_param(download_mode, bool, 0);

  #define SCM_HAS_CORE_CLK       BIT(0)
@@ -427,7 +427,7 @@ static void qcom_scm_set_download_mode(bool enable)
                 ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
         } else if (__scm->dload_mode_addr) {
                 ret = qcom_scm_io_writel(__scm->dload_mode_addr,
-                               enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
+                               enable ? 0x20 : 0);
         } else {
                 dev_err(__scm->dev,
                         "No available mechanism for setting download 
mode\n");




>> Also, testing of this patch needs some minimal out of tree patches and
>> i can help you with that.
> 
> Yup, that's fine. Hopefully we can also work to get those dependencies
> merged upstream as well.
> 
> Brian
> 
