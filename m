Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E2B618D8D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiKDBSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 21:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKDBSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:18:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025F4764B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 18:18:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A40T8tZ017515;
        Fri, 4 Nov 2022 01:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=afDnWx7KDSr+HSL4S8p4GAQRhSMVUXfqMhYDI8im7Bk=;
 b=Rz7U2RL0TS7JXynFcNYvcXMZNmnmQVwQroyoOH6WtzPXAZQzy7RUuhaQtVoWY6ZsSal4
 fBnfFMWuvJY9Gq0j3SDJBCeeWSYpjfqPNl/lk7VBdnS2gw+9MYEBAMqjsuRMyd4xd/qT
 e1l21JlF+6SUi7mBJx+z9yK2Ta8oF8m/EEEQ9+36CDEzXXo0psFFuUb5ecMXSYVkBPOZ
 5DRgADzMfTtLkwhjnMJgAb4KlJBJ6TRzuEkkmwYeXvUyHWkCY0OOPG/o1xxz14dwugrx
 VgNz12j7S8hAr9SvkYcLu4Ng1xA4MB7DEhgUS2nHLaSMCavNvtkqiYLVM/W+Jx/ekmyr qA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtpsxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 01:16:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3NL3O1032943;
        Fri, 4 Nov 2022 01:16:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kmq85hwsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 01:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBSnp+lMbzySjSwMJj5FL/ozOYjnTA0kltrIw9a8THXC0+Gh0mdgKoxVeelV6eM2A6sxToOdcxiiLc0r9Boeg6G5R+RQ8yL6TptY/j0AQE/Rc/mxBTYMdQqhUhvNFePLy7nDMkOUFjAse2OrkfrpVI5v5BiOHAHSGQOVNR9KKEwp4DSr9iSASgwhv5lQL398KBc+j8UO8+hOSTIcsGdyg4i+K4Tqdum1lT/uUnmmKN1fXNdPkLft+O/Wyv8VTI1TF6q/4LpHInbdBOin8jjG7EQoy7ENbs6GZHSPdPYMgO/x/hfKlo/zI+n8k3Q8rpT3kQ6G6vlLkJZVwxIn9I8lFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afDnWx7KDSr+HSL4S8p4GAQRhSMVUXfqMhYDI8im7Bk=;
 b=F1agSBKeDtQ+8j644BER6KrRp5PgrE/KEeLIKqBuZmq+v5zoSuAT4WVU8y4nuURc/kQq9OUDd6k8JB6seuwTrlb7orZ0RFrL3qqWViQ8HsfS44AB+qRaQFXIE+fU5fQOgbCIdpziSJmgLl60zgPAawBRr1GNUq66eWMFK7YKQmCXJY9X3Y7TXISlvKwUUyhSr+PAsVSBMymLV0H+f76MBdm74Ck1cV2s9rJe+TQqMWke0lRm6Z2mzL1tWyc7voIscpnSE3qw2W+YIgh5LXEm5QR+tKJGP+fU6sIX+0AGrQ7eVph5ndnKrZ7dz/dSzTIMD2KjHi/mSoSAcUOUiJST2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afDnWx7KDSr+HSL4S8p4GAQRhSMVUXfqMhYDI8im7Bk=;
 b=K+97/8exGKqyisYIeLWqwOdNX05zh8AWo9qcfmdDVNGt7dLAmpZbdiYIwiM2P6aWGvPXiMskr14bISNYJmAltBCqxTg4E+JDV1wcysVH7ZamsKqiqHtSMhV2DAwcVRByHSTATF+4sH+kie+yy+bpBHfh6/o2BGbf59vsk8ZUIfw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4151.namprd10.prod.outlook.com (2603:10b6:610:aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 01:16:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5791.021; Fri, 4 Nov 2022
 01:16:37 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oe-lkp@lists.linux.dev, lkp@intel.com
Cc:     Rik van Riel <riel@surriel.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] selftests/vm: update hugetlb madvise
Date:   Thu,  3 Nov 2022 18:16:32 -0700
Message-Id: <20221104011632.357049-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdfb4c9-1c1b-40cc-f456-08dabe023866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHJ3dpnS6tcw5tZiYnbrhVLmnqee8QyIjN0IKFqiP7Mn0gCvMMANwSjxyhXxoYTO4hO0bzGY1GiGIeKQsP1EKdOXx67dGb4XcinStHP5P/qEfcbqmZA3/KVPhQzJPFvKCzUx93Kp/BuksL2Z/uZT85dvSev3ZSa1omdjaV9Kr1iDx5WJq7jo2wzIlAWhvbltzjr0mUXZN1c5c7SM2773A5V2nLpiQ+hCh/nrW9MJFfiIKYD7RkXUj+pzsnz+KyGk/h+5PcoyFUBc1hJUYV3krj2jkr2YWl747XMJcCdtrvP6S/QWUCX5Im6J2cBqSTHemZeh+7VbZeQF2DGXkLscqZXFeCt46mTyO4wEp8bmD+dF9gkSBMLm5hdhyidfZ0aflLqgNw3uPAv+hVnA5lg9qD6X+aXq5T+VAu6sZ7rloJS7nOPvccdrwO0aADwSLhUTVug8wRgSLmPT3w8QAqtY09nsnTs9Yl5DRmgvXZB9jq69ZyYM2IlTRJMksZsWiauZZhubenpWsJ5/SlpopyC/tZHcu7xx2HuBL16qqx3oAqx4RjDV3a5Xir2JDOZduw3oRpHf7Z8d2YuGi41e7CXxAgo7nBTtuNvUVajhDAcTfjtSnnhWb9zpW/JD9ss3rYk0R3jylEc8I/Oh1zy0ElBlZJWuPwo2uv75iRtNTayGRs2dXB6VHMrlcUg61RhhdXCQ82nZhaIhhstM2qQ8risrUUS05M4ptA85g86fazXeFoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(2906002)(15650500001)(44832011)(36756003)(316002)(6486002)(966005)(66946007)(83380400001)(41300700001)(4326008)(54906003)(8676002)(66556008)(66476007)(5660300002)(8936002)(478600001)(6512007)(26005)(1076003)(186003)(2616005)(38100700002)(6666004)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NKMCnK3WBf82+pLxXicH0ET2TJ/mN3TxGA+OncKjQQi6SyNXVF5Ii4QlD9j9?=
 =?us-ascii?Q?wpNxaZmWWqUafdCzvNt7Hs/7zEplL7D5CPmUxxNovYxk/iqx4BHhAx7ZfVQo?=
 =?us-ascii?Q?oG571kprS9IFKmbyit6AKYHYvsOVBkItDn87ynENDxAv6oFcEJvcTMVGpiMO?=
 =?us-ascii?Q?25GEZ/CbWjOLdGiVAuJ5G7qHhxnvV5w0C9g83J010MOUgoJOlOdGL0CwIKtG?=
 =?us-ascii?Q?/MUKS8+a4CyFF4dj6/4jhTw4cwKuCLrBdVM+kdPnJe3yFACJcns3/9TOTJsY?=
 =?us-ascii?Q?ZgjvgzDz4NIYbvZkJukBXedjPTnI7w9gZB2oo/RW1Abnh2Mgn3iWa4pdnL2X?=
 =?us-ascii?Q?hJwzF0ysx9StWGv+iP6Yz9aRwakGv5ABS0EdL62l577vc0QgFP3HSwIMOg3s?=
 =?us-ascii?Q?gKbLrkLI8NhveAX6UuRSD2uLGNPEpgz9fV6WJtDa+DXWqDoigua2h4RNKYbj?=
 =?us-ascii?Q?YONArYP/YckroFX+RLRETgLbOIlWQNWDyC3M2/Qgg3OixqBDh/qyJ2ZaZXZL?=
 =?us-ascii?Q?a3jXri8GBwck9ErtrQs90dY33MQRbI6ogagvqkYg8P19eK3MwczoVsFuI5FE?=
 =?us-ascii?Q?lhgNIcnLPk849MSARS5+WUaJliUT/0A5DtXk5qQh0J+bNdlNbLt+UR7gl1ej?=
 =?us-ascii?Q?i6L+cqE9tAhN+RN246v9Q5BBA34zGFbR5bqWSnJBcRgSbGvb2qhlhXNZFNq2?=
 =?us-ascii?Q?9IThWY29G5LB6hKIH+LLsTSIL1NRLTMqoMcvj5i0lMoVcXJ+Yk3TR40I3mwb?=
 =?us-ascii?Q?ct2w/gnH1JxbtD2qtPyHWzzMSq5TYx1c6HL2/NP02soZwcLQgFVPqeGRJeC+?=
 =?us-ascii?Q?rELSGwaejxcKjbDuNYtVwmmxQCGM1hU7y+YvFCx1sIbWXjwDszVYMoMRnp8V?=
 =?us-ascii?Q?uK+CkXAXIwRuAWp40rrOGsan1FuQh3+U8EhIC6XltOLtCZ1PQIy8Qx2j1e/E?=
 =?us-ascii?Q?IliHT+7sGlhGC4SNllkcpSCPRPav2OBNpAPwZiZASn4prti68xLQz+KN/iK6?=
 =?us-ascii?Q?n7MYVS/KN7K0j9mUjCpxxOcv5wPLQ8rEB3FFNyqr/4fA1hqgeBAKKMgUthtw?=
 =?us-ascii?Q?h2GEYMPAJ6oSXqYcSOXEKH0awweoiA8XSPArt37gOn/pN8d4pk1x8tSM9FhA?=
 =?us-ascii?Q?q1uhbD5CRIKVYAbCQcsza+67F3L0jl6kUcfznet5ZUnd6AmmK8pS0C5xPSV1?=
 =?us-ascii?Q?U0YsmFDMGxlQrzh6rB58SAVEa8TJYwmrkQbPjq+vSOY9lNgKam4QTSGRwLrv?=
 =?us-ascii?Q?COCb7EoHDLShNrcLvDD8+RUDTbMpscnYMMI2Krl7ZHeU5bsHBPunPoMD3yfa?=
 =?us-ascii?Q?rYJpxOc4DaphZ/gCrC1SpSqLWRPeAg+ZPo6rncFJNmXr+3t542H4v6TQDhJD?=
 =?us-ascii?Q?Iej1P+XEBNoIHh2hK94fsWxD0KVOdOIcMggY7Fkxbc/fkVUs4FgQWICkLs3A?=
 =?us-ascii?Q?qBj0nBXaQZjAp7h1Jbb1n2BoyvR43djZw/DRAt3gqyfFOL/zYkfqUllIs+wK?=
 =?us-ascii?Q?iab+F1TPup5V6ZVd8I1+DB2X7L+CeFNUCUc9SnbadjMMtfmPltS7VqurGTS5?=
 =?us-ascii?Q?72GjMoz4zDAsUVTjd1MWGep/jTGL3cn/cME8VCYt7jX7yCXZ6kQwy+jtKgX/?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdfb4c9-1c1b-40cc-f456-08dabe023866
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 01:16:37.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DglfjAGe6oB5TcFeeZv6S590/l+LdVwrkaDP0r1NV+lz/3jcea7pYmMlzY67bKl/wlWanbarcfq/bgF56YZlIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_01,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040007
X-Proofpoint-GUID: u07FZF5WFJWHk4_BU4H2p86JmJ1W3c2K
X-Proofpoint-ORIG-GUID: u07FZF5WFJWHk4_BU4H2p86JmJ1W3c2K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8ebe0a5eaaeb ("mm,madvise,hugetlb: fix unexpected data loss
with MADV_DONTNEED on hugetlbfs") changed how the passed length was
interpreted for hugetlb mappings.  It was changed from align up to
align down.  The hugetlb-madvise test explicitly tests this behavior.
Change test to expect new behavior.

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202211040619.2ec447d7-oliver.sang@intel.com
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 tools/testing/selftests/vm/hugetlb-madvise.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/hugetlb-madvise.c b/tools/testing/selftests/vm/hugetlb-madvise.c
index f96435b70986..a634f47d1e56 100644
--- a/tools/testing/selftests/vm/hugetlb-madvise.c
+++ b/tools/testing/selftests/vm/hugetlb-madvise.c
@@ -195,7 +195,7 @@ int main(int argc, char **argv)
 			exit(1);
 	}
 
-	/* addr + length should be aligned up to huge page size */
+	/* addr + length should be aligned down to huge page size */
 	if (madvise(addr,
 			((NR_HUGE_PAGES - 1) * huge_page_size) + base_page_size,
 			MADV_DONTNEED)) {
@@ -203,10 +203,11 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	/* should free all pages in mapping */
-	validate_free_pages(free_hugepages);
+	/* should free all but last page in mapping */
+	validate_free_pages(free_hugepages - 1);
 
 	(void)munmap(addr, NR_HUGE_PAGES * huge_page_size);
+	validate_free_pages(free_hugepages);
 
 	/*
 	 * Test MADV_DONTNEED on anonymous private mapping
-- 
2.37.3

