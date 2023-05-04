Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B7C6F7222
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjEDSu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDSu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:50:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF7B59FB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:50:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344FriHs025933;
        Thu, 4 May 2023 18:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=kp6oYBMwRqCqUXABvwGJpEMpluJci9XgbLfziGePJC4=;
 b=DDVO1KClbCOBpQEsjkGM/TlctJm0K8DNhIgMWaIaXr8qUM0YZi1GTDWXz3Y7IPYqEhGR
 H+4OycKll4sJkEx3k3S/9kc7bjo3RoHpv3cfCkZmMadRxCk5XW5PHAkGQ+F6Im39m5F5
 pvSPC2iacAKMdBEsSo+XDKhIRU1tIOXoxYCkaRGa5wSA3Iz14zSXPrhTMN54zie4UKTw
 8LAdwe+M5zcLM+zOELYfBBx/98W5bTJWaT0rjVknu5GUWbI4QZnh5MHMNcWTVxAtUWn3
 XA7BIh0URU7A2WIxcf70X1ghFGQO1dNPZfpwMOepUV3e/ejESDUz7tlbkOL8Zvv4ORie Yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sneaq6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 18:50:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344HjPW9026900;
        Thu, 4 May 2023 18:50:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spf6bf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 18:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYHAIGHD9Pu+BP8xZOwuZ2LzKFq5VkUAY1RXWyPD0dWAgURSqLTCST1/tEm8oN7MoWbBNi8w8O91jSb7xHQwPLkJx4vamoJj+f1C29OpJM+6nP5vg2RLwNK3pcToA50/CVg6nSf87fjQsYMIhKqxfa9FcquXnT6axSbeCAA/w1K2WjMbJxqbEqCB7DjrmMv9ijxvmXjMPPgAkBTVyNrCo88CKzDEFbDmHLq3hPPKMvb3Wpf7xi9mrUdPUlwAggLjbuqDTV3dvCsVYac9+ssF4+8SybBC1Rpv2FYCn2wZLhUKpY/LkGr4UA4nr77a41vODk6JQYSq5PlcQSquH1qJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp6oYBMwRqCqUXABvwGJpEMpluJci9XgbLfziGePJC4=;
 b=eYruF1PbIKhbb50vgO1ncoNjHBrHmfJ/G6kpRhgC84XAyFgf+F8jYKN3nqBl+YkRNhxo8WmH019n8R9vOquI4m8qJ0GJ1T90IM+psjoaptyxm5Hgbac+g0YbePxsTQhp/46/a9BWYYxrAr+Lw53Et3j6YEIPgzQPc5zf74f9K+upocFC8IxGYex/mZ32tNgYhWi+RX8GGX/VTzVpA4nDjJp+hpWwV3Lmj/0PwLP8bz13BKxWx34sM4KCPAR2Z5D/wpaz5H4Nm2kd2QXO7FKtCT2Pehe1zUY4FrhwIMqtHmbvsZaN+G4Y+rZVNov+QNIjx4CnC9wSO8zdjdZrlcSLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp6oYBMwRqCqUXABvwGJpEMpluJci9XgbLfziGePJC4=;
 b=Bfe9VEBzQpl9BS9YO5EDtlvfPBpZJ4SEXhHkHphioTqVH8x7PuRuEq0UPxagyFIQYH76pHu05ZHUzCkrrqstoKx5AUPybN5nHptKARRQR2EjCjLVDW63arAO0g9Nwe1BC7vA4TEALucDiFV/zmHozQ5bTakESs04jiC3l7MeiFc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 18:50:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 18:50:26 +0000
Date:   Thu, 4 May 2023 14:50:23 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 26/34] maple_tree: Update testing code for
 mas_{next,prev,walk}
Message-ID: <20230504185023.4osqa3spndsawvl4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-27-Liam.Howlett@oracle.com>
 <915edff9-1753-2a0b-327f-ba11e6c5a7b1@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <915edff9-1753-2a0b-327f-ba11e6c5a7b1@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0396.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4752:EE_
