Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42386631AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiKUHwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiKUHwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:52:43 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637CFC72
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669017147; x=1700553147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Rp9kWpuT6pIIhsZynR/lMA5UOMgFRoaQHtt4LKxmwU=;
  b=iODKhvao3hbY59CyUW/lrNSmx3LVyNfDj8hzoATLWcbXO1dWxIIrXnVA
   9hkCkjD7j/QwGB93kaWyLkJwdMNj0RY3bqSaJrojSQ/oiEvjxUiAsxl8+
   dwMNzsEm7qY7nZG7u2q0sCQTFyJiUPxGxUsiowExroxOOiR8zBjrjn7zO
   S2YraiUCTwctMzATxwh13hZaBFVZI9Jf4v1w2Rd5Z3Yfxr93B/EBquKD2
   /mw3RVqyHZoWTmwi3/qF5+nxYVdIsNGvWeFZTUCSqNY7eryKw5fAhQ3qT
   D1XmzfQ6Y5CBQx+XcwL/hKhNfIgMTLCbPjPxOQspA1DFtAXtzfGPcxTyc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="375639962"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="375639962"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 23:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="704463226"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="704463226"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 20 Nov 2022 23:52:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 23:52:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 20 Nov 2022 23:52:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 20 Nov 2022 23:52:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POPPQ1Et2SlFflWA1r+ca/RbtWAIKe7WpzuGoW6u/Gqfk4qtlmD/IclO8wdacJ0piiPWhn4lGYjSYdAXuYM0bD+ok3sBXiElR2S0ze6zCvY12WQMVp41qc7JVZcp6vNEF7rMNqSDduYuDrBtyBgr5E4HUf+ixelySZqzPmodtEA4D3bOJsm1RKkBbqToTomtkOQtfRl4AwIy/cIzbJND/Et5DG6ZvO09q/YYGXja2ch9vbL0fX6kjH3NykT6al5dCxeojqbMRMt5KRAGQP9QMSDs++334huX5DlJuhdja6X0CCMCOHPgAzV+FrzvIKZ57Z3eM4XtmJSba0juPi+Kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhonqX9yZWZyP0gULt3R5D6QWsukKdL9T0uw0UP9hvs=;
 b=nIUGY9GKBHwE01U/+VdGRSY12CLoOxk4d29FrHrmrxO2TEJOryohJl8wHbMV88wSyIApEredeuICbkrtJI4UV75J02J/w67HCroO0FUOxRcKSI/MPdDLeJ4LnfoXeoA7+Dc+2WjmN8r3iUge7AUfwnO8zkE56dLmMaIoIK5nQfS1sfzFXPXmVpCkbSOUYYTDXzmQLFXT0XIfiMCuKOwVWjA5ucr0ea/jRsrrMMHq1BnKunSBX7uC/O3Qlfxi7LtT5dv3ftS6NPq9YNFnDRcmyf0oDKRSZAttvgq49cjWDZhlzdM4EPcZTSth+a+NdgFW/3Ox30/1BSzNSxehya2iWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 07:52:23 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::296e:d1c9:648b:2aa9]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::296e:d1c9:648b:2aa9%2]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 07:52:23 +0000
From:   "Li, Fei1" <fei1.li@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "Wang, Yu1" <yu1.wang@intel.com>,
        "Chen, Conghui" <conghui.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Mao, Junjie" <junjie.mao@intel.com>
Subject: RE: [PATCH v2] x86/acrn: Set X86_FEATURE_TSC_KNOWN_FREQ
Thread-Topic: [PATCH v2] x86/acrn: Set X86_FEATURE_TSC_KNOWN_FREQ
Thread-Index: AQHY7bJPaJkWnW5TA0i9pVLsL611Fa4zoFSAgAqGfoCACvoBMA==
Date:   Mon, 21 Nov 2022 07:52:23 +0000
Message-ID: <SJ1PR11MB615392FC28992FD088E05046BF0A9@SJ1PR11MB6153.namprd11.prod.outlook.com>
References: <20221101053019.174948-1-fei1.li@intel.com>
 <Y2kkk+XqBP3u6ObI@zn.tnic> <Y3H44Rdi5ari6fql@louislifei-OptiPlex-7090>
