Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D446D3CD5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjDCFXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjDCFXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:23:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F335BDF3
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:23:14 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3330qGbo020222;
        Mon, 3 Apr 2023 05:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=j54SMO8aHZZZsgBi7r1t7d7dsJQz4KL14GWBankHCBc=;
 b=lppQNTdGZtE0ehbHr57NIjPQfjX3bwIRB/Y0grP86aC7vC6mTDe/8r5J/HiKIubZsiaK
 er7J1ohrWApuGNzCsHcCm+p2wIC9jAsy+Ipcih/ORquQ7dmNncTR1r9MQ0BAO6jT19Yk
 kTrPfLDvEwoiABFzDnh2ec1j8iagTtvpirk0VA8eO0+znd229SP31GlzZLGrgyiF36pA
 SME8AZFMRtq52+CgB8TYYt/VuiNJpiBtLuhAUgjj3I0r71nsO8ZKpO78InXHNBxggdmc
 mjVFWsF0U4Qlhl1FR15mUji7rWy6aJPYT59mNSqTrDKO9W/i+oHDvGlC+IeGxmXNX+mK VA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnct4sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3332NM3i028114;
        Mon, 3 Apr 2023 05:22:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt243jf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLx0Ec+40KiTSJJWUXk2QMZFsmqR1BwZ66ZexSTG1z+vBWlWGtzJ9Klhbi/mTiytvyOOvvReyiLgl9OPmsnFran9yjeTWVO2xjsQkx8x8SGFyfWCuz8Cm4DSJGx5alwRI1jOt7YjSTMInSZEKX2YluOuKGY5SA9nbjMkHEkcJtOp5BpbT6+QSkcyg1YJ6a6GS7nE07VpsJEwhYvmpWBzOh+TEAUZNwe71W6i3MBfA9PXmpxkbmyHvcm1jwF5TUcwZZqzd+hjA8FPGS/aRhwxOkLHHissxs4x7AR12/Y3Pl51O2c9e+qoePjWJNttCsEUAXtrx9HUZ8BFZmbVwC6sDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j54SMO8aHZZZsgBi7r1t7d7dsJQz4KL14GWBankHCBc=;
 b=FbVPuUSqf8qDw6A2V1Czu3Mk993iYLy/sO2KUwpSVAEaRHq38bB03fsnQMxLO8cP8PmfbSXcUb5IedaoOwP6aCeqrIx1cwm9e3O6krjRXrpIJHRjRGNUKwR4vETIReNaZg7CMjU6OueXRfLA4wx7ssR6wijmWc3FWq57cqBghdHR3U9PuP+DpqqbiZJZnlvsRa4zCoCJc2NFDPJitoA4Nvicb93XDemsVpEWMzPGRW9gV0MgfysxhlwUfIsnu+5SVX+kdLhJEAgkCHEwmQP7S+iAWDC/SC8Kyv95QNJeOGMwHOBZ6aqtWSd7EMfOJEuBsD+ZzBL55OYfp3pRXFi05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j54SMO8aHZZZsgBi7r1t7d7dsJQz4KL14GWBankHCBc=;
 b=rsOWDWhCY3QbgShl49gkoaEKpfnDdPghQYRs6hg1QOE2tNKSKNifGD5K9mq78qxsJXh3IaGsm42DIfNA/YP3LcXqaMxl+SeFWbYBiBqojXbvpOq0bjVONt4oo2PINsxwN9MZDTPwscNunHaEcCRAttbma2evFksAWXu6hHLGp80=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 05:22:39 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 05:22:39 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH 6/9] mm/clear_huge_page: use multi-page clearing
