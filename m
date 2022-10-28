Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11131611BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJ1Uhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJ1Uhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:37:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F10F236414
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:37:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SKT5YJ001956;
        Fri, 28 Oct 2022 20:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=D8KQT3YuZOp0VW+jKJUgkCPu34p4BvaPSYC9ECjbefU=;
 b=YTTGwFPfS56oxNvN3aWvumunVfXBNLbc//3rveI7Lras/Lx4h0meVZN60yzuADVxQ+8p
 hSix0F0XTdshBtODilH7/8nGyx3LBiDNHSuzr9DKg4f9wXBcMQyiZc0IE9ee2zNLAKXE
 NO03FoqK2SI16TX7N6FFmwQtvI55499CvSR4/CmY/tK8w3x88iBYPKGzJ6lSsFPWmS7r
 THIkllQWv3ZLU/vfV1MZIb/SYOtWRVy/dj3sD1V5MdIDZ0dvWrdd6CEiC1cmmbjDQbLN
 MujNR8I8z8r1V9AClfaRQMOksn+2xPs2xKljZBoxtGMq3DAzcUZBak9G+BHdFJoNWjFS zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0ap2bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 20:34:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SHL1d9017466;
        Fri, 28 Oct 2022 20:34:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghx05d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 20:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OW78XLNipNyl6HIMnC4SjIzB0WXe0vQvZEARlkJUvuTQv2lRooNW63+g9MLCP9GLD17CSyUdvxpZAz1QKqyAjpiEk5IfltiBQIUsMJNTif4xmFBAUCNjsUPcB53imW/2Kw20u4wZs3kiCTR43InGScHLZUMbgNw/nPeTeaBRa0X2t7ApHTpoFVMlAQR7kHf8QFhEOG9qtTusDBwdTy4FTEuQQJI+iphVUZCJI8MjXiTYp/i3vJy5FS5wgI865hgSzKxyJs9RXF3II1CXJVgVRkeYjEjIQNUBV2F1p/N8bIfxCN8TjD+77c0xPe7bdB3GBzpQBTshRQdpM3OHUhq4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8KQT3YuZOp0VW+jKJUgkCPu34p4BvaPSYC9ECjbefU=;
 b=Xhgx97a9jkudhyoOS+im3i/8bWEqWXkD3nWHKpbETBeZI11YCmJ2RZ+OncMYE8yDrHJPVl1fWf5jl4rKYagElTHLjtHDy01La/Ji+/fdVMt9LtWQZwd6bkb5TH46of8CqWGmeW0xjSaKYA21RCqninlhnmrd9pX9S/Lh4ollSnc82pW2IwMp6p6EqVMOL67w58a3Mfu/NjVdpFd7YYSEmWk/NT/ermu9RHMC1rF1wsrkxUMdHCkLDK4Hu1DODMzCm++2VKCtuCspPvDGuO98fD2ALzDyRS7L5YVZxEE9CR/0uNXPEEcPxmBHwdlSFF2Av2Dw8KYH6OJ3NqhCwcbqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8KQT3YuZOp0VW+jKJUgkCPu34p4BvaPSYC9ECjbefU=;
 b=xLoEWA4nZ28yoK6+98j9hfesRtPg4hKxUR7Dh+KawDS0zeYgxv/+a/0O47q4Ti60MjQeBVRMRZ6tQRgiMYn7CzDrC8336jEOeLsUDmEWPEslRUlNprf35v2VoeXgKN98aVKhE7RCHf6XTHG7qHWNIwYYTbyItbdZlpe3VXVD5vk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB6283.namprd10.prod.outlook.com (2603:10b6:510:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 20:34:50 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.014; Fri, 28 Oct 2022
 20:34:50 +0000
Message-ID: <f9a57532-42c3-8c68-bb10-6a9648c93b15@oracle.com>
Date:   Fri, 28 Oct 2022 15:34:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baoquan He <bhe@redhat.com>, david@redhat.com,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
References: <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic> <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic> <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com> <Y1uspLb7fLdtnQq+@zn.tnic>
 <d91f8728-6a63-415d-577c-bd76e69ec7f6@oracle.com> <Y1wL+ZrvD5gTZaKN@zn.tnic>
 <ca43bd5f-8a74-9412-3d4b-52c7d5e54978@oracle.com> <Y1w76RwZUKUvsS7A@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y1w76RwZUKUvsS7A@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::19) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: e3abaf40-439d-4626-7e3a-08dab923dc8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBc7dkOLmecqv3jXi7fMgYA7UNw13lP6w8iP/BQc7WOsswmHlSh8hPb7oS9Y364gbVLy8/k+K9ynl3ZvgUt/LSQ9YSrWbwJoJdqyKB0AJIorKx47cKn8nBJE5ateOX3u4ivIioZOVHGknBV8bhPR4OqXHzYrtRe5i6VaqU91zyQWdiJUAkC0AmRwi7KEv4chjPShU3MzZbdfNl2ALBGlM/71zsJknjz+0oqPC6nrRq6qpA7VVIZcArx45eYNlCRIDOFS6eUo1xO/lZ++SRQXORzyCEe+16q04MBgwyxULt6243h4wFLhVR2LxxMSh1koF/xaGoS/QG52vpuiO/ULDHgYVwGe9pXUtqMj7umvteh3MSDzOp3fbWDSau56TMo1T0eRRntD+To6GO+8DFK9HlzdNrEgpvlK32gRB44bmKh9hC8EkS6zSbn6/+tTEoMdEJHPv1YYfCkLzKJRq834UqhS/oUO84eTruR9psyqKePqddDQXCBWuO/zjkbNnJA2ZxGOjwsXeu1E2n8ISs06RYgBbKo8le0BdgMrabC1ZTUws7/sQG8nugAT2AModykElMAZR8f1sNEDFtOKyGAfk+qCWcqYvmYC9dh5X6huKLmE0RBNKsD6anlC+Gb3b0RUbq3+NzqpCBXEetIbHpd7XgYVuVGHSsOkcXgCAmYwes4FmCbb9fJAX/o3nWAN7FHEEdfOmsIE3t8892EQIRXWSfwhmBMkWyV/ZZMRajuJghBxqSykST5bb7F4Rs6XaIPGl2EBwQlPdmVd5WCH49rZuexYvxD/sx6u0/zzB9wu7PY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199015)(8936002)(8676002)(66476007)(66946007)(4326008)(66556008)(6666004)(41300700001)(36756003)(2906002)(4744005)(5660300002)(7416002)(31686004)(6512007)(53546011)(6506007)(2616005)(186003)(316002)(86362001)(54906003)(478600001)(6916009)(6486002)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2RZeWp4NExlTFM3VEdjeFF2elh6SHp2WEprUUlROEU3THkvS2dxQ0k4RnBn?=
 =?utf-8?B?eHY5ZUxCTVVTUzkxbElzWW5YN0l4YnNhN2JRWUw4ZFR3Tk42N0NDcUdLMWlV?=
 =?utf-8?B?ajY5MnpFZVRRcGpybjVzYkJnVk5nQWxxaXVDSTdsejV1VGR5NkZRUDBpdG1m?=
 =?utf-8?B?aU95a1c4RW9NTm53WWtGRVl6MnBEL0x6NmhVeUs2ZHNEckR5aTNjYTU3Vkpx?=
 =?utf-8?B?c2llZTJNMWJEWVphLzhIWGo0N0QxYTlHbW5PVkp0b1BaMVU5THk2b0VoM0pj?=
 =?utf-8?B?R0ZhNldKUHNLNHBaeVR1dEJXZGtodSs0b0pzZWRtN0dqOWdsMHVoSThKeDFy?=
 =?utf-8?B?eVlicmJLRXI4WDdvdVhKU0xvM3ZBL1pFVGxEdHNvSzBkZnViR2E1Y2RuQVg0?=
 =?utf-8?B?OUZEQ0lqRnMxRURXZUF4VllqOWIrdHk5UmlTVzYxRFBmdTV4MjNOcndnQkgr?=
 =?utf-8?B?eDk3WS9zWEJiLzVtbFdEUXVvWEsxaG1tdG1SZC9rNGRUWEhEV3BYQUZ2TzJV?=
 =?utf-8?B?MlFUZXQwVU1SUUdGdGFCWUVoVkswb2N2TWlqcWxRTzc0R1hkbmhkUlJ3VUFL?=
 =?utf-8?B?VjM5RXlEVEhuNWtxNWNSYzB2M2laeGNJM1FNWUNSVXl1OEcwZVZ4QjlYMFZy?=
 =?utf-8?B?L3orQnA0T0g2blNuZlFqZGdUSDBPalFQd3VRdWt3OTZmR3FXQytVTDNnNFkz?=
 =?utf-8?B?SnV4TDVUMXJ2d2xIRGRKQWFGQnlmK1FqUDdhYXlabWhrMlpTVWVDclJuSUpk?=
 =?utf-8?B?Z0EyRWF1cjZJaElKVkNmYW1Nb0EwR0hmOFBIN2thZ3Y5OC9RbkZZbkV3QTRa?=
 =?utf-8?B?NTlmNmR3OFd2WXhrMk1pS2dnRkJRZ082SVZKeDAwaXhvWit3bHExODdZSnZ6?=
 =?utf-8?B?WDlwSGJYZ2R1MlFNMzNpWGxpNlU0ejFDWXJSQjJKcnVmWi8xTUs3SGlGMVVu?=
 =?utf-8?B?dWllR0NQWFdpRUdoclB1UlIrNWw0YW9KbVNDU0o2RHdBamp4OGJTdFh5T1cz?=
 =?utf-8?B?ZXBPN1lKc0s0Uks2N3BuQXE3MnpDd3J0UXcvNUYwcUQ4SEx5Y2o1Q1FJTk5r?=
 =?utf-8?B?UnZBOXBkajIxVmg2ajRHTVdZZEJSUEdYUnRIV2FvcjArTTQvbmRabmtEdkNK?=
 =?utf-8?B?dVNhbFlIaGt0WjRCcWJPMlRxMjlMME14Qm9SSmxoQVBPK29rYzJrZWJFdHN2?=
 =?utf-8?B?WFIzSjh5dkI2RlFEbHUrajM3V2diakVQS2dRWDdhUlRCZEk5bWlDVG5BMGlk?=
 =?utf-8?B?RGtRL21MN2lxMWtma05ZWHEvdWVUTWhXM2xmLyszR245Vy9jbEFyTTlteHdt?=
 =?utf-8?B?bjZ3ZldUaWxVYjhLcTJ2UFRXRVpWSDUybUo1RzNUWWhvK0dTNTIvZG82UEZk?=
 =?utf-8?B?WXV0WU96aVdheU8vbEZKMFlhd2R5MDZmcVllUExtclFGN2tyWmFmd00xZW5S?=
 =?utf-8?B?N0luNzNXQkEwK3FXa2s5MHJOWWR6MFlpRnQvN3pNdHUxRnhTUXB6ai9hYWts?=
 =?utf-8?B?ZGg5d1VwN2gwd2ZRNHpSWkpZTmJpMm1idGtKclA5RXZqcE1pZ05sdFc5bjJY?=
 =?utf-8?B?bDFSZXBUWllBdjRwWEovNjNzQXVBVE5mc2ZWVVM2RFFQTHFqd0JRNkM5eXFv?=
 =?utf-8?B?aDBzajRTdDNhVGE1TnVvbVVhcHBKcHZxL1h3WE1QSnBJVFVUSmtxaThIMUEr?=
 =?utf-8?B?cm1BY3Y2ZnBLbVBIWEs0M0k0Y3NNR0syREhwNisvUFNHR2V6eFlGVDB4VmFs?=
 =?utf-8?B?ekwveXVhejVjSXZaWk9LeEU0cnhIY0F3NFNnOTU5RmRtNWZVL2JnNzcwMDdu?=
 =?utf-8?B?MGUxN0dsZVl2ZFY0UFcvb2VibFlIT0V0MEZZc05FOHZXOE91bDViOElpQkRl?=
 =?utf-8?B?UjFwMHdZT0NUZnByb0owSnlFRW00TnJmVWpxZGh3bkdMZXVvd3F6aGdINUpr?=
 =?utf-8?B?OVY2cWtweHFWdlp3MUcyeGhVeldmY3NhTTdOc2VwTDEyVDd1ekxJZ09JR25j?=
 =?utf-8?B?b1AzelNGWDBwaEpSVHZIaU1pN0ZTbWp1VjE1Q3VZWWFzM0VmbllKWUcxUHNN?=
 =?utf-8?B?T0M0RENSYzVPOVJ2NTJMUDA1MnhOaU9aUVd3Mlo0T3ZReEZrcjhQOHlDeWxJ?=
 =?utf-8?B?UXFoSmYwMlBNR1E3cGprODBPR2loRFVnVW80My83Rys5MWtIL3FIeUUyRDBZ?=
 =?utf-8?Q?lvxXK12c0YH07cKr+dUNvcM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3abaf40-439d-4626-7e3a-08dab923dc8d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 20:34:50.4256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsFHM/BMyWF0w8dAlsHMKJqFF0APqIdeaN37HedTxEr94q+UOJv5jxdtsVUbF3dqRWXVOhEgh/yRRawV6t/bPYO/92ESp/78abIZgo7mIWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280129
X-Proofpoint-GUID: 77SYHoV3gXdpcq-ZcO8MHzUpEpzfJoMt
X-Proofpoint-ORIG-GUID: 77SYHoV3gXdpcq-ZcO8MHzUpEpzfJoMt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/22 15:30, Borislav Petkov wrote:
> On Fri, Oct 28, 2022 at 02:26:58PM -0500, Eric DeVolder wrote:
>> config CRASH_MAX_MEMORY_RANGES
>>      depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG
>>      int
>>      default 8192
>>      help
>>        For the kexec_file_load path, specify the maximum number of
>>        memory regions, eg. as represented by the 'System RAM' entries
>>        in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>>        This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>>        size to determine the final buffer size.
> 
> No, do this:
> 
> config CRASH_MEMORY_HOTPLUG_SUPPORT
>      depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG
>      help
>        Help text explaining what this feature is
> 
> this thing will simply get enabled when the user enables MEMORY_HOTPLUG
> and CRASH_DUMP.
> 
> and then you do in the code:
> 
> /*
>   * A comment explaining how the 8192 value has been selected.
>   */
> #define CRASH_MAX_MEMORY_RANGES	8192
> 
> Thx.
> 
ok, will do!
thanks!
eric
