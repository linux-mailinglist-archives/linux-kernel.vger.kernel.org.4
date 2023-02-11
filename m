Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF6692FE2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBKKEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKKEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:04:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84FC83FC;
        Sat, 11 Feb 2023 02:04:47 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31B5w4FB014654;
        Sat, 11 Feb 2023 10:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Xq5U+oi1nguO1buGTmtamkFrEQ1DpgQOGcOL+blIyrk=;
 b=Y/loQLeMYJiRS3OX8zIG+ikUIz6Y6uFX8yr7bck3+Y1r9gvwqphz2aowjkmgxLWmvZ3j
 0NEBNAqxIPHnw+6otyNVLwNI7c5/Bl/MUPGdoA8DMWbDIL6DW2KXPbXrV7Q9KEldWiPp
 qLeU4WQUnadcHn6MXx3FYQgsohjjzzblHdgASNatB+zIBKCwM1je6uO1cdNLQKbY4ltu
 n/0XdBQH7MXqz+aVBDygUDnXUD4mumkwlZ5spWLGf9r8k1rNRf4dLA1XXfCYwFpjcuMY
 bjKcVvZNPx+AJVsAeLOAo59zICw+x0FwsqrYI9OJp72i0/gqSWQ0EeHJSblqOiH4pjNn bQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2w9r7rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Feb 2023 10:04:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31B6ftLO028863;
        Sat, 11 Feb 2023 10:04:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f22ens-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Feb 2023 10:04:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGOaToxGn/2HBj7NySvkIOSMYmbC9eBLozrAyPZs0znx4YWTJ9b28xqpNeExHLtPlhb0+7nsqubR1Q94cBX2xs3FRA13SDhW8UR7hWsHEI6s6waMgft1ahYmMKRsm8Kw6s5byCeqtyeyaMGF9hxDaRJsAfQ7BTV67IDqgJrSBl9Wl0wfEyDy8JUAcAKQLDsUAOKElqDvo1ezQV0YlSB81nvBwwcfjtDjDovI6QRchBhzScl4b4dhwbg6GGNr9Rrih2b0d+MDQNjfcXEvA/ZEp2/2Yk98Ak0+bM9Ijivmk1DW4oB1d4gNLsZ4eGCulj5RggzsAY0VtIo7jARwVaiYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq5U+oi1nguO1buGTmtamkFrEQ1DpgQOGcOL+blIyrk=;
 b=St/lT3pDtvdS2EhF2NiUr4HQiUpoWhoPiTzD7N0TnwIT7TvJwXTerATPTxaXMxk6WUSjjSz/cT8l6U3ngIqd8uJ+LuKSbkPVM8PCma9QxrX7ANLMvnpY6yXt0oYSpLdTxZgLGJGI8/3agZWruZd8bC0OI1F0fcMm+59M/9KzCXSWOKWtz4ksnghiIA3pMcg1JEI893oi9iSSfBpDNj7Hf+yfFBHgO2H/UTiyPwzGqgS8zFVpTOuapWbt+9PP2JDoLZEmcZpALY4fETkTxGEZX26pvi4+bRWtGsKPNgbfJCs3iM6D0joE7FIdLqokQLMdYJ8AQdY8rZW0/JeoDU+Y+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq5U+oi1nguO1buGTmtamkFrEQ1DpgQOGcOL+blIyrk=;
 b=W7bGd3fBELrcVh6SHPClSHVJNhal50FsMLhdUFjA+kdUm/ehFfahpjcj0h1gE5FRMjSBq0gvY9mU0Y6uSL/UZf9ufvMAPAMDkO00hqV94G6uBPCPXVPuC523M8//JBQDgtc0o44iVVLUcIQm0t5UXh+RJdSir1GwFr1/k1WSpU4=
Received: from PH0PR10MB4581.namprd10.prod.outlook.com (2603:10b6:510:42::16)
 by BLAPR10MB5027.namprd10.prod.outlook.com (2603:10b6:208:333::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.8; Sat, 11 Feb
 2023 10:04:43 +0000
Received: from PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::9013:b768:5177:564a]) by PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::9013:b768:5177:564a%5]) with mapi id 15.20.6111.008; Sat, 11 Feb 2023
 10:04:43 +0000
Message-ID: <b11240e7-e6d0-cb82-37f2-f0b69bcb069c@oracle.com>
Date:   Sat, 11 Feb 2023 15:34:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] scsi: target: core: Added a blank line after
 target_remove_from_tmr_list()
