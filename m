Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3846E2440
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjDNN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNN32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:29:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019286E87;
        Fri, 14 Apr 2023 06:29:26 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EDIdW1025912;
        Fri, 14 Apr 2023 13:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=L17NEor15alxJnJyRZpYEiLZmDLO42JcdjMLI+tQ52s=;
 b=k28EzNguGaMswoOu1OjTLikcPom2JuC/5+dGXxoeRcKzkRnKwqEGPvrEsMxT9GDHJbVU
 UKr0034wf3T852k1E50/Ne7HEiLr43ahlNP0J/CG4ZWPeBi1q354txo+rI0daGDIVNv0
 c26oKF/S8IkuxHypxBOHbdCCqPHOy+NwsJKGrPC+joI0INGaayFCuVWoXaCYM2QtKHdu
 Gauj8Vi6pAz/myts07wazLGOQUeY+rCXRmdWwKHkVqBbRIXncZBdpp/muSBDMVoqMIBn
 iuhE9Gf/IHj5HM/3XdFXDotlSYnCulRiIvX2wDTsgAxnwS6aTlldpiChDWVSu6BSSr8I Hw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3py7kt8ba9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 13:29:12 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33EDNMdB027913;
        Fri, 14 Apr 2023 13:29:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3pu0jjs2v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 13:29:11 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33EDTAfb10879716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 13:29:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F18FE5805E;
        Fri, 14 Apr 2023 13:29:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 103BE58051;
        Fri, 14 Apr 2023 13:29:09 +0000 (GMT)
Received: from [9.160.183.133] (unknown [9.160.183.133])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Apr 2023 13:29:08 +0000 (GMT)
Message-ID: <29e7972a-17ad-638e-fa2d-1c65ae619c41@linux.ibm.com>
Date:   Fri, 14 Apr 2023 08:29:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] Remove POWER10_CPU dependency.
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20230413194625.10631-1-dtsen@linux.ibm.com>
 <20230413194625.10631-2-dtsen@linux.ibm.com>
 <87ildya9xd.fsf@mpe.ellerman.id.au>
From:   Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <87ildya9xd.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TAZXTrc9NthrcIflRSRgsBWMNDFafO9O
X-Proofpoint-ORIG-GUID: TAZXTrc9NthrcIflRSRgsBWMNDFafO9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_06,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140118
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michael.

-Danny

On 4/14/23 8:08 AM, Michael Ellerman wrote:
> Danny Tsen <dtsen@linux.ibm.com> writes:
>> Remove Power10 dependency in Kconfig and detect Power10 feature at runtime.
> ... using the existing call to module_cpu_feature_match() :)
>
>> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
>> ---
>>   arch/powerpc/crypto/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>
> cheers
>
>> diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
>> index 1f8f02b494e1..7113f9355165 100644
>> --- a/arch/powerpc/crypto/Kconfig
>> +++ b/arch/powerpc/crypto/Kconfig
>> @@ -96,7 +96,7 @@ config CRYPTO_AES_PPC_SPE
>>   
>>   config CRYPTO_AES_GCM_P10
>>   	tristate "Stitched AES/GCM acceleration support on P10 or later CPU (PPC)"
>> -	depends on PPC64 && POWER10_CPU && CPU_LITTLE_ENDIAN
>> +	depends on PPC64 && CPU_LITTLE_ENDIAN
>>   	select CRYPTO_LIB_AES
>>   	select CRYPTO_ALGAPI
>>   	select CRYPTO_AEAD
>> -- 
>> 2.31.1
