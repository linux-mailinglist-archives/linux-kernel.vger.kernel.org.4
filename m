Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78275BD0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiISP2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiISP17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:27:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D995FD4E;
        Mon, 19 Sep 2022 08:27:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JDOMkg013592;
        Mon, 19 Sep 2022 15:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=grwk+7Nf2V7P+kMswQ9g8hLs9YrvDULViQFD/H06sUU=;
 b=YxsE9E9dL88dgnVycioXJQKY+d4P66jFbzCU5ACy8PPf4AfpGm4p8SEtYDJB/ZbFGd8v
 v8lU1K4TGGYJQ9tPCeNoMpq4LA7cVmzsjUwBFgnKFhI+g73rNU7rkRohCuOhmykhjibj
 wnsQyyFNNUxO+UwH8uJT8CVZTsI2g7xb8YO1b/hG0sK7nWU73Vuo7BlSow0lyDCDuYz8
 kSHob3szyY8iYPWb+Ky/+1iqe6SQ3LMX2ehLRDh1SYHKy0JS6YiTkvv6PFd08fmsi17U
 XKuRDTsdmbjroOVOTPF+ABxtFtTADvqDnuZLtdc8btv4upLpL7PpiY3KNPTuvkWMq9nq Ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6f0c3bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 15:27:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JDjjJr009513;
        Mon, 19 Sep 2022 15:27:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3c7umqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 15:27:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7+97RqwmzFUrZmB65L4d+Z4MK12znWWZ1fUYabgaTHX4OmfuxG5/T4tf36ccwcL2vFo7f0EO63vAOcPq7G33QjyGQnFIqm/f0YQhnb/BXJyykOyywprFYtlyKbIG/YlL+1wT2fUtAHI/7VSJbZK2PwzNocRVQKqESKfjKJmhoF5fUkzLobZBp8bzDBqZY1oy6QZ1msHaJkajxDWEy2y1WVjNo60xXklM4TOcMuhIs74o1ropFH6c/2vh3v7e2Eichy50Felm8lMRT5WOH49Orfcko6EcbwDcP/N5k/R0ZWoQRar/c2wr/n4FB6ZhMCF7CM/YwukI6rBd/k7pTXNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grwk+7Nf2V7P+kMswQ9g8hLs9YrvDULViQFD/H06sUU=;
 b=i7qkl7mUkYBk96niJOvr++foSSLt/hYm8EKPx1FwhPfXHRPnRgNpe4Akksc04xc8LBFSZajuurKQOLPWu5zg2KlyIt8d60u9QRfrfNs2s/U2t5c9/ScsxiBmXVwjdHL6IR5LQen2oNGIwj7ZaeLr321cD4w59Y5I7+NQ4EGT+mNWftIRJRHKDuMOK0wzY+v5fG2Ki7zLhLyo37g3gNvEgqrTkqfqjEqtshlCUpD//n8gFGLpeCRKxh2LVpPW1ny7MRY9qBl/7mTQf5N52MskkAAjKwq32wpimTNf+IJaC3TCvH4c77BbaTi0qLd+I3ZpbKl81/7A4cw/+L6LFo1PtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grwk+7Nf2V7P+kMswQ9g8hLs9YrvDULViQFD/H06sUU=;
 b=lZgJjLfIDAId/fvO7gmbX5lJJpyRaZtr+a4xcLWyvjRYUKxTiH8U6+ZnITPxNxhevznPSqdxtN/dotsjQMcEdNh9CXm25V0iFnKcVU2C/w85pxU8CgQNwb3Yf67f425aTRu9LY+MJ3cHwqzAcEfxwWwCkvs7UytYY2mkjQ8fQWc=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 15:27:44 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::64a1:f8fa:afd0:1eda]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::64a1:f8fa:afd0:1eda%4]) with mapi id 15.20.5632.015; Mon, 19 Sep 2022
 15:27:44 +0000
Date:   Mon, 19 Sep 2022 11:27:40 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     eadavis@sina.com
Cc:     syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] padata: fix lockdep warning in padata serialization
Message-ID: <20220919152740.t7keqbjfvl4ylf77@oracle.com>
References: <000000000000122cfc05e8f8d09b@google.com>
 <20220919010555.130609-1-eadavis@sina.com>
 <20220919151248.smfo7nq6yoqzy2vo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919151248.smfo7nq6yoqzy2vo@oracle.com>
