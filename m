Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B83772D0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbjFLUlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjFLUkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B09170E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKO0Kh029029;
        Mon, 12 Jun 2023 20:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=1prjPOCurqnWH4L6WzWAHY38RL29aaMdFp7clnJuEH4=;
 b=p3GpDCa/k56YDHOiV7cMF5GbsyCGzTh8yocigOFRfK/p6WjUqZo2vMqdBfLmRO4e3Uog
 UyYGGamwY7K9BorOFQGpA45gSHATG4HuiSfGU/pzxgKMObgZZh5mc9jBeLeXjezj93/9
 gjOV+JeDUKUisWVRopKdes+/3RjEvtf3fdJxrs69dzvVvHY4XllUAe67Mr1lbfVEPQWS
 /CCev1SFNCYxioNo83Z/o3K8Ezr6NLJOlikXhbCLs1Z+UC5/007Hl24O8ypcAdaxhUQm
 Bt2poh7ecsozBgjR3NK/yoNzWYsjIJPNI4uzKvPXm/eRMLJ0tEWG1ITIFC9WlpVXZrmq Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bkxa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJC1GE017781;
        Mon, 12 Jun 2023 20:40:16 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm313vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckwOPp+rrVKNVHhkbwbbYK8SPI3NOEpsSXbNIAFKmmioiwfSesJKWjdBMNYTO5E9V6nDfxRo86d280s3sMWXns0k6swJNnOq8Tgup7h5sy+heEErFn6yke6Dd1EfE/YXxy4HmSp6jOQ5DaB2vV8cwfHWKIJuqWZmqTKxi3nfCzR+O5AGujvYfApU84wZtu1kov/iwsU3TTZg4sjoMwT4fYFWNqi4PC/FvjqPymKZefepn6dVDOuYdGdcxP0Ee9nu2wgR/wzy+xDte07nyWj7VvA/kovvhsWLYoDlNNd+Q6hd6IPbFiKbsk2yIqJLcwJv1Z+QqORpP7/vUaypD28Zaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1prjPOCurqnWH4L6WzWAHY38RL29aaMdFp7clnJuEH4=;
 b=U7aO4PSRoSmlTQjmPRflNfuUMquui3KTErMyhlnW9L6yzA+6FOiOr/DqImQNrnaKYoL8v8vkUEh2W4prJPe2BtdgOEK7jp/h0kpdYEph5YMEEcgNQCmKAaqFZD4SfhqPqNZSCDC0mVOcXmGJ6jdfhV34CPhA44qXM8YnSrXEKhcm/noHKhT/Ndd1qIljrv0CznQP29WM3PBZmrjb8gW/gC3LbU9castXgzTApUE1TWTnyRkNgaOn+F08/43dLxZnB6fU4u3xfkTCYM2e4S8oVFfUj3qbmZUXN6J36K4Fq/pR5dJEhYFUIaeo+VYsEhsaaxn4O+QjKNzrkiOEUUbnlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1prjPOCurqnWH4L6WzWAHY38RL29aaMdFp7clnJuEH4=;
 b=UAnjf6G7TrPWj8ln0cELu4fOS5Udg90RClOLcy4y1VffQOfeujLTHJO/6vs/Uw/y8bOX/jS3PjjBvUG1ycqITNlXTMEI49aMXq3Ve3aVw/dtRKT74s6J4QZnBDG/QHvtRFGHq2BcHFVkcY9kNTukUuzPvBpiu29B2Bqp4koQp1M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:14 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 06/16] maple_tree: Introduce __mas_set_range()
