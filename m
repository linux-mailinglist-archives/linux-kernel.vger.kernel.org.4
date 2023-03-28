Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8096CB910
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjC1IHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjC1IHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:07:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90FC193;
        Tue, 28 Mar 2023 01:07:29 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S7j1c8014543;
        Tue, 28 Mar 2023 08:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8dxXEASTuugZX06RZvf5bwr82eM3WswKmCdFTJR9cdY=;
 b=iWiGtqPGi4P5bX4Xq742PWjUTq56iK9awn9U+/raar123tjnGQIUxoX9AGP5akJ4/iBO
 ftAzlkbq1LvHKivQFdxx7OXPubwOuRsIn3WipvxDfiFevM9m6dPwlQdsXH+4qIkgwfdG
 LhoAVNaUsKJYXG45KMupHrJKJFZclkjf1/BUBQ/MMzm7fKrlcJyJRPVgNcND5fnwBsHO
 8BjboRvwSk0CLBRtMfO7LsTsasTtD/QQxnPGhYmHC1jxal2m3tV16vn8/slPhFKr9ETE
 eBRkzFpnbUZICcUXXB6iux7dNhTMShflsCIj5qXlyyjspFJ1viVUZ/i2zC1mMsTmJyFC KQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkv45g1kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 08:07:14 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S87DQ3028377
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 08:07:13 GMT
Received: from [10.233.17.245] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Mar
 2023 01:07:06 -0700
Message-ID: <fa7bd706-c8ca-d7d8-eef9-05b908625741@quicinc.com>
Date:   Tue, 28 Mar 2023 16:07:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] Documentation: trace: Add documentation for
 Coresight Dummy Trace
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
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
 <20230324061608.33609-4-quic_hazha@quicinc.com> <ZCFclDU2JZLzbVX/@debian.me>
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <ZCFclDU2JZLzbVX/@debian.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D_SNVCOQQfo8XtW0QfJGFO5RGS_HwTYp
X-Proofpoint-ORIG-GUID: D_SNVCOQQfo8XtW0QfJGFO5RGS_HwTYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 mlxlogscore=674
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280067
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On 3/27/2023 5:06 PM, Bagas Sanjaya wrote:
> On Fri, Mar 24, 2023 at 02:16:08PM +0800, Hao Zhang wrote:
>> +Sysfs files and directories
>> +---------------------------
>> +
>> +Root: ``/sys/bus/coresight/devices/dummy<N>``
>> +
>> +----
>> +
>> +:File:            ``enable_source`` (RW)
>> +:Notes:
>> +    - > 0 : enable the datasets of dummy source.
>> +
>> +    - = 0 : disable the datasets of dummy source.
>> +
>> +:Syntax:
>> +    ``echo 1 > enable_source``
>> +
>> +----
>> +
>> +:File:            ``enable_sink`` (RW)
>> +:Notes:
>> +    - > 0 : enable the datasets of dummy sink.
>> +
>> +    - = 0 : disable the datasets of dummy sink.
>> +
>> +:Syntax:
>> +    ``echo 1 > enable_sink``
> 
> Is enable_{source,sink} integer-valued or bit (0/1)? In other words, is
> it OK to `echo 2` to both sysfs files?

It should be the integer value, that is OK to "echo 2" to the sysfs files.

>> +
>> +----
>> +
>> +Config details
>> +---------------------------
>> +
>> +There are two types of nodes, dummy sink and dummy source. The nodes
>> +should be observed at the coresight path
>> +"/sys/bus/coresight/devices".
> 
> For consistency, inline this sysfs also (thus
> ``/sys/bus/coresight/devices``.
> 
>> +e.g.
> e.g.:: (make the shell snippet below code block)

I will correct it in the next version of patch.

>> +/sys/bus/coresight/devices # ls -l | grep dummy
> IMO I prefer `PS1=\$` (that is, omit the directory). Alternatively,
> you can write `ls -l /sys/bus/coresight/devices | grep dummy` (specify
> the directory to `ls`).
> 
> Thanks.
> 

Thanks for your comments, I will take your advice in the next version of 
patch.

Thanks,
Hao
