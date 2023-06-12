Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65E772D0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjFLUlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjFLUkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A38E54
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKOQtT003957;
        Mon, 12 Jun 2023 20:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0QsGUeSC8PoHDvjhcOgTqj5kZeGqMxkW78nbUd0JW7g=;
 b=yFkLpVjmpeFyAtGtFkwT1a9KXx87493sNzLCV4Sd1ewYYqNofgtBozTilp6fBszf/0C7
 mOKC6BupJpB2VXmJ9rpyDB+tTrpbBQxk/74hCawJKxFpGEErqD729Tb/7Z2O8nN9WifW
 uU9VXK9hFcjwN27aLrtEHo0GlWC8elMUZg+lwTBzdLslmNNxhqimmXADxpldhbnwh70R
 70oMJ3oYV1DMZdylZBzn7WEFeIEIV4ZpIewZ6xposdUa7S4lHOSlZV76yx82+joVWv3H
 x4sfVXZygcksa5Br5LK/MiyCvtpJrCF/bQNUpgyrqntgl2xLyfDEqkG+UkT0S4H/ihZf 8A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1uxa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKZPxi008941;
        Mon, 12 Jun 2023 20:40:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3hf7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0P7E79rwmAdL1sZFZb8mW0RxW9udSDv+LV5gy0KBo+yxqAXxwaiYgKFSm29fDVYTI6J3O0qHGQMmofTmy3ZJOQEnSEmZRk7hxfV1YbShXxIhffI40ygy45nOe5uiLagO/9ANsWwKYnlOGucd08UOggxa0cERtK4+y9/IfRiKWYOVxpke5PxznPPGRogVHuKmZ0f+mEJyPUsA5L8SW3FvadXflYW0VnKXhkCca5BDeVOmn6p+mkChQv0eAiQs9wI1X7GdPiawWgIqy1iuJZ0aRkr+NKpVdxFrxJJKuKBM/FJtysFnSTMFy4UjWU2mNLhGdBGB2Bn+oRjqWO5yGRH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QsGUeSC8PoHDvjhcOgTqj5kZeGqMxkW78nbUd0JW7g=;
 b=PN6BRqk0UhU6E9tRic7PKGgvfZCcP0zIsVR64OvftBf+qiQUDSWMV3X+bdBYto9+xYmapPG9SpvPFlo7M69ERoOCRBAV9AiVRMV5vPxRFPKCM1cbR9TwhZSTxUH4Pqa8T1MsygHH5rwQfp0JAGLKwZYG0lPgh4V6pCcecjfou8o9ma5uhsRkoLUQrP/yTAk12X6q4aSyZ+oHKF4OBO5XMuPxCJXaexrd9Ngu50aebUpThj2wQskrAkXlgThf5cJ5jNf82ma/MbEDci0t29wPMtFdj8L1HDYsLKBThDnamUUV7BuaZb5E9JNzNdC7t6UquwzwhAwK9bX2ZIAFIpxDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QsGUeSC8PoHDvjhcOgTqj5kZeGqMxkW78nbUd0JW7g=;
 b=sTWDow2CVvoldR7CJo3/r8Pe9cCoaEzx1VfEJ6wfzdwEaeYTOoLUNHRQ8+2LZo/s2lxRg6JHui8MXDKqArNoBtTIAjnGQzhpA3a08wl5KFbwbqSY/6HSdsOTLQ4sX37F2soYmZlClXZo5eW7ghgA+DR6TQ4slrqWoH9a6vWa57o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:17 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 07/16] mm: Remove re-walk from mmap_region()
