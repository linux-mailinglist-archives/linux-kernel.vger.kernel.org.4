Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB11F6A4BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjB0Tzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjB0Tzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:55:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7521010C6;
        Mon, 27 Feb 2023 11:55:24 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RAWVRG029618;
        Mon, 27 Feb 2023 19:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yyjtWLIykwqWbnASTfX43OiaKw6JvPDkF5rJFcQ8zwk=;
 b=e0ArFJwK/+I5veR/aap9UJRjpjVCH0eWS/5JqZ3IngEqgwEpOEfu4GzxPNbTxNXVmTWa
 Ccn1XxQxMHQRSWCXPjGnqFq9KKwUyiPu5v++KJKYEIHAQRA/LInsERbY1DeU7cOBx2Yt
 z3M2CndJSACFEou4pJoLfTwO9Y5GG3dHssHxODDy680jMk6l/yl409zzwLs/384WaqDD
 sHk5sWpk9yhvunKyRZGG7MHjuzSEGLH06nlHjOBZHO8vH40TtZFSa4HnyisER48ksURE
 sVGmpeSOpbpToAgc69QlmQK+rqL/DSFl9r5A/0HXEmTdNiMbm6sDbMB40jKctZxp9Mko 8w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nyajax123-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 19:54:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31RJswh7021960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 19:54:58 GMT
Received: from [10.110.56.105] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Feb
 2023 11:54:57 -0800
Message-ID: <877d045b-59ad-1e77-1527-e1b2a7e3c331@quicinc.com>
Date:   Mon, 27 Feb 2023 11:54:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 0/1] Add trace events for remoteproc
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230224165142.17745-1-quic_gokukris@quicinc.com>
 <20230227193620.hzrlt3e5vh5xz74v@ripper>
Content-Language: en-US
From:   Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
In-Reply-To: <20230227193620.hzrlt3e5vh5xz74v@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _hhGIkzjX_zj8O687bKRf0192BvCf4mG
X-Proofpoint-ORIG-GUID: _hhGIkzjX_zj8O687bKRf0192BvCf4mG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_17,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=768
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270157
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/2023 11:36 AM, Bjorn Andersson wrote:
> On Fri, Feb 24, 2023 at 08:51:41AM -0800, Gokul krishna Krishnakumar wrote:
>> This patch attempts to add traces for important remoteproc events,
>> this will help in debugging errors with the subsystem restart and
>> also helps in getting an estimate on how long each event takes to run.
>>
> 
> Please skip sending cover-letters for single patches. Also, this is the
> kind of motivation that should be included in the commit message.
> 
> Thanks,
> Bjorn
> 
Thanks Bjorn, Moving this to the commit text.
>> Gokul krishna Krishnakumar (1):
>>    remoteproc: qcom: Add remoteproc tracing
>>
>>   drivers/remoteproc/Makefile           |  3 ++-
>>   drivers/remoteproc/qcom_common.c      | 25 +++++++++++++++++++
>>   drivers/remoteproc/qcom_q6v5.c        |  3 +++
>>   drivers/remoteproc/qcom_q6v5_pas.c    | 17 +++++++++++++
>>   drivers/remoteproc/qcom_sysmon.c      | 13 ++++++++++
>>   drivers/remoteproc/qcom_tracepoints.c | 10 ++++++++
>>   include/trace/events/rproc_qcom.h     | 36 +++++++++++++++++++++++++++
>>   7 files changed, 106 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/remoteproc/qcom_tracepoints.c
>>   create mode 100644 include/trace/events/rproc_qcom.h
>>
>>
>> base-commit: 7c855ef7137a67bcff0e039691b969428dd8ef6a
>> -- 
>> 2.39.2
>>
Thanks,
Gokul
