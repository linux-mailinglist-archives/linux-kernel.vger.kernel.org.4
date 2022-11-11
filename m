Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93757625CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiKKOOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbiKKON4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:13:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B6F83B92;
        Fri, 11 Nov 2022 06:04:10 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDhkou013729;
        Fri, 11 Nov 2022 14:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=q70Wrrwfd0MAGjQANnCx/gTOnZ2WfE9mmP9oGwVRMts=;
 b=XddvMeWoDLxBKIqUn+YceTqXlHZ38keyrmRZqsy79CU1T1QEcPczV0lBb+0e01pMDzTQ
 bcudPho5FXztQ7ir3pUHiIJycSwdVa3sEjSALrF/5h49cIB5DY7wdxf57LnZSmKwG/3u
 SzvJL1A6QdfWjZW6jeQdWSt+LhZUvprNN6You4xL8BGjPney9ci26vgNsecFUt5hyIZQ
 YJVMj9LDhz5GOi3ivWL51wy96/cINjxevxQS7ehUiSVfYAWZVWL3WkkGp2r7frf63Jiw
 cshKUvFT/rgNm9V0DJwqRutph1QCSECnRQFkHFEIK7QjSR+BQ96BDRgfaWKLvEoywLYv yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksqh301xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 14:03:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABDWp7C009038;
        Fri, 11 Nov 2022 14:03:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqmjdwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 14:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBdRxuSIn2R67oojhoFc8ZxL2XvoU5TSI3EuPLwfOY2ZXu0/EAHeydoKTKDck/+Fhe1k/M9XH8Qjmt0PyHtWSlOKAKv91kwmce6YqCiq04n0TBYKxutMXgZxqEUJZUibTBfxyokJEPlkT1jHHsyWaAkiwOPdDaKJ3regnY1mkc1P+MRXHWSG28CLi6vgRmZrL8wXBBF9vOenbHhNEUTm4Yog+PWJbRCy7KDXaPpOY/QpVYLNZEb/av0sxFdk1hUtFy9MJyqaCaHhrY7iO16fD3IajqqW2MUa8gxDfCknu/1djLLA9CI4C4kLjN4jkysDxqVYJli5Y7IdCTifL7cPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q70Wrrwfd0MAGjQANnCx/gTOnZ2WfE9mmP9oGwVRMts=;
 b=iBvPPWmIYH0oxEqujpYwu+ZoPdt5RcgZCqDOS5DNASsoqe+WlFFXQrrD7lp17YLA9r7DDLdyDIgB9qP3KJGiCeKzvHTGPO+TKTMkIXWQjSNfbarywKqT4DjaPShYDGFocneNVK7gzEFAWiGfiQmNvxLmPnvVHPmpoiJUEzkItl6UFU66clIXWT8zydbkhLhxlmipq5+FmGg58P4v/Of1rqCJUKH9xKH3dHcj8qgSLs8YZumesB2KglaJo4sfJ0vx7prbNnDR55fxqNnRDaVLmH3fvwx/XrbCfn2ct3+aF55REMPbSN8+W+7aUUv/2pe+zkULX4fXm6qU7sqgiZGZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q70Wrrwfd0MAGjQANnCx/gTOnZ2WfE9mmP9oGwVRMts=;
 b=xgt8sBnkktyJj9FE6eRCKGS7RVf3r7RJjFX8xPCrIiwrejz9Sv/CEE4wtnoE1NElCJ3jmz0H4L1/JCsaIPj0nwXWarT+Uyl2fqjWhZYPaY6ZDGqG3Knn55TWnmVeFN4Es0r8O5TSf6F50SubR6Rz+ex9PfMuU+V0crr6M6iCONw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MN0PR10MB5983.namprd10.prod.outlook.com (2603:10b6:208:3c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 14:03:48 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 14:03:48 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PATCH v9 2/8] kbuild: add modules_thick.builtin
References: <20221109134132.9052-1-nick.alcock@oracle.com>
        <20221109134132.9052-3-nick.alcock@oracle.com>
        <Y2x22mKtaZvC7ZSk@bombadil.infradead.org>
        <87h6z5wqlk.fsf@esperi.org.uk>
