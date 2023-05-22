Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE4F70BB52
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjEVLO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjEVLNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:13:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D6F40E2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:53 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M9aADR016006;
        Mon, 22 May 2023 11:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : content-type : in-reply-to
 : mime-version; s=pp1; bh=5GCHBjrZp7XRFILy5bRVhHJS6/L3jzxBL3QKZZ24N1g=;
 b=jsqPt/22LMz9HynaJX9PmGvEF1e0/pmhbNSA+J9icU82vFP2hBBd0alWTNfy1UJ2iuXo
 AjCix4IALgpsSp9QIxP83sf4htUgLZHNKd5VybMVCWd7RjUElBa9x17HikTx8EGwifXJ
 RqBEb3OzsHqkQUtUxzEnfJKf/mtc4Fivp4RfBh8tqlVIgMcD6JBDujpUvS8FKGDlTCfr
 wEc/0Nt5oVnvmfdbchcXkVt+Os8WBqwpOyuzYN2hX6yt/GI7fhFEU8J0Sjn0bIkyVH+L
 kna4P21ZAq4HTdBb6V/Bqzuih2fYQdGqnhUe/CkiYvFfNY1GeURNuYcaUjiHs9n+sOc1 zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqh1294hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 11:08:26 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MAL2dK024151;
        Mon, 22 May 2023 11:08:26 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqh1294ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 11:08:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M68qGp021547;
        Mon, 22 May 2023 11:08:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk0wgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 11:08:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34MB8LwO42664652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 11:08:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36DC02004B;
        Mon, 22 May 2023 11:08:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2528520040;
        Mon, 22 May 2023 11:08:19 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
        Mon, 22 May 2023 11:08:18 +0000 (GMT)
Date:   Mon, 22 May 2023 16:38:18 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sachinp@linux.vnet.ibm.com,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Gaurav Batra <gbatra@linux.vnet.ibm.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: Probing nvme disks fails on Upstream kernels on powerpc Maxconfig
Message-ID: <20230522110818.GB3902@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230323095333.GI1005120@linux.vnet.ibm.com>
 <906d4d0e-b487-00a5-9399-7d1edc5e20a4@leemhuis.info>
 <87bkk2khl0.fsf@mpe.ellerman.id.au>
 <2a80cb20-0c9f-2d0c-e951-c4f005f3e4b3@ozlabs.ru>
 <20230522072412.GA3902@linux.vnet.ibm.com>
 <87edn8ak4d.fsf@mail.lhotse>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87edn8ak4d.fsf@mail.lhotse>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S9juypeAE7KEM5E2DSgm_qKtBVJvWnG2
X-Proofpoint-GUID: LcPgIepHzWanw9OEbSdOuQcVZCIkkXwp
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=881 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305220094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Ellerman <mpe@ellerman.id.au> [2023-05-22 17:41:22]:

> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> > * Alexey Kardashevskiy <aik@ozlabs.ru> [2023-04-13 22:09:22]:
> >
> >> > > On 23.03.23 10:53, Srikar Dronamraju wrote:
> >> > > > 
> > Hi Alexey, Michael
> >
> > Sorry for the late reply, but I didnt have access to this large system.
> > This weekend, I did get access and tested with the patch. However it didn't
> > help much, system is still stuck at dracut with similar message except the
> > trace.
> >
> > However this patch
> > https://lore.kernel.org/all/20230418204401.13168-1-gbatra@linux.vnet.ibm.com/
> > from Gaurav Batra does solve this issue.
> 
> Thanks.
> 
> There was a v3 of that patch:
>   https://lore.kernel.org/all/20230504175913.83844-1-gbatra@linux.vnet.ibm.com/
> 
> Which is merged now into mainline as:
>   096339ab84f3 ("powerpc/iommu: DMA address offset is incorrectly calculated with 2MB TCEs")
> 
> Presumably it also fixes the bug for you, so I'll mark this as fixed,
> but if you can test that exact commit that would be good to confirm the
> bug is fixed in mainline.
> 

Yes verified with mainline kernel and also with the v3.
This patch/commit does fix it.

-- 
Thanks and Regards
Srikar Dronamraju
