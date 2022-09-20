Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BA65BD9A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiITBrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiITBrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:47:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F72A53033;
        Mon, 19 Sep 2022 18:47:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMinKT006527;
        Tue, 20 Sep 2022 01:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=9iD5USZvB16AVVkG4yrC05YxW7LDiDMhlgCSXpFCCgg=;
 b=pMT+PIxiTC001yKYyzxJ13kPMncGTSix+w328guCLoZPtrxrT+yRH34/U+OSZfZGgb8z
 wjbZL3NhJahdx1cDIbtRn2IHWcs/Zbba4r4h/Qkd0CK55Rawv1ld2cYpD468Hxo9QLnb
 ZUXj5TYChylrN7XsVhbf+bcj3BZ9nddcEJ5WK/psvkvdDrgtTmjLa+Y13Gvv9NhxOPZy
 cEekYZfsmgGhZ/ynjPo5+wu8LlKTu3NkzkU1DqT+SIAAURNebQOutRGaZ9h/saNWo0nG
 W3AV8SIm5ItSUjp6qIkvhwzXh8jJKunGL25OpPHES7vMoAPZfTQ0+b+y62HI9nGUuCIY aA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rder6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 01:47:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28K0bJLb036355;
        Tue, 20 Sep 2022 01:47:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39d777u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 01:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5JeGHHHeBwCjlKGCrAZOikxkk6pyjBPv6ECfxjHpsqFLOCi/mJ+ZvZyklAMK4qSVmAotdGwkEvvb6fPPE8RFtURdHjw/ih99r6iYxKUm7sHhudxiIlppl2C884cYmH5n/yl6Hi3GCR7pgxwgI/IHDKjCP6uoKl4Vaph2eKC5FKmiNUr9T9VfTcLtL2+uk8zwRx9Ia4zh/XCIxr+9V5LHXh4ysDaddX75nOQZlZRcMP/5w15sSBsBDK36RXV/qs64FbWel7keU8rQ+jbNqUDdXZbb50NYpHltylmzvxYXEzWfsJ1W3ThuvytiNJvTxPwycnNZ0a+PFs4BdipNd9R1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iD5USZvB16AVVkG4yrC05YxW7LDiDMhlgCSXpFCCgg=;
 b=k6PVu4R7ICaXS+/8uh4GNtMKVVLS0nk119xzybELyBdwz2XX/lC3I0EeD7vrtgFoXvv5o2NK6pB192+9yO4r4dVWMUrqB9h98cdhdNPpIxr0jeMJlhgESANRe8pIbMw1JtYgSUW+I0IT3N8GhrsibfTgFVXvJDoHPeXi1yBB3mE0sff6GrmDwUT6gf6nLiylaeXQXkYpM3+GXQStAuS/x8cxMcfAf7cLPw9V/ZbCZVAQyY1Acy2qnGXFNLlnynLdUVS16DU7hSN8pj0Ug3fwJg7LrHF3Pi1Y1T/jktPCcHiXacMCzX/q+lcvRJKGNZraxX6NYMq1l+64oHbhqV8gMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iD5USZvB16AVVkG4yrC05YxW7LDiDMhlgCSXpFCCgg=;
 b=PKpl/e5td+Ks3FF1aJCGlgFTzk5iMtT1xQTmXpkfUAZ0A1/HmynGRP0N+OGB/jKPQj8Coj37q3jx0Os13y6tlfvQNHtGXtduKYRqdxTtx9B9PYuSpP1shuf9HpjGSsW9R2EKkw+1TEMRrpfLK7y+30YnsNpYxHFj4qzuShwGMiA=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by BN0PR10MB4934.namprd10.prod.outlook.com (2603:10b6:408:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 01:47:15 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::610f:82ba:a9ad:bd65]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::610f:82ba:a9ad:bd65%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 01:47:15 +0000
Date:   Mon, 19 Sep 2022 21:47:11 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     eadavis@sina.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        steffen.klassert@secunet.com,
        syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] padata: fix lockdep warning in padata serialization
Message-ID: <20220920014711.bvreurf4ex44w6oj@oracle.com>
References: <20220919151248.smfo7nq6yoqzy2vo@oracle.com>
 <20220920003908.391835-1-eadavis@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920003908.391835-1-eadavis@sina.com>
