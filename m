Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31BD64754D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLHSGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHSGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:06:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761F32FBC2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:06:34 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8Hhlma000755;
        Thu, 8 Dec 2022 18:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vOJv+nGwBEjEi1/gm0VY1lgPbSdK8rNXwIPlyy4nSw8=;
 b=XQ9KR4sKdMm473u4XDgF6kYCkWL2acyrCliZcnMOB5oj7N9isR1RUey7Iybbve0Hd7Mt
 RvV+euyY+n+JRiTG4iJ40X8tv+uR2tO1I/Ngr7vTIuyydhZbYWeyHXXdGgMqPyRu1iBU
 SnIaMl++TTXXlJ/1sgcfQsKDfY5tKBVDYjnr/Md0Ls7U6V7jFLnbccsdeiH7NWr6qgxw
 QZat+y45yHRHBSRA31XRBIJpwdaVWpdM3rnDwT4VGpXfFZpzDwsE83Gf+Wbs4k7PcKxj
 D54MQRz7w/omq5s9i1umAuNncktau7qv4b1OEJRXJYKQ4WqAlCw+0tnNVehyO0cuZtwp vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maud73hr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 18:06:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8GmoFZ034465;
        Thu, 8 Dec 2022 18:06:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa4sc38h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 18:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdqWGdLjZDNZAVQyXFW+vXqiAdCm0tTjX5Fh1ZgesoIr6oxWIWgt04/o3qGf2BJQQWUxMVAEGLn4xuHdv/xPQR508qO+wXEAgzJ3AJtigC9u1k2LmoaCa3qo+Z0fCQ+Px8FY0t4GLegfsG8w0VrkiljI3eTirxdUcwRqBVy+WluZvflP1YC9pxWMh1dwBrk6IJF0gDfJXq4kbBa9JL0FDXOxgSeDc/fsTo26OlNrouTy/O0r0wpmc0Es0/AYoGQgPRNwiiJHnmFaizodI6qDjh7SDSTiYhjPvDAP9DUqTyg7SgDoBHPo9b/cdCiEaGWO4MYrczYWMyiwWxr5/Wzqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOJv+nGwBEjEi1/gm0VY1lgPbSdK8rNXwIPlyy4nSw8=;
 b=lbK6ZJ9uj14wLjofUMK0odUKiUzZms3qMTvIi1EiiZw659XAfK9nZClaJS07UyKcwq63x842c0d8vza92+qkE8B+jKvCpm/QE+sNjStMcpI6oBGf1a5ZzOphVUChzl2IwZ9OFhAo5zCvKgVxgQ078tEgxCnjLQY/QXzk8Qu/fO7MGT1BMKaGGiQ85fi/Qt/yHTaVCbVz2DVpXKqXs6Rafh/scMd/USgEV7bhocaPx98UYGTafv+Dsaf66Q3K9b+hN6pzDvAbcSm28wBEFNqXUsFbwwy7+Vputp5iN3TMNhzGAZX57IUSWYBWqti5Chcc0EOo25kDaQWDnM319tXHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOJv+nGwBEjEi1/gm0VY1lgPbSdK8rNXwIPlyy4nSw8=;
 b=Sozfc8dGkFj8gEfHIF4Xlebcs9z/YW5hQloWIOtgk9wvUu/mQ0UlHEUYh9gJVSlQQj99+haGOZ44iAWJUoAF0FibTglGG4L5hbNDBw9MNoHUPll4D3sB0nho7l9bRbUqGUBQLSVml96nzrQicv3Os1eovVjqVwMzKyjuHP93N5A=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH2PR10MB4136.namprd10.prod.outlook.com (2603:10b6:610:7f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Thu, 8 Dec
 2022 18:06:13 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%4]) with mapi id 15.20.5880.016; Thu, 8 Dec 2022
 18:06:13 +0000
