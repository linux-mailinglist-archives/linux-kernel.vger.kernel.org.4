Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823B26DF921
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjDLOzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjDLOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:55:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B8D7D80;
        Wed, 12 Apr 2023 07:54:54 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CBlRdS008600;
        Wed, 12 Apr 2023 14:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QmBxSPgpcmcK/QVNrjAI65RRMerHngfc1aqP8vuhlMo=;
 b=SP1BKJziS57ya2czGwuZjw849nivcTfA7+dUHnI8DnnTe8aK6c+z53pOTijqoMvNA72D
 QJmU/kd12yvZ4f94uoy3/oCYd1jXKUX8Bz0HiO3QGvNQM3Gcyab56nJ8QLJxVIOFnawc
 FgZ5AaqN2x3ZVhhGsQj0wn9pt85IcsF1aHx/Aj4WnMoW4U+XV/WKpy7sx9YTjxlbduyi
 jZ4WS7B2CXbsEd614XOXl50ekpp51FLsTZkAbRbSvxzqGhzUcxXABxMASLjAy/ICj5ZK
 9UCJhOTjb4R7DlyW9hQj01XaNWkMd5H67LRcWQaxvRSYuYHlHMOk6j3cQw1USYVMD1S/ 5g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwsx68r4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 14:54:46 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CEsklD019579
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 14:54:46 GMT
Received: from [10.110.84.106] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 07:54:45 -0700
Message-ID: <5e11d4ee-75dc-31b8-432d-9aef3a38d885@quicinc.com>
Date:   Wed, 12 Apr 2023 07:54:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 0/2] Allow parameter in smc/hvc calls
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230410182058.8949-1-quic_nkela@quicinc.com>
 <20230411130136.lkblyfg3jaeitzrt@bogus>
 <ef3ae792-8900-d4c4-7fba-cbfc636a0315@quicinc.com>
 <20230412083723.r4vnkl3c7ykauzps@bogus>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20230412083723.r4vnkl3c7ykauzps@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uNETzF1YhKDaqCNrs_96gdohvaG2LGkJ
X-Proofpoint-ORIG-GUID: uNETzF1YhKDaqCNrs_96gdohvaG2LGkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_06,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120131
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/2023 1:37 AM, Sudeep Holla wrote:
> On Tue, Apr 11, 2023 at 07:42:50AM -0700, Nikunj Kela wrote:
>
>> that's a good suggestion. Any solution you propose shouldn't just limit to
>> only one parameter. IMO, there should be some way to pass all 6 parameters
>> since we do have a use case of at least two parameters.
> Please elaborate on your use-case.
Based on your comments below, we will change our hypervisor to make use 
of shmem.
>
>> The shmem proposal is fine however please also incorporate passing of other
>> parameters.
> You are missing the point here. SMC/HVC is just a doorbell and the main point
> I made earlier is that there is no need for vendors to try colourful things
> here if it is not necessary. So no, I don't want any extra bindings or more
> than one param is that is not needed. I will wait for the reason as requested
> above.
ok, understood. In that case, we will change our hypervisor to use shmem 
address as instance identifier. Please add support for one param, thanks!