Date:   Sun,  2 Apr 2023 22:22:30 -0700
Message-Id: <20230403052233.1880567-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:303:dd::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abb81d4-735e-4473-77db-08db3403715f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUltraz0xtWPZn3Uj5/EngPUTJ+kcPgAYtWU08DjJwocetxXw/OPferKiVhzJd8mOl9VLy1c1I55KK0+WcTM0ayPI4vMsv6IAEyq8PbSrSpzj19Xafahz0UQWziyt5l7mLeUrnjL7gGMZZkBM3bx0ZQsD3SqJcyr4aLpkV01fso/hA4RJrWPfUDhXFaCEf4tIYchu/z0Mpuv//pzhDlx4iIi+lL1jVTthamtqS+G0oLrSMKFmECuk+QfQpc7NG28fMv3sb5z4MVzmG1Gs/VVkvi5d5fuZPnBlUlyKjWod6Bp/ERAsiyYhvimBj8CvMx/dxGm0LlLu//SPn4dy9789PhYrjlA3dSFJPepQ+UvlvgSe3zL3jyvfRfwvatbiCEhjjo0xjjvRcXBQLwx4tdtpytvm6UVP7fYmSfuHwMEX4Kvt2NlSGv8+sKM+FPBdri4JwqoSrSOYWhoDPNULI5zj5ojVbTWyzvbIcxD4y5ts/Lzq5MSUC9u+lXgCDVKvOSHUEdI+z+jGOQd6YZV74YP2E0Q90CXeF11U8kwEzP2QadtryhUZhCPJkbfEGomI+f8GTansnfpMDpYjkguVVwnJ69BeFTNPAInqigCtIjRFe0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(86362001)(36756003)(103116003)(2906002)(2616005)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(107886003)(6666004)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(5660300002)(7416002)(38100700002)(316002)(478600001)(30864003)(8936002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LDwZaoxviroa5oZKWcjLk4+gKaJkaTgn1Tv7iWksudtQqRwBOXztjUo6ZBsY?=
 =?us-ascii?Q?ygygzZLMbpeW7v0BZm9oM3CjDfo2VQzMPKO2P+Oca2nF5RU7W4jrvcgLzNAn?=
 =?us-ascii?Q?rWxbvzmulCvyAJUtiNSIL3EwH8hdru03fUFxhb199R6Z5KWOrU0+BZW3XbUG?=
 =?us-ascii?Q?isZvYsBd4waNZcrzKNq6SGaTLaKYjWFB2YTOVzQxHcgvUf4QLAjkYKWLu2Ke?=
 =?us-ascii?Q?2KE2219HPA1YxGgswDUHVPL+iqNpH5HPLkUfzGUUEPKgyl2b1k/9EppRYA9K?=
 =?us-ascii?Q?eOfb1UfnAp77+dl4ZrZ3+m5KNpqGz8TTl3BbUWvAxZHOMHuhdPtI9+cx+ruL?=
 =?us-ascii?Q?YcKewx7zb71lq7Mu7FN4JCfjomZIG1xuFEyk/938QyVCnOJAQYLr+dU+d/sO?=
 =?us-ascii?Q?qWcmX+ACIXgQDBCSvv5icmXODcTH+3GlMHjA2DqgLNG/C7VQ2HV6fmEmR45G?=
 =?us-ascii?Q?ljiKGctMAxW8G+C6WhEBWneoWcZfLp/lceRDNTilqpgfJ8lP1pXPFOskFsJE?=
 =?us-ascii?Q?3H5vQFv4mqpn43kQXNyBRRUbXkA/HNxF5m3DtRhuXqU4sFeWUH1zlz8RB4Ci?=
 =?us-ascii?Q?WvE1N3q6ZLfbB92N4CLw1k5AWZLZekidy73cHsNjySTyn57PCbEnR9sAJLNn?=
 =?us-ascii?Q?OSV0TwEYShihHJP255vNTPO+pO65Y5es5kjwMtVOaZi9mAUDF/Tuu5+w9At5?=
 =?us-ascii?Q?EQu846YDeKlBj6QxZmkezFr/SC3dKlp+81ovQA0z8+yyV/zj7lWwcZ9Qvutc?=
 =?us-ascii?Q?c/CkQOPPS5e3IwBnzWT/ehgCf5HWFgj1eIqTkvDzZHa2tX3yTaNTJ2H3CJy7?=
 =?us-ascii?Q?zms+YShFDm4i1NgWmfZty98kWs8kdbOvCpaivhSMgepE3mZAP1CiGF64rBWR?=
 =?us-ascii?Q?ZeUwZHYWD+GWXTsYXLv1RvXDJgATqEOfdcH2KKEh0EBpfaGdzLodNdiHvTUl?=
 =?us-ascii?Q?9iMItgj2ayB6QwFRNAF2Os9AjRbbJY3D8tZzVQeT7FBcWetQRz8MNtmEyiQP?=
 =?us-ascii?Q?ZbWm7n5NvVk4htMRSlZAT8GlQw9iEsEqp3Egg3Ce8Bg0HOT6wx2suTrOB/ZX?=
 =?us-ascii?Q?l4lOhN4DSOikKu012PW1i42wsNa3Gxr7U9aCDQXp6o6cFlN1UaTJ6XaEKJ0M?=
 =?us-ascii?Q?HrwWF9dj7NTVVGNbO8QktpIXMJYi6WryCOMOHydJhJBW+o4klpAyylVicmUA?=
 =?us-ascii?Q?v1usOu4dTOpS3W5A4dBaDSpingMzIZRsBYrFhR2VjtNBgg4OY83BzuqCWA8s?=
 =?us-ascii?Q?/FDwgL9qWZarYHFBtWJyGNKTq9b1cDjzaguKfkxOIp7PS6GHqDvOHQGGgyNe?=
 =?us-ascii?Q?C+SB5gHyKCMMFCSLKO1/l2NTtxYIbSpj/sQ6WOyhFpsTOWTgikcuAYXEMl3J?=
 =?us-ascii?Q?rdACXzE9KaEQ1w87IzA2wXb+3vvljBpBdSsZAqhjmUKWrwJ7HJKLixyLdhH8?=
 =?us-ascii?Q?UcnvyL/Q0q6MHtP5tBhpqSlrBjEiQHUFA2cxirpbGHcqtI0wYIuoJVmhszh9?=
 =?us-ascii?Q?COk+O9DdZ2iWlvYvKj9+bCWty6+7fihtqDo8pg6IEO9V0QRpLayLgrdM80j1?=
 =?us-ascii?Q?1ai7ArMrw2ld82qrvIY4PEomVxvUeMTa1U/ypICh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jC5u5HHWWcM+U3N7pE9x+2Vpo1XxWleztbM+IsfBIR/ncJHRueiqIggpefAN?=
 =?us-ascii?Q?nBAaM+E0I0ExyL2fcXtb7pVfDjwvX8r6MzYI09oCbCoeg/zDheswn5f1dHRM?=
 =?us-ascii?Q?0LNaxUoiMgtvQvMVnw6DF4Dt9fvATXmOq8QdBMjfVDYsrsQYl+txcqQmJCpM?=
 =?us-ascii?Q?TwxYT0+ZaD6P3iCSyA7vKKllzgumCTQKqAGn+dXDXUgaWn2zFN+L7FYUfke6?=
 =?us-ascii?Q?/NhVxH+pkpXsYToQbED9RB9j49Rz1gORr25/5ec9u2iLhTCjyvmWqay6DuNR?=
 =?us-ascii?Q?T15NhwOJaOltskdE4Sptn+BIfONNqQ53sNsd1smJ0jhxl8+DAgFtIg4IkE2l?=
 =?us-ascii?Q?8ROgznedsbqtZSWsqNGZ3gFvYLg9TaPhXJLSpxOqREkLP5exKWm3888r0qD0?=
 =?us-ascii?Q?Vu3lbKzF5REQKnNvAm7T/oEfwuObt/ltZLheiui6HT10q8SoHgc+5XzEi5r7?=
 =?us-ascii?Q?iZE6EZqFKd6zNpXHjSILMwSnFkyxjAQEwZ2UFvZWDlA9zCSK5+pRaQX36Bpl?=
 =?us-ascii?Q?OQLqIQzQJCA2+UA+01bCiTV7e3Afsdu0OyuGAKsGrgTXjjfhmWZZ1WTd8As1?=
 =?us-ascii?Q?86F9ar5yZ4f8RqDE5quMhuw7fuOhVBc8N0Za8Yi19PNdzsOiXVAqQ5OHF/qp?=
 =?us-ascii?Q?JnprzKbYzK1VdCgh5dxujI+0n9TeOYpZaoIGwvh4Gq7M8QWXJeXBd+9uBfh3?=
 =?us-ascii?Q?3aHBEoNz/wksaLqfjKsDl+ZY44Dladv3P4ag7ifiCrpV7Uo4lv4EvnffyaTu?=
 =?us-ascii?Q?nT4xi8gFVsAgvB9TzXQeR/w0Ln7QD5f6vYx49GflwMumf4B8ZqYYMYex15Nj?=
 =?us-ascii?Q?rs9V1XwErxNkpeeYzEmifaywlpGu9YZaNRRy4WQP/h2DuojZIWOmrnr/NBa9?=
 =?us-ascii?Q?puV3ImDG2nVQ07kb1P7D2Be5K+ckmiZlIf3QCfpf4WcE1iqHd0MIMyJ69+n0?=
 =?us-ascii?Q?KSAQf0HKW14xrbLwidIYIq+HyUtSJlMjr+a/SwetyznwByKFmxgYcFdTi1QD?=
 =?us-ascii?Q?EsYczsOd569b3oPfjZJtmpK8fbHUt0vfSGF5IMnNnHmcOrCoLAjhNuc62++z?=
 =?us-ascii?Q?r4480ve3vzSOLtKGfU5w7RfakQv/WMiLmE0Yw6MZafPGMCsI8h/zeNBZO95r?=
 =?us-ascii?Q?pEvLjZrzYWhYtpTjfEOWeMDSGWNXukl1L2G/wvTeW85leIpkhn2A07Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abb81d4-735e-4473-77db-08db3403715f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:22:39.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MdWZq9BlrhY8Ydt9i6R0oplwyjsNqivR+6F0aE66sPzJMWuB23Eqm7AdmO16PfdzWUtDeCbR2o1BUC6B+Hr0dFbh1MJm3y04n2f/uhib4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_02,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030039
