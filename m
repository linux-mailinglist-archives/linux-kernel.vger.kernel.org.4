Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5364BE54
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbiLMV0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLMV0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:26:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C8862DF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:26:12 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLO8mR016099;
        Tue, 13 Dec 2022 21:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TIG+p19bCGlszanUSqVWC+PxpXzQLT9505FiIpN2ww4=;
 b=VdsXkbWtWPeVJZ3VmV3jqSeLZ2RFW5kd4Ixq3rSRQfFsNyodZP+khzSFCq1HFCshpNbW
 a8ZNEECIpoueYjeTJ5DCL2VUNHHY8IuCL6iY3K33J0i1bmYfLWSNoFRbi3TfU5PfDXJQ
 K6av9UEIqdR+FTWFcm6pnhH4M3YNMc4yTjA+XwCvXQLcmWVkLXgpnukHGOLZc863iVPD
 rtgZ4zuQOH2gIbyeZbfi8eWCyGFdMmPt+Z55pzeaKUmL/bR/Xy8OmfrEOmyhDaRY1Ls6
 rKzw7TBI8chaNc3SMnxDHmw6/4b3JBQFmdH0yqI7w/aOuuhOoPtX0H4dPkQPulcJMyBi NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewr9ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 21:25:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDLNK2j030241;
        Tue, 13 Dec 2022 21:25:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyenwwfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 21:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIz8DSjMXY0WJQOLKLArrgCoz47iWrgPKnVVavLYcg0g4SGbZ+DBHD0rkGhk8ts5vz3dfxAUE3JPvsgDC9OLIDuSqZDiwJbz2+XHt333X9IX18nyb3zMMihGt9sufx548hboRfDnWv0yRfIA0zHZozf4AFAg8ELBI7PlI0u8LiDiNNOBnJv5jY4EzrKjbLWgAyQf9tKlg3WU2rBZz7w8zmZNvmpKDvHOy8TPDuROK+FZuZshHGqyrxe0Zw26t/DaDqnO++5o30kpEYUt8c6EPHtgR4zjSOLXiaxky1QZBi2jylxU3yLnCUwnHa6KCZEcN5f4NpATEOzc2zPe9XxpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIG+p19bCGlszanUSqVWC+PxpXzQLT9505FiIpN2ww4=;
 b=Vki8Tq6ZKfJgxpy8aG/IBMzvJG88wDoyx8AA9IXpTsBjB/sdW2SPcS1dn9YZBvdzL56xqrcwYrJUxVIL7rDbCR49rhRjrIVHLhpIUzJlkbYx91W1K6do8xCe59ZaREqsHxtgLjeu9jFCgX+8se0ljmgzIlL6fPJoolpJT9cM2lZxNXTki9ZOnqDqC4WV/dqZsBEhqhZjbwAYkrogz8dJARuu+kjR+GKelfhg+KD4ynnodTpuq1PUHJHlgG8uP5oucdjbIAumyuQtrocvxBgkopHTjDC2HFbGVqOO0VzcbeDj1c/qnYX5iRtymqdqWUWVsofw1VQziIn5KO29vV1gUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIG+p19bCGlszanUSqVWC+PxpXzQLT9505FiIpN2ww4=;
 b=HlxyLxyYWpmA9tq4PoTy65nHrlOqJTBsS3OeTdPv/NmJZ1ckw+vreq6xgDeLvlUDY0hnCidRBVoPuMJkoiEFCNn9LyTsuvw42Pgh0hOxKXiJW/2dvLKsWdTfPMsKaDp2zUtYap3ntf0F5q1R9OdM4IavxCk9Lwn50tnCEXZT0B0=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by IA1PR10MB6194.namprd10.prod.outlook.com (2603:10b6:208:3a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 21:25:37 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::909f:fa34:2dac:11c5]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::909f:fa34:2dac:11c5%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 21:25:37 +0000
Message-ID: <9dfe87f0-fc95-6c28-6695-62f1f5403df6@oracle.com>
Date:   Tue, 13 Dec 2022 16:25:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
References: <20221208163650.GA3225@templeofstupid.com>
 <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
 <20221212155730.GA1973@templeofstupid.com>
 <20221212160524.GB1973@templeofstupid.com>
 <d1a2b785-edc7-b7da-d2f2-123d1555022e@oracle.com>
 <20221212220959.GB1935@templeofstupid.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH linux-next v2] x86/xen/time: prefer tsc as clocksource
 when it is invariant
