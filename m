Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3546686836
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjBAO1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjBAO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:27:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A13D91B;
        Wed,  1 Feb 2023 06:27:31 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311EO3sC012757;
        Wed, 1 Feb 2023 14:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AAEkVQOgLdmASNm7gysdfBCID/RcKO7/3fDpSSKyvLQ=;
 b=th7g6UAJZ9r+GQrigTNkNLHgePiapqZlGqzJ5tPECGyE2Vm4o9XyH6TMvLtDQL/SGMbk
 ybjiBHTvU0W579o8y9xKoxFOpbmTJClK1M3L4EM5jL1wfs1Rr7w0mklidC8iZ+JXufYR
 i9sgETl9lm267Kt3O6JSJJE4KFhclYc1+J/C/MBfJCdHQAE74lmogwm96eNOcRh0ajqs
 QaomUwedxEE4O57M9QorkUWELa9rsGBstd0Lhqof0VBXd99W+XQGVl4PP5XYmqOATAZA
 VHt33TwkXeulTCsaXCe8WBhXOh922/NDhtMKGVtf6ASRAbvZjwJqq3BbKTSCHTZqZpod lQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfkfe0sxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 14:27:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 311Dk76P025405;
        Wed, 1 Feb 2023 14:27:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct57k062-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 14:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwrSCPa8nLW7JkVcsNYJHAB9/T3451k9ZJ6VkbLctfGN+g31Xgh2WhhBJTo4BAd2hGHFFgQvFTv6WDQW8xRxhd6kJQ+hHI4cwZgrbe/6AwZDeSCs9pvtfhlqCoH+1gIlTegp2sGGR0p9WT1V7V/RGQvfcAqkGJFQ5WnwWjqKmeRbHWnQwngSiTzBhTszvc9LdFXfMDwRWsx+qq0GOJwtLo2x05whe0Z5EjTMDbx8cRzpsgyk029BY5rYpgkZKtHKgWJnTvPgHir+JTR2SM/LGMLXRv4auhKJYsuyDkLIWmHEAWXPfqlGerBNp2Hlp4yzOCg6ARNmrDv0FjqjGFNGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAEkVQOgLdmASNm7gysdfBCID/RcKO7/3fDpSSKyvLQ=;
 b=V+wD1m4qLaE1rI430HG6iRXlEdsMal7Z/Qvou7frfnfor0oRgNUb/WpRNoqdlQBqaZUGc3bu2rG3vdBjO801I6zwGS44pZ2wtWWotLb9ihdoIRYV7j+lcDNDB3puG8ANe/Cz0o/gEjUCOvfY6UEmOuozg9vcN2F//U2Kp7c67xzG/CqnUIu4CuWXiXMczS6G9HzJqiWVtmsdeyiWslHJ99shckaPG06DyDWl8ewbL2PvH+vFjL+IhspxOjJYoSQigl0NzgUQ7rgbIGpv9gL4aRUO+Wqg1Z+UkjNiowvUYvKD3AiwVsDcggAgTE0eSCAnVMmO9XIziX1/vOcVwzp5oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAEkVQOgLdmASNm7gysdfBCID/RcKO7/3fDpSSKyvLQ=;
 b=RyjjBuXFZMqEgTUyh/2Oxo4/AZZUtr8gcK6bibgY3z+V+GFjc598dIN9+rTKb2XcpY100ETIa+SNJZMgIDMRyNVsRsrazsnBnS8MU1aKQtPKqGtaF4FyAq7gGQozJHofuiG4e/ubG5SELHjL7A5e4Gkn886HKnQXdEP3dV6pxEE=
Received: from PH0PR10MB4581.namprd10.prod.outlook.com (2603:10b6:510:42::16)
 by DS0PR10MB6917.namprd10.prod.outlook.com (2603:10b6:8:134::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 14:27:22 +0000
Received: from PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::54a1:30f9:c42e:d74f]) by PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::54a1:30f9:c42e:d74f%6]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 14:27:22 +0000
Message-ID: <d7cb61b8-7403-a240-d2bb-97fe082a10a4@oracle.com>
Date:   Wed, 1 Feb 2023 19:57:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] spi: intel: Add support for controllers
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mauro Lima <mauro.lima@eclypsium.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230201050455.505135-1-mauro.lima@eclypsium.com>
 <20230201050455.505135-3-mauro.lima@eclypsium.com>
 <Y9n9fhc6YbdPe08f@black.fi.intel.com>