X-ClientProxiedBy: BLAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:208:32d::8) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|BN0PR10MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d05bc94-144e-48f6-da6b-08da9aaa0b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fplXWCzLAebgvP6D+zYyOHQSkuzpeM8hz3VZltHqGhtomhPLUaUhijbMtvmtIllWGV4BGYXuIFT1U4Akj2+Q7tP/XCiqyFE1XKZ0gp2MEniFnrijqInucqmcue0Hg4hul1liVAqRxaO6xrAY0lZIbvSexeuAHfbuch6ojrNU4TgOo87NX8j6AV2JCCrM5M8pKVMRmA/uefebv1As8Pifj+lwv81ePY8T5TrwTXnhVKr9Bf1M4DFpPMm9H4DLbgLDoaPRKisb1U0bNpBM9tIMNrE2jD5flbHetJ7NRoN1XFXRgp0uN6ztM5/c9fANpaGHbYsQ51IOlBfipt1pCb5Ijer6z9nPaRwizzRO31ECEMu+qnfYYymIGBqpdIeBIhaGi8HnNXWyEXLr1IJywJae+I2pfIWP5ID3OCcdHgvTW8YcoIYA+Dnd67TtRIehTvhXyeqRv4+n47Crnkz4TrXMIIU6ZczQEo/UJq40lgxkdH437+YzxUHHSEO6B/CXMgM9QrdfL87XNI1Y1oxzN7uxBQ9JkdRIV2CKO5sBhr+yhIJH6PeXMemVNCDYBaQ/ZmTETkGz5G3JASImw5rIjyP87EXOjZiWMl4dxrKeO0jeB0lpzcFxZpQbcYLbmuA2xgZlTLQQbTIzOeBsbJY2TI8XWgcyvu0Fiv2Upnvh6EqwBhlUZ8hVkI/dLhj1jGfHUDY7Rlh6EDG4fCXFZFAV4UiY3i3qZs6LoWMp0E9zEx3p/86YU4sKRw/4P7DejTtUEJnRGA5mxzIQHc9FvpYwAMQR3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(36756003)(2906002)(316002)(8676002)(38350700002)(38100700002)(4326008)(66476007)(5660300002)(66556008)(66946007)(6916009)(8936002)(86362001)(1076003)(186003)(478600001)(2616005)(6512007)(26005)(52116002)(6666004)(83380400001)(41300700001)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G+FLxWpswXehXOLRyrnhxtgxjrxQi+ic7c2IYewEMuFEayIq1s+v0YrdqWjL?=
 =?us-ascii?Q?o0pRzTqnFpVFkxHlHjiuJE9v7NMHWqcY45QxYt0z/ZsItW8IXdLvFhaitgOn?=
 =?us-ascii?Q?t72Ue4PXO6S6LE7yt+imrCuCXAXUWkruy0v7mimSbpHPEhooPhmEyHABfSE1?=
 =?us-ascii?Q?OviROfCYnXuaX6Y7oZ0uiN71AY0Xeatw3ZhXkYMeFCtaKPHjKBQ3pttttvRn?=
 =?us-ascii?Q?is0+9d1JPRWSdJHcyAYGVspVJ3k7gv9NN7PJGlWI6f60UpHqwEzgfQGgq9US?=
 =?us-ascii?Q?LOaFyFR9oczPakCoMtOTqZzdDF66SUcZApTboAi5WsDqbXVut0KJLV0XZUiN?=
 =?us-ascii?Q?bmZOrcmEbdt6+SmPueaBVsCFrM3DEXF+cY0Br2Is4b55e1+EUKmtlwBMI7tq?=
 =?us-ascii?Q?X57L5d2Rdw+FSpgATvE1D5yk0gYTLbX9uCnMSifMGTaDsh92HuEX2QrkpgiR?=
 =?us-ascii?Q?0JoAb+gt9hHsyNP6V4a+eDRql/5XYwd1gTk9iSGigtxB9uY4kYghTS0s9/d6?=
 =?us-ascii?Q?4Pi6yM12ulrR7gkm+MP/EP9f+nDiJgMjqjHWLdeNa0CI/1kQ2GyOs8WkDeSB?=
 =?us-ascii?Q?45Wt85+w7ux2Dr65+LYLDJB8CFd58PbIweozqSNNXP9OVkyC1CotjamptVVu?=
 =?us-ascii?Q?jk9J3qRugqTYb3e/nqawjUESsE5mTulYj4TmXYkrCp25izUUWAPJR4LnIC3P?=
 =?us-ascii?Q?NUJvcD5XH6Bq5gLdj28FqLCVkiGRSS3favsxWGJINH595gF5tbNAkgAXXc2M?=
 =?us-ascii?Q?4IaTlig1de+Khb0XFaTS2aFRiKGyolE2NR28+xZ2ZHqoeFvp/RdMXYthSaDa?=
 =?us-ascii?Q?8mmzw+YAwXWRLQuG7QdlX/0ExSE8JO+AiNfoDHHrE36dbJx252XG43hd5CTd?=
 =?us-ascii?Q?kjqKzSGGeEUVPLjCsaDo9yGXfncfDmR7G8ckfo8IxOLmX4vpuKHYStTMX6VN?=
 =?us-ascii?Q?6dCJzRDaOJAHM+rlLkPf31eSMvAk93dygbMIwdfFaRusfUT+Q8/xv9vCR181?=
 =?us-ascii?Q?Z4CWmlD/mPU1miq6sOXACKZYbYeb0Oggd8PxUqVHRGD/CanTNdyQYHLh0Edz?=
 =?us-ascii?Q?PTV1vjYAScOTpoVGGLYHqsr999Y6rBIWVd3FMpe3+110y4t2Uiby3YWoQzuG?=
 =?us-ascii?Q?y++LGWkqK9jhRnrhqKS/kyQAR7+3U5fiiE4LODEDorrvCMVRjGIP1NXZ+I+s?=
 =?us-ascii?Q?pd0ZjftjMc1C9I1ebxa06iq/TprxFyDlbZ5Jnjuxg1hqLPdfhTOfR3QxeNBS?=
 =?us-ascii?Q?fmAAMIuVq0pvB0ahedbX/UjY97J8MXgq95b/Ru6GDR294gNHuYGKsZyaQZxo?=
 =?us-ascii?Q?nk6phPU6kSoY1aB+tJig4CMFtcs19W841yesGI88c9YGKFbNEC1B6jkE7WZB?=
 =?us-ascii?Q?zRHGES1aR8+ITHcRFnXyJSkNrBCa+RJYbNXZUcvCq//nCGYn3gU4JelV69OA?=
 =?us-ascii?Q?XY2q5E2tfnOCwfK1Qh60IZs0uarmtcOmtsGnzk3dUDCzJwLvg6LJfMhmJgDS?=
 =?us-ascii?Q?Cbjilrt9DjsmofLsmGyWRfHw7caRj1s9VVrVT6yoGeFOaqxlAEhF5mEFjd6H?=
 =?us-ascii?Q?H0+tTOibgo9I6hihxnEznG3+AkVz9EMNOKstbEy9ePddpC0uU/OSopkGJdMb?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d05bc94-144e-48f6-da6b-08da9aaa0b1b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 01:47:15.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSvOBA8D4fgeP/mOlmX/znZ1xzOQswqLPiClABxFsx4+ym5JQ4mfRU17efvZgzOzJfJhGTMPKIGlbc8/0HlToZklvFwuJ4vbdHnXHiNccyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4934
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200009
X-Proofpoint-GUID: hXJC3RPl8lpz0kZqd0-lyKNO1lNDw6zC
X-Proofpoint-ORIG-GUID: hXJC3RPl8lpz0kZqd0-lyKNO1lNDw6zC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 08:39:08AM +0800, eadavis@sina.com wrote:
> From: Edward Adam Davis <eadavis@sina.com>
> 
> On Mon, 19 Sep 2022 11:12:48 -0400, Daniel Jordan wrote:
> > Hi Edward,
> > 
> > On Mon, Sep 19, 2022 at 09:05:55AM +0800, eadavis@sina.com wrote:
> > > From: Edward Adam Davis <eadavis@sina.com>
> > > 
> > > Parallelized object serialization uses spin_unlock for unlocking a spin lock
> > > that was previously locked with spin_lock.
> > 
> > There's nothing unusual about that, though?
> > 
> > > This caused the following lockdep warning about an inconsistent lock
> > > state:
> > > 
> > >         inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> > 
> > Neither HARDIRQ-ON-W nor IN-HARDIRQ-W appear in the syzbot report, did
> > you mean SOFTIRQ-ON-W and IN-SOFTIRQ-W?
> Yes, I want say: inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > 
> > > We must use spin_lock_irqsave, because it is possible to trigger tipc 
> > > from an irq handler.
> > 
> > A softirq handler, not a hardirq handler.  I'd suggest using
> > spin_lock_bh() instead of _irqsave in your patch.
> I think _irqsave better than _bh, it can save the irq context, but _bh not, 
> and in tipc call trace contain SOFTIRQ-ON-W and IN-SOFTIRQ-W.

