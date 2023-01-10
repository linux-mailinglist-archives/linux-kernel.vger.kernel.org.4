Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E63F66432E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbjAJOXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbjAJOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:23:00 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC28F51311;
        Tue, 10 Jan 2023 06:22:58 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AEH3eB032674;
        Tue, 10 Jan 2023 14:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=yECEqCQiHABnizLQXXGBiPXiREXHpGO1VURQLRTIjCM=;
 b=sAGs979adpx6xWvwrs46Uou4RE2Nf9bUoCljf/HFUIKX0IMwM9bHr5cDzKyNROke0pqL
 qH0s4Unc6UPVxB3mRpv5B+ybQbYcnyJptyigPFyQprwndgs4osXkeVmBSDeHhDyM1GJn
 8ABvqfA0NTnNooxQuqfxIq6RXZefpo7RrCy0yNGfcdkf7vVFChIf2f+V5MxyKHFuUsHP
 BAcsTONo6r5Z8oiTKz6AUvnidvJWBdpgKeDNf0zkGRu+NBYfq6xTXSvW3EdkSW1BV8gJ
 cVd3nIfIkXrmRfQl7LEEb5vTAKefWbIA32iPTRwq5c0Q5PENep17pQJGDRkP88+aT6e3 rQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n19n2r68v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 14:22:46 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30A89VO0024687;
        Tue, 10 Jan 2023 14:22:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3my0c6myq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 14:22:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30AEMe5624052436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 14:22:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E8C72004F;
        Tue, 10 Jan 2023 14:22:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D13020049;
        Tue, 10 Jan 2023 14:22:40 +0000 (GMT)
Received: from osiris (unknown [9.152.212.250])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 10 Jan 2023 14:22:40 +0000 (GMT)
Date:   Tue, 10 Jan 2023 15:22:38 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the s390 tree
Message-ID: <Y710ri9sVzmWNpE6@osiris>
References: <20230110202221.2e284ba0@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110202221.2e284ba0@canb.auug.org.au>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qsHL9psv4mIuCKshV0XgzyBQ2rPoVSR-
X-Proofpoint-GUID: qsHL9psv4mIuCKshV0XgzyBQ2rPoVSR-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_04,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1011 mlxlogscore=957
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:22:21PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the s390 tree, today's linux-next build (s390 allmodconfig)
> failed like this:
> 
> drivers/s390/char/con3270.c:43:24: error: 'condev' defined but not used [-Werror=unused-variable]
>  static struct tty3270 *condev;
>                         ^~~~~~
> 
> Caused by commit
> 
>   c17fe081ac1f ("s390/3270: unify con3270 + tty3270")

Thank you for reporting. This should be fixed now:
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=9cab4f7d98eee90b762ffbc87055c9499d51a635
