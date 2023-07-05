Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC8C748EE3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjGEU0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjGEU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:26:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D994B1998
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:26:09 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Jrjrk022397;
        Wed, 5 Jul 2023 20:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ozpGq1Zq+KOFM96Vk8yiwBIGrRGa/i7QodeqekJLJNI=;
 b=G7Pg6RjPCGfGL6inK6yOJYeAQVaZWs99axnVNVn9bNl28TiZ0F9praW4eLi6uvsRzkla
 Rr+WJsLdI4538YyLkmUVUMGMuTBSmYKbQtjVe582npDX24Sug57x/IvLiemCM83iHVsg
 zPXQYYQ4el8VEzI4JA7LxA4MCKEwoRzE2GW/Ky2Ey0xV0R5r8VA+sSJu4y7WpBn/yr2L
 4fsz9KuxHFyncNnG80R956mHU/A0BnhLSCSQTU/LEChPjD/BcrPSJ94B8MEepq4w5cWi
 vuin5aHaFsmqGhyLAP6+rAZbO8zewJYdbLFEjAB2uGGugLtste9+KURU3ItrQm2NmVqc yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cqegf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 20:26:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365If3I8001673;
        Wed, 5 Jul 2023 20:26:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakc3gec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 20:26:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyIkFy9lZ0/hYyLxRnQoskvUgx9OOCPB+NlXvUcFPIknhbKyyftiJmgF0iYkp8z5av81RjR2CRSQYMPeBEwskJFZ36ToC6UzFaGSjwvHtytjd6gxoxpUAXOIlgK4fvBoZJdBHYvoM30R/muKuC1mZBOCpxgTXTgK3IT6OiW87zNNVxjoeNdTdUg9zATiixDLVUjcLycxkGrQ16t/CsqM8a26QWUUUhHJu5UEQT/6/ozHXLMt16Bt7JR5BRdxFEGS91TpiHcPg98/8aSCu3roMpk5Ag9qZ9SY6y3YkkLaWXIGMwwYN3no3F+EaRjy3+99jbBXgJfcKOEzStBf+JtKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozpGq1Zq+KOFM96Vk8yiwBIGrRGa/i7QodeqekJLJNI=;
 b=dYBOUQOnLF0DfXIzZdVM/0vPyHXTtmorqfURRH2eX1whOMIH4/Yp8ollczFDhxmcGjXGSQ1llQXDhUF3rNLrLPM2/MS//rW0IPXNPU4GaCQOzxrZUsY04YoqabipfHjLUIeT7+O3ErOpVPPpHVXQMjtYheAdjNDY+vslxUuOiLN/SzBp/LupZAVk4UxLjJNL3MZUvf2KDxiPlTO9pHxeHEs46a3OPzP7dlmgDqBXl880Lklef6Q9MRRrgpAlROovtGGJBjsANlgEOmHV89daw9IIZ+p3JPxPGOFP3b8p3Knc9KChAEwOYPBdVxVgs3yQcp0dQmBC7odAADBY9fli3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozpGq1Zq+KOFM96Vk8yiwBIGrRGa/i7QodeqekJLJNI=;
 b=h6dS1l7SkX6TrfWNJvP23pK/hYDuhjC+7fxGT3LrLhbVeP+UGvPmSsiWmRbyegJWSn9vy0yr/IjVUAogx1uS2NxuZbijmzD76JZUmU75HJovj8beib9RHlHcbp0/rkMZdhtS6vPyTWfx8TC+rb2gCl5M3DrAO2nMIJHIuz1hV2k=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO6PR10MB5570.namprd10.prod.outlook.com (2603:10b6:303:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 20:25:59 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 20:25:59 +0000
Message-ID: <7033e7a4-5d5f-7e7b-20af-ff1c85ec3b3a@oracle.com>
Date:   Wed, 5 Jul 2023 13:25:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/4] mm/memory: convert do_read_fault() to use folios
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
 <20230705194335.273790-4-sidhartha.kumar@oracle.com>
 <ZKXQNa7mikRJWO2M@casper.infradead.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZKXQNa7mikRJWO2M@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::12) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO6PR10MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f3874c-a780-48b3-242e-08db7d960b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnG8/C8+J+ks6xiZBIVm0hMkg14Blqih3y4uJXgHX/hxPQZ4EZ78yKe4YnfN0AMauYCg/LMMKJpK9g42X8JrWYH88Rdu89EBK72JjCgGIpaQZydpoPv8YN13pYcam4LqQEdBYBzAlW31QxQm8HeRpH+W3SwJeWIhZ7UCvTuuoDJ1RmNnszydIm997MvRqDTHWBbEOjKARNtZMIiK25coOX4Lm7b25MAWb1KzYvU1LcBtoVDNQdWbj/xYgPSnCtpkmudIAsLLyfqYZW9UeqGWPOBDscmBvGaK/9AD5N3bhNiCoW0PnPvcTqAoP0CV6sdKfqA5mz/ljL1QX8kVJp3mT07Q5PITrFOZ0MwZljC9EqkaG5ZcUFioeqkIzR+5ZIYSCqd+25bNKCjge9IcKn13NKsy3H+DxyvvWA3s6KF3spa/y0dsUN+5HelR7X+lVEmeFKgWkR1wPp1wVahG0loxKeAHTrSGQ5TLHHOQap2xHyMJ/71j0v00DF8NCm7/IoCXYmkeWX5twDUoJqqA5LYRA4cfm3pwn5XB28dx2NkA2j8EvPnaJQg3xBdL8y7xNzoPNTaCQoWVGnMTJ8ogbHR3yKIFy3GVUAmcXjswT94CfH0RMJaCFfPEIMAsXLC/wAit2W7iYCcME+hQiIy2Mpx6yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(8936002)(8676002)(31686004)(41300700001)(36756003)(6486002)(316002)(44832011)(5660300002)(2906002)(66476007)(4326008)(66556008)(6916009)(38100700002)(478600001)(6666004)(6512007)(86362001)(186003)(31696002)(2616005)(66946007)(83380400001)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmVoVXRJelRqUlNjWkhuTzRIaDcvWVhkczZHMXBEN2E1VTBIazlwWWdtS3FV?=
 =?utf-8?B?TXczSkxQWGFOWW9ubGVTcEVGUFZQcWlRUEh5MnZCbFJ5dS85Y2VESFZEcnZI?=
 =?utf-8?B?M2RMN2NpM01lVStrZjI2OG9qdDNzb1huWG5vRTZNcnRSTStKVmJmUnBSL1BK?=
 =?utf-8?B?VmM3a1pML1BLeTF5UGtwdWZBUVFEMlBsWnE5MkFKRzJZNlFQaEttOTl2OWQv?=
 =?utf-8?B?dEhISGZKUVZ4RHRjU0wrNGdjVHBpdXh4Wm9Tek1rYTRRbDkyYm1sb2lseHB1?=
 =?utf-8?B?eGNwMnBKSEVrRGQrdkFVZVdjQVhXTCtWemYvTlhtOHJOK25aODVvUTU0TXBC?=
 =?utf-8?B?K2RrYWdwTzZxeSt3bmVRYjJHa0I0eTZEU2d4cWhVTy8ybGQ3L1NUZlNleGNQ?=
 =?utf-8?B?bG4xK0I5WDZWaXFkSUJwSTU1R2FhVEx3b3RFNzBvOElhYnliV2dzNEo2cFFH?=
 =?utf-8?B?YVN6M2I0VEYvOFBKN0tqdTFyTjdrcnR6SHExaGhYSXkwK0VEOTZ0L25PaXJF?=
 =?utf-8?B?cnZNK2dCcUZGT2h6ZlZ1Rit4SnlCTFZoRytqSDF3QXk0RVF2ZktySGU4RVll?=
 =?utf-8?B?elI4dWJibGZpNU5FL05RdVkxekdCeHJDSG8xa3JLdmY2S0NBbktqV1U0Z3NL?=
 =?utf-8?B?UmptZXdnYithMzdrTFRnaEdTempvYXlBWnJCYnVqQm9LS29wUk5LVUtaNGlE?=
 =?utf-8?B?RFd0QjRUcHlrV1VjYWw1ZUlpZmx5V0swMTFoTk9aczVxVTdNSlhhaVZjcjVx?=
 =?utf-8?B?ZlBVREdLWXRGOEMwSzdQcHQxYVd3WWx2bzNjRmU5b0Z6K1JlYjE0aDd5NUxZ?=
 =?utf-8?B?THN0Tk1vaWNwNElQMXRwUVNEeFlONVZ3cE9NMzNhM3lyakJJM2FVb3lHTlhk?=
 =?utf-8?B?Z3Z0RnVGUS9vNTY3cDZab0ZKaVhhQTBoZzVyMVhkUGd6SkhlTGMxSGpDdjRM?=
 =?utf-8?B?ZldIeDU3YldGUlBscnJZU2RKUUFSaFdPSWlhU2ZobnhEN3NmMU9nTk5nbDY4?=
 =?utf-8?B?TmUzQk1lSVpqckxraXhUcldLV29BRjVtS1ljOEdvZXZrcno4cm9TNzNBVWRq?=
 =?utf-8?B?aUsrN1pxY0poVWFQeStGZ3YvcHR4L3VXN1c5bmJuTEJRMnFLNVd1cjlUVzhJ?=
 =?utf-8?B?cktBZTFQeG9WMlNYOHU1Y3JPN2JCS2tiYXk0OC9aRExIN0luOEJmczZJK09u?=
 =?utf-8?B?WFdPVDkyMzdDcGJ6ZG9oUWJGZzdQbmhmM0hWNUVHMS8yUTFTZ3dOYkR1Wk1I?=
 =?utf-8?B?cUhGcUxhaG5tMVpNU3UzV2kzT0FXT2M0b1dSc25mVDJleCtQMEFtSWw2Slgx?=
 =?utf-8?B?WUY3V3VvN2ZlTlJEYXlMeThCMTl1QkRJNVptdXU0c3h1TmdTZE9mKy9vWjJu?=
 =?utf-8?B?MWNrMmFLY3NEL2JzWnVpZFpCMGI0LytCdjlKWGUrQnZYLzB1SmZtcVo2Kzln?=
 =?utf-8?B?U05DVXhnVllESVhCS2dETEUrQU9PUU9ld0M3bnhNZTU0VW1mNFhNVDdGbEMy?=
 =?utf-8?B?bU54ajBMdHFhWmFBcHFVYmpJYW90b094bkxLdHN6WGgxQ3lodFAxNHk5VU1u?=
 =?utf-8?B?blB4NENMdjlVb2svZ3FtMUdjeDJLSUJUaWJubGVvZ0FsSmlNejhiV1BpRGlI?=
 =?utf-8?B?cnQrczFUK1dTZVNRTG91Nmx0dDd2SGRGNFZyUzJjeFdlTnZBcXBOMTByeUcx?=
 =?utf-8?B?MHcyZzExVEpoQ1Nndk51VmJ1Qk0zY3ZEdmN5OUZjVmNDZlhDZFYvMWZYaUxu?=
 =?utf-8?B?OENDT203VzB2dG56ZklVd3ptNkkxRmlvdG1YSE13elFETXBMUEYxRjRkMlY5?=
 =?utf-8?B?S2xTQVVtdGluZ1BBVytSc1JNT2p3VXlNam53ZjJtYXBFKzlET2d2Q0x3TS9T?=
 =?utf-8?B?Q2pjN0RtRlZoUUFQNlBMeVAxWFgybGxuL2hiMFpMc1NKSk9rS3BkMEdVcTNz?=
 =?utf-8?B?Z1JremhjNHZrZWNVRlM4cjk3SHdjdWFVUmQ0NXFPcjJ0bWw1ajhBUjJBWFA3?=
 =?utf-8?B?dmhOTDByaTZueDB4cUpBRnFJbmRtZEFvdTdMaFpHQitRZ3VBR1orVzJBOXI4?=
 =?utf-8?B?L3RTSUFPQmZZS09jSDNsYW5KOTFneU9NTEtlaTFvT3Zvdkp2QWpOYnY2L0Fj?=
 =?utf-8?B?cWx5azRIZnNCeklqWUFsSktzQWRSK0E1YnVGSUZrd3lSWlkzNkYvbjJYbEZX?=
 =?utf-8?Q?/AOJZyQPSeipfmTdytct4PQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: COcnT/qUuF3KNPxgq7Oz/2PMhZQ24HVHd1s1T78zRCnCeptunR7qC2QO5JLlhXtU6rbB6XE3wfONJxIir39Tl8qmJdEqP2svfKh+lCydrSd0hRV6EyhPzeMoq2+U3rjJi6pLaaPQ3AVGn+oh78fIj/VbvCg+ETpLBkNgFZ5eDp0HIpHkEc3EFFDkuXu2NxzERQbYJf0wAA5fUO44byu1fOWkGeYa0m7phrifYwgEWBeQ8NXog+vBias1Y39R4zR5J8zGLmyCxtrKcHBZ0ls4yHplwbX4DOSetc4V9AZBHxs53usXhHcLgAF21tHH/pji5UIimC9iNLY4unp9fIywd2bc062uy2cRQNPGC3qPSAWz3aAhozBY7A88ckAvsbobDgB56IZ3cyLxiLdoUiqMzGfS//HmBGXRkjyjaFVm6vL3HjTM5RF+tfsQJGtLrIoMJk3/EuPIxzn5uro0Akl+VqUjBnoPDdhFvHrPuLroe8VinCGhWvVO/1baEKoNbJvRBzRnbafslVxqWFG1NVhcGeTgvfz164xCNDF29TBfLlw26sDD2sMyFL3vVr0wr/3hiBBK5u5tXvkkqC21P+fH1BGYslmlzNtuZVfh8Nk3lWmk8Okb8AkAE0oGTMKQ3rp75r+raOrm+EyPhLiDxv1g3X/CQ4IlbtrjTqcfTHd0hLPr4rCpM/SKcctcabW6Aann0n6rg5otHSFmJSM7pjrfliLwjr1s3VJY1edcRX+NyQd91VpTKzk/KUscDyCQsXjqgezABHG7ipyh0tBLfbDrDvoLkgjmCAaf6Qs9h8aNfFgPcl72dul2f6wFuQnm7FX9DB7cgTLtNu8caHbw0W4wl+/AEqiOVplPuZXPwLPnqML68d9Myy8W/XOG47oXzE57
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f3874c-a780-48b3-242e-08db7d960b5f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 20:25:59.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGnJ4tCQGMpBNXkJqNpprPrJ+/bh3ZNMmQV7TRt533ve4MDYoahU88ElQ2JZFwGkX13m4+mpMhJW+JSkixnjrcgJUYFVlaNgXCDyEalqk5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050186
X-Proofpoint-GUID: ybPcgeZ2Nf5T0KqLDnj4p_08m-Zr8YXj
X-Proofpoint-ORIG-GUID: ybPcgeZ2Nf5T0KqLDnj4p_08m-Zr8YXj
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 1:19 PM, Matthew Wilcox wrote:
> On Wed, Jul 05, 2023 at 12:43:35PM -0700, Sidhartha Kumar wrote:
>> Saves one implicit call to compound_head()
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
>> @@ -4543,10 +4544,12 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
>>   	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
>>   		return ret;
>>   
>> +	folio = page_folio(vmf->page);
> 
> Why not move this down to after the call to finish_fault()?  The
> compiler should be able to do a better job with that; it may have to
> spill it to the stack to preserve it over the function call.
> 

I just noticed that the page inside the vmf was being used in 
finish_fault() so it would stable enough to do the folio conversion 
before. I can move it after for compiler reasons.

>>   	ret |= finish_fault(vmf);
>> -	unlock_page(vmf->page);
>> +	folio_unlock(folio);
>>   	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
>> -		put_page(vmf->page);
>> +		folio_put(folio);
>>   	return ret;
> 
> 

