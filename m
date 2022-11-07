Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2824D61FAA8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiKGQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiKGQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:56:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDD421E3C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:56:04 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GT2bW007234;
        Mon, 7 Nov 2022 16:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=rroH3Jpz/NKKggGH5pGmOcVcKuTplS+ZkEPY4MA0rpw=;
 b=NBQuhzbyQ5EssIAWQd1NKqHH2s2vieyK66sX+Lg6JAZKlHSWxESOxlcDAYI1YoiriplQ
 r/asa+PCfrcWOSaHMqqxCXwypcR3stqcClY9LfvU9GJBr74Mcjm7opSggB+hw7KzpP5B
 /aJdTpMrqP5MraDZeXh4uqoWyMAri6to5qbfeaxdwmU7gumksgwFSTlmnoIAkfS5Tn3v
 3s0HKnMKHOUJdse7Rk/8H2ntFo+gBDwxFacaEw+ks/OYB0oo/EoGtguZtGrMRi2D35XK
 dGJlNkNH4H0/Q4sxIJ9lR6pcNiQkr2VCP1n1NIcTZQ1HzvgF8UJ0xWA2OlJeRDxufeu6 Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngmj49cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 16:55:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GQwxj030127;
        Mon, 7 Nov 2022 16:55:48 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctjfr69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 16:55:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bebvKV2mb7WXIzOwEqmCa/+EnWq9SWtH08F+B5OtYFS+4l4fMh4CNDP3TOBf2y6CHi+kHkC0tB4GQnBZM3E97LK5gMM0X51OvAw+2WHgOqPXy750xZ4C30lo0nJdxCOQteqVG3Y3x6KiTWCxYUGGr/kcXwAoRgAmxuNXTmUcSyY/JorVwAF27vdKAJbnVTtXasUSwOIwTltDrx3XnHeu3BfOOolmUmS7fvhWI8tnRHlY9+HH5tysWEHIBfPgfqtu62/9YowRlZZjtIkp94Lf6VFGL+QvAcC3skwMS/CeFZhyKvbx3V/ju2gZYFJd07RCsGGnc9APRDtr8isQw0L0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rroH3Jpz/NKKggGH5pGmOcVcKuTplS+ZkEPY4MA0rpw=;
 b=Y2c//f7HW+u1C93bCTsvtOYb7S0e40t9SiN9qEngnhi5SFT9HNOkkQXxe5n97kknARFQ4Cb9M7lBNYbfrusWtSlja8/MXFngfaFty7P8q+2CniCJO2f5ZyanI/4/tGIXgXI0DEZmXUhgsLJPivbBpx7Qn8zBJtMhicYTs289NchuVk5MTWIhIyaWwW6taNaQA7UwcT1ryn5/8UneFPTtDJ3DU5MvQemosJ3UOzdrwN9LwSefvwpYDSBHA2AE/3NgrfVVtZB5AaLBIUrJP2uixx7RCJbWgmMUkc/rQulgoOheSAe9rLO0fcw4JwiuRaziV0rTfdI8F9ukRnqSGAvBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rroH3Jpz/NKKggGH5pGmOcVcKuTplS+ZkEPY4MA0rpw=;
 b=up2//v7v4849Pa5OJd4yAGCQu16JR2kindSWopiB8KgsKusWYweQsX9A6HQDboK6riF6YipPCUNTXXZrmCa7Yiw7JlJR7o2qRcob4RJtEEhkodWBB/1vRNpT7B6FoOAEOOt4OgDq4TysylArV9yLs8DXLamsU+YaovjoOpsRymM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 16:55:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 16:55:46 +0000
Date:   Mon, 7 Nov 2022 08:55:43 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hugetlbfs: don't delete error page from pagecache
Message-ID: <Y2k4j2fzQYrW/ptz@monkey>
References: <20221018200125.848471-1-jthoughton@google.com>
 <20221104021035.GA297167@hori.linux.bs1.fc.nec.co.jp>
 <Y2UTUNBHVY5U9si2@monkey>
 <20221107042544.GA436198@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107042544.GA436198@hori.linux.bs1.fc.nec.co.jp>
