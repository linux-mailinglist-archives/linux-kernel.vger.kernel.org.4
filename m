Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BF668B939
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBFKBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBFKAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:00:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3F3206A1;
        Mon,  6 Feb 2023 02:00:17 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3169Hhtn019017;
        Mon, 6 Feb 2023 10:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=gukPO4AglsSWsyYU7ixRfKwe2lBd8CbhvzavI5w21YI=;
 b=M96HcVNS8hcWO0nkLoLFn9QlgeArVCOl79h4pOW48M6Wh6SFrQsj7aobWh0zZ6yi0S+S
 ToTisuUUFMFtFyLgIKS81EgsQIimB8YjRDfcIgGQqFfnwlfo/dNg1ocxR7fjqgz7D8uv
 0oCdfOl5L98Ey67lon1BnGcei/v6vifAByZHNkHuOz43wl1kqGZu2TXxT+hufShT+s3Q
 B8Ynzq481YBH/1gILyAUHWai22N04GWnfZkhK1kb4e5pT70FGJtjd3iDDmdc/Jd02Amn
 TtgHmFfBt+ANmBL53GmHbRV8dyM6hDOL/l3rOJl5g1cqMSOCppgzVJ40d6oOPJhLlqJg 5g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3njxsm90h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 10:00:03 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3161VFcm027110;
        Mon, 6 Feb 2023 10:00:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3nhf06sk99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 10:00:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3169xwPW43975050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 09:59:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B13182004B;
        Mon,  6 Feb 2023 09:59:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5224020043;
        Mon,  6 Feb 2023 09:59:58 +0000 (GMT)
Received: from osiris (unknown [9.171.69.162])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Feb 2023 09:59:58 +0000 (GMT)
Date:   Mon, 6 Feb 2023 10:59:56 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH 0/5] diag288 watchdog fixes and improvements
Message-ID: <Y+DPnGN9l7Ix+TX7@osiris>
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203073958.1585738-1-egorenar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h2_lCqvfpK4eiKS4hLOyxvL-Ri18TvA2
X-Proofpoint-ORIG-GUID: h2_lCqvfpK4eiKS4hLOyxvL-Ri18TvA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_05,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=856 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:39:53AM +0100, Alexander Egorenkov wrote:
> Minor code refactoring to improve readability of the driver,
> reduce code duplication and remove dead code.
> 
> Alexander Egorenkov (5):
>   watchdog: diag288_wdt: get rid of register asm
>   watchdog: diag288_wdt: remove power management
>   watchdog: diag288_wdt: unify command buffer handling for diag288 zvm
>   watchdog: diag288_wdt: de-duplicate diag_stat_inc() calls
>   watchdog: diag288_wdt: unify lpar and zvm diag288 helpers
> 
>  drivers/watchdog/diag288_wdt.c | 162 ++++++++-------------------------
>  1 file changed, 37 insertions(+), 125 deletions(-)

Guenter, Wim, how should this go upstream?

I can easily pick this up via the s390 tree for the next merge window.
Please let me know.

Thanks,
Heiko
