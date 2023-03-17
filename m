Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EAD6BE208
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCQHnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCQHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:43:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F7486BC;
        Fri, 17 Mar 2023 00:42:58 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H7XuMo019978;
        Fri, 17 Mar 2023 07:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LcTL+5gjoj2QFyT9gYoPRzMtz6+6VJDaGPUlo8LTWsw=;
 b=HTqyRbcx4cG/CFvnT66bRbYYdD6oldXS0bOXZhI0xeoIigRsCBuSNRvCYWWcoqN6kFb2
 dSYVtbJYRqQPJezoWFrxJY0wj5GysWJc9Yr1edkdd2M6+ik3IACnff5IK/00T2OpaqLr
 v7xuCo21wd43Wc+vf4+Bl10M4hYCjoLo0ek4WmIcfnp9piivrX8BvBDAmh0/IDlyGAOL
 AVP6pmo1htIAnHBvyqIzdC0aRoNd4FoPdoYtSM+YiEv0F+2ydsTK18pk8lMeCB8JjEIf
 YqxvaoF1WinyHaPSTeCpRUPS4Baas1QC+G0ltnE48k162nImRaKqJm5CsxsXAtTDiG3Q PQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pcem18t9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 07:41:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32H7f3W4022509
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 07:41:03 GMT
Received: from [10.233.17.245] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Mar
 2023 00:40:57 -0700
Message-ID: <4c2ff883-13af-19be-e4e2-35a66f2572fa@quicinc.com>
Date:   Fri, 17 Mar 2023 15:40:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 0/3] Add support to configure Coresight Dummy subunit
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
References: <20230316032005.6509-1-quic_hazha@quicinc.com>
 <0db33881-7978-41c9-45e3-63dc2ed7be4f@arm.com>
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <0db33881-7978-41c9-45e3-63dc2ed7be4f@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uWCTNsihlvukbU0MvKCCFgtOrOVg0XMn
X-Proofpoint-ORIG-GUID: uWCTNsihlvukbU0MvKCCFgtOrOVg0XMn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_04,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 3/16/2023 6:55 PM, Suzuki K Poulose wrote:
> On 16/03/2023 03:20, Hao Zhang wrote:
>> Introduction of Coresight Dummy subunit
>> The Coresight Dummy subunit is for Coresight Dummy component, there 
>> are some
>> specific Coresight devices that HLOS don't have permission to access. 
>> Such as
> 
> What is HLOS ?

The term HLOS stands for High Level OS, it means linux in this case. The 
HLOS runs on APPS processor.

>> some TPDMs, they would be configured in NON-HLOS side, but it's 
>> necessary to
> 
> What is NON-HLOS ?

There are some other sub-processors like modem, adsp etc, they do not 
have a High Level OS. The OS in these sub-processors is lightweight, 
less powerful, somewhat real-time, it would be called NON-HLOS.

>> build Coresight path for it to debug. So there need driver to register 
>> dummy
>> devices as Coresight devices.
> 
> Build a path for who to debug ? If this is used by some privileged
> software, shouldn't that do all of the work ?
> 
> Suzuki

There is coresight source or sink in sub-processor, it would be 
configured by NON-HLOS, and need HLOS to configure the last coresight 
components. So we will use dummy source or sink to replace it in HLOS 
side for building the whole path(from source to sink).

Thanks,
Hao

>>
>> Commit link:
>> https://git.codelinaro.org/clo/linux-kernel/coresight/-/tree/coresight-dummy
>>
>> Hao Zhang (3):
>>    Coresight: Add coresight dummy driver
>>    dt-bindings: arm: Add Coresight Dummy Trace YAML schema
>>    Documentation: trace: Add documentation for Coresight Dummy Trace
>>
>>   .../bindings/arm/qcom,coresight-dummy.yaml    | 129 +++++++++++++
>>   .../trace/coresight/coresight-dummy.rst       |  58 ++++++
>>   drivers/hwtracing/coresight/Kconfig           |  11 ++
>>   drivers/hwtracing/coresight/Makefile          |   1 +
>>   drivers/hwtracing/coresight/coresight-dummy.c | 176 ++++++++++++++++++
>>   5 files changed, 375 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
>>   create mode 100644 Documentation/trace/coresight/coresight-dummy.rst
>>   create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c
>>
> 
