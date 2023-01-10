Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E030F664E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjAJVaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbjAJV31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:29:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED15C60CD2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:29:14 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AL3cHe011301;
        Tue, 10 Jan 2023 21:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/QULkUox5rmihInJovSFDI1yjAOFhDzEXSOdbMBjXi8=;
 b=eBp22SYBtvNKEZ6zOprjdyIyBSwdb/3z273+jMBssMP1Okfy1mUL8kBPSM1Gv0hY3TnQ
 wSEomke+4H9hQppoydCfvgDKVmk7D85tVfzmeg/GCSorOP9xI8gHo21Dr05AkvRKlBSg
 L3Faf6Y60oK8vgxwdIYAY5824ClAXfoCBLc5Z2P6HGFRYFSJxXO62FcgaJJIh8+kGjRg
 e78EWlNhWybGV1WreLzVMt0yAjaoUfdb4QKWuWjNaFWHTiCqu7KBiQ42LPeDuqXqcut9
 w/TcFnmRSUaANd/6kDLYou4zBvVJGh1S0P5INzij1Ksu8swXwBOOqIGD06lLYMnheNIY YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1fe5830x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AKY8kQ022668;
        Tue, 10 Jan 2023 21:28:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1f5x25br-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeSmqLawREU9WB+NmaDkjvt3fVoAV39/HkUC+wGMFw/8IaQ88aKt/druCCT1C7kqta2NazqsxcDeHSv37bD0PoGBezTQfTI4SF689Z9902pLe/KrdIsYIazWshlBwRMLavBPurmbino7McaneItpuhS5jT+w8FTNLCWtOQEZJEWzKUBAiNajptLYrGhaxQ2/cMHuFlSgYAEixVumqqbZkpdYf/P+4JR2AT/JeLJf/LHIgQzEEzTidU0YFbnRbrny3bjjywgHLdX5SGeK5J2MRq0abdcDxtgAhrpJN+SFXeOAkheVFDCu1gbsYuCFBTdo1oMU716WuUlWz5pbhFJtlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QULkUox5rmihInJovSFDI1yjAOFhDzEXSOdbMBjXi8=;
 b=GirLEpTHL9Vyu8eipOnHfKDPdlzHFmgvcdIgeZ88diB+QObIe8YQqX/SOV4S+wwibEHUxMXqWf0VWQOHTLZsI1+5Dwvq/0p7TwbHuwIidXrXutu/SgQKa3rqr532kjI0Hw/m69Lnt5ZYxYaz/gw8hJG+fLXbXRgIlmlwjiKuHDnrMVDJygkb5Klk1W/8FKdmJN7u4t2ViDqw58/Lakzb7Oz4dzhbicO2i6qtmuaf/DCmXfIYHW4Ag3W0w1V4nWkYKuU0zljZn2Ks9E59huz8vxxtm8GpoV319t2OTBEdsOWlzD4qZsLQ8sZGxhm2ye1nCnj7RQ+TqI0h5+tjRvjpMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QULkUox5rmihInJovSFDI1yjAOFhDzEXSOdbMBjXi8=;
 b=wOwCSzhrSDm5sM4iJ4hMhPgXHZFFkCA0su5HSt5Tuj8MkP7KDmDVbqzo9POoJjc0BhL+lPCIKcfzlkmr/b1LWoQIznHm/S7LPXcIvLOQOBcurLkNZUHkDuFFWYDMjr8oDfYRWD7DcLvkyqt/LhCWlZStTs4o24iBFvF3FBUJymI=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS7PR10MB5133.namprd10.prod.outlook.com (2603:10b6:5:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 21:28:45 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 21:28:45 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 6/8] mm/hugetlb: convert alloc_migrate_huge_page to folios
