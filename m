Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51BB6DE277
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjDKR0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjDKRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:25:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACBE130;
        Tue, 11 Apr 2023 10:25:33 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BHCn6H024948;
        Tue, 11 Apr 2023 17:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aTlxtwTluZLV4/fm2feyiw/YtayFgYCk75sK6pXIdm0=;
 b=A3uF/88Y0mxz2set/w9FY87lc66cEByizAJQbX8myO42VvrbTHK2bSwrFUuIDvrHyutk
 i+2TEz54losTlhRiDQb0frhcqoMI5PAdx2TlKZxPqKSQC8z0A36jhzW/hKye8sX9V8Xz
 OIXqDOr+n8tPrBv83UhO8AS5zDxG8CeBG8CT7FwgkA0+tX1cORibb69obFh0s+i39s/0
 7zFkGwrGJ9IUYVxp6NvS1mizbeIgLk6LzBQIwRS9dX/9Qq+jdr/mYkbINfaaphVpKGoM
 FoUlLm0jhTeceESRjfenh2J7o3PjcIxe+vF6+Tm0u6t9X5AUpAKsNGzODlJA/2taVIXC Ag== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvj1kude6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 17:25:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BHPMIW003432
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 17:25:22 GMT
Received: from [10.110.88.83] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 10:25:21 -0700
Message-ID: <823f6057-7fc5-4600-e078-a2d04e82db3e@quicinc.com>
Date:   Tue, 11 Apr 2023 10:25:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: support parameter
 passing in smc/hvc
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230410182058.8949-1-quic_nkela@quicinc.com>
 <20230410182058.8949-2-quic_nkela@quicinc.com>
 <85d61b1a-2017-cab5-8a6c-71714aecb455@linaro.org>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <85d61b1a-2017-cab5-8a6c-71714aecb455@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1j2xR3GP6wvQgXydf9FtNMM1pNURhw6V
X-Proofpoint-ORIG-GUID: 1j2xR3GP6wvQgXydf9FtNMM1pNURhw6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_11,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=897 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110159
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/2023 10:18 AM, Krzysztof Kozlowski wrote:
> On 10/04/2023 20:20, Nikunj Kela wrote:
>> Currently, smc/hvc calls are made with smc-id only. The parameters are
>> all set to zeros. This patch defines two optional device tree bindings,
>> that can be used to pass parameters in smc/hvc calls.
>>
>> This is useful when multiple scmi instances are used with common smc-id.
>>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> Since you sent v2 before our discussion finished, let me answer here:
> this does not look like property for DT. Do not send new patches without
> giving reviewers chance to respond.
Ok. My rationale on that is, if we allow smc-id which goes in r0/w0/x0 
registers in smc/hvc call to be part of dtb, then we should allow 
parameters which go in r1/w1/x1 to r6/w6/x6 register to be part of dtb. 
If you have an alternative suggestion, I am all ears!
> Best regards,
> Krzysztof
>
