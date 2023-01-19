Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECBC672DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjASBLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjASBLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:11:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32EC683FB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:11:34 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmotE006826;
        Thu, 19 Jan 2023 01:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=KfD1m/lxUk2pxmFXPAi9alNjoQft9LApRNq5lDsuNzI=;
 b=AVNwSCyze6RQe02EJE0I1IAgt3pyedTX4biFVZJCpmyJusoTXR09KMnk3yvRo8Im/aQy
 vyXEYpCkMgk5DaPUHt4ET38r/md7Omvj3kaYhgTjaYqzeRoHycAGBpTDDBkipdzwudnr
 vM2CsbrWjOLCkCRJi2gwu9k92frSUrpf0v+gvOkqQ7hSW6/12z7VsLRonUe9VEytITO4
 fO8b7qGa3kcl5aaOCKudcpmvU9w/aLq3NQrGpJDUR8qKiCnLs2xocrhPXQczRhkhNVTO
 WFL5/mqNYaj8ZExACEIvgJJKNOPB8UC2mk4YzmOo1bumUY35KYO+ZXRzkC90DKrJUbO5 3w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6c91pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 01:11:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IMpfsD039584;
        Thu, 19 Jan 2023 01:11:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2tqgnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 01:11:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLI247Y1Ej8uHB0TEeTwO6EtI6HT4gEhVQ9vbFziIF2oZ+0+HxY6IIZjA9bb2YcTpGwLPjr5yTJAhtWJIBfCeWCAvq3mvUWsHPjeUlFY85gGJR073VHg9uqsYOSCoKC29xlViSKdYxomqcxwYq5Ij4FMp4R7UQlmCvjvxdqyIxosDHI7qjA7o/BVp1VPic8/QU836RTWx7fWDMBnWM8WmWBF0MmpeZ9ajuq1jZyoS4tABN+lqtyB9Ys5i8A/eoMGrwYZyVJHkc6s62rpDVKHPHimWoB3TXklo+jxHAGuBycp5eV6VPRoHTJJYqLEmFrre0a+QVOvWuV3jAgLzMgBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfD1m/lxUk2pxmFXPAi9alNjoQft9LApRNq5lDsuNzI=;
 b=A67h7hU6m3L7Dm6L2BwUzQ+Iu3sGjeLlUfVzJhnBUqfJF67KyGATcKouhiNsHklCO6KbEdCgGKxRod0Ft7UlQLML8GgaNgdTj1tejHsf09Nb8tcQcuAqf8AHkEINlgBzib9Tzjn2OfMjgXBo4OFj40bbmNNZEg1s+NQzN0kfODrrrU610gV9kt4GgXASd5QrkuC3HPyAZcl7wWdnwE8gyTtSjY/2bwnYRcHJZo9Hg1c8lAjuniv9xpOsccr71WxwjcatdShiEr6aXcKIFXPcSnpBUDaY+9JcJnXXb6t5NvECWVBJMCBN3RqvOilD7HGfMEvHR9XFgHrei8m9jBaRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfD1m/lxUk2pxmFXPAi9alNjoQft9LApRNq5lDsuNzI=;
 b=oLeI+hNPobzv1MILar3WirqC+kLRbXt0vsmQ1MrdMYsEe+Rq3b4rLzpUyCL6pWFoPeO7IYTudSWrgQ3zda7BS2Y9L0PsFTTQaoWaiJQQOYrik7WPJ1yippfIyxSHg21mikl+0Iks+bV0gmz7IiKryckJLHLX6OvU4+o/eHBhdG0=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by MN0PR10MB5981.namprd10.prod.outlook.com (2603:10b6:208:3cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 19 Jan
 2023 01:11:03 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 19 Jan 2023
 01:11:03 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        naoya.horiguchi@nec.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] mm/hugetlb: convert get_hwpoison_huge_page() to folios