X-Proofpoint-GUID: OzYmjE-GglT-w3DRsHWC62p0xNTxrbmF
X-Proofpoint-ORIG-GUID: OzYmjE-GglT-w3DRsHWC62p0xNTxrbmF
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_pages_rep(), clear_pages_erms() use string instructions
internally. These, unlike a MOV loop, allow us to explicitly advertise
the region-size to the processor. Thus, clearing in multi-page chunks
means we can specify the real region sizes (or close to it) which is
good for two reasons:

 - region-size can serve as a hint to current (some AMD Zen models) and
   possibly future uarchs which can use this hint to avoid polluting one
   or more levels of the dcache.

 - string instructions are typically microcoded, and would be cheaper
   if amortized across larger regions. We also execute fewer loop
   iterations (ex. a cond_resched() check for each page but those
   instructions are likely free.)

clear_huge_page() now clears in three sections: the local neighbourhood
of the faulting address (faulting page, and four surrounding pages),
and its left and right regions.

The local neighbourhood is cleared last to keep its cachelines hot.

Performance
==

Use mmap(MAP_HUGETLB) to demand fault a 64GB region (on the local
NUMA node):

Icelakex (Platinum 8358, ucode=0xd0002c1, no_turbo=1):

              mm/clear_huge_page   x86/clear_huge_page   change   
                          (GB/s)                (GB/s)            
                                                                  
  pg-sz=2MB                 8.76                 11.82   +34.93%  
  pg-sz=1GB                 8.99                 12.18   +35.48%  

