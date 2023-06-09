Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3F8728F05
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjFIEjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbjFIEjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:39:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C1230F1;
        Thu,  8 Jun 2023 21:39:35 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3594JVM3025898;
        Fri, 9 Jun 2023 04:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AdSf+nxOWU8wHe///6FcmZs/IpVxpxCPCP6es/Dvi1s=;
 b=CeYakn1JYqqFu+ge2bylCXj2PWPF4MPUqCsahlBLVzB12mgBE8bhO7h57mqJ0WaPaxV9
 eYl/Ubc+gInqNl186Z3FuNnOn84ztZkYeHoTHT7EEuqmP6tiVqlUkUTbwRfKqRsuV8bd
 98pmgUHbvTNM0abCJJTccRBis8AkkOe261IgnyEuYLWXNkWubjWuzfhznYokv0jhqUsI
 XeurOtecTpE+pICuLCxhkcF46Hr0NLhSjjOMgP0xidgXa5jefJyqE7+512Qb0mtd/2eZ
 jh4UTWKMkRuXDDM0+JVV81ITeMSx4OofDQYLghvwMbtYKQ+DFzx5AnOPl1R5H4jF/nZ6 Lw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r39kuae4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 04:39:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3594dUL9032544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 04:39:30 GMT
Received: from [10.216.3.169] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 21:39:27 -0700
Message-ID: <b95652b2-c93d-34b3-1d52-340f7590b857@quicinc.com>
Date:   Fri, 9 Jun 2023 10:09:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings: arm: idle-states: Add
 idle-state-disabled property
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_lsrao@quicinc.com>,
        <quic_mkshah@quicinc.com>, <devicetree@vger.kernel.org>
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
 <20230608085544.16211-2-quic_tnimkar@quicinc.com>
 <20230608-steadying-idealism-1f8a97db1491@wendy>
From:   Tushar Nimkar <quic_tnimkar@quicinc.com>
In-Reply-To: <20230608-steadying-idealism-1f8a97db1491@wendy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1pNJGaNN2yWtidvUjT0AUrC2_kIVTxfR
X-Proofpoint-ORIG-GUID: 1pNJGaNN2yWtidvUjT0AUrC2_kIVTxfR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_02,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=517 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090040
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Conor for reviewing.

On 6/8/2023 2:49 PM, Conor Dooley wrote:
> Hey Tushar,
> 
> On Thu, Jun 08, 2023 at 02:25:42PM +0530, Tushar Nimkar wrote:

> 
> Firstly, you should CC the dt-bindings maintainers like
> get_maintainer.pl would tell you.
> Secondly, there are two 1/2 patches in this series.
> 
1. Sure, I will include dt maintainer in next version.
2. Yes, one of the Patch 1/2 sent by mistake.
I will remove in next version.

> 
> Thirdly, this is operating system specific behaviour, tied to Linux, and
> has no place in a binding.
> 
3. I will remove [echo N > 
/sys/devices/system/cpu/cpuX/cpuidle/stateX/disable] command from 
bindings document.

> Cheers,
> Conor.
> 

Thanks,
Tushar