Date:   Tue, 10 Jan 2023 15:28:19 -0600
Message-Id: <20230110212821.984047-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
References: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:806:130::34) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS7PR10MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d520678-d78b-4982-8d93-08daf351a796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlGY2VRmQt1jtAqr6txqzH723D1txWZd7Q1oyO2nJH5eNBSPayQPIq4WO2tlL1isVaZgFzMO6MT7ZPPj58uwraEU8HbLqeNMIQw4U4x4yH0UHnYqh18uG1vlXnKRieksSa9y3CG9Uz29BaK9UAV5gMxnTuYg+CotPBGCChrr4CYfDLPMxTXofT4/rY1q7Y5KIKdbtMXscrpKXvH7OdbZnYP0Six5S1HxBUxTr8V5mR2VqB334MHhhRBnMXHQfzCQk4u/b+FbgWFNzwZ4Otd1HTuG5p2N2mdzTiO3GCSFn4p6jJC7cXMstwZxt+rj13uZlFLFJjsC6PH8+yt4AP8YZZagw77pedHaydMbTiZ/WMVvzVm8n6JyDYrpz1SCsrZX6wYixUn/Pg76LzOsxu0N/hn6d221ZLcUelK2kts5IN63f5uzZzd1Hi87A7mEkKp1qASsUer+OAR9B5z7+xPgIzuyg2stCqSe47PCK0Zg+Vi1Zm+0vFGpTnamD6Kz35BUFFpVmToliv3Rnm6YJSaTmYISt0oJ2nIgkEmHFrtiSWo78ZRRcwzkJthEUALRp+M6IoYRNFLzz50xd4OqyqX5D8BZNbxogq037tRIbgGPa+OS0rtU6VKhaghXp9MRmxrJ02aFTiBJkIrCee8DsDJlmQ+NFgkKjA38Fbv441k0DAL2XQe0NO8rnIfUdLIJ2sId
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(38100700002)(316002)(36756003)(5660300002)(2906002)(41300700001)(44832011)(86362001)(8936002)(66556008)(66946007)(4326008)(8676002)(66476007)(83380400001)(6512007)(478600001)(6486002)(1076003)(6506007)(2616005)(107886003)(186003)(6666004)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7LIBioIc03Vjh6qEcvWWmobp+Axm8JVNcyNppew+iqYv8I7buyvg11hhfy1c?=
 =?us-ascii?Q?PJItgzUJtcPGTGEs7iJ53hGG7ERZ3Od0iiLnFv+hoCav3/cJdxz774E6u7Em?=
 =?us-ascii?Q?20bdjw2m3oCRn83SYw3+btqrMc0d98w2k7We5B0i6pjQWJmunQ8Tb2ETuyy2?=
 =?us-ascii?Q?PNcX1G3SCkSvb4smtWHqm76y33TuRkK4QxNFSTkywYO5S646m7p38d62olk4?=
 =?us-ascii?Q?wQBhLujej1wWZOJre7oUxeAJRZ+o3/HrzyAEgdzjg7CdMRWZ5qNo7jUBprcY?=
 =?us-ascii?Q?w+IvImPLhB8QHZwBKBt71aPlEQu5ECZTItypOsWw2jytlZnEY3W8O1zTuV+W?=
 =?us-ascii?Q?IOZb/bbSeG0awAxSXf6VzH7JgZmLSgHHgrZmVsa/H3ikVDhlhMo2PmjaGf7/?=
 =?us-ascii?Q?va9gwIkb5LkhiEg/vt3U1rZNVBau8EZiNUuLsVr7+jnnYTkQQrL0gci3iNLG?=
 =?us-ascii?Q?3CfowDGypBa/ct6HaQYAU1czX90iBPsnoKFsl9aEA88CIuq3SVOCHAqvk/q+?=
 =?us-ascii?Q?WvcwLBG+aqyWndSjA38GpHuIgkga56qRaYJYG62jtc3UmR4bRUK1ATyTjIFb?=
 =?us-ascii?Q?4wEGPqqFWMNjMhDO4mm15CipvG18cY3LV8doiHD7JN6NzFSnvTCxzgDn+m0d?=
 =?us-ascii?Q?N7zGBTt2LUl+719UMNbb8Cd6qP4fAOypCQOq1xyYGbyuAkHW2R3c+ZAyTteJ?=
 =?us-ascii?Q?ON0/iSj5vuKkdAWXGhm0IURwXDVoKrkChpUoEkzUA1nXzDgUgSw5kwft63rh?=
 =?us-ascii?Q?nj8qCwfs9RqrE/pnFhfnHIF6RXkb9Biy+5NBshYa8dGwxX9/fjosfuAUXSin?=
 =?us-ascii?Q?GNhP57nJPKtykEF/VpLyw/e6yTJsonRYNcwrnxJL9seUh4IFvniL6BkHPFr0?=
 =?us-ascii?Q?oGFAH/kURZPBHH0pvtr5UtHYGV6ftm/+KzjKx5WqyzhHCW4cUDFzSznTEaSE?=
 =?us-ascii?Q?OtbdOYMny6M3K8+3SzN2DCJw+y6apytpGURlvEnY7hlxLCR8rkMlv11Ml8I3?=
 =?us-ascii?Q?kyYJ47akvOpU+GdqsJnylYvV4oGUNNUJfU5Fh3FZpgeRjp+BNyrbn2NFGI0W?=
 =?us-ascii?Q?+c11FZwMf+wjHZycHF6zVnPMzLt21MaPnkO9Og3kZPlv2i+XULpGOSPqnUI9?=
 =?us-ascii?Q?qTk1nohw2EYErzXv99R4HjQ2/kFWyFKXJbEsvTyNYm8+hl5/C4QPaDbl06JO?=
 =?us-ascii?Q?g1qevq74Xj4Vm7pA5RmA3+IE79ADJzoV2F+kDKuML2SwoAH5RId2Ke+snOzz?=
 =?us-ascii?Q?Zii4k3nblOB//Wma4e5jLPQpPMwYMg08cJEgfXqBUS9D6l4VY6UIn0u+2Oin?=
 =?us-ascii?Q?mPsoOGWRShPZ2yaDl/agNFv2r53q4q0+tIir5qKjcB+fcsJOOYFrwB7AKArs?=
 =?us-ascii?Q?0HgeWQTOKIL/nejccQLEUtyFSIfp3dGFuqgwZpT5tUfg2jyg0XYsDQxtujtx?=
 =?us-ascii?Q?v/T5+67JfUCGv/vK0xa+8VTnuqjGAKrOqdWHTDX2lc4vVhF0YqymRoTFxcLz?=
 =?us-ascii?Q?zva7gCtBV76xUHEV598Se41wcmkb/JQzkID2W/yXJtW07hRdC9gn50Hug22u?=
 =?us-ascii?Q?DDqlcGdoOI8C57TMSxYu3GX+egAYFDxuWv2oVD869EgQOqai3Q8qRTZLfTah?=
 =?us-ascii?Q?mZwCZ2zzoE5rS1LQbiP1ZU0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QFdxagAbmlEy4NFpvyB1Cq/ckqpXjvI5PIIQh0g3cdgvjux86cBHx1Vt+qX3?=
 =?us-ascii?Q?L4/jLhBkpSh5Drv5khCQ0IIgb5UHmNeGe5vxwpo3pcVpFh1yUQLPznFOnXUI?=
 =?us-ascii?Q?9XtLt6P8u8x512bKxponOK4KtcAtVRwybL2TcSq5YGTVRUAe8Bt4AgzQjBj4?=
 =?us-ascii?Q?Fgy0v2UeZcpHGZBP5U5yAlDMKbq/L1rKzpWju1JBbrSOhrdFuQpZa9WL6oXD?=
 =?us-ascii?Q?t2rYI4a2Mw8SAGjg5TAq9pVc2MEvOOtkQP9AaEhUNzRZxlhPas1ERtXugMuv?=
 =?us-ascii?Q?03BJnen4W3H6Z9juUlF9WrWb7Agmcwx5Xpu6X+ZBzw+Ar0LBIiJpwbK6qji2?=
 =?us-ascii?Q?Y9hzX4WefvqXBUnhGlSDI5tORQIB2NoLZBTzG5wEz7isPTGF8HkORkUdCqoV?=
 =?us-ascii?Q?gks7cpUpvkC4xRfEa1R/ezopZF9nR9MZvKPgzvMLTfWZSkSyDfj5mupxondj?=
 =?us-ascii?Q?HYZfw6di6IgdMZ3M6xd52mA2cxq1OkhKEoAbRgYvmb/bmLoRzWP+Kwum6Ux2?=
 =?us-ascii?Q?EqU4ivGcXHpXOTVBYIiuPYFCUkX7+7S1xQra8Ce8Z29cReMj6DehckaFTQVg?=
 =?us-ascii?Q?0W3xtTzlz0wAZRz75BIkHSFIYYjwLmT2N8ZyrB9A3qk5Zrw62tHQkyoFdkAN?=
 =?us-ascii?Q?4nyLXP+Rq5oNwj1yQvC3kJ2asFa2PLQr4g7NapnqEJ+fNbnv/VCViDjXbCal?=
 =?us-ascii?Q?zi/6VVEh7nvplqoOYyGDypPL+ei/5TAniUohlow1Ez8QCfWecN41RjsdBiYh?=
 =?us-ascii?Q?TmA+CQPR11u/kXvlCUAMoS+LOi0fItghC2lyBAMtjkrf0LkU9RExaIcjk+ML?=
 =?us-ascii?Q?Z1J6DLeiTMpWDran6D/OLMFP93pBBLdroXqyZnKEewKbeuVVDapAtQDnfBr2?=
 =?us-ascii?Q?ozKx2Z1GKGEL/hilndisaUvTIRZSEfxXloywcEVEK7qJYKJOtB+TOARp3LbG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d520678-d78b-4982-8d93-08daf351a796
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 21:28:45.7783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFJznWQHR27S4a41dMgZ27GkYO0X18py7ywBMWPzMlzgzx4MV4xlHX9OsMVClLaq9RKp0CzmsxYpWDAiTsC3tKqLJl0XXJOX+rPxaf7oWrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100142
X-Proofpoint-GUID: zZBcUxr38dw456bCMStSmob7VO_kQPnR
X-Proofpoint-ORIG-GUID: zZBcUxr38dw456bCMStSmob7VO_kQPnR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change alloc_huge_page_nodemask() to alloc_hugetlb_folio_nodemask() and
alloc_migrate_huge_page() to alloc_migrate_hugetlb_folio(). Both functions
now return a folio rather than a page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  6 +++---
 mm/hugetlb.c            | 18 +++++++++---------
 mm/migrate.c            |  5 ++++-
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 482929b2d044..a853c13d8308 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -680,7 +680,7 @@ struct huge_bootmem_page {
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
-struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
+struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
@@ -1001,8 +1001,8 @@ static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 	return NULL;
 }
 