X-ClientProxiedBy: MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM6PR10MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: fa758da6-a7d7-49a5-a79b-08dac0e0ea43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYZGJFl/SxsrttiNilgb1GwFKnPdOfdqlIih6QVspP7yJVyK0jcAKabRHIRYhbxyd7MGUv9bgT6kd+XZvKMMLdAQLI2DLyLW9q8ewG+kUBGvKZYt2XpY26c47xfw8CdTt1K0eKMyoTnpRPW26geMGNKfsZqKAuRLYJpA31w6yfj1+cYjfZxjtstLJkREzDrv7RJJZ61YPpO57M1i61Xm/i86HEvrF5PvasKXN6PdtnRy+yPdIRFjAfXiIaGdyjUlRhHqzaKrXJtm/1tzqZcAjcPOWy+60WbmHgKHNdBiB1Y/fhKKJi7IsbUlAy9Ej3B16bHXoOvLLQB1eaSrAJTpwqs2VmjkpcVR2/ZrHj2aN6oPZMz0gfUDyDwTI5ASy55ZenTAj8VOkjtrgSXhuGz0fE1iBTTMkv1jvRqdN7DTitvsxWETomAIrO7oeGhPJiQF/8rJPqYb+xZk0u2Za9KbNQXT1dSZ4QZQR1Xcu3OFwQ6fSuz+mbCxCUqfpJdzPzD6iy1ewgu4YbPgQ45Kwn87NzqEUcpzSxff0NceL73zlk1JIQn52h2FuWPCux3uOeFc9+6U7c8MDUuJFbVp3wM4GwgF4fuIadkIka7QWWaC3TfodyP7IEO7BjNsHqO7FAcJf7Uyqy4B2SEv8XjUUNOzmwC8VHWkoe6D1TJ8s+8cDxD9fbz4JdsODyb3XHJsDkME
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(6486002)(2906002)(6512007)(9686003)(26005)(478600001)(53546011)(6506007)(41300700001)(8936002)(6666004)(38100700002)(316002)(6916009)(66476007)(66946007)(66556008)(4326008)(8676002)(86362001)(33716001)(54906003)(5660300002)(44832011)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG44Z0N3Rjc1OVRGS1c1cCtaVlhXTW5UWGVOc01VVTZOWG5sWU5BTHc2djlH?=
 =?utf-8?B?ZlM3NW1uTEhUbnlCdUlRbTNBbFo4VGxJRWxFOTd4c2N1WVh5YkpOYlAyN3BT?=
 =?utf-8?B?N0JsSW9JMnpFaUlNaG9SVkxPemhqVCtRenVoTFFHOHoxcHQvSFZXSjBvcnRJ?=
 =?utf-8?B?MDNta0VwNkx3dHY5R3BVdWpJT0ViOU1sd3EySURTS1hGUStSWWNpR0Z4dU0y?=
 =?utf-8?B?TGRORmcra0orNVZkU1ZEYjRCei9HZGZTM2dITGk1TVFUbEM0dlZMZXJvMkRn?=
 =?utf-8?B?TTJQMjNXOGlCMGxPQ1R0UmlBTjVsSTlVMEFXRjlvdHlYM0FTWUljU1dXenUw?=
 =?utf-8?B?U3l1QmlhbXFnL1pEd0xaOGhpL1BjbUo0RHdiOUtaVzY5OFAyeklJVXVoTkRV?=
 =?utf-8?B?YUVHenBGcmJHbHhPcXRWNWFnM0FpS2dHWlRpMEdlVDRhSWZFVDM1S3g4eXZD?=
 =?utf-8?B?ZGFsQ2pualo0aURxQWlRc2NMT2EzakFzWWdkWkxsSlh1aks5dkF2ckJTU0lY?=
 =?utf-8?B?dUdDbnFXQzFHTHFWZm9INW14MFRHWEhtRkdGLzh0Ni9pc1BmMnFvTEFDQTBy?=
 =?utf-8?B?blNKdzNwem1PZ1EyVnNQczQ5cml6Sjk5QXc2dlJqNEpmd0FKT2ZpS2Y4VnBO?=
 =?utf-8?B?L0JwVmxyWHJ1QmkyYWxNT3cyVzc4WXhsa1RTdjNwYlo1K2hSQ2d3eTM0WjFX?=
 =?utf-8?B?NHZwSmR1MXhPNHEzTkxoci9SWjZURTJScG9CeEJrN0h4K1R4b3lJb01ITkZK?=
 =?utf-8?B?NUUzYkZEd2ZzWXN1a09KYXNINzRoWXhERHFKd2NBSlZPU1hkcW5VdXFDcGY0?=
 =?utf-8?B?Mnd6MVQrTnVaTUJyN1pjWmQyWG5aV29GVUxNay90U2pVdGFhOStXMUhzS1hz?=
 =?utf-8?B?YzdWTWpDTCswcVhjWFVWUWlTV2E2cDQvY081NG1LVktxVGZUd1BPYjhEN3pn?=
 =?utf-8?B?ZERYcWs1bmRSQnNsYnRoR0lyNk43OUhzMjRLdkRiNDJRWUxFZEZBSU5Vd2RW?=
 =?utf-8?B?TUVidzU0YTFKVGZNQzBERVJxdmtqeFZ2NlN2UDBsRlI3NWh0WDdybEx2SEMx?=
 =?utf-8?B?bzdjY2FHQmoxSmIzc2dDcG9uaWdxQm9HK0hTNUNQZVQwbzhrZVJUYVN0TnFU?=
 =?utf-8?B?SnZpTHBNblhqVmhDVVAxQWx5VVRBU1hySUJ6a1BtU1pXVXp5VE0zTzI4RWps?=
 =?utf-8?B?WTJsb2xrZ3FKQ2htYzdkdFhpNms1Z0d3Lzc4S0hjbjR6SjNKeE41VHN5Z21o?=
 =?utf-8?B?ZEdmdGovSnpvdDJyR3pOQThFZXZvMmxvODNUOGo0ZHNJUkhEa3NObnVZamlx?=
 =?utf-8?B?WHQwR3RrckphWXJ4ZXhQWm9XQmpEYXFrUWZPRXgrNE9ROE80dmovdWNnSjVF?=
 =?utf-8?B?Z3FhaUY4VHk4M2dkQkZtY0cxWUUzY01nSnl0a3N2MzhwK3ExYkN4aDdhN1Nv?=
 =?utf-8?B?V1JBaXBVNkJpSU1CWXlSVE15OUdIdFZjZjgvL0N0MlY3bmNSRlB1SFFtc3FD?=
 =?utf-8?B?TzZOakp2K0MremtMM3dqSkxubis1RTVCd1FsMU14aHp3dmtZbUpETXY3SDlU?=
 =?utf-8?B?cXJlOGZJL2dMcDdINVh5MG9IaGpnenNYTzR6eEpYSEh5ZVJiR0JuQVBuN1g2?=
 =?utf-8?B?MERtWE8wMkVVcDNmN3lySU9xSFl4ZlNZRzN4OWxvbDFzQmx0QkVlbituQ3Bp?=
 =?utf-8?B?NXc0M0ZEWU9kRUcwbVBmL093d0wzUVdTcTk0aWxtdUV4amNiS2xZN0RCUVZu?=
 =?utf-8?B?MnFoVDU5WjBySnVGOFk1Tlg2ZEVSZlhnWEF1U2lURTBJVUVkZlgwcFNCQnYr?=
 =?utf-8?B?T3VoT3A4R01GdC9Ic3J6RG9NU2o3MmRxcXY2K3FORUdEckYwM2tVbVRya3F5?=
 =?utf-8?B?THFkaUgvclZlZjJiT05SYmVrdFJsSWpzZmNCeGdoT012Y2RlZFk1Q3M3QlpQ?=
 =?utf-8?B?ditkd0xHWTR1amR2WEZIQ2MzeHhDbVV1eUtIYWh4T1ZORENPQzB6Tkp2TDM3?=
 =?utf-8?B?VGxDbTJMR0NhUUlWMEd5WS9haEJPT3crbDlsaFFYSlZ0b2xBd2IvMURxZHFm?=
 =?utf-8?B?RS9vUjZVUTI3Q0xRYktUbXQ0ZTg5QktJVEZnTU14RXA1c0hyUmFnVnNBTGpK?=
 =?utf-8?B?R2ZTYjkvelNEeGZHSENpNHR5NHlLcjlUNElhdHV2RXY3MjFoa0hyekRrSlN3?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa758da6-a7d7-49a5-a79b-08dac0e0ea43
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:55:46.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEgsEacvmwXCWoOIX2ypbDGzW701dtHfe6oiS2xkO0qGG0mTP1g3dQ+yaaIAAJB1MbhhW+UOwfh6EHzvwrBGbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070135
X-Proofpoint-GUID: CyC2FA77qvI5u93i18nvrkR8UygbUyaD
X-Proofpoint-ORIG-GUID: CyC2FA77qvI5u93i18nvrkR8UygbUyaD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/22 04:25, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Fri, Nov 04, 2022 at 06:27:44AM -0700, Mike Kravetz wrote:
> > On 11/04/22 02:10, HORIGUCHI NAOYA(堀口 直也) wrote:
> > > On Tue, Oct 18, 2022 at 08:01:25PM +0000, James Houghton wrote:
> > > > This change is very similar to the change that was made for shmem [1],
> > > > and it solves the same problem but for HugeTLBFS instead.
> > > > 
> > > > Currently, when poison is found in a HugeTLB page, the page is removed
> > > > from the page cache. That means that attempting to map or read that
> > > > hugepage in the future will result in a new hugepage being allocated
> > > > instead of notifying the user that the page was poisoned. As [1] states,
> > > > this is effectively memory corruption.
> > > > 
> > > > The fix is to leave the page in the page cache. If the user attempts to
> > > > use a poisoned HugeTLB page with a syscall, the syscall will fail with
> > > > EIO, the same error code that shmem uses. For attempts to map the page,
> > > > the thread will get a BUS_MCEERR_AR SIGBUS.
> > > > 
> > > > [1]: commit a76054266661 ("mm: shmem: don't truncate page if memory failure happens")
> > > > 
> > > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > 
> > > I did some testing and found no issue. So I agree with this patch.
> > > Thank you very much.
> > > 
> > > Tested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > 
> > > As for whether to go with HGM patchset or not, I have no strong opinion.
> > > As you stated in another email this patch is correct without HGM patch,
> > > so it's OK to me to make this merged first.
> > 
> > Thanks Naoya.
> > 
> > This is a late thought, but ...
> > Should this patch and Yang Shi's shmem patch be backported to stable releases?
> > Both address potential data corruption/loss, so it certainly seems like
> > stable material.
> 
> Yes, I agree that backporting these could be helpful.
> 
> So I think that I'll try to backport commit a7605426666 and its dependencies
> to 5.15 (and older LTS if possible).  For this patch, just adding "Cc: stable"
> should be enough for now.

We have now actually seen users impacted by this issue.  I suggest
adding the following tags to this patch.

Fixes: 78bb920344b8 ("mm: hwpoison: dissolve in-use hugepage in unrecoverable memory error")
Cc: <stable@vger.kernel.org>

-- 
Mike Kravetz
