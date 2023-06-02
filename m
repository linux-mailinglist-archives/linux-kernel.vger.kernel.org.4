Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E3472096A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbjFBSxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjFBSxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:53:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700641A5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:53:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352HfDGq027951;
        Fri, 2 Jun 2023 18:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=fmPoTDtkiakxHq+gMwk0sv+7L1m3ndWAegMFi+v3Cw0=;
 b=OC4gkdwUzE4T0RdfeJo0zeCuSUtiQIjGlT5MCeHu/mFNqMuauoH4XZYPHSZcz8+enmeK
 +WlWIQlJhykGt4RCyPh3EI63sJfpAW/a8SXhNQmHn5NPYBxG4KAQkrBm+dMY+bqS/RSq
 pdDJJt8Hlb0ISrAtkQgwYlLrbEC0i+Wn89d2xFMDbX2m3xoqj8Mxde+K4h0gz2Hz6Q5R
 IzePEUgS1rgnS8hn+M4Mky8LLViAsbgRSp8aDMUdpiUQFp6ljtNm0zeptp4W3VOlY6ef
 mh+kPki8uaY+5LvC3K3gVDk16bZ/nUz8WDqTzpGyHPQgZ/R5lwZagKm0XmdrRb6O4nZv LA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkumuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 18:53:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352I0xoC031922;
        Fri, 2 Jun 2023 18:53:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8qdfyxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 18:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsGY3XswBg/DfugRxPEXcY22lod/HoX8BHccdu5EL83mFXcEhybv7iN4lhDjK0CpqSWVXU+/LZew8tmLQ0prXyoptAYgwLw7JMzMJLT5M+wkG0gxTXXOr+9HEaobAuaRAs4M01Qne6Rg4/+T3pfBBCxJPUTWrfGwveImF3eJa3AuSgxuV2qvbPYHHFUd44M4zM5rU/7j6n6pxqeRwazBWPDTxmIik0NSd6+/H83iBCagbM4e2bGo3mr0fhrJyfdfd3FGmAF6P2rOqJF26t99C7yFDfaH5M4KsKBao/6w+KOkjl1Kyb82toMih6txSa0LqNiwXhCbKS6ibFmIuLujKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmPoTDtkiakxHq+gMwk0sv+7L1m3ndWAegMFi+v3Cw0=;
 b=TjabtIw7n0UPnYosdhx3EZoqyFmYhuT64UEj1bx+a4kr0FWDqowoc7AkRKE/CqkQ/nKz6chSOB7xuibg5dAT9vPF+tc3Pn6skYOlBuJBtWlztKbe6YYRMVq8g9b9s/ELxkIbKmxYSdBRDsvOGX/iv81oMjdB707i4lUxqm/vv6rvWBmTes7QxdHTElDp16ciF0Czu+WEg5719aQBVZ/crEzAvLrgXhCIyCaxv/z9IL9fpk/SsZ3GFYzBRWxdUYZSKQ9ATFQqQUigmiH4/6cBtiyD9QiC6VKCSizj4zlSvd54yZCLC65KVViiPJmqkebaYUM7LkEIwF8XuJ2GmNLrKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmPoTDtkiakxHq+gMwk0sv+7L1m3ndWAegMFi+v3Cw0=;
 b=e/zevlBqOMSjLtQbgWCHQsOA0MJF3C3ipg6ynPogn2EvARx8NxbeL1ME+RGrUj5Hzsuf2mha1rUxoh/5WYUnf3lNnBysIdwed/4KUazpz0WSIEMnIuuRLvmTzPv80QAJYcI9XoHeix5GjpnxhbvnfXtxRS6Nkj1ub/kw2t80iT0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB6691.namprd10.prod.outlook.com (2603:10b6:610:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 18:53:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 18:53:22 +0000
Date:   Fri, 2 Jun 2023 14:53:19 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <perlyzhang@gmail.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 13/14] maple_tree: Refine mas_preallocate() node
 calculations
