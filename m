Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957A074610B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGCQ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCQ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:59:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6340BE58;
        Mon,  3 Jul 2023 09:59:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G8fS2020452;
        Mon, 3 Jul 2023 16:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ikAaTQzLfOOmcMzlqp3cK2MZCA2eXnVXtcWSBj1+Uzg=;
 b=j+P36wvdOPXHMAZopJflV0wBcBfBvrvwF55beL/ZlvOv/lhWWHtfSmoFpon5q0rQ0hVG
 156K48jEegT1ZaK7PYLTEzHB23kXTe2HW5XDq6uwGRmMu3cT7pQfiJukdruE171ra/CC
 GT+VmLkVlITJBCZeSZHd0/THYpqxy2UgFbkZjHvGWbLgkT8LWg/qu9lTDnuM3DMT1WBU
 kuRkHjzIzRi11lpJXzjZbxp3223FrDu+WR9A2ac1KX0WzayqFe+6Zc5SjIZiFyLm7DqW
 YqFufIKJstcYJqTyJF78svm7Ld64O/qQZuC7LVyQMFNOUPiqLDjeonFG1DbeTLkm5QIe QA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjax3b52h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 16:58:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363FJE9V040312;
        Mon, 3 Jul 2023 16:58:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak9ayy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 16:58:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZasWOog198xv35CbMXWsRLrGrLjLmfLooObaujxw7XmzB6h8VSzj/ZUnKkGb0tqBQH0gRB09y0ErwrcsOSSjG9TQ0tw81/U7Gdya+botjglQr9ujf0iwDWbR84JSG7tomGpS+6TGjymbnVZvmCNaOOeVcqcf+pLhVPWy0ZrCUSbbxRa2oBYilVCBQ5Q4fL03BQa7Eo36Ugh151ut4qeHtsz2IcKxVa6hbONUHGSK4rhgKcAMpippejUzT9kxtRbdslIO7deyZ7J3AfPudIa/rGgQVuFp1iZZltPe5HR0esSjhfsTJl2VJXe1mno4IPPMD5l1voGNs0epXqjolSuNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikAaTQzLfOOmcMzlqp3cK2MZCA2eXnVXtcWSBj1+Uzg=;
 b=RDBX378b4BmVGvRWaCFKjvPmlsTi1EV4q3k0MifxW1IwyAknsNQUzPAV7bNMwRNZcs2alOukeWiQeH+uLt/DwMtL16GiSkAxJnFpvfre1PHujELTS9nuI5nnnK5LvSyD5RA5e8/liaOmdSkVzYs4vcqS1sFR7r4+iy23Lv/XtaOgVajrs1DM8vpuslxYVZm4AMPbYHbSxs4zHR8PUwACNJof9qo3qI26IQbj/W68cVIHoTQh0QjGiytj29Qn3ADHAXEtezAinXMzYl/II5HXkgWQ8B+pMsXaaJCIxyhu0LW8c5knfRSjYBJQyo9voB+7gtSDLbgup9YQxDLY8G1pTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikAaTQzLfOOmcMzlqp3cK2MZCA2eXnVXtcWSBj1+Uzg=;
 b=dhhSdHSiYqcMR2ezJGUrpoaiZ+dUa2UIXVnrxyafVEIu3MhE3C8LoYxQDMmEHLqLf19NP98LHgCt6G0rYbGbVrkfTEKr8jvJFQtikSReWgGiY4XBwMelQzewYYzVLnibuA+c1yaEKXc7uG9Ey5Zo7prWhcKt8zBUkQ7/Fo7i+xs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4638.namprd10.prod.outlook.com (2603:10b6:a03:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 16:57:58 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 16:57:58 +0000
Message-ID: <0ef856ba-c32e-c0bc-f5eb-e0af024cee29@oracle.com>
Date:   Mon, 3 Jul 2023 11:57:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v25 06/10] crash: memory and CPU hotplug sysfs attributes
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
        rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
        lf32.dev@gmail.com, akpm@linux-foundation.org,
        naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
        bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
        seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-7-eric.devolder@oracle.com>
 <2023070359-saline-unsolved-3a99@gregkh>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <2023070359-saline-unsolved-3a99@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB4638:EE_
