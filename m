Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FCF709D14
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjESQ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:59:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8D4132
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:59:02 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JChS8k020839
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:59:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=A6bD4pqAy7cB66atyCNREi+vmWF8SO6MiaWbWqZiKkg=;
 b=PvtPNikYmPXXf5tdQK9e4F6KDGyRvScX+5TjyE05uyZ1edbAaciKfHqJWe4PSbN7czE4
 CTwqomrj/V3uqtBIL1SjeKPHcIenxnkNLxuUwnQnklQRGz4SfBdrq2v2VoVtf07nSMAS
 LVCT0Jj5BzR2divNDzJBoBxQAbPJemrREB2t57Trhhkc+kUFN0tKx4Dys0NNSIIPvlll
 8ZBublfr7vNPHOTCZTQ0ZeKEU7iy2cog16lSm5FA6fTlRLsEtVO9j+3rXMwLFgHEhkxi
 7v8Hs0iqxzX1dkLsgDn6sZdmsLWgSjEwG0Wc+48EwA4slkPvbR/owICxepBYF7uhCH8C ow== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qp9by1r92-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:59:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDvU8uuAVRoU4tA3IVaw44QMJcIRuyK6/YuEyOImy81Nt+QKl/Rw1paObFXn1WZgWzNsrbUpLNiYeQJ/YXzwKbuNUr7DJ4jA//yxuJu63gpJDgmyxKE+aXjDXw0tlqk/Ehq+knCOXqEVit6zYSr5jFKtKTPrfUEhqgGDIHI/gLt0Q5yr/1hyomYDGowGe3XLkim2dJOKt4mw4qstGsspnHU8MrmioYFWZUlvUV0yu+yMxtfjQ3x71jPM75CpQK7jqSo00RverkBJzMC/m2Zfv46KUGp3dfWF7/8guiKqBW1UwJT6MH7xjm2sYfcuxjP7YiY9qze8RTg+tfgYja4a7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6bD4pqAy7cB66atyCNREi+vmWF8SO6MiaWbWqZiKkg=;
 b=eZzVU3OvemKY7QwKoNmh6/ufIocMTCM2Sc8Wtdu7k3GnAfLwzDYiGZIfqBGinlEFmlcxZwf/02l9wPdugu8yuhlQv5SYo0zjVOYF9cdJbPUXsqpgCLRUIe64t1HQKIjw2Sf3oeXqYou2r0e4DGh2S/HB2OFrL8Fvk0jzpkNw2ZGWNjiVob47L6r4W6IpQq1Njucwc5iWa1wJp/TvyP0mRsPgvFIpOcJDfly/mEr4MDXUGY0aj/sQLDj3rwSybVuxxklTRFQ6rxxHx2Hdj+zZy0KKxndsiUU9U0XJ2xmJYqJ5OPv+vfd80TcNYT6W5Wpho8Gd0xR3zEGnRNpFyVHZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA3PR15MB5656.namprd15.prod.outlook.com (2603:10b6:806:311::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 16:59:00 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 16:59:00 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Song Liu <song@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles" event
Thread-Topic: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles"
 event
Thread-Index: AQHZiR9WEaR3xoFFfEGCLaxGjWAWL69h1CkA
Date:   Fri, 19 May 2023 16:59:00 +0000
Message-ID: <3BDFDE24-C5B6-47A0-A541-2BF833BBA832@fb.com>
References: <20230518002555.1114189-1-song@kernel.org>
In-Reply-To: <20230518002555.1114189-1-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA3PR15MB5656:EE_
x-ms-office365-filtering-correlation-id: 3c608802-6fbf-493f-2ffe-08db588a579a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v8hp3HWegMe0i5WBnyC9DmULz+NEpnMr3jOCFZ4JkmS6Kg8//uLtCNe7hA7PYV+lzNn9IOsNpSsJjgLv0ii7JEkiP5K6DsNQZ6Hug7anNC8uQxK7CDg8o4MmiIIk3cRjF37f7dnsSPRt8MG9m8oRddRsSRVitw0D0gke6gt9vierUmKASVTdHYvYuqapZZdA7GU/8lj34WPoHVlcBtdvA/Y9BstWI9tPR06f3zUtxlk9ZlxElr7S70E5ngDM3Vi6ATeAuFvDqQR95iNtG/MribDZqrMls9KDLBUYrnp0rHdsQKx8fH550E3ATL56/o9Y3UkKdFZveL8IYPZU+oNuuxSgfNXWOCPqIZAAboeiPQ+6BsphJfhD1nYz9AVdXyXgUOm0mlMLdxNWwQZoeyCQPF/kRDWPL/1fOy9pbcCv/rGd+JgQn7jMZf28QzQRclZpGj2QQ9IX8/uTIzPrMWFqYdQSNONAPrfI589ZOAFiPhWhJzSGrcBKg5LiBT/40lpGhHUUUJ7ol16d1mWqn1A7ITUZKZ+TguA0B98B/zdJRqN7JMQ5MOptevWnv0EDODivaofuqxglajb5pJLBzyenR1ChpCbG3HR53UZw84N2cER/j6pr5buxfDJ2/pizFSYlLNAR0gVSYOw0bAqx3sTOrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(71200400001)(6486002)(41300700001)(38100700002)(53546011)(6506007)(6512007)(9686003)(36756003)(5660300002)(186003)(83380400001)(38070700005)(2906002)(86362001)(33656002)(8936002)(8676002)(478600001)(6916009)(64756008)(66556008)(66946007)(66446008)(76116006)(66476007)(4326008)(91956017)(122000001)(54906003)(316002)(461764006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a6mF07UoSnRlLtNX05xwCb+RZyx+K1dSw3JM3y+Y8oJeTAjXGIYBIN7cSrrL?=
 =?us-ascii?Q?W1yhqFOw7A9XjcsdlPdFWG33+M2oQZSb5Cs0NdlcTHWWUX+tZIee3WTb6Wjo?=
 =?us-ascii?Q?AAVhhAg7T5c4TjK7CFr7St8vEWZgr9RinxNerfRPlYi2tCnEVga/Ea/FCH+K?=
 =?us-ascii?Q?d7CvZMYKvQUFPwYo3OvpKwsUhEaJIHS91+z2bPhpWk0kfYbjpmnSypFOe69U?=
 =?us-ascii?Q?XOboDFzfNfPzlHyFDp0cs862lWhynosdoVVH62ZbP7lNeKAShnevi4Zw+Hui?=
 =?us-ascii?Q?yEEUlj12gbuqcJkmPp05+LpzYXYCB19M4klvHsiyT3MSzq7aQteTue5ruxk0?=
 =?us-ascii?Q?zhfQy54driy7U/mbdWuk2q7JRogMHb8NtweI5vh2X2ghm+rNKuJbfh87pUMR?=
 =?us-ascii?Q?s5cBUcMk3lGJsv5f2DWb2FnwP9fyyhprH9LJ/5Sgf5EytGI9WjnXgnwL+NAf?=
 =?us-ascii?Q?ZHOO+wEXhJcuCEi77i3j91tL3lHxR2Kk7hO73bzzv5gWUISfggQmi1YvaRuq?=
 =?us-ascii?Q?DpMsy+3YkrPTdrtWem5kqc1U3nWHeL9kfXapMsPNcGUH2MSYMR0L3AqyM+dB?=
 =?us-ascii?Q?Es2rh/VP1yJyMlSk2xwIZ32+PKv9XVBtUIhFOxJh5nM2DoJZtj/kWz/UxKRG?=
 =?us-ascii?Q?xVOH229KUE17bh9b+h7JjXDYLGcVc1/LgyIKkLcP0vj0yfFcUsWrhDemCb3w?=
 =?us-ascii?Q?t/qiEV0DOHvNF2/h0lZqROLjA6/S9ncslqp61ZctI3gmh1i/AJVmzI8wu3Yh?=
 =?us-ascii?Q?fpACL7S92YIycaaWrOhVFhTNUx4kX1xyD2UcDMYK9O+lmxmZ4N22CPWBU8ip?=
 =?us-ascii?Q?oxqmSLZSLsTdjTU6kGPz6HrAciQacsRWV0LAiA/xaG2qGqCqphmC5S8YxWCK?=
 =?us-ascii?Q?WtTZYP2o4aPnebLktEojkzzoo31+ffWvIUlF4lmYywL5XXs4U/V/kdKEZ/1Y?=
 =?us-ascii?Q?phPu+WcQfkpDf12wv2zqzqyolg9Nc1cyWS19R3B00D4N/l/Er0Yt6tr2FQJb?=
 =?us-ascii?Q?xesTpb77dOhuLY3j6CYjXmfDXzUmsl6szGGb9vvYWFaPG8XKJQDZXDNK3Gpg?=
 =?us-ascii?Q?iWNVY3XMmQtjPAYPKaVROlK+W8j3rXXPWiDa5GI4Nz26bVpGMiDaDbrzZZUS?=
 =?us-ascii?Q?+/I5hHnmBBUcg8FF0ZfXYHSrF65pqeHtQEryCCVEdGsyJ+tIzairVK/hg7X+?=
 =?us-ascii?Q?2NeW+ft77G1fc5ynY0ZLdkngPkh6GrJ99yy8dqKb4RQ1VIEpLqM6pFwFkUqe?=
 =?us-ascii?Q?6ZvjCAHRMF/NjqTWs5cc7Y4EV3u1QA0FO9dd8BCnoKI2syK6jbHcvGHSSKvh?=
 =?us-ascii?Q?NMtsKf29tGlIn6iry8H2j+yrMyfCeFh28giOz0esWPoxCbN80egp35MNQG+J?=
 =?us-ascii?Q?4AlR3vB2bEggZ7BYR2JZCBrUqO270yPtDFwg1dVzqVygFfsnMXeKUvZy5zmV?=
 =?us-ascii?Q?5Nak18B/CKUNwToLLrDL8we+kmEe+ffL/rllLhzRNOOPrrMn1KLJCbj/AhFm?=
 =?us-ascii?Q?m68ZAumY0GEYsZaADmMtOmDVydGEDI5fUdZVKpJ9jdzopFtJGoINYrDC5syC?=
 =?us-ascii?Q?t6urnCcQ6JcsSp8YByTTsNzMLaYNdoHobHjxlqHyOI1QE0Ic5uIbSga5xjKM?=
 =?us-ascii?Q?tFzkK8BPrGuMAszVu1bWXK4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F02F8509FC6F94FBC647694DF73C206@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c608802-6fbf-493f-2ffe-08db588a579a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 16:59:00.0900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHtbWqX6yZ6pGTC5atbhdUIh+VqYo9yvJ6RR2/4g6XVE2oR/UsqoR+ZMvvQNBIFunbUjef0e6nlR+FcXswnaxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5656
X-Proofpoint-GUID: Balj3dD6pqUx882n5vz5RmW1II3Yi-Q5
X-Proofpoint-ORIG-GUID: Balj3dD6pqUx882n5vz5RmW1II3Yi-Q5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_12,2023-05-17_02,2023-02-09_01
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

Does this version look good do you?

Thanks,
Song

> On May 17, 2023, at 5:25 PM, Song Liu <song@kernel.org> wrote:
> 
> NMI watchdog permanently consumes one hardware counters per CPU on the
> system. For systems that use many hardware counters, this causes more
> aggressive time multiplexing of perf events.
> 
> OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
> used. Add kernel cmdline arg nmi_watchdog=ref-cycles to configure the
> watchdog to use "ref-cycles" event instead of "cycles".
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Song Liu <song@kernel.org>
> 
> ---
> Changes in v4:
> Fix compile error for !CONFIG_HARDLOCKUP_DETECTOR_PERF. (kernel test bot)
> 
> Changes in v3:
> 
> Pivot the design to use kernel arg nmi_watchdog=ref-cycles (Peter)
> ---
> Documentation/admin-guide/kernel-parameters.txt | 5 +++--
> include/linux/nmi.h                             | 2 ++
> kernel/watchdog.c                               | 2 ++
> kernel/watchdog_hld.c                           | 9 +++++++++
> 4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e5bab29685f..d378e23dad7c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3593,10 +3593,12 @@
> Format: [state][,regs][,debounce][,die]
> 
> nmi_watchdog= [KNL,BUGS=X86] Debugging features for SMP kernels
> - Format: [panic,][nopanic,][num]
> + Format: [panic,][nopanic,][ref-cycles][num]
> Valid num: 0 or 1
> 0 - turn hardlockup detector in nmi_watchdog off
> 1 - turn hardlockup detector in nmi_watchdog on
> + ref-cycles - configure the watchdog with perf event
> +             "ref-cycles" instead of "cycles"
> When panic is specified, panic when an NMI watchdog
> timeout occurs (or 'nopanic' to not panic on an NMI
> watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
> @@ -7097,4 +7099,3 @@
> memory, and other data can't be written using
> xmon commands.
> off xmon is disabled.
> -
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 048c0b9aa623..edfd1bcce0f6 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -102,12 +102,14 @@ extern void hardlockup_detector_perf_disable(void);
> extern void hardlockup_detector_perf_enable(void);
> extern void hardlockup_detector_perf_cleanup(void);
> extern int hardlockup_detector_perf_init(void);
> +extern void hardlockup_config_perf_event(const char *str);
> #else
> static inline void hardlockup_detector_perf_stop(void) { }
> static inline void hardlockup_detector_perf_restart(void) { }
> static inline void hardlockup_detector_perf_disable(void) { }
> static inline void hardlockup_detector_perf_enable(void) { }
> static inline void hardlockup_detector_perf_cleanup(void) { }
> +static inline void hardlockup_config_perf_event(const char *str) { }
> # if !defined(CONFIG_HAVE_NMI_WATCHDOG)
> static inline int hardlockup_detector_perf_init(void) { return -ENODEV; }
> static inline void arch_touch_nmi_watchdog(void) {}
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 8e61f21e7e33..fed4f0be8e1a 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -81,6 +81,8 @@ static int __init hardlockup_panic_setup(char *str)
> nmi_watchdog_user_enabled = 0;
> else if (!strncmp(str, "1", 1))
> nmi_watchdog_user_enabled = 1;
> + else if (!strncmp(str, "ref-cycles", 10))
> + hardlockup_config_perf_event(str);
> return 1;
> }
> __setup("nmi_watchdog=", hardlockup_panic_setup);
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> index 247bf0b1582c..4deca58ba6ed 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_hld.c
> @@ -294,3 +294,12 @@ int __init hardlockup_detector_perf_init(void)
> }
> return ret;
> }
> +
> +/**
> + * hardlockup_config_perf_event - Overwrite config of wd_hw_attr
> + */
> +void __init hardlockup_config_perf_event(const char *str)
> +{
> + if (!strncmp(str, "ref-cycles", 10))
> + wd_hw_attr.config = PERF_COUNT_HW_REF_CPU_CYCLES;
> +}
> -- 
> 2.34.1
> 

