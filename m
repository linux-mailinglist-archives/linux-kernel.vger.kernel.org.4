Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F1270E45D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbjEWSAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbjEWR7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:59:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A89DD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:59:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHx6Qn006606;
        Tue, 23 May 2023 17:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=dhmJqgtDOox7FfHdA54uZa13fDK7Aw/wkh8qswLmoxo=;
 b=cGyTkyQ/6ETka83X7KZqLXXRyjoQ8vpw0OnIjTpUNKZvwr9i+WO8/UJdBy3bF0DZrnxL
 +Mi8p2bktz5H3UN9J+2pPySddVz7hH4Tzi8eZu05dFMRdYXJMI56Dk0npZYt5wtNOkNN
 f+vPYVFgN4i6NmL166QgELExfOEVMu+LO3eEkjMeCnDanyD5s8Zf10R33QYLZnlLMWNK
 L3+fS1xIMkL8mjoYPjOVyQloxjTXP8N3FkPFC1TFcFgURfC2EfvdbVbZ4f0E9cnQAjN/
 ZNCrhWWgaZfQz7sdFHpJzD4djs1MKWD8BdW9mDsI6E+T3O1jIlL2+RwXEQC2DLZcL+dQ 5Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3qnsu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:59:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHnEKd029093;
        Tue, 23 May 2023 17:59:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2b6g5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:59:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF4CB8ZXzGVosX1xWBoCPFN1EdL+mkL8wQg/LtSLs4jcGLJ32pTMRtEm0sKhOgCdO1Qc2zqrz//gRPzEUILkM+nmylNzSwUWsX+wi1GzrsxuPlv0CZxsDN8ukAUGLzXSvwFzdBuNpfpBTOm3zQfkCAPoZn7QVTgOZ5dXO9tZ7k2ymF9OkRuhl5RH1lovb8vt6E3ttmT2ONDvt3s8ZJqR+a6/pLYeSA6IfcieZjKNg6bi5eZGbnxcCnHmaxeKYYZG6CleSaPR6vgNr9w9IgSI3OhB4XbjQqmmuoh+LbTUP+/1nW1AWCAAstYOx+tKbWWLxfwKBB+T05OqgJlGpu8QpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhmJqgtDOox7FfHdA54uZa13fDK7Aw/wkh8qswLmoxo=;
 b=I4dwztHjvMqnwKJLqtj0vmcNLboJ8P90PduCTgOeXxE+2qX16ZcyOwjHbHwAaW+NZyT/78BE3KA/mZYSeNHpoGzuMbKnZRtFP9jUG6lZ2xv7VVFkyJvmR6zzWQPhiPuREFH3PXwyEx1SAOyjSlDixO/qDWYOyrPlvPKxedCF0874uJ/xufX4ZMdtRTtqDK6RJVnkkWdIyOb+Go0iDEj2d9HxFu3rEbP0l7zdjShsK0iyD2B4nZgoxCPuyk1lGjsJrorbzSTCSqyuCbNHuvqmV/bt9bLnDyNdsVHhdCqlVxLNF2cU2eYU1LCMhAmTWRbVJ6esTG+CMG39VRq/0DU6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhmJqgtDOox7FfHdA54uZa13fDK7Aw/wkh8qswLmoxo=;
 b=B50G4LDeRVztC3k0myxCI/js2enR5qVFbZuLQpAqGsc1MZbxSX2SmOzTs3fiSvnuBylS2Z6Hzs5OfAwRgLS5cQBaK/LT2PKbcu9OD4V3uS+pAgGrUoMX8mVNX7/WfOyjQ+q50Cf7ZyaVaxEhAQ4WYTO5cscUk/uvU1vszzaoNE4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ2PR10MB7787.namprd10.prod.outlook.com (2603:10b6:a03:56c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 17:59:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 17:59:25 +0000
Date:   Tue, 23 May 2023 13:59:22 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 10/10] maple_tree: Relocate the declaration of
 mas_empty_area_rev().