On Icelakex we continue to allocate cachelines:

pg-sz=2MB:
    -   701,951,397      L1-dcache-loads           #   47.985 M/sec                       ( +- 19.22% )  (69.23%)
    - 3,239,403,770      L1-dcache-load-misses     #  691.17% of all L1-dcache accesses   ( +- 19.25% )  (69.24%)
    +   194,318,641      L1-dcache-loads           #   17.905 M/sec                       ( +- 19.07% )  (69.25%)
    + 3,238,878,229      L1-dcache-load-misses     # 2480.93% of all L1-dcache accesses   ( +- 19.25% )  (69.26%)

pg-sz=1GB:
    -   532,232,051      L1-dcache-loads           #   37.378 M/sec                       ( +- 19.25% )  (69.23%)
    - 3,224,574,249      L1-dcache-load-misses     #  909.02% of all L1-dcache accesses   ( +- 19.25% )  (69.24%)
    +    22,587,703      L1-dcache-loads           #    2.150 M/sec                       ( +- 19.38% )  (69.25%)
    + 3,223,143,697      L1-dcache-load-misses     # 21478.37% of all L1-dcache accesses  ( +- 19.25% )  (69.25%)


Milan (EPYC 7J13, ucode=0xa0011a9, boost=0):

              mm/clear_huge_page   x86/clear_huge_page   change    
                          (GB/s)                (GB/s)             
                                                                   
  pg-sz=2MB                12.24                 17.54    +43.30%  
  pg-sz=1GB                17.98                 37.24   +107.11%  

Milan uses a threshold ~32MB for eliding cacheline allocation, so we
see a dropoff in cacheline-allocations for pg-sz=1GB:

pg-sz=2MB:
    - 2,495,566,569      L1-dcache-loads           #  476.417 M/sec                      ( +-  0.04% )  (33.38%)
    - 1,079,711,798      L1-dcache-load-misses     #   43.28% of all L1-dcache accesses  ( +-  0.01% )  (33.37%)
    + 2,235,310,058      L1-dcache-loads           #  610.770 M/sec                      ( +-  0.02% )  (33.37%)
    + 1,089,602,355      L1-dcache-load-misses     #   48.73% of all L1-dcache accesses  ( +-  0.01% )  (33.37%)

pg-sz=1GB:
    - 2,417,846,489      L1-dcache-loads           #  679.753 M/sec                      ( +-  0.01% )  (33.38%)
    - 1,075,531,869      L1-dcache-load-misses     #   44.49% of all L1-dcache accesses  ( +-  0.01% )  (33.35%)
    +    31,159,378      L1-dcache-loads           #   18.119 M/sec                      ( +-  3.27% )  (33.46%)
    +    14,692,358      L1-dcache-load-misses     #   48.21% of all L1-dcache accesses  ( +-  3.12% )  (33.46%)

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Fuller perf stats for context:

# Icelakex, baseline (mm/clear_huge_page), region-sz=64g, pg-sz=2mb

 Performance counter stats for 'taskset -c 15 bench/pf-test --sz 64g --huge 1' (3 runs):

         21,945.59 msec task-clock                       #    2.999 CPUs utilized               ( +- 19.25% )
                34      context-switches                 #    2.324 /sec                        ( +- 20.38% )
                 3      cpu-migrations                   #    0.205 /sec                        ( +- 19.25% )
           198,152      page-faults                      #   13.546 K/sec                       ( +- 19.29% )
    56,513,364,885      cycles                           #    3.863 GHz                         ( +- 19.25% )  (38.44%)
     2,583,719,806      instructions                     #    0.07  insn per cycle              ( +- 19.24% )  (46.14%)
       585,212,952      branches                         #   40.005 M/sec                       ( +- 19.23% )  (53.83%)
           562,164      branch-misses                    #    0.14% of all branches             ( +- 19.23% )  (61.53%)
   282,621,312,162      slots                            #   19.320 G/sec                       ( +- 19.25% )  (69.22%)
    11,048,627,225      topdown-retiring                 #      3.8% Retiring                   ( +- 19.22% )  (69.22%)
    34,358,400,894      topdown-bad-spec                 #     11.5% Bad Speculation            ( +- 19.57% )  (69.22%)
     2,231,092,499      topdown-fe-bound                 #      0.8% Frontend Bound             ( +- 19.25% )  (69.22%)
   246,679,210,776      topdown-be-bound                 #     84.0% Backend Bound              ( +- 19.21% )  (69.22%)
       701,951,397      L1-dcache-loads                  #   47.985 M/sec                       ( +- 19.22% )  (69.23%)
     3,239,403,770      L1-dcache-load-misses            #  691.17% of all L1-dcache accesses   ( +- 19.25% )  (69.24%)
        11,475,685      LLC-loads                        #  784.475 K/sec                       ( +- 19.23% )  (69.25%)
           793,272      LLC-load-misses                  #   10.36% of all LL-cache accesses    ( +- 19.23% )  (69.25%)
        17,821,045      L1-icache-load-misses            #    0.00% of all L1-icache accesses   ( +- 19.51% )  (30.77%)
       693,339,354      dTLB-loads                       #   47.397 M/sec                       ( +- 19.33% )  (30.76%)
           637,811      dTLB-load-misses                 #    0.14% of all dTLB cache accesses  ( +- 19.09% )  (30.75%)
           131,922      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  ( +- 19.59% )  (30.75%)

           7.31681 +- 0.00177 seconds time elapsed  ( +-  0.02% )


