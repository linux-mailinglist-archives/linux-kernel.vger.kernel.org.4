Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85180664DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjAJU7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjAJU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:58:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655F212A94;
        Tue, 10 Jan 2023 12:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673384338; x=1704920338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DUOoMT/KoCA0/04PsCdLFNoA07rLwCOAgfXc68bNVwg=;
  b=Zbyp6mAfFEEyQ4mGzbUQfDtWakOlXBNv6i+Gn9RxjHz0D+kotgVkYNI+
   iUSSZnDjn0sLjyMrxg2jaB+vXK3NfVEj5mOYX7Oqi/ZBVatYu+Cd3gKq8
   +D0gn8BSTUihYDB8QaMdxnaaxHsJiBL27nM5A7NeFLTCcyevkt1nLi0i+
   Wy0SjyaayIrgls8lE/bSIW/mxYMt1VJ2itDrqgXDqGr9mlm30CE7n85UC
   DVkZ4WyWIl7tOk4weczPNDe+seod2fVBbUpCfbm1Ed/cy656rDfHA8wMK
   eDCyyjdIboHUawX3tlk0tfZftDAn9bU2JZrTwaSrYkZ5sLp0ubkKB5XN2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385564551"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="385564551"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 12:58:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659113188"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="659113188"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2023 12:58:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 12:58:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 12:58:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 12:58:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdwVnscR6JuyIiS+XGAi/WqysVLkmxYLqU+Y2ttLWm2NHKZWpis62YO9ejYT4YSwSIL3UAti53sDAkSlzc0HTOwTXLjmaalIFjO75BgfXbfcA+4qo6Y90YAiL5gSaFKoRPyS/OnTMppnwQ/+A6T5b8xlg0EunfT95YgjyuMJrvPv2ghNEqrn07aaecm1IFtXXwXyrOoVslW19dKTRoEMC0G+PNbir0KT8to92g2V5SNY6R85ouASWvaDkkiErAOxltKli8Sdz/Fbs01YExAn4k1YMJXs3tCGjxkyTkFF41F5FLd4Br8R3P5tV9ybks6+wwN94UU5Do3FeGi2g9XVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxW2UAUG3Gvef3gJm0FG2jg3QAEIQ0RIjBXHmSBgLHA=;
 b=VyQ6gRJk7BpqrA61fMtQ0tas7nGalIEKUm6fUDFJimifCGPR+u9HYXX6PmuXusHWNjkE0Pb2wx4BeDbx2aehyS4WYS32GrOfmMzvsXGxrAGoroogA3zb+lpUlCZmuctjZDNAbDkFjc5joiULM6Y5cgdRgZxBtJbZJhDkdWWeunSpq5CFLoQv3PUf3ykOCOXPFNPaGAbNduUvjb/acG84NtNI4KxppD7hFP9nztESFjsJJ30Kmf67m7FEyicYOjGOTUheGPDN4edP+4LGBtWtu8eLK4AgZ4zXJkbKQ331dqYfI4nsz4DbOexePbb4bKL8Qj1xzgioFKQN3Ezn+UaHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 PH7PR11MB8059.namprd11.prod.outlook.com (2603:10b6:510:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 20:58:47 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::bf13:dd27:972e:decb]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::bf13:dd27:972e:decb%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 20:58:47 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        Ashok Raj <ashok_raj@linux.intel.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: RE: [PATCH v11 01/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
Thread-Topic: [PATCH v11 01/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
Thread-Index: AQHZJEmwi0Q/9mo+9USczeuBgpw/V66WuyYAgAAxMQCAATbhoA==
Date:   Tue, 10 Jan 2023 20:58:47 +0000
Message-ID: <DS7PR11MB60772F09B9749307CFA0ED0DFCFF9@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-2-babu.moger@amd.com> <Y7yiwOerGiEKAF9i@araj-dh-work>
 <MW3PR12MB4553FFAA412FB741A73009A195FF9@MW3PR12MB4553.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB4553FFAA412FB741A73009A195FF9@MW3PR12MB4553.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-10T02:09:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6f41249f-7e8c-4665-a2bd-54b4700bb467;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|PH7PR11MB8059:EE_
x-ms-office365-filtering-correlation-id: 629a65a3-bac1-4351-f0bb-08daf34d77a8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vCEejtl6KNFt0G8P3g8/7WhFbgLQP+dNVWwnjWx+WZ8WNBuxnjiLYVUsI3c1wwOZfBU6vZ+LSTH76Ay/eJPzQeC9hKAnIwCKEO6FMZWYJXRLBEhGjrC+G56xK/Du1lzEy9QcXQfK/elbWXbhp3Aa9Y9dQWxWO+bgOw67tG0a6j9b3KAJEClIX6I4sEoHj3V0GZUhbeleXujTSDIDGOdKdS622cW5MKsRDGI9hCRiQsICEonrVyIEZKGn2OxXpi1lQXOLhYfAAfcjU9N3q+xzDpRmBDlneCDBsg1XmxONV8uni2J374UvdhOBMF5TlwOudGl64Fx0tQT2fXO1h1ZRQ5AnIUD3EPkjP02v17C4yka2cdhS21PLMoCs+/t7FY1ANENfmuOd8Z9g/cZGKoNq6nGteqWPDkPsrwKogr6Zg9E21Y2J2ZRyV7+IP191MyIpC5Jbbs+ktNaz9eNfQBmY2QnsJ6/fuWu8G1jfGZh2ziWz3WfhpCOtJabkI/PKpuv0Yy/85uQo1vO2Ypt0uDvsxQHnbAh73AKKlICrolM5XgMhSzsgDtQEkyqUzC5G1u8j2iW9ygJKrHetQ/lpmKuOA9oaEl0SsX/IWuSvgaVvvD7WnSNa6VnbADws7C5HuxHqAQLNZNncUGDMtpYGvfVksSi+Jy/ip0KDMrrWwqRPzj40A3jNlKpCFXK3aUFaqddXFcqKY4WHu96JjttaAc8nDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(52536014)(66946007)(41300700001)(2906002)(8936002)(7406005)(5660300002)(7416002)(4744005)(8676002)(66476007)(66446008)(76116006)(64756008)(316002)(66556008)(7696005)(71200400001)(54906003)(110136005)(478600001)(6506007)(33656002)(186003)(4326008)(55016003)(26005)(9686003)(83380400001)(86362001)(38100700002)(82960400001)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?haZGgkyEkaKI+npfRQ6PqU1CL1b8t5+Y4BwB3jnXOzMtPODt5Xfs8zsT7ebt?=
 =?us-ascii?Q?6zzGNUe+x5wqnWFTQuQZhlL5MtoWcgJeqUjnQa2GjY1ZzbYCfzXB2vpPxbY8?=
 =?us-ascii?Q?7CtzPtFhZMdiWASLXvfWTeOfNsZhb0Lmaxj4qbv0M/duh2UTQGBU3ZbZMUCr?=
 =?us-ascii?Q?QCGZtQfzjZ8otR5svmDaB6Q8rFN5UjGEwleTRO7Y100K0Y6RkrQk7/eD1JHz?=
 =?us-ascii?Q?OhPi3SY1ytfFw5TWWNRmUeDXIbsp/7yie7x48DOf/KSXyMqxTYamwBrExqlN?=
 =?us-ascii?Q?HnVv07QqoBeRhZF8Z5+v9Z4KzIFR8OtyUpQrJJTu69Kl2XSwIcrD3B9uXNvc?=
 =?us-ascii?Q?rSNwtuOOTfrs/GIF0mReHewI30eYovjQ10jp/G2dBJsARNx73E+CU0eVMxWm?=
 =?us-ascii?Q?sUspQBKaD+rItOlC/mib463gw+bCwcU0FnC4koCZVzkLZjmsw0WrT0uGvaJt?=
 =?us-ascii?Q?gKKQAiYUPIT2w1HFTU/lASLMMp2rHn6YYppFOTq+WWzava65mX2tVQ1RUGpu?=
 =?us-ascii?Q?2swY8Snj2jvc3dRbrTQ4gX+Ji5VlxACnM9vLiTv+8hBax0CGsI8L9VI11G2Z?=
 =?us-ascii?Q?ADuSr8yTFw+WZG5waCDf0VI+k1FxNQgNMT19GixiauN3DB3LMQJHKE9R0QKn?=
 =?us-ascii?Q?IE11q6XKAARgeKlEFdmOFfNZY4teQbmQ3Q3ZmbXoN8Vf2ZX/uu4fOB3zk14p?=
 =?us-ascii?Q?RqMxmPb9sfi03iPgSklS6nFCxR7IyDdQyQpxfXiPkNximPdBDkTTLOJJC0NM?=
 =?us-ascii?Q?tENYsZzXxvhhwJtnLoifLpZQumMGZzC1st1gtS7oVR85emKwtL00qpVuot8p?=
 =?us-ascii?Q?glQf/HykARG23O9FpUzEzey9j5sf1uG691cbRA0c1MedPy0jg2RSka/jUUuO?=
 =?us-ascii?Q?8gjzSn3wq5IzuYyH6FjxiVoSXy/iBXo5O58ASatCAkuraYcHfet+L31aIi+t?=
 =?us-ascii?Q?YSBi88bvkwiQluqIdcs5hY+UgohokhRpxQIq2+W+38Bh+Pppg8U73RO1/zmo?=
 =?us-ascii?Q?xQ5z29km6ZhqOBwvk4Z1cHTgkzB5mGFh/zb1Fr6qtrgcnWHu7i8sFENaunoq?=
 =?us-ascii?Q?RshIcyD4DbjMmTHFvn5PcaJ7N1ggvbj20PgFRbB0BdZxL3XWJ0WfMqsNWuuM?=
 =?us-ascii?Q?RyworeE7mycg0hFrgFiR6jIiux42su+jsTPVJvMcGYaswe1xuSAM3HusFzjD?=
 =?us-ascii?Q?3G/c65RI2sMD7WKrBznxSAjvxz8rSxCMEIc4poaF6SzniNaJR40R8XSLiZ5I?=
 =?us-ascii?Q?CgvLL0OUBeLEoGpjaRhxictjnjH651IktEbYglNKCABEoz+dJZ8BHcbEpaTh?=
 =?us-ascii?Q?WMT+7RLdnS2jY9SUuP9Sq6HNDcqGQ8D+P9Lsk/7+616Gqr3YvkpgHE7M1IF3?=
 =?us-ascii?Q?jCOUqb+4beWfwU49oq1hCik4Pd/kJbQqOFVesqEWgQhUEMVCKc8jjqEAo0Lv?=
 =?us-ascii?Q?ATa56ug6+yCg2zBqIKzOo/fDUtwW3RMQLk0opcaRzL6SSCjw0Ovwe7NcL4+J?=
 =?us-ascii?Q?+PX1gD+iL9GZMVwmuca2WAKu7pX8DqG8UQjg+qBvnCJE8WuuBeSdq0k8+OKQ?=
 =?us-ascii?Q?6nUj5Gsz6aaMZzXPxylksYsNZRioVc96KQ50DCUg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629a65a3-bac1-4351-f0bb-08daf34d77a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 20:58:47.1469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5BAFiw9bVVpZ8DNyShI4ghM9v0B7ehOxvbp5cdsk6DM2qKuCG6B+yhGiOnUH7IC0VhU9YAHYlpX3GNyO5Pzng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8059
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > + /* Update resource control msr on all the CPUs. */
> > > + on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
> >
> > Do you require these updates to done immediately via an IPI? or can the=
y be
> > done bit lazy via schedule_on_each_cpu()?
>
> I have not experimented with lazy schedule.  At least I know the call
> update_cpu_closid_rmid should be completed immediately. Otherwise, the
> result might be inconsistent as the tasks(or CPUs)  could be running on
> two different closed/rmids before it is updated on all CPUs in the domain=
.

I think this does need to happen somewhat urgently. Imagine trying to give
some extra resources to a CPU bound real-time process. That process will
keep running with the old resource allocation.

-Tony
