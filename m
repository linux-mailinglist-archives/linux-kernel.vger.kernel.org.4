Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241076AC3FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCFOwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjCFOwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:52:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A672F7A4;
        Mon,  6 Mar 2023 06:52:11 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Di5W5007503;
        Mon, 6 Mar 2023 14:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CoparZnNpF8ldgrpBfRtdxPsE4hFBtRG0ld7fcT6gC8=;
 b=XqgQ+EEhYXLBzaZp9WwRettk7Dseq6n0tLTnoSfxIAPIu5WFCX0OUJF9la/Bb0nSivQ+
 ByuZKgXcbpEzUGlyd+/Nx11V0mofc2KzDvn+Bcn36pQZwhRoikLcB6V6clOYr2m5+C4n
 GfiIeIUObZuSj4B3pKoHwMvGMQXiDVrHcqPe22dvhtWklKGtQJ44KaUahN8rRMH/VHu9
 +QWFreeqYpfino0nNIE3CuiXAj1BWvRB0lBpzgwixSstWEQ1tCXfk9DBlQshaPX0eSRD
 xa+l65em+DCYVQkILnadYQ5mvhfzdwpUj/IPpv1CI9qi3ZzzfHwAznB2n3qVqxwf5+Hm /w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p418750tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 14:33:49 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326EXmHG010409
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 14:33:48 GMT
Received: from [10.201.3.104] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 06:33:44 -0800
Message-ID: <6d5ea6d8-d8c6-0875-f0b3-2fcaac64899d@quicinc.com>
Date:   Mon, 6 Mar 2023 20:03:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/5] mtd: rawnand: qcom: Add initial support for qspi nand
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <quic_srichara@quicinc.com>,
        <qpic_varada@quicinc.com>, <quic_sjaganat@quicinc.com>
References: <1602307902-16761-1-git-send-email-mdalam@codeaurora.org>
 <1602307902-16761-3-git-send-email-mdalam@codeaurora.org>
 <20201029100751.713e27df@collabora.com>
 <b70ddb40-a1f1-f967-6b7b-057a39b0bcc2@quicinc.com>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <b70ddb40-a1f1-f967-6b7b-057a39b0bcc2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2jpZ0Qo5wMLVWlkDhIdaNydO2Jvw1oGR
X-Proofpoint-ORIG-GUID: 2jpZ0Qo5wMLVWlkDhIdaNydO2Jvw1oGR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_08,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060127
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/6/2023 7:45 PM, Md Sadre Alam wrote:
>
> On 10/29/2020 2:37 PM, Boris Brezillon wrote:
>> Hello,
>>
>> On Sat, 10 Oct 2020 11:01:39 +0530
>> Md Sadre Alam <mdalam@codeaurora.org> wrote:
>>
>>> This change will add initial support for qspi (serial nand).
>>>
>>> QPIC Version v.2.0 onwards supports serial nand as well so this
>>> change will initialize all required register to enable qspi (serial
>>> nand).
>>>
>>> This change is supporting very basic functionality of qspi nand flash.
>>>
>>> 1. Reset device (Reset QSPI NAND device).
>>>
>>> 2. Device detection (Read id QSPI NAND device).
>> Unfortunately, that's not going to work in the long term. You're
>> basically hacking the raw NAND framework to make SPI NANDs fit. I do
>> understand the rationale behind this decision (re-using the code for
>> ECC and probably other things), but that's not going to work. So I'd
>> recommend doing the following instead:
>>
>> 1/ implement a SPI-mem controller driver
>> 2/ implement an ECC engine driver so the ECC logic can be shared
>>     between the SPI controller and raw NAND controller drivers
>> 3/ convert the raw NAND driver to the exec_op() interface (none of
>>     this hack would have been possible if the driver was using the new
>>     API)
>>
>> Regards,
>>
>> Boris
>>
>    Sorry for late reply, again started working on this feature 
> support.  The QPIC v2 on wards there is serial nand support got added 
> , its not a standard SPI controller
>
>    its QPIC controller having support for serial nand. All SPI related 
> configuration done by QPIC hardware and its not exposed as SPI bus to 
> the external world. Only based on
>
>    QPIC_SPI_CFG = 1, serial functionality will get selected. So that 
> no need to implement as SPI-mem controller driver, since its not a SPI 
> controller.
>
>   Please check the below diagram for top view of QPIC controller.
>
>
___________________________________________________________________________

| QPIC wrapper                        |

             AHB master IF                                     | 
|_______________________                __________________________     
             |

<-------------------------------------------------     |                 
   |          QPIC                                |             |    
QPIC_IO_MACRO | |--------------------------------------------->Serial 
NAND IOs

|                        |     QPIC_SPI_CFG = 1     ----> |             
| (Control SPI Bus internally) | 
|--------------------------------------------->

| |                                                   | | 
|                 |

| |                                                   | | 
|                  |

| |                                                   | 
|__________________________|                 |

| |                                                    |          _ 
___________________________                 |

| |                                                    | |               
Ebi2_ext_if                        | |

|                        |   QPIC_SPI_CFG=0     -------> | | | 
|------------------------------------------------->

| |                                                     | | | 
|-------------------------------------------------->Parallel NAND IOs

<----------------------------------------------------   |               
    |________________________ |           | __________________________| 
              |

           AHB Slav IF | |

|_____________________________________________________________________________|

>
>
>
>   Regards,
>
> Alam.
>
>
>>