Message-ID: <20230523175922.7jf2yfwt7h7xagwp@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
 <20230522050656.96215-11-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522050656.96215-11-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0315.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ2PR10MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: fee4305c-3318-40ed-f803-08db5bb771d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMpOk3eOodiOAopFlGCKXhpBVR7CI/PCRIyHvI0n9PB7lO2M6h9Nt7DWgKl2v4/YP5uyMPiQo+bPq3zzvdCM3kpMVdF1G6uiXUIkhyLLBDbno1ZEOgm0IJKGPQmL3TVh74K9mmlqpoG+R2RSYHiAio86M179YquLdbsjbYbp+fD6UBe0/5mVts+3O08qAfjVwZsPL13O429yrnio2PvkrTrFPKDBaUfzy/pPs9Mdl0DLh0g+uBFhFrOjlO+AB6VSCAdyWOhGD+QlvRjgaMZYtVopzE1ChhvbZ9Y9fXFb8zLu16BT9p68V2FVTHXQuXRfKhgOTe7gh7FVi5yiL8xRCU+XgjJwLghfyvbDlq6lF+7HwoCcODAZroGVH/VeHmnDXVf8BVzGG/4b2ZKc6/mBYocGaCG5SHfOkwgQY/GVndd7NuKKvV7s9XclJk8aFWe/Q1/Un1p9GXNqafK5tP0Hk9UBl8Y4/EobE5PNbUV/CJASM+HZRVykUJVxvl4u3ZLHtTxjZ17h/JpOkFyS9gVOJuHpLN/g+CahYcTeEjpw+LMeSBKmO3sjVpN2id4kSM/U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(186003)(2906002)(83380400001)(6486002)(478600001)(4326008)(6916009)(66556008)(66946007)(41300700001)(6666004)(316002)(66476007)(26005)(6506007)(5660300002)(6512007)(1076003)(9686003)(8676002)(8936002)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h4ve2PaGyoufrfzgWCDkwQyktvN1pxAX5RG0+rX/6iPmXPiNWHck7LGE82iR?=
 =?us-ascii?Q?huuCadUfPsn2oigbVBjneqlshWb3GGcEhrvIN4czE55Q6otcCPd7LhPsxi/B?=
 =?us-ascii?Q?45AHWN4jtPOH0F7CNrjatlAbEqs2vbC5crFf6MfGcJ4R2iKz0PHj87gjPPV1?=
 =?us-ascii?Q?D7d1sCfO2kbT2vZ6B9jcLx+3tqbwfArCEiik3p46P49XPOcBmI4Jt8QCfrEI?=
 =?us-ascii?Q?evx1hM2epdqphiymLaTV1lzmRUm5P15bUhNTaucQiWtdj6otQMsdO+RTfyrL?=
 =?us-ascii?Q?mLfIMTN/1fMrICLo/eW/YKUiLNe8diG1n7lUza1wKx/fD4uZjoHOtp64c0tn?=
 =?us-ascii?Q?KB/2kHB2wyzveE1g7P4CeTdTwz0lsl+7VKB+xldlcA0ZU7m81yPk/p9cFWvi?=
 =?us-ascii?Q?KDbV4jV8K3AGJIbmjcP6iY31M0vQb/XO/0vso8Z8/fwp0qzbgSzv0dZ/Tfz1?=
 =?us-ascii?Q?atySU+xLkFCXi3zeLQBEa9HsVvX/koq351ue9HOOL7Y5AvVmsAXWZPqdmvCL?=
 =?us-ascii?Q?XdU7dKr0T7t6s7OTezIcl4eousXIVdFQw2or5fJFEyzb0sTelU1IfqT+eRgX?=
 =?us-ascii?Q?lEWglkRp6GfRJw6AxaGI2mxWu9khCjbjmXGKYFm1nad94N6ajA4Q2ImwqWM3?=
 =?us-ascii?Q?3v6WEGIpuYlOxUGhZksz+y7tNxYwocvwC3kPj/dBBEDBhDd0fx4gvobHNfSh?=
 =?us-ascii?Q?EXpHb8d7X7MOJ9ZeCKjstgUR0c47Y4UdavLCxHCCBnMMIGkDdcqM8e58zo5A?=
 =?us-ascii?Q?JHAU1tDkAuKZwjHZVqOY6yKuMS5wtZn4u42gQTTEZR0gMxuQmvAQbBBi5X1u?=
 =?us-ascii?Q?1JnU5u9gAyd4aU1OhQjNazmwtDcQF1YBih7Fa9dr2AUElfiKLZ6uUQQV2bBV?=
 =?us-ascii?Q?eAVqQV9kBrLdJjCiuUNXZRT0NvIOQ62/5VihXAYAwKtvMA08Le8niUPF7+eA?=
 =?us-ascii?Q?ehPUIQY0K4TluPbK0+nsnaZJsKaQHkIoLOxRFONpoc/ZoaqJgWbxuvIQbBYd?=
 =?us-ascii?Q?2hiRv08ekR6d1F/ZIG8vgApDk9bFHFHluG49IBDmA+n1beCd2OfN9T4p1O8/?=
 =?us-ascii?Q?x5dvXHYqkOFF8hwqenMxXLkz/62vRxbtcjFBauKWAvIvYNgq+0bwZkYW2aUO?=
 =?us-ascii?Q?41mosQkjSTM+y/DwI6tYTZdeMRt3LkMfoFvEewcRXDqoIrSQo8OFADMSL7yi?=
 =?us-ascii?Q?pRe+fwq305quBrRSg9iZAUV2BKfoWMPLwXKc021mXA0875qoy+pADAyEZqJb?=
 =?us-ascii?Q?uPZuayXm/9vHDcICELBH7GwbCzfluSfFqqbV1dDcTRp33gGXUuTb1kdvPF/W?=
 =?us-ascii?Q?NGgh8HL8+1dO8pkg04r/ojnuJvT9cUN48PKLo11fsGfn/X80SUBG1zfnpgBL?=
 =?us-ascii?Q?LmMVRKUEMSwM6Zp6HH6ijPl6O3sI/WootpL0kEpUy92yPCMLJCOEj9wNPmoV?=
 =?us-ascii?Q?dKMSdiQ3uu/3PqDonIsoDEAesZEsbUHrfhHujHPrMB4fuViu7/LG4MHGT7Qh?=
 =?us-ascii?Q?doU6JMqXtEPMs/hUKFE88xR/VF65vCMKsmMSj/5rQzhWrINqA04miUdVKeVy?=
 =?us-ascii?Q?URIzRwNd/yFd+JqpxTHQKcdA79KadprN6T/cDYjUWL54LgxcIaqNAM/daYsx?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bls0DZQR63HLOZTRqmj+1DWadxI/d17TWKStO4d5AD//VMBUMqYwwQO5mMs6?=
 =?us-ascii?Q?4XpXZbdjS05YKKZsVdWFtuPUrYYvIxSNlrWF7na91em7ou76ROd6VzNYqi7X?=
 =?us-ascii?Q?BbTcLlhNWZTGpPaeP6gAZSq5fQfYy6vNLH3S4fIdCRPWMGPyCO4DIOumJ8U1?=
 =?us-ascii?Q?tzVot46t0zb8F6oBzpZJzlI61cNJo8LubbBTIfruCezEuTkJ6lqOog6kw8ZK?=
 =?us-ascii?Q?hoUxzZ03ZdnTgbLtbsqiNINPf2nV9WawUPPrUxrbZcAYGJsWBi+wbQHV12vR?=
 =?us-ascii?Q?tiUtqzNmC8DhRLchZVpuZDYZT+7uuge9/CGE1px036lTzMY+wXLWlXalWt7p?=
 =?us-ascii?Q?1XYv9Tj3Q1WgUzKWj0dt+IIVM1NVfbd1cymNFSxpda0iUzpr2fdJ962w+4Rk?=
 =?us-ascii?Q?QQd76zeR2Sg8UgQZYtvNhPkTRePKY4J5uLsNvO3uaNnMnMuKHK1f5rjWkVWt?=
 =?us-ascii?Q?+LJHrrbGDXx7O2dJaEiyvd4X9kNu+7lCr5x340Kp4kzbrflARWcnr4v4MXR4?=
 =?us-ascii?Q?SwB8Tklu2ivUul8Y6xZsW3bkF/9F7CqIESSn0W52ViV8LuXRJ96v0oaGtr8S?=
 =?us-ascii?Q?orTHSfyOPxVzClQ/9cU1KcqCqwXGoCDqnm9hcPxBSbktqXgsaqSaOd5KRd1S?=
 =?us-ascii?Q?7aHGqT0tqVNzNoS9/y1YzDMmnv7m3FI74cNyb3k5dC6uCGuKamwlqnaSjLtu?=
 =?us-ascii?Q?prNzF26BUAbYws/AzqsJgetRlsvsMnTFi0yxJKp6rpQH0p6NjknrEjwqLYfK?=
 =?us-ascii?Q?iZfhv/vYGAnUOsNjcr7AXDfJL4DaFEOwP2Nv2Z8Hq8DVZ1EfurOOsbiL6FvR?=
 =?us-ascii?Q?DOb+vyFZWBzO2ogLF95UEtJV/KVDmf8ZXTB+bBfz1nUS4WjGiWGdE4Cmr8/x?=
 =?us-ascii?Q?xMpdZ0t8mvZVFR2wkOvK7YWpP/FSNPKB0632Jwui5S3rwsOrO+7nIsR54e9Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee4305c-3318-40ed-f803-08db5bb771d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:59:25.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ta0Qr7MJ7Xdd8RbFXjiW5xeIl1ZzlsnG/9qdos95qTTLneXsa6etWI65F4mujxG4WkIMVwkRDgj1qt5v4Upj8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_11,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230145
