Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450987001C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbjELHwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbjELHwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:52:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D152AE705;
        Fri, 12 May 2023 00:52:17 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C7k6vC011471;
        Fri, 12 May 2023 07:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nHqs3cbznyy9gdtabZI1rFArHV1FP7rzRz/FpxP3dOg=;
 b=b/0DQr8oGZsAVbXE2Lr6NA3O7EhwIJQ82zpDLU3gkza6le84WwULm2hkB787OClrCv9k
 6KgAVDQztulgm21zEROEKV4V+AdQtDY6lIqzZNQDWr6u6flXxFBVb4NEwAZqICnaAv4C
 pqVJghb1VLWl8jSMaXeS90LGjdYystxqYZHtESS86Yog7rmKlsDP5ViRyOiA5GoqWFKA
 NkVDZrXCOdj3/rcUylzOc82AbJbd7K+qU5zGuof1jMLGROBEx/V28gJJRPhqJAmeOUi1
 N+ZJ5uV+O7FlLdrEZjmktLE3N5BP00Wyq2fqauofMcDsa7DXvrKIWUQ/NR5nQjQTe0r9 Nw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qh5g99ck9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 07:51:46 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34C7piRG011044
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 07:51:45 GMT
Received: from [10.253.73.41] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 12 May
 2023 00:51:37 -0700
Message-ID: <82aab1d7-0157-983a-5f92-3dcd1e04fe23@quicinc.com>
Date:   Fri, 12 May 2023 15:51:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/3] Documentation: trace: Add documentation for
 Coresight Dummy Trace
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        "Yuanfang Zhang" <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20230422073714.38844-1-quic_hazha@quicinc.com>
 <20230422073714.38844-4-quic_hazha@quicinc.com> <ZFsdvCuTTEkTm9VA@debian.me>
Content-Language: en-US
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <ZFsdvCuTTEkTm9VA@debian.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3FKdG7ONrS4So1yTJqPohs33FvWIO9pQ
X-Proofpoint-ORIG-GUID: 3FKdG7ONrS4So1yTJqPohs33FvWIO9pQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=915 mlxscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120065
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On 5/10/2023 12:29 PM, Bagas Sanjaya wrote:
> On Sat, Apr 22, 2023 at 03:37:14PM +0800, Hao Zhang wrote:
>> +Introduction
>> +---------------------------
>> +
>> +Coresight Dummy Trace Module is for the specific devices that kernel
>> +don't have permission to access or configure, e.g., CoreSight TPDMs
>> +on Qualcomm platforms. So there need driver to register dummy devices
>> +as Coresight devices. It may also be used to define components that
>> +may not have any programming interfaces (e.g, static links), so that
>> +paths can be established in the driver. Provide Coresight API for
>> +dummy device operations, such as enabling and disabling dummy devices.
>> +Build the Coresight path for dummy sink or dummy source for debugging.
>> +
>> +Config details
>> +---------------------------
>> +
>> +There are two types of nodes, dummy sink and dummy source. The nodes
>> +should be observed at the below coresight path::
>> +
>> +    ``/sys/bus/coresight/devices``.
>> +
>> +e.g.::
>> +
>> +    / $ ls -l /sys/bus/coresight/devices | grep dummy
>> +    dummy0 -> ../../../devices/platform/soc@0/soc@0:dummy_source/dummy0
>> +    dummy1 -> ../../../devices/platform/soc@0/soc@0:dummy_sink/dummy1
> 
> The wording confuses me, so I have to make the improv:
> 
> ---- >8 ----
> diff --git a/Documentation/trace/coresight/coresight-dummy.rst b/Documentation/trace/coresight/coresight-dummy.rst
> index 7cb59f080c8892..f0a92669288b0c 100644
> --- a/Documentation/trace/coresight/coresight-dummy.rst
> +++ b/Documentation/trace/coresight/coresight-dummy.rst
> @@ -8,27 +8,25 @@ Coresight Dummy Trace Module
>       :Date:     May 2023
>   
>   Introduction
> ----------------------------
> +------------
>   
> -Coresight Dummy Trace Module is for the specific devices that kernel
> -don't have permission to access or configure, e.g., CoreSight TPDMs
> -on Qualcomm platforms. So there need driver to register dummy devices
> -as Coresight devices. It may also be used to define components that
> -may not have any programming interfaces (e.g, static links), so that
> -paths can be established in the driver. Provide Coresight API for
> -dummy device operations, such as enabling and disabling dummy devices.
> -Build the Coresight path for dummy sink or dummy source for debugging.
> +The Coresight dummy trace module is for the specific devices that kernel don't
> +have permission to access or configure, e.g., CoreSight TPDMs on Qualcomm
> +platforms. For these devices, a dummy driver is needed to register them as
> +Coresight devices. The module may also be used to define components that may
> +not have any programming interfaces (e.g, static links), so that paths can be
> +created in the driver. It provides Coresight API for operations on dummy
> +devices, such as enabling and disabling them. It also provides the Coresight
> +dummy sink/source paths for debugging.
>   
>   Config details
> ----------------------------
> +--------------
>   
> -There are two types of nodes, dummy sink and dummy source. The nodes
> -should be observed at the below coresight path::
> +There are two types of nodes, dummy sink and dummy source. These nodes
> +are available at ``/sys/bus/coresight/devices``.
>   
> -    ``/sys/bus/coresight/devices``.
> +Example output::
>   
> -e.g.::
> -
> -    / $ ls -l /sys/bus/coresight/devices | grep dummy
> +    $ ls -l /sys/bus/coresight/devices | grep dummy
>       dummy_sink0 -> ../../../devices/platform/soc@0/soc@0:sink/dummy_sink0
>       dummy_source0 -> ../../../devices/platform/soc@0/soc@0:source/dummy_source0
> 
> Thanks.
> 

Thanks for your review and comments, will update it in the next patch 
series.

Thanks,
Hao