X-MS-Office365-Filtering-Correlation-Id: d3200e6b-023e-464b-5470-08db4cd06c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uoAaa5Q9RsHgWkWNgVoyCDCHXRrZlv9AUCxuuTbljk80dm3pG7mF0hyAIaAO7lW0HXM/fcCAUV7FvTb26eOWO4Zy02MO0lthkaEETOgKRi5Qlaolt721YsuA/8JBNUMJNYCPZw/J+0gaM73epe9CkKpdBb5dLemd0G+hQKlqZjh3JxatoJLQDiuFSEBOzYGkvKrfMhDzut34j1pSRUPyzexJuzqbDvXRWmeXQ55M6eUQTipFZtvT265T6GMrINHGrzd4uByUMt5TlBiuD9zUVW0QU5T8Am0FqFcHbpxhs1OSPlCIH8DyAacSt/QeKDVqktaiXLHUhKgYHi9pP0dMH/cdtLoYGxuxr39Y+DlYzUQGY+4S6ly5vRegeGITeXfGRidPzuUMazczRrYTcyo7ZBui4gp5dvuSuI9JprmLGpmdcdw+Ic0p6IKrFJw+t02v0BnGeoNMeZmtJ9iHTbIlSk0xzMlovkAWGWYphOTNGyVRjDi7Yu0gBTyfK0xyKrd+1LAjgE2Zquzx1dkUVZZ99yowOUfuC5uzs2mb5w07Q4ksFN1PtZDOZR8RkSjZ3pc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:tl;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(66556008)(30864003)(15650500001)(2906002)(8676002)(8936002)(41300700001)(5660300002)(316002)(66476007)(6916009)(66946007)(4326008)(478600001)(86362001)(38100700002)(6666004)(33716001)(83380400001)(6486002)(186003)(6506007)(6512007)(1076003)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1Q0bGNhaURpalJSSFpaaUhINm5XeENkNjJLWnluRENsdEdJQ1RObHNyZVZT?=
 =?utf-8?B?NHZVQy91MTRlNldUalVZRGovYWNKV0JKRFhhbTJLMHVSa3NkalNOMWhHcWZQ?=
 =?utf-8?B?NU5YTVVHa2crS3dJZ3VzaWhMeGpPN0JDakkzQ0tDK0ZIT3FMZXZQV2c2clJ5?=
 =?utf-8?B?MHh3enJPU3FrZ1VRd0U0VEVqUWxETmpTR1VUNGVWdzU5MGpjN09mbWNGQ1Np?=
 =?utf-8?B?WEpwZXp2czU1bmZ5UFhqYmRHWFQ1dEFyVDRzVFhuZGd4dTh4UjkwZ0M4dTRG?=
 =?utf-8?B?c3lhczFydnFTd2dHNVZMNkJIRjQ2aFJ0Q0JNN25ZQVF2bThURTYrLzVVbWVw?=
 =?utf-8?B?UmJyMzBIYkljaGJtNnBsejZmYTA0L1hJL1haOWl0NVd4YThLRlN6UGZ6Mk5Z?=
 =?utf-8?B?RzZHRXBoNTlqNmxFMGcvV3g1cjJSdjBvM1VaSmdmZW13NFFnUVFqSmxycWlv?=
 =?utf-8?B?aUVEK1l1dmU0Y1c1OEVxVU45ekV2UWV3Qm44Nk9Ld0dsZG5xY3FlYUhCZk0z?=
 =?utf-8?B?QTFEMmhlaURWQ3VSc2ZBYWRyaEk1RWc1UEoydnNqd25LZ0lublU1bE82VTFT?=
 =?utf-8?B?L2NiYUt1R3J4YUNhaE9wQ2U2RTFudnRqMDhLaWpXdnVJRDNZS3BOOUUzTm1N?=
 =?utf-8?B?dUhWbjl6QWxLOWtmMGhmYlUrV21pMG5Ybjl5VUJ6YUJGL2lscGJDdTVKUlNy?=
 =?utf-8?B?MmZURWZCclV3OFA2d2g0Rm9ySTRlcmZFSFBBekcwdVR1K1pzNDhkbkxzQlU4?=
 =?utf-8?B?eW1Jc1JMUXBTRXU0VzV4a0xNNGU1UWZoWlg5SGova3pnc3dvY3krenhyQkZ4?=
 =?utf-8?B?czRyWFByL21NaG5tR2VKMjU5R01ZMG9nS01jK3ZXZGdSK2UwSmZ1ZHI0b2ZL?=
 =?utf-8?B?YmF3dXRqV0Y4T3A3L2daNGkxMDFmcGRoNDBOZVR4anpvRkZ2YUZ1WkJreFBB?=
 =?utf-8?B?NVVaWmZaSUF0UGN5UDIwWTJ1a3VKc0VjVmNMejZXem9xWVA3MGxEeGh3WGM2?=
 =?utf-8?B?cWdtanc3WXF2ZWpUR2l2L3pBMnFlbUpwaU9sM3M4TTJMeTZkak4wdFYvblNR?=
 =?utf-8?B?KzRxL0dCc0U0djIvRjd6NW9ZMHlmeHgwaWlPMSsxOTR1cXprSEQ0aEpObUJW?=
 =?utf-8?B?TkdqMVl6U1ZwQmFTc0UyeEs1TVh0RndtSjRkT3JmdGs4QU9YUWhzOEdnUmVq?=
 =?utf-8?B?c0lXMGwzbzFxN0ZnTjVvTkw3Q0lldGNkdFR3ZGsrbnZiN05Ja25NQzZSVVNW?=
 =?utf-8?B?dHc1amtDUVV1VTg4ZHlSYkFKOWo2SERBN1N6RDZIUG9Ca29XeTYwS2ZEYWtj?=
 =?utf-8?B?cjZOcGwwakxaVkhyUkNGR05nSFd4eHV2ZSthNzRxODgyVFltVVRiODdkVzZN?=
 =?utf-8?B?dlVNK21iRTVKcXJRUnNNOWRaSXNnQXVIN2tUazZScnAxSFNIMWlwbk9TaldM?=
 =?utf-8?B?N1NjeCtGNGR3UXM5L2p0bzYvcUJNUUpsdDU2eEFkN2dYQnBCdHRmZUFTcktZ?=
 =?utf-8?B?VVlXQ3dUTUZHa01xV2NHTU8yRXRCQUdoK1MybmMyUXhabkYxd1E5ZTVLczlh?=
 =?utf-8?B?TWt5S0tPUUFIMjVwcDEwMDZ1WUVsZnBiK2ZEbktxdjlnVGF3a25qRjhlTytr?=
 =?utf-8?B?NFRVajVUWnpJcTRZREN2YTRIdkJyWTdDZEV1RStwdFFEbU9ZM1d5Vi95MHly?=
 =?utf-8?B?aFVYM2loa0xiWWw1U3QybmxqK0poa2RtNVYxZzNLclFNUzdnMlRDU2FJQlF4?=
 =?utf-8?B?bys1M0hKbnhXOFd2R0tTR2tFdEtPSnVsRzl3bURuU0RSSjhMaUcwZ1N1VzZO?=
 =?utf-8?B?Zm01WWhnVEJaR0Y5Wk9LMVdrSFNSWnBRZk1sTkNCUWZEMFFzSVVMQ2NvYUJu?=
 =?utf-8?B?VnEwMFNLN0xVSzliaTY4UlFjZkNESlJJU0V3M1kwRzhJVC9EWkhFVk9LNnZq?=
 =?utf-8?B?UW1jV3p1N0EzazdNTXBZMjVraEUwUy9oUGsramV2MUlucHFIaFdSOEtiNzdJ?=
 =?utf-8?B?bUNOUGpZSjYvS1ZhdmVnTkdJOHJJY2pDWnZzZW9aUEQwWXZ1OFhXam52UTZj?=
 =?utf-8?B?cVliTXIzd2ZoT1dWZHhQd2xNY2krYTZFTjRjZTJwYVBabkV0TEtlSy9rVlZZ?=
 =?utf-8?B?T3BQd2laL3BpSkRvTVFlTTRrVnIvTFNDTDhSM0RpK3laQy9tWnhVK2N3WnZQ?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WGNqelRCRzVmbjVNa3U5WkNtTzlrdnhIWUc2UW9QZkpjajZNY1RLR1puTnZ4?=
 =?utf-8?B?TnhPYml4WlFSR0VPYTczOC9iaVdKTXY0eWNzU0QwU3hiZDVpWHpXeHBFSC9D?=
 =?utf-8?B?bnFJQUFaYUtHTzZRYTdBL0Z2d1BZZGlLMGJEVHVwNXl4T3ZrS3o2MWtxTHNL?=
 =?utf-8?B?SG16djZoQjNUQjFUV0d5ME9tVG9iUU1xSDc2cWg5aDAzUVRabEhRcUtTNVda?=
 =?utf-8?B?ZEQ3a0FjcDgwalpTNi9tQWNndGhTRW40OVkwTVBhYTRCeFdhNUtDY1dBNEVi?=
 =?utf-8?B?U3VqOU1XSWJiNG5mN3l0WWc2Y2xPVUhGRmJsa24vNlozUEVBY1lNQlZPUjdr?=
 =?utf-8?B?QnpTdHY1MnpTa0I3ZWdrS013MjFEVjdYdkNwVE1idzZITDNPeDFnM1FnQVZ5?=
 =?utf-8?B?LzU1TnIwYjlDT1JzL3pkYXdoaHhrcWJ0b29kY3VHL1dDMXpkWTVSWFFGZ0cw?=
 =?utf-8?B?NklOWmlsMm1JclA3eUpwVVJya1hDVlJRYVJ2cjgwMVNiY1VXeVUwTWJzM0dO?=
 =?utf-8?B?bVhRdlRPQUpnck1CTWpDMVVVa04wWm41Y21ZZUxUMGs1cjdYTkc3OXgzdUFP?=
 =?utf-8?B?TDZXVkRUSTlVZHZoa05tV3E5RHBWUGlXN3VhUzNlL0k5TCtnTzQrY2g3NkEw?=
 =?utf-8?B?OW1UeWhlNVh5cXVSbldKdjhrTmxQOXhValNBTWRyZG5QU0ZNSnV1cGdRY1Vt?=
 =?utf-8?B?WGZPVzl6d2ZRak9KM1BRaFh5TEMyanY4blY0cUZxV1hRRXl0a1IyVUFwVWQz?=
 =?utf-8?B?cGxYUnZlVTZiZTk4M1Rjbjg0V3YxMFN4ZlRzdmhVMG8xakMwdkhsSDZVSmFq?=
 =?utf-8?B?ci9HbUJSQ0hTWHMvbzltK0pqOUNFNENYY2VLVHFkdmtFWWpweXk5dUVVMlNU?=
 =?utf-8?B?SDlwZGMybmMzY293YlpqeW9JRjJ3UjFQVjN6bFE4UGVmc1NpL0N1K2pCejVz?=
 =?utf-8?B?Uko5dk9idlBTUERRdC9aSDVtWVE1MDQvMGlpZGFsUHFMam92b1Yyc1pIZXdT?=
 =?utf-8?B?eWhlWWdWbFY3NlRQMlRuZFpLQ3J5TkhickFjNlRXL21NWXExN2tLWjd1RGk5?=
 =?utf-8?B?SHMwaXFNampqbUg3Q3hxMnpCYTdaZ2s3ajhacjA4M3FQcXp3WWVYS08yZHJi?=
 =?utf-8?B?N0pzZkZBdGpqa0JDbEp6UkF0NkJ4MCtkaDZoSWppWms2WnJrQWVPSzNtT1Vk?=
 =?utf-8?B?WlhiZVpRZ2FCcUE3N1JWMVo1RDUzcUVqVWdrMjRZU3NsOVRzK2IzU21uZmE5?=
 =?utf-8?Q?wcqn2mOoouZDtV5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3200e6b-023e-464b-5470-08db4cd06c7a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 18:50:26.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqsCVHPeG/Q3CwVgvMHhHKm5+hMN+MUaDc7hdPb/9osaUG2xPPP+FA3GPnt4h144wZ0Eck6YBoqkxK5jSdQ7sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_13,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040151
