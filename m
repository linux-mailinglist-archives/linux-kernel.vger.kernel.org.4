Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB136475F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiLHTFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiLHTFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:05:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721AD8F098
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:05:21 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8HhjJe013208;
        Thu, 8 Dec 2022 19:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F9wwaTN8iqNO5eNX/cHqRztrlFmjmQmPLbz7VVsy4fc=;
 b=oC0+137TnGVur3uoquPx+fJMSmyxUbct7Z22zsjshAB0wfmVXe+rPesptA5dbyNbEE23
 DgMgMHtOAaoTvoftwvrbhpv9AIFKLD9dF0dtKRenuLZyJNTNIx8YHzc9x605wyjZRVzg
 ZC5ha2z3DnOsw1R2btzW1qZ7KuWw96D9EN22rstWmBZ7E6t2jp8S2eGM+MSmfeZTMeKC
 zPkr10M8BGls2p0MmOGG9hnuwxXYrpsWTWADFgudzKknJm/PLkz3W6O8YTLtSxmxKJMq
 qwRVMO6syzFZbxEhxtGHDs511hq4pLQsxYIfdZdt9ogrP4S5WoCQyjSpIgehcE81pFEo MQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mauduugsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 19:04:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8II8HI034467;
        Thu, 8 Dec 2022 19:04:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa4sfe28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 19:04:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTYifCfz6YS3IEMkj7aB1As6bmGrWKuDCTSSlgVmGXM5+N3BX1QVEqIBQqET5oER1zWpOpxq3OwVGX5hdvX3roGTtxKjFs0s7168rOAIl8rYIVyZmrrYi98UD7BYP3KdV+w89RPYofheYs+S4E5kIlRLyoLRbvVE9o3T+A0ppxvVgMmWjVW5Vzyvqb3ry1rZNpGa1uDgtTGGAn0LKv5TPRx8h95OeRBTnt3Fwg3630xhl9D+sqBaB8fYjI7kTv/bvKmtoA4wMvdmmlfIWm03Q0A/+ngIQGL+HuVeL95DWZ1gA2r7XhrQK9Jg8HlSTjKmTr/En+1z+owOgy+/qp66LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9wwaTN8iqNO5eNX/cHqRztrlFmjmQmPLbz7VVsy4fc=;
 b=ORtla/ENp06QJB1ATwB9xXe327OeXo1GIrMTPy+TBpLvykxTClMqPfIlRD8X6c0/NTHAsA8S54+JKyy01pTTCWTEKCTtmswJiXDRKUK3SScxwpmiZybYYByh3Cd8I3YNAMx4k13nNpPXbfSTQ/SxfnIK+bd3ElhRyALqEU/liBmisutwpfjnFBsrpcfddzFy8IAsILabb1KirRzJt1Ux7om4H2EFrWrSXCwnAb31vYTIvqkHWvqmYmYRWVh7ew3X/Vj8V9PspqygmAxzD1m2QmH/PnLasdhFgaHUgkE/TKH77BBLeoXh/E13W4NP5xdi62FfOh1+gFvAibpGyZZTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9wwaTN8iqNO5eNX/cHqRztrlFmjmQmPLbz7VVsy4fc=;
 b=zrQXUaqKNvHDDmkyJInOl2GBvx0JDIxPqOflBbok+cXrB9PmXWl92lTYIV7hsJ/AFaR2cIKtSCtQjgxXmJRrqCnFB8BK6kOx1rvhgqZK6gvfqEEd1UKJrpvGhA6lCKMhSd85rilJJz6Iy29SZ3BJusBhF39cINZ+ESPRQVWBqM4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 19:04:43 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%9]) with mapi id 15.20.5880.016; Thu, 8 Dec 2022
 19:04:42 +0000
