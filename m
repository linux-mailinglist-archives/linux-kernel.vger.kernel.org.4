Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5665F7166F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjE3P0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjE3P0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:26:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8AEE5;
        Tue, 30 May 2023 08:26:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UFOP9N017821;
        Tue, 30 May 2023 15:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oUOQK8Iz8aYCeBXG6GeIOPm60eWDEU6fa3vZrPfglYE=;
 b=bfx10SnjEyW4j8IUPsFHElgMu0ci6XZ5U6b5E6ERkzpOeks/Uh3FgilKHpaxp23yYG3W
 XtewSnKbzATaalYsJaJ/rAlQ2cXAvgz03riYUYjkR8wW/aR9p6ok6zXlyZOeLkwIrqMs
 1iJxQL3hO5W2x4/VnEcaw2LqShZ52EF3HS2TcpFtuyiUFBI+2Tp2NdvAfFHX7Pr4ybAT
 bLolT8EHQ/9cTXscUyv2T84lGUsn159ijs/HO4vZ81Blxaz8CW+IAi8BG9IU5j8LbNpd
 Rq6gb91FhZzBK8aRD2ksHbYtkcSaDkwa7VhG8YXKlm53LBy5uEm2lRCEEpRo6/Olspwb Ow== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qw83csg47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 15:26:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34UFQX5x006278
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 15:26:33 GMT
Received: from [10.216.63.60] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 30 May
 2023 08:26:30 -0700
Message-ID: <498a0b96-4c40-cad6-8da7-e9819035ef22@quicinc.com>
Date:   Tue, 30 May 2023 20:56:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1685421871-25391-1-git-send-email-quic_prashk@quicinc.com>
 <2023053058-baffling-unveiling-e597@gregkh>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023053058-baffling-unveiling-e597@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zPe4zLltf7nXpYY-Sg6lJUPjos-AOlzU
X-Proofpoint-GUID: zPe4zLltf7nXpYY-Sg6lJUPjos-AOlzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_11,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=822 priorityscore=1501 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300123
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30-05-23 07:58 pm, Greg Kroah-Hartman wrote:
> On Tue, May 30, 2023 at 10:14:31AM +0530, Prashanth K wrote:
>> Currently if we bootup a device without cable connected, then
>> usb-conn-gpio won't call set_role() since last_role is same as
>> current role. This happens because during probe last_role gets
>> initialised to zero.
>>
>> To avoid this, added a new constant in enum usb_role, last_role
>> is set to USB_ROLE_UNKNOWN before performing initial detection.
>>
>> While at it, also handle default case for the usb_role switch
>> in cdns3 to avoid build warnings.
>>
>> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> 
> Breaks the build :(
> 
> Please be more careful when submitting stuff, especially on v6 of a
> patch :(

Hi, sorry for the trouble, I didn't see any issue in while building 
locally nor any warning/errors from test robot. Can you please point me 
to the error report if available. If the build is breaking due to enum 
value USB_ROLE_UNKNOWN unhandled in switch cases of other drivers, then 
i will revert thing back to v1 where i used a macro for USB_ROLE_UNKNOWN 
in usb-conn-gpio driver. Something like this in usb-conn-gpio.c would 
can help us avoid adding default case in other drivers using usb_role.

#define USB_ROLE_UNKNWON (USB_ROLE_NONE - 1)

Please let me know.

Thanks,
Prashanth K
