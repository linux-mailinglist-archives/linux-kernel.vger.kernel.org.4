Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A71673488
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjASJft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjASJfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:35:39 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFD25DC35;
        Thu, 19 Jan 2023 01:35:38 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J5s9LB005692;
        Thu, 19 Jan 2023 09:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+t0N4+b4buQwinEa7WbbZp8BZgMLgKEVgjODca5QfGY=;
 b=frt+8/UudeL8bX7PGXPtxw+e3fbeykeqs8WIM0/Yq7ZcCgVVZJEpCnhGj/Ayvu4u0rEG
 7R8NgE8at5U59M3azh8D0ziqZTMl0m1kTDR+Nw++8Gf35Qi66aA3KZh20j/oXuGykK/p
 XEoHfCIqNfaSw3Eb2j8+VASEW1PFI2gK/paSL17/rsIfQdrIRW5815XpWEIJC9Y5tYAD
 i+I3307U6IJAONeoxrVaG7eVyR1deeXC8ghMtgxy31cQUFOWgzxY9XOdCkrsk35LsjIc
 1O5OkgWWuL1DL8JyMyVXhzLpMaGDyp0vju35LG47+KG2SbJtORcgauN42AoKnc9HdoVd Eg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6debtx4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 09:35:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J9ZVuh030122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 09:35:31 GMT
Received: from [10.214.82.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 01:35:29 -0800
Message-ID: <1d31a521-f5c6-48f0-1202-2f19919bca6b@quicinc.com>
Date:   Thu, 19 Jan 2023 15:05:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] soc: qcom: socinfo: Add sysfs attributes for fields
 in v2-v6
Content-Language: en-US
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>
References: <20230111082141.18109-1-quic_namajain@quicinc.com>
 <20230111082141.18109-3-quic_namajain@quicinc.com>
 <08ffedc3-3104-18fc-4813-287eccd1fdca@linaro.org>
 <0794d7b5-2eb9-f11f-56bc-bf9d702022df@quicinc.com>
From:   Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <0794d7b5-2eb9-f11f-56bc-bf9d702022df@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G0WPyyDJigf69s7Yy66O7hbdHBhvLs5O
X-Proofpoint-ORIG-GUID: G0WPyyDJigf69s7Yy66O7hbdHBhvLs5O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_07,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=710 adultscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190077
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trilok,

On 1/12/2023 5:28 AM, Trilok Soni wrote:
> On 1/11/2023 3:19 PM, Dmitry Baryshkov wrote:
>> On 11/01/2023 10:21, Naman Jain wrote:
>>> Add support in sysfs custom attributes for fields in socinfo version
>>> v2-v6. This is to support SoC based operations in userland scripts
>>> and test scripts. Also, add name mappings for hw-platform type to
>>> make the sysfs information more descriptive.
>>
>> Please include a patch documenting your additions to 
>> Documentation/ABI/testing/sysfs-devices-soc. Please describe usecases 
>> for new attributes and their applicability to non-Qualcomm boards.
>>
>> Note, that testing scripts can access debugfs entries without any 
>> issues.
>
> The commit text mentions the "userland" scripts and it could mean the 
> product OS like Android or Yocto having the applications using these 
> /sysfs entries. Naman, please clarify if the vendor application layer 
> in the Android is using these Entries to make decisions based on the 
> platforms / soc information?


That may have been a wrong choice of word here, if that is what it 
means. The use of these interfaces is in post boot shell scripts, and 
userspace services. As these are Qualcomm specific, I don't think we 
have any examples in Android. I have now mentioned the use-cases of 
sysfs interface, in my reply on Dmitry's email on PATCH 2/2. Have added 
you there to avoid duplication.


>
> ---Trilok Soni


Thanks,

Naman Jain

