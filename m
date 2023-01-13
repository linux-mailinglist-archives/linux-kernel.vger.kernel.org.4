Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59CF66A5F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjAMWcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjAMWbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:31:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F6876EE5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:31:45 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DLYhXA015860;
        Fri, 13 Jan 2023 22:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=t+cvMLTPBSJVaKyqZq16czoCTbRPJGAIrZqEk13/WdQ=;
 b=BkMwvgpkHMHYZs60YEuxguveKpDekLEieUkqDY63SGcGS6MHu7cbaqMwkGNe7Gcy1989
 VJukAQ/lIAb6GIEo6mXCWLbvrizCc8hlK7NUUH6vQCbixIdn/mPmhXN7T1bj91pw7Sy6
 g87ZaoICW5FLYpeQqHNtzRLPrFeyDtHlOcUtpHEkYw8xDXXsK2q77A+MTvSUU55bpugp
 xyFUku/a/6ZGSmdLFeglBk1IZH9njIFIUswikzKOYyzZh9uA2tjh5L43azDo2p0IMDA1
 EAovBQTGnMrnFmTGM4dx24LdNshJGmM4nnuJYdKM0+jWvZalB221bPIgiCjbH8bNZgun 1Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3av80ph3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DLJ7X8031512;
        Fri, 13 Jan 2023 22:31:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n3f3y20wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUdOFVYAKez53r7jPZAOY/yzSkob3k6/ywTazpL5AkFsA/pBF1/Ceu4fWYt4frMMaexWrocc5KeBI0DJOI8TPRcDCHjMhJaNpalXBoAENxhflJDZ4qCPTqRCrz1wvNRZ4L9EC564sliEMex1xoWoJagijAONO1+mzsRep7NDgLjWeJmaAL9Q6seINLsoBhb7Nb7xAffIb+Wb3U19g3qgSkaJOaU9pcrvJKcfijDpCuwxrX7xTALuCtoQ0wC90dGL1Cgh+b68/0tNEEkQai+wrqZC0Qi6W3LWGl4cSBKJyj8J29D7XR50b3jzhgiFpo72a++nu0aR6beFykP6l7AP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+cvMLTPBSJVaKyqZq16czoCTbRPJGAIrZqEk13/WdQ=;
 b=hWtI31Hp79cZW5pBm8EinHumPN3RAHhe8t3r2D00LiXlafjabCGemNn+jnt6+zYHucLX/2KeUo/7h3yDXWuK904EjHdvqjS8mdqtlcb62j1J1KrlCaezbO+WxXN9zbSQeZl6FB1QOobVlgDjcyI/9HV0FbI6zIiqVY5FzeXuy2m5gkax0guVWzoMw8BjGxwnJjw/HPkN62UxdGP1Ow9oBp1NQIk3TiWzmjo2EuaLbQGIUvKvGfiTKRS0W3FR8sHYKK9GO6NBjzc5V0kDdVTV9rUawBeY+sPrXFaJ6x0QBVbMvBB6dfMl1djPcIpd/fKGSENE1KmNoWVEXE+Bx4XKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+cvMLTPBSJVaKyqZq16czoCTbRPJGAIrZqEk13/WdQ=;
 b=cMGE4ulwxFlGnDlBLqZgf7xwdKw81CCe0eta3LHP/siB0FKuAmz2ujrui0bADS8+Jun4G1XRbgcq2CijLeCMm2l4+9E+fjPRxd4gBn4qfFHwAvLJgPmE5619DbTZiyWl+wvG+/bf6QrarHdF1k5nfSNkMxzd5MplAowxAYw8WXQ=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 22:31:04 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 13 Jan 2023
 22:31:04 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v3 1/8] mm/hugetlb: convert isolate_hugetlb to folios