X-Proofpoint-GUID: oIqUOpTYDq5uvcRNfRhBMs3u9mL28cCj
X-Proofpoint-ORIG-GUID: oIqUOpTYDq5uvcRNfRhBMs3u9mL28cCj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230503 23:33]:
>=20
>=20
> =E5=9C=A8 2023/4/25 22:09, Liam R. Howlett =E5=86=99=E9=81=93:
> > Now that the functions have changed the limits, update the testing of
> > the maple tree to test these new settings.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >   lib/test_maple_tree.c | 641 +++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 635 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> > index ae08d34d1d3c4..345eef526d8b0 100644
> > --- a/lib/test_maple_tree.c
> > +++ b/lib/test_maple_tree.c
> > @@ -1290,6 +1290,7 @@ static noinline void __init check_root_expand(str=
uct maple_tree *mt)
> >   	mas_lock(&mas);
> >   	mas_set(&mas, 3);
> >   	ptr =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> >   	MT_BUG_ON(mt, ptr !=3D NULL);
> >   	MT_BUG_ON(mt, mas.index !=3D 0);
> >   	MT_BUG_ON(mt, mas.last !=3D ULONG_MAX);
> > @@ -1300,7 +1301,7 @@ static noinline void __init check_root_expand(str=
uct maple_tree *mt)
> >   	mas_set(&mas, 0);
> >   	ptr =3D mas_walk(&mas);
> > -	MT_BUG_ON(mt, ptr !=3D NULL);
> > +	MAS_BUG_ON(&mas, ptr !=3D NULL);
> >   	mas_set(&mas, 1);
> >   	ptr =3D mas_walk(&mas);
> > @@ -1359,7 +1360,7 @@ static noinline void __init check_root_expand(str=
uct maple_tree *mt)
> >   	mas_store_gfp(&mas, ptr, GFP_KERNEL);
> >   	ptr =3D mas_next(&mas, ULONG_MAX);
> >   	MT_BUG_ON(mt, ptr !=3D NULL);
> > -	MT_BUG_ON(mt, (mas.index !=3D 1) && (mas.last !=3D ULONG_MAX));
> > +	MAS_BUG_ON(&mas, (mas.index !=3D ULONG_MAX) && (mas.last !=3D ULONG_M=
AX));
> >   	mas_set(&mas, 1);
> >   	ptr =3D mas_prev(&mas, 0);
> > @@ -1768,12 +1769,12 @@ static noinline void __init check_iteration(str=
uct maple_tree *mt)
> >   			mas.index =3D 760;
> >   			mas.last =3D 765;
> >   			mas_store(&mas, val);
> > -			mas_next(&mas, ULONG_MAX);
> >   		}
> >   		i++;
> >   	}
> >   	/* Make sure the next find returns the one after 765, 766-769 */
> >   	val =3D mas_find(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, val !=3D xa_mk_value(76));
> >   	MT_BUG_ON(mt, val !=3D xa_mk_value(76));
> >   	mas_unlock(&mas);
> >   	mas_destroy(&mas);
> > @@ -1979,7 +1980,7 @@ static noinline void __init next_prev_test(struct=
 maple_tree *mt)
