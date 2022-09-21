Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FF95BFB19
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiIUJgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiIUJg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:36:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E20991D33
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663752989; x=1695288989;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Kqv8Lw3LsR46AdFQGjaSPRvNzdWjV5KJBlI6yRvCx4=;
  b=VCskBGpbgPL11RVMUbpewwQsMO1GpnwzNffHfE+MKBhmV2PGHfCUDZZB
   4mB4w/KkLKxHRPwhtn8jgm9/7w25CAv/4EccdfvuhsP19l7p6xDQvtETJ
   TjMUu3CrbgCfB+m8D/sfTXWicXpfEh3UmLVlwcFIFt7qWWANFL1naHob/
   29IBuAHtbQt5BGlzRZjseBIFkKYq832Pq9Z4cb4PpsGE3kC1NFYbotpAT
   iQFIIOMXL1ngbeaybHChKCP1NeDgYWKVIxJYdpdqpSyy8kdSZ0kilX6Jr
   nM0HMxWybPd/BtO/DNlEd9uvAEYMHfjZuFAIvni6BSytvdayyxtSPmYs0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="361711338"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="361711338"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 02:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="596906210"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2022 02:36:28 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 02:36:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 02:36:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 02:36:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZq2zYCImJ6Zwlwru5NUxPHzArQsWitw55wUNjY71rc54jzk0+eTxLp02o81FhJMK18zpiYlZgdMUSQb9dKRrikhFdV+mX9M3A2BZJCDXzLkrxunB8vh6I45zffa82KNk7QLNUXol3SpIh+Jg6zqGP9N8lkxzK1lWGiaDGDc5kU8K00UVHphbtaGgREJUXHYgr3JOdovhOs/o79ZStBCVoS5ZouGSazMTFgx9lNeKu82odBJDU9vcZWTCg65xkcBQ+7YYVy/3iB2M4yAwu4vILq7qpZVWH/mqTcygChwNCllXJM/4p3pimg7lfxPnd9rbrq084X9CshfgzH6ijn+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Kqv8Lw3LsR46AdFQGjaSPRvNzdWjV5KJBlI6yRvCx4=;
 b=EmAHUD05kdQwKjaufF8gFiZlFRaHZw/vk2zFDqIBcJYBTHbk3Nt5jv5ejxCTRadI0KfnilDnUE/6MAulcFT9Osf7nceNjVLyhXV9Y/k3XtJTNFtll6fLA0ZBYjA/f8UpaclAQVaKnJxRbYPouy56/OFNCpxHlSLYJko9yie0O+780GTDvKW320pi9+fxGN58yjvUS5k5XFlOjichlPt6eaAb35oO073Cyx/Fh1ycDp4HHeInq/iftb8MGgK8RFbOrXuf61QI4hV7DdhVsXSWhZ/5w+kdf47iwpNq1q2R2thm00ZKVT47U/pGB2Oh9oyKtMxiS1NTmt58yr1XiBrFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6990.namprd11.prod.outlook.com (2603:10b6:806:2b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 09:36:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 09:36:25 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Kostya Serebryany" <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Joerg Roedel" <joro@8bytes.org>
Subject: RE: [PATCHv8 00/11] Linear Address Masking enabling
Thread-Topic: [PATCHv8 00/11] Linear Address Masking enabling
Thread-Index: AQHYvAwcdGfqE8P69US/yrfpdW+Ch63K3Q4AgAOYigCADgYlAIACnWEAgAAHRYCAAAH0AIAAA88AgAADzQCAAIe2AIAAmcKAgACNwwCACOYFwA==
Date:   Wed, 21 Sep 2022 09:36:25 +0000
Message-ID: <BN9PR11MB52769D9ECC43029B8B7DDAFC8C4F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
In-Reply-To: <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6990:EE_
x-ms-office365-filtering-correlation-id: 7b2034a8-aa72-497e-822d-08da9bb4c08f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ko/ThOLOIXy1QORzNsfTy7GK43qi3MkciTxyhx8796XD0T1zDbrGRWp3zWlnWoscDigYhkdHX04DEot09kQshJtumpcP5FWxOl3kFUCUUTxulFBJkBwEPcSI8Eqy6o9T/zEHXA+yHM7buPC+pYKicCLSzTK9wT6nR2Utz8ObBsSsi2+HAaZ0CHj5axDFD6+O2aZ/fEmJDkPsJBbhwlWU4sieCg4OthrogwacUvJ/gNed35X09KXaETwFHFgvulCS+0vlK6eMfYgKepMCFTIL3a4rLOcSinrmb71VC6wmXj4bPCSMhxLg197ukEAL2m42fYbPr/ZikefSRfGJer04SROCdSsp5EBi2M/BOsyPEnMY2uIr2l6NtVZWsbMqvJdpBe9j/7EFddYNVz4m/S4Lp9eqJLeatDJre4A8FdCGZqkGHSgsktLiY5EkzvllkmB2SMKtgkPDwDhQMmc9ZbxGzep9g9OMJrEtmAtuLNKDlLKpcaq1xfAWP7ZGQWzg44dnc/sex6Bs27hAPNG5CSwX7Dwa90X+/rwx9iVCei4nTfvHvz6/YIG81l1H6t8zMaZ0fHrm5mJhT11/HESAB51fX3qAQggwiosvUzqmWaoFF2U5ZvrtBiPQ9fANzoqlVVHHK7daHMBACXa7RT9ukwXZe1XWJnVyNEhnT4rBUo7/rrCt+qCX3UFvcBSzbhqzXFKjPfrYwfGcmIyYlJWf6M94AZsYLGM8puWr17Is9NLLPG75/O9QLUet9ZwGFUiW4aEW6th55bqbKse9LoD1yfSSAaFbvBifJ5+UtpCeZZq1Uwc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(66476007)(122000001)(4326008)(55016003)(6636002)(66446008)(66556008)(8676002)(76116006)(8936002)(64756008)(4744005)(54906003)(110136005)(5660300002)(316002)(33656002)(2906002)(86362001)(7416002)(66946007)(38070700005)(52536014)(26005)(9686003)(82960400001)(83380400001)(478600001)(71200400001)(7696005)(6506007)(186003)(38100700002)(41300700001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yfnjaIQde2aSxkIFDk4XQx89mZjrd5TR1zsdqvLoXD3PZlSRQsgElEX3mfXH?=
 =?us-ascii?Q?yqZdiBbPjwA34uK/7wQxWOFvOAJNIFknkmHeYIg0PgY/kCPMZ/Fc04ova3OY?=
 =?us-ascii?Q?LKL0Sm6leivpSK+sy5++vMRWb1/xcof0cqkEStqR4UP+d4ZKc5esfXQZF/k5?=
 =?us-ascii?Q?quv5+exTUdUlJipHUSEz5/y2NVvwB8RVWRS21etL2jvz1WqZWCMscqPm4Qzr?=
 =?us-ascii?Q?HZuaXryu0oByPBabq2BsVfPSJHnHq+/6FeaSRG1cdhrFC+50WAhCbIL6SYNy?=
 =?us-ascii?Q?/mCLXE/bjCkBKs+jfuGHRNpMfHiwm4+d9DzZ0LdCLmuxelzPiN8puXxwMUmM?=
 =?us-ascii?Q?eeuMUjQ6zoHIuso56Wj+7d1BCEqW+PmWSuFcqwlS/WxavqRZIh3GVcLJqxGt?=
 =?us-ascii?Q?n/bey3hHcGn1pbfW7LC4xX5fRsEXHOrltqhyLX5qxaFkPmXuFkQmZgr368CP?=
 =?us-ascii?Q?TsVGKbmydzd8CmQHnkqn5NaKwkpPwsPQxUtRI+TnFx/NmxKcP6o8fOEx4eq8?=
 =?us-ascii?Q?zW1MSo1CbosF7CJbjIiHZ/PVLiQc6hFz9SYShsCQMNc8GM3+SdepRpfgAuI8?=
 =?us-ascii?Q?RGDPupIWUTfNWof3OBe3TmNjk/RMXTPV5pUXna08lgdBLR9ozLcwA18jYNOJ?=
 =?us-ascii?Q?QnKlvfObsWoS9sPc4YGzEsmLxvfUR2MYoRWRIqDC83jLy0RHJKcbEB2umLco?=
 =?us-ascii?Q?2JRnuHiiwwd1kvTmVIHPTBwaN/NczBzOLn2DEfzHQjul8yeLVkW3egl4eoL6?=
 =?us-ascii?Q?Ji+33rNK+kpB6mqqnJZnioqV9WlO8m3QAxt/KoPWbP6G3gQh35VCsjS/QWN2?=
 =?us-ascii?Q?TuJCaicsxarkt5bCXelDlaUU4vdKO3vFDwroCk+drxm+FnRErJgygzmiHT0D?=
 =?us-ascii?Q?OCnj3C/zYIcTFVtBosfGT+QkaHhoCKADp7HAm28SmUaO686BjuMRl1D4uOOQ?=
 =?us-ascii?Q?RhpyGVK0t12r3elsEpTbXjUWPtiasWCCISGVgdPM8t1LfU9jplrzmFu2jMc9?=
 =?us-ascii?Q?Hx2iLnrp0waEPaT3agt36+rbhTH+uw7LpzKuwBQV9ANE3+3AXuEOJgKDucGC?=
 =?us-ascii?Q?ibU7MgvpsaPWoUszMCaAz0EdHWORETmRZc1E+khlAZ9igvj48gyC5sv8yvSE?=
 =?us-ascii?Q?BxmNGDUkWgAP8JyWz1Q28lGdWAffN9WG74Xjj8gMDixdw3bVSi8tdabXWv2j?=
 =?us-ascii?Q?Kumk3erIFSVtIgiYa1vVmkwbMf1Mv5qc3Z8kNVU4qXeMfulGxIcoSUqi9Egv?=
 =?us-ascii?Q?ahK6wos647AkJBP6HUWB8grG19myZ/4qw7qcVMMaWpU6cWJpFP0Dnzaj0U5V?=
 =?us-ascii?Q?svnwwqJtMb2o6AKxdOgpD7Ym02SPqNG6tonwBgcWbzYSLA9eWOm2kvQahjNe?=
 =?us-ascii?Q?tOPMclzawmCiPUlOCauD0g2/cbPcXpJf3EcsYznAS64jARl3U58EZ1SGJ3Si?=
 =?us-ascii?Q?RMsH79/SYb7RDTPLuQiXtK2rkkUJWBSTKUEsKatxt4wKfQQNvZ/itt71/A9A?=
 =?us-ascii?Q?Fsn7+VVDloTfoakt8z0sspKHSocSONtoyL8O3bVoVcQNp9TIaPLSLfmBa9wt?=
 =?us-ascii?Q?UxNz/jZbyDr5lzJQaST9Gbc0DgCsfSlQWhPozAK3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2034a8-aa72-497e-822d-08da9bb4c08f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 09:36:25.2926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XINNtaRd008Sb/laq8lBJs9ibP8EGFYFCVQ4+uYHpKQfLiHSHi7cYUZDESWkxDMzKCPG48JCiUCVSlVWpoDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6990
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Sent: Friday, September 16, 2022 1:29 AM
>=20
> I really struggle with naming here. Any suggestions on what XXX has to be
> replaced with? I don't think it has to be limited to LAM as some other
> tagging implementation may come later.

What about ARCH_ENABLE_TAGGED_ADDR_CPU to mark that the application
tags address only on CPU and pays attention to untag when the address is
programmed to a device?

w/ ARCH_ENABLE_TAGGED_ADDR_CPU then LAM and SVA can co-exist.

The original ARCH_ENABLE_TAGGED_ADDR means that tagged address is
used on both CPU and device. Enabling sva on a device behind an iommu
which doesn't support LAM is then rejected if LAM has been enabled. and
vice versa.

Thanks
Kevin
