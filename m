Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220D764E5F8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 03:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiLPCZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 21:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLPCZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 21:25:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A2A3D394;
        Thu, 15 Dec 2022 18:25:31 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG2KwNM022197;
        Fri, 16 Dec 2022 02:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h+BBl5E3nTO96dKQjtNwWhXFbNBo6P8F9L3AZagn8aM=;
 b=oEALiZAg//kadKitpJ0kNuv/m4bBFafW49yGlG4uKOJwTLEMwKgt26sEtM9O+4LjzX4O
 qd398aNfa64nTs3TxZlXqTb5LIK2yHjgIvJa6nlhDfaqAT3Y5JWXdhMmzycyKTUdf2HH
 kJeY+ciNo538w0v1eSzdT27KKISfc3cVRk1u4DdAdz8IRxb+K1mscY3AY06o1HhnXm8m
 k8pol6tuxXT0rY1Cfhv3V8w3tN0qDFca6XCIJp/d26To4QYlpp9NijWEk/2gWvUhlWZM
 OZJRon0Ctj28SBmEj0JDRvi919z2va5v6VdyUnE43fnxhkmU+VAiAxEMXz6PcyPEmRqG eQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg2892uad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 02:25:15 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BG2PELv004345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 02:25:14 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 15 Dec
 2022 18:25:14 -0800
Message-ID: <f0f4243f-4cbe-0aa2-19b6-047d791207ab@quicinc.com>
Date:   Thu, 15 Dec 2022 18:25:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 10/20] gunyah: rsc_mgr: Add resource manager RPC core
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
References: <20221121140009.2353512-1-quic_eberman@quicinc.com>
 <20221121140009.2353512-11-quic_eberman@quicinc.com>
 <Y3uYRvrCZNnbDiY5@kroah.com>
 <425a8fe9-24b6-26c7-9150-0d3fb76430be@quicinc.com>
 <Y5gbFhVpuDoZ2ZmY@kroah.com>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y5gbFhVpuDoZ2ZmY@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zdJLKuQ4S6s_49WrXNiwwti2L0ZCD5zo
X-Proofpoint-ORIG-GUID: zdJLKuQ4S6s_49WrXNiwwti2L0ZCD5zo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_12,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=719
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212160021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2022 10:26 PM, Greg Kroah-Hartman wrote:
> On Mon, Dec 12, 2022 at 03:46:53PM -0800, Elliot Berman wrote:
>>
>> Reference counting is not needed on the gh_rm_rpc object because its only
>> client (the VM manager) is torn down before the gh_rm_rpc.
> 
> So again, who controls the lifecycle of it?  Where is the reference
> count for the structure as it is pointing to reference counted memory?

Had some internal review and I think I'm now taking better care of this 
(and the device situation in the other mail). I will send out next 
revision soon.

In summary:

  - Incrementing platform device's refcount when creating a new VM since 
it spawns new file descriptor that could remain open after closing the 
main miscdevice.
  - Re-organizing vm_manager so it is much more like a library than a 
separate device.

Thanks,
Elliot
