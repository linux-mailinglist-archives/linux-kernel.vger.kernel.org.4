Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C576F87D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjEERnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjEERnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:43:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D751893C
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:43:49 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhOVM031610;
        Fri, 5 May 2023 17:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=OTNs86+onrSNHPY09/su6NByy+9ufcuOjzP06XsSUv8=;
 b=vIrJxB/8cLV3e9mzkhGPn9k9bDF2SPZ9696IPtreWfuPXSkr/2w4uNYmqlvsdLz9JufC
 WTlN6o0nz/yBdFeslzObUSTTJj3YuLF9OAVDvCxNy9ne1jts2UwXDhHOAs2s51sASbHD
 TgZAANVAkjxEmcdFHRWXRrR/UkqACk8iJymVyJZUZUAZz/wXitM42hKgLjUKfLQAxFxK
 kNDqHKwnnDhp7EVw1gyYon4qFDhbqLYJum1ZHYHKNKestVk3OtMKEqvcRm/6b+cnZYBR
 /fhc4E1SdqjrkajxQBJrowrRyPD3wUm+tIXOBe+fGdBcuP/nSGSDUvKnt2by8SIsq7j2 RQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d5ndb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345G0cUN024954;
        Fri, 5 May 2023 17:43:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spachqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkZGvEOMCrWF0MND7M766khkObeDd+pPFgf7GFAc/BUcnwTMOdCyP+zUBxWerprndmTse37FPjQkvFp+spPtkmfxtG/eSv00jRbDVfp7pbjxE/VgFXbnUTGdS55QhRblPIwOZryN/aRvyY1LIDMRNOtYslXVk4GGhwOLDoYDQl34P6o5lIvj8E4Z2mIWbBOIGWQ582Z/niF587a/tBG6ktnEd0mkYs6FImjoojSI6dtNxGxStwFSpvb+6ixUmFniQjnZLbo7/HymXmsBJxRJaggyc2WK2XlIUk2dufEw2iNSfTcqRYRC9J5N6MFPUbwpwCl6U6XUtIFplscqmiAPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTNs86+onrSNHPY09/su6NByy+9ufcuOjzP06XsSUv8=;
 b=IcjA+Cxye7x3wJiFzasaX3UGBpiJMzuSHa4Mc+4FdXbTgI1pX86sJf8Q3Oeo8usNBgC0UXcMyOD0h/l2ealKGamlCUjfu2ozVYk1bG1JdrtJ6GYLtI/V5P4Kcw02CZ+kjC6pDjWqtQ0cenT691370LX4MYhhwFV3NoyAzZ052Y3wA8iBldU66FXKYDaNFtMOHCq1P2NMV65cTHSNAbhqNMuPMX1aiMTwbykYhDjCHZnryY3Bzma3Ar/BW/Zc+uc4Qn8nUMDWzkx7VbWEDhPgSK98GkRZQ2jhGLRlpulHSQCM1+U+i4B4gIWTLlYTW752Da+zfw9EQjKH1F2W9lz4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTNs86+onrSNHPY09/su6NByy+9ufcuOjzP06XsSUv8=;
 b=kzTN0h2Dn7ptiN2yV50w3dNTUg5/Ct8tl8hjFW/0/WFdpQS6n6GaqQvTjbzy0bdsESpApWTcxwTioeVEJZPJgM7L+XY6fXab714jWnL8hKs0JnZK/VSOSMiE6shy4ysI7J4E7iBocL3rBaPQlh+wZSZ4+aYwTsUsnhY2EvqAhK4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7199.namprd10.prod.outlook.com (2603:10b6:208:3f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 17:43:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:43:41 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 00/36] Maple tree mas_{next,prev}_range() and cleanup
