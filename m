Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC7689237
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjBCIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjBCIXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:23:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6389B701;
        Fri,  3 Feb 2023 00:21:43 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3135HX2b017013;
        Fri, 3 Feb 2023 08:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vGCDi8mazy8C2ArRV8P4USNLAvgRgQFuyX5QpQr8bXI=;
 b=JD7lBvVRfUiWpb7ra75gvs1SS70jJvuY17QPkdPaoCY5hA5ywIc9Vz/XpmADZWJG5ikf
 1cmjisa80G2Rd6aIJABY/F+CiF5L+TSmb+h/XBtiLuxwl3kpWb+0BnPCIiKdJOcc+Dke
 t4+fuoRRGiAQpwbnxGF15qlH5BqpYLD4/44BYVeW5Jc5Cs1lhZl92u+R8k2cVviND4WF
 IYp6bTbCCKcRH+ueS+PZwUJcSYiEboKCBkfSOv6v7vkKOQb/T5t5mYkxr9Y08ZMz3qRR
 FHBPXTG4zJmMOHrGaRRQMhdzjoTmqyNBSZ28pw80zWmYvz2i+zVnBesyW2t71c9uV26U 0w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ngahqtme9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 08:20:42 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3138Kfnh013369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 08:20:41 GMT
Received: from [10.216.62.140] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 00:20:37 -0800
Message-ID: <d2af0b0c-718a-a625-3630-05631d0e310c@quicinc.com>
Date:   Fri, 3 Feb 2023 13:50:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 1/2] dt-bindings: ramoops: Add support to get the
 region dynamically
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <corbet@lwn.net>
References: <1675330081-15029-1-git-send-email-quic_mojha@quicinc.com>
 <20230202235916.GA2931100-robh@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230202235916.GA2931100-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m_x_UGIBt3jvA9wc_qwpE2Y9If-Y-5vC
X-Proofpoint-GUID: m_x_UGIBt3jvA9wc_qwpE2Y9If-Y-5vC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=747 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302030076
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2023 5:29 AM, Rob Herring wrote:
> On Thu, Feb 02, 2023 at 02:58:00PM +0530, Mukesh Ojha wrote:
>> The reserved memory region for ramoops is assumed to be at a
>> fixed and known location when read from the devicetree. This
>> is not desirable in an environment where it is preferred the
>> region to be dynamically allocated at runtime, as opposed to
>> being fixed at compile time.
>>
>> So, update the ramoops binding by using some reserve memory
>> property to allocate the ramoops region dynamically.
> 
> Sorry, but I still don't think this belongs in DT as I commented on v4
Do you mean, we should not even document this here ? or are you against 
the size property mentioned in this patch.

-Mukesh
