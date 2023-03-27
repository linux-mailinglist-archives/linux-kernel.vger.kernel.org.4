Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655A36C9B43
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjC0GFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjC0GFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:05:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A664EEE;
        Sun, 26 Mar 2023 23:05:33 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R5fwVf014477;
        Mon, 27 Mar 2023 06:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c5Moma9QH1NFeyptfTJA6uULulI09houVr9jBihY+sE=;
 b=jZf8vqINdE2wX/JjsMfeN8j6DCG4vol6NRi4QBvIEEFtH0Y695l6DrIDLLXO9n945nP/
 j+rGF2F1PmwvTUX3Mn9aBhzw55xY5ntyNamrmRM9GoQXLFCBgkPexY4LvXZoIdk+HA2k
 G6aAb79avxYwqyJTtyFIApK8sbVgwKW/xXYoX0kJWM+Up2LyyOQX6XDjPeDEbD9yDk8D
 7WzRYdPmN2DOgEI5gZ01R9QO7ESNK6j0tLziJujU8Rq8ANUxypfJRP8jjSTvc6X8ti8Z
 CzhiBW9B86DVnjMXfKAwIcn7fctl+dKI/t5ni8W4daRLFAkBA5PYgGD1csD8Fn78G7+j Cg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pk57701x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 06:05:19 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R65It5030052
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 06:05:18 GMT
Received: from [10.253.35.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 26 Mar
 2023 23:05:10 -0700
Message-ID: <a56a460e-7d50-fcf0-95a5-cf08eeb73f43@quicinc.com>
Date:   Mon, 27 Mar 2023 14:05:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] Documentation: trace: Add documentation for
 Coresight Dummy Trace
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <20230324061608.33609-4-quic_hazha@quicinc.com>
 <e383c17d-12b8-b134-acc5-82f515714562@arm.com>
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <e383c17d-12b8-b134-acc5-82f515714562@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W2Z5qzmY9BFcRWSfwrWsZFOaxkPYsP0e
X-Proofpoint-ORIG-GUID: W2Z5qzmY9BFcRWSfwrWsZFOaxkPYsP0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 mlxlogscore=986 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270050
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 3/24/2023 7:00 PM, Suzuki K Poulose wrote:
> On 24/03/2023 06:16, Hao Zhang wrote:
>> Add documentation for Coresight Dummy Trace under trace/coresight.
>>
>> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
>> ---
>>   .../trace/coresight/coresight-dummy.rst       | 58 +++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>   create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
>>
>> diff --git a/Documentation/trace/coresight/coresight-dummy.rst 
>> b/Documentation/trace/coresight/coresight-dummy.rst
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
>> +    :Author:   Hao Zhang <quic_hazha@quicinc.com>
>> +    :Date:     March 2023
>> +
>> +Introduction
>> +---------------------------
>> +
>> +Coresight Dummy Trace Module is for the specific devices that HLOS don't
> 
> Please do not use cryptic abbreviations, please use "kernel"
> 
Sure, I will change it to "kernel".
> 
>> +have permission to access or configure. 
> 
> Such as Coresight sink EUD, some
>> +TPDMs etc. 
> Say "e.g., CoreSight TPDMs on Qualcomm platforms.:
> 
> So there need driver to register dummy devices as Coresight
>> +devices.
> 
> Add:
> 
> "It may also be used to define components that may not have any
> programming interfaces (e.g, static links), so that paths can
> be established in the driver.
> "
> 
>   Provide Coresight API for dummy device operations, such as
>> +enabling and disabling dummy devices. Build the Coresight path for dummy
>> +sink or dummy source for debugging.
> 
I will take your advice in the next version of patch.
> 
> I think the following content may not be needed as they are part
> of the standard source/sink type devices, nothing specific to
> dummy devices.
> 
> --- vvvvv ---
>> +
>> +Sysfs files and directories
>> +---------------------------
>> +
>> +Root: ``/sys/bus/coresight/devices/dummy<N>``
>> +
>> +----
>> +
>> +:File:            ``enable_source`` (RW)
>> +:Notes:
>> +    - > 0 : enable the datasets of dummy source.
>> +
>> +    - = 0 : disable the datasets of dummy source.
>> +
>> +:Syntax:
>> +    ``echo 1 > enable_source``
>> +
>> +----
>> +
>> +:File:            ``enable_sink`` (RW)
>> +:Notes:
>> +    - > 0 : enable the datasets of dummy sink.
>> +
>> +    - = 0 : disable the datasets of dummy sink.
>> +
>> +:Syntax:
>> +    ``echo 1 > enable_sink``
>> +
>> +----
>> +
> 
> --- You may remove the above ^^^ ----
>
I will remove the above notes in the next version of patch.

Thanks,
Hao

>> +Config details
>> +---------------------------
>> +
>> +There are two types of nodes, dummy sink and dummy source. The nodes
>> +should be observed at the coresight path
>> +"/sys/bus/coresight/devices".
>> +e.g.
>> +/sys/bus/coresight/devices # ls -l | grep dummy
>> +dummy0 -> ../../../devices/platform/soc@0/soc@0:dummy_source/dummy0
>> +dummy1 -> ../../../devices/platform/soc@0/soc@0:dummy_sink/dummy1
> 
> Suzuki
> 
