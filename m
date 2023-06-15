Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13F730CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbjFOBlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjFOBlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:41:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654AE213B;
        Wed, 14 Jun 2023 18:41:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EJw75G011575;
        Thu, 15 Jun 2023 01:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=V62KdqHCqs7L0G8KpXXuHDYrGNz6+56V+biVqINbQmQ=;
 b=bpa39S/TDKyoRTEC29lKMNWMatNy3274SEESY4R9z+fsiWNTIjJqxm6xTnrGjqzoFBI+
 XSCM7HMMCVBRclKDpzbkQ9fd+SftnZsIGuEr+c4sX+YhjI71vRF13RHsE/E693Vetv3P
 OLrgWBnhRY8Zc7fUOD9doqYjFT94qHbhKK0X20MiAACFwrWLHjBRWPgCCIOjdPJjYzyc
 lodrDlpQKpQF/pZ1MJyIuEgnmrBiEPd//prKLbu+60CuGxIwpGYvQv8onMpy8q5Cb/ie
 4lGikGfct/KGXH1AgbRD8CY7TT4w2WuDmq6ZaKrEHHNAJad/mufqXcfcrVnv+0nEYKgC Nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqurwut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:40:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENrX82016344;
        Thu, 15 Jun 2023 01:40:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6ayrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:40:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+ngg65d7ilLW8KFZUDo+nqTbBDP3tcWU0BtUFzmfasLqS2tO7CVW6+vY7IT1J2lPJAtjczuDdJW8LbaB6BjHXOk7BIzdy9DBN0PcN8XBRaxLj/d4lCZVtXbJEOkYrOacwUEeFsQ0WaH9RxQuOvuXv/N76DvLNBzPBTXqA1OA/8vAzBPZN9Hg7K/As1wB5VJSEk0uRrVK9gtnO2/CNw0qxOxlStjvMjSNcKEKggxZSsqlRRSxY4mbsLgPt++mlsFhrhZWOq6EMArV9800kdlrzoGAvFEl6VcxF9Y6eFMvK3/0gh+/yAd57J2SrHNxJzqLB2UceI8/++6G2LMdOvdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V62KdqHCqs7L0G8KpXXuHDYrGNz6+56V+biVqINbQmQ=;
 b=DIwKjKbxBGcycCH7Lm+GMHgmD+XCFhxoVutaD2Hzp4TN5jrU9zZp5dHkJYy0XavZT4ONR9DLynlTJhqczhCKy1ePZ7gT4Fu/DBIvNrggJzaOjWCAic6WyWQ6kL8dhT57iTv1Kd7gndSNP4yZxh6n6kV4LOwS1XdbReE8Ztw9ys6VzL6HzmBlvEoWxSorQogk49jWay6OmnEdvrr+GpgeacGI8QvdfEUwDdnZhrxLPOp0x025PJgy9CKBqrTk9TOCTI1r4tFs/PAqWt8CyhECLvRYW0cW3yGr5P8G72JMMR2Z9aa2Vlx8oPm69JkeOXYU8RZidqGEcw5cHPOn1TbaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V62KdqHCqs7L0G8KpXXuHDYrGNz6+56V+biVqINbQmQ=;
 b=L+lDirVyvlDJcPbWl0u4isL17raAhpPrxRgGL7+5JSYUWlAwhlwO2vN6JBL2XpFfwsX3H9owAltG3G7Ki6o9JlO6RZB9aQJvoAhDyNOsbjM9hOxrE3lxl4p9LRkJKQebVF/QPV1+/uoEbpYiIeQi3Eh0LsyxtJVkybaFKUO0mb8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB4871.namprd10.prod.outlook.com (2603:10b6:408:128::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 01:40:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 01:40:46 +0000
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v5 2/3] scsi: sg: fix blktrace debugfs entries leakage
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1leglwljg.fsf@ca-mkp.ca.oracle.com>
References: <20230610022003.2557284-1-yukuai1@huaweicloud.com>
        <20230610022003.2557284-3-yukuai1@huaweicloud.com>
