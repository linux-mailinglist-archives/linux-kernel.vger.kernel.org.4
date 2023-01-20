Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6076759E4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjATQ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjATQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:27:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAB46E40F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:27:39 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBZwC029948;
        Fri, 20 Jan 2023 16:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=CIiCBeNDMKcdKFYj9W01eSuSwwcpL5z0QlNg4Wg5P8Y=;
 b=tOZEjld1qBVjri3Po5cLTvATiwFrLgPwrAEyeJClehZwzKKdUvzGTgt0Rb+lmVKdcVcV
 O+824KhHwdR8ZM8G74sXO1S/p0qSzn4Rkghzfeclljg/XScwgwdrbsK8nky3WYfAVRKi
 pzeV3IjAQZnPYj4r1B1tSeerwsT3W0Vv29gfz/Ll1XMimIJ6Ine4T5y3vZU+BLeu5m7o
 CkhQDCbfAqw4DsiClkBSQM3DaO+lM8V1CTFvZ7TA0r5fY/3MTLxe1bZlrKrFHhDJmceu
 uEi2V2r84eaquNgGR7yY4zxrUXRs6MYPEfhi33TMuJIWIHkw2EkT8vh+yxDkTKHfXyFs jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6cd3cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGRStd013513;
        Fri, 20 Jan 2023 16:27:31 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qmfax5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI7FZjrhM6OvgFVRkm9IPmH31W43Oet47HcMUm4J2GxP2kHGWtLnQN7OOv3ZQxJrCJImHwkX8wtGXoSER01Ea2N8OGWSgXCNZGqULIkdvsvjYlTf8eGhN42yF42ZDWfA8djUZGOxx4UqqaPODsIcNAi/b++iW40Vri2RFn3RDpCnSKZmnBCd8syy7++VlGRfTBjy/bsvgrhEfexaJyKqpHkVLZ1Xik+2yUdRJ7peejR50LW7YiVnoNCLlGv/GCNBbZxJLk+ZHiXK6eEiqT73QORF5kU4mnv3GQbWNT+PyAT7PVmmcJrCQQAUEKlDPlfOaBotPAedSdNYsjPg7FvzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIiCBeNDMKcdKFYj9W01eSuSwwcpL5z0QlNg4Wg5P8Y=;
 b=Fjbmwa4BY9MA4PNNDP+NugXxoJkB27cCeh6ei9orU8SsdRyYO389AuxitPOhsl7cdCFVfhnQJCS7rVFW8/26r7fQN+VcCCKIGkcRCe4gqyQTB6mkzy6lGeywgfXAVk7b9ez/Dedpskh1v0ljLUReGcUgnqWr61HS37InFtL8rAn0Xe3HZmepD4UjTDJ389fNIhGB4ra0Ylei+uKm8c6bB8DWfABv4uJIxmZmU7Fv6s8TkaxdE/NV+LVexMH0XJiPMK/DTBi+wK5q0o0gLO53cj2hdEL5ZJx7L1aCjt1a8CoKr9AMe5Zwbvm5XPNKXj7LTKtM2wRFdY+U8ysOumdzfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIiCBeNDMKcdKFYj9W01eSuSwwcpL5z0QlNg4Wg5P8Y=;
 b=ZIMcV+3BOHsXmYO+eHn3cQ+WFqj4abiavHMWU3N1m0am9VzTveNpmMQ5eLGtk/0ze5MJLvUEvkEpRiJtAxT8l6mRq3MLgB5sF8lBuV5R/O0RvlSFz3N9v4tnaZL/4uj8xPIPSAkoB/ldm5pTEurwVMQlMp9X3T9i2C6U/1NSvEI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6026.namprd10.prod.outlook.com (2603:10b6:208:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:27 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 07/49] mm: Expand vma iterator interface
