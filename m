Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCBA6759F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjATQaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjATQaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:30:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E34AD27
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:29:38 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBXpi020077;
        Fri, 20 Jan 2023 16:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=XZZVOOCjuW4MAwS/kA83MzCLjQvswkT2jbNv3CY+qPY=;
 b=S61uec+eW08GfZif+Tdd1gShj1/3EmxCKs7LkKA+Opd6gfhINJeuRDDm79r9+gX8T8sx
 4/3jijLBoBEQCo+0JFi8zSLZF+5yiboX0fRDlk4QousTvT0Tdp6aBk8s4axryiwMTZFY
 yBzxULww5RwpzdhY0xzuFz6tJ7w0nOCpHXpNajddAa+Xj3SVUCfC3dA+5EwuiDBCOCHB
 9Z3F66GmVtGdXonDV/jo2uLzTEUM3vMFdphTnddG345CEpNmCOrq3QSslBzx09HsKb2j
 MFmwhq1XAufsrwaKNVPhcVcCsV3hg8PRgnHOlNF1LajhbiCzSdTf4ilGgiNPEVqIydUe Aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tw257-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFOoWA000777;
        Fri, 20 Jan 2023 16:28:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d2svt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNSbBWR+gw6V5sm/nArthwl1ZtN0apoWUbNnRZyS3Lz17F2c4O7qFHXgu8oCKJgxtV6HtxIG7NecMxGc7Q7GhhMwC7ziqNx5bAebsKjLajNiH9UEf0LpJHNtVUsIcysQFlj6UViI5IWmRJmOkw/G+rqavbShX8H6UoWwtAHCkzZ7eXuBj4N5p2Pp8HVOLueVVMbBSWL0Dp+5HoZ01XLx5IpTXBG0wOVJZBqMduU0Sb/LvffLIY5l/PGHeNfOkxO+pAdWsaJfkJl7/IJnrvVTFnDedoGMLGoXVLMRWXzXfExaF52NLU7IKelHDQYNB09h7e/W1DBNeMA/1wVC7l+G+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZZVOOCjuW4MAwS/kA83MzCLjQvswkT2jbNv3CY+qPY=;
 b=cUsfT2/7oxWRy/rAh5Ni87llczkVNDr66Dmv+Mn6cHzdVft8ZCRSRc94Gt9OXWxWP0qZBdsvnd6/rV1Ty3y7jGshIYGqgwy/ipRJGE5Ftwifh3TNNiHXklt+ngU7ED+VR8Mm2J1L3io1Jkf3kl+HhKpKIPOnprkHrMcotMd/f0ys1SsmF3prKYVvQZ9ieGt0uWD6pMoTeQ8WIPAc/y810SJorYMk6UQK7W1h/Ui8J64LFd+iwBAhwVJhb1zrIoVjtCypS0u3C5gHal7MzjeM5ju+ZJGj/Fs8l++Vlf/zGJo5befzAo9X/cOjPfQRGSfVePiQaC2+uAax1P4ScybL9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZZVOOCjuW4MAwS/kA83MzCLjQvswkT2jbNv3CY+qPY=;
 b=Qjhv1fmxDuHer7Z7vjO7YIyR324FDkMZF5KriXlm3Z+PzjUMrKHKQG4ReXX/yCDI3DR9adRyf+C83Y5fbHDLdYJi1YxrTAAuqWm4bzc4S9i5ufrJQdmEtMgkJ9FJRiGcPSEL82JElW+LfPNVVveN/+Od9+hylKU2Hi27RNdQN0w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:28:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:12 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 24/49] mmap: Pass through vmi iterator to __split_vma()
