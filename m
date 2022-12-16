Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C53864F4D1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiLPXNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiLPXNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:13:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40F2897D8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:11:23 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGLSwqn012293;
        Fri, 16 Dec 2022 23:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1KQ8PxZItsxrmUfOvO5xK16t1lWi0K/hGf3/UQF1JTQ=;
 b=n/NQ9+9uTmxGdmf0HmqJyqZyaiB/mXFzHU8P7+2J5QPjnil9LpG5730a1k0V+YbGHou+
 J98a24CdOn8zHDxFaY8f93De6BlMRBEnR0QAF4IqnInTwucBO673EvAmPoRqPoXdnQwJ
 XknSnNdcibhhpQLMw7VrORb33OqvIiB1YOhJ1oTeOY61dqpqIHVfczICb7ASPUihSbTQ
 U/kvXEfW7VUyFbdGFwL8kxga3vdyKdoJzKAzMqmo9SS20oRv5MJKKeP0HrYWBqqCEHSa
 lNlrkIdtZKgx36xQssV9MrPk1WeuOj0eNlw31GlbVmrzqJv9M2AlKnUAxaUJX35imnIT 0w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyex8pv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 23:10:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BGLY7PO034828;
        Fri, 16 Dec 2022 23:10:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyer737e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 23:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV50M1ciwW/7iUCNqTmrZ0Ys9whj+AiJurVK7yLXyW38OXfU1W8kHO39MT3AHgP2cLcgCWZNK8kei5fowZqw98H36MXuvVlS0nTkYvuFmF0fHgLtxSU1vb69Y7JZaibzGYaKylwCNzT1q7G3ym3roO8a1N8GWjXsR0euaGGOe0i+Zcpe2r3Mx2OTWDa669nhWoFpO/DqfqDhJYTmrmDYkWELIWIYMzonVI2ttGWt+qcmbLiBX0ogSKbXm2oPbIA6yMVltSADUJysVwbcrfHu2Pqv42vo9VuMwuxTleNO0bcil6P5+lQJhSAtoaJ6YpYkPQmlkyt7ZWMlQJE5Xw/IQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KQ8PxZItsxrmUfOvO5xK16t1lWi0K/hGf3/UQF1JTQ=;
 b=kDJz0+FBRU34723DEmSlJkPDIlJwZO9pAvcOUBJHcMqAp4wGWHaEUeyIcaI8HVPoCkzS1AWfn7Gqd/pUOwIf/5zVIxgvht6Ib+rZjfkKEjn68EoCDv79Cn90e0TETRn6pUoQ5uk9AtGtsKHF3vvXR+oDnxzn+k/WH7mMS3bUc97RGDj4LivLUIEYskddtaZTagikCQJvDZ6NTTMpzQ3+J2UgevlKLFjtTjdMig4twYJG6oakWW99xOwOmHQ4iadkIzfnydkZK63GORLcXqw1OstZ+kiWj3FQ8yZJtYt335WBwckJhpkY1GMXlfyM295kbh1L1dn6HDua92rspzPShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KQ8PxZItsxrmUfOvO5xK16t1lWi0K/hGf3/UQF1JTQ=;
 b=b2A8wZvpN++v73S9+FgnHmxsF1WV4dZQrFRCH1jGpIX9MZp75PY3m5Y1MD2A3HPaHUjWt4+YdE74xD0Ec2UKh2TT0zmuyMCLeoh+FueseNgsJbOSHTPU+JnaofulMQz879GBNTAzpmZFcHlAHn6DyL8wuS/4Rrhivmg7G58krQY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA0PR10MB7133.namprd10.prod.outlook.com (2603:10b6:208:400::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 23:10:45 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%5]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 23:10:45 +0000