# Icelakex, multi-page (x86/clear_huge_page), region-sz=64g, pg-sz=2mb

 Performance counter stats for 'taskset -c 15 bench/pf-test --sz 64g --huge 1' (3 runs):

         16,276.28 msec task-clock                       #    2.999 CPUs utilized               ( +- 19.24% )
                27      context-switches                 #    2.488 /sec                        ( +- 19.25% )
                 3      cpu-migrations                   #    0.276 /sec                        ( +- 19.25% )
           196,935      page-faults                      #   18.146 K/sec                       ( +- 19.25% )
    41,906,597,608      cycles                           #    3.861 GHz                         ( +- 19.24% )  (38.44%)
       729,479,932      instructions                     #    0.03  insn per cycle              ( +- 19.38% )  (46.14%)
       133,969,095      branches                         #   12.344 M/sec                       ( +- 19.35% )  (53.84%)
           412,818      branch-misses                    #    0.46% of all branches             ( +- 18.97% )  (61.54%)
   209,574,316,961      slots                            #   19.311 G/sec                       ( +- 19.24% )  (69.24%)
     4,933,512,982      topdown-retiring                 #      2.3% Retiring                   ( +- 19.24% )  (69.24%)
    20,272,641,267      topdown-bad-spec                 #      9.4% Bad Speculation            ( +- 19.51% )  (69.24%)
       837,421,487      topdown-fe-bound                 #      0.4% Frontend Bound             ( +- 19.24% )  (69.24%)
   190,089,232,476      topdown-be-bound                 #     88.0% Backend Bound              ( +- 19.19% )  (69.24%)
       194,318,641      L1-dcache-loads                  #   17.905 M/sec                       ( +- 19.07% )  (69.25%)
     3,238,878,229      L1-dcache-load-misses            # 2480.93% of all L1-dcache accesses   ( +- 19.25% )  (69.26%)
        10,560,508      LLC-loads                        #  973.081 K/sec                       ( +- 19.23% )  (69.26%)
           724,884      LLC-load-misses                  #   10.28% of all LL-cache accesses    ( +- 17.15% )  (69.26%)
        14,378,070      L1-icache-load-misses            #    0.00% of all L1-icache accesses   ( +- 19.13% )  (30.75%)
       185,562,230      dTLB-loads                       #   17.098 M/sec                       ( +- 19.74% )  (30.74%)
           617,978      dTLB-load-misses                 #    0.51% of all dTLB cache accesses  ( +- 18.72% )  (30.74%)
           112,509      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  ( +- 19.76% )  (30.74%)

           5.42697 +- 0.00152 seconds time elapsed  ( +-  0.03% )


# Icelakex, baseline (mm/clear_huge_page), region-sz=64g, pg-sz=1gb

 Performance counter stats for 'taskset -c 15 bench/pf-test --sz 64 --huge 2' (3 runs):

         21,361.22 msec task-clock                       #    2.999 CPUs utilized               ( +- 19.25% )
                23      context-switches                 #    1.615 /sec                        ( +- 18.95% )
                 3      cpu-migrations                   #    0.211 /sec                        ( +- 19.25% )
               701      page-faults                      #   49.230 /sec                        ( +- 19.27% )
    54,981,958,487      cycles                           #    3.861 GHz                         ( +- 19.25% )  (38.44%)
     2,012,625,953      instructions                     #    0.05  insn per cycle              ( +- 19.25% )  (46.14%)
       470,264,509      branches                         #   33.026 M/sec                       ( +- 19.25% )  (53.83%)
           194,801      branch-misses                    #    0.06% of all branches             ( +- 18.88% )  (61.53%)
   274,966,507,627      slots                            #   19.311 G/sec                       ( +- 19.25% )  (69.22%)
    10,555,137,650      topdown-retiring                 #      3.8% Retiring                   ( +- 19.04% )  (69.22%)
    21,206,785,918      topdown-bad-spec                 #      7.8% Bad Speculation            ( +- 18.13% )  (69.22%)
     1,094,597,329      topdown-fe-bound                 #      0.4% Frontend Bound             ( +- 19.25% )  (69.22%)
   244,462,123,545      topdown-be-bound                 #     88.0% Backend Bound              ( +- 19.33% )  (69.22%)
       532,232,051      L1-dcache-loads                  #   37.378 M/sec                       ( +- 19.25% )  (69.23%)
     3,224,574,249      L1-dcache-load-misses            #  909.02% of all L1-dcache accesses   ( +- 19.25% )  (69.24%)
         2,318,195      LLC-loads                        #  162.804 K/sec                       ( +- 19.35% )  (69.25%)
           206,737      LLC-load-misses                  #   13.44% of all LL-cache accesses    ( +- 18.30% )  (69.25%)
         4,950,866      L1-icache-load-misses            #    0.00% of all L1-icache accesses   ( +- 19.26% )  (30.77%)
       531,299,560      dTLB-loads                       #   37.313 M/sec                       ( +- 19.24% )  (30.76%)
             2,811      dTLB-load-misses                 #    0.00% of all dTLB cache accesses  ( +- 17.25% )  (30.75%)
            26,355      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  ( +- 19.58% )  (30.75%)

           7.12187 +- 0.00190 seconds time elapsed  ( +-  0.03% )


