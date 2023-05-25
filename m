Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56172711A19
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbjEYWVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEYWVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:21:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487DE134
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:21:04 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PKntqq003927
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:21:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=4hBqlwgfPJco1zzeg6+iHejF69vO+73xJ0GtlzbNYv8=;
 b=VfWo9Bc+hHyeE0aZtUdmfvaqgAMs+40SNzPs2rYuIoJZZItVenCsHT9VZCdBr93Uy4VH
 Bk7ImhHbVLdy6iYY2RkIiA2I/1FAOV/+GatyPhqlNBvXfUTpTHu/lNGHh8i/MrvEOHq4
 SF0FWmFTA7FggFOCqnUQukkPv/woanPoo9zp5PMO1c4LpYsgfbgLa38tHYGYWM6fTDNr
 q5QHFyB7RsqsiR+bfwhVAsJdt/hUAIrJMZjz7N08gx7C1L/gjJWIvR0oEDXMUKwy/CUr
 /F14/60ndMSoz0QUBo7msOkPlE4E4hKRE34NNLbxKd77YqtP2cP2mk+ErHh7krt+9OZE dw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qt9b0kexx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:21:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+0YTs6aCxntDfLWlXJAoEJrpFVxSK5dIWQk3hYYOsagh+Hsbu4L47AZxDUxsDz8bPbEZuJR6ygTmuQTBFXqHQPxU/BH0EbhWfqfzxbxsAqG1eveHxz0eI9tMZLnW9qbxm4w+MmbmS3wYtEg4JV7F73wurC2Qg3zmpyE7V8OghPfb6n3iTrC9kfQZQb0hVrL5VqB0hmNDiXoh0e4dhPTtKFr+kBI+dEwBnbIMrBjmKU7h3QZjjnVl26fWCyqq9lAXFAcKqbg1jbRS+NnuPdqKVIjpHH6NgBdfysNdBC7p8IB7K6nuw445FaaeKXvLTGwUCIvXJglEnPwK9i6bUAiDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hBqlwgfPJco1zzeg6+iHejF69vO+73xJ0GtlzbNYv8=;
 b=bHYxHnQg6u+EX0HYY6HkDcYImeaF4qqPD7Qam/X6XtpGaYnJIAfOZtuj33OjHRPAwCWK69QPkIUW1CxN94EtkflvV7k5jWLemUTU7OKlfeJBfFYSCdsOdtAKfzeesJPpj+mf6NZnrh7dfq/JeFxguFpPZQQH9Ha1YvZ/QU7/ASjHnUwU0ToY2+0bfAauqnRQdpxIJ6ywlV/0PcaJLSN2uNDAhZHZoYr32IQKg4iQnoB//cAuGMIyReFJAn4ziY2hCUnQpSfE3auV1afZwqSBbv777Qr9NR2+LdUgjYnW8/H27ptCFGPLle7Qq7vjg1wU/8FtAETe0+5q/NrQj88Rgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DS7PR15MB5374.namprd15.prod.outlook.com (2603:10b6:8:75::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.17; Thu, 25 May 2023 22:21:00 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522%5]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 22:21:00 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Song Liu <songliubraving@meta.com>
CC:     Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles" event
Thread-Topic: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles"
 event
Thread-Index: AQHZiR9WEaR3xoFFfEGCLaxGjWAWL69h1CkAgAnH6YA=
Date:   Thu, 25 May 2023 22:20:59 +0000
Message-ID: <5F882BF2-6B6A-4809-B0D5-9EF430E11C2F@fb.com>
References: <20230518002555.1114189-1-song@kernel.org>
 <3BDFDE24-C5B6-47A0-A541-2BF833BBA832@fb.com>
