Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF47708939
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjERUMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjERUMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:12:35 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C5810E6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:12:31 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIHAFC020902
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:12:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=IlU4/1Q9sBDfrsoOZUWZLxpw7CQ1FHqOchbijkAaeik=;
 b=UKeRgY5mZfMOd6XrVow3nNfGRSrOE/33m+NaR5HLE/FiOynau21XSkvJFOz48e0en9cb
 7h+oWZIYluJVa3aAG2BMnowkamq2fHsl6Zv4gRu6tlIYEEgHrCmOwU9yFoa4VWKwpc/2
 nvHiqiCRIQA05hiA1gIgGJUP2WtcP1PcbFFy+DMqDUcIvYm49r8m14In0mvpw6cbmbU7
 Ht4KlDSMwtdbBptpkL/h+XwGNJwBh9rcpx7OpDQIdmf1Wj/fvXte0PEI5ZYlAjwpVcsT
 dO3jkCflDfGfK3Bv7qDupECMCmoIYXkHP26eHBHSPeVRRDQ40peEg/Uj20Z6JIIvdYSU yA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qns5n0qvb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:12:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZKR6+3s7xBhAPcrDjm5no7QrizJgcbKwVLInX/BPEOz8r/Fs7ZSX4K0e+Xx6Kwx+XS9dRH62dQGisPjHRxxFkq5V1cpQ1oYEXVLE0RHAW1teZecBaA4y9SoLlHZXCcMnxkKBbqdzobriA7nkZ5DMfClUYVv/2Xbx5f6Zw7BTQEdFmjY92MI7N8jiWK/QggtNTR1ab999Uoskwfjxg59QSDX6oemx8tJx/JeMAVRNM5B7yhwvDcxdSAD4219YrcgDQASD1DLtxLCX6jDaAMOnm1SIQ0eo/jjZK+2d5FKbzQZe65PwZD/HSa8lZ3SGqUC1LE+l+DfVRDZp8zVhkFhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlU4/1Q9sBDfrsoOZUWZLxpw7CQ1FHqOchbijkAaeik=;
 b=Aqd46aXAE3d2uCXgx9JhT0QD59Jij8AQtAvb5BWvbyArjaVckv73zyS6VHmLJkf5D2d3yERgvpvEC3/RDQTftOgPu34BoAw45+AGi+7D9UPViKbNvDcdSrpn/e51IYGtI1NFN+YChqIxtWPzEfErJbAGBva335bKZnHDYSWa3+EzZf5DxmOr14tR+5KJPSzKd/hPlPicPjkcctKWRyqmzFa77q4dGtKgrm5+9rllIqULxZy8k73vU/+23FSLA3fqcMp6Rp5adAvJHGIAnm6kr8JFpcDWuPR8CemZFkjqiL2f0UvqbQZiu89PgXw7QkMZj4PJqjCidmZuXv5lWAKt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB4723.namprd15.prod.outlook.com (2603:10b6:806:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 20:12:28 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522%5]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 20:12:28 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Yonghong Song <yhs@meta.com>
CC:     Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles" event
Thread-Topic: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles"
 event
Thread-Index: AQHZiR9WEaR3xoFFfEGCLaxGjWAWL69fljCAgADhp4A=
Date:   Thu, 18 May 2023 20:12:27 +0000
Message-ID: <E206E9A5-7B13-42BB-A78A-CF329DB667CC@fb.com>
References: <20230518002555.1114189-1-song@kernel.org>
 <437cc3c8-73e0-dbc2-2998-39310e1597e9@meta.com>