-static inline struct page *
-alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
+static inline struct folio *
+alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 			nodemask_t *nmask, gfp_t gfp_mask)
 {
 	return NULL;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f3e1d052b40c..c0cfb075cd58 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2275,7 +2275,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 	return folio;
 }
 
-static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
+static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mask,
 				     int nid, nodemask_t *nmask)
 {
 	struct folio *folio;
@@ -2295,7 +2295,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 */
 	folio_set_hugetlb_temporary(folio);
 
-	return &folio->page;
+	return folio;
 }
 
 /*
@@ -2328,8 +2328,8 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 	return folio;
 }
 
-/* page migration callback function */
-struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
+/* folio migration callback function */
+struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 		nodemask_t *nmask, gfp_t gfp_mask)
 {
 	spin_lock_irq(&hugetlb_lock);
@@ -2340,12 +2340,12 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 						preferred_nid, nmask);
 		if (folio) {
 			spin_unlock_irq(&hugetlb_lock);
-			return &folio->page;
+			return folio;
 		}
 	}
 	spin_unlock_irq(&hugetlb_lock);
 
-	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
+	return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, nmask);
 }
 
 /* mempolicy aware migration callback */
@@ -2354,16 +2354,16 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 {
 	struct mempolicy *mpol;
 	nodemask_t *nodemask;
-	struct page *page;
+	struct folio *folio;
 	gfp_t gfp_mask;
 	int node;
 
 	gfp_mask = htlb_alloc_mask(h);
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
+	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
 	mpol_cond_put(mpol);
 
-	return page;
+	return &folio->page;
 }
 
 /*
diff --git a/mm/migrate.c b/mm/migrate.c
index 6932b3d5a9dd..fab706b78be1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1622,6 +1622,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 	struct migration_target_control *mtc;
 	gfp_t gfp_mask;
 	unsigned int order = 0;
+	struct folio *hugetlb_folio = NULL;
 	struct folio *new_folio = NULL;
 	int nid;
 	int zidx;
@@ -1636,7 +1637,9 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 		struct hstate *h = folio_hstate(folio);
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
-		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
+		hugetlb_folio = alloc_hugetlb_folio_nodemask(h, nid,
+						mtc->nmask, gfp_mask);
+		return &hugetlb_folio->page;
 	}
 
 	if (folio_test_large(folio)) {
-- 
2.39.0

