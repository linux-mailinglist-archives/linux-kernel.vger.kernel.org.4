Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDFD6A59D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjB1NGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjB1NGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:06:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA7A2FCD6;
        Tue, 28 Feb 2023 05:05:54 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S60tcf010583;
        Tue, 28 Feb 2023 13:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OQfA2bVrJa4ntLAwG1aOF891hUbYSLmzE2fwBNA8CNQ=;
 b=Bg5Bg+AUYR/fpka/y7271xKYLDx3qJlbeftOLfwGH1Qoo33sb8nTf+n507/udehs1Hys
 aXJTne6iGirmPeVj1F5PYod0Ba8qklX/QzOAMKZyP8mrjC0k1UcEjA7+FuJ4TKvLO7QF
 S25fyUVDGUcs7oGqTKEo9CfZk7ZH/jUswfMcYVH8a8YnLmgjGhvfIcRChQ+0GqehW8hP
 IvG/IDr0pGLwFT4+JgW2+zHJzQX5eZm+tbjRtArCf16Kh9YrTC5nQbQXtTO6KYxdrqsS
 J3Hkza+lgOtRgDjxLAwhvAySH/QoB9FVpts8eBvZTotkOP/175B6OgFiCqOnDNBWBy8u ig== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6ee62e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SBHvEW031632;
        Tue, 28 Feb 2023 13:03:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sdh8ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6d7MsHwOsR+ZvDeKAIeG9Bcm78qrdBPnc8GkFib6iy3V7MYxTROx7iAOlYt8wJmb3CDVwc67xIiazBJqiB/SQaz2981GxUjK0M3bWoO8EpeQ4NYnIfPAicof56gJ9uw6BxAECZb1udcHUK2s5g41HIuQfhEtweXEHb44xFdoqV2afPeQEdYlg917ulAUi8drf4VH/J/gtdgqX/4EvA6WjT5irzjUN39pDRxt1Pn8m3XpWprJJ1WArGO3QsZ8qfEHcyo0ESqktk2dtX80Ya3uDO+VADlLFAIjAxZgGQZemG+n4/lRRsloGeVZin/+TOt9qpeTXMNdA6RJP2dPm0lYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQfA2bVrJa4ntLAwG1aOF891hUbYSLmzE2fwBNA8CNQ=;
 b=Z4GEkGsCh8THi4o7AHvm9M4UfHh6QscG4IsMaiG7fhi+Zn5bAzxwSCg8qjz0EoUWKD1jvmWpWbTA5f8I/KxX0QC16+vJLiMgtkW5o3hh5YvVdtQzNJ4AzswyzgCzP5DJSEdedHg7sgZokpdctKi5VbuBbdbXwEDa0qVpJU0mf8sHaYwfHvWDfWGS19E8J//pCviEXlBDPeX4VNBTKKVaNvk/Ea98waivKJ8j1onMHqmUUbxwjUX0BlYp/HK8PXBSL2DRblX3LtP3ywmbI0V/haL2v59CqBLL9V79Vc6UxaJQxOalN7pYlKVh+/9vOBShQvxmF7OX70JyHccQ4nBYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQfA2bVrJa4ntLAwG1aOF891hUbYSLmzE2fwBNA8CNQ=;
 b=IWLch45HE/HKWMe1UTV/x/XrbyrTpWCCLh1ku5yGTkjK4+i5b52lZwrMdOoK6UMrGLp/mp6iC/e2M/vKljs4XOfIm7GXJLRAimFuK0UraboG5lPr8Y7nN9Gs/ERFYAWICzb49G4RTBrF5s7Cx/s+tSg3f7UhW6dmhJIZV6jlwWs=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 13:03:51 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:03:51 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 19/20] power: reset: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:14 +0000
