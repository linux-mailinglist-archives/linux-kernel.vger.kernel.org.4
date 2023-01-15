Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EA966B3E0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjAOUe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjAOUez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:34:55 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C2212F23;
        Sun, 15 Jan 2023 12:34:54 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30FEDgwq015903;
        Sun, 15 Jan 2023 20:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=1xzxUn5io4MOqbVROavDWiLZH9RakxX9HiJJQ5zs4R0=;
 b=gHYGsTdgXOFi3d/kiz4uWUuU2aNW/E/tJDJQdqiLHW/uCiBaSZiaRjkJ2bdxmh9Fp3ZE
 uwQc2NA/PCxCA11mBnznC4FfMyZGt+BrIdPeYWAINTtMadsJIgR8JYew1t2a1r3Nmp60
 i0jNPq5L4BuvsOfWn9npOVctn2+4Tib3/8/xF2Dt+vBLl+mD6ZS9Ls8l3jWcXdcIDSkI
 Z1uLdEiZUxQEtiM4BhYJZ5QGG26bQ1kTKFLZ4yuvvNZpCHzq7/hujqC3yyaejGOfybYY
 Bkpf7yI23g8TN2GF6lXcLMAym3oSOSIB/OdcKlzVrE0b7CRj7cac4GC2ISPdApbD9pmY XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n48nt5239-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 20:34:53 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30FKYq8R031007;
        Sun, 15 Jan 2023 20:34:52 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n48nt522y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 20:34:52 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30FARtKM002192;
        Sun, 15 Jan 2023 20:34:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n3knf95qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 20:34:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30FKYlEQ50790670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Jan 2023 20:34:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 460BE20043;
        Sun, 15 Jan 2023 20:34:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8DAB20040;
        Sun, 15 Jan 2023 20:34:46 +0000 (GMT)
Received: from osiris (unknown [9.171.18.28])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 15 Jan 2023 20:34:46 +0000 (GMT)
Date:   Sun, 15 Jan 2023 21:34:45 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/ipl: Use kstrtobool() instead of strtobool()
 (second step)
Message-ID: <Y8RjZQBqWxug5nn8@osiris>
References: <58a3ed2e21903a93dfd742943b1e6936863ca037.1673708887.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a3ed2e21903a93dfd742943b1e6936863ca037.1673708887.git.christophe.jaillet@wanadoo.fr>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I7znFn07prtoGb1HtUXgBGn0dYevvsug
X-Proofpoint-ORIG-GUID: hawnuB-sNZ1KU4KQbCKgkbETYqZHikC_
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_15,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=748 clxscore=1011 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301150163
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 04:08:22PM +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is similar to the serie ([1]) that tries to axed all usages
> of strtobool().
> Most of the patches have been merged in -next.
> 
> Commit d9b25bdf57e4 ("s390/ipl: Use kstrtobool() instead of strtobool()")
> already fixed this file, but a new usage has been introduce by commit
> 87fd22e0ae92 ("s390/ipl: add eckd support").
> 
> This patch has been cross-compiled with make.cross.
> 
> [1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
> ---
>  arch/s390/kernel/ipl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!
