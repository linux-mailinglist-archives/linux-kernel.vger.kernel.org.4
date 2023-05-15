Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBC3703D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243334AbjEOS6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbjEOS6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:58:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D228176FE
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:58:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGn8ko012981;
        Mon, 15 May 2023 18:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=CLCmfU+GgmP2p/rNWg/rT1b5FILCUyAGAn8Lbl1Nz3g=;
 b=Ny419x6miYD+cyd7lJvcv5wR9s6KCscYQJkd7S6u4sNGRM/H/DlPeAG1Gvd8o/7JrDOc
 aPKjMie2PQKH2HAoLOAXRWogI8fn7DuHBOr5tlY+/BKomNnh/UQvLSOUHtQZSQsiBf+S
 SxFGNbRL3k0r4bHzGXO/n82X4qbziv6b5gZz/hW2+ccQ/yCEjwxppHRLeofS9ezpw3UP
 5MOgZwkwRDQegccv+8gRsz09J9MwVhF2jbsNMQ5lyGBuau606L2eCjqQjLe9hmzHbPqf
 iKm45y9XYuzQeSP3gnZfzzAe3QKVdICw1sQp2XkRFUg8b3asjtZYi0LA57OwJnch/zdZ eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye0syc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 18:58:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FIXNq3038969;
        Mon, 15 May 2023 18:58:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1092s59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 18:58:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAeN5q41VqrNU2SvvGnuwa2o8IjntSZenFFLPmO9jBW/jPFP6Y2QTArrSnpfBrgLvj/pM52CCpwQ8++7msP0pf8h/HlspojS7+rIboJIqR6DMoeI+vPiP5PsTNmn6ZuyaXF5vL5YHSQAanLfAr06do4Go3z68OUbCVDNmTWne4FJrHuO6rQLRhv9ypF+phpXi6Xa8wsJ7iNDlCPbWhEsWn9mQoo2E6rVoYXzQqw+vfj8LDSzfKbwXg2JLJQ7CHaiJculKtiOyz3VCHRPpz7aQiHGQOCoTQCmoVkKFGQDJfQglKgahhFBm2i0vokub9hrZDLtBMOOvRWYSyf+V0JnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLCmfU+GgmP2p/rNWg/rT1b5FILCUyAGAn8Lbl1Nz3g=;
 b=KG5FiWrQ8kW5bBQSZldGfdbIMiTephv+4SJZfVT3Y/o02zCrL4G9vKiulGxbmmyoyH5mAy81xLwCzLYSiGu9cWJVQds3Jt6Nq6Dt2IU9GQ2xe5A8Ia7jaNYEDbgAX+ZYbTxGHHQzVVq4BXHscYb7Iu3/lktMFYUJQo86GH1ZAhJIoZN4T5OfGIYUjjC3lpt9DEqgekyeqX1ap7j7KraqqMDk/qkF0sTI3G4K3XhvDxMW2KM2izuxJKxnWOzvVnGcIoppd8bwpEw5StTftfFuUYr4RA+yFHI2s4ppVOt+kOgcFqb7dxVSC6Zin4jiPh8RU0H/RnvxgsdWr+LHAliv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLCmfU+GgmP2p/rNWg/rT1b5FILCUyAGAn8Lbl1Nz3g=;
 b=CyUoFpGXFRHfIUOCrEI3QqKKD/6z6Xd3Hg76RTqw7WxyuRbfeoZZuNDABQKgSJ4QXkQY8RCYBeBbLze9WQM+2xa+i8GufgBPD2hWPk43SZpZUgS68EJl/Nd1Es4+8OEROVgZueNqLmkr6uRTH5Dki5m4icJe6is78Z6ego5sVQM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4438.namprd10.prod.outlook.com (2603:10b6:510:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 18:58:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 18:58:13 +0000
Date:   Mon, 15 May 2023 14:58:10 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 10/10] maple_tree: Simplify and clean up
 mas_wr_node_store()
