Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051F56684F4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbjALVDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbjALVCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:02:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA64244C68
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:46:38 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CJXpNN031537;
        Thu, 12 Jan 2023 20:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=XoP6FImO4GxwVThkgUQMfeBQKss2upzCfkJWHtJqCPg=;
 b=2g9AvPDA/WmR9m4bZS2jcsGHHz2PyZD9GN4zB1ZGKsLCj3fSXRsDqRPWrv43HgZ0RgPw
 /EHOGopvUkFrFkepcnIJDNqybWR8Umf7MCReaQ4+k1IkNLaRt2uXKQYMPfEr85NiuUTd
 0iaAdNPWyFX6YoUbFJt1esBdaSh9CBxNReYkA5zqXk4p47Pk86UK5Os4DGSs87rQuX0a
 52J6i/vK/4BVkRSlUV4dnGPpmv9Xe2kdaKYLcUviAGcyjb2Hb7PgJqYAIGAsRe8li9k3
 dLBtCxilow70V8m8iIxWcROQDNmJBAtrRceEbtiPI0Vf1QfJtwkCbc5FwBtF8z3QGGvL yQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0sckag6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CIt3Bv005182;
        Thu, 12 Jan 2023 20:46:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4brqny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cg49J7pF31xKveuPWWOQ9+XE0uS2l1MIvxEv7vAF8iB1l6e+sHyY4L+hyi8DMqsWf9yPvbV2vDRiqaJRzUY5qnSmKi6JBXacB0OSveqx7IB4CYWTmAbELzBP4469vlP3F1EoeZxH6UapFFkNOXSUwFcp5PAonIBz+t4iEVejM8YsOtbxtX2cHg3WDgHDXDJ8UsMJSBEDELJg3mikHiAidtCLbo6WnUn6qm0GEf5uUARbkm2fLQZ8RaocopKvvbcnFQ1G/9tZtzbb4t00qnSwYY5xbfCcKSK+Qwn4vihFE5pRUGB/RPLqv7e+MXS4T7Mfvb3JQlYdy2+KUDMZeOEz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoP6FImO4GxwVThkgUQMfeBQKss2upzCfkJWHtJqCPg=;
 b=R2G5pmzi6fhLC097+pIkeKrlw6iQPDzI6aRNcpjk59Qgl8fycxO7wzrolceBlA2LKG3xZX6mhFTj0Lf+MlHOExGPbLiI0/YN8bnEsA5wF6MUqkQr3maWXmk1wJCXzfj7uELzqxF29vQOC6K8q7w78A4d8lwkHYB3aegGTtOh3gSuIOfgAi9VuX5zwYLxZem5R+k09OLJkEBFQ4IoLqclTku3QDhltToKOrwCmGpcKuSRFV23vLkyEXxbultsJD9LGAgbbzM/9QV/BITxS75lQ3ZpYjh2heuVPzw6vU6HXnH8WJ9AyzABigETPGd28Q1+AvcmsReYG/wmJHh7JW5eOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoP6FImO4GxwVThkgUQMfeBQKss2upzCfkJWHtJqCPg=;
 b=0BQRSALtA1UNA5ODRhOHjA90cIMYl3wcxL6xOzm18pkbD9oL3ZXCeUaWpxJZy4N0lcGtnuiKANXJEq9eoQHHNMfvv/bPYqzQkALAXqvyaE1CO5G0LiacxHxsI+pZVqraB0/Crk8auxaJvsWVZtlbdHJ0jm2gP3yyn5ooRiqCEVw=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CY8PR10MB6804.namprd10.prod.outlook.com (2603:10b6:930:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 20:46:13 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 12 Jan 2023
 20:46:13 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 0/8] convert hugepage memory failure functions to folios