Date:   Mon, 12 Jun 2023 16:39:43 -0400
Message-Id: <20230612203953.2093911-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0039.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b4764d-038e-47d5-fdf1-08db6b85397d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ay1EP2fPCKOJyBkgLP2tJ8FujDl3HFR2f5q8eyJB6KCkxxmezqRtgfumAOraShnZyT24gpK9RZ/5W59/AKxnXNI6PLVNFuBNV4DW+/Ch6u8BYau8cMeYVMSMIJeV8m1IuxZiGOA1MpCSHHDNWub64oWYxdfX5dB65x8iLv9N8PYqIo+f35RKHAtm2unKzgvuVk3kYmy9UWsIJorGoiYcDgElIVZtLxGxsAtuig1u56lgvQfUKAhLUzGiFITRb0x0zuVPSYWVTOKMGUiQb4XE4oYOA+79U6a1qxFMwU3M+zhiBDruOO1HFqpCtrcdPhDHxLRoHbAEi0R3Ufm8TKPvpPAtFMPsD1PPkz/CggKfc2XIKSHZ9TiqE7DjXg7RFAXveL8xClytyAHmIjR3Tx8TiOyldtkKn2m8Yu1IKtTm2ZMr9d1rBj+C2CiHvc7au2Ng4kn90SFwMV06Yaj5iovEdMO4mIfa/MWpGUi5OgCkYm+EIxh4Adp0VIgL9IW2kHS6oNDkKG+JfnWqyMUPHfaUHDl4zL8yriJK/qs+ttHKrqchNszql9Q9HMVdf7bug233
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(2906002)(41300700001)(6666004)(478600001)(6486002)(6506007)(26005)(1076003)(107886003)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KzGCn9CTDO4urX3FRQIXCLJdJvkG70PSKpRjkTl1GtjG94QY3uxsJdrAEiuB?=
 =?us-ascii?Q?iCZT6cGuX22vzZefkmtMuL/STH+bvz3bkz2OhcKroh8yztnJtAdqgSbli0Nq?=
 =?us-ascii?Q?JdPdoN11M/vC9DlvyjzABAWcYdLgfg11PXHLaVV1eIx8J23qK+qgpNYaW6uf?=
 =?us-ascii?Q?0JWAaHdd140ALDemI4zP5QOeOq7HXhGrVDLKwjPgresjxx0PQVR6Sohw3EYp?=
 =?us-ascii?Q?ojbZS8ke5/W9xg3ooSX4PvVU0DPdZ97A2rd7Y21NF7QxN50rCngJeDwXqI8/?=
 =?us-ascii?Q?vBdNRDcu6TqIGgK7zQ20dtiRvBZHv+cLc41SytOhkM2EOKTb9/aNCg+Osiss?=
 =?us-ascii?Q?aTxpF7uX5WHKTFph/4LVnmD7HE49sQ2GD7FZu4CENWYH8DOKznbIbVFx/0Dv?=
 =?us-ascii?Q?hSBCOZunadbjtoCC4VA3/C2rPxbS1jD/eceFN8CWq1JFBy+p6fMQ0sWBVpT0?=
 =?us-ascii?Q?Tbe7jnO2QAUHLwFpSA6s3bAOsBuCvubQRtH4eHaskvriKeZjTuTjQlQi19Z/?=
 =?us-ascii?Q?uhshVF6Hm7zn25KoiSvnfbW5n6NSc+iwWYalR9rqswnKhlKm8OYFUIq7tna1?=
 =?us-ascii?Q?J0Zx13BTTB+lBPTan6VL30FqqIrp3fgcS6sVnBBu1gAF0XGKnSH16yDzE0NY?=
 =?us-ascii?Q?z9fY1Kow8dDX45S6412oZqXiI5easX1khD/dS+kXSGtfPYY2rh2zVuzt1Co8?=
 =?us-ascii?Q?wRUpxgS0dsrmsIPU32MZKYVgB8UZLizV0mih/EIBWLfYLiC0uFdCr4/VnmIB?=
 =?us-ascii?Q?SxK4O3h5jjSAf6+yxXN+3DW07OOwnfZVz9qFK6AZz5Kdi4PP/OewmWndZ8Km?=
 =?us-ascii?Q?FM5rxz0GrgulVrA772naMRYvxMmPLhe+lMP/cie6RXC7XB1PCAG1G/mEaZOq?=
 =?us-ascii?Q?/vUbsi9oJERqVX0D6DxdUVzbVL6EkC/vEQRA0QXMQEteQTawuVQbtNGclqq2?=
 =?us-ascii?Q?4CPTQ9flC7pb+mfNw92XVM1nZexIsycNqIdB44MNwPC/pxiLTv7k8Cnkx3ka?=
 =?us-ascii?Q?m2SXr8+paRmFNdgdMk8/CDFPkKlatWZ2crIbEVpIHVD4P9U8ImFbED4g5Eyw?=
 =?us-ascii?Q?sfsE90vTqGzqBWm90om4Y2mNJ6cojoNyPmEPbfM8cpbNoikzHeuMnLnrqX5/?=
 =?us-ascii?Q?4Wz1RMgFwXgQMIV2LCJ8qwjyRTXVCcApQlQgUSntZTLwS0bMnBLJcgkLRy+7?=
 =?us-ascii?Q?HdJl+WnGnz+mqj0BkjPtYG5lu9+UrajnvsjbuK+8U81rr6oTeyULmvj9RnBF?=
 =?us-ascii?Q?OdHUhrNZBvyCsXHJNVdFI7DGl884SdL5ZX13OpfPAmkpeJYGChjEHUjTDKlF?=
 =?us-ascii?Q?S6DhZ92aZs2xTkEn0CJ1ZA0Tn4zBbRuAELC7FFUWEZXjHxabrb+yIIktN7DU?=
 =?us-ascii?Q?ZqEID1hXfKT+lAMsUwqqD3VS3LR/xpViuvQNeOab6/V7+mc7o8AiDO9If+BL?=
 =?us-ascii?Q?0m7gfuZ8k2SWosFlRLGuN9Mu+qkMhWVQtsBEv+0XbSyDCKlO9lvddOdZ3piy?=
 =?us-ascii?Q?dn8sJKjdIhpa4a3hDouUdXIrWyIRVZxHbXeVZJsW+5EXRjX08SsrfPsJxpBr?=
 =?us-ascii?Q?4vcJ2row9ih49VIzbxnd8snZp/5vkjjxOhjDtw4FMwdCFMS2btku7LTsaDHB?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PdAVC261onP7BcS05T3eNSaLCtJJegzuBXdX1kyBt2qAjPBMMlcLiFxqql79?=
 =?us-ascii?Q?gOt3iBMqWvHdDCKYmxq1N0QNfAkWPy2S2LYYLPhx55Dhw89/lOZKZ+5dDg6W?=
 =?us-ascii?Q?lBfO+2Xh/VJR/ZKPMpVj2on99hArjmN3L8dTT/CPF35x9UZFgRkTe7Phi4Uw?=
 =?us-ascii?Q?CZO13RBdsXRUWtYc46Ncc1rvMX52q3uGQ4AKNNAlrjE1H7tIoSIO3O1H9C73?=
 =?us-ascii?Q?e8Ob6Froybly03FIom+VNP7viao7+WfuPhL/FrhS4W4CGs4aYb9uc41Ejdw+?=
 =?us-ascii?Q?0759v5svVImGdqc7aUSg8eHUnA+tYgwf4FYaTeoY/C9wvnTWmTZIDLHtC+sa?=
 =?us-ascii?Q?AWPRya/LpTD23U9PGDY4+EyRAOf3bZU57d+zd23N/j8gvwld16F8qYXdpHjM?=
 =?us-ascii?Q?qcXovuUjNpHrneuG8V7jDVBQ6Pc3WDKPHmpLvZrTkIzjo4d8MezeofsJy3dT?=
 =?us-ascii?Q?ciku3hSuIEaX0HjeAewz2GRoxetF1Epcmp2r7pY5dWGqYKaLWEcF7oP9+9n7?=
 =?us-ascii?Q?LheeH0c0sc7PP7w7B5K/Pum61YPsD+aOZTVJcyT8JISXRGWXKa/wGrM1fykh?=
 =?us-ascii?Q?hVHQGX+m7ZsP3giLDIrRSATAaM9LhY4AYUoP0+7NeU9aMk2mWXfI3dpau6mb?=
 =?us-ascii?Q?aiM7vIA1yauNNY4XrruZQdMwIfTmx+tkfxCmZ9HQcfZAkss0xQw5s0MIkieO?=
 =?us-ascii?Q?K4ScJuykP3FZFUd8FlUTlKVN0CwzBeQ8whr2K1J6HLArkRRYkCjA0hyx+oQx?=
 =?us-ascii?Q?W9vOhUe236uz19Uc5bpC3D7px26G81WN/k4fYWzcuwLQwpKNFXRjUWXvkIFZ?=
 =?us-ascii?Q?GAcM+txhOrlXgzztN/JCi785l7EdAmcBbgSAkCEEPm09FZvEaZUOPyQPv3hT?=
 =?us-ascii?Q?mLn5Uh8LtREvB3WmG6GfQB97S2OjsuDejJQfM9FRLd1VSY6bUq1BMCc8oA6L?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b4764d-038e-47d5-fdf1-08db6b85397d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:14.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7zfx+g3YsD0fZUgxek1cnSYpd3dSJ7oep46Z8fFaxDInB/1xkHrfQuhYCkdNuYEhCH1VjFO106ssrFSJhqggg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120176
