Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B018E666AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 06:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjALFLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 00:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbjALFLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 00:11:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393AB42E3C;
        Wed, 11 Jan 2023 21:11:44 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C4sruY010361;
        Thu, 12 Jan 2023 05:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=+CPr+WUbp3NTV1VEa2Pgqd0dydGxKJ5c1ePvtZ5rgy8=;
 b=DNas4KIdgICga7dBgYnGgH7qRCxoRMm034BQOIYa92iZXyDLUYffYsah1mvCg6sjtxLH
 ie1c9zPBdDt0cM6OCulCeqBKntJzjGgARW/Fq2LIz5qFYXuaXuCMpQizLU1HY762Kp6F
 W2wCzyR3t06foE3OFzBodz3sycaY6xzNRYfzNQEBZ/Hmht+q3nt8Wt4rxpng1cbs1IRy
 0d1w506cQpV4GxiO2nCLaOYw1FNOiFryg6u7GTlLLVUuIZ0gtyI2OlfFT4Jo+RYtbm9f
 x8fj6CU3tZ2XO5nsW6rgikAWp898vusMWZ/QkXIiYDXhuJxvvGfVVDzKKxenXvoK03Ok aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0schgy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 05:11:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30C4EI7j005358;
        Thu, 12 Jan 2023 05:11:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4apgb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 05:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu/7B8b4pen7T8UMhHW9qDS7FaGou2fNeeG9tfx/qFTTzQQVUymujuOYLHR5ZIQJqjZjCtOS1+Wko+BaIKW7ykiiEacbVUDTfWvbLn23+aRuSgDKU7IOhI9jIzY/8KRMdF8VrsPM62fh1XbCInAT9SoVwkeZZ8JUaCXtfhCFjADPSvvu/s0kddyOFQDE7f4KTRIwEXO3dnzAeRxcp1o63NlpWxZSU+PBcqmPAez5zl30wPCkfi+qoQFOiJaQXss0twcjiC0VcNI+dtEKa/t+3sG78xHxgKlFk4U8vT1iipw+7/3Nfg+oOsqQL2bIwlC8xgLZMRsBTK/HVKt/nz8N1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CPr+WUbp3NTV1VEa2Pgqd0dydGxKJ5c1ePvtZ5rgy8=;
 b=lghBrCvuwoV3Wn24XoMsh5pxvbDPK5HUcrmOS8T0/mPE0WKmcfstZZynPELryIWHIF2/ACUd706lCDRAAzZAicGBewaIQAQCa4txgYj8xtjqqOTgaytn+dYhzqFomd/iOWSocUNImYcdkc/jR+aPH/kHIh0f5zEa13u3fRkuE5cexm4Fi5KCdnaFFIneqg5kE+YsYVT+l8sK23CdQSW6XuoUK+dl1mXfR4h7rYb+BIsrFmxpXYUwWfsVQ5EPDl6R+30Rp0UpnW/mfiHOXAUvBWW5m+1RhC11Vv/876Tc8jBxuDluOEO6WK9MIXIRYSqkCkBdySkMfnpV+MHenWf0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CPr+WUbp3NTV1VEa2Pgqd0dydGxKJ5c1ePvtZ5rgy8=;
 b=TFtP50nUup+mLeCtiFSQjN+ZMtlYaU0KxyPsEWPtd/GiqjllNYRyyHhHxw0XOI9J0jNzSdJkDAV8m8igTc6vABskyDat206COjKSGQPTBOcIo9Pf4XxjzSoeLNKuLo7Sk/5uG/iyvce4m53bcnj7KNJ4y7NFc+6234UEx2VVzdY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 05:11:36 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 05:11:36 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: mvumi: Replace 1-element arrays with flexible
 array members
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a62ouykm.fsf@ca-mkp.ca.oracle.com>
References: <20230105011143.never.569-kees@kernel.org>
Date:   Thu, 12 Jan 2023 00:11:33 -0500
In-Reply-To: <20230105011143.never.569-kees@kernel.org> (Kees Cook's message
        of "Wed, 4 Jan 2023 17:11:50 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b83a9c-09a2-4cdb-41f8-08daf45b7aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIw9yHasjbTaaoFfo46jaFsGMuxV6NqzbVEb5uU020OqrgFbAk7IO0GDDD4sj6G2qFn1YWtV02Kl+6xGPjATCSAv7yMstAjNzwbzuEdMFQuK+8/9vOJY1wu/Xks8SgNFdRnfWo2O+WmbSOfVDe1Oywd2HXPC1vRyMzrnaAYdCsLXWjnBiSom7iYGqkRhAo0B2lt1UYsSZWEwGgzp0fpvsPoPFyOnRiNvaDUid5OJukGF1gSq0QUqgEq3g7prNJ+I8XQFTEitSuA/ehUkYPZG4qAZ3NgizxivmQ2Wwknr6gWQazx1cc3ylaciGtlITubHKzBj2mx9qiM8MLxP36I505NeExFEpb2qB90295wpRpPwfWKEkEfde6DgEgb4hhibvC+Q6DcCf7lrgQPzkhobch8Yeye+X+vjajYP2uX0J7NMbyjQD1CbJvOkyJDIYC6VunIKFTBIpsJITGEdLen+LkHWMCz+d1+yJeszezP6Z2jnVvxAdJiA6jh+ROG3e3ZuAXoAMxSbYve5VxylsTmk/W+yG5Ssxq2ZB618cRk5ghPZfu3f2In8KuH5rXBqZKE+ODiPjp0Z0/rhAYiR8KyXPprOP98Rd2+Bk38qvIns6doB1GsPCaBT4mnuPHm2BDv/DHXvTFz03rrz174ojONtvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(8936002)(5660300002)(41300700001)(38100700002)(2906002)(4744005)(86362001)(6486002)(478600001)(26005)(36916002)(6512007)(186003)(6506007)(8676002)(6916009)(4326008)(66476007)(66946007)(66556008)(316002)(54906003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OdND/arNeKBqQ/h/77GkR9C5JIURUWs16MEfuiGrULlhDbVjQ6u/GjJtW840?=
 =?us-ascii?Q?ZL+cxOfwEIreidTFiCSp46uRW96JkBNI4pP8WNQqUiDAEPjyEN15e1cqeW+O?=
 =?us-ascii?Q?Iz1t1W/f+uu2bs0Zbqk1G1PHdtzZmab7SY5DvoL2PuhnuR/dypgJIb9aK1Ub?=
 =?us-ascii?Q?9KPGbrRvfCtkknYdo3vZ/qjK1tkhodkYE/5MHy2Vzs2XqXRVLy7qwyLNiZob?=
 =?us-ascii?Q?rigxMwGVDUvLDMJHQGVubCxYcfZLc3dkOQ+phbbiEocaA7rnr+DGCZkoqXec?=
 =?us-ascii?Q?L5n6pGYWr1TbDPuF8mm0K4nbIblpaP1Q/jyBAHTtUpdPC0a5XlVcsoV8EB4Z?=
 =?us-ascii?Q?bXTyGPp+WN8jVZF22oxKT00Hf5kmzRhtr7uFkK6aB2er4c9Oeafm0dNDPlK3?=
 =?us-ascii?Q?GAMa1HouJabimWbXJca2xh7hn4BsLcuUC/NIizoH9p2pgkkCY+cb2PB+bnCq?=
 =?us-ascii?Q?nuF1P7U4pWO0VRsaPKHOHRM7Cghu5E+DBI9sya4+wCv0viIOnZURV18X4raG?=
 =?us-ascii?Q?Czzrd1O6MrKdOmpHpuYtmXRni2qRP6EKh3YzR6HqAsg+ib1xsF6vAJm6feoZ?=
 =?us-ascii?Q?V7kVqCdTePZV9V/JjS9SjoKNSOM51NJ3d7O5RDWeYOcnz22UbQafon+/jtY7?=
 =?us-ascii?Q?YpuxXw+wVO1yBrj/KlG8JUzAm4855awAbGbAbCa9fgAeysYZm7q1O9bFzFDd?=
 =?us-ascii?Q?xxItb2Uh4YYu/ZQvAPhhgkyAxs9IwZefEg0cJ39QWNaQ17kJgjvXuX9X+VbP?=
 =?us-ascii?Q?4BeCqL6N6utmq7Or1AmrUtPx2VolRZDYMFgwEo/kkg2DkbcRwzwLfSxmYnjY?=
 =?us-ascii?Q?ogwgmnARTVhGtZ+8nwoOSb1DhGhv1FMeO7E3f/sglfwDw58Id9hFzTaFi7Sa?=
 =?us-ascii?Q?DPjn1uqN+giizweq9fXhtUiP04VBSm4DHbO7HuoUb1w2cb6iHreiXbFWJPRV?=
 =?us-ascii?Q?PYZO1UYByxMiaxCqGDBUMT62NXYzp9520xc/2VYAsBkHlt8eW7NmozLIGDnx?=
 =?us-ascii?Q?fEf40OFDOvgI6vmlUYtv1POItl5ZT25KKaC7B861MZBwp7OPmAqG4zf8XOL2?=
 =?us-ascii?Q?bH8K2+T11Ef1JoyxYPkFIlO0YHc2ZGTNx1nUl+fb3Gp7Fmf2XbSDAHs/6164?=
 =?us-ascii?Q?5PTA0iVc+KFTIm+ADZcN4z66MHShDXppojnCYI5xMQNXNg66mkpknP1/fHKg?=
 =?us-ascii?Q?inBuxgevi/XrqQwyAtpVLI9vrFJQyuF/AGJaFTk6wBFVSXFOr7p1/rhlHn1H?=
 =?us-ascii?Q?JIrlaEdbn+Rv4ftpA5MluLEWoThdqOirSirJQOVRL9aJ8zwJj/yLFsAn1iEh?=
 =?us-ascii?Q?vR/zw/Y3hZptsZD3Y34raBHj9DPnZ2F+mqZNloBAGwMiuLMY+yLWzyvT9dhx?=
 =?us-ascii?Q?q9hKEwUXP9ezLVeoks1233pAr0son93zbaDxMf/HU58sB5QseEVEre12kab3?=
 =?us-ascii?Q?eiVvOA1q8exF4hdn10wYozfht1uIBm1ON5fzPcxrPpwlwtSsOfJAKVXILQ3m?=
 =?us-ascii?Q?LhRNJEYW+RNLLvn2K2jg35FaSdz3NrG6hVWGP8FOWgI8SW88ygFnWjrhXPQn?=
 =?us-ascii?Q?a4rBYMCAAPDvjVIj2dIdo2JE5p1htmZTwsUhQC8rgJVAPeOZWI1f6zUtHsOq?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jan73fZ8XJz8w0k4WgKE5QDWft0rDvHjr3+xAx9FvMO+fZi2LDwjpcsWN6rOd2Yig7pgZ8qyQAUtQqIzmp71nHLb2sgVeR9korvnmGD3x5NpB5jkxKyZnBvn4wAVMxCnpytlCQfVrm2yBTg7IxuFaXgDywyd77GLnZWyri4/ZgCQz+zROTIqHMh9NVg/ux0GfGtk9DXw9nB0hIPbkiwHePvIjgczSs7gth/pYBP7XG55hUYMILUQndp6nRFw6Ek0GivCwlEY1gl0myuMLUee8w6dHuQWP+/nOsFCR+CzCKG55+Mx12OHtYUV9EZoYJj8Wrz0kgZc/g3tJslT4/Gl/bsnD/LJ/TuCLF/x4v0VE3eQI8ptzeFIeTRYsjd34134Ab25zkbIjIsxarFPJ0zCBg2tXka8grYx8ZC4+wjHACD7jNakcDSP0omlIB3zaSR6uNl/+z12JavgfFgH+4CTZHVB23busTCHyKkETDHaySspYI5iFc+dHO2weAZptNUgAABQ4422HQEpWkJMB/P87YP5Sb+8kioYDkviuGY70F+8aA3LTR7mYNLIJl1p+Ak2J+CWky6G87VjCvb8sd4B45FyGzlAn6ib9IUTNf72SnSIm6u5t3ThXVpM30syMC2YaSw1RwD5PblwDlCsFgw89XG6/c1izi3hnjIYIivP5Ja/BZfOLKqXqoKuYoL3aa0Fwl/ZkX7hheU/jvD9lMmKrIPlEgAEXTf76ei1nN76xXODZfohuNvuekXoTVjq7c8ifDYPteugasYeX5EFukM1nFWSsqbEng+YCZzRX23TdB5RvehDPY68J+Y4YoOugP6Y7X0t9lDQ5egdU/l8OLEBhi53W3vse6esAyLo047UVe8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b83a9c-09a2-4cdb-41f8-08daf45b7aad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 05:11:36.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEgY+P2D2jEaqgWp8c7jXM0jTkkXOII4/ocdgSsVVPX9V8mMdg1FD8oLYHWb4qikrElR3LfOlUfQyTnAQqg9PHTW0YggplRpskML0v3/86I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_02,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120033
X-Proofpoint-GUID: s7BMVbp8Ivvob8bm9rnb13leCyqZzqlg
X-Proofpoint-ORIG-GUID: s7BMVbp8Ivvob8bm9rnb13leCyqZzqlg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> One-element arrays (and multi-element arrays being treated as
> dynamically sized) are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten
> the FORTIFY_SOURCE routines on memcpy(), correctly instrument array
> indexing with UBSAN_BOUNDS, and to globally enable
> -fstrict-flex-arrays=3.
>
> Replace one-element arrays with flexible-array member in struct
> mvumi_msg_frame, struct mvumi_rsp_frame, and struct mvumi_hs_header,
> adjusting the explicit sizing calculations at the same time.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