In-Reply-To: <Y3H44Rdi5ari6fql@louislifei-OptiPlex-7090>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6153:EE_|DM4PR11MB7205:EE_
x-ms-office365-filtering-correlation-id: 65896d3b-0362-4ae9-7601-08dacb95533c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KAcIVia062ae7a10DC3769u+A0KatjJrQY9RWZCYBYTeldS1UhiQfZnz0yd0o34/wGy/pvibGwvalGubFitl3PtgTs0qOR46gobKAFAn62esGW9L9qsnWHO968SN31z4+nejlp6MnQ2obN4ZLkfljz+267nMdQRVlAOVcOfuq4KhLaq0ZhMjhqbpjo7gFQqN2gspnE0oIFt3TOZ0x3AWnWN2vT7Z1pTdJw74teb4RJsH/jJx3dLwty7+diNnxrdOdXsI0+7brG4otjVkrhOYjd4Nq08t2SHOZogIEXQ8UWEMWE6CrSapmfGHfIk31Hb1aUNVg1e2dro4zXvzGIXEj/BMgwjiTwGyxHLhZ2Tr1QztJAiXLYDy6mC+mr8IMqM9+Oucdws3pzelLbyZxxDNdwxe+OiHaLyceCudqks6AnkrnFtkyptIW2yyhqoCSJQ5NWOSOcZ6sUmLXO9DtKAXzGT3g0l7MRFUEO01vgw3ZJiiqiYl7Xgjv93QtPF4MuVOAdhpTB1u+HwoJyCycWfu7LSO7vFSXVKmt/DWNGc+U0+h0whJqcGwU6x9LWGE/0u3zv8Ecn2kr+m3TMjYJynZ4wDzkCLWr9Sur2hsDzxGrFo7w1tW7D4GeiK3UKy+1cpSSqYBbMeS67mJSeM/mEB7HAAsxA9MgimXZHX0uHhddEovhFVbfAs150uc02qiv9hnKQawBsB0JIOySvy63yiDeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(5660300002)(33656002)(54906003)(6506007)(7696005)(6916009)(316002)(66476007)(8676002)(64756008)(4326008)(66946007)(66446008)(9686003)(41300700001)(76116006)(4744005)(26005)(8936002)(52536014)(186003)(122000001)(38070700005)(38100700002)(82960400001)(2906002)(55016003)(66556008)(86362001)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pj0m43i75/AVYm5QsLDNLnFmQEfTx5gJYIS37680UhcXj8Aj9Mqm+2Xg7T/S?=
 =?us-ascii?Q?++OKtbTfbvBd+P/pPN7WJ8LsRu5bLHIO9zDm9fWSVgLMh6J30C70KQGH2im6?=
 =?us-ascii?Q?xgTGaNbYCpBT11F1ONRtNLBqs1xR4W6HvTbMhF2p+k2PWy9h2GEMiAWg0Otj?=
 =?us-ascii?Q?XObSia2KelBN6uVgRP38eitjZDyD26/2yakbG5pY+cHKf9uqvA0FF/XVrRV1?=
 =?us-ascii?Q?ZayX6RoYhQ8lbCoECM2KQT+kovgSkbjbRZpGfrIrXNgmm1ZGOX0gm4FVnW+4?=
 =?us-ascii?Q?gCRPb6khNKycEM5hadeYFR9hLXniUn0tOi0MElb66mDq2CCOtexpctgYwjVz?=
 =?us-ascii?Q?EmOdKHYgZbd9a+7sAVs41FWiSRuXcNH3/Wh5CJ4CZxqu+m+F4GuzMC9jxQve?=
 =?us-ascii?Q?g5oDsUU+nkVZ3F7JSreU3FG88z4sXkLo6KrSnhDpEyh0tVmLv6kl1eUC5Q4q?=
 =?us-ascii?Q?5lnAsH2/qqkv4q25aQcK2cf/YpdVBL8JaGH93eCf/JJUI9FliJI2nAc8bMW2?=
 =?us-ascii?Q?Gb9wuIP0NqZRzoLHfMlgLGifCQXXwW3gtkztWOlmOLmoDgGsQzaHMzFkx5CO?=
 =?us-ascii?Q?ROjUk3j7CES/ZNXAN1RvL+BFWLQS3KVtOrjPp1ROoK8yf91vwbKlnS8sTEWG?=
 =?us-ascii?Q?RJ7no24FVxfh5sYOZRTrC1SIJWo+R1bYcvTOIC1YdN44ZD+VMDRCRhPe+F/l?=
 =?us-ascii?Q?mbZ25hj+kCalO2GWWlMXYSk5M7mMtJgDidw4hpDBQtt5rzqoGaYSCaMEKk+i?=
 =?us-ascii?Q?8tbneSMGMpt1GQnDdklAo2tt0tPaE4CQ21vl5IEjSnydRtFo2qMgryjsXnfl?=
 =?us-ascii?Q?K9bRSyFeXIlc2otb8hcoOjOWQEgrraSlcVi8xhzKYybPlNw/EaTttJXl0dBN?=
 =?us-ascii?Q?hu0v3Hl0w0JEnIwckUkbXTtdHJqFOWAsw+Qh+rZ/buVy0H9RRxiKD8A7TYg3?=
 =?us-ascii?Q?3UVO6vCBS3GEU6d/gB3oTIvM6kl2tCt0pzBBRad1ozSM9Lu/9T+E0SjKdnnN?=
 =?us-ascii?Q?WaA8T3zwDWr0+ChR3sfCq6E6qqIGVzhMZhvfot+307zilaxqBnwqKeHZ7kQd?=
 =?us-ascii?Q?hSD0Wu8d/3c5wOn6CQjoluCoon9ZQ3wdpI81JEAStzjA/UXW2XG5vgXUp2ar?=
 =?us-ascii?Q?vNq3WpE6dULjp3hEb058rka9Au4omdtn3zv6l5TyLtm/kHbOWdgHOslkrXzU?=
 =?us-ascii?Q?JJXlI46IEEhcsU5vN63dgXhtVZL7yw/W0XutGC/us3XMX5ayHOqgz0AyTTdi?=
 =?us-ascii?Q?LSW6tlnGvX4KnRDFtXjRY+02pJIHjONHwYeLQ/hp3jVZtUw/M/RtPLziUgqE?=
 =?us-ascii?Q?z4kOwHKVQ+qfOR3K0fUbKXGDAk3RcSCge2/p1CG8SxwfwhcBzw+ZxppXIjPj?=
 =?us-ascii?Q?kNf/D9+1m+/vfHqs1bDmVkak0GGI/OLz86wa/f3c7oMmk2lRxAAOOst2cYqN?=
 =?us-ascii?Q?LHg3IJ8qTpXeJq6T8LHuGeFJBk7Qk2y/8iZbiQ7IoKhahgTGtEABDbQWzTEL?=
 =?us-ascii?Q?DYQk5VhqM/XieruAk1FPeyLo2uNliHIZm0YbIl445fzX4bNLTUQ3nUMex73/?=
 =?us-ascii?Q?GF6aJllFgSaIxSRm4CSczd4PChnc1hIhDbDQNj2q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65896d3b-0362-4ae9-7601-08dacb95533c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 07:52:23.3227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmViYJMuAQdwGpTt8YS0UebKGAfoGL1nf+TTpCuZhzCGDaG8XMH1yPOf2pARcn5pbRixruLlhm3nNjN3EkQAxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Borislav
>
> Thanks for your comments. So sorry to reply you late.
>
> >
> > What if the HV has unstable TSCs? How do you handle that?
> >
> ACRN hypervisor assumes:
> a) The TSC runs at a constant rate in all ACPI P-, C-. and T-states (i.e.=
 invariant TSC)
> b) The invariant TSC is based on only one invariant timekeeping hardware =
(called
>    Always Running Timer or ART). ACRN main target uses for IoT devices
>    which are typically one-socket
> c) ACRN lives with temperature influence on TSC frequency
>
Hi Borislav

Kindly ping for any comments here ?

