Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF80C62469C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKJQIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiKJQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:08:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EA43F05A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:08:02 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAFvJje017398;
        Thu, 10 Nov 2022 16:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=0tIq+Nk9fP8w3iWkgsV7ZO05ZvnZbB65xj6iQU83LWA=;
 b=SAcskyplNTxQOltZwOHQeXIl7O72J0k/d1mousiQuZbMk3HTtSulh515Mg9xJmcdKX/B
 /yuZJHsSMR1yib3aISCytx8IUW69KbiRKkRjMvFAh0IqgaIwg7+T9k8MSOuogOLtsraG
 1yaZSMk5T4W+DG/I+F0lmUzdY0lqPcYaEwpKZL7Qv4GdA2FxQWn0HU48mf6s/kG8+93p
 572nBUkbe5Pu2NQoUikuhDQQayylQyhlM5JQKJ9JX+/w34RxQM+O9inQ3S5NqZoJ2lY6
 rmBmQqvPzL9rwTsDa/QG2f6IjMzC5NNunmp4IVgHu+a3cFT+jaDD+s+xJtpYA7LdLFgn qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks4d581r2-30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 16:07:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAFaWBp035073;
        Thu, 10 Nov 2022 15:45:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctfahdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 15:45:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hk94l+0YDzJMJ996aup9FtDik88ppQAy9rCYbBMWv68M3Llcpsp6zDCDxZxa8aSbPN/jk9fQH5IIK4zf/Kk47VRPsrUlxt1ZvYR6vKifhoaZxu2yRXicuEqUuoMpyhTGGNeKuOAmvzaAZg1t0I65H4xly5YQ3Ko7QvNPSrhVWiA+sGZYzjzEomPtSx0/MRVs7Ka2u5jLU23UvNxouu8uflorfp/D8YsbHGSiFGpRWWr8RYF3U08FHSbQUAzkIiN7asEt8Qdyuc9BwLE50ADTyL5GiEz3ycIjz/BtOxj+xmaDA3qwLYQ3Mh4LMCCrqw7HpVKEYpMftQc72BKb2HGluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tIq+Nk9fP8w3iWkgsV7ZO05ZvnZbB65xj6iQU83LWA=;
 b=FlHMlHiD4W4zC5brSuC6h32f4z7fTE371qOPBZF9UFux5D7UMgyqZXCsWxODVOG5oDFlDgTugpxjrnuEOXUhym6LL6++KEXntn2dhnBk7WHrVAD+8wPMIrR50+B1K49KhI5KdVhOIRQuAuvDlWAWWtZ8UgMjaLXBR1xnAYgzoiHE4XRkglCCtxb+l9uAGCV/d/e+qLEAqHsAmUsLmTYBS+nz7kyzj+4gsvXZs1ciTuPBWtjkFgi0MKAuGNtp0beloZp0ZFF4u67MlaWUkXRQevT481UxcowepHPPY8cKrA8tnQTTpVIneqKY6P/4cn28NmQzEpy3LCuquuTo618vow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tIq+Nk9fP8w3iWkgsV7ZO05ZvnZbB65xj6iQU83LWA=;
 b=aVMcad4g66TYhg1YlYzTZCwvP6l8fHRjvb/pmPYvtLoAiMU+z1pnyvKvM3PqXtAb7HC7bQBbnXeqB9bfrEF1/zoS2j9N+26RYifwKNphoSu7B+40IE9GCxmioxONTsEwJRrOZ56zep/vI7DLknV4bEWQRlZ6f0OYFA45Jeeliok=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BN0PR10MB5286.namprd10.prod.outlook.com (2603:10b6:408:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 15:45:23 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::72b3:f74a:9e7c:680a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::72b3:f74a:9e7c:680a%4]) with mapi id 15.20.5813.012; Thu, 10 Nov 2022
 15:45:23 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
        jailhouse-dev@googlegroups.com, jan.kiszka@siemens.com,
        xen-devel@lists.xenproject.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, andrew.cooper3@citrix.com
