Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3596197DD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiKDN2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKDN1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:27:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759172EF74;
        Fri,  4 Nov 2022 06:26:02 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A4D2Ghi030654;
        Fri, 4 Nov 2022 13:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=40jF6bool0pRdYkHn/c8RLr0Y9N3r7cZhNrwHaQljDs=;
 b=RknmRGqD7UX935qS0U0YtasmJrHa2C7jkwTLc8FmHBqsB9hzf7ySoHOiWa7BUPYdMJgf
 MWoTAGGJ3BhpT2oOCDRNVeMoSaHo724uEoFXGQ7g6X6QpDapSnCDa8x637MLpvpzvtej
 w3lMAt6YmP6m8xOBebQCGT30aQqrWaetTrsGCYkyPKfP76pAw9iYMWFDCIUQwPRr2tPP
 YHAOBHskXTgnaZkXG4FzZ8yczTcV8Wtle5VpN3RurloQi4AB1W2xYF3DdeMNMfeIe7IF
 ilkKs/d689fHu3aIzqye0u9kgYmEKe8J/AixTbF0T6VbQCt8q5XCQerEj2sDshdeSOLF oQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kn0830hmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 13:25:43 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A4DPh0m021473
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Nov 2022 13:25:43 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 4 Nov 2022
 06:25:40 -0700
Message-ID: <b5e5244f-fa9e-0701-4efc-088ed2c7ac1b@quicinc.com>
Date:   Fri, 4 Nov 2022 18:55:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] serial: Fix a typo ("ignorning")
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        <linux-serial@vger.kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221104103719.2234098-1-j.neuschaefer@gmx.net>
 <71ac8750-8a15-4d0c-7b0e-8992b68992cd@somainline.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <71ac8750-8a15-4d0c-7b0e-8992b68992cd@somainline.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DHblWlrTP9jx1hN_DHS53DQ86XyeKGL8
X-Proofpoint-GUID: DHblWlrTP9jx1hN_DHS53DQ86XyeKGL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_09,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 malwarescore=0 mlxscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 11/4/2022 4:16 PM, Konrad Dybcio wrote:
> 
> On 04/11/2022 11:37, Jonathan Neuschäfer wrote:
>> Fix the two instances of this typo present in the MSM and VT8500 serial
>> drivers.
>>
>> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
>> ---
> 
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> 
> 
> Konrad
> 
>>   drivers/tty/serial/msm_serial.c    | 2 +-
>>   drivers/tty/serial/vt8500_serial.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/msm_serial.c 
>> b/drivers/tty/serial/msm_serial.c
>> index 7dd19a2815794..d9a3aa941427c 100644
>> --- a/drivers/tty/serial/msm_serial.c
>> +++ b/drivers/tty/serial/msm_serial.c
>> @@ -819,7 +819,7 @@ static void msm_handle_rx(struct uart_port *port)
>>               port->icount.rx++;
>>           }
>>
>> -        /* Mask conditions we're ignorning. */
>> +        /* Mask conditions we're ignoring. */
>>           sr &= port->read_status_mask;
>>
>>           if (sr & MSM_UART_SR_RX_BREAK)
>> diff --git a/drivers/tty/serial/vt8500_serial.c 
>> b/drivers/tty/serial/vt8500_serial.c
>> index 10fbdb09965f3..37c8a55b48eda 100644
>> --- a/drivers/tty/serial/vt8500_serial.c
>> +++ b/drivers/tty/serial/vt8500_serial.c
>> @@ -168,7 +168,7 @@ static void handle_rx(struct uart_port *port)
>>
>>           c = readw(port->membase + VT8500_RXFIFO) & 0x3ff;
>>
>> -        /* Mask conditions we're ignorning. */
>> +        /* Mask conditions we're ignoring. */
>>           c &= ~port->read_status_mask;
>>
>>           if (c & FER) {
>> -- 
>> 2.35.1
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
