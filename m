Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C14664E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjAJVfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjAJVfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:35:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4F215FF4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:33:28 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ALURlI023382;
        Tue, 10 Jan 2023 21:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ia/pKYvs485DK07VT5Hlv1uptsr6AIwYUeTt8NNpORU=;
 b=fTNoAIxRBkWp+dRlqkY7ujQX9WGEtZJDvbyhlydkZfv53fbfajR067Rj3a6dcNYpU3W/
 jUFl/9/NIG/RksQkLoRhM8XKR8ekr0jYPCVdcV2k/yuPycrfpzaFu+zZqkVFylq7lUa8
 zoadp3gd4wZgFcyfmzOsK38lJygxwzLX8Aio2e9i+vILQAn56P3BNnnYxuDuePQJEDQL
 2TyWkN3/LQQhqjWyDTHTVuP6s1OZfMKdbNdqXFhJCpoT9isVp/1W6beNtxfiFHZH/CTz
 FOpRIa6Cv/+GSWUg6/RBh8J7mKybr1EAiNKMbmkYuYb7JKTA0xdqPF34sNXJKv8gFgXx 9w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n185t96fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:33:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30ALOdsJ003116;
        Tue, 10 Jan 2023 21:33:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1fwera8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:33:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YddkCwTs2WJx6lF1QYlWr6nXo9uq68Q3IaF65ne9uA3+55ALdKrRg8LeEpYePctlEMvN5t3r+DRrdFT4ptitq2v0b4ImzS13/AafEchnCbFq3VObCwjLQdmDiikUH3QtLD0/AqWlxl7WVcGOjCIlqMTvI/yqhU5S/F8Wt9On/0neVbsN4ZG4MMRCGP0wEJl5NYSXpnVmDpGKPfXJDKq4GZBq+Vc42MF3t8kC1S3ttXz2X/XD1zdzjUpiJ2hU3IZcyDK9XVn3bEPH6ty0znyD3e7JB93BlJKDSOPpc0K/U7AX3Gcs1F7lyS8m4YQfRd4MQWaO3r8ycNzxGHaJlqebOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia/pKYvs485DK07VT5Hlv1uptsr6AIwYUeTt8NNpORU=;
 b=jspRWFq/I4w6EYaofsW5E0iB+XkSyEiox23EmSmaoSl3KZd0CSw+upZRrAoFx17FCCNgscI64gbvn87Vpn4kG02Ff2G++7SOt/5Blldp+k54cE54ccT3QmplpOnlDFCyeXuv2OPjMJT6qR/S6aUht27+LTvi0+weEDdsDSanPIkHfQp/CdgiBsTmBntXKmt4p5PXTn6iEzckuJoxGE/BG7SH4vO48Ky93EVzZSG5t+zOVKOFO4jRP+V0rIwfUrkxht2geCQ03bU8L0wpEXRk4IgHkFbekuvcP9cYKVoFo1OjPz7879Z+j+7M2Yel1Sb6ehGUlorunfI6Rg6tnbgprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia/pKYvs485DK07VT5Hlv1uptsr6AIwYUeTt8NNpORU=;
 b=iWkdDCSAFFZ/Q9I9TVULsXtOXbWVvCss81IOOTDw8Q1zqQ7DiPVENV1JHsX0ytXZaBFlSVUYDWkhGqJAGadOJ12Z53tqWOvOujt1heeGZ43q2/ckRUI9CC9qXbvMrnm9tB/W4EH8p23q+8PHUrkHIf3Fk2tMkf4fQ7t3GHWm6ic=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS7PR10MB5133.namprd10.prod.outlook.com (2603:10b6:5:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 21:28:35 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 21:28:35 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 2/8] mm/hugetlb: convert __update_and_free_page() to folios
