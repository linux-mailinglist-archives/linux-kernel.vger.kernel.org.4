Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9B68C514
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjBFRr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjBFRrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:47:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D05455B6;
        Mon,  6 Feb 2023 09:47:50 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316EXYxZ011717;
        Mon, 6 Feb 2023 17:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=U/99uh2B0mljlEVKFeApNzCyNXyjW0N7U7zVg6mrswA=;
 b=W3wL03j283pQFWbu/SnaE/4MNqze8Ly4arLIwnlXzjWdelfWP1Rv5c9PoEcHtyW9hzzl
 VShO3scUJImmZxviJtW+jajG3A7jJJWfmETiofNrk7XxeQollMK9G7vGHq32Wk104W1/
 Mt0xJE9skppYdI4DF7+ss/LRnLbvzn4TTUR3ywwgqKsIQsvDnq0YZ7f1xBfUdWcblV6l
 e4qeL0AR3/BZs64T2awUyqRyOAAm/6XJTfYRJVqgSYa9vUxdgip67QJY2BguO1n5+gP7
 DXasQRCQ6vj7+F1F5hwTBksaAOPsy2U7usqeByY5RzjEjE8RE/NhQsmUs3+7eVsSZFna NQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nheb0vawb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 17:47:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316HlkfO012770
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 17:47:46 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 09:47:46 -0800
Message-ID: <8c471d9e-5830-e367-4b24-097f644854e3@quicinc.com>
Date:   Mon, 6 Feb 2023 10:47:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] Documentation: leds: Fix warning from leds-qcom-lpg
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, <andersson@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1675700261-25531-1-git-send-email-quic_jhugo@quicinc.com>
 <87y1par955.fsf@meer.lwn.net>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <87y1par955.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Cbh0RejaOdLYhMXgB3kOHN7qc5c809x6
X-Proofpoint-GUID: Cbh0RejaOdLYhMXgB3kOHN7qc5c809x6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=897 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060154
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/2023 10:33 AM, Jonathan Corbet wrote:
> Jeffrey Hugo <quic_jhugo@quicinc.com> writes:
> 
>> "make htmldocs" generates a warning about leds-qcom-lpg -
>> "Documentation/leds/leds-qcom-lpg.rst: WARNING: document isn't included
>> in any toctree"
>>
>> Add leds-qcom-lpg to the leds index to fix this warning.
>>
>> Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> ---
>>   Documentation/leds/index.rst | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
>> index e5d63b9..014e009 100644
>> --- a/Documentation/leds/index.rst
>> +++ b/Documentation/leds/index.rst
>> @@ -25,4 +25,5 @@ LEDs
>>      leds-lp5562
>>      leds-lp55xx
>>      leds-mlxcpld
>> +   leds-qcom-lpg
>>      leds-sc27xx
> 
> Already fixed in docs-next.
> 
> Thanks,
> 
> jon

Ah.  Missed that.  Thanks.
