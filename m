Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E63763CB32
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiK2WvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiK2WvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:51:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFFC1EEC3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:51:08 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMDsOP015137;
        Tue, 29 Nov 2022 22:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=tGmuZTBNbre96NHUK8JjH0uovdu0VRYw1Si/RwfIyuI=;
 b=mq0c2fsLy5cLmwupFkkaJnXjfa9zYMBaPrg9037SbEnDUQm5rgzI2/7j5eNjp/MHBPiz
 hKih/AB/PB2+3P06ke4/tKubolti4/ej10YLGGc1UxBuye0eLkv1qscxo5ZFmYCoZY/c
 bqLyyPf7dT/9WxPRU/p8wf1c2giUrVviXdyKDX+1b0mu7M7K9Nbd6DvrpdFV7f7MKODP
 V7Os2IPnOpkRB8Mp7JrBcJmlWz8Y2DYXrPKsf5ivZ1mp2T5j5d4H2MOp5KHb1JOvDX8M
 YrUUJ2eZH0ZE4LzrSp8L5w22L8owWxO1orgjkwuxNg0NCcs3ZR4++QTpI86PokU6wySA XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemepjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATLF0FH027905;
        Tue, 29 Nov 2022 22:50:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m39881gmu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U26riPB8rzpZD/mVj7xcQmCmmSme7gVs69ABJoz1+o4R3aGcIu+MQAWe3AhA0Jhb6BiwoCL+dB++cLpwj63JUes3P5oCh7OR1MHyd+ynco/o3btc85rVbt4PS1ub/qZ3/n3tWKw7i7CG+0XEjsn0WE/zkPJz3s89UVPHxKTvZqUPdWUoxVnH9WRUlsAoi4uSm6KU/stYb48HbsZTx3kBxOXCbSfet8iy6qPKLrSxnQNbkFRWCIE2hGgQPFZToXYBn0PbSaRGQiyVv+pJqN8+HzDCPz32rcyvltKVGeCx9Upg6JS+fArGEOUh4mlMLvJF+ngFof1TjNRrie3G29lzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGmuZTBNbre96NHUK8JjH0uovdu0VRYw1Si/RwfIyuI=;
 b=krEfZmyNKJ4y+YokliQLhMoy4CU8y8x2XxulJtlPdxz8zo3eyCHBJKTqt4aR+EhN4Ox2dD6QhERmODSWCUce3RuGJRcOMBQouCXpaEd+q1mP3BK4N9TcLiY6x/5Zcv0MnKXsmLv6iFc5XmxVdRctrX8UNFn2xA4dw59YIcdMzG3x+qZe2BUwYAR42Zv8Zd5iiUnRazk5slUIlDI0HNKBYxRlglDm45aJhw1lgyyN528WWueOWLEW0ra22w/2PTvpbkzHL4XMEucn9Qwv7pIjv8RgOP2I7NrM0bQ5VHJ9NKH8Rb2b0ZV29YVUiLwX7QSUkWkLl+KSVu0JYJ3FMEFjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGmuZTBNbre96NHUK8JjH0uovdu0VRYw1Si/RwfIyuI=;
 b=btFQdzpreugE1+lrF25lSUv340mhxEHm9tpb512aC8S0k1OadUrQ5014mIQeTYgcKPW7KqiaE6KMnqbiUuKWLTg1uTZS6eg1TvfV19fYu2+caURdxoXE1lZavY00nvarju9C21O5cN5m/+RdJTk8LCdCGVDgRrq5NeTEzPvlOao=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 22:50:44 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 22:50:44 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter functions
