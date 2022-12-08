Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616726478D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLHWda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLHWd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:33:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964F82627
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:33:27 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8MIgpV028900;
        Thu, 8 Dec 2022 22:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xogxgduJRE4SF9gjzsYLI4koXbPqjha4cuHDQkvpQ8o=;
 b=IMCLOJQDSJyTxjqTsHeDChJKG19Jszeq66uoH/jkFHxYNAK8DjhQXJP/KA6+WoJeb/wG
 w3k3LDVWcj9qZ7Y07sVxN/5VbaBH8uidA3ejKXpfeC0LyPHqPXLVSEp+cQ8aV/eQ82TB
 9v17rj7dcwVh7id1O1ViofIq2eqkWK/W9T4abtbEJMArreYO5PvbzVxGyd6anQ20QlVn
 V7sKn+J2VcUghaNKiWun/Nw67HyuUm2Fu7x0j1KihrFnOHYaYW0c1P7B84hD2K6fZmpz
 AuSCAjEqU7Zr/VchMY6jbZW0+5A7Ca0HKzHna+Yld+p0jijsqoOlkPGfFh9L2mgKho9c Dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maujkkw8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 22:33:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8ML274033733;
        Thu, 8 Dec 2022 22:33:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa6bru79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 22:33:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FShyhezy64j4+LAU/x05qfEIUOxvhf9o+fzlQMhehS4om9NcXqcysVfM4p6aLROgn9yzj3a1r5OsE50ak2rcQ8QgBRE0vXsxYlIxNDIuD7VkjG1u1f/19QGTu9MPxy2NeQmJFVtYH0P7SmLW4xG3lukokmz/XBDMVNBt1zEnBUDmTZRvx6OR2IZydS45CO1ICyk8N6fS+Cdr041aIZ3zd+PPRcRt8uv05G78is17RWjKfbrvq4F2mnq6h4BWHqMmSHr211zu8Ha1x7LHR9UuLTMSKfFAfA4qXWaD/Tfpq6KGWFM7WpEsz9k809/ZphB9ADvQj1O27yRcVIlYsO5ZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xogxgduJRE4SF9gjzsYLI4koXbPqjha4cuHDQkvpQ8o=;
 b=P1TT7lVkR1i5ed27750fsEMXqJICGjcrJnUFIPM11OU6hDol5cMNuktszZyQyx6SRZ3Y0B4gs3HuRMv4mJ2OK1Wqc68oMpE7kEYrRBBrscMmUMicMow1OhjsR1onYec9QbhpNq+QUL60e/QoDezzJWk2EPn/KccqANPD1qVI/MvG+t4335QoWtg4mREPw5WTuBC2Fxr+fr5V0RI6WhkeRohwz9wsdjQx/0p5brBE6Wr5oTR3Bke47pI0l40F3t32je0Y6ihxtDe87Kp+v4mYUIFbxUe4BKJt/A8MI7qoZJoV+odTgdMbZ90V9WCtQ3N13cK5Jo5PMAeJQ3Da2+3wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xogxgduJRE4SF9gjzsYLI4koXbPqjha4cuHDQkvpQ8o=;
 b=A8JtnCj+3e5DqHNwqo1HavNM8xTLu1+x/NJMFhuwE9Cp1PmBHUM98Zem5X812iM/CoaVmHLQLwEBnFXF9rIYXQR2rutrOGsPpRO+6ZHej6L+2HM6th8uUDUAI30YIa23aFvV6bbWAa3dhibrdBYgAU1PRrerGJiTM7ZRqW8PJ00=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB6625.namprd10.prod.outlook.com (2603:10b6:510:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Thu, 8 Dec
 2022 22:33:06 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%4]) with mapi id 15.20.5880.016; Thu, 8 Dec 2022
 22:33:06 +0000