Message-Id: <20230228130215.289081-20-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 73311f4b-c918-4d0a-5265-08db198c3d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPqMXc7qnf7t6LlbUWOl9+ePt1W9yI/4pqKi15yp+DhonGOs/szSRW4bQdzSeIav3bYzaHNJmZeRUkDletcVGczkCKf+axkk+poC34mGYfYKIk/ZlWVV8kQGchHQp9/9DgoecZaHt0qnV+K7VbUnhGkacfnkYbjsuhYngcZUT8n1cb3M8WPkP2UuszCagENjauvN1o0V/hXyV02AU9DRfDvaMGhBcvRUjD1Oo0rg5xlX6TgNUsouq4FSxm1yWxVhrCxRqAmTWaLy19Ix4krjxfLJICyJkRw9CVHNC96IR/0FrR16dLnxz60O1/eWcY6k/+zaEEM732bqwjODSjguPzyKHVg8K2QPG8mDbMoYm1vEfKY4loNPCgkR/xhQxXFgRIQvDm2ge3jCYVuNZpXpiJX/ptsTxTKPFTGmJYzp+Jpz/YXH/pbuurre3VMxMmnAuMID8yho3srLhCHkzSJZmm5YQn90LQU8hmrBX9pS/MXOhIH3AM3GGUqe7xZFTVjgNH4QD+MyNq2jrno97f+DHx8JaOj5mijQWQ8iHaB4NVz56FfdghUHfeo2I8xLx/ezsO+7UTKJ57xYzGnqrNpIkkToDM8LVcKaZhvWDDwvnAJ0nxkE2lEfpZLpOwJ2DWSYEHCOYld/1ajD1q/JU/JtPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(66946007)(6506007)(66476007)(66556008)(6666004)(316002)(6512007)(1076003)(186003)(54906003)(2906002)(478600001)(86362001)(6486002)(36756003)(83380400001)(5660300002)(44832011)(41300700001)(8936002)(8676002)(66574015)(6916009)(4326008)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE9yRDdEOVRFMVB1RjNKVlBWUEJONk5PZWNFamNzYk5aYWdQcm5VN2cxcFBl?=
 =?utf-8?B?ZWlJUkxkR2NIZVJkSGYra2Fyd1BCUXAvQVNDVXJDYVE0VXNJV3VPc01IbjNQ?=
 =?utf-8?B?cE1mRUNDOUQ1WXc4dDdVbHhHTUNiem11TjdRcEtnZGQ1UDRwUmMzSEtGbHRG?=
 =?utf-8?B?U0RlYUo2QVJ0dDJVVXd4WmsyY3lzOElXSEhiT0VEUm85OXJKMDc1SUVXZ1RX?=
 =?utf-8?B?Vlp3MVJpUnpJcmthdmFuSEhlblJkMENibTZzTEtTM3l1Nmo3OERybHBEdDZj?=
 =?utf-8?B?QkR6TjdYTXFDTVoxK0lvK3QzREMzazFISzJBT2VOdk9kTFRtRDJiVDNocWFT?=
 =?utf-8?B?OWUyWHNKNjVrY0NYM05wQTRnbWdEQ1crZzMwOU91dXRMK1pOWkgwQVRUYk5l?=
 =?utf-8?B?OXQyNVIvcDJjVWFtYVl2U2wrZk1xc2FRMGVqNVF4MVYyaW4wYWZVV3h5cWRv?=
 =?utf-8?B?YTNZTThDYWpEa1BaZzNtM1JvRnZUK0NubDNrSGZXS2RCcnJWVEhDalNMTXF3?=
 =?utf-8?B?aHBTK3h0YVVDcUFPZHlwQVRJZlRnalREMGRkYStFZmJGelRkYzVWK0tQNHVU?=
 =?utf-8?B?eU1STHlmN25jZHYvQm04NDJwMmExUDJ6cHI3dFJDVFd3SzhhclRWOUNlWEY0?=
 =?utf-8?B?MTMyaUZIMU1Sek8vWmsrdTRPWkRTQ2wyK2h4SC9vN3ZXMUdzcnArczVGUENp?=
 =?utf-8?B?bTBHTzJzVERpREp6VjFkK3ZwQVJaSG85eUprRDJaZURueTV5c0N3b3hhTGJP?=
 =?utf-8?B?ZDcvdzdQbGFkZzdKSFJtRFZkbUlrV1NaMktxRzZiRE5ldjZ0TmlOOFVLdWFN?=
 =?utf-8?B?aGxXYTdIYTF5NHBIb0I2QVVwSnROQlBkSWVDcDZGaXpYVkdQaFNwS01DblZW?=
 =?utf-8?B?aDN4ZFNYemZ4VVlGRUdRTHBoaDRmQjFNdElkN0VRL1NMMmN6UGtRTFBjK2lV?=
 =?utf-8?B?ZzFzL3VSNGhNTktDYmFLRHJ1c25RZlpBcXowTnp5emRKVGNKdEZyOTVzUW5x?=
 =?utf-8?B?eEZzcUNwTUNqM2phME1OUktMalJHb3BuTFNrN1dTWVBtdytTaThyclQxelRq?=
 =?utf-8?B?cWpxSENtbjV3ZUdnUlQrWDEwWXJZWkxrNlFDNjdTbTNoRXpWWjJxajAzb0Ri?=
 =?utf-8?B?ZDNkeEc4aTIrNDk3VmRCVkpzOGhVTHM3RFNCLzVTbVZUaXR1R0tWYlNvYWpj?=
 =?utf-8?B?LzFLWU1IRWNkcVdEMHg2bm1rOEp0ZzluTjFJMXBtRi9zQmNXb0dzaEhHT1VI?=
 =?utf-8?B?VFZ1KzBsc1VxT24wOE80aXpsd1Q1TkVvU2c5ZTFqMHBjSTc5Qmo4bjlRUFRN?=
 =?utf-8?B?SEJzOGZsb3pOY1AyZnZvU1FVOTRtLzRDNE16bm55WjBIcVpaNllzKzJta2JY?=
 =?utf-8?B?Zjd2bzNyL3RZamFhejU5MTc2SmhGZDIxWDVnV3pXd0ZwN2pDZXNRWlo4b3Vr?=
 =?utf-8?B?cXgyYUYrbHFTSlQyc05KVUYxaDczUnJXTDFTL1JINy8xUlpiZnBVdHNIdjc3?=
 =?utf-8?B?YmRNR0ExeGxKUjlnUm5BSXhNV3ZlQk9FRU02R2hDTXdFUEVMeFFuOTE0UWhB?=
 =?utf-8?B?N0pha2pXWnk5S2wrKzRpL1ZEUVh3M1Q3RFhMejYwNkVTRVZLd1VZektVVnNZ?=
 =?utf-8?B?QWZpbU41THUwRmkrS2JkcVNGSThLOXVodjVkMUpPcjd1QWgwSE1uMGFjZGF4?=
 =?utf-8?B?eEM4R1hUSDMwQkNVWndHZVplZ2tld0ZmdTVBY01tMDFvaW81NmhZQ3NvYWw0?=
 =?utf-8?B?T05MeG8zc0lNMnFBd3NEeWlpT0lzcHRiZHlMNHl1Q3ZnVmNwc1dZMWpiK01x?=
 =?utf-8?B?Wm0rZTlld1Y3dElROUNLVU1pdStyMUdDeU5kaFlYZDB5cGVvck9Ld2tJNDRO?=
 =?utf-8?B?SkVXd1ZFQ0RIYmZuTWhvblk2UVEzYVg4ckk5enBNUFIxb2ZnKzVrcXMvdUFn?=
 =?utf-8?B?NFpObXNrRmczeXhSL1d6RnFBRnZUMjl6MnMvZWx3ei81VXVXb2VhWnF6eGtp?=
 =?utf-8?B?bUhsa3laajVIUllKcjVKc0F3UmRZMlNuVFZhS2haUmxxVXRvSlpxVFF4K2xB?=
 =?utf-8?B?Zm9UWHd1ZEtHQUkvYU1NdGNoVW14OHFrRDF5dUR1clFWV0xjaitlT1pvZWd5?=
 =?utf-8?B?WGFBVkdab3pUTHp5WkFSaVlZekFvUWFXYnprdFlpSGR1Rkw3RmZuMndObGlU?=
 =?utf-8?Q?c//VGZ4+jN33TGT+J1ebXYo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BJXB2DgX+gSxeGMp3t2MaeLLveBSJbZtF7e62Omo1Dp1ykd6W8s5C3dAyj4OnoVucH1ms5Uj1pYDwykk1dLDY1dBq/lsKG9JfRSVLY/laF7RC5SCpUiCtVcJh20EBpTEls+nR7yChkeqBBtYxBC9B6mbw6nnmUexya2NO3/sMBT8IgdSsQFKISN2ILAN5j0LdL/aHcRxVlQC22OFkWVzdFUzDgHW/UlwUstJT40XyXT2V8fTnBgPJRBVV1CaP7yL3tJmKXCfwI+AITh+cq4Gx+lVYJJj0qfdoHJQddRRjAeKtbFZCTLANuSNm1gmB2oapz089S/XqO54zAq6Qw2nJuXf5+OcCVcm+QXCT4cagtJ94u+hG1UE+f9Eg4PrLut6w6z2yNxyP7dc0JPem628ILU05EkmlVhnllt4E4UgtObBOR+RT6B/Uag8nSE8G6vqyP9hfotSAQsz5qD+nb070KPZnjobUvuxW8s/o+JQteJHPk9NcAFHK9l1nerBfGCCDMqA+qvs9ib0XhWK1blTTx/kMGYDuuf3N0LGGvTqDjyz8/MbHtdus3NYZsvQV0pIqkCYhvinXLqPQz71XD2qOEsTKNnGYSehHS0zSJ4q6Ys28roa+I34zv7Rw7MFqCCPei1AjfLFBehJko3Cm6DOglokhfCF60LoLY6djtebFOYtvyy6P4PdAygpeZzUIk5tVGRRLssmvW/MfMI9ppGfv5INCqieowsGh9fgErujnsUvyH8ZpcucPl6qCGwhvmVCxN1rzgHV0L2LBQ1c3Rg5jbs4Tmt+QW3VOdryLIrXUuQzIIViLdjTXIu+P4nigbk7
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73311f4b-c918-4d0a-5265-08db198c3d2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:03:51.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Jg7rm3LVhgsE5EY3ONWKfoLFP9/zQLuZugCl9FwGbAXxRu23yIvxTi+zgRrNBfqWB66w8Bn1f20soD0y98BFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280106
X-Proofpoint-ORIG-GUID: sIoPIZguO5WyqlwxORYEAbgTgWG4CTPI
X-Proofpoint-GUID: sIoPIZguO5WyqlwxORYEAbgTgWG4CTPI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/reset/as3722-poweroff.c    | 1 -
 drivers/power/reset/gpio-poweroff.c      | 1 -
 drivers/power/reset/gpio-restart.c       | 1 -
 drivers/power/reset/ltc2952-poweroff.c   | 1 -
 drivers/power/reset/regulator-poweroff.c | 1 -
 drivers/power/reset/restart-poweroff.c   | 1 -
 drivers/power/reset/tps65086-restart.c   | 1 -
 7 files changed, 7 deletions(-)

