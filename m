Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA0743F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjF3QFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjF3QE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:04:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1441F10A;
        Fri, 30 Jun 2023 09:04:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UB80b3022110;
        Fri, 30 Jun 2023 16:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tky6m4fUf0fCfzuDZQBGDmIT+aFWsl+CwJAdAJ5dtR8=;
 b=eohuH3XVi7if6yQGxcXHvspndAdCdUC1K8wFPmmbx5Acv4mHVmtVJzXrQGzx2mcuS/VB
 8Nzmdq8gUwN03mlvmqFTV4FesVyo6e2Lxj9KHts14fJnOK7RPOxZW61/pEwcbCRbL5J8
 pidfbCDJVK8lxDW6ofo6c2JkQf0eGJ6hh/IdgQ0DXCFDJETCI2eUhTCKj71iwCjI8RKY
 ryQmZcTh4QHTDRVV5/xXIn/ekdohDiUXXn8z7DLhhJ2kLqVlOlHGzXpb88yaXVdpZ5qI
 9p3ksx4MiPxl5uuhC6Cc+76QdmxmruHkmc7tuNwgwUiMWbThFpBuQerIKOeKvjWUlMsY cw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhsycs6sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 16:04:22 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35UG4LHO028478
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 16:04:21 GMT
Received: from [10.216.37.216] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 30 Jun
 2023 09:04:12 -0700
Message-ID: <cc30660f-dd72-aade-6346-a93c6ad4b695@quicinc.com>
Date:   Fri, 30 Jun 2023 21:34:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <mathieu.poirier@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linus.walleij@linaro.org>,
        <andy.shevchenko@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <2023062814-chance-flounder-f002@gregkh>
 <CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xFGHRqPtPcAUiRgmUBFSReWrwDHZPxak
X-Proofpoint-GUID: xFGHRqPtPcAUiRgmUBFSReWrwDHZPxak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300137
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2023 4:42 AM, Rob Herring wrote:
> On Wed, Jun 28, 2023 at 9:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Wed, Jun 28, 2023 at 06:04:27PM +0530, Mukesh Ojha wrote:
>>> Minidump is a best effort mechanism to collect useful and predefined data
>>> for first level of debugging on end user devices running on Qualcomm SoCs.
>>> It is built on the premise that System on Chip (SoC) or subsystem part of
>>> SoC crashes, due to a range of hardware and software bugs. Hence, the
>>> ability to collect accurate data is only a best-effort. The data collected
>>> could be invalid or corrupted, data collection itself could fail, and so on.
>>>
>>> Qualcomm devices in engineering mode provides a mechanism for generating
>>> full system ramdumps for post mortem debugging. But in some cases it's
>>> however not feasible to capture the entire content of RAM. The minidump
>>> mechanism provides the means for selecting which snippets should be
>>> included in the ramdump.
>>>
>>> Minidump kernel driver implementation is divided into two parts for
>>> simplicity, one is minidump core which can also be called minidump
>>> frontend(As API gets exported from this driver for registration with
>>> backend) and the other part is minidump backend i.e, where the underlying
>>> implementation of minidump will be there. There could be different way
>>> how the backend is implemented like Shared memory, Memory mapped IO
>>> or Resource manager(gunyah) based where the guest region information is
>>> passed to hypervisor via hypercalls.
>>>
>>>      Minidump Client-1     Client-2      Client-5    Client-n
>>>               |               |              |             |
>>>               |               |    ...       |   ...       |
>>>               |               |              |             |
>>>               |               |              |             |
>>>               |               |              |             |
>>>               |               |              |             |
>>>               |               |              |             |
>>>               |               |              |             |
>>>               |           +---+--------------+----+        |
>>>               +-----------+  qcom_minidump(core)  +--------+
>>>                           |                       |
>>>                           +------+-----+------+---+
>>>                                  |     |      |
>>>                                  |     |      |
>>>                  +---------------+     |      +--------------------+
>>>                  |                     |                           |
>>>                  |                     |                           |
>>>                  |                     |                           |
>>>                  v                     v                           v
>>>       +-------------------+      +-------------------+     +------------------+
>>>       |qcom_minidump_smem |      |qcom_minidump_mmio |     | qcom_minidump_rm |
>>>       |                   |      |                   |     |                  |
>>>       +-------------------+      +-------------------+     +------------------+
>>>         Shared memory              Memory mapped IO           Resource manager
>>>          (backend)                   (backend)                   (backend)
>>>
>>>
>>> Here, we will be giving all analogy of backend with SMEM as it is the
>>> only implemented backend at present but general idea remains the same.
>>
>> If you only have one "backend" then you don't need the extra compexity
>> here at all, just remove that whole middle layer please and make this
>> much simpler and smaller and easier to review and possibly accept.
> 
> pstore already supports backends. Why aren't the above backends just
> pstore backends rather than having an intermediate pstore backend in
> RAM which then somehow gets moved into these minidump backends.

It can't be another pstore backend since, pstore backend(ram) is for
the system where there is a guarantees of fixed ram range content 
persist across boot, but that is not true with minidump, there is no
pstorefs kind of support with minidump.

Instead, the whole idea of backend/front-end of minidump here, is
entirely related to minidump and here minidump backend could be
anything like could be Shared memory in DDR which is shared across
multiple subsystem (CPUSS) is one of them or it could be something
where you want to collect minidump for a guest vm which guest
does not have access to backend instead it may be the hypervisor
do the register the region for the guest.

Pstore(ram) is one of the clients of minidump where, we want to collect
the console/pmsg/ftrace/dmesg logs for production devices where
DDR dump is difficult and the reason of doing this to not re-invent
the wheel and it just need physical address/size .

  +---------+     +---------+   +--------+     +---------+
  | console |     | pmsg    |   | ftrace |     | dmesg   |
  +---------+     +---------+   +--------+     +---------+
        |             |             |              |
        |             |             |              |
        +------------------------------------------+
                           |
                          \ /
                   +----------------+
             (1)   |pstore frontends|
                   +----------------+
                           |
                          \ /
                  +------------------- +
             (2)  | pstore backend(ram)|
                  +--------------------+
                           |
                          \ /
                  +--------------------+
             (3)  |qcom_pstore_minidump|
                  +--------------------+

-Mukesh
> 
>> We don't add layers when they are not needed, and never when there is no
>> actual user.  If you need the extra "complexity" later, then add it
>> later when it is needed as who knows when that will ever be.
>>
>> Please redo this series based on that, thanks.
> 
> My bigger issue with this whole series is what would this all look
> like if every SoC vendor upstreamed their own custom dumping
> mechanism. That would be a mess. (I have similar opinions on the
> $soc-vendor hypervisors.)
> 
> Rob
