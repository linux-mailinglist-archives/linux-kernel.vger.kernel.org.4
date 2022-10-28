Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299A7611462
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJ1OXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJ1OXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:23:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142427E02C;
        Fri, 28 Oct 2022 07:23:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBNteg003776;
        Fri, 28 Oct 2022 14:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=isGe7JQmkmVFJFmFpelFjpr+15IR2mDMt3iEHubnizc=;
 b=lTEacUMM/O7Fu05+qRbDbQpnOJ4Y8CKfndXzyh1qziv6qP+cgm8YO39qfxsi/hUtKIRq
 Tb8mXgmp1LYzV3RoLzbXvnjPaovC0+MRkC6w+icDEci+Nrv5RpPLe7a8eErylgIxugrt
 AD81vUNEb+d7Dal2W4n2OBArtn0UKx5fp8twJpsjo5NYQHrtisPrbUUtuU/tr2nV9d5e
 pxjvRik5gZoMMJOKJRAbL09Qm+fExaPTprp7P1fXe+xvWb9U0dDJSZalxYNOJuz7n/wz
 0Krpyb8hXzAMLmPlBWIv74b1OB+SdAI8XWbXB8X2RJmILaXpjR6rgXBKSeP3bUdrAGkE lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0an3v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:23:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SDLg8M012085;
        Fri, 28 Oct 2022 14:23:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfags4uf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:23:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJVYmHhzfMxQlrxiHMbF4xk0MG1sdUrwn9MN4N8G8VwDS/cYMMlqkaU4J6JoyABGFFCZKePnhYC3CkhSlQ/N2fwUYpP8HFLrh2jrw5jJd14dL0Zogzdme0ZjWWJZE3XQbw0JJCrcKhjbboUlaPIhMSkcmls9HqUWOBt8+L6c8f21mkPdfEQKT7Hxg6X4Aeyx97PrSWLHQ2diRLfWCJHyOXv0cWlPo+uob3JrVTrxLo6hReGSWn9K9sssJm7vwAcYY0dvEyEv5YIpj+5qvSGduccD4oGdYH0vPqIJrk5HUVTqEfz/huwZtQBSKudDLvf/0DUlLolB6YU5KoCEJjbuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isGe7JQmkmVFJFmFpelFjpr+15IR2mDMt3iEHubnizc=;
 b=Y+trm+TJXQ3cghTKGMlHkrmt5oGcgQTbYRie+PCyul02SQvuklkBSrgOF7pihPyO6k+xzJJ+t/Sf9fPfLEHz0s14ykLOe4aENDxDNebnrZiBlKRPGYYUXhuWbKREDXqyXkbX8ZZP3TLV4pfV/Ikxi1FMHv117NDUCMVF9Pz+6NJH3R4+V7Ttxo8MyvJN6x9AzO5NxH9ZDUIs4tpV10ta2sgVKDTgJsi1b7TIDnywL1fxZ0s301ETENnUDrV1b30CpqJOYYOcI3Bn4RhgngeOIqAVTDtNrtVOvty0vI8ggPW38srRfuj7OtQM1y3itJ+iGe330WeLV+AR1iYvgDvewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isGe7JQmkmVFJFmFpelFjpr+15IR2mDMt3iEHubnizc=;
 b=ujhOMMI5rMqnSN16nBn38GgmsFJQO1c6g1FD+D/dU+vUvgcjXdcTSKr524SKAjWlaKfcFNgwhbvm2Q3IVs4ehGABwNs5QkXRi33XgXmiqR8qqOM7cR3RXGJTLMErIr3xizmqJ7IIEPZi+PuW1vdO8vZOlGSy9YE/W/ZKz6JOJWg=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by DS0PR10MB6946.namprd10.prod.outlook.com (2603:10b6:8:140::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 14:23:18 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::780c:bae6:7248:d67e%9]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 14:23:17 +0000
Date:   Fri, 28 Oct 2022 10:23:13 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] padata: introduce internal padata_get/put_pd()
 helpers
Message-ID: <20221028142313.7msfbgy4aurrqndx@parnassus.localdomain>
References: <20221019083708.27138-1-nstange@suse.de>
 <20221019083708.27138-2-nstange@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019083708.27138-2-nstange@suse.de>