# Icelakex, multi-page (x86/clear_huge_page), region-sz=64g, pg-sz=1gb

 Performance counter stats for 'taskset -c 15 bench/pf-test --sz 64 --huge 2' (3 runs):

         15,764.52 msec task-clock                       #    2.999 CPUs utilized               ( +- 19.25% )
                17      context-switches                 #    1.618 /sec                        ( +- 20.47% )
                 3      cpu-migrations                   #    0.285 /sec                        ( +- 19.25% )
               700      page-faults                      #   66.614 /sec                        ( +- 19.22% )
    40,560,984,582      cycles                           #    3.860 GHz                         ( +- 19.25% )  (38.45%)
        79,578,792      instructions                     #    0.00  insn per cycle              ( +- 19.24% )  (46.15%)
        13,872,134      branches                         #    1.320 M/sec                       ( +- 19.23% )  (53.85%)
           119,492      branch-misses                    #    1.29% of all branches             ( +- 18.80% )  (61.55%)
   202,854,573,160      slots                            #   19.304 G/sec                       ( +- 19.25% )  (69.25%)
     3,982,417,725      topdown-retiring                 #      2.0% Retiring                   ( +- 19.25% )  (69.25%)
    13,523,424,635      topdown-bad-spec                 #      6.8% Bad Speculation            ( +- 18.69% )  (69.25%)
        18,661,431      topdown-fe-bound                 #      0.0% Frontend Bound             ( +- 19.28% )  (69.25%)
   185,884,147,789      topdown-be-bound                 #     91.3% Backend Bound              ( +- 19.28% )  (69.25%)
        22,587,703      L1-dcache-loads                  #    2.150 M/sec                       ( +- 19.38% )  (69.25%)
     3,223,143,697      L1-dcache-load-misses            # 21478.37% of all L1-dcache accesses  ( +- 19.25% )  (69.25%)
         1,777,675      LLC-loads                        #  169.169 K/sec                       ( +- 19.60% )  (69.25%)
           126,583      LLC-load-misses                  #   10.77% of all LL-cache accesses    ( +- 19.82% )  (69.25%)
         3,333,729      L1-icache-load-misses            #    0.00% of all L1-icache accesses   ( +- 19.49% )  (30.75%)
        19,999,517      dTLB-loads                       #    1.903 M/sec                       ( +- 19.38% )  (30.75%)
             1,833      dTLB-load-misses                 #    0.01% of all dTLB cache accesses  ( +- 17.72% )  (30.75%)
            34,066      iTLB-load-misses                 #    0.00% of all iTLB cache accesses  ( +- 19.09% )  (30.75%)

           5.25624 +- 0.00176 seconds time elapsed  ( +-  0.03% )


# Milan, baseline (mm/clear_huge_page), region-sz=64g, pg-sz=2mb

 Performance counter stats for 'taskset -c 15 bench/pf-test --sz 64g --huge 1' (3 runs):

          5,241.76 msec task-clock                #    1.000 CPUs utilized            ( +-  0.08% )
                10      context-switches          #    1.909 /sec                     ( +-  8.82% )
                 1      cpu-migrations            #    0.191 /sec                   
            65,636      page-faults               #   12.530 K/sec                    ( +-  0.00% )
    12,730,694,768      cycles                    #    2.430 GHz                      ( +-  0.08% )  (33.31%)
        36,709,243      stalled-cycles-frontend   #    0.29% frontend cycles idle     ( +- 24.07% )  (33.32%)
        37,520,225      stalled-cycles-backend    #    0.29% backend cycles idle      ( +-  9.87% )  (33.34%)
       874,896,010      instructions              #    0.07  insn per cycle         
                                                  #    0.05  stalled cycles per insn  ( +-  1.23% )  (33.36%)
       199,308,386      branches                  #   38.049 M/sec                    ( +-  0.84% )  (33.38%)
           441,428      branch-misses             #    0.22% of all branches          ( +-  4.68% )  (33.38%)
     2,495,566,569      L1-dcache-loads           #  476.417 M/sec                    ( +-  0.04% )  (33.38%)
     1,079,711,798      L1-dcache-load-misses     #   43.28% of all L1-dcache accesses  ( +-  0.01% )  (33.37%)
        50,936,391      L1-icache-loads           #    9.724 M/sec                    ( +-  1.29% )  (33.35%)
           284,407      L1-icache-load-misses     #    0.56% of all L1-icache accesses  ( +-  4.60% )  (33.33%)
           546,596      dTLB-loads                #  104.348 K/sec                    ( +-  6.14% )  (33.31%)
           231,897      dTLB-load-misses          #   42.08% of all dTLB cache accesses  ( +-  4.27% )  (33.29%)
                 6      iTLB-loads                #    1.145 /sec                     ( +- 72.65% )  (33.29%)
            34,065      iTLB-load-misses          # 262038.46% of all iTLB cache accesses  ( +- 44.88% )  (33.29%)
        18,237,487      L1-dcache-prefetches      #    3.482 M/sec                    ( +- 12.84% )  (33.29%)

           5.23915 +- 0.00421 seconds time elapsed  ( +-  0.08% )