In-Reply-To: <20221212220959.GB1935@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0059.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::11) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|IA1PR10MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ec1c74-08d6-4a2a-0a56-08dadd50939d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dYJgUXWvdKTRjz0AsFcgprMvM68enCUkIrHiVmiAYMiJ+ci3wtQVS9KduvHUYehp6TcGl7AGWp/Xh7X/A1pki+zmkb9sEO41pfv+klO1Q/f0qvc5D7FkKvaLmXBvtXs6Uta8oqTq5Td0Cs9atTdoxcQOMdFrZzpe5q5bZWYJdVbL+ZRBhf5Oxn0cp+QcnwSqU4TPEIN2vzbH3y/ZapmR46mRQ73I8V5XclxS9joPde1meYhQfDNYxg14AOOpz0NlFvEufszZr5QC0YSPvI0vUZKnzpjHUQb1dw8RiGsWLNxRMYJM6PbcgM2zlkPNt8WvqCYeYb6AFSOSaD6QdPmdhcTB/FQvktbwiL7nfxFlWUvn3rGzjyHVA2yXv5otsy65NcNImhaudxjCF33n4ZQwsTbWGqtrkJ1Q4lMJsn2dJv/e0A32hPm54qYVSSKKXpHvbVOKaj/7ch7PppPaih/9oQpYkI1CqZR8VB7lpTn6eK/z5G1f5ekBj442xF55N2vO5Qs3Fhj6MJiXL8i9DMHkxjZg+za4VU6exR3aPmtR/1IUUHHrlyhSf9j1DkTccdXwgkpIcMJeW2KoQQo8IZfK4yC2GddGge+NEl2dPaVUG6OwEMH3GyoFFlGI49fnNPalpqy3PxH5dKdEf+t+cXVBkc4RomKZy48sFQkgQF8UG5cdQ/bSHpGvrTrvkmhU/qqcbdrqq1CKYsRT4HhTm0Z05Z+3sYSSWwgIfy1OGsLEGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(6506007)(6512007)(31686004)(53546011)(26005)(8676002)(478600001)(4326008)(66946007)(54906003)(6666004)(66556008)(316002)(6916009)(6486002)(66476007)(2616005)(186003)(41300700001)(5660300002)(86362001)(7416002)(31696002)(36756003)(8936002)(83380400001)(44832011)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTBJVHhNQVpvUEVvdTIyTHNmQlVYM0EwcW1scklJbDNXRTA1YzJ3SWd1T1hr?=
 =?utf-8?B?OFdNUWdKT3d6cXo5Vm5CN3U4eGliM2pHM0tiOXBQWHZCbHd5Rk5Gd0s0QXQz?=
 =?utf-8?B?RVYreDVhZmhHOHJ4ditrWG9lYWxnc3JvbHBiMVdkRHNzVHFQWGtNY09mRkZ4?=
 =?utf-8?B?aFpnS1Vwck5lTVlZQmNHYmVyMm80Z1VJSjhEckxONVY4YjBmc3ZPMlNDK2Jq?=
 =?utf-8?B?cWtLc1ZIVGRWL3R6QjNOZytiVnpXamtZWjBDTkovMElZdUk4VDhibHRzenNB?=
 =?utf-8?B?L0xUR3NWZ1hpcmN5eWRhWFhkTTRxOFRKOEg5Y3NIM3V5RUhxNldJeTJUeGVE?=
 =?utf-8?B?dlE2SjVzeXdZaG12N0o0dDkySUVVOXRlZ0JzMnNIN1U1NEw5cHNPTXBCZVE2?=
 =?utf-8?B?REJsVm9yNHNDSjltQ2NGWjJTdXBUK1EvckdQcEgrUU4wbXA1UTlUVVJUM0Vp?=
 =?utf-8?B?YlF5VTIyTVRMbWhxZy8vNEVMN0xTZGdCbUxpUGRFN2Fib0hyUUEyU1VnU1Rk?=
 =?utf-8?B?SE45cDI1TWZHWDBTeExKMDZxYWo2cDZFWThXenhzQXd1RGhzcXgrc09sUlgw?=
 =?utf-8?B?Q3dZR3h6Q0o4cXpkUVBWc3J3VGhJemlua0hzR2NzUUR2d25DTFhRZ1J6dG9y?=
 =?utf-8?B?OGh6WEU1ZlZ3RWEybzdKcXVpcG1Na0lXajViQ0dNQmI0Rzh0MzFyWThUZXgv?=
 =?utf-8?B?NndUc2g3NlkrMU1YRG9rcjhZajlkUHMzcmxOT0d0UHdzcXhJVG5DQkkvNlRw?=
 =?utf-8?B?d3gvTEFkdW15b2FPR1JocUtDMUFXb2daS1Y1YkY2MFQ3SmRZQSsxbzVjbTRH?=
 =?utf-8?B?aHE1MjRiVzBEMW5BMjNFNDVsbXNzL0wyK2pENVhUUytEWFpjNWJGZmVmR0pZ?=
 =?utf-8?B?Ujl4R3RWakpiK1RzemVYdGlvbHVEKzd2SHIxK1laWldaRWpxY2tmUERobytY?=
 =?utf-8?B?STE0aWJRcWZqZlVOTkdPSlp0bjdleUpMTDdQbW1sRWxKdDUxOWt5dTh1VWY0?=
 =?utf-8?B?OUYxb2tXSkZEYVRZWDJSS2VyOWhocjlKbUhOclhUZEZaT0pkWUk5ZzVTVlgx?=
 =?utf-8?B?VnE1a242WG84QVhIVW9mbzJ1Y0RmaG9QK1FPVUk1UkQ5OEtNV01PYzRSY1dC?=
 =?utf-8?B?VUxOMFhKZGNxZXdBOUtMSER0aUdLUkNYbVZwS3hlNTlDcTNQQjZTblZVckN2?=
 =?utf-8?B?dDZpMkpxRmR6eTJkZEM1ZVZleUhUa1ZUMHpJK0Vod2tTdHlYdi8rNi9STjEw?=
 =?utf-8?B?am96aitHQUFnMUdlY0RxWGVHSkFBNjVnTjE1U3kyTFpDUlJTWHpmMUNVYzdV?=
 =?utf-8?B?WUFPbSt1cHhTWFQ3ejV6ZjA1enVIQWtVRXpXWC9NTFVPSFowc1VZTCttTHJy?=
 =?utf-8?B?THFVVlF5K1NSMGhJR2lkRFFXZ0FkZStmRjh5bm5xQm42dVdLcGlNYXNra3pK?=
 =?utf-8?B?L0tOWkZBWnN0RE9VV2w5WFNod1pXVFhUKzFMekhwdzFnOFloZmtnczc5T0hH?=
 =?utf-8?B?TmlwMjc1MjVzdSs1ZVU1dXNGckJyZDdwbUFPcUZ5NTNnQ0ZGZVhjcCtPaXFB?=
 =?utf-8?B?aDN6WU9tSnhIV1FWcTZGQTFPeXdpdjV5VElpME94SXlmc3hDTENFbWo2NzVs?=
 =?utf-8?B?YzZERWVzTjRoUlF6azVkMXRqZWVVbFdHVFh5ZnJTQUNmUzhhRGZvdllISVFH?=
 =?utf-8?B?d1hMVmVRQWJGMHArYjYvZGRGMG1sQytLUWxTS2hpTVlITEVxWVVZdW5LaVBi?=
 =?utf-8?B?aUhZM0RWV3Rvd05uT2ZWVjF3R1hEcUdGcGhMM0UrcDQ2QVkxOHB2RDUwN05O?=
 =?utf-8?B?cUNwOGREakNKZ3AyTzk3VHBKVDhqY1BBWTVVRm4zNlpIU3d2NWk3WS8rS01r?=
 =?utf-8?B?L0hmNmdVeW93aXU3eXU5RC9PZ3dxMDFiZmhaN2ttdmVLYWU1U0oxS1V3SGEx?=
 =?utf-8?B?dlpIc0pSY0lHRU0yQjZWQ21HWnU4VzFMdjlXZmdnU0FzZDJpa0owK1pYRENo?=
 =?utf-8?B?YWVNUTJvUGhVMlluYkZCbTF6OVFlNGcrUDFyMUVPanJWbC80Qlh1K2tGVWV3?=
 =?utf-8?B?TVVremx5a21CNUVxOGxMd1hUTmNyb29SUUE1TW5ocDQvMGZqdk9INWdRRnJW?=
 =?utf-8?B?M1lWUXNCVWhMemRVbzNTZFNJcFdBa3MvNUdYSmIzZ3Q1MXEzQlFndDRKRHNC?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ec1c74-08d6-4a2a-0a56-08dadd50939d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 21:25:37.6728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmIzWHe1g8klWZnw/xEtef0Q5xkObCXuWeGy0vX3WA6URpl+lBibHVSABwLCaVhP0zUEdutw9d3xCc1RJVu6vCLQWcFi9d2bcv84CEJJxe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212130186
