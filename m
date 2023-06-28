Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61334741636
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjF1QUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:20:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131]:17472 "EHLO
        mx0a-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231652AbjF1QUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:20:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SDtUVW018875;
        Wed, 28 Jun 2023 16:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EwVDj7xAWxMaQin2z34o8A2NmK4g7lRRidATpk7p6xA=;
 b=S9Ni0/QzzFh/cejWqPDW+NzQo7AgGrCBD+7x91tqrmPayMunWSJY91L9dMDYQlwpWwhY
 S4bLiFjFe9U0BnxbA7BEzhrgxPBWfn8MM9QKsMiJdVuQgvu+xNie06YXYNZ+EHbwvaIf
 ZfPX2rETz1dtQ9zPJ58B5FgSsi9GFgTIkeC0IzbVUEgsjG0UmGmTkMitVfW37HX7OWVp
 Lo4n3fq6/c+GO1eHGtFS0K+rzcglDvwhaC/kf8BasEx/MNWQ1gjDFCOq6fsWjbZa8i62
 CknK4g4h5YnSWcShVYT0gYeuu1/FN7eYPX/SYZE8PI3iLJDMKpYWTfUv9C7nTzBsN7qV eg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg21tb128-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 16:20:17 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SGKH3B021301
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 16:20:17 GMT
Received: from [10.216.26.159] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 28 Jun
 2023 09:20:05 -0700
Message-ID: <10dd2ead-758a-89f0-cda4-70ae927269eb@quicinc.com>
Date:   Wed, 28 Jun 2023 21:50:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <2023062814-chance-flounder-f002@gregkh>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <2023062814-chance-flounder-f002@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4bKvRVyoEnkrTkaXXrIlB4hO_M8fRGoE
X-Proofpoint-GUID: 4bKvRVyoEnkrTkaXXrIlB4hO_M8fRGoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_11,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=728 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/2023 9:15 PM, Greg KH wrote:
> On Wed, Jun 28, 2023 at 06:04:27PM +0530, Mukesh Ojha wrote:
>> Minidump is a best effort mechanism to collect useful and predefined data
>> for first level of debugging on end user devices running on Qualcomm SoCs.
>> It is built on the premise that System on Chip (SoC) or subsystem part of
>> SoC crashes, due to a range of hardware and software bugs. Hence, the
>> ability to collect accurate data is only a best-effort. The data collected
>> could be invalid or corrupted, data collection itself could fail, and so on.
>>
>> Qualcomm devices in engineering mode provides a mechanism for generating
>> full system ramdumps for post mortem debugging. But in some cases it's
>> however not feasible to capture the entire content of RAM. The minidump
>> mechanism provides the means for selecting which snippets should be
>> included in the ramdump.
>>
>> Minidump kernel driver implementation is divided into two parts for
>> simplicity, one is minidump core which can also be called minidump
>> frontend(As API gets exported from this driver for registration with
>> backend) and the other part is minidump backend i.e, where the underlying
>> implementation of minidump will be there. There could be different way
>> how the backend is implemented like Shared memory, Memory mapped IO
>> or Resource manager(gunyah) based where the guest region information is
>> passed to hypervisor via hypercalls.
>>
>>      Minidump Client-1     Client-2      Client-5    Client-n
>>               |               |              |             |
>>               |               |    ...       |   ...       |
>>               |               |              |             |
>>               |               |              |             |
>>               |               |              |             |
>>               |               |              |             |
>>               |               |              |             |
>>               |               |              |             |
>>               |           +---+--------------+----+        |
>>               +-----------+  qcom_minidump(core)  +--------+
>>                           |                       |
>>                           +------+-----+------+---+
>>                                  |     |      |
>>                                  |     |      |
>>                  +---------------+     |      +--------------------+
>>                  |                     |                           |
>>                  |                     |                           |
>>                  |                     |                           |
>>                  v                     v                           v
>>       +-------------------+      +-------------------+     +------------------+
>>       |qcom_minidump_smem |      |qcom_minidump_mmio |     | qcom_minidump_rm |
>>       |                   |      |                   |     |                  |
>>       +-------------------+      +-------------------+     +------------------+
>>         Shared memory              Memory mapped IO           Resource manager
>>          (backend)                   (backend)                   (backend)
>>
>>
>> Here, we will be giving all analogy of backend with SMEM as it is the
>> only implemented backend at present but general idea remains the same.
> 
> If you only have one "backend" then you don't need the extra compexity
> here at all, just remove that whole middle layer please and make this
> much simpler and smaller and easier to review and possibly accept.
> 
> We don't add layers when they are not needed, and never when there is no
> actual user.  If you need the extra "complexity" later, then add it
> later when it is needed as who knows when that will ever be.
> 
> Please redo this series based on that, thanks.

I already followed without this middle layer till v3 since without
the middle layer it will be end up with lot of code duplication if there
is another backend.

We already have other backend implementation in the downstream, if you
want to see them, i will try to post them in upcoming series..

-Mukesh

> 
> greg k-h
