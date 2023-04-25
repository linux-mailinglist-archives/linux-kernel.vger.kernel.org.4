Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB436EE193
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjDYMFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjDYMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:05:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB133AA9;
        Tue, 25 Apr 2023 05:05:01 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PBqFac007063;
        Tue, 25 Apr 2023 12:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/8ly7NB0EZiI9RE6wDMPvrgIWMIFuN3yFNswmt8ospk=;
 b=olL/tHMn1R50/Qy/51hfVODQtkWyG0ReUdGDWOuwbuC4otXgrxfiBPIMh2IUpWTzXFsD
 i0kpN5o4gmRXZI5IvJc+U/BRnETgsph9TdCE9kcBWjndeRLphabWDVN3x0YJcTP3Uo97
 siWMW/s42pbGFA1mP512GMcLRJEjUogAiLUqtyLK66HiNrnDyNgQWDoAArhxChT8z+4M
 q/RwbH2P6wJlUHf6ELFre5htcfgvwO3NcdTqaeLqUfwZMe6Mjbc56ZzFh+rq/ka1KXC7
 cRBRviBYcy9lUfqhTyLeuUdRDBQ8NFgIcHumn2WA7gMQzAY/SJln6T4IDPOjQwpHgFDM TA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q6ec98ew4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 12:04:52 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33P8oQ9V006400;
        Tue, 25 Apr 2023 12:04:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3q4778v2rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 12:04:13 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33PC4B1j15663732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 12:04:12 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBB8F58056;
        Tue, 25 Apr 2023 12:04:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 813635803F;
        Tue, 25 Apr 2023 12:04:10 +0000 (GMT)
Received: from [9.160.16.18] (unknown [9.160.16.18])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Apr 2023 12:04:10 +0000 (GMT)
Message-ID: <1202328d-de94-7e9d-c0e8-bb1bd3e9a988@linux.ibm.com>
Date:   Tue, 25 Apr 2023 07:04:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] Update Kconfig and Makefile.
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20230424184726.2091-1-dtsen@linux.ibm.com>
 <20230424184726.2091-6-dtsen@linux.ibm.com>
 <ZEdpHDpm19XwN3dG@gondor.apana.org.au>
From:   Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <ZEdpHDpm19XwN3dG@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JOMv6Qr3aSMatP0sBxYQFbwXkjutJ7Bu
X-Proofpoint-GUID: JOMv6Qr3aSMatP0sBxYQFbwXkjutJ7Bu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_05,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=979 malwarescore=0
 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250108
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was not sure at the time when I use IS_REACHABLE.  Will fix it in init 
code.

Thanks.

-Danny

On 4/25/23 12:46 AM, Herbert Xu wrote:
> On Mon, Apr 24, 2023 at 02:47:26PM -0400, Danny Tsen wrote:
>> +config CRYPTO_CHACHA20_P10
>> +	tristate "Ciphers: ChaCha20, XChacha20, XChacha12 (P10 or later)"
>> +	depends on PPC64 && CPU_LITTLE_ENDIAN
>> +	select CRYPTO_SKCIPHER
> I thought your IS_REACHABLE test was so that you could build this
> without the Crypto API? Colour me confused.
>
> Cheers,
