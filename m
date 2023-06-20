Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF11736FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjFTPDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbjFTPCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:02:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E3294B;
        Tue, 20 Jun 2023 08:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2Vt4pTCY9TrsSLYPgv9LLJ8fIQTPfhUggKi7URdhBD11ZnOY3vYwdAJwZrvTgVEuhYpimspcWWGsJQM9BQqW6f0KK6GVmLfmbM4ltPV5c85QqQ0zZo9KBM7DraeP6B2Nci9zKIvRFoWfGacclMiM8uhAUwEaThr2HgLSF0FDE4TG4rX2EvP0UdhIEPzcSL4fKQcegln1/G/r1U4bp8YvM9aUymQUjFmv5t8vxS0cDUxQ8JW8+YQShOB3moLi9n9/SLBwQliRguCevJqT5ssKXaJguLRk8Oge2Fzon+sZsWJURXU2EAtH/+fqtu/4lexi46wbyHU+sUS2Kfa/ZF9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVL95KflwLnNq4ca9RL32t/8Sg5zMnPF53T95r/057g=;
 b=ec4MAdGu1aEEoZmlmcO0Vf7q5WRXUDApV160PTyHgchOKN0P1LZvDl81fUDClCdp3FdclQp3iGIdi5JgxDQk3g0CBa/P1VpUJTBobFnoORfDdnX8Vztxrep78rPiVsY+345U6L4Y0WRueQctlwfuZTm90l85VmjSWm7O6fMusxT5aMh/7Lz3jUb7/oz2wGAfTp/IF6rdFfzrcU9n/dOgzY0TZOAT0BoLEMsWA8/9YBS7G6SA+8JjSkXH9a5/3rSBoVebAyM+sPlg6iGbOfwOpqB8Ved89a4SLChSl52KMnkG4v40gpaLENBJYofEoEx6TlrwautBTBIzu+pxZPXqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVL95KflwLnNq4ca9RL32t/8Sg5zMnPF53T95r/057g=;
 b=BoOLT/2lnxy+YfN3GbdF8Crr45AD33z5x91RwG7z0gYTwV4FhN0MnCH2yqcJ+8vCLx/pzIwiOFSae5Nu++sqdzN2Llmbm9WUdXBzNg9hW4IYoSCCGUf2+J88iZHLnNgvChZG21Hy988ZQWJG1SPLREk4ZlSuV/gs04rCWy0QOQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 15:00:36 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 15:00:36 +0000
Message-ID: <debac5fa-3ea1-3796-8eb4-ff411a174697@amd.com>
Date:   Tue, 20 Jun 2023 20:30:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Content-Language: en-US
To:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        catalin.marinas@arm.com
References: <20230619092355.133c5cdb@canb.auug.org.au>
 <20230619204309.GA13937@willie-the-truck>
 <20230619143944.fb445cb3f28bb839942ed4ae@linux-foundation.org>
 <20230620094314.GA14607@willie-the-truck>
