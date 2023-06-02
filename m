Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46AB720C37
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbjFBXPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjFBXPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:15:23 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78971E40
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 16:15:18 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352MgZFL028367
        for <linux-kernel@vger.kernel.org>; Fri, 2 Jun 2023 16:15:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=XwxraOzOTsc37FVMG1KJQGJbdmNPpUJLHRCwudNIQ0c=;
 b=AOtZuaE7/fBFnTMWpNqDHlGIcAY+Oc3rUshaJQxu7gcP/p7Y8Bh8rs9AZRTLDld/Bqww
 jJPtJt/wAEmwQRFRZdS/5ZttBAl/1AcY/x9aIrV6NddYGPrKSVv3KK59IcwHKFYYr8g3
 k+LVLz08jaUVS87O9pRY/EYh3xevIzxRxsSyonc0YjNCiTmhmTKqWz/qeroVrL6Wvzoc
 I6hluI81kbM0fqUiUN6b1hJe3qGIAlFDHoJAZZzjXIfm3BzG7Ir0iPA7dhWbJ7UCkSDT
 +JuVfBRhFqb4CjUlEvzIX0duYFBN7mkaMe+uV+dehm8g3jVhAFSMLD4xLvhPIwqAXnZo 2Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qykxhbf6t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 16:15:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUdZCNW67b99z0L4pLDwb1NnbMQfLJtFRPfwXrrOBw4TI7s87adhStV7mw5H62s5Qay/ErzaMndSOpbtiEbdWkMSZYR48sB8dOYES6KwtdCogq0xZsE18LwlrMuw7/Era5Q5ACM4Eai1XjrLhkU/MZzAkAwDejAmAsXOqwkFgxUAxBqX2zjegsrdg3GhQdxzr7b4s+DCO/rCHKe1B9E+L0kUogglkcx6OmpI5xWG9wQmnlmlc2wTL0MN4vkV9uCkolHce+TyDnkaESTbGaXz1vgXDYo2fx70IaJ7/espwLdn/WVIz0ZOeRdmX+KOkOZ4tV1arSH7dUkai2Q3OnEnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwxraOzOTsc37FVMG1KJQGJbdmNPpUJLHRCwudNIQ0c=;
 b=dpaf+vZIqQJM++w2G2jdKzFdQ6YAXVOY5izeW3Aw8Ll2X7/t4ppZAH5alogc02EIry8Xqhvxv1yaiijnOAWgJXJW7EARdVOtIAl2g7lAl4VETvVN2bIH+/H3yIKD3ZxImbVqlObThHZ+JcLhwOEnw/+EGz7ro7PLHSqUsOxjRJLC3/li1SaeFU0KbAl7rH2F+4L7krBcvEE3WPPEdU4EAMlT1sbKlc4WVe1k2wUg9rz+5buUXJAaTgidjGUQIsHegEKmCXrGiKP4ctVseDm52fBwscrCM4kTWVUtP35QJKRMxlv9KPyVYnPcu5kJ9fGLGiToR7d86Z3DiL1qdfQMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by DS0PR15MB5621.namprd15.prod.outlook.com (2603:10b6:8:13e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Fri, 2 Jun
 2023 23:15:15 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::2c21:3ce4:979d:ace0]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::2c21:3ce4:979d:ace0%7]) with mapi id 15.20.6455.027; Fri, 2 Jun 2023
 23:15:14 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles" event
Thread-Topic: [PATCH v4] watchdog: Allow nmi watchdog to use "ref-cycles"
 event
Thread-Index: AQHZiR9WEaR3xoFFfEGCLaxGjWAWL694Nj4AgAAHooA=
Date:   Fri, 2 Jun 2023 23:15:14 +0000
Message-ID: <DCF269A8-4C64-4FDE-AFAC-92B6029EA3BA@fb.com>
References: <20230518002555.1114189-1-song@kernel.org>
 <20230602224744.GC695361@hirez.programming.kicks-ass.net>
