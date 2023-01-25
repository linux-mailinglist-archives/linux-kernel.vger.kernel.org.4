Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7507A67B7DC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbjAYRGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbjAYRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:06:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A314C6EF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:06:26 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFQCou018592;
        Wed, 25 Jan 2023 17:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=94lBh0ooEc80+xdbQs4bs4zXgqJnvhVf37ugpDePoN0=;
 b=ECGeHdceuC0AOPOkhE0mG3KO9w7i75zRTJ/c8D/ibKLqUji5gOgctae2KgCdtE+zP1Yl
 4XH2IqV5c3imG9hC9NXdbmv7rdKmHn2Ql0jDB7OgdldFJ5Kap4BXxfxWWBYl9mcj7AG0
 Xf/We5e9Mm2wPrz79NrRoasjDnWZJvko+lkw77tvnztJFyq/S8azuo23UNlrWKITYCtJ
 5vdl/HOYKbPxJpwrAd53WNP+Oj2QTkON8azhg2RnXfUicyhyNhQXqC7nWZ5jS3HlfvR4
 iLXnjoEuyEQAK9AzdsgwIIwAKd3WipWRgRBvWg+koZ2k3jHwPa58XlHKJhGQNErA+ay1 ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86ybggha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:06:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PGAI8v019113;
        Wed, 25 Jan 2023 17:06:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gd5hdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:06:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JojxX4xoAPdovAkofWLkGrDSWx1S1XOowMyCVJFE9oLbMvG7YJQs2yV3HMaLTcHiumwGjod2inLXkR5NXoC9RcUikHluDHrA57cWV2xIRuIbSkqWu3gS2bUy82F79eJbbrb2fRJOvxHgYt1fCPr/wSExPdWZLfN5nGug866hATJnT0YfPIpL1B234aruE8spaPkzrUtGJA6F/eLf5P4tuDaB9kyhRx9UPP8telvxkb1EV8qQnSE2KV3C1Nu0gMZQFroIKks2BXo8LFECH+ksTNOjAyvfCDejyAB/U2W0kG1SrVy/yn3jkUPqt2YjzPjcnNGySM4oINY8mqXraxC8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94lBh0ooEc80+xdbQs4bs4zXgqJnvhVf37ugpDePoN0=;
 b=e8q2j89Z8rNyY5AHsbPLW1Yt8GmbqZZjRpmX/CGHZijHXR3LPCCf6IUSXJ2CDwN5Jr+/2mSMburZ5XvglQ2cD1Q7rIvXU299ZWd+fSXsCCm3XdhZ2X+8CqYL7aDlSM1vRFm7fLrvnFaDDc2V1/6MmaKv8Yx4oOlO0JEzep702bZOcrizsgMIfPKQn+AoaWWtqxyXZpirH7aBX3FYDXbN9/iRBmQ2dHh1Hy/K2/ktzXyFE4uVjflIKdFANSF+josXUeHz20LJo9Uv5KfJnDPFOxGYmWPOSs0zBxagzICsQ8p+SjI4mUC6nfBHXoULVjhfMlf7+FJ/qJ3/9c1HWisuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94lBh0ooEc80+xdbQs4bs4zXgqJnvhVf37ugpDePoN0=;
 b=T+mx9ZQjRzJKe8Qut8zD88J7rFGfdFPXrBOkFt3E9WjfisvjB4hn9RpPZ1gloKS3OS/18fgbvMoyERnkEyNHKOE8tJPydglb6gZNGhxJ6S8FaRCIC3eOe+xz0Q+hHbVvQLd4RG3tTNuE1v3JBE8eAu5nLHPSND/gR2VuFepaqZc=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by MN2PR10MB4384.namprd10.prod.outlook.com (2603:10b6:208:198::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 17:05:58 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 17:05:58 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        gerald.schaefer@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 4/8] mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()