X-ClientProxiedBy: BL0PR0102CA0067.prod.exchangelabs.com
 (2603:10b6:208:25::44) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|DS0PR10MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: e2630d48-5954-47aa-43b9-08dab8eff4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdEKKcIYyH3ajRJwNyVjHAGaXNIfuwLvKndR/fa0u51ZcuDjI5BHzEks2ebiP/noaWljFvQT7LIe3x4bA2L3BNZqyeqASRNFAMRr5wO/ddmHoycxyi6Zw2/9fqYTe+0HyWYbNuwlfHrRrNaYzcSpxR730+Xq/n1DwCEeh40gYya+/ZAEXo8YIz5KWQxXpbJbFvP5th6B+amIfalDYIJy55Zl2j9A5gzAiSDylbGD4rA+0pgXY9Z1wyg/3MnM/TSi13UWIkpn4zVJji432aQWEmGOpjFAIAPA59BQaiNI+7Vs1hfl8VNsGVJL0OZd5WesOfkbfrcnsFHd6K+nTQCRp/EQlIB9eNIBs6oNqhiH5i5/IwkEp9ioizjul04Og5Edi+L/YCfwBfpILgNyaR0+xJCBgNKACUIcx3ErjEIQL55pvChWVtU70bXufnoWv0Xn+PchsWFGWa1orY/okEEBnrWFUwznwlIZaY7JQjeAtn2szzEZk4vExIu2vdy3Hgsa0UWk8ZHAabYcJKDIelyzZ3D2habNRwO+fh1cTPtXayNH02ZBSQ6xfiJszfkIa5i+cMdsd60YL54gYswPoUpvuMMP8E/cF1rElffKjahFonRpvzi8sYG3++mhITsWYTW4Nnf3bqVsY3WIc90gJ/MlApoJ45GOZSwR8CuqhKUaBmlFUgLPKVsrHWywtDhszKLKNoFRoXxegdWJRgylruDyZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199015)(9686003)(26005)(6512007)(66946007)(6506007)(6666004)(478600001)(186003)(1076003)(4744005)(2906002)(54906003)(6916009)(66556008)(316002)(8936002)(41300700001)(6486002)(4326008)(5660300002)(66476007)(86362001)(66899015)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SX37Xo/baUV5sIB8WC2M5mBkG9hT50Z6GKzYrA6Tjh2pw0xqHlKNbXmpNnKi?=
 =?us-ascii?Q?vhsikBkDeFxZOz6dCB0vOSz2vfZrjpZiJW3ZWTwos2Qy0wkMckMvLqSqP/5Y?=
 =?us-ascii?Q?Tyb+DdN9EvTUwVbhrQM3WnIWVZv2aKhlmRvZoGNkNKx4dIKYZjMP2OmSTWsG?=
 =?us-ascii?Q?N/Nw6y9BoWNcB8qZpx6+qK311qJjc6XMAFA1V02egW1YFcRUpW3CPldw3r0W?=
 =?us-ascii?Q?dCtqVkjt8rIhPTBKPVPOV1GESs4CqqnImtfBcemRkDXYHkChTx04zSOVw1rM?=
 =?us-ascii?Q?IskFX4QI2EfY4Et9r3epkrOLxb2DvALejJ8pLj5j4Tw19cuMdoya+hZj+3G0?=
 =?us-ascii?Q?Bk9jz0t6K2YrjbXyK+hYeUHHKOAs/LSe4J1zDJLGZ54fTEVUzaFLmNtr+tyu?=
 =?us-ascii?Q?C1MvtKUdS3+ALT3loGgT2GQni+/HbyYM0QI7ytuQGDWpFBXtu+arL31UEVNq?=
 =?us-ascii?Q?K2c2GBxg6QqRJ7g59FrvxPmm35f1QqQrb5HaJijhSZfq2ZrvzHxE8I02nNwG?=
 =?us-ascii?Q?8w5G885g9QP1W9zAu2DBK92fu9T3OXYEgLvs40aNVs/KwZx2IFazS/Flls4v?=
 =?us-ascii?Q?HstLPwv0x0+JsDh9uUUJvdCx2WNV59xuzyqUO7KxDktFCpV+OJfqjEsEBhWj?=
 =?us-ascii?Q?YhDVoOLwUYhR7wTyuL+CIBPdQLauSuqM178U0QfWeH1yO4JebA1sv5E30vUR?=
 =?us-ascii?Q?EhF8uYSZ3F0kXTRNJVNLB540IuPLWLJHOeWdEuXLjY7ZISgKibL9sTqjzwpi?=
 =?us-ascii?Q?iWVVrFQGDD18uGLvPa4M9Ncfqx2ibz/H3O6Rv4hZoom9fmaiXHPUbtszhoRs?=
 =?us-ascii?Q?610fh5NuH2I89UUTyp+7Jqr7Osu2qTklBquBwSRZRlmrgbaNBCe2M1lfIboH?=
 =?us-ascii?Q?5ogjwpXU2yfP+R8ziAmt3uDc4MbS2jnu90CpxU3xdwOY4oS/VmfV01RunEJf?=
 =?us-ascii?Q?g0pdDfsY+hiJ6EwmeAN9byRphqn1YUr6MvmUpklUi8H777GmbHFlxQcWkCr+?=
 =?us-ascii?Q?51+Whfdyw6sZXPmNitOgMJ3Q5D//egZBiIUhqWHIEFyUhJfGXIHMF7a7rfP+?=
 =?us-ascii?Q?kHc3G9ZjpowpfXka1FsJ/n/EMoHzeQIazjUtJ/MOKr6KkM1Cr/9Xzo83+7Wu?=
 =?us-ascii?Q?pKh+1uX91bQpDESjBWV24jJZUIfd9FtLbWHNBcrhJQC77bUbnIwqD7EuNb8O?=
 =?us-ascii?Q?SxSsknt6g95gxUYWeOSTOYEmnyReRNMH9cywaLiIF2huNl+rxEk64mOfP/+q?=
 =?us-ascii?Q?W1o+0hkHU/N03nPM1lAmLXwxF9ybfE1vKv2uRTRzWkE8KFq3gqshd+eO7uhz?=
 =?us-ascii?Q?Td2SJnbHsEZRXAgumUWLUBWqm2dTsu+cqz/vzz5uliSZKqzUslFWchrBjrAH?=
 =?us-ascii?Q?ttSE31X6mndKJ9FInTlapw5c6y8gI8SvXbNN/mB0w/5FcE3k0KmHnOUh9tWe?=
 =?us-ascii?Q?jp+R8ImD43A7rzXfLAzL4bG8ox7e5W3N3FjvmPJDmqIdQ3NA+YWguJ4DfzAh?=
 =?us-ascii?Q?7UrgoLgsClmKth/SfJxlKNy+LgoYLPwuJBbZnkK8D3wKjzr9W/5zoYFJvd7f?=
 =?us-ascii?Q?f50m2Joh0SFskTlVXF0P9SGUTz7aIhtpU4qFw5LWmeUDM7G7IRERIERJwEej?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2630d48-5954-47aa-43b9-08dab8eff4d0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:23:17.1736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4I4LdDYVFlO9CKDzfvka7hHYC42CjzhC3dTmIUm4kYGshUVtx1uUYYPK2djRUWCDMd3wz5K1CBi1StpmBuXqlcLv1N9R8Lf61CNOr1bf3tI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280089
X-Proofpoint-GUID: OmGsGyG2GezanSN98X-gFdynx8DnJXXD
X-Proofpoint-ORIG-GUID: OmGsGyG2GezanSN98X-gFdynx8DnJXXD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:37:04AM +0200, Nicolai Stange wrote:
> The next commit in this series will add yet another code site decrementing
> a struct parallel_data's refcount and invoking dealloction as appropriate.
> 
> With that, it's due to provide proper helper functions for managing
> parallel_datas' refcounts and to convert the existing open-coded
> refcount manipulation sites.
> 
> Implement padata_put_pd() as well as a padata_put_pd_many() for batched
> releases as needed in padata_serial_worker(). For symmetry reasons, also
> provide a padata_put_get(), even though its implementation is fairly
> trivial.
> 
> Convert the exisiting open-coded parallel_data ->refcnt manipulation code
> sites to these new helpers.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>

Thanks.

Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
