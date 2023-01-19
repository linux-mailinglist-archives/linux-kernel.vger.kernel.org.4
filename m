Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E53D67347C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjASJdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjASJdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:33:18 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632C84CE5D;
        Thu, 19 Jan 2023 01:33:17 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J4wbG7006391;
        Thu, 19 Jan 2023 09:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KQg9Y6asG8lSYiYfhDRUcGfO3pmkW6FWE3FD97jRdGo=;
 b=bzE2/02mHBudNdPZHdXQNSyFMbpKP50c5LJESgtDzR7llPisvnrosxyGPZdR7L0LCF5s
 N4gkNElO/NvwEZ+5oOoFoUo+A+pTbHjlNVKHLQoYkoEKSXZIIz6PdbCFzg7wdz6sx6tl
 8a5BnUuxcscVqKW9iZyAheGzZXIzCmvW+c2A6nursxy2E4KZPK9PHIN6Bpn0su/E6iNN
 QMzV9eO6hPAAJAwO4BMEwVTQasLAwl/nEntZCa6lgXxccUymWadVC3oA39TsNv7pH5t3
 r8K30AlgaOk71RqFP02NOicrMGFeRNV1idW73J/8PiJLHRTGUfhzkAbQRjgHol8XNCX2 xQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6ya2rrjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 09:33:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J9XB6F031785
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 09:33:11 GMT
Received: from [10.214.82.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 01:33:08 -0800
Message-ID: <725edcc6-250a-0cd3-4c32-300f48a8ad79@quicinc.com>
Date:   Thu, 19 Jan 2023 15:03:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] soc: qcom: socinfo: Change socinfo variable name and
 scope
Content-Language: en-US
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>
References: <20230111082141.18109-1-quic_namajain@quicinc.com>
 <20230111082141.18109-2-quic_namajain@quicinc.com>
 <2f1d92e7-08e0-13f3-2087-f0c55d83383c@quicinc.com>
From:   Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <2f1d92e7-08e0-13f3-2087-f0c55d83383c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k5xsrHUZtgBuaCurz5czDh4ak-XRbdb0
X-Proofpoint-GUID: k5xsrHUZtgBuaCurz5czDh4ak-XRbdb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_07,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190077
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trilok,

Thanks for reviewing the patches.

On 1/12/2023 3:07 AM, Trilok Soni wrote:
> On 1/11/2023 12:21 AM, Naman Jain wrote:
>> Change socinfo structure variable scope from function to file
>> to make it easy to support custom attributes for sysfs. Also,
>> change variable name to make it more descriptive.
>
> Did you mean debugfs?


No, I meant sysfs only. debugfs support is generally added with every 
version update, in kernel. Since debugfs can't be used for these 
purposes in production devices, we are proposing to extend current sysfs 
interface.


>
> Can you one example of custom attribute in the commit text so that we
> understand the motivation better?
>

I'll add the examples in next patch. Thanks.


>>
>> Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
>> ---
>>   drivers/soc/qcom/socinfo.c | 80 ++++++++++++++++++++------------------
>>   1 file changed, 42 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
>> index 10efdbcfdf05..251c0fd94962 100644
>> --- a/drivers/soc/qcom/socinfo.c
>> +++ b/drivers/soc/qcom/socinfo.c
>> @@ -175,6 +175,7 @@ struct socinfo {
>>       __le32  npartnamemap_offset;
>>       __le32  nnum_partname_mapping;
>>   };
>> +static struct socinfo *soc_info;
>
> Is there any better way to do it? Should not asume the just one object
> and dynamically allocate it? Let's wait for Bjorn to check as well.


So current sysfs attributes are added in probe function, where this 
"info" variable is defined and used. For additions to current sysfs 
interface, using a separate function, the need for having this variable 
with file scope came. Now, I can keep the variable name, same, as "info" 
and not change it to "soc_info" if the forum suggests that, just that we 
thought it feels more descriptive to change it to "soc_info", when we 
make it's scope to file. Also, in future, with this variable global, if 
we decide to support kernel clients by exporting these fields through 
APIs, we can easily make use of this and implement.


>
> ---Trilok Soni


Thanks,

Naman Jain