Emacs:  it's all fun and games, until somebody tries to edit a file.
Date:   Fri, 11 Nov 2022 14:03:43 +0000
In-Reply-To: <87h6z5wqlk.fsf@esperi.org.uk> (Nick Alcock's message of "Fri, 11
        Nov 2022 13:47:03 +0000")
Message-ID: <87cz9twpts.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0420.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::11) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MN0PR10MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 0708acce-698f-4882-3c8c-08dac3ed8e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfCw+81Itt4C4gyJOz+CMTuSICBGpu/IZdqeJDqL0jSGh1E/7ibDIgu7XhJSg8Xnqh+Ot2RgxoOesRS3n6zF52GabWvSBanA+4UgP41dIqrtYnN9j1y1n0My/kbSjXMoGoA8mP57AEyoXJCUrNsCnmR/lr933fzw3mK6QyT5eHD2BfxXlnalKHoTIKzAoHInvXvi7jake38MAuBOv4L6X4r/Fuv+1wfrXSft85KhL+MuFq0qq2PEnRZT/8IzmXskl8vluhQuQdgM/+o55EeFbRvzFj9mLeJmO34oQiq+xx+t/WZQJPr5bHKWDErvXXfQ6zPNRuThM6SYy8rm07hUF6dhGZSXZQGCXaBS+n9aDfCfMmCOfsaJ5Gw/m7IbVAkk9z+kWLmYG8bTcrR/U6DUjsHNJEY2uBaS/x9Z1Bx45sy+ZXs5sZ2s59vP1q7Vg1AYBDkC2uvnXVhNe5JRfh6X6TkGW4NlNqTamZ5OEulpywLVZkCwebMSTR15nb0pRJfikTxzNPPImhuktn228wbPkNV/bqxzQObugY5HNM25pna4pZjCRlqHLU3XK51348DpAimjzHpZJmGqR+Te+vlcIF5TBFvGKL7Nm5Sx5VGhxqAbkBxxubG+D+4S0RiTvnEEoH3l6+woy6WxfWEG0wBlvcANS2IXtTQRWiVv41XnOicIUXbn6DLz4OLQoUHoy4ROXxW0pp0Rd8FEoCZtiPnCXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199015)(8676002)(107886003)(4326008)(44832011)(8936002)(6666004)(9686003)(6512007)(5660300002)(66946007)(66556008)(478600001)(66476007)(6486002)(2906002)(86362001)(6506007)(36756003)(41300700001)(186003)(38100700002)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zyUXuczyOShRMKPbxr+kdcGR43gbBM+u19nqdDXarkGeOVrToDptddcfFYeB?=
 =?us-ascii?Q?yQwkVYqKE+FP9IMapp1Z+WXApCn1lBr8FPncRWrErfXq3RHHx3OXa0c2dXI5?=
 =?us-ascii?Q?SJ383eqh1LMEOsTydug5xSnX8oL3ip40ccbVThAa2zpe/oz+wDdqulIQ9gZz?=
 =?us-ascii?Q?cDfMXysR+kJqhrve1Y2W3u30uewDixncBssIYmZQFd7FcZYvngzB62LBi5dd?=
 =?us-ascii?Q?36NZ+T2HY74QhoMXVa/5l+VA2H0IndGSsUYi1Wi0CxUhS7JEEcMx1Mq5I7DW?=
 =?us-ascii?Q?0x4iH9peNNxIJu9U4YazlJmBZBTgK9bO8bvwA3eyO9DLps9t8CVUOj1wDA3Z?=
 =?us-ascii?Q?eOhsZEB9V95Imatssk39uEHwnW2UnnkfShEHR4I/hLwWqKkcX7hfMwf9Es5s?=
 =?us-ascii?Q?3mr2YsRnjcjYMSwTfJrgKG6bT+zssiXWzeOiZ+RF60Pp6hWBrHHT4k5LIHvL?=
 =?us-ascii?Q?TO23eNYGDB750otiCyAn+wAuwhlH9eKqAybCwqD9huGO2zIH8tp8oecPrIZ7?=
 =?us-ascii?Q?+89dHipmCuu+1sE5ow6LM9pIAgru6GEtARFmStfJUeulcz3MRXMtZDpVeTCC?=
 =?us-ascii?Q?HCAnNWq+RTSpD9CnHLH6Apd3zZ91+VLu7CTMRhiIFoQBbfYO1heGQ4SUU9N6?=
 =?us-ascii?Q?nX380gaVWK1wehEsxN8HemAVi70eWxNTPec7FXfY1SAHpzizlyZUragd3i59?=
 =?us-ascii?Q?AvXRnh0RlzFYeTZe9XyGKswXBSfVSYlPUDuN/inOuTG4AvhQcf3WFAAFRqYl?=
 =?us-ascii?Q?Tt3V8UXy+/wAeEIyaeHLnxRHF94IWkXah/fep2f4ySDv3MkgV5l6X6REXQb8?=
 =?us-ascii?Q?zGDlY79FVudWK5Quk3TjdI92pEITneIhA6Q/f0zFok/9LDHkHxMqHUIji+vi?=
 =?us-ascii?Q?r+xDg7CJIZpkuTkqivJCKwyZxlyAax4RnyWInLaH4ygpe7RubWKt6LrDRB+v?=
 =?us-ascii?Q?84bhXOfixjnCfIERFJG40GWqVTEw9EdyL2m2Fu/8USfBrE8FMBt4TAHfO4cA?=
 =?us-ascii?Q?+X9jMx0/+LYNEKffZ0O7KNGrVMRnLwT2Td7+Dwpm1XFfzJ2z8HvGpBGmcoj4?=
 =?us-ascii?Q?ONAkwH9zAKb/3Ir/u4u9uVaQK8Dq5NUDLfWjyujKDraAEjomwT6mfM/gqHiu?=
 =?us-ascii?Q?YfC0tlcW47YrOk1KrrcULaoIoiZkDC/vi3lRLaAK0pH8AKQizAJByu/pjrj1?=
 =?us-ascii?Q?UATi9kXDaOwRNcAnMHl6x3uax8H/oyM0XsdLvZw+fNNyKewm7gwHSol+4r+t?=
 =?us-ascii?Q?vVMkkDBrWoJDqeDnSFRqiUCI53G9Ab5NLeoSE6CHXgDt2cI0HUuC8uxOxeAw?=
 =?us-ascii?Q?9qVmlTQb9BK+VZLfxG/Z9GONRqrsBywCUTfOOzH2mcAklYkTjzFIS1kId3I7?=
 =?us-ascii?Q?6cpBRZ28cperf0kwOskT9SWjYDf1+r4dwEZ7lgn8/VORKeogrMsTyhqsuHwb?=
 =?us-ascii?Q?bgveDSPZu9qvKJuosmT47/TtZ2WVUrcQH/R2rkpxFN7B8FkLiq4ZObv+9U8N?=
 =?us-ascii?Q?qRQfX6k3+JGqPHfxCF9zp9AYxTncX5x3Qx1Bqujorjpg5UzAwWMLpCXdH6C4?=
 =?us-ascii?Q?WpMvisuQ4UgbJ+ZQ1Nl0TyVY18pGZ+OOj8K7j7cA8uujb8dQYsUOfLAccnXj?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0708acce-698f-4882-3c8c-08dac3ed8e0e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 14:03:48.4934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAcYPzVopfWDYjO1JeKI8XlIv5mg5+FPaTK0PYoFgeTRfHwUtUliE//aTQJ6m11148YYfwO3O6irxLVB/X3Tsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=538 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110094
