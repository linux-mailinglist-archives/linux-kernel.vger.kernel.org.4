Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3FD60E935
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbiJZTms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiJZTmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:42:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B12DD03B5;
        Wed, 26 Oct 2022 12:42:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIobHB020594;
        Wed, 26 Oct 2022 19:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lBIDfYERkNAr4lL9jFCw7JLd+2Oz04DuNQGPV8zUJzY=;
 b=WVZ8//flnAvBme21Y1FnpXixMqCzvFWrUTtI8kBzmxUyFkI4DJbIfkLERfFy8WIoycpy
 PoyuWlow4DdFjtCwoG4w5RlM/vJ1BVErwGGE/gCAa7I8J323UhY+6woAxgxEalFJcD4T
 ukBNMJa3aW6WhluCgIhn2hLz7AP9uulufk0lgvM++OsnxxhCG1UkdWCrtasRVaokjjxF
 +USCsoGNhFnq47cWEEv7PaVDSaIqu0HgcYCxikha+d68+eVM52+hpjNHzjyc/JtzSTtj
 OjpxxMsTg/GUJBZMjTW9JPv/GamAWT7E4NHUJFnDtZnEkt/4P3NvPyVXvDji0s11M6PN 5w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfahe84er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 19:41:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QInFbZ011678;
        Wed, 26 Oct 2022 19:41:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagq9atd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 19:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoEWs5wupnVSq1Ul4cYut/KY3V67fMBp2VIIHa6hHFyzLtG9u9N3pVWOzQYzWx6viSyzDS0kPsZaZx4lJy45NYKWnDyjgLG02qXb2LT9o3uj67E/592cdQwrKMdxPxUB9fkuEczJ1ku5NKrw8jGOapRNAcibxoomrVUADQ/RrBTmEdel/MEW661tFJBTElhCsaE9D4gslXq56sVTFdXmS/iOJUNWPCwoSNfId2uhi2rvFYyri3kdcbqjR+LocUXBo1Ak2RgQvKcyct6nXlIu2aRBm4ME7jwciS1AF6mtUm2UkqpixZ/X3o5/6XFk0P8wWxBxDdnGJDA2fmuuGC2JDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBIDfYERkNAr4lL9jFCw7JLd+2Oz04DuNQGPV8zUJzY=;
 b=mU41k3F1j0Wr/9KAf55eGuLL+Nzc3QSC87eoZxs/swnfuYDh6L8/rrWBkKDxn5oIashXJlSp1jIz95XLYE5JbM2lNsDuTKgtCEl+7GWyvFzLfdeyEw2VO99E7D0v7lSzXsfVEp3f307j26c96X+WLT1PW9cJM2odyAvnct3hePD/MRzq5eWSDXzP6N+H8SxwWRsupflGwKtUQymMfvLGH6QU3TDynRBN5ewwhCeENAeMk+YipTWKxVRFf1g2ZTziYERaMPvXyFAq6hhM+SyK5IqMXHJusy1xYFMgjpbT+1kxmq/Tu6W14nEsppRJ/LGNtdqfQ/IJHBDrxyz4pwmdjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBIDfYERkNAr4lL9jFCw7JLd+2Oz04DuNQGPV8zUJzY=;
 b=tmAMzSY09zedK0UZ7RYnyCyJcTjI3k/8dXFU0SQJzCYjoXRAYbXX+KT9B1/M/zRPPzdAMZPcYfDBcWcWkisodImejhWI/9v0fUl9Vv3W1/fMqWK+qZ6G//FxKiPFtefKAKKtqQQw0yeSqejKdiy5sP7Zli/NrABcB8aC0W+hlSo=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 26 Oct
 2022 19:41:41 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4cb8:f380:67:fe9e]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4cb8:f380:67:fe9e%4]) with mapi id 15.20.5723.033; Wed, 26 Oct 2022
 19:41:41 +0000