Message-ID: <20230515185810.esnbqaybs5ivttwq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-11-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515131757.60035-11-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0452.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 511319d9-18fa-4dc5-f52e-08db55765579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GrFvBDGJaI5Lt6dTjhlaJnQHFRKBw+35Frvg9lWxkOZDv7224lHM/gevmoNX7v3DqsuzDZlve/ns9tfF72H6fGdbCjdMC86MWZQWy2FUNd5JK6evwmkBSyEoyQj+IcNw/aA8b7ItDlN8q02qUvusUSKoYMDlcFgkaWfJ0qmWJYA6nHsl9xrGZKDxRhrtfNr/otN/sMf1pJKa2Most72LIwfoHoFU1YP6Zkl4ktw5KSa7lj0HIbj5x+GblEhhtXeFFSrNLcKzgTMx248slpGi1608r4nHY4EM7kj8yAj/6nQzbSxyjhONs+Vt9XreUhwIwAbTrxiWjlOpWksvhO015abo4fRsPsyfUDfZ5K0ZUK7WT4b48k4m19w1v1MOfncf41KYBhl+qk+wCN6YKzEA4KRaEMwhgEPMtIjdPf6INxn7br1oJcfONH1YlFGniQqoger1ZsJk8ArOyxoPMymL4vGZbDNhZXOe1ZVXVyGZhMh+4M677S1XnJJdJImzS2HDOKzJzkKrqibsmLPK0rBr9pIYwSF5o8uzsubgvwsnYDyNllgucx1vJ9NkifnHC61
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(66946007)(66476007)(66556008)(6916009)(4326008)(478600001)(6486002)(86362001)(316002)(83380400001)(1076003)(186003)(26005)(6512007)(6506007)(9686003)(8936002)(5660300002)(8676002)(2906002)(33716001)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PfYdUvTU+8I8yNxVi+fol5NB6YBFegtjdePEWLJdR7lyGygzhTlmaqBtVgFs?=
 =?us-ascii?Q?i5L+SGJV4Gcr4A9NBb4Q2qIoLB7N4xC5fMGDoFU63Yz7uxVoB1b9yYtSsOBY?=
 =?us-ascii?Q?nndPtSXUndoMlLjjVPxVg8B8C0cnmiBt0Z7oPkMvtRjDiRYoLcTUqoPprDQ4?=
 =?us-ascii?Q?sa8CY5y65nKmKaEizZ/5DSGSmf96xSStHLXoX2JNQ3t701FO6zV/eqY49YV5?=
 =?us-ascii?Q?jRq+CCb3rIE7ZcP3hLTvOlz2QjVwbxymUYj3bMos74dfLE0ZA88SnJETjtsk?=
 =?us-ascii?Q?lQwmyREMZph+whNfrWm0rDnt2Kq32SvWemZHwcpYGsx/lGZt54HHbX9GVHV2?=
 =?us-ascii?Q?72xn1R7oC1FvwE2uY4j4nFi3YvW3qnAPp+LttykTung1dZwK+Ivj6CMMZFfq?=
 =?us-ascii?Q?w9nP6c+6upWc9FMFehYbRQxzzSwN9cvZJ5vpyMZmP5scapDhQtb4kQ6wXsra?=
 =?us-ascii?Q?6/0GHE6h2u3/tFFZsbKHIPnalFM/eHxb1iJcgbG7gwEtrF0TCZP/zMrIaKrg?=
 =?us-ascii?Q?Ohswsmeptlf7NK8A0J430EphjZPRv812kijAfM2J6bQOxFusNFl76gilsFy3?=
 =?us-ascii?Q?ycmIJwAATm8K6wfPVxpWjvmrskBM1X+HdtmGjZ17ir8OfH2awpFGUMEn74jY?=
 =?us-ascii?Q?se70j1fU+i5OGUcLwngMZaLBQul0oQk0nnSSkTFMiuhhlbsH5ntjwn3Kh8jx?=
 =?us-ascii?Q?InSaD9gZYHLtyi7+rXDuNXPt/ZP/0x9rtnIjbOY5BKpEIrBqbEYzRjgrzoaH?=
 =?us-ascii?Q?x8iV+fAy621wpWkF7vP9vhLid/pr9CePno7d8GONYZnYK/aF7rO4C0aR+DOJ?=
 =?us-ascii?Q?0BHyBKZCKhgW2sAZP2jOBfU2KXpTbdiOD87exQxt5C37oC4SkW7TzZhDksxK?=
 =?us-ascii?Q?+PyoAHt0RpkfdNT0bOaGFwubZMrK23zCDM/OCfUbDvGVFou0whG9FxJ5Ret0?=
 =?us-ascii?Q?SXC9b4CIOkzCuy0fIzXwFv0VPs48ufACN/VwAc1EzZNn093qGqxPdk2nL55d?=
 =?us-ascii?Q?cxbVSjvhEHDYp5Z7XeZ9m5Dla3/EgBiIxxyv3gx4fLbJ5EaOYTKhwr3q9WFk?=
 =?us-ascii?Q?xe0fZ+Kv+SBkK4YObNguJtdWSv0Y8n1I/1zNa1vGjZ7FOu4WiskJSFkCL30r?=
 =?us-ascii?Q?ILL0eP/W3u/L7qFCWtIAlyVQlMPkdxG5T2/ltNeJ0KFE/Jxrwk3d54Fo1fJF?=
 =?us-ascii?Q?cNzxkkTWM4kltriKjVK8LHcM18e5rN4lE7eH63ZkoG5QovwVDpJwH9GM3aWY?=
 =?us-ascii?Q?g4SVAH4j8kINQGdvik7R4zlIhkxQsfymunr9JFRR+68YxhCfjIev8nXGwzDv?=
 =?us-ascii?Q?PLZd3r6QHD1IvhJV6f4BcuY3On88DWk+gRTV3S3meFTe0k/A9j5YofzFTyS9?=
 =?us-ascii?Q?cJg/bdz+ecq20fCamVtmfhPjeDupRfIKia5dEHhhIlrm/pXHkRQtx96DJEYc?=
 =?us-ascii?Q?m5O56L7txdxYeDl144p9lNS9ovUraZ892gzxbPoOPIeqqPHp159Vy6+SguhW?=
 =?us-ascii?Q?dWKRkQD6eepRlHsdOV6Jp0jgULFG37juXLzwGrjTYp7jCfjFq2KHFY8711mV?=
 =?us-ascii?Q?WBZrEbUkTDoH65FoJe8eXdjDdQgAy8NL/fyJecDr2+1P/778dbirnSKJL6eM?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?W/OSiqiNlKVb2RVuhIT1kFkbpt5jEKK1UU8gkZExDbLVQpSTMPvqf6hj4Y9c?=
 =?us-ascii?Q?O9Jdd+1z5dBcg0EfiYIwZP8BBk3dNT1ZU8hnbTBoLoVTjnaG4Uez6edsW1+A?=
 =?us-ascii?Q?UQIJeXf5xebgn5dg1MumIAwAEMNV8qF4yhToah+AGD2P9jeyBsD4yztxgqt9?=
 =?us-ascii?Q?+/9Cgl4fuse90JO09CZdbWO95MohcPv6MHFnISI71f9Z5CSIpUCSNB8eT6UP?=
 =?us-ascii?Q?PlT7nH1eNWed63cDjv3zkpU6MkWkSr7MQ5JRm8RDpz3ZLZi8TZj+q9/9jTG+?=
 =?us-ascii?Q?cGV+lGkTXfYPTQTY4ZU5VRmeAkjCmZwgSDI4zNgPXNMugW0fo5SmZ5pUeIw5?=
 =?us-ascii?Q?X/Gt8hwyg7HvDffbcHKZZIQsRnug0WRfYfrTS4zinRNqwOU+hJTjyc/tBCvE?=
 =?us-ascii?Q?yVeqzlnBctsCopVO6SMb+hJgTDOr4nAifarB09dkAgzC8KA0nLxqa8NQdh0r?=
 =?us-ascii?Q?/ZWm1UFfsdRw8j7b5+RSeR2eovnqk5aapEnk3vfzHsDXYu34KPwUYAxPShou?=
 =?us-ascii?Q?vv/Xm3Hh0HJcP5exUaZpwFRw3i3Y4Shqr2Bm9FKxIOrSwgNA246zWK0lRjRl?=
 =?us-ascii?Q?lJtH66RpVivtGumCs/WqaJFpNDgFDxSjGkQZuA+MDpORfFWjSBaPsEnTKb5R?=
 =?us-ascii?Q?QOjT8lkZyT9vmuomWF132JPwWpX/fBt3mYGYQCcvvri1hKisia+lTk6I3/dr?=
 =?us-ascii?Q?NSoV93s0tplO0ZPjT3qL74ZilU+eCZASW6QXDAtBXBmedMIejdgz6Iic4cqH?=
 =?us-ascii?Q?SRJbLaSzGRsZREv2G+sgIIW2/CLR39R/D+faeYhtkQ21Q6eda1eRZUBtO2eR?=
 =?us-ascii?Q?a11O8AlrfTjaKSIvMVnO0ImeSHeMaasxJhoiy6y1NRthwGhnF0xlj3DkAMIy?=
 =?us-ascii?Q?TDULr1WPS4f6JLj7EBwa1P6Lwm1FUn5q5QZFDqr8/5yzXidTp8yUyahMNV6x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511319d9-18fa-4dc5-f52e-08db55765579
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:58:13.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSyE+LG4G4PiwCJXTjv8136znT7sFWdOKhsxt6ZgQj3Vz5w7hw/qH6QebjTxDwpNggEq21a+ng9ER9jNHq9uJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150160
X-Proofpoint-ORIG-GUID: cGnuv7zN78HIl6ALnNx-CBTOLjcuVd6m
X-Proofpoint-GUID: cGnuv7zN78HIl6ALnNx-CBTOLjcuVd6m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230515 09:18]:
> Simplify and clean up mas_wr_node_store(), remove unnecessary code.