Date:   Tue, 29 Nov 2022 14:50:30 -0800
Message-Id: <20221129225039.82257-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0397.namprd03.prod.outlook.com
 (2603:10b6:610:11b::30) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c488c91-f80a-409b-e44f-08dad25c25c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tVBZRxKrWWNI02ikFOjc22TlbxwdcGSSV8d+RCfoqU2sMGnUcWiO9ceXTvmzjHZ8AsGevv2FlXUuFkSIpuaP8cvvvEBFdjkzPEy415g65KHjN45v8kOdeSnb0hBWJuRDsjIWoitIyqZSWbYV0hrSVpm94iZu90rh/9i5giSB/EEtQACElPL8gcJJfybjiUCs4htToDQFETRcuyKYPJtVSIqUscfozxjxEzyBOwbpuJHjd6oQF1jt3hhvY84ZB2tackTbXbzZxuaaLbZRxIUE+eRcGcEUwcLqZ5Iuetaa69WeaAzorWOZoFv9ERTgX1UoZQpcT5w3WXP57pwMsjnZWf3LA2Ifl2kBYfQXe64itfmDCqY0K2FNz3oxsicEsdWN5sANGolyCJEskz1OtNwUHiyX197Pk0ZyDhVK94YHzZl0G94M7iUG3aVCwHt0FD7xEV31QLJ+hW5EmZ+V/qkpdq8nSZLxBT8aJ//M36M+GW0lTQgvZMwcqserY8zokKOWFm/pZPFNcH78lQ/MIAgAlcZ38owgT0GcSM+vsj0EbusggBvEzyOun3y80uNuxj0hlQVdPqRQH2rT8wgqif7icKFL1RzMBtADB+9QAIn81T+Z8zQMXBlxkRld8Xw2qig
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(2616005)(6486002)(186003)(41300700001)(1076003)(478600001)(36756003)(6512007)(86362001)(26005)(7416002)(83380400001)(38100700002)(6506007)(8676002)(66556008)(66476007)(4326008)(6666004)(107886003)(44832011)(316002)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hSrcKvGfsyqr07KCR4Jld6R0dVwsBaAsOpwsEPxk7jgFZctCHnJFdMpaZRyI?=
 =?us-ascii?Q?Psm6IklvnDr1HhakFHrV/TlVS01JdWk6dOLI7QOQftMHygGjK8mKMkHUpAis?=
 =?us-ascii?Q?AvXHUGggah2XnfDpqnm0YvO5rgdoNv+o6AANO7Z4eY4da0RuxwxgiwvvKD3p?=
 =?us-ascii?Q?M3Y9Rjk1MIFFEJp7HiaaSaSDMg9ciRyeIUoyXMVYDKhnKREBLHLlH4qnmTTB?=
 =?us-ascii?Q?GMb7CA7vB+jHpgILQyzSwpha9rC7yG7VnTTIte1j2PzPQE+IZX7PlGzSTVtQ?=
 =?us-ascii?Q?YetwbS7NvZ7ReOM7xYEQmdFP+OsZLt939JnfUtU99KS2PzWanDiP9Wvldyoe?=
 =?us-ascii?Q?hwCPNLxomemH7/HPGQ4l80cbL3YS06Ps6hSn+0LllYt377+uRma4a43JIsdo?=
 =?us-ascii?Q?8IgqiqS3EY/8wb4KcmEr2Y0s+P8CAhgqZiuQ5ykiU7gkj7rYNIyJ9mqV84C9?=
 =?us-ascii?Q?TeWw+x1WeEFw/H1ItkFCmRPbKy08vryUxcKD8f5u8v3bKeShXO48+4a3PnLw?=
 =?us-ascii?Q?Iu8ZzSMXwHcVWFUgZIZ7z5LKYHkjlxghxN0PiKO/bova4Pey4da4jIbZRMtn?=
 =?us-ascii?Q?J3xM1LMK1omAGSq+EocBO04wJrfTuOZACkYOchk5x2deifL6OX6XgwilqiPw?=
 =?us-ascii?Q?9JKD9QuhcqMfHUGZhXNzQuVT+UW34afjPNbC+pFQbOn1g4/qBBPsBJHDsaGU?=
 =?us-ascii?Q?hpaZoycZcTX7PqMf0wjCQZJdOmmuReutVLcAlbB0UOQ6oGoNh6qUC5WLDboY?=
 =?us-ascii?Q?Ti+FRNmV2FI+5QHfcWVJmiIt09XmQqL13/aFEL+/Y3WViO747faTENb+JjBy?=
 =?us-ascii?Q?DtcPnOUZ8wLgIoBehfhNhj2iVRX96nREf8wSaC1cElQ+jDKYq9OzSfCPUilY?=
 =?us-ascii?Q?GGfNX8OUo9HnGW8ZSUJ6nlvtWznMtDp6Fk73c9Ax14cPRM6dZKR0BV9tT9YH?=
 =?us-ascii?Q?nUx1Xc71/jzB2DxO+2J0wFk+UzC+AS0MskqHpsI7NaP+xURfCmEN0DZkTZsf?=
 =?us-ascii?Q?VLx1WHps+Q0cixd4R82J7tBqZkZLDst44up1i5yQ3bHddf+aikGGleJ543lv?=
 =?us-ascii?Q?xybCE0RRBP6JOfxCp85MbS0S10IXfYImYQP1Vy8xRRHrmzStQGRf3L6OSTBY?=
 =?us-ascii?Q?6tY3T8HHmAskHa+GvBe9GUN0YMume7V4lVlzoKjTmKmpF6FXh8oZfmHDsrSq?=
 =?us-ascii?Q?1BI52u6lrTorYqHy/hFeWcM16BWVsh6L2yOu6ViSkS5W2xR/N9XWqEBAeyAm?=
 =?us-ascii?Q?21BVNN4pV8EOHrAoXIqR+pgihMcmr6XNXkJx85JLQnPzPUvym4UTidN+mnH+?=
 =?us-ascii?Q?nrnb1xlzq72Gs0QaQV/3FLiYPOtDWy8hOaGk3AjRfmoDdZE4E1hchuCkwS/f?=
 =?us-ascii?Q?1cu0OWzcpd7or5+Q3rv1CBqBBk2hcTWZASY9x7AxsXEOmD5UrBlIVtd1/+6C?=
 =?us-ascii?Q?ah3lEtL6d/SJJZYc7gZL6z5RLwG6YL1tFF23WJm+YPA2LDHfcEPy8MkzWaqd?=
 =?us-ascii?Q?vDfmONG+yBSgwzEQIGbPBfKUZKHy9tyzvTPUpNUmcd1H3rj8O11Z8ld5dvV9?=
 =?us-ascii?Q?3p0mSejDLLyPy4SiqEMstNlxXDPRr6QmZsczhZlX1sr6HB6U7jxs0X9t8BgE?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zw5eKEqYUMj5vYO9d0dKyNUC4BnQ9HaLHzRJXHZziK2VdGLnl/lnIoNLol+t?=
 =?us-ascii?Q?O55ihEIurlhh5F8nMwhdX27OT8azvTHnWPxYCH+zQmbFZDADoFFMWWytzuqE?=
 =?us-ascii?Q?fy8QxcPB2UJXKrA00EsHhhdKocc0uJiVNW9aKPduDwPhFJo3BeQ5TKSLNPmZ?=
 =?us-ascii?Q?IQS0t53m+TOs9/iLvzWhtDFwvuYyNiKALWUfKy6gXODSyOUmDn1izE+7L5cU?=
 =?us-ascii?Q?OTjlXPo3hR+43zxTRksJ9nnFA27UnunMMTkjUy8cfwwKGZqG6hhm/2cslcaB?=
 =?us-ascii?Q?E3SHvf7ZAUUkGP1vUdBJYhA6IdM5FR3cKgzSrimfJGaVMw3BLDnGVEClzFNa?=
 =?us-ascii?Q?N5H44ayvOq/PM8PJ9UIOHIiBL+7fWYE4AkHMNCCNJOOzprDgfJaTHZDQXffI?=
 =?us-ascii?Q?h0W4Rsol8Z19Ouh1TTg7yUgeF5xwoOTxR1YXYwiScJZ/SfKq85/UjJx/1FVG?=
 =?us-ascii?Q?dx88ep4lrsG4NqFRVaxeu2dSOOAo9PfJFsRpk5Cof+0yVo0l/WOpIy9UTTgE?=
 =?us-ascii?Q?W23N8HA8kg1KirAI3UCdkMohAxx2appQxgx9TnopnEv4rSuzvgrF9wikhdd0?=
 =?us-ascii?Q?KKvOj2tvu/wuwnxI8+s8cz3m2nVmflw6Bi2wRfm3KQcHyeoM76T4zoy2BvSv?=
 =?us-ascii?Q?YGCJwSl9ye4FufMGTjBwldv40Ll7n5qUyCYcTCSJNVH2hkRb/7maHIeh2KgM?=
 =?us-ascii?Q?6mxvdN60/ydDnfuNkXE0AiJaR7hjFRVyPwjPJMhtvzN+p+cdLaHPGCje0lfI?=
 =?us-ascii?Q?saxCjFXLHqGSrIjPhYACPf1+WC2ywW1i9jeksFfATS0EGhE9vTl5sj3/mdoO?=
 =?us-ascii?Q?+PU5wsmDCqlMd2AzvnGp0zs/Ys359p9jWen75+hUfxd/zZFavtblTZRSCEl1?=
 =?us-ascii?Q?I+QpH5ZyAydGh1dEwSO4PBwBOEuIyNgk/yaqHnmGIkltbnpAhwT5LNqWZrnS?=
 =?us-ascii?Q?uytJXAJoEU737I1fIMx3lnvs4i4BuCEBgt0R0ZqxhQEy/E+xrmNVZ4uS+uSV?=
 =?us-ascii?Q?S0YzVqaJ/g0lSFZ7+bRIh0T2kydYh9QODXi7WqWYSkkI5xsiVeziyeRoWJd0?=
 =?us-ascii?Q?v7bb0+RZAR3YpN4tilTEEsarx2nQk8C8c+QWZorDiZCn0gZ+8Ec=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c488c91-f80a-409b-e44f-08dad25c25c0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 22:50:44.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykDOd7EDrmXoFetYWuu43ynh5LPKcPZ9mg+D/axNHBDvQNopxDWiJNjJzsQae4sDhuadQlKnIsnfnYk0tIKQgtE1ElX1RZ/hrfiCIfPUNYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290137