Date:   Fri, 20 Jan 2023 11:26:08 -0500
Message-Id: <20230120162650.984577-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 799bea2e-8708-4b52-1296-08dafb033875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1cZ/FkjktXDmvpl+OJRU+MY3duVjmWoLbRXEaBEzHjykh7Hoee4FoXrvJQoupPU0BKTznTF9ieQx0xiDa45PS+4YX10yAsB2fCBLOzZjFG43TFQa5F4hP0HLf1PDfLG5S8DzLZvQdE1YxyIieremy1mEDLqkmuudHHlSJvONiLmYu4U7qbtWTTG9L0jmu7xdNl01yD7YbfhqqfEFiUpHcYFwez3/xd65ULEWIIbmLpTM6RDjnCNKbejj9H/68LmPDrKQWxYz1w6V9zRf0DAMjwCpJcqyFI9YybC9rw5wBA6P0AeNl//wNL74pAEgB1CE67Nc2xqqMMsxKR1iq6/bj7yJA3ys2slVRCXyZ2a6YMggZTzqFgKf5zo8yjgnBZ3pv3sgFQenVK76xlKyTjz8d0GVMAqprBeflN1diahtLywneQayDKaVhtJqFV8G3IIqxqh8WlrbxODG0MhP6vn82w/lrTJaIVG+xS9X38QqwObPLZLDjCjlo5kmIyzewFNgXRVmy/MZJqXiwvQvLbV5lJ1+KS+TKXhUlT6NpSgOMUZlIQsINSlTuxy/F5jAImDdcrXkz/9nTOwu8pdFy9kgDtLwGRiy8Y7mG6kJd908zaZ2Qj+15NsxmeOzfN6H4HMdUxpIwZKxbzfDl2HdjKY4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(5660300002)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(36756003)(6666004)(107886003)(38100700002)(6506007)(26005)(6512007)(186003)(2906002)(54906003)(6486002)(478600001)(316002)(2616005)(83380400001)(41300700001)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tBcFc638iXUIzaYAC8OwmP/KoVrcPixXbgaz+xT98auj1vUZjDk+NyCE1SP2?=
 =?us-ascii?Q?2YFQcFMbaOMszMjpa7Z/uztoykROt/YoSOxwmnsghyn78mEvBs1Uw+mM72mj?=
 =?us-ascii?Q?qxrn/yuKzyLldWQO7i9RxnA9JZPMkbRZIdJpyjrVNNCSUfHa5J1kfBSmFXe7?=
 =?us-ascii?Q?GEWTW1Pt7MSA5UwCbWY+06vSoreF16c3PizhVBYtVik5QdWObCbe5EY3l+wu?=
 =?us-ascii?Q?mKu4W4PgptUHc1yqJxIp/VYzFZDBs3ENAdF2dYmgMIuAefOoA/mfjMONN2Yi?=
 =?us-ascii?Q?R8VygAoOn9fJb8/5fnj/e7BV28FihrQHY0PdkZyXbrK53P2jAhzJU5a+s3KL?=
 =?us-ascii?Q?iHbK9xUY22YYukkO0dHPD9adbKiEaz2D7VEp1+IgaGlxoIIvkrdYG/rnr2Q1?=
 =?us-ascii?Q?6gkxkMtZCv1dW3uaTRWE25FHFyQ3u0x4rqKg+rmLbUTcq0BVz4cDtWS9duVA?=
 =?us-ascii?Q?IlaVLIX50hznTlMxfbhKzcH4zqUGdQ/CQ0Bs4mxKSiVEEHo8KLx15uS28CY3?=
 =?us-ascii?Q?l7N7w3StxB7tcig4PK9sMmjqz+2+OL1NbHaN0ua1XXyWI4oio6yOXqCA/wk/?=
 =?us-ascii?Q?xcxR3m9ikbFmki7jGRl66WLHMNtRU53t9bxEJWtqr/3pyneq1f0GtDki8d1M?=
 =?us-ascii?Q?xdrASi9ItEb+/0kRoarcJ20ZbRr1nOsnmX1w9wdRduua2gIcvyvxk796jKNT?=
 =?us-ascii?Q?qnfFqLVtbPRnAt7nLHVPT0yf0BGZK1lA7LlpPEhOwbLGCBnPciDDaMcKowSZ?=
 =?us-ascii?Q?JWRFYLie88YvIx5I/wI5dnydR4PfmaxqP8RNhlCyo1lPQvIaqRNM53L9BAY1?=
 =?us-ascii?Q?xOS3FrJy+0S0bkEx93AQNFWmJCCKgJ3bnPBmIcVIdhAGb8jjEcuvshqJiOCK?=
 =?us-ascii?Q?3u9lEqZ1wNDTs9hwMQN32ATsdU/gsqUWd+SV7jWV1XG0DWI7sW8YnwST8AOG?=
 =?us-ascii?Q?RvpRSdRYCe27dMv8qrUdBtWc7s9ZrhTahu9ywucPi5mHMgpdvhrbVk6VA4YF?=
 =?us-ascii?Q?vboIbmwIYT9eG4z8KFBifAM3tCwrXmdLro1juSZ+NX88oOlYz7HzrhQk0N8+?=
 =?us-ascii?Q?SynsdLxRzL9Ph4mMGz4115E9u/rEKx+73OBtQu8cj81yi3WvKa89Jix+NfWx?=
 =?us-ascii?Q?crq97izk3bwE70Hy3eER0OI3TaAU3rnH4r+9av4+1Uysf6AqbwjWM9mtjP1p?=
 =?us-ascii?Q?3B/NQN8GfLpAkACArp8FkALeiQjtk5XDatJwe0RpM3PURrSr+QTNh262gp9+?=
 =?us-ascii?Q?CgPcFCGxK7yrg1CzJBwErHE1Vd3Ba0zWVW1Qjs3dQyZG4lJ5GGDIlMskMWzk?=
 =?us-ascii?Q?N+6iUmR4Shdq4gKcuRFQ9VJu0QDoV3jDBW6KsAJ3YQwxXa2aj0qdRBRsdQm4?=
 =?us-ascii?Q?ciQvXecIfC03LQ3MBVjbfCCbhxaLV2nCt21J/Ne/jE6F4lnCvS6GJ6bLadek?=
 =?us-ascii?Q?X8VhqSL9in2BHoGOmN0d2xH2b4sG8Cefw2PuZ1msymIdBWNhYAX34oGuliDr?=
 =?us-ascii?Q?YNRxqk1KQoToZnGu3FkJRQIZd+jPzMKoTZaGwLI1ALVkR8x3npfmLOmWLQRp?=
 =?us-ascii?Q?8eJG03gCZsUFu2yjtfQycmIeGTSypXVdoCXRhKSGuXrjg9nhl7z/ad8I7YeA?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q6F1unTc2EFnOxdI6CFyI77grsaXW/nO367iyVOyvkuVsDdJcpDgjN2eFFqlnd8laj7KuVP0KnZxpBgGoeJE+AsWTlHCIUxbrw34qXrdHoSGI1i/hD/cg6K6mrGC1N4H3D2ursOY1WfoamAfhNS5BzczcUIqjHEy29i91KEAuIvJfLpgcCJEJShFmfqjB67TcJwQlz9FFEsS/kt7ytt4KlvMdJqMJ0uQiCnfa34ooRIJhv1UrCG2j4cnxMiKb1wmjcd2bh/UOWax3v/7yClqXMuR1zCP3vapR/gVrIZGfELxFJ2ZBl7CKajsFcKBxqDeFxc+iJjcr8vEqp6PTwMS1lqRRU+59xNXytpRmcKeHXGVUX61rN/7fRHBVpkCdcPFvIEci2mj/nvUFmSLWhq4EQQqAxLxQxPis2hu5gfdLbHn2D9WkDuqkUDrUuwwrR6k+LIHNsdQE91+DONr3FqXLuDSsJtQUFvxv2ZhW/wCCfw5MfBk2H14X+ePYGbpV/FW1ZZ7dkpBAqokZJ2lBw8JGxVnkipOK6DJP7Skgsug+LdqK7+mbM0HAiT4NOWee4trhR4ghr8ks2nndBkYAEJdQcKHQkTav2usujZe/HhLfM2TDHHbt0+MSXwcH8HvzqOmzjie07wUnKiEbHqz2CwMknr400qaxXjrQrY8OCfmQBZFpSalfxsgCxa4LoC8ns6WLHpXZeh1POGnGHG9yxchkqPEEA2WqSu1nJGRTadCKENOCIDNY8ZHUddaD/rqSwNTwyq+b/PAwTVV0PtF00LzgFBnJaTlFhPSNHcvQXPz7RJkmxAOYFIFLZ6ER0QUdx5xRv1tMp4bt9N/B2q096RrD7p6CPKyFqDiUv9x0xp/TRRXlJUQJAlWs9Nvorb2Fd1GWee/H7phFy3LLeWRXSqkLA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799bea2e-8708-4b52-1296-08dafb033875
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:27.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GviPx8ERRn5iXh7R21T74a4VrJw/A5j+L3j5FX08UogMcUdzBN6QwpCM6U+QMnrwdb46uyc5RWzSvbOF9OlcEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-GUID: WUOXQHQraippjWLIs-tSAnoFr9YuRBvN
X-Proofpoint-ORIG-GUID: WUOXQHQraippjWLIs-tSAnoFr9YuRBvN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add wrappers for the maple tree to the vma iterator.  This will provide
type safety at compile time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h       | 46 ++++++++++++++++++++++++++---
 include/linux/mm_types.h |  4 +--
 mm/internal.h            | 64 ++++++++++++++++++++++++++++++++++++++++
 mm/mmap.c                | 18 +++++++++++
 4 files changed, 125 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c9db257f09b3..b977a90d9829 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -670,16 +670,16 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
 {
-	return mas_find(&vmi->mas, max);
+	return mas_find(&vmi->mas, max - 1);
 }
 
 static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
 {
 	/*
-	 * Uses vma_find() to get the first VMA when the iterator starts.
+	 * Uses mas_find() to get the first VMA when the iterator starts.
 	 * Calling mas_next() could skip the first entry.
 	 */
-	return vma_find(vmi, ULONG_MAX);
+	return mas_find(&vmi->mas, ULONG_MAX);
 }
 
 static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
