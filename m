Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5EA7412C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjF1NmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:42:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229501AbjF1NmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:42:15 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SDUbtL021362;
        Wed, 28 Jun 2023 13:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=u0Qd7Mi5Q42tm2xnqxhRAfFdIueDZ16m47hmhgl0Fdg=;
 b=VW2Kr8AtUTxVbLg+B5xmlqEXH8fcKmYxQHCjsxrwuP8iET29pwHb1NBMa65CX56M1SNh
 gI6ttCOTucJXWF41MRzqnfnjGG0GuHkI2N0JGFH193dLGEGXTJLzy9HmfvUq8+rzyH9E
 PFtiznhS86+iiKvJ6mAjRC99ywOPyaoTiyesl81+p1SjUXdBW/baglknCfLxbnULLuhy
 pag4hXWudKI55wLwjFxwul0HEy1AlCAq3Yj82TnZKFWMtPJNLRPytRDNHgfCIQ3zIn7y
 EVC8EXQhmdBDOYVAgEzuVy2m54ByORWwSisqZGD7KvbQak0u7T+PT7PdDwo/nMBYDfh7 lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgnteghb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 13:41:35 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35SDWNjd023915;
        Wed, 28 Jun 2023 13:41:34 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgntegh8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 13:41:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBRBxV007291;
        Wed, 28 Jun 2023 13:41:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rdr452j6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 13:41:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SDfRCI41550130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 13:41:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1BF120043;
        Wed, 28 Jun 2023 13:41:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B24CE20040;
        Wed, 28 Jun 2023 13:41:26 +0000 (GMT)
Received: from [9.171.10.167] (unknown [9.171.10.167])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 13:41:26 +0000 (GMT)
Message-ID: <a05a7c3a-0f2f-c3be-3630-6774a26b994f@linux.ibm.com>
Date:   Wed, 28 Jun 2023 15:41:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] s390/net: lcs: fix build errors when FDDI is a loadable
 module
To:     Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman <simon.horman@corigine.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230621213742.8245-1-rdunlap@infradead.org>
 <98375832-3d29-1f03-145f-8d6e763dd2d2@linux.ibm.com>
 <ZJP99hSRt5MakBXC@corigine.com>
 <3da03251-21ac-b41f-593d-cbc9ac9f86f6@linux.ibm.com>
 <7f585168-7296-58aa-7fdb-c2aa08f346f4@infradead.org>
 <510b6216-35e5-5ea1-525f-5fab35b901e0@infradead.org>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <510b6216-35e5-5ea1-525f-5fab35b901e0@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ew8dw-WLMZw9y1snxnhb174TagLqwCvA
X-Proofpoint-ORIG-GUID: rcr6kvi0Y8dIFdlXI8A5FT4zron55KQK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=524
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.06.23 07:06, Randy Dunlap wrote:
> Hi Alexandra, Simon, others,
> 
> Here is v2 of this patch. I will send it formally after the merge window closes.
> 
> Thanks for all of your help.
> ---

Thank you for the patch, Randy.

As suggested by Christian Bornträger, I did some research, whether the FDDI part of the LCS driver
could be removed. And actually there is no s390 machine above the minimum architecture level that
can have an FDDI interface.
I will send a patch to remove the FDDI option from the lcs driver.

I apologize that I was not aware of that earlier. And thank you again for pointing out the issue
with FDDI as a module.

Alexandra
