Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CA374E65B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGKFcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGKFcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:32:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D5C134;
        Mon, 10 Jul 2023 22:32:10 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B53qBL023938;
        Tue, 11 Jul 2023 05:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=m/CC5OB0w71/IgL8c8C7UM203werPDp0QoX4/Uvu5Jc=;
 b=Le53YbwOg/otVxIZhSejurIBnulnt7WtP7wWstCvf7fHAKQ8kG8r5J89QmkEmI98M3s6
 zjWQ+j0MKE9NerYF3E4ROwRTfijgW6s4dx6ivkiMOwMZUA5AmtEIxvEr8eBbRbBi8+lT
 sQ5BKwZhrbQEzMyZfOtPfo3XZOVfcxXiNQPLVFYqE3JUckbKYTdtywMWD7EGCexjBI4f
 Ih8L/7LTqPhgNO9IhH3bBHt/CcMfdwKQa/yxQ9PLwkyCw7XOcIPYEcOsttc583JYv4VZ
 7AbvmnUy6W13wf3Su2/eBCLICujBDJDBtyEqGlUT1k4tilTykX10nXPWOHg0VowiGV5s qA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs0kpg1b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 05:31:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B5VIjW024546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 05:31:18 GMT
Received: from [10.50.43.38] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 22:31:14 -0700
Message-ID: <de6a5d53-4b69-8dc9-648b-aa3f6ff772ac@quicinc.com>
Date:   Tue, 11 Jul 2023 11:00:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V7 0/2] firmware: Add support for boot_stats
To:     Brian Masney <bmasney@redhat.com>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1688533340.git.quic_schowdhu@quicinc.com>
 <ZKwhwUnKR7vqQZms@brian-x1>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <ZKwhwUnKR7vqQZms@brian-x1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SbiCwzJyJJ0oeB5LrmC2A6lA_byGY6BT
X-Proofpoint-ORIG-GUID: SbiCwzJyJJ0oeB5LrmC2A6lA_byGY6BT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=754 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110048
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/2023 8:50 PM, Brian Masney wrote:
> On Wed, Jul 05, 2023 at 11:02:30AM +0530, Souradeep Chowdhury wrote:
>> Qualcomm's proprietary Android boot-loaders capture boot time
>> stats, like the time when the bootloader started execution and at what
>> point the bootloader handed over control to the kernel etc. in the IMEM
>> region. This information is captured by the bootloader and populated on
>> the device tree properties "pre-abl-time" and "abl-time" which can be
>> be viewed from the user space like as follows:-
>>
>> /sys/firmware/devicetree/base/bootstats # cat abl_time
>> 17898
>>
>> As a part of this patch series added the bindings for boot-stats which
>> was suggested in the v6 of the series. The link for the same is as
>> follows:-
> 
> Should boot statistics be exposed to userspace through the qcom socinfo
> driver? I see that the socinfo v19 metadata has fields for the boot core
> and boot cluster [1], so boot timing wouldn't be out of place.

"Boot Cluster" and "boot core" are soc specific info which are fixed for 
a particular qcom soc recorded in smem region of memory. "Boot_stats" is
not a property of a soc as such, they are KPI measurements in the boot 
time path stored in the imem region. So I not sure if this is the right 
home for it.

> 
> Brian
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/qcom/socinfo.c#n572
> 