Message-ID: <434a111c-7f1a-0018-6bd2-561cb382deea@oracle.com>
Date:   Thu, 8 Dec 2022 14:33:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        tsahu@linux.ibm.com, david@redhat.com
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
 <Y5I78soNmAFv7pi8@casper.infradead.org> <Y5JCi3h8bUzLf3cu@monkey>
 <2723541a-79aa-c6b5-d82c-53db76b78145@oracle.com>
 <e86ca90f-e59e-3851-7225-b5f596ad04b9@nvidia.com>
 <36ddac45-ecd0-e2d2-e974-8c85ca503053@oracle.com>
 <20cc2088-b66e-28d1-a529-414e82146336@nvidia.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20cc2088-b66e-28d1-a529-414e82146336@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:a03:117::40) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fc7a10-0429-4bc7-a8f4-08dad96c2cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIsPp4koqgJfipJDRXQpqngFc1DOluu7/jgSQ47mQ6Vljb2ODuaYyS7PFhujw0Y0618mR8bjxPICFmf4dqFfEXEk/Ezfclr2vtHZtbWBm2DfQqTpP0JAgcDSXBgIk+jLSZ4D4At86okEZal064bUkvdDzOr0wzySHMmn4qOVZQicBT/QsfP2IxhLriUOeUzYsz+Ie+rDzMYf3nBbu8AyYn8IpZHeuvdjRCAEUGCEvXB3IzHfgPOWUcAA+Wpl+04M36gMAa2kpyWXvVQEIaa3D61s0t+RjWHLWVSnE5U8ppoB7kk8DT5Y4/PkplREp4na6oAzgVavtkuPMjcNeu4tqlhGdMYsLh0t9fSOGQ79ONjEEUCO2+48qnadp9J90wP6E4Vlq4JaMANICywNS5G/80fq4MMvObpDZtIYoXw4jV/b9Ab/cs1eGJ7+b3AbaQ/cCNIBdn2I0zPOSJfNJSpphLVg91xdC+GPJ1d6wqSWMGwQJpypfC/bixTKoo4etDN8xyBph162nn5HVQcIO2fXRpfeCYFwNDmdw/Wwat2rLayW6nb0D/l8gjODtzydgOFPX5KZmcFupQ77Kn1PV/oSaoPMSIBFhmA9AycilIMnsGHLzn4Qax+Q8irfPz9jDjAygUINViHxHz9qFFoNoVbvHdlto0weNIdsn6JyfTiXwI8ETJoTOMpftLBDKqbeMxa+RoYbb72MSKVCOrFGKfhJZUrcYCkP57ueJEYd+6yzR+ETiU1+V3pu3xCovtFNtXQK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(31686004)(36756003)(4326008)(6512007)(66476007)(5660300002)(2616005)(44832011)(2906002)(38100700002)(66556008)(316002)(110136005)(8936002)(41300700001)(8676002)(6506007)(53546011)(186003)(966005)(6666004)(66946007)(6486002)(86362001)(83380400001)(478600001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFh4UkttVlFWOGJrZ1MrTzQ0a2RubWxOaXA1eWpTUE5DTmw1eEE2dkVHYUtV?=
 =?utf-8?B?Q3p1MlczQUpPNE9kcDk1OGpOT0tnM1pVdi8xS3dUYmcwb2J2b2JWVDBIZ2pV?=
 =?utf-8?B?Mk5VY1M5ZXBOOTdSbk1DWFkzbTRtVy95VzYwUE93cnBkSU1URlMvd054RnB1?=
 =?utf-8?B?dXhNQVhzeVorR0FBaFRwaytIUm1PYVovY0dmdnNnaVpCa3czMndkZ1lDSVRx?=
 =?utf-8?B?eEZ4aVN2SllQTmd3VFBKNzFqNGNkTWJ2UGs3R1ZyejI0NmNScURDRmZXQ205?=
 =?utf-8?B?Tlc0WU5uQ1ArVjNlZDc3OC9LSEM2WHdYNVlGcVBjUXpNUXozRHpwL3lDQk1r?=
 =?utf-8?B?WW11Snl4bEtNUlVoczZZVjRsZkdManpUc2ZxVDlzMkxhSE15Rk5PRlh2d2ZO?=
 =?utf-8?B?cXJkMUxGRnJDOVBTU2syeWg1S3B4b3dzSWdjNUlUS0ZMNHZ4TktVT0lSS1I1?=
 =?utf-8?B?YkY1QXhyUW4rVWJuVWxqOWpMZ1Y4aHVnRG4wYm5qMWRGS1dwTjRBdSs1NHFo?=
 =?utf-8?B?OWIrMUh4VCszb0IyenRDZ3JlZ2lQNXJtYkovWEIyR1Rwd3hGeVMzcEt4cFpn?=
 =?utf-8?B?RVNTVFc3S1RUWWJKYmw1VUJYUzhxYlVkODVObENlV1pJanBZMVZ5aTZETmJW?=
 =?utf-8?B?dERIZ2pDY2FabU1EN21UNEhrU2NES1E1WGJsVHoxTnFWQUhsdHNLMmtvbWU4?=
 =?utf-8?B?dzBCYW0veTY0RzVpcFFhMFkxNWpHbmRPMlFnQkgxSWdrOHZHYXJBeWo3dUFv?=
 =?utf-8?B?dmpnem1QSThrbW1LWWl0bjBBMEJqR3EvT1ZHaDcrelVsMkVMcmxjSWM1NzBk?=
 =?utf-8?B?Z3pRUjlrdDRaaEVHLzhjcnpPZTB3ODRnOUNDK1Q5YjRYeVJkbUpBNlZHMVJM?=
 =?utf-8?B?TFlNV3JNUVRpeS94bFJLTk1aMzBiMFJsVlRvZkJzV3AwRXBXUEFONE4zVi84?=
 =?utf-8?B?M25Vc1hKblVoNklPQ3U5RVRQVGVSR1l5VUE1VWdHaWY0UlV3MXBCbm1icWtH?=
 =?utf-8?B?RVlvVkVaUTBiUGIrcUhzQW45UWdjbFIxSG9XejNKNGdmcXJPZjlHTGIvcmFH?=
 =?utf-8?B?RWFHTHNuMUxNZWljYVNYVGtHeUtZNC9BZHNNT0pzUHZyTERVeE1PTDIwOXQ0?=
 =?utf-8?B?eTl3cWdIR3dDOFVqb01CSEJDZXIzWkxkU2x0OHNZeSsvaHNZWUtuT1pOR1By?=
 =?utf-8?B?QkozZm4zNnR1eHo5Q2tjaTdKSHRVR3pkYnFQSHlUU29obGRYbDBiZ290Q2pF?=
 =?utf-8?B?VWlsRENvLzZUZ0tzUXRmcWdyWk1JRzRUVXJyN1lKVGp0WXV4VVorbFJlNldp?=
 =?utf-8?B?dGh3RmRsNDQ0RGo0TXFVaTU0N0FzbVI5T3ZhY3NOMEJtbmxyUk1wTnhGSU5O?=
 =?utf-8?B?NjF1dDRTMUdPL3VjK3V6TnVCVDk0UkFoU3pvTFA2TUgzWmN6ZnZTbFJzZldv?=
 =?utf-8?B?WVR5ZkZ1b3BzTFNxb20rNEowZW1aNWRQRkhQREJ2VnhITlhQZG9rUzgvQksx?=
 =?utf-8?B?clNtdEhpeEw1aHc2WEwyOTlzOWRQWTF6SEdudFgzN20ybW9ZcVUwRURLMjdU?=
 =?utf-8?B?VHNIeWNLcWJFOGFYSFpTRHFERk43bFBRVnYxYjMrZlh5bnQvTk9GSGZhS3M4?=
 =?utf-8?B?YXdqSjl3YmhrVWhValpPT29HUE5KWjF3NjNGaVVDdU15b0pkNkx1V0ZFTkUx?=
 =?utf-8?B?bkFyckUzaDE0bXNYWnpYcXpGa1RhSE16YW5jaXU3eXZ1OThxelEyL3FFNjVQ?=
 =?utf-8?B?Q2dQQlFjY1lQT0pDSFFsbXBNR1M1eVd5SGI1bjhmV0pKSlB4Y29DK2pSMFFL?=
 =?utf-8?B?TlI3Um5hMlo5UDJ6VHZiRUx4RDhqNG1naWI2WnNlbXJFYXMva0xlaUJBMlNx?=
 =?utf-8?B?UXpvYW9KU0tVcjIxZ0dWNnYxd1VZVGJWQXByZllObjBKeHN0V213b3FFM2Mv?=
 =?utf-8?B?U2VFQjJBVDhGcDd0QTN5WUxuekU2OGFzNFE3RDA0c01mVEZiSEpNQjFqUGVQ?=
 =?utf-8?B?QkhLSmY2YmNvRU5nY2s5Mld4NGdLOG85TFhScmhibFVJVTdxSkZROU1nclN3?=
 =?utf-8?B?QVBGckZvRk9TSTVGMWRhUnQ1RTEwdTY3N0pBL3NIZXNUOVRnQTJvck80L2VY?=
 =?utf-8?B?WFdMc3ovZGwzemx4YnZrNUNFSHpaaVVTUUh5M2NDQzhrcmxLN1pwa3pzKzBK?=
 =?utf-8?B?ejZTMyt2akVvSzg0QmNMUzVZb0ZxbkF0SHBTZW1ZejZCRThOcXBYTXFLbDJ4?=
 =?utf-8?B?RnM3dXljQ2E0b055elJ6YzdCaW1BPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fc7a10-0429-4bc7-a8f4-08dad96c2cfb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 22:33:06.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytSzTC7H5rreARLX6Runj2oiDHBqI1BXNmxPyKU4lACNuqQ7FdhBbsNtR3bq/DX2DshGDoc9YVdZu5wYdOESQIx0zVgkw06RIAVMtyu2jGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_12,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080185
X-Proofpoint-ORIG-GUID: rMBVu6QQApgMgFqvbGj30l8FS45E7N_c
X-Proofpoint-GUID: rMBVu6QQApgMgFqvbGj30l8FS45E7N_c
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 2:14 PM, John Hubbard wrote:
> On 12/8/22 14:12, Sidhartha Kumar wrote:
>> On 12/8/22 2:01 PM, John Hubbard wrote:
>>> On 12/8/22 13:58, Sidhartha Kumar wrote:
>>>> Thanks John, Mike, Matthew, and Muchun for the feedback.
>>>>
>>>> To summarize this discussion and outline the next version of this 
>>>> patch, the changes I'll make include:
>>>>
>>>> 1) change the name of folio_set_compound_order() to folio_set_order()
>>>> 2) change the placement of this function from mm.h to mm/internal.h
>>>> 3) folio_set_order() will set both _folio_order and _folio_nr_pages 
>>>> and handle the zero order case correctly.
>>>> 4) remove the comment about hugetlb's specific use for zero orders
>>>> 5) improve the style of folio_set_order() by removing ifdefs from 
>>>> inside the function to doing
>>>>
>>>> #ifdef CONFIG_64BIT
>>>>   static inline void folio_set_order(struct folio *folio,
>>>>                   unsigned int order)
>>>>   {
>>>>       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>>
>>> Sounds good, except for this part: why is a function named
>>> folio_set_order() BUG-ing on a non-large folio? The naming
>>> is still wrong, perhaps?
>>>
>>
>> This is because the _folio_nr_pages and _folio_order fields are part 
>> of the first tail page in the folio. folio_test_large returns if the 
>> folio is larger than one page which would be required for setting the 
>> fields.
> 
> OK, but then as I said, the name is wrong. One can either:
> 
> a) handle the non-large case, or
> 
> b) rename the function to indicate that it only works on large folios.
> 

Discussed here[1], the BUG_ON line seemed more appropriate over
  	
if (!folio_test_large(folio))
	return;

as the misuse would not be silent. I think I would be against renaming 
the function as I don't see any large folio specific function names for 
other accessors of tail page fields. Would both the BUG_ON and return on 
non-large folio be included then?


[1]: 
https://lore.kernel.org/linux-mm/20221129225039.82257-1-sidhartha.kumar@oracle.com/T/#m98cf80bb21ae533b7385f2e363c602e2c9e2802d
> 
> thanks,

