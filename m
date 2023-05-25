Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7EA71103C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbjEYQBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbjEYQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:01:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED0ABB;
        Thu, 25 May 2023 09:01:11 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PF9whQ007396;
        Thu, 25 May 2023 16:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W0UodC4wO9Z0PPDH8IxHje0JR900ThyIMrr9RUQ8BQg=;
 b=Q0T5Lr+vZCGKyfz9i6KDG6BUaEr8BQSsipwn8mNMPmF5JLEuVkp5qLCHVXFRyFL0TR7E
 pR/7/kAqOmU6jYslXviVKTSoOOBtQO4NvlcfEVShlLWFKfcaB2mx9DzWpvGiZVCxk1qr
 NCGRETcOJ4f1BZTf7T/do8ezoXoqJDv97pC6HOVzMgcmDmhdPu9qniB74Z1AkuaIHcn9
 O4U4ohcdkOu90v92P43Kj6yjJv372GJ67KWGCKv9BPCU5PbqJ6AIH6y1okVyCYj8wVNC
 AQpy6FoTOz8XMFIOJCYlPv+b1XyW0ctqZ0tlVyaLRBBwjtT+modTGHAb37NYc/Z4L78c KA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsuc220hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 16:00:47 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PG0lZ1006058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 16:00:47 GMT
Received: from [10.216.59.206] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 09:00:39 -0700
Message-ID: <1e6c1471-91f0-f230-1590-c835ba27fba5@quicinc.com>
Date:   Thu, 25 May 2023 21:30:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 03/18] docs: qcom: Add qualcomm minidump guide
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <corbet@lwn.net>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-4-git-send-email-quic_mojha@quicinc.com>
 <ZFjIcSRSitmOvmZw@debian.me>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ZFjIcSRSitmOvmZw@debian.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fWnLbuw1DUmaxRUqwxLGGtNGT4L3nLvJ
