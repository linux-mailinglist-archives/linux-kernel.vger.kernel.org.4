Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832CC67E52C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjA0M2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjA0M2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:28:16 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD48AAD24;
        Fri, 27 Jan 2023 04:27:46 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RALg1j017328;
        Fri, 27 Jan 2023 11:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mghF05r9ADEypUYcx7SnYoI/1VfwNYwXit9C0zNG9xc=;
 b=jE7hqYahf20n0Srim2uO+xkZrfC1F4wAmsQrA85TUoN9gwJWwZgHUi4Lijo3qPffpUNE
 Z2loP0s5iaRbG0uGa91OvNTqEFpXjPaJur4v5N0oTThBiNvdVfkGkTlkqt4/7Ethem0J
 nI+EYZk2amFE8t2u/r0N4JtAEbVCV6rZ1GF3mRARnxOZ5q0WMBbWYm2iAqJ9mtjlWViL
 tFt4Bq30A2eKGQ96qFqqaIw/8gGBsXH6nOocZslL+0Tuo/dSi+KQsxsP+enqiSbrmfDQ
 NFqHoCXXuHYhbh7V/+/qbcYw1SCuVp/MYb3uVPR5BR5GFtC6xITf2dpitTfioMw7XlDL Cg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nccsuhsq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:43:26 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QNr64q029222;
        Fri, 27 Jan 2023 11:43:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n87afddb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:43:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RBhLZ845875624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 11:43:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75DC12004D;
        Fri, 27 Jan 2023 11:43:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 101F820040;
        Fri, 27 Jan 2023 11:43:21 +0000 (GMT)
Received: from osiris (unknown [9.179.15.200])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 27 Jan 2023 11:43:20 +0000 (GMT)
Date:   Fri, 27 Jan 2023 12:43:19 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 23/35] Documentation: s390: correct spelling
Message-ID: <Y9O4150V0hMBsEoj@osiris>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-24-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127064005.1558-24-rdunlap@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P30Yg8-afwC5vdm2D5Zy-_VHHMJ9sY_t
X-Proofpoint-GUID: P30Yg8-afwC5vdm2D5Zy-_VHHMJ9sY_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=399 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301270109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 10:39:53PM -0800, Randy Dunlap wrote:
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
> ---
>  Documentation/s390/pci.rst      |    4 ++--
>  Documentation/s390/vfio-ccw.rst |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

FWIW,

Acked-by: Heiko Carstens <hca@linux.ibm.com>

If you expect me to pick this up via the s390 tree, please let me know.
