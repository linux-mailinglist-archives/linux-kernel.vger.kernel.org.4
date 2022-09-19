Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7561C5BD01C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiISPN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiISPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:13:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF6C3136B;
        Mon, 19 Sep 2022 08:13:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JDO4F7012235;
        Mon, 19 Sep 2022 15:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GOPBl+gbG7+uxXQSFwKqvK4d8p3A51oTT4mkRx0sJRY=;
 b=nDwURx+8hRAkOagebbD2EC57BwgfwRkV71v6YQ1oACb8vjmXOtOfTfW4uXESU3r8MzNj
 8mVratw7rXIcs1pVboMcz3bv+L8Yo0a5sE71J3OGKNdERWpIYNO4Qz+eQQadHqS4Qoe1
 YTRnmU+Q0k577Crhl1tIZzOu8YSXu5moiRXpND/qYL7Zw3oNDc8mf3quYYEmVKsfsxsu
 ggjn0MkTKWEenxjJiM+KNbBQLXRuSPA8vphQWysXsHrWArfnjBYLHiE/fyEpCPJRa8bO
 8BgrNmdOgfpn0gXVBhcJzmgiM+zdWtjZrfNEsDICMiUEJ9HHDtlbbsvGWdAnTi90/WeQ Xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68rc4fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 15:12:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JDjL86036149;
        Mon, 19 Sep 2022 15:12:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39j3k7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 15:12:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxDAPmD7NMScj/wxZd8acRurgjzjMKgoFjUg7ty2yWB+sqheKI7vbuaNqCbu50DknyS8KRcq3n5Uuz7OR0T7+uS/pMqd2McMwUxFKwZNlaLeBnOJ8TVx7dgU7KwGNb/PCxZkmg8+0RxNuWBVg6fXFI4xkBPZPmeaCSHYSABmMhNtCftxV0q6A3295T/dYhluyZPRcz2ndTbwuXX4FWHCiMIKlcDV7aN6hDaTmxRf3EVNsgSZV2dgyq9TSRxhHVnY0jz1nL/Xj0qEPgvAJ2aD0shR3yncjQmTMlE1zqW7yGxnYoOTS67/IxKx9lxXW6f/7i3MwUIHePBYzDENMCOxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOPBl+gbG7+uxXQSFwKqvK4d8p3A51oTT4mkRx0sJRY=;
 b=gft+A3OigL6cuDHaukP7cetOVwx4+SKChjwfppzcEJOUSBBb/Mx8LvchkyMH8R+rRfns8cg45mBwJCC3kVYJWQA3lDLLJv/51icoMgApl0ccW4+9FfXwSEUvV476ycEO8jZhq5VhSmGcUjys17kKmM2MMJ8WeG5d0sF7maaOEPYxPWKUfqMI8gZ93rNUcUboWPnLenQz0d3cymuJYi7xafTGXux4oohx9sm9ygi9yWJ9Y68Tv82HdeygeR2yhZo5TYEA6N0arr0zwXp5G4BP+OfOE7BU4lRmIgkv4Jjw6OdSIEL7v+APTCFRhwtCLQ+p6BW+1HHD7rOnF/81jOQhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOPBl+gbG7+uxXQSFwKqvK4d8p3A51oTT4mkRx0sJRY=;
 b=XBLzOwA1XXul0fMyZJtg/QPplOe+/KYwY5EIt5wWRQn0K88I08XDBTl4/DRa20YabMGU0P1lmSttbZrqxb/NpVokcxrUyiLEK5A3/ZHmbFl7v7uix3UopTXrbq6nheA9QSWrs1K0iSzBs6Cj5/3uEL73N0sJebM6Igy1KbbJzps=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SA2PR10MB4617.namprd10.prod.outlook.com (2603:10b6:806:118::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 15:12:52 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::64a1:f8fa:afd0:1eda]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::64a1:f8fa:afd0:1eda%4]) with mapi id 15.20.5632.015; Mon, 19 Sep 2022
 15:12:52 +0000
