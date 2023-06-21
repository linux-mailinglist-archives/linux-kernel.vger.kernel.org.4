Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9794073866F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjFUOLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjFUOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:11:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F52E1FFD;
        Wed, 21 Jun 2023 07:10:40 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDGeik017878;
        Wed, 21 Jun 2023 14:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WgTBLUs1PWh6w65rKM7aa6Jgp86SJZJPAhgM7c6bdKU=;
 b=NXoGmondoY+xbBXy/M4UINPmFwJHJWwpCkH16m5jLABT7lTXefVFHqYxSGwQna2dXqHn
 gDFEnZhNfsMC7t8cBFbiWheZa8OpzdkbVY4P4l2ADsf1n2PyfihGDRyqSD32Cu9V7iQK
 A3yBBw7pY+ciaBMzVPZ7Zc7KulCDc0ms1u6ygsHgqn4VA/NHUeAneYLz+PdKjNXoHzWf
 6l8AeXwPChCPRbRD/zlvwep/mEQnHWRsQS91DuzkaEtvbQPXScPAHS03oHAA+GVj9hfT
 UtXgJoHVe5moq202pDxhelgYr36nIyklwPnQNaXTBVCptmMbnRl3D55HzYCVG1Fzjxbn kg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbvr1gvg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 14:10:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35LEAAks026035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 14:10:11 GMT
Received: from [10.111.161.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 21 Jun
 2023 07:10:09 -0700
Message-ID: <ee483022-3f1d-3e79-bbdb-71c22c48c73b@quicinc.com>
Date:   Wed, 21 Jun 2023 07:10:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RESEND v2] interconnect: drop unused icc_get() interface
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Johan Hovold <johan+linaro@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>
References: <20230523095248.25211-1-johan+linaro@kernel.org>
 <37dcbd3c-1e41-023c-8bbd-19cf9c9f151b@quicinc.com>
 <ZJK2Ki6--nLe8bK0@hovoldconsulting.com>
From:   Mike Tipton <quic_mdtipton@quicinc.com>
In-Reply-To: <ZJK2Ki6--nLe8bK0@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jf5X1Op7YajBCkjGMkubkCAg85GYu681
X-Proofpoint-ORIG-GUID: Jf5X1Op7YajBCkjGMkubkCAg85GYu681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=640 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210120
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/2023 1:34 AM, Johan Hovold wrote:
> On Tue, Jun 20, 2023 at 02:57:17PM -0700, Mike Tipton wrote:
>> On 5/23/2023 2:52 AM, Johan Hovold wrote:
>>> The icc_get() interface can be used to lookup an interconnect path based
>>> on global node ids. There has never been any users of this interface and
>>> all lookups are currently done from the devicetree.
>>>
>>> Remove the unused icc_get() interface.
>>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
>> We have downstream debug/test modules that removing icc_get() will
>> break. I'd like to get equivalent debug support in mainline, but until
>> then I'd prefer we not remove this.
> 
> I'm sure you've heard this before, but if it's not in mainline it does
> not count. We don't carry code upstream for the sole benefit of
> out-of-tree users.

Yeah, I understand that in general.

> 
>> I suspect having a mainline approach for voting paths from debugfs would
>> be useful to others as well. There are similar debugfs control
>> mechanisms in other frameworks already, e.g. clock.
>>
>> Instead of removing icc_get() immediately, can we wait for a future
>> patch series that adds debugfs as a consumer?
> 
> This function was merged over four years ago and has never been used in
> mainline and I doubt a user will suddenly show up in the near future if
> we were to keep it.

I guess I'm hoping if it's already been unused in mainline for four 
years, that we can keep it a little longer until the mainline debugfs 
user can be added.

We can prepare that series. Not entirely sure when it'll be ready, but 
can try to prioritize it.

> 
> I guess you can just carry one more patch out-of-tree until you can
> mainline a proper debugfs interface (which should probably not even use
> this function, as you mentioned yourself).
That's not really possible in this case. We're limited to our DLKMs 
running on top of the Android kernel. We can't modify the interconnect 
framework itself.

> 
> Johan