@@ -692,12 +692,50 @@ static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
 	return vmi->mas.index;
 }
 
+static inline unsigned long vma_iter_end(struct vma_iterator *vmi)
+{
+	return vmi->mas.last + 1;
+}
+static inline int vma_iter_bulk_alloc(struct vma_iterator *vmi,
+				      unsigned long count)
+{
+	return mas_expected_entries(&vmi->mas, count);
+}
+
+/* Free any unused preallocations */
+static inline void vma_iter_free(struct vma_iterator *vmi)
+{
+	mas_destroy(&vmi->mas);
+}
+
+static inline int vma_iter_bulk_store(struct vma_iterator *vmi,
+				      struct vm_area_struct *vma)
+{
+	vmi->mas.index = vma->vm_start;
+	vmi->mas.last = vma->vm_end - 1;
+	mas_store(&vmi->mas, vma);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void vma_iter_invalidate(struct vma_iterator *vmi)
+{
+	mas_pause(&vmi->mas);
+}
+
+static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
+{
+	mas_set(&vmi->mas, addr);
+}
+
 #define for_each_vma(__vmi, __vma)					\
 	while (((__vma) = vma_next(&(__vmi))) != NULL)
 
 /* The MM code likes to work with exclusive end addresses */
 #define for_each_vma_range(__vmi, __vma, __end)				\
-	while (((__vma) = vma_find(&(__vmi), (__end) - 1)) != NULL)
+	while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)
 
 #ifdef CONFIG_SHMEM
 /*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a689198caf74..2d6d790d9bed 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -854,9 +854,7 @@ struct vma_iterator {
 static inline void vma_iter_init(struct vma_iterator *vmi,
 		struct mm_struct *mm, unsigned long addr)
 {
-	vmi->mas.tree = &mm->mm_mt;
-	vmi->mas.index = addr;
-	vmi->mas.node = MAS_START;
+	mas_init(&vmi->mas, &mm->mm_mt, addr);
 }
 
 struct mmu_gather;
diff --git a/mm/internal.h b/mm/internal.h
index ce462bf145b4..b4f66efc912d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -873,4 +873,68 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 	return !(vma->vm_flags & VM_SOFTDIRTY);
 }
 
+/*
+ * VMA Iterator functions shared between nommu and mmap
+ */
+static inline int vma_iter_prealloc(struct vma_iterator *vmi)
+{
+	return mas_preallocate(&vmi->mas, GFP_KERNEL);
+}
+
+static inline void vma_iter_clear(struct vma_iterator *vmi,
+				  unsigned long start, unsigned long end)
+{
+	mas_set_range(&vmi->mas, start, end - 1);
+	mas_store_prealloc(&vmi->mas, NULL);
+}
+
+static inline struct vm_area_struct *vma_iter_load(struct vma_iterator *vmi)
+{
+	return mas_walk(&vmi->mas);
+}
+
+/* Store a VMA with preallocated memory */
+static inline void vma_iter_store(struct vma_iterator *vmi,
+				  struct vm_area_struct *vma)
+{
+
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.index > vma->vm_start)) {
+		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
+		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
+		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
+		mt_dump(vmi->mas.tree);
+	}
+	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.last <  vma->vm_start)) {
+		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
+		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
+		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
+		mt_dump(vmi->mas.tree);
+	}
+#endif
+
+	if (vmi->mas.node != MAS_START &&
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
+		vma_iter_invalidate(vmi);
+
+	vmi->mas.index = vma->vm_start;
+	vmi->mas.last = vma->vm_end - 1;
+	mas_store_prealloc(&vmi->mas, vma);
+}
+
+static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
+			struct vm_area_struct *vma, gfp_t gfp)
+{
+	if (vmi->mas.node != MAS_START &&
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
+		vma_iter_invalidate(vmi);
+
+	vmi->mas.index = vma->vm_start;
+	vmi->mas.last = vma->vm_end - 1;
+	mas_store_gfp(&vmi->mas, vma, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index 335ba3df9898..253a7490fae3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -144,6 +144,24 @@ static void remove_vma(struct vm_area_struct *vma)
 	vm_area_free(vma);
 }
 
+static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
+						    unsigned long min)
+{
+	return mas_prev(&vmi->mas, min);
+}
+
+static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
+			unsigned long start, unsigned long end, gfp_t gfp)
+{
+	vmi->mas.index = start;
+	vmi->mas.last = end - 1;
+	mas_store_gfp(&vmi->mas, NULL, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
 /*
  * check_brk_limits() - Use platform specific check of range & verify mlock
  * limits.
-- 
2.35.1