# Milan, multi-page (x86/clear_huge_page), region-sz=64g, pg-sz=2mb

 Performance counter stats for 'taskset -c 15 bench/pf-test --sz 64g --huge 1' (3 runs):

          3,655.71 msec task-clock                #    0.999 CPUs utilized            ( +-  0.13% )
                 7      context-switches          #    1.913 /sec                     ( +-  8.25% )
                 1      cpu-migrations            #    0.273 /sec                   
            65,636      page-faults               #   17.934 K/sec                    ( +-  0.00% )
     8,879,727,514      cycles                    #    2.426 GHz                      ( +-  0.13% )  (33.26%)
         5,733,380      stalled-cycles-frontend   #    0.06% frontend cycles idle     ( +-170.04% )  (33.28%)
        42,012,302      stalled-cycles-backend    #    0.47% backend cycles idle      ( +- 24.51% )  (33.31%)
       214,672,610      instructions              #    0.02  insn per cycle         
                                                  #    0.28  stalled cycles per insn  ( +-  1.71% )  (33.34%)
        42,298,268      branches                  #   11.557 M/sec                    ( +-  1.28% )  (33.36%)
           267,936      branch-misses             #    0.62% of all branches          ( +-  7.80% )  (33.37%)
     2,235,310,058      L1-dcache-loads           #  610.770 M/sec                    ( +-  0.02% )  (33.37%)
     1,089,602,355      L1-dcache-load-misses     #   48.73% of all L1-dcache accesses  ( +-  0.01% )  (33.37%)
        48,725,812      L1-icache-loads           #   13.314 M/sec                    ( +-  0.25% )  (33.37%)
           231,227      L1-icache-load-misses     #    0.47% of all L1-icache accesses  ( +- 13.20% )  (33.37%)
           280,655      dTLB-loads                #   76.685 K/sec                    ( +- 13.33% )  (33.37%)
           151,028      dTLB-load-misses          #   44.02% of all dTLB cache accesses  ( +-  6.64% )  (33.35%)
                15      iTLB-loads                #    4.099 /sec                     ( +-  6.67% )  (33.32%)
           121,208      iTLB-load-misses          # 865771.43% of all iTLB cache accesses  ( +-  2.74% )  (33.29%)
        18,702,209      L1-dcache-prefetches      #    5.110 M/sec                    ( +- 12.51% )  (33.27%)

           3.66065 +- 0.00461 seconds time elapsed  ( +-  0.13% )


# Milan, baseline (mm/clear_huge_page), region-sz=64g, pg-sz=1gb

 Performance counter stats for 'taskset -c 15 bench/pf-test --sz 64g --huge 2' (3 runs):

          3,544.20 msec task-clock                #    0.996 CPUs utilized            ( +-  0.21% )
                 5      context-switches          #    1.406 /sec                     ( +-  6.67% )
                 1      cpu-migrations            #    0.281 /sec                   
               227      page-faults               #   63.819 /sec                     ( +-  0.15% )
     8,609,810,964      cycles                    #    2.421 GHz                      ( +-  0.21% )  (33.30%)
        77,420,424      stalled-cycles-frontend   #    0.90% frontend cycles idle     ( +- 20.55% )  (33.33%)
        25,197,541      stalled-cycles-backend    #    0.29% backend cycles idle      ( +-  1.09% )  (33.35%)
       658,146,061      instructions              #    0.08  insn per cycle         
                                                  #    0.16  stalled cycles per insn  ( +-  0.04% )  (33.38%)
       154,867,131      branches                  #   43.539 M/sec                    ( +-  0.04% )  (33.41%)
           167,531      branch-misses             #    0.11% of all branches          ( +-  5.19% )  (33.41%)
     2,417,846,489      L1-dcache-loads           #  679.753 M/sec                    ( +-  0.01% )  (33.38%)
     1,075,531,869      L1-dcache-load-misses     #   44.49% of all L1-dcache accesses  ( +-  0.01% )  (33.35%)
        12,835,321      L1-icache-loads           #    3.609 M/sec                    ( +-  0.41% )  (33.33%)
            55,282      L1-icache-load-misses     #    0.43% of all L1-icache accesses  ( +-  1.98% )  (33.30%)
            23,287      dTLB-loads                #    6.547 K/sec                    ( +- 15.61% )  (33.29%)
             1,333      dTLB-load-misses          #    4.48% of all dTLB cache accesses  ( +-  1.26% )  (33.29%)
                 3      iTLB-loads                #    0.843 /sec                     ( +- 33.33% )  (33.29%)
               231      iTLB-load-misses          # 11550.00% of all iTLB cache accesses  ( +-  6.14% )  (33.29%)
       170,608,062      L1-dcache-prefetches      #   47.965 M/sec                    ( +-  0.84% )  (33.29%)

           3.55776 +- 0.00738 seconds time elapsed  ( +-  0.21% )


