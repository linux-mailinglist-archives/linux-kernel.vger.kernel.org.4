Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E285063CB39
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiK2Wvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiK2WvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:51:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85671EEC3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:51:12 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMDrpT003552;
        Tue, 29 Nov 2022 22:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=VEjluJMxaaae4AwJxe5SeRqJf5l90Dwnlg9eOn+TBrc=;
 b=rdUq6asB04bq4S+8JctIthM7n90/mFKk6Mh1v3Tykh4ji7X6OWUfg8Z9qJTdPlUR1QqP
 NqRfFZWEgzo00wziieQAdOgL5m2arsU1ObzGdXuxP1aPbJuVT1Wjf4m8qHXgohTDVzBe
 09dmRB1VHYWXP8eklmh5C/s+0SMinsdnyDAbIjZ+b4KDTb7CiTkSyl7ZH+9Qm+G5Cn4C
 ET2+cuDXw33ZAaXKLpOe6mxoVYd6HeRnJp9wQ4B1UeWrW3WU3zrWb3z2ZXoRqkP8fvcu
 38dMDcJZvcxijLG9LcFgU6/he/zRKE9Zh7E5vzQPsFpU826Qbem9XkyRaDhPLeSMRHQ+ Jg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3yddv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATL9k2P019333;
        Tue, 29 Nov 2022 22:50:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398eax7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdaLa6CSEk2e2HLe4/TM6bUloAqoO/Vz3Y2sK1vlKj4WGmAfk0feavCxR6DC1aCpUF3kuuxlpBVH91rqEitz7k31yk1LtzAEWTiKCxWLc7B5uicqZYDAFoJG91wzgQELZuQm7DRXD6dpLCc/C0vsqYAfisuJWqHjf9LxdBxCSE+q3L1OXD/zWceXar7DjiX1YNgxj3ZeV7UwZ8YNhG0wVBUEvyjAZRZYTmF0vNcISLNk4yJmn6PHe5Xh4/FG19jxULAPRpj/oimTtJ0zPIgLD+UdsB2aBRzGP1RpqwDkErL2vK+uTdcsBgnZ24GC8joDu+2OGaSLuRhBlUlZygxydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEjluJMxaaae4AwJxe5SeRqJf5l90Dwnlg9eOn+TBrc=;
 b=ZNcKaLc5Ze9QaVVVSxa8PSHW9Ir+9hHw6BzrTivljrhrtskYBqhjyGE813rX4IusUQXiTMWabVQKqkMQEMYH+RaTcxce+YsT+d0KK8ktny9RIid9N0krvPsxOMOgISV0FKwi3NsRc7P1JbFBvjKwaRS/X409AqK9ZmqwNGktay1b6KFHi2tj3iHlwrEuwWnFdMj697N49hN7x+AKUj3n+WGk8VLG87PSiKBNGnz/OdRDvvAJPyIaDwFctTGXyuxMacLXeWfh1mO1x7MNu1RpF6/oVIVdlnXm+8caf0Z8EYDWlaazbEwlESnjZ9CJnkBFc1HMqAtKFJC/hAIvW53srw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEjluJMxaaae4AwJxe5SeRqJf5l90Dwnlg9eOn+TBrc=;
 b=mmU3WTqaxSvSDSsUwNFrFT6Y5TE1/A1eRQGVgh5vEfSKMwomCrI84wqmGS6tjE1BCOv2j0czUccaXCspiuirgax5A4HFe6rHbwj53XRDoS78YTswOep78DHbLZXoDbfPJyphWR+eLjvheK3yq/P9xnCkhkTDPA7XcVIXnweu7bA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 22:50:54 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 22:50:54 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v5 08/10] mm/hugetlb: convert free_gigantic_page() to folios