diff --git a/drivers/power/reset/as3722-poweroff.c b/drivers/power/reset/as3722-poweroff.c
index 661e1c67f82ee..80edff1a556f8 100644
--- a/drivers/power/reset/as3722-poweroff.c
+++ b/drivers/power/reset/as3722-poweroff.c
@@ -84,4 +84,3 @@ module_platform_driver(as3722_poweroff_driver);
 MODULE_DESCRIPTION("Power off driver for ams AS3722 PMIC Device");
 MODULE_ALIAS("platform:as3722-power-off");
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index 1c5af2fef1423..84b3c3528afa1 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -105,5 +105,4 @@ module_platform_driver(gpio_poweroff_driver);
 
 MODULE_AUTHOR("Jamie Lentin <jm@lentin.co.uk>");
 MODULE_DESCRIPTION("GPIO poweroff driver");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:poweroff-gpio");
diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpio-restart.c
index 5466eeea261cd..35d981d5e6c8f 100644
--- a/drivers/power/reset/gpio-restart.c
+++ b/drivers/power/reset/gpio-restart.c
@@ -139,4 +139,3 @@ module_platform_driver(gpio_restart_driver);
 
 MODULE_AUTHOR("David Riley <davidriley@chromium.org>");
 MODULE_DESCRIPTION("GPIO restart driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 65d9528cc9899..eea05921a054b 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -317,4 +317,3 @@ module_platform_driver(ltc2952_poweroff_driver);
 
 MODULE_AUTHOR("René Moll <rene.moll@xsens.com>");
 MODULE_DESCRIPTION("LTC PowerPath power-off driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/reset/regulator-poweroff.c b/drivers/power/reset/regulator-poweroff.c
index 20701203935f0..7f87fbb8b051e 100644
--- a/drivers/power/reset/regulator-poweroff.c
+++ b/drivers/power/reset/regulator-poweroff.c
@@ -79,5 +79,4 @@ module_platform_driver(regulator_poweroff_driver);
 
 MODULE_AUTHOR("Michael Klein <michael@fossekall.de>");
 MODULE_DESCRIPTION("Regulator poweroff driver");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:poweroff-regulator");
diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
index 04d4228119b2c..28f1822db1626 100644
--- a/drivers/power/reset/restart-poweroff.c
+++ b/drivers/power/reset/restart-poweroff.c
@@ -59,5 +59,4 @@ module_platform_driver(restart_poweroff_driver);
 
 MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch");
 MODULE_DESCRIPTION("restart poweroff driver");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:poweroff-restart");
diff --git a/drivers/power/reset/tps65086-restart.c b/drivers/power/reset/tps65086-restart.c
index 78b89f745a3de..5ec819eac7da4 100644
--- a/drivers/power/reset/tps65086-restart.c
+++ b/drivers/power/reset/tps65086-restart.c
@@ -95,4 +95,3 @@ module_platform_driver(tps65086_restart_driver);
 
 MODULE_AUTHOR("Emil Renner Berthing <kernel@esmil.dk>");
 MODULE_DESCRIPTION("TPS65086 restart driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