Message-ID: <46618e3c-def1-8502-47b4-9cd132f95c53@oracle.com>
Date:   Wed, 26 Oct 2022 14:41:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Baoquan He <bhe@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        "samasth.norway.ananda" <samasth.norway.ananda@oracle.com>,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <YueMyUqannVg7l9v@MiWiFi-R3L-srv>
 <a80c2b7e-a510-8e45-1f3c-7e2ddf79bc37@huawei.com>
 <1d89e2cb-de26-0f85-7a2a-f68599a1b143@oracle.com>
 <Y0fsi4+T6k/OO0hx@MiWiFi-R3L-srv> <Y0mOaLL6wO2Mp7dy@arm.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <Y0mOaLL6wO2Mp7dy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR18CA0028.namprd18.prod.outlook.com
 (2603:10b6:5:15b::41) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4722:EE_|PH7PR10MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bdd319-11d0-445b-0e12-08dab78a1ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgQYqNjrSlb6eo0aLFI/TXuqJXC4hA4JRqQ+uyHwMMtfwtCfcQ58Ak9WR9ATd73h56sG8LMVIRf2wJEePiyb7JhB4+T5RdofKFA3FdmXACpr+S2IHTdYYakBz8YuDBuQcAU6BORnngj4Pe2hKJMwD7u7JOviagVIhHAXl2yY6QbsQfz4bBth32wJnabG/NKBFl8ySTs6x8wHKhUF0aGAARfHOAtFO1jeNCpMh10fEZhwEzccEJtKT9/20tMpds0UgZZ9DPG2ZGalalsKbdZ3lnMt0omHxAc04eymoNnhjG8OvsW5aRmb8S25hmNKTLIFiOUWiU/g7X28gq8atyy39TctDPHqu+FVC0vrd3UOfHFJCXVhSiCefFobXU0RgsR2xx3XcKOTreLInJuIu8FXSWOtFJZFE1TB7L1+ryR8Pdbu3uQxVHYjeU4U86AQ0jIoEXLdGdHT5SQcHSwE28GmIh6u6d7C1nKnB625qRsZLmFkSRZXZd9JdGN7TpElqSQj26MlZ1/6R5iOS+zUWmmBNhxu6a3k0BiCavGzUeNhNlq1WDSmAhzG1Jo8nt/tIxOVVWEFG5uKeLNUdn5bZA4fcOyGVX4F2sX78kcKfVPU+48m1WZ3ZQvisbJqqJeLyz5sBI6ol2olTlQTv5nYBWHsjR7gUwDifjQZ3kwjMCb70iTZcoUEXpLB9sY6SZ2Ypjno0HITFIj2qQEHOgyVbSyHxtDgccQ6Lp5j6Wpk20xViQnLn6Im4GRmY4wIP+GRvqsKmDsCrT4TBnW9op8iQoHJeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(66946007)(54906003)(8676002)(38100700002)(478600001)(6486002)(2616005)(186003)(110136005)(41300700001)(7416002)(53546011)(316002)(6506007)(66476007)(86362001)(5660300002)(26005)(6666004)(66556008)(31686004)(107886003)(36756003)(2906002)(4326008)(31696002)(9686003)(83380400001)(8936002)(6512007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2lZQnljZUNYYzNOWVVGUUhEVkVnRnlhR25CZUNmMW1qN1d5NGI2NTVFOUxx?=
 =?utf-8?B?ZTBKU1lYTUVEU2poaVd6Z25BMHR5cTVhelZxWjNLdjAwNnE2clNockVCTG1Q?=
 =?utf-8?B?NGtyRWhQN2xLUTlKN1VIaXhRUDUwaVhoM0dTVHZkZk9UODJoTGFhMlVPZHcy?=
 =?utf-8?B?QkVmendHSDBxZms4OE5iV04zMG5UaVc1blVCN1IyVVVOV3RGKy9LV2gvdFpx?=
 =?utf-8?B?TzlPaUMrMjNqOExvbGF0NGl6SWRRZnFUUDF3Tk5iaitibzJTTktIeUZKU3Vi?=
 =?utf-8?B?Mkhic29LZGNTamVQMFhyMU5pZ3JQU2hhK3duRjJnZml5M3JENU53UGF6WG1O?=
 =?utf-8?B?b0lKYnl5SGtjTVAzaTAzR1VPS2w2bFY2eGlZVmY3Y3A2MXhIUXhnSUxCRGNR?=
 =?utf-8?B?SVNFcDZWUDFiZUlxMStFV0hSVk1hV1g1RGpXdXY2cnNLSFRwWUUrMXhSWUlo?=
 =?utf-8?B?MEhpTk0yamY5N2pHM01zMkVra3lTZVRjcG5CQUk1OGVoSEtxT2t1dm9adkFq?=
 =?utf-8?B?SnI1RFB3anpaOHpIbklJbEhYYWNETXRmeUhYY1dSck5nQW12TUNMell4NEJo?=
 =?utf-8?B?VEhwaDlKZjl3bWJLa0ZyWDlQWlh0SHNtSTJKNCtpSDZWc3RKeE5iL2YvTExY?=
 =?utf-8?B?cVo0MXoxQjhvTHpJVk1HRUpMQnJsUERBTlhiZXh6c0d1VG1UdHFTMVhKV0hF?=
 =?utf-8?B?OGdiYkVFS0FVVVIrbWNJY3pjOXhabG9vbURWenlJbmtxS2JqWWZibTA2dmZP?=
 =?utf-8?B?WFRhNndMM205Z2dvNUlEdzlCdjVIY3hNSk1jRTM1U04rQXBKbjBNL1VXL1A1?=
 =?utf-8?B?cWNjK2tUYTUyTWh2dU9uSUxJMjRTUE9pWndGUHlvaWZzTlhWZDllWnk0akNw?=
 =?utf-8?B?Q0x2ZXJsYndmUWkrQzRtOGFMbldnQk9RdEd5cVdoTzd0OFNxd1Q4WmdQTkpU?=
 =?utf-8?B?SXpaVDFhdm1tajdxOGN0K2g4M0xXaExVNmM3cGdRNmtEeXlvT2tFTzFXSzds?=
 =?utf-8?B?ditnOHRHYW9zNU5CK2d6VjV2WUxJS01VV1lheTRJMXo0WFJMTmc4bGk2ZVNS?=
 =?utf-8?B?cHhObVNQSmpDSDI1cVhkMU10M0l1UTVvek9renIvSXZMZTUzalJndnZIOG9P?=
 =?utf-8?B?ak5aMzVRMlhzR3FMeHhvUkZjL2FXYXphUU5WYmhHNUZWSitUV1I2N1I4Yk9G?=
 =?utf-8?B?dEV5OURYYkNTdUlZQzZtN29oMkZHellCMmF4Vlk5V3F6TWgwQ1RmTDh4WEgr?=
 =?utf-8?B?Q0lWMGw2MTErOHVUZmt6R3RjY25rbXZSVTRPeWFXRWlsYklvaVVGZTQ1Sisy?=
 =?utf-8?B?Y3BXNFZ4Y1VPdnBDSDhDZ0FaM3JzUjZ1TzBEdUxJcTZKb3p2Q2tVZVo4SDJR?=
 =?utf-8?B?cE1lUWFXaDI4Z2xIQzlzVEhFaWFmZnQwOUE0cVpSOFVmanJhSmt5dkhZV1Jq?=
 =?utf-8?B?OS9QTW5FeHJHUUNRUUlFb0owYmhaZVgyS0ZMemRMWGkwN1pvWXBhbWordjY0?=
 =?utf-8?B?ZTZQRkdxaG5hN1owcEF2MzFTc0U4eTZwMkVLUGdrVHRhS29lRTJVaXQxdWJ0?=
 =?utf-8?B?VVByUDQvMmVUTmlPa29Bczgvcmd2SDZ5cUMvRVE3NTVxdENUa1VNdVJZNXRW?=
 =?utf-8?B?S3pEOTd3b2IwcUtsUVNMa3ZXa0RUOE5wMWduVlc3VDVWcVkvMGpaTmE5VWhW?=
 =?utf-8?B?ejBhcmkxVmlLT0piQVpiTFZtNmxSdEtxLzh0T2Q2VVRRNzBpSXNGZmp4dXI5?=
 =?utf-8?B?YUdkOFZkeFNaY2Z0djgyU2dHdlNqbW55WHJXRjhNVlBhd2tmdDhmZXBNWUJ4?=
 =?utf-8?B?YmlQSlZiV1doNzJCT0czOEtTNW44dUhQTW9wZlVBRkdYMDdrNUNuTTlWWWFX?=
 =?utf-8?B?cXJsbUVXelJhMlVYL1BXSGgyQU9oTloxd1lWeG1lVXVrTjlwY0wxR3VBNDFa?=
 =?utf-8?B?SkdVK2xvaXpNRkxjZkNzaTE5TmVmWUw2UTIyL2g0VWg2ZkdTeDdsMTY3clFm?=
 =?utf-8?B?cW5DWm1zVDdnQTRxQW1mUXU2eXJEb1JrTmgxOFNxWkYzZkwraHp1NS9Fckc2?=
 =?utf-8?B?VDR5d2lNcU1BTEF5c0lBZU5ocE55a2Evb3hPQUs4QTlOUGtmQnA2NkQ0MEY5?=
 =?utf-8?B?L25wRXB2dm5ZUUZnbjgzU2FtZ2JQV2QrRFY1aUVLbVVCem9wSFQwaTgrUTR0?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bdd319-11d0-445b-0e12-08dab78a1ab7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:41:40.9639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfHC0ey1A6pfRjskTVQm/Ho9W1KUxcl8yZmxjcbWlQuL1CYxtF6FZeu8Ot/N+jFq/nxRVQkKJZ9LWU5L+3Hujl0oH4MFD2/qOfJ/LDZ8X3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_08,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210260109
X-Proofpoint-GUID: ueBG7zw6j8rwTBwsFkC-nJFBPHmVJtJ5
X-Proofpoint-ORIG-GUID: ueBG7zw6j8rwTBwsFkC-nJFBPHmVJtJ5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 11:29 AM, Catalin Marinas wrote:
> On Thu, Oct 13, 2022 at 06:46:35PM +0800, Baoquan He wrote:
>> On 10/06/22 at 09:55am, john.p.donnelly@oracle.com wrote:
>>> What is the progress of this series ?
>>>
>>> Without this patch set we are seeing  larger crashkernel=896M failures on
>>> Arm  with Linux-6.0.rc7.  This larger value is needed for
>>> iSCSI booted systems with certain network adapters.
>>
>> This change is located in arch/arm64 folder, I have pinged arm64
>> maintainer to consider merging this patchset. Not sure if they are
>> still thinking, or ignore this.
>>
>> Hi Catalin, Will,
>>
>> Ping again!
>>
>> Do you have plan to accept this patchset? It's very important for
>> crashkernel setting on arm64 with a simple and default syntax.
> 
> I'll look at it once the merging window closes. I saw discussions on
> this thread and I ignored it until you all agreed ;).
> 


Hi,

Do you have a timeline for this ?  This crashkernel > 4G for Arm item 
has been lingering for 3 years. I think it is time for it to be 
incorporated.


Thanks,

John.