X-Proofpoint-GUID: 7cVE4r5nzkYWxa7W6k7iGD1skcWUsqSB
X-Proofpoint-ORIG-GUID: 7cVE4r5nzkYWxa7W6k7iGD1skcWUsqSB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Nov 2022, Nick Alcock said:

> But... it's not quite doing the same thing, so perhaps it can't be that
> much simpler. Picking the first item that appears in my test build of
> this but not in modules_thick.builtin:
>
> +arch/x86/crypto/libblake2s-x86_64.o: arch/x86/crypto/blake2s-core.o arch/x86/crypto/blake2s-glue.o
>
> But...
>
> obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += libblake2s-x86_64.o
> libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o
>
> config CRYPTO_BLAKE2S_X86
>         bool "Hash functions: BLAKE2s (SSSE3/AVX-512)"
>
> This cannot be built as a module. The point of modules_thick.builtin was
> not to capture things that can be built into the kernel or left
> unconfigured entirely (though that is *also* a nice thing to capture,
> and should probably be captured regardless) but to capture *those things
> that can possibly be built as modules*, i.e. those things which are
> tristates in Kbuild and might possibly get built into .ko's. That was
> the whole reason we needed the tristate stuff in the first place, and
> I'm still not sure how to do it without that.

OK, I think I should be able to combine your patch with (a variant of)
the tristate stuff and get the best of both worlds (only-modular plus
the efficiency of building and simplicity of your patch, with no nasty
separate recursion like I had for modules_thick.builtin). Working on
that...
