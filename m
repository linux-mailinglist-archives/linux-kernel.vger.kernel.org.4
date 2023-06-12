Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6CF72B891
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjFLHX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjFLHX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:23:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFBD1BCC;
        Mon, 12 Jun 2023 00:18:57 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35C6pRXn022968;
        Mon, 12 Jun 2023 06:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=K3D1Sz4WKpAet6+SohT1HO2ZPLd63LAEGwR41ci7owQ=;
 b=hiQOK8rtOxwteTG2TFSZJT2oMJHVl6UcLEVjuDk/heq1ndUcDOXvVSJ0pNeDnUMuIV2e
 294XxaTD+B9svORAUnW99zsxtRvWQG8sEPApMFSpK/nRDAjF7qHSqhz5F7FUrt8NZd0A
 j//guqw1xA5UWXeWVUfvMkJOQb82pilY/RDXaijNS5z64fDLuMzFD7KKnuIQI/S7NDO8
 3EHYEKuGCimMY7b0Kp7aaUwRXkOS+hJ2EyzvoAKKZYUpxwTeuaiJiHA4EYwdojAadtVx
 Xxg2RXRZo9OruaJQYfQQcSI+WbJ2MHI37hKkAUgW0+5SkyAzv9AqY+4jB9iepfgyJchT 5w== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r5xfb054r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 06:59:31 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35C5PDtZ002065;
        Mon, 12 Jun 2023 06:59:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r4gt4rxth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 06:59:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35C6xOD057868726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 06:59:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE1EA20040;
        Mon, 12 Jun 2023 06:59:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F60E2004B;
        Mon, 12 Jun 2023 06:59:24 +0000 (GMT)
Received: from [9.171.42.131] (unknown [9.171.42.131])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jun 2023 06:59:24 +0000 (GMT)
Message-ID: <23bbc436-f5f5-0d77-900b-81aa57e8f3ee@linux.ibm.com>
Date:   Mon, 12 Jun 2023 08:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: linux-next: Tree for Jun 9 (drivers/s390/char/uvdevice.o)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20230609140618.532c4bcc@canb.auug.org.au>
 <8db150f5-0a37-5ee2-c221-9cf150420fc2@infradead.org>
Content-Language: en-US
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <8db150f5-0a37-5ee2-c221-9cf150420fc2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bf7kRgOBcDe8b13SkfWfIwRWFEllUIpX
X-Proofpoint-ORIG-GUID: Bf7kRgOBcDe8b13SkfWfIwRWFEllUIpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_04,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/23 05:48, Randy Dunlap wrote:
> 
> 
> On 6/8/23 21:06, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20230608:
>>
> 
> s390-linux-ld: drivers/s390/char/uvdevice.o: in function `cpu_feature_match_S390_CPU_FEATURE_UV_init':
> uvdevice.c:(.init.text+0xe0): undefined reference to `uv_info'
> 
> 
> 
> # CONFIG_PROTECTED_VIRTUALIZATION_GUEST is not set
> 
> Also, KVM is not set, so PGSTE is not set.
> 

Thanks for the report, we'll fix that up