Date:   Mon, 19 Sep 2022 11:12:48 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     eadavis@sina.com
Cc:     syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] padata: fix lockdep warning in padata serialization
Message-ID: <20220919151248.smfo7nq6yoqzy2vo@oracle.com>
References: <000000000000122cfc05e8f8d09b@google.com>
 <20220919010555.130609-1-eadavis@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919010555.130609-1-eadavis@sina.com>
X-ClientProxiedBy: BL1PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:208:256::21) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SA2PR10MB4617:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b436c0-423d-4c5b-38c1-08da9a516bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3NlfNENUm5PcMdVP2NyzGwR6Xq5bR5F0LdRBmYc8ZdfNWzadSsczt0p1JOzAbs/ce92U6YLkC3otMj4Gc0Cb+/ug01ZIb81gR2yQt4Mtd35fMdgRq4Tclkpu2c6aO8lLwJ4dFtAmfRo8KcCfAwW5ImGN9vScPHBWYmXI7dx+gov6o5YtD6hyudCDrK7P1O7LT9iEtltlY9NcYQUxIUooOYdULVs2Y49dShnljQwfG7yxBgQt1wBqAme940kPD/vu26TEmud7VyQvJVzWtwvG8YcZHNvUEB9apfOg3Y9gVPopEVq+vBY9cR59qGbbeQ3P6CTfPRmn3DqAp0nZAVYo7dxYF06LY1b5AYSq/ghMDuVeIxmn9YvpzNDG8TYPhJkFFERhNayYX671rkJmNW7Jc8ofU5sgWsvuilYNyoQ8lbZwMktm/VfUuGQYzYQneQHFZ78OiRLKremYtqtgyXFY9GU7cRIolt/XcN2kDe3kNU3uTnqFtm2zQgG1G1/Zks3zzcrmgy2NiMsB97rDWSqGICB9jPz8J73k7t6X4ipJTdVHWvOQpp9NAqO16foTvEo1srxYHvhGtwOi1PsjT1uN1zK/jAmaMD790/vFaRwx2YPgjdrC8y+IHPmG8IcDs2ItnG8WpqDrLcC/vobKvwB5O7dpPLbbkQ915N8NY1cWqEa1IJngnPpM858oz6ftAqdcsFa+zj2VHFQU5nhHuKjuBtwukdqcGgER/GLRFKxq2aNdfibBgTvVZkd4BLGUe1TkTy4V8JFVB6ps9riYV+XQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(2906002)(36756003)(316002)(38350700002)(38100700002)(4326008)(8676002)(66556008)(66476007)(5660300002)(66946007)(8936002)(6916009)(86362001)(1076003)(186003)(478600001)(2616005)(6512007)(26005)(41300700001)(83380400001)(6486002)(6506007)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dYhTeJtYMloELclw6Sgyn5EMLCELwv2juWu9l3cX/RTFv00BNowA0YwGaMGi?=
 =?us-ascii?Q?ZtI4Ec0LzxGXA/xEMVzCXpZzC87pPAAl/EKMNFwfEFDsUUCFe/cVnGF8Um1r?=
 =?us-ascii?Q?+1EREl5YoayunflqZRUNiAJT68EIjGCPlb8Ph7FXXkdRulyBg54OLckicmTu?=
 =?us-ascii?Q?Q9Yu2yWvRf3pltgfEeWyJosFJ+WPvp4z/cW8VJsx75EcGDRcRVEL9e4txXkT?=
 =?us-ascii?Q?R7VgaxJ0MPqop+VxQGAnPAF3scveLKaWJuP4JD2fGM9P3TZDU2dzlnG+zb7D?=
 =?us-ascii?Q?V/OSlLV0LQhNmZq8dUad/e+lP8SkVBwdxYvq9A/p8Otjq/cAbii+XLfH8v2O?=
 =?us-ascii?Q?C0r4sqZ1SxX59JRJUa9qkp+NH7ETcHedAyXj/nYUY1+rmhJ1588xNln73FEF?=
 =?us-ascii?Q?/mrjTnDapCVHq9c6RS44NXfKkQTmUTgcSr/MiQeNxzFNqXKDx0MoEFuvNVSY?=
 =?us-ascii?Q?Xh7TnMKxdULxK8j1sR9odmEdgsuXx2XTUVi6dYAgAxh4dcPInC96FEkW9sN9?=
 =?us-ascii?Q?BghZmHioMH7FRHj5Qw3T4ZfpAI+zBY7k9OnP/Q3h8cW4mF2tnSsJ6+0nHl9+?=
 =?us-ascii?Q?H4lkgVcywxARjg4vNVKyB+P577tcfh83bP8hRUiTMY0TdFmE12BESPakqPM8?=
 =?us-ascii?Q?Wb24P1TK+/wUkcExv2UVZwH48VLfCM3vWI7mFBwk7YLpvBZy3gKXhAG1c056?=
 =?us-ascii?Q?yCkhJbF/qaKPhrR3QtYNRxfB5j2bjQfiLyL76LMOsIs040P+RzdOPZBx2pak?=
 =?us-ascii?Q?/Ek9XMt0bXaiVTPFEn1zVwxeYlL7GXaBxXk3ukAI7YFSMuZ33vzqLObU20hD?=
 =?us-ascii?Q?OcPtgguyG4Vd4t0JrPEhsqe6W/Q2hv71cedzgn79hrpDQbSTAnwiddbD0HqH?=
 =?us-ascii?Q?PxbwmjopyRGLx5ZapKksO71I2SRbswp2Ulx/JGoB0JZhGbh8+eRSxAle4bOH?=
 =?us-ascii?Q?KD6e5qHx5EnhYBH5l/W/EBGO9lbkv7WzfaMllzpV3Snt1pq/RZ4CcMwHz+yi?=
 =?us-ascii?Q?pytyZyF9e1WapamD+QScnM/eo72Uo0xMSqtq8YszttYqXurVh4Sb4jTFVtt/?=
 =?us-ascii?Q?jlx8xdHITbeQ28IqXq5ivv9prPPAWATZg+hJz+KQytaBbfoVajqHXHTwdJAX?=
 =?us-ascii?Q?vIZU3mn9GTmypvGJQP1s+QU5KrIfPAZg/uUamkUyxxgip8M+bH+ZSD1qFfaG?=
 =?us-ascii?Q?WfNU4IklZhiVUAdXExVuKa/C6jaKStb13svYIDtJSmGh2wuK36wl0D1ra+10?=
 =?us-ascii?Q?XUeFuHGsURrt2XRAqkZes6q4EC195CijYS/yU9PJwQl5R7nM46i6dr+ZNrE7?=
 =?us-ascii?Q?J9tdVs15gnN6EiVIHq3ImlCGce+YeBGW4kh5wtY55izr0PNX1aLOIDQiv0nD?=
 =?us-ascii?Q?BZiHoZq2eqAzt8d/MKQUS7ujvrBQ9pyvwLDDNokeUSmfOr9vmhjZrD5VS/bv?=
 =?us-ascii?Q?09A3tgkgEGCy3IfY3epLkbOupciP3QwnA7r2jiNZZWpiD2qUc3x0v3kStVmY?=
 =?us-ascii?Q?M7VIFusA79q2/ixp3pz406Oit00SmxZbAO5mo6//N0uCkA33+ZMVPt9pPNkX?=
 =?us-ascii?Q?NNj7FBeOuMFzAHB3kLM8xzSBeenOtmge0wpCk2Bk0koSP1sWlWfgwtBZELZg?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b436c0-423d-4c5b-38c1-08da9a516bff
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:12:52.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBtL2NQOD/G3/IlklM92fRyjvNvEv09a8+N5DIMjaSfLVppeE80z+g/JTAafZXh5rwEw5lB1vhSZLA0rGsOwwnIZYu1merU29gcUta1kg5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190102
X-Proofpoint-GUID: FHYq9STBTtgZOlriSpk6gpAC4Vbd_QP-
X-Proofpoint-ORIG-GUID: FHYq9STBTtgZOlriSpk6gpAC4Vbd_QP-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,