In-Reply-To: <20230602224744.GC695361@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|DS0PR15MB5621:EE_
x-ms-office365-filtering-correlation-id: 2ed56d17-07fc-4507-8bd6-08db63bf389d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qceNfjMX53wQ1h0lhcjhD/h0kgrC/J+8JOUb1pXlCMUhls2kR+GvrsdEbj9oT9hGREUuICnw/Qdd2hIRE6HXzamKzKETA5UvFjq7j0Cn1N5ndTlTgl9NBx/qj9d6WwzPDSI0lMjlxoLL+EZoy2f8wZ5uMhDZWQlTrYUsLXUFkA0uCtwg9CchEsMctWINgat+zGTO/BL+9NDt6WgDBXZcV5wL0oeLtCY+fZIlIk43feVVj3HEMSTdy4YZgiGX2/NeEU9fXvna7Qu0iPbIV/Wk1TIbmpWaSOg2DXyv7FEx3p5Sa5mIrTNpPrXCBdnqBF20wXIa0Ok0PjHxd9tvKG8QezNL4DRkI+6DFDBIYAGzjc/K/PB1t+TXEhD7YQHLok27xCwsphSe3l+OfwzhHWVOcGr1KltVw5yipli54sXnD0IRZDpt/BI6eDogYnoQNNykAX9YPgM0jKc9dOGvo26nZlu5WslK1IaK8oIyrgjS1EPeSnX++MSkRaeZ0SV7mqNlP/+jHnHqV6985C+NdocV5tUQvSKC69/W13cFr4/ZBZjoSFl+PwojI34kkX0APrf9wbVE81d/D+S1IZ6Ar3qKJW/awJwl1fq1/PVmFx34QN/O+AhMMb7FNtfxerNeglfFMcb+R7Lzokquvm/BqKXdfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(83380400001)(2906002)(36756003)(86362001)(33656002)(38070700005)(38100700002)(122000001)(6486002)(41300700001)(316002)(5660300002)(8676002)(8936002)(54906003)(478600001)(64756008)(66446008)(66556008)(66946007)(66476007)(71200400001)(4326008)(6916009)(76116006)(91956017)(6512007)(9686003)(6506007)(53546011)(186003)(461764006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u55c0nlbp327VE2llZlKGxGoGgec8wOjqWW5iURb4QehkF4pxmfqRZsuo1oj?=
 =?us-ascii?Q?YJd81Y1TdlRMYE5tgU27Vg1Ij39tU/M8Tm/9+KrtunYbHZB/z95fFBoS3kPK?=
 =?us-ascii?Q?GTrlAUh5gzBuwl+iG/wwe8xbt90CwbL4K7DQSPRzIU+QUF1q0xMerjQv3szd?=
 =?us-ascii?Q?tkPsx01M7/2yToUDZmw2D2lpQu6+PLJjluQZArYvkci+bbeGJCOqC/ElEhDr?=
 =?us-ascii?Q?Mwd0Lqkd6TChmnwHmUrqr7xrpZIt9TdAdKjzDDKH8DPt6Bo+2cRxe21N73P5?=
 =?us-ascii?Q?+B0PyIIrNoZKDos3G1uhmLP1zDnFI50HwE/EqdsfcIXc6G1/ZmC5q9o+Sk8C?=
 =?us-ascii?Q?qHo/WY0jclGC+NJg7WkB5UlRQFU1/1JKsCFHDCRQ3aySwn5oz6RESpiHM5I1?=
 =?us-ascii?Q?H9ReyzNvRWSP2P4KC/CuhOIRRODUXqC6GRg1ZCQTMSYuHP7x71CHPL8Q2Bkm?=
 =?us-ascii?Q?jYmqs0SJgvbJtj3XE6hyNpbnnUO0souMZxyvpHobOyoF8ZRKnqwNOFaO/n7S?=
 =?us-ascii?Q?PhcKGHVo9SMo/GkAhFAPaxKS5oaZF7cg6V71DJPnQgp13UVHaIlL6Kyxa9C1?=
 =?us-ascii?Q?vnHTs+7e8EvDyb/AagWA6z1U+cglM6Aiv+61ta3MoBxHk2werd6xuQcOEK8r?=
 =?us-ascii?Q?M7rRPeVI2ZK9xtM71eYZrSiXqcMkFYLQAAdgCl3V0o2b3hm3FWlIxRqhZuQt?=
 =?us-ascii?Q?9HJVuHw4n77+jByiBWLuH41unmWho5aWu+aYvWJcY2oM9iQIrHdhkwQKaw56?=
 =?us-ascii?Q?Y/638hNFaVvV7VRwktdf5dR9wFa7mZ910yPZwX3yjDeU/T++BzjHL9+qqsiv?=
 =?us-ascii?Q?BvPSCErkEm8UWHV44OJmnf8jKDljSEaQym19ZvSAFp6qWFc2HFqJHnGK1NLM?=
 =?us-ascii?Q?VkpHXqMtlgGp1ZXsZzkznMvyXCmNUswbMVpVaBINaQzX0KLNKlSF+3DKqtHY?=
 =?us-ascii?Q?owta5vKCF7MEFyVsC8aVDedlBb9IYwCW5sR+X+SQ/tJMxyF6+X8bYrtViHfo?=
 =?us-ascii?Q?jxxka5lpDNGblzqfpaeh671RxN26+xwtWJxZ/jzQRRgjQqxB+K7oU4PgHLNI?=
 =?us-ascii?Q?llW0cSCtJIyKCDemX7B0YKU5rZ8wIQUAQ+5lWKGKR0NGt7slJdk4u5CFt8ZY?=
 =?us-ascii?Q?MGgar0jXHQNqfVdkg1YRhsBrlWTqTne9QAeGst9C5EGz9UQu7wE1Vlqq+Czu?=
 =?us-ascii?Q?dG77kudflqG7XghYcYd8vGaCE8G3tfiCPZ+yfHbz98SRQgEqX+nnDRgVf3sN?=
 =?us-ascii?Q?9P2iRSK6SHXqNW3COO9PNmMfRwqn6R1fzz1HMmgDSA2KWyyqcBk5pJgL8vkp?=
 =?us-ascii?Q?Ky7eCt5zGa+CmVNrChbEPVKncYeyT15h6Y/PYnBamFEwGsBB524jz6R/QZI6?=
 =?us-ascii?Q?0ODHjTS4PdlNIib//ZIVAczW2ds0Y6YYIpsOE4TecPuQXwn7UPHh9HBQFS6E?=
 =?us-ascii?Q?L1bSDOYvH7LBm5tN1ahdtMoSbXkk0ILQuSFCE049hBTJ8RlexnVMlPp20ndz?=
 =?us-ascii?Q?7qRvNWQX2VkxLjZgM8tXg28S0luzWu2KibGKUxxebnKXCsv/DGYugpB/TRbW?=
 =?us-ascii?Q?rQ99MPKBsYjx1vBgkhXsIsz81dr5WIXZ12vsKw5au4EHra+FMV3/3I5D9ecQ?=
 =?us-ascii?Q?aLFJyhZmE7dBmMVXY2m0N37BTbZOGZCIpNB4mHTIftPN?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B830001C016CE841BDDFBCA2E11D1E52@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed56d17-07fc-4507-8bd6-08db63bf389d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 23:15:14.2750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ou/P0grCifkULDSgIwjtdSxFbtmjJfGV68SIfvWAQqPWLfayaBzpAi0KNw9SnusquB3w2BuYgsDQXgJwF4OGAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5621
X-Proofpoint-GUID: X9ztUn_h22_Svi2dMpr_Rlv5V3Uu-5sN
X-Proofpoint-ORIG-GUID: X9ztUn_h22_Svi2dMpr_Rlv5V3Uu-5sN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_17,2023-06-02_02,2023-05-22_02
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



> On Jun 2, 2023, at 3:47 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Wed, May 17, 2023 at 05:25:55PM -0700, Song Liu wrote:
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
> 
> I still hate the whole ref-cycles thing, at the very least powerpc also
> has HAVE_HARDLOCKUP_DETECTOR_PERF and they don't have ref-cycles, but
> perhaps them wants to use a different event when the moon is just so...
> 
> What again was wrong with the option of specifying a raw event value and
> falling back to cpu-cycles if that fails?

The same raw event number may mean different events on different hardware. 
So it is more likely to make mistakes in configurations. For example, r300 
means ref-cycles on Intel CPUs, but it also means something else on AMD 
CPUs. I need to be very careful which hosts to run with nmi_watchdog=r300, 
as it may cause surprises. OTOH, nmi_watchdog=ref-cycles won't have this 
issue. Of course, this won't work for powerpc. 

Does this make sense?

Thanks,
Song