Content-Language: en-US
From:   ALOK TIWARI <alok.a.tiwari@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-scsi@vger.kernel.org, darren.kenny@oracle.com,
        michael.christie@oracle.com, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, d.bogdanov@yadro.com,
        target-devel@vger.kernel.org
References: <20230210175521.1469826-1-alok.a.tiwari@oracle.com>
 <Y+dINRZ9ZKLhvT94@kroah.com>
 <19b4a1e2-c8f8-dad1-51eb-c565fee405ee@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <19b4a1e2-c8f8-dad1-51eb-c565fee405ee@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0145.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::9) To PH0PR10MB4581.namprd10.prod.outlook.com
 (2603:10b6:510:42::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4581:EE_|BLAPR10MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 58562fe4-58d0-49be-fedf-08db0c1765aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ztr13DD436ceGpRgRbjPxFWEEpr6lUL6lP1mUKnW8GWhuHXwydnVP01THb0eGKQDFmVSH441LskGZooMiZGqxi8+f+1rL2Tk0u/RXeks2tYGk4Mx+wHzVUeSUU52w7i7bZPe4KDjWZ7LIq7pdnXz6tfhQCcXWYVWPoYHoCBA00FkZIFuRhfAhNYDlO2wg3SpFZ7PACKuMVuas01dcbz9Lv5iWbXRJmdQq7F1VEGKPrGyxU99vRFXZZTQKb5ub/bfUyiFTjFTkAcYPvKqCnWN/imBKaS6I3SaeUvOBhL6SDayBP0eg3uZP0zJZWXZHlkSm2zoyfQiqMvL0s+d60rlA+yTPxzntmD8d7Ls5HfFQX4gjOaQZV9A6wPiXxxP7VaETvXbf4sktLEra6cgCDGQjaZzq5N7hGYdQMeKMl/xdUpebpHaAJ3j+l8NpmYKzpANT5dLvu1v32VWmqoI0d889+8oH5xYvsoj36Z2F3AyEDTDjW9jXoIEAm+KOJnKzhXXL7q/tke2UPLXZOz+acaFdnrweaWHzivLmeaLUy/6hI8jDD8qWmHI0fTz9lj4gwJtP3yue//zBaPEvCvLMn181rza1UE0QlJOKpKLq66uJ/PAPpmdLcbx96kvpDChWSeZsP/9DXl/CVN7q0WjXIs4nfn45DxGGTsoaP52UiK1HHceq8r/+X4AM5LRQYdV30BkVjaMS+Fw9f7MXpfJk3k4fwEn5wBKw9/mdEwMEIMwikg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4581.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199018)(478600001)(5660300002)(41300700001)(316002)(8676002)(6486002)(66946007)(6916009)(4326008)(66556008)(36916002)(66476007)(2906002)(8936002)(36756003)(2616005)(83380400001)(31686004)(86362001)(31696002)(38100700002)(26005)(53546011)(186003)(6506007)(6666004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnBQV0N1eXVuK2RieHBjSVBKMjVBVFpWdEhoVW1yMFBGVDJvRDBTdG9QNUs0?=
 =?utf-8?B?U0FPUFBmWUhTdGpTRDdtdFRyNkpuTzVNTEx1K0p0Y1d1OHVISVl2TTlYVzNY?=
 =?utf-8?B?WVVPeEJUUFJWbzA2bWVQTGUxcXg2OWVxU3dDNGJVbDNyN3lMeEgzUUpzak9l?=
 =?utf-8?B?TWI4Z2dzMmM3S3dHdGN0Ni9CUkNxQVN0cHdXRjRiOTNIWTZWWlljR0JtNkxu?=
 =?utf-8?B?M1VVRzZaTjVuQkVOWTZnYU5kcFlzVWFrUDBPbEZJK2RDbUZ4d25vVi84VWJJ?=
 =?utf-8?B?L3FCN1pNK2x2WDJJbWw5NGZJTXpGcE84TWFQZHNRcGZpWTFiY3Y3WGFJRHF2?=
 =?utf-8?B?UXVpSG9MVHNSQ2xabWpsdHVUK0YyMUU5VFpHZG56eXBSc1JHZFMvK3RscFdo?=
 =?utf-8?B?TzdXUlFJanpmRkswSk12MWtjQmlnRGJoVTM5cGIzTjJoeWVjdmxxQjgyWW9j?=
 =?utf-8?B?dnhoYWU0T2RsSjRubDc0UVdvdDZuaXByMXVFb2ViVjJFMnBBNHZaV3RubVJr?=
 =?utf-8?B?L0sxeFRFb0RQajEzRnpSdElsajRsS2hsbDZEN3BGekNlK1BtK2xIV2Fmcjg2?=
 =?utf-8?B?c1BlRUJONGxsOUJsbGFuM1ZOTTVWbnRoQjZrb3I1cVpNTklMd0ZuVnNTNWhE?=
 =?utf-8?B?WnhnczVJcXNBUnlDbWJEemkydnVQV0ZsVFlQcEJXTncyNEJlMGY4SUo1TGs1?=
 =?utf-8?B?THdZVDNkVi9wOGpTQlMxV3A1OXdUaDgycU1QM1R5RFA2VndZU2pVQWN6R0FN?=
 =?utf-8?B?b3VkQThkajZDQ09aL0VZRW5OOTBpQlpCeE5XK3hpTUtYZTBSYXMraTZMK1dP?=
 =?utf-8?B?MzFUbFJ5UVU1Vklsb0tNMUI3c2xlQW4zd29jeDBnZTJpSVkzc1dLYmJvd3hh?=
 =?utf-8?B?WE9INXpXRE0rVERxcnR4ZUo0QkdvUmJMOTRRL3Mzb3dUcXhYUjVKLzdBVWF5?=
 =?utf-8?B?eXA3SDNrQzB0MklZRkVLNm9BdlgyVndKam1kS1VZUHdKZURmdi8xdnQvVzVC?=
 =?utf-8?B?OVlKWjFNNS9OdFZpSCtzUEpsUHZmVU1SZDEvaUJ2bXVtY1N1Uk1YQkZ2ZThY?=
 =?utf-8?B?TGFpOWg5dGFqQVN6eTNlWkdyUXRRNDFvblNkZXI3bkpYU1c1c21VeS8ySlJD?=
 =?utf-8?B?UEYxYzFDWGxDNGdjSG9GQUlHN0l5NTlIZzNpT3RWOGVhWS9zWFBLdkVHSzhU?=
 =?utf-8?B?WVpoc0Fqb2dvb2o5aTg5SlF3OWlTcWRJcTdPa3J4cXNRdzJQR0dtVTZENG1r?=
 =?utf-8?B?a0o4ZmdSWHVXQ29ZbEl1NUoxTk1VU0lvQVBaZ3R1N0p4QkdrTDd4Q0dlVXJy?=
 =?utf-8?B?SkkzVitCZGZ1SGExRVlpNy90aE55OUZKM2Nzc1NwRTRzanhCVXJxVFhxSzI3?=
 =?utf-8?B?VzIydXJnRUhtMnJFOUE2N1lvRkFoVDNPSVI2Zk9hL1VNVTczYTdUeXdNeFhj?=
 =?utf-8?B?RGtHT1RtZHlBWUVib2NBd1VOTk1IYXBEdFppSDFHV1ZPWU9weDA3R09QQytV?=
 =?utf-8?B?a2FoRHduMm54S2dXSm1ocnA2aW5FQ3Myby9JNTJDN2E4ZldqcmptdjFhRm56?=
 =?utf-8?B?MVVoYUwyT0VTSE5Qd05QNjFRVGxhdjZpSmtYaEphVEU1Z3JKWEZ4dVJSSVM0?=
 =?utf-8?B?dXN2N2EyRFFySjFTSWlOL2Q5OTlUdlhFWFdOelR4K1JIQXNVZFZXc200UVhH?=
 =?utf-8?B?K1lNczl1TFpTdUh4ZEY1L3BrZWsydkhzMGhDMjhGdHBkM1NJcklZdFhzSmM4?=
 =?utf-8?B?Vm5scU1Xd3VJUitmVXBHK21ldDBkM1dTTFJSR3kxZVlhTUtYcWlPc2tkeC8z?=
 =?utf-8?B?MlB2cCtCTkdNbzMwOVI2d3BTVWhrNldHQlJIcXcrUkp1MzFkazZmWGYzZXpR?=
 =?utf-8?B?MFpEdDdGMWZNeVpoMVlZN2QxVXVhMHZyMCtXMzJnY0dWWXkvZTdaRi94RnFk?=
 =?utf-8?B?b3orb2w2UnpWLzcraTlwd0ZiSUNSVWxRRkEvT2RFT3E2Lyt3MXJTVW1JOVhv?=
 =?utf-8?B?TUVjV0IrOTdpdEY5RDZ1djErZVRGTng5M1lxbDhxaGVZYVU0QWEra1hQVWhG?=
 =?utf-8?B?NjZXQ0NiRjlTTHNOOE1rcVp3UDU2cG0wMzlBZFAyVmVXMmIyekxmUjNqSUEv?=
 =?utf-8?B?Q1RWN1Z0VlB2aGR3Z3JueXJoVUNjL2VTVG9mbWpBQ3Z4Y0R2MjI2cXpyaUU4?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oPYio1gHD3Io9hx88cBgJDWlnfZwchZk9Y3rRysdKC9YSLE2txq4+SyNzhNhobl+yasfoXrgGpjjxCJ4+qwRrCTxIgpi30am66TR792Ioo02/1RpLAwEqZGAv72JoOLM7F6q7QsRLKpSjCNT1HzbF1sH+N0MLHUm0q06EeBLFnguk542SHieCVyXgWXlR70ZEHrPwWdwQbX3bWNf3Lio+T13eyae1YEFaicDyyy2SK2cx1ITOaQwVSlbCUhtvmxbId7pWHzKKYu4vdlfr5Pa50JBMYhdxzVX64Gs4210ssiU4DGxQSKttyOC3+DRoJftwgVcfWUc6P2kO2GsFubJ9v7f07CDKMjeFruR66wElqHLWe0uulrGxcz9Y12QeEbBVvPQpSQ998U8eiREwa72iKoXE0+nFM6Auqou0SHoDer7mNoBI3+MdB3eHoRLnsWcKhxz82jIufz9gW6+fAu+yEYg+gwcziSp5tHPgb2EEnIemoGeou74m1En8mwLAIgKXXkm2JD6DkAx4Mb4avW1kkX/N+t0JAXvl6i1seucFhTSqrNEPDGbYRR3mFHqX3uNoBnBSFg1YdH7t34+9UBYCThk5bkuP4tEZOsU8FSuIYdCSgOAYggjPhj3KT98aMWe/BTyApB4EeNM01kIZOtVc/Bvn36yRTt95RGthMOPKKK/G7tV1sxovn2hKoZEX8nf8XIQ1Maw6CnoD+kbCawpwdJbXyMif1IjXdCXajBlv9xgAz7LCkITNE1p8xHYtoMyL3srj+Qsuoigr93NATtwh7id/oWHsA+wYRl1ogAA/UJDLPFhyUvI6X5OM4gGiJLEJ61hHz009btB69dO6hflTg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58562fe4-58d0-49be-fedf-08db0c1765aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4581.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 10:04:43.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwVWeyE5qWDBncnjJIkZwT0FVHROFj39idrCzjLJ0t451CD2Lw8wspEcigcvaELijuCpTMmS3MPPHBNbQ1z0V6I4NeC6tB+WXse76ZmkkAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-11_05,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302110091
X-Proofpoint-GUID: dLAYWqy7zuhhGn5yQLHvk3pM74oZ-eS0
X-Proofpoint-ORIG-GUID: dLAYWqy7zuhhGn5yQLHvk3pM74oZ-eS0
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/11/2023 1:50 PM, ALOK TIWARI wrote:
> commit "Fixes: 12b6fcd0ea7f" introduce that change in source code.
> that's reason we are using "fixes:". back-porting that change is 
> creating awkward manual conflict resolution.
>
> Thanks,
> Alok
>
> On 2/11/2023 1:18 PM, Greg KH wrote:
>> On Fri, Feb 10, 2023 at 09:55:22AM -0800, Alok Tiwari wrote:
>>> There is no separate blank line between 
>>> target_remove_from_tmr_list() and
>>> transport_cmd_check_stop_to_fabric
>>> As per coding-style, it is require to separate functions with one 
>>> blank line.
>>>
>>> Fixes: 12b6fcd0ea7f ("scsi: target: core: Remove from tmr_list 
>>> during LUN unlink")
>>> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>>> ---
>>>   drivers/target/target_core_transport.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/target/target_core_transport.c 
>>> b/drivers/target/target_core_transport.c
>>> index 5926316252eb..f1cdf78fc5ef 100644
>>> --- a/drivers/target/target_core_transport.c
>>> +++ b/drivers/target/target_core_transport.c
>>> @@ -691,6 +691,7 @@ static void target_remove_from_tmr_list(struct 
>>> se_cmd *cmd)
>>>           spin_unlock_irqrestore(&dev->se_tmr_lock, flags);
>>>       }
>>>   }
>>> +
>>>   /*
>>>    * This function is called by the target core after the target 
>>> core has
>>>    * finished processing a SCSI command or SCSI TMF. Both the 
>>> regular command
>>> -- 
>>> 2.39.1
>>>
>> Why is a coding style change tagged with a "fixes:" line and cc: stable?
>>
>> thanks,
>>
>> greg k-h

I will send new version to remove  -> "fixes:" line and cc: stable

Thanks,

Alok

