Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26B667B7DD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbjAYRGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbjAYRGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:06:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5655976C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:06:28 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFPxlv029537;
        Wed, 25 Jan 2023 17:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=WtlzYE6hM1ROsmIkU6D5BBeOZTR3jQ1kLi1nmizsNy4=;
 b=qrRs4T+/nah5RKC3ZXPKGruglhSCbp4MPkpevczlMX7d+xBbNBjxcnFhhpU13k8msE8h
 x00wX1ycgaMKOSUQg83qGy5WbtTx6tt4Y2G2zyDLJFhRYQG8TNwBiqlv/jhMWo9JNMBw
 gqJ2xgoYIBdGj34/LqftAOWvBJbLzAik99RsqwacnH8FoihhkRXKaWK/boZ1IOEVWcJb
 uDjy5n60XoK3dDsJxNEM+okYd8A4PqeyBIG4Z8P0EA5QOyB2M3nhdwPZo0wVeuzDNINi
 jgixy3nWhWtpSKgz+XD9COm66NS7PlDSTJIieL1YE1DZzEvxOl3cp5M80CRtdWtV1cTh HQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n10jrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:06:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PG4N3F009387;
        Wed, 25 Jan 2023 17:06:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g757r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:06:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EanRIY8s+MJm7mY4NfGK1jfY6Wy+3QfQEqfHJjXu01CRJ7wfdJ0nkDJp+RVLMGaV2YPJ3mp77IuUpwqDBxUSQI1v488w8oYgfF1OxDbFG+y5wP6IEftRYs3cEQVqbU7gCcEwrsl8uuVNhOae4l1dOcYi0MShwm+XAGG8M0JY82pax42Y9XMi+qIXewa4VE+MvjDEKcaAFv1vCVQZqEM1HFPgdPFKT+03qb97RaQ2VHNZz6TgNAxg4OOFlf8x5hmYBAVL2lBpBbnHIPF1MCgv3x8QX+IVLXD/sYhHWxKsYx55ci6tV0zfwyFAS2jyxdRwtujLRO1li5a4+E46kFrWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtlzYE6hM1ROsmIkU6D5BBeOZTR3jQ1kLi1nmizsNy4=;
 b=oLTBs3rAtqrLZh0cG9FWdbrJxTBvdTLwaaQJ82AE2cpW+xm+mhEVoJGIERov7V+wgWQyJmD6jO2JfhPiqZRZUuvUECahRYIz6tacKNRKVBco8D0YuH2giCIMeZDAjCuj6eQuDyLGOwOOxdEfb6s4WgjFZX4quqN4YBEqv0zHa+q6DbDwERKDgxprAxNhfxOYQVrCiuHuQkbuxhkbpWVXVpC+J3n9cwXCVpF48taf7hgpZuzZzRS2NTXNGas5cc84r0aQ8LNOy1xGJ3DKz25aI9Hw0aepVt6tYNddOTrTE5LTAuQHHtVsWyiwBNQdD9MY8ueij5ddj3FnPG/yg/VhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtlzYE6hM1ROsmIkU6D5BBeOZTR3jQ1kLi1nmizsNy4=;
 b=oxZeFp7qZYnhSiLhSuA909YCiD8VqTYOSNFBtsxGwRplwRhaj8/PLBA8B1h9KhigOoNX7rysVwAgPHx8JbLyekEmReGz/3+Fm4OAZuqfY/WQtJRYy4ERMrwrqB97TpA+1I+VWVCxw5kezKOhSMTkaqEerRkmo0aTv8dwiCd0688=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by MN2PR10MB4384.namprd10.prod.outlook.com (2603:10b6:208:198::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 17:06:05 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 17:06:05 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        gerald.schaefer@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 7/8] mm/hugetlb: convert hugetlb_wp() to take in a folio