From:   "Jain, Ayush" <ayush.jain3@amd.com>
In-Reply-To: <20230620094314.GA14607@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::19) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 88900f20-bed7-4d12-e7ae-08db719f1aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1N8Q1uJdADdoZy5wUnFpr+CVSIRlwd5gmtQyEImS3osvBzm2xyFr++5c4+kHaCFCLyNcqlWTNz6I8/wx4y8nw/HvBYGYY89EK4zs5goCkJR5Z+8u8NRK85EX3FrKQaeC+i3nl8eD83qBJVERRHLADzS3jpHoKqFE0OXl7uiSLmzsoLUC3qJmFvyaIG+Uko5AUxXATrlRq181UAQDW8LJBv9E4pcBl7sfESEzIfb+LXcm1OosalJrDHXXz1xxQQ2tQKK+he0/F1aCfXM3HvWfzWJVIWKf0HcbOnRGI4PN/wH1D+0R6HjKP0yoJeAGN6I1Kxr3QJw3dv0NJBOvKcFh2K8jVOBTHY/N5qeztpc9kgUGk1Ybv5RzztcdnA3Q1GSWVsg+v4nnEuyh4ndm3lzZ5vZUY7fm/8xyKEmqI5IkkkvTlR+brQdQuc54PdE2OBU+UyvtVcBOjaeAjb5mZyWGx1e8lhlTnTBL/xOY8Qd4jMuVCbPPs4DaqHEgB/xelH2WGibbpm8FXx1nqbflCogrBhoMJWIzovLdXcrAcQc07CFGN3FAVgEbGX2FPaGvoSKzRIOAPjMT4l9eekmGxjwNL0xK8KoF3kbBKPgb+QknIMxb68j2JB7Wgs6AY3vAOs43ruzBwKm6nCB7qf+c1KCbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(31696002)(83380400001)(31686004)(6486002)(54906003)(6666004)(316002)(38100700002)(110136005)(8676002)(8936002)(6506007)(36756003)(86362001)(26005)(2616005)(4326008)(186003)(5660300002)(41300700001)(66946007)(53546011)(66476007)(66556008)(6512007)(478600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tno5dGVqYU5scklGT2J3blpibkFlWFpzZzh2V3A4UEQrWTh1UXUyQ0JoRE5I?=
 =?utf-8?B?SCt5MGVUYlU0cmZ3amNoM3BLUHVGbFdPSkZPUXJUVlRneFBoMlAvU0V3bGc0?=
 =?utf-8?B?NHg5VUNvaldTTDdMa251dGNpREh4eEdyRmJJN1pER0lSalRwdU9jUzd2UGs4?=
 =?utf-8?B?a1AwQzNuajR0TTBiRTdIcG1LTEFMdjFlMW43cnRQcnFqbkRSbm4wQTgvcjl6?=
 =?utf-8?B?ZndPYUN2QmI4WFgxWEZISS9CazVrTDI5V0ZxcGZuNjlDWEpOcDZsbG9pQXZq?=
 =?utf-8?B?SGdwMHIwTDBNRlNJaFZ1c1VIaFdqQnBxWXZXNE5tYkFHYnhZZDl3dW9jOHFp?=
 =?utf-8?B?L2IxYXdlOENsaVg5bnYzSDJmbW1GM1N3bE11UEUydzd1MEQ3MDZqN1FMN3Vr?=
 =?utf-8?B?YTVHUkVzZmsySFdhZytqbGpPeHVFajR5Nlo1ZWFTUkJJZFlyaGpXY25YYzJQ?=
 =?utf-8?B?Tzhvb3QwZm1lQnUzTStXMXFOK1JQYi93RTU4MjBvbGNJa3BSOHpSTnRTNTVu?=
 =?utf-8?B?QjNFcFFydzBudGg1Qng0RFRXdlJBTmY4L0pnK2g4LzZtcDZKTGZYRllPQytx?=
 =?utf-8?B?dXFlcmdwdHAxZ0xuRVRqSzNxenM0SG04RklvdTh6Z2orem1kOWdvUTY4c3NY?=
 =?utf-8?B?N2dzb1AwbHJzTlE1VDhBemdHbG1sUy9YM2NKWnk3VGJqOG83NUZUeFBLNlJJ?=
 =?utf-8?B?blM3RjJzTXo1Y1RPdUppSS9aWHNyNTUzL3VjQ29OeS94T0hMUUkzTSs0OG01?=
 =?utf-8?B?UVh0U1N3TGUrMDV2M2d5KzRjOWhyTCthSlkwa2V6a1YrdHduaXg0aytBT2xn?=
 =?utf-8?B?WkpQaU8zeW1XYzlVelZWUk96azhZakJtaGlOVjZtd2dnaDdrL0xObGFLa3BK?=
 =?utf-8?B?Rm9Sb3dmRVkrN2xSY3l2b2RLMDlzUDFETzBCZXkrWHFrWXk2djFJcTcvMG40?=
 =?utf-8?B?bGlidnpGNHhlNnRqNWhiYWxqR3E2Nll4VXZSUHppQU9keFRpMDlZVE9MZCtC?=
 =?utf-8?B?ZzM0aXArKzBUek1NU3J0SVZGd0JjbTd5bmNsTnpQRTRKRTNvTWZoWmEzejRk?=
 =?utf-8?B?aHVtZHRJckhOYmdSQnZrai93ZGFxSXVFRzc0a1ZsK0gyZ0w0c1dHR2cxNlM5?=
 =?utf-8?B?cmgxd1k1Q3RHL1NFUVNCaXJsdlIxUkF5d1NOck9uZFRJam1yakpSRUJnM0Ez?=
 =?utf-8?B?VVc1RERiN0pWYW5OR0pjaUxnMTg2bGNuMS9XVFZKMFJ2ODIxai9YOTlZOUlP?=
 =?utf-8?B?Y3RaL05ydFBuckgvMDV0ZVBPWlBjTG1kTUw0eFY3andFUjUydnV4QUdMMHBG?=
 =?utf-8?B?OGt3RDFQem5kU0c0bzl0R0NMUlh4Z3dGTVdPV3JOaWtvTDh0UXBlNTFOQVdw?=
 =?utf-8?B?dk5aYlMxalRWVG1wZ3BmdS9qL0dHMm1WN01vNnRKbEMvUVdVbWVPdVFEVjlM?=
 =?utf-8?B?RGtnOGFQcGlPem5SL0RlNGNnZHU3QWp1NXdidS9QRG1uMXJ3L3FmeHVaRDNR?=
 =?utf-8?B?NzYxWlEvZndKWU96YjBnL1dDRXFlNHZrcDhZZkJwd1VFZnJ5Rlp0QWdPU3I0?=
 =?utf-8?B?RUtkQmpWZjBkenlRaWVLUENzN0VaRUhVT2FITExCdTJoZmFiZ3lsNnN0ZDhZ?=
 =?utf-8?B?bnBrZDdtNnJwZ1QyenZtWW1HL0xJRzVtSnh0QzNaMmxyUEtWTURaeEluM2JS?=
 =?utf-8?B?VElLTnlPYnZPWTBEbmpYRlhMeU92dmtnUzFiTnlHZUM3VmlzSzg4S1kyZCtE?=
 =?utf-8?B?RTdldDE1THZ0RWF6YVdXeWdTOERXdjZEd0I4ZHJjNUxMWS9ZT0k0c3JBQ2dK?=
 =?utf-8?B?NHl0WTVjV1ZwYXFjUnRDaTVMNTVVS3ZLRzlKM0FueTRodiswRWFXT1RTOVNU?=
 =?utf-8?B?TlJMeVIxc2FRcG0rRTVnUU9jRmVzU3NScTE5NFJIa3ZnN0huQkh3eHhxbXpR?=
 =?utf-8?B?Ny8ySVRQdUw3V2ZRZ3pIbkZ2UUNWMkNvbVhvWjEyWnZ4d3VXVU1GeWhUeUdD?=
 =?utf-8?B?MS96VnMxUWMwZTJCUitBelJsM1ZjWGNYR0NnSjNsUDdnRU10ZzdRUTJ5cE01?=
 =?utf-8?B?TTA4eWRjMExkcy9YRDcyNERpVmEyaWx3MFlFbHN0ek5IaWNMdXJsUTJVNWlZ?=
 =?utf-8?Q?sJiBLniFj8CA4JK6lFNq1iPWb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88900f20-bed7-4d12-e7ae-08db719f1aa2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:00:36.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylbu9bRGuhNpxcETLNnphNtGp4sxOA9lRJma64PCknwwkkB5dOv4NgJtkXdXrN4AOxs0MIEVgHYIPs/h68EGfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Will,
On 6/20/2023 3:13 PM, Will Deacon wrote:
> On Mon, Jun 19, 2023 at 02:39:44PM -0700, Andrew Morton wrote:
>> On Mon, 19 Jun 2023 21:43:11 +0100 Will Deacon <will@kernel.org> wrote:
>>
>>>>    	/*
>>>>    	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
>>>>    	 * VM_GROWSUP VMA. Such VMAs can change their size under
>>>
>>> This resolution seems to be causing horrible problems on arm64 with 16k
>>> pages. I see things like the crash below, but the two branches being merged
>>> are fine on their own.
>>
>> I've dropped the mm.git side of this conflict so next -next should
>> be better.
> 
> Thanks, Andrew. next-20230620 is still broken, so I came up with the diff
> below in the meantime which seems to resolve the crashes. I don't pretend
> to understand the VMA iterator stuff well enough though, so I may have
> missed something else.
> 
> Will
> 
> --->8
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9a93b054148a..4c82e9b36fb3 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2396,6 +2396,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>                          if (error)
>                                  goto end_split_failed;
>                  }
> +               mas_set(&mas_detach, count);
>                  vma_start_write(next);
>                  if (mas_store_gfp(&mas_detach, next, GFP_KERNEL))
>                          goto munmap_gather_failed;


Thanks, Will. I have been able to reproduce similar kernel panics on AMD x86 platform
on next-20230619 and next-20230620.
By applying your patch kernel looks to being able to boot now.

Tested-by: Ayush Jain <Ayush.jain3@amd.com>
