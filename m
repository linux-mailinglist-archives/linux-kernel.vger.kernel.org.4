Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB6C694C80
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjBMQXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjBMQWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:22:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896CB1E2A2;
        Mon, 13 Feb 2023 08:22:44 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DF43Nm028366;
        Mon, 13 Feb 2023 16:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FDaTDQg1rW+LlgrMINWC28sg8HDQb4nJuGCyPqDRVOU=;
 b=EoIcTlieiokfMGyczBh3nX1a1mmH1pgJ0AbhDcYgsCBxuPXNuPF0RPaJ4vkNErvkKffI
 IZc37UEIGVzgzxvGyhrHhYDM2XZlOUqUPAz43tG96EEPBuQ5MnNXXMiyu/m6M7ZsSWSz
 q89FXmAxML4O2FxmVB0fp0E+2CjiH1h0dozikg253fxFJqT5X46somrxhI9ChLeo3nFm
 nvEz0XVfmK7Uooerf6aDeFf6imlvhg69TI47jba+VTIBqv4G6CaL/ONGKTcbhs6jjN7z
 ug1b/RnVRW4Aju/HhzGiD8XIw4Ux4caG2Lj6eAaI1EwpC57rwFXjMdvhFnwdM4GRCWdo TQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3jtu5n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 16:22:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31DFFfk9011554;
        Mon, 13 Feb 2023 16:22:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f4bcxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 16:22:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvkiyiwX6jl9cFeb4YljQlvozNQa2FQE+SEr8vMM3DwbWB9YyWWwlmlu1k3hcbsotTzllW7P0JRkRMwa8mUzDtUecT+PBrSGMKv2W/KWHEIszPLMOgLWz+0+sdqzMq5WuYcmyXVzRJL7goEo80TBLQyx0IlPQKxq3xmpef8jggmy703qr4d/Sr8/qzOiKWvIg2YYnSdxlAwFzd92ndQpjcD52CcRAl/rMt7Ei5Ac2liYn5ky9Rkjazm1vGzHNt1SMboxpPMAkgo8cx76le/EZwQjlRv+lxkzjdGgSrdyPs7q5q+aa+HcgXgt5mU3u3ocMCrpE3bsYGtKdbjj68jpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDaTDQg1rW+LlgrMINWC28sg8HDQb4nJuGCyPqDRVOU=;
 b=MtImgdqMIlaLV0EnOueRyFZsNN9icm3808EvbHItJbE5CW+Aej13BkzWFpObjX2MArrS5/zt0Vo+AzUUIzE4XeNGO+BzFlrSJtXub3LoIYHI6rJQ8/RfOjP1LUcDpif7rDveE1TNsuxfw9aYpRFHs7+oH7or/bLWFVUMnsjlJkwy335NwweU0zRWVP9LCzaydKFoWht/cmcZwfbsKakz+9VG/GDDro21CZis/3+N1nVdlWa5nBoHUu7nQVg1/VWBrFd5koHtbn9q0j/KUy/gErxmp4tyhQcn0nAJm36xZQxalqVHkdfcqbszwNJUcAKXOfzCgj7GQ5MgXg5MYF6vtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDaTDQg1rW+LlgrMINWC28sg8HDQb4nJuGCyPqDRVOU=;
 b=WzwGSkC4cOMaNF7I3v9Y+YxzcYzCy+VvKzHhkJMLhbpiyvbKZQbRvLb0x0RrfQ46i7tBiwvE7GRczUeQuTbhp+6AQisKxKTi3kxXp46N4ozHSxHg+Anjgf1o26hTmvQyQUETPI2FCk1uvqo8tUnbED244USOuusZryy2pgq7dxE=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS0PR10MB7400.namprd10.prod.outlook.com (2603:10b6:8:138::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.9; Mon, 13 Feb 2023 16:22:39 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 16:22:38 +0000
Message-ID: <2fea4b28-e441-6c77-5bb6-97428c19179f@oracle.com>
Date:   Mon, 13 Feb 2023 10:22:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] scsi: target: iscsi: set memalloc_noio with loopback
 network connections
To:     Maurizio Lombardi <mlombard@redhat.com>,
        David Jeffery <djeffery@redhat.com>