Subject: [PATCH v2 0/2] x86: Check return values for early memory/IO remap calls
Date:   Thu, 10 Nov 2022 15:45:19 +0000
Message-Id: <20221110154521.613472-1-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:806:28::28) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|BN0PR10MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc44359-3b45-4427-9eac-08dac33294a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: If/RgOQlPiPi57BbY+nwagCaBxGqJLuUX5nCtb5wU7Lt5fuv7+K3sVU9NRWa9HSgKGxg6IRNL0k0iTNbhhTRZL/xucHh57J5zqvRfKMCiD2uwHy+NzOXj6cfpwY+sAiTBslpeJ3M4+7UVLg/zC0PtIxur3xy95l6gIvJQl60Y6RbJVzrwNkvPnM90872pfkLvzDPQURtPfKriZpQZiglfGsPSiHPTKnhHV/VDxzcP/mgTwRCPDFWHJ2nxCf/DO6MX6hHtnh+TCD/WP47z7J74/kmgL+5Lk76977fhT156AEFMGMQUZbR4RXAgd2mS8B45X5oYRr62PEflU94H3hbDaqEb+SZNA0wyfzX1OG/L9FLjV8BPamJkuDbgSxNW+1twrBNiTMf0QD9qGcnOR6/E5jaDESzcdJ2oPl1QsbE/u/zcC/1O/+MX36ozVNjTf94Wyc8BGXRlrwQOOtHQJwZ6TQGrLl90olImT39a0Pv00Cxg2W4EvnvfyqLD1ZOxHJph3RpWV1japI6nrnPyIiJj1zTtzELXJZZOTiu4kWHI5IGwiL8S+MeiXyAOiroUHhhBSjry9oX9B6CBP681oElQJPLjN6eHP86hvPNfJ03Ky5kBjrNUoTI4Acea8LPWGsG3sSqyq6RlZlJOvA+v54lm+R7aMZVFFe6t1t0ZLIW7j8pyT4MokTbZV2p1eOqNRgUUyiXWE9ioDcpQaii2miZ6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(86362001)(7416002)(44832011)(8936002)(41300700001)(6666004)(6506007)(66946007)(2906002)(4326008)(8676002)(66556008)(1076003)(5660300002)(66476007)(83380400001)(6486002)(316002)(478600001)(2616005)(186003)(36756003)(38100700002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c9VomFaLbZSYbYnPXlqTqw/Q9tgio1lZBkDZYLNnVKK9MVs8PStlEl8CyRnj?=
 =?us-ascii?Q?MeU4Yx//JFLRiqLyUptwuZ4B5QE3AlaDMEDlIRKtA15IbRKrAc07OCNi76w3?=
 =?us-ascii?Q?8IaKP004Q5KhRjXeu6CWv6vkGDOlBJ44hVSEXv8Hj3TV6rAmZG06VlZPN5Zi?=
 =?us-ascii?Q?1TsMbI7Temed44F6kxXz418siuG93JQFiEmVJHznXEZJJwk257dHfTjfBj5r?=
 =?us-ascii?Q?EJdVrOYqWO+Mjl586nhMZcTluxAXty5OvWntNan+aLzIpy2siP747+Xr8gvz?=
 =?us-ascii?Q?HRkkZl6Zstmmpo2gPcWR2fvS2P9K5Qndu/03v7O8XnWn7GxvqZ9yK6BBOsOc?=
 =?us-ascii?Q?1Mux3nc1C/dJh3kpl39dmIlbjel7EGpQ45KveALBzf2PyQlKvRIiPL76mCGJ?=
 =?us-ascii?Q?IUK/Tu8JwtbH7+QvjC8ndhBYvUUjBl9278RKt/zOgP9ftFlXFB5XB+aWR5Kh?=
 =?us-ascii?Q?kYhwGE75317ItO5wmGHNXBayV+fM9N6VJp3KnySW5nsp5TxjQtwlXkFF/rKF?=
 =?us-ascii?Q?wn68bDp4qqWac7UNgAui9qf54pvtTxa+1QIuVnyRB/MUDDJaIRgcQnnq4Iqg?=
 =?us-ascii?Q?6GCBFyz0q1Xlhn2M5kS+3+4vZnA3eCB36tFgWp/gFzmpEd9cVvYnKL32VDsc?=
 =?us-ascii?Q?Xnsk0P4uAteUtjTkS33LxkVC1eqbfLQhITAl5oUPWeGwIkY6vlRw5No6DBPL?=
 =?us-ascii?Q?9zQuSeIhu9T98mxim0BkkpNYWSI4zn5ye59qdtwcayz9zo4NDpSFO7cGypiE?=
 =?us-ascii?Q?1Rfw/xBNk6qkBEJeIR8klEaR2AtCE17rjOWKxittq3y5/f7aZQnmk2B1zEhK?=
 =?us-ascii?Q?TY1UckGs+mhqeIOdvfAHJl4t02F7zd+ygrjwBos9ah0sFMToUrVjRe4dwxqq?=
 =?us-ascii?Q?165PQ6FODsGexbx3VLt04SoF8yWuCQO611jwjnXGDfv01Xfgl8c4LMU4lA0d?=
 =?us-ascii?Q?aaXFNDq2+aNnNtjx2Jd9dIvZl99X2TbX72Rf+3xKV4vDr0uhcgYTIa8c/03V?=
 =?us-ascii?Q?xbWjaCszMApzxXMG/YYsnzfd7DFB2Od2jTJkECvVETn/+Cz6jDba4WBkrpo7?=
 =?us-ascii?Q?aGVp+/74DUF/ubFsqGBFmyRkfCHeFqX6xFFGmxecrlF3/M473FtG0wVaGSeS?=
 =?us-ascii?Q?aaOJgRRQ3dAXkmoww1WZDXswV1Z2MKX6QdPIgiEjXdYvYBX+lodW6/bR9mmb?=
 =?us-ascii?Q?mvbT169N8po3lBz2AeAOhHL2poGGGbwvu0X10NFGPV/ucl2kY9+WeuFG7WYj?=
 =?us-ascii?Q?BZRG/JHgKoegSOjzd8FFITjOtPXxugCvnDRY7PLrrelN+gISNh4pE7sShYth?=
 =?us-ascii?Q?MvdzhYwYvYyKqfgzOD1XuozuTu3drmTSbmahxDGg7N9r4XQiSetUDNgCf6N1?=
 =?us-ascii?Q?K9itbahGppdSqwZ+AqWKQic81MNRysZDg17SaYNAmLncHvxwAtvW1X+gUgLK?=
 =?us-ascii?Q?IYI825WEZ+HvgGPUs+BxGmDB+k93/N2/6WkWYLCrxgbizvgezilKJ096S9t2?=
 =?us-ascii?Q?wxUbAzdTiDpnM6/ORAxnRlunoH0zY/DMNMh0hgsx48g54V1Dj1Sxz1e1PGrW?=
 =?us-ascii?Q?jglH0JMI/HfyxLOu1vDSYelVZRd8yUXHW/UbEn/YcdwP2fahujp5nUPsqrVD?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc44359-3b45-4427-9eac-08dac33294a2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 15:45:23.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTpsJqvgszOxPEqQJ1cBZvOT1BDwD+x6B3L2yepoXinaxA7A6yt17UrNQIFxXFb+04eUFwZ8HC3Xo/XV9xiYABXTA5RQ/3+EL+dxEZaCnMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_10,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=694
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100111
X-Proofpoint-GUID: 5ZCQR8N8QRNY8JYeYDKOaztjqMhOmB2S
X-Proofpoint-ORIG-GUID: 5ZCQR8N8QRNY8JYeYDKOaztjqMhOmB2S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While sending an earlier patch set it was discovered that there are a
number of places in early x86 code were the functions early_memremap()
and early_ioremap() are called but the returned pointer is not checked
for NULL. Since NULL can be returned for a couple of reasons, the return
value should be checked for NULL.

This set fixes the places where the checks were missing. It was not always
clear what the best failure mode should be when NULL is detected. In modules
where other places tended to pr_warn or panic e.g., the same was done for
the checks. In other places it was based on how significantly fatal the
failure would end up being. The review process may point out places where
this should be changed.

Changes in v2:
 - Added notes in comments about why panic() was used in some cases and
the fact that maintainers approved the usage.
 - Added pr_fmt macros in changed files to allow proper usage of pr_*
printing macros.

Ross Philipson (2):
  x86: Check return values from early_memremap calls
  x86: Check return values from early_ioremap calls

 arch/x86/kernel/apic/x2apic_uv_x.c |  2 ++
 arch/x86/kernel/devicetree.c       | 13 ++++++++++
 arch/x86/kernel/e820.c             | 12 +++++++--
 arch/x86/kernel/early_printk.c     |  2 ++
 arch/x86/kernel/jailhouse.c        |  6 +++++
 arch/x86/kernel/mpparse.c          | 51 ++++++++++++++++++++++++++++----------
 arch/x86/kernel/setup.c            | 19 +++++++++++---
 arch/x86/kernel/vsmp_64.c          |  3 +++
 arch/x86/xen/enlighten_hvm.c       |  2 ++
 arch/x86/xen/mmu_pv.c              |  8 ++++++
 arch/x86/xen/setup.c               |  2 ++
 11 files changed, 102 insertions(+), 18 deletions(-)

-- 
1.8.3.1