X-Proofpoint-ORIG-GUID: sNlQXmlEEKrlm4HgpJ-YgBR8i48z7t0e
X-Proofpoint-GUID: sNlQXmlEEKrlm4HgpJ-YgBR8i48z7t0e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/12/22 5:09 PM, Krister Johansen wrote:
> On Mon, Dec 12, 2022 at 01:48:24PM -0500, Boris Ostrovsky wrote:
>> On 12/12/22 11:05 AM, Krister Johansen wrote:
>>> diff --git a/arch/x86/include/asm/xen/cpuid.h b/arch/x86/include/asm/xen/cpuid.h
>>> index 6daa9b0c8d11..d9d7432481e9 100644
>>> --- a/arch/x86/include/asm/xen/cpuid.h
>>> +++ b/arch/x86/include/asm/xen/cpuid.h
>>> @@ -88,6 +88,12 @@
>>>     *             EDX: shift amount for tsc->ns conversion
>>>     * Sub-leaf 2: EAX: host tsc frequency in kHz
>>>     */
>>> +#define XEN_CPUID_TSC_EMULATED       (1u << 0)
>>> +#define XEN_CPUID_HOST_TSC_RELIABLE  (1u << 1)
>>> +#define XEN_CPUID_RDTSCP_INSTR_AVAIL (1u << 2)
>>> +#define XEN_CPUID_TSC_MODE_DEFAULT   (0)
>>> +#define XEN_CPUID_TSC_MODE_EMULATE   (1u)
>>> +#define XEN_CPUID_TSC_MODE_NOEMULATE (2u)
>> This file is a copy of Xen public interface so this change should go to Xen first.
> Ok, should I split this into a separate patch on the linux side too?