Message-ID: <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
Date:   Thu, 8 Dec 2022 10:06:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        david@redhat.com
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::30) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH2PR10MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 8443c0ee-b1ad-4193-2960-08dad946e4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbR2PwiXBuqYPeBtCNhsgp94r4NX8kfgvEKFUD4V2a31yst17ZgksSezSWVexBSMH4ZF/Q3mMpYzzsJGwhv+GE8eH9poKSRatvvC/l3ZcofyJRX5S08UhOC8tKqRsAJD+3Fiu9lfhrLOzF0f5/d2x8FJlXVBFbA3mfh1ke9G3dvZ+p84rg28P3zQRMrtECcW2W8P2J5nWy82/Bi782UMLle+bpTn8f4CtWgDvzS6+XqfTSjFRwOoEZlRF1Zg8H/2yWqdBFieSYeR/I9i5q6eGmurv7AclOkyknsqWZ9Lm9Ls3ZPAiPUsFtaDyX78FZpVJqQ9ya1LT6D9ZJGTJ2nK78BPif1d+I7/bsYJBnhDX3SKEoK7+jStR6B1s7mTgbQFKYm5NkOdMHSVzOOVVsdPTsKCZQjwfSpt+VJKSqQURm0Ka8o3XDeoakKgYOo3dPyFG7jBwfXETf2wQKA7X6SecQOscoWM1VHaVyrJYedUdqvItSSgy+136dvx9JXHB1WDzPko4kuLe61QxhkBrGycoI24c4uiAfp8LjT9LRYmlCFOiKjVsjEsXaI1Kj6AQE+2Z5sEAslU+xXfTeQ1Zno1EO6HvBDZerzjzGCcbGVye0cU7rSTueKSwlzlHZ3fwhFMN2frYDsmfeytqMZFYhx9pNFXgoL+Tl6N0OFfEBeAXkINFUTqqQCnekcfLZgKo8TQOp5K7AehhttVe6alJSl8ZRQrLScTxFvPXpRs/KogQdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(31686004)(2906002)(86362001)(83380400001)(2616005)(44832011)(36756003)(31696002)(5660300002)(8936002)(41300700001)(38100700002)(316002)(66556008)(66946007)(4326008)(8676002)(66476007)(6666004)(6506007)(53546011)(6512007)(478600001)(6486002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHBaczdXbXJEREc1YlA3UmRvOExlQndJVHltLytnbjFVZm00MjFHUDVYTVZ2?=
 =?utf-8?B?YkRVYWkwaVZaQ1oyb3E5TVZtQ3REM09Fc3EzdHRuYTVXYjdnKzFVUXIrMXRk?=
 =?utf-8?B?VlJSZVVTZ0lXK3lPdHM4TkFMM1MrMDNxT3VoVlhReFUwWUpIMEhBcGdzZm5Y?=
 =?utf-8?B?S1J0SmV6SjlWdk9XMmwrWFIvY2taRm5DQnVnUnBRVDRVc0Q3V0dzMFhON1Rr?=
 =?utf-8?B?cU1nelIzLzl6NGVnS1A1NXM3QnlVeGJsQmxMbTF3VmxPcFIzMDBzNWhQSUpz?=
 =?utf-8?B?OEh4YlZla3FiS0tWN3dFRmpXY3RGOGlTOTFaSWN1R1B6SmRzOXZ1a3pqQmkx?=
 =?utf-8?B?ZU5rNE43SUUyam1WRmpUWER2LzNqdnRBeE9WU0hVMkdXMHZ1WVZNeHY1a1pL?=
 =?utf-8?B?U3VXRmdYY1ZrVjFrRUZXSzd0Q3ZrZjZheEpjdjJMcFdSNytJYU01S3VBUXp3?=
 =?utf-8?B?MGU1L3NBV1RuZHQ2aGVQeHpJYzBZSmxxeEN3K3FDSnF4VU5EZG5sRUhlZnJB?=
 =?utf-8?B?V2VPSnczYm0rdUJXcjFoVWFFTzAzLzV6cjh1Q21NeGxjRklNV0VTMk1DM1E1?=
 =?utf-8?B?OHRzQjl4cU91UE5RRDZPdVhKY05VenhIUUNPNlB3WlpQZ1F3cTNzZEdFYjBv?=
 =?utf-8?B?UG5ORWV2dXZkbTZNbEJqYkJvcGZGa3Q4SlhBbHdyRHFNeUE0MmRUdW9DM3BX?=
 =?utf-8?B?UFJXWFQ3RXpzT0RpV0hET1dqdjFSR3dYTi9sZGptZGN0dFF6RVoxaWRwNHpr?=
 =?utf-8?B?ZS9xa1ZnZ1BHNm8zZVIvZDEydHlWdVVDdUQ3dDRscG9oQXk1VG1qMXdYc2hC?=
 =?utf-8?B?OXEvaWduODAxMzRlV01RbXZOQnNKVjZaTDArZWJuQy9WY3FnVWFodU9IWks2?=
 =?utf-8?B?dkJNRkl3WVdUck1HcXRVcFp4UTNSRVB6Tm1RRVJGMm1rcU1ZVnRsTGNIUkFB?=
 =?utf-8?B?aW9JL08rc044T1FDUGYzV1NqTE1MamFVL3U5UGJCazYzM1FkRG9TQTdxOHh3?=
 =?utf-8?B?aExkSE5IbDZzZTJxZ3lkWjdZdjNzbml1L0RtMnJGckpUdGc1Rmx1RHJRbHBU?=
 =?utf-8?B?VHhHLzA1L0JKTElNS1lLeUxvUktZT3o4L1RmMGREeFBlRFl0VXVyaFg5WUh4?=
 =?utf-8?B?UDEzRGpubXljdXJhWHMwZERxN1Rpc2k4bFZHdmpzSmpWL0lOWlplaHNWTG43?=
 =?utf-8?B?V1JYeUJhNmMvMzRJeXZjMTBFeVRnN2ZTMWZOVUpkaUd2d2wrY09Sd2RaSE5M?=
 =?utf-8?B?L296Ty9mbG50K3o3UEl4KytoVno5MnJ0YnJMMy9iQkdGYzdXMnVyYVVkN2RC?=
 =?utf-8?B?Q0hNSHNMbE90aWVvMWhOOXJOUDZVL1NYRmhDUlR1cExBZVNzTzJQYUM0UGhI?=
 =?utf-8?B?VEI0V1pNUk1YcU1YaVFsMmNnT0lxd0FZdGxUcittNTFLSExOSk9TcDgzQUNa?=
 =?utf-8?B?NzhPaVU1NzNvckRGRm9EekNNTnppT0J6SU41TEFnMnNYTExKMHFpa3NTbkV0?=
 =?utf-8?B?U1NQeEJETnVscU9ma3VYUUY5RWtnblVyMWp6V1RhNWpzdGNpZUo0SHZrS2hX?=
 =?utf-8?B?dUFuODBIUU94eHkvcHlNZktkQzNFQzR0QjMwWEluaGplcEI1OTh1R2wyay9a?=
 =?utf-8?B?RHF0SnRqeVFzaHdoZG5GRXdpR2UyUEY3ODRuNU1sZmRqQUROYWU1U2dFUTdh?=
 =?utf-8?B?UHZ6YnlFNTlGaWpsUkQ5M2VqMHJOMCt0eWhzVFhCbmp2TDVONU1KQitGR3RL?=
 =?utf-8?B?SmVvTHNpUG1JOEJwU0RhRzU5K20wZDBEWUU1aUx6b085VmJ5ZDhOQnh1K2lM?=
 =?utf-8?B?Y3QrY3RZSlRNdjR6T01ZQlhQMUdQNmw2TGtKYnlkRk9ia21PTmtXUnRWeU5V?=
 =?utf-8?B?RTM4YkVjNmxhckVnVDNEUCtHcndSTDd6S1V3MkpLbm1YWHd5ZDcveUZmUE82?=
 =?utf-8?B?eWd1T094Q0pBWWF5TTBhOWI3ME44aGROcnNGc0dBYUdJS1Y0RGtqYmJzaStI?=
 =?utf-8?B?T1JJWkRIQnFLTjZ2MXpPcjJhOVlzRDdXYUNySWxXRTdGbUNFVlFWakRZN0NK?=
 =?utf-8?B?YUNmZW9nYzJabnArVzdpUmYxS3BnaHhsL2lxc1pVRm1lNVQ2ejlmbktSUlVa?=
 =?utf-8?B?Vkg2dGpKTFVzQVdmRU9QWFgreXM4N3d1bnVKU1BRck94OE15U2tMU1U3Vkxq?=
 =?utf-8?B?bnl3dms0M1FhaE9weGR1dnhXZ081VVFjbTc1K2NMNFVFa3FJbXhVZFNnY1pn?=
 =?utf-8?B?YnZ5eXFJRi82VnR0eDQxY1FWWGpRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8443c0ee-b1ad-4193-2960-08dad946e4b9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 18:06:13.6824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXLyul5ql4XKYBFZ1M9truGV2zqtgocfnMXC474vF7UNd/SPI1fRi8+uaAQ8xbzhmfEk4fh92ZBAZUqO6m5AxvWqTfah7acq6G7LG4nmOk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_11,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080152
X-Proofpoint-GUID: zRZhzWvattaM6IpwMSYFsQd9Ee_JIa7A
X-Proofpoint-ORIG-GUID: zRZhzWvattaM6IpwMSYFsQd9Ee_JIa7A
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 6:27 PM, John Hubbard wrote:
> On 12/7/22 17:42, Sidhartha Kumar wrote:
>>> Wouldn't it be better to instead just create a new function for that
>>> case, such as:
>>>
>>>      dissolve_large_folio()
>>>
>>
>> Prior to the folio conversion, the helper function 
>> __destroy_compound_gigantic_page() did:
>>
>>      set_compound_order(page, 0);
>> #ifdef CONFIG_64BIT
>>      page[1].compound_nr = 0;
>> #endif
>>
>> as part of dissolving the page. My goal for this patch was to create a 
>> function that would encapsulate that segment of code with a single 
>> call of folio_set_compound_order(folio, 0). set_compound_order() does 
>> not set compound_nr to 0 when 0 is passed in to the order argument so 
>> explicitly setting it is required. I don't think a separate 
>> dissolve_large_folio() function for the hugetlb case is needed as 
>> __destroy_compound_gigantic_folio() is pretty concise as it is.
>>
> 
> Instead of "this is abusing function X()" comments, we should prefer
> well-named functions that do something understandable. And you can get
> that by noticing that folio_set_compound_order() collapses down to
> nearly nothing in the special "order 0" case. So just inline that code
> directly into __destroy_compound_gigantic_folio(), taking a moment to
> fill in and consolidate the CONFIG_64BIT missing parts in mm.h.
> 
> And now you can get rid of this cruft and "abuse" comment, and instead
> just end up with two simple lines of code that are crystal clear--as
> they should be, in a "__destroy" function. Like this:
> 
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 105878936485..cf227ed00945 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1754,6 +1754,7 @@ static inline void set_page_links(struct page 
> *page, enum zone_type zone,
>   #endif
>   }
> 
> +#ifdef CONFIG_64BIT
>   /**
>    * folio_nr_pages - The number of pages in the folio.
>    * @folio: The folio.
> @@ -1764,13 +1765,32 @@ static inline long folio_nr_pages(struct folio 
> *folio)
>   {
>       if (!folio_test_large(folio))
>           return 1;
> -#ifdef CONFIG_64BIT
>       return folio->_folio_nr_pages;
> +}
> +
> +static inline void folio_set_nr_pages(struct folio *folio, long nr_pages)
> +{
> +    folio->_folio_nr_pages = nr_pages;
> +}
>   #else
> +/**
> + * folio_nr_pages - The number of pages in the folio.
> + * @folio: The folio.
> + *
> + * Return: A positive power of two.
> + */
> +static inline long folio_nr_pages(struct folio *folio)
> +{
> +    if (!folio_test_large(folio))
> +        return 1;
>       return 1L << folio->_folio_order;
> -#endif
>   }
> 
> +static inline void folio_set_nr_pages(struct folio *folio, long nr_pages)
> +{
> +}
> +#endif
> +
>   /**
>    * folio_next - Move to the next physical folio.
>    * @folio: The folio we're currently operating on.
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e3500c087893..b507a98063e6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1344,7 +1344,8 @@ static void 
> __destroy_compound_gigantic_folio(struct folio *folio,
>               set_page_refcounted(p);
>       }
> 
> -    folio_set_compound_order(folio, 0);
> +    folio->_folio_order = 0;
> +    folio_set_nr_pages(folio, 0);
>       __folio_clear_head(folio);
>   }
> 
> 
> Yes? 

This works for me, I will take this approach along with Muchun's 
feedback about a wrapper function so as not to touch _folio_order 
directly and send out a new version.

One question I have is if I should then get rid of 
folio_set_compound_order() as hugetlb is the only compound page user 
I've converted to folios so far and its use can be replaced by the 
suggested folio_set_nr_pages() and folio_set_order().

Hugetlb also has one has one call to folio_set_compound_order() with a 
non-zero order, should I replace this with a call to folio_set_order() 
and folio_set_nr_pages() as well, or keep folio_set_compound_order() and 
remove zero order support and the comment. Please let me know which 
approach you would prefer.

Thanks,
Sidhartha Kumar


> thanks,

