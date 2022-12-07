Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE63646148
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLGSt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLGStz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:49:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD668C48
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:49:53 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GDven010253;
        Wed, 7 Dec 2022 18:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9Bno0cJYWBwIkLXpNnDWGShTTpdjdj0xd00yD2LLOMQ=;
 b=G4ALFs7BGXutAOBdWafs1B21Vqo/jco28Y9NAI71Gvu5oFotoOAPbEEupbC3Bi+ZDN70
 cE6X2FOyIKVp2JerEhQ6DUPrTAEFwxtaUmOhv5WI33q06yMPBkMLdKBN7OxKW+MVVzcU
 F3Ng65kPsC6tb50vw3+1KKm3ai1y2gIInbNZzzRlKklEgGKtn8zc2ElHbhExJ1Be7hEZ
 KZTlbsqkSVr1QUv6hXx4D1p7nQosMTXdGent06N7klq7d3qs/oqv8ORp83UgNLw0O4Ug
 168YOpbRUtEHzp7yv5nSBbx966LzH00whySbgOMpFS9jlqKM9rzttgMvL0xSavhovU5+ uw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maudus2xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 18:49:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7HMVH0002304;
        Wed, 7 Dec 2022 18:49:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7cqvac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 18:49:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRXjsMlw7SjpotbBmXuvbxKUo3K56LoA42aAOpY1ww2UKeQkReddwzjSPTWOKkgfkFfbxo4oeTIyjPiQSlBG1akHN1jU5GswAd8l/1nyoJQmLOVzGXoF3gZ4DsuYR29nJf4ckhcnHaIiGfGPbgUDi0/lyGu5ajEzqJSmE2da81Yi5yOsEr7K+7YkI2BuaO1wFzXBnJisDq2n7cOkfuNDuV4B3G6Lf/dYKhy4IRtdExOBH2GeOdwjKJVA5x51pWcce3PK5GZ19a4Q5tOEp0ea496XwNwo9hOy5DFr5MUPbmwHdR3wtNGX4gOPW7iTwkvlR/cEfKafTogA7iPwxed7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Bno0cJYWBwIkLXpNnDWGShTTpdjdj0xd00yD2LLOMQ=;
 b=EsrdxSGjxjEgQKaIFnzRirXSKaACWUxgaAELYWFI6FQYMJ41M9TD6zt+FE/n8TgghgBFRZAlGHtZciq5tQdNlB6kwK9Gasz3+YcsXhx9rICAfyMNquOrB3QnPPtypQAZ2DEinolV5na7taLV1YjUKGVwmQJCNG1IiIbPLVRtaqOCAWQkWdNB0A0EM+pqk93l7TRsNRypYBBTMlo9PLchNmnqiWvhpIFqP1NraL542WOzUm2QC6Yf+qWY6A+PycecAGlje46TkqmitJhQ0VnBJ2pwSbopMV7A759J0d9AyAHWrqlt1HcxntIgLekDo7LJgY54dB2ViRSgMs9Mk/uLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bno0cJYWBwIkLXpNnDWGShTTpdjdj0xd00yD2LLOMQ=;
 b=y5udZbtbPTmHQR8GeN214lUqz5jgM73lMroCdauVuLBEUyOllQvnayiYNwpBd47M3yce18WfupQu/DWabfUDQ+sMxN6ppbi29GxFagLCfo8qV5mTj7qoJWcJWE4q6B2quuQv84nlEjoDmVSHlaST2c/yPpaCIkl61HFV54Nz13o=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA1PR10MB7334.namprd10.prod.outlook.com (2603:10b6:208:3fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 18:49:26 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 18:49:26 +0000
Message-ID: <b995eccf-5818-84ee-560e-20c00f9936b4@oracle.com>
Date:   Wed, 7 Dec 2022 10:49:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com,
        David Hildenbrand <david@redhat.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
 <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev> <Y5ALigw0kUO/B3z2@monkey>
 <4161AF1A-9508-4DF8-B756-FEB476EB32B5@linux.dev> <Y5DXivFOA+bO0IYQ@monkey>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Y5DXivFOA+bO0IYQ@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0061.namprd02.prod.outlook.com
 (2603:10b6:a03:54::38) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA1PR10MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfb9738-28d5-4c86-21bd-08dad883c3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPXJrSXcA6fzMx5enADQ0ME/udz/iKmRp3I5/T+Niiw8lfoojrUjARKjUDaYDhBznoGWecq9GqcEqvWLCljz5Z3Flngew/hPbJ99xFQ5Blh4acaQHwPGPa64C83xWL09BogXyrGnCiu473O3U9e+z3s3LS0MTIZFgc52zD+2/yfwJ9xK3M3sesQ/BFLvLzgxyo8wW54Wg4cnkEVtnyitD0pOFwALOyMV4+oRh6avRBDlIYZgEm5mv7L0S5WyKltP0gW3RD1EYwg20csw7tJi7ynZ9RbLM90izoAuECWSFSwqbwjPNM+wqlaM9I96mnt792NqogRfawz942hytrlbhKNFlMNhS6d48Ic+6XNdwAZH5ix5dUSYDyY+xIDbLxpjAC0h/3KQLcHgHwlKV/z7raNOroeEBVSFpkoD88LzZmldEudixguEgVgJGoI0iF4v2U6Ri9WfquG7/QZrkdy8+m7P5FHSgyHqb2UHOcPQaGD01f3gwg1f4VQWh4U6sxQclux/NzC0r4Dmc77oEFHJAsD5WquXrMZX41j+WY4XeEgItsIyvCBFp/JL9tBBx2fvDRs2C6VZvNzYeZcyq7RT5hK1b0GVlOFleFxb0pt52UvD/h++uvhDENFIihmgdTBddB359HaqkeoIQwkMfyPkq3qkfIcucG2QZpN/Gf9sdXwhzvcufvNVd+oWVW4Q2TFa0iconOG0lnyWn3GsS4aAm7sg1NuNqOgibiV5JcZedCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(478600001)(6486002)(6666004)(186003)(66946007)(6506007)(86362001)(31696002)(110136005)(53546011)(316002)(6512007)(66556008)(54906003)(41300700001)(66476007)(4326008)(8676002)(38100700002)(2616005)(2906002)(31686004)(44832011)(83380400001)(36756003)(8936002)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0pJY2JGTmt1MVNzSkpQVmY2dUpNM0pOWFE5Q1gyaHJwMFgyZkc2Y0FseEg4?=
 =?utf-8?B?YzFXbVd4YlpFbWJEQjJ0N2FPZnBQVm51VW4zVythWmFWUmNzaWd4RHZ3R1A4?=
 =?utf-8?B?bjFGbU55emtiL0MzdXlyZ3hjV1BpWnJSMGRxbUh2bU1DYnBSWkZmQ2FONnFa?=
 =?utf-8?B?RUN5V0hwc3JVZlhyZzc1YnlCcUp2YjNFVnhMN3lPSWJxN2hFWWltR21WQ0Z6?=
 =?utf-8?B?TVY1UW1FeHBVTDhzNHA4OE5pZ1doOU1kdjhCZExsc0Z2cFloMzVzVy9GSDAz?=
 =?utf-8?B?dWhMTVlYdXlzaU9jWWswbEttRTZXNU5xQTRlRjJkK0xFRWpveG5FRkFDRW1a?=
 =?utf-8?B?UXQ1R2VsU3N2cU51NlhLUHhhMURFRkhEaTZwbjIwRTg5L2N6ZTQ5ZkZweVBi?=
 =?utf-8?B?ZGIrU3htZGVzUEhDQ24wSlVqNDUvejN0WEZ2djhjdXNaQk54OXBZYlp4OWVm?=
 =?utf-8?B?cTU2TzcyR3dxOUpQc3VLNkFaTEVrN24yRmNGSm5lVkhhclRwTnNtUjA4N2Fp?=
 =?utf-8?B?RFVxZ2ZLcmV0Q2Q5cGk0THp5akx0eDE3bnlLb0h6L3hyWVN6RjhpNUZneHVr?=
 =?utf-8?B?RDhRV0VWdTl1eXg0Q2lZSlhsRlUvK01TVk1PZUxsZUlJSGlsMXFQR29YaHgx?=
 =?utf-8?B?eEtKRmxqZ2wzMnVCWXR6L0xEQk1OYkI2a0xjOVQ0YWo0djBicjZTRXEzZkpo?=
 =?utf-8?B?TW51S0FtcHUzUGhTVjY1SHNqRDNrTGtSK0R6UDFlaC90cC9qMkorcDdRc0ps?=
 =?utf-8?B?V0JBRExHcGpCYWgxMS9vVTFoRGtoeE44ODR1dkhCYXIzdmpFamxJQkxoZWZW?=
 =?utf-8?B?amhqQmxkQ2FCNU1pNDRmV3U2dGhvRytwMEVDV1N6QnVGYWg3Z0QrME8rWHZn?=
 =?utf-8?B?ZGNVdm9ad3ZoazBkenpieEVoWjRySk5jZko4YjJSS2V1dTUwVTdLMTIyekd4?=
 =?utf-8?B?eFFKR00yY2dEQzZsMExPMUUyQmljWGcxMWRGaGgza01xQXQzZjVtb1pMdXcr?=
 =?utf-8?B?ZENiRkhIN05EMUwrV1RvcW5tcEgzZWNzUE52T3lycDdyNzlVWXFiWVRYWU9l?=
 =?utf-8?B?U3ovY0d4TmlvTFFMSTA3SWZDSDgvb0U3VmVpbVVBNWpKaWVBS1pleDI4TGYr?=
 =?utf-8?B?OTMySW1SUTNEbTJGVVhwdmR4eTVZN1hKc2NkZVFoWVlscnpuL2xYUTFkYTFR?=
 =?utf-8?B?TWphMEpvN2FqbWJabm9VcUxUNytta09BNHBTeGpBblU1UWRIeElFQUhocVNu?=
 =?utf-8?B?bUVUVDVLZktPM2l5RTdiVlh2YkVYcm9nWm1HbnJ0dEU1ZGZOWWdzeEUyWTdv?=
 =?utf-8?B?eU5RU0UzWStUQ2xwNVBPUzhTaHdDc0xmY1U0ZWFwWHk1TTZySEp2cm5YYkZB?=
 =?utf-8?B?Y1J3TEkvYVk0S2xQTU1ZM1lNYi9vSnFNY3VuanNnMEY1M2tNcUwyK3IrbUR3?=
 =?utf-8?B?NksrRDBiMlQ1VVhjc3NyYi9MdnFKMUIzbm9Pd3dNRWpwTGRDdkhQRE1zNWkr?=
 =?utf-8?B?bXArZExwSnBlb3VUTFdEc21HT3hZeE1Bdkd3L0hpd0wybjlVbEo1T0lnbzdG?=
 =?utf-8?B?ZVRLRDFsMDBLRmQwOVBXVktDb29uL1pvTGNQQkx0V1M2V0lGNWk5bHJNRzMx?=
 =?utf-8?B?MEhoTDFtWm51TVdnVksvc2VBWS9xSTBab2dEY2owd2xHK1pXRm9wNWEwa2cy?=
 =?utf-8?B?NDRaQWxPb3gwM2Z5eEovSXJ2QjRXSDBIWklDdWdzYWlXd0dqVWdiMC8wTlRa?=
 =?utf-8?B?OStDcDdYazd4Z2MzVng2T2xrdEtrdXN3WmZXdzRHR2w5cHRKSzByYW1kcHAr?=
 =?utf-8?B?V0RGQ0JMOFQvOXRJa2hPSVFxSitpYzM1bFptOFdKWnRTeSs4RWF0YmdKdjgz?=
 =?utf-8?B?b1c1elk3NlJ1K0RrV2xrcUFVUURVWU5ueGk0NUswbVBVRkVEYjJHTHMrdGtK?=
 =?utf-8?B?U1l1WUJXY1Ivd1F4MlptS0wzamhKM2p0Y1NKMFhrb0lvQWNkSCsvNFJBSHVz?=
 =?utf-8?B?VGRLbTIwQlpUZmdiRTNvQkprWUF1NGhLM0xVL3FrWHJ6NGYzU29ZVVg2SnlM?=
 =?utf-8?B?Z0piL2RDWktVeHVBeFZRSFk1akRRWnJjb1liMFVhNytkRVIzZG9KQ0F5WURJ?=
 =?utf-8?B?U2F5ZWZrai9yODNaVVEwUFdxcm1YZzZjcnBXc0lHWFVBcVVTQy9abnBySEpC?=
 =?utf-8?B?b0lHMGZjWXh3WHVGNFVxTFBnWjlUeGpxbEx6VVVOVVNkY0pYZUNRekhVbm9V?=
 =?utf-8?B?MmZUMHBDb0ZyM3dtSndTZlB1UWR3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfb9738-28d5-4c86-21bd-08dad883c3e7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 18:49:26.6616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gg5YlOeYTmJMpcmCGKLudp0Bk+MbCIGAdX9Gh1Em5pVHI8vM79026TanCGfEpJz4pOQVbK+ewNFy7OmonoQNZzZclSueYEvVYhfhOUCHNEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070158
X-Proofpoint-ORIG-GUID: ONURiwlv8fA4BdHWLOVzlM3dQZORuZkn
X-Proofpoint-GUID: ONURiwlv8fA4BdHWLOVzlM3dQZORuZkn
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 10:12 AM, Mike Kravetz wrote:
> On 12/07/22 12:11, Muchun Song wrote:
>>
>>
>>> On Dec 7, 2022, at 11:42, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>> On 12/07/22 11:34, Muchun Song wrote:
>>>>
>>>>
>>>>> On Nov 30, 2022, at 06:50, Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
>>>>>
>>>>> Add folio equivalents for set_compound_order() and set_compound_page_dtor().
>>>>>
>>>>> Also remove extra new-lines introduced by mm/hugetlb: convert
>>>>> move_hugetlb_state() to folios and mm/hugetlb_cgroup: convert
>>>>> hugetlb_cgroup_uncharge_page() to folios.
>>>>>
>>>>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>> Suggested-by: Muchun Song <songmuchun@bytedance.com>
>>>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>>>> ---
>>>>> include/linux/mm.h | 16 ++++++++++++++++
>>>>> mm/hugetlb.c       |  4 +---
>>>>> 2 files changed, 17 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>> index a48c5ad16a5e..2bdef8a5298a 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -972,6 +972,13 @@ static inline void set_compound_page_dtor(struct page *page,
>>>>> page[1].compound_dtor = compound_dtor;
>>>>> }
>>>>>
>>>>> +static inline void folio_set_compound_dtor(struct folio *folio,
>>>>> + enum compound_dtor_id compound_dtor)
>>>>> +{
>>>>> + VM_BUG_ON_FOLIO(compound_dtor >= NR_COMPOUND_DTORS, folio);
>>>>> + folio->_folio_dtor = compound_dtor;
>>>>> +}
>>>>> +
>>>>> void destroy_large_folio(struct folio *folio);
>>>>>
>>>>> static inline int head_compound_pincount(struct page *head)
>>>>> @@ -987,6 +994,15 @@ static inline void set_compound_order(struct page *page, unsigned int order)
>>>>> #endif
>>>>> }
>>>>>
>>>>> +static inline void folio_set_compound_order(struct folio *folio,
>>>>> + unsigned int order)
>>>>> +{
>>>>> + folio->_folio_order = order;
>>>>> +#ifdef CONFIG_64BIT
>>>>> + folio->_folio_nr_pages = order ? 1U << order : 0;
>>>>
>>>> It seems that you think the user could pass 0 to order. However,
>>>> ->_folio_nr_pages and ->_folio_order fields are invalid for order-0 pages.
>>>> You should not touch it. So this should be:
>>>>
>>>> static inline void folio_set_compound_order(struct folio *folio,
>>>>      unsigned int order)
>>>> {
>>>> 	if (!folio_test_large(folio))
>>>> 		return;
>>>>
>>>> 	folio->_folio_order = order;
>>>> #ifdef CONFIG_64BIT
>>>> 	folio->_folio_nr_pages = 1U << order;
>>>> #endif
>>>> }
>>>
>>> I believe this was changed to accommodate the code in
>>> __destroy_compound_gigantic_page().  It is used in a subsequent patch.
>>> Here is the v6.0 version of the routine.
>>
>> Thanks for your clarification.
>>
>>>
>>> static void __destroy_compound_gigantic_page(struct page *page,
>>> unsigned int order, bool demote)
>>> {
>>> 	int i;
>>> 	int nr_pages = 1 << order;
>>> 	struct page *p = page + 1;
>>>
>>> 	atomic_set(compound_mapcount_ptr(page), 0);
>>> 	atomic_set(compound_pincount_ptr(page), 0);
>>>
>>> 	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
>>> 		p->mapping = NULL;
>>> 		clear_compound_head(p);
>>> 		if (!demote)
>>> 			set_page_refcounted(p);
>>> 	}
>>>
>>> 	set_compound_order(page, 0);
>>> #ifdef CONFIG_64BIT
>>> 	page[1].compound_nr = 0;
>>> #endif
>>> 	__ClearPageHead(page);
>>> }
>>>
>>>
>>> Might have been better to change this set_compound_order call to
>>> folio_set_compound_order in this patch.
>>>
>>
>> Agree. It has confused me a lot. I suggest changing the code to the
>> followings. The folio_test_large() check is still to avoid unexpected
>> users for OOB.
>>
>> static inline void folio_set_compound_order(struct folio *folio,
>> 					    unsigned int order)
>> {
>> 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>> 	// or
>> 	// if (!folio_test_large(folio))
>> 	// 	return;
>>
>> 	folio->_folio_order = order;
>> #ifdef CONFIG_64BIT
>> 	folio->_folio_nr_pages = order ? 1U << order : 0;
>> #endif
>> }
> 
> I think the VM_BUG_ON_FOLIO is appropriate as it would at least flag
> data corruption.
> 
As Mike pointed out, my intention with supporting the 0 case was to 
cleanup the __destroy_compound_gigantic_page code by moving the ifdef 
CONFIG_64BIT lines to folio_set_compound_order(). I'll add the 
VM_BUG_ON_FOLIO line as well as a comment to make it clear it is not 
normally supported.

> Thinking about this some more, it seems that hugetlb is the only caller
> that abuses folio_set_compound_order (and previously set_compound_order)
> by passing in a zero order.  Since it is unlikely that anyone knows of
> this abuse, it might be good to add a comment to the routine to note
> why it handles the zero case.  This might help prevent changes which
> would potentially break hugetlb.

+/*
+ * _folio_nr_pages and _folio_order are invalid for
+ * order-zero pages. An exception is hugetlb, which passes
+ * in a zero order in __destroy_compound_gigantic_page().
+ */
  static inline void folio_set_compound_order(struct folio *folio,
                 unsigned int order)
  {
+       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
+
         folio->_folio_order = order;
  #ifdef CONFIG_64BIT
         folio->_folio_nr_pages = order ? 1U << order : 0;

Does this comment work?