Date:   Wed, 25 Jan 2023 09:05:36 -0800
Message-Id: <20230125170537.96973-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
References: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|MN2PR10MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7da166-c20b-4d74-a41c-08dafef67199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RANY4V4l3gzGdxcpIJR8HhpGcu47zOXGBLvYbZsOOx3qt/3oFCmY3jdwbn/ALvk/1w3mt/UCYqHQTq8uYlUEH1VS6defQ1lQYUUpL96xEqU+hbSus/p+5N8Bt4VCiBZ4t3FvtkJ8T7L9yZOvE/sUfCNrH7G+z1OqG3Nll3R1X6fjV64ogIw8jqgZsu4Aicxz0bXWQSG6jksQVXPw/TGJ4d2cOElaKynQVktZjdGDfLCn9rYeSHfkhS4vaRMpsVMyHfhIDRJJir5xheaOo08CsaYn5l4j+BT1pVdpb95S+G2mSu3KAXwh72jojWv11xT48sB3s9XVMDtiJ2RJccEYsIdSBEQLqREcrORltfKuTVeXs+tMNV9D4Unh3d18rpFXQmm/IxsX+zIVYtn4nQB9s5Re+ryW9ekPsQ+ut92kh3UHrUK2FYyDSGf6MYPgdy6qNSbqc25sSq98NLH9RE5XIKqRW+1ZWUxhCkRBicz0uulhsUTcen+Wh9A3CBPYwMvfp3uwvrN42OHhygpfc5hHlC8TcicmYrzmYEg6qxVtCL0KB0DavBhyNS/kiEHGhWUqgylEnA3L8axEp7xgi912kW8SMNnDxHN0Sf7Zi5Bn/RjIkA33mGrhNBO+1N8bw13WKsR2Kx+2XUZG5MmBvKpBiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(186003)(26005)(6512007)(38100700002)(66946007)(66476007)(66556008)(8676002)(83380400001)(4326008)(8936002)(41300700001)(2906002)(44832011)(107886003)(6486002)(478600001)(5660300002)(6666004)(2616005)(1076003)(6506007)(316002)(86362001)(36756003)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SgFEj/uxRRUF3FaT1abQeHHo7F+41oc1NhAAiieXOLV1hXnZ2OmOtl/3rwsK?=
 =?us-ascii?Q?gSB5xKwJPJV0pU2XtB4b3F2MV99W4I84N++hpvgFtNVvGybWIieL1ZkfiMVR?=
 =?us-ascii?Q?6+dl5P3xz9s0L75BJUeLMNdf8ie5c1eNbrov1Mza8t+HPD3FtvQywaC7jNF/?=
 =?us-ascii?Q?v/LWMJGQcbW5Rh9SaDWAd2Ly3Y0iffzWJvLd2OZ9hTBijLyHYR1ryzr8XnPp?=
 =?us-ascii?Q?nAgJT7ef0V1yyFHQUV318yZXS5h31PFlDF1iLzOpWRugHO3mG6UlDE7VUP1E?=
 =?us-ascii?Q?wegoD5KC3anAY8ASVtRKhIF28Qq6R/FD0DxjJhfe4hdclGv+NAH7J3t9vzle?=
 =?us-ascii?Q?M2z/CbPXmrFeMnvJ1fA0hdCk9nqR4nu2pRXsT2fnn8JAsHuLZe4jVtnHzfjP?=
 =?us-ascii?Q?9iY4gmTO4n9PhW/Z2n+IQ2cfEwmGyNWKd1+R1WfyqDZ+kDVvB6Pa5GXG/30R?=
 =?us-ascii?Q?EjJXvXZ4WsudkFcj/mfWdK9pXvgSodd+7AU8teQecXAM5B/A5D/tWBz9wPRo?=
 =?us-ascii?Q?jpRo+807xdR8gujoQx7FGWDCo9574htNxwHYI1OSA8vU05N5C72o0Jy6QiEz?=
 =?us-ascii?Q?8zWaoq7tuZmrrZmyVBFg1MON8ets3ugOOrfuiyjW83HdJQC3ZNbN5bwQSG0t?=
 =?us-ascii?Q?OnHPRt6Rz+ttPjSNsCLYDfmYzFv80SJ6Q0SEDO4PTbMvU35cAWiL7gIIv0o6?=
 =?us-ascii?Q?Ku+J6gX9dFwy9yPIBbPg1YU8EyJYImH3Ccb+00J5jjfeM74cMHIWEoJjLTrC?=
 =?us-ascii?Q?6c3ZVJqerO5nC8y/YXJDYOAzfZ6IWKxMhdoHKQACF9MFnUT8DLzpVRtdIjFZ?=
 =?us-ascii?Q?PTu51Au0jvFARr+FWt8L+QzEHyKNuhSs2jApRqk4IcjdpvMnNyLCToehsP7k?=
 =?us-ascii?Q?3RbePJv7jm2FEkNL06LVr/t5+IfbltNYeDuVo0xQLtAv4pGyJfVZOMjcAI9G?=
 =?us-ascii?Q?mNFEABEssWphAfOgpkgQTnbNx/O3WXZm21q0JNz9loTI3DYS3NLvNEAHctHF?=
 =?us-ascii?Q?UvKgCeC4MvSzAvuWRxqUdQMtOgFEbMBUnEGSj0SpC32EeOWi0fzZ2gSrXAyl?=
 =?us-ascii?Q?kwyK8QoaJdj5oH9hj+Ss+MMFzzbGuQTJMpMviOCvDQvMgXpA07oxc27Ol8TC?=
 =?us-ascii?Q?I/s8kPAdNzMka2w09qYZjjJtUv1j97JgClbasiXtV8bkcvWyfDb91WpOSRhs?=
 =?us-ascii?Q?oK9mjN0HzQfK8K2kH+12ImqIQianC6vbcQvUdzwfu++DtSjSM4+MlkSEANlu?=
 =?us-ascii?Q?LN4UlOvXGVdSlU64+c6wbYexJZrn1DcPYoMCqA4OXdUmIzrOdUgXjbKO3u3h?=
 =?us-ascii?Q?PDnemLyGsR7RgzXOcMV7ELOGK+jGUnV9L29nVekpEpz0LSpvtaA113MBCVpi?=
 =?us-ascii?Q?B47yhR+83TB0Td0hPcVD2JSiP/OfJoKzwOM37zRnmuBBpiREReTrPEjcmu1K?=
 =?us-ascii?Q?QlsAP0mnxGe3CiUMCCIGWbPsjejeMcJ0PZf8WNewRVg01C04URdpHfWfynCt?=
 =?us-ascii?Q?aJ7nnQGqpp/q1Ff4BRVgo9UXF8q7Yv1EKjMAdhYoW+aNqMTeVg21B0bZdc41?=
 =?us-ascii?Q?7lV9sO5FNqL8KihkSMuaIyoTRLJWmNlBKglFMHc/YLdeTtT96BH/LqpvzeiJ?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?T57ne3MA2hxnmDUG6KHUrxiwyAbL1CNNvDx+ejbYauHFhtGkLjNbVYJSwP0I?=
 =?us-ascii?Q?YIJpnTcWJtRQGc1OfzHi50PxmMef3VcR0vM5VDFkSww+drvZYHg6W0tgs/0E?=
 =?us-ascii?Q?iqZhrGU2asHpnOLU+pgwj0zQJofq+a7IzC6+7mbEpRJ1fSv+W7aMJq6gJnPW?=
 =?us-ascii?Q?vhywx33VUkhaG8WN4YIpkBDLVvnSNk9bncjESBMrZS9QgXTkomA7KYLMQl7Y?=
 =?us-ascii?Q?QZFlvg/SkQUD6ccnS68aJlmcJktyL+fI1zXdjRl4rz7k6Lr+z9/9PUkKNQ13?=
 =?us-ascii?Q?37cEUTg8pTo7w/F7gYSfkq/T7hCz+l4/jrUO2e4N7q5iB+cDhTA+c5J+Bu7D?=
 =?us-ascii?Q?pA5J6m68nySaAPi35TQKG/2lSzfso8djQz35od213swjdfHts3FYLgcOSf8S?=
 =?us-ascii?Q?nesm3r144N/YScJpf3uc/5IYkjVD9+S7fdJetjMXi+wPbkMcOsgar1iW5LAJ?=
 =?us-ascii?Q?WHYt17eWH9lvoCWkaSkQUry1nS81SSRFaXNMzLEBHOuHl8YgU5HKmxAqInsb?=
 =?us-ascii?Q?DYMNVg8/vaNZwXS2zwPhHasjBx+1Zq0kgsHNwoNvPEHSpeTUpybducaVDw0I?=
 =?us-ascii?Q?LwTgqyj+UbNbkw5Q33OtMPOvW3HlaICdM8x+eVSDP08bEFv60uIlBFKTXHdF?=
 =?us-ascii?Q?ElGaGG2mtwIAROiEEqwUPly91LpeMMCQA7ZppcumFUUcqqRmwQCIfvEnO/ZG?=
 =?us-ascii?Q?BZt0yfjc1tpgMeIcNk44xWM31civ+wAHZp4/ioRQfTysh+2fJmYaYNLqJUQP?=
 =?us-ascii?Q?zCq7TgDsP4OtkbMUzX71L7mZW+XvVruevtITa5uQ16L/89UA/sRVlRsFgPJY?=
 =?us-ascii?Q?9AT6H1J1Uf6RLshseyIz+/8oiRrkp7Aisbf0r6E3rL20+OID/9rAD6ox1Iqw?=
 =?us-ascii?Q?gj2GJciV5wr3wJOlWZnhzQBllG9y3hfdFbcjrMwKqI5DTYdJ2gOueOgREICW?=
 =?us-ascii?Q?vaQ5p3aYEiwRgadcnckZXGf85ZUD7LfKANO3PkjiPP0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7da166-c20b-4d74-a41c-08dafef67199
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:06:04.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGzF/uRCxv0B4b3I7nDeJXnpr/DRe17aYBUEK3O/PCA4UlcHuSPtNgpftEN63psau/WC+Vvz8RIQJTbwxc9YlGE1leNNZWcyEn5jJglTIko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250152
X-Proofpoint-GUID: H4MkHNqU6PYG2fkN1Btuektho_ZnFs5T
X-Proofpoint-ORIG-GUID: H4MkHNqU6PYG2fkN1Btuektho_ZnFs5T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the pagecache_page argument of hugetlb_wp to pagecache_folio.
Replaces a call to find_lock_page() with filemap_lock_folio().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reported-by: gerald.schaefer@linux.ibm.com
---
 mm/hugetlb.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ab30f8550631..b6cbba105ffc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5472,7 +5472,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
  */
 static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		       unsigned long address, pte_t *ptep, unsigned int flags,