Date:   Fri, 20 Jan 2023 11:26:25 -0500
Message-Id: <20230120162650.984577-25-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0018.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::31)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f1cbe0-ac1b-45d4-d7b0-08dafb03534b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMFtSgue+9Trg2jL72/k0nkYlpGtXBQ9IDJucfhTwzzO9KCf1GeP7qUUgFB16C7d/qqQylR/W6G4Ur0vyYSZtVc3zk3p/4YW0gtz6Nr2DVHEgbDYmCecGyPzOjB1uWAPjbepAIjSle/FXFMz0eYytanHEp+6OIoqlplLOTBcsLp5n3GCLVypTvukookZtrUMKSp2BejlldQ58Y0VK4nj1OqhmzjkDJIOkuE961IrTKfPaKdZTS21sQ9CkhUG+TUwRrvrYaJdzv86YOm0uhrsh6FQpaUriDtJp+/fbBaHLlY4JSZtmfzHhvBWoywjSQu/cyQulRgLETiTfdfsfkOcYPH+GIRWpt0X3ZIrcverQgqO6bJPSGJcMSMX51xJwWOtaY6w1r+y32eST8EEIGHSEacHK2UCxvG/WeBfbkjTsst2Jgz4y/pdSy2UOPwMXA0qj/rURAqI0dfxNUuLt+SyROxIg4A0jNrLnxmSUXEeEkbqKTB84Ym8nL1Do4yx/GKBcqDv958f4bGr7rfwwDE6Bf/bAMh3OiNWrl3GlC01q8EVZvxT6zvIq95ZbN/V6mGsVKChOg/+kSCvTVDFZR4BdkfKT0x1EfR5OW7xSu41wAG+eNmSdV4avHkMauMmna7mtOKXZynWiOS+9RzsWAIoWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(4744005)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ryQhpu5U3t7P32/mOBBnsvI+AxhMdXL4tH8WeKtqJpxjrgvDqv1OdDoL+IWt?=
 =?us-ascii?Q?tOjwTDZOeQE5SKhEHuOoNWa2q07m1Z3MfrWwcfoF9/ANK6PgomZnRPJpPU0s?=
 =?us-ascii?Q?PzemRkBVW3RrLCW04QUE/LqpjYvZKKFC2Zx+CRknV6VMOMS62EbAgqoVgORn?=
 =?us-ascii?Q?6ujTeKckrKdnCj4XvcJRlCPOLO36j9ADgDCrdIuhr9wFRO+Hqn3GH4bSDTRy?=
 =?us-ascii?Q?u1quIS9Cfb9vL/xB9Kq2mraVI0wwbvHYtE8NK4G75BxyukxdAUA1l4FPk0aQ?=
 =?us-ascii?Q?vqH0Vl4+Ef0uZdO8ZoLQubeg+H6q+xPQOa1cWULD5tydOLkeJge3pdtSQ7VI?=
 =?us-ascii?Q?5KMuWsjKwgwj/7TpKLzB2NRoCAS9m3s8eaCW8LvOi07LQ/vm8Eww0guHJ28S?=
 =?us-ascii?Q?8jw8fqIcqRi7R1XcfH1q8LCRrU4gJbDhIXcY3BuTPtmxnqT3Thq1ZAYwTOay?=
 =?us-ascii?Q?+deuGtx7bjY1KPbVYsGIBWHYqT1VL0OwfJf71zhrGvsbN++6Ei81DY4aFM64?=
 =?us-ascii?Q?W17msP5PLy4FOkPLkFhMVmc2rO2H8uWW/LecKoeCmAMaV1iDPAHl8KVfTQSX?=
 =?us-ascii?Q?BbpCLgEIWbWFv2gyuwqKPHu0LPmUNQn1qjgyoDnr4UxK7OhBGCyAJVbEJtLH?=
 =?us-ascii?Q?k2UOrQ+ziew8yVFGPVySslQxEjGNE23660iH9c5obwjUhW5qiyBK3QtBDlCT?=
 =?us-ascii?Q?CrtbftJUUrI3slGfgn2JbN0tZJ3jyd3+SjIg+mwLNXpUPbg8/Ezp3r1oTUT4?=
 =?us-ascii?Q?B8ryAOgeqscJZIk4x8iJWn9ELVo3ehawefsCGw6akmMks0GcyhYu5Mlz4Q/c?=
 =?us-ascii?Q?lLURCnkdW4pk+F6K/k1ugjwIpZUo6mT7hzZplKU75TA7JmIjTqd23E4wfFa0?=
 =?us-ascii?Q?EooZc3HdAdkYFKDEoKrIGBDajymhpG6Lo7dh2DKrcASQLTofypHrTDBmNZHm?=
 =?us-ascii?Q?f+4kru76SPvJFClGGC3P74hINQUzdBbyn5xVje2L8gxip4rfg1jUlprgPVLc?=
 =?us-ascii?Q?/djJk2krzBoOiZG5yjUCXwridyHEQbaPjoT3x73kwFO3wSvdpHN3ZR1kUeL3?=
 =?us-ascii?Q?gSxl2uqeA3OVCr+VQQJ1tTLqvW2FavG1MqqtAo6qBX5o0kTXbo1orXewfteT?=
 =?us-ascii?Q?DFjhngOG08DmglT27YXv6X5aKl7jO5HvyI+dhM/J+1Pwq3ebc8GcFGnHlf8v?=
 =?us-ascii?Q?HLjm8l30gOnh2e1E/pf7lFcnO7OEMT8I2C//aFQIKoa7/WlXkvJ8SMpBAT8F?=
 =?us-ascii?Q?OHadVSsPRQAEXK4DaRz+I/SiSh5SHrS0ov5SgmsLo3isdGNOoq61gx0BIDS9?=
 =?us-ascii?Q?hktRmHOcMhC2nH0zw363aGRCLWARrJhBPxwD7JJTC1sGskit2kwPu330ADDE?=
 =?us-ascii?Q?BaOBFdrhS/u9eadDrC0nxAXrVSjl55eDuIlJxyQMtoit61bJgNz/zFpyPhWE?=
 =?us-ascii?Q?zgV00rkvUiQFxx6IadVmWRz8t0PEiK0RCpdOTgAXAPP4dZ4Ug/sBj0fy+m4O?=
 =?us-ascii?Q?q9lT5XRy18HI+ncJRzf5lqkAhiltPxUYaAeCxp5CNZTirdqB6x7nu6QlGX4H?=
 =?us-ascii?Q?T/X7E6ha/jjbToqKA5fCIF8jzOQ+1t3Kd1hIxNdjAh/xRfd6Rb68hXfX/im0?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fGjjqvOzI53/qWxQU67pYrcAKU7nxjyWzhJUBXAJdu+ACoH+QXSRWIahEP3F8JXn0ZX2ddaPYMmPOMHIhEFK0BlC+kYKMadaefh5BzRQMWBAq+6iKnQgPzW3lpEsuzfSSTHEp3CEBqAxJS6WQnTW96JKh3QCkn/KShcRVWRR/rZHZBEUZtxyLjUEMFEPJKr4M0g9ALgHahn/0Q6oADG+IQZiq3bRpDnnK3Xb/2avTsAg3mjjeJiQIfuaH7/8Apis69WMNnkA5JPDGcdAZbXUDjgUjdyRtKkUoCMrxlhDSfo0FsQ+/azfE62prpqMdCiGR1q4zrmM5Qbm6E1iZnsrmNsoXMNqPCsxaUuoLVWl2JyEmhB2s0HW3YCrCtCwuk6DA9j5lDIHQIA6eS1DyOq9/XyEChBUbAlRGLFJf/6A+xFWhzBdF0RpCUsKVxBGhHrjTas2kZ/r2b9fQazZKy2KE7Zzeald2+JF+Qqrd9Vj9Fvw3vq5GLyBPhTu28pPin2Rhq6G3Rc8oVYFkFszsCP2gPSYVaPw1wo0GemF2ZuO0j1BWqx/TIqvh2n4tZkDlUiUr6KD3hwMCBub3ghECUNiiAaV1YjIMDmxP+ldBNM80ERh6zftpgUWQ4xDInoIxYD5Mbnl/x9Jnvyhz3ZUHt3G80s2GEI0fEfvv8pKyoDvkizjrz2Yc9eqla/5UlA11gYfZrXXtGRRQ1vK0GnbXKdqkxxckdomOe5IAKfMmTh+S5pcBfnHtMhE5uQUYlnYshTQXXhEsH1PkF9i2yI0YQWKMrZP+wXswfvo5NfJKk2nMBYSGVFIrdFC8v04kLmWzNxh5Mm5cd9/s7fv/E9ZGvUyEJqittDcacaDpwE5TBJsM2ubqOZoYz6zEFj+Tdd+fEPw/7y2fwFDvpKteGY7JHVecA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f1cbe0-ac1b-45d4-d7b0-08dafb03534b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:12.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldIxr2U7ElivZQxLzv4gLTM0ZOWzknXZtCFpk2vY6ctGhfZiZAe6OWJBSJByHvK2UC1zfoDPYP0hePih1XPRzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-GUID: CFYzbznot7Yn5W3QVXrXnKEMTtJVpCqG
X-Proofpoint-ORIG-GUID: CFYzbznot7Yn5W3QVXrXnKEMTtJVpCqG
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

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5092d0405883..0de180bb4df0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2391,7 +2391,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		error = __split_vma(mm, vma, start, 0);
+		error = vmi__split_vma(vmi, mm, vma, start, 0);
 		if (error)
 			goto start_split_failed;
 
@@ -2412,7 +2412,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (next->vm_end > end) {
 			struct vm_area_struct *split;
 
-			error = __split_vma(mm, next, end, 1);
+			error = vmi__split_vma(vmi, mm, next, end, 1);
 			if (error)
 				goto end_split_failed;
 
-- 
2.35.1