Date:   Tue, 10 Jan 2023 15:28:15 -0600
Message-Id: <20230110212821.984047-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
References: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0109.namprd11.prod.outlook.com
 (2603:10b6:806:d1::24) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS7PR10MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: bdae4b27-ffaa-4b77-deea-08daf351a15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mI9lrunfJ2xs+JpKSSar20cyp8EwLL/4pNDZMnyrtDBiBX4zxs6ILAMWm77IIoiOIPSia23SFowSIY8KTV+Qk9kLPmn9jkQTh4Lr4Xu2Ggc71mOh3kV5KMYcvfaGXCe8XRZdkVU4VawuhNItrwA8olsA8tugZ9k/HcQy0kHyKb3ocWdFZHW7B0wBgl3gs3GrJAPoO5eL/oUiSo2u8J6Prlz4zFnsMqEhyEU3BFybmNNl0HTGVevc0DRvk+i7muIWaO5lYAcES/CEiS+lx643uDYS0DvlpHkU8abQ1LH3AYrCsfTciVg1it/5rfwDXT8cN91IpArIJoyJmeuz39s6279EHW3tA60eBIhcvcnL7KPeaBV3VjGGjTQJyij25YQfLVOSFI/T8sUZYlHp+foLufpsHuJadD34+52g2qW/JXcygKUJxAbGogj8N+MluZVViEjVMymRSUp1EKvlVHbktC4AMWIlfsvn//PvT13EH+bMhUkp0JzbTMMTsVWTVIuMosD3malqjhZp+zi16JlB1U9V2zqkYu+G9mW6DKkhIIft6U+UpWZ5sMfn6T5ZWhOaCEMOoWUXnQbMm4/PHuItaNvTESjd2Vz1xgHdVvQQR/ZjlXtsXYFoNUxXuAx3wf/QVIr5S+sHBwjO8WX4SqAlTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(38100700002)(316002)(36756003)(5660300002)(2906002)(41300700001)(44832011)(86362001)(8936002)(66556008)(66946007)(4326008)(8676002)(66476007)(83380400001)(6512007)(478600001)(6486002)(1076003)(6506007)(2616005)(107886003)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1pf4ss0ZXrngEpP3s6Fad79txZOqDpBBGjLpdipeLg6G8e9jy+polv57fGNI?=
 =?us-ascii?Q?xaCl0sH+r81aV/734H5ZSrhKMseLeczA6POCv6P64E/rR33aI33+eDIow7P8?=
 =?us-ascii?Q?M6hxIdZxcbCawbgZeuAZPSYHs+9Iwm0aet+CQSYu/YF/inxuRys2xXV1fuId?=
 =?us-ascii?Q?gv5rdJKdlGDJPcfZxPxE7G30NB1ZuIYDrruavIeWDkm0L6s8dLO1d/C77HsS?=
 =?us-ascii?Q?fgEF5VOXHRpoPb7bc1FruBO8Fgh2FYp63PNxQqpQbX8c/eiu9QVQK4aJK/P7?=
 =?us-ascii?Q?jiwvRw6FsIimWAj4uRMy5G9qvlNV/taaLrIaq3Jw6Z/W2tSa9VksuMDIaGQv?=
 =?us-ascii?Q?XiZ1WqahA3MHzur/f61XnJ3CKM1mnXbyTlMs2KbPQv8chO3UiKOFCRGf5BjJ?=
 =?us-ascii?Q?Kh15rz5VeloitGZGJnE5OQNqni1nbd7Y0OAszuPJrYQ37gTwP3/i7YJoRz6a?=
 =?us-ascii?Q?A7mr1t6XI8pagzgtkX4GEgLvQzHj3XAMWeYD5RHdoTtJdat/Bfb/sYGOKSX9?=
 =?us-ascii?Q?iUv68mz9wiVRmERmIzwMpzMRT4bYuMjn+rKKhtdqFY72+5WKFmwv7SXMERkI?=
 =?us-ascii?Q?IyetDrvupWWQIg9Z29tmbDt2LTFMa9MU2bYvBvav5H7kOrTKiKhsLigKaVet?=
 =?us-ascii?Q?OPaBBl3h3scQeivRld7O2VCNhdiBIQEtJ+lGfuNiJSVFxs0uw/MMZgPxQ/3W?=
 =?us-ascii?Q?gW3BgzOkPFTYpgQDzYnncuBPv8rYXZV0mLEUeaseHEC0z5bMC6t6oTxbPwx6?=
 =?us-ascii?Q?pmP9FtPmdTI+2Ar1phCzyRazol7Oix6jN2CUwL9QaN6d27C3nkWXiwkV17Pq?=
 =?us-ascii?Q?CA4HAsfunv9l/iPJ2kpH0opmYGQ+o5vLwIKBCvIGfuY2AoYpk/LOATbXqG/s?=
 =?us-ascii?Q?E2n8+vLjkR+Uz9asjVr7/6VO4AKqFavH+ieLXe0y3Bj2q/NY9Zvsv2WnmbB3?=
 =?us-ascii?Q?l40vTCoviJaqgHFpJnwjIqNqZMUEVXWrg9CwjTPnN7/PiIOeaMta/EkV4+cm?=
 =?us-ascii?Q?yfh1eaTSGv4alWfipjxmQReL2l1bzyMtWXGv1fhP2FH6atSxVvpGEAbGttom?=
 =?us-ascii?Q?TYqnNjnJiSsDVnbuDeKR1pT2+5/4QNVkFdj40buooaCZ/I7eFSdu4hCRJvey?=
 =?us-ascii?Q?VxauUXp/n8w+Eutgyhhi+Uq30IhWhjmg2q31iOsmKEzDD/UNogmlY8E57jxy?=
 =?us-ascii?Q?lTw3dfZ1nfiMLh7Xl3y+U+Q7b15Y8Ml+6jxws98poPpYCQZQ0gPRZhTYmzYB?=
 =?us-ascii?Q?yI9tFp2NAPqjVo73NzSwZFuKC3moA3vHKbLwK99YiSksp0gM+UW4H7cKJrhY?=
 =?us-ascii?Q?rDbGJSYaShoKAfT2oIzz4KdaweLPwzy4RibS0VasFjmhKA6+ZWZdM17P4Pjf?=
 =?us-ascii?Q?R/EYIPsm0/y5TxRgEvw5JM49++eZ3o00WXktyjyGmn4vIgbboTvHZOOtiQEo?=
 =?us-ascii?Q?fCwRcgGnuD5KjdbRAHf0mrqpUwBEAiNjsQRZOxQP7GZjIysAe/P+lJgVi4jf?=
 =?us-ascii?Q?yukv4Zn1g5LE3w7noVMUnOeTQBShbcMa3lYOILCe2H3ssMZOn18Y4R/JYyYg?=
 =?us-ascii?Q?wzfUXNnoy1HEAyenLOdFknaLaMISAOSK5VPTkNlVXqWHegoA9kbTFpNJ5vO1?=
 =?us-ascii?Q?WXBRikyjrnyHSycGTHV8T/0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JSxArzg/iEwXMYb7PqUj78oZCdfqdmOiDDVqEj3AtaJWGs8gVz6eq+pViM5s?=
 =?us-ascii?Q?rd+6qv9IjlJtU0l+FkA0Gc/7uCmUctofGpJs77Xy7tgvCNWLYZNc72Qmzgli?=
 =?us-ascii?Q?GIfgKZVtrLHN4S2bUJy+8oT6n0lfjAAuOjDG5eb5/uPCIlFBkqcQ/f5mEvdv?=
 =?us-ascii?Q?cbKJNxfEw3qhzf2v3F47ow6cz4DZRurr80e/ukoLjyB8uxbPJKglycSLSBa8?=
 =?us-ascii?Q?0aqYHclQdbflqXg0WkjEwhp7Y3iiULxMg+hBzcnjiNz7FhdWGV+kI9GYVEGT?=
 =?us-ascii?Q?TeYVpYGi/jb4GSUux6lj+a2jlMbJhjV4suKRNiYf8z2YbRQ/amaEq+7tAVxi?=
 =?us-ascii?Q?Zm1a8xdianEXaCkJJ3qKGvKfDXy8JQBeS/mPth/EVEfXvjZKyay79zVHoBVI?=
 =?us-ascii?Q?65xsQC4m0h/jOpg67Xva5dEe2uLgTy3HZ5ipfM3UsRU/wUri2GSUcE7x4m1H?=
 =?us-ascii?Q?ISrtY9ehWdl2F0aowd9g1gd0Xxw8P2CSYuFKT7OUzgWZtcV5G7Eg2EWkkZXW?=
 =?us-ascii?Q?l6JMFU4bi2mCp/mPM4bjEB/idpKTIQZhSUeZZmdDJ0L080ZzFzB+iOcRUctY?=
 =?us-ascii?Q?/hj0xnPnuKKAkH/o38PbwDOpZgwZkWBKn9erlSYGSboK9MK4XOW6/uBRJlJI?=
 =?us-ascii?Q?v9A6lRoZbRt/VBJ7XnolW3W8FKlIdAXpFXqXQCXB1Llul1CFXVmsaIVPMG0B?=
 =?us-ascii?Q?Cnf5m1fxoUomItkW+PXeOghyGMI90OoFTPA1vEWEtxEaBt78mD57VYTEGqMg?=
 =?us-ascii?Q?zIUYdj/BrJEYdQTl82lSXK7i1Vfts5O+LmcUEMo9KUvXIlOUozRcvvki7xXw?=
 =?us-ascii?Q?WR+QEpfCG92smTUX73XdP5pSz8oqKAI4MWa8YiqLLY/LLa+iON5Op0vFveD+?=
 =?us-ascii?Q?BCINdO+BMeMpR7yzITXxz4J6ZziyYQePY2SqmMqXBNT+EG8vK8Lps1eQbuGw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdae4b27-ffaa-4b77-deea-08daf351a15b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 21:28:35.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gd9ZhhDq8ibECPYdu307LtwCie3V4cksyW2DRS9ZjCXfrypo9HejW878+QpbCFwjE5bN0FPnewofDgZDAJEcimmPFKNQX/E1zKu4VdamcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100143
