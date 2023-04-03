Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E8D6D3B8A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjDCBit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjDCBir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:38:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B427E7ED8;
        Sun,  2 Apr 2023 18:38:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332MbCkf007082;
        Mon, 3 Apr 2023 01:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=lv57re0W9D+c2KA9uO6kkiN4UHyuflytVfpU1bBWK+g=;
 b=FrYlwr5/mbewrg7hoTCkCx8aNh/u8WuCo72ltZ3oF0OA1qEHcBK0st20DOYkCK6nQqWy
 mbbIRGUJQZPBMgy32lBzGnBShjFmhAP8m0ipJ0QpMN8+rPxAMngngsml8Ytcfu8liNQJ
 v2WWEZzgK6STs9NqT9FotsmUsltNOKX9DgtOfn/W1WBc39jDnlz79nJ7+frPlzMtQx1G
 GugxKi4/Gi0ZQfHSLMPOYdgOfRQ9Pzpikv3Jmr0jF454iOvW/sSZTm+JCIsjL/Zf6JTX
 hMS5eFUpwn2H+SaF0nU5D9ZEtbGj8vpMqgY2AzKreGfVxU2JX5cpK+DjdrY22N279fgJ TA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5u9xh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 01:38:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 332LLaR5037593;
        Mon, 3 Apr 2023 01:38:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjpm395-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 01:38:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7uS7vtUIVZ72fNt94ErfbfE9epEoyCsGm2vUSvhHUjaAUKrl0TcmB/DjMw5yffN6j6dlEyfkENqhkIqhod6DMxjVHD+2PmAZST8/JDMXhsAUuZQ6hIsrVULF6pv2AbJ3nBilFvPXwH4dzL8esOgJxpaskA82R9KE0Wx6o7s0/KgproPRmIq+CiL2vB93VPq68ocqCKtS/DVNA3PqE1VSbDR4WgEG8fybGTrur0LI1TsYkVr7oNMNPFUmLcJ3iEwlSDujHnbD9KN2svtvkCKganUXhS2IQQDy93mPaD2ayQ5dzzBLSUi0bwQxIo5PC2rdBwiTgI/0rMfS5nqtVbDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lv57re0W9D+c2KA9uO6kkiN4UHyuflytVfpU1bBWK+g=;
 b=a5jey2x33gzYQVhrzefrUjC6YMNOnC04U4JBzUJiAguR3C5bhyO6B4U5WgtdcJyDojCe8TsrKRt0G+8gM8ZiejuNvgJH4+SE5qvEWduzq/CsW2Z6hrcR0MD4LoRYVa9aITicj5lVUDHVRw4jfih9KoxQ4Tpi+NzcViH6j5G11myaIyF1u97z78teIupOPXqqydF1lw4cBi3bIQBFuBTQCWFAldKhyp1VDjggJKgd6sK5Vk1tFqoVrkVVzB+pu62O2YJgZUQK1GEKnjlgkBDSLquMRBGfZIEb/hnv98bqf9Pkgc/bh2fBDh8Qn0o1rGMKl8dqx2hErrY4RVXEQvzAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv57re0W9D+c2KA9uO6kkiN4UHyuflytVfpU1bBWK+g=;
 b=PTSAg5uYUED7vOOCCodI06LRr51eLgKQtzj3vdiJjugUGmy5V5UwZhQ+whi1xpc0d2wNkhJtnB/XNQ1P+ADRY862wC3OjcvPGG+p71JpV4NbBK7UUbKDGhwbmBgVzcz27te3G/yya7S70BuTpO+3wbkDEYEIpOVHDspFHzR8Nss=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 01:38:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%6]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 01:38:15 +0000
