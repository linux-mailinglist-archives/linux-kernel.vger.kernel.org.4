Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B3A6759E3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjATQ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjATQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:27:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35451DF96B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:27:38 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGDiEX014953;
        Fri, 20 Jan 2023 16:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=IzMHcWQLwYjfKZ6H7eGpUqZOzos98KPjiKb3gCvpIlU=;
 b=oWoPqEwIUL5GKj4xAYR5o1jdwCVQyim6DDILC139wyyXVvhTi04XiFkhL06Y9te58src
 d4C5vB5bFTXEvGMO2QxZ1Mfk/NaXYT/Hdewo33cplgkl5OTOiCCKZNsPpsvF5fDqZat3
 U4nbdII90PeqSJDRAB7eFLvxJjaP7Xu7VG5baQxTjufjXmpRsMcbnOi/bNoTAq+e+fZb
 KfXBWxSDan+zbyjhGbi6qKO5dWekCR6D7mFHQCnu3cecfz9OtwSX51xTIUZJWSdtZ4Ch
 G2se3TqSK8/pLnl7E2Z770ZmHpaLrgIz5BPktcVx4KnKzH2LZobSd1LK9LtdttvhkLsI 6w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxtd20x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGBRCI013478;
        Fri, 20 Jan 2023 16:27:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmfax1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoVDeFOAzAeqnd1ihucP0yWJ4v/+UdSgnXwHbsgIDN5iex5AvYzNzZQwKAfcYnaC3kmZZQJzZLCVOm+x6BAMKVbLJz2Cl/Yk9OmlmJzi+JaqLyCBp/8qARbHU4W2Ys5SEQl3F4F6oRl8i2QYD/ImfijQlElthKgRAk6xBHpjLIE4rVeyDWbLSIdPQNt7WBIvl/hEeJXlQPkpDTB8Vc7Qd5BJnNR62lTdyTt/ySDp3GUyOYj8P8UITxiR3ziXkL0Qk96IPHkWBoc4Z7l2ieqc98cuUf46o0c6f5KvfbJKj/UoQMlOuL1gWKUXOgaHMgsrU1UDl5wuD7OVi9HNwsBwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzMHcWQLwYjfKZ6H7eGpUqZOzos98KPjiKb3gCvpIlU=;
 b=RkcdGqf/tIkSujX0E91SAylgNeJIvp7t7igyVwR0yQ9JIsD2gy9JyhTO5YXLlbNyqAwy+ur6r1tirQRdIl6NNwVIQxP6U1clyHB3P3XkOl4EQehLnSXPGIW4PD4htNbqxXmAY6wcIJr4XeCIBwvN68Q4gxJ293oZ7VCjjNd9rPZjzHtcWFnyTOPDDUc9E0SOgGI8Sd8jTUBzwtypwl7oX0yk0WNl8F+RncKwrHo1wMf81ffIq4QQuk6/3TpJemI/H79lkw0mLyKGH2lr533bRlnsWZTHBts1SvClSr4bLwstSebqPv2lKHps3f0zkvLLPhrEGaXPDOa5V0eaiYjgNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzMHcWQLwYjfKZ6H7eGpUqZOzos98KPjiKb3gCvpIlU=;
 b=rTxwKahMekKLUW65Ylfpe7dBo0CLY3flIILfoZ2INe0b1A9i4M8gPDKfTndR0AiKNaVnMymTOaWAYOvUOIZu3ZrDslysAO+xLREtNRXwDXkTRIy95FW7QxnXDp1o1Ao4Ab0oEyVNaYCtdt52SKIulOpl6wwj/N2bSRy1uqN9W7U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6026.namprd10.prod.outlook.com (2603:10b6:208:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:25 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        syzbot+502859d610c661e56545@syzkaller.appspotmail.com
Subject: [PATCH v4 06/49] maple_tree: Fix mas_prev() and mas_find() state handling
Date:   Fri, 20 Jan 2023 11:26:07 -0500
Message-Id: <20230120162650.984577-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ead38aa-b4f5-4c7e-425f-08dafb0336b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PFhqMldtaEyKCykFiRXWHP9eKE8r3903eIOvsQI4iJg8Un5ebvBHA1O9zqV3V3aUUnQ5X8Xq4DwwXvr5330CDMBu4qrGb09MkhyPfEiZ4WPnBcTIKnbE8oZ2TrffMUY+m5RKPHXenPcXprqjim96OuvN77Kz1q6aDFEmBlN+/VVlZ9MgY0RJInzv4nPx9hP3N/lNuIt/+axMyqmTULA4vOKsFyOwMHYgz4S/00ZMrRuCdflpcTSpsCg3dGJX8E2TDJZ5FDwCQVxvBbEoIv92ofj44Jhsm1+V6WLvT2z4BOUM1q+1yyaJvE0BKbXoCJ47uqpO5vWMw9J7ncKOjtJ19sjRFdpDFEAOzpI01unNDROvxT3CjXD12TmUSn96nGgFPMFqqzzWrf/Vg4VR06J8Mbo7m+SXNbRiUAQBRDDXRov7YX7nyx/auNEKXcIvG8TDjDJpliKHT81/0LJs4tIvYgamwoxoHLl5eFfx7g3VtIvDb4bpTgxoEWWH99EIhBPvB9IaVbqxv0QkeZV+b8l+N94mLs9wk6DJumrWVr/fAl9T85BwQOf6gBtoZcUAyUndVbElGa6Km1S8MIbNCT77BC3BHzzr6EkZRgXTmeiHsDeckZT2nHimrvuA2sOzyr2gFZRC6kfeCvfqd2Id0fwHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(5660300002)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(36756003)(6666004)(38100700002)(6506007)(26005)(6512007)(186003)(2906002)(6486002)(478600001)(316002)(2616005)(83380400001)(41300700001)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z0QF/GQXpobJ+q6JqSR9VVsmQmz3gsk3JdtQ1gK32XkswU2+hLWMf9UHd4ye?=
 =?us-ascii?Q?PU65DXwafgAlgXT86fIkbFm2hhWBaLvOK/ghbeJ/iy9yZkuL95U8rbxyWdFs?=
 =?us-ascii?Q?91JhxAlUc13JSuNplpp2+YHWSEjZC0agROtvxtWI4Jg0+aLSZBszD/1zNW4F?=
 =?us-ascii?Q?t1jt8OivlpECUOgXZ3jXXJirH4kH/gnhhUora7hU1F2HwZm3GtXigYN4em1G?=
 =?us-ascii?Q?WyGntvg87wK74sYo+5Uhfo8J3fdgVlJ30eziFhMuuzQggaEuY48wYHT2pBBY?=
 =?us-ascii?Q?Avd+MnuhsBgYRr16e7g1uTdlIVMR55dPndFiHKBHJtg1VvwZYIbsOf0ABvV4?=
 =?us-ascii?Q?LiWYpZhqEY7GbCmOmNMHy3Rpbes9RdY467Y7kIpF0uz9x0KGn+wxS8V5vpoc?=
 =?us-ascii?Q?FSwwsF9NUhOMiO2A6mczfVTQOYjxJ49KxYN5hqS6Z9uWtls/KMSPuvjUOnJs?=
 =?us-ascii?Q?0M+opkbUanXnSSWHpHkti/ES7CARUWaJji+OkmAPINk3j/qn8sSa/aQic3jq?=
 =?us-ascii?Q?PD8d1f3+g4tSM06uvkD8OtdaQ8gnFSJPizRJqmaqWLTZdSWUljPkH6TQOy4Y?=
 =?us-ascii?Q?WFIuHOWov0RPcYj1xe2r1xORQPN0HbbEPQ+bOKfy9Lp4ESwM0xAEuCUYhW3j?=
 =?us-ascii?Q?HMkn0VMcrqucT1OegZBmcGCU9vPB57+tP7vLgsX0CE22NAfPjzQNkNxsninr?=
 =?us-ascii?Q?uDHFw04LvRcFRVk0HRA0xHR/pgJZq0QUXv4M1nGVjJLwBY2gI7Gxs9lx66/R?=
 =?us-ascii?Q?Hh1RI+wdL4yx7h+oKcmfqPE6qV3PgVp/KsQSlxASWYK0YNVXyW2PBKarpKQw?=
 =?us-ascii?Q?ojfQPk8bEgfnAwQxAotWfzxVTcDLqCfwOKXEEGx8lzwfzkM+eunN1swaoNma?=
 =?us-ascii?Q?25QkJquc+Ig9EZ4qXKlfuXKXYWo0gCM54bgguKgbSgDWDgKSP6/i9GFK6Mp+?=
 =?us-ascii?Q?TUy3J2OZlYxNSRVG9DVP7GrvwKI2euFLpYHVsbRtiUI3dgpwUzPOSD2QtDv1?=
 =?us-ascii?Q?MkuxYKfcLuDxBcv0/hJFVigoh3L30RU9dZo2/sX4mDiRjdrGICOwOuP5BOko?=
 =?us-ascii?Q?JpAHI0HaNgauZN9O43xtNvm8HC/z2A98ctN/5COlJfBcwdqflfZRyVa8Gb3c?=
 =?us-ascii?Q?bz2vKcVKlpMFSqNiN2x3O5tdMawVBpTnGnOOsHFnPD6k3K8wenC6sROYzkFR?=
 =?us-ascii?Q?DqMWKJpgvIzduczOSGLGWd6ZmGX8SD7/F3R7rOMkcatXVu8owAaZ8gePkDfu?=
 =?us-ascii?Q?7kQHP6wX7lFa4adNOiBF5Cf4jDi5G+KV4jr5zxV/50Lkljoag4cfjn6LYha4?=
 =?us-ascii?Q?sYrr9KmQcSnI++LdJvd5W8403mb9Q83OGAKPV1F7aFLSfjNlBnfw+oOgqUtB?=
 =?us-ascii?Q?2xj0cQgIB/MNeZCRgvrgw2Df8iFNmABTsExw3RfJWCiR/4FcvP8fftrS4kq4?=
 =?us-ascii?Q?1Sh9xY4p8TMyEuCurUaURQ2ewvG0WGtpuqmchoA+EIQJ3OPDWLbOZhSuNYSD?=
 =?us-ascii?Q?ZPo/OEItLtGLv0sFfs0dcpGA11sPLK6RcXWmddp+eHses/Ucbyu6xKvnFcSV?=
 =?us-ascii?Q?0ooFcHcRVJE3Qm9jkJau3WnCE9zHA7J0I1NXS4F6ammLKw9Nsm+ZGPQmcKlG?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wM8Tol2Y09cVvyxkbpjYgW++Zo7JfZA+rvvwFKIx/D3lTyQ9Z6kfeRn26G1o?=
 =?us-ascii?Q?5wYeTysys4z4xR6CswhHr0QRLSCmIBwDv4t7Tf5TvcyXMShmFd/dCNUcnLqq?=
 =?us-ascii?Q?w3RKlvVqThoGcViI51BBzV4gU0OabBzBD5W+pmt9OXJU86gzFfFRU3QMvsoF?=
 =?us-ascii?Q?T7heJWbtePwqv5VQ41/qZtlMDFjXtSMfvWRmg/C0KMM+V5ocdWq41mNI+OTQ?=
 =?us-ascii?Q?kEPA8I8ashlT13VVQAqR+3/u4hr1i1pEgI9Y2VyZVe+a0KVeMyNFZ61zt91O?=
 =?us-ascii?Q?M0xy89ycMcpbiud46NpLJ77UejlLIBFiojx2A5BptqNjhBUvdFNH4xiHhSEk?=
 =?us-ascii?Q?Ogzj5x5SinIsiPtbEHQl12UVoZIrea9uksHdN19X5dA7sFAYUO0l88JkVgBj?=
 =?us-ascii?Q?7GcNdpi241qO2Jkir/l6PdQXRxQz+e1lxqYSY1wR49wZwqB6nQBVf519CvMN?=
 =?us-ascii?Q?ab5eQ3OMtudGlI0T07SUpPR+EsQaojcL0YNSC5NQi3OuVUe6If2petWXHRwb?=
 =?us-ascii?Q?KKafLOgcN114et24xgYd6Pq5Bi8C8LI2fZNL+IZtMKK1KKMGTUzTPHVhwg0Z?=
 =?us-ascii?Q?ghMHVgQTfmAqxssgG/y2eNsTyCtI2ym5TA29daUf9YnGybgP0o3OAcPnXkbI?=
 =?us-ascii?Q?ndUB64SyajGHCysIqKuDIERoD06UqXEG0HnLQZGUhMv/0UmH6CGFTR7kYu+A?=
 =?us-ascii?Q?yLOg2K9O78GVh2AfQQgaLXVIsxnpHjkc1wfWVTZ9c5A1165FAGi58sQmYLrg?=
 =?us-ascii?Q?CIoijGFb+q0R+FrJezugiVPoMXpP9zO1mIQGt56Nv4EQWpecHxkssPf8DzXH?=
 =?us-ascii?Q?pZ1XC1U627HvoBWIz0ZknuMtysikdugIAJZgO6u7GEc9igf9w145SB6QrX22?=
 =?us-ascii?Q?lnpJ1ryKl7KwJZiyK0S0HfIsB/NugGOzEV4zgy7R7EPifG4TY6kY/zdy4/3Z?=
 =?us-ascii?Q?ymurAG4lwDlKi0ZQYLqoOQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ead38aa-b4f5-4c7e-425f-08dafb0336b7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:25.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHBivq+fUjfw3eZcoXHW+G182ocFZlM48EkMLMikJPkiAx+QHkH/IW6ISb7PhjofPKzaQC+UwgDgWkdAduEB+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: b4pExbaDn3pZilN105Jl2hc26xDZJwXz
X-Proofpoint-ORIG-GUID: b4pExbaDn3pZilN105Jl2hc26xDZJwXz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mas_prev() does not find anything, set the state to MAS_NONE.

Handle the MAS_NONE in mas_find() like a MAS_START.

Reported-by: syzbot+502859d610c661e56545@syzkaller.appspotmail.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 14ce355e4149..43bbf1906571 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4844,7 +4844,7 @@ static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
 
 	if (mas->index < min) {
 		mas->index = mas->last = min;
-		mas_pause(mas);
+		mas->node = MAS_NONE;
 		return NULL;
 	}
 retry:
@@ -5918,6 +5918,7 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 	if (!mas->index) {
 		/* Nothing comes before 0 */
 		mas->last = 0;
+		mas->node = MAS_NONE;
 		return NULL;
 	}
 
@@ -6008,6 +6009,9 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 		mas->index = ++mas->last;
 	}
 
+	if (unlikely(mas_is_none(mas)))
+		mas->node = MAS_START;
+
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
 		void *entry;
-- 
2.35.1