Cc:     target-devel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230208200957.14073-1-djeffery@redhat.com>
 <CAFL455kEoLQF+vc2MGmtLdrQ-=U+HJzqgknZmM54iCPJD1p_mA@mail.gmail.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAFL455kEoLQF+vc2MGmtLdrQ-=U+HJzqgknZmM54iCPJD1p_mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:5:134::39) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|DS0PR10MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: a44d79cb-0337-452e-3009-08db0dde8610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96XlKD0u8MdR/KB51lALnTtrduJCsowMjBtK1Zwp7wf8Mw53Bi3nhcS1+lvN7a7L5SLNwWzMBGYfA/FyPtmS1ml1/OyNFZb7ej7Xvrz13ZegiEHVqT12Zu2QtGwo3WtOJ6xsRrtS1QI4PyHpKaw8O6I4N+QUboN6pBdw+MXAabpZt0jB9YZY5RlIYvGUE7QGkuGsSCuOOpM3wa13UnVPrmebuEu8JYFe1mMlpIW9Kl03r/KQRgr0XA6PV/neXPSHZTQBXVNQqLPzHzaT0RraBT42jbFssVLqw930El2MNy8QmKaK9ZuNRj5/Q/RRBawQgZzXBU9mDzolrDWaTmFNlIkCLXqWUGlVsAO3CrR9UtGWtAyuxkhs7UnKmqdY+ZA8U8J/aiFAOm1C3SHFpv0QMO/JlhaG58fqEcv9Ncyx2wAR3j6vFHEhDFE0F6N3uvL1f94yH3+PE5yw9lkpDbQTEGgfKI8jrKfrm567A8xYE94Hw1A62zpBTy90khVjCfMyprjQj9dfaIxgJ8oiVeLPpX8hTEErxpJozERKvX/ubj8qJ3dWKMMQL1zJSnm2zEUGObVqv6Q5JRcEJMpZnN1s9xL+6+wdUZzErgvx1F81K4oia45wOguICKNlN2xKWnFVK+NAbssQpOwDVLWWciGooUZP2d2mw1mzdYnvmGcAMewHbCDnC8QdX202LoFLlEEENBFSwEjqhK2dbgq/8bG+/NPHhGiD0dpqPbZkeldbPWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199018)(31686004)(83380400001)(31696002)(86362001)(36756003)(4326008)(66556008)(8676002)(66946007)(38100700002)(2616005)(66476007)(66574015)(6506007)(54906003)(26005)(186003)(478600001)(6486002)(110136005)(53546011)(8936002)(5660300002)(316002)(6512007)(2906002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZTaGc2MU9TOXJaUmpyL0Z3NENDc3RRbDJ5MFhmcVp0QlAwNm1GbHltWTZQ?=
 =?utf-8?B?UkFkL1NMbkpJd0p3dVgwajYvajBydldWUjYwVHkzV2VxbUlMSDVWMlhiSmJw?=
 =?utf-8?B?L29Ga245VWNyTEgyQ2lMSGY1dEpFRElkNU0yVVBmOWw4L3NqdHhYNERYMlJC?=
 =?utf-8?B?aGp4MEtqeVhSaW5vamkrSVRkVnFiRTdIUk1xLy82d3d4U1Q5QzJ5azc1Yzhl?=
 =?utf-8?B?WTZkRzFTQUVMN0k5MHF2YXl5d1I5OE5KT1U2N3FLTlJhVHpzK2t4OHdiTmho?=
 =?utf-8?B?OENrUmYzbS90QWlkZzNieXdMOE1oRC84eSszVE9sVnJaU0oxb3ZTUy8waWpw?=
 =?utf-8?B?Lys3bEh0Y283NjVGbkdNRHdPT3Y0Wk1QZ1JYRGFvNHEzOWE4TGIybW9jZkZL?=
 =?utf-8?B?UEdmdXYyZTJvRDJpVmtKb1JxNnZuL2J2cE5obzAwRTNwR2hzR0ltT1ZIQlph?=
 =?utf-8?B?VzJFUmdHSUFlVm9sN01tS1lIYWNWc3VoSTdrOTBwdlB5dzhOODZFbUxkWDNo?=
 =?utf-8?B?WEE0allRc3Z5MkV3QW5TbjQwanQwRnl5NlpaaVlZVGtZeW1BdnZCd2xnMGxF?=
 =?utf-8?B?TUZIVWRmUTFsL1hOdVFaZnNRRkUyOFdBUnFYcmhkdnluSWIwMjJiY3JGUWpO?=
 =?utf-8?B?WXVuMUVWV09BYkNvVXp3K0cxVG9UMXdXcEtERzVqMiswUnQ5UlRLWDI3YlBu?=
 =?utf-8?B?bEFtLy9PN3lncWYwaDY1c2JWMnk1RnBMbnhXb3JHNEVJMXdWeWsvT2FUUUl0?=
 =?utf-8?B?YmZLa3RLTGxDZFVhY3dxbzVuWllwcnpiUEVScnVnNG5KM1RocTd0MlB6QXVE?=
 =?utf-8?B?Y1h3bW5yTVNNMk4ydEFGcitGSFJ2K3k1ZzYybE14aDl1L0NtemQ5MHViMEF3?=
 =?utf-8?B?ZXVoMGtOcERvR3NZUGgzY2w0UWdqYUF4N3R1Q1NETlRWVnRUSUVNdmVrRmMr?=
 =?utf-8?B?WVhJWXlMWWw0eldPYW9SbTdaeDhHYXdacmloOXZxdnpGY3F0OGdaU3dHSnFw?=
 =?utf-8?B?dFFRN3RleHJlRFdxY2ZLMzZZelpkRG93UzIrbFduQjlacWxEQ0lNVUpXRXlH?=
 =?utf-8?B?VmtxajJjMDRHSyswZDJuRFV1Y3pBUmdjdUE4UVY3SE55U0NhY3FhYWFYbmpI?=
 =?utf-8?B?Ly94c2tRcGxBclVIVklNQzhMQ3pVWkRYSTlIU0labFlzdEhKcW1qTmpiMThw?=
 =?utf-8?B?b0JoS0VkejEyMURmK3I4OXJ2ZUdzQmpQS0hOQWw1Uk1TZS93TVl1UmN0bW5h?=
 =?utf-8?B?UVExbS9Yb0JYNm9rRVFoSXdLRHhOWEhlQnF6WGZjZDhEWXIxTDZCeUlyS3Y1?=
 =?utf-8?B?OG9FekFxT0c1czc4RWZWTlIzMk5vOE1aZ1RxYTBMWVFhYUp1MHR6clBuSG1v?=
 =?utf-8?B?eThZWkw1VU9scEtaTCtDS3B3RjBRYVdWQzJYbkptWlVhTWRJUEU1azdIT1pD?=
 =?utf-8?B?RVdBQzBsODN3eklBQ1BnUVJpc2UvU1NzVC9rTEsyYkRPbTNncWs4bWNjampQ?=
 =?utf-8?B?c0trY1JiU0VJNkJqTXllMzB6RjA2ZG1tUS8zL3dCdEZabnozZlhDQk5zc1Ar?=
 =?utf-8?B?OUdzL1k5dmo2ZG1IOWU4K2RRSnRNck1MMVlEdldjZWdtMC9nRzBVNHZ0TG8x?=
 =?utf-8?B?eDdKMzNRYkxhVUpUVkRXTVYvakNRSWJwcVUyV2RCcEdrSFRpNFluSlc1d0lB?=
 =?utf-8?B?TE5WcVd1a1RvTFpmM09qNDlhMjhQYityWUxWUTNKMFVWaW44NUpmSFRPVTFs?=
 =?utf-8?B?clFUMUlyTWQ4aHRRRWRRT0hSR3pxNnJXVDZHVWhwS3dxaXZ2dWRLaEVDejNv?=
 =?utf-8?B?cUZnNi9PRDF3K1BuNC8xYU9YN1pkc3IrMHl0TCtQUWZ5R3NETHlqQnluR1pQ?=
 =?utf-8?B?WE0vb1JmRytZbW95b2syMkNPQms2Zzc2Z0pDS2FtbXVSdVVsR0RWL2QvRFN6?=
 =?utf-8?B?S2tsODlsL0ZLSXhoaHdTTWJEMzZSYjNiTUgyU205azZNWXVneE12RVQzQkFK?=
 =?utf-8?B?anhMOCtwMjZVNHFIV0dUUUdWSk9iNHlCSG1PbEh4Ni9KV3ZLOHdnSEhZWVYz?=
 =?utf-8?B?anladW9hb08yTGRQNjN0SGR5T2JYcXVZM2pYb3cyZU93NjVRcHIyMm5IeWpT?=
 =?utf-8?B?M2cwZ3RlL1FTZklZL1VlajNuT1l6a244NjVFczY2U2hseFBlaGJ2QkxTRHZw?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4qnaBjMzIEY5sPfE2jroZqnMkFx/3NyfNkJEYXci4OSmjt5ci4Yi2mYo2bzrILpGxvtxKgDHHPjE8RKVBQ8q130vK/oX7n0JRfZElW/s1XQp60Loi2xiCcVYx2yz4GhUoyeLvR8p6W/OkOx9PFHI7uilAzZ4M3XWGAtVRxQpaCeiTq2/CU6QzRTcghG5aYo9YsrTuitJju3y+L9BdFvqWTj6FgJZlho0lc0bQe+JxTNsWucqAiXeb/szBo9EBy/4gwKXArVmOJu3N0JGflueTWb3fR6rgTa5VKdDzRACG75Wys/kE/TLppMtw0uGp0VIU+92rMcdo0cCsn5Y4xtXGf5UChCPVqlRdecq51jw2KQFWXq1o/nZ01Dj8BIArkp8rLh+OflV4xQrocMo3Y3gON1ccHa0raFWEhki/zRZm7AuO3goeK25IjwalXZ+8sbURnV2nXvxaWQqEx7IWuQI4/i4AMJX78soCZFsQUPZi8nj9iX0hLrgNt38yuV4ENZbQ1RGjkkuemgEbMQXaMEm7VAKiLeajCRb9lP9Q3JK41xZwKSfrDN4DzM93zlMN0Ex/sBDEdcpy8nNu0wrJb8mV6tyqPHTdqCltof6zAcS8Fzv/2A5B62AlkWJDuJCw7P392x6So3yGMfOFQoygcLXw30zRUDG2iOzypN3x8bX3v1sbcUAfRNxbYvn2i4jcHz+uZGghsVHD4vWfigj6M80lDZvA/dG2p6VsG0SUtv4FTiHgJtZbo9BarGfwjNn3aJXHDkqpQFBAw/Umfg9qrbxcL+7sz1dF43M8wsL1eMU8Ik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44d79cb-0337-452e-3009-08db0dde8610
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 16:22:38.8040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUolyhuxv1VchSkuhamsSakpLOPKAdiBEHeav+GBNopTw/BYe5ptGDc8Sur9crYHOHOq42KOX43SeUXEEHvzDA5rFWNfrscMbaNk41o7WTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_11,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130148
X-Proofpoint-ORIG-GUID: 7BZDSNG9MPvZyd1rEYFEDprrZgrGxeMA
X-Proofpoint-GUID: 7BZDSNG9MPvZyd1rEYFEDprrZgrGxeMA
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 5:59 AM, Maurizio Lombardi wrote:
> st 8. 2. 2023 v 21:10 odesílatel David Jeffery <djeffery@redhat.com> napsal:
>>
>>
>> +       /*
>> +        * If the iscsi connection is over a loopback device from using
>> +        * iscsi and iscsit on the same system, we need to set memalloc_noio to
>> +        * prevent memory allocation deadlocks between target and initiator.
>> +        */
>> +       rcu_read_lock();
>> +       dst = rcu_dereference(conn->sock->sk->sk_dst_cache);
>> +       if (dst && dst->dev && dst->dev->flags & IFF_LOOPBACK)
>> +               loopback = true;
>> +       rcu_read_unlock();
> 
> Hi Mike,
> I tested it, it works. The customer also confirmed that it fixes the
> deadlock on his setup.

You never responded about why/how it's used in production. Is it some sort
of clustering or container or what?

The login related code can still swing back on you if it's run for a relogin.
It would happen if we overqueue and a nop timesout because the iscsi recv thread
is waiting for backend resources like a request/queue slot, or if management tools
disable/enable the tpgt for reconfigs, etc.