To:     Tom Rix <trix@redhat.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: scsi_transport_fc: remove unused desc_cnt variable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1n9wxs0.fsf@ca-mkp.ca.oracle.com>
References: <20230326003222.1343671-1-trix@redhat.com>
Date:   Sun, 02 Apr 2023 21:38:13 -0400
In-Reply-To: <20230326003222.1343671-1-trix@redhat.com> (Tom Rix's message of
        "Sat, 25 Mar 2023 20:32:22 -0400")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0067.namprd05.prod.outlook.com
 (2603:10b6:803:41::44) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e3e901-ae47-42b6-a455-08db33e41851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/2j6xMDZBT2hxhvUp9Tlsh4X4gLlN4D7unge1ELUDThQO4Py7LegCR8WKdWKMEh7NtTjtvdumirQOQKm8L+tXiHhDicG4IKtIZeXemvFKk3FqSQH0Hu8LSYYriknhvW2wciDqKkyAKUnLp1Jok4GAbz5N+KNYnwBOOiqU/nc3qmwRhdPseKS1y+EP6WQ6H5Uxj6jfKcJlPGKD9xlsLzFjUoQgH1hKx+tlYFYq88lY38c6HEw4ey67GUiLD7oabnrrdsILehkYeoc76vdnq+DKAMeGmxMrrQl5QoZ6W9m6sFoEl1WjmP8VxoXDTP+2IPrL2qc2PPysZICisEIqSl2+qc481MgUlMIMzwANyiJVpavJOaGvIohPenOdadgZm+qs2tUpeN6e1f0cg0U7EOiqDFBxIqO9SrNPpJTmaIHBsiaC/g31fYp9g71mCltCaQDPg+OUWW/DE5klAYBQg3V2bd/eUzjx8Q59nkx7iI0WK+fe0rv5plM7sl9ca1McQrXLlxIjhEZkWbSfPy5i5E76s7+Jb0rE3NLRPuq+s0ca3FJBaSCKzCh7cbRNqkkvw7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(4326008)(6916009)(8676002)(66556008)(66946007)(66476007)(316002)(478600001)(8936002)(4744005)(5660300002)(41300700001)(38100700002)(186003)(36916002)(6486002)(6512007)(6506007)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2l07dk8sVH+v/Ie83+U8fKXyGihSklwzekD8xDBzhz41JrWZUa9s1kKKXo4u?=
 =?us-ascii?Q?fZgfPN3KWIt17eK2GatV3suntFTeJ9qIWmOAhP5fk3KeNJgCXy6JpM3UIkzm?=
 =?us-ascii?Q?Pw+su8dlKX0MXl0PsROwANHUDSsBqEgxkND40cyLQzISjeJLsQlgBgNXvsX4?=
 =?us-ascii?Q?HJoNNWfsK31M1BJXX7Dlk3EK7yll1ko6jYG2huEjFeypf6sr0HP9hhoKaq1u?=
 =?us-ascii?Q?dH9SOftBs1RYhC71QZypxoG5xYUHooFDqnG6n1j7Nl0hP3I0/QwQtRk95GIJ?=
 =?us-ascii?Q?skHui0SIWgLOfd648zlJ3YtxOMmfhsle7Q+ag8OnAPy2of9uZvDSHwlDmzFP?=
 =?us-ascii?Q?07cyyqnH0jyT+0LQK892xkiDZZnobqJwAKzX35VBTQNv0GWmNh9BOZCm7JKU?=
 =?us-ascii?Q?JsUqwhY8BuvyAnzWhyDmjjAvcnwTmObCNA+3MiJwz0kKhCw7cwwyBRsttQ5h?=
 =?us-ascii?Q?AE7CeB6I96P6MzWT/WhK1+0Me8AMo2xYY9SlZMd8+nvnAGAonvU2VquDgS6a?=
 =?us-ascii?Q?zk3F03oTyZZjpCMHqBchhd02Jl7kmoHHa5uy9L1fMPF+UXec4P3HnNZ7hiYJ?=
 =?us-ascii?Q?be0yTHmei6WoPiVDE4JF7kJUMRknHn7YAta5t74hNwuwfLL5+2i68f9ZC3/8?=
 =?us-ascii?Q?n+fZ7JbKivaWypm5+l/lQUF6pfpyacnnveSYYyZzbtkpXa3sy7rgHDMW3iUS?=
 =?us-ascii?Q?rP2UAHKsKGqg9FLPrRYmVlvXAizG+J1AmaCme61gChagBjvJgo8Qt9nx7Pjv?=
 =?us-ascii?Q?ORL5DxSnKa0C7nJ3VpmX0DplShn0IGEQqt5JiErXuDim/OdBCAWyneZSArQO?=
 =?us-ascii?Q?/+mSt7yuhIWWEqBvbi7U+rLFFaZVW4IOKFbbG5NdlT0NK1DHJd++LEFBDqt0?=
 =?us-ascii?Q?aAtLPNTvGW5gJZViYdmVNjHx2GfZsHWjVqODJ4qB3+uUlKg42ubq1Os2tQb1?=
 =?us-ascii?Q?sDp/RYoFWf8c8Y/igbDgo3y6f503zqNsoGvsM1t4wDSu7FXoEG1873emWCyG?=
 =?us-ascii?Q?0MTjyqcJyBhfsWUgQUnJj7ILz07KyAzqq+BttoWvOAW39HSuMRUqnPLFqvXQ?=
 =?us-ascii?Q?uv6v2i1HZ4ywA/tVz75Q7sZ4NpMMHppCHMwuqJxpB0bOIAh3vqce/ZEIK3DL?=
 =?us-ascii?Q?QQ83B2sL4oItOJrkXlXaWnO4W5KoKS0S7Of2MwGqUSuoyFMnKdLIWob+o04e?=
 =?us-ascii?Q?V4jFuSyIF4NyTlXeTkVAyIQJ4/pKLAtK8E+Rrpfps1k0qfSBdFIJYtbLqw5f?=
 =?us-ascii?Q?R6L41n7+tj/H3bRycNMbRrWbE1t7IeFJJR4Khx1+h9dtYkolwnYHw/VxHFab?=
 =?us-ascii?Q?93HOrv2tJljxH06nUY5GO3uENA5pqq+6FUwZ5N0yNAnemRE+PHPyF8mXMUpq?=
 =?us-ascii?Q?o5QyEjoH9y0HHEVlZ5cZM3ODrhbBvvEW7ySqP59uQhH8oiNU5CAdaWx9eGol?=
 =?us-ascii?Q?xUT0Jz0BBwsre75StUYm76NnNCYF2LI9sbpj95v1hcfBq4qzlM/dXQ9lppRQ?=
 =?us-ascii?Q?70T9yxKxYze4QHaE1J2Z5+qByvdgk13r5fo3M2tCsUU8T93tEpSX1Ua+aU3t?=
 =?us-ascii?Q?XhVoTfXyk0Ns4Q6anIDct870G6cL+c3AYAomqkBfR4yJQ4DyrjeiorIlnbq5?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AkjwWgejF3TFftRSlsvwcDmP7OT40ecrEs/kK1U9l1Tb7hQa0rKty4XpHynGxBdrIF39BnalW/24zUrN+PNPh0S1yvqtHFA5uF2Kr86sI8F1bToCB0LtsmzNMBQlhc0aE9gN3eLZKFGX0pxnEXp0m0bEdOrohoK3wyQ6ATxi2I/8ns2YBkDa77hq4WMFVr7ueEEQEOsGsqZHORcjST6jgfj13Z4fWnI9H5s1yaXafFDJ712MNC2DP3Ov2+fAIj0+cw7MGpUC8hVSvxsxrNwyc5yUU2awbTIKPd00oRQNIdsGBHZHvMge9g3x+eVppY7R7jY0oc2D9LNm74G3qTXh5sGkmD2I3Vz74e3gXNRB4ZXOtYIMeIxE5ZhKAltDRkfhpjd1pbLgrO7AiA7BvR72pgLoTqdu4VpjpRUKMTkKKynHxaBZwYa35/uDmffDz1p2P1BEqWvOnxJMYrReuyWImLEikWS6REVE9gFWBYjp04Uv76nT9UE1NtFHd7pyOd4s3zUTLjZUCp+FixIGxZ/uH9fI3VyJCNwCBzUiU65M4h4WIerdy7B99usNT3xayQMp/y8IhW//zPs03T6DOuJ64OU0I4907ufxyiNwZd9rkWGTZ718eHq4V8c9LHNKPLPOXQwT5ddWwXk22A9MiLuNfyqWgn3+uLz/cFtYHxr1hAPWoKpx8arldTDxZGMcBkxGpaXjuP+tsAjxS6tXg+zqlWVkUZCJ8p5ZRG6GtsCtbccb6bzkDTOGhm4IkHggsdYi7ymaHSgMaaJwE+ejJ9IExOp+evmFxukLnVVx+gfksZ3iFKAMfKE5cwbnvmGLot1pqwQKjY6izedX9IW9HZh7Iiv0BvBIazkLo7QynrFROAtjJHoSSH0IXE5mC61QYwsx+krjMFXmZtJsL8jgekLZoA2fFcMR/Id932E2qfoojGg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e3e901-ae47-42b6-a455-08db33e41851
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 01:38:15.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIkW/N+moTfvyBujmqCqAG7SMOvDYDyoWX3NBt38ToUnUHkH26L+AAnwqTLJe+0tqRAJulQRLdDApofaN5yhdDO3KFQaaRWCUNiTbqJ8Dh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=917 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030010
X-Proofpoint-ORIG-GUID: 33D9bT8Ol93SRLxa_oNF5oYi7uTN9YNQ
X-Proofpoint-GUID: 33D9bT8Ol93SRLxa_oNF5oYi7uTN9YNQ
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tom,

> clang with W=1 reports
> drivers/scsi/scsi_transport_fc.c:908:6: error: variable
>   'desc_cnt' set but not used [-Werror,-Wunused-but-set-variable]
>         u32 desc_cnt = 0, bytes_remain;
>             ^
> This variable is not used so remove it.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