X-Proofpoint-ORIG-GUID: krBTCGsmoZ1qLCk89MOoVIMewxOellAd
X-Proofpoint-GUID: krBTCGsmoZ1qLCk89MOoVIMewxOellAd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change __update_and_free_page() to __update_and_free_hugetlb_folio() by
changing its callers to pass in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 540f33d8cc51..9155bb5ee570 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1556,10 +1556,10 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 	enqueue_hugetlb_folio(h, folio);
 }
 
-static void __update_and_free_page(struct hstate *h, struct page *page)
+static void __update_and_free_hugetlb_folio(struct hstate *h,
+						struct folio *folio)
 {
 	int i;
-	struct folio *folio = page_folio(page);
 	struct page *subpage;
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
@@ -1572,7 +1572,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return;
 
-	if (hugetlb_vmemmap_restore(h, page)) {
+	if (hugetlb_vmemmap_restore(h, &folio->page)) {
 		spin_lock_irq(&hugetlb_lock);
 		/*
 		 * If we cannot allocate vmemmap pages, just refuse to free the
@@ -1608,7 +1608,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_folio(folio, huge_page_order(h));
 	} else {
-		__free_pages(page, huge_page_order(h));
+		__free_pages(&folio->page, huge_page_order(h));
 	}
 }
 
@@ -1648,7 +1648,7 @@ static void free_hpage_workfn(struct work_struct *work)
 		 */
 		h = size_to_hstate(page_size(page));
 
-		__update_and_free_page(h, page);
+		__update_and_free_hugetlb_folio(h, page_folio(page));
 
 		cond_resched();
 	}
@@ -1665,7 +1665,7 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 				 bool atomic)
 {
 	if (!folio_test_hugetlb_vmemmap_optimized(folio) || !atomic) {
-		__update_and_free_page(h, &folio->page);
+		__update_and_free_hugetlb_folio(h, folio);
 		return;
 	}
 
-- 
2.39.0