-		       struct page *pagecache_page, spinlock_t *ptl)
+		       struct folio *pagecache_folio, spinlock_t *ptl)
 {
 	const bool unshare = flags & FAULT_FLAG_UNSHARE;
 	pte_t pte;
@@ -5529,7 +5529,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * of the full address range.
 	 */
 	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
-			old_page != pagecache_page)
+			page_folio(old_page) != pagecache_folio)
 		outside_reserve = 1;
 
 	get_page(old_page);
@@ -5922,7 +5922,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(mm, vma, address, ptep, flags, &folio->page, ptl);
+		ret = hugetlb_wp(mm, vma, address, ptep, flags, folio, ptl);
 	}
 
 	spin_unlock(ptl);
@@ -5985,7 +5985,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	u32 hash;
 	pgoff_t idx;
 	struct page *page = NULL;
-	struct page *pagecache_page = NULL;
+	struct folio *pagecache_folio = NULL;
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
@@ -6067,7 +6067,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_page = find_lock_page(mapping, idx);
+		pagecache_folio = filemap_lock_folio(mapping, idx);
 	}
 
 	ptl = huge_pte_lock(h, mm, ptep);
@@ -6087,9 +6087,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		};
 
 		spin_unlock(ptl);
-		if (pagecache_page) {
-			unlock_page(pagecache_page);
-			put_page(pagecache_page);
+		if (pagecache_folio) {
+			folio_unlock(pagecache_folio);
+			folio_put(pagecache_folio);
 		}
 		hugetlb_vma_unlock_read(vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -6098,11 +6098,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/*
 	 * hugetlb_wp() requires page locks of pte_page(entry) and
-	 * pagecache_page, so here we need take the former one
-	 * when page != pagecache_page or !pagecache_page.
+	 * pagecache_folio, so here we need take the former one
+	 * when page != pagecache_folio or !pagecache_folio.
 	 */
 	page = pte_page(entry);
-	if (page != pagecache_page)
+	if (page_folio(page) != pagecache_folio)
 		if (!trylock_page(page)) {
 			need_wait_lock = 1;
 			goto out_ptl;
@@ -6113,7 +6113,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(entry)) {
 			ret = hugetlb_wp(mm, vma, address, ptep, flags,
-					 pagecache_page, ptl);
+					 pagecache_folio, ptl);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
 			entry = huge_pte_mkdirty(entry);
@@ -6124,15 +6124,15 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 						flags & FAULT_FLAG_WRITE))
 		update_mmu_cache(vma, haddr, ptep);
 out_put_page:
-	if (page != pagecache_page)
+	if (page_folio(page) != pagecache_folio)
 		unlock_page(page);
 	put_page(page);
 out_ptl:
 	spin_unlock(ptl);
 
-	if (pagecache_page) {
-		unlock_page(pagecache_page);
-		put_page(pagecache_page);
+	if (pagecache_folio) {
+		folio_unlock(pagecache_folio);
+		folio_put(pagecache_folio);
 	}
 out_mutex:
 	hugetlb_vma_unlock_read(vma);
-- 
2.39.1