X-Proofpoint-GUID: 3n59_1lTXwk324m_jTnDaqOA0wvP5tOx
X-Proofpoint-ORIG-GUID: 3n59_1lTXwk324m_jTnDaqOA0wvP5tOx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230522 01:07]:
> Relocate the declaration of mas_empty_area_rev() so that
> mas_empty_area() and mas_empty_area_rev() are together.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/maple_tree.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 85559a34a098..c4681cb8414f 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -474,6 +474,12 @@ void *mas_next_range(struct ma_state *mas, unsigned long max);
>  
>  int mas_empty_area(struct ma_state *mas, unsigned long min, unsigned long max,
>  		   unsigned long size);
> +/*
> + * This finds an empty area from the highest address to the lowest.
> + * AKA "Topdown" version,
> + */
> +int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
> +		       unsigned long max, unsigned long size);
>  
>  static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
>  			    unsigned long addr)
> @@ -497,12 +503,6 @@ static inline bool mas_is_paused(const struct ma_state *mas)
>  	return mas->node == MAS_PAUSE;
>  }
>  
> -/*
> - * This finds an empty area from the highest address to the lowest.
> - * AKA "Topdown" version,
> - */
> -int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
> -		       unsigned long max, unsigned long size);
>  /**
>   * mas_reset() - Reset a Maple Tree operation state.
>   * @mas: Maple Tree operation state.
> -- 
> 2.20.1
> 