Yes. Once the Xen patch has been accepted you will either submit the same patch for Linux or sync Linux file with Xen (if there are more differences).


>
>>> +static int __init xen_tsc_safe_clocksource(void)
>>> +{
>>> +	u32 eax, ebx, ecx, edx;
>>> +
>>> +	if (!(xen_hvm_domain() || xen_pvh_domain()))
>>> +		return 0;
>>> +
>>> +	if (!(boot_cpu_has(X86_FEATURE_CONSTANT_TSC)))
>>> +		return 0;
>>> +
>>> +	if (!(boot_cpu_has(X86_FEATURE_NONSTOP_TSC)))
>>> +		return 0;
>>> +
>>> +	if (check_tsc_unstable())
>>> +		return 0;
>>> +
>>> +	cpuid(xen_cpuid_base() + 3, &eax, &ebx, &ecx, &edx);
>>> +
>>> +	if (eax & XEN_CPUID_TSC_EMULATED)
>>> +		return 0;
>>> +
>>> +	if (ebx != XEN_CPUID_TSC_MODE_NOEMULATE)
>>> +		return 0;
>> Why is the last test needed?
> I was under the impression that if the mode was 0 (default) it would be
> possible for the tsc to become emulated in the future, perhaps after a
> migration.  The presence of the tsc_mode noemulate meant that we could
> count on the falseneess of the XEN_CPUID_TSC_EMULATED check remaining
> constant.


This will filter out most modern processors with TSC scaling support where in default mode we don't intercept RDTCS after migration. But I don't think we have proper interface to determine this so we don't have much choice but to indeed make this check.


-boris

