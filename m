Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33406BE0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCQGAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCQGAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:00:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EEA28E7D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679032812; x=1710568812;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aEUfCgj2ePJoT8upci4bj1OGnIe2eZ6h0mEA9X6OSBY=;
  b=Yi9gQ/rC7ehrSpY8zja+QTskYG6zgAA9DwVncO2pFXM0Z9PyCkiQAc3z
   zx7jlKaeT4DsPzyHHP0Tv4LtTKT4WXicPufQLRC7oV9PQFAN5HdKx43s+
   qtdQfDT3Im8196aRPYEBNL638fL4YXtEmASzg1Y2fjg9FSZOmY4g0VsPy
   aHeVd83xOmOwr+HuIOj5/pSZkBf5+rqwmc7Nfbl4BNJ1V/R5ZvCgYWPO6
   eL8KD5HZOzIYGUBxWEYBbcQh7D5/UQJAd651HbuRSCn+trj1BioXDiqY7
   xv+DRVGmoNaaRf3VpRdZ2YIbvLwVu/v4HnM4IA8uDGaHn0LYoa+6fjZB+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="335680533"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="335680533"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 23:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="769241620"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="769241620"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2023 23:00:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 23:00:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 23:00:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 23:00:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU7SsE+F85zPrcbYi69zT8NN6K8qhrSD6SFkMVAXsBq737yn8xxqMD2pS5yjlelB6pyvzxfsT4c0L/bo1A/oi/J9aWxvU3OoOa+2M/P0v2zEEZfzWDR4ovyRz7RxrxDBhr3wFgFyqIoO7kmyJhOdiuh04JA6bNb/hwC96TrNZCTN4BKXKBR1KQ5RADdX7IldLuMpz6q9iBpTrK2ewtl25dmXJfj98ct+Bb4jPaS4ecpXApwPFeIdIkBKqfJINgjhkGD9UfkbZ412IQ21V+M6O4MqzqoBMHnhY1hLvy8UuCJKbaQwMAcy6ghvMG+okh0jGwNW+aDpUtKb+e8R4zmhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGMeesuHszeLdc7kz80MRJW1NUJd3lNZpUp19uMMgRs=;
 b=D6pDfQSAaWDkzpUy2rztL7RCGBz3ZcNluH/r8Bf9K5QkugwRbrDW7G1WAPBSOgMFlankwCyPnfzs2goePrApNkC+EjmfKDezrq4QWiLpmWKFLqlpSjOf7oeO4kE+skTqu5OnTqCDAuErAgBpPEmUTISU5KqK1/OiE8BK2OoaG1vcRhqVgYv2uuv+Z0TNobcPqL3Q6hdJPgHAMfNfMQSR1v8bbAVZU7hEy7Y4ZcLGRVeKPZrRTuGGoE01B1VevPQt0xPssXGLs+mKaL1S0BpB10Av+664qzCXjVa9DAaPz6LptNJachnrBH1/qQ9h731d3qw/Cv2h9qW21yO4Rrri2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 05:59:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 05:59:54 +0000
Date:   Thu, 16 Mar 2023 22:59:51 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Message-ID: <641401d75d039_1dee294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <1678955931-2-1-git-send-email-lizhijian@fujitsu.com>
 <64133bcbbe368_269929415@dwillia2-xfh.jf.intel.com.notmuch>
 <ca55bea9-d2a8-ccce-010e-a26f6003a059@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ca55bea9-d2a8-ccce-010e-a26f6003a059@fujitsu.com>
