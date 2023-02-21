Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BE269D915
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjBUC5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 21:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjBUC5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:57:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FA92139;
        Mon, 20 Feb 2023 18:57:36 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L0x4TK006750;
        Tue, 21 Feb 2023 02:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Qt5A8aL5VkNz/RvRzAD7hRDQ3ubedALcRRkudlM+bJM=;
 b=Cu4xUF6T+XdWVQ0Pbp2RhwPALBzUDRgpetzjNWCVxOpuVTAhNKBoEgfjjgcsmLuZBmKq
 5pjTeTfpl3FpT08ymMRRM1Kcqsho6O75Bp0FUr+DWxlPHecsFl8AEuYooi/61iAyLTBG
 gnWvvWpsZ2HYxrEMsVTKBQhI27LaP/iXR782O7NssCf6qU6sJIP20HXLSN3d8cGDTS/g
 C4PUGNghyZbEHVxHeYOe/a5pf3VSnFxh+apBlPXFrRdFqBtsCukoBJg3WpfurQI1CLVn
 uRly3AuHdj6l3MfowMo+p5RuFPIXsovSDTOhet31sxoMHgNt3nuCbEfTSILMWQzctMxG Bw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvknya4b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 02:57:28 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31L0Y6WL000573;
        Tue, 21 Feb 2023 02:57:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ntpa74h9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 02:57:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31L2vPu466191640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 02:57:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 215CF5805E;
        Tue, 21 Feb 2023 02:57:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFFD058043;
        Tue, 21 Feb 2023 02:57:24 +0000 (GMT)
Received: from [9.163.84.166] (unknown [9.163.84.166])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 02:57:24 +0000 (GMT)
Message-ID: <b79673c7-a626-22e0-3e21-fc3e425f153f@linux.ibm.com>
Date:   Mon, 20 Feb 2023 20:57:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v4 1/6] Update Kconfig and Makefile.
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@us.ibm.com
References: <20230220204224.4907-1-dtsen@linux.ibm.com>
 <20230220204224.4907-2-dtsen@linux.ibm.com>
 <Y/QwUWVhaUZ8fjO7@gondor.apana.org.au>
From:   Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <Y/QwUWVhaUZ8fjO7@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FIDKi037QG-6C44K3j7NIbwO7V6hjcnl
X-Proofpoint-ORIG-GUID: FIDKi037QG-6C44K3j7NIbwO7V6hjcnl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_19,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

I am not sure why my patch has to build one-by-one?  I compiled with one 
make.  Here is the output.

   CALL    scripts/checksyscalls.sh
   DESCEND objtool
   CC [M]  arch/powerpc/crypto/aes-gcm-p10-glue.o
   AS [M]  arch/powerpc/crypto/aes-gcm-p10.o
   AS [M]  arch/powerpc/crypto/ghashp8-ppc.o
   AS [M]  arch/powerpc/crypto/aesp8-ppc.o
   LD [M]  arch/powerpc/crypto/aes-gcm-p10-crypto.o
   CHK     kernel/kheaders_data.tar.xz
   MODPOST Module.symvers
   CC [M]  arch/powerpc/crypto/aes-gcm-p10-crypto.mod.o
   LD [M]  arch/powerpc/crypto/aes-gcm-p10-crypto.ko

Can Stephen explain why he is compiling one-by-one?  Any output I can see.

Thanks.

-Danny

On 2/20/23 8:45 PM, Herbert Xu wrote:
> On Mon, Feb 20, 2023 at 03:42:19PM -0500, Danny Tsen wrote:
>> Defined CRYPTO_AES_GCM_P10 in Kconfig to support AES/GCM
>> stitched implementation for Power10 or later CPU.
>>
>> Added a new module driver aes-gcm-p10-crypto.
>>
>> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
>> ---
>>   arch/powerpc/crypto/Kconfig  | 17 +++++++++++++++++
>>   arch/powerpc/crypto/Makefile | 13 +++++++++++++
>>   2 files changed, 30 insertions(+)
> Stephen mentioned this before, your patches must compile one-by-one.
> This patch doesn't build by itself so you should fix it.
>
> Thanks,
