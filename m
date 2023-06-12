Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE3472D312
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjFLVQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbjFLVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:14:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA6D35A2;
        Mon, 12 Jun 2023 14:08:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNtsi031449;
        Mon, 12 Jun 2023 21:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=bIW0yu58Z5ZXhTnCLH0tFN1HT5VoBr0mDtLIn1ZAbCU=;
 b=DPumACs0CacMiHyyNdZbWaNsXzCDQhjiN/OrDecc2K0xPaD9EhYfaFYHO8Na5+mzVaXj
 b7Tjn6j+ASK27zvSPq3cPsEVG71qJ6iA9LECC6pgV1yqVnaNBFMb0y0B4B7VYqhv3jx6
 DhcJmktoWlknJgrx0ZHg097NGKpgisStuieLQtoj0/dCXzjf+oAqY1T7nVfUBm4aI0Xq
 pT/3ki6VtHK4OWWsSUwcq6Kle5PDAfzigZsofh845LV5Oqyi+Y48YFQtmW401qH2l4k9
 J6bsancZIRw4/4o+lGSg1tzvB7FLPqZSc1MwAJTl/ZUPVuz3GC7TLjzH3QtniaLHo9jy 3A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gstuufk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKWd0E016285;
        Mon, 12 Jun 2023 21:07:48 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3a6wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9Lrz3Pz2NiuZFzNHrMTRqNjX834U6voKBGkktDKEREYZmiig12IY8yv2N91MStAcel9EZMYzGl6KdTiFB8MZ0ZVFe/OCizsvZwtECBU0HDKXi1p2F0PMweyUkVxiSMZh6VqsnWYJzLidBmVzhReE8EwMq2xeuXCWoEOLKx5QkEnXCM2D4u1bdQH2xeUejnaKAZXXGmWBycBGbz9Z5VRn5noNOVvFm5XKj6f9ybxTVpP9f+hj18i9d1LgYYGH27p+oiNtu/22q7MrHWAeC4NQ+C8FWqVbhiULFYu3eyU4aF5bMLCbdWBsIXj1LvqvdNgTtpgj51J++A5TAkL9dozhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIW0yu58Z5ZXhTnCLH0tFN1HT5VoBr0mDtLIn1ZAbCU=;
 b=YiwjNwEB7Z7vp4Z2gt3i+XCvMVcegvTKQbCO9iJPs6WfzNa8Ux9ubcpeYPYZNSydqKCeYgfmeQb1iqnF4NJkQ1uVnqwDJ4qI49r9jTlSJt+d1llrQp0YniuCy8b9myy4X71FZyN0mg3u40Pcu5ctb8dKZF3o4ToPIRBn3oPmyYe0X1Uva2RQld1o0xcXCreCawVWJoWZwk+cCnRtX0AH+XNNNWb5SY+KHSZ1KZoJ36mgJ+1gwg3Zyz6b/TPiiJWdBVpzRN9CYqr6RJ99qOqEqJc4MC451WsfYo34DA2W9bhvIWKHv4+pa2VPnDPtCA5g3CZakE7BPd/5S2HhM3CzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIW0yu58Z5ZXhTnCLH0tFN1HT5VoBr0mDtLIn1ZAbCU=;
 b=vvW2atC9ndzdpOlEJLuHf5CAXz2qZVkSJOGa72WTra0Gchtn0xfOu6Bd3tOXPeXLDlfjcNrMPGSUOEbA3Crt5z8MYk+fiZONQ/cx+iqyJaag3eoNgzlYf8xmIGRjmqXSKZowFrIeNiq6syLLNzI4pB3xu2MvlMnhRSbOaW9gQ0g=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH8PR10MB6410.namprd10.prod.outlook.com (2603:10b6:510:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Mon, 12 Jun
 2023 21:07:45 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:07:45 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v23 5/8] x86/crash: add x86 crash hotplug support
