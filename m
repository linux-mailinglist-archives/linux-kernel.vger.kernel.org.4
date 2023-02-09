Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACBA691204
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjBIUN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBIUN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:13:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8591E2D171;
        Thu,  9 Feb 2023 12:13:26 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319K2GAk015494;
        Thu, 9 Feb 2023 20:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vcJjJdk6QEX8L6WsXwfTpKjSPrRPcFjdQt2YkY9eoko=;
 b=LokNXZptfpDFziM/NpqWppV32MINQ4fMvfjKavWNWYr+XiDMDKPYqgI0Idz1Vq0SSi7b
 4IO9XsttsxOBVulJagvWqhaUhKbYRcUEVKpg4A7P0UMtXxyUjyi+zq8XGE6ue3sjtouV
 9s1GwYSa4QUlm7WcqGCz7MBT3vhZ4PXF/ZS3N18QS5jSg7gq+iX9vn9Ozam/anNy5vYO
 Is5+/Yh/hrQkluUCqvSo33pxPY6XH4dENUcJxZRfNHOs8t9tzfOb8sVoAZryNMxrxRne
 7VlTDJiATEwTOrQf2JkRs5ufKVL0YOf1+mWGSG7aeWSJbjwmxYMXP0RinUbM8gwoeZhj 4g== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn7h1rkmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 20:13:22 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319E2mij005567;
        Thu, 9 Feb 2023 20:13:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3nhf06mqk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 20:13:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 319KDHs525887082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 20:13:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 012E520043;
        Thu,  9 Feb 2023 20:13:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B2D120040;
        Thu,  9 Feb 2023 20:13:16 +0000 (GMT)
Received: from osiris (unknown [9.179.10.102])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  9 Feb 2023 20:13:16 +0000 (GMT)
Date:   Thu, 9 Feb 2023 21:13:14 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 15/24] Documentation: s390: correct spelling
Message-ID: <Y+VT2o85uX3D1M2J@osiris>
References: <20230209071400.31476-1-rdunlap@infradead.org>
 <20230209071400.31476-16-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209071400.31476-16-rdunlap@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BshR2xYXG0EXcDiuKKPCNJaI3Ow8LsdG
X-Proofpoint-GUID: BshR2xYXG0EXcDiuKKPCNJaI3Ow8LsdG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=484 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090186
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:13:51PM -0800, Randy Dunlap wrote:
> Correct spelling problems for Documentation/s390/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  Documentation/s390/pci.rst      |    4 ++--
>  Documentation/s390/vfio-ccw.rst |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.
