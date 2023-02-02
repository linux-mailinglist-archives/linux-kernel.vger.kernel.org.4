Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D946879ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjBBKPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjBBKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:15:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E527981;
        Thu,  2 Feb 2023 02:15:25 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3128J2ko007928;
        Thu, 2 Feb 2023 10:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2EbbVrVKhxvbj1uYMv77+4MNtoSyJ4b/lq6gFHp1A/w=;
 b=J/6HU5JpGB6QrSKTC+NwZXoVz6hhRbkz+rD29buuJnneZfUbGf4aHZMUw3hTp7WlzrJU
 S2ucjQ1ZkeHK+kh4FWbNhFoO8smzbUi1hR2l16i0n39BqityGEdq/qWggO/2UDf9H2eV
 VZB0ClPN6kd7u3GJxu41RxWvfYnOV/xnV59w7BoNfavxJm1qi8XeC0jkcZVdEbvi5byK
 kg0YGnBXG7/W2nVDWz15GTxAqBGRVYWrQblIzwNIVtdY6FyIDgn9xIzNd4tHtvTaY8H9
 pHhqN46M0AQEGItLz0K9hhPF6r31zgM/VW/Aw/pgLDLZcE9hFhmOQx35Im4kes0ULeMv eA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfm9cttsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 10:15:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312AFMZa016089
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 10:15:22 GMT
Received: from [10.216.19.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 02:14:48 -0800
Message-ID: <10d91214-4106-7a9d-b1ac-68df1aa5f6c9@quicinc.com>
Date:   Thu, 2 Feb 2023 15:44:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2] Serial: core: Add compat ioctl support
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_arandive@quicinc.com>
References: <20230125113418.7221-1-quic_vdadhani@quicinc.com>
 <Y9EfYCBngFAG+RBw@kroah.com>
From:   Viken Dadhaniya <quic_vdadhani@quicinc.com>
In-Reply-To: <Y9EfYCBngFAG+RBw@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U8gd3PA-P3pKF3TIKFv0JcnBw2G3MlZz
X-Proofpoint-GUID: U8gd3PA-P3pKF3TIKFv0JcnBw2G3MlZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_02,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302020094
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

"Can you point us at the out-of-tree code please?"

Please refer: 
https://git.codelinaro.org/clo/la/kernel/msm-5.10/-/blob/KERNEL.PLATFORM.1.0.r3-01300-kernel.0/drivers/tty/serial/msm_geni_serial.c#L750

Thanks

Viken Dadhaniya


On 1/25/2023 5:54 PM, Greg KH wrote:
> On Wed, Jan 25, 2023 at 05:04:18PM +0530, Viken Dadhaniya wrote:
>> Current serial core driver doesn't support compat_ioctl
>> due to which 32-bit application is not able to send
>> ioctls to driver on a 64-bit platform.
>>
>> Added compat_ioctl support in serial core to handle
>> ioctls from 32-bit applications on a 64-bit platform.
>>
>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
>> ---
>>   drivers/tty/serial/serial_core.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index b9fbbee598b8..ad4c3a5a3d29 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1601,6 +1601,12 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
>>   	return ret;
>>   }
>>   
>> +static long
>> +uart_compat_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
>> +{
>> +	return (long)uart_ioctl(tty, cmd, arg);
> How does this "fix" your out-of-tree driver at all?  What command is
> being sent that has this incorrect that this simple "pass through" is
> going to solve?
>
> Can you point us at the out-of-tree code please?
>
> thanks,
>
> greg k-h