Date:   Tue, 29 Nov 2022 14:50:37 -0800
Message-Id: <20221129225039.82257-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:610:51::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b3d9ad-0e28-4aad-49f1-08dad25c2bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SxxuUHRt4+B/KHMko0C/zo3Sq2M1RkjR+7W3eNBa/k+7fWKZNlB/u1dbAoLWSa9YJ6Nzk/3Dg93wdYIVjUwFblvAvjw/EEljQx9q/fKhBvT+QOKBfdQmBD9WjsOouDJ2Xs8UOs7XphO4djOrDmQyZ7d3vTFazTIR3cjjTczWFx8haqhmN1jr9ICRMtTaDKkxLWD258W8a4dgRscwXlwky1rvJ/s9Au6q+rZ385X7+56AgnvPZTUZzOr5wHFS3NrREte+qqtBF8VHxV1kOIyc8zR8lL7j/p0JmbqQgbpLmUxYO47oqLZzeSo4j5YX6f8b17Bfe2BLKkzcbReMKRdTIyecR02+RzqYcUliqd06c9eCF6ho3NcI4trgyNN4/qzE2UR/smZZ2vd+oO3GPbKE2vApVfOInCAh42bHCMtfkw9lAd4D7lbEWrNSMMGg5lzIKPbMKIqUcI7NDFnrw48Ukz1gE0GuxMX/J941U0SGgax49hM9YqFRwKRbMELoxaR7WDk4v73OfpajDc+ykS2nWiVjaFp+28l2Lf6lhnNf3WKFfXNrY+SC6DVphfVwOrEtzqIntcbxtlRi9k4mCJnsvTLbZDtII0n+c7JSufxDBExajFgZKZiplwKmg4y8T/cEmpI/rTmm0ufaukI45lo11g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(2616005)(6486002)(186003)(41300700001)(1076003)(478600001)(36756003)(6512007)(86362001)(26005)(7416002)(83380400001)(38100700002)(6506007)(8676002)(66556008)(66476007)(4326008)(6666004)(107886003)(44832011)(316002)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bwR681NMFRJ4/akGQMeZ//uWJAXAGxSGfZGHGv8zU8vHTIX/llrYhciG79OH?=
 =?us-ascii?Q?LTJsUnR011JUsV/TYGdpVS0FeAreAKhSz3elmsB/b1MwR7UJg0+7bsA2dIPv?=
 =?us-ascii?Q?RDTxjIiDa7ZMhYdhDsSQhElkmPH61TZeMyohMUWje9KHbqDQuKzRi3V9deBx?=
 =?us-ascii?Q?PghYrrdvAz73SDt2nleiw/6EuOjEZIMD75UcWXriqNHT9tURrt6e2kGGKT/x?=
 =?us-ascii?Q?yU6orC47awKbCwFzA11FWB1AQPvm+NJyOsJ+pZdTWqZdI5RhU/gCKxZV6Kph?=
 =?us-ascii?Q?vlkRxy76KfXPxYff1utU/pP2AlqQtMIY81xXVM3MPBebgZgDcSoq8tw0aAjH?=
 =?us-ascii?Q?7/Q6AitFf/6hM3ASyBqVE/xxnc6saKD4xt4fo/s6mRyrlJM++0X0o5raLQkI?=
 =?us-ascii?Q?o8v9XERn3hLNlw/KFaP/y3aGT9w7EwHrN2ju/+8aaXCDlelmg3worwFCA84E?=
 =?us-ascii?Q?TCYcKC6MtRTJ5O1aqV9u5OjsHsuQmUZHH/Ld/aBz+fpMyXctmjKU/UGH1H9z?=
 =?us-ascii?Q?/qm5NU3Gyy9r3RBcaid6qxdlaMZiLpwS9odG3RzNHqrn++IL5gQ58r1LC59x?=
 =?us-ascii?Q?70tb22oXoYf+WYzc7/STW73Zf7i+DkrfQb8vrcGUX5Vc5kz+D/hiGOpSEQBY?=
 =?us-ascii?Q?KTWPvNX+io8SrjHhQmpdneOW0gtC5BRMAIgmcnBmYB6hBTeLdxFXVQx+pXqi?=
 =?us-ascii?Q?9V0tmARbcohxXyuN2HghtntLZpNZgk3TxOGQlS5kF4BgkTx7+goKsmoe8XvE?=
 =?us-ascii?Q?gBzF0ulnMPWFgtpQKwT9HpD3opefZp0FM7t4mzJfeGkCFQLrswcvJLpNnn1V?=
 =?us-ascii?Q?hppfz48buITyZ319yoM7vzUMO5mk6BkDNZ6JNDQf89x/+cKMhLl+iwRZ7X3z?=
 =?us-ascii?Q?6Vo4bKnNi1NduGwtP1bn66qW/zfsw4ANd/p7yt0M9NmbOdMRdRh8Abf7fG4G?=
 =?us-ascii?Q?a//cVPt18olyp0aSP8UnsTr1H7d5e+YTP3SApRwnQKRmq8BmjDYPRInNj8Nb?=
 =?us-ascii?Q?EADiPw8QBVQjotQiHg49WOQVZNvJrYOnq6iRIl+hUIirsJtZv82o+AKgEG8n?=
 =?us-ascii?Q?hUfjBFwhgQi2G82EQBrgbMeLwPlE2r5xvoAd8Okwv/8P65gf8140widz1jLe?=
 =?us-ascii?Q?D1icIrZYbtqRwESKwIFEAwURJeixOgXxLFlBBu/5+f5KoV1oD/LxSJHPFNt9?=
 =?us-ascii?Q?+DpfKc+sSsth+hlJ4UymK28d654sVlw+sFElWUZOcEKSzSPGUfmGEpd38fkX?=
 =?us-ascii?Q?m8OBYHQSwYMFRfF0uiZs1SewCLZEXFyGlHnodBxF5nyL+JkI41QDxqevzE0b?=
 =?us-ascii?Q?1lW4rMagEGUJpBg/5II98caaLSll6Eulsn9FTPpw0oej1TS54VUsMc/lzGy3?=
 =?us-ascii?Q?0sB9CSKVsX0X4uAEjfNU6SKlO45aXsiiI5FP2nWNvgDV2Oow2c2Bcp3DpDDS?=
 =?us-ascii?Q?EIiOZ3ojKUu7Xv0VYUTVo+sMpuuuThHjCCRbOnCYohVwSA2/bAZ52O5ZHRvl?=
 =?us-ascii?Q?/u3yrntpoaz2Many7kVk/iEHTEPNNJ9Sj3ByGp0nSHGOZjKZ1GG6L88cE5yp?=
 =?us-ascii?Q?TNMjQvwl2Odt8cBmI6gnvLKQrCofffxSuQIyiJj/R0dFp5b9WdFtNnqWbJ2l?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZY69ynzMqolXsszWV0KgH15dUkDP5ahmvkQ1oDrvT/HpADt2gmGkAmJNSqvk?=
 =?us-ascii?Q?PeKN0cAlIm4K05ydg788ieP3rHuqD5Z0lqR8RxaMUaGdzA3eITllR/oEMOFd?=
 =?us-ascii?Q?cWkQfRMuMQIsr/+FmGxqntatToVf+7GKNHUAuwBSvmy3lb2SNccSqAxvFc3+?=
 =?us-ascii?Q?of+SpkP1cfPlvbhfMaM1Ov6bANuThJTGuGRNeH3lsxXtILmPw0NpFV6GIMB9?=
 =?us-ascii?Q?r5E+Lf84BsgYiRR8IaeG7LP+FsvsxBSgKYxoZ9s04ygtRieIxjrNl0vv6Roi?=
 =?us-ascii?Q?SHDCHig4c7690bgjs2kRxjT2lCEU3J7xBrZw5Un6VDdc5xK4deeCz/BoNpOO?=
 =?us-ascii?Q?d/JqUE5mNdbAo3yAX6q5/4ck1nuLZpR8vIuVjYCxgeY0DEhKfCMN3OGIv6UW?=
 =?us-ascii?Q?K3Csvjo3ErLUY6feyb49qyaCL2c70xgS6As8xSJfcx1r2q3MUtUX58YnpvwL?=
 =?us-ascii?Q?jGCIMt2RIF82GqfTbKFaqDalHXTb0hJQlZSg+N2zsycpjaAchg/FJtNUzM2X?=
 =?us-ascii?Q?NMhFiCQzGFNKMSqti9G4X0HISEGDlvaNKNWTMG5c79YIe+PQRCJX5etV8H8M?=
 =?us-ascii?Q?BjnkOG4LPCqaNX/j6291++CNv6SYosvxDbkNRmxr1yDWAcAGA8CVDUFGNqE0?=
 =?us-ascii?Q?4i2u8SN0mqCd036eNk3QiEo9+J6E6iZiA6jLCAIO/NqrLOopEdXhrFaiBjiR?=
 =?us-ascii?Q?QKDADvFZITGFVOJXFjuSqiRipq2OjdxsroOllG0ob/Xr2vYUoN29p5RsGVvK?=
 =?us-ascii?Q?ZJBiu/jHweQYqckRsvBS1YxbiyxpkUGUdumCVLb/s04L5tTdV1qQaw4M6VM6?=
 =?us-ascii?Q?1XCvE8ns3s6niaFkmKOUrwUVTeKxGVWHlWLljEmb4msc6t8cIMeeV5lsxoOd?=
 =?us-ascii?Q?T+hNN7JY2lXoqylLKbzUC3fa4bM8jlKg2jtvu53RFZ9dXD7HI/ttQ4Zh6prx?=
 =?us-ascii?Q?YlYXPjqAH8+LPt9TiV6JMM+4ivX6CsZBrCFH3nMgjFIEufxDf4GNs7uv2G29?=
 =?us-ascii?Q?cFGmezruVfMJ/Wg2Je5ZVbYsX7EUD+5u4oWGjemkg1GL5jUq51Nfl+gU/DBv?=
 =?us-ascii?Q?uP1vRpqm947fsV0pxexi6jw/yRDECvG7eM5BgYIP23XITDgk9JM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b3d9ad-0e28-4aad-49f1-08dad25c2bbc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 22:50:54.4417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhXLrsLiKFd0IuWiYi3NTDIAct07rfrBhSEENQw9paVwimf/wKSCMITkdZO8BEObWJt2zkSPGVj1+ruNfKt/YORBFTC9b7lPl/iVDEnEDXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290137