_irqsave saving the context is about handling nested hardirq disables.
It's not needed here since we don't need to care about disabling
hardirq.

_bh is for disabling softirq, a different context from hardirq.  We want
_bh here since the deadlock happens when a CPU takes the lock in both
task and softirq context.  padata uses _bh lock variants because it can
be called in softirq context but not hardirq.  Let's be consistent and
do it in this case too.

> > A Fixes tag would be helpful for stable and folks backporting this fix
> > to understand what kernel versions are affected.
> Yes, I will add it, thanks for your suggestion, and add Cc for the "Fixes" 
> owner.
> > 
> > > WARNING: inconsistent lock state
> > > 6.0.0-rc5-syzkaller-00025-g3245cb65fd91 #0 Not tainted
> > > --------------------------------
> > > inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > > syz-executor.2/27685 [HC0[0]:SC1[1]:HE1:SE0] takes:
> > > ffffe8ffffc7d280 (&pd_list->lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
> > > ffffe8ffffc7d280 (&pd_list->lock){+.?.}-{2:2}, at: padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
> > > {SOFTIRQ-ON-W} state was registered at:
> > >   lock_acquire kernel/locking/lockdep.c:5666 [inline]
> > >   lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
> > >   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> > >   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
> > >   spin_lock include/linux/spinlock.h:349 [inline]
> > >   padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
> > >   pcrypt_aead_enc+0x57/0x70 crypto/pcrypt.c:89
> > >   padata_do_parallel+0x87b/0xa10 kernel/padata.c:217
> > >   pcrypt_aead_encrypt+0x39f/0x4d0 crypto/pcrypt.c:117
> > >   crypto_aead_encrypt+0xaa/0xf0 crypto/aead.c:94
> > >   tls_do_encryption net/tls/tls_sw.c:529 [inline]
> > >   tls_push_record+0x13e8/0x3260 net/tls/tls_sw.c:762
> > >   bpf_exec_tx_verdict+0xd82/0x11a0 net/tls/tls_sw.c:802
> > >   tls_sw_sendmsg+0xa62/0x1820 net/tls/tls_sw.c:1014
> > >   inet6_sendmsg+0x99/0xe0 net/ipv6/af_inet6.c:653
> > >   sock_sendmsg_nosec net/socket.c:714 [inline]
> > >   sock_sendmsg+0xcf/0x120 net/socket.c:734
> > >   sock_write_iter+0x291/0x3d0 net/socket.c:1108
> > >   call_write_iter include/linux/fs.h:2187 [inline]
> > >   new_sync_write fs/read_write.c:491 [inline]
> > >   vfs_write+0x9e9/0xdd0 fs/read_write.c:578
> > >   ksys_write+0x1e8/0x250 fs/read_write.c:631
> > >   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
> > >   __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
> > >   do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> > >   entry_SYSENTER_compat_after_hwframe+0x70/0x82
> > > irq event stamp: 740
> > > hardirqs last  enabled at (740): [<ffffffff814919a0>] __local_bh_enable_ip+0xa0/0x120 kernel/softirq.c:401
> > > hardirqs last disabled at (739): [<ffffffff814919c3>] __local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:378
> > > softirqs last  enabled at (0): [<ffffffff8146f02e>] copy_process+0x213e/0x7090 kernel/fork.c:2202
> > > softirqs last disabled at (717): [<ffffffff81491843>] invoke_softirq kernel/softirq.c:445 [inline]
> > > softirqs last disabled at (717): [<ffffffff81491843>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
> > > 
> > > other info that might help us debug this:
> > >  Possible unsafe locking scenario:
> > > 
> > >        CPU0
> > >        ----
> > >   lock(&pd_list->lock);
> > >   <Interrupt>
> > >     lock(&pd_list->lock);
> > > 
> > >  *** DEADLOCK ***
> > > 
> > > 4 locks held by syz-executor.2/27685:
> > >  #0: ffff8880445f0460 (sb_writers#3){.+.+}-{0:0}, at: open_last_lookups fs/namei.c:3470 [inline]
> > >  #0: ffff8880445f0460 (sb_writers#3){.+.+}-{0:0}, at: path_openat+0x2613/0x28f0 fs/namei.c:3688
> > >  #1: ffff8880465111a0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
> > >  #1: ffff8880465111a0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
> > >  #1: ffff8880465111a0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: path_openat+0x1514/0x28f0 fs/namei.c:3688
> > >  #2: ffffc900001e0d70 ((&d->timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:31 [inline]
> > >  #2: ffffc900001e0d70 ((&d->timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1464
> > >  #3: ffffffff8bf89400 (rcu_read_lock){....}-{1:2}, at: buf_msg net/tipc/msg.h:202 [inline]
> > >  #3: ffffffff8bf89400 (rcu_read_lock){....}-{1:2}, at: tipc_bearer_xmit_skb+0x8c/0x410 net/tipc/bearer.c:550
> > > 
> > > stack backtrace:
> > > CPU: 1 PID: 27685 Comm: syz-executor.2 Not tainted 6.0.0-rc5-syzkaller-00025-g3245cb65fd91 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> > > Call Trace:
> > >  <IRQ>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > >  print_usage_bug kernel/locking/lockdep.c:3961 [inline]
> > >  valid_state kernel/locking/lockdep.c:3973 [inline]
> > >  mark_lock_irq kernel/locking/lockdep.c:4176 [inline]
> > >  mark_lock.part.0.cold+0x18/0xd8 kernel/locking/lockdep.c:4632
> > >  mark_lock kernel/locking/lockdep.c:4596 [inline]
> > >  mark_usage kernel/locking/lockdep.c:4527 [inline]
> > >  __lock_acquire+0x11d9/0x56d0 kernel/locking/lockdep.c:5007
> > >  lock_acquire kernel/locking/lockdep.c:5666 [inline]
> > >  lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
> > >  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> > >  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
> > >  spin_lock include/linux/spinlock.h:349 [inline]
> > >  padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
> > >  pcrypt_aead_enc+0x57/0x70 crypto/pcrypt.c:89
> > >  padata_do_parallel+0x87b/0xa10 kernel/padata.c:217
> > >  pcrypt_aead_encrypt+0x39f/0x4d0 crypto/pcrypt.c:117
> > >  crypto_aead_encrypt+0xaa/0xf0 crypto/aead.c:94
> > >  tipc_aead_encrypt net/tipc/crypto.c:821 [inline]
> > >  tipc_crypto_xmit+0xf7a/0x2af0 net/tipc/crypto.c:1756
> > >  tipc_bearer_xmit_skb+0x1ed/0x410 net/tipc/bearer.c:557
> > >  tipc_disc_timeout+0x75e/0xcb0 net/tipc/discover.c:335
> > >  call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
> > >  expire_timers kernel/time/timer.c:1519 [inline]
> > >  __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
> > >  __run_timers kernel/time/timer.c:1768 [inline]
> > >  run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
> > >  __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571
> > >  invoke_softirq kernel/softirq.c:445 [inline]
> > >  __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
> > >  irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
> > >  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
> > >  </IRQ>
> > 
> > The changelog doesn't explain the problem or why the proposed solution
> > fixes it.
> > 
> > If I can read these splats right, it seems lockdep is complaining about
> > how a task can take the reorder lock when softirqs are enabled
> > (SOFTIRQ-ON-W) as in the tls_push_record() stack, but also when it's in
> > softirq context (IN-SOFTIRQ-W), as in the tipc_disc_timeout() stack.  So
> > it should be enough to disable softirq here.
> Yes, I agree with what you said earlier, But the softirq is already on before
> the tipc_bearer_xmit_skb(), that is, (SOFTIRQ-ON-W) and (IN-SOFTIRQ-W) will 
> be included in the call trace of TIPC.

I hope what I said above about hard vs soft irq clears this up.

> > 
> > > Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> > > Reported-by: syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com
> > > ---
> > >  kernel/padata.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/padata.c b/kernel/padata.c
> > > index e5819bb8bd1d..38c7b17da796 100644
> > > --- a/kernel/padata.c
> > > +++ b/kernel/padata.c
> > > @@ -388,14 +388,15 @@ void padata_do_serial(struct padata_priv *padata)
> > >  	int hashed_cpu = padata_cpu_hash(pd, padata->seq_nr);
> > >  	struct padata_list *reorder = per_cpu_ptr(pd->reorder_list, hashed_cpu);
> > >  	struct padata_priv *cur;
> > > +	unsigned long flags;
> > >  
> > > -	spin_lock(&reorder->lock);
> > > +	spin_lock_irqsave(&reorder->lock, flags);
> > >  	/* Sort in ascending order of sequence number. */
> > >  	list_for_each_entry_reverse(cur, &reorder->list, list)
> > >  		if (cur->seq_nr < padata->seq_nr)
> > >  			break;
> > >  	list_add(&padata->list, &cur->list);
> > > -	spin_unlock(&reorder->lock);
> > > +	spin_unlock_irqrestore(&reorder->lock, flags);
> > >  
> > >  	/*
> > >  	 * Ensure the addition to the reorder list is ordered correctly
> > > -- 
> > > 2.37.2
> > > 
