Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2371D622CF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiKIN4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKINz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:55:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF8DDD7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:55:57 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9Dl9WK017489;
        Wed, 9 Nov 2022 13:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MoSnuwU/pqOdFc7MKJas0bbeN8NaEX9pl/8y9x5XR0U=;
 b=1WYoj1Vgiel15CW0fiR2MBj+C68I3FZxAzAGIksvMwN5JRVdMTIQt8RyxESHlwhAmkfQ
 P8Rx/XwnB4lm7v7gCig1t5y40KulJ1zMGmQeOYxPkOj2sCracMA3waW6zWvy+PRK0jPf
 f0J5kJgRGmSdHhNpO4Pwvu0Dg3rnkfbgwTgfVqaU3Tf/enhegkEnNrRvXDxWim3LgHbE
 zIwXUCXE6we3YlJXDsYUy+mPDgahzP4Yg2kPsjPRLj6N3PFIUrXBSTgKT1IMth+R/Y1u
 DBuqBukblZfSjv4nxK63xPQIpYhXsQ0TG61VR1jUAwGcuLriPnX8Y3m6jm8w6dMf9zxV pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krdd28139-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:55:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9CDYWt040156;
        Wed, 9 Nov 2022 13:55:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqhgjs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 13:55:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkM8faIyANM11TzPg/XU3JorUdcTVuekiAOPpyawS7PW4txF4YcoxLHUM96sYI7nHG0EhqHAHtTSGmDRz90WqylA+Nmxhr4/D71j+i/h7zxggddY36Mokax18knT7A+4puMtKPubBZNIe6rUwzl8u6+7RdG/bxAYUoDV7mdnQblc7XCgf3Zy9BFk2QJsnio9Jw7M7Uv/zgMn3ue0qCzWeil6xnXPXP2Lewfo9chmjFVyainYoIT82OJol+nTETMhbNWSIDjxGqgqLp833HZ136c0vS6CSUhw0JA08WQyr0QOpUC4YGNgve3+HPw0IjGYK1iIcxYZ92GX1oQn8q5JAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoSnuwU/pqOdFc7MKJas0bbeN8NaEX9pl/8y9x5XR0U=;
 b=k/O+QpK6Fc3mJbjU1aAZuLInAOmJs4SJwIK5jlhqjWNkD4K7gxwbg5vCqSNKc7p1IPXH+iwo8GXOFfakl9tr7owcXjl9EEdefFzqO2882fDtJy8z6FvNk5Tl4N7h0eTsk+Mq6hw+Rriv9qVshT9DYhoU+svJ1Mi07gPjoLXn36FDdcvACb38LmX9i72GNzaZ6kowbSFcOMRcurdBtDu1H9OSkL/ImANTnbswYUATvdyOzuwzltqEtGplKL3I7yIChpI8D83P+VSYBP1I6oXwlQuWdMVrb6aB/N935EZ94M3ZgCmnK0FGeyetmrtljdV5/Izs3U/z0CYyoT7R1+dtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoSnuwU/pqOdFc7MKJas0bbeN8NaEX9pl/8y9x5XR0U=;
 b=Ce+GXAx6eCPvsnxGML54zAbRDY9gm6GPFUQatQAax7/LJc7gQReXBYv8mR6QWBelsegcDocH/9yv8xVu3AAk/LyT6ET81ejbQYquLfxhaSdnpM8VUh6MNFUejgkT0z54JOfA2VFh/G1UhGh8dmZJe80hHeyBqhwRmP2zk4rSOEs=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CY8PR10MB6634.namprd10.prod.outlook.com (2603:10b6:930:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 13:55:13 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::8068:ac8:217c:a891]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::8068:ac8:217c:a891%7]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 13:55:13 +0000
