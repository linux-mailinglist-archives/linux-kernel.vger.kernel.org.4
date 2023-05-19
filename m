Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A045B70A2C4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjESW0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjESWZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:25:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F08EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:25:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JJECoZ001734;
        Fri, 19 May 2023 22:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HdlFplk5qhlhoA5aRAZEuOG0i5tuzU8zMdFpgbpBXco=;
 b=rzF91hOkLeAPlu48XNfjh17b3rOwm0aU4LR3sE08krhAiGjEu5iMLrrcaMLZgRhcCN2W
 yBmmmct8FUD0WQqKSvcBRM0iLRQ2e5i51VOFsGCQ9J65dMuZme4UIlrUmSs1OAgC5bx2
 t0d2kAJW2A+GK1VHp450TFPIVawJLXXeqbk+zuIZykAx+nA4AV3fDKQTipMj4sSdT4WE
 JLVTTTFr0UVobbAxiLjgV+sPjVGxZnPycZVvqC7mqeGXEQuafUQH9Y0bgUc6Wdj90z+y
 awXJY5SXjTiUXMWPeiQSwqLAz/1e+/zPxgL80AHxFyfzFlhCFLVN/h8TFitMEV/O7ehI hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qnkuxbdh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 22:24:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JMLInf032189;
        Fri, 19 May 2023 22:24:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10ep7vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 22:24:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uu5fj6h79XBCo8xGjjbowYMoP7V78hz1+i0TBnk0kQ+O6FBe/rgZT4QXYSP4Y7kHQOMCc7G9jH5AGjKrvhYPndE5y+e4q1PXWjbTr6gEssEkPHFo7/eqiJNJd7xQBLEqkyORhLGXNPkflt+r0IcgX6I0c7mHoXpLuG769JsQxFUVJ3HLumZ4nOwhrfhzW9blOFOT7RDMMEQQXVDrNgbqzQ0uh33BsBBA7RSD4p23I4iL7ALKiB4T+GFhoaPDAtQvUbn06iagesGdU7Np0JvgC7CfTEp2TaYbJysMxphABZJg1ia7/KbrkKA4zH6LxeGBy6tOcXUVPs3ZQIdnpTwJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdlFplk5qhlhoA5aRAZEuOG0i5tuzU8zMdFpgbpBXco=;
 b=Oa7WI6tqhDnKbmjE9NZsTTPG7Ug6SbpPESqR1hpGhfo1lskf17qgnsDCQBfCvFgIwcdMSmMVrh14iDH4GQhNJaa5494XdU/WgIsPWcCJeSzKl1Rpi4zUN1Fhd2R50PjH6f3ZXptyxZSnpj2ZutMXlepNC5OpqdIBkuZ7eVwcVOVBVRY1Gkyd3sp39kOnROScHKemBbiz3Ahmk2UqQCAuRA/y7sS15axoSV9YYTtwNGvOUSMuaBGYCs1lVCa5mbrI+5vAfZ7C56ptxNMh3IZ6S52+0mWaRg4uhd1KEIRWyJNtnSiOCudvt1zlChO5kd//muyVy+hQndfoYcWnplJjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdlFplk5qhlhoA5aRAZEuOG0i5tuzU8zMdFpgbpBXco=;
 b=W52sGHBaqOCqqEkSu7Iy5O7mQ2Vn1R1jSLEEnpbQdLnk4qrh/eBA4irV7aRiyz63djtql+rb7Do41TaDog/T5L3cmz0ITb8FvINi5tCwiUoHFZXvU0pPsT7YYRk8Q0lKd0lDx6dyCeNUEddxrpH+7HCXg27KZhajN5y2c5v42oo=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by DS7PR10MB5135.namprd10.prod.outlook.com (2603:10b6:5:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 22:24:37 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1be4:11e3:2446:aee4]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1be4:11e3:2446:aee4%3]) with mapi id 15.20.6411.018; Fri, 19 May 2023
 22:24:37 +0000
