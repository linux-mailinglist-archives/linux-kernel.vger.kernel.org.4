Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F0269D922
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjBUDFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjBUDFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:05:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65017233F8;
        Mon, 20 Feb 2023 19:05:30 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L2hmLs015917;
        Tue, 21 Feb 2023 03:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=O07ApxOOjxYzE6kswAFlfApRGRGaC9bTfX01xlm9QgA=;
 b=mfWMmCaBxlb/dXPtgnRLhzXVwXLgpccNquFG2aKI8YH2UpRLceJ7vgqESzEVJjVcoKH1
 GRrurmwDudYfK6zTDp+44EfSHJT2TItq/YRNZkx9LjdfVLvUqD83uXogBkz30+CdFf9v
 NhqbAAfnZnxTvOg1si7LV/qp4tPoM12Fmza3w7+rrlnYQtvABMHr2Lf4sHzq9lVRyaAP
 1/Jb164lGUk7F58p+lmgyFMH5pR3PmZxtZ8jZ9FkzoDwksA3eLoTSIqSFcRPocPQ2AeU
 UFRXEB9s/Rw+RuGknlune7OTsaXQdKaSfRl7zJhib3V5ja39m4ML8ECg59IOY59eiWQh Pg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvjbcc3hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 03:05:18 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31L0Hdao011396;
        Tue, 21 Feb 2023 03:05:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3ntpa7chuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 03:05:17 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31L35GWA61079810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 03:05:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74A0358065;
        Tue, 21 Feb 2023 03:05:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F15F58060;
        Tue, 21 Feb 2023 03:05:16 +0000 (GMT)
Received: from [9.163.84.166] (unknown [9.163.84.166])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 03:05:16 +0000 (GMT)
Message-ID: <72d189d2-f5d9-f268-4ccd-4f213a7b99e8@linux.ibm.com>
Date:   Mon, 20 Feb 2023 21:05:16 -0600
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
 <b79673c7-a626-22e0-3e21-fc3e425f153f@linux.ibm.com>
 <Y/QzjvCSgmGKPjD8@gondor.apana.org.au>
From:   Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <Y/QzjvCSgmGKPjD8@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8p21Zx1121T4Bm4YQtK4rMFyvbk7DB4M
X-Proofpoint-ORIG-GUID: 8p21Zx1121T4Bm4YQtK4rMFyvbk7DB4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_19,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=919 lowpriorityscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

Thanks for the explanation.  Will re-post the patch series.

Thanks.

-Danny

On 2/20/23 8:59 PM, Herbert Xu wrote:
> On Mon, Feb 20, 2023 at 08:57:24PM -0600, Danny Tsen wrote:
>> Hi Herbert,
>>
>> I am not sure why my patch has to build one-by-one?  I compiled with one
>> make.  Here is the output.
>>
>>    CALL    scripts/checksyscalls.sh
>>    DESCEND objtool
>>    CC [M]  arch/powerpc/crypto/aes-gcm-p10-glue.o
>>    AS [M]  arch/powerpc/crypto/aes-gcm-p10.o
>>    AS [M]  arch/powerpc/crypto/ghashp8-ppc.o
>>    AS [M]  arch/powerpc/crypto/aesp8-ppc.o
>>    LD [M]  arch/powerpc/crypto/aes-gcm-p10-crypto.o
>>    CHK     kernel/kheaders_data.tar.xz
>>    MODPOST Module.symvers
>>    CC [M]  arch/powerpc/crypto/aes-gcm-p10-crypto.mod.o
>>    LD [M]  arch/powerpc/crypto/aes-gcm-p10-crypto.ko
>>
>> Can Stephen explain why he is compiling one-by-one?  Any output I can see.
> Your patch-series should be bisectable.  That is, if I apply
> only the first patch, it should still build in all configurations.
>
> Your first patch only adds the Kconfig option and Makefile rules
> without any actual code.  So it will fail to build because the
> code is simply not there.
>
> Normally we put the Kconfig/Makefile update at the end of the
> series to prevent this.
>
> Cheers,
