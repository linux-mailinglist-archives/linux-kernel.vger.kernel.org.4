Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733226C6D60
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjCWQZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjCWQZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:25:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F40810F0;
        Thu, 23 Mar 2023 09:25:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NCxB61009946;
        Thu, 23 Mar 2023 16:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NUMlcVpk/E/wEldmaJ5Jp9zPob+olH3AyY4aEH8mcCA=;
 b=I+/xz2WLxIU1g0g4tn454UMetzkmcEnq1R+oKmsjtDDoB2xItsfwDZB8IuKkykDBzhuE
 AfQlLHxkfENgS77iYeRuDzlSe8Izyva/llVXzb+lmUWdnPjYWMX95gsY0cuP40/euWcd
 Cyo1GMHwlEGLoIZKFv4D6M8N2x5fOKBjGowEX9sx6Mj1+M39ykWLGddebndGVqTyIS7i
 PtODLBLsW8t+21B0YsTzrXWS30znA4lD/iMqpTpXQ5Fzdagf/Lvn1vb6kEIaIeGmvIKB
 2zHZxLZRWrTvNqlK4vDhxhWIHs2cVkMTRsA9gY2/hOXsqnDkQnMPX7FFCWYrnzrop0IB WA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56b45wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 16:25:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NG9liQ008129;
        Thu, 23 Mar 2023 16:25:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgt208v7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 16:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYu2lg8NfY/hALN6xoESK4wm3VtYXKEPvGjsSxeWkbF+SHuuoo+WYzmENbU5f9c4Hf3tNoUQOqcj8tIhDxXaAxTolEYGnypwwkL0Isyo2AbKEgJMMKG/8U3jNjmREtdkIX0BH+Blx2QxyJCJQvOY/SphEg2y9mv6S652SSt/O9PKioj/6gyDemeZdsnkDcECL9DK7WIFAkp8MTxLAHX5Q705zuMqIXb+4TOgoO1Zxk/pSqFrd3XW2s+2I19mMpdkN8HVDcV3PnpMVyk7Cv7qjxiJ+A1m2I2a+HK/qpvd4IySihucwI0fjqTsmIEXLU5oWiyC49usJNQQqISi72ZZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUMlcVpk/E/wEldmaJ5Jp9zPob+olH3AyY4aEH8mcCA=;
 b=OqQexbrcrUPT3DEKr3NE2fJmUynk58FMqaTfHqUxTKWoFMvz2e6peyHMsslBjw4EUUPiNDfoJVlLxgB8yFL3uJKP5QWQpvJgUMGgziTzdKEFyuk3WnU3r4yIl+fGrKOgVw3+p2Ur4jFA33eLupIvukOwVgzwMtrZ+79ZwZk6djIjUgLshftOkQHDU12eGrHFqk9I6//sy48XhHlq5PdF6jDz6rw1IVvNM6UcOSAQxvXGhlarGlzSudQOFrvydW4k6U9y+Acx2QfbPl13p4gGxTT2q0Q213Q+UcMZU1F9AeXMTk1hY+2GgCYrStMHiL12JOdNkx8xmg7Sap0U+BL2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUMlcVpk/E/wEldmaJ5Jp9zPob+olH3AyY4aEH8mcCA=;
 b=M/iuOdVXh/F5dD5h4O+ZyVH79JT/2JlNqHhfu7WgRLaXCKWZnlyv4k33VH6AYfiFr9PIOU7APFMoZ/U6SC8G2rFMW2n1LOpi2fK73ixRxlY1pFoOrAHwqTWcJoO1idB3voQNGjWDe5QL4Fu+Gg2WaCMCUgZODiFnJj4bQEXZeZ4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6368.namprd10.prod.outlook.com (2603:10b6:806:258::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 16:25:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 16:25:16 +0000
Message-ID: <750a4b24-6122-6faa-fed4-25e3167ea376@oracle.com>
Date:   Thu, 23 Mar 2023 16:25:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/5]scsi:scsi_debug: Add error injection for single device
To:     "haowenchao (C)" <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linfeilong@huawei.com, louhongxiang@huawei.com
References: <20230323115601.178494-1-haowenchao2@huawei.com>
 <b5f8240e-f46a-b83b-ed16-66c2d8c5571f@oracle.com>
 <c9d213e2-5ab4-0db2-f87a-247519debbbb@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c9d213e2-5ab4-0db2-f87a-247519debbbb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0266.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d71048-84fa-4f8e-3404-08db2bbb2f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCU0Fikcx7n0SEuuziK3ITpDBTsR4d6GZgbvUs1RNO7OTlsL6F+Gi++TdRWMr8J/jXtWvClKBI7V5VkWefVN2NearRox4AhF5HKsoNpRoFWlOVf2nAC7tVTf6DnH3fGYw/dv90FZOPMt+L9Sav6S4/3bUv2uH6cBSGuGNNILBR8tQFt5h1SxO1DdhJrPP/IDbyyyqO+hSJphKL+l3VQDPuuIW8SNB/u8XhQtLNuxwUhJUpEahLBhnJVA1ICUb1vhDBt9i4bWFvwpjl1+HhwNiuS5+1Rb31cVSl/oNsvPH4i2GeXRXHHSdrUUWRoGT5VPNic+0TAtZcQ+fkUG24Li8YBvZGcRdxq42CekHSm+GXJOphAdJvlZayLUGsmJWzo+zZz3+U4rI0wS+/zz9uP0qSW1HTJmnOxtdmazZpyiC5qjA83zprh+9U+ueqAi15QYVvY1STMbycf2r214xID+7TiF9UQCxSUW85AtaLt9S/egy8mDMsjqUHiNM5bZ7DsGYlk4MkaVr/hUhsZHO9IJBRtHE5CTpB/gl8uzVEtJTvISzQqA3yDc6WV6qh69lIpoHuXwJ73hdqy3KB1MnQPoKX1cBplz4poiRdpYO2rUxvYtjes5y3bKQKxeygSlrXYjDznRjb93T65Yr4ytv38TxzdK6oatDT9z8gbU+emR6RXUigzGBIDh/yJFp+SwLbTmlkZ9PT4EDPIhPtCF58byYw8zL4aOdTiAyDN7fXwNQv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199018)(31696002)(36756003)(86362001)(38100700002)(4326008)(5660300002)(2906002)(41300700001)(66556008)(66476007)(8676002)(8936002)(2616005)(53546011)(186003)(83380400001)(6506007)(6512007)(478600001)(110136005)(316002)(6666004)(66946007)(6486002)(26005)(36916002)(66899018)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sks1T3gyYU11SHo4YlY5SFd4U0U0L0VRYzNzckNWczF3Ni9MZ2MxNFFkQU90?=
 =?utf-8?B?VGJFRU5NOSsvQWduUWp2bFhvOEc3NTk4Vk5ZMXB2QkdkWnczTWR3NEd1VEFp?=
 =?utf-8?B?UkJBbUZGUFdXM1ZrL3liOGxOZmtkQU1lU1IzSExMbWw4NEJtRWE4WXoyOHZY?=
 =?utf-8?B?Ry9Qc0xBSkI5MURPSGliakQ2OXExamV3UGpxSnRlbXQ4SVAwN0xHNjhKWnlr?=
 =?utf-8?B?WVRnSkRIRzI2Ui80Y3RWMHM4SG9wcjJHNE5wWWMvUXR3b3NGQ2RkMXBBcERo?=
 =?utf-8?B?RHoxbmpTQlZOSTBROFk2MFYxMFpsNlExUGN2bWF4M1ZtNEdMYnR5SXlJVGVj?=
 =?utf-8?B?ZERMMVI5d0VyRmRGOVltcXd2Mzd1ZjltSFN5SUxteTh1bno4dGh4T0pZQ3Vq?=
 =?utf-8?B?VGVFaUtCNW9rblUwVlNJV0FySWhIekNqS0NUSnc4dHlOYWhyL0xSSVFUbFNi?=
 =?utf-8?B?cmRHZmYySDZETW9yTitlVWdQbzN3T3l0eWNBcHNXL1FicExGVWQwSVdVaTBN?=
 =?utf-8?B?Q1d6YmxpZHhJUjRrOHp4K2l4RFJSam9yVk1sN3MyS0hYYVVRSGIxbnJBN2tp?=
 =?utf-8?B?RGN4emJSNGE0N3kySGxUZHgzNmhUcUNSdkZteHFzaHpBWmR4b3FGTTRRWGlh?=
 =?utf-8?B?NURGZ2R1TUs2bDdhY3lQUUI4QzB1Yy9SR0g0N1I3bkhkSW9zN1A5YzlMU0h3?=
 =?utf-8?B?Zk51WFdzRnA0K21LMm56TGZVS1JKOGozUWgzUFY2bWgweXgzVklCTmVrS05J?=
 =?utf-8?B?ZTNjcXZaV1pJYlVud3lsOGtzZnUydk9uNmxybS95ZGpINTM5eXNmMVpXUWty?=
 =?utf-8?B?dUpHdHd1TlJvcmE3dmdRcmtIY29RRkVhR01DSkZNWTBzVHZpNFFRcVBZVkNU?=
 =?utf-8?B?clVwUzIzSi9vWHAvUXQ1ajRrWFVCdGFsbjRzbnc2N3UvdjR5UjJQYVpEai9N?=
 =?utf-8?B?eGVjeW5MZ3FMN2NuZjg4T1pYbXpJY0krQzYzVTJPcFJlWW5aMHNSSEVzU0F4?=
 =?utf-8?B?T2ZrNEVINU9qRWlWdnJVQTYxbWRNa3NvUUJSY2pQeEZ6c005WHRETVJBTVFG?=
 =?utf-8?B?S3F0NjBtMnlSVSs2OXVZbzBNSUZBcGZqbWYvN0lFNkZid25CY0N4cCtrVXIz?=
 =?utf-8?B?MHNkMS92VjFGQmY2VkZ3UTkrNWQxbUJGaEo5OWlEaDlJbU0vb3VuM2VMMmFl?=
 =?utf-8?B?bTBGL0x3UC83cXJ2bzV2T3oyeGRDdFRvS0lzOVpjSjNhN3lMQnh4Q010dWJ6?=
 =?utf-8?B?VzNKaTRVZ0lPYmZKaDY0OCszb0FQYW90dnBVMy9DS1dGaHRjSDQ1SlY3bUZt?=
 =?utf-8?B?UFhmejMyeXlEblUyZXVTQkE2TlV3UHVHbjFjUWdIcERSTXVqRU5TdU1lckJz?=
 =?utf-8?B?ck5hWk9Ga2NaVkJod0ZyM2pQMUsyNHo1RTRoY3h3TGZGcytsTm12Zkw1dUI5?=
 =?utf-8?B?cStHQm5rQ3BVV0NnMUxFUFEwUFBpZUttbER6R3NoaThQejBoY1Nwbk1vbXVC?=
 =?utf-8?B?SzZnZXR1M2dVZ3dMR003VDRlUmhxQWVTaWY2YUZiTG9CVW9OSU92dWYvWEhq?=
 =?utf-8?B?MHhUa1VrUDlLV0lETEFuelU2Rk5YNzRaOEw3ekovZlBtOXVsS1pKZjFiVEc4?=
 =?utf-8?B?VkhTYzNrNjlQWXI0YlFFYjhmalFmd0Q3a0R5dEF3SW5HTnBiZHU2aGFla2hZ?=
 =?utf-8?B?ZnJmbEhIaHcwbmNNNmtWSFdIaDhEdGRwOWQ4UDArdkZBOWJCQmtCbUxCbzhi?=
 =?utf-8?B?aWQwTHhkOTRVTTZrSnFOa2pXZ2VxUFNOYjRlOEdPSldmd2JxYWN0cDhQWjVG?=
 =?utf-8?B?eVdhbitWdXZCaVdmWkNrZmRtRkZXTHU3M09vZE12VlBzWlozL24xNzRkMFBh?=
 =?utf-8?B?RndSODF5R2Qrcnl4RmZIUkNMZGNWOGsxR283ZXJlODl4QzlmVXo4bENOMmRi?=
 =?utf-8?B?a0xwb1hlaFdOQ0Q2cm1WcGFMb2VnYjAzV05ERmxrSE9IVnpDSC94aExGY3Vl?=
 =?utf-8?B?cm9iSnNSSm9MMjY4dlJZWENHNjAxRU9qR2xzWmw4MWZnZURmQTlCb0I4M2Y4?=
 =?utf-8?B?bG9IUzdydUV5UFRSV0dhMktINDJhVnJrcHVubHRORWg4QmU5U3gwSzRPVC9s?=
 =?utf-8?B?bWxkMWlXcU04QnJBd2oyZHZOSDFJQzlvaHM2WnJ6NXlxbVc1ZUs4YkJ4U1Vn?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DcgDOrJuYK0a/20NmPdFOjoXip9MRZ9q++g4Uhuj4JFXXwWQPl6u0iKBG2BvISwObIX21gONuogSRqjbsJF2J2+g16idGnzvzn5lu0HOt6PhO+BWMVHwKG07sAjMmMak+swN6aa8axDZJKjmrt04i6Sy95GARx97ts0j0lmmbUw+bVO8JEA+3oetK0FlL5mgV+9ghL3/+idh/GAG7ZkYUw3JjORQrUYkc0qF3yqMWdP5g7LRZ0kK3OZpSkyKolaf/dsFl+fqxARlQ0tcWQCaiFMMHOQ+IxdmGDKkiDEupYymCllUftc9DadZ0gvV7JwDGXBA0cvhiVBhvP9yZIjHfCg81GNM40LV2yu+OSwpYJQA2GBhNefvMxVOImViCaElc53HHmnMdPzVCLhqefv3hEG+BJnOqRWpMTSF+tmOWdb5LHRd6DSasNUvGwjyRuLB8FhBPqcLNTNVALwf2+eYcxA2wTssHvCWWKRvFKEehQEMB/kFUWH6rA0dQbH2VGVfW8+t+rcuJV7VFXmxMUS2g0g/2tzxTDItIvuN7mREH6DzjrXcCpgRgQPapcnn4MEAP3Om8hFd4gcv/Fu9xMGlD/HPNicFaQsI7JMzZDsSBqpEciBeoTRam3+/ARkmJztHpZeRqeobKdxkReA+s6cv/wqGMRzTtfpdI8Rwr7YqDMHc8OE5wPxkLV3dg8Z1WjRQVKTgETiKUvvsih/9ENW0mrxlLANCMD2qammUJg+sdngVQcCX9AjA4Gn87GSASBpFqM5v7FhCCTvHsyPOoWLrY+Rt1nW329YOKAX1YZmFFHE5ax/0unHZ8xA2RZTW/IkHAhSOr/MEdA1nPy1sr9k/oqjyz6MOIO0b/2f2D2HBaGg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d71048-84fa-4f8e-3404-08db2bbb2f83
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 16:25:16.0782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+zIaYL40FNmDyfbwTAuVDmeXwbGH4g7viqRicMOkW7ByDowPxqsSjDwpBR8Tj5XWdBjPWgY72tFut40dKW1Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230120
X-Proofpoint-ORIG-GUID: wmoDutSEzIAxX_7R8dl_942PcFJCA_Mo
X-Proofpoint-GUID: wmoDutSEzIAxX_7R8dl_942PcFJCA_Mo
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 13:13, haowenchao (C) wrote:
> On 2023/3/23 20:40, John Garry wrote:
>> On 23/03/2023 11:55, Wenchao Hao wrote:
>>> The original error injection mechanism was based on scsi_host which
>>> could not inject fault for a single SCSI device.
>>>
>>> This patchset provides the ability to inject errors for a single
>>> SCSI device. Now we supports inject timeout errors, queuecommand
>>> errors, and hostbyte, driverbyte, statusbyte, and sense data for
>>> specific SCSI Command.
>>
>> There is already a basic mechanism to generate errors - like timeouts 
>> - on "nth" command. Can you say why you want this new interface? What 
>> special scenarios are you trying to test/validate (which could not be 
>> achieved based on the current mechanism)?
>>
> 
> I am testing a new error handle policy which is based on single scsi_device
> without set host to RECOVERY. So I need a method to generate errors for
> single SCSI devices.
> 
> While we can not generate errors for single device with current mechanism
> because it is designed for host-wide error generation.
> 
>> With this series we would have 2x methods to inject errors, which is 
>> less than ideal, and they seem to possibly conflict as well, e.g. I 
>> set timeout for nth command via current interface and then use the new 
>> interface to set timeout for some other cadence. What behavior to 
>> expect ...?
> 
> I did not take this issue in consideration. I now assume the users would
> not use these 2 methods at same time.
> 
> What's more, I don not know where to write the usage of this newly added
> interface, maybe we can explain these in doc?

sysfs entries are described in Documentation/ABI, but please don't add 
elaborate programming interfaces in sysfs files (like in these patches) 
- a sysfs file should be just for reading or writing a single value

> 
>>
>> I'm not saying that I am a huge fan of the current inject mechanism, 
>> but at the very least you need to provide more justification for this 
>> series.
>>>>
>>> The first patch add an sysfs interface to add and inquiry single
>>> device's error injection info; the second patch defined how to remove
>>> an injection which has been added. The following 3 patches use the
>>> injection info and generate the related error type.
>>>
>>> Wenchao Hao (5):
>>>    scsi:scsi_debug: Add sysfs interface to manage scsi devices' error
>>>      injection
>>>    scsi:scsi_debug: Define grammar to remove added error injection
>>>    scsi:scsi_debug: timeout command if the error is injected
>>>    scsi:scsi_debug: Return failed value if the error is injected
>>>    scsi:scsi_debug: set command's result and sense data if the error is
>>>      injected
>>>
>>>   drivers/scsi/scsi_debug.c | 296 ++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 296 insertions(+)
>>>
>>
>>
> 

