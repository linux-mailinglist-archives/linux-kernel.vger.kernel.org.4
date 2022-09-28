Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77F65EE699
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiI1UYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiI1UY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:24:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BC8AF499
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664396668; x=1695932668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SNQDEbMi0n6O8jkdGIm1mtXhz4l951HTgZ426l1DvmM=;
  b=gNE/rMJdKiwKIkv0sNVC19gsn265FJNp3ooa1+8RNcj/lIOrf/I8E/Yh
   QGn0K3QoP0P1O8p6aTgQJgobPQtp5xb5ltQsRlNmKXFKxjVbvuOwrbyQR
   +WDuNULz0eU0IK9uL+B4b/EPWHE9paDBohVXaLfYDN3GFO1uyrGC3JV/3
   4xjfR+a2kZjdiuoGd/aZCepBbQfkTsEs2Oor/sgsA3zJixzI8cTzdNsAH
   m4ZS9mzx0+05C7+pKVEA63iwMePrel6Zh53rkvg1ne0VFO/QSL6lHekZ2
   SevwuMvfdrhiVfzaGPPIa0LjS7Izf2deqmno5JgBVyI7hooirgVqQzmkd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="282072102"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="282072102"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 13:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="573181460"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="573181460"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2022 13:24:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 13:24:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 28 Sep 2022 13:24:27 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 28 Sep 2022 13:24:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O30VQOSeDB0vZhtRPlyyJgzuex5CVrSmWI4e9pyPDTo4xq8BRRP3iK37XjN72kTEs1wZcggRzof2/BowalZOy1qYugj/gI+NbEB6coPK9/pgxFIGN3dboZxpki38N+ftuvldpf/VUFwBz0xS/3+n9mjG7VZkUQfuAMdokUYzs7q4v9iUjgT5KXpW18vFrifM3YWESxfnlMzcTbHRg7C39YJ+Nsn5Ql0B10UNeO9v+Z/wPHSV8vr+ayYV9mY/sez0XjtTPKIKwIfHzB6+r4BPXi5q2oxlpMGeiZS+dg6Lp6AUjjnHAEaXo0RDi3o5x5kAETYjqQZ/veYp84c1toN3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihJgrHGHCzz/dDSbXeY+6Jjjc9L4TX1zB4Ro6t7zurY=;
 b=VAKGFwP+yXH5Mix05yVQhwdrdPPEpqiJjfPLud/qWDQX8ySBM+iOrO16CpYIyY58mEmAUNqOYVIJkB7L2XpEJ9jqgw2glKHpJ332A4IMt43AiEFHB7H5MifVmr1hQ9ghgy0iJt1IUu9ooT1Jd2yJixl24EHrhJucHfcUhBSjj5FexYhIJKO3Gt9TzD1nRF53jqq6Yk/sSkjyxaMvi1AqBHUmaj30I9T+P27oTXoKhFdL0/kuzc3dUcA8aGiwtJa+1uX8x4pF5qP0jQg9jp1rrTDv/EUXCr9FxS4fnQfIL3eDg3/68z2GhxNYNO1InmJaD5KeGAGj4TEjEsqwr0QkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB5822.namprd11.prod.outlook.com (2603:10b6:303:185::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 20:24:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Wed, 28 Sep 2022
 20:24:23 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        "Melissa Wen" <mwen@igalia.com>
Subject: RE: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Thread-Topic: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Thread-Index: AQHY00XBSghclGVOu0aBjgkf6Dcm5a31R9GQ
Date:   Wed, 28 Sep 2022 20:24:23 +0000
Message-ID: <SJ1PR11MB6083113884DD0B3031FE372CFC549@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
In-Reply-To: <20220928142109.150263-1-gpiccoli@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB5822:EE_
x-ms-office365-filtering-correlation-id: d4464e79-f9bb-4664-956e-08daa18f6ee4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DMXPEIImdOWcp/Wv7h/gDE9QLmluf4nwOiJhTIT13yx3qgZJiNvlVhvyPT3y+XpfmKi+lfsxQtEfcOXuFhwjfPiV04rkwb/AVnERlXUcUm54F24JmU+9BzKeGLIiyH+nRcHQzbc0rIpDBjrhHt2A5TvOQv8f6bQIVJ5wve3erm6+Ce6tfK4IBNNBl4iyFlnRhg3GLJl8teW9Q5yuunwrZ7JNRRb5dTcAtrkxSGRYChDJZdl73eTd2cBUMGGkMmvyCZ+lz4TjBme/k+Ftj/wlkICNODPJ5Fs0zko5yVvRay3YLfkd6yuctEBKmX3nR1KvplpJjMm9idTFTswP8t2LwVAMkOALvJQKjtOSvDlDed6/25S/+49IhAfn6rpmnaTktLdm5akNhsO7OfK+FueG/VXt8w1mLIQFmjv0Vhrn6NQybpoDidAlDoebwCqYj+Rih+AMHQO4XTU8vBCbk45JYtqR7nuIJ3q5myxoHlISxzOuhM8UfXFot1CutNBBGUUGH17IfyPdH76G4v455nHiv1ukszANvyneWpgGVG6L64NtYGgtKxIbGXlOfRaKTGpY+mOr74IXTL8HbAao2uwcG5GqIxImfAgfLoRXKwUONCA7YSkTtPE8lFq20dneOLTf9E72I3+NLG9eMNwY2YBBZboIgbmiwjnnPojiU32R4Yvmi4FXTmgZp01Utbgs7RR3aAlL9+8u93PTOkoM1QFLUA7nCykfT5cV2HjU6V/7Ibb5t69XNtqL6tMJ+Qyut+5g2lJNKf7vcJgE9d24pYQWWntIgMefVS8TYt/ry+oNkiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199015)(83380400001)(55016003)(66946007)(110136005)(86362001)(38100700002)(52536014)(33656002)(9686003)(66476007)(82960400001)(38070700005)(2906002)(64756008)(66446008)(4744005)(8936002)(7416002)(66556008)(5660300002)(8676002)(4326008)(6506007)(122000001)(316002)(7696005)(41300700001)(76116006)(186003)(966005)(54906003)(478600001)(26005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LU497bPSxJC/T9rxlDUXd6H0L0R/KPdL6JoK2HxSrsyZkd/HfqJnCyAM0RiI?=
 =?us-ascii?Q?XNeqi/VxY11olxQ8zYv96+KYF2QNFfQjtcwheYIp4TlVgLH/SahJuF+PRWsA?=
 =?us-ascii?Q?7LDgg0EO1r1/JE1SHFMDaJLyZRAYLXZRQAcVJAMxnUwmDUyv46ZnsHkZY7qg?=
 =?us-ascii?Q?XZgvPVb449wZ7MarNZzfnAua9xxiWEvEBduQ8aEJPzkpJfKeZ/xKhxpvWBRj?=
 =?us-ascii?Q?SbXXsbj3kdCntHinXlA4nu/aYXTYsalTzA8N9lxhhYUD491cW20GefHdVb+E?=
 =?us-ascii?Q?+FUAFuyJM5sMltHUTVleFHMXUWsvfWTVKlHSlOpsApmkMr5neZJhjlCcEU71?=
 =?us-ascii?Q?CA8S9/sJcpdIZBhXQwOVJxRWkzgPlPV/mIZfN5sDNPlbYJXF+9S9xte9nXio?=
 =?us-ascii?Q?SQDQsw5z2sgu5fFYeS717C5XBX71PWgJTsnIXyzrIVu2COMbDnqDznX24vGN?=
 =?us-ascii?Q?LJ17gS71OFSXVLLz7Nqh6htaSimcpwx25Plunx00fbB101O+UCBZsH7EX9cp?=
 =?us-ascii?Q?WRrN6THCN8uezn+ZwQfIFfhN3x8QdSvvQTz5oOhdK9VMFTAU84UHwIdPMQyV?=
 =?us-ascii?Q?gacyYhNaT062yTYvrsbDLNbkQ8Vw3fRdOzoEbI5YlQhU6/WXEC246Ihy4v2K?=
 =?us-ascii?Q?bIwRNcYftq+s9wv/Xmj2K1/OWZYmrn0scVPY8fzozvb5YUlKEqt+hvDruK7q?=
 =?us-ascii?Q?2J/qM86yoH8nI29TvR4ZVc7XDGswOJvCsdz/YJUYN/TBRomqxciSD6D/BHwA?=
 =?us-ascii?Q?V5FP5NSTtc59ODVpzpcZuIS4jKd3UPRmr4hS5UrkG7MKA2Yh4qfC78hi/aEw?=
 =?us-ascii?Q?uSRVk4M5DgmyDYAwuqQS6me2NU//w9LILTtq5VyI+jXjUh93TWTg+EXacyud?=
 =?us-ascii?Q?OfOO5oBHE3UeqXnFWuT+Dhfn3nwFDeDVSYWYZ8j8Cr0/3iZx4KU8+kq6CN65?=
 =?us-ascii?Q?ktTTcNvsDN2i5T54qyLIjTZ0orvMmFvqFChGhx3fNis0qeBr5pNE3hlkyBcD?=
 =?us-ascii?Q?Zb8S9mJW3v8i8uYSfhlaLTTjsW08GCVnumDecbaPuIaYXpeIk3ZGsVyk+Ri3?=
 =?us-ascii?Q?kz11cz1wIFsdPQTLv6vp7X0MyUeCvdMZxQTHwlnR+qKOGk7sbqSi6y3PCs9t?=
 =?us-ascii?Q?qcdlirtmcMcfkJ9v0tInVX5N2njXDJdNR9pj7oihrlnndXfUI5LKWp6G3KzN?=
 =?us-ascii?Q?aS0VUEVD7/qMI8qeVpa170zEPPKJlFucaj8v0KB7Medw+JQSeG2JNQb+uCov?=
 =?us-ascii?Q?PEWV/2uRBzu6gCiJWoYF3hWZPq8fKlmZ8ovJB0hpGwWGlIHBmr3JhNZqjayL?=
 =?us-ascii?Q?SWMGWVHu+ckDrk7o8Uc2Yz77b9NCJvxv/loWWokg6RC+gae4uOsMj6pc40Cr?=
 =?us-ascii?Q?SC/vf0YF/5p57Pa8yIv9fUsgb8aSEezgrRqsoHsfXP6CRhzNFjRY43rJkuPh?=
 =?us-ascii?Q?5LbhHau8otXeuJnO0pH27uLDp9hHc607Eil+loeIzi9rGSBhNGuY2C4CZ3K8?=
 =?us-ascii?Q?gE9zAdY/dAeHW8DAjnyQ85nB6RgTL+hjRsTJwlYE3Nz6CF1k12RV6PppyKs+?=
 =?us-ascii?Q?R7IYNb8Stps933RzEZD+6R/2lsIEr0+9FgBf8zTr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4464e79-f9bb-4664-956e-08daa18f6ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 20:24:23.8903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOnzcDdfQPb1ZbAv+7rnzpUmIWPUuOcaxziev4523c9MPX7Z01HvGpQfHcLuPcxY/m+J5yCaWed9UXq2glMI6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5822
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So let's revamp the idea of having another option/mode for the split
> lock detector, which is hereby called "seq" (based on the original
> "sequential" naming in [0]). Also introduces a Kconfig option to give
> the option of Linux vendors have a choice what mode should be their
> default. While at it, fix/improve the documentation about bus locking.
>
> [1] https://github.com/doitsujin/dxvk/issues/2938

Why not just use the workaround suggested in that bug report:

   "so manual switching from default setting to split_lock_detect=3Doff hel=
ps as workaround here"

If you add this extra mode, I'm going to argue that the kernel default
should be "seq" rather than "warn". So these game players will need
to add a split_lock_detect=3Doff (or warn) option.

Has a bug report been filed against the God Of War game? Probably worth fix=
ing,
the performance penalty for split lock is only going to get worse as number=
s of
cores keeps increasing.

-Tony