X-Proofpoint-GUID: fWnLbuw1DUmaxRUqwxLGGtNGT4L3nLvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250132
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/2023 3:31 PM, Bagas Sanjaya wrote:
> On Wed, May 03, 2023 at 10:32:17PM +0530, Mukesh Ojha wrote:
>>   Documentation/admin-guide/qcom_minidump.rst | 246 ++++++++++++++++++++++++++++
>>   1 file changed, 246 insertions(+)
> 
> You forget to add toctree entry:
> 
> ---- >8 ----
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 43ea35613dfcd4..251d070486c2ab 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -120,6 +120,7 @@ configure specific aspects of kernel behavior to your liking.
>      perf-security
>      pm/index
>      pnp
> +   qcom_minidump
>      rapidio
>      ras
>      rtc
> 
>> +Writing to sysfs node can also be used to set the mode to minidump.
>> +
>> +::
>> +	echo "mini" > /sys/module/qcom_scm/parameter/download_mode
> 
> The snippet above isn't rendered to code block, so I have to fix it up:
> 
> ---- >8 ----
> diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/admin-guide/qcom_minidump.rst
> index 062c797e90d9cf..408fe1beed1b78 100644
> --- a/Documentation/admin-guide/qcom_minidump.rst
> +++ b/Documentation/admin-guide/qcom_minidump.rst
> @@ -208,9 +208,8 @@ Similarly, "full" is passed to set the download mode to full dump
>   where entire ddr dump will be collected while setting it "full,mini"
>   will collect minidump along with fulldump.
>   
> -Writing to sysfs node can also be used to set the mode to minidump.
> +Writing to sysfs node can also be used to set the mode to minidump::
>   
> -::
>   	echo "mini" > /sys/module/qcom_scm/parameter/download_mode
>   
>   Once the download mode is set, any kind of crash will make the device collect
> 
>> +By default, dumps are downloaded via USB to the attached x86_64 machine
>> +running PCAT (Qualcomm tool) software. Upon download, we will see
>> +a set of binary blobs starts with name md_* in PCAT configured directory
>> +in x86_64 machine, so for above example from the client it will be
>> +md_REGION_A.BIN. This binary blob depends on region content to determine
>> +whether it needs external parser support to get the content of the region,
>> +so for simple plain ASCII text we don't need any parsing and the content
>> +can be seen just opening the binary file.
>> +
>> <snipped> ...
>> +One need to read the entire rawdump partition and pull out content to
>> +save it onto the attached x86_64 machine over USB. Later, this rawdump
>> +can be pass it to another tool dexter.exe(Qualcomm tool) which converts
>> +this into the similar binary blobs which we have got it when download type
>> +was set to USB i.e a set of registered region as blobs and their name
>> +starts with md_*.
>> +
>> +Replacing the dexter.exe with some open source tool can be added as future
>> +scope of this document.
> 
> There is inconsistency on inlining code keywords, so I have to inline
> the rest:
> 
> ---- >8 ----
> diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/admin-guide/qcom_minidump.rst
> index 408fe1beed1b78..117e61ef9fde67 100644
> --- a/Documentation/admin-guide/qcom_minidump.rst
> +++ b/Documentation/admin-guide/qcom_minidump.rst
> @@ -118,7 +118,7 @@ Client driver can use ``qcom_apss_minidump_region_register`` API's to
>   register and ``qcom_apss_minidump_region_unregister`` to unregister
>   their region from minidump driver.
>   
> -Client need to fill their region by filling qcom_apss_minidump_region
> +Client need to fill their region by filling ``qcom_apss_minidump_region``
>   structure object which consist of the region name, region's
>   virtual and physical address and its size.
>   
> @@ -166,7 +166,7 @@ Test
>   
>   Existing Qualcomm devices already supports entire ddr dump (also called
>   full dump) by writing appropriate value to Qualcomm's top control and
> -status register(tcsr) in driver/firmware/qcom_scm.c .
> +status register(tcsr) in ``driver/firmware/qcom_scm.c``.
>   
>   SCM device Tree bindings required to support download mode
>   For example (sm8450) ::
> @@ -202,10 +202,10 @@ For example (sm8450) ::
>   
>   	};
>   
> -User of minidump can pass qcom_scm.download_mode="mini" to kernel
> +User of minidump can pass ``qcom_scm.download_mode="mini"`` to kernel
>   commandline to set the current download mode to minidump.
> -Similarly, "full" is passed to set the download mode to full dump
> -where entire ddr dump will be collected while setting it "full,mini"
> +Similarly, ``"full"`` is passed to set the download mode to full dump
> +where entire ddr dump will be collected while setting it ``"full,mini"``
>   will collect minidump along with fulldump.
>   
>   Writing to sysfs node can also be used to set the mode to minidump::
> @@ -223,9 +223,9 @@ stored to an attached storage device.
>   
>   By default, dumps are downloaded via USB to the attached x86_64 machine
>   running PCAT (Qualcomm tool) software. Upon download, we will see
> -a set of binary blobs starts with name md_* in PCAT configured directory
> +a set of binary blobs starts with name ``md_*`` in PCAT configured directory
>   in x86_64 machine, so for above example from the client it will be
> -md_REGION_A.BIN. This binary blob depends on region content to determine
> +``md_REGION_A.BIN``. This binary blob depends on region content to determine
>   whether it needs external parser support to get the content of the region,
>   so for simple plain ASCII text we don't need any parsing and the content
>   can be seen just opening the binary file.
> @@ -236,10 +236,10 @@ partition on the target device itself.
>   
>   One need to read the entire rawdump partition and pull out content to
>   save it onto the attached x86_64 machine over USB. Later, this rawdump
> -can be pass it to another tool dexter.exe(Qualcomm tool) which converts
> +can be pass it to another tool (``dexter.exe`` [Qualcomm tool]) which converts
>   this into the similar binary blobs which we have got it when download type
>   was set to USB i.e a set of registered region as blobs and their name
> -starts with md_*.
> +starts with ``md_*``.
>   
> -Replacing the dexter.exe with some open source tool can be added as future
> +Replacing the ``dexter.exe`` with some open source tool can be added as future
>   scope of this document.

Thanks for the review and the shared diffs, have applied the changes for 
the next version.

-- Mukesh

> 
> Thanks.
> 
