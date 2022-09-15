Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F95B922C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiIOBdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIOBds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:33:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922C792DE;
        Wed, 14 Sep 2022 18:33:44 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F0ZueQ017536;
        Thu, 15 Sep 2022 01:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LRBFs3XrfWaoGBTNqSmEzJ2c04tlJ8Rh82eU+9eVUuw=;
 b=CwLYmIockp2hO1HIFAmLCwql+ZIz8z79i7hCI1ceXHtX9LT8mlv9Y2vkMxBR2texMvL9
 m5u67dlx/JJjuUTe75kta+ZQEV9StCCW/J8KPBFhpRK/Foo7wlrgd//7giu4Pptb/Ffp
 uqwbvJvmxpdGDsU5WCaGncSj/tqC1dnFndiQK58hz+vjSpLfvCsVr9OE7abtGwf9hwt/
 ddhaB+HMixJXtTgTQ27Cr7uAL8c+ojHR1Dd8QWClv+8DftUR5Ziv2HfFnM4ucXspLLvm
 i1k2h/gOD97gjMn1iM0ebvqiZFdtjUcSuHCKUqkZueTZBzABIOdxucLdSJy3Vf4z2x4j JQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jkp8arh6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 01:33:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28F1XAPk023301
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 01:33:11 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 18:33:07 -0700
Subject: Re: [PATCH 2/2] mailbox: Add support for QTI CPUCP mailbox controller
To:     Trilok Soni <quic_tsoni@quicinc.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>,
        Gaurav Kohli <gkohli@codeaurora.org>
References: <1663135386-26270-1-git-send-email-quic_sibis@quicinc.com>
 <1663135386-26270-3-git-send-email-quic_sibis@quicinc.com>
 <b8e0cbb4-8d4e-1208-0fa0-8f9178b6d85f@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <04d046aa-59c8-46c5-d957-5d2e48f25d72@quicinc.com>
Date:   Thu, 15 Sep 2022 07:03:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b8e0cbb4-8d4e-1208-0fa0-8f9178b6d85f@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aVU5gjC4oydM2V8ZopPTFBLGNHmETNjq
X-Proofpoint-ORIG-GUID: aVU5gjC4oydM2V8ZopPTFBLGNHmETNjq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_11,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=794
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150002
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Trilok,
Thanks for taking time to review the patch.

On 9/14/22 11:08 PM, Trilok Soni wrote:
> Hi Sibi,
> 
>> +
>> +MODULE_AUTHOR("Gaurav Kohli <gkohli@codeaurora.org>");
>> +MODULE_AUTHOR("Sibi Sankar <quic_sibis@qti.qualcomm.com>");
> 
> Email address should be quic_sibi@quicinc.com.
> 
> codeaurora.org is any way deprecated, so we should we keep it ? I know 
> giving the credit is important, but above address will not be reachable 
> anyways.
Ack my bad.

> 
> ---Trilok Soni