X-MS-Office365-Filtering-Correlation-Id: 720fa8c6-445c-45a6-51cc-08db7be6a6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+pByjMPDusqvXb4TissUbGdJXUV0y0/hIRXqk0NwKegWbb0AzTNtW3Z8Ire0fKeFLKorlJAmwJIFkjVXyT7Vw2c8wqy403OXphDteetQiJDM1DBKOPN4cr5C3yM6bqSOaa7d+O0dpQzv9sTw/amb/qexwER9NRE8tbGEAM2V28RYq2lgAiJn9k3ruGbmgUKoGDSbLoi69h8GP8wjfzT9/hMWoq7NMeL+z0EAYwcHbuDPT71AvAKVFwEVAkLQtI22Vf9EQYn3GQ1KrZWp+7KvD9evMBi+TOpa1g0r3+TJkDlKiLpbo4w8XBLUjrX/nGnrDGjOPOc9iI2sv/MiLFE1Ob3rxtzkSyFdRgoroC5p3Fvioez49V/VuohYiO/KNPHu5+vZuDTdqb3Fr/LnMW1ahSGHtDe0RSYUqLtf/iGqvQ85iI7dBM2S7i70EucoUhCnl5djWM+mvIWgSfJwRBtE4rLwvf2OCQKWvTPnJ5XB8hPxw4vkf2M+zMzNbt4NoMZVF8T+H1pA25QVORYhbcmhtrPlM8UzZjZ3hvtLUZjdN4tnIBgixAHk/SPz9rWN5vLOhx7UFCcf3eoVyDz6krzr95MmWvG9vLcnJ+UzqqyirptNoBqZRFGyVArnCuYGVi8YWCnBk00la97GfXwSUMyTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(107886003)(31686004)(478600001)(26005)(6666004)(6506007)(6512007)(31696002)(86362001)(2616005)(186003)(38100700002)(4326008)(6916009)(66946007)(66556008)(66476007)(6486002)(53546011)(316002)(5660300002)(8936002)(8676002)(7416002)(7406005)(4744005)(41300700001)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZPWWdQODdsL0lOWnRQNTNSMmFGOGNsbGN6eTBPQ2QyZ1F3NnNtdXgvdk9D?=
 =?utf-8?B?RVgxSThHMHp3T0tjTjZyaExZYnRWdEpOdHYrbjNsSXMvajhhaHZqSU9DaXF2?=
 =?utf-8?B?Tmlsb0FEN1phQWJRYzczbkxHTVFYQmxKYmRrVnZvNUZmWFZRY2h6cmx6bFNm?=
 =?utf-8?B?VWRGMHlTMjVKdFNtZXhZdzFYOXdmelV6NHFkSWx4NGZHYWtSTkpGcU5nSEJv?=
 =?utf-8?B?ald1L3VlajMrQUIxcjlYRzZ1N041aDJWNjQzQmFlTzM1ZzZpOTVDT0JLZlg3?=
 =?utf-8?B?UlJYTWFxNnZzck1leGxrNUc1bnBPZTJJZTlGQkU0U09Rbmc4WTNUM3lZZDU0?=
 =?utf-8?B?N3pzTnRQaTlsZjR2R1c2aDRZWVB6TXdpUndINW1nOHAzTTI4RFByT3JiNnJ6?=
 =?utf-8?B?bDlLMFVLRFRWVEtpZ3hFYjlLS0lzb0FVdjZyUWI5bWtVdVFoMVQ5bXZ1WkVl?=
 =?utf-8?B?MWVkbG1Udzh4WXRabHNDQ0RrMTM0L1ZpaCtkM09aMGxJWURtOWJMclVGQ3ZX?=
 =?utf-8?B?ZE5zT1VwNDhuU1I0bDB6dEZ2dzhoN0R0czNaR05XRlUyQm5WeTA1aHZ6S3pS?=
 =?utf-8?B?RUlZZDU0ZEZMUzU0c1diNmtHSmxTMUdSdzJVc0VlY3RHOVlRNTJVcUtpeE1j?=
 =?utf-8?B?U3hsc1JxcG5Sa09qaXJYWm1mWGF1UmQzcHovbnVXVUoxUkxNZFlvaWpRQy9O?=
 =?utf-8?B?dm1vZFJKb0x1MzNNRVVWTEJqY0F5VkR5V3dEUzVHRTlEUmY4bEdyT2llaytX?=
 =?utf-8?B?Vi9Pb3lZWWJoQmlVUFFmYlhtVml0NE10VDZ2c2ZSUW90MHRNWG4rNkRRNmFP?=
 =?utf-8?B?dFZHcXJWLzg3ek1YMmFpaTc4YXRqbnpjRVZuMlczTC9iMXE3NWcxQ3VZdCsr?=
 =?utf-8?B?Tm9kMHNNOGcxVDZMVG1Vb21nTE9XdWIvOGZ2OGkyaFhFSzhjTDRwQ2lOQzJu?=
 =?utf-8?B?cnl3bkpyZHovT3FpWHBoSHdpWVRKNUgwUmMzOXhTaHFRU2l5SWtIZjcxbXZ1?=
 =?utf-8?B?Q01la3RpbC9kUmEwcy83YXJzZjRNTDBtV0VGS2VQdUY3bFJwQWY5bmkyMXZB?=
 =?utf-8?B?ajBQTVg1V1R1RzBnT3phREh2aTVIUjg3ZzNueFRVL1djSnRwbkhWYWs3dUhJ?=
 =?utf-8?B?ekpLSXI4WGRFeTJROHVNeUZQK0s1dUdsNjVZOGc1aFpJUCthRVlYamZxU1Ez?=
 =?utf-8?B?Y1ZOV2c1anovUS9zMzNIZEFONDF6cUhzUEdwK1dURGF3bGRYNXBTYituck93?=
 =?utf-8?B?cXdUWDNXc0NJbHIrT1l2NWtDR3lxYkMrTHBKTllHc3lCbUtmQTcxVTh0RS9Y?=
 =?utf-8?B?emMxdVIxMUZib3ZaL2pTYTNoTTdDczRtbFE5dzZPZ3B5Q29FMGJORFkvWUE2?=
 =?utf-8?B?TytGMUY0aVkva3pZd1lJNkJNSzh4RkdtQm5hcFlpL3UvUWJSY0JqeVRjVDF1?=
 =?utf-8?B?NmFicnhZbTRUUDJ0cHJzaEY2S2ZvazdIRWQ1dlBxckFUZnR0cVkzVWQ3VnR6?=
 =?utf-8?B?QS9NUnBVSmQyc0ZuZzJDTEZaS21kdHNqZ2hzR2U5ejZ3V0xJMEhVUEViMHQ0?=
 =?utf-8?B?aWhNK1BqTm1senJ5NVN2elFqaTI1V1NyUVdRcmxDVTdkbEhnZ3ZJT0QwdHpy?=
 =?utf-8?B?cjRoaGd4WENEUkpIL1ZyMVgwNVVFdFNMV0FZZjdwTnBBRVo0dkZuZjFOVU1N?=
 =?utf-8?B?aEd2cXhnZmgwd3NxdlRCTHZNRG5NcE90SEJSNit4anVUdGNlQnV5cnlSZzUv?=
 =?utf-8?B?MjNNa1hFZ1BZa3Q5clhrUjBBWGFiQ05ydk1NS3lXOGtJbnN5VHNlQUtLSFRK?=
 =?utf-8?B?NnQwcEF1NzRESVIxTU1xSzNDY2t0VEJsYWZoaCtvM2F1Rzl3UnRkRVVzUkRl?=
 =?utf-8?B?TjhnQTRJOGdLa0xXTUZLZ1dTbit0aWtUM052VnUyckFGVE51dGowS0QvL0t5?=
 =?utf-8?B?SC84NEd1Q1FNSFJKRWRzbnFubXBvN1dlZnB1UDkzZnQ4SG8rbko4NmF4dWdS?=
 =?utf-8?B?WTJlKzhqNTFESzFyL1hyTnpoTFR3N3hneHhmZmRUdFB5TXNhNDkvWnZJendP?=
 =?utf-8?B?WnZKZjNIeWNUbVRHanpURWRleWdSTWJqamN4Q204YkI3dUl3UGRPMFE3eWFN?=
 =?utf-8?B?VStYdXRZaC9hOUtjZUJBTTBRTVdpMXZxN3VCUkhEMWNmc3U2SEI1clJrL0tQ?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZWh0a3Qxc0d1UFROTHFVT2J0MHlGc2EwZUFhOW1FZG81YzJpSHF5OFhsaGc0?=
 =?utf-8?B?eE1xK25SRGJEbWJKR0NIMFo4VlhScXNLZUFXQ0tuMFlSV2lYVGFEVkg2Ukdy?=
 =?utf-8?B?cGljc29Denphb0w1MFpubVBqUmV0UFJjd3hGR0ZNNGEvQmtEUDdBWGZtbG04?=
 =?utf-8?B?WDRQdEM3clZBb3g2ek5zZDgzNldmTFJ2enRYdzlmMWlYNEk4STVheGNNb0tT?=
 =?utf-8?B?SVVHWDA2TkM2YWdUWFMrd1BXYzlRdFZXRFhHZXl3akFlaXVLUjR0SVhJVFY4?=
 =?utf-8?B?SExyTHFXbTM2OXd6b0liT1h2ZGJ1Y0RBR2t3VW9UdFV0QjZWUnlIdGFhZEpk?=
 =?utf-8?B?Wmg3Z0ZvVjBHdjMzZjFWS0pBN0J5aUlOa3NGV0ZBYTc0a09aWHl3RksvK0Mr?=
 =?utf-8?B?THhyY0NhWC9ZRWY5L2R3dklGcldkR1JDSjErRGVHS2NxWFJRU2JUYTFDSjdr?=
 =?utf-8?B?TS95NFcrRzFNOFVlRjZtZ0tVcXdvWjFmbDFibjJ1Nmtmb2lhdlFDckNrY2xS?=
 =?utf-8?B?YWxnRGpWUWpOVGx6TzFEL1d6dXh2Q3FhL0puckdEZWl6dHBiK1JiTFdBQmRS?=
 =?utf-8?B?a0lUOEdhTExzQTUxZ0xKV1lOMzhmQmhzNzcxNXhRYTJ6K2ptUDI5SlNTaTRI?=
 =?utf-8?B?cjRrSHlJdXlBNTJ1bUdEV2x0Ym1wWk1NNGNYSnJxdkJGa3FEeHN0WXdiQ25a?=
 =?utf-8?B?dUFlaWM4QWJpaVBrT1VFakpnS0VTZjlFVkNreXYrSExFM2NZdXNFbnpMTDV4?=
 =?utf-8?B?cVBIaWU0RW1jRFpnOFVtb2oxUUNwVkJLSjBpRVRlTjlZZHRiWDB4NVdHbjBB?=
 =?utf-8?B?MWFFR042d3dnWDBGamNIQy9pOWUxSlIvMVR3MGZVRVF0enl6S1NZR0VmTzZh?=
 =?utf-8?B?QmVENEpCWFRvSUU0Vi9iR0RJSksyMDN0aTE4Q2xBSVgrRTVsM2tJL3kwTktL?=
 =?utf-8?B?NVNmdGVINVFYVFBFRjZabkFyMHRJeDVUSnhiRjJ1YnpQdU53S3ptTTd1eHVo?=
 =?utf-8?B?VVJaWGI3akQ0VzFVQ0d2R21xNUNjRXp5TVd3YkhZQ3VXTkpwZER4MThDZjRN?=
 =?utf-8?B?eXExRnNzdEZlMG9UVDBZZHJmU2l3WGZ4bHNweFJYVXJZS3Y3RXJiSXFlNXlK?=
 =?utf-8?B?aWpiTG96VEMwczVHL0JDdzA5VjFHSXJXR3lVZmhGUDlXWGYrOTl3WHlOR0RF?=
 =?utf-8?B?RTJmR04vd2ZLd2NUS3BGcmZiL0hGSVFuWUtSbzRmc2ZQSjQ2czc5M3hnckNS?=
 =?utf-8?B?UENWWm9KTllTMllCZUgyU0VTakRmaFpCaDdQa2tUelJLYmpDaW1UUFlYNGRU?=
 =?utf-8?B?VElBdFQ2NENyUDQ2TDVhSlV0dFpDYUlEcnFDSk0xcFpZVTE0OTQ3WDhORG9P?=
 =?utf-8?B?ODFhRHhwYXZMVGlQRndRWndoRVNQS0lMdFc2WTQ1bURaUm5TRE93TmVGK0ZV?=
 =?utf-8?B?QS96TGVudytmeXI0WDhaMFhCTWMrWnVheGFaTGFrejNZNG1rR1Bobnl6eWRl?=
 =?utf-8?B?S3YzdWw1cXJvQ0swd1gwMzhzY2IrWUVjZmlhSHFKZGpObUpmK2RTaElKSm5G?=
 =?utf-8?B?aDAzd2x1aHdRb2lFYklPV2ZCcDhrS0U3bkZkbDNxM3Bhb09YdmRRZUxEazB2?=
 =?utf-8?B?ZmIxbTJtUFRHN2VkTlhxN1BidWltQXhCYUx5TnJ1NWp4MHZUUy80RElGN293?=
 =?utf-8?B?ak5lQUtoWjZ2a3l6UFJlRkVVeUtRaDllT2toSlp6K3ZoT1l1cURYSzgxUWhN?=
 =?utf-8?B?V3BLRkRrb2hydWZqekQxMmptRWJCc1ZmOEphL3JmblQ3M3hFYlNGSWRBWGM4?=
 =?utf-8?B?ckZxUnROUzQ0bWJ4ZnV3bGtybHpvRFFxTEpQdTE2OGZBUkhWb3hGRzJyNUJu?=
 =?utf-8?B?RnVVa3NNNUxUaDdWMTEvem9JMHUyLzR5RGFlRTl3VEJFOXZEamgxL3RuU0li?=
 =?utf-8?Q?QoglFN2xz9U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720fa8c6-445c-45a6-51cc-08db7be6a6f5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 16:57:57.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwoMIEGsQ7vjVCs/mMPLniyKgEHPy3aBclK96GuvwGUvBhDsbJiwXWLFL6n4d9XQWdnliU6fa5bF7AAxXywIsa4UvCWbb7khAViXDjec91g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030155
X-Proofpoint-GUID: 6DdgYeK9DvZa9gbqPIP4VjT06-ok8wNS
X-Proofpoint-ORIG-GUID: 6DdgYeK9DvZa9gbqPIP4VjT06-ok8wNS
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/23 08:07, Greg KH wrote:
> On Thu, Jun 29, 2023 at 03:21:15PM -0400, Eric DeVolder wrote:
>> +What:		/sys/devices/system/cpu/crash_hotplug
>> +Date:		Jun 2023
> 
> It's not "Jun" anymore :(
> 
>> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> 
> Why are you not going to maintain this?  Why is this up to me?
> 
> thanks,
> 
> greg k-h
My apologies, I'll correct both in the next posting.
Thanks!
eric