Message-ID: <20230602185319.zoccz6sf72cruczr@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <perlyzhang@gmail.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <20230601021605.2823123-14-Liam.Howlett@oracle.com>
 <ba09af90-2f00-f2a6-94e3-7a1c9c74c31c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ba09af90-2f00-f2a6-94e3-7a1c9c74c31c@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 16127d7a-959a-4776-1726-08db639aa396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfzBIhRooSr1xxibm/uaQtHjrQxJOK0Enhlp0+8h1ZcEa7c/+4f17V7DJoh5FudJ2BKa60ih15ydFFZplb40Q8DgFa6JNuV4PgnVGpjGdyvo+I4pfHD6RY/hcDIP7Oh6osKHzFejnuwO4XTxzxOEwMDHICcZaW9GTHE6pp25DSQKsNhGvMBKcPVH6VD5+08t9F9nreCFVZqDn6ENjim6A9pB5khZNqpYYiAzwHNggmgWCYCvb/13bw47jMzFAfH8zYvXLWLSiXH3Ry7GC5VzZHskUU8mKuVZHhJqM/YVAg/fcvq/x4667ij5FO7j3Z0Ga8N2SV72+foABgscXOJ2K8lgR4up5ctySQXnQl2mXlVNtUf1UR13xkRrCsNTNY8LpljYzmLyNQIcoKZ5l+yvXUbJ3DLd0YRFA18+leMxtD2GhDNqp4ZNcWt0CSA1luwIaw1d/Sw1ybkMnsytYGS8nbcsxIc5oYIxK7/UIgG1dXJmdNWhkuZdqkcHRQbXF6Kv+rMrw00ETZ0fZhLHuwoOd/pIfd/ADVWzksBhE9CoizvJDHlwVuzF6rgrgHNtoan5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(33716001)(6486002)(186003)(5660300002)(6666004)(41300700001)(38100700002)(8936002)(9686003)(8676002)(1076003)(6506007)(26005)(83380400001)(6916009)(2906002)(478600001)(6512007)(66476007)(66556008)(86362001)(4326008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9ablJqVWFjeXgrWkJoVEV1eHJHRytsTkM3WXNCSXFNa0EvRVBYTEFxUmxD?=
 =?utf-8?B?Q2tvTktBY0h6LzVzSmZYUHVIMzhGWFdUK0NwSlJXdUpKSGFxb0JDUmQ3UnpX?=
 =?utf-8?B?VFNjM2FWcHRBbnh5UkR3aFVrV1pQWmowRHBQN1JkNDg3ZHV0S0cvM09QL3Ra?=
 =?utf-8?B?LzY5WUM2OEhUeng1K1NxaFNnRUNMbXVZeVZUUm05dHYyTFlLMzc3NHREak85?=
 =?utf-8?B?N295YnRWQXk3dTNFOVN0ZEprdzVMWmRBbGE4ektNb3QzMWREdTYxck04emNt?=
 =?utf-8?B?emJjR2UwMzNCZnBDa1R3UUZoK1NQL0NlZkpCSFMvM09Pb1pka0dxZzdmc3VY?=
 =?utf-8?B?bWFyMzZyNmlYYm9hd3QxZWpUUEI4U2ZveEsxc05xUjBvRUs3dDMrS1YwU0Ni?=
 =?utf-8?B?aGh5OHFEUm9zM0VpM045VTNxdC9LOGhBZHJwdDB6clZ5T25VR2JhUGpsMVF3?=
 =?utf-8?B?dkwybDlwTXpscEYyTmtWYm9PeGxCOWMvR3Jsd2VKK1lkSytRcWk0bHp1N0xi?=
 =?utf-8?B?cU9oRVpPM2JhTFFHYy93UUxxNktJVjd6d3FicnAxckpQbE9DMzdUaEtUS3BM?=
 =?utf-8?B?V1hRVmQ5Nm1RdnQ5djdlSTZxbDdjbmlWcGs2MHZGbytEUXRNYmJQQm9mcnFW?=
 =?utf-8?B?R2dhYzFXZGdYYmJtUDU3UTRWOTN3b3AzOHB4RDQwV2NoL1FpTU9icTBMeFNF?=
 =?utf-8?B?RVB2L1o1MHJCd1B1OG5MTlpiRWlueklpVXN2NHViZmhEeVhpd0pBVFc5Vkk3?=
 =?utf-8?B?THlBazBXa2F2ZGxkc1pLbWxDVGtwOTN2N0RDbWRCemRiME5SRjFCaEZzSWdX?=
 =?utf-8?B?NGxwQkorS01Xcmp1Q1YzQll4anZCSkRTckw0ejZIVU9ZRDNFNzEyL3ljaGJZ?=
 =?utf-8?B?QXQ5Wk5vVGdCR0Z0d1dxOXBrWGtrYjJkdzVhUG1jNGtXM3FqU2Fob3d3eDdo?=
 =?utf-8?B?OWMrdHNPSER1NjNXL3FDUEZCSUloVmtLdDFqdFJYV0tPMmhMK3FIMzlkaGtM?=
 =?utf-8?B?K2poRXJCb3dhM0pIVzIzK0ZMQ01qWkw3S2Y0OVVCOElRaXUrU1piZ2pyczhB?=
 =?utf-8?B?SkZibGg5MmRyM2ZxTzNYOHZ5ZHArN1dvcTRmQ1k1dG5MUEpnc25JUlhGRzJG?=
 =?utf-8?B?S0NSVXlnUXBaYm5ybFFBTWRyTHBxN2V1WVdoOUhTOXlRU0NJdm1UaUNhTjNH?=
 =?utf-8?B?N3B6ZWYyZjhVaklQcENKMGJlUnZnamtKUS9EM0I3dzVKcjFJVTAvUnh0RHcv?=
 =?utf-8?B?aVplcTlJSHkxQVBtVTVMblhDTTh2TWFHUURnRm1YVGJNMmlsU2M5d3h1d1RH?=
 =?utf-8?B?ZWxETHIxUHVnSTdUL2w3RHpyTFVySWxYa2w5M09jNzIwTTAzN2IyTlp4d2NG?=
 =?utf-8?B?dHYyTGFnNlREVVU3emJRTStNVi9qdkNwZlBHTTgxM1NRcFhVdXVBV1ZFejdU?=
 =?utf-8?B?cXBwbTViYk9vUzcvd2J0VnRDZlRqV3N2ZFJXQTlVZENaS2VweUh6V1Y2dXVm?=
 =?utf-8?B?MnEwRXpMRVp2WE1zSWRFdFYzSHkxRnQrV0lCTjlyTlF5a1NsbTkzc1BSMWRG?=
 =?utf-8?B?dmRRL2YrZ1dEOTFuZi9yU3lZbXNjUDBaZDB1NEhIdXhDMkp0YUJyTjVLMnpm?=
 =?utf-8?B?RTJ5QjVHTWRER3g2TU05MktqRTdwZG1VSXdQT3RDbklhUW01SDRINUJCNDJy?=
 =?utf-8?B?cEVDeXMxdG5HNkR1VnZBTm9CZnp4THNvcmR2dFhuTnQvSzFrekVqbDEwRndv?=
 =?utf-8?B?czQ3MzV1SUZaSEJ6eEtKTWthcFNOcHJTdWp2bUswSEdUa2paejNyTURRREhK?=
 =?utf-8?B?dFU3SEdLbWJjdkpwWTBabEF2eVYvZDRIY1hQaUxBWXkyclVLYjhSVk9IanVo?=
 =?utf-8?B?UjJEbnJuSkhreW9hQ3FubXZ3UVgvbGErYjZDNnQ4OEkyQjU5b0tCODFNaHRX?=
 =?utf-8?B?RGxpK3FBV2JGSU9UOUQxZW9QYXFRS3JNTnFmK1lLY1M2dTZVQzNWOFN0VWZw?=
 =?utf-8?B?ZitiWGxGZFBHTy9RTEtCSGx3YW5xcXpYWXg4ZXE3ck9JZlI3d2VETnVmZjZh?=
 =?utf-8?B?M2hsQXpzc3g5aENBRnJwazdVaGZvWWo1V2RuUlVvWm11T2xZU1UrWk1tam9V?=
 =?utf-8?B?RHhWbGJzUjZxYnBta0EyZWNWM1UrUS95YkdMejhqanFKZ3ZHMVlXNmFMaVNY?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n7WxKwrW89QDIkfE5zRCVonsyDpZH8sc2Ai1ax0rt7tR05pKXMPNmNAuvU3Lbf3XFBpP+9X3UGV2+NdXJS4YmQsfNCO36U+k9i0QagckT1r/8LPJ0wcw2RMIrVw79oGJ5iu+Ua2dDtVwQ5hoQiydFwD8XQ8VYk68ZcBjguN283MBLLa8vtvoDwTZDJUjH5L97VkjA6dAAZWpUIHy9AQvMoDM/7Xw52jj1ztJOhPvXVtZMKoJMv4Yo4dekK8+BxDYhYkt+Vawyt7pCiWXkMymqq4J1iRmCMrimybfHvtOElLSg8vjKZkiVNgbUKuwDIWVIGebjgS/RMjZBHC7DpTL21xURnHv847uDOlKh1oNpf89333g+KGvHfMkkAP/7iWuYqO6MmWBQONyQ7yZY2/mBDUxbhcJwWNJMG6+3PcfWUmHFH89oJ6XTp7DPpp9XSL48iqlTtIzqKEJjDYyhMeSrP6VjD7DUXgFWAWe2Ah0C1lJ8ubfsoSyykX02CYIpgSuKqvLn7n83e0mPunQKb+TQMhHhJij7awfPk13ChyDcS3x+nyADOhX91tEbkqw3VsvYhcPpDQjwXHJuRZKisTlPWPhI89MK9bepg+oCih4mpK1KFfe0XvErcFNVGct1ZWJ6FhWigsf1faXUKm4hlli4W+sJjuwkY7yy09smjAOePnUye4NYeRzBu0lN+MiKBJIOsxDL+IQ+CDAP80cF2etpUH8JqsVvqrKTLDSDsxVkj3WQx+iAGBDRkHZYr42Y9ODGF5uU3MT+2ix7ysqhEcC7f/LFlfZPJv19B5+axklntglJrdQnvJ9MogyRF8TyJAPN4WdnYQvVnYv6d7UBQZk9jMMHPiPATlns6D8SFj7Svwgya4mLZ4LqWUXBvbPDs9sjRDvwZfK2H2vAz77qdLL+l1B6Lgky/MFhPinUbds33Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16127d7a-959a-4776-1726-08db639aa396
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 18:53:22.5223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIDJembhfSQjCbqlYZvsKpJ1Vc0Ah6vDGTyjK6B9d90Df2MdksHpXzdSAdfbk9R2u90qH+cqBOBgPycFFHb9bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_14,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020145
X-Proofpoint-ORIG-GUID: siJR1HK2weIOhPrdDBdgf1syB0bXpyJ4
X-Proofpoint-GUID: siJR1HK2weIOhPrdDBdgf1syB0bXpyJ4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <perlyzhang@gmail.com> [230602 06:37]:
>=20
>=20
> =E5=9C=A8 2023/6/1 10:16, Liam R. Howlett =E5=86=99=E9=81=93:
> > Calculate the number of nodes based on the pending write action instead
> > of assuming the worst case.
> >=20
> > This addresses a performance regression introduced in platforms that
> > have longer allocation timing.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >   lib/maple_tree.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 43 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index adf662bc413e..5ea211c3f186 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -5541,9 +5541,51 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
> >    */
> >   int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
> >   {
> > +	MA_WR_STATE(wr_mas, mas, entry);
> > +	unsigned char node_size;
> > +	int request =3D 1;
> If either mas_wr_append() or mas_wr_slot_store() succeeds,
> or does a simple replacement, we don't need to make any allocations.

Thanks for looking at this.

See below

> >   	int ret;
> > -	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
> > +
> > +	if (unlikely(!mas->index && mas->last =3D=3D ULONG_MAX))
> > +		goto ask_now;
> > +
> > +	mas_wr_store_setup(&wr_mas);
> > +	wr_mas.content =3D mas_start(mas);
> > +	/* Root expand */
> > +	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
> > +		goto ask_now;
> > +
> > +	if (unlikely(!mas_wr_walk(&wr_mas))) {
> > +		/* Spanning store, use worst case for now */
> > +		request =3D 1 + mas_mt_height(mas) * 3;
> > +		goto ask_now;
> > +	}
> > +
> > +	/* At this point, we are at the leaf node that needs to be altered. *=
/
> > +	/* Exact fit, no nodes needed. */
> > +	if (wr_mas.r_min =3D=3D mas->index && wr_mas.r_max =3D=3D mas->last)
> > +		return 0;

The exact fit (simple replacement) case is covered here.

> > +
> > +	mas_wr_end_piv(&wr_mas);
> > +	node_size =3D mas_wr_new_end(&wr_mas);

> > +	if (node_size >=3D mt_slots[wr_mas.type]) {
> > +		/* Split, worst case for now. */
> > +		request =3D 1 + mas_mt_height(mas) * 2;
> > +		goto ask_now;
> > +	}

I will look at adding the mas_wr_append() and mas_wr_slot_store()
checks as well.  I suspect it will need to live around here.

I'm debating a function that returns the type of store and saving it in
mas (wr_mas does not live beyond this function).  The mas store type
could be cleared unless mas_store_prealloc() is used.  This would avoid
duplicating this work on the actual write operation.

> > +
> > +	/* New root needs a singe node */
> > +	if (unlikely(mte_is_root(mas->node)))
> > +		goto ask_now;
> > +
> > +	/* Potential spanning rebalance collapsing a node, use worst-case */
> > +	if (node_size  - 1 <=3D mt_min_slots[wr_mas.type])
> > +		request =3D mas_mt_height(mas) * 2 - 1;
> > +
> > +	/* node store, slot store needs one node */
> > +ask_now:
> > +	mas_node_count_gfp(mas, request, gfp);
> >   	mas->mas_flags |=3D MA_STATE_PREALLOC;
> >   	if (likely(!mas_is_err(mas)))
> >   		return 0;
