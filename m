Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209AB6A0BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjBWOgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjBWOgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:36:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D739B5653E;
        Thu, 23 Feb 2023 06:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677162991; x=1708698991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gm6IfztlNq3KfhDnfG30Uy6xKY2vJ5R3ggYKXwgR/iE=;
  b=C2UalSJrawVsSqgbYDmTn0N7BkpoBEUe2IsCWCQ0VnmAI3CLwuZhfNmg
   bVPAZiL207F+TJFY5DgBUO/QqSfOowC6yIsPfE6wv4w2Z0zfuKKAusANd
   1oKbABkxd6hWZhKjcHYsgBuJA6CJZanwB/CfUmthOWbJmkkWfwtSr1Wqi
   aN4uHKrLNKhaIHeDn6s4cj31IpTLCTQhhdoYIAdlOVgv5Uvk/IYBZE6/P
   C7d76z12q3GUPeFv65gAH/rJBeQBKhXH9Zf+52Yzts/GeKFCx00WINLPy
   pq+IailmQ4ObEN5C+SvoYU6x36CfHPqKC3Zv9O4uGhW/T6k2wMNhqZgjH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="313594390"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="313594390"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 06:36:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="649992599"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="649992599"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 23 Feb 2023 06:36:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 06:36:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 06:36:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 06:36:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksvxZfmu3kPK/K6OvkMQx3V/9J18twOcZFa8JSjC6cvZvKxwjq2qGH9aG2zPzJauRADxAgYgTRAR0U1UylFQKo6cybF7ECSnkU2wcwhIHnmXyctkpuKp/ANRDRqmrGLdP0U68Vs5tLx6MF9LvRMIo2Bj4mW+CVQzU69jP5jWaGjqZqqVe8PB1Q+/K62ogiPGnQ8Lf6tm68Gh0IKb5i22Qwr4E3J2VSp6woO30sPiv73cdU0w3CfTOfa77x+xvKt+UFbgWkC8gaWaekQruGudZJ5ZCipSu3moxV97n+uXxb27qpI/vef6fCEfH8K3Yj+ZcQVv2yO8rFrtMAQMFE21Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blJQkuJ6F3PW9a5/NTZtl17EmLKL5bmHc5C+VVnCHNE=;
 b=GzLokNtySc9VkD4YvemYQJkaom32Jjfc4rJ7C3uAgKjRhhrvPB8sK9I6gt08/8aJa8yVGe51PVbRZ8c3hciwRGEYq1NSpbhvZuNmrjL6W5AvnPO7qRyrzai90jcchV0LaanHTURcQK9zVC3xKxZD2g+/Bh494pZUFB24bH2VytpsyUQGHi46TAjMg5/95CSxSwsJwO06wHfwdJeyBHeBd+xSFGaCWEMWxMwzKeaecc5v2pqL3VTc0vwbJ+Y5zvzjShfnLlnYjYhxfvbQ5/7WQxTvJiJp670EqdSlpGWQBhfh3M8LaxqiYEKLgg57k0PXo2hFdhtJceUuX4QEoeUyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by CY8PR11MB7780.namprd11.prod.outlook.com (2603:10b6:930:78::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 14:36:24 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56%8]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 14:36:24 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Thread-Topic: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Thread-Index: AQHZR0+oSq8/M5EvMEKqC3ssehkf+q7cNNoggAACN4CAAGElUA==
Date:   Thu, 23 Feb 2023 14:36:24 +0000
Message-ID: <IA1PR11MB617147000BECE62798343DF289AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230223063022.2592212-1-qiang1.zhang@intel.com>
 <IA1PR11MB6171F5F6B525B6C599024C9D89AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <PH0PR11MB588084641FFB675A102BA503DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB588084641FFB675A102BA503DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|CY8PR11MB7780:EE_