Date:   Fri, 13 Jan 2023 16:30:50 -0600
Message-Id: <20230113223057.173292-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
References: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:610:4e::11) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: db1858b1-774a-44a1-624a-08daf5b5dadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UbRuZBdy1xcpq8yRSO+qqYaVg7AX0hFLRmnhC7tQDKwpdpOtjKx72SfHlX7ACovXPv22khdvi4IRoYFzJnORytrFhauHJ7ZZzTrUSk9hBSaHhptwIU6Dvd9gGcZdrhOTOUAPnJd9NctsuZPrJuej3xOXb+jLla4xP1B37FfXu9tIChPFEkWfPATNYDyNCMqSI5OpEQIO/pb52waG4lxz1dqrQCYdFp/N3JxNqnaGP4HHNYR2aFhK8Dm4OkqIBARkQKuAhAyGGK6nC4hVu3iSepeAEunkX2mvVjitniaGogBk2pXtnrVchmDSL8Et8McpXbxCmk71/sCJ55EIztDbs+UR3bPNt5bu4YyQz9jKl8i2nYlBOyswqZs3A4ViHmYXc2WUDUQw9gLAvQoM1uk+bbTjl0UpJlVzzkHQrkPmkAGrxgb0aRiBCu27SntiOlK4jtk8HM45P+bSFH2H4C7T4wcxNE0eRo1THeEwutqeqxfsMgYRpwQXHfgsoEQgsK/9jiXYZx1OI85tNYyvRd2QJ2ftBh77fsKo9nlssHdL7cBUzidG5dmPnjCZEa35kFgHupmbCbNobGmdk3kqzMHeSoTAy+tnvm3sk42jyulfkcLTdFnLMA+ZR8z8vSVMf2DOW89/4LwJHXjt5uuS/KpdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(44832011)(38100700002)(86362001)(2906002)(41300700001)(8936002)(5660300002)(6666004)(107886003)(478600001)(6506007)(1076003)(2616005)(26005)(186003)(6512007)(8676002)(66556008)(316002)(4326008)(66946007)(6486002)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xfn+H1Ao5WoNGwaQOUABfOEPzn8MZSAZrkuxlgJYtoZ3EWHKm8vDAakiq0jU?=
 =?us-ascii?Q?72t4GjTJFXr2rHktnol5gmpQa8apSEILL2saaOHEKV1QYAgC3whkdNaBpPfm?=
 =?us-ascii?Q?g7v9wU/mtsBbg/i5zTIC+SK37yf3B7kbfSu9cSDR5/FktFMIMM6Zu80lMKHK?=
 =?us-ascii?Q?RAYuLe1g3Yyk/0puwumxpkPzSGJECGybbHUeYMPay8nH9puLQUTfvV/sV2Yd?=
 =?us-ascii?Q?3yZH/mIIghLzBDr6XtcC5PHCnRohuEvN8u8Qy7WIj8jeTsUoxVLH1Mh3Auxv?=
 =?us-ascii?Q?QAMXBJmCXmLYItV4lgYPV019AnK10176uRvHbmTvpNHjq6fqUEdAw3wF/+z2?=
 =?us-ascii?Q?zVoV+l41wKHryMZ5GMIabFoFVeolIjr9uQYWUaETzanudBHjAHyFcURWMiLV?=
 =?us-ascii?Q?WvDTrirDxIVTOE+vXIYajAlxWY+PB35b2uEl1hap6AcgjJ/pyrFeBAWXrc1o?=
 =?us-ascii?Q?wJI0cI3WdjSDFdIDxUO4palN8+qeVMs1n1HA6/y4v2o8JCtDmgb6D2oXmkWm?=
 =?us-ascii?Q?qzr7AV3L77BN7JF3jgHNhLytgWv7v/I3C23ifweu3TVrhHgAQoPmEcnelMDg?=
 =?us-ascii?Q?daZH8J+WpU46/WWbv9tc7bJ0moIvSuAegJ1XpPIqg4GAV3/xgAnmVi7X9eb1?=
 =?us-ascii?Q?+uLoSrd6XciRMAtpflcxXnPMje5eKRS6LHlVKOFsV68ZRM4dq5WPGtV55Ef7?=
 =?us-ascii?Q?zACBjyieRdv15EGqpplWsHdHcBJPNkbMbLeM3myPwV6QMmrr0Najc3hZBpWU?=
 =?us-ascii?Q?qfAbHGDLvjfdVliPpN3Rpjpb+5Efq0M+1Ui4blEpG0lXH60TrWBai2jqivHH?=
 =?us-ascii?Q?fjF+egLcURnzuqLE+Omkte/42RNY8CsAXRP1HZIirUn+pKAl/f747DRDinhM?=
 =?us-ascii?Q?ShPprkOyXYmH8VapATW4aN44kJ53h9YuKq2BkpSxYDZnFkw42wsDXIHvKcsR?=
 =?us-ascii?Q?Q/z2UzHMM11lNeAtBr4JMypfI6dPIUXIeSX28AsibkhJgCNpqsLVNtgUJfhB?=
 =?us-ascii?Q?hSLOZLQf24LDuJNDKbCV7mgI4qOtHJxej5iQZ+7TttXh4qpWYhp1W+iO4scl?=
 =?us-ascii?Q?0+WVQIFw5xk3bbEfhI0XSTaqT7xh93hP6+k1CYQIWwc3/2Brt43kyE8b2l1q?=
 =?us-ascii?Q?o9X48Hru9B3UKwwCbNJEyOVpVlXs98vmeKNXct6ROoZiDhyv1uMXZ6T9+z3z?=
 =?us-ascii?Q?ob3RV+YTxxlvkTBQNJeRHdkB+d7KrWwMiH9/IYBjCVAVSkNuz1octg2r1XGM?=
 =?us-ascii?Q?Z4n/imKoFKn5+h2zxGvCsC+bcWGWCnzJmigstd5SW3GYsw65S65r/rf126M6?=
 =?us-ascii?Q?/aKNxVDTd0il/3wcLdDMBJJPdm6tqRx0bBK/1wso8eR86nnTQ1rUzR+gMssU?=
 =?us-ascii?Q?ZUfyxIoyKac7MzkYpcURzrN6GeIBUsdKDTqIHR3llnwBrY5eqsw0sAuY0PXM?=
 =?us-ascii?Q?dw7yVOoMgd7xcn2Og23BmXm5dFRBa1eItbj0VQ7wa4mvIEK+kvotstdFGUO+?=
 =?us-ascii?Q?lfaioRLiP+Xr3Aq90VrjbSuqd64nHx74oCrM+8u0gQipZUfmGF8AqJPfWYBz?=
 =?us-ascii?Q?0AaHGCLTz1c4yzV33t1vSatWfNod9JP1xrPIS65+qKnml6O252IsZ955gSJZ?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WYFbMDNTRUjn8tIuS3w/6Zr7iRdBC1xCfqcRwGBK8lnCnTser1jwKewY57cP?=
 =?us-ascii?Q?DzCKaahHsYe8b22eNhsNXb6SqopsI4+WK+kJHD1DIXN59mBUSw+2S+Gx0+kt?=
 =?us-ascii?Q?LH2f8cm2bHF86pEOBl9T8BW9Pbim3q8+WGKz5no6Nt7Yzlb+NP5FDKcXwB9T?=
 =?us-ascii?Q?/OCA/okjEuKbjkAr5WXFRx7kPWxmuPRDsQ7qZ2ulkKmD5uECbj7du5IGrU8U?=
 =?us-ascii?Q?ebesAXCf+B9/ZgBXjM81/M5gBH9vU60lq2PyV94JgIJS3fGiIH01VewfMnKu?=
 =?us-ascii?Q?t7Pft5ICN4PbaqQQPPewI/vr38E/s7C6hvSE/TQ6FP1GQZrU7LSOUfPMVl4l?=
 =?us-ascii?Q?PjHgPPnRo1T9EaUgQ3F+Pdjq22HKr75riPr9BFZzLcZcOV97oyiVArXNnRqC?=
 =?us-ascii?Q?OUsBhekVQVikDyPM6khkGNu4uNMTOTpe8rxjYyRGIGm+Hkg6OVLjaQh5Ibz6?=
 =?us-ascii?Q?+7WAz/AjNMHe/KGkMo/C/TuIuHK8QuKkpCfXuDSL0sDHY3RlyA6Zb+9+0VVj?=
 =?us-ascii?Q?3WDT1SUzSZayLuEsVoWErSCsloUvRPFHqQLMDNFZ9zQYfEIFNV/DVe9K8ovn?=
 =?us-ascii?Q?dRGjw61oMZU+vS6Sv+AiOrDwj8GhU9CS9TstFGU+9/5Pmt3Gva4kSWFILgNR?=
 =?us-ascii?Q?VLagGBrRTZ/rW0TkYUewy7YfvuUrtZE6L0ip5jkqm70cBgMXhzKSj8bqhFTv?=
 =?us-ascii?Q?9Ug/4H8hau4oucS9ZSHij73k2WN51L0u7bx3rZmhS667G+olSz79/bfDV9J7?=
 =?us-ascii?Q?7oO9f5QvD49VZwqK/slfAn+8rbxjc4X0xnEbCVHv7snlYDmIjfu3JDZcDqRV?=
 =?us-ascii?Q?hche04riI/Kp8FVe00NUktH0mAUJgqt6onwm5Ciq8hR0MI8VgljiygxjlMPT?=
 =?us-ascii?Q?Xs9LDu0I3KAZx7bWptl1KFnGnHPK/9AxUaX+A81NImqx4DsjQV1ygxLfA8ez?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1858b1-774a-44a1-624a-08daf5b5dadd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 22:31:04.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c57UxOF1Lft875HDJYChWlYmnRTfaqugZBt1iejspZv0QXXIPk2jDCs9f6RvcLyfyqq6IshZmjh2q/3xtCU4uf5KZYfTZqo1zuT348BYzAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxlogscore=823 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130154