In-Reply-To: <437cc3c8-73e0-dbc2-2998-39310e1597e9@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB4723:EE_
x-ms-office365-filtering-correlation-id: ad9c89c0-fec6-4fdc-f3ab-08db57dc3403
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9u/DlYXCAn7zB48AuQ6NJ5RFtpCzyAm5p81nqEUKpOTG1qn0rcu52Z2f+0PQPXzAyzXhzMNvkDytCNRUAFB3FgypgtRl8j1YgxFI42dt8aTTWH7o1QQv1bS9lkqMibosNLxLZ3TFFk7k4RoC7I4P/d976C/wlJYMQS8UGpAgwubwSk2JoZK4/BsH76mRWe1AO/cFDfUevADy6BHqmP6WM397Dgc4wVD0VCSiDrJMg9Ys2XZkHDWrDT6dArc4FDxMMuFcJg9zaVgcUW8NTrHgExGYGHeIUNrQ2cT2AZEZ6Yw2aWceRJu3fpe+Iw5cTc0KO24o7BCzOo6OwxopPP143fsa/btX6b8M1N1+N+ApHfpijz6jmZy8RKTCaIh7g+guKL6ZGG4TFs3W7MPU3FPqzzOxGw2cyKyee2SEBYXkYMFSKdlX0hB21CxxD4LJrBflMsuJz24I/IFImtRntG8/fojYL8PNFTJLcEZPvGctor+NPhJLJ8c4oXKDeRQbB0k8wtRi81i/TGzcbVvRDZeYUiLHu/eG6IRvNZ+ZDeDnH8zIpwpOC+CO15UDkQRW2YUSNx2POGDC5OFg6liBH8nkKi3dzSTLxVjwcA7VCjkQXFC+0moJM2emaj+GvHKc8ZQz5Wg0gCUZQvvtfXbJzHHy6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(86362001)(8676002)(6862004)(8936002)(5660300002)(66556008)(91956017)(64756008)(66476007)(2906002)(66446008)(76116006)(66946007)(38100700002)(478600001)(122000001)(41300700001)(38070700005)(54906003)(71200400001)(33656002)(9686003)(83380400001)(6486002)(4326008)(6636002)(316002)(186003)(6512007)(6506007)(36756003)(53546011)(461764006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VOpfP18c3HW2zvg8k9F+zGfY3UXWRYrCbS80lGYCAL/P6J115D2VIvgtljcV?=
 =?us-ascii?Q?1bL+jZ76bfpPm+h6fQev7K4ye7pn9NWqWyzJN7F44jIFxU3/Ddr4WZYLYQi1?=
 =?us-ascii?Q?2lQ6kr+ptU+UATmFYbOxyw5WR1Xukd205HRZHSj2c+TrLFk6L8/xJGLril49?=
 =?us-ascii?Q?HHhOvVJqIWNPBNfr900Q3LbGYEkgkwEJwHSCrjPR53GQZcQ3c7isizyceqmE?=
 =?us-ascii?Q?LYwXQElx4JaYNtNL7BIwQ2PnjiCokWqC8djEwRUf/XKOc1ooCBPYRK4Sv6S9?=
 =?us-ascii?Q?6hf3SGSnCNe356d+L7phOn+g3Stpzz+wUBtzbdP0UsvHrX5mkqrOJXVItBZu?=
 =?us-ascii?Q?y6N4I6htPJhC5wgTOxwrNncKC1vpDsgNdhVY9IAN6M3fCNsjtuKOSGoAtisp?=
 =?us-ascii?Q?XRJan5I5xe/wsqI1ynxDOSnPiGamRGaQuVemOx3n9IwndJbqerO038+nHY/X?=
 =?us-ascii?Q?eoq9JERvDovu6Gicu7igFFvT0RliRqt8DWX6Jpi7FZokaXLN5hxteT6Zq+gE?=
 =?us-ascii?Q?rjEZDFfk1ySz8ColbZq+JID5PrUpQQG/0GG8qEkDa4wiIbiUnqh6JP8h+/Lg?=
 =?us-ascii?Q?SDSvh4qrURe26X2Z/KL893QpEaDMXogPaT3PrnCf5Mixh9k5nFeIFWaJ3Uii?=
 =?us-ascii?Q?FBvoKWOaVYN0WnJVZ6EmdxlytHFMpIgGLWgf+MoYamiAHJqCy5RCWx5ztH1Y?=
 =?us-ascii?Q?VB1dzdCC3RVHS1bsMNWxwHKLE9MKksNq3SXv5HgZV53bcoagvm8t2WzIgXii?=
 =?us-ascii?Q?DZg0ozZyRjJAKW+7bu5+guaaEziLFYt6vwO8Dr4l4076FjToeuD1m2bwu6M+?=
 =?us-ascii?Q?QpHEUuD1NCsV2KXQ6M+kr285ikkAqOgoVoduUICnhHNU2JfAf1bSpylD5Y12?=
 =?us-ascii?Q?neZ50nZv+lh18+6hOCFyYiEJH7YjJJz3evt2j7u6GPFGAJ+BYH9sX+7iZ/L+?=
 =?us-ascii?Q?X3mWgVdS9qtP1I2DKjvb4I4BVcYJ8y5MRRIpGnXio/YMjhorbLOCnPa6ToGx?=
 =?us-ascii?Q?SEieiCAR0OgXDGHbfjwYBt/xSkajV70jlRxmz0FNFfGIslopZdDbLiG+gwAP?=
 =?us-ascii?Q?HTsr2krfT7yvW2nexc/+ht//6Ly2iwqTdLlHhQLma8PqPO5uWVctcybDvl3v?=
 =?us-ascii?Q?+t9uKCGd+Seu4B/JXssXdgbO3t39eJKJ1EO0+73oLrKtrw2lnWbZLtxWitrZ?=
 =?us-ascii?Q?vWys3JOKTODxLsfRMQQ9BMpojMFd7Z8Tn2KuT4CIvNP5wzfDnePJP16G6UmB?=
 =?us-ascii?Q?Jp6ET0Ud6AvIH9FJ+9as+DJ75HS+GbOfn0DSv57s0/xGP8qFWnTSCSvzUsPF?=
 =?us-ascii?Q?iEQu90irlvGemp9TcQLgrg+CM5Wyy7CO8evLln4n8el2k110TMObICZ7i0Kp?=
 =?us-ascii?Q?J/b72jvmihKE+zpV73lxIsHGgtDitwACVCLnkKgWqQMU45JqXsoXBKvqpN4U?=
 =?us-ascii?Q?MxHAtYVmjfnWHCTQ/m8nTTTPP1sMOrxLs/HwVLRMsnEE1X8XWumJlRl3t6ws?=
 =?us-ascii?Q?5+tlYzfMX0Xn6eiNRBDG6Cw6pUOt84VjnRpDkVV+AkeHLmdm63kYrIdzDvpw?=
 =?us-ascii?Q?w++20cHDvHMvcsY6Iq/oAEKcMd294M0hFETNyNGZxJtEIfCRAMijgBUEormw?=
 =?us-ascii?Q?Lw0XT911ybesXBi6CEkKhJk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A548A6EA520BA45A72CB6FDA3D9CC9A@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9c89c0-fec6-4fdc-f3ab-08db57dc3403
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 20:12:27.9900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1TAViswlvQBn9ArMJloyzQ5NqXW0F8Jb/FE5fNl0zNUibIzy2O8GHXd/qjh9dz70I89cXPI+TBM3xdme2u1knQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4723
X-Proofpoint-GUID: Tlyqw_ssMnyjpjGP2n5VP7QTVbf7Z_uz
X-Proofpoint-ORIG-GUID: Tlyqw_ssMnyjpjGP2n5VP7QTVbf7Z_uz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 17, 2023, at 11:44 PM, Yonghong Song <yhs@meta.com> wrote:
> 
> 
> 
> On 5/17/23 5:25 PM, Song Liu wrote:
>> NMI watchdog permanently consumes one hardware counters per CPU on the
>> system. For systems that use many hardware counters, this causes more
>> aggressive time multiplexing of perf events.
>> OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
>> used. Add kernel cmdline arg nmi_watchdog=ref-cycles to configure the
>> watchdog to use "ref-cycles" event instead of "cycles".
> 
> Maybe list some example how this new option will used?

In most case, all we need is to add "nmi_watchdog=refcycles" to kernel args.

> 
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Song Liu <song@kernel.org>
>> ---
>> Changes in v4:
>> Fix compile error for !CONFIG_HARDLOCKUP_DETECTOR_PERF. (kernel test bot)
>> Changes in v3:
>> Pivot the design to use kernel arg nmi_watchdog=ref-cycles (Peter)
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>>  include/linux/nmi.h                             | 2 ++
>>  kernel/watchdog.c                               | 2 ++
>>  kernel/watchdog_hld.c                           | 9 +++++++++
>>  4 files changed, 16 insertions(+), 2 deletions(-)
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 9e5bab29685f..d378e23dad7c 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3593,10 +3593,12 @@
>>   Format: [state][,regs][,debounce][,die]
>>     nmi_watchdog= [KNL,BUGS=X86] Debugging features for SMP kernels
>> - Format: [panic,][nopanic,][num]
>> + Format: [panic,][nopanic,][ref-cycles][num]
>>   Valid num: 0 or 1
>>   0 - turn hardlockup detector in nmi_watchdog off
>>   1 - turn hardlockup detector in nmi_watchdog on
>> + ref-cycles - configure the watchdog with perf event
>> +              "ref-cycles" instead of "cycles"
>>   When panic is specified, panic when an NMI watchdog
>>   timeout occurs (or 'nopanic' to not panic on an NMI
>>   watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
>> @@ -7097,4 +7099,3 @@
>>   memory, and other data can't be written using
>>   xmon commands.
>>   off xmon is disabled.
>> -
>> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
>> index 048c0b9aa623..edfd1bcce0f6 100644
>> --- a/include/linux/nmi.h
>> +++ b/include/linux/nmi.h
>> @@ -102,12 +102,14 @@ extern void hardlockup_detector_perf_disable(void);
>>  extern void hardlockup_detector_perf_enable(void);
>>  extern void hardlockup_detector_perf_cleanup(void);
>>  extern int hardlockup_detector_perf_init(void);
>> +extern void hardlockup_config_perf_event(const char *str);
>>  #else
>>  static inline void hardlockup_detector_perf_stop(void) { }
>>  static inline void hardlockup_detector_perf_restart(void) { }
>>  static inline void hardlockup_detector_perf_disable(void) { }
>>  static inline void hardlockup_detector_perf_enable(void) { }
>>  static inline void hardlockup_detector_perf_cleanup(void) { }
>> +static inline void hardlockup_config_perf_event(const char *str) { }
>>  # if !defined(CONFIG_HAVE_NMI_WATCHDOG)
>>  static inline int hardlockup_detector_perf_init(void) { return -ENODEV; }
>>  static inline void arch_touch_nmi_watchdog(void) {}
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 8e61f21e7e33..fed4f0be8e1a 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -81,6 +81,8 @@ static int __init hardlockup_panic_setup(char *str)
>>   nmi_watchdog_user_enabled = 0;
>>   else if (!strncmp(str, "1", 1))
>>   nmi_watchdog_user_enabled = 1;
>> + else if (!strncmp(str, "ref-cycles", 10))
> 
> str vs. 'ref-cycles' is tested here.
> 
>> + hardlockup_config_perf_event(str);
>>   return 1;
>>  }
>>  __setup("nmi_watchdog=", hardlockup_panic_setup);
>> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
>> index 247bf0b1582c..4deca58ba6ed 100644
>> --- a/kernel/watchdog_hld.c
>> +++ b/kernel/watchdog_hld.c
>> @@ -294,3 +294,12 @@ int __init hardlockup_detector_perf_init(void)
>>   }
>>   return ret;
>>  }
>> +
>> +/**
>> + * hardlockup_config_perf_event - Overwrite config of wd_hw_attr
>> + */
>> +void __init hardlockup_config_perf_event(const char *str)
>> +{
>> + if (!strncmp(str, "ref-cycles", 10))
> 
> It is unnecessarily tested again here.

In that case, we can probably rename the function as 
hardlockup_use_ref_cycles(). I am fine with either way. 

Thanks,
Song