On Mon, Sep 19, 2022 at 09:05:55AM +0800, eadavis@sina.com wrote:
> From: Edward Adam Davis <eadavis@sina.com>
> 
> Parallelized object serialization uses spin_unlock for unlocking a spin lock
> that was previously locked with spin_lock.

There's nothing unusual about that, though?

> This caused the following lockdep warning about an inconsistent lock
> state:
> 
>         inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.

Neither HARDIRQ-ON-W nor IN-HARDIRQ-W appear in the syzbot report, did
you mean SOFTIRQ-ON-W and IN-SOFTIRQ-W?

> We must use spin_lock_irqsave, because it is possible to trigger tipc 
> from an irq handler.

A softirq handler, not a hardirq handler.  I'd suggest using
spin_lock_bh() instead of _irqsave in your patch.


A Fixes tag would be helpful for stable and folks backporting this fix
to understand what kernel versions are affected.

> WARNING: inconsistent lock state
> 6.0.0-rc5-syzkaller-00025-g3245cb65fd91 #0 Not tainted
> --------------------------------
> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> syz-executor.2/27685 [HC0[0]:SC1[1]:HE1:SE0] takes:
> ffffe8ffffc7d280 (&pd_list->lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
> ffffe8ffffc7d280 (&pd_list->lock){+.?.}-{2:2}, at: padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
> {SOFTIRQ-ON-W} state was registered at:
>   lock_acquire kernel/locking/lockdep.c:5666 [inline]
>   lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
>   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
>   spin_lock include/linux/spinlock.h:349 [inline]
>   padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
>   pcrypt_aead_enc+0x57/0x70 crypto/pcrypt.c:89
>   padata_do_parallel+0x87b/0xa10 kernel/padata.c:217
>   pcrypt_aead_encrypt+0x39f/0x4d0 crypto/pcrypt.c:117
>   crypto_aead_encrypt+0xaa/0xf0 crypto/aead.c:94
>   tls_do_encryption net/tls/tls_sw.c:529 [inline]
>   tls_push_record+0x13e8/0x3260 net/tls/tls_sw.c:762
>   bpf_exec_tx_verdict+0xd82/0x11a0 net/tls/tls_sw.c:802
>   tls_sw_sendmsg+0xa62/0x1820 net/tls/tls_sw.c:1014
>   inet6_sendmsg+0x99/0xe0 net/ipv6/af_inet6.c:653
>   sock_sendmsg_nosec net/socket.c:714 [inline]
>   sock_sendmsg+0xcf/0x120 net/socket.c:734
>   sock_write_iter+0x291/0x3d0 net/socket.c:1108
>   call_write_iter include/linux/fs.h:2187 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x9e9/0xdd0 fs/read_write.c:578
>   ksys_write+0x1e8/0x250 fs/read_write.c:631
>   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>   __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
>   do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
>   entry_SYSENTER_compat_after_hwframe+0x70/0x82
> irq event stamp: 740
> hardirqs last  enabled at (740): [<ffffffff814919a0>] __local_bh_enable_ip+0xa0/0x120 kernel/softirq.c:401
> hardirqs last disabled at (739): [<ffffffff814919c3>] __local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:378
> softirqs last  enabled at (0): [<ffffffff8146f02e>] copy_process+0x213e/0x7090 kernel/fork.c:2202
> softirqs last disabled at (717): [<ffffffff81491843>] invoke_softirq kernel/softirq.c:445 [inline]
> softirqs last disabled at (717): [<ffffffff81491843>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&pd_list->lock);
>   <Interrupt>
>     lock(&pd_list->lock);
> 
>  *** DEADLOCK ***
> 
> 4 locks held by syz-executor.2/27685:
>  #0: ffff8880445f0460 (sb_writers#3){.+.+}-{0:0}, at: open_last_lookups fs/namei.c:3470 [inline]
>  #0: ffff8880445f0460 (sb_writers#3){.+.+}-{0:0}, at: path_openat+0x2613/0x28f0 fs/namei.c:3688
>  #1: ffff8880465111a0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
>  #1: ffff8880465111a0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
>  #1: ffff8880465111a0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: path_openat+0x1514/0x28f0 fs/namei.c:3688
>  #2: ffffc900001e0d70 ((&d->timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:31 [inline]
>  #2: ffffc900001e0d70 ((&d->timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1464
>  #3: ffffffff8bf89400 (rcu_read_lock){....}-{1:2}, at: buf_msg net/tipc/msg.h:202 [inline]
>  #3: ffffffff8bf89400 (rcu_read_lock){....}-{1:2}, at: tipc_bearer_xmit_skb+0x8c/0x410 net/tipc/bearer.c:550
> 
> stack backtrace:
> CPU: 1 PID: 27685 Comm: syz-executor.2 Not tainted 6.0.0-rc5-syzkaller-00025-g3245cb65fd91 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_usage_bug kernel/locking/lockdep.c:3961 [inline]
>  valid_state kernel/locking/lockdep.c:3973 [inline]
>  mark_lock_irq kernel/locking/lockdep.c:4176 [inline]
>  mark_lock.part.0.cold+0x18/0xd8 kernel/locking/lockdep.c:4632
>  mark_lock kernel/locking/lockdep.c:4596 [inline]
>  mark_usage kernel/locking/lockdep.c:4527 [inline]
>  __lock_acquire+0x11d9/0x56d0 kernel/locking/lockdep.c:5007
>  lock_acquire kernel/locking/lockdep.c:5666 [inline]
>  lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:349 [inline]
>  padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
>  pcrypt_aead_enc+0x57/0x70 crypto/pcrypt.c:89
>  padata_do_parallel+0x87b/0xa10 kernel/padata.c:217
>  pcrypt_aead_encrypt+0x39f/0x4d0 crypto/pcrypt.c:117
>  crypto_aead_encrypt+0xaa/0xf0 crypto/aead.c:94
>  tipc_aead_encrypt net/tipc/crypto.c:821 [inline]
>  tipc_crypto_xmit+0xf7a/0x2af0 net/tipc/crypto.c:1756
>  tipc_bearer_xmit_skb+0x1ed/0x410 net/tipc/bearer.c:557
>  tipc_disc_timeout+0x75e/0xcb0 net/tipc/discover.c:335
>  call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
>  expire_timers kernel/time/timer.c:1519 [inline]
>  __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
>  __run_timers kernel/time/timer.c:1768 [inline]
>  run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
>  __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571
>  invoke_softirq kernel/softirq.c:445 [inline]
>  __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
>  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
>  </IRQ>

The changelog doesn't explain the problem or why the proposed solution
fixes it.

If I can read these splats right, it seems lockdep is complaining about
how a task can take the reorder lock when softirqs are enabled
(SOFTIRQ-ON-W) as in the tls_push_record() stack, but also when it's in
softirq context (IN-SOFTIRQ-W), as in the tipc_disc_timeout() stack.  So
it should be enough to disable softirq here.

> Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> Reported-by: syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com
> ---
>  kernel/padata.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/padata.c b/kernel/padata.c
> index e5819bb8bd1d..38c7b17da796 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -388,14 +388,15 @@ void padata_do_serial(struct padata_priv *padata)
>  	int hashed_cpu = padata_cpu_hash(pd, padata->seq_nr);
>  	struct padata_list *reorder = per_cpu_ptr(pd->reorder_list, hashed_cpu);
>  	struct padata_priv *cur;
> +	unsigned long flags;
>  
> -	spin_lock(&reorder->lock);
> +	spin_lock_irqsave(&reorder->lock, flags);
>  	/* Sort in ascending order of sequence number. */
>  	list_for_each_entry_reverse(cur, &reorder->list, list)
>  		if (cur->seq_nr < padata->seq_nr)
>  			break;
>  	list_add(&padata->list, &cur->list);
> -	spin_unlock(&reorder->lock);
> +	spin_unlock_irqrestore(&reorder->lock, flags);
>  
>  	/*
>  	 * Ensure the addition to the reorder list is ordered correctly
> -- 
> 2.37.2
> 