X-ClientProxiedBy: BL1PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::26) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 565f8520-9fe6-464a-384b-08da9a537ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0eK4w8uV4M9tjpvYSxakaUXZMOrIG6fmydrZ2kyUvTf6RWWCQ1Kkehxrj4qL+mS7ykEuW7RExWMPEfbIZ1vcVW8SmpSfEHzTSoEomjJGOY+nRpwnxcBLBOPKCYZkYTtaqtPLz2OiwZf2Z98b1pOuq01W2kMcvaKLBwPyp+1koZourcgDYHS1VjCYkWXfFTqJc1Z2a0kFXZ93v3MxYmEOKmPjqJp8iZ/tJlch5VhFTsBJb1s+OvsQiOnyX++3mR9JT9JLklrFBfrV7k8sPv7aeQskjjVi45whJ+Hpj4/Z5SB9K3YnSaC4UjaCvZGkQBrp0zThxa2e+1o9ria8oD1BB4nSwuHsLnDp2r6SN6U6/UuYXDjIGQ/0TYDa8UfzU8EqEisl6EdwT4mxYX0LevCgJZZBZcNqNq31HXY7PpdZdqlHJXNG44qzRgKVMHPU1knWrGv41FwDh+H6d0OXqxY3wZWSiIknnIyIH/jV32wupwISFJDJqrifsTZ8mWLJ7VBQ/j4/4JzTc/H2FcxGHsJpjudOhUmZym4zZBB1x6bRKieAeyrQJpICgwY1dqqMKVcJSC2CP9pkJpA83/ZdBgs+aCdeRwVCBMMqBXwcN97VJ02HP5DaYXjRXeca9rierTUL6+ybV7WyKJvk5UR7ZUBV/nijwKOQtzRJP2s4eanmvf7W18uUkgk9aEkUygJV4ni+IQhNh+Nh0gbZjmFEyaguVZZPEGb+rSoI8rdO/pohQPd1GFVJy3bATiet33Gdvi2jUeBrd24QNoFy5nmyiELyBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(6916009)(186003)(2616005)(1076003)(86362001)(83380400001)(38350700002)(38100700002)(8936002)(66946007)(41300700001)(66556008)(66476007)(4326008)(8676002)(2906002)(26005)(52116002)(5660300002)(6666004)(6512007)(6506007)(316002)(6486002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qphM5omHVGKTenjs8RObbxeLH0hCgiFlNhe1uS/f7UrZ7kuniok+KUFWihcF?=
 =?us-ascii?Q?Q9MCE4N70+RVgzCTfMSDkWHbF7V6zAP1TrGs00PW0OLqkwbu9HIKuMgmgs+6?=
 =?us-ascii?Q?xsFgNWt4D/2uBtR8OrGdlLvB9n7+Jq/HxASEB2Ib/BqX8dMDbqiXROnWw/Cx?=
 =?us-ascii?Q?h5gpsCfC6sqP89MchlNx4LrgpjUTQv4b4QeOlxXnfFqYhT0tXwJEcV3acuju?=
 =?us-ascii?Q?J2CC+8L0pdoOeQhNx15vgwsegceh3BCS2tVE/lPSd630nSTgYjsoZ+fpnpMV?=
 =?us-ascii?Q?NiiRKQpHRFgc6IyqRQYWtw3QpigPh/sZoVyfuM669FhodCj/L7wB1OonF3xw?=
 =?us-ascii?Q?34tJ6FMZHsIMwkeCp44QZZFL8uxCG/FOegQxMFR4wFGRLKtxvpAbQXg2U2u9?=
 =?us-ascii?Q?X8YXBDN9ZJo1K/nltzcBpDR+mzLGL6Et6o7L7vGC84kB6On8U7X5rAR2eFIE?=
 =?us-ascii?Q?YvAfZDl3zMLcXWlK5fzOp6lkW4g+LXhmqWSaUUSFsrmm7Au1IvZptuImDaf0?=
 =?us-ascii?Q?h2q/o6mavkbPMMC9HZhfrNZvKcPnWJUpgMCA6MF0d5FPEENUMnJLBScNTLVP?=
 =?us-ascii?Q?q/S1Upru9b83jefF77wLMPWnXgjqKMFk8RrJbvZrjaYjr2GLJLiWKTFVJxvp?=
 =?us-ascii?Q?BlP0djtDhJcFxnQHSTzkL+89SdpG97+k3FHpEuNazznLs4ASHHdAc2LVJh0w?=
 =?us-ascii?Q?S/UkJ+4W88LVWy7tpz2/thgkoLnl3jlD8gO7Hkj8mn0tdKFzeLOr0VW/fJgx?=
 =?us-ascii?Q?9VPBT/33Y2pB93J/QRc7uc88SCiwRMGAKPxCdpACpRdyUBWfYiIyvEKXDcSf?=
 =?us-ascii?Q?P4xFLolKptEEeC+WVu3SdaP6lqt0vnFYymyfPor7GnD/5VPdFEq5OahoxXsO?=
 =?us-ascii?Q?q058+pvnn/jdk+fWY6M2NhurBzD0iN1vFa72u9VSFIjl5s2CSfqQhN/56Nhx?=
 =?us-ascii?Q?f9V/lDTLfYG2s6tCdb7uuusgt8QY/Zw7dwgGho0ufhB/pXItK+lL5soksyXs?=
 =?us-ascii?Q?JIt/+F21o+Fesu7I8jTaqR64jl0uvpX4KBkVBcHqY61SwflrTba7IO+BLGB7?=
 =?us-ascii?Q?ZrHKUo+KGx78t9m0rpBr/K9Vr5fvc3FXP+Gmlc7NjCeeBCvrw2w/T9WZVMyS?=
 =?us-ascii?Q?Cu9pPy9kpd/zxqEE0SOvXXJp6dqseBvDY1dQLH9seInDcbZdYfoMD5S/EbWk?=
 =?us-ascii?Q?bqgnh5mCLLwD04ezpHsRWMmuCszzkmoMZ2WaLBQKVQm7azbcuqdsTtzFJSTM?=
 =?us-ascii?Q?tBtaR95zOkDFSO0RZzM9k9xwDGN2aL4WH36yhZCDpio+xvfTW0AjeMOwAVZ9?=
 =?us-ascii?Q?Y/+18ELwWrhGkDOIrZzongIEwsMepvjtXf63D9177fuRHMET2IdCN1DILF3g?=
 =?us-ascii?Q?DfBP/OLtf4bEkkWxhB0/MkhVurRChbWAMaXU0hclnvAcor6RuKzJfLMcdnNe?=
 =?us-ascii?Q?wjFapkOHYLbATQYkJMw0kKVx35/xuYA8sn8dG4dZ6Z8ZKwChIAmlTkBB4sBA?=
 =?us-ascii?Q?+1k4dLdmXrU1LcQ+q51UarNm+2kUCffmo06DLR1B8UjdQCehaEULleG2sg/C?=
 =?us-ascii?Q?MkBquCO0UPIMc2kg7lcVh+TAUIM5PX4KoL6QHZd10cg+caydpHj9XcmIU3ep?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565f8520-9fe6-464a-384b-08da9a537ffd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:27:44.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kp16OLmhhly02dZuaHIPf4etnKV2szbZAyEfRvPUQiPUhbvSuHPSXQjss4T340MSWTBAWsDplKSoULG6Qzk/MHuHqxOmu3/s8cDrB0uXoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190103
X-Proofpoint-GUID: 4xzFUL4pjK5iu2xp0RQdJCBUkGWcyJ3X
X-Proofpoint-ORIG-GUID: 4xzFUL4pjK5iu2xp0RQdJCBUkGWcyJ3X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 11:12:48AM -0400, Daniel Jordan wrote:
> Hi Edward,
> 
> On Mon, Sep 19, 2022 at 09:05:55AM +0800, eadavis@sina.com wrote:
> > From: Edward Adam Davis <eadavis@sina.com>
> > 
> > Parallelized object serialization uses spin_unlock for unlocking a spin lock
> > that was previously locked with spin_lock.
> 
> There's nothing unusual about that, though?
> 
> > This caused the following lockdep warning about an inconsistent lock
> > state:
> > 
> >         inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> 
> Neither HARDIRQ-ON-W nor IN-HARDIRQ-W appear in the syzbot report, did
> you mean SOFTIRQ-ON-W and IN-SOFTIRQ-W?
> 
> > We must use spin_lock_irqsave, because it is possible to trigger tipc 
> > from an irq handler.
> 
> A softirq handler, not a hardirq handler.  I'd suggest using
> spin_lock_bh() instead of _irqsave in your patch.
> 
> 
> A Fixes tag would be helpful for stable and folks backporting this fix
> to understand what kernel versions are affected.
> 
> > WARNING: inconsistent lock state
> > 6.0.0-rc5-syzkaller-00025-g3245cb65fd91 #0 Not tainted
> > --------------------------------
> > inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > syz-executor.2/27685 [HC0[0]:SC1[1]:HE1:SE0] takes:
> > ffffe8ffffc7d280 (&pd_list->lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
> > ffffe8ffffc7d280 (&pd_list->lock){+.?.}-{2:2}, at: padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
> > {SOFTIRQ-ON-W} state was registered at:
> >   lock_acquire kernel/locking/lockdep.c:5666 [inline]
> >   lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
> >   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> >   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
> >   spin_lock include/linux/spinlock.h:349 [inline]
> >   padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
> >   pcrypt_aead_enc+0x57/0x70 crypto/pcrypt.c:89
> >   padata_do_parallel+0x87b/0xa10 kernel/padata.c:217
> >   pcrypt_aead_encrypt+0x39f/0x4d0 crypto/pcrypt.c:117
> >   crypto_aead_encrypt+0xaa/0xf0 crypto/aead.c:94
> >   tls_do_encryption net/tls/tls_sw.c:529 [inline]
> >   tls_push_record+0x13e8/0x3260 net/tls/tls_sw.c:762
> >   bpf_exec_tx_verdict+0xd82/0x11a0 net/tls/tls_sw.c:802
> >   tls_sw_sendmsg+0xa62/0x1820 net/tls/tls_sw.c:1014
> >   inet6_sendmsg+0x99/0xe0 net/ipv6/af_inet6.c:653
> >   sock_sendmsg_nosec net/socket.c:714 [inline]
> >   sock_sendmsg+0xcf/0x120 net/socket.c:734
> >   sock_write_iter+0x291/0x3d0 net/socket.c:1108
> >   call_write_iter include/linux/fs.h:2187 [inline]
> >   new_sync_write fs/read_write.c:491 [inline]
> >   vfs_write+0x9e9/0xdd0 fs/read_write.c:578
> >   ksys_write+0x1e8/0x250 fs/read_write.c:631
> >   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
> >   __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
> >   do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> >   entry_SYSENTER_compat_after_hwframe+0x70/0x82
> > irq event stamp: 740
> > hardirqs last  enabled at (740): [<ffffffff814919a0>] __local_bh_enable_ip+0xa0/0x120 kernel/softirq.c:401
> > hardirqs last disabled at (739): [<ffffffff814919c3>] __local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:378
> > softirqs last  enabled at (0): [<ffffffff8146f02e>] copy_process+0x213e/0x7090 kernel/fork.c:2202
> > softirqs last disabled at (717): [<ffffffff81491843>] invoke_softirq kernel/softirq.c:445 [inline]
> > softirqs last disabled at (717): [<ffffffff81491843>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
> > 
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> > 
> >        CPU0
> >        ----
> >   lock(&pd_list->lock);
> >   <Interrupt>
> >     lock(&pd_list->lock);
> > 
> >  *** DEADLOCK ***
> > 
> > 4 locks held by syz-executor.2/27685:
> >  #0: ffff8880445f0460 (sb_writers#3){.+.+}-{0:0}, at: open_last_lookups fs/namei.c:3470 [inline]
> >  #0: ffff8880445f0460 (sb_writers#3){.+.+}-{0:0}, at: path_openat+0x2613/0x28f0 fs/namei.c:3688
> >  #1: ffff8880465111a0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
> >  #1: ffff8880465111a0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: open_last_lookups fs/namei.c:3480 [inline]
> >  #1: ffff8880465111a0 (&sb->s_type->i_mutex_key#9){++++}-{3:3}, at: path_openat+0x1514/0x28f0 fs/namei.c:3688
> >  #2: ffffc900001e0d70 ((&d->timer)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:31 [inline]
> >  #2: ffffc900001e0d70 ((&d->timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1464
> >  #3: ffffffff8bf89400 (rcu_read_lock){....}-{1:2}, at: buf_msg net/tipc/msg.h:202 [inline]
> >  #3: ffffffff8bf89400 (rcu_read_lock){....}-{1:2}, at: tipc_bearer_xmit_skb+0x8c/0x410 net/tipc/bearer.c:550
> > 
> > stack backtrace:
> > CPU: 1 PID: 27685 Comm: syz-executor.2 Not tainted 6.0.0-rc5-syzkaller-00025-g3245cb65fd91 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  print_usage_bug kernel/locking/lockdep.c:3961 [inline]
> >  valid_state kernel/locking/lockdep.c:3973 [inline]
> >  mark_lock_irq kernel/locking/lockdep.c:4176 [inline]
> >  mark_lock.part.0.cold+0x18/0xd8 kernel/locking/lockdep.c:4632
> >  mark_lock kernel/locking/lockdep.c:4596 [inline]
> >  mark_usage kernel/locking/lockdep.c:4527 [inline]
> >  __lock_acquire+0x11d9/0x56d0 kernel/locking/lockdep.c:5007
> >  lock_acquire kernel/locking/lockdep.c:5666 [inline]
> >  lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
> >  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> >  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
> >  spin_lock include/linux/spinlock.h:349 [inline]
> >  padata_do_serial+0x21e/0x4b0 kernel/padata.c:392
> >  pcrypt_aead_enc+0x57/0x70 crypto/pcrypt.c:89
> >  padata_do_parallel+0x87b/0xa10 kernel/padata.c:217
> >  pcrypt_aead_encrypt+0x39f/0x4d0 crypto/pcrypt.c:117
> >  crypto_aead_encrypt+0xaa/0xf0 crypto/aead.c:94
> >  tipc_aead_encrypt net/tipc/crypto.c:821 [inline]
> >  tipc_crypto_xmit+0xf7a/0x2af0 net/tipc/crypto.c:1756
> >  tipc_bearer_xmit_skb+0x1ed/0x410 net/tipc/bearer.c:557
> >  tipc_disc_timeout+0x75e/0xcb0 net/tipc/discover.c:335
> >  call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
> >  expire_timers kernel/time/timer.c:1519 [inline]
> >  __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
> >  __run_timers kernel/time/timer.c:1768 [inline]
> >  run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
> >  __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571
> >  invoke_softirq kernel/softirq.c:445 [inline]
> >  __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
> >  irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
> >  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
> >  </IRQ>
> 
> The changelog doesn't explain the problem or why the proposed solution
> fixes it.
> 
> If I can read these splats right, it seems lockdep is complaining about
> how a task can take the reorder lock when softirqs are enabled
> (SOFTIRQ-ON-W) as in the tls_push_record() stack, but also when it's in
> softirq context (IN-SOFTIRQ-W), as in the tipc_disc_timeout() stack.  So
> it should be enough to disable softirq here.

...to avoid a deadlock.  Helpful to include the impact to the user too.

> 
> > Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> > Reported-by: syzbot+bc05445bc14148d51915@syzkaller.appspotmail.com
> > ---
> >  kernel/padata.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/padata.c b/kernel/padata.c
> > index e5819bb8bd1d..38c7b17da796 100644
> > --- a/kernel/padata.c
> > +++ b/kernel/padata.c
> > @@ -388,14 +388,15 @@ void padata_do_serial(struct padata_priv *padata)
> >  	int hashed_cpu = padata_cpu_hash(pd, padata->seq_nr);
> >  	struct padata_list *reorder = per_cpu_ptr(pd->reorder_list, hashed_cpu);
> >  	struct padata_priv *cur;
> > +	unsigned long flags;
> >  
> > -	spin_lock(&reorder->lock);
> > +	spin_lock_irqsave(&reorder->lock, flags);
> >  	/* Sort in ascending order of sequence number. */
> >  	list_for_each_entry_reverse(cur, &reorder->list, list)
> >  		if (cur->seq_nr < padata->seq_nr)
> >  			break;
> >  	list_add(&padata->list, &cur->list);
> > -	spin_unlock(&reorder->lock);
> > +	spin_unlock_irqrestore(&reorder->lock, flags);
> >  
> >  	/*
> >  	 * Ensure the addition to the reorder list is ordered correctly
> > -- 
> > 2.37.2
> > 