Message-ID: <3d7e864c-e5d4-61dc-bbfa-8e0eb73adcee@oracle.com>
Date:   Wed, 9 Nov 2022 19:25:02 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [RFC] iommu/vt-d: set default value of INTEL_IOMMU_FLOPPY_WA to n
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
Cc:     konrad.wilk@oracle.com, harshit.m.mogalapalli@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Darren Kenny <darren.kenny@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20221108125855.2984751-1-harshit.m.mogalapalli@oracle.com>
 <dc463b3e-2875-8aac-aca1-edacb90e5650@linux.intel.com>
 <76cbad17-ab5e-3dd9-cf94-df2b26748167@oracle.com>
 <362bac0f-3dc1-b5e8-2bb7-c8e0f546eaa0@arm.com>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <362bac0f-3dc1-b5e8-2bb7-c8e0f546eaa0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CY8PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 47efc435-51be-4325-dc6f-08dac25a0612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AyWKUyksZLvrfa+WNy7JSYyohqFYt3n7m9s8S5aduYry5+iejxFH43nF4u1ZptiEAGNWJBkxc1OsSPHpQyKMWMdOuHQIzUTc9HljV5879en/yGJaJkeDtdVTuu0EWuM3Qb+BNGZ4J/6ofVQOrAe2R5Q84WeiSxnZSGtxfDRZ2J2CeBStFPUzgAZfqHV5JMbhKIJCaUDAh81e7rcD/SzKqgtkEd3MFe7l6giw5O2nHByMQyAtsaxuGTaTc+N4OAd3YET8BYGgEh0omI7UOoV6On06D/p4+vkY/DSq92E0xiFqBvoCpeqbiURUlJ1SZ1fq+vG6dwJb7YNcmDR2aJHeQylx5Our+Z2pU4zbmOTfpxxyGp0RGbtBsA9n4R9wZxAgz2JAppSRbujyS9YQMm/97vVhvlN9+b35rJWETU3NwBuvqKqHcRj+ngd4/TAX1zuoHWcrEZ8HSn4ZbHgroUYHBBNHSlCXD4npQXQSw2EmRwd+0K9B4Ej6+2uwh5srtFQyGQOTgSjk+gVPy125Prr2k9cy/NUPDKpbPqv0Eil9owcf6p3cIY6xqiMaXaE9gDUJPRujY/Sqaua9Db1NHVJCOFxSHZz2S/mJ+McrlwS9360MFG0XYuklgF5twV838eDjJvAShQQL9QwDZHnksKBnE9j79gEn8gc/oiuMhfzR/ZoxfhftKwyT2gK4rouONCjk0SuGkj//X7sM4RQ7aGqYIqT5jehRBWoMim4aP/snrG2eXDdaib6XWR7rftuyrRcx164wQ4bEViM97EtO9oWSn2O7WyZfCngAACxEfj5EKJ8DhrDWbFi/rRXf+D9APiww
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(31686004)(31696002)(6486002)(86362001)(2906002)(53546011)(478600001)(38100700002)(36756003)(6512007)(2616005)(26005)(6506007)(83380400001)(66556008)(186003)(66476007)(54906003)(66946007)(110136005)(8676002)(8936002)(41300700001)(6666004)(316002)(4326008)(107886003)(5660300002)(129723003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRFZHR0TitSRUZxdFdYZ1BucXFvYzdhdE1ab0RtdGlSdEZEK0hKdnJGWFBC?=
 =?utf-8?B?bE9UWkFmMGVsRlJnR2NKbDA2YlVSVHJTa0k3YjFlK21YZVZacVB0Z3pHRTRw?=
 =?utf-8?B?T21Za1BTTHRDZEFPTjdLYklWcFhES2hFUURDY0RjMnBHZjZNWHRKakdpcU4r?=
 =?utf-8?B?am9CNGR5RTlucWd6aldxbVNaYnNEWWw1M09pWlY3RWNlY01nU0p0bzlrVnV1?=
 =?utf-8?B?cWRWbTN2TUN5bGpibFg5bzBWUVl3TnpPTlhyTG9aMWRKNHVNNG5uRlF2OEdm?=
 =?utf-8?B?cE1EWXc4c1o3aWNUSXQrdG5wRnU5eHl6ZTJWdkN0dlNYcVcxeFppcW9wYzQz?=
 =?utf-8?B?Y2l2MHZVQjd6azM1dW9ZNXNXaXE5dnhhZkl5Z3FwRHBad0ZmdCtJWlZ0c0l5?=
 =?utf-8?B?NG9TR3ZTeTcxU2IvSURRUFEvUytrRmJoY3RuV2wyMmMxQzIzVHhxNy9CRGpH?=
 =?utf-8?B?a0Rsd3N5cHo4eXJocTVJa2FtT3k2ZTFHUElPTEFxWnptL2x0RVRwcUVTS2FR?=
 =?utf-8?B?czBWYm1abVp2RUlacWdQZ2ZpZnZJTk1uSjI0SS9USUsxemZyMDFQQXYrcXZ1?=
 =?utf-8?B?V2NtVlVPc3dBVUFBakQ2TFhCN3NVOXdCK1FQVVFvbjMyMk5uUG04MTc4WTR0?=
 =?utf-8?B?TmJQUDNQdCsvS2RnTDJyNTB4N1owOHl1bHR3L3dZM0RabVJxeDJTVmtGQkkx?=
 =?utf-8?B?OW93M01Cd3g1YUM0dkRNUzhJQVJjUU1Cc2pxSW52QUdWU3dWWDJXNlErVWxZ?=
 =?utf-8?B?RlBPMlU2L0VaemtGZ2NPZFpWcExoV0gwVnZKRjliK1cvZ0NZMzZQTnFGT0pl?=
 =?utf-8?B?S3lxVTIzK2tqTzRiRXBQV1BHVHJPTWg0WE42M3FFcjgvdU5xc2FjNmg3akh3?=
 =?utf-8?B?SzNlVkx3bG15MlBCb3RONi81bW1COUdpWFMvRG1JRmpSQnRENEV2TGtYcThO?=
 =?utf-8?B?ZXRCdk1vdUJHOGtEWnovVU9STzhUMjRDWXZEOThTeGtFWmk4RldoMUE0cU5P?=
 =?utf-8?B?WmJ5Yk1WS05mZDJ4Rko1K2U5d0VDc2RWZVVoOXFFTzBaOTBaZDYvMThyZlBs?=
 =?utf-8?B?VmMzWXNXbktieUY4TVlTa1UzeEZWVUVyM2I3K0RQMU90RkRyMGhzeVRjdWNq?=
 =?utf-8?B?N3dOSVpRNUZYVTdwallibmUwejduREorU0RNb3M1aWhhN3NHZlR3aUFKNDhJ?=
 =?utf-8?B?amR3c0hCWVpTWGlIMnNPQXhCY1orY3ZrRENuaEdoN1FxbkNyRGk0azVUWXgr?=
 =?utf-8?B?dXgyS2FldVdHNjRnZWxGMWEwaFRLdmZsTEVWRkFON1VjQ3JVV3Jqby9CNkhC?=
 =?utf-8?B?bWNGaE5COFdwTWZ1bFFhU29OdzhPT01sQXlOVjZ5VVpNbktKMENybm83RG83?=
 =?utf-8?B?U0lMQ1Zock4vdTQ0S0Nxd29uTnRXRDFCZVh5VzJDT2VGMDBOSTAzTDcyWnF5?=
 =?utf-8?B?UEhwamZsY3pNSXBkMTVFQkFLRytVclBFMVQzckhFREVMeW94MkVtTXlRWkNn?=
 =?utf-8?B?eitML2ZNeVcxdkt5akkxMklZMUVtaGxiY0RQS0dhck8xYUdubXdoVHlOSm1T?=
 =?utf-8?B?eWFhUnNXUXdSL1ptYnU3SytEejk4VTlMQ0lLR0VoQzNNUnM4SjVxZnJkVHdk?=
 =?utf-8?B?YUo4VWZOSkxQd1VHNS8ramlQOG1obmVNakFkNmdVVFVodmxLYlk5b2dqTjZu?=
 =?utf-8?B?aHVVaWVJZk1LQlZreHc1OERwSWhWaDIvVytxdHQxdTAxd2JjK1duNHNHODFz?=
 =?utf-8?B?WnVUTjVUOWF4TmtKYWNtd21LZkpQZ25BcjVHNU9BOGtqcVkrUHM5cGhZdFA2?=
 =?utf-8?B?RDdvS3ZwZVVORzI1N2ZPdFVteUl5TjIwaFQ4dWZwSlBzTEl4R0ExQjhlSmNE?=
 =?utf-8?B?dzNDcVJYMkZUclpvd2hwbE1mcUR4TDBBSWUreWNwNktjemtaZ2VHNXI2eHNt?=
 =?utf-8?B?bHZwbjB5aUpTZlZ2TGRKeC9CRnlTRkNIclgvcDJHRmtwSVhMeEhEOW5raTg4?=
 =?utf-8?B?OGxESFZVL3YxdFc0b2h3a2duOFdXd25DSE9xK3crN0FPMllCTFBHUE1DSnJx?=
 =?utf-8?B?ditkV0RGWnJvd3ozOE5COTRrNjliUVJ1bW1WdlpNVDJGMEszblExMTVoS0w3?=
 =?utf-8?B?ZFc2ZWZLUWl6VDVlV2pZVTAxVzhZNkRwMFZJRGk3UzhGM1lzR0JZRXZyT1Fz?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47efc435-51be-4325-dc6f-08dac25a0612
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 13:55:13.3915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CzNXpBywnEr8oQYcrrjfOflHN8GNt6owtzOPtY7lCLWNmrUlXt+n5OcL6YUGP3s535bAjWbMryvwsflL0nTF0UcL4bze49F8Ek0NMrMYRXjF02JoeTT8ztdD2LR0Lpl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090106
X-Proofpoint-GUID: Ku4fzy8dd-0xuzRGpZdvCAgB6YcuiOLy
X-Proofpoint-ORIG-GUID: Ku4fzy8dd-0xuzRGpZdvCAgB6YcuiOLy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/22 6:56 pm, Robin Murphy wrote:
> On 09/11/2022 12:16 pm, Harshit Mogalapalli wrote:
>>
>>
>> On 09/11/22 12:35 pm, Baolu Lu wrote:
>>> On 2022/11/8 20:58, Harshit Mogalapalli wrote:
>>>> It is likely that modern intel motherboard will not ship with a
>>>> floppy connection anymore, so let us disable it by default, as it
>>>> gets turned on when we do a make defconfig.
>>>>
>>>> Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>>> ---
>>>>   drivers/iommu/intel/Kconfig | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>>>> index b7dff5092fd2..c783ae85ca9b 100644
>>>> --- a/drivers/iommu/intel/Kconfig
>>>> +++ b/drivers/iommu/intel/Kconfig
>>>> @@ -76,7 +76,7 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>>>         option is removed in the 2.6.32 kernel.
>>>>   config INTEL_IOMMU_FLOPPY_WA
>>>> -    def_bool y
>>>> +    def_bool n
>>>>       depends on X86
>>>>       help
>>>>         Floppy disk drivers are known to bypass DMA API calls
>>>
>>> Nobody selects or depends on this. How about removing this bool? Only
>>> less than 10 lines of code are impacted and are not in any performance
>>> path.
>>>
>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>>> index b7dff5092fd2..5e077d1c5f5d 100644
>>> --- a/drivers/iommu/intel/Kconfig
>>> +++ b/drivers/iommu/intel/Kconfig
>>> @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>>         to use physical addresses for DMA, at least until this
>>>         option is removed in the 2.6.32 kernel.
>>>
>>> -config INTEL_IOMMU_FLOPPY_WA
>>> -    def_bool y
>>> -    depends on X86
>>> -    help
>>> -      Floppy disk drivers are known to bypass DMA API calls
>>> -      thereby failing to work when IOMMU is enabled. This
>>> -      workaround will setup a 1:1 mapping for the first
>>> -      16MiB to make floppy (an ISA device) work.
>>> -
>>>   config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>>>       bool "Enable Intel IOMMU scalable mode by default"
>>>       default y
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 48cdcd0a5cf3..22801850f339 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -4567,7 +4567,6 @@ static void intel_iommu_get_resv_regions(struct 
>>> device *device,
>>>       }
>>>       rcu_read_unlock();
>>>
>>> -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>>>       if (dev_is_pci(device)) {
>>>           struct pci_dev *pdev = to_pci_dev(device);
>>>
>>> @@ -4579,7 +4578,6 @@ static void intel_iommu_get_resv_regions(struct 
>>> device *device,
>>>                   list_add_tail(&reg->list, head);
>>>           }
>>>       }
>>> -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
>>>
>>>       reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>>>                         IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
>>>
>>
>> Hi Baolu,
>>
>> I have a question:
>> Shouldn't we remove the code between ifdef-endif statements?
> 
Hi Baolu and Robin,


> No, machines with floppy drives may be uncommon, but almost certainly 
> some are still in use and being updated with new kernels, so we should 
> continue to support them.
> 
Thanks a lot for explaining.

I misunderstood the code, I thought when we are removing ifdef-endif 
statement, the code inside(within ifdef-endif) becomes redundant, thanks 
for correcting me.

> Do you have any practical issues with the ISA reserved region being 
> present, or is the only motivation here to save a few bytes of code when 
> it won't be needed? In the latter case, making it "def_bool BLK_DEV_FD" 
> might be sensible.
>

No practical issues seen.

> (For the original patch, note that "def_bool n" is always a bit 
> redundant since plain "bool" implicitly defaults to "n" anyway)
> 
Okay.
How about Baolu's version of the patch, where we are removing the CONFIG 
item from Kconfig and ifdef statement from the code in iommu.c?

Thanks,
Harshit


> Thanks,
> Robin.
> 
>> I mean something like this:
>>
>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>> index b7dff5092fd2..5e077d1c5f5d 100644
>> --- a/drivers/iommu/intel/Kconfig
>> +++ b/drivers/iommu/intel/Kconfig
>> @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>            to use physical addresses for DMA, at least until this
>>            option is removed in the 2.6.32 kernel.
>>
>> -config INTEL_IOMMU_FLOPPY_WA
>> -       def_bool y
>> -       depends on X86
>> -       help
>> -         Floppy disk drivers are known to bypass DMA API calls
>> -         thereby failing to work when IOMMU is enabled. This
>> -         workaround will setup a 1:1 mapping for the first
>> -         16MiB to make floppy (an ISA device) work.
>> -
>>   config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>>          bool "Enable Intel IOMMU scalable mode by default"
>>          default y
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 48cdcd0a5cf3..2c416ad3204e 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4567,20 +4567,6 @@ static void intel_iommu_get_resv_regions(struct 
>> device *device,
>>          }
>>          rcu_read_unlock();
>>
>> -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>> -       if (dev_is_pci(device)) {
>> -               struct pci_dev *pdev = to_pci_dev(device);
>> -
>> -               if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
>> -                       reg = iommu_alloc_resv_region(0, 1UL << 24, prot,
>> -                                       IOMMU_RESV_DIRECT_RELAXABLE,
>> -                                       GFP_KERNEL);
>> -                       if (reg)
>> -                               list_add_tail(&reg->list, head);
>> -               }
>> -       }
>> -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
>> -
>>          reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>>                                        IOAPIC_RANGE_END - 
>> IOAPIC_RANGE_START + 1,
>>                                        0, IOMMU_RESV_MSI, GFP_KERNEL);
>>
>> This code is introduced in Commit d850c2ee5fe2 ("iommu/vt-d: Expose 
>> ISA direct mapping region via iommu_get_resv_regions")
>>
>> If others don't have an objection I can send a patch with the above diff.
>>
>> Note: I am unsure about the code internals.
>>
>> Thanks,
>> Harshit
>>
>>
>>> Best regards,
>>> baolu
