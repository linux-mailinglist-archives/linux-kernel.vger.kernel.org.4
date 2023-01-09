Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297336634DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjAIXNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbjAIXNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:13:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7741F3B93E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:13:40 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309N5x2r032724;
        Mon, 9 Jan 2023 23:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=lfbQckkoJIIjZmYOfddCE6MY8KyP2sezfW57rnsCmfg=;
 b=QCL/C2R3dLZjRvPkAan2qbCTQpHVEalthF/4DIhAXpXat57D703J1W7TINfGA7vS79Hy
 l/qILuW2lbUulU/Ek0vfElDWsb1dgDGXC2Fgsv67y/T0lsCwpSIqd7U8dlTiojAcYR92
 Xzggk0KK4qjkWNDPjrcj08gIxiEUjoBhNnQdkyD30Kzl6NDWM9zSLvo/V8GvCkAmk2KD
 5vkI4Q+XxbgEvOGCiBLR6PRAlA0lZ3p9jKWx2O0EISSvg0n/K3ZpiUuiF5R6JsJeTp/7
 uMLI9flv2pgVqQG3myX45CzcX9jCbEC9lF4FAcEFgXvjPuCvACX8N6xi0BZgAkjXAPkN Sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n0uc8g3dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 23:13:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309MiK61013261;
        Mon, 9 Jan 2023 23:13:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n0uywru7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 23:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwttEC3hLZPtNCKeP+3HM6xUhaZzBNlhH0VpasVmKMHRyY6or/SCglzSx9Rx+ZOeg912dkUQyDR6eS+OnUS/ljdkH9zGFBKx0QLpQ17GTQKUDG5dP0sAXm7de4RJs1u6kkWLrqLyKJYy/e+0rR1wVgsHnPRj5WB4UCe33VHzfwP1f/QOm73Y90XSbBTZyEeL0jyIiNE4Upi2S7HyKCz/YIWJJrd4ZaLeWiTA0mS9BibRvSBiIonw9HulZAWx0Q9UL0yphpqyjSiHG5O8vfL1n1tYCb1ro5/VEVvsNC5On1W9aiz97wEyvZXMvwQbuLibcqTVkTUn76WiIfe/t79pfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfbQckkoJIIjZmYOfddCE6MY8KyP2sezfW57rnsCmfg=;
 b=COosPXLe9xWc8Zw4mb7S83OxipLZX1ux1rMt3ZdT2pwS6FgRpDdLY0HrVAKxoFbXX2Dqgvu6RjkUYjs6s1LN2LWmNIOzGNU19ETHIGRiQq1odK/7kRUmkGMPC6zcH5EYrc4P6ApL3xafcqoMFOG+xayzQM8D9R/Cx5hN0gmgzGkrlW+VO/OnYyjCMruBLJ4VvH2Gw+hRhHseMsirb57Hg/fVbecqnaHyZrp0QU3ceEi/bz97OY9QtF62v/SmwV2t4R/tEcSNEYPmmLoBnKTM+uLuDWtm1IU3/g29sQGr1IIWiEByUty59ekG2l6b9VqZ/+DlgHLkzFN3PAnmeW4GEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfbQckkoJIIjZmYOfddCE6MY8KyP2sezfW57rnsCmfg=;
 b=viLWpBotXHxMct6U25VssBvF305V1SSqAxo6hGUicpYLFk59AkTtl+FwYx7dg0XBvq6UJIqf/63CsM0oslltACJWYN2iyDMNNGdsjuD/1wkyu9va7YfsjF5Rt5f6xfKSFGxbarGMtfueLWXYc3tryG9qDA4Uri2z6d7fSTbpt+w=
Received: from BN0PR10MB5112.namprd10.prod.outlook.com (2603:10b6:408:12c::22)
 by BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 9 Jan
 2023 23:08:20 +0000
Received: from BN0PR10MB5112.namprd10.prod.outlook.com
 ([fe80::8519:3291:3e72:f6b3]) by BN0PR10MB5112.namprd10.prod.outlook.com
 ([fe80::8519:3291:3e72:f6b3%6]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 23:08:20 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable] mm: remove the hugetlb field from struct page