X-Proofpoint-GUID: LyypGqLyMKerSw-r-tHOcNGzAUezfYBZ
X-Proofpoint-ORIG-GUID: LyypGqLyMKerSw-r-tHOcNGzAUezfYBZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert callers of free_gigantic_page() to use folios, function is then
renamed to free_gigantic_folio().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c889593d5053..5e580ab834c3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1361,18 +1361,20 @@ static void destroy_compound_gigantic_folio(struct folio *folio,
 	__destroy_compound_gigantic_folio(folio, order, false);
 }
 
-static void free_gigantic_page(struct page *page, unsigned int order)
+static void free_gigantic_folio(struct folio *folio, unsigned int order)
 {
 	/*
 	 * If the page isn't allocated using the cma allocator,
 	 * cma_release() returns false.
 	 */
 #ifdef CONFIG_CMA
-	if (cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order))
+	int nid = folio_nid(folio);
+
+	if (cma_release(hugetlb_cma[nid], &folio->page, 1 << order))
 		return;
 #endif
 
-	free_contig_range(page_to_pfn(page), 1 << order);
+	free_contig_range(folio_pfn(folio), 1 << order);
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
@@ -1426,7 +1428,8 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 {
 	return NULL;
 }
-static inline void free_gigantic_page(struct page *page, unsigned int order) { }
+static inline void free_gigantic_folio(struct folio *folio,
+						unsigned int order) { }
 static inline void destroy_compound_gigantic_folio(struct folio *folio,
 						unsigned int order) { }
 #endif
