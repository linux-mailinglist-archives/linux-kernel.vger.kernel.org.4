Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745DF62B819
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiKPK1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiKPK0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:26:39 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB8B2ED7E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:23:47 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGAMO6C009783;
        Wed, 16 Nov 2022 10:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=l0Sxeb1H9mwSeEpl/cbTCA5k5f6fmEy7YXshdvG96Oc=;
 b=KNg91Hgw5Jc7a+xv066W5tTCW8G5PFZT3oFZgN2bRilJctpSY5z31ztefftksp3VOmwJ
 FVy5YzogOz7nJ8P/pNR1pA+HC1LBEJeA5n+o362lSb0adVuFe9FTos9p8Iu4vM3KISAk
 prTk5m/Ij0G/7OAtfRQz9HZssiI/OCESnYli85YoVtMieagaO6VIFxEQxUoTZBCH6kPT
 6qQY77WUM49Zpgfj1UosHzb3cBjkS2U1Luw+cvMCYimvUqs+ASvvxDZ07CEdKjajK7b8
 TnS4kAOo5ENyNHzmISAmrrOdcoViROdfVhNce9hGaI0vcHmSeTniXyvdyLOAxhrVqw+q aQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvx24g0as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 10:23:02 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id F35502EEF2;
        Wed, 16 Nov 2022 10:23:00 +0000 (UTC)
Received: from blofly.os1.tw (unknown [16.231.227.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 6D53780B774;
        Wed, 16 Nov 2022 10:22:57 +0000 (UTC)
Date:   Wed, 16 Nov 2022 18:22:54 +0800
From:   Matt Hsiao <matt.hsiao@hpe.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, christophe.jaillet@wanadoo.fr,
        gustavoars@kernel.org, nishadkamdar@gmail.com,
        torvalds@linux-foundation.org, dhaval.experiance@gmail.com,
        viro@zeniv.linux.org.uk, arvind.yadav.cs@gmail.com,
        standby24x7@gmail.com, wfp5p@virginia.edu, prarit@redhat.com,
        tj@kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Message-ID: <20221116102254.GA15492@blofly.os1.tw>
References: <20221116094712.14312-1-matt.hsiao@hpe.com>
 <77be348e-3e9d-7bbf-5581-95d78124daa7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77be348e-3e9d-7bbf-5581-95d78124daa7@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: VKhEd0_xN62TDM3locTn-LJFHB7uDvrL
X-Proofpoint-GUID: VKhEd0_xN62TDM3locTn-LJFHB7uDvrL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_01,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:10:40AM +0100, Jiri Slaby wrote:
> On 16. 11. 22, 10:47, matt.hsiao@hpe.com wrote:
> >From: Matt Hsiao <matt.hsiao@hpe.com>
> >
> >Currently, the hpilo driver is licensed as GPL. To run OpenBSD on HPE
> >servers with BMC (HPE iLO) functionality, a dual MIT/GPL license is needed
> >for porting the hpilo driver to OpenBSD.
> 
> What about the MODULE_LICENSE() change to "Dual MIT/GPL" too?

Good catch! Thanks!
Will do v2 patch.

> 
> Acked-by: Jiri Slaby <jirislaby@kernel.org>
> 
> >Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> >---
> >
> >Hello contributors in the CC list,
> >
> >Thanks for your contributions to the hpilo driver. Please kindly review
> >the license change and hopefully you would agree and approve it. Thanks!
> >
> >  drivers/misc/hpilo.c | 2 +-
> >  drivers/misc/hpilo.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
> >index 8d00df9243c4..6a06b6485950 100644
> >--- a/drivers/misc/hpilo.c
> >+++ b/drivers/misc/hpilo.c
> >@@ -1,4 +1,4 @@
> >-// SPDX-License-Identifier: GPL-2.0
> >+// SPDX-License-Identifier: GPL-2.0 OR MIT
> >  /*
> >   * Driver for the HP iLO management processor.
> >   *
> >diff --git a/drivers/misc/hpilo.h b/drivers/misc/hpilo.h
> >index d57c34680b09..581dfd7834b8 100644
> >--- a/drivers/misc/hpilo.h
> >+++ b/drivers/misc/hpilo.h
> >@@ -1,4 +1,4 @@
> >-/* SPDX-License-Identifier: GPL-2.0 */
> >+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> >  /*
> >   * linux/drivers/char/hpilo.h
> >   *
> 
> -- 
> js
> suse labs
