Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D616F87EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjEERrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjEERrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:47:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5374A18FC5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:46:58 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhJg4031569;
        Fri, 5 May 2023 17:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=u3/zRZ2Ucre2QO+L/T9jdiOBbG7EEf5W3yMRjcw71Ww=;
 b=pahWxCYrDEghRdMvwuhc+oWonYau/MONHHYd+bJdqo7ybGwMiZUhWCDLJxTGd7TyGgS0
 QQ5mwBrUDjNWXXBTnDawDt59++4l/vsWHKZ1bDcYAbwtCAaWO+fQNvUnCjFh3KoG2orq
 gX2DnQ0naMFNmsMd+OsUWNRiBDAe3Im/prVN5VE3CaME1SVmQBXamugQA2q/lDE5A+go
 TeaaSvh9hLwOGEb6rkxYNaU4SKVECBysnhew9TyiZHh+G3EELAP7LKaRzmSBc/MeXSEj
 bBcigmbGNiFs0qUwNCafQjmqk7rO9Tn4VYIUfwv+KRg/YDQTsbhME7T46HGmXJ2rDU8u dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d5nfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:45:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HbPfx020743;
        Fri, 5 May 2023 17:45:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa5fx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:45:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmuSEypsqfAs1PYm/IsoZjKGl901Q98PCmAmAxhw6hc6E6mN9Di1XJWOVCsUpN15hVbTsu4yevAaHp5OBg9XcF84OuH6OxPMh/HaaqUPUT0vcWfzmRcqr4FJS8GLi8DaeaxYvdvdi/0FYizU4UmhBBcy1XdgHGLTIg1os5yDA6ocKSqPIU6Hr7lz01z+Ddw4s1N/LxZCALROpuOcdhx/wde0NKdDaTWSm5BhHjeDDBjZvBjVJv5T61yJFCNDm3YDG9K71ji5YqX+lWi0uzpGhFFgQwKofjVIKCoAQvwVnIPbM/3u1IehBIdgl1A4nrSACv8N4y6ZTXEYtPvv6dFvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3/zRZ2Ucre2QO+L/T9jdiOBbG7EEf5W3yMRjcw71Ww=;
 b=ZjeFbgHO3i8G15kei40q3cYZoaCOFKkRsPtpzW54MBJ1Rqggeh+iruftNcEBWD3GK7/NYJG6CyBb2F0uTYVkr3MG29FoCbQIVeBm4YJRmt19GsV+++bZH1s0/Qit4tRnwQKHqlvm2MCIcLqG1K0kUSX8aKHh0hgIMg3Ra/ToefbPFJycqa1KvbaBpMcOp6naxLBTRl6U/L2r555jN8Va5qwUNnFrJjsd3ZUQ1I3XUJQ+brMWWRVj8jebmaj4ono+9ERinR5Sv1Agmt1cGKbAvRSmKg9hNJUaM6LtxllaUo6MUFlAv4IzOsPTxZL/vIaKdMdOGlpJMWkqccv146sqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3/zRZ2Ucre2QO+L/T9jdiOBbG7EEf5W3yMRjcw71Ww=;
 b=pdoLd2FxxApSZYhwUQnjaFvg0rNxx8NvVID9ew0lvBWJoRQL+RC+kZCC9ipeqZtKSFpb6sMtWSYYNoKulkugmIgn6f+DrWKSQuLWDleF203RGpe5EwGWNZh3sfDCxXkY1KhkXi09uPLx3wkCwn85xz/69WIKwh6LZJeKp/aIyWU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:45:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:45:03 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 35/36] mm: Avoid rewalk in mmap_region