This change fails the userspace testing for me.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 75 +++++++++++++-----------------------------------
>  1 file changed, 20 insertions(+), 55 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index d558e7bcb6da8..ff4aa01cf88b6 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4066,46 +4066,21 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>   *
>   * Return: True if stored, false otherwise
>   */
> -static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
> +static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
> +				     unsigned char new_end)
>  {
>  	struct ma_state *mas = wr_mas->mas;
>  	void __rcu **dst_slots;
>  	unsigned long *dst_pivots;
>  	unsigned char dst_offset;
> -	unsigned char new_end = wr_mas->node_end;
> -	unsigned char offset;
> -	unsigned char node_slots = mt_slots[wr_mas->type];
>  	struct maple_node reuse, *newnode;
> -	unsigned char copy_size, max_piv = mt_pivots[wr_mas->type];
> +	unsigned char copy_size, node_pivots = mt_pivots[wr_mas->type];
>  	bool in_rcu = mt_in_rcu(mas->tree);
>  
> -	offset = mas->offset;
> -	if (mas->last == wr_mas->r_max) {
> -		/* runs right to the end of the node */
> -		if (mas->last == mas->max)
> -			new_end = offset;
> -		/* don't copy this offset */
> +	if (mas->last == wr_mas->end_piv)
>  		wr_mas->offset_end++;
> -	} else if (mas->last < wr_mas->r_max) {
> -		/* new range ends in this range */
> -		if (unlikely(wr_mas->r_max == ULONG_MAX))
> -			mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
> -
> -		new_end++;
> -	} else {
> -		if (wr_mas->end_piv == mas->last)
> -			wr_mas->offset_end++;
> -
> -		new_end -= wr_mas->offset_end - offset - 1;
> -	}
> -
> -	/* new range starts within a range */
> -	if (wr_mas->r_min < mas->index)
> -		new_end++;
> -
> -	/* Not enough room */
> -	if (new_end >= node_slots)
> -		return false;
> +	else if (unlikely(wr_mas->r_max == ULONG_MAX))
> +		mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
>  
>  	/* Not enough data. */
>  	if (!mte_is_root(mas->node) && (new_end <= mt_min_slots[wr_mas->type]) &&
> @@ -4128,47 +4103,36 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
>  	dst_pivots = ma_pivots(newnode, wr_mas->type);
>  	dst_slots = ma_slots(newnode, wr_mas->type);
>  	/* Copy from start to insert point */
> -	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * (offset + 1));
> -	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * (offset + 1));
> -	dst_offset = offset;
> +	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * mas->offset);
> +	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * mas->offset);
>  
>  	/* Handle insert of new range starting after old range */
>  	if (wr_mas->r_min < mas->index) {
> -		mas->offset++;
> -		rcu_assign_pointer(dst_slots[dst_offset], wr_mas->content);
> -		dst_pivots[dst_offset++] = mas->index - 1;
> +		rcu_assign_pointer(dst_slots[mas->offset], wr_mas->content);
> +		dst_pivots[mas->offset++] = mas->index - 1;
>  	}
>  
>  	/* Store the new entry and range end. */
> -	if (dst_offset < max_piv)
> -		dst_pivots[dst_offset] = mas->last;
> -	mas->offset = dst_offset;
> -	rcu_assign_pointer(dst_slots[dst_offset], wr_mas->entry);
> +	if (mas->offset < node_pivots)
> +		dst_pivots[mas->offset] = mas->last;
> +	rcu_assign_pointer(dst_slots[mas->offset], wr_mas->entry);
>  
>  	/*
>  	 * this range wrote to the end of the node or it overwrote the rest of
>  	 * the data
>  	 */
> -	if (wr_mas->offset_end > wr_mas->node_end || mas->last >= mas->max) {
> -		new_end = dst_offset;
> +	if (wr_mas->offset_end > wr_mas->node_end)
>  		goto done;
> -	}
>  
> -	dst_offset++;
> +	dst_offset = mas->offset + 1;
>  	/* Copy to the end of node if necessary. */
>  	copy_size = wr_mas->node_end - wr_mas->offset_end + 1;
>  	memcpy(dst_slots + dst_offset, wr_mas->slots + wr_mas->offset_end,
>  	       sizeof(void *) * copy_size);
> -	if (dst_offset < max_piv) {
> -		if (copy_size > max_piv - dst_offset)
> -			copy_size = max_piv - dst_offset;
> +	memcpy(dst_pivots + dst_offset, wr_mas->pivots + wr_mas->offset_end,
> +	       sizeof(unsigned long) * (copy_size - 1));
>  
> -		memcpy(dst_pivots + dst_offset,
> -		       wr_mas->pivots + wr_mas->offset_end,
> -		       sizeof(unsigned long) * copy_size);
> -	}
> -
> -	if ((wr_mas->node_end == node_slots - 1) && (new_end < node_slots - 1))
> +	if (new_end < node_pivots)
>  		dst_pivots[new_end] = mas->max;
>  
>  done:
> @@ -4429,7 +4393,8 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  
>  	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
>  		return;
> -	else if (mas_wr_node_store(wr_mas))
> +
> +	if (mas_wr_node_store(wr_mas, new_end))
>  		return;
>  
>  	if (mas_is_err(mas))
> -- 
> 2.20.1
> 
