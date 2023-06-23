Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7482E73BA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjFWOZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjFWOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:25:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7F0BC;
        Fri, 23 Jun 2023 07:25:11 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NEKpgA031340;
        Fri, 23 Jun 2023 14:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0xPSbAvfexZJBAzkGJRkUdUZf4Xgk8KIZ+PbAcOdwjs=;
 b=rukP4B+t1Fb6qKgwvKNHDcswwABhBAXTOoatUqjVtyr6YJqY6opazJ7AETs4cwLmBy8P
 n8EevD8Vo3dgHwQj46KKpvmCVKfw8dmvx1J9gHqXLxKE7d5wo7tBCKB0jbXT9tMhfeeO
 ExiuS7V3j/1v8j5SwawqLhNkiTpUCCQ8kEls2Xz7M7Q2dMR4aKt6TwaAoBpcIYxTN5Xd
 30iPII+6r8GIIVgh1KOOY/tuoX64/cI3FgQOsUeQ4ElHINTXzcmJ+lv0tvilX9fjrtnK
 m1LdFawvrPBJcIgyEY7I8uFFrry97h/LjuXfZTxg3cxuCTI6A05cV1Az0ZjhwYnAnHH4 RA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rdc4n1d68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:25:09 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35N4RDbv001200;
        Fri, 23 Jun 2023 14:25:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r94f5b5g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:25:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35NEP4aR60752294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 14:25:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FA0D2004B;
        Fri, 23 Jun 2023 14:25:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 767EE20043;
        Fri, 23 Jun 2023 14:25:03 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.5.134])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 23 Jun 2023 14:25:03 +0000 (GMT)
Date:   Fri, 23 Jun 2023 16:25:01 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [GIT PULL] s390 updates for 6.5
Message-ID: <ZJWrPSb631x4NIh9@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <ZJWlqGlx6LymL7lO@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJWlqGlx6LymL7lO@tuxmaker.boeblingen.de.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IkLRBTtTnjbNXjH5kvwjMa-2td11c1GE
X-Proofpoint-GUID: IkLRBTtTnjbNXjH5kvwjMa-2td11c1GE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=621 bulkscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 04:01:13PM +0200, Alexander Gordeev wrote:
> Hello Linus,
> 
> please pull s390 changes for 6.5.

Sorry, this is rather for 6.4 final.

Thanks!
