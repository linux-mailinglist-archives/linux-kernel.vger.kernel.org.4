Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADCC64A793
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiLLSwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiLLSvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:51:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F5A18B1E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:49:11 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwrDj002656;
        Mon, 12 Dec 2022 18:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=k4h51/WRXTtFsJMSStpAC86JVO2KTQ5d8/KBnNwLiW4=;
 b=z60wzJRGrJEZHiI8Gm3XS1kRCU5s3SnCE2u+9K1yjq2a06FDrn5DXq5TQ2kc6H+/fxYP
 sURdAgIGSQmMYtE0qL87QsaVx+pIp1KOpwG28VobP52EhpEUyQLMNzrT0nDmqpobLAhT
 LNlX9cY/GFk5JCHGfkB4l28Bl5Klg3UVcx9b+tbkxsWViI3XemwG9HRl2ZyQO5bgbZ7k
 YRQcTnFzollmdRM+wnBg0BRWOzQq682HHcSIlbvX1j9auH6yrD94Gsf6mOHm1HPVaKKa
 F+JLpgLZWqp/RdhZK9I9PBvsbfTsQZVQScbXCZ84FDHce+5zcax4M+GsUolB4vN7qliP VQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcjnsuj2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 18:48:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCISLKe033022;
        Mon, 12 Dec 2022 18:48:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjb0ab5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 18:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePINLr+FRab7KhNLVUok7fN/OAnNQ723rIzGt+ArWnC81gCULLCTOwYH0z027m4Nn2GH/V+cykqdRZ2S6CoeWNR5ZiOPNA5jsAoBhXPe74h2afbB+X2+T89AheuK4AhGr1EYhP6F7v1XuEg2yGzNkocExxako+zGBPgu/DFvURmKNn3e/VYz/lwLPTGsiJMpLEBPl5sS/9dtMEgWiABJjjxB02e7i6gShBiXIoENwWMvHQCxo1UN5wa+qVzCTTA5D3RNawJ0DUonbi0bqdy/2RCT1UidKcLrIjwTHX2MKczX1nqrsgJ38shl0oCoXbNhkdhlNB7b0mzv4jvt9HXQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4h51/WRXTtFsJMSStpAC86JVO2KTQ5d8/KBnNwLiW4=;
 b=QcX5zG+sEDjcjHWThwtFNxUz+4MD7qlM6XnRWFKmdRdNvyFkiNjXFuVlB6wMgXJW99LzKqNuRRwQk9DPpjrq2kc/AIueC3R95+R85Nz+vmGMOzO2tNSdYTelEzxYYxPki+nynREvI6PfqxJTUVJ7wFg4dXIQpwulGQFSEkgNuhAqMv0HYefyAeXQzlmkUFWdeMfXo3v0Nd9XULYoKt8nM0iDCCZxvs4RasS3b82em0gtY9SWrccge6479SOlJT40id7DPCIxNvp6k+LlnQPgvusXw4q8g5uXw3dY0220xzbxZaihF1n3b7JG14c35tJz1MigJ+R76vWxE/ehQy/WOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4h51/WRXTtFsJMSStpAC86JVO2KTQ5d8/KBnNwLiW4=;
 b=AFOIE3ETYz6+dhEr2isNlhCOOibvDgFw5oSYRlSGOXbhjgdVv+77p14vPt8+Ozmjg8i/hEHqtZBko77qKf/xQXATZ88t5rIewT1oZjIwkWujLVRcGQ5YT1sux9CS1TJCRVrT0K/04UNNcsciQWE+qQkb71Qs9XlICz2jSclf0fU=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CY8PR10MB6753.namprd10.prod.outlook.com (2603:10b6:930:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 18:48:28 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::909f:fa34:2dac:11c5]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::909f:fa34:2dac:11c5%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 18:48:28 +0000
Message-ID: <d1a2b785-edc7-b7da-d2f2-123d1555022e@oracle.com>
Date:   Mon, 12 Dec 2022 13:48:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH linux-next v2] x86/xen/time: prefer tsc as clocksource
 when it is invariant