X-Proofpoint-ORIG-GUID: VufT3BYM0vTRovhzMkprFtWtqClY2Vd3
X-Proofpoint-GUID: VufT3BYM0vTRovhzMkprFtWtqClY2Vd3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add folio equivalents for set_compound_order() and set_compound_page_dtor().

Also remove extra new-lines introduced by mm/hugetlb: convert
move_hugetlb_state() to folios and mm/hugetlb_cgroup: convert
hugetlb_cgroup_uncharge_page() to folios.

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Suggested-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/mm.h | 16 ++++++++++++++++
 mm/hugetlb.c       |  4 +---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a48c5ad16a5e..2bdef8a5298a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -972,6 +972,13 @@ static inline void set_compound_page_dtor(struct page *page,
 	page[1].compound_dtor = compound_dtor;
 }
 
+static inline void folio_set_compound_dtor(struct folio *folio,
+		enum compound_dtor_id compound_dtor)
+{
+	VM_BUG_ON_FOLIO(compound_dtor >= NR_COMPOUND_DTORS, folio);
+	folio->_folio_dtor = compound_dtor;
+}
+
 void destroy_large_folio(struct folio *folio);
 
 static inline int head_compound_pincount(struct page *head)
@@ -987,6 +994,15 @@ static inline void set_compound_order(struct page *page, unsigned int order)
 #endif
 }
 
+static inline void folio_set_compound_order(struct folio *folio,
+		unsigned int order)
+{
+	folio->_folio_order = order;
+#ifdef CONFIG_64BIT
+	folio->_folio_nr_pages = order ? 1U << order : 0;
+#endif
+}
+
 /* Returns the number of pages in this potentially compound page. */
 static inline unsigned long compound_nr(struct page *page)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4c2fe7fec475..6390de8975c5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1780,7 +1780,7 @@ static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
-	folio->_folio_dtor = HUGETLB_PAGE_DTOR;
+	folio_set_compound_dtor(folio, HUGETLB_PAGE_DTOR);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
 	set_hugetlb_cgroup_rsvd(folio, NULL);
@@ -2938,7 +2938,6 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * a reservation exists for the allocation.
 	 */
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
-
 	if (!page) {
 		spin_unlock_irq(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
@@ -7351,7 +7350,6 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
 		int old_nid = folio_nid(old_folio);
 		int new_nid = folio_nid(new_folio);
 
-
 		folio_set_hugetlb_temporary(old_folio);
 		folio_clear_hugetlb_temporary(new_folio);
 
-- 
2.38.1