X-ClientProxiedBy: BY3PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e1aed4-5abd-4a87-514b-08db26acd452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zSUlCP5izUB43yX3o/9dTMU7Jyvo+3i9LQHNMXdUGFnERJYMblWiS7fvFaxsN6tADgycqPHl26w+41rmlDHFHuAUSb2xIG01SPJMF86CmiezbNPFZN6BmQi91Wc+l7hcioqvWJaPiIadRppG8Hno4LaaNauk3ZC95mkURluTOD5WQK/oGFylmdIHbAN6buFFLYDbMS6ouPpezlFUlIcbTGx9vncV4bMc/rXm/2tkq0bTdPhU9kjU5aBjH1u0hN/HAZR1pU4EQEsaRuBwMQbhTYPOZYvh2jyq2GrJML7za7mnJNxvSldxi1i/yY2J9iuf0PX7Z9c1hCDLI7x9AZM96LyJ+QvDMaT0ZbvJYGdp5jiFolfCKMCllfZqqZk54T5ralsxia/RV38k3wY7Kne03IKhsynpoXDk88LqXASWiomEvJuRJ5WcJx5ZGgY53zxvZvpaDsfBWN8umQEjudvwpCrB23f/WkyGB2Def7t/ml0E+Jp8KY26Hn5DDt7xvjpdEFdeyV+WMoJZWZGs8bz4nyMhOd/QfGYjNbD9pq8UQrMhJSvMZdNWwniPprpMegny7QCP0qBtoLFHx22l3hmOPQC3oRU6ONPlH4RoMRb7XzptsIqfeMHaHNOwm7e/3jpKIVaEPKCCQZPz9gBJwUglg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199018)(5660300002)(53546011)(86362001)(186003)(6512007)(26005)(41300700001)(9686003)(6506007)(4326008)(8936002)(66556008)(316002)(478600001)(8676002)(66946007)(38100700002)(6486002)(82960400001)(110136005)(66476007)(6666004)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y0OvtS/R6doldoSfmnV57robbWuOfXoBso23dyFcAaxMWfud0BJNvrf/YrUm?=
 =?us-ascii?Q?danDYUX+KoQ3bOmYYQoYKi9ti/uZ10yMLzY60YYo8JzoqFvl/QeAOKyPs8Jd?=
 =?us-ascii?Q?fDJ/jDoLISIMglbO1ykKtHpX8dEyw/R+LYEHNT4+J4tfzB+uIW6AHybs5wYr?=
 =?us-ascii?Q?x+Udtoz0KwHivAZ+wj3pe+5SPAhotTooEU5zNwsH6vM2469aI8raoTOPNHZF?=
 =?us-ascii?Q?+zvQCT1dvVkg+tjGZ76SrO7b6+UDbU5mGbaRyCfsq7A/x029Nmd+gW8jnnk7?=
 =?us-ascii?Q?7lOdxnC4CL3UVcW8Grsx8ncS5qOrK2EI3ZLiwx+iZtEWSZwi7S5pc5p6gAEj?=
 =?us-ascii?Q?RKPdf3dzjPsfeBYlU8ZD/ZBgrcFmTKOTpg9vKhD2/V6wKAsem8ZQyG8KkB6o?=
 =?us-ascii?Q?dINcQFe8xX57CdqtLsjegGPb2rdkzyEi+dkiTCwEe/lQUEa0z0FEI4TCzAKT?=
 =?us-ascii?Q?rTyo8K1UWmv8oEBAycQbMirqkKH6WJ/0Rxuo4kwKXhNoDAkr2H7r0dUOFvLq?=
 =?us-ascii?Q?7neksNQTt9PSuSruZU7/looMyw+0z+o4coiOj5gF0kQefR5IEGGoWnxzaGdv?=
 =?us-ascii?Q?dxHtwKsHMPdJtXMIjtCWl04RwdX8K175hb+UPBnNLuyapsIwmcxvHIBQny6/?=
 =?us-ascii?Q?IBGMI6Br4hr/4x8OdJoDrJfJeN+H7vsDyymKpPhmTUjksXAab2PNvgruRGI2?=
 =?us-ascii?Q?2pcSAtb201inaUExbJXjFoV3YIdvOjJkLT4zEhFjonsA9vOQIoUSGXZkv+6m?=
 =?us-ascii?Q?dasInURb7S69z3S9WQXPKwb8fNesK8sWT5jq41NPZYEmh+Yz1Fx73lg9zGa6?=
 =?us-ascii?Q?0VET041o1sm8Gl5dkzEUC/XTUOFYQoEPjl+JgPuKSz0ZaHwySuKFdMzc2SLK?=
 =?us-ascii?Q?QUV+YuFHk0yP80Ei0lTh9cmm+pjlvYlgis04UJx1vEISKtgPLAZwDb8oThEE?=
 =?us-ascii?Q?B1QwJlmhqiYcoOp6eeM/ek0oGUr8yiafC/QVPdpPNURUpI7iATmEPEAshnUj?=
 =?us-ascii?Q?YpeDtECumxUVu1ovQqNw/GCoIFipKi2+yrXOID9BYAyZBz8H74ajXI+L1ZL7?=
 =?us-ascii?Q?Bf4JQIhuRHNlWOIkWExIA+ZO1oSMNwaogT3b9kyPBfiBSHeNZvUC1FVFQk+q?=
 =?us-ascii?Q?yTZpSlUNHzyNcs3YVWTkwyc4lNxEUIz9kmcPGyHIoh0gdlSjNQRYHSVbgnJf?=
 =?us-ascii?Q?r0BIu9LcDjzzYYasjjdGbXOe//RMSCSPpyQH4J2+lRIFL/4oufiOH0j5v8i6?=
 =?us-ascii?Q?wwzcUeuE0tnD4THRhCkAGZagxY2pyRAT0BBBdn95VmNWZ2S3K/4yngc7Og3U?=
 =?us-ascii?Q?BViLSXsSPEA3sflb3jBGKbGQ5tZlnb6GcXAVaofyhu3PxrF5bjSz4aVt4w7q?=
 =?us-ascii?Q?q2OKEk/m1l/Fu27TbuuZt8RIEpslCTGGCRwxN9oTmw8WgxIeyjZz3etVWv4s?=
 =?us-ascii?Q?j6m+h1XAvwtq4NGxifhg7HLzNVFbzYTYR6YY6cqTgX5xlV+6KWxw1Rl5SR34?=
 =?us-ascii?Q?W5kv+Dzf81JiBBmdhKVZFzQ7G8gyTh6qtSzGpSM6dEyoGTLBxdQ/OyOGfYjg?=
 =?us-ascii?Q?oW+Ff7DrKpoGyYDcfCL2y7eyKthxd8Vd9d8FuNWo6BKvBHmcxirQq0Vqkyjr?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e1aed4-5abd-4a87-514b-08db26acd452
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 05:59:54.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xi9JUGgn8W7t0MA3kg24K7K9XzVZTSffNX3UxQZAxrOJTKSHY0S/P0/gZhUHJo6GarEJvCIiaaCq51vNZYcDaVTm4XuEXvpB3DJ4gXetOnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7989
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lizhijian@fujitsu.com wrote:
> 
> 
> On 16/03/2023 23:54, Dan Williams wrote:
> > Li Zhijian wrote:
> >> nvdimm_bus_register() could be called from other modules, such as nfit,
> >> but it can only be called after the nvdimm_bus_type is registered.
> >>
> >>   BUG: kernel NULL pointer dereference, address: 0000000000000098
> >>   #PF: supervisor read access in kernel mode
> >>   #PF: error_code(0x0000) - not-present page
> >>   PGD 0 P4D 0
> >>   Oops: 0000 [#1] PREEMPT SMP PTI
> >>   CPU: 0 PID: 117 Comm: systemd-udevd Not tainted 6.2.0-rc6-pmem+ #97
> >>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> >>   RIP: 0010:bus_add_device+0x58/0x150
> >>   Call Trace:
> >>    <TASK>
> >>    device_add+0x3ac/0x980
> >>    nvdimm_bus_register+0x16d/0x1d0
> >>    acpi_nfit_init+0xb72/0x1f90 [nfit]
> >>    acpi_nfit_add+0x1d5/0x200 [nfit]
> >>    acpi_device_probe+0x45/0x160
> > 
> > Can you explain a bit more how to hit this crash? This has not been a
> > problem historically and the explanation above makes it sound like this
> > is a theoretical issue.
> > 
> 
> Dan,
> 
> Configure the kconfig with ACPI_NFIT [=m] && LIBNVDIMM [=y], and add extra kernel booting parameter
> 'initcall_blacklist=libnvdimm_init'. Then kernel panic!

That's expected though, you can't block libnvdimm_init and then expect
modules that link to libnvdimm to work. You would also need to block all
modules / initcalls that depend on libnvdimm_init having run. I'll
respond to the other thread with some ideas.
