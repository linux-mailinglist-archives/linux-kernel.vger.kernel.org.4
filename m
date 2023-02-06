Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA568C02B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjBFOdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjBFOdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:33:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18B23DA0;
        Mon,  6 Feb 2023 06:33:45 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316EPEXd027376;
        Mon, 6 Feb 2023 14:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ao3Mhl42KnQiZqqzA5ntTP34H2cmeTV2b2QVANFd4VY=;
 b=IrxtBvAJMVZElSULY1TGF9pp2fOxKk1vmozJLNgpMLfIty/EbR73vQffvYv2oHN/UCyL
 +Xrx75SRGFtwgEXt9Emoem8VxuU76wrbVK7k6bRi0HqipKOMCeSESSve/dSeP1ScIMUX
 VgHpkQI6yDcLL2uOrVuJJ6HE/tls9HWajaI8v3i0AR7rl2cLdEfNUWq4htImMfIzQ+Zx
 m3HqMsXuOtLxkcoMNGt6mcZHsCUYZt+7tTHBJrIHWcB9IP+HEglXdEIkamRy0PSqhhks
 H42AfvlPkzJ2Ui2k8Ee4SVqa39som7nXZOyDMJQoxJfn/zySypL22l8U/MuOy7Q+R3Tv 5g== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk3a087bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:33:30 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316DwUQt026483;
        Mon, 6 Feb 2023 14:33:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3nhf06ssdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:33:27 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316EXP2946662082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:33:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D8F720043;
        Mon,  6 Feb 2023 14:33:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2E5320040;
        Mon,  6 Feb 2023 14:33:24 +0000 (GMT)
Received: from osiris (unknown [9.171.69.162])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Feb 2023 14:33:24 +0000 (GMT)
Date:   Mon, 6 Feb 2023 15:33:23 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH 0/5] diag288 watchdog fixes and improvements
Message-ID: <Y+EPs2EQEevzhpvB@osiris>
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
 <Y+DPnGN9l7Ix+TX7@osiris>
 <b7da8789-6c55-cf41-b95a-e87f9341c438@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7da8789-6c55-cf41-b95a-e87f9341c438@roeck-us.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JGrMefBoedSyf1-Pv6kVLHqv2yNIVWeN
X-Proofpoint-GUID: JGrMefBoedSyf1-Pv6kVLHqv2yNIVWeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=848 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 05:55:40AM -0800, Guenter Roeck wrote:
> On 2/6/23 01:59, Heiko Carstens wrote:
> > On Fri, Feb 03, 2023 at 08:39:53AM +0100, Alexander Egorenkov wrote:
> > > Minor code refactoring to improve readability of the driver,
> > > reduce code duplication and remove dead code.
> > > 
> > > Alexander Egorenkov (5):
> > >    watchdog: diag288_wdt: get rid of register asm
> > >    watchdog: diag288_wdt: remove power management
> > >    watchdog: diag288_wdt: unify command buffer handling for diag288 zvm
> > >    watchdog: diag288_wdt: de-duplicate diag_stat_inc() calls
> > >    watchdog: diag288_wdt: unify lpar and zvm diag288 helpers
> > > 
> > >   drivers/watchdog/diag288_wdt.c | 162 ++++++++-------------------------
> > >   1 file changed, 37 insertions(+), 125 deletions(-)
> > 
> > Guenter, Wim, how should this go upstream?
> > 
> > I can easily pick this up via the s390 tree for the next merge window.
> > Please let me know.
> 
> I have it currently in my watchdog-next tree, but that is not in linux-next.
> Fine with me to go through the s390 tree.

Applied to s390 tree - should be in next linux-next release.

Thank you!