Date:   Wed, 25 Jan 2023 09:05:33 -0800
Message-Id: <20230125170537.96973-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
References: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0037.namprd17.prod.outlook.com
 (2603:10b6:a03:167::14) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|MN2PR10MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fa5dd7-d744-496c-9e75-08dafef66d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +s9eGb3d/uZ+MhhFG9PRCqWpl/kXQFJTFT80gcJRr2+KeGaWn0PMFX5lF0pux5V8eD+uMrnt+VXKa2bIVQeGEsAUEvouOeyuSqRyAO86B7Bmi3UI6eOLRmCYSa0NRxHTyd+nlAoAFCIQdfy/12erFksdGtCeofThbuqhgCyVvr/TlPiT9bLBH4Hmcu0iTg6iBhQ4+5M+HQYOGhgzye7yl7Ie0SX573oy1S6/x/2/796SS4YMmuu5F/1sP3u/ytP4S3ry9ZNGxK5xOy9iYPlOhzeeBf4HeG4/2MAHdVp5C6B5gf9qnvrLZrLYu/bB3QQQ/vVsJSvbIA4rRII91QJ6fMIkqCk3q7XssybLFHkm6q0NTAbdpuvDs2CtUUcp6RjR+RPmX1j7VpKGTJ1Kaa9wmyedcLyLDYXTRoL9H7TgQu37hDsOTyGeAVZ5LEn1M5r/JAlxfl0wReuqOCTvTiJ34vQjKV6FbiKqf8WUbVYiQSQ6eFWfVmwd5WlePg7bJY8TdIyKrbKY71j63x/stxRpAjc6cYcJ48yD5ZoyYmdsAbof2kXlG5YpzobKWr3x24z7GUwUpKuJBmePEHGAhdLo5WnRZ9ccWUXCLJBGAfcF/Rv2nLcR/Ut1aEBDJPt7sYYR2XY8FsbWFncNZqw5+OChlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(186003)(26005)(6512007)(38100700002)(66946007)(66476007)(66556008)(8676002)(83380400001)(4326008)(8936002)(41300700001)(2906002)(30864003)(44832011)(6486002)(478600001)(5660300002)(6666004)(2616005)(1076003)(6506007)(316002)(86362001)(36756003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1tr7GkweEPn6m2LC0T00DwUlLCicYEGPHsR8+x/dbhsfjK2U7ahS4x159AGX?=
 =?us-ascii?Q?/NiizUktdcvk+Sh+hUmNC0WJxX/+D7bwI8RcW+9D0ZUZ6iXZtdTQYBb7gntJ?=
 =?us-ascii?Q?iFFHWI0q/dJ/zXiND4f57AlMN7Bm61DKARznBxp6ARxYtC2ESLjLnQJvSdUu?=
 =?us-ascii?Q?wEqsME8vD4O4YALWP70/W2WcFmsWu1avHKLlLcn2h1dfkWDaB5eq6ghfIooo?=
 =?us-ascii?Q?MPsqKAkAQ0ODtLXTVkkOyYPEN7Dh6U9NHPhYVdkH7b53/cUMfaT+4vupIKbh?=
 =?us-ascii?Q?ja0UcvKA2n6w3fhWrEh523qG/eWLan1Vm+Bt3T7+NKiDBSsOSyEodEK/BWLG?=
 =?us-ascii?Q?L27httipOFKUmD93UiQWoWRhp9Qztm18ohN7zT+OTaS9cUtgEX29lktgyaOM?=
 =?us-ascii?Q?afC9NXnZlxPQ3Uhum8OEfEjs0zZPeZn1hnsGvxlIim+EiaUWgW1/nuP/WVA0?=
 =?us-ascii?Q?2MZyOO9uBk/VIiS5GoravUvwKg6k7tzBv6be7co8SVQ79gtBIIilrGhivE16?=
 =?us-ascii?Q?q9jIlqAz6TASVxUUlk64h2J2FPjycKQEjGRwZec3UZyDjZX6+uqKEBae+lmo?=
 =?us-ascii?Q?4rAwXvaw2yKihEM80fArcJqlj+dmYGpmmv1t1i+6pecW36SizfsbJNmZW9MK?=
 =?us-ascii?Q?3/EPxshoJenLti5mXR7Oe5QKg7YW0Z2zcdGJSYRblC3Vb+daeM+kxyT8fufp?=
 =?us-ascii?Q?bvWaaXAFuKaB2cxctwoZQ8yFuMltkQYl8WgNGKryJwsReV7NviFfoss3AYol?=
 =?us-ascii?Q?irke+a1pt+hpUnFp/LEdoLgoqRGuYYA9ui2fmPweQZBMv2AVzWcWijToGBz8?=
 =?us-ascii?Q?ak1F6kEshRUt0Dx30VShIGl+99m6cvP+8HSuKsHrOtQKkUIjEM0z/7K8mybt?=
 =?us-ascii?Q?OeRew1a2H5SNVPEnHm2GwIBxrZGMRucGnhFnKIwcvAtmibk90w4l3IM5GOO9?=
 =?us-ascii?Q?yYAstsTwODELAFIVXCDW9lS8uvsCvaeTzP6PkGQea0fD/Xl1wFjYBsJYrAbf?=
 =?us-ascii?Q?gDDK8NJ3sxqVLY2LT2Sv0A8cd3zwPsQMhSwDv3MDO9gjY1mXE3Zj2hwJuAzI?=
 =?us-ascii?Q?l+vpVWJMC3UEReC6VAqALUVLSAyBfNr82dxUwN1bRcqdliMBXTISMGBdfy/6?=
 =?us-ascii?Q?fzbg/K2h9n6DfxoleBV96w+qKu8KSJ5wQZscp8IXXnbSiFJa9LrURxbikHbo?=
 =?us-ascii?Q?UZMnLWal1q5VpZFBMgXL5YwNFJKIWMQK4Xq3RltD05OnPpvsizylT/A+jweX?=
 =?us-ascii?Q?vXSknrgoefZ926S4+PJOhOmw3nHrjJcf4HcTiQbQAfm6QOcMqF6qecllQuUN?=
 =?us-ascii?Q?RizroECj+TKe79Rj7zZG0d2dQntt7NAeXmswVtcWqFBFNOrm2UyxUGlK3aim?=
 =?us-ascii?Q?eEF/vaXsbjbZzGloLE/IzE3zHRS3abTg1lkpgREp8HiZSezwbcgv4MaxGKX9?=
 =?us-ascii?Q?2v3M9udtwRb3j4YVdO2YL1IhIPFa9c16EnlhIzs6Y4VVGQSHYIO/sKcJ7L+Q?=
 =?us-ascii?Q?Mrz1Tc+IBv0DTtViYWoH+fFlYgRNWpdwxji8HXVl6EEbhWR97k3idBrCc9Z5?=
 =?us-ascii?Q?EJAbdgaswDJGChYDOMFFB32wIReHz8dqACJUO7NOrWraWFbTW7BdtSjWyQm0?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Qg8Qp39NfaNeuAwGRFN/WMcH3hWtyUaVe3KU6ylRgq83zTSWgJp2nO+Jwo8n?=
 =?us-ascii?Q?sZrYpewXY9JwConYtApQRa5VvI/dNK6zcSJ7oY7mMY5Ha8zBmzwf1G/2e95i?=
 =?us-ascii?Q?EJOMUjUydmi+2NhphiyjBv6DX2mRNC1uCS+gz49+2RYI2uY5khWjhE9ip9n5?=
 =?us-ascii?Q?us1zpPlfEdCmbGxbuP8sP0niZ3lVyoB2KUpXlCT9tu0EW5NeY58XgMVLYNeG?=
 =?us-ascii?Q?F2nobIKNgfzrfG6Wv+PrmurnETgC5okUGKli8RosY5dT4ujcZwtbmkSug7nz?=
 =?us-ascii?Q?T/szycmIhUGYXjmDYonSRE8SO0T9cO/ndQRyy8HzK/AprwHNS6S31bO+ZyST?=
 =?us-ascii?Q?zZ33hC6DnNaeJZcRC0vQySbIqaeMKUZDmrkAwVVUUgoEkJAzN4EIUZ3L/F48?=
 =?us-ascii?Q?blP6vXImR69tyGVUUYrsZYuKSeS4qCthYf1VDF/Cpq582rD3RWmiinaMCV+6?=
 =?us-ascii?Q?6qF5VM8HWBSXMxnk670hCPjbxjrYTUQd4f9bMKjl7D00x9rADJIPsR517srk?=
 =?us-ascii?Q?F7iEEN8IzzbTyK5di++jBTO6gpV019gZxpN89GgSY4P1fospatC9QW4dWxSI?=
 =?us-ascii?Q?afDTCHhmbNtzkdc7jMgr0IBQJ9Hjku8wWPxxn1UiS7Mx5h0bOV2yWRT+l/ss?=
 =?us-ascii?Q?Te/MUWRLL9b7GrurUp7s1sW7J3Qwx/n1zqOj+jcCBedRRImII0r90//lVnEs?=
 =?us-ascii?Q?q++puEWpPEbFz2jKlI1gGvHfQ0oQMJgcO2OnmgwpjrregPVgUFp+Ps8RVwNk?=
 =?us-ascii?Q?lBqsuXBfuj87l+CA+tT+SSJqMqZ5nHlV1IHCM+CYzjsyVBQiNxTvmM850NzC?=
 =?us-ascii?Q?Rs+zB0bO58h8NgMKBTETkNCJLhOBsp6bvARDBVa2T6gFgyLjXDD6t5FYnX0J?=
 =?us-ascii?Q?8XtaZfswDJjdSFmqCZ13ThItC/0YgrCxshKKPQPteCVhHVbNs2zl9rNOLSou?=
 =?us-ascii?Q?B8Cvb2+sdk8F2/hzD4p0AfBDnGXu9PwNWpFpPVbdwPKGkGBf1NQKTKUHf4cE?=
 =?us-ascii?Q?hJkM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fa5dd7-d744-496c-9e75-08dafef66d42
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:05:58.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axf2CwCC05RZyPJ+dAmn4wsI7MY9I5S/GIPZ6A+DXNe/XljiuiaC6Kh8V8IwjGsW2+W1jmFFpRFN4N4Yd55JItR0TmVegGCdGGIaMYGqmCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250152
X-Proofpoint-GUID: 0cUQtaBqS45hEWh9cKhVQokPEOI8jnEJ
X-Proofpoint-ORIG-GUID: 0cUQtaBqS45hEWh9cKhVQokPEOI8jnEJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change alloc_huge_page() to alloc_hugetlb_folio() by changing all callers
to handle the now folio return type of the function. In this conversion,
alloc_huge_page_vma() is also changed to alloc_hugetlb_folio_vma() and
hugepage_add_new_anon_rmap() is changed to take in a folio directly. Many
additions of '&folio->page' are cleaned up in subsequent patches.

hugetlbfs_fallocate() is also refactored to use the RCU +
page_cache_next_miss() API.

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    |  40 ++++----
 include/linux/hugetlb.h |   8 +-
 include/linux/rmap.h    |   2 +-
 mm/hugetlb.c            | 201 ++++++++++++++++++++--------------------
 mm/mempolicy.c          |   6 +-
 mm/rmap.c               |   6 +-
 6 files changed, 133 insertions(+), 130 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 48f1a8ad2243..ac16ada48f75 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -819,8 +819,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		 * This is supposed to be the vaddr where the page is being
 		 * faulted in, but we have no vaddr here.
 		 */
-		struct page *page;
+		struct folio *folio;
 		unsigned long addr;
+		bool present;
 
 		cond_resched();
 
@@ -844,48 +845,49 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		page = find_get_page(mapping, index);
-		if (page) {
-			put_page(page);
+		rcu_read_lock();
+		present = page_cache_next_miss(mapping, index, 1) != index;
+		rcu_read_unlock();
+		if (present) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_drop_vma_policy(&pseudo_vma);
 			continue;
 		}
 
 		/*
-		 * Allocate page without setting the avoid_reserve argument.
+		 * Allocate folio without setting the avoid_reserve argument.
 		 * There certainly are no reserves associated with the
 		 * pseudo_vma.  However, there could be shared mappings with
 		 * reserves for the file at the inode level.  If we fallocate
-		 * pages in these areas, we need to consume the reserves
+		 * folios in these areas, we need to consume the reserves
 		 * to keep reservation accounting consistent.
 		 */
-		page = alloc_huge_page(&pseudo_vma, addr, 0);
+		folio = alloc_hugetlb_folio(&pseudo_vma, addr, 0);
 		hugetlb_drop_vma_policy(&pseudo_vma);
-		if (IS_ERR(page)) {
+		if (IS_ERR(folio)) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			error = PTR_ERR(page);
+			error = PTR_ERR(folio);
 			goto out;
 		}
-		clear_huge_page(page, addr, pages_per_huge_page(h));
-		__SetPageUptodate(page);
-		error = hugetlb_add_to_page_cache(page, mapping, index);
+		clear_huge_page(&folio->page, addr, pages_per_huge_page(h));
+		__folio_mark_uptodate(folio);
+		error = hugetlb_add_to_page_cache(&folio->page, mapping, index);
 		if (unlikely(error)) {
-			restore_reserve_on_error(h, &pseudo_vma, addr, page);
-			put_page(page);
+			restore_reserve_on_error(h, &pseudo_vma, addr, &folio->page);
+			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
 		}
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-		SetHPageMigratable(page);
+		folio_set_hugetlb_migratable(folio);
 		/*
-		 * unlock_page because locked by hugetlb_add_to_page_cache()
-		 * put_page() due to reference from alloc_huge_page()
+		 * folio_unlock because locked by hugetlb_add_to_page_cache()
+		 * folio_put() due to reference from alloc_hugetlb_folio()
 		 */
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1170db8e7831..f6849e67ffef 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -716,11 +716,11 @@ struct huge_bootmem_page {
 };
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
-struct page *alloc_huge_page(struct vm_area_struct *vma,
+struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
-struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
+struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
 int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
@@ -1032,7 +1032,7 @@ static inline int isolate_or_dissolve_huge_page(struct page *page,
 	return -ENOMEM;
 }
 
-static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
+static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   int avoid_reserve)
 {
@@ -1046,7 +1046,7 @@ alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 	return NULL;
 }
 
-static inline struct page *alloc_huge_page_vma(struct hstate *h,
+static inline struct folio *alloc_hugetlb_folio_vma(struct hstate *h,
 					       struct vm_area_struct *vma,
 					       unsigned long address)
 {
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index a6bd1f0a183d..a4570da03e58 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -203,7 +203,7 @@ void page_remove_rmap(struct page *, struct vm_area_struct *,
 
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
-void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
+void hugepage_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address);
 
 static inline void __page_dup_rmap(struct page *page, bool compound)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ded5fe790c79..e104dba1e5ea 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2493,7 +2493,7 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 }
 
 /* mempolicy aware migration callback */
-struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
+struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_struct *vma,
 		unsigned long address)
 {
 	struct mempolicy *mpol;
@@ -2507,7 +2507,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
 	mpol_cond_put(mpol);
 
-	return &folio->page;
+	return folio;
 }
 
 /*
@@ -2798,14 +2798,14 @@ static long vma_del_reservation(struct hstate *h,
 
 /*
  * This routine is called to restore reservation information on error paths.
- * It should ONLY be called for pages allocated via alloc_huge_page(), and
- * the hugetlb mutex should remain held when calling this routine.
+ * It should ONLY be called for folios allocated via alloc_hugetlb_folio(),
+ * and the hugetlb mutex should remain held when calling this routine.
  *
  * It handles two specific cases:
  * 1) A reservation was in place and the page consumed the reservation.
  *    HPageRestoreReserve is set in the page.
  * 2) No reservation was in place for the page, so HPageRestoreReserve is
- *    not set.  However, alloc_huge_page always updates the reserve map.
+ *    not set.  However, alloc_hugetlb_folio always updates the reserve map.
  *
  * In case 1, free_huge_page later in the error path will increment the
  * global reserve count.  But, free_huge_page does not have enough context
@@ -2814,7 +2814,7 @@ static long vma_del_reservation(struct hstate *h,
  * reserve count adjustments to be made by free_huge_page.  Make sure the
  * reserve map indicates there is a reservation present.
  *
- * In case 2, simply undo reserve map modifications done by alloc_huge_page.
+ * In case 2, simply undo reserve map modifications done by alloc_hugetlb_folio.
  */
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			unsigned long address, struct page *page)
@@ -2844,8 +2844,8 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 		if (!rc) {
 			/*
 			 * This indicates there is an entry in the reserve map
-			 * not added by alloc_huge_page.  We know it was added
-			 * before the alloc_huge_page call, otherwise
+			 * not added by alloc_hugetlb_folio.  We know it was added
+			 * before the alloc_hugetlb_folio call, otherwise
 			 * hugetlb_restore_reserve would be set on the folio.
 			 * Remove the entry so that a subsequent allocation
 			 * does not consume a reservation.
@@ -3014,7 +3014,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	return ret;
 }
 
-struct page *alloc_huge_page(struct vm_area_struct *vma,
+struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				    unsigned long addr, int avoid_reserve)
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
@@ -3023,7 +3023,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	long map_chg, map_commit;
 	long gbl_chg;
 	int ret, idx;
-	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg = NULL;
 	bool deferred_reserve;
 
 	idx = hstate_index(h);
@@ -3130,7 +3130,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					pages_per_huge_page(h), folio);
 	}
-	return &folio->page;
+	return folio;
 
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
@@ -4950,7 +4950,7 @@ hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long add
 		     struct folio *new_folio)
 {
 	__folio_mark_uptodate(new_folio);
-	hugepage_add_new_anon_rmap(&new_folio->page, vma, addr);
+	hugepage_add_new_anon_rmap(new_folio, vma, addr);
 	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, &new_folio->page, 1));
 	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
 	folio_set_hugetlb_migratable(new_folio);
@@ -5080,34 +5080,34 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			} else if (page_try_dup_anon_rmap(ptepage, true,
 							  src_vma)) {
 				pte_t src_pte_old = entry;
-				struct page *new;
+				struct folio *new_folio;
 
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				/* Do not use reserve as it's private owned */
-				new = alloc_huge_page(dst_vma, addr, 1);
-				if (IS_ERR(new)) {
+				new_folio = alloc_hugetlb_folio(dst_vma, addr, 1);
+				if (IS_ERR(new_folio)) {
 					put_page(ptepage);
-					ret = PTR_ERR(new);
+					ret = PTR_ERR(new_folio);
 					break;
 				}
-				copy_user_huge_page(new, ptepage, addr, dst_vma,
+				copy_user_huge_page(&new_folio->page, ptepage, addr, dst_vma,
 						    npages);
 				put_page(ptepage);
 
-				/* Install the new huge page if src pte stable */
+				/* Install the new hugetlb folio if src pte stable */
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
 				src_ptl = huge_pte_lockptr(h, src, src_pte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
 					restore_reserve_on_error(h, dst_vma, addr,
-								new);
-					put_page(new);
+								&new_folio->page);
+					folio_put(new_folio);
 					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
 				}
-				hugetlb_install_folio(dst_vma, dst_pte, addr, page_folio(new));
+				hugetlb_install_folio(dst_vma, dst_pte, addr, new_folio);
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				continue;
@@ -5478,7 +5478,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	const bool unshare = flags & FAULT_FLAG_UNSHARE;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	struct page *old_page, *new_page;
+	struct page *old_page;
+	struct folio *new_folio;
 	int outside_reserve = 0;
 	vm_fault_t ret = 0;
 	unsigned long haddr = address & huge_page_mask(h);
@@ -5539,9 +5540,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * be acquired again before returning to the caller, as expected.
 	 */
 	spin_unlock(ptl);
-	new_page = alloc_huge_page(vma, haddr, outside_reserve);
+	new_folio = alloc_hugetlb_folio(vma, haddr, outside_reserve);
 
-	if (IS_ERR(new_page)) {
+	if (IS_ERR(new_folio)) {
 		/*
 		 * If a process owning a MAP_PRIVATE mapping fails to COW,
 		 * it is due to references held by a child and an insufficient
@@ -5586,7 +5587,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			return 0;
 		}
 
-		ret = vmf_error(PTR_ERR(new_page));
+		ret = vmf_error(PTR_ERR(new_folio));
 		goto out_release_old;
 	}
 
@@ -5599,9 +5600,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_release_all;
 	}
 
-	copy_user_huge_page(new_page, old_page, address, vma,
+	copy_user_huge_page(&new_folio->page, old_page, address, vma,
 			    pages_per_huge_page(h));
-	__SetPageUptodate(new_page);
+	__folio_mark_uptodate(new_folio);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, haddr,
 				haddr + huge_page_size(h));
@@ -5618,12 +5619,12 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		huge_ptep_clear_flush(vma, haddr, ptep);
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
 		page_remove_rmap(old_page, vma, true);
-		hugepage_add_new_anon_rmap(new_page, vma, haddr);
+		hugepage_add_new_anon_rmap(new_folio, vma, haddr);
 		set_huge_pte_at(mm, haddr, ptep,
-				make_huge_pte(vma, new_page, !unshare));
-		SetHPageMigratable(new_page);
+				make_huge_pte(vma, &new_folio->page, !unshare));
+		folio_set_hugetlb_migratable(new_folio);
 		/* Make the old page be freed below */
-		new_page = old_page;
+		new_folio = page_folio(old_page);
 	}
 	spin_unlock(ptl);
 	mmu_notifier_invalidate_range_end(&range);
@@ -5632,9 +5633,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * No restore in case of successful pagetable update (Break COW or
 	 * unshare)
 	 */
-	if (new_page != old_page)
-		restore_reserve_on_error(h, vma, haddr, new_page);
-	put_page(new_page);
+	if (new_folio != page_folio(old_page))
+		restore_reserve_on_error(h, vma, haddr, &new_folio->page);
+	folio_put(new_folio);
 out_release_old:
 	put_page(old_page);
 
@@ -5753,11 +5754,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	int anon_rmap = 0;
 	unsigned long size;
-	struct page *page;
+	struct folio *folio;
 	pte_t new_pte;
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
-	bool new_page, new_pagecache_page = false;
+	bool new_folio, new_pagecache_folio = false;
 	u32 hash = hugetlb_fault_mutex_hash(mapping, idx);
 
 	/*
@@ -5776,9 +5777,9 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * Use page lock to guard against racing truncation
 	 * before we get page_table_lock.
 	 */
-	new_page = false;
-	page = find_lock_page(mapping, idx);
-	if (!page) {
+	new_folio = false;
+	folio = filemap_lock_folio(mapping, idx);
+	if (!folio) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		if (idx >= size)
 			goto out;
@@ -5811,8 +5812,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 							VM_UFFD_MISSING);
 		}
 
-		page = alloc_huge_page(vma, haddr, 0);
-		if (IS_ERR(page)) {
+		folio = alloc_hugetlb_folio(vma, haddr, 0);
+		if (IS_ERR(folio)) {
 			/*
 			 * Returning error will result in faulting task being
 			 * sent SIGBUS.  The hugetlb fault mutex prevents two
@@ -5826,17 +5827,17 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * sure there really is no pte entry.
 			 */
 			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
-				ret = vmf_error(PTR_ERR(page));
+				ret = vmf_error(PTR_ERR(folio));
 			else
 				ret = 0;
 			goto out;
 		}
-		clear_huge_page(page, address, pages_per_huge_page(h));
-		__SetPageUptodate(page);
-		new_page = true;
+		clear_huge_page(&folio->page, address, pages_per_huge_page(h));
+		__folio_mark_uptodate(folio);
+		new_folio = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = hugetlb_add_to_page_cache(page, mapping, idx);
+			int err = hugetlb_add_to_page_cache(&folio->page, mapping, idx);
 			if (err) {
 				/*
 				 * err can't be -EEXIST which implies someone
@@ -5845,13 +5846,13 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				 * to the page cache. So it's safe to call
 				 * restore_reserve_on_error() here.
 				 */
-				restore_reserve_on_error(h, vma, haddr, page);
-				put_page(page);
+				restore_reserve_on_error(h, vma, haddr, &folio->page);
+				folio_put(folio);
 				goto out;
 			}
-			new_pagecache_page = true;
+			new_pagecache_folio = true;
 		} else {
-			lock_page(page);
+			folio_lock(folio);
 			if (unlikely(anon_vma_prepare(vma))) {
 				ret = VM_FAULT_OOM;
 				goto backout_unlocked;
@@ -5864,7 +5865,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		 * don't have hwpoisoned swap entry for errored virtual address.
 		 * So we need to block hugepage fault by PG_hwpoison bit check.
 		 */
-		if (unlikely(PageHWPoison(page))) {
+		if (unlikely(folio_test_hwpoison(folio))) {
 			ret = VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
 			goto backout_unlocked;
@@ -5872,8 +5873,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 		/* Check for page in userfault range. */
 		if (userfaultfd_minor(vma)) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			/* See comment in userfaultfd_missing() block above */
 			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
 				ret = 0;
@@ -5907,10 +5908,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		goto backout;
 
 	if (anon_rmap)
-		hugepage_add_new_anon_rmap(page, vma, haddr);
+		hugepage_add_new_anon_rmap(folio, vma, haddr);
 	else
-		page_dup_file_rmap(page, true);
-	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
+		page_dup_file_rmap(&folio->page, true);
+	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
 	/*
 	 * If this pte was previously wr-protected, keep it wr-protected even
@@ -5923,20 +5924,20 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, address, ptep, flags, page, ptl);
+		ret = hugetlb_wp(mm, vma, address, ptep, flags, &folio->page, ptl);
 	}
 
 	spin_unlock(ptl);
 
 	/*
-	 * Only set HPageMigratable in newly allocated pages.  Existing pages
-	 * found in the pagecache may not have HPageMigratableset if they have
+	 * Only set hugetlb_migratable in newly allocated pages.  Existing pages
+	 * found in the pagecache may not have hugetlb_migratable if they have
 	 * been isolated for migration.
 	 */
-	if (new_page)
-		SetHPageMigratable(page);
+	if (new_folio)
+		folio_set_hugetlb_migratable(folio);
 
-	unlock_page(page);
+	folio_unlock(folio);
 out:
 	hugetlb_vma_unlock_read(vma);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -5945,11 +5946,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 backout:
 	spin_unlock(ptl);
 backout_unlocked:
-	if (new_page && !new_pagecache_page)
-		restore_reserve_on_error(h, vma, haddr, page);
+	if (new_folio && !new_pagecache_folio)
+		restore_reserve_on_error(h, vma, haddr, &folio->page);
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	goto out;
 }
 
@@ -6173,16 +6174,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	pte_t _dst_pte;
 	spinlock_t *ptl;
 	int ret = -ENOMEM;
-	struct page *page;
+	struct folio *folio;
 	int writable;
-	bool page_in_pagecache = false;
+	bool folio_in_pagecache = false;
 
 	if (is_continue) {
 		ret = -EFAULT;
-		page = find_lock_page(mapping, idx);
-		if (!page)
+		folio = filemap_lock_folio(mapping, idx);
+		if (!folio)
 			goto out;
-		page_in_pagecache = true;
+		folio_in_pagecache = true;
 	} else if (!*pagep) {
 		/* If a page already exists, then it's UFFDIO_COPY for
 		 * a non-missing case. Return -EEXIST.
@@ -6193,34 +6194,34 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			goto out;
 		}
 
-		page = alloc_huge_page(dst_vma, dst_addr, 0);
-		if (IS_ERR(page)) {
+		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+		if (IS_ERR(folio)) {
 			ret = -ENOMEM;
 			goto out;
 		}
 
-		ret = copy_huge_page_from_user(page,
+		ret = copy_huge_page_from_user(&folio->page,
 						(const void __user *) src_addr,
 						pages_per_huge_page(h), false);
 
 		/* fallback to copy_from_user outside mmap_lock */
 		if (unlikely(ret)) {
 			ret = -ENOENT;
-			/* Free the allocated page which may have
+			/* Free the allocated folio which may have
 			 * consumed a reservation.
 			 */
-			restore_reserve_on_error(h, dst_vma, dst_addr, page);
-			put_page(page);
+			restore_reserve_on_error(h, dst_vma, dst_addr, &folio->page);
+			folio_put(folio);
 
-			/* Allocate a temporary page to hold the copied
+			/* Allocate a temporary folio to hold the copied
 			 * contents.
 			 */
-			page = alloc_huge_page_vma(h, dst_vma, dst_addr);
-			if (!page) {
+			folio = alloc_hugetlb_folio_vma(h, dst_vma, dst_addr);
+			if (!folio) {
 				ret = -ENOMEM;
 				goto out;
 			}
-			*pagep = page;
+			*pagep = &folio->page;
 			/* Set the outparam pagep and return to the caller to
 			 * copy the contents outside the lock. Don't free the
 			 * page.
@@ -6236,25 +6237,25 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			goto out;
 		}
 
-		page = alloc_huge_page(dst_vma, dst_addr, 0);
-		if (IS_ERR(page)) {
+		folio = alloc_hugetlb_folio(dst_vma, dst_addr, 0);
+		if (IS_ERR(folio)) {
 			put_page(*pagep);
 			ret = -ENOMEM;
 			*pagep = NULL;
 			goto out;
 		}
-		copy_user_huge_page(page, *pagep, dst_addr, dst_vma,
+		copy_user_huge_page(&folio->page, *pagep, dst_addr, dst_vma,
 				    pages_per_huge_page(h));
 		put_page(*pagep);
 		*pagep = NULL;
 	}
 
 	/*
-	 * The memory barrier inside __SetPageUptodate makes sure that
+	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * preceding stores to the page contents become visible before
 	 * the set_pte_at() write.
 	 */
-	__SetPageUptodate(page);
+	__folio_mark_uptodate(folio);
 
 	/* Add shared, newly allocated pages to the page cache. */
 	if (vm_shared && !is_continue) {
@@ -6269,16 +6270,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		 * hugetlb_fault_mutex_table that here must be hold by
 		 * the caller.
 		 */
-		ret = hugetlb_add_to_page_cache(page, mapping, idx);
+		ret = hugetlb_add_to_page_cache(&folio->page, mapping, idx);
 		if (ret)
 			goto out_release_nounlock;
-		page_in_pagecache = true;
+		folio_in_pagecache = true;
 	}
 
 	ptl = huge_pte_lock(h, dst_mm, dst_pte);
 
 	ret = -EIO;
-	if (PageHWPoison(page))
+	if (folio_test_hwpoison(folio))
 		goto out_release_unlock;
 
 	/*
@@ -6290,10 +6291,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
 		goto out_release_unlock;
 
-	if (page_in_pagecache)
-		page_dup_file_rmap(page, true);
+	if (folio_in_pagecache)
+		page_dup_file_rmap(&folio->page, true);
 	else
-		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
+		hugepage_add_new_anon_rmap(folio, dst_vma, dst_addr);
 
 	/*
 	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
@@ -6304,7 +6305,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	else
 		writable = dst_vma->vm_flags & VM_WRITE;
 
-	_dst_pte = make_huge_pte(dst_vma, page, writable);
+	_dst_pte = make_huge_pte(dst_vma, &folio->page, writable);
 	/*
 	 * Always mark UFFDIO_COPY page dirty; note that this may not be
 	 * extremely important for hugetlbfs for now since swapping is not
@@ -6326,20 +6327,20 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	spin_unlock(ptl);
 	if (!is_continue)
-		SetHPageMigratable(page);
+		folio_set_hugetlb_migratable(folio);
 	if (vm_shared || is_continue)
-		unlock_page(page);
+		folio_unlock(folio);
 	ret = 0;
 out:
 	return ret;
 out_release_unlock:
 	spin_unlock(ptl);
 	if (vm_shared || is_continue)
-		unlock_page(page);
+		folio_unlock(folio);
 out_release_nounlock:
-	if (!page_in_pagecache)
-		restore_reserve_on_error(h, dst_vma, dst_addr, page);
-	put_page(page);
+	if (!folio_in_pagecache)
+		restore_reserve_on_error(h, dst_vma, dst_addr, &folio->page);
+	folio_put(folio);
 	goto out;
 }
 #endif /* CONFIG_USERFAULTFD */
@@ -6871,7 +6872,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 			/*
 			 * pages in this range were added to the reserve
 			 * map between region_chg and region_add.  This
-			 * indicates a race with alloc_huge_page.  Adjust
+			 * indicates a race with alloc_hugetlb_folio.  Adjust
 			 * the subpool and reserve counts modified above
 			 * based on the difference.
 			 */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fd99d303e34f..945b41c245a5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1218,9 +1218,11 @@ static struct page *new_page(struct page *page, unsigned long start)
 			break;
 	}
 
-	if (folio_test_hugetlb(src))
-		return alloc_huge_page_vma(page_hstate(&src->page),
+	if (folio_test_hugetlb(src)) {
+		dst = alloc_hugetlb_folio_vma(folio_hstate(src),
 				vma, address);
+		return &dst->page;
+	}
 
 	if (folio_test_large(src))
 		gfp = GFP_TRANSHUGE;
diff --git a/mm/rmap.c b/mm/rmap.c
index 948ca17a96ad..e6d94bd19879 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2547,15 +2547,13 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 				     !!(flags & RMAP_EXCLUSIVE));
 }
 
-void hugepage_add_new_anon_rmap(struct page *page,
+void hugepage_add_new_anon_rmap(struct folio *folio,
 			struct vm_area_struct *vma, unsigned long address)
 {
-	struct folio *folio = page_folio(page);
-
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	/* increment count (starts at -1) */
 	atomic_set(&folio->_entire_mapcount, 0);
 	folio_clear_hugetlb_restore_reserve(folio);
-	__page_set_anon_rmap(folio, page, vma, address, 1);
+	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
 }
 #endif /* CONFIG_HUGETLB_PAGE */
-- 
2.39.1

