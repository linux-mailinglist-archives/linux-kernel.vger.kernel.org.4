Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27970718D84
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjEaVuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjEaVuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:50:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4865E12F;
        Wed, 31 May 2023 14:50:20 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJ5M6w012658;
        Wed, 31 May 2023 21:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dUqD5IBa5ecMGFwx1vgmAf7YAQeqER/pA51g5co8ax4=;
 b=cJ5/pq3lr1vkwfykoD68B9L3j1DwP6K3GFwvnhOc8Hvk61FIqSY3HhUmtSx5MQoSWoUl
 t/N9lu6tPhQC2zjOvKSz+WLD6ikWgwvpL4dJTyFcF+m+TdVr6gMFSMexaF0KUv09tDSi
 mfvEzm9hKRdEn/UpHaJBDpYVlB6RGBX6upAibjlsxeFL+7p7dPwDogm4eaixPL6MSImV
 pKSpB9HrENNB6qUoc6iTzf4FRpB0gSm07hW9fp4R3mQQYrjakYnk3GT6O0GMjB2Mu0XW
 Ftao3dqlS7XJl1K9JYYc1dGUd4qDa8zY95ogOHLdMibmtjFyLEILULqXEG3l41B9KAAl 1g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwvt1tfas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 21:49:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VLnpnF025365
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 21:49:51 GMT
Received: from [10.71.110.156] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 14:49:50 -0700
Message-ID: <9ada3c21-45a3-582c-2cba-3a19a1e7cad5@quicinc.com>
Date:   Wed, 31 May 2023 14:49:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v4 0/2] Patches for introducing traces in remoteproc.
Content-Language: en-US
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <cover.1685486994.git.quic_gokukris@quicinc.com>
 <63da3282-6a94-3807-b23f-73c4c6111936@quicinc.com>
 <f69b6e5c-e6d6-b575-9e9c-6516a3dfe5e8@quicinc.com>
From:   Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
In-Reply-To: <f69b6e5c-e6d6-b575-9e9c-6516a3dfe5e8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ppnBtSPHz0xuZSXU-RbFWwa0UH8Yjj1l
X-Proofpoint-GUID: ppnBtSPHz0xuZSXU-RbFWwa0UH8Yjj1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=590
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310184
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2023 2:36 PM, Trilok Soni wrote:
> On 5/31/2023 2:35 PM, Trilok Soni wrote:
>> On 5/31/2023 2:28 PM, Gokul krishna Krishnakumar wrote:
>>> V4: Add config symbol REMOTEPROC_TRACEPOINTS to enable traces
>>>      Rename rproc_qcom.h to remoteproc_tracepoints.h
>>>      Rename qcom_tracepoints.c to remoteproc_tracepoints.c
>>>      Switch to EXPORT_SYMBOL_GPL
>>
>>
>> Any reasons you have not sent these patches to mailing list?
> 
> I don't see linux-arm-msm mailing list. Are you CCing all the required 
> lists and maintainers?
> 
> ---Trilok Soni
linux-arm-msm was not in the remoteproc lists(I have included everyone 
required), I will include the linux-trace-kernel as well from the next 
patch.

Thanks,
Gokul