In-Reply-To: <3BDFDE24-C5B6-47A0-A541-2BF833BBA832@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DS7PR15MB5374:EE_
x-ms-office365-filtering-correlation-id: 71e03f43-c39d-49fd-e034-08db5d6e5191
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bPoW9x8UCeKl5EPAo8f22cxHWEOLHJnU/mbe0tNyqI0q+HEYAed6uqMEwhLWXhkp0mqfgH04YNgmk5Kn7kibfGrbePHU1WtvrZdX8rxBPMrdVW6bPzAIkzzfjCgzg7weZtDMKOk9Zddtv/PYDUXFk8NnIed9/eigiiNBjg4aD/LQ+WEi3HNc0cUjOFWbGOi0zyCRkgXbHyDevOlBVZZqRnKKASRo7tgSD2/e1QamrepadJjgcoqbTDF5bedJ41zdqEv1qSpX0qPUrkR3xTE0n4UkaWVgtLZGLmrWedcgzOzgxJL1cdYop9A0Q6onOLjur0vjTqkGBQ4kpS7K8NKpiGwNO1gSVqptwuYUqXGuamRerAAUJ/nuEahjVsf2CHp/HTMHPLUHg3OAGD1/o25yk9kBLkykN5KVZhXutrni4fcDayHfysYMfKpvdvjEgC4OhGXsPWR55LSdde2Lfv6XgjNDE81mJaL8a5pNSVIrtbDv1ali0jbEFkPn32KnM/oRgc1+80jm0FUNclJAxl0ZAJHdsezc7JdzVmrDsE+hxUU5eqNcFvu13IO4bq5yyUVnmaYhvQ0yPm+DD0v/VFjQNsMC21w6v7iOQ9vVwh98aeurwKaMMTbVNdLVDWCK6DtcDHPY0Nxf6GY1VHarB8t1hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(38070700005)(36756003)(86362001)(33656002)(4326008)(316002)(54906003)(64756008)(66446008)(66556008)(76116006)(66946007)(66476007)(91956017)(478600001)(71200400001)(6200100001)(6486002)(8936002)(6862004)(8676002)(2906002)(5660300002)(122000001)(38100700002)(53546011)(186003)(6506007)(6512007)(9686003)(83380400001)(41300700001)(461764006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nfz5v7TXtnBypOBVhGoSHehQO6DUn5jM93CR4CgkwTGlkCcK1swlHUISt1U2?=
 =?us-ascii?Q?Dd1LPjQz57E5fGHKMM2pDr2zP9aJupMnX6uCUX+77mHG4k1SZ/Lle77UN+fa?=
 =?us-ascii?Q?dycp27TILEok4/mKkLYb0qQxpjaX+5kDC5zLgiuhomSjARjuEdLXwvu2aLIj?=
 =?us-ascii?Q?+didBuHMsEkvsdY9lsitM5QGEVrwQXGeiUK/euHYU1HhPVynttVgJt5ioRsG?=
 =?us-ascii?Q?M+oA5DS81rb95uMN92/fMMiYcxhzxmbRf/ZYYzMM30ss4km7gP/Uy9mN5hwU?=
 =?us-ascii?Q?6N/hYzjZYwp424zQ5yRwT24mhmKXptTM5iXnssz3r4Mn/LiF0xbQFiMese52?=
 =?us-ascii?Q?P70E8nvvuCUQLruWr0cOQw4TiRjaoTcqo1+adyj0dN/k+NVC7NZugJwSXV99?=
 =?us-ascii?Q?ieCOBltquykZH7h8c8Bs0SJDv+x17tMFmd+hOwCWmMPkIiW2nNHwCUfcOXyV?=
 =?us-ascii?Q?yB0V7ynrpaH8ro5OQOJjFA9x3j50Fto69vtUGfPTzSV7Wu9hwbUXfGGSGvBr?=
 =?us-ascii?Q?xmyNatW2Yw69YoUT48UTjWoNEckp3K0xVJmGO22P7AsnyAhu3QHxefNs4dQu?=
 =?us-ascii?Q?9hWNm5SR7N3sVucWNmjePuzbdqez6XkdqhuXCuX3SxD+2azRL/zel5jFPt52?=
 =?us-ascii?Q?QzDzwgFX1RXWENAmzMwNCnerW339mrDnpwqvRe8V0pzxlsmhG5BMNbGzKx+h?=
 =?us-ascii?Q?nwpZJfDdIkeXG36qIcDEfjMUV5JheYHBdntEPwaGtQzJYtDDfNcXyYDf8Q/1?=
 =?us-ascii?Q?OFSStV+8UaHc6lxBD7Y8sBAvJdG1WkBrGpLlu5/zT1amdq6cSbn0yWEuqrug?=
 =?us-ascii?Q?GLMCRzcXanc5Qf9QndhFi98xXpn/ybxdlHnhiJlkfA8V69Ev+GUnTT8ktr1v?=
 =?us-ascii?Q?7t2nc2EKRuwnNRK5ymE7poeHr+RNPq9yVp9ojitNhJss3YVqIPBbyazjm3FL?=
 =?us-ascii?Q?tShiPXtpWCgqagOTvU0Ha13NZwpHISpUQYFMytKRkO+NnejRJuDdzGaxAWi6?=
 =?us-ascii?Q?2ak8V3I9ElcCUeFpZwIckg6nZ6OWsXhn5UpjiDa83yrVNdR7ohQZU3Aka3FS?=
 =?us-ascii?Q?+Xxpupz1zt97sVHHd0EDvrhi2dVyrvvRJOoZ/OYqBwx58XGglR7jdBBlJhDW?=
 =?us-ascii?Q?3Tr9+gVimA39Qdw7DOYqV6epOExFuRQFCTowQYUk7UBQX2qSCMbVnXa2CLKp?=
 =?us-ascii?Q?ODwxdF/1xo+hMO8GCMPT2XZS3ivseVgE0/1O0H84BQ+LNaOoQ8N3rCJGF44m?=
 =?us-ascii?Q?7kM5Ht3bSYEsFgLGc26ir5G7spNr7IHo0DU3ZYdMoYScYfoAaZN1Xdr19re5?=
 =?us-ascii?Q?OIwjPOA8BZi9LEW3wr1/wHuakwUXMqRSvvcr8AyrTlsI1El4moDszd4d9rY6?=
 =?us-ascii?Q?5bnkx5mXFNaiUD8aWgTHuBapHInw5E1maOcxtZF1/exc6qfxuoOUQn4E3JDE?=
 =?us-ascii?Q?8d7HwEP09NHxfD5zX77hK8Vh6nNknXPX9WjOdvoRZPJPRzq+d8SOIpf0hPX0?=
 =?us-ascii?Q?SrJJ3AoB55/jsfToFyvwGAwJhFDDsr2zoMT5MA4nwSphQxy7B0wp/uiqP5yq?=
 =?us-ascii?Q?xsKdNY0enCMtf0Y7wImW1oycEEqcwA4eEytTY2b6tsW6LRF0ni9FVmaTPLQP?=
 =?us-ascii?Q?kKoPFDX6BHVREvL4H1tW25w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2F620BD0870AE4EAFA3EAA5F31F6C16@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e03f43-c39d-49fd-e034-08db5d6e5191
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 22:20:59.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhu/+EidFoI4L0VjP6srkkgSPp8ovfnl5XM742/4a2HCvg1U3BbfHs6Zp58HeDzCalghEGdQATUb4j5MtevOHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB5374
X-Proofpoint-ORIG-GUID: H6efL8MM3Hj3HmMc2tdwIQUNvdqNhDFU
X-Proofpoint-GUID: H6efL8MM3Hj3HmMc2tdwIQUNvdqNhDFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_12,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and Peter,


> On May 19, 2023, at 9:59 AM, Song Liu <songliubraving@meta.com> wrote:
> 
> Hi Andrew and Peter, 
> 
> Does this version look good do you?
> 
> Thanks,
> Song
> 
>> On May 17, 2023, at 5:25 PM, Song Liu <song@kernel.org> wrote:
>> 
>> NMI watchdog permanently consumes one hardware counters per CPU on the
>> system. For systems that use many hardware counters, this causes more
>> aggressive time multiplexing of perf events.
>> 
>> OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
>> used. Add kernel cmdline arg nmi_watchdog=ref-cycles to configure the
>> watchdog to use "ref-cycles" event instead of "cycles".
>> 
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Song Liu <song@kernel.org>

Could you please share your comments on this patch?

Thanks,
Song



>> 
>> ---
>> Changes in v4:
>> Fix compile error for !CONFIG_HARDLOCKUP_DETECTOR_PERF. (kernel test bot)
>> 
>> Changes in v3:
>> 
>> Pivot the design to use kernel arg nmi_watchdog=ref-cycles (Peter)
>> ---
>> Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>> include/linux/nmi.h                             | 2 ++
>> kernel/watchdog.c                               | 2 ++
>> kernel/watchdog_hld.c                           | 9 +++++++++
>> 4 files changed, 16 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 9e5bab29685f..d378e23dad7c 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3593,10 +3593,12 @@
>> Format: [state][,regs][,debounce][,die]
>> 
>> nmi_watchdog= [KNL,BUGS=X86] Debugging features for SMP kernels
>> - Format: [panic,][nopanic,][num]
>> + Format: [panic,][nopanic,][ref-cycles][num]
>> Valid num: 0 or 1
>> 0 - turn hardlockup detector in nmi_watchdog off
>> 1 - turn hardlockup detector in nmi_watchdog on
>> + ref-cycles - configure the watchdog with perf event
>> +             "ref-cycles" instead of "cycles"
>> When panic is specified, panic when an NMI watchdog
>> timeout occurs (or 'nopanic' to not panic on an NMI
>> watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
>> @@ -7097,4 +7099,3 @@
>> memory, and other data can't be written using
>> xmon commands.
>> off xmon is disabled.
>> -
>> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
>> index 048c0b9aa623..edfd1bcce0f6 100644
>> --- a/include/linux/nmi.h
>> +++ b/include/linux/nmi.h
>> @@ -102,12 +102,14 @@ extern void hardlockup_detector_perf_disable(void);
>> extern void hardlockup_detector_perf_enable(void);
>> extern void hardlockup_detector_perf_cleanup(void);
>> extern int hardlockup_detector_perf_init(void);
>> +extern void hardlockup_config_perf_event(const char *str);
>> #else
>> static inline void hardlockup_detector_perf_stop(void) { }
>> static inline void hardlockup_detector_perf_restart(void) { }
>> static inline void hardlockup_detector_perf_disable(void) { }
>> static inline void hardlockup_detector_perf_enable(void) { }
>> static inline void hardlockup_detector_perf_cleanup(void) { }
>> +static inline void hardlockup_config_perf_event(const char *str) { }
>> # if !defined(CONFIG_HAVE_NMI_WATCHDOG)
>> static inline int hardlockup_detector_perf_init(void) { return -ENODEV; }
>> static inline void arch_touch_nmi_watchdog(void) {}
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 8e61f21e7e33..fed4f0be8e1a 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -81,6 +81,8 @@ static int __init hardlockup_panic_setup(char *str)
>> nmi_watchdog_user_enabled = 0;
>> else if (!strncmp(str, "1", 1))
>> nmi_watchdog_user_enabled = 1;
>> + else if (!strncmp(str, "ref-cycles", 10))
>> + hardlockup_config_perf_event(str);
>> return 1;
>> }
>> __setup("nmi_watchdog=", hardlockup_panic_setup);
>> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
>> index 247bf0b1582c..4deca58ba6ed 100644
>> --- a/kernel/watchdog_hld.c
>> +++ b/kernel/watchdog_hld.c
>> @@ -294,3 +294,12 @@ int __init hardlockup_detector_perf_init(void)
>> }
>> return ret;
>> }
>> +
>> +/**
>> + * hardlockup_config_perf_event - Overwrite config of wd_hw_attr
>> + */
>> +void __init hardlockup_config_perf_event(const char *str)
>> +{
>> + if (!strncmp(str, "ref-cycles", 10))
>> + wd_hw_attr.config = PERF_COUNT_HW_REF_CPU_CYCLES;
>> +}
>> -- 
>> 2.34.1
>> 
> 