Date:   Wed, 14 Jun 2023 21:40:44 -0400
In-Reply-To: <20230610022003.2557284-3-yukuai1@huaweicloud.com> (Yu Kuai's
        message of "Sat, 10 Jun 2023 10:20:02 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0101.namprd07.prod.outlook.com
 (2603:10b6:5:337::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BN0PR10MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: d7735921-9f1d-4f4e-2c9a-08db6d418a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FR/XnpYJgwyOJkxHfZwj8hObDYQ+afTGNZo/nwWpBKpWBgZM201NlQJKqvbzxwqZ0dxC6G598wiRK28tVfW8yxtXWHGIw6qDGWA/szLB0sqAexMBIXQSLiWKVzzW2Ay16lPxQTrVl2xFAVJjAseHdky4K3uCcUXHENWdR41vNj93q3fbFe+oW73TkWmf9jZA3ChlyZbNA8OA0/uJ7Ejh7RqVhOp/V/WjruIpCJeJ9bpq89AMK/1azwju6zeaBcTxAxv+cClHNy9Hw1L7Z/oFaDC63ryH1RszWOrmCj4l6gTL5TNqdIsEp7naSzdqz54qWB9W9Xv+rw4cI3Qpv4z9LmmS0qto9rjBB9bH/1pirNidzVNSWn5wQM5sKdmmCyTyw0/6Z7uOP1UxZKRoBpYxKTAt5TlgeOPe/vCRLoC6eDeor5JkbJwrtbBYGwcz76GdGDqlFI+7raXgVs2qIfMoiY388I7gVRVS1Eq/SCRmXXmU2YCQDW3EUW4SnOxSE/jCwc0o77P1fwph0IecLU5rewY/6UWscUljv+AXteBZICGX++9kM1AIr/fnZEPi6G1k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(186003)(6506007)(26005)(38100700002)(6512007)(86362001)(7416002)(83380400001)(4744005)(2906002)(41300700001)(316002)(6486002)(36916002)(8936002)(66946007)(8676002)(478600001)(6916009)(66476007)(66556008)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nEku2Jv+46mIe3R1ikHuPzQkX5Flad5I5t+h4pKrwgZ3nZV4g68bWPP7Msb5?=
 =?us-ascii?Q?78ZKbzkGeITLtnGHN6KnZK5I4+R36IuAfQuRmYx90OSxtDlUKYTLjaZnfMXS?=
 =?us-ascii?Q?wDGOa4B69u+Uhqrv8KMKZqXCcXM4vRXliu5tPAvD6/JXTzJzlbjA5OXHbTX0?=
 =?us-ascii?Q?SLcU7m2PNivjcufwGD/8rXNx+xx6ar6c0uoi6jZeIzFCLTWfvEK/jiyyOtzI?=
 =?us-ascii?Q?PLBUAv3HTUE+aAcWXMRoGZFvmvCnEgCWz+CeMQtCePvbvm6GE/H7RrjlwaLN?=
 =?us-ascii?Q?2g1MaMPAo8PZqk8Fm93f+7MAllhE3LiN1YP0wXFiG3ww05QdTfPqXuJe5Nmg?=
 =?us-ascii?Q?xOWjhdPXA5DSkGKDIXvmxhuHBcL1Wt0j4Ng1za5WvhecbnvvwTaXSYUTVIh2?=
 =?us-ascii?Q?kFFcHb4T0maxbe09SJg3rQ58QrZkWFG+S/cZgUiWWwrP4JoHqDzw9OhrHezm?=
 =?us-ascii?Q?cTc/xJmhOZO75gB+0wRLvGwuDzyalofSdeIJ81UH/RjgB4TLJhUIZFQMnjL+?=
 =?us-ascii?Q?Pxd1/nJHrylonbxgCGD/NmATYtAhBr2z3I7xRs4/0Gq0ULMiE/EwREGjA/ci?=
 =?us-ascii?Q?Q6wXdwHyI91nwxYnX5TB7KB/haNVuUEIvjL7nwfOh+3PnvfHvZ9grtZo1NZU?=
 =?us-ascii?Q?iipX/ZjDoiNwEr+1vTtkHafpDLfiplyn26c9coxTWob6yN+STWCg2iwCr8v4?=
 =?us-ascii?Q?PNL814DRdjIgsOKCtgTIzOAZW+sIk0QqjJ3wdqboO74zS0lftkIdiawhxY6I?=
 =?us-ascii?Q?bXXQY4bA7qy0+KddcIiyGg1Q7+Vzi6Aklird66b4jWlx8uXMfWaPEkGNQsc8?=
 =?us-ascii?Q?v88lJQ3Y7b1sQqBP8WsW1Xq5mwK9zare75JUXCvHcV5hjxHkCTGq7Fs1jA1f?=
 =?us-ascii?Q?AMBA7dvPPwH8wkpM0sNaBY/fHJN0/jmR/TWo2yxcEgxob0QoxfBbwl1YpbZ2?=
 =?us-ascii?Q?8DGK0yDF0aFdmtVK1FSw4yZC1phBBOjgBXmU4hRcT7ijliPet9f4ZGs4ie93?=
 =?us-ascii?Q?FfjMASDbne2i6YIbJdafm3d3PdHfI/ntSnl+j7twF7NU2RQ90lhgZ0cmBrVZ?=
 =?us-ascii?Q?f86hyOMYch5EenX45WKlde136qLlzg/Oa4BM7nnoFBJDYRnudYdlWCYn2Ze1?=
 =?us-ascii?Q?CMwsBthwd0Js0bh2WznjVDjZXV0Jtq1DGzzX24PrUfAtIP3jTKOg1zOYm67r?=
 =?us-ascii?Q?UeXeYqsgx3aUuDEAWGiEks5D4VNDFtngui7QL1lJPu9obGsv3iLenYQlFmC0?=
 =?us-ascii?Q?Xm8ESf8uLzudOnfLcA0Ii6xWUCzSdu7J585b1z/BnJJvOLMrAoPjUQWHnGEY?=
 =?us-ascii?Q?GjZxatvEbMlC8ztYdCs/72LnZCWdLhFPcFX0M5/Klea+uItpZvfA68xiX/gs?=
 =?us-ascii?Q?jcGlb1Avfdmzd+w7wnnRIf04sRQ2URVg9TGDar3xxKKa9BjPdpvQNTnmOsD6?=
 =?us-ascii?Q?p7W+SDItAiYdm221DCeb9+pSRRHJ/0LlcdCgVlGFMcpCbd5rU3gSAKRwZKab?=
 =?us-ascii?Q?H73zRSNsNwSknfFrH7iF9AsegoZcXg4HwlckP7WwVMt5gz2Bf07FxBUE6Vuq?=
 =?us-ascii?Q?yUrLC7NYuYcYCGQZyuobSjL4n8ftnPeQWZjmLipSrtiuHybyfrA6qCbjDY5c?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5yreV8uQUaqpQdRutMZHbGKDqAxhhKS2Bq4b4ye02PC/oLVOentTD2fYdYYR?=
 =?us-ascii?Q?gFysfKsNlWbdcNJfOr5rqQw/ihlZx8tw/3s97z0vmTAtxZemkGxFMmQbIdGH?=
 =?us-ascii?Q?3L2S8djFj3JYrsNcuXbd6EFKbOlkxIZ3V/3q33+rsI0z85HWgvep7l95N+hN?=
 =?us-ascii?Q?sYG70TPr+NJO4CqFS1Is2HQLZcm6JMoYohILT90x2bk14wVq4+i3ol/DGqU5?=
 =?us-ascii?Q?BYkZvi+on2VPBcRAykBTQe8E1DHT+TaNRqFvnt/e/0chEnKXC+R2U7E0rSUq?=
 =?us-ascii?Q?wP9ZNNdc+erDo3A8y0IM2mt6u0hhLf9gOMNqcD/LL7LG7Ut2V0gzgqeute7V?=
 =?us-ascii?Q?iSZUd9tH4Fv/oP3gwGgK3Ntmw+nis/UTV/Oc/2RCBzkOCOBy4Vcy0F8QuVgV?=
 =?us-ascii?Q?ce2YlxqLIfL56SOEahv44WvSIszQvqmrsHMY6MdPI2/blDkrlKi9SFuLsWYC?=
 =?us-ascii?Q?pwZxMdt3SBh22S10JSVO/uj2Oa21mia1+Tbhux0KYizZPW7/PkHEK2C+WXWo?=
 =?us-ascii?Q?4wZQ86xNPIJB1yTdTzX8yl29wu4U4IlHc6iWh/oGNi4aaAEDSxOOW8C1QS5m?=
 =?us-ascii?Q?eqLBT7c8AQt4mrVeddAacEux0RDSaTz6EbHKIOF4cz6Ekufxfx8f1bX6KjKQ?=
 =?us-ascii?Q?C3CB5YIfW01GMuM8i4FIX9iEa17NTVo1OdNjBCjUQyFAb6DgqEbrEjOLsjP8?=
 =?us-ascii?Q?DDPMZkUy2h3Klb6zvglf1zyJ44ypkZ3uyKkblZJ6YbJuA+VV76SyLtDm7tGG?=
 =?us-ascii?Q?ffDcS+dGxeKzw0WWwq2qziKst6TUOwLsInDkg2Z2t8huUhRfi9K0NZguG2rW?=
 =?us-ascii?Q?U4+iJDLSM4HAMWzwW5ifN02nfDqz+qdTRBdXc2S5LdKFPciDCncpDpf4xDhL?=
 =?us-ascii?Q?CZo/cIZYBosclwY91jn4AP955enFYvMd02an4KhLAt9eUSMXu48yDttY1g0d?=
 =?us-ascii?Q?o9I+apqNl7CYUAM2dI6EJg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7735921-9f1d-4f4e-2c9a-08db6d418a62
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 01:40:46.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRbICS9X1Q6bmHNX2TVI+p47aDaIkPvwfiUZuPKf6ioi9OrO908Soy5iQIRWbCjYw6mdUDHxsx+AYScyUpDv6tF1ZrIRKL9SmVEWvLC3Xlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150012
X-Proofpoint-ORIG-GUID: i6ZnHub_ol-y7Ghfkfve4szDno60rrEk
X-Proofpoint-GUID: i6ZnHub_ol-y7Ghfkfve4szDno60rrEk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Fix this problem by shutdown bltkrace in sg_device_destroy(), where
> the device is deleted and all the users close the device, also grab a
> scsi_device reference from sg_add_device() to prevent scsi_device to
> be freed before sg_device_destroy();

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