> >   	val =3D mas_next(&mas, ULONG_MAX);
> >   	MT_BUG_ON(mt, val !=3D NULL);
> > -	MT_BUG_ON(mt, mas.index !=3D ULONG_MAX);
> > +	MT_BUG_ON(mt, mas.index !=3D 0x7d6);
> >   	MT_BUG_ON(mt, mas.last !=3D ULONG_MAX);
> >   	val =3D mas_prev(&mas, 0);
> > @@ -2003,7 +2004,8 @@ static noinline void __init next_prev_test(struct=
 maple_tree *mt)
> >   	val =3D mas_prev(&mas, 0);
> >   	MT_BUG_ON(mt, val !=3D NULL);
> >   	MT_BUG_ON(mt, mas.index !=3D 0);
> > -	MT_BUG_ON(mt, mas.last !=3D 0);
> > +	MT_BUG_ON(mt, mas.last !=3D 5);
> > +	MT_BUG_ON(mt, mas.node !=3D MAS_NONE);
> >   	mas.index =3D 0;
> >   	mas.last =3D 5;
> > @@ -2015,7 +2017,7 @@ static noinline void __init next_prev_test(struct=
 maple_tree *mt)
> >   	val =3D mas_prev(&mas, 0);
> >   	MT_BUG_ON(mt, val !=3D NULL);
> >   	MT_BUG_ON(mt, mas.index !=3D 0);
> > -	MT_BUG_ON(mt, mas.last !=3D 0);
> > +	MT_BUG_ON(mt, mas.last !=3D 9);
> >   	mas_unlock(&mas);
> >   	mtree_destroy(mt);
> > @@ -2718,6 +2720,629 @@ static noinline void __init check_empty_area_fi=
ll(struct maple_tree *mt)
> >   	mt_set_non_kernel(0);
> >   }
> > +/*
> > + * Check MAS_START, MAS_PAUSE, active (implied), and MAS_NONE transiti=
ons.
> > + *
> > + * The table below shows the single entry tree (0-0 pointer) and norma=
l tree
> > + * with nodes.
> > + *
> > + * Function	ENTRY	Start		Result		index & last
> > + *     =E2=94=AC          =E2=94=AC       =E2=94=AC               =E2=
=94=AC                =E2=94=AC
> > + *     =E2=94=82          =E2=94=82       =E2=94=82               =E2=
=94=82                =E2=94=94=E2=94=80 the final range
> > + *     =E2=94=82          =E2=94=82       =E2=94=82               =E2=
=94=94=E2=94=80 The node value after execution
> > + *     =E2=94=82          =E2=94=82       =E2=94=94=E2=94=80 The node =
value before execution
> > + *     =E2=94=82          =E2=94=94=E2=94=80 If the entry exists of do=
es not exists (DNE)
> of->or?

Yes, thank you.

> > + *     =E2=94=94=E2=94=80 The function name
> > + *
> > + * Function	ENTRY	Start		Result		index & last
> > + * mas_next()
> > + *  - after last
> > + *			Single entry tree at 0-0
> > + *			------------------------
> > + *		DNE	MAS_START	MAS_NONE	1 - oo
> > + *		DNE	MAS_PAUSE	MAS_NONE	1 - oo
> > + *		DNE	MAS_ROOT	MAS_NONE	1 - oo
> > + *			when index =3D 0
> > + *		DNE	MAS_NONE	MAS_ROOT	0
> > + *			when index > 0
> > + *		DNE	MAS_NONE	MAS_NONE	1 - oo
> > + *
> > + *			Normal tree
> > + *			-----------
> > + *		exists	MAS_START	active		range
> > + *		DNE	MAS_START	active		set to last range
> > + *		exists	MAS_PAUSE	active		range
> > + *		DNE	MAS_PAUSE	active		set to last range
> > + *		exists	MAS_NONE	active		range
> > + *		exists	active		active		range
> > + *		DNE	active		active		set to last range
> > + *
> > + * Function	ENTRY	Start		Result		index & last
> > + * mas_prev()
> > + * - before index
> > + *			Single entry tree at 0-0
> > + *			------------------------
> > + *				if index > 0
> > + *		exists	MAS_START	MAS_ROOT	0
> > + *		exists	MAS_PAUSE	MAS_ROOT	0
> > + *		exists	MAS_NONE	MAS_ROOT	0
> > + *
> > + *				if index =3D=3D 0
> > + *		DNE	MAS_START	MAS_NONE	0
> > + *		DNE	MAS_PAUSE	MAS_NONE	0
> > + *		DNE	MAS_NONE	MAS_NONE	0
> > + *		DNE	MAS_ROOT	MAS_NONE	0
> > + *
> > + *			Normal tree
> > + *			-----------
> > + *		exists	MAS_START	active		range
> > + *		DNE	MAS_START	active		set to min
> > + *		exists	MAS_PAUSE	active		range
> > + *		DNE	MAS_PAUSE	active		set to min
> > + *		exists	MAS_NONE	active		range
> > + *		DNE	MAS_NONE	MAS_NONE	set to min
> > + *		any	MAS_ROOT	MAS_NONE	0
> > + *		exists	active		active		range
> > + *		DNE	active		active		last range
> > + *
> > + * Function	ENTRY	Start		Result		index & last
> > + * mas_find()
> > + *  - at index or next
> > + *			Single entry tree at 0-0
> > + *			------------------------
> > + *				if index >  0
> > + *		DNE	MAS_START	MAS_NONE	0
> > + *		DNE	MAS_PAUSE	MAS_NONE	0
> > + *		DNE	MAS_ROOT	MAS_NONE	0
> > + *		DNE	MAS_NONE	MAS_NONE	0
> > + *				if index =3D=3D  0
> > + *		exists	MAS_START	MAS_ROOT	0
> > + *		exists	MAS_PAUSE	MAS_ROOT	0
> > + *		exists	MAS_NONE	MAS_ROOT	0
> > + *
> > + *			Normal tree
> > + *			-----------
> > + *		exists	MAS_START	active		range
> > + *		DNE	MAS_START	active		set to max
> > + *		exists	MAS_PAUSE	active		range
> > + *		DNE	MAS_PAUSE	active		set to max
> > + *		exists	MAS_NONE	active		range
> > + *		exists	active		active		range
> > + *		DNE	active		active		last range (max < last)
> > + *
> > + * Function	ENTRY	Start		Result		index & last
> > + * mas_find_rev()
> > + *  - at index or before
> > + *			Single entry tree at 0-0
> > + *			------------------------
> > + *				if index >  0
> > + *		exists	MAS_START	MAS_ROOT	0
> > + *		exists	MAS_PAUSE	MAS_ROOT	0
> > + *		exists	MAS_NONE	MAS_ROOT	0
> > + *				if index =3D=3D  0
> > + *		DNE	MAS_START	MAS_NONE	0
> > + *		DNE	MAS_PAUSE	MAS_NONE	0
> > + *		DNE	MAS_NONE	MAS_NONE	0
> > + *		DNE	MAS_ROOT	MAS_NONE	0
> > + *
> > + *			Normal tree
> > + *			-----------
> > + *		exists	MAS_START	active		range
> > + *		DNE	MAS_START	active		set to min
> > + *		exists	MAS_PAUSE	active		range
> > + *		DNE	MAS_PAUSE	active		set to min
> > + *		exists	MAS_NONE	active		range
> > + *		exists	active		active		range
> > + *		DNE	active		active		last range (min > index)
> > + *
> > + * Function	ENTRY	Start		Result		index & last
> > + * mas_walk()
> > + * - Look up index
> > + *			Single entry tree at 0-0
> > + *			------------------------
> > + *				if index >  0
> > + *		DNE	MAS_START	MAS_ROOT	1 - oo
> > + *		DNE	MAS_PAUSE	MAS_ROOT	1 - oo
> > + *		DNE	MAS_NONE	MAS_ROOT	1 - oo
> > + *		DNE	MAS_ROOT	MAS_ROOT	1 - oo
> > + *				if index =3D=3D  0
> > + *		exists	MAS_START	MAS_ROOT	0
> > + *		exists	MAS_PAUSE	MAS_ROOT	0
> > + *		exists	MAS_NONE	MAS_ROOT	0
> > + *		exists	MAS_ROOT	MAS_ROOT	0
> > + *
> > + *			Normal tree
> > + *			-----------
> > + *		exists	MAS_START	active		range
> > + *		DNE	MAS_START	active		range of NULL
> > + *		exists	MAS_PAUSE	active		range
> > + *		DNE	MAS_PAUSE	active		range of NULL
> > + *		exists	MAS_NONE	active		range
> > + *		DNE	MAS_NONE	active		range of NULL
> > + *		exists	active		active		range
> > + *		DNE	active		active		range of NULL
> > + */
> > +
> > +#define mas_active(x)		(((x).node !=3D MAS_ROOT) && \
> > +				 ((x).node !=3D MAS_START) && \
> > +				 ((x).node !=3D MAS_PAUSE) && \
> > +				 ((x).node !=3D MAS_NONE))
> > +static noinline void __init check_state_handling(struct maple_tree *mt=
)
> > +{
> > +	MA_STATE(mas, mt, 0, 0);
> > +	void *entry, *ptr =3D (void *) 0x1234500;
> > +	void *ptr2 =3D &ptr;
> > +	void *ptr3 =3D &ptr2;
> > +
> > +	/* Check MAS_ROOT First */
> > +	mtree_store_range(mt, 0, 0, ptr, GFP_KERNEL);
> > +
> > +	mas_lock(&mas);
> > +	/* prev: Start -> none */
> > +	entry =3D mas_prev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* prev: Start -> root */
> > +	mas_set(&mas, 10);
> > +	entry =3D mas_prev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_ROOT);
> > +
> > +	/* prev: pause -> root */
> > +	mas_set(&mas, 10);
> > +	mas_pause(&mas);
> > +	entry =3D mas_prev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_ROOT);
> > +
> > +	/* next: start -> none */
> > +	mas_set(&mas, 0);
> > +	entry =3D mas_next(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 1);
> > +	MAS_BUG_ON(&mas, mas.last !=3D ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* next: start -> none */
> > +	mas_set(&mas, 10);
> > +	entry =3D mas_next(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 1);
> > +	MAS_BUG_ON(&mas, mas.last !=3D ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* find: start -> root */
> > +	mas_set(&mas, 0);
> > +	entry =3D mas_find(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_ROOT);
> > +
> > +	/* find: root -> none */
> > +	entry =3D mas_find(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 1);
> > +	MAS_BUG_ON(&mas, mas.last !=3D ULONG_MAX);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* find: none -> none */
> > +	entry =3D mas_find(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 1);
> > +	MAS_BUG_ON(&mas, mas.last !=3D ULONG_MAX);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* find: start -> none */
> > +	mas_set(&mas, 10);
> > +	entry =3D mas_find(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 1);
> > +	MAS_BUG_ON(&mas, mas.last !=3D ULONG_MAX);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* find_rev: none -> root */
> > +	entry =3D mas_find_rev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_ROOT);
> > +
> > +	/* find_rev: start -> root */
> > +	mas_set(&mas, 0);
> > +	entry =3D mas_find_rev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_ROOT);
> > +
> > +	/* find_rev: root -> none */
> > +	entry =3D mas_find_rev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* find_rev: none -> none */
> > +	entry =3D mas_find_rev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* find_rev: start -> root */
> > +	mas_set(&mas, 10);
> > +	entry =3D mas_find_rev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_ROOT);
> > +
> > +	/* walk: start -> none */
> > +	mas_set(&mas, 10);
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 1);
> > +	MAS_BUG_ON(&mas, mas.last !=3D ULONG_MAX);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* walk: pause -> none*/
> > +	mas_set(&mas, 10);
> > +	mas_pause(&mas);
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 1);
> > +	MAS_BUG_ON(&mas, mas.last !=3D ULONG_MAX);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* walk: none -> none */
> > +	mas.index =3D mas.last =3D 10;
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 1);
> > +	MAS_BUG_ON(&mas, mas.last !=3D ULONG_MAX);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* walk: none -> none */
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 1);
> > +	MAS_BUG_ON(&mas, mas.last !=3D ULONG_MAX);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* walk: start -> root */
> > +	mas_set(&mas, 0);
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_ROOT);
> > +
> > +	/* walk: pause -> root */
> > +	mas_set(&mas, 0);
> > +	mas_pause(&mas);
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_ROOT);
> > +
> > +	/* walk: none -> root */
> > +	mas.node =3D MAS_NONE;
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_ROOT);
> > +
> > +	/* walk: root -> root */
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_ROOT);
> > +
> > +	/* walk: root -> none */
> > +	mas_set(&mas, 10);
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 1);
> > +	MAS_BUG_ON(&mas, mas.last !=3D ULONG_MAX);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_NONE);
> > +
> > +	/* walk: none -> root */
> > +	mas.index =3D mas.last =3D 0;
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.node !=3D MAS_ROOT);
> > +
> > +	mas_unlock(&mas);
> > +
> > +	/* Check when there is an actual node */
> > +	mtree_store_range(mt, 0, 0, NULL, GFP_KERNEL);
> > +	mtree_store_range(mt, 0x1000, 0x1500, ptr, GFP_KERNEL);
> > +	mtree_store_range(mt, 0x2000, 0x2500, ptr2, GFP_KERNEL);
> > +	mtree_store_range(mt, 0x3000, 0x3500, ptr3, GFP_KERNEL);
> > +
> > +	mas_lock(&mas);
> > +
> > +	/* next: start ->active */
> > +	mas_set(&mas, 0);
> > +	entry =3D mas_next(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* next: pause ->active */
> > +	mas_set(&mas, 0);
> > +	mas_pause(&mas);
> > +	entry =3D mas_next(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* next: none ->active */
> > +	mas.index =3D mas.last =3D 0;
> > +	mas.offset =3D 0;
> > +	mas.node =3D MAS_NONE;
> > +	entry =3D mas_next(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* next:active ->active */
> > +	entry =3D mas_next(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr2);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x2000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x2500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* next:active -> active out of range*/
> > +	entry =3D mas_next(&mas, 0x2999);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x2501);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x2fff);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* Continue after out of range*/
> > +	entry =3D mas_next(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr3);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x3000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x3500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* next:active -> active out of range*/
> > +	entry =3D mas_next(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x3501);
> > +	MAS_BUG_ON(&mas, mas.last !=3D ULONG_MAX);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* next: none -> active, skip value at location */
> > +	mas_set(&mas, 0);
> > +	entry =3D mas_next(&mas, ULONG_MAX);
> > +	mas.node =3D MAS_NONE;
> > +	mas.offset =3D 0;
> > +	entry =3D mas_next(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr2);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x2000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x2500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* prev:active ->active */
> > +	entry =3D mas_prev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* prev:active -> active out of range*/
> > +	entry =3D mas_prev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x0FFF);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* prev: pause ->active */
> > +	mas_set(&mas, 0x3600);
> > +	entry =3D mas_prev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr3);
> > +	mas_pause(&mas);
> > +	entry =3D mas_prev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr2);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x2000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x2500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* prev:active -> active out of range*/
> > +	entry =3D mas_prev(&mas, 0x1600);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1501);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1FFF);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* prev: active ->active, continue*/
> > +	entry =3D mas_prev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* find: start ->active */
> > +	mas_set(&mas, 0);
> > +	entry =3D mas_find(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* find: pause ->active */
> > +	mas_set(&mas, 0);
> > +	mas_pause(&mas);
> > +	entry =3D mas_find(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* find: start ->active on value */;
> > +	mas_set(&mas, 1200);
> > +	entry =3D mas_find(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* find:active ->active */
> > +	entry =3D mas_find(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr2);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x2000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x2500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +
> > +	/* find:active -> active (NULL)*/
> > +	entry =3D mas_find(&mas, 0x2700);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x2501);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x2FFF);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* find: none ->active */
> > +	entry =3D mas_find(&mas, 0x5000);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr3);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x3000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x3500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* find:active -> active (NULL) end*/
> > +	entry =3D mas_find(&mas, ULONG_MAX);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x3501);
> > +	MAS_BUG_ON(&mas, mas.last !=3D ULONG_MAX);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* find_rev: active (END) ->active */
> > +	entry =3D mas_find_rev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr3);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x3000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x3500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* find_rev:active ->active */
> > +	entry =3D mas_find_rev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr2);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x2000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x2500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* find_rev: pause ->active */
> > +	mas_pause(&mas);
> > +	entry =3D mas_find_rev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* find_rev:active -> active */
> > +	entry =3D mas_find_rev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x0FFF);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* find_rev: start ->active */
> > +	mas_set(&mas, 0x1200);
> > +	entry =3D mas_find_rev(&mas, 0);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* mas_walk start ->active */
> > +	mas_set(&mas, 0x1200);
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* mas_walk start ->active */
> > +	mas_set(&mas, 0x1600);
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1501);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1fff);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* mas_walk pause ->active */
> > +	mas_set(&mas, 0x1200);
> > +	mas_pause(&mas);
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* mas_walk pause -> active */
> > +	mas_set(&mas, 0x1600);
> > +	mas_pause(&mas);
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1501);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1fff);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* mas_walk none -> active */
> > +	mas_set(&mas, 0x1200);
> > +	mas.node =3D MAS_NONE;
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* mas_walk none -> active */
> > +	mas_set(&mas, 0x1600);
> > +	mas.node =3D MAS_NONE;
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1501);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1fff);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* mas_walk active -> active */
> > +	mas.index =3D 0x1200;
> > +	mas.last =3D 0x1200;
> > +	mas.offset =3D 0;
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D ptr);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1000);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1500);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	/* mas_walk active -> active */
> > +	mas.index =3D 0x1600;
> > +	mas.last =3D 0x1600;
> > +	entry =3D mas_walk(&mas);
> > +	MAS_BUG_ON(&mas, entry !=3D NULL);
> > +	MAS_BUG_ON(&mas, mas.index !=3D 0x1501);
> > +	MAS_BUG_ON(&mas, mas.last !=3D 0x1fff);
> > +	MAS_BUG_ON(&mas, !mas_active(mas));
> > +
> > +	mas_unlock(&mas);
> > +}
> > +
> >   static DEFINE_MTREE(tree);
> >   static int __init maple_tree_seed(void)
> >   {
> > @@ -2979,6 +3604,10 @@ static int __init maple_tree_seed(void)
> >   	mtree_destroy(&tree);
> > +	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> > +	check_state_handling(&tree);
> > +	mtree_destroy(&tree);
> > +
> >   #if defined(BENCH)
> >   skip:
> >   #endif
