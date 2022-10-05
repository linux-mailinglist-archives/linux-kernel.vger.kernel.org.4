Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B215F5230
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJEKGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJEKGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:06:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC185A2FC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:06:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2957lvl8005055;
        Wed, 5 Oct 2022 10:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=kJ266YDuh/Xy6plBZk5cYN/RH1yaktm/nvDR7RgOKaA=;
 b=YzFrmuxLJ2m1EFarmp/U2+Vz3Rn7XxaYnp669Uv/IEryK6Wu7bNOA8rE/LBpORpeRiHu
 d8/yXgOttFIbxvSYZd3277RezkX4/oMn41jFqO7xK/juoQSpxXhmsPO4+TIVqrxdWz17
 aMhF55RY9MjCQI3YVnRTl2RmqPqkqJpPaxDoP6XXJp9XOu1h8b5JUIkMOeuUtxUYydMt
 Zje76lTo5/CrytrgDVvBZrSzhV0z2OamIM99XuFHnnJcRydmpztOvXMI2yG21+p3By5X
 ps9s4Lkym7X9X9LxGOOwKIXTLJDRY5KqJ2NmuNIrADVj5/bJYJPaNCNO6kQ/XcUtdhB9 XQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k15up0a4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 10:05:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2959sruN037912;
        Wed, 5 Oct 2022 10:05:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc05fu9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 10:05:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9VPQaLfzgx8CWCO+PRFeBV8tVZ/WgzPeH1b9wJc7saw2/MEX9LmJOb6Qx3rjwLxZILsg6/uX1j3l1P4N2PAoUAEdlUoCy+QCgXG5zwh4oWsc7zZDaZfe/Y6X+IVaxoIwethHmI0WhkAAYmfRX2H5eghppTw1KS2WLussgEeR355v/u5PZGrJE8Az4E+LCm4G/80JjNz2wB3DEYj2ZHL3dZ9HqhbZt6KgFfbtgoEMXVPYNslZd7LpRlBZm5H25Iljmyc4/1+QNMIDoSZWatnk8PWp+DW2rNcPTO7iXokdd0xPXj4TZkHZUqkIZtDwW8zrw7NBawIA7+0sS6uHCt+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJ266YDuh/Xy6plBZk5cYN/RH1yaktm/nvDR7RgOKaA=;
 b=fx15lFpvlukDV5ja7W7RXo3EWnW76ydgWxL+RxCRLg3CMQhbOd1P3lVl7FWRT02H5MTMKEh+n+vh+vgh3m3MxbI+b80GgEJdjgJdo7KAjS/scC/CMJeeFKTUUYu5A914+L5rmEQZBHQUEWB6hNggWpSL2HQofff1aCVubeT6qmHmiqdoHxk6W2NCzU4jaR/gne3qmtpl2RKIQpuBP++iAVyF1dbn0p7WT0W34Z6W4rq2E0brQoUinyL0zQ3jjOeB/Im6D3fFtZ9AccGMViC/nZgG2DXQkQUsNb08ErdVxq892vvv5m50/0v0KnJnMEbDcNGSjDXgXNPpIpzdGyUcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ266YDuh/Xy6plBZk5cYN/RH1yaktm/nvDR7RgOKaA=;
 b=C8bEDtLlfZJ1tRPi+weiuk3wO72tRatl479asSxeF86gwJDwQw5PhQ0NcIh1vjvEyV+3OGbnm5njmnJBTp2g9fFDFpHJk7XMAKiSFsLoimPrrYcNyQCXU7PKgKyyLwJFNz4duMjgtoWxdfKGSN1OBsrrS4Xjh4wWcJG+qp6yegw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4672.namprd10.prod.outlook.com
 (2603:10b6:a03:2af::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 5 Oct
 2022 10:05:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 10:05:50 +0000
Date:   Wed, 5 Oct 2022 13:05:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Mengyuan Lou <mengyuanlou@net-swift.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [kbuild] drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:54
 ngbe_shutdown() error: uninitialized symbol 'wake'.
Message-ID: <202210051608.le3wSeQi-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MR1P264CA0203.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|SJ0PR10MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: 266a49f7-d5b7-4a78-e85c-08daa6b92e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1eWON8sSUuy4h667Zft2oq44tl66Nj+LSbSp8qwUpN8+JvJW/G0G729Pr1NIKGTFRlYeh91Tl+0O15JWtRulK+RCvOnlad6LECa2u9N4iG/Q3y6lK8lPuKU/t8kjTMYTwyp3wnch4EboXED7q7khRnZx0Ov720nkd6XcC2zE2wm2qH/SdJOcZ/aGciPETsqis/avkmUT74v0osQCeGZhHns76mlAs1K3XEfTC2Ek7UfMDua8Mg5tpB8+zwpIkeWAvwrvGZUs9f+0F0WDILwL5hQQZRHcLKr2APkYcZ5v5zS0UVW8XwqsmCExqu6ipl2RhecWFJT9sp3nI6L2pQx4FuG9kFNotjW3ruikR2puursJ0VwrQ4McHjuhPh7YPPOnTE8xQxU4uIMJJzC+50VI3TXjNPt9Qd0WluG/XA8pMGsrgPrffK41ngsZrvHWvka5XOdUgSwooyaLoX2TsTtgSyx8xn9WWSqj+jFrqdJ0IdqAcO6ArbRbOnn+KzIlsyDR0xDsD3tILjQfG8W30f7OhwUvwmsKgAV+UJTZW4KrOkzQG/VQMKQgBtwMtgQ1aMxRjf+jIlfOaMrMi4rC97FQxwMfweniRC4JAXqDrDjt/iqpgNVh0VyO8oT67bIUVIN5TMGJciEkeLmF7RHP0OCP8E9Vcb5HR/FJehTF+31tfj9FZ2GoIRcu0CYx47WcgjzsWRoVHPUdHTTOg2OuhRIpNCGEjdUXeP5RcGZChxiyjIXJjOPXGxKyl6rSQbngwLuois6r7FdVitMP0FPz7AldQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(5660300002)(86362001)(8936002)(2906002)(44832011)(41300700001)(1076003)(66946007)(38100700002)(186003)(316002)(54906003)(66476007)(4326008)(66556008)(8676002)(6916009)(6486002)(478600001)(966005)(6506007)(83380400001)(26005)(9686003)(6512007)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YHACQebRjDfpYEzRbt27zkbugl2VYULyQ70wf8NqlF09R1DbpTuh2wlFQTBy?=
 =?us-ascii?Q?kfo/aonxJK4W/4erRDMo2Tgi6Jtmven+Wl+HvuQHQNQazjzEv6hqWRl2zlPm?=
 =?us-ascii?Q?y8gRX4CX8TxbsO5qsiTEpiaEPi1SYQzqAcIa6Nd4huaDBn9/9K21yxYJcbiU?=
 =?us-ascii?Q?sV6FWLCg8RvpqUzjeyOJ+LybC5d+KoCmyvXSeUcA81yoqYp7jO+fUMF1wmu5?=
 =?us-ascii?Q?3rHiymIXdVf21JwrhbYZPhTEb/aPrEeE1rG5KOGmJ8ePBwpWxzXt+kCOUIn5?=
 =?us-ascii?Q?uvYuYZFrYmXYjjwKv6/yOHKQPKBtK/7KqIyWWaIXqOqqVlRIS/XPFGL20Rvf?=
 =?us-ascii?Q?+agcMFCXiJAffyJ+4FTcppG1ddvGivVT7+ldeF2QK+3Ae/UtKMKy2eh5zbzj?=
 =?us-ascii?Q?TFv7eOviHgHiS+vqJMmiL71jvzLRvRb+pJyUSSNQtyjYELWpHUdDQ7CsQcly?=
 =?us-ascii?Q?9XmHyqX0N82QV5IkCGsG3Xdmm/VlWQmCctn0yM0k/PcH2qbuHkmJnugrkxso?=
 =?us-ascii?Q?CmCvT6k8iZo3fo9phe/wN1diUilG43J8T27o9mmbdaFDAGA15I1vNIVkNNXp?=
 =?us-ascii?Q?Lkd5L6aOAGgTeYUvRsJEazkNtn6ryyIRDpVsWjql2q9F4U/PoVHQcIuXM1ex?=
 =?us-ascii?Q?jGosG3yJB1u0YMJS7rJxWrluYGRKjdr6nnjpfVdX5mXz0JiwEGNw5GBQQ+p6?=
 =?us-ascii?Q?beM/U+m7MW9iFwYCsbLvDNrFxP5ENHjW5aLcMn70UULmRSXNAdUmjx1vT/7x?=
 =?us-ascii?Q?0mp5vqIA+PdS9m5L19FWLXU9TpSfJvo6i7QBbchvHaMuVbfowop15lyaUlZB?=
 =?us-ascii?Q?s++WFJy4okbB19ut5+O2jy9b1tLA232Zq6GmHA6smmovenPjqp3VnlKTH+6f?=
 =?us-ascii?Q?WwZwyb4NvWs7y+f0Dy+fpMqjIEXp426xl3FzrstMPr5BNVjOYXFGPOL9qoDs?=
 =?us-ascii?Q?7Dn/y8qMSmch6XBQg6K49K8I2wqYHURmApceGlOSjHNgyq9DcnDOz7cbo4/G?=
 =?us-ascii?Q?MqpQ5sZnA82id6NX23T2BDtcF5tu7u0Px0dXp5jNqrVFgd6J35ayTz3a0ZdJ?=
 =?us-ascii?Q?JSMGPgc2gNHTE02l++UFOaTNzKZOIU1c6vyWY2OCHqu2pUZEQV3m8pjduqqq?=
 =?us-ascii?Q?gKPdr+T/ry1fA/OLZfF2ts+8OgJYCuSJVKHETWndeoaeW2GiQF3yHoOz2SfB?=
 =?us-ascii?Q?czedZ78gbIriLg0hWGpfa/AAMVTr7NVrwueOdQ8PR5jxfQeGUGH1CFFMwIKy?=
 =?us-ascii?Q?Kn+4mppwednvCzKY0LVO9ffszqr8kcyTVM6mOeh/1WNCCv1+zyQdUyC/QMVt?=
 =?us-ascii?Q?865jIbxDrNHK2xDdv2eZIhQmv29iEdIfy53USpFJ2mFYh/xsYJ4suNHCuGTD?=
 =?us-ascii?Q?9vTRC9RXv4mtOPxetRM896V1I/wur3cbchMLLqzWQMXhywiAj+aeyx0J6Sp1?=
 =?us-ascii?Q?xKCBFATgakJwqmGBfS1zqtKcWRb6oAQuqKMw57T5yUdYkqi28o2CmDajz55s?=
 =?us-ascii?Q?SFvGGcQ+tH4LjkWXNgyscOD14O2FFNi9fraX3To4lQxsj3wthkHEbO+buSJg?=
 =?us-ascii?Q?SKrJzfm6ImVBuDYcwcaz4S5O9dqWt04tkXofN+oC4FeOFJZhBgY8X5eVZRZ2?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?s2MKQSM1sBrkLWkpWlz1X7CgbsdoJ75oO00Ed11r0aEcQLdrwxssCuxi5rNU?=
 =?us-ascii?Q?4IgqIrtJLVWYTV86fW3/rCtkpPTO46rxy+Y6WAkTP/hWynKsiF86bUs4tKno?=
 =?us-ascii?Q?v6FMpa5P/wdymO5jGUYJJto0cX2/TSKds5rqPZ1LNTTLVueg9fNRHetPwE5C?=
 =?us-ascii?Q?LVES4XD+tsXxRQ5MTllWvwALnbH7tNUrkukwXQL6Hj61KsiuU5tBnOi+D/f+?=
 =?us-ascii?Q?GNJ3Mbe6JpP1dxr+pdKokgPTxKpdi+FvEejIa7bMqHsp/GKX0sgAHIdiDSzD?=
 =?us-ascii?Q?P13zVrW8RS+yOe5FdXjb9hzgVtmmZvI8qqXsFbFI1HsDaWsHX5MFe1jGHF88?=
 =?us-ascii?Q?5FthEYdgIyH1aFcsjPXa824+YiMxpiKOfAwy8bH4Z6vvTcCKpV+qGHLsP2b4?=
 =?us-ascii?Q?voYEj697l1I2+Qy1qWAzrQsZGhtv+iQpAubpMdGZyY8HQz7ZlUIJ2J2vGkue?=
 =?us-ascii?Q?eC/lJ8fvgIMrAiV+YQMtcxXu4ImLgUGr5m23vHxkEIFBY9bdUf9uBSK9dgR0?=
 =?us-ascii?Q?SWWrL17gpdjWFEJAIQ6zQMGNhfKi3r7eRF29EyRVwbnaIa8fae9iAhQGqiOv?=
 =?us-ascii?Q?zflItXHoOOCEdtgZtCgCkCGGSyYxf9Vx/tbIhlLqndegyBcQz1k/J+2ouNH3?=
 =?us-ascii?Q?SgyDJY+LxrTYgp0d4ETWzhkUVCIJpE1ImZs4/KNUl7+Ap+QHPXoC18kDkW5f?=
 =?us-ascii?Q?3TXoSC10iuTVEJTeXDUJz15t85ViuGYGLXFliNwNEPK9eqKxgaRvDP+ACDFC?=
 =?us-ascii?Q?2598Knhvti70Bhbp/K+JQxvwFCe5iFm02wpCjdQgfvTyFMdg0cnICDnkd6nF?=
 =?us-ascii?Q?66Z5MT8TkERVOJc1H9cvSiRnH4i95FL0r/8744iJeliYP2XQLpsCjWehRAZd?=
 =?us-ascii?Q?VRopRGDb5e0fzEt+gZvg4ngK3BxnMzBrNLfRSqULLL6ikIwDdxxa5E6DmX/E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266a49f7-d5b7-4a78-e85c-08daa6b92e7e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 10:05:50.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFOnzkHuuH9idc9ZR57Cex691p6LLMfbEDMX//1+rZzVfhPNKBXh296bvcY+FY5r4IZWBpxxZtmjq3y4UTGeoa3NMXxZmaOOjk7qAqK8c2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_01,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210050063
X-Proofpoint-GUID: kohNGr12ou7EiyHlrY6XZZDWh_fM77IF
X-Proofpoint-ORIG-GUID: kohNGr12ou7EiyHlrY6XZZDWh_fM77IF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git   master
head:   2bca25eaeba6190efbfcb38ed169bd7ee43b5aaf
commit: e79e40c83b9fd4e8b9b9d4fc9093d25b7a67c745 net: ngbe: Add build support for ngbe
config: powerpc-randconfig-m041-20221002
compiler: powerpc-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:54 ngbe_shutdown() error: uninitialized symbol 'wake'.

vim +/wake +54 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c

e79e40c83b9fd4 Mengyuan Lou 2022-08-26  47  static void ngbe_shutdown(struct pci_dev *pdev)
e79e40c83b9fd4 Mengyuan Lou 2022-08-26  48  {
e79e40c83b9fd4 Mengyuan Lou 2022-08-26  49  	bool wake;
e79e40c83b9fd4 Mengyuan Lou 2022-08-26  50  
e79e40c83b9fd4 Mengyuan Lou 2022-08-26  51  	ngbe_dev_shutdown(pdev, &wake);

ngbe_dev_shutdown() does not do anything to wake.

e79e40c83b9fd4 Mengyuan Lou 2022-08-26  52  
e79e40c83b9fd4 Mengyuan Lou 2022-08-26  53  	if (system_state == SYSTEM_POWER_OFF) {
e79e40c83b9fd4 Mengyuan Lou 2022-08-26 @54  		pci_wake_from_d3(pdev, wake);
                                                                               ^^^^
Uninitialized.


e79e40c83b9fd4 Mengyuan Lou 2022-08-26  55  		pci_set_power_state(pdev, PCI_D3hot);
e79e40c83b9fd4 Mengyuan Lou 2022-08-26  56  	}
e79e40c83b9fd4 Mengyuan Lou 2022-08-26  57  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp  

