Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92961619A2E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiKDOhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiKDOhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:37:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63F432B9D;
        Fri,  4 Nov 2022 07:34:12 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4DAlnn023752;
        Fri, 4 Nov 2022 14:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=aBeC4NCXkA3s6DXqP+TwBnJxjDQUnPTlKhNwpr0fMwE=;
 b=WrOIRGnvGnVJpRf97ZntvrVRe/fD3xZs7lGeLy92h3xv/V9dhhrnY9RZsCsZQyqH0Kd8
 fIobPUYfxZTv1NqI37ATxjDLonLAdaQw4dv7bioooUHLMdby/HKXdzKHJBYYS9FM9/yz
 BpLhW1m10AzhyghsWnwCj5ZMC7Tc9vKTd46tb1woIczWJyOFVW3g+SZ4vJYsS4JJc0nk
 4ABw/JGNvw0LJmKtAGwvGSycGD3EKWxIWRTJIHHOYMQ9wx8nLrtycpiS3qG1tLTrfHJ0
 hP9oqh35zk53rqJrZkDcNQBJpVfJx+6DSSFmgIwYghCPGR8yQHkCHGMyNUK1poVR2CdA Wg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmpjfhbdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 14:34:11 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A4EL19N016468;
        Fri, 4 Nov 2022 14:34:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3kme349879-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 14:34:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A4EY7Oe5112508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Nov 2022 14:34:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78EE75204E;
        Fri,  4 Nov 2022 14:34:07 +0000 (GMT)
Received: from osiris (unknown [9.145.59.57])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 479E25204F;
        Fri,  4 Nov 2022 14:34:07 +0000 (GMT)
Date:   Fri, 4 Nov 2022 15:34:05 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] random: do not include <asm/archrandom.h> from
 random.h
Message-ID: <Y2Ui3fr7pwKGJzM3@osiris>
References: <20221029010857.161574-1-Jason@zx2c4.com>
 <20221103121740.6684-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103121740.6684-1-Jason@zx2c4.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AwH_zitacjeviaQQd7lDRyCgpevLYE-H
X-Proofpoint-ORIG-GUID: AwH_zitacjeviaQQd7lDRyCgpevLYE-H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_09,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=666 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:17:40PM +0100, Jason A. Donenfeld wrote:
> The <asm/archrandom.h> header is a random.c private detail, not
> something to be called by other code. As such, don't make it
> automatically available by way of random.h.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/powerpc/kernel/setup-common.c | 1 +
>  arch/s390/kernel/setup.c           | 1 +
>  drivers/char/hw_random/s390-trng.c | 1 +
>  drivers/char/random.c              | 1 +
>  include/linux/random.h             | 2 --
>  5 files changed, 4 insertions(+), 2 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