Date:   Mon, 12 Jun 2023 17:07:09 -0400
Message-Id: <20230612210712.683175-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612210712.683175-1-eric.devolder@oracle.com>
References: <20230612210712.683175-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:5:60::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH8PR10MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 73717630-a06c-479d-c0f6-08db6b891174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gjl/z1rWc3LKKQ7N+U0pDoYCn1MnPCRMFuWsCIsi7SmIadg2lzQYm1mhNHhsnPr7mpKDbFT6JqkefUPvyF57MBxHabE6iBV4p60sN7HEM+Nd9uIC0UsFrF2r61KS7Dyh/PTfqzeykDq1MchqTUoDBKNT1SJ3FGkQTOHOdy+48qcuHfKIAxVoP7bXy3Zi8tqjzYnpGS8TybIUQP7tTdRneyZ1w7BCSD0E90HbjTxxaYViepCkjybyI/I7uTml1BcVKz4srDyjDFB1/d1aasgP33a5CSrZbACg2Wf9A92daTy0gCYFrUirP+BYEpscvckCEojW0RGCaUpIBeouZ77/7XsBLFH31GMINUqQWxjHkmmHbCDnpRQKP0oXJNJ0vjuSMjI+xZeHjQV/Sec5yEVLoPcbWDC9k5Vt0j2MM866E8IvdcCEkKK6Ot7eUq1O/tgfLh1EVsni3e6D5X39QXfR7KMpEvn6POzcR68k1EqmAFPaSKviVsTib0QfTWCGm1TDOa2aaOmzpDzbvcXB2XJUK4KTHYQeWf/+taikX121SC1ypMox9kNv0b+FnXoypJPp36WmkFAtsniuNExglIZIITKW2QWhvAz4q5VBumh7514=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(66556008)(66946007)(8936002)(36756003)(5660300002)(8676002)(4326008)(6666004)(66476007)(478600001)(6486002)(41300700001)(316002)(38100700002)(921005)(107886003)(7416002)(6512007)(186003)(26005)(1076003)(7406005)(2616005)(6506007)(83380400001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tYVaLUFYWrBx/TgoHsv5KvzkTcSCptaXYpqRxdYfPfNE1S+e+Al2xNo5OLYX?=
 =?us-ascii?Q?bGB/t6VNCRPqnA3e/Qtx6uN8BSZEEsPoFAuKOP/ScdCGmN2I7pDFtSKik665?=
 =?us-ascii?Q?tfNpdpRQNTtLK5xCJ23wkJgr4z8ucgaaHhZPhNOIxKDnUD0qJzFSF6uRK3vk?=
 =?us-ascii?Q?xrPBA/HGrqGmIDiM9QM2SxcP5o96YjrkVNfXJ1v1PpYp1a1sAuq0v9NiOAu0?=
 =?us-ascii?Q?LcpaW8BcfszCrO3AIhElD8wjpdLtHohy9dOO3q1M9k4TyDggyyv2nTzbkg73?=
 =?us-ascii?Q?8UqUDE7QcaWx3sxkF1TGVBF6/EthvGHrVKxPA1duoYzfKrBpuNnJ5cLKQIRQ?=
 =?us-ascii?Q?f1resiWB5WBGptqaR6gaqc3qjJFntr9950T7y9SEUI4QfeySM4xYZsTkS3P0?=
 =?us-ascii?Q?uPXF7TQBFyd/WUEQrUvg1qUPBIP+hRxztbWB0CMJcs+GYCb1mUWRAPOdOpef?=
 =?us-ascii?Q?EfGlO1fxt3fEHtpSXr6WFN8H7nNIIW8ZQod0PLKLT0SNP0pezzpgP7Z08DMT?=
 =?us-ascii?Q?0XW6hLWP3B7erRifB0yCGA+ZUo+sUceInn+LRyIQPMx6nYgpW/xoih1wg0zb?=
 =?us-ascii?Q?EdLzSbFN3hqvSWt0hqAF/4vN3wCUKPy8aGmJrn+aTOfy481yXVw42tIN2aLQ?=
 =?us-ascii?Q?pFjBN07OsWE4dDyQ5/H4oRK2SRNI3EFsuZc5j9+Ee9HbcNhMn2u7bfO1zqUo?=
 =?us-ascii?Q?f953eVLmQpgAFGFGRzIk2I2bQY8nzsOSJsXSXei4/nmbeUTOSTPStcT+4nr0?=
 =?us-ascii?Q?pyZNgwLSx1BPv8hUYCkojY+5sQ2x8G6uMO7p7ZLiS26/D2exLiDTXVARykS8?=
 =?us-ascii?Q?1viC1u3ca6ZMFRdSHxL4Bis31TCxfooLUNsB58paT5uUCbVv7CmuOACZvhZ0?=
 =?us-ascii?Q?XCTysYKHzjjvbaGSEKPtLNjYgPkFoNf/HicXtdxn7psxMiYZ6L3JJLsTy05O?=
 =?us-ascii?Q?Tlwg7j7wuR8z3kcnInpoPvEwY9ILbm3fOLU+5L4fel6F4dl8Uu0unWvwF+5n?=
 =?us-ascii?Q?EoX0GdC0n1y7zyZzqh6kWvE2teVFJ5nvEFbUY7j7VudfKHLr/hS8rxha71Mb?=
 =?us-ascii?Q?5I8OlsjXIfp28ZTXXumyit4CnD8hAAxaI39KhuvY2sX7AOB+XKx6psV5PA0F?=
 =?us-ascii?Q?YLPzeiHZhedNly3aUaKxPHr1uTeJx/DEaDjm1+OUaU8zxw9zcKs2G8EQgDE+?=
 =?us-ascii?Q?YopA3oWwruMmO6tDQUHG4wy0Ax5abx4vqhk6Hq7F/iFqvLYV3ZExdw1Uuh5n?=
 =?us-ascii?Q?6l6IJ0V+tA4rfsCnunYM6pOo88bAiPE+5zI75cOlutxx4IQTIIUiy5nSprle?=
 =?us-ascii?Q?Q0zgTX9RnBUBPBuiZDji1jmvaG4DpqKw93jfq8GHZHtgosr5N4Ja+L1pTGxa?=
 =?us-ascii?Q?myFzJ5VCG2y5AM54sKNgAlsT6M+sn+zAkkQh29NZQUF1stalPSMf4oFHAEwC?=
 =?us-ascii?Q?Kjm4+4zUE8G2FkVSjulpwK+vzgXd9FVQDqCHBP6jeNWtT/fAl7DVQEcWgGBB?=
 =?us-ascii?Q?Zn2jHdwkVNN+nPjIzlefk9fqMoiK0iM/T4eIRGVBSb3vSB5sFiUG6K9wDnda?=
 =?us-ascii?Q?AiM1do1YhsssLhEJNQIsJIlRJ/NidVjc5rYPrDoqE6mofdE8xOUonafFjETi?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fj+7Qd0h5PwbLI4gCrJ/vCN6NZ8/3NtxshtLK6c3APYJ9rJzZsa9sFL4mH+h?=
 =?us-ascii?Q?UMRz5n+HcvEThCX1ikcoF37ps7fsnZksU/tHJUtcwEyGiVKggczkBRumwkvM?=
 =?us-ascii?Q?AJAuT5iEiSAMyAn5kuctVIf2ogFYXrbEsLdk80ZK0PiCOXLFt5DEKEbyM27A?=
 =?us-ascii?Q?OKBp+lvQk9nNW32XcNyhQ2FY7AT8bxbcJiAUinAe3ONqH6Xih31vgh25Acf5?=
 =?us-ascii?Q?mUPztZg3RLPhmU2ATW6yrCvW/oBbrzAM8gC7pfE4weKpoRsNWJd6d1cm0qB3?=
 =?us-ascii?Q?+jxKsSE10EoKLTFJBOWhTiRPdXOkMsNFZwXJH+VV1dKjHcizYvcYLLJ7/rG+?=
 =?us-ascii?Q?pCL2TilG1DQAKI2Rgfpeke0Hz9eEEYTzDPZE5cdPFjAy0uj/hEPnmS2X2qzp?=
 =?us-ascii?Q?XrYTXSETInkczyTWElJr5vtvEPoi5asaM4Me/wkKFldOi70RqhOVPgn9p3PY?=
 =?us-ascii?Q?Vb+jzHOLNXAZSAxwaDSkqDABnjYrDbk8xEpS6+SaD5kXH+uhBGrCbc/l6TEW?=
 =?us-ascii?Q?Urs0gNv/sJ5jlJc8bLphsimYB4yL7jgyuI36B9bRLFZdjP8duTsm4hi5I0l8?=
 =?us-ascii?Q?JkDKZ/SqSqx6WAt2N+fgnpPH4QZhDNHP1keojcX+2RsWRpaTV+Zgnw7DEo4H?=
 =?us-ascii?Q?w7XSmxH7uoWasnL6/NlWbNboyFpoiDeBcdu66KZoKP6ddSl6+e/ip6F37FZy?=
 =?us-ascii?Q?M4ATP00xFnBzVk9+WsfRboPraowbmXsJD37R/S2mynYqr7lM45WvvLTDjsAQ?=
 =?us-ascii?Q?T1vIqclXwf40Le0UkcVw7/1DrI4olzuYApf93odwhWoqyxFTnn+/M8W/pLHZ?=
 =?us-ascii?Q?X9IrjkzeBG5v2JVD6JejXFk5IUSzzC+g+fRdbxhw9xY53NvdCrk+Mac6m0Cs?=
 =?us-ascii?Q?VS4y4/8JYKBd1U33oo1cxtjO/KcvNjTxAbUqlfExZ2JQxrQs/wimiqqOVGo1?=
 =?us-ascii?Q?BdPU2WzKkdhtNBTSAzpP6hmwZ+Kmy/B+rxhtQIia2zJdGj5gnFW1yIi+Jo3E?=
 =?us-ascii?Q?KeIdcaYoRydcwesS9DPufjFkDRnxGyK1p6RSz8fZv0ubr/WZADtiLq5DEPUW?=
 =?us-ascii?Q?EiJ7w2LGh/QXTR1N/UoWENHcFCDZsXBfhSwz7t+uI5Bb6QmaFCheSaXdkOmF?=
 =?us-ascii?Q?iQKUmTiTH6zajSgc6cJ6GKyLFEgztvUvhglWoCiCwHs+mLtH8pSRSYCDlyU2?=
 =?us-ascii?Q?KcYJsOL0LLS9zHAShP+INlCoqJ0d8MvbFk6wLBlQJwCvmIBW5Fs1bEOOu6F1?=
 =?us-ascii?Q?4/Od2VVEld2olAhyklcx/BojgK6MOrw+fNN1VD/MCEbcT75y2g7YNeRskCuB?=
 =?us-ascii?Q?A3LpyCJDYFWDdg3bzxXCTCi87ReqSKe7cJ2UIszGjsvjtosoSOkd6KrDzCAd?=
 =?us-ascii?Q?IhylgOI9wJDPEzKDM9aTmmPC62bhgWmNXXa6vSFnAEPYry8MKRGGjC64YdTU?=
 =?us-ascii?Q?TexONsHRkho=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73717630-a06c-479d-c0f6-08db6b891174
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:07:45.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNmBaBs7iCHBRs3zQwLu8T4vql4IBuSnGoAFTEgrol6G6ivtaIllJSnVenJEL+OFwNsKzL7/DIPhxiw8vt4VL8S9fPo7ZXf5Hm5QbPYFLsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120180
X-Proofpoint-GUID: vFkX8BPwch_p8PQccIWrm9ogCHa6ycPO
X-Proofpoint-ORIG-GUID: vFkX8BPwch_p8PQccIWrm9ogCHa6ycPO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, or off/onlined, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

A new elfcorehdr is generated from the available CPUs and memory
and replaces the existing elfcorehdr. The segment containing the
elfcorehdr is identified at run-time in
crash_core:crash_handle_hotplug_event().

No modifications to purgatory (see 'kexec: exclude elfcorehdr
from the segment digest') or boot_params (as the elfcorehdr=
capture kernel command line parameter pointer remains unchanged
and correct) are needed, just elfcorehdr.

For kexec_file_load(), the elfcorehdr segment size is based on
NR_CPUS and CRASH_MAX_MEMORY_RANGES in order to accommodate a
growing number of CPU and memory resources.

For kexec_load(), the userspace kexec utility needs to size the
elfcorehdr segment in the same/similar manner.

To accommodate kexec_load() syscall in the absence of
kexec_file_load() syscall support, prepare_elf_headers() and
dependents are moved outside of CONFIG_KEXEC_FILE.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/Kconfig             |   3 +
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 103 ++++++++++++++++++++++++++++++++---
 3 files changed, 114 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7dff2481abe0..4b39f4059876 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2063,6 +2063,9 @@ config ARCH_HAS_KEXEC_JUMP
 config ARCH_HAS_CRASH_DUMP
 	def_bool X86_64 || (X86_32 && HIGHMEM)
 
+config ARCH_HAS_CRASH_HOTPLUG
+	def_bool y
+
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
 	default "0x1000000"
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5b77bbc28f96..9143100ea3ea 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -209,6 +209,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cdd92ab43cda..c70a111c44fa 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -158,8 +158,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_FILE
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -231,7 +229,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 
 /* Prepare elf headers. Return addr and size */
 static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
+					unsigned long *sz, unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -249,6 +247,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
+	/* Return the computed number of memory ranges, for hotplug usage */
+	*nr_mem_ranges = cmem->nr_ranges;
+
 	/* By default prepare 64bit headers */
 	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
@@ -257,6 +258,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_FILE
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
@@ -371,18 +373,42 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
+	unsigned long pnum = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
+	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	/*
+	 * The elfcorehdr segment size accounts for VMCOREINFO, kernel_map,
+	 * maximum CPUs and maximum memory ranges.
+	 */
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
+	else
+		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
+
+	if (pnum < (unsigned long)PN_XNUM) {
+		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+		kbuf.memsz += sizeof(Elf64_Ehdr);
+
+		image->elfcorehdr_index = image->nr_segments;
+
+		/* Mark as usable to crash kernel, else crash kernel fails on boot */
+		image->elf_headers_sz = kbuf.memsz;
+	} else {
+		pr_err("number of Phdrs %lu exceeds max\n", pnum);
+	}
+#endif
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -395,3 +421,66 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: a pointer to kexec_crash_image
+ *
+ * Prepare the new elfcorehdr and replace the existing elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long nr_mem_ranges;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+		pr_err("unable to create new elfcorehdr");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (!old_elfcorehdr) {
+		pr_err("mapping elfcorehdr segment failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1

