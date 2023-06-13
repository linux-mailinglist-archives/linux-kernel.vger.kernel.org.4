Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A39872DA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjFMHL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjFMHLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:11:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C76B13A;
        Tue, 13 Jun 2023 00:11:52 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D6pXGf009742;
        Tue, 13 Jun 2023 07:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lHbvjzg+JN1rB6ifJXgO7XUOgQ4ftErpZSvR7J6UnnE=;
 b=osR+kD/VK0enAD8robL8nRNJDEWTG2Rp1a1h/OnSoeA37ApsVCXoA4Ear93/FU5W4sWE
 +Od8nCit8cMY0hj5uIDIFq9QMaHCwc6sHONT1S3kVsQElAZykDjpX01mVNwXE8zn6M+F
 f8P7gAX8QYIXCVU7F9OwZsPTV+/JdaeASSIZ9R951o7rwv7j0EQe0xXmedDDgcSs5rhf
 CPbEd0u1e16bbBXaDckRf19lANq0yXzYNj5G8XXm2gZyibmiajiBIqWs+bkFMtjxYRaJ
 +PTvwbee0ccdGyMW/i593mWIjrFV/hMPd0uCepwxp6oAGqyKRJzIlnMxaeetDUvmsGbD RA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6kjc8h6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 07:11:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35D4tceY020338;
        Tue, 13 Jun 2023 07:11:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt51yfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 07:11:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35D7BXoO38863116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 07:11:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38FF620040;
        Tue, 13 Jun 2023 07:11:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0BA220043;
        Tue, 13 Jun 2023 07:11:32 +0000 (GMT)
Received: from [9.171.86.1] (unknown [9.171.86.1])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jun 2023 07:11:32 +0000 (GMT)
Message-ID: <8701bac9-e604-40cc-74db-18b0ab1e7490@linux.ibm.com>
Date:   Tue, 13 Jun 2023 09:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230613092726.0383cb94@canb.auug.org.au>
Content-Language: en-US
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: linux-next: bad rebase of the kvms390 tree
In-Reply-To: <20230613092726.0383cb94@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5k5a3KuRXkokiz0FQUvyg9Yymq4oO5Eo
X-Proofpoint-GUID: 5k5a3KuRXkokiz0FQUvyg9Yymq4oO5Eo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=986 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 01:27, Stephen Rothwell wrote:
> Hi all,
> 
> The kvms390 tree has been rebased onto Linus' tree incorrectly - it
> includes duplicates of 3 commits from Linus' tree.
> 
> Please fix this up.
> 

@Claudio:
Not sure how you managed to do that.
Please have a look.