Message-ID: <e3153841-6a20-f175-8174-2efc9efd8dc9@oracle.com>
Date:   Thu, 8 Dec 2022 13:04:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v14 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com> <Y5Bn2Y4ANWX0U89U@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y5Bn2Y4ANWX0U89U@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:806:120::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BL3PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7d0e11-c90a-4f59-560a-08dad94f1033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNwrX8in9ZAq0pOvatY20vr1K2667tu1z8eIIK1Jz301GSoOYnk3OWGI768sAryW+h3Eew222X5U+OLSpOO+4rkXUM7DA6m3Na02hj6ENAAMh2NZ9wfYNFjiXY0hKjFPp5ROqYxmWjbKzxGEds6GPN3AZintVH2v1A4lFvQlv3DO48h2SYM0von2gGHyZfIJ1B7cDC2wKCotwaTmJKdQ0HWiXov7ymAhHAjnQVGfUNEcTwn01slXBcGSegyZA0x2Ut8HGgGqokvkp8BiHmQcCVUF+Oxnh5xTsbLslvdrvy2IOwswGN53p1/g0DtoeDCJS3I+FXf770qg7pXWPQPAoLoIJw+Zzl7rHw2IsZsIri3wSBGYqNNMCMH7XmCtGlYx0KQ9LzyXWnQHr6gxYm0sKFWjlI3G3CPEpHqVLeGabz8AWCwdWMh5YZ+hAwiPxmhJgPsLQGZkFLYMXK5xsA08UlfI8V2a4QWGYs5ndBJeYjSJCOI5sd7mwqNxIpxPdzb+RPlrb/e8XLJkSh1SZKmppmGBR6orlMiwzpLpQEueNfobvEtUUilFdaIX+EfrEEaZ8vzPZQ/UTR9QvOqi9IouCxN4J2l3dW4FPbmxnHxwigtnSyYS2HvLEbTjrRTKlNsMSxWK6WRz8tc9T5wDUKwgozpVotd+bItiYabXfJJC4Nk0JizIxbUvuIusUmeppSQEbrQHj3/Ta8+1MV9ZLSRq0eaEj3Fr6HfQ+AmOQAuiQxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(5660300002)(38100700002)(8676002)(31696002)(4326008)(86362001)(8936002)(2906002)(7416002)(4744005)(41300700001)(6512007)(6666004)(53546011)(107886003)(6506007)(186003)(316002)(2616005)(66556008)(66946007)(66476007)(6916009)(478600001)(6486002)(36756003)(31686004)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0ExaW1FSGRYRzhGa1A4dGlaSUhvdUdJeHdBR2NMUFE5a1o0U2dJWE9Bckw1?=
 =?utf-8?B?d3JtQ3ZWeHpOcnJ1M20vVWVxNnFuZ1BqdmJHN0JJRndrZHBTZlFWRFd1QXN2?=
 =?utf-8?B?ZlBpWm1iaUxNSU16b2FGOHl5SFdURVZPYmx1Zm5QMk10ZHpjenRaeG5NVk1L?=
 =?utf-8?B?VDVsazBoYWZONjZWSzQ1cXJ4UkhpL0hGanUzdXJScGp4WHl3WS9FSnZHUXpL?=
 =?utf-8?B?dnVRODZuQzVadkRybjhMNzZCRmIwWm5YcHNhbzljcUQzT1RvVG54aDdBeFhT?=
 =?utf-8?B?SjA1THFqQ1hhVmdrNzJNOHFORktIQ1hpRG1pVkdVbjQrK1huN2IwQzJ5S0ZK?=
 =?utf-8?B?ZkEyYUUxNHBhbitlSTdsbUdqWkloVTh6WWlsM1FLNmZMeDEyeFF5bkJNMDRS?=
 =?utf-8?B?UnJqaHhSeENhTzdGUUtMTnpKUmhDZGhLMmxaUkJ2VDBDSzFJMGRnWnM4ejA5?=
 =?utf-8?B?d3NMUU5kdEJxUFd2a3d0OWlGT3MxNHdhMkJubXdTM0c2c0xCNHFDRm5vS2FB?=
 =?utf-8?B?TUovVDZmUkllNDBVSWpkWUl1ZkUzSTEvTVc0aTgxYUVNWU9DWDVXcTNFV2xl?=
 =?utf-8?B?ZE02Tkg3V2hRZ0QxR1B3UnQ2eGdiTHVFTThoYVNIQ1JRUHgwZndhVlZaaWxG?=
 =?utf-8?B?cWxYL0daWnFOWGF2YmRGZ2tnNDcyOEptd21tdDhOYncrTS8rNW5acUZoaWxZ?=
 =?utf-8?B?NVBUdlFvZWVQQVh5L1ZNK3h0czQ4Y3pjZWJRamZxa0lubEtBMDZFNVlNbVU5?=
 =?utf-8?B?Z1JkNVhyMHBTeXNuaXcxNlFGdXdnT1AzSVN0ZjRmdFVYaUR3T2tSOENPckRY?=
 =?utf-8?B?bllBc050ZHB1d0FPUWVRV0xINGZDRmxQREZvNFRjYWp3UkZJUkRFOWZnd0xk?=
 =?utf-8?B?TmI1SWFPVmsweGptY1lYWWQvd3dNazY2UzhqcXV3aG5EWWt6bWFUSE8rT2hD?=
 =?utf-8?B?WFcwTlhFUUlmUkZEN241T1hlRWhKZFFHZ3hrQ1NZQWVzRHAvOEt3SjFMRVFa?=
 =?utf-8?B?ZlJjSlNIY0JIOHF3cWVVUy9oM3ExWTJsZUhqUHdEYnFQdkordnQwTlV6NjlY?=
 =?utf-8?B?ekRDcUlJQk5rcW1aVEpueC9TQ3luc1F5aXB1YW1DZ2x0M3hheUdIaXJTUmFy?=
 =?utf-8?B?RmZwdktjaUVvd1JNMHBySzhBY1pyNmxDSG0wNENhR3lBQ2xLbUlwUlZmZi91?=
 =?utf-8?B?REtseW4wQjFKNVhuZmdYcElZeVdveFJPVGIwTTFjYXQramRSK1luaWh5dEtv?=
 =?utf-8?B?RzJtY25mN1dEUTYzTWFuOWV1c0t0ZFBVQitXbmtpVGxqVWpLT3NmMFlkdkxD?=
 =?utf-8?B?WU11WXAwNGIzWVg0QXNGWjNxQnJpd2pFcTFjNDRBU1dqbDAyMnhyQWtRZnVE?=
 =?utf-8?B?QmZ5dUpzdnIxQ2lXeGZFQ3h5WjVPSTNoemY5QzF3dHV1VEJkSVVXWTFHclJX?=
 =?utf-8?B?ZHRZUUNJOGFnazg4aVpRalZXQWRtcktQZ2JiaVJhdTdHdE9LY1RjMHZUT25v?=
 =?utf-8?B?b1cxSHRGZkQrTDQrNG05Mzc2M0EvOTF4NUJzdWtqcWpWQ2xGM2wzaGVXN1dU?=
 =?utf-8?B?UDZEN250cG9mY1Y0Sm5CZmZOSGJ5aDRTZys3QlAxcnFnam5wQWNUUm93Y2RP?=
 =?utf-8?B?TUNyTzFNNEh2NnJ1K21hQTBpZnlBWnBpb3lMMEJMdDZCamdZRy95Nnpid2JR?=
 =?utf-8?B?SkJOWGpLRFZtMElsQmVOeUJ3YUlxRmN0S3FWdmZ6TEFpSFRQOTQ4YVdEMFph?=
 =?utf-8?B?NW9jTEZjUnlTTzhKSFZaUU5EN1NnWGN4bGlIcTFSRDhpZUdWTFQvTCtITGZR?=
 =?utf-8?B?RS9zNFN2UUljVFI4cEt6WnBBRGlMSmFOZ3lPMm1xNWU2UnBlSlIxa3dkQ3BB?=
 =?utf-8?B?RnE5d0lVaGpxWngrL2NyWHZaSGthT0hVTGM3eERuQlhYSW9uRTllbXlYWGp3?=
 =?utf-8?B?THlEYS9OSHpDVWtRYzVMVFd6SEFTdS9oUE0vMTJnZUVWbEI4Ri9kRmlLY2sy?=
 =?utf-8?B?bHJGdVRTTGYxUGI1blFmMHVFQjZ4Uzc4ZFAwSEw2c2JxemlYWHdUVXF3MXg3?=
 =?utf-8?B?aXZwR1c0QnpqR2w4Z0U1dzZBTjExQm1MZC9vS20waFBjTVhvaXJvSDkzdGhB?=
 =?utf-8?B?SnNNN3dWRXJQeEZuc1BEY0JvYms4NkNzTjFOb3hmL1NxNGIydWlPb3FuTmU1?=
 =?utf-8?Q?1HV9p/MiT0S1UEUzb5fadCA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7d0e11-c90a-4f59-560a-08dad94f1033
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 19:04:42.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gD5CNT/v+/rjPJnSZfkvhWEtEayShYBOHKAS6vhDWmThhcGvYRGC1kNh2vML/OuTYJdZpRA8/0YVne0niybx0mOkKf2T72gNQszdzqLeKQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_11,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080161
X-Proofpoint-ORIG-GUID: -jjCjWzYHmCXCzDoesPV9ZgkG3f2qejy
X-Proofpoint-GUID: -jjCjWzYHmCXCzDoesPV9ZgkG3f2qejy
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/22 04:15, Borislav Petkov wrote:
> On Wed, Nov 16, 2022 at 04:46:39PM -0500, Eric DeVolder wrote:
>> +#ifndef arch_map_crash_pages
>> +/*
>> + * NOTE: The addresses and sizes passed to this routine have
>> + * already been fully aligned on page boundaries. There is no
>> + * need for massaging the address or size.
>> + */
>> +static inline void *arch_map_crash_pages(unsigned long paddr,
>> +					unsigned long size)
>> +{
>> +	if (size > 0)
>> +		return kmap_local_page(pfn_to_page(paddr >> PAGE_SHIFT));
>> +	else
>> +		return NULL;
>> +}
>> +#endif
>> +
>> +#ifndef arch_unmap_crash_pages
>> +static inline void arch_unmap_crash_pages(void *ptr)
>> +{
>> +	if (ptr)
>> +		kunmap_local(ptr);
>> +}
>> +#endif
> 
> Why is that function still here and why aren't you calling
> kmap_local_page() simply?
> 

Corrected!
eric