Date:   Mon, 12 Jun 2023 16:39:44 -0400
Message-Id: <20230612203953.2093911-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: bb06d531-bedc-453e-e26f-08db6b853b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdU7jP74WRqKJNTDI59tzfberdQwwUYcA2ismbAoht3v0sOOtrTK/Dq4HsLSaTeK44b73gj/sekCTlInkW1G26nY4LK8o8QD9oCMprcWqXF5ydZLTGq4u4yrsIJHcftUhOA5HYdhx/A2pgtyHVE93NXUr2YuzAaOV/ZVci7VmYS68zZ1/AjE2uLNsoTxWHTIX7DpUhPUH7PsGzqlhHIG4NqF3CkpepI/Nd54pOK5AMzv7CHFD7r4VgnlS+7o4pBTyq54KC51+QsxbjoRKf5lVGhlqMN9ZL2QQmH5dim+ZYaimpQ9nWYzbF1j9kI6V2KTkIlCnOCPaurXA+O2pAMeEB2kixJ+jSCROwAh9imVovoH0BYqdZ2d2zQy8CRLtRDie8dHTFTWvRrFxHh+R24+BE0p3gps/wq8YekCx3GVUIGUzI+Whiok5DDdxpQ6Ia/0W17iZrP/kn3O4dNANlCAaZgMvqdvrdcvBmSLjIjaAKRK80CRghj8jHZmKtyUbNPC2iDJpXfn2xkqkMtK5qj6Pg0NoOFc9kAlCz2PUkY+nTZ5uZUluULUZrl/2zLsluOZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(2906002)(41300700001)(6666004)(478600001)(6486002)(6506007)(26005)(1076003)(107886003)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UzikNdRC7YheZf+k+2UjbzIkGxwrU6xmUAb+lxhuJLF97p6W416NA3Dm1RF3?=
 =?us-ascii?Q?z7LuBjIdiAPNj/PilO57uJV448NYQQp6CIA/98IiTkElg63ur+d5pL21oq7B?=
 =?us-ascii?Q?XJ3aMTlyx5eImx55cVLwGPHwlGwUxfv4xRPaqd5Q5BQm/25HhBw+UdwLOgWD?=
 =?us-ascii?Q?0wTvpBZAJd152aMjnC6qp1/pSAX4g50o5rBfHghuSAP4eYWmxAu46eg3eVjQ?=
 =?us-ascii?Q?lhncXNFXCA4UL8OpSbkuNcZMtb8GoWTZ6uU+RtDz1NQf0FGYjmLiLhVQrZW1?=
 =?us-ascii?Q?hlM7u9vaW3Ud+X1PdcnmBIRLFHEGNLO09ky+4SHBM6EZBf753GSbxB7FWrpO?=
 =?us-ascii?Q?Ef6cKnFUVU5QS3ANE0oKlZ4MtnqPrtKrLYpIYUcaycqrSc3dpF/2Ehf04HFt?=
 =?us-ascii?Q?hZ64seYvUPeyMJ6GNCz4/Ih3Ct+AowVwzq5A41CNI1Cp6/hphCZqQoZUcT3T?=
 =?us-ascii?Q?DaF6a3IMabMoJn15njmnp7MczC/mr35PUWUkPCKCjtoDjRqnRTa8m21gFdnB?=
 =?us-ascii?Q?oeHt7p9X2jDX2+CEr63Bf/aYiC7A9xlCFeBmKbjGh2d6sjs6dtrhqGyZOpY6?=
 =?us-ascii?Q?aRlt3ZKrN0kAeG25iZ8HNgXcJm4UJ9E+5rzxoWDtUbuyheAhF0bfw3cYOaRx?=
 =?us-ascii?Q?3UBeK052ixYBuvN2Kfsi5b+bMtY9diIZCZoDn6ml1CTwdZRtrgGqmfk02kur?=
 =?us-ascii?Q?mENvh/kmFkQKJI/VUQ2gnSdJBboSSet3dzeU3Cw8Uz5Ic6nvuMjyIc4V0rTP?=
 =?us-ascii?Q?4uBWF8KudOstfqYtQyyEYxevY4XxV6mBHREtnVS13AKzx99CiHYJdTKsA1ec?=
 =?us-ascii?Q?Fd4zHvXHmCcDZS5YF5fcXRjMefgqrH59sAPgbPQrR09VEbkeOXwMyWxzudoq?=
 =?us-ascii?Q?lyCwEcBP/kJJiz/VYSNPHXSnKK8IzvL+csXFRnphwbRK+lJYIIzwyCpEiaBf?=
 =?us-ascii?Q?o7pGj5y+1Gn+KLX/+1JDlgREaHELsIViQAXRRz2V0eTVmBLP25g028BF3F11?=
 =?us-ascii?Q?RH5v/U0POY2heVzYB8tGfElfyAk3WRsfLV3jfDY0jZCJpBZ5A5/xK6WrCtZv?=
 =?us-ascii?Q?wJnuSckcaaNA+2oCEHx6W3wEeUODnCENERWMEmNU2ETQA7rHIxtMtrgXWbir?=
 =?us-ascii?Q?l9oGd3yrgp+XJdZQcLFIXdVviMwSDJpqsFMhYDSfx4Byi5Lq3TPjq/bQh4EU?=
 =?us-ascii?Q?nSlGNclvDmbq6LzjSXe6+IjNmPHBazhdXbb+4rr76IShT07avpsgPoYTJQxk?=
 =?us-ascii?Q?hi1PwC4swIS76T+rOqI4/igikKG2jKJ4IhYPijBJ+rB/bc5qpgckcrpR5R1i?=
 =?us-ascii?Q?PaDn4HeCyMEYZ8d/+2JkYPh/8Hij+GOOn94GbfXMlSAXCDt729Fevs6Cpz4b?=
 =?us-ascii?Q?yB6SBP0MzkV/7QaevzBYt0/kBQBAD76A+KEhlk41N8BgCMdjWvnU0mism1yc?=
 =?us-ascii?Q?gl0HOqhZpZZGnNEUeonazrDJTwh03UAWuZXlXxDwBYF9fPov37cUuPM2XbeP?=
 =?us-ascii?Q?ErSBWXi7vnUZtKwqpaLC1zwRr6Vd7EctWhs5goU8uA73XCEgWW6VukIsr8uM?=
 =?us-ascii?Q?+ftjLwdyCwuasnKgUOw15a2yCo2uSbme7r2wESg6nTVfmWa+9rlgMmNeni3d?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?h5DJsf9aOA2PLYoDopwjdOtKiZleyNCrQSxJxUFHk5Mnr8HJ+jzERkjY2c3B?=
 =?us-ascii?Q?/eK0Wxbo6KegZ5Afm37lafPd5jZXHOHDFHZXY2Rg/kgOmWbd2xmFjN6CepoE?=
 =?us-ascii?Q?Q+Ix+tT7SUEw8jG/aYbwmjQVwJ+EnsyhxGFs1iyEWblhqWggAtGw86XJoBA9?=
 =?us-ascii?Q?8n5OKrRfdnk7r/pTSEEgkzcSxfFM3l6J4y20swROzwV+iZ6mdoyOJAEeoXPQ?=
 =?us-ascii?Q?3VzYfwIXus0g3PZTMsXiRRCaZEjmDWovbx95yoKbtujTBk/mjyyiVNFnt9Gj?=
 =?us-ascii?Q?z5/UpJyMSUnKwMUHhInaXnaSv9BZlYQe35UV+eJ5jfAuLWImaGeYTJ7Dpaqt?=
 =?us-ascii?Q?4ig0qeNL4pnEfNOctQ3yUOy7s1eKjs2gEjKVqHZCzHmTONbSx3X2a9PyYIUE?=
 =?us-ascii?Q?h5U5HR1+aMJ6uT9sn76WSaiG8WKZTMCTp5rpahtfNld3J0rBsUFSkslmIUHH?=
 =?us-ascii?Q?9DKE64CNINns+JkAKqQf4Gy9byjuRe/LPRRR85aww8EnUhvv+GES8Kioi/uZ?=
 =?us-ascii?Q?UlqBqEitaAofhXuUtTosT0eA0p0tzQyuCT+0wCCACy1YI/QUzBzKUTZcnq6W?=
 =?us-ascii?Q?jz/PmEFjMDzpC7088r7qyJsedukv4Sc/xk/kcgOaw91VRP10XsNeX430HFkK?=
 =?us-ascii?Q?neGoj626Ggjzn2RJnEYknWb8Tu9M7OChcWQTfWiYEp33uFcneQGDm//hYm3K?=
 =?us-ascii?Q?4TooOG6O6oR4whsz7+j2JuqTW449wRQN4RjCr5q/Q8vvLZm5Sunc8ayOmqbj?=
 =?us-ascii?Q?vgeBUsLvVMJc8XQwqXth1ak9TlmPjNjuS55T2nFPfiakwxLAqH0eM0Mfzzxf?=
 =?us-ascii?Q?RzO8QoBbF3wPc7Vk2Cs/Frw87vvClqYpMmFT+zY4X9TUwPvYeSbTJtcFE42m?=
 =?us-ascii?Q?ngPRuGWU9hcI85yTg116OE893fkF+ZMQP+IGrGGlKgvUWfc3WO+H/UEJg4Nq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb06d531-bedc-453e-e26f-08db6b853b2f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:17.2080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eo81gt8tJY7HTMPVL2K5LAN8kacb7MZYcGxB1v1q6bREAM0xsiEOfIPmfP3fGZv1OVdh1w51bP7M2cBWNcxkAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=760 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120176