# Milan, multi-page (x86/clear_huge_page), region-sz=64g, pg-sz=1gb

 Performance counter stats for 'taskset -c 15 bench/pf-test --sz 64g --huge 2' (3 runs):

          1,718.27 msec task-clock                #    0.999 CPUs utilized            ( +-  0.08% )
                 6      context-switches          #    3.489 /sec                     ( +- 14.70% )
                 1      cpu-migrations            #    0.581 /sec                   
               227      page-faults               #  132.000 /sec                     ( +-  0.15% )
     4,176,107,493      cycles                    #    2.428 GHz                      ( +-  0.08% )  (33.19%)
         2,675,797      stalled-cycles-frontend   #    0.06% frontend cycles idle     ( +-  0.34% )  (33.25%)
       147,394,527      stalled-cycles-backend    #    3.53% backend cycles idle      ( +-  8.80% )  (33.31%)
        12,779,784      instructions              #    0.00  insn per cycle         
                                                  #   13.14  stalled cycles per insn  ( +-  0.09% )  (33.37%)
         2,428,829      branches                  #    1.412 M/sec                    ( +-  0.08% )  (33.42%)
            63,460      branch-misses             #    2.61% of all branches          ( +-  3.48% )  (33.46%)
        31,159,378      L1-dcache-loads           #   18.119 M/sec                    ( +-  3.27% )  (33.46%)
        14,692,358      L1-dcache-load-misses     #   48.21% of all L1-dcache accesses  ( +-  3.12% )  (33.46%)
         2,556,688      L1-icache-loads           #    1.487 M/sec                    ( +-  0.89% )  (33.46%)
            21,148      L1-icache-load-misses     #    0.84% of all L1-icache accesses  ( +-  0.25% )  (33.41%)
             6,114      dTLB-loads                #    3.555 K/sec                    ( +- 12.76% )  (33.35%)
             1,742      dTLB-load-misses          #   33.73% of all dTLB cache accesses  ( +- 21.79% )  (33.29%)
                45      iTLB-loads                #   26.167 /sec                     ( +-  7.52% )  (33.23%)
                90      iTLB-load-misses          #  210.94% of all iTLB cache accesses  ( +- 21.20% )  (33.17%)
           257,942      L1-dcache-prefetches      #  149.993 K/sec                    ( +-  9.84% )  (33.17%)

           1.72042 +- 0.00139 seconds time elapsed  ( +-  0.08% )

---
 arch/x86/mm/hugetlbpage.c | 49 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 5804bbae4f01..4294b77c4f18 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -148,6 +148,55 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 		return hugetlb_get_unmapped_area_topdown(file, addr, len,
 				pgoff, flags);
 }
+
+/*
+ * This is used on all !CONFIG_HIGHMEM configurations.
+ *
+ * CONFIG_HIGHMEM, falls back to the __weak version.
+ */
+#ifndef CONFIG_HIGHMEM
+static void clear_contig_region(struct page *page, unsigned long vaddr,
+				unsigned int npages)
+{
+	clear_user_pages(page_address(page), vaddr, page, npages);
+}
+
+void clear_huge_page(struct page *page,
+		     unsigned long addr_hint, unsigned int pages_per_huge_page)
+{
+	unsigned long addr = addr_hint &
+		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
+	const long pgidx = (addr_hint - addr) / PAGE_SIZE;
+	const int first_pg = 0, last_pg = pages_per_huge_page - 1;
+	const int width = 2; /* pages cleared last on either side */
+	int sidx[3], eidx[3];
+	int i, n;
+
+	if (pages_per_huge_page > MAX_ORDER_NR_PAGES)
+		return clear_contig_region(page, addr, pages_per_huge_page);
+
+	/*
+	 * Neighbourhood of the fault. Cleared at the end to ensure
+	 * it sticks around in the cache.
+	 */
+	n = 2;
+	sidx[n] = (pgidx - width) < first_pg ? first_pg : (pgidx - width);
+	eidx[n] = (pgidx + width) > last_pg  ? last_pg  : (pgidx + width);
+
+	sidx[0] = first_pg;	/* Region to the left of the fault */
+	eidx[0] = sidx[n] - 1;
+
+	sidx[1] = eidx[n] + 1;	/* Region to the right of the fault */
+	eidx[1] = last_pg;
+
+	for (i = 0; i <= 2; i++) {
+		if (eidx[i] >= sidx[i])
+			clear_contig_region(page + sidx[i],
+					    addr + sidx[i] * PAGE_SIZE,
+					    eidx[i] - sidx[i] + 1);
+	}
+}
+#endif /* CONFIG_HIGHMEM */
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_X86_64
-- 
2.31.1