Message-ID: <35c82bbd-4c33-05da-1252-6eeec946ea22@oracle.com>
Date:   Fri, 19 May 2023 18:24:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20230519092905.3828633-1-arnd@kernel.org>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH] [v2] x86: xen: add missing prototypes
In-Reply-To: <20230519092905.3828633-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0097.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::24) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|DS7PR10MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 209ca017-450e-494e-a70b-08db58b7d45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23ULu/aiS2Va4WibWi54PdbeFCiR9k1+enOUqNC29D5nK1SduXWhw8V3AB2UGl/RGfP+tB0truCl2U4HNlvg3Wt9vIkQoHziXjYkBAZTKkuwtjAXL2FA7MzWtgj/tUXV1pZTLyu8qsrmqBaV7fvmKD48R4tdEhtvV1JOoDp8IS0SDaweHJm+tz1qbIrrZIKzH0tMYpS9vAWNJxs8JCNeXwI/qP9nUmHPrkFzQm1KZ8CLcGRKnGCwFW9wqKCQTFti4BLrPQ0k8nlZcGuMljiwbQ2jI7z+khp7ApPKg/OnOmwn3zZsf+lul9JFooSFpKZvo0j5dcHQoaYE6N5SCcRLDNsUUJSe7lFHqfr/htHj/Wnq4V868LkUw0DNdFmcUSA7kxm1uc9h4O7aC4uvKrcEuCxyEfBbiHY+mgQoVBMiQpga5UoyqFqWO3xmY9Kx5XRAaQqTcf68yr2mr+87MMZh8d6oiTbygvaZ6twNNEYY+lcVspOnCSaKFvcoWmCDGr9uk/LuzRcoWVqanKvICAdEkCC+WmKsZAn8gfwWlqvcETKrBkLEQzAxB0WuzL6I+ncZ72erEcOALfplrWlcOo1zye6a4xgjY+Tjf5MSpUxI6+gVr5I153rYZSSNfrAaEnvbWdjEM4Gf4pTazD4kbeZckw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(66476007)(66946007)(66556008)(4326008)(110136005)(54906003)(31686004)(8676002)(8936002)(478600001)(316002)(6666004)(41300700001)(6486002)(2906002)(86362001)(31696002)(53546011)(26005)(6512007)(6506007)(44832011)(38100700002)(83380400001)(2616005)(186003)(5660300002)(7416002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clZ4TnRTUTd0RFdxbmJJMVdXQ2wrd0Nvb3YrbEExek5SZDVtcFJYZ3FJM2J0?=
 =?utf-8?B?c254bzNZNWtMa01peUR4ZURXbEVENTJWTUdxN3BybkcvZTJXQklrVTZKdlB5?=
 =?utf-8?B?K0JHL05nTkNXdXh2SkxONDlBb09JN285UzQ5NW4vNXYvZU5DLzRmeTFXVElz?=
 =?utf-8?B?ZmpPc2hzSkIzNEhIb0w1MEYzYkRFdEZFSTBYWVVPMERTaDJmdjNjSmtPRDZk?=
 =?utf-8?B?RTR1ZXRMa0k3NndDTHVYOERIcjRrakM5dDJWeHV3OXBPUm9ZOVFMZDdnL09H?=
 =?utf-8?B?Mkd3K05UcG5YTlp6MGh3Q1MxSGQwWUUyaDFMZHRRMEppdWRyNmhteWFjbC9G?=
 =?utf-8?B?UTc2UnZsMHBOa08rL3RmS05PV3orVHBnY3JHOElxTjBzSytxS3I2Vk5KZG82?=
 =?utf-8?B?TEdrOUJIUGRZaW9Rb2hkKzQvMFB6dXpOazVJb0MwWHNkRWpsbENkT0dCVTBy?=
 =?utf-8?B?Zzh4VlJYdGxXOGQxblpNL1Y4R2FQd0Ywc2wwNUc0aHFDYVoxZFNLMVpHdFZL?=
 =?utf-8?B?cHhtMVVvZlloM1NvYVhlT2VuNktDeGV6NVBDb2MxMnNITHRvT0Rra0xwbFNl?=
 =?utf-8?B?QnpHUCtNRCtiVFhESWpVZ3R5VFNJemtadm9EdzdUU0dtYU1HRlE1NXUrZ0oy?=
 =?utf-8?B?NVZzQkRja1NDdy9iTUk0Q2lvb3g5Qm9jWjB0ZmFDRjZyQ2Z0QjF4MFlRK3VD?=
 =?utf-8?B?OXRraFNvVFZubk4vZ0xtMVBGbDh4QVJKZ0R5WkN3SWJsNDI5QXczak95Zk5R?=
 =?utf-8?B?MXFRVlh0WXkwN3ZoWTV2RVBLTUdXZXNvaFlCWnpvK1FycmZHNmZ5cVVRY1NN?=
 =?utf-8?B?WHVnWXQxYko4MUpoeHdYWDlGcUpQN3lyQW5vQjFqNmxSU1VHTkVjQzZSZGlQ?=
 =?utf-8?B?WFdhVWRJaXJ4enhyVEJTVlFwL1hPVzgvaElpekttaUZJZ2JZdk5tckZsZVlN?=
 =?utf-8?B?Wkk2ZldXZDJodDhuTlgxNHR6VDV5a0xHMXpEZ2Rsd0tMUjRkZnVPbHB6N2R1?=
 =?utf-8?B?OFJKRjY5OXFabk9QRXZYOWlOWFF6OVQ3VmZUZUZpNUx0NStqc2Foc2g1cWFW?=
 =?utf-8?B?WDVVNmExZGpQRStiMlJYOGk4M3NCZ25RYTJKYkIvVUovLzk0OS9XSnZYQkxL?=
 =?utf-8?B?dmlCRWRyNmxvVm5aMndHMTdxUmNyVkFmMWcwTEF6SnEySGRSUUI0OEZVOUZt?=
 =?utf-8?B?ZmlGYmpieTlrYnRoVEwxZW5wclpjZExXWU5xQS94dEZYYVhrdWVFdlpNcG8y?=
 =?utf-8?B?WWU0OUV3VWlVMFY0UlJuNDZzNXBuT2syRFkrK0I4d1FGaFhiMTM3cng4aXhG?=
 =?utf-8?B?UDZRbkRsY29XQUdsdTVrS3BkOFZJVDUrbG1mbis4RHVGcnc2WCs3MnRYSWlS?=
 =?utf-8?B?Ry8zUFJaREVIcGVXQkJidUM1czBJbGhlS2p5M0ZzUFdIY290cjhtNTh5RUh4?=
 =?utf-8?B?b09LZ2QzSkxWNmhrSnhHdGZDaW1CU2NoV05uRW51RGd4SDVBVGwvQ1pqMUM5?=
 =?utf-8?B?UTdqMlZHV0pvQ2JCYXZxV2lPRlRBVUovZGxPMHNWVzhEd0pTOVpQTktWM2tv?=
 =?utf-8?B?RE9sWW8rdUFoZi9jOEVOajA0cjFLclQvMk9MN0RFY2ZRbjhRNFhFNEVZc3ZV?=
 =?utf-8?B?QVd6VE8wQS9ySTZ4ZUNkVHJJSTVoZThJaCs1VFR6NmdwVHF5ME41RXJhYXBl?=
 =?utf-8?B?cnZsWkx5U25WS0M4YUhsK3JwTUNlSnhPYzhEOFJLaVV1QnVyRU9FVWRwNkZH?=
 =?utf-8?B?MUViYzVpRTdyVFhnUmZ6UFZwSGk4UlBUQXRDOU11R25ISDhkOVc4b1YwcTVo?=
 =?utf-8?B?RjBLdGhla0dtYzZGSHhTZnp0bjNNZ0I3VlVhbGVmbU1rSU81MHEzS0tTRmVa?=
 =?utf-8?B?dVZOak9FSVc3ck1rWHJoNVNNZWFUNW1DYk9WY3A2WndxK0NWNW1LcWY2TGov?=
 =?utf-8?B?a2NyVHY1L3F1aWI1L3I0eXlSdmdHYUNtVmhZOG85V00yV3ZKSGRKNFpOWjdm?=
 =?utf-8?B?UExZYW1mLzh5SGdTczdyZGl3Rkhna1RHTjdPOExSWkRhaFNaYTRMT1VzU0hv?=
 =?utf-8?B?cWtyZEp2Y29BMkxpMzgvZ0lqWmdyMzNaMDN1M0RWdkU2ZWxNd3BkbUZSNlpk?=
 =?utf-8?B?MFRCTnYrWFVEUml5YmN2RkVTZnp6MEovblZLNmpDUFJyeDBHVjJYZWw3aSs1?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dG5iR3ExVUJNa3ljb25wdlh2YkhZWUFtbnlmY05vUUxrSkZBMXpHcXN1OXNO?=
 =?utf-8?B?dlNvdmRvMDV6U3lDeGpsT09pdXM5VVRrWUZVRFExZzZqWmdDN2d3ektrR21o?=
 =?utf-8?B?cEdkUTNuL0hoUWcrOGJ5MHd2RzQzOTJxQUdMMVZ4UHRHNzVqOGpsWFBDZHd3?=
 =?utf-8?B?cTJPQS96UnVGcDdOMVJyaHRITFMvSENBU0JXMC9xdmlHV3pTYnRPdEFVQ2cw?=
 =?utf-8?B?bUkzaUZaNjh0TG8vVWdIdU1vWjY0djJGM0pqeDNybmRTOXc3b2hWM3p0Um1O?=
 =?utf-8?B?TE0rZEkrTkdIS3c5M3B6UVVtckU3TzNjM3BNTlF3eGpiU0NaVHRETDZjY015?=
 =?utf-8?B?eVh6Qmt3MVJicURSWlp2b3FBZDI0bW11M0VtYzRzSUdTZFNzZUoyZFIvVitR?=
 =?utf-8?B?Uit0MXlObnAxaVZhbXlORE82SktoSmtaWSt1RGJUYWxyMkFERUNZK0ljd0RJ?=
 =?utf-8?B?K3dRWFMweHZzM3JHNWJPdzhhR0YrUWo3WmYxZjRQYk93S1VKc0hZekRuRGF6?=
 =?utf-8?B?UTcrV2lyZ0JNVnAwVTl3Qk4zMjluSURGUzhqa21peUI1MndSU3gyT1NBeVFE?=
 =?utf-8?B?SVcvL1JVSTNWRE5kQmsvdXVMMzdMZFZYcXIrVVhhZGlDQ2tRWk9uQTZ4UXd0?=
 =?utf-8?B?YmxPbGJKTXYzdGRtMnR5WXVqdlhhV1NrNkQwelo3RXNsZURDZlA2eG5CNUlB?=
 =?utf-8?B?Vkd5L1I1WGtkeEdWYTdZUGl2M3Z4QTJlU25rY0dZRjRvUlFnSDRVMlAvMFRs?=
 =?utf-8?B?aENnU2FtU3h5WjBMODNFdkwwMmVkNEJhQ3NXTllSb1c5VTR3bUQzbzcxem5R?=
 =?utf-8?B?bDRWd2trZEIrQy9VeDZITDJ5Q0tva3pwWWdUMzVYOVJRVkY3ZXN1cFRybUNq?=
 =?utf-8?B?cU80NmhKYmxUZGJpZmhyaEVGNHlUQnJLaHpmdjJsbjFhL3RRQTBtNmNnNmow?=
 =?utf-8?B?eGJiREZkdzdZQnAwSjVUWG1HZ1JOUXV1T2NwVG5oVlZ4RWN0QjBUNytMR2lU?=
 =?utf-8?B?dWh4TWozOFdyTFZSUHdMS1lhcTFLSk5uV1UvRGxTTmxGUWtzLzVZdDdFa25N?=
 =?utf-8?B?UnlXYzdpaU8zMFdWZWhJYzVDRzJROHlZMis1cm5icFR5TENnNWhpeE1MaU1s?=
 =?utf-8?B?Q0k3V2JNb3p0U2RDS29HM2lrb2RWZXdNL296cm1ibExpWjlPMHV1dUk4NE9j?=
 =?utf-8?B?ZGZ1dFhhUXpYcnJ5SVdFNUJDdWowNGkrZCtFWG83czJaQktKM2RpTDh1TXVw?=
 =?utf-8?B?eGI3azgyR0k3RlZlajBvdXVHYklsQnhkSW5VTnd6QS9xazZkdW5kVGd4djFF?=
 =?utf-8?B?ZXozNmhRNFFzZ1VaK09oRlNiSXJZUUo4Uk5yUnVmWmx5ZGpnM3EzUndEQjMy?=
 =?utf-8?B?WWZpaXlDSisxWHZnMWlhNjc5SDMxK2VvdVFKOHloM1Y5TFpyTnRNOFkrNHN4?=
 =?utf-8?B?dTEraWFTYXNnNnZyc09Nd2RsZVJtTEFteWcxS3RudVZyOGgwakxqVnFIbE53?=
 =?utf-8?Q?QYhvUlo5ia3QQHd14jBPmyBa0sN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209ca017-450e-494e-a70b-08db58b7d45e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 22:24:37.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emR9jnEX0qFft6PJMCtw1AkOpX5TJNvV1zquriaQ6ENgTzlRiZj4e9pEx49IO/zjUPnvDJ/qBcEVhUr9vjm5hK0GsgQX+f3WpnBk9v9oITI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190192
X-Proofpoint-ORIG-GUID: ct0DRok6u-O7dl4WKc2W2x02pcKn1ske
X-Proofpoint-GUID: ct0DRok6u-O7dl4WKc2W2x02pcKn1ske
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/23 5:28 AM, Arnd Bergmann wrote:

> diff --git a/arch/x86/xen/smp.h b/arch/x86/xen/smp.h
> index 22fb982ff971..81a7821dd07f 100644
> --- a/arch/x86/xen/smp.h
> +++ b/arch/x86/xen/smp.h
> @@ -1,7 +1,11 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   #ifndef _XEN_SMP_H
>   
> +void asm_cpu_bringup_and_idle(void);
> +asmlinkage void cpu_bringup_and_idle(void);

These can go under CONFIG_SMP

> +
>   #ifdef CONFIG_SMP
> +
>   extern void xen_send_IPI_mask(const struct cpumask *mask,
>   			      int vector);
>   extern void xen_send_IPI_mask_allbutself(const struct cpumask *mask,
> diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
> index a92e8002b5cf..d5ae5de2daa2 100644



> diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
> index 6d7f6318fc07..0f71ee3fe86b 100644
> --- a/arch/x86/xen/xen-ops.h
> +++ b/arch/x86/xen/xen-ops.h
> @@ -160,4 +160,18 @@ void xen_hvm_post_suspend(int suspend_cancelled);
>   static inline void xen_hvm_post_suspend(int suspend_cancelled) {}
>   #endif
>   
> +void xen_force_evtchn_callback(void);

These ...

> +pteval_t xen_pte_val(pte_t pte);
> +pgdval_t xen_pgd_val(pgd_t pgd);
> +pte_t xen_make_pte(pteval_t pte);
> +pgd_t xen_make_pgd(pgdval_t pgd);
> +pmdval_t xen_pmd_val(pmd_t pmd);
> +pmd_t xen_make_pmd(pmdval_t pmd);
> +pudval_t xen_pud_val(pud_t pud);
> +pud_t xen_make_pud(pudval_t pud);
> +p4dval_t xen_p4d_val(p4d_t p4d);
> +p4d_t xen_make_p4d(p4dval_t p4d);
> +pte_t xen_make_pte_init(pteval_t pte);
> +void xen_start_kernel(struct start_info *si);


... should go under '#ifdef CONFIG_XEN_PV'



-boris