Date:   Mon,  9 Jan 2023 17:08:06 -0600
Message-Id: <20230109230806.910287-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0052.namprd18.prod.outlook.com
 (2603:10b6:610:55::32) To BN0PR10MB5112.namprd10.prod.outlook.com
 (2603:10b6:408:12c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5112:EE_|BY5PR10MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 47fd5bbe-c9aa-40ef-bdbc-08daf2966650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6ZlmMf/XlUrLxA0oCVGz7lEY/yd6GKBFuWtEBqnwi7UtSAWqiNEi1OOfi+6RRZ30SnpT9yr33LcEh5FkHerkah34ERczfreom6ITtPOVOnTv2bhwpnbHWAfG5N0oxIUUDeKaTjsS+uHo/AsN3CzWtDg8An3chl1mnRgm6xnx+yqyqRLyNcGBzUbZv0wxCWUet0IXWUGOt9PNRYEmI02Tcj9CDm5+iEEF/AwMf0KXa2XHaSMmyw+cwBwhYbzX5V3nTswRWcfeixMAqQC1VHCVWTFnMzjkaMxGpCOn7auJfJzsIiEqR5ZExRgvIAW5LHWJKg18j4P7Q7VrSHM5Q1bB8gbgMQwIjxuYwZVkmGtZbV3unos7R0xFdaxeA/X9GNAurlc4fh2Wt31Pttad7cat5j5IArV9S27H7gsH/CJCUAsigveRmgSOijQeBy2TCIsWw+21eBRHRD/CRr5ISHqTtKM6LuH5P4j5TCHLNoObQJRpF9eOzscYG4DWUZLuBms4el2PhTChl3mLx+kSy4vYtK0zAQ3cDWF9jGRpzraeeOAiI2QOlLdkucViXeN6Gy1crRXs09ElJc+w0n1K0lC5okPDPjydor6JxmNgiKkXfPzHCecSfprTP+mTqr7bIpEA9DUARNPiEDQk/20pcl+OzE7+XTME7SdRCYYQFTALuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(38100700002)(83380400001)(86362001)(44832011)(5660300002)(8676002)(4326008)(2906002)(66476007)(66946007)(66556008)(8936002)(41300700001)(1076003)(186003)(6506007)(26005)(6666004)(107886003)(6512007)(2616005)(6486002)(316002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KM8HLqkOys0wrdvXSJm26+kcl9mRxJEYC4B6zAji3Y0wDQLguTIBwuNPS6ug?=
 =?us-ascii?Q?G6P2jDw2CFwRnn7Flt2HOVCf36gcAGbkpnIccuqzsDM6jwoh740s7bRUKHa3?=
 =?us-ascii?Q?T5fMncs3m/SnJqSKPsBeOO+9n6kfReNQYMgEfT8kg8Ns4Sna6awgLam1ellN?=
 =?us-ascii?Q?XNUKKpsMVbUhonBj3fMbTMP4MK3PpVrSNj8vw65LP5tK68gs8AEy9iSY3SRH?=
 =?us-ascii?Q?SBGGiO+zLkjjZs1BNjL/zzvczD/DHS8ui+FFEURqmH4KwpsrnwF8EtGUSSul?=
 =?us-ascii?Q?KEe2S8yP4ePJoIsARJkhBJAiZRrsq2vPcaqwMWylguSx+gDKycT/8bj0kMye?=
 =?us-ascii?Q?nEACj/EIlpbLnSLFLWkhRQ0zMyV5I0zT2wfcu4waCB9+EyaVvBnRGIL/xo9J?=
 =?us-ascii?Q?L8mh496FogJ5cPLoTEg/ly4391P1xTHAhEpI4/XYjMj8JBGK4PD3R8J9HXQV?=
 =?us-ascii?Q?ZnH6r2/iypvrPczhD5BuotCfIYKE/w1vA/gjU8a9SG9ANTUM6p0AM37bjB0x?=
 =?us-ascii?Q?wNEjKux9jvITIqh4Qg3mzfCjZhZnUL30dfuDCX15uNzYmbrigV2tsp6XLYo5?=
 =?us-ascii?Q?1kN3g/DQVP3+H0mi4MZPxNj91BYRKjlja8rsTfJPOjENm1dquWv3DJ3W+Pff?=
 =?us-ascii?Q?nHMi/gImwMy+Q4e4R1nULOjK0TOF6VWZzxB3/etZaJnMveKKvcssR3xIudwG?=
 =?us-ascii?Q?89jXg3T9Mume+3qqjV9Zlzfhf92uAx33lky/jWyHwbDbchnE22rDJGyZMsTJ?=
 =?us-ascii?Q?EtDB+iVeqJ2KLulc0Bw7ACijZ5Hn50DnIZlt+a7C7+5Pf8kW6x6F44mnbxqq?=
 =?us-ascii?Q?1Lk48TXrTjoZk56lqCVMvN0XzQHrRwCNVyu8O4dTxOLQDX6iFk8ESUMQ2EHP?=
 =?us-ascii?Q?xFDn62q1I5kZbWMJciLJlSTz7tExRSL1RD/Z48mIsU2xCrIPRpmvSxiOVDrm?=
 =?us-ascii?Q?kNORKDN8txMkAureD72JYx7YAsGpedeCD2f2nzCfkHr9yG1e5iiDOOS/1Fyn?=
 =?us-ascii?Q?H92wdnDvFK5oxp5z2GUNpjjYvFeKtIIP6jm9x3ZS1q2i33jTwbzK+P4iR1Cn?=
 =?us-ascii?Q?iy1818iL5xYE9LncblpNI6NmNoYEPOvt5Zj8c/aZ7SK5qGD5wBJV5qln+Dpf?=
 =?us-ascii?Q?KBg7NaQzjbGJ8GjCFzAfawkKAg6zITVLLATrARuZiCDayqGIUMlql3oSrevG?=
 =?us-ascii?Q?sbpmvw7Y0dtZjaaCinx+MhlCDkmQQT2LU55VkDImEMfZWxuL+4oHnS8HbZ3V?=
 =?us-ascii?Q?d65qhj9yZl8egEcD1veSMZqOzZXfuv4ZhA83avNrxU0fsyym/Ru/X5F/VdZq?=
 =?us-ascii?Q?HLP2H2hco52UtA38vKYGbWaipqGNXOIN+Y0Josd2zMyYeqR4JgOBL/TiBLPB?=
 =?us-ascii?Q?br4NaEei2Owwdc47xVsMqR5cwH1o38WWo5X2xqWZtRuG3gdOyVEJEGDZxaO0?=
 =?us-ascii?Q?P5z5THxEzOu2tRioO27NhKY3T8BX9JhH/214Ft/7KFatR28yBVupeLtpNrek?=
 =?us-ascii?Q?IC7dgoD36rb2SnFBQ+guWWtin0UHDL5SpOKYXnwB4UT9403MDrqFOXUiA9LX?=
 =?us-ascii?Q?xk0H3KW7iJ3bqRJVbYQ1hU5WuRv0HQMDC4uzTH4M83nGn3aGV5AA3tTMAbCv?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QP4Acu9nC/dljVmcKYOeBFXsplTf8Uf9lxpIxr49bOzP25Z4vn1Nn9SDAoqBtGIsAiLePDfhlDUY5VOoomAmy60Pxe6HHaWPDHOqIwCzM1n5JZcYhYwOUMfau9gjomMjxBbBbjlib+jx0g9UDl9pS0xTcI03aK/kGOcwB6qxoCPBju2mdi2jKi/c/prrqqOehOSl4I8vtwM+FWs/O4JOL0D8PfJG36rNDq/pTHuO10ICBXyPVFz5Bi9bOPJsek8InmEkKizelzWyCvy68fCMK6TfR5S7MUDmtYJ8puyToCppp36MZ/7Nd1ZPdMq2Pj634/TcfTkc73aGOf21T3EtXzcu1e5lkfvesmNBZIM/nQmqB8dznmvBf4cie9G2kRFZrJh6Sd7e6hZT1bA/4iasb/d72xMSkWVkbobu6n63cd0M48tDBTXHn6H4XTcLIxEFCWFJw9bNVmg2DgMNZnHKXBlXXAvf6NWRvATaAwdtcgG8HN6oNwjMW39xxWiMZ9637TKJ72BAm6k2GJAOzRKdwF6ujZjEaeL2ZVAQuWxzzN0AITwtEnVJS1cMKzmPn52S52/4DuZ6LdF8SHXkdsaGHRigN93sU7IMDq3rS8IURDqIpwuSio2LnumNyAnVUlsG23+esv556PM96OTAVPvNGljsfZ/cbcufQ/r8gQQZLtkDzmcVTjReGovKKRbdbuyHljtAW8JxYoCIXOm5gTeNsPgyJsjIjfrt69zMKe8VRKKfzRKBmOlN8SNE9nDcpOzj+GxWOQfxJUPR4Naq2HtdGZfg+uolsGPcIjAHc2al3MVXe5GZ7P0QBcp6XIixHtfzXKF+ml6NuxurKWiJDJQql3vSWI6FyR0FYe7E7DmMiMlO+6TBJ6nJAOi8jushf4ZUAf6ZcMTDm45Il/XuhVq6ztvNLQSMZ8bD+Kt9iguI9NM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fd5bbe-c9aa-40ef-bdbc-08daf2966650
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 23:08:20.3648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0So+MJEaBFRYY+jx8ivoI38y/+d8aw8U4fAU2LYvgvvQEnEUbiFcuBpj8KnGJjACtSp9H7YXtdkrXyy4QJevlK6rUGLEP/OWTn8HOPTD9Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=991 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090162
X-Proofpoint-ORIG-GUID: yPL1uJZvuLqvx4G4k3xc0LC-xPwegqMu
X-Proofpoint-GUID: yPL1uJZvuLqvx4G4k3xc0LC-xPwegqMu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit dad6a5eb5556(mm,hugetlb: use folio fields in second tail page)
added a transitional hugetlb field to struct page and struct folio to make
room for another int in the first tail of a compound page. Hugetlb folio
conversions have changed all page users of this field to use the fields
within the folio so struct page no longer needs this hugetlb specific
field.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
This is rebased on 01/09/2023 mm-unstable plus Matthew's series[1] applied

[1]https://lore.kernel.org/linux-mm/20221231214610.2800682-1-willy@infradead.org/

 include/linux/mm_types.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 330d2f2648cd..456adae75f74 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -147,14 +147,6 @@ struct page {
 			/* For both global and memcg */
 			struct list_head deferred_list;
 		};
-		struct {	/* Second tail page of hugetlb page */
-			unsigned long _hugetlb_pad_1;	/* compound_head */
-			void *hugetlb_subpool;
-			void *hugetlb_cgroup;
-			void *hugetlb_cgroup_rsvd;
-			void *hugetlb_hwpoison;
-			/* No more space on 32-bit: use third tail if more */
-		};
 		struct {	/* Page table pages */
 			unsigned long _pt_pad_1;	/* compound_head */
 			pgtable_t pmd_huge_pte; /* protected by page->ptl */
@@ -397,10 +389,6 @@ FOLIO_MATCH(compound_head, _head_1);
 			offsetof(struct page, pg) + 2 * sizeof(struct page))
 FOLIO_MATCH(flags, _flags_2);
 FOLIO_MATCH(compound_head, _head_2);
-FOLIO_MATCH(hugetlb_subpool, _hugetlb_subpool);
-FOLIO_MATCH(hugetlb_cgroup, _hugetlb_cgroup);
-FOLIO_MATCH(hugetlb_cgroup_rsvd, _hugetlb_cgroup_rsvd);
-FOLIO_MATCH(hugetlb_hwpoison, _hugetlb_hwpoison);
 #undef FOLIO_MATCH
 
 /*
-- 
2.39.0

