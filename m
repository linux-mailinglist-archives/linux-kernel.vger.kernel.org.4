Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D76F0B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243905AbjD0RkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbjD0Rj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:39:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630EF559E;
        Thu, 27 Apr 2023 10:39:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RFn1RA002572;
        Thu, 27 Apr 2023 17:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=x+177+5YsOsT4Bmr42FwgHgXkFSpzE9mGxRgW3peBGg=;
 b=dY2C2dLOXVyZ+ze40xVk8Wl4seW+8vcnSC1UOuVFSixc6XENtNNdyM/RtdqQgJQesjDR
 HBRD0hbwwMMyWltB76pHxd++aZZkvvnLhUB2dRiRF6/CFu8xDxG2reSnpB+VaZ/isqd6
 oHGkFSk9ybfLrZebQkQQsKJFJRnrFapXRfugoRcoS+LY8Wtdh3MJ2XYouenO2u2xblAl
 bdUorkN+ddjK9MUJBVfvcZZ4dHFBppADZ5cdPkI1j8V3sAckPf96J3KaMy80NdgHMdN2
 PMJSjm4n1eUuep3/1vNmzmcqqDLg+A/uyzH9mtqD12oOFIxqDvCzAHXdMv9jksX1z0zN fQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484uvje5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 17:33:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RGphNv013409;
        Thu, 27 Apr 2023 17:33:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4619e0x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 17:33:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9HP45Te4nW7Tcl1wav/B+O2X2XnO2NjW1zEIWGblZQhc98GdQmDUlfklbXxpgo2iEdBYWaIgUftiprlxPWgTX7r9rFUes+FbWmN26Jpb4P2uqE8nzpsn/lJ0XSRkRJIvJ5BPsi2OzlF4wApZZgSRsyodJuEDB8kN+2irQoUerROfGQ8BccfYmH2KUxeak79srDKR2bmITGCJS3of/XXlhzCR9pgPHJIgrbna4l92zjv087NbrMHJCgvoJKMvxZ1Nbx0+XFj4X4Lo93pSVq7GMu7YxVILN2CdPCZQ6ksckKCUrEHM3qBUJCa9X69EHwaJRsjOamaDhXsKRvcrEwEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+177+5YsOsT4Bmr42FwgHgXkFSpzE9mGxRgW3peBGg=;
 b=A2u4SEkbVWFHCazHEAXQp2h9ghWN9Zk+U/UQhu+cSWd7rl8qp9+3UYdX/wIEc+TQ5BjizVzC1accfhS9Rq9QMruAzM+aExdjCFmJzRKmsyMmxcKb7YkJVCHVF1M8iFs0pLKmQz4kX62ILLKVmzmBD2XsEyFMpJ5gIaxjwofNkRSPq3UvJGv/lDont9spz5eh++GJgmawOkeEO+8lP4TFEALcRlmmOv483Vl56ECK9cVKLi0P8jPrc6LLV4paTS8R7JPeAJ5rDOTxX4s58wThCPTHTLx6CmmOGyI7i2vEigjuavi5GsyBwl3J0aZqI1aauZSA2ZbMflEOclsmtAcg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+177+5YsOsT4Bmr42FwgHgXkFSpzE9mGxRgW3peBGg=;
 b=gw+Vfozbbz5LkfL0c5oj58l6elfqJMGbLbBiJkZ6I4BhGwOdMVyaEn/kTWhpcnR06LumW0lxiT735ACSbjOdKuFk1SJ4hNMWQDiWxberllNoSX9TucsXLnmzgDC8D0+JvHuoRPg0Yi97SCjTpWQb0DDbzqvhXCmTtNkqJS3kxTw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4391.namprd10.prod.outlook.com (2603:10b6:610:7d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 17:32:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 17:32:49 +0000
Date:   Thu, 27 Apr 2023 13:32:47 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com,
        stable@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: Fix use-after-free of VMA iterator
Message-ID: <20230427173247.s5rn6nujoxiatviu@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com,
        stable@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230410152205.2294819-1-Liam.Howlett@oracle.com>
 <yt9dildhke9l.fsf@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dildhke9l.fsf@linux.ibm.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH2PR10MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 153d6ba9-4ba7-43f8-0a7e-08db47456c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rod/roc2Wt5Hq6J+E6pTGAxwu6CKPGp3WsA4FX3rxSdRta/f+b32yUq4fW5CtmHqMxCyCNe5iMcxEOvsc2xnCKguTFRj+huAAhsXhZNOo1OgWpV95gzTwTigowUajswA0oTk2worv51P61f60KVbrYq6gv5qhhmtDKpLaNBP/o1GfIMENXwgUtyP3W2zI9nltJ0ezn6vrdROvmRVkKxUAMigfh2n+Fh632q+w+RpstGlrdivOF/eLJaHsX5PJRfK7DQLyi+j4sOjSNQdQxwlt0QO3Y+AFTweUf4Ah3NIwF5h4naenWgb+PceR2RmMdzv7zMpk2OyEEx8OBnLgwzRR16KaiTZ0yfagKucT0Q8s62gfmozu0ppWIka5SK0l3b8nu2cO/wTt8o6HdNYT8MHuCWdZcoKiReinnJtfMb+zizAVawyXoGx5dfLbMwEAbrPQB8rg0uGjyp2U6+b61Scm4CTFGSEklBY1G+GGqyCr6G1fHtR/wzBJ/IqUN58enGw/kV8iJR5zo+7xzerf8G2lBEicC+ItFNK+U4afBTm4dE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(1076003)(26005)(6506007)(41300700001)(66556008)(316002)(66946007)(4326008)(6916009)(66476007)(966005)(83380400001)(6512007)(186003)(33716001)(86362001)(6486002)(9686003)(45080400002)(478600001)(5660300002)(2906002)(38100700002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtIFOHk6jC7yBjYY4JdP2kCAmH7tWSpScRMEXtQSipYNcMLkNp3Ef6uqKm4V?=
 =?us-ascii?Q?rvej6Xwg/9w68JmyHJxKPpo25TBRLofRhngfaS04cZIm7fd//QZNpHIG/+t0?=
 =?us-ascii?Q?L4DlOqvZ/1ZV58Fd8wMgmGJO8R663MgZG4EHR/FfXIVWgQxnOWBT3O/SesAf?=
 =?us-ascii?Q?UFcX7hCkRTTTztmPSawetIHZ9dCXjXEuHdxs+dkZRVORVSaIKNlo4eCrsXQc?=
 =?us-ascii?Q?maLucN5Xr1KWU1il+EUmTAzaMqM8XZ7kOWdjUjeeeh9aWr9S+0U9Eas7W4vD?=
 =?us-ascii?Q?jJgrPvtpT12tATCiyr0tm3G6Bp5PcxoQCqgen/H/LmjF5NXpCBi5dZZgODdk?=
 =?us-ascii?Q?sbl1lprH2An7/7CObMPkFSBW82mh75apEwV41O9WLU4RbCKELnunc2+gO71V?=
 =?us-ascii?Q?gyhATwkn1HFogpdPELK4qpMvK4/uj2rFfe8KK0cvuyWT6kjJMlrzC9lxtBSb?=
 =?us-ascii?Q?l8N7MggaM3AIsdZv4WLKGWQ4gQloYmKxSxWaSLRszbqV+9E5nuLFMTO35AWQ?=
 =?us-ascii?Q?xVnJvSWa2nDNK54j8xfUn2tg5+CFUUT4HFplyD8rGVzQjyoQ7X7OyGqDyixR?=
 =?us-ascii?Q?R/2IlFbdWcm6d2CHlId6U75sTchbmJa/XlT/08fgII+z2TgYNC/td0fB3UDy?=
 =?us-ascii?Q?Ta/eeY4POc5QyF8FFnnRBXPUF907dcRze49N174O0m0sbXO4RvuizuaI/wsf?=
 =?us-ascii?Q?sKTkj4PkZsi8BxldCZg9ap35AFDJzO5+Aa2aqqCEmUWJv9lmlN6s7jIlYlEQ?=
 =?us-ascii?Q?zw8u8M+KiTaxOKm2W+8wBAZVq5ogR5cgC8ko+8s7FmFG725G4mrueNfk64YZ?=
 =?us-ascii?Q?mfGPjm0iZ3DE5WOsk42MC1Kd00gffeWjoELoDjNpDia4dhndro/DQCYrI0Dz?=
 =?us-ascii?Q?a4wfoW3rh35if5WwzIgfDC4nmOjGCPrLQR5Ij/dZIIWIx6cFYdRP4kk5tf4k?=
 =?us-ascii?Q?UrxV8inzkfEgMWBU5j9XcGTlVRoLwR3txtaZ4cV6374t2Ntc4LP6TWxUgR9j?=
 =?us-ascii?Q?teULVt3AZM02hDlQlyKGhAIslSOXkhCQWgsZ+F/IgcOYe/YcKLcJhCUHQrzm?=
 =?us-ascii?Q?nrvKVnhVgSPS/vs/vN0plPOeA97QsBU/pTvvkOEpCEPgFoJVNkqvzMBNc6jA?=
 =?us-ascii?Q?DPgoMjaM4rlPyXgR01AgjZBtUmyLQhFek7AOAMbEaZh77cUy9fgyQTFdE88O?=
 =?us-ascii?Q?ODqbUNL31wm3VFjvLOuo0nX/JimkiDRj0mjLEDPUOjlCcrUWwI+GxABrwmPa?=
 =?us-ascii?Q?NVgHs/J0VZ6JvKCqaefRnc+Bwawd6scVKGvm90WJoo1sOiFy+mIJ8vJlPj3v?=
 =?us-ascii?Q?gAh6b2e8pVBBrtSM1ZdgiBjsHE7EUzTnoC0bRRNsRxARLZ+rLUyq2rZ4xOmI?=
 =?us-ascii?Q?UdlUAocGniUpcd/Ns2tXls0bWZFZLoJjjENyrXMdOthulXw95j9tG0MvqYbt?=
 =?us-ascii?Q?lDTA6UvAFh4zeEQ64nkVMJP2zNJAk+5qyaJRHpTS7b3tOG/nxeetXjCs1lbP?=
 =?us-ascii?Q?VxEjVy9hALfACATmm1uHzoiVjjxoL1LP62iB2TlWE3Y+G8HRuDk3jNslJ62E?=
 =?us-ascii?Q?eBeTYKr1SOlwe8bqrCddyi2BBrk7v05+qEFFXd9cIoXNsKm40hxAEmNahiaM?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MDzXfwrZTfvoR7S7uE99Dv/UDXE/9HzIi+R/vke3g96KqSATvyrBJBc1ej7Z?=
 =?us-ascii?Q?sgPWkkbhyi/DpawlYigp3cwWZhNAZa6GfQr7GPFxetqsghYLWY4qkBMHQ2vg?=
 =?us-ascii?Q?30cJ+nyo16dD6DToly6PfqpSezU8hZtqqfyVHS5BOF0E9FzouaJdtDv9R81F?=
 =?us-ascii?Q?JtVs0c9CtYZ0cIx6SyRbbAvjWioYWKyl7XyWwRwKgX0SmapBTl9jLPB6taOq?=
 =?us-ascii?Q?GKRMoowPmJPjY1rYtxlGBvxM+yik/4e+kHcKFytDV2qB//am6Kv8vkV7R6p9?=
 =?us-ascii?Q?b5HhBClMnct1dUiEdMOxxPvboHBx+z57vI5aygLSnauvd0AUfYkBEMlD7XU1?=
 =?us-ascii?Q?ZloA5Y69R2Y6Zm1oR8tuKCzZt5gLqpRnnYeb4dipUG+gi67swRCKuI6n5Wxd?=
 =?us-ascii?Q?7rk+wMO4I/AAC+jRecF8PszFbYXX98Uy0kBg/3Jn7TRzccqFASn+xnab+KQx?=
 =?us-ascii?Q?99xDBvF5zk4+Ai5P0NtePp/bbpwj2z1R1dTSVV9N8tehE5oIzAO+MHwMopSR?=
 =?us-ascii?Q?kOlAXFBVQO0ROxnbmWOahiGs+M3jx+JjpHU9Vd9fYv7vCr3+iiCi4VAs0kqs?=
 =?us-ascii?Q?6k8pj3ckLtd0zYdcB8FvHBvAC9d5autlY8RZC0V5BYFRa07Z8Ws1r6pgPc68?=
 =?us-ascii?Q?LEFzVpdUTd+tT1qeVIrx6s65Sy2vOBgeOAwvQVOHQ0wejtIZ+Yq4C44yQhKG?=
 =?us-ascii?Q?DpLSgRpIhIEeimiKrJjDpnnIfpH7TKmmrlmUrkkPmmNFc3WksjsoGKJhJDkR?=
 =?us-ascii?Q?o3c9sG85wQ4j+eCuXGwWIs7ljKVKOPYWlHS5UVFkTn/MCAv2OT+awgLK/Jsx?=
 =?us-ascii?Q?Te91om9px9ftERciEgV5EZveWrdf1N5mFsWZQBcTG3jNjMv5piKF4WtQ4Lap?=
 =?us-ascii?Q?2pn0zWzMEaJH7j3DVS3ne4+Idk0B4W6zdXOj+iO89sQAYR9sirLsdgvCTmoQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153d6ba9-4ba7-43f8-0a7e-08db47456c22
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 17:32:49.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANgRpViao6MYLkMfr13DEYQUHGsTrLKxrv4KkApcBJ6ennIVp59yy6U4XGwg96F+Kwa+hVMNX9vSjUIGY1d1mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=698 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270154
X-Proofpoint-GUID: GW4RuLSj__tCrnGYWc-O1nilKMxLFj1k
X-Proofpoint-ORIG-GUID: GW4RuLSj__tCrnGYWc-O1nilKMxLFj1k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Schnelle <svens@linux.ibm.com> [230427 02:53]:
> "Liam R. Howlett" <Liam.Howlett@oracle.com> writes:
> 
> > set_mempolicy_home_node() iterates over a list of VMAs and calls
> > mbind_range() on each VMA, which also iterates over the singular list of
> > the VMA passed in and potentially splits the VMA.  Since the VMA
> > iterator is not passed through, set_mempolicy_home_node() may now point
> > to a stale node in the VMA tree.  This can result in a UAF as reported
> > by syzbot.
> >
> > Avoid the stale maple tree node by passing the VMA iterator through to
> > the underlying call to split_vma().
> >
> > mbind_range() is also overly complicated, since there are two calling
> > functions and one already handles iterating over the VMAs.  Simplify
> > mbind_range() to only handle merging and splitting of the VMAs.
> >
> > Align the new loop in do_mbind() and existing loop in
> > set_mempolicy_home_node() to use the reduced mbind_range() function.
> > This allows for a single location of the range calculation and avoids
> > constantly looking up the previous VMA (since this is a loop over the
> > VMAs).
> >
> > Link: https://lore.kernel.org/linux-mm/000000000000c93feb05f87e24ad@google.com/
> > Reported-and-tested-by: syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com
> > Fixes: 66850be55e8e ("mm/mempolicy: use vma iterator & maple state instead of vma linked list")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> 
> This breaks the vma02 testcase from ltp on s390:
> 
>  ~ # ./vma02
> vma02       0  TINFO  :  pid = 617 addr = 0x3ff8f673000
> vma02       0  TINFO  :  start = 0x3ff8f673000, end = 0x3ff8f674000
> vma02       0  TINFO  :  start = 0x3ff8f674000, end = 0x3ff8f675000
> vma02       0  TINFO  :  start = 0x3ff8f675000, end = 0x3ff8f676000
> vma02       1  TFAIL  :  vma02.c:144: >1 unmerged VMAs.
> 
> When this happens the following VM_WARN_ON() is triggered:
> 
> [   25.628747] ------------[ cut here ]------------
> [   25.628821] WARNING: CPU: 0 PID: 617 at mm/mmap.c:922 vma_merge+0x7ca/0x970
> [   25.628834] Modules linked in:
> [   25.628841] CPU: 0 PID: 617 Comm: vma02 Not tainted 6.3.0-09574-g285e1dccc348 #108
> [   25.628846] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> [   25.628850] Krnl PSW : 0704e00180000000 00000000004317b6 (vma_merge+0x7ce/0x970)
> [   25.628859]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> [   25.628866] Krnl GPRS: 000003ff8f62d000 000003ff8f674000 000000008e7cb908 000000000131f0f4
> [   25.628871]            0000000000000001 0000038000bdba1c 000003ff8f675000 000000008e7cb908
> [   25.628876]            000000008e7cb908 000003ff8f674000 000003ff8f675000 000000008e7ca308
> [   25.628881]            0000000000000001 000000003ff8f674 0000000000431048 0000038000bdbb08
> [   25.628891] Krnl Code: 00000000004317aa: a7f4fcea            brc     15,000000000043117e
> [   25.628891]            00000000004317ae: b9040087            lgr     %r8,%r7
> [   25.628891]           #00000000004317b2: af000000            mc      0,0
> [   25.628891]           >00000000004317b6: a7f4fc5f            brc     15,0000000000431074
> [   25.628891]            00000000004317ba: ec38fd30007c        cgij    %r3,0,8,000000000043121a
> [   25.628891]            00000000004317c0: e31031d80004        lg      %r1,472(%r3)
> [   25.628891]            00000000004317c6: e310f0f80024        stg     %r1,248(%r15)
> [   25.628891]            00000000004317cc: a7f4fd27            brc     15,000000000043121a
> [   25.628970] Call Trace:
> [   25.628974]  [<00000000004317b6>] vma_merge+0x7ce/0x970
> [   25.628979] ([<0000000000431048>] vma_merge+0x60/0x970)
> [   25.628985]  [<0000000000482e5a>] mbind_range+0x13a/0x1c8
> [   25.628990]  [<0000000000483448>] do_mbind+0x2c8/0x448
> [   25.629013]  [<0000000000483662>] kernel_mbind+0x9a/0xb8
> [   25.629018]  [<0000000000483724>] __s390x_sys_mbind+0x4c/0x58
> [   25.629023]  [<0000000000f38c3a>] __do_syscall+0x1da/0x208
> [   25.629030]  [<0000000000f4ed40>] system_call+0x70/0x98
> [   25.629037] 1 lock held by vma02/617:
> [   25.629042]  #0: 000000008c570ca8 (&mm->mmap_lock){++++}-{3:3}, at: do_mbind+0x102/0x448
> [   25.629055] Last Breaking-Event-Address:
> [   25.629058]  [<0000000000431070>] vma_merge+0x88/0x970
> [   25.629066] irq event stamp: 12559
> [   25.629070] hardirqs last  enabled at (12567): [<00000000001fcc6c>] __up_console_sem+0x8c/0xc0
> [   25.629080] hardirqs last disabled at (12574): [<00000000001fcc4e>] __up_console_sem+0x6e/0xc0
> [   25.629086] softirqs last  enabled at (10076): [<0000000000f516e2>] __do_softirq+0x512/0x618
> [   25.629123] softirqs last disabled at (10053): [<0000000000162bbe>] __irq_exit_rcu+0x13e/0x170
> [   25.629132] ---[ end trace 0000000000000000 ]---
> 
> which is:
> 
>        /* verify some invariant that must be enforced by the caller */
>        VM_WARN_ON(prev && addr <= prev->vm_start);
> -->    VM_WARN_ON(mid && end > mid->vm_end);
>        VM_WARN_ON(addr >= end);
> 
> Any thoughts?

No thoughts that I should share.

I will have to boot my s390 (vm) and have a look.

Thanks for letting me know.

Regards,
Liam