Date:   Wed, 18 Jan 2023 17:10:57 -0800
Message-Id: <20230119011057.91349-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::44) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|MN0PR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: d22412c1-882f-485a-f2db-08daf9ba08ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOF0TT89nRUmlf4PFbNGJwZiDhlzz8BR4SJUXPUAmn33yx3oZSkSPkntHrJY0HUSCBh5Gorf30dQleXLNnKhwGqlTPmezTn/ucQAnSJ5JqJWLDZ/XzE0EFnMtwBLIKTCwA9u/Tn8EQfWqWkDIHVMMBkuxKab/MrwUG1LI8eq4AgBZAog7IQdNpfhJgIalaCGr/KmtAksPBQofBmNRIjiECSGyu8hBVnoe8ZkHpRctwojiA9svkkFChUxJpErSdl8RB3RXSAOJzKMDnqb1ljpDjY/vrCqccBU5gbhGzo4MNtt9V+ltat3VyIZeJ8I5LwMhru/MuCWMP+PRoI6PzKWfm3NTcAhqaidwxoZIvKb8BxSK26rliPit7itMexjasxxNhCpNH1Mz5FROudZsfvDzaXcc9B9wV6WP+6/eh3+iK/huKK+r+25fb5NDSiOf/eehyw6M33Z9CAsgmJQdmKy832I+OkMTA2mBRuQHDJ89E7YN6bwCFsk67UlXN4TWABHLtYkTq0R8zeJaD14vzFRUCb9dBWpmPPl+4ZHeB4Lv8EAX3foxx9HCn00B7JO0I5QcWBc3ZeRxF9LLalRYIhPgLZ60UEhv/KAGpa28Yt7x/Rmse5W+HQhWibd2+U7F3usZD2N/uGmnF3MvuglBHjVrItLCYqueIoeRUQw0Xxw3WUjEKn1+ybDuznFQNaTgANx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(83380400001)(5660300002)(8936002)(41300700001)(8676002)(4326008)(44832011)(66476007)(66946007)(66556008)(86362001)(2906002)(36756003)(38100700002)(6486002)(6666004)(2616005)(6506007)(6512007)(478600001)(26005)(186003)(1076003)(54906003)(316002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G3KcI+dSWPviAfLiXFp/1FeJWk4p3wv8Ng4zbLrDTrBq10yYpjMeeI2/8Mrp?=
 =?us-ascii?Q?JWnEHJibesxAJe9RNirHloe3sywKLwA10nYAsC8d1+8qw/h8Ce13+uta0ege?=
 =?us-ascii?Q?n0JlWPXANyPbmKbQ4PrqnluoIOLxMWdXjshYCZjgz3TKXT8HK+QjwR4qT3iN?=
 =?us-ascii?Q?CcCzpp/GSSfNAQPoNo2NyBOiv3Hp1JWZPHp2WMrNTiDyMMlGyqh/v+/VOYpa?=
 =?us-ascii?Q?yRhWaKcCgpA8/qF0ZZ9RseCRDM0MH1u1XVa+N9LoUf29omr4zitbQPEKJa/Q?=
 =?us-ascii?Q?vB7crivjuZNjtHAhLnVKFgudgw07N5reyMlBZVFE0iOK229z11WBCmT5a8AJ?=
 =?us-ascii?Q?czQLhQWI2nQaS3883nD9G36sJ83NF5WRGOaVJtFpCy+UiyBkAH/3Y79a+IPw?=
 =?us-ascii?Q?FBmAyUV7MJEn62GXqyjL7LDXb5N9PL0cBNBRIAoF+Ad4xi4GrmvdwUvVOZgw?=
 =?us-ascii?Q?hUGll3foTpD4vqTvuyg3xjiwnSLsf966E5reg4hwtCT+jBM3AEo6J8ZW7Uyd?=
 =?us-ascii?Q?lw3Uk8UFA3i2nT0oPTMJ65+MraGBvB7O7K6Wion6OFPj9K1M2p/dCAGvhpxc?=
 =?us-ascii?Q?MKkeM0FvkCu0Se69+zU9TGZbdg7dP124jR5W9c6PPCFZYwcqD3U4SQpK2dbx?=
 =?us-ascii?Q?VhDlqcQa7xtL/j9b3gkMEyv4qOI364P/tOSE2/ARJOVSHx0hnbs61NGTcDjm?=
 =?us-ascii?Q?2NxWDU2OfXtO3FqID3mQdhc54ptvf4VesbdmqU3/HoKnXYToRa/reOg3PUTO?=
 =?us-ascii?Q?aDJY6LPRqSECn1laPDw5GgaQ2pNYSrn+lG9KkmWDMd1dOwt2Irb0OP78hCFg?=
 =?us-ascii?Q?pIe+c76FosC1GGsx71FKTm/9vEg12lSB7lSoMzNmvVIZxtnKOMUcJuhSd7qJ?=
 =?us-ascii?Q?bNAcXqklViAuZY1vTXESp8po04tQN5S2MebD5Y0Uk+ziwqk9ixULFSdF2rNa?=
 =?us-ascii?Q?cfhK5W6NKaBpjDgVGs2fLDSp1Er3ZGBcu6MtzCa4V2QrG4FgM543S1VUuqMV?=
 =?us-ascii?Q?teGe6KUrvl3B5qFNRxm4Dd9Oh4RZ4i6L21uXylgRayeu0I4Iraa9ZJRn7VbU?=
 =?us-ascii?Q?uywhI6s/ulen3gbYQEkITCZgZhsLlK3B0Dg4pszKOiydxyQZHDFfFX7deKgL?=
 =?us-ascii?Q?AOqDB44Cyap/1kwkKsw/Uhl75fEe3EV+Cbs0gXcLxjF3hgLhGpve2EvnXwln?=
 =?us-ascii?Q?ku/+RjhsQDO7h8anVduTzT7G1/UGIDnjuzTVMk4TvQYejTna8WDuybzk1RMu?=
 =?us-ascii?Q?neoxU+C700vrmLpqM6s/liSwAJAO+V+ogn7V5NU/5ElWcY05knN8/xBNzd+h?=
 =?us-ascii?Q?x0a+Aum2sOX9rcgh/aJihzwUH+BLON3WjYuayYqJTNGwGEbhycOQ8aVPHcoX?=
 =?us-ascii?Q?aKbL1xmjtuMgm6+r7pw2xJGravtBa9oRMjzIRezme5fcIs7QLHyL46RtzRfE?=
 =?us-ascii?Q?mGJBMh0onQmgH2J5ajCGOc+2A2ah8RH25MnOfMAeQgC0EUque6tZKu0/BDhW?=
 =?us-ascii?Q?mwdacvjOudEaq24E7battvhkxjp4hWcUVvFjWXbC3L4BqLKhHPpMWMNXwsJf?=
 =?us-ascii?Q?neOyEDgwtYPIfN4Is49UGIIpyWc8o+hnaNXGrjSJYU8nk/xlLxQbNBawdRUs?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9rDY9p1Ns4fJUF9OSJELVxFMP3uUUnB1/FL7ZFWuopCeO0WyBX55/WHdX769?=
 =?us-ascii?Q?6D9GFlmLuZy3mzaGDvbEIUG/3h3qUiF0F+uBXvO0WtyFLbvGHy6mzzpII5ya?=
 =?us-ascii?Q?f7XKU1rEYuKdphCQk0k49Qq4Rfc2hqmcBv+LsJ8FX0RY8b9SMNY9sMHtf8Hc?=
 =?us-ascii?Q?DPE8FYeHl6YWzEAA1jk2MqZk97xPiYX9QLatOMg5HFiQOJJQAf4rMRvdEAPT?=
 =?us-ascii?Q?vVgwTzdN+PMuSUC9dAdWKNcRu+QJHWISUwm48cQB1CZ0N137ot94tvdafqdm?=
 =?us-ascii?Q?R7gJye6q/ucV78sB1o8YpSPxshz97s3iP7ZljaRRXj+z9ZZcVN0wW7C0PyCS?=
 =?us-ascii?Q?O/GTReSwMsLzXGVXz6lt6BXDowSJdJSKOVTRoJ/29zMIs6ZBiNOpNbARXtIx?=
 =?us-ascii?Q?7LxouVzowacFshLZPZGj9N7clex2YMdFsrl9Q1kScPEL35c/uVU3yjCviF7x?=
 =?us-ascii?Q?KC8DcLtIYGCsCZNJ/4OrrzBhzPXP+MC/MMdi0l+Qep6F1r9ZIyXmSBANmkB5?=
 =?us-ascii?Q?YIm/a0kc+XekA4+DEYAoEmZPnhUsEWDBMxR6fCTTRaS/ZeTyEm76pS41I44Q?=
 =?us-ascii?Q?iX1ojzphq/cXHihhzMkkT0hz0c+n5VtQOdyg+iOm0T5aAbEAz8DxzRybWpDJ?=
 =?us-ascii?Q?aAs6nTr2DLL3Yv3S4FgblKCSahUce0Z6PYLvjxgC06mpNqVir+kFomMf9NyZ?=
 =?us-ascii?Q?Blu5Pbp/x5MRPZrBbpG9H79pTBagUAyE2ovQ97YSfQgvf1igUkGSCqmPvqzw?=
 =?us-ascii?Q?NrVTMf9foUlsqyk8ssFnVFzgo9pYZHj8j2iJtSuP+7SJ9D57MwLEHe5fYwWN?=
 =?us-ascii?Q?Uy2MQic1HJrklB1Kz8XXe2FcpcscIpUCawMisoNWJQerTfKouqHobLa9ZpGd?=
 =?us-ascii?Q?eW5Gf/UNqYE5Iclj8MUSyca/1PrwV2UE+jY2tipV1H7bi5hjPuwkHT06cDWY?=
 =?us-ascii?Q?eZoE5LS0mG3YlVHptQXASw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22412c1-882f-485a-f2db-08daf9ba08ca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 01:11:03.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YhsPgW7SqdYL8u85lhp4p5UJde0F2zdHbIoiE/X1Z23yhl6xubat01tb69OePY4D+qLnEIkTczD6/KILqmPJVaN6bZdkmpNsc+yzc4g0uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190005
X-Proofpoint-GUID: iHeOGg1mEGvIModNHA2gr6yjz_zmxxfM
X-Proofpoint-ORIG-GUID: iHeOGg1mEGvIModNHA2gr6yjz_zmxxfM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Straightforward conversion of get_hwpoison_huge_page() to
get_hwpoison_hugetlb_folio(). Reduces two references to a head page in
memory-failure.c

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
---
v1 -> v2
Change &folio->page == compound_head(page) to folio == page_folio(page)
in __get_hwpoison_page() per Matthew
add a-b

v2 -> v3
Fix build error due to not changing definition in hugetlb.h
add r-b

 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 10 +++++-----
 mm/memory-failure.c     | 22 +++++++++++-----------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f631ecc0419c..06eb59711e4a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -171,7 +171,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 int isolate_hugetlb(struct folio *folio, struct list_head *list);
-int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison);
+int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
 void putback_active_hugepage(struct page *page);
