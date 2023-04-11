Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CDA6DDE53
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDKOnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjDKOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:43:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014422100;
        Tue, 11 Apr 2023 07:43:04 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BE27HU001769;
        Tue, 11 Apr 2023 14:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DYrTTsi6pmN9A94wPsFhth7vjrkUJf81SgSUfgeVBE8=;
 b=PPTXM4Jvkqm4uvWdgnTRGkVdpPur7zfgqYXkUzhh/7IdjJ498T0dy3hKKy2imiCqx+Ix
 mSEJAX2Vw96PJvJuYyRIqo0hA6JwsUbHqUNFgP2QdRoWmlqJEI31vwiV7nWG57kx0PJB
 au2sASskDWEMMf0Q/tZM2liQNu9KJGxzp/j6og+Qpvz8sy4104vCTcYko3rBhhTmdxt0
 T/T+TyxoQSmzD91XTg7kI6ywqE7sevPGvriIy30XUBt23Bf7+ak4GM5XgNACd42eMUfd
 9fpliZaGxpydrtKC+8RIElSF3jRGhmG80/KEUXojsW9m2S+e5Qq9x+k8zSzrIIuJ9AlP zA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pw4usgjay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 14:42:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BEgpaf007689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 14:42:51 GMT
Received: from [10.110.88.83] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 07:42:51 -0700
Message-ID: <ef3ae792-8900-d4c4-7fba-cbfc636a0315@quicinc.com>
Date:   Tue, 11 Apr 2023 07:42:50 -0700
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
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20230411130136.lkblyfg3jaeitzrt@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PU9PRoA4XNBy4Han5dNwok8o3_WkkY6X
X-Proofpoint-ORIG-GUID: PU9PRoA4XNBy4Han5dNwok8o3_WkkY6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_10,2023-04-11_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110134
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/2023 6:01 AM, Sudeep Holla wrote:
> On Mon, Apr 10, 2023 at 11:20:56AM -0700, Nikunj Kela wrote:
>> Currently, smc/hvc calls are made with parameters set
>> to zeros. We are using multiple scmi instances within
>> a VM and hypervisor associates a tag with each instance
>> and expects the tag in hvc calls from that instance, while
>> sharing the same smc-id(func_id) among the instances.
>>
>> This patch series introduces new optional dtb bindings which
>> can be used to pass parameters to smc/hvc calls.
>>
> Just to be sure that I understood the problem(as your 2 parameters confused
> me), this is just to help hypervisor/secure side to identify the right
> channel/shared memory when the same SMC/HVC function id is shared right ?
that's somewhat correct. Our hypervisor allocates 64bit ids on every 
boot for each scmi instance which it uses to identify the scmi instance. 
Additionally, our hypervisor also categorizes events within each 
instance by an event-id that gets passed to hvc call as second 
parameter. So we can pass two parameters in addition to function_id.
>
> If that is the case, why can't we just pass the shmem address as the
> parameter ? I would like to avoid fragmentation here with every vendor
> trying to do different things to achieve the same.
that's a good suggestion. Any solution you propose shouldn't just limit 
to only one parameter. IMO, there should be some way to pass all 6 
parameters since we do have a use case of at least two parameters.
>
> I would just change the driver to do that. Not sure if it breaks any existing
> implementation or not. If it does, we can add another compatible to identify
> one needing this fixed(shmem address) as additional parameter.
>
> Does that make sense at all ? Or am I missing some/all of the requirements
> here ?
The shmem proposal is fine however please also incorporate passing of 
other parameters.
>
