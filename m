Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE9769150F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBJACl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjBJACh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:02:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C377E30EB9;
        Thu,  9 Feb 2023 16:02:34 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319N4XMA005273;
        Fri, 10 Feb 2023 00:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=MU2Jr+Md3sLmH44sqAy7N3rO2iHYWHHAtfGcvCC5YGY=;
 b=JC4ftLmWqifg94y08Hy9UEkq/XGBtyBE3PsJOfXKfwT0/wae9bZRI0Sm17lTmggRYLBf
 Gr10lTKhVGVY18/IFV4cjd5HDu+f5ZFaNTfQBsYanA5YppGUyq+uNuCB4dkZL4DKF1YW
 VxFNKV6FY8XD2Suo1j/eMGRV3DXQRRz2WdKZJtGKzw6LBWW4Lv25MHRE0W+l8oNcMBYW
 n7eoSt/Sg6OF34/YPeG7/hm6tsaOaxqm8FRiW7sbl8hircwyzo+b7sWXkmi9+2LCcdds
 MARKUI4q5sYFjTrcNBT7oJbK1mwBDw6KKhsItN0tLUz0ky+tXE/DDNHPq7vBX7EVVQaU Tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdy1c919-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:02:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 319NaHQj036139;
        Fri, 10 Feb 2023 00:02:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtfwt6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:02:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjUY14kBAnNrQJUxmied4gZLT9HAoTNBjrj/COPhiDYiRZXVIBGzfJKFjqyXN2wMLT0jZWyV31f8Di7Zh6r4IiU7nkl344siOhIsxRc+QUHupKr7SiLHzdvi5imV+EVMi2sCAa6GRWVpTxcZYEiLqh6zg27JrZoRBXk8QWVYZ8QrvCD8hidhpRMLym8aiGgbsr8Kbkb73IjhTYA2nXSiik8IuzBKuxjUfGFW3uJG0tX+B5lQjFrhtBpJTVP3qDvpmdfpCM8sgbF8fBamhVdkZB9MBxnfWSNKPQp7/dWS3tTjcU2XqjWBP0G5sGZK9mICozXZpOS59QHt+YaAbOLMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MU2Jr+Md3sLmH44sqAy7N3rO2iHYWHHAtfGcvCC5YGY=;
 b=SwgltnfZP7dn5gMbI3hoBb6l5xgiovfS0tPINrXC2qIEWXcRqpqVFU6d6OHbDPJ62yzGH79UG4r0atjuQu6Chl0v26VolqT/R1kQhuBXDFoA+sZV7wLIvpkJFx9yg2PUjjxGG2S0SDjSTQ+N+VNetu/u1DEDw0VUOCR/ga9npV88jbMA1yctrmM433eu+OtVECzdaytxyTVaO8W9+W/GgXAEsHtGXPd40PX/LDeFT3kpZopRqMTfjxrLFPLWwd5EPBQJsWb8466fX+KW09ZvR5b2XyJAXDlG3SYQBZtO4oKwBlwvwqRJc1zan4qs6H9JWmZ5r5DGq1e7wSpwpx3oIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU2Jr+Md3sLmH44sqAy7N3rO2iHYWHHAtfGcvCC5YGY=;
 b=a7ttqc4bswzZN8ZFWnKQg3jF3Ztj96TeBNOs5+5U//HX6SI0d9Ucr3N8hBWm1JadZUSTgvN6rEz662LacfPT4z2bViElXnC77QfJ5zNGJRYYNFktL7dC70gc0VFivO7W129u1rR5W5AV2fTUnOLTdoJ2okMWZIuI+LLxLACLufk=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6576.namprd10.prod.outlook.com (2603:10b6:510:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.5; Fri, 10 Feb
 2023 00:02:29 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 00:02:29 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, elena.zannoni@oracle.com
Subject: Re: [PATCH modules-next v10 00/13] kallsyms: reliable
 symbol->address lookup with /proc/kallmodsyms
References: <20221205163157.269335-1-nick.alcock@oracle.com>
        <Y8b8TOJzd/RZXR8z@bombadil.infradead.org>
        <87r0uy3hkw.fsf@esperi.org.uk>
