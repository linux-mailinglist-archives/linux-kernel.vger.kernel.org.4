Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A116CB352
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjC1BqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjC1Bp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:45:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801271BCD;
        Mon, 27 Mar 2023 18:45:57 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RNMXeU030957;
        Tue, 28 Mar 2023 01:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NVqOR9PCgqZAIwWDr1ktOZBwWzDpzUHb7zx6m33Yw64=;
 b=GQ5XHLxSje7Lk6mPzUZXjl3yB1USrYBQC7XDhBUiZ7Za5okLKv1iKXWAxY0BngQMWbyU
 25zongN3NNhe8Jt16J4XzPXzpv9daJ9VTTTuuoMK6EmdBjUGpviBuLUPW/ACf2iLmXwi
 IpKnaD1hRedSSuepWbEzYZbz5Z6lIwK06pSWmBq7NjWXO/p2cKXCj/LaXbSTxheNnLlQ
 KXHx4CvzaKyB1Trmn+Il+YvTMcAGHmpxz+JM+BPEo9OASpXAERofSaj14X2mdkc87Zr2
 8WjRrW6DhQqCY8pD7UsimseFUhQ1bYIL6ZqAPiRX0wTBWikRHdidyCsjiwK08ivypIYe lQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkby49j4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 01:45:39 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S1jcN7029325
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 01:45:38 GMT
Received: from [10.233.17.245] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Mar
 2023 18:45:30 -0700
Message-ID: <4abcf829-5265-d8ed-05a4-e3259068ad51@quicinc.com>
Date:   Tue, 28 Mar 2023 09:45:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] Documentation: trace: Add documentation for
 Coresight Dummy Trace
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
 <20230324061608.33609-4-quic_hazha@quicinc.com> <ZCFeJkkpIor5P28r@kroah.com>
Content-Language: en-US
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <ZCFeJkkpIor5P28r@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DZya5-LtyXjXxFnWoKDxk3ifvAVdMTO9
X-Proofpoint-GUID: DZya5-LtyXjXxFnWoKDxk3ifvAVdMTO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=991 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280011
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 3/27/2023 5:13 PM, Greg Kroah-Hartman wrote:
> On Fri, Mar 24, 2023 at 02:16:08PM +0800, Hao Zhang wrote:
>> Add documentation for Coresight Dummy Trace under trace/coresight.
>>
>> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
>> ---
>>   .../trace/coresight/coresight-dummy.rst       | 58 +++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>   create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
>>
>> diff --git a/Documentation/trace/coresight/coresight-dummy.rst b/Documentation/trace/coresight/coresight-dummy.rst
>> new file mode 100644
>> index 000000000000..819cabab8623
>> --- /dev/null
>> +++ b/Documentation/trace/coresight/coresight-dummy.rst
>> @@ -0,0 +1,58 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=============================
>> +Coresight Dummy Trace Module
>> +=============================
>> +
>> +    :Author:   Hao Zhang <quic_hazha@quicinc.com>
>> +    :Date:     March 2023
>> +
>> +Introduction
>> +---------------------------
>> +
>> +Coresight Dummy Trace Module is for the specific devices that HLOS don't
>> +have permission to access or configure. Such as Coresight sink EUD, some
>> +TPDMs etc. So there need driver to register dummy devices as Coresight
>> +devices. Provide Coresight API for dummy device operations, such as
>> +enabling and disabling dummy devices. Build the Coresight path for dummy
>> +sink or dummy source for debugging.
>> +
>> +Sysfs files and directories
>> +---------------------------
>> +
>> +Root: ``/sys/bus/coresight/devices/dummy<N>``
> 
> sysfs files are documented in Documentation/ABI/ not in random .rst
> files, sorry.  Please use the correct format described there, not a
> random one like this :)
> 
> thanks,
> 
> greg k-h

Thanks for your review, I will correct the format in the next version of 
patch.

Thanks,
Hao
