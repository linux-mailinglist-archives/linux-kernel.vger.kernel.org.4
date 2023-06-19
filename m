Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28F4735173
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjFSKEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjFSKEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:04:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940F6E59;
        Mon, 19 Jun 2023 03:04:28 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J9MZie027177;
        Mon, 19 Jun 2023 10:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EdEtN+o8C25mmqwDYGCqUsh3TXJ29oh+zpreQVrX0Uw=;
 b=fjovvVVzZSoIoWjrTTCriOhGIbwMWAZnx338qVOpbhGWRXkYlmSRlO+hhHTu/cRegyEl
 Mr0tYJ633CFNnLWeGxrYx8z/ZYmXoRVMPsiB8urIyE1Y6feucfoXU8syC67r7akgeROP
 D5bVCsoPWpnrbXXlQ2If+2A3f5X29Uq7MbGei7nmCJz97w+bV/NXTVvEJUSTmVMHjB7M
 0a7LFTFWBbKEMryPP/NfjWl6qiVX4qTYBJrD/mxC+7EQgZ0PuN6IFuUKOGqEWfqfzAeE
 VcGT5eY1XqWw272LayeJD3Q48n+I+TZCN9z3mmQ2ApqgnUXotFGBXJoavfU+3WNw8NhT BQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ramb611w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 10:04:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35J5BQdw025864;
        Mon, 19 Jun 2023 10:04:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3r943e19uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 10:04:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35JA4GWH57409962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 10:04:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8285E2004B;
        Mon, 19 Jun 2023 10:04:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D29542004F;
        Mon, 19 Jun 2023 10:04:15 +0000 (GMT)
Received: from [9.171.4.59] (unknown [9.171.4.59])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jun 2023 10:04:15 +0000 (GMT)
Message-ID: <4f2afa34-830a-3c17-99e7-1cb5b874e7ce@linux.ibm.com>
Date:   Mon, 19 Jun 2023 12:04:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] s390/net: lcs: use IS_ENABLED() for kconfig detection
To:     patchwork-bot+netdevbpf@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, wenjia@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
References: <20230615222152.13250-1-rdunlap@infradead.org>
 <168690302072.8823.785077843270614259.git-patchwork-notify@kernel.org>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <168690302072.8823.785077843270614259.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jgyEbaYa6AtKo8QDsTl54lZEVLR9-CNq
X-Proofpoint-GUID: jgyEbaYa6AtKo8QDsTl54lZEVLR9-CNq
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=864 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.06.23 10:10, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
> 
> On Thu, 15 Jun 2023 15:21:52 -0700 you wrote:
>> When CONFIG_ETHERNET=m or CONFIG_FDDI=m, lcs.s has build errors or
>> warnings:
>>
 
IIUC, CONFIG_ETHERNET is bool.
I reproduced this with CONFIG_ETHERNET=n and CONFIG_FDDI=m,
and verified that it does compile with your patch.

Thank you Randy for correcting this.

>> ../drivers/s390/net/lcs.c:40:2: error: #error Cannot compile lcs.c without some net devices switched on.
>>    40 | #error Cannot compile lcs.c without some net devices switched on.
>> ../drivers/s390/net/lcs.c: In function 'lcs_startlan_auto':
>> ../drivers/s390/net/lcs.c:1601:13: warning: unused variable 'rc' [-Wunused-variable]
>>  1601 |         int rc;
>>
>> [...]
> 
> Here is the summary with links:
>   - s390/net: lcs: use IS_ENABLED() for kconfig detection
>     https://git.kernel.org/netdev/net-next/c/128272336120
> 
> You are awesome, thank you!