From:   ALOK TIWARI <alok.a.tiwari@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Y9n9fhc6YbdPe08f@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To PH0PR10MB4581.namprd10.prod.outlook.com
 (2603:10b6:510:42::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4581:EE_|DS0PR10MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc93601-ed59-4c47-6805-08db04606eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJvVu6PxGPWwuyAD6nIKLmD7izagxiojbCqCy4dbQQ/4SzQDu4nsu6blMcRqvpUxuj9rQveeSB7FaAoVcB7fcRrQ/FtXjHRM+JxPg28sKzGOEYNIV7bgaws06XsLmqhGD1xo2YXAFZ4Y0VLM7SrEH6KcUokaFSIWKQJpw03shXSMeChVjNeIX9K1M3H3+TJZ+yJRj+z3WpS0p6FErcgdJUt8Ie7XUR73ZPDoywcfZlBHQNXftUJo1lIuKc5KxIRP7/WpI8VxK5ekOqOTLFCVQ77TcVwZuqvFXVj5gRl/9AFbGeBEh6CdYDMkzgblXjzEouW0TRNcunEqeeaUVRHBMGWfOdmwrGl3G/9NzjnhRzGII7Cl6w2c0bJ4gHKg8YEGs2BLchVvL0+e+fbGra9YX3yBJa12qjilTArHkIf9AguqZqk2PoGmp9PwyKeDb1TeRZtuFy5RyQU2DzIzk9kDa9zD2ts290nKOMMW4W5bdw9vSRmsWA3QbSwiL9/F+LjZgG8kv4rkpZqfDB1jrVNgWgqok2UrrOsYulo8LcpzgfT84gQol07O7FIBaRQFjeBmQ7TeMwJC/yOe/idadG5P1YqVaFQmIhpUZ6YvkcEDjOgMbbb0a6C5ZfScS+25ewQJr2MdEzf+CKDYdIvR8mF13k2qdMYw4/VJlW4+f3P85KTSUcsn4jKyDDpzTDm+Wwxbl3bRHYorv7dbeuJd5so4VdPi0Zk7Empoaq2sR5kA3Zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4581.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199018)(4326008)(2906002)(31686004)(5660300002)(110136005)(6506007)(31696002)(36756003)(6666004)(8936002)(66946007)(186003)(2616005)(41300700001)(26005)(6512007)(66556008)(66476007)(8676002)(478600001)(86362001)(53546011)(6486002)(316002)(36916002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdKMDQ1S2JvditKekViTDd1MXEvOGZJODduYkNoTUVOK1VwUDNiTHpsVDBi?=
 =?utf-8?B?OTFsdE00ZmloVWE5VmhpN1FSUWZ0Y3htQ25qYlEwTGsweGxRd1ZJYUtWUjlF?=
 =?utf-8?B?N21UK2MzVGIva1QrWk5vMkpQZ21YZ3RlL0NXemNhVENPMUVHVERqclE1WVJ0?=
 =?utf-8?B?ams4RmdTMFVoSXd0eGtodkV6L3JDSk1pUko1bnZpaGZXTGhKcWZ6QWVzNXlu?=
 =?utf-8?B?VkI5cW5DSVZLNjd1dmhXVkkwWXFIQzV4MWNhaVFNaGJHMDR3UDVtMkRNaUxW?=
 =?utf-8?B?dS9TcE51L2NucnVORE1kU0wxRXA0Szh1NncrTUdldVpkUVlDaFBTbzI4WnpP?=
 =?utf-8?B?K1NScktONS9XVWREbzRNMjBLejRoblhVMzluQ0dOVWdjdzh5bmZJSVJwaVkr?=
 =?utf-8?B?dE1UU3pFM29qaEZLOTQ2ZUhjL0ZwSjRaZnN5bk45S0FvVjBjdkJZV0hhMjVQ?=
 =?utf-8?B?YkhMUnM5NFliQm9KQ0lyemdMWGJ3cGEwTXgveUpJeDYxZnM1VlU4dVh1NGJk?=
 =?utf-8?B?ZklDeUJ4YXBRN1JJN0dka3dIN2EvV04yclZHTTJ2TkV6RUNNTU5aaWNtOGVT?=
 =?utf-8?B?VDVjL2RqRGdtZ3F5c21OdDRtcjNkcFhlWmxVK3hudGp5L0lWYTFFWk5mNW1w?=
 =?utf-8?B?R2dJd0RDMlJscFF3QWd0Lzh5Ylh1Mng0L2ZFZzV5cC95S2p2dFdCMGtXZkpF?=
 =?utf-8?B?VTNLZ2pjKzk3SmY5UFNUSyt2TGxvUnA0bkJuMGR3R001QkdDRVdNN0hsazdU?=
 =?utf-8?B?RDdLTk03c0VQcGxWMmxQVDdGSXBLTnQ5MjN5ZVRmV1NyQjViVml4dWVrNVVW?=
 =?utf-8?B?VlhNNmZ6dUVmTForYWVmMHl0RmZ0Z0hSU3pGSFd0Z3pRSjc2ZlE4RGYzME44?=
 =?utf-8?B?OGMvRy9mQXFQKytUWTRmNlArSmZtcU9BMzRLek5UOVJLZGoreEhNdGhiR3Fw?=
 =?utf-8?B?R3RHbDVoblNFc3lEYUdEQ0hSMHNWSnpoWENVSnJ4ZnY1TFpNeWthZVM2ckFV?=
 =?utf-8?B?Tms4b0pKK1RkU1BMY3VBVWM0WEhHQThJdHhhaDNJUHU0UmpMSVlkdERheUhY?=
 =?utf-8?B?S3NDZWRRRWViUmJFVjdSa2VBSnp4SzFjdndWdnVldDByaFdZbk5Za2pqRkVq?=
 =?utf-8?B?NWJHSENrVjNsWFBjYnNJOGUySWJLN3p6RmtEYnJ4S0YwR3g5T2l5M05zTTJa?=
 =?utf-8?B?SVpXbjBCWGlpZ0dXNW5QQjRFb0hlb1MrQmFqcFNoNnhNMlV0UXJIeW9SSGRS?=
 =?utf-8?B?U2x3M0Z0SW5LczZBR1NDN2JMYkZmeTVIbG5FN1VkSDdLQ2pOSDgzRXg1MjlC?=
 =?utf-8?B?YUVkQk9sQ0ZvSldLUDhWMHpObUhtaWtySUo0ZkFYRXYyaVM2V0liZ21BUHdG?=
 =?utf-8?B?YWF1WGsrMVhkWTVEVjVhb2Nhbk1hUFA5YkJyUFhyNEtOOVBCT21nbklaOEpa?=
 =?utf-8?B?RkpCNS9EdGFObnhvZmdXM2htbDR1OGZwM1k3UytIazhtQy96QzhKaDhuODFr?=
 =?utf-8?B?V2puWnpHcnJEZ0NMbU5VNjgrOWErakdTTkZKY1NzZ0JkeVlQL2R6MWhFVFd4?=
 =?utf-8?B?ajRiRjRFY0JEZ1FRMVlrVTBjZk9GRlhmM0xQTFBISUZEZVpwMjhKM1AzaFNT?=
 =?utf-8?B?ajNlZklPdGVuVktLeVo3LytRbVBCQjBvdDdyUjNQQ2tZZWE5bmdwaXZ0V3dK?=
 =?utf-8?B?YTlFUEw4SU5ZeTJkWUlYQXJ2RjU1aEh3ZDAxYjhRS1p0ditHd3hxSjJGK0gw?=
 =?utf-8?B?MlcvNmVFYmlwSElhN3FsZzA0UmZuY0J4T1p2NFRxQktySWZiQjMwNmlnWmdp?=
 =?utf-8?B?Y2loeWQ1MlU3ZTlzK3pzckxLTFFhdEVzMXp3SDdZMHZXNUczWXRSUHl1bXdv?=
 =?utf-8?B?RlkwTDNwUFhFZFNVTU96K1M3bEVDcjYycG1WR0xGS1lxUzFKTzRWZ3Jsc3Vt?=
 =?utf-8?B?RzJLQS9QcC9rUjB1UmdTYkFxQzJvQlRJSnU0OFk4TDNTWjFxUmRsZmQycEFi?=
 =?utf-8?B?aFRiVXQwNTNVMG02c3BvMjM3ZzRldmszbjRWdDNmSjhqNEREU2FUcWhTTmN6?=
 =?utf-8?B?TVRCOEdtamNmNnhGNm9VbWNSWFI4UkpoMHhQbHpRakluYkhGTWtjWUxaa003?=
 =?utf-8?B?WlZwL2h2N2NYVXhCNDJyMDJwWTcvU3djblc0d1Jhb3BGa1hscFpacG1aaldx?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5Q7oC/Y3o5Q5m8H/SvSgPxj7wQY6t5IwEy08mwGPPa7kVDq/9Gh15EdbeE/B+f9XwZGVMYkKQWj+u+8KsYkmZKByDDhUcVpSAonLctRl8pFVFBQObk5pVqZ6q9zGiSc+rAaHY8/h21tCAA+T78NTthqu/7/7UvILH/yRxx2Tj1S5qpxFPavmoWbnmF4PwlH3CcwQLRyM990aK7NVNFVDXzpfIitsGwYptl85SDdtz4xXvnaiWaDEpNDZrvvELZpi02wz+QUC+P4+3/0jV2JI7CtHH+tE3tnl5JogfH3fIfHf9MRnMb2LMYNY1e/msQo7KudXjC1VBOuUp2ODhmRiLPkH6h+SgoNWNubzI0lbRm/3RNiatTwa9quKsMhkyx4WsJyvX62mTUjopXeLakbxy/Vp9FXmceb2itnf3C1lq4rUHZAkIUurJDXNCmFYxvoOFnT412YkzwRLNVid/cIk6UX6A7jXNaq0/vvWIHm7KmK6ee42FTqkB5uhdkMxHMBjylz5Ur35djB69uDV1TvEJUXVmtxMtzDQgkCbbF9yunSKdqfK67WACOsHLFNICtRlGrLwD5HD3RVtTyvTm/NAfwKT27NFQXMwXq/ntedaVr6QT1cOklpljNjK6PTaAzl3jakjNtcujU+MyJ8YNj817QBWPvJgy0hYPeVIQJGdtlaBh9dFGfWXUkZtEwVYfzAvmJ65bG7HOCdBLuVzdmkz1wMCaT4OraiSb7b4k7g4CLiNjOiE6CrRnDZvjB5+rbSaQ/XdcN4RxMPBe9ubb8vlWp3e1wtn2d79z4eG4iSR/otDdTaZn720+sHR8sS8DXrnfDuo9+dy0bME2UpuZjXEaB7X7x7X7jn5Ztm0wPsVBaYg8Pia1JuhOKzGUIzt0EeM
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc93601-ed59-4c47-6805-08db04606eb5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4581.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 14:27:22.7261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2JZBgO0v/WuSei3fZlDTTd5PPsGoApbbFmSEYrrHC0XCLMwQvb7BC9fDJvcD5n+0OBQSUklbz+puE016im8DYMMLk/tlj/M8bJAkIe5Vho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010124
X-Proofpoint-GUID: q88foieltFDsDiaRy-_SM9Muxm9NWK0i
X-Proofpoint-ORIG-GUID: q88foieltFDsDiaRy-_SM9Muxm9NWK0i
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

9d24 and 9da4 should come after { PCI_VDEVICE(INTEL, 0x7e23), (unsigned 
long)&cnl_info

and a2a4  should be after { PCI_VDEVICE(INTEL, 0xa224), (unsigned 
long)&bxt_info }

Thanks,

Alok

On 2/1/2023 11:19 AM, Mika Westerberg wrote:
> On Wed, Feb 01, 2023 at 02:04:55AM -0300, Mauro Lima wrote:
>> Add Device IDs to the module table for the following controllers:
>> 	- 9da4  Cannon Lake 300 Series On-Package
>> 	- a2a4  200 Series/Z370 Chipset Family SPI Controller
>> 	- 9d24  Intel® 200 Series Chipset Family (Including Intel® X299),
>> 		Intel® Z370 Intel® H310C,B365,
>> 		also Intel® B460 and H410 Chipset Platform Controller Hub
>>
>> Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
>> ---
>>   drivers/spi/spi-intel-pci.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
>> index 10fa3a7fa4f5..ba08f64e56eb 100644
>> --- a/drivers/spi/spi-intel-pci.c
>> +++ b/drivers/spi/spi-intel-pci.c
>> @@ -80,6 +80,9 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
>>   	{ PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
>>   	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
>>   	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
>> +	{ PCI_VDEVICE(INTEL, 0x9da4), (unsigned long)&cnl_info },
>> +	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
>> +	{ PCI_VDEVICE(INTEL, 0x9d24), (unsigned long)&cnl_info },
> Make sure these are sorted numerically.
>
> Otherwise looks good, thanks for doing this!
>