Date:   Thu, 12 Jan 2023 14:46:00 -0600
Message-Id: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::28) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CY8PR10MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 47dc3d8d-1cf8-4266-bf7b-08daf4de0aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YF/ywWXfEBrFlbq/tKhQ3Ddvoc7qLSDiY4zWKh9xhVhAc1bPE8ifMZkuqIG2nIPWDwsB8wuFsItrEZiLJreXkBfYhuQZQuQRKLsOEaBQTlaaFTMr5ufSdEtY047PGhNmkO3SBAc2XnK3kR3+PTK/jC4c9iaPHpfFP6SIgDpcarCvQFKIP6a1ZpjmpeGxq9lwjV/0wuXPcJbJ1M007dUTox0bTDWjoBjV/N5/34dJqaJtYNdfoglxzwHkEatJ1mMNYszpMJH/two2KEAugXOaWADg6G5lMNW7hknsmF0fDYWolYZDGxVcpX4/m8So9WW8vTuiRkFpM+2ELjBqlHd6u3jVNfcHzLcpDAPr2bYPNi2TXqJW4DSN1lfhVJUvWcaPC+LTWx7ca3n8Jkf4Gwv2+JSYfgISUnntNw8GA9/FWmwrh154RLWz0Pu6a1k08cnpGwIcmTGXAcwIgfzWMYQPCHxyQTJjNvZwUChHUPh/zH9k04FJDQ3nyFukJuEzcsSLqKbKB+9zu0uEuSLjKCgr2xJCvuTAOmIlHHKrgaJQrtd4Gxt5X0tAQGwkQbw3OfSTN9LZIfiowFLgxBfXt4XbIwTNbNvfCb5mqtIuHjiaXdZaKv6LDqEvmvh29x/9FQfaxup3KuJiQH0v1FyXYkB8Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(44832011)(186003)(2616005)(6512007)(478600001)(316002)(5660300002)(107886003)(6486002)(1076003)(66946007)(8676002)(66476007)(66556008)(4326008)(83380400001)(8936002)(86362001)(41300700001)(36756003)(38100700002)(6666004)(66899015)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DUC9K6IJDRLdEoQ3Nq6aAr813rYtddbiAs+4Lk9k0BHOduseFCjou+mgqFIr?=
 =?us-ascii?Q?nCMzMem1TnxwrcaOLPpYN9oLiGXJrAapeaFksiR/Ey+xPJVVGa5s1a74CfLq?=
 =?us-ascii?Q?MEFK0bmnUBpUsSOeuR+aMp6MDAH87bOi1bqC3urCd4HD0nhrbTEJuqpe46iw?=
 =?us-ascii?Q?+5tONaiYTQmN92MfeXfNAQ3dlK4L5kkfZpl+vn65WycShVz/C47gkv4cT0Wf?=
 =?us-ascii?Q?7+YM5IKSJh9CymcinTTF7FTpcE4V1RVR1dchyRiEuo/EyezgYMP/6CbxEMWn?=
 =?us-ascii?Q?PX7BHjQqf6NhovwNtxhwFCkPYpGxu09axUBKxTHEZo0Ppr5XysthaYcqlkV5?=
 =?us-ascii?Q?8831WmtyPFEyVDB78d2FYY+RNZf37OLb8hqrtDGKHZq11ZcpWAB/odRLtMKV?=
 =?us-ascii?Q?RZRlSXOLpnfIofB45jhH3LIZ+Ocq7AN3tmCgdoUSK3kSFzZaNUNNP3WU1L/o?=
 =?us-ascii?Q?2vHnVuepHitJI/rgfXupGa5x4dFOwGZnkJaWKK/OGSe/RYadyWKZu0g5Xg+H?=
 =?us-ascii?Q?6+hmu8SEw7iLLwJ7zvcSlKFMtSZg9t5V+no59V3WFmIC5Mf1H4YGgmuVsqDa?=
 =?us-ascii?Q?dKZ0twFuNDbOGkLVDJm4Zyyu7lT+EeW5XLeOj7vxcpoEs2ZKtRLlGcTlsnz1?=
 =?us-ascii?Q?HXqavwUI5pwPMjv8Xyk2X9Mc/cVHsgfwqEaU7kfaTT4PXzBjpYU/M0fk7q4T?=
 =?us-ascii?Q?SCTO+8b6Kb7bIzagoXhmK0/UyFfi12/8sX0MMUCsPRoyV3tp8YL6XsFW7PTQ?=
 =?us-ascii?Q?n0XvJmsbcoHOnef9FyRvLQPe5TdY3JoLqubfWLrid06qXrknzcKnPp+Me6zF?=
 =?us-ascii?Q?t1pWJjJTzeEhE1Zzu8+x7AHTYD2gVf3qSqhnlyKofQmIa/5Mk02siNN9cWc6?=
 =?us-ascii?Q?ypHafX2OKpt3PAow4gBlEwhHau8o35eWXjkIpNvbZJDwjdP8vq7p0bqM1JIb?=
 =?us-ascii?Q?WnEGp7SktaMwusT2x8bHxuTvfEWKJUffZCp4uO66ABQcAc1qsmAdrrRJiSgY?=
 =?us-ascii?Q?+MVbTSk6gTpiIAjggXk9li8n7B3Q8KFaTku430x05JZ0x+lZmYngL+9dp1pe?=
 =?us-ascii?Q?iWFl3XMcjXbjPk/HRTMYuoRMQxT1Y4p0Ne+yP1O60G+3XDQy+zpHU27KD3DK?=
 =?us-ascii?Q?Jqo2NzSh1nYrTK9UWDqAkG/im15IGYfmgYBvggKYGTUFDS3i3AdTySiDTHBy?=
 =?us-ascii?Q?sa5oJFo3FCea/XiSHUoMDA21iQMTtvH9qxVsMXX1SRCOgDpKlGrJhF2qwzW/?=
 =?us-ascii?Q?XbJDKF0o1dLxhHhpTbT0tWuy0JhJvLXM/BElg6hzYCGGcVL1m6TV5SAqmJhs?=
 =?us-ascii?Q?HjHai2cPjWw93Ob62YjNtpsR/Pjft7A4boBwl7i60YR7zEC1K+eR3X1OAHvC?=
 =?us-ascii?Q?L4p5QkH4UncQ9NZDDCGb8Ou/EQ9MdKwR6egD8+0aCPLVOPZcWBUZ1Svvf6E/?=
 =?us-ascii?Q?4neHnunvqjOJZbnZ7kNNhmgc7F160BIwp7aT8t9VhkXpqKac55E5r4O5OfuD?=
 =?us-ascii?Q?nxBJHx8o2wf0/lK3CpweDfE65xArttdk8exZcxmTMNMwkD9md1uW6oTlZ98M?=
 =?us-ascii?Q?WImlxlcJFci8hO9hvNVFxpzjkZ359C76WdXdjeGj8QLe4JWYL2OqQYX2KM6y?=
 =?us-ascii?Q?LdrAAIheIKu7bEUXLUMR/gA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CjaR6EPnWKuCG22WP26/Xu5JpdaVClHiMS7UBxE1cSPGGoI90CZGLvb8BRDC?=
 =?us-ascii?Q?vimQPadzNStXxqVWZvqdFuSx163nWKCy53O/s+Fwzf8ZhL3AqsBEWrcFmOnk?=
 =?us-ascii?Q?OzsMOCr6v7eq1MpmWiSgv9d+rfLAMomEE2lm3/p5dQIoBMykFN3tc3828JdA?=
 =?us-ascii?Q?z/3+6NaNoxu1JzFqUheDnOUJI42A87BVFUxxCbJ4UMeBnypXjtxtGpq0VCnb?=
 =?us-ascii?Q?rjcgBdSSg8SHXuOzlonGNKvy6BB877RTqG+PkP+1UDNS0COt3XF9SaPrBQv6?=
 =?us-ascii?Q?wwe1r++RLAPzWcYSnF+LTyHZ7zZMhO028+e/SeAfSVpQWuZIbHAHEwe4nOJu?=
 =?us-ascii?Q?YGYcu4aNIshu7Ybd9QTEMxQaWFCPWYa/2lnNAjjrkPhQucvjr0DextxMy9QR?=
 =?us-ascii?Q?HdfIPlsfWz47JzeiUho35EKiQLeufPw82gjf7s/V2R+OcIKLO4mPYN0z1hHb?=
 =?us-ascii?Q?lJ0Q59jkrD/IYoiwd4OsW2RWnbll85tA5OvCDUFwDzZ9WXn+/D3AIhVhFJbU?=
 =?us-ascii?Q?zaeFjafSVzApGVrw2t5Jzull7Ua/1arbDn4CyAqK+7fYU2+bM7gHSoQCqZat?=
 =?us-ascii?Q?mntDGgaA1YenRuL9nyfJVpMpYAXM/mOF0NO5XGYkiyoVTHV+qnDee5r/Kj9P?=
 =?us-ascii?Q?sOSbyQe0noz2on7Ced/gYap+Gwm0211RxTwR9HPWKD9EYIgo44tMCGJTeffV?=
 =?us-ascii?Q?LCftUUn57MrdBbnku/OPdx6ly2zUCpnuBdL5aSl/TlOiAW+XYkV3BP+2LeYb?=
 =?us-ascii?Q?FwPaDJyd8L3t2BIA3aF35oIWI0orzIvZ/jtUKSfsLqfSzYqLS1HSZHWctB8r?=
 =?us-ascii?Q?DIOF3hy8b/PmUmb5305QfWAGsr4nnBh5r5it17LDLFMi2SN0Mgk8ZAIOXZNm?=
 =?us-ascii?Q?2F+/qtuwYd47he+H9cekM29nWBkjICpp/bYksLLZgGj+221sg4RklYp6p8aQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dc3d8d-1cf8-4266-bf7b-08daf4de0aff
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 20:46:13.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbzHOas5TulDJo/BvndB/cFQJB3HqBNnI+9aPGCdo7kxcgdJkkZTM+q0mBwfiWbWf4mOAnrxgUGF1XI07S49BLWCMdveK7hY2f4WuG3izQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=583 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120148
X-Proofpoint-GUID: IwcPYTIKWB2QvScVZ3HMNxUx1I83k0hI
X-Proofpoint-ORIG-GUID: IwcPYTIKWB2QvScVZ3HMNxUx1I83k0hI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