Emacs:  if SIGINT doesn't work, try a tranquilizer.
Date:   Thu, 09 Feb 2023 23:53:29 +0000
In-Reply-To: <87r0uy3hkw.fsf@esperi.org.uk> (Nick Alcock's message of "Thu, 09
        Feb 2023 16:54:23 +0000")
Message-ID: <87bkm22y6e.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf43775-f691-44c3-7453-08db0afa1962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bU4LnwU5purf4vVnbm1UIb6L1L13iNd1iKQxZsRYgOgV6OqljYXJwpaUp6BV5br1dE3PRVM2scQ8AGmq2QKlpA71wKvyjmo00ju1AHee+3izJFTr5AugwRKzAFRuLMtePIldJqlJPS9oIXHj9P2fhV1Uhmqhtcs+iixB0IJXdwAAfxeeSf4Y3ZzOOkfwEOOE6Q9OHR0o51WOKOF4w5xYDoCIor+Hp5WLvzcxj2Z7YuppHAmppEE7//lgT/dnYolu9254o5dLiCoS5w5pFTQXIyrwGNKMoNp125is3OIaE8TBAyBa/HjVZn9EHcbM31LD2rEoyFAxMwVcVxvxbMN71gfAB1g2xCfH/RtgTOVD2dXIbl+/yBhAIeza2JlHTuvbC4IORivbJi6FvCduBVetckU8J8BerQYK0QOvDnins8N2dUX25W0hEslHEde0F36ECLvj/liAAXym1VtT5srAyV7vrHWqv+Sw5HOQE5oo7L92fNtZtZlvPk67SxdGpSc5RGJbu1LQiCPG1RjKbpxmuVMhU654gF2i73kMqjuZJ1U8kMM0tK99wh9y6XW6TOd1b3dsJhOsYwxi4us4a2PnKwcyucCCWl0fWgz/cc593rfyJwqOQpR/R1CR9IbFdcIBZmKqH/958CJcTro1earfVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199018)(6486002)(6506007)(5660300002)(26005)(478600001)(6512007)(9686003)(107886003)(86362001)(186003)(38100700002)(66556008)(66476007)(8676002)(36756003)(2906002)(4744005)(44832011)(316002)(8936002)(41300700001)(83380400001)(4326008)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ngO5AKc/fkPje/ehz9PBDxVPR8yunMYuQrws/acBeq2uZSXc07BrXvaHs1dg?=
 =?us-ascii?Q?xF9b0x9OOQorVlvbeQvFCZXX684jB5rboTRcMHnu64wLJp/m2ghnf3OggrYN?=
 =?us-ascii?Q?IShObYJK31KSuMUCb2xI75ka28DoiMSz7R8MlJXAf+a66ZzCjSuE1/RncXlX?=
 =?us-ascii?Q?J6DyTZ08h+g8pOJOT2i2A63KcANnKWfSJgQ1u4jrAHb+S6OH5M8cPfFYJ1So?=
 =?us-ascii?Q?P0htXv9ESvcvomciN1vUR5tOWXPipcfVfImG/vrj/2P/4jiGXtHyI3ybyLjf?=
 =?us-ascii?Q?oeVu7xYLO00N7bNp8a77DivgDzAbSXqsEh1gB/rEVvOGJkM0d5nOfII8t8lo?=
 =?us-ascii?Q?lwbVRKraaTf35WZDEua876WZ6jWkU/61MrIm8jkRd81GuKw/GGw3PWa0txEH?=
 =?us-ascii?Q?H5P9KRpRU//u918E/71EVMrd/L621oNu1dBI4Y1ZIIfBrwwmSIcoqkk29KRP?=
 =?us-ascii?Q?zTKLt/II665sB2y/PDMamx5tDuXs8gRN8ZDAtuBpaiRLJSg2bqds8WlhCgPe?=
 =?us-ascii?Q?2+d2oVNBPJw0aM0XmZM1vq5rG6f54MEWTEFpiIM4fCUQECA2NqbGKnZDK4/c?=
 =?us-ascii?Q?9FE/Agt0/qY8DZvYAICR/TkeY+THcvoXq01lNuMsLaMm/nfFtQbrYnuJMZNW?=
 =?us-ascii?Q?9WpalMb1cOEh9mM3KgLdQSPUEdapOPyHR1IworrmVDFyOeMtMvwGWIiClYU1?=
 =?us-ascii?Q?lyw/kYHR7KlgTU3vC5kfJ7DmsrNXBaAKqH1sDS+W2h1Es8cmrBwT+X0M6/7I?=
 =?us-ascii?Q?pctXz3SRV6cUP0ey8BoTclvkck1i7nRJhdqX8T1U0Hn8dhLnDv/rggv1lv1g?=
 =?us-ascii?Q?cvnTotGXsC18ANqmidvaOMulNP+JMSzAgfGPlmiHD9g9wjkz3/oP9lXlu2iv?=
 =?us-ascii?Q?SyZ8l+xO6/4ZV5L3VPQJxXGPJfbmsa7YNINrBP+h05p87BLNfDuMzwthZwrU?=
 =?us-ascii?Q?1rP+BxDgUESSPCMm4djKiIL2h9ouQg+7LpeHoa7BkOL6SuI+qwkum/W746qb?=
 =?us-ascii?Q?PJovOUBsxE68nbqV7KoS3M6r0rFjf2UUZTaECJ4KezU830Qp8icLy+/xtLrX?=
 =?us-ascii?Q?ab7rmzTXsdTryqolzucyLEoukwx7c2dKnlWF1okAiAagfYoM2n6b1W5vO7QQ?=
 =?us-ascii?Q?cyzSKiQx2B+kyotJtsi/cfBMa4OMee/OvEdtBldSBCRmyJtAc1wPCJptwwHN?=
 =?us-ascii?Q?UHweKWd5BWAUSfaD6eC+9/zY0v6P25AV3ZCnaeVDA2z2NLr9KKEItsG574sj?=
 =?us-ascii?Q?/IA98b594Vnvdst1pKQAZA2o3VpnIXrwDSNmkbwWHLlEarrYeJHuXi8aLva7?=
 =?us-ascii?Q?oPSXap1SiYlkMby0syTshlZDXN+sg1yxkeic0eKml4URTo/y2HjeONT0FvTR?=
 =?us-ascii?Q?i29w485rcjm9S3A1gtAJ0xDiv25In4TZnkvs8Gyam90gk219Kt5bCiPTJ27i?=
 =?us-ascii?Q?7diLL+rEJuPDrlccBgmcS1MR+Y3P3betuUJstf3I0V99FLiiExovKohUSXZD?=
 =?us-ascii?Q?KClP2HV5tNIsL7FMmIaffKGcO/h0KQ22neU6Ye4VXndZsEz5k14XJXuXqInP?=
 =?us-ascii?Q?sMmmbLrxPU3JuESUdVJOpo7Ulm6+IWz4VNCrcAk1sPopmgamDt+Tvwq8scgz?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DEkV6zC7E0XcdB53uxsQX57cvj9AKhbDtBgR0WZ3uh4BG8PEYBeLaD+oDj3F8kDxqfSeZDD2dpxleyijd2XD+Bv0bdupB2QRa7b96hUVZVPCP1QH8o4bOUoJdbiViwXkL55xUgViK8AQDcA4Jji5jBKbfUpvtuF+uUt7zhMM2D56jcQvVx5V3l+ub+LWhkJO2mSO368K5KYV+AWFSSKdwRNFCNdYIBqlXZ9D+QvNwDb3+CNjct/SYJ0mMDiHGdEpMn2vja/7vk66dc0bpSr+6o0xmun4vl4L+0b72MjLOX10DN4Uk93iw7JO03Wt7TtHrL1GG+dxD+WmvIki/+I/ueMmUAZgAHDhiFUKoXe/Mu6xTcENtyJISpQDQRz1oLAHE8qbJ0+US/FJRMpbp9cZB8cqkyPBd7dXrcgw0sSRo7/3SETKXC/GYWUTY6tIPct8fB3bzs5DLVLkXwdojlEh7NZoFyYPB5iPEDNrBkeXU+8DlFhJdN5l6vfE8eJNOpYQU7GDOaOBregZwO8uVan4kuHF3GHY6qOOxJQkj8ZTYRtrMaGyvm7q9dSBx12oVxsCGJ/cnbMt5qS+Ki2/MvDJ/P5UJAvvNG5Xn+hqU96Euu421CkutojihILSQT9Fyzx68xvqYtntwVc1KQmM4fqZ9K6xDrcmOo4AydOW7sDdHgEmnR1mlDnaWiV6G6zeYqjr6Fj53WObzflPifuAQXbSn9/8+xyCahSwKCXXH8wWoUzRfsp1jfgurVX1HrfOhzn+bD4aMNFup/8gdeLaGiGffv8E5IfZL+oqWcb0HubH8No=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf43775-f691-44c3-7453-08db0afa1962
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 00:02:28.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saLKsRbPbW0jlo9I3A9ZlmvwJOp1ebtuFrQxFzY3S8totuwOM3Iqjap6zC17OIkL9VUwNuB3qgRwIWxETxeRig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_16,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=782
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090217
X-Proofpoint-GUID: SYNRAJCiaK5XT_nNJllWnO3TQDvlHB-0
X-Proofpoint-ORIG-GUID: SYNRAJCiaK5XT_nNJllWnO3TQDvlHB-0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[most people trimmed from the Cc: list for this procedural question]

On 9 Feb 2023, Nick Alcock outgrape:
> I am going to split this whole series into:
>
> 1. A series of patches (123 of them at present) Cc:ed to subsystem
> maintainers as well as you, to comment out the MODULE_LICENSE usage.
> These patches will have Suggested-by you. This series is rebased against
> the latest modules-next and revalidated, and is ready to be mailed out;
> will do so shortly.

One quick question: if/when you're happy with this series, are you
planning to take it yourself via modules-next? My understanding is that
if you are, I can just send the lot as one big series, whereas if you're
not I have to do it as a lot of little series to avoid burdening all the
maintainers who will have to take its pieces.

(To me, taking it all at once seems like a lot less work for
everyone... I'm still Cc:ing maintainers on individual commits affecting
their subsystem though. Seems only polite.)