X-Proofpoint-ORIG-GUID: QViMhexuKJwuYAl0IJkZO2TvD0jIjTc6
X-Proofpoint-GUID: QViMhexuKJwuYAl0IJkZO2TvD0jIjTc6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_set_range() resets the node to MAS_START, which will cause a re-walk
of the tree to the range.  This is unnecessary when the maple state is
already at the correct location of the write.  Add a function that only
sets the range to avoid unnecessary re-walking of the tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 295548cca8b3..ed50d8f459e6 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -531,6 +531,22 @@ static inline void mas_reset(struct ma_state *mas)
  */
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
+/**
+ * __mas_set_range() - Set up Maple Tree operation state to a sub-range of the
+ * current location.
+ * @mas: Maple Tree operation state.
+ * @start: New start of range in the Maple Tree.
+ * @last: New end of range in the Maple Tree.
+ *
+ * set the internal maple state values to a sub-range.
+ * Please use mas_set_range() if you do not know where you are in the tree.
+ */
+static inline void __mas_set_range(struct ma_state *mas, unsigned long start,
+		unsigned long last)
+{
+       mas->index = start;
+       mas->last = last;
+}
 
 /**
  * mas_set_range() - Set up Maple Tree operation state for a different index.
@@ -545,9 +561,8 @@ static inline void mas_reset(struct ma_state *mas)
 static inline
 void mas_set_range(struct ma_state *mas, unsigned long start, unsigned long last)
 {
-	       mas->index = start;
-	       mas->last = last;
-	       mas->node = MAS_START;
+	__mas_set_range(mas, start, last);
+	mas->node = MAS_START;
 }
 
 /**
-- 
2.39.2