Date:   Fri,  5 May 2023 13:42:03 -0400
Message-Id: <20230505174204.2665599-36-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0217.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d52c6f-f213-4703-2630-08db4d90750b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NDbfh/N8FwETHtRuNOPMuOCAGZB4jKWH/H4JWJZ0y25XNXE3ZRmLZ9LNSw/VAqCDQNE1ml7Dzzo/LZ+5FlNiX7/jzCyguK6FGFjcpg2V0sGDaNdIqygEy5Th9I7jTLlr06dFnKxdVZiKFi4p/rwnw1EPaQ5YH1Ql0LROQfY7xsvhoPs3+stwG0+CHgxK+UArLEc7GWT0VCuqFF/GfvDxxTubnMvNCu+9h0nv1j4HjpeTsYSRZtFYK7ERWkgqddSHQePlU7WIxX5qYfB9UfIWJgYthPtu3kuZbuFrSId+9SaxCUGsHJDCFVVDPIKWZ2+FxR7hiw2fBpHKm/QJJ9wbsOA+Y3lyILmYxdQn+IW95wEfhNnpd6hyhYyFB6RHR99MFKfpeHS8XGp1zGw/+iPxdNAbU8ivRtUIt1NTurFL5VJKSUF0yyofbDY60vQf+ZptFRfat5dzVsuIP6HjjBmA9MdnGBJbdhidlHn/+8SFaqSgMxzBUwze3+X0zJW2Ee77Lugmve4XoqogT3Vce3KsLDwZO+nGF/qoa541M7C/7zCwOzBWfD6pCOlFfRV12uL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6486002)(107886003)(2906002)(4744005)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0W0bMN9Hvu3dRa9sKpvMLCm8zuL7eudMrQSSivwHjzUBUqlwvTYLndjjAg1?=
 =?us-ascii?Q?dkIsYUU+KMfKWUff6hM2U1l0k3hG4v+roHun6aEIYOXRmLeFVNNKiidiUPDk?=
 =?us-ascii?Q?qabGDQKt3LOO45lW/kJJIxTD4XqjUC1ogpRjG9P0JXXkO6HaZi/k4PI0qQOq?=
 =?us-ascii?Q?ucppnUG5kB1BKthImL9qnie7GW6SMnzlkmKFgUdEWxCzuex9D6XnFrfnWY4o?=
 =?us-ascii?Q?BzmejAUAFOZLB7qK8iXMXaPeCYPMGuWcLdCU7i8Mu6s2C3Yf6dY4vdjDWhGK?=
 =?us-ascii?Q?KkAMqSz8xu4KL2LD0kxvE6sHATjuUtny7JjMAY4nkDgUYQrpDsmg+V9jo7iP?=
 =?us-ascii?Q?SA9uE8alsjyGYZnpt0K9/ObCjes9Y269QBCpEX2JW0q60pe6Hg+HWN0niGaK?=
 =?us-ascii?Q?X9LN/onQZHKupEgbA4SFHh3HEg/0rO+CJjvdJ1RMrVPsQX1dU16CDLfy824n?=
 =?us-ascii?Q?lG3pOA4bMIZkaxSwVoIGZQwRQujwnbgVIA3BFbj05ivYQ4ZwCFt+LhlftJgT?=
 =?us-ascii?Q?MsoLj+AxnWGlw2xtK90Yz1iPvZKJckPbjQ1WKwZCr22KT4sJtTyojEXRReCX?=
 =?us-ascii?Q?4tvtq7Irvnd7E+yo77A8ya+/sxLITpPjEhPUl22kpL/NjVXEk4UbWckjRZ5E?=
 =?us-ascii?Q?W/S//mcf1lBS1scNAOntxtOLOO6kZ3KCa8Xg7GLNfMYGEXbPv/2LxKT8CGPY?=
 =?us-ascii?Q?5greN9UD1byt418aWT1hC0VpSfcPrCKChaXdPhv7FdtQMQeIjWzMUvkJcVYk?=
 =?us-ascii?Q?/g5TrqSSfaBxuceTur0TndFoRK/Zv3Gt7GLGRPNiyf9o+DbcDTMvbLrus5MH?=
 =?us-ascii?Q?xHi1n3FQzBAhclJ1NlXvWbErnCTISAPmn7N0ZAXVSWPLlBf8JcCMd1YxIzFV?=
 =?us-ascii?Q?FVljxHHHsqQ4HYoiy84Qfg8iQVHCp+lV7YpuIKLXNcYtRxs/rfPHoRCjgJO2?=
 =?us-ascii?Q?qgfTwoEHYNMMib6Xe5zgQQMOWqpIoehk7CPwkWyupx//Kr7pMNGNhhcH0OWa?=
 =?us-ascii?Q?5l2QBy97FYo+whw/+VfZVwd3dLgb7yC9PekQaJBpLusUHfoaSYoLjBnOMYTO?=
 =?us-ascii?Q?Xfv+oFvx3XPVCmDeIgcJvQk+TCp3jfC9edDN5K0ZsglfFP2vj/AzWjP2HONl?=
 =?us-ascii?Q?qkt/pRsjMSiBuEQ5hsJbvfEBf3WwFwwr2maL04YwUXfx12cspnLtz8CWo0nf?=
 =?us-ascii?Q?imZZ3/9AfVjjqFp3LLwvk2/GAjFe9OWaM1q0EPW/AQkIpErh2d8+wFWVtLeN?=
 =?us-ascii?Q?H8VPBhIMmfhVcUmzSbekvLzeXybddTncblWCa/VX99Tnald4xjikoy7rNSwv?=
 =?us-ascii?Q?FWGtBfVeR8pZ6oXjKnSx7TfjYtGCczhN6BhAFLWxNLPnPjHFJwh9EHmiHifF?=
 =?us-ascii?Q?jRxzk3DFFhq02ALz8YPmP69jcbKMh7CIknjitiIRmgwitf2Mkduqm27P1rJW?=
 =?us-ascii?Q?RdIcFgdqrJLD4s3EHQBNkoCVxoyN/qg2stKsqqDJQ4D5bnL3krW4AaIyNbVj?=
 =?us-ascii?Q?IB3wLGzEwbZUlLtOVmcOiK4TdXUjnoJrJyUs4TgxfbCULG1eaYNdc1uHgCZN?=
 =?us-ascii?Q?DZvm26uoQGV+k3kFOoBaBpTWKkum5BNFcpgltms89edS/3o7bDWmCaeITp6X?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KniLLsFqxbmz4RRNoBSqGH2GiTDmkgh1WJecUrUVX61I64BXxHb6bNbRUU8fzKLf7wZ4bfrYVHkpBee2bamENbkDsZZHWUpW1Wg/mB8CuW6nkzBZn1VWNFrGgJqFOCSuRkMngV/gt4utLODKedqLo30XzlWXO/Nma/tAbxgZ9CJdTKzMK6Q0XVUm2L6o7dzmrqLW4dzWbjqDSHJIQxP8GaomVewLR2A4dNnFrhzCGUonRA/jURsYhohvX7pFDtmqdyADWq7IOvGFmCkRoZ2SCp/g4yVC/dGlozefpaXNlqWgDNcZ/+PT5M4wIrlJ1bkuo7AktFSImNYRoYYkdayTpV6QeOmZf958j0Hfgl7/374H85X/6viZnGkdGnVGmZVKJpPYtO0Dfw9igP8dC89A/mrPFCg3k8j6KVoKbvCt2mbNxHILWSqEskwoJOfwFciw454gTfo5EPuzj0h4gEetxc+iEMFcupdb/4hmw9Y+ldaY5SoMVAXPa060hBtMs88G+GHLrJVjd1uoYMYdKSF6z/MA45NqVSd8YrwuMYNcNmNEYXLgXzcydZhMpbQIFa9B1cbkwRguMpCkztjHKiP3MEaGZc4txquUrfciJJoOJQ6OhIkabnHPYJ12vjztF76kAlPy9AqstG7iLcCc2C6zGL2wPA4j+q2skdkh/2hXNIJkt5kE1ODlF80sSB6IfBzm3Sx1c7Nwjp+8TCaZgxaOBG3Pr3thODT/JVorOfVJtmyF9Cm4USObNNoitr5M1NnmoQPoYlB8PAbYgiDU8JkWmPKCfRJx1U6XJuAAYXbote+nRXdM4+eppK91rFaQ0SK2u0FaomE4IhldT+xUtZ1SX/RLS6zhBrbQbDEBIdoQDnT8yBzWQl0vmcBkD9bFKAnLqXGnjtEcfJ0zHG/kZUm3aQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d52c6f-f213-4703-2630-08db4d90750b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:45:03.8633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRClgog24OKVIgUIw1SH6RKc9vZsdle0y+U/69l6hd3PJp82tecUa1D08sTDIqjMy6N1vJ08piuEjHOJ+5VuFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: h5WrWaYfPzxYfDORltX47ft6PN3He3lk
X-Proofpoint-ORIG-GUID: h5WrWaYfPzxYfDORltX47ft6PN3He3lk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the iterator has moved to the previous entry, then step forward one
range, back to the gap.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1602c854133a4..71733953ff836 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2636,6 +2636,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 cannot_expand:
+	if (prev)
+		vma_iter_next_range(&vmi);
+
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
-- 
2.39.2