@@ -1565,7 +1568,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 * If we don't know which subpages are hwpoisoned, we can't free
 	 * the hugepage, so it's leaked intentionally.
 	 */
-	if (HPageRawHwpUnreliable(page))
+	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return;
 
 	if (hugetlb_vmemmap_restore(h, page)) {
@@ -1575,7 +1578,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		 * page and put the page back on the hugetlb free list and treat
 		 * as a surplus page.
 		 */
-		add_hugetlb_folio(h, page_folio(page), true);
+		add_hugetlb_folio(h, folio, true);
 		spin_unlock_irq(&hugetlb_lock);
 		return;
 	}
@@ -1588,7 +1591,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		hugetlb_clear_page_hwpoison(&folio->page);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
-		subpage = nth_page(page, i);
+		subpage = folio_page(folio, i);
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
 				1 << PG_active | 1 << PG_private |
@@ -1597,12 +1600,12 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 
 	/*
 	 * Non-gigantic pages demoted from CMA allocated gigantic pages
-	 * need to be given back to CMA in free_gigantic_page.
+	 * need to be given back to CMA in free_gigantic_folio.
 	 */
 	if (hstate_is_gigantic(h) ||
 	    hugetlb_cma_folio(folio, huge_page_order(h))) {
 		destroy_compound_gigantic_folio(folio, huge_page_order(h));
-		free_gigantic_page(page, huge_page_order(h));
+		free_gigantic_folio(folio, huge_page_order(h));
 	} else {
 		__free_pages(page, huge_page_order(h));
 	}
@@ -2025,6 +2028,7 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 		nodemask_t *node_alloc_noretry)
 {
 	struct page *page;
+	struct folio *folio;
 	bool retry = false;
 
 retry:
@@ -2035,14 +2039,14 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 				nid, nmask, node_alloc_noretry);
 	if (!page)
 		return NULL;
-
+	folio = page_folio(page);
 	if (hstate_is_gigantic(h)) {
 		if (!prep_compound_gigantic_page(page, huge_page_order(h))) {
 			/*
 			 * Rare failure to convert pages to compound page.
 			 * Free pages and try again - ONCE!
 			 */
-			free_gigantic_page(page, huge_page_order(h));
+			free_gigantic_folio(folio, huge_page_order(h));
 			if (!retry) {
 				retry = true;
 				goto retry;
@@ -3050,6 +3054,7 @@ static void __init gather_bootmem_prealloc(void)
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
+		struct folio *folio = page_folio(page);
 		struct hstate *h = m->hstate;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
@@ -3060,7 +3065,7 @@ static void __init gather_bootmem_prealloc(void)
 			free_huge_page(page); /* add to the hugepage allocator */
 		} else {
 			/* VERY unlikely inflated ref count on a tail page */
-			free_gigantic_page(page, huge_page_order(h));
+			free_gigantic_folio(folio, huge_page_order(h));
 		}
 
 		/*
-- 
2.38.1