x-ms-office365-filtering-correlation-id: 6f57f44d-09f4-4706-6d22-08db15ab5716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJ25fwTlGQgLacc0qLXdUpixlOmpFzYvNA5hMZbPZu1rkcRTJlNW0K8/BupalgvaprS7VUiFDIQZC7LDLBvVcYPwbPSkrxZWV4+lJRbpwlPz6MsixPsU3z+o59hJTxC0Nmvr74k84v7FkLr69tiz+5i1mhpxFjFuTn102y84BtOawKo3Ns55ILkZSm2RLkwBT13ONL1HZhstHoQ4UxLNmxrj8LOjw7fwBio2cTszV1V6S6v5q6CVoXEpZlf69qmn2CadLY/L0egwj1bel5VDqfLn2xPRAuMjS7PzgkBJrbeuEPSEXnPjgCTRCiYRqbdXiMjl8IWOgPutviWQGqbFcoT89HImLG7/cTn9eq1U6qJd5MFX6WsPUpjDJ0AEQ/U9tsOyjhvF1J2D664BllFCEYt8+DXGKGPZ8lrFaJp5EmFbzrFHLMM1PdlJljdTkT15xiaW732lWX6u04Lch3S1JnVMKnTuwzeW3JosTQrVg1PmRAi6GMvYRqpVua3pJydRFagLmWdHkmZwOU+8HFNpzl4qlQF9aAM2CE4DsMFWHgqXZa68bFpz7ay+X8QmaoayzG/p/zevsarrBfZmhk33a9abkll3nPw4t6yhn90Ef32+KDIQLq49g4A25cXg1U0N/P6sboD0Rb7crZ1bsG2izxUmz6ocWJJ5crjPWtk/vQwCuBW5nM+GrzALQi9gJt5LzeUbmL6hy4Oohq5WgchmLvjm1uDEjKt9uURGJms8nQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199018)(8676002)(33656002)(38070700005)(76116006)(66556008)(66446008)(64756008)(66476007)(66946007)(7696005)(4326008)(2906002)(54906003)(110136005)(316002)(122000001)(41300700001)(9686003)(82960400001)(55016003)(71200400001)(26005)(186003)(6506007)(86362001)(5660300002)(8936002)(38100700002)(53546011)(83380400001)(52536014)(478600001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tj36SJprQdGOjLl2z1saLuhpcff5uccOy+rLlBN4lQYRnHhPL89keZhsrkLF?=
 =?us-ascii?Q?6L7HimL4XECbJbyqngIBSYipkr42TRmJj2muXtP3aH9HAoiB7Y2wtR4y+7tY?=
 =?us-ascii?Q?LmjK6OAN8XqOyW9sf4LBPEto08WXHdODn4tuQktjnSoPAw/zbr5+cHwm7psD?=
 =?us-ascii?Q?wvnSaj5GZWoxL8iIClBAJwzQV4MW4ojKStBasgNLtIVJtsogXrBwrlOV/fC+?=
 =?us-ascii?Q?nws0KIL858JCGEUqZvjfJeywZZCUXBW2IowiPorjX2rzPaPuncLb8NTWiPsJ?=
 =?us-ascii?Q?FvCLMxdcSkBozW4jE3c8+VNhLVWSlQLdcTxRi923+OwlAYQxsFzKFGsiVahX?=
 =?us-ascii?Q?Hq+9rJYWKLrmgqT10V2BL8WafV1NXDZ9FebhalD9kSfaGZnVU24xtXHGgfwZ?=
 =?us-ascii?Q?DZmC3nUsbu1pKGJgGBIwuzJzSkadUrT9D4QzCoR12IQhiqiP2JRaxS0kDoh3?=
 =?us-ascii?Q?ctQQ7qCiKIhn5XTvU9NT+rqSsU1ilHvLvPNeDpY++dfSs4Vm1u8EttW2f34L?=
 =?us-ascii?Q?p7Vf8adoCEBAbxXIEUXAOHmNHRkwiXXBBKFvV0IVKZx3nLFY5vudb2kVxtNv?=
 =?us-ascii?Q?abhR4hlwCEv+Rv7hl80LOw+fhXfWDgqsiBghZSCXpeIzoZYY9VDRZ3BKHcuG?=
 =?us-ascii?Q?3tX63u3g1m/LQO6DJDWJQacVo8nVq75cT7tS0DzOGH+vbryVA0VS6iuX+cL+?=
 =?us-ascii?Q?C99qhJkYipaNORQESbx0rfoiW61rbBgHYLL3Wg0Eckz3z59N7xHFtyuxNOie?=
 =?us-ascii?Q?AfScagRREVmx8B97ldCoPVbC8ypFjHAzqCrgNOY3E5hZHmIeOdhXqb9oGMdG?=
 =?us-ascii?Q?WkZhRkL5rlWuWXwm0ln2AiNF8btw8/4MlziuAnxCwBoApcvEc7btkoJPS6TC?=
 =?us-ascii?Q?8gvKTIkIGqp5QHTMRuKvhtSch5CYS4mVEXUbWDSEOxzMmAdK6TEx8XcJ07Nf?=
 =?us-ascii?Q?ueKpv5yJl9ItfQkUsuXmbObiG8shKijSyjG4F8LCiVV+q+BFA2yC0Kdkfl1u?=
 =?us-ascii?Q?lGhc4ybqnHIjQdchaZCpH6z43Hdm5dFBV4eiqYl7/bF18YLH6/6cpiFiMJOp?=
 =?us-ascii?Q?GA5+/xm1AgryoBHg18iZI1qFRC2M5MXAXd//af3fDH8H5BlZeRXeBSuzj7mX?=
 =?us-ascii?Q?M06Kgham8Ys1zFculkrQmUE/UPi/JX92zhy8Qkj6DXy9CGBcOGEBrMKLFMob?=
 =?us-ascii?Q?7gn3fCCbV5eywv6T7iJkiKV8HigoWcttt0AmbFnjAs03sa+fGKK591m54xtV?=
 =?us-ascii?Q?+a3BNOfpequahl/7w5VU29RGkSSkZzYiJY46Eu/vwNcweZkh6x4IbnoDSZG7?=
 =?us-ascii?Q?uZFJXrJpAcySB99UoO7Mv4JumkNQfTq/aZFct8TYwASqAPdH942Y71xaATwR?=
 =?us-ascii?Q?nNfFolEbvVN8g8i5BO66UtLP+RdIr/7/z0ydvCnINlg4VNGHjAueyYNlJMKT?=
 =?us-ascii?Q?dh3+7gGEEI0kHL/sT3pt1yBjHlKTnJEi3YIQLtNwvnw2hX75DnGdsNMWBUzQ?=
 =?us-ascii?Q?RumqRUaR964IvjZJ3JFwGRJn+g8zUgfL9qLAmvfJI+0KZECEOq6fnnMc/aB7?=
 =?us-ascii?Q?d7gy5Doym595l1NLovDLb3P2gXL9sW5IppK4EYe1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f57f44d-09f4-4706-6d22-08db15ab5716
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 14:36:24.7423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qawoiMW3a6/Iap+/YsOYUF5QsGlRTfwCeQud0+eFPXQA6lO5amZhKmnXb0XLWCzavG2WJCCGkv6olqE5ZsSvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7780
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Zhang, Qiang1 <qiang1.zhang@intel.com>
> Sent: Thursday, February 23, 2023 4:43 PM
> To: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>; paulmck@kernel.org;
> frederic@kernel.org; quic_neeraju@quicinc.com; joel@joelfernandes.org
> Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
> call_rcu_tasks_generic()
>=20
> > From: Zqiang <qiang1.zhang@intel.com>
> > Sent: Thursday, February 23, 2023 2:30 PM
> > To: paulmck@kernel.org; frederic@kernel.org; quic_neeraju@quicinc.com;
> > joel@joelfernandes.org
> > Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
> > call_rcu_tasks_generic()
> >
> > According to commit '3063b33a347c ("Avoid raw-spinlocked wakeups from
> > call_rcu_tasks_generic()")', the grace-period kthread is delayed to
> > wakeup using irq_work_queue() is because if the caller of
> > call_rcu_tasks_generic() holds a raw spinlock, when the kernel is
> > built with CONFIG_PROVE_RAW_LOCK_NESTING=3Dy, due to a spinlock will
> be
> > hold in wake_up(), so the lockdep splats will happen. but now using
> > rcuwait_wake_up() to wakeup grace-period kthread instead of wake_up(),
> > in
> > rcuwait_wake_up() no spinlock will be acquired, so this commit remove
> > using
> >
> >There are still spinlock-acquisition and spinlock-release invocations wi=
thin
> the call path from rcuwait_wake_up().
> >
> >rcuwait_wake_up() -> wake_up_process() -> try_to_wake_up(), then:
> >
> >    raw_spin_lock_irqsave()
> >    ...
> >    raw_spin_unlock_irqrestore
>=20
> Yes, but this is raw_spinlock acquisition and release(note: spinlock will
> convert to sleepable lock in Preempt-RT kernel, but raw spinlock is not
> change).

Hi Qiang,

Yes, you're correct. Thanks for correcting me.

-Qiuxu

> acquire raw_spinlock -> acquire spinlock  will trigger lockdep warning.
>=20
> Thanks
> Zqiang