@@ -417,7 +417,7 @@ static inline int isolate_hugetlb(struct folio *folio, struct list_head *list)
 	return -EBUSY;
 }
 
-static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
+static inline int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2d2a460472fb..d20c8b09890e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7272,18 +7272,18 @@ int isolate_hugetlb(struct folio *folio, struct list_head *list)
 	return ret;
 }
 
-int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
+int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison)
 {
 	int ret = 0;
 
 	*hugetlb = false;
 	spin_lock_irq(&hugetlb_lock);
-	if (PageHeadHuge(page)) {
+	if (folio_test_hugetlb(folio)) {
 		*hugetlb = true;
-		if (HPageFreed(page))
+		if (folio_test_hugetlb_freed(folio))
 			ret = 0;
-		else if (HPageMigratable(page) || unpoison)
-			ret = get_page_unless_zero(page);
+		else if (folio_test_hugetlb_migratable(folio) || unpoison)
+			ret = folio_try_get(folio);
 		else
 			ret = -EBUSY;
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0b0a36afd79d..eb8c3cf2ca36 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1328,28 +1328,28 @@ static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
 
 static int __get_hwpoison_page(struct page *page, unsigned long flags)
 {
-	struct page *head = compound_head(page);
+	struct folio *folio = page_folio(page);
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb, false);
+	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, false);
 	if (hugetlb)
 		return ret;
 
 	/*
-	 * This check prevents from calling get_page_unless_zero() for any
-	 * unsupported type of page in order to reduce the risk of unexpected
-	 * races caused by taking a page refcount.
+	 * This check prevents from calling folio_try_get() for any
+	 * unsupported type of folio in order to reduce the risk of unexpected
+	 * races caused by taking a folio refcount.
 	 */
-	if (!HWPoisonHandlable(head, flags))
+	if (!HWPoisonHandlable(&folio->page, flags))
 		return -EBUSY;
 
-	if (get_page_unless_zero(head)) {
-		if (head == compound_head(page))
+	if (folio_try_get(folio)) {
+		if (folio == page_folio(page))
 			return 1;
 
 		pr_info("%#lx cannot catch tail\n", page_to_pfn(page));
-		put_page(head);
+		folio_put(folio);
 	}
 
 	return 0;
@@ -1418,11 +1418,11 @@ static int get_any_page(struct page *p, unsigned long flags)
 
 static int __get_unpoison_page(struct page *page)
 {
-	struct page *head = compound_head(page);
+	struct folio *folio = page_folio(page);
 	int ret = 0;
 	bool hugetlb = false;
 
-	ret = get_hwpoison_huge_page(head, &hugetlb, true);
+	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, true);
 	if (hugetlb)
 		return ret;
 
-- 
2.39.0