============== OVERVIEW ===========================
This series contains a 1:1 straightforward page to folio conversion for
memory failure functions which deal with huge pages. I renamed a few
functions to fit with how other folio operating functions are named.
These include:

hugetlb_clear_page_hwpoison -> folio_clear_hugetlb_hwpoison
free_raw_hwp_pages -> folio_free_raw_hwp
__free_raw_hwp_pages -> __folio_free_raw_hwp
hugetlb_set_page_hwpoison -> folio_set_hugetlb_hwpoison

The goal of this series was to reduce users of the hugetlb specific
page flag macros which take in a page so users are protected by
the compiler to make sure they are operating on a head page.

Sidhartha Kumar (8):
  mm/memory-failure: convert __get_huge_page_for_hwpoison() to folios
  mm/memory-failure: convert try_memory_failure_hugetlb() to folios
  mm/memory-failure: convert hugetlb_clear_page_hwpoison to folios
  mm/memory-failure: convert free_raw_hwp_pages() to folios
  mm/memory-failure: convert raw_hwp_list_head() to folios
  mm/memory-failure: convert __free_raw_hwp_pages() to folios
  mm/memory-failure: convert hugetlb_set_page_hwpoison() to folios
  mm/memory-failure: convert unpoison_memory() to folios

 include/linux/hugetlb.h |   4 +-
 mm/hugetlb.c            |   2 +-
 mm/memory-failure.c     | 116 ++++++++++++++++++++--------------------
 3 files changed, 61 insertions(+), 61 deletions(-)

-- 
2.39.0