Message-ID: <389f9eca-7be2-d43a-bc3f-f638b955b55a@oracle.com>
Date:   Fri, 16 Dec 2022 15:10:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: move folio_set_compound_order() to
 mm/internal.h
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        willy@infradead.org
References: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
 <20221216142733.e2a716a4cd7ea55240d98391@linux-foundation.org>
 <963ba9b4-6ddf-39bc-85cf-2feef542029d@nvidia.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <963ba9b4-6ddf-39bc-85cf-2feef542029d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA0PR10MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bd6731-559f-4179-fba4-08dadfbac296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dyq7DWQqcA4QHKqLAtXurGK/fMSBBMZdXE1nEbZB98sG9f/9qLSFuCLVkE4oIApkvtiaXfPYvm3QJB+GjEUqHKFaqyAwzYxoP4f1RENAORk8m6NarHo8Fw9L2q4iPsoD5nnXY7bSFpM/20wr6SmRvxIryV4/peDSAyRRsikWz8oSsIWyPNc0lAtpCvtg8kG83+eyOZ7aAG7QneACyMUANNDJHuS7vFIb1W+oemWjqCX9gleX3EJfE+IhfBNJzQKeyiSNB0qhNWiTPdR3EiLM4S4iu20eQ70VcNgOxsQ6L8ByZHgJpsLsE2dNTjw+gY+70D4NQ9F6ZPjNCKeUlSmYoGIwSWE6o6mxnhMwecVBARp9pwvjAHYqO/66s7dJcSFn/mynrUIYiggmfogZUr5NH4yJyXnSFwjWq9HSLtQS+CLuh+FrXWAlnvbFBvWEnm4gQSp3p8qWd2x5E0SY5EYT3SlmG7EkTsBRYH9C3S4xNerqq16YblrkJAogNPpIea2/Xf/nM8wSlzkaK5RO/VVhP9oyaX4F03hQM/HSTqleS6i8CgTzDg/Kxh5Wod+ZSiNTNz6RsCY8TvjufQAj9IcuWiuNylH/xLUoGU2bCFBQ5Xla28pko7F/ED+i8OitIfmLhtVJ8OGM24UcWI4e80vi+p76K9wR9onJ2QMt/qyEdNhPZPoOLajosRdOFt1IqpgSK7NlzpFc0/6ZCZYRIFu5KKjysybZlZY5SG8aIe/grRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(31686004)(2906002)(44832011)(5660300002)(66556008)(8676002)(41300700001)(316002)(110136005)(36756003)(4326008)(66476007)(8936002)(53546011)(6486002)(6512007)(186003)(6506007)(26005)(31696002)(478600001)(66946007)(2616005)(86362001)(38100700002)(83380400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGhaZzFsdDE2bTBGSThibFZINzFsdHhUbmdvNjd3eTRXY1lTQ21OVmRpMmd4?=
 =?utf-8?B?NEtjcEtaUi9qMzNqRVJjeCtxd1ZFbmE0YmIyWWhEM1U1bjdCTDBmQmJtc3hC?=
 =?utf-8?B?TEZneDRhdnJFTTdzYnp4ZDVUUnpjSUxaTGsxdlltSzRWU0M4dFM3SThpVzNo?=
 =?utf-8?B?UmJtamRBMDBrT0U4bUoydUU4cGM0NzdDSVB1NEE3VjdXM1dIajhzTzZqNWRx?=
 =?utf-8?B?UXVJYTZBb0YreUc4ZVg5aUtFL2ViVUx5REdnTjQ5aWlMVTFHMExObDMva0hJ?=
 =?utf-8?B?RnVnaDdtK0hWT3NKUXZEazlPb2lZdnRUM1lwNGxKUEsrMnYyMHRRazRxL2k3?=
 =?utf-8?B?YkFKa3dCK1QxNUE2S09CUjE5ajRieDh6SmdpQXpXcHdZWkFXenVnbjh2Z2Ni?=
 =?utf-8?B?WnczSUhiR2hLTXlnNmkwVDF2VDROcGEvNGN6c0VocmowQTBLVldPb05aSGl3?=
 =?utf-8?B?aHdnMzFqVStFaC9scEpvVWlDODROMjFqMlhJbzFTUW1uc0t0TFVpSERESVEx?=
 =?utf-8?B?NzBrNEkrSDNDMlJDbnlzU1Mwa1lqSWJMekUxSFl4L3JPVDV6b3ljK1hQbmtW?=
 =?utf-8?B?ekdndEoyK1pWM2pYWkpZK3FpQkg5VHNES1hFd21oSUNVTDB6WFJ0aWhaTVZH?=
 =?utf-8?B?Nm1rR0U3b0xwUERpZlc4aE9nSFU2c3JiNGNsVU1ZUEIzbDBCVlZXWnJWNlJD?=
 =?utf-8?B?aFVyYmNmaWpsM1lYQ0FoSzAzVS9IWXFQclZheEVHMzB5OHVTcUlqNFVSaC94?=
 =?utf-8?B?c0hEdEFiN3lCUXZXVUtrY2dpQStxdDZ6WjNUMDNYYWkwTnhhU0FJUFUvQlVu?=
 =?utf-8?B?NDhLVWNIUVVxaEZLV2VZRUFhMjUrbXA0UTd4dlNQVFdEWnFQT2M1REx5OTky?=
 =?utf-8?B?TmVWYTNBNEQ1enNlbi9UcjVrVkM0eHYyNlVZTGZXOTMwVGxSRXB4Vzgxa1FY?=
 =?utf-8?B?bFVrZjJWVVRYWk5KU05PY1Vpak9xbzhSUTZpWU93TEZhUlNZN2dWQlV6OFRU?=
 =?utf-8?B?MXZINVRUekdxY1lBWjZjNUtVWGkyL3h1Y0E3UzQ1M240b0RkbFFHY1BId1ZW?=
 =?utf-8?B?MVQ2YWI5VDRLM1lWWS9XeldqeVI0TUJiTVk5c3NtRWZSZGdhMG5RVGFpYllL?=
 =?utf-8?B?aTFvd3hScUptWTl5U0RFUk9wWVM1N3JiakNQalA2UGtRQlhSd3Z0YkpHVlpY?=
 =?utf-8?B?dW51d1B1bG90dDFXZUh3WUh6d1dmeFAwdFBMeHBoRW5XUE1MN2ZpQmlkSEk0?=
 =?utf-8?B?Z1ZNUmlRNVFUQmFMSFJkZkFJTkZ2T3VHZTJTMWlQaG5HZnA0eHVpc3dXRU1Z?=
 =?utf-8?B?MmpwY00yclZwTzZtK3NNWnRWT2lPVEVsaG9VcWZJUlRZaVVMd1R3SUNqbkJY?=
 =?utf-8?B?TjdsbVdBVUhjb0RjbTJCMkJBa0QxRVkwY1RGdHBwbk5aU0NURTBWMWZiVEE1?=
 =?utf-8?B?QmxvbnBGT050NG9SaHBXWjJKdEhrcXNIZzBuNHQyWVRyRzFHMmNoeUFQUnd5?=
 =?utf-8?B?MFNzb2IxeE1BMS9uL3R2WlFRYkZVcWVMWWJwSEo5QmcyOXBidjZNZGwyUkI2?=
 =?utf-8?B?Q3UrVXliVU83OEZTejY1bW1GQU84WEpoa2o3VEZhWkZEVkVyZDBZS2VJbnRh?=
 =?utf-8?B?cW5BL0Uwd0NtSFFiUUhTOTlBZ2ZKc3NDTHB1MDVOVXFZVldBUjhOdyttMXRE?=
 =?utf-8?B?ODd3VVdaelRUQmxGMUI0WlRWdkdyM1MxMys1RXp1YUpicXBYYTFFZGE5Kytu?=
 =?utf-8?B?ZktPYllHVXI3eGhPSlVMV0V3MmNkdzJCNHAySmtpZmg3L0dCSmdPT3l1WGJL?=
 =?utf-8?B?Z3dyb1dzWUJ3K0hZV0J5eGkrU0ljWE80YUI3RStTVU5uVDY1NkFUMWJvbG00?=
 =?utf-8?B?ZUJRdk95aS9iUHNNUXlOWFFWTVRXbGp6T0RCQXRUTWpWWWFLR3VucGhjRTc4?=
 =?utf-8?B?QjZCR052NlYrK2lTRWwxS3NVeGZCS2VyeXpPNm05NWNoek1ZMzdrdEFqTFhS?=
 =?utf-8?B?aHlmenQ0cjlTQ29taGFYalFURXhMcC85d2M0WTFBbWhKYjVKUVJuSE9SbXhx?=
 =?utf-8?B?OGFEbzhlUFR3RXRKUUwxTHZsTm9sY3orVzhPQkYrc1AvbXNTZjBiWkJiNmlW?=
 =?utf-8?B?UWZjcXJTMmVaaSt5ZEdWMnVXZ0hXZm5UL3lpeHFkbzgwUFpDc1hFOFdpdytE?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bd6731-559f-4179-fba4-08dadfbac296
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 23:10:45.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DLBWOfsZYC2XYLrMrd6bD1gCIyjzf3DCuzfsZmnY8iD/TPUrTOgGBSslnjvB8UxhtuARckld+ppPZxFlEljGSBrEcqK0T7kcNLMouTe+wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212160205
X-Proofpoint-GUID: eJu63TERvmvzoKo0ZjLux_8uWx6HXiD2
X-Proofpoint-ORIG-GUID: eJu63TERvmvzoKo0ZjLux_8uWx6HXiD2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/22 2:56 PM, John Hubbard wrote:
> On 12/16/22 14:27, Andrew Morton wrote:
>> On Tue, 13 Dec 2022 13:20:53 -0800 Sidhartha Kumar 
>> <sidhartha.kumar@oracle.com> wrote:
>>
>>> folio_set_compound_order() is moved to an mm-internal location so 
>>> external
>>> folio users cannot misuse this function. Change the name of the function
>>> to folio_set_order() and use WARN_ON_ONCE() rather than BUG_ON. Also,
>>> handle the case if a non-large folio is passed and add clarifying 
>>> comments
>>> to the function.
>>>
>>
>> This differs from the version I previously merged:
>>
>> --- 
>> a/mm/internal.h~mm-move-folio_set_compound_order-to-mm-internalh-update
>> +++ a/mm/internal.h
>> @@ -384,8 +384,10 @@ int split_free_page(struct page *free_pa
>>    */
>>   static inline void folio_set_order(struct folio *folio, unsigned int 
>> order)
>>   {
>> -    if (WARN_ON_ONCE(!folio_test_large(folio)))
>> +    if (!folio_test_large(folio)) {
>> +        WARN_ON_ONCE(order);
>>           return;
>> +    }
> 
> I think that's out of date?
> 
> We eventually settled on the version that is (as of this a few minutes
> ago) already in mm-unstable (commit fdea060a130d: "mm: move
> folio_set_compound_order() to mm/internal.h"), which has it like this:
> 
Hi Andrew, yes this version that is already in mm-unstable represents 
the v2 of this patch which is what we agreed on. I think the patch 
mm-move-folio_set_compound_order-to-mm-internalh-update with description 
"alter the folio_set_order() warning" which was just added to 
mm-unstable should be removed as our discussion lead us away from that 
version.


>         if (WARN_ON_ONCE(!folio_test_large(folio)))
>                 return;
> 
>>       folio->_folio_order = order;
>>   #ifdef CONFIG_64BIT
>>
>> Makes sense.  But wouldn't
>>
>>     if (WARN_ON_ONCE(order && !folio_test_large(folio)))
>>
>> be clearer?
> That's a little narrower of a check. But maybe that's desirable. Could

Ya I think it would helpful to have a wider catch for the warn as any 
user calling folio_set_order() with a non-large folio should be aware as 
they could misuse the folio later on even if they passed in a 0 order 
because order itself would be an OOB access.

Thanks,
Sidhartha Kumar
> someone (Mike, Muchun, Sidhartha) comment on which behavior is
> preferable, please? I think I'm a little dizzy at this point. :)
> 
> 
> thanks,