Date:   Fri,  5 May 2023 13:41:28 -0400
Message-Id: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: f54932a6-b5b0-4bf7-9216-08db4d9043b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9INRH0KLBxCdvvPg2pI6XnBOPC/Lc2lezGE4KLkiSHMmK0VwQqn/MEhfjKd6tO9aNd+U0J6qAsadWus5vgiDRNTmRqvLQydN/PCZjRXiYrHi9xvRIP4rk7Q8Zj8uyjAtAsODgWP0xqeIrV0hNLWshumDv0qJ+Ld8gCYTFOZNgcFlMwJnN6WI3DtCZchG53wmoCV8zKxv2RLNkEM5Pe1guR5NFTdmcZtRExBWzmgfGR354xk1a2WR/J5QnznvfWCIA0KHtbu66Xi0wuJs9A8RvTaP6YlQV6qW7bQGfEt02JWQExpP8Gs1Z82AK80MrUG4SGevWrWygn0mDXRKjQRwInuUFZklgeSz5il8OZoASuHt7I1+PQSjowMC8BZcrRBHHaFq9by6yZYgdczP75uqNjyyfiNa8AsDZj2MPscA06ipHWSSelVPb6VzRIf05t64Ere6MPYZ/7TLu1zpUmGKE+F2iVIe0unOKwhZHjoQcFQzNHLHe6uYqCXRQgiOXU9MilS8x1VtBAyJU/+SvLG+djOE36Ice6ABGTN0dAdxSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(2906002)(41300700001)(186003)(6666004)(2616005)(6916009)(86362001)(6486002)(6512007)(4326008)(107886003)(1076003)(26005)(6506007)(83380400001)(66476007)(66946007)(66556008)(316002)(36756003)(478600001)(5660300002)(8676002)(8936002)(966005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1RuV3RzempRM2l1WGdRNUNZaEJkazZ1bzBTSlFEQTJCQk1hZlJNU1kydGlj?=
 =?utf-8?B?dTd2ci9xTjRmeWRIZjQwWGNWbkc2QlBuUlNVbmszQUwxK1RjZmt2NTY5eVJX?=
 =?utf-8?B?a2FRdmV0QWFpUVlFZ0pqUXNuL1YxRk9nWVNZWERTanlDRGFrWDdscnQ2TVlZ?=
 =?utf-8?B?a2ZPZTAwdzJGbklqbityUVZFQmhZd0ROSFhuZGtjdG5QOVVCNXpOcmI3NTYx?=
 =?utf-8?B?VCsxV2Y5SWFmK2V3MHIxdmlhMzBJNHB0a1FzOVhUMEU2N21oYnBKZm5QNlNX?=
 =?utf-8?B?TjBSbmZ0b0dvMmNDOGYwYllWMmFHSm02NHJMYloyTFBqb28wL2pDQ2pKbFhX?=
 =?utf-8?B?ZXpSRHN4RVRyOGtTMUR0d0RScHo3dnlXSHdrYmNyamxRbnBUaHlXL1RVYVFS?=
 =?utf-8?B?eGJZOHdScmErNTN2di9wUUl2RWNPcnNpYWdaT002em1zdGlQSXA2N1E3a3ZZ?=
 =?utf-8?B?YmptbFFzbnhtUWQ1MDFMa2xiQ2lONUtlalovWTFROHlQdm1OM3UzRzh6ODhZ?=
 =?utf-8?B?WHZreFFEdm53SERHajltNUQxWnRKOW10Tm1EdW9BR2Y0V0EzZnQ1cTlwblVz?=
 =?utf-8?B?a2srYStMNU1DVzBrdHNoZCtTd3djVUNvSmdaYWVMTXdrcmdLaVBPMGNVRHV3?=
 =?utf-8?B?dzc1Q0VPT0ZsYStIUDMzVHgyZ1Ywb3hQR3JUaXdLWFBhU0pPa3Bmem1odk40?=
 =?utf-8?B?M0RJWkI0dG4vaFRwVTh3UURqYkJEbFpUU1hBSUxUWm5LWTNFa2IrNTNseFk2?=
 =?utf-8?B?WlhFL1ZFZjF5a212a1hqM0N2bnFvbURxUytFN01TZGw1eVVSVzR1R3pCVjRM?=
 =?utf-8?B?T1Z4S1pnSUJNZXRLTU0vL1FrV3RFNFZJdlFSSUgzVXpsNHJDb3doWHJzRFdk?=
 =?utf-8?B?ZUpKK0NPUWxZUEExOUVsenZGTjM4MXhCR2V3Wk1keU16VDdsR01ETktMZSty?=
 =?utf-8?B?ZVBBcG5SdjNTalNNOG5WQmhoTEdSZVkwRGxpT0toblJFcjNVRzJNOXZTUS9P?=
 =?utf-8?B?VlBleVlrb2UyQzhmazlaaGVLZHRXYkw0WHVLRTBMZTlzYVJTOHJhS3YrMlNY?=
 =?utf-8?B?dlJoOE9xWUZydnhPZGhseXNBalVIc1VhZmFvOG5Sc1RkN1o1SVpmYWYrOWk1?=
 =?utf-8?B?czA4NkRRaEhsazZlTEFBQ3F0NnZNR3krc3pLRTBNZHBhRzdya2xyRS91Nk1u?=
 =?utf-8?B?UFkvdWF1UkkyNlhVd3RWQkJ2RDlrUlB6VGdnNHJTUndtVFJlMHNuR2J3c0dM?=
 =?utf-8?B?elcwVzVYd3oxYXc2V2x0aGpyNW5IdkV1VWovSkVuZzdCYjRESWZmclhUdzFV?=
 =?utf-8?B?OTZ3MW9NdU5ZR2p0UzN3SlFGME8xMlFmN0FlN0NWVTNWT0xMWkRDc05hckk4?=
 =?utf-8?B?cjV3M0dQNXRyKzk4MklxbFVwbnVXaml5cmV0L2xnakM3MFU3TjNrZG9FSGNE?=
 =?utf-8?B?RnlIS1R2T1VYWlJTTTdySnNJaGRVT0hKSURaODlpdlQ4dDNlQzZKcUx6K1Ay?=
 =?utf-8?B?bEp4dmpxd2pTTjBsL0xxWXY5a1d4empTOWNyMGpqS1hwUXp0QS8ycktZbDJ6?=
 =?utf-8?B?TERwampzTEpXSi9zZzlhdVFRZDNJSERZaExDK3VaZW5NWE9DQWhnWENzcG1Y?=
 =?utf-8?B?c0lvMno0MnNLZWVyVVRKM3c2Y1FZanpnOXhJV2xqQWFHM245cGJERFpNR2FJ?=
 =?utf-8?B?ZzFJb0xOQkJCemdTYitkcUpzYWQyWmdzZTlnRFI2NWF5clFFaFE3MmhOQnNq?=
 =?utf-8?B?NGhYTjVhSE1FNHVwRTI3R2NCbkw3OEhBK3RJQzNBd2ZnN3M1LzY3ckJlci9W?=
 =?utf-8?B?ZWxXbHh6QkU0clpTMnNscWloMkdvbkZHc1hKbE12S2ZoUW5OT3gvMkwxdlFP?=
 =?utf-8?B?RzlpK2tlMWwwRVRaakZHUWJhSE1jblk3OEdsK3k0TDU1a1pMU2w0VnBlOW94?=
 =?utf-8?B?N2dBaWh4RkpkYk5DZ2VmTGhIcWxaYi94ZGZaVmY5aVBISDV2dDhTOXBIOEFp?=
 =?utf-8?B?bmNpVVlXMDBiOGZrb0tZK1Z0UkxZYWlUVWF2UThTWmtnNTFmbm0rWjZqK1Nh?=
 =?utf-8?B?MGZkdEpGM1E2L0dDMTZ1RFJMZkp2eUhQS251RGN1UUpMcUhHYWQxSURXdkVV?=
 =?utf-8?B?NTc1K3FqTHh2YStyZEdKUFhJdjNFSFQwOHNUWnI3eEoydloveFBYTXJET0Fo?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p9adw264bAxYTVDmvDSHzeIZQYh5KpyCOgNrHh1jSPRVlZKLedSZTh5sTBTo1zAt8OSXJ24cLDI/AV1YR+hLP3Qb2pbOE/bdJkeDfO31kbwYsXzZCIOEvcl2t9m1bJYgTaiHdPn7e+N1Lq5QIuobvNHQbn5J6meRgSzgP7y+SVPiJ207oGCs8dl9cvXp8W8vyTZBJpinedMHzCWfpHxVbUOQxZzqyNzbZwp6plFRF5eCH25LCTxXQQNyVhbWrb6fTWjeBwHRCSg6IjkxbjIGkPO2t3vwZCM3C6ppuUpYXzVx0WNLE6YfQ1PLdMxKUqcq17fM1L+fUdwtxiRCFZe/Isg+BmnbbT+QQxojy5IDjaYwWjJeGmslRRmjlTIFCUEk8/wEpIZmDFfUSnDdf0Z+E8aqKHh54oh3K0FbQCnFYTQhMOp4DRIm7hdsMRm/dPz+cHV+TvrY90yPbNWQLQpC1qq7NmiHIIe0nQAGhOabjzqDKc8JGZrNPwcNc73+KFqG5eSYuZBf9+oljprrbQqZ5SrBKtSETGEhWwrSmqn0m/h3MtXmGqtmoHYJf8S29KgYmeiditj0IGeIa7+ZYNL5YE4yLN/tKkcYzb4FmPajZchNNF1uzqQ5kVmzDtQM51teCNygw1e046TSDVEv+hSNe9vRBBiAvlJ/5jnqAdXbys0Q4M+eh5MU0CkP+jFR+XJF5qgTCPb2SliiskKM1Xevi/BNxLAjmrG+ZkBIDhucTW8KjhExQwv6+kgfdVSy+wnycRESH/ZM1AdqJsnKZz+qb0wMXtIb83XmbvlV9c2h9nCRB/hZgro20QGkGfsayxpJAIdyVtZ+2/lXcdlucYy1PXmCvCbfsXAPT7c72YVPcf79DEYk56BaDDlGayKLONpaxzq9hvXm/7nZFKs7a4W+5Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54932a6-b5b0-4bf7-9216-08db4d9043b4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:43:41.0704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uu7bIAXmfZoaMoXKgkQ2Y0rN2FElZlTcmnUIK8t60+Sdo6cNT/rPeUkz19dL4J2pS+A/bxO44yNfv7uTESoS5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050146
X-Proofpoint-GUID: Fhv_hKC60JoK_A29NPVKZBHAEpL45_Ma
X-Proofpoint-ORIG-GUID: Fhv_hKC60JoK_A29NPVKZBHAEpL45_Ma
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains a number of clean ups to the code to make it
more usable (next/prev range), the addition of debug output formatting,
the addition of printing the maple state information in the
WARN_ON/BUG_ON code.

There is also work done here to keep nodes active during iterations to
reduce the necessity of re-walking the tree.

Finally, there is a new interface added to move to the next or previous
range in the tree, even if it is empty.

The organisation of the patches is as follows:

0001-0004 - Small clean ups
0005-0018 - Additional debug options and WARN_ON/BUG_ON changes
0019      - Test module __init and __exit addition
0020-0021 - More functional clean ups
0022-0026 - Changes to keep nodes active
0027-0034 - Add new mas_{prev,next}_range()
0035      - Use new mas_{prev,next}_range() in mmap_region()
0036      - Fix testing code of alloc_rev_range() testcase.

Changes since v1:
 - Changed mas_parent_enum() to mas_parent_type() - Thanks Peng Zhang
 - Fix the test code working without debug. - Thanks kernel test robot
   <lkp@intel.com> 
 - Change vma_iter_store() debug log to one line - Thanks Sergey
   Senozhatsky 
 - Change mas_walk() to return entry instead of mas_root() to avoid
   potential RCU issue. - Thanks Peng Zhang
 - Added fix for testing of mas_empty_area.
 - Added check for underflow to mas_prev_slot() - Thanks Peng Zhang
 - Fixed compile issue in mas_next_slot() interface patch - Thanks
   kernel test robot <lkp@intel.com>
 - Removed extra check in mas_next_node() - Thanks Peng Zhang
 - Added missing T's to commit message in two patchs - Thanks Petr
   Tesařík
 - Fix the change to the do_vmi_align_munmap() function to work with the
   new iterator - Thanks kernel test robot <yujie.liu@intel.com>
 - Fix the testing of mas_{prev,next}_range() undeclared function names
   - Thanks kernel test robot <lkp@intel.com>
 - Fix typo in testing code of mas_{prev,next,walk} - Thanks Peng Zhang


v1: https://lore.kernel.org/linux-mm/20230425140955.3834476-1-Liam.Howlett@oracle.com/ 

Liam R. Howlett (36):
  maple_tree: Fix static analyser cppcheck issue
  maple_tree: Clean up mas_parent_enum() and rename to mas_parent_type()
  maple_tree: Avoid unnecessary ascending
  maple_tree: Clean up mas_dfs_postorder()
  maple_tree: Add format option to mt_dump()
  maple_tree: Add debug BUG_ON and WARN_ON variants
  maple_tree: Convert BUG_ON() to MT_BUG_ON()
  maple_tree: Change RCU checks to WARN_ON() instead of BUG_ON()
  maple_tree: Convert debug code to use MT_WARN_ON() and MAS_WARN_ON()
  maple_tree: Use MAS_BUG_ON() when setting a leaf node as a parent
  maple_tree: Use MAS_BUG_ON() in mas_set_height()
  maple_tree: Use MAS_BUG_ON() from mas_topiary_range()
  maple_tree: Use MAS_WR_BUG_ON() in mas_store_prealloc()
  maple_tree: Use MAS_BUG_ON() prior to calling mas_meta_gap()
  maple_tree: Return error on mte_pivots() out of range
  maple_tree: Make test code work without debug enabled
  mm: Update validate_mm() to use vma iterator
  mm: Update vma_iter_store() to use MAS_WARN_ON()
  maple_tree: Add __init and __exit to test module
  maple_tree: Remove unnecessary check from mas_destroy()
  maple_tree: mas_start() reset depth on dead node
  mm/mmap: Change do_vmi_align_munmap() for maple tree iterator changes
  maple_tree: Try harder to keep active node after mas_next()
  maple_tree: Try harder to keep active node with mas_prev()
  maple_tree: Revise limit checks in mas_empty_area{_rev}()
  maple_tree: Fix testing mas_empty_area()
  maple_tree: Introduce mas_next_slot() interface
  maple_tree: Add mas_next_range() and mas_find_range() interfaces
  maple_tree: Relocate mas_rewalk() and mas_rewalk_if_dead()
  maple_tree: Introduce mas_prev_slot() interface
  maple_tree: Add mas_prev_range() and mas_find_range_rev interface
  maple_tree: Clear up index and last setting in single entry tree
  maple_tree: Update testing code for mas_{next,prev,walk}
  mm: Add vma_iter_{next,prev}_range() to vma iterator
  mm: Avoid rewalk in mmap_region
  maple_tree: Add gap to check_alloc_rev_range() testcase

 include/linux/maple_tree.h            |  129 ++-
 include/linux/mm.h                    |   13 +
 include/linux/mmdebug.h               |   14 +
 lib/Kconfig.debug                     |   10 +-
 lib/maple_tree.c                      | 1175 ++++++++++++++-----------
 lib/test_maple_tree.c                 |  863 +++++++++++++++---
 mm/debug.c                            |    9 +
 mm/internal.h                         |   26 +-
 mm/mmap.c                             |  111 ++-
 tools/testing/radix-tree/linux/init.h |    1 +
 tools/testing/radix-tree/maple.c      |  164 ++--
 11 files changed, 1760 insertions(+), 755 deletions(-)

-- 
2.39.2