In-Reply-To: <20221212160524.GB1973@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:5:14c::36) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|CY8PR10MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 84100975-8376-44e5-f3aa-08dadc717567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+FoiIVyEX9bZswzAqaARpAnpseKtBvCMYhZyc3XySaHiQBmf2TMLecAtc9QKt6f0s3Ugy8huQku120UvYLaCLKhaUV5XVWegRQ69QgATiDn2UneM2liZUeGA9dSrSsBXHTRD0uF1vFHv0Fd5fPkvqiDp8jhrKfyAftL/tH8RgSFp22b9xHWKOFxyAfxYXM331sczbdV91v8YRwe6fVZH2GQfOrfuZFDCrUVIYv4fuuONXZW5UD51sOj+/YJB15fQElwVXZxGicKjOUgtUE2um3Jhxa7vjGPnUiOm8oQsCo27yPJxvAdyWd5M7zIFAztXO37XiCGGAUAZ9dOKP55az7KTW+J4Utt2WKJd3sbUGzk6qcVGbPSFbZUBvieCibb27cDCxaOjmQ+tLq3kUgn5uyCgS3ZJTVgSHATh1RGlQeQ7H39o3evtOXBzAeirj5aVvp2wn9XTwNb06Dh/vnObmcRuNTt4lF47dGon5qWrvPXL6emnmfGa17aEFnxlI3Pdi+krHTD49CjhZKon4alJcb8KKDeMV7LsmrOVwOYXp8X4Xkew+6R5aK7jRcc4Wl2R0S/KHiYixRzV+J9nvU6NZtZ9J6C1pRKQMKtjli033GRb8ur/mSMB0Q7t0j/Ch5xLBtFamxjq8s4KgUkeIEZ9XMVUC80BiKoegPHUmH1fYV5isxjxKw9vsYbsIeTSOhYVuEPh6kjWE87I7344uPtMuYa59yiC/onbvLl3L1yWcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(2906002)(31686004)(44832011)(38100700002)(31696002)(54906003)(26005)(36756003)(53546011)(6512007)(86362001)(6666004)(6506007)(7416002)(316002)(5660300002)(8936002)(110136005)(41300700001)(66946007)(4326008)(66476007)(66556008)(8676002)(478600001)(6486002)(186003)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJRZnZJT3cyVUc3dlNHU2JqSHg0bXJ2d2VyOFVmeXhrWWNxVXM5bkhyRWVJ?=
 =?utf-8?B?L08reDN4Sk5pMW04WEpzcFlvc2NBUHVvWW1QWWp5ZWJpVXBHZWwzVXdBN1kx?=
 =?utf-8?B?a3lidmNOd0YvTlBNVHlNVUxxQzVkeFVaWURMMXE1T0NTSGNUdnV1cnBZNEJ4?=
 =?utf-8?B?dkx5WVkyVG5jaTgvd3hkVTkvbFVkZGFsWURqc0FEVk5WdmdnOW0zODVia21z?=
 =?utf-8?B?emIxNUZNc2c5NHp4RXE1WEtpaE1Za2F6eVJOQjZ2RXFSK0M3cUNXSWdZV1M3?=
 =?utf-8?B?QU9hUkZsMlRQSjgyZTRnUDFsTnNvRk5nYmFKaEd6NlMrY0dYWllhM05YUFNO?=
 =?utf-8?B?cFpVc1FTYnJLVmNKYlJLbVd0YmtWMGhsNEdEOGdtdXZoUDk4T1FiMEpacDhm?=
 =?utf-8?B?cTVtNUhRcWpwczBpUHQydWdESFhxNHNzSGJuRkJzcU5Zc0hHMkFlQ21NVjZz?=
 =?utf-8?B?dDlHTnZvV3A1QzRlL1RVZElibTgvUlRDWXNFVXpZVnVCMFZJdVlWVk9YRzV4?=
 =?utf-8?B?WVh0ckF4aU5ldEZlMld3K1RGa2hBSTlCL3JqNjhlZEY1bXVmLzR5QVN2UExx?=
 =?utf-8?B?NGFFQUtRNE1XRlB3dytEK1FPSk5NdW9KeEdlUGtaelU0aEpSWXpzSE9taVNB?=
 =?utf-8?B?VlNPUDhITU90VGdVbWY3MUtTdElVVWpweklXTFpQVS94MmV1dXBSbElEdWZZ?=
 =?utf-8?B?SWI2WEVOSm1mT3JTSXptTzkrMml4OFVZSVRGa0svbzBsMHNvNGJmTEFHeGJF?=
 =?utf-8?B?THpEbVM5MFJlb0sya3Y5c0FvSVp1cnNlN1BpVVlBQ01EZlpIK3lqN09JVEVC?=
 =?utf-8?B?d004YjZXbC9iQWwwaVg4Z1hjWXNWOWFYMEw1V3FneXh3OWJZVzhTZTMxMjQ2?=
 =?utf-8?B?aHQzUEFRaHE0dGc2TldJU3U2QUliYzZMMUFaV0pMbmlabnBzaHdmRTdQTEMz?=
 =?utf-8?B?dWd2OGdJZzBHUEt0SExxczJRWDAyb0lYNUFRMlFxVGcxNnBmU25Fbk9OMmZZ?=
 =?utf-8?B?cVgvQWlMN09vRDlxUU5pK1FaZ0Vxd2h1SFFNVFZDOWRkQTIySjhmLzIzem5j?=
 =?utf-8?B?ODNOREdTZUxWd093MTR3YVRvaWt4QjU0elZiY2pBd0Fwc0wrY2J4UG9FYURH?=
 =?utf-8?B?Y3ZRanM0T1JIUGN5dE5RbEYzdWlaYnlCSnRkNkovNWZ2c3hRei9ZTDVvSHdU?=
 =?utf-8?B?TkpzL01EcHljTmE5cVp5bjNHOWdxOXYzTGMwTkY3QmhoZmNYRlVzV2lEckFv?=
 =?utf-8?B?NUE5NG04czlDSWV1dUdQY3lieHhtRW1LamRLWVFLeXJaRWhLUWlDQ2RwME9M?=
 =?utf-8?B?Y0NmTWFFZmRhdE43emh3THpPWm1SU3Y4T00vUFFoMTkzZm9ySkJFMmlZdnR0?=
 =?utf-8?B?UHU0RlV3aFZrU0Z1aUU0YlhSaHltN0xQV3NTajljdUJPM1RVY0lOdFM2N3B5?=
 =?utf-8?B?dkZCS2N2YXgzZnJXNG8yaGppYkxTa2JoKzlyVytKc3IxWFdmSWQzd3FydzBJ?=
 =?utf-8?B?bjVDeUdJdEIrbUNRSDRXNzE4ZEZTNmJvTU9vVDFwblhZbUp3cmVRUGxnbG9w?=
 =?utf-8?B?amJKSnU4a1lLbUhQUkJ1VVdITXlhWnh3VG81aDBFVFRLVmgxOVdETUwycFNU?=
 =?utf-8?B?d0NzRkFBVUdyVGJOd0JhQy9HOE5MNWJjZndXeXVRem5uWHNoU1I4b2JpK0Zy?=
 =?utf-8?B?a29GSjEwU0xjdnhvaldTa2VETk9oeTZwNkZtMStiQUFPNTBwT3NiQlhUUUlz?=
 =?utf-8?B?VnM3RXpyaVNuMVdmeUhuMjI1ZnBxS1NZd21PcW5HeDkrT2p3R0tBMlJVekVF?=
 =?utf-8?B?ekxVSWsxYkJCZVROYlE4dTlVUTMwcThPY2ozZjE5NUFtdUdhS0lJSGVyNDZQ?=
 =?utf-8?B?VFVBa2JteW1lWHliaGFPcUhKU05Wd0J0VjRXNTNpdkFlbkc2WGUwcHFTcHho?=
 =?utf-8?B?eXZjc240ZzgvblExUjk0WWRwVlUwZUJPOEFoa1gxTzdoVlRiMlRqdG9BQlFV?=
 =?utf-8?B?RTN2RzY4Y1VGdXZ5dXI4dm5RanFnUUpiRmNva3I5d0tFUUpsMlZ6M0NndmE1?=
 =?utf-8?B?WDhLSnpBd3JvaU1uS2VZY1Ird3Ruc2ZvOGJYWE01aVRnY1FrTDRQbk9qUjlL?=
 =?utf-8?B?VG43bWVMYzNTK0hWVExqNmh5UWhGWXJ0RjZRTlNZTkY2OFdDNUF0NlBvcFli?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84100975-8376-44e5-f3aa-08dadc717567
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 18:48:28.7695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TeVxGkWYFhgPCDxC7QYP3Ke1Upzp2/6qWKN4RKd/YG5tN4FkX+6aZQPEcFqbkBkmbvorVZy5RSPyUZY5qUCZQ+UlEweg6TM2tvoqQD8f2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120169
X-Proofpoint-GUID: plJxmSLFR9HAg5GUYqYHJllH1GMBh8fc
X-Proofpoint-ORIG-GUID: plJxmSLFR9HAg5GUYqYHJllH1GMBh8fc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/12/22 11:05 AM, Krister Johansen wrote:
>
> diff --git a/arch/x86/include/asm/xen/cpuid.h b/arch/x86/include/asm/xen/cpuid.h
> index 6daa9b0c8d11..d9d7432481e9 100644
> --- a/arch/x86/include/asm/xen/cpuid.h
> +++ b/arch/x86/include/asm/xen/cpuid.h
> @@ -88,6 +88,12 @@
>    *             EDX: shift amount for tsc->ns conversion
>    * Sub-leaf 2: EAX: host tsc frequency in kHz
>    */
> +#define XEN_CPUID_TSC_EMULATED       (1u << 0)
> +#define XEN_CPUID_HOST_TSC_RELIABLE  (1u << 1)
> +#define XEN_CPUID_RDTSCP_INSTR_AVAIL (1u << 2)
> +#define XEN_CPUID_TSC_MODE_DEFAULT   (0)
> +#define XEN_CPUID_TSC_MODE_EMULATE   (1u)
> +#define XEN_CPUID_TSC_MODE_NOEMULATE (2u)


This file is a copy of Xen public interface so this change should go to Xen first.


>   
> +static int __init xen_tsc_safe_clocksource(void)
> +{
> +	u32 eax, ebx, ecx, edx;
> +
> +	if (!(xen_hvm_domain() || xen_pvh_domain()))
> +		return 0;
> +
> +	if (!(boot_cpu_has(X86_FEATURE_CONSTANT_TSC)))
> +		return 0;
> +
> +	if (!(boot_cpu_has(X86_FEATURE_NONSTOP_TSC)))
> +		return 0;
> +
> +	if (check_tsc_unstable())
> +		return 0;
> +
> +	cpuid(xen_cpuid_base() + 3, &eax, &ebx, &ecx, &edx);
> +
> +	if (eax & XEN_CPUID_TSC_EMULATED)
> +		return 0;
> +
> +	if (ebx != XEN_CPUID_TSC_MODE_NOEMULATE)
> +		return 0;


Why is the last test needed?


-boris