X-Proofpoint-ORIG-GUID: xSUdV6INIKqzmjeR1zNO8GvwqaYNOMw0
X-Proofpoint-GUID: xSUdV6INIKqzmjeR1zNO8GvwqaYNOMw0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert isolate_hugetlb() to take in a folio and convert its callers to
pass a folio. Use page_folio() to convert the callers to use a folio is
safe as isolate_hugetlb() operates on a head page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  4 ++--
 mm/gup.c                |  2 +-
 mm/hugetlb.c            | 16 ++++++++--------
 mm/memory-failure.c     |  2 +-
 mm/memory_hotplug.c     |  2 +-
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 551834cd5299..482929b2d044 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -169,7 +169,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
-int isolate_hugetlb(struct page *page, struct list_head *list);
+int isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
@@ -374,7 +374,7 @@ static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 	return NULL;
 }
 
-static inline int isolate_hugetlb(struct page *page, struct list_head *list)
+static inline int isolate_hugetlb(struct folio *folio, struct list_head *list)
 {
 	return -EBUSY;
 }
diff --git a/mm/gup.c b/mm/gup.c
index 5182abaaecde..bdb00b9df89e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1843,7 +1843,7 @@ static unsigned long collect_longterm_unpinnable_pages(
 			continue;
 
 		if (folio_test_hugetlb(folio)) {
-			isolate_hugetlb(&folio->page, movable_page_list);
+			isolate_hugetlb(folio, movable_page_list);
 			continue;
 		}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0c58f6519b9a..540f33d8cc51 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2781,7 +2781,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		 * Fail with -EBUSY if not possible.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		ret = isolate_hugetlb(&old_folio->page, list);
+		ret = isolate_hugetlb(old_folio, list);
 		spin_lock_irq(&hugetlb_lock);
 		goto free_new;
 	} else if (!folio_test_hugetlb_freed(old_folio)) {
@@ -2856,7 +2856,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	if (folio_ref_count(folio) && !isolate_hugetlb(&folio->page, list))
+	if (folio_ref_count(folio) && !isolate_hugetlb(folio, list))
 		ret = 0;
 	else if (!folio_ref_count(folio))
 		ret = alloc_and_dissolve_hugetlb_folio(h, folio, list);
@@ -7271,19 +7271,19 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
  * These functions are overwritable if your architecture needs its own
  * behavior.
  */
-int isolate_hugetlb(struct page *page, struct list_head *list)
+int isolate_hugetlb(struct folio *folio, struct list_head *list)
 {
 	int ret = 0;
 
 	spin_lock_irq(&hugetlb_lock);
-	if (!PageHeadHuge(page) ||
-	    !HPageMigratable(page) ||
-	    !get_page_unless_zero(page)) {
+	if (!folio_test_hugetlb(folio) ||
+	    !folio_test_hugetlb_migratable(folio) ||
+	    !folio_try_get(folio)) {
 		ret = -EBUSY;
 		goto unlock;
 	}
-	ClearHPageMigratable(page);
-	list_move_tail(&page->lru, list);
+	folio_clear_hugetlb_migratable(folio);
+	list_move_tail(&folio->lru, list);
 unlock:
 	spin_unlock_irq(&hugetlb_lock);
 	return ret;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c77a9e37e27e..9a80d7830b40 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2437,7 +2437,7 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 	bool isolated = false;
 
 	if (PageHuge(page)) {
-		isolated = !isolate_hugetlb(page, pagelist);
+		isolated = !isolate_hugetlb(page_folio(page), pagelist);
 	} else {
 		bool lru = !__PageMovable(page);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fd40f7e9f176..a1e8c3e9ab08 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1641,7 +1641,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 
 		if (PageHuge(page)) {
 			pfn = page_to_pfn(head) + compound_nr(head) - 1;
-			isolate_hugetlb(head, &source);
+			isolate_hugetlb(folio, &source);
 			continue;
 		} else if (PageTransHuge(page))
 			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 61aa9aedb728..4e62b26539c9 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -601,7 +601,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 	/* With MPOL_MF_MOVE, we migrate only unshared hugepage. */
 	if (flags & (MPOL_MF_MOVE_ALL) ||
 	    (flags & MPOL_MF_MOVE && page_mapcount(page) == 1)) {
-		if (isolate_hugetlb(page, qp->pagelist) &&
+		if (isolate_hugetlb(page_folio(page), qp->pagelist) &&
 			(flags & MPOL_MF_STRICT))
 			/*
 			 * Failed to isolate page but allow migrating pages
diff --git a/mm/migrate.c b/mm/migrate.c
index 4aea647a0180..6932b3d5a9dd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1732,7 +1732,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 
 	if (PageHuge(page)) {
 		if (PageHead(page)) {
-			err = isolate_hugetlb(page, pagelist);
+			err = isolate_hugetlb(page_folio(page), pagelist);
 			if (!err)
 				err = 1;
 		}
-- 
2.39.0

