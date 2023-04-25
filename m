Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DC46EE38D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjDYOCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjDYOCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:02:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE5CC1E;
        Tue, 25 Apr 2023 07:01:58 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P7ddLL010956;
        Tue, 25 Apr 2023 14:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5sDebuCS3ZY67b7mDVj0PQsBdF0GrchmOu0ms0J8w1o=;
 b=ZaenPkSbN452uWmhDMtuFXccPDgXFmPH/Hn69jzr+wGoNw9tcrJpKtr56t/MWcMe/TJL
 2jFvUZoCA8r5HpF8dG7vA0ULihEY2fAsGL6RdlWi6mGsPwQGhcNnVtBTHwE4b5FHbP3Q
 4DOoW3Xlbu1NK8jkDkRdxplMkNy+BofDI8Cm+BPehsVqYV3S4wR7qYdz7wpCXg4pChFk
 v4MfaMrdd0MoO0pNL0BT+tbG7g/31EqQ6xON4hSWh8ZltYhhaeEETmeUENssV6po5YZe
 /r1MJ13ODJBM4nZc53kfnpLyjO+gr8/Ziqz0SeMGpAxYtDriCjRVZiVuTL35pXJAMhW9 Qg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q6an20yut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 14:01:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33PE1ibB025297
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 14:01:44 GMT
Received: from [10.110.33.34] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 25 Apr
 2023 07:01:44 -0700
Message-ID: <e5f7ba28-65b8-30f4-78e6-b3e242054110@quicinc.com>
Date:   Tue, 25 Apr 2023 07:01:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/2] Allow parameter in smc/hvc calls
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230418185659.29745-1-quic_nkela@quicinc.com>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20230418185659.29745-1-quic_nkela@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8bEMc0AuzzmYFdmo7xf8W5XaWumZOJie
X-Proofpoint-ORIG-GUID: 8bEMc0AuzzmYFdmo7xf8W5XaWumZOJie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=778 bulkscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250126
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep, could you please review v4 patches. Thanks!


On 4/18/2023 11:56 AM, Nikunj Kela wrote:
> Currently, smc/hvc calls are made with parameters set
> to zeros. We are using multiple scmi instances within
> a VM. We are sharing the same smc-id(func_id) with all
> scmi instance. The hypervisor needs a way to distinguish
> among hvc calls made from different instances.
>
> This patch series introduces new compatible string which
> can be used to pass shmem channel address as parameters
> to smc/hvc calls.
>
> ---
> v4 -> split shmem address into 4KB-pages and offset
>
> v3 -> pass shmem channel address as parameter
>
> v2 -> fix the compilation erros on 32bit platform(see below)
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202304100606.kUjhsRYf-lkp@intel.com/
>
> v1 -> original patches
>
> Nikunj Kela (2):
>    dt-bindings: firmware: arm,scmi: support for parameter in smc/hvc call
>    firmware: arm_scmi: Augment SMC/HVC to allow optional parameters
>
>   .../devicetree/bindings/firmware/arm,scmi.yaml     |  8 +++++++-
>   drivers/firmware/arm_scmi/driver.c                 |  1 +
>   drivers/firmware/arm_scmi/smc.c                    | 14 +++++++++++++-
>   3 files changed, 21 insertions(+), 2 deletions(-)
>