X-Proofpoint-GUID: _VED76G80_mQbMfxLkOmBxo76DP78tXA
X-Proofpoint-ORIG-GUID: _VED76G80_mQbMfxLkOmBxo76DP78tXA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vma_iter_set() will reset the tree and cause a re-walk.  Use
vmi_iter_config() to set the write to a sub-set of the range.  Change
the file case to also use vmi_iter_config() so that the end is correctly
set.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h | 8 ++++++++
 mm/mmap.c     | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 24437f11d3c2..cdf06f680d6e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1034,6 +1034,14 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 	return !(vma->vm_flags & VM_SOFTDIRTY);
 }
 
+static inline void vma_iter_config(struct vma_iterator *vmi,
+		unsigned long index, unsigned long last)
+{
+	MAS_BUG_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+		   (vmi->mas.index > index || vmi->mas.last < index));
+	__mas_set_range(&vmi->mas, index, last - 1);
+}
+
 /*
  * VMA Iterator functions shared between nommu and mmap
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index fd3f505b40cc..8b3e58d6ac40 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2659,7 +2659,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		goto unacct_error;
 	}
 
-	vma_iter_set(&vmi, addr);
+	vma_iter_config(&vmi, addr, end);
 	vma->vm_start = addr;
 	vma->vm_end = end;
 	vm_flags_init(vma, vm_flags);
@@ -2686,7 +2686,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (WARN_ON((addr != vma->vm_start)))
 			goto close_and_free_vma;
 
-		vma_iter_set(&vmi, addr);
+		vma_iter_config(&vmi, addr, end);
 		/*
 		 * If vm_flags changed after call_mmap(), we should try merge
 		 * vma again as we may succeed this time.
-- 
2.39.2

