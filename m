Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1956D6C2C98
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCUIhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCUIg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:36:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B97199D0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679387790; x=1710923790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QszN8GXk3epkx+638Fsa5zVCFLTyQ2riiTuM20lv6TI=;
  b=WIyHzm7wwV81MM2W5XDjLY/ixwD8zv5v4vAtm2sXq+5yEwiG3zvy7mHU
   WnejN6CjToIyOnxtoJK7SBJBWqsfgowpxTtQ/Ws1uk9Qav2V11t6/S9lk
   H9ssp3ojf3yWYVO1R+z0Li6lEBuS5ZbhCu8AS5aT1/Vq5nCbezQ41Nb11
   tqqbSHM7avvW5+tDwS0/bqTaAd45d68mMcERads2IMMB0c7SHAH4ChiNA
   h3QLdLFqQ7nyjJ1FL4z21gjQCq4PFGHs8HiTqhEhuyQCyzjavOvizQjKE
   XRH/shcyGZXVHb2KO6Ae5IBad6Lclr+gfxC7Pu8o2SLL7Dlh0xWVaaAea
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="403755417"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="403755417"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 01:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="770538286"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="770538286"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2023 01:34:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 01:34:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 01:34:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 01:34:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNZfyGadzj9FhZni0AtFEeQiajEVAMgNhcBAevBm9I1QdsOBbs+wYDuQF2ZUgpHJB7LpMgQe+mZIi4R8g8J4wa5NHI3QO6n/bUZth+ugT550H+msHte2RteoOhrAjws8ylVeuXDTXu0K2UgXxH/I0dCJXPjNl0gHqP0iZZvatd25eFfqR6drDxNaZxBhb6tCBSrVqcgokXWDfKN6xhM+SWGu/Jb8nknYIT85m0s+GNFETblK27cr5V34l9YTxS8A1LBV46kNvzEaokFlkHaKaJ+eKcetXyuTA7N5cXb8reYMyIIE5nZ8wDVr48TXr5854e3fdwUfrPOmqAftOTbBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QszN8GXk3epkx+638Fsa5zVCFLTyQ2riiTuM20lv6TI=;
 b=aswpTbax2Xnko1MGgpkO50mbGyJXQzC5G9dF3aNKxCJMQvYc2KBFrX0ULbXKFFTMLf5dVWLkIrqXrivhsI7BTJarunJfb5eLFE1wenUm8hE8yp9V5HDl4AaXjvYFl400h7alDVSDvFh0dBkJtx/qAsn7LxH85qrEh2HeA0Utx8+FFu+7o4JtxUrJ/cugrdMhKnvPHBlRHpdbnSAK5gD9oSjG8uYUUmDxNCiFNTX0fzEGbYXVlqtbpTXNLXnF3nJ1h7TBzTQfIT+ckvQIzxOmR0Aawl/b2RlSIlU4oJcLHpAuCXkD99AYPdber1fURZOc6/Gjm51mByKfipd9m7YRfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7318.namprd11.prod.outlook.com (2603:10b6:208:426::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:34:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 08:34:00 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Topic: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Index: AQHZUnWe1bQRwtfhAUSI/T7BqHBa167yh7YAgAALsACAANbagIAAyRsAgAqMnjCABPKxgIAANdgAgAAeawCAAPG3IA==
Date:   Tue, 21 Mar 2023 08:34:00 +0000
Message-ID: <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com> <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia> <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com> <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
In-Reply-To: <ZBifWkY2Lt/U1Z7R@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7318:EE_
x-ms-office365-filtering-correlation-id: 383ceaa4-5346-4b6e-c19e-08db29e70546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZPNrypwU6dvTX9bROWYFPR3M+ED9sv81oF8c4cNlQOuJP0LewizLHO7v5hkYkgaTujpnNL/EEP1f0vDr25hEIwSPLFR0611T7c17bfRl2e17zdC2XibdZ1d0CujRyPR3M2h6BMtvHSiwdzvFTfs6CxndJGh8IYEPVvW5fQFIbRu29uj3HxmrLQKz9XVCUPnX4y6gtvydg4bUdw6CTWd6pF52my6JHSUdQurr83wKL1M8xoWLy7RCd7Dh6EyzfoJx7lifO1oRDvEzYV94Mhpv5pHjPaArTL/A/yPy7EWZ19Y4jGC6HSQCaxh5YPVnGooMg7Xl5NiviMn6MYzkN5biYOaVHewFdmG4Y48TWR7woC8S4ngxMKrTJODvNRUPiObR+5p870sojLQzbVb31Gsh5IBR0X4IgUbQSTOyhtiDQPoWu8qxVRPC0gZUpW8t533RBSc43CmQ2s7ZYaJUXlwwnMSjE1/4qnENvsOlmbS/vBorz4nzNqqDz67H3hgaGRG5ioEQHXt5eEfcqaPQragpd2ULWrgpC9s7A9sxqfhXHHyKv5jen18DIcRsp5L8zH6wf7I4+Kw4VjsFZu3m3hzu12YALblBpjEQe8BfvXHM9r/k6mrMqv5asD3LjZHZt0xDFhVBG0eDVS5NxQpbiHCGFl5PaBcDp6yyQ6PauwqLhJm2u8dcNkbnXqqOzpNlOvy6cG9ep2pz72PKgF4GU8O8sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199018)(82960400001)(2906002)(55016003)(52536014)(9686003)(8936002)(5660300002)(7416002)(6506007)(41300700001)(26005)(186003)(86362001)(7696005)(316002)(33656002)(54906003)(66556008)(478600001)(66446008)(110136005)(66476007)(38070700005)(76116006)(66899018)(64756008)(71200400001)(122000001)(66946007)(38100700002)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U+bR+4Z8jCyEahTHG9WrG5aE9MZzh+T/zEVK1c60lil1NMG9Tf9ySp4VohoN?=
 =?us-ascii?Q?+IapmzGGbKdj9FJ6Hq/Q+J68NJObhCNIxOze0b8gb7+3wR7q0IpbKRlels06?=
 =?us-ascii?Q?JMlbgXJFV/sfg/XlNmXO6SyLMhdmBV8Pdn5zRy8yJX3f/wP3+kHhpjs2jvbP?=
 =?us-ascii?Q?oyc8NzwZAmAyEo1YSm4/6r9X2+fdYXuzka+3Y4BgNcc/uvvkMB8D3PbN02q3?=
 =?us-ascii?Q?ZTwD/XpMSSwiwNgidueNLfdGqXpaA3vSmFgKELUPrgll10YnbUqaeq8KFPZo?=
 =?us-ascii?Q?k2HuPm2ntA5/Zux8+kVj6Q5cf3G2oaSfndSkDdiq+x8fXSkI3+GKUJi2j48j?=
 =?us-ascii?Q?0VlB04Zbr2ITIt7TLKNN8HTxaun/s+V21fGPnBhgPnc5butCT0xWOBTeR9/G?=
 =?us-ascii?Q?cH85dVH5W+xDwVbkDX+IKm+Wsk2/sYsdFmNZnD4hX7C1GZzn0438CeRnPP+P?=
 =?us-ascii?Q?xin9U+yVCTKjzTJqbmNe8Eb0S9jAlJkG/BoC18bkjpLZzXwHBO2/X0m14GRY?=
 =?us-ascii?Q?7LN/6pqo6saM58JGXmMH0jo45K41y6E6CvfFMgRgMyFQ4KWDn8mZmflRFI0r?=
 =?us-ascii?Q?aSata/L5Uku6kVpnJ0wvqaG0fU/Tv/s52h5lgYdF4CQyC6ylv37PpNEB/8ny?=
 =?us-ascii?Q?y4fRRrV67qVJUn7IASqwuVN4Vc1lUU4VFM+W5eWUEhyC1MRuO8khwOejlAiY?=
 =?us-ascii?Q?4p3A5LV3r3X/KFTTQ1jl0BA3pXFNbrd/dG2HszCSxcckL7mMX9D00EH4ASJn?=
 =?us-ascii?Q?R+E6NJARggAGa+zPYaTaF2RwuLNR77/6uIDjNw6NRkKx5ocyOAJ0xo5+aYUj?=
 =?us-ascii?Q?tb3GgFci/cVHPPyNmNSQVIGgUYpJnQ2VYGROlq1GusvxQk749ocgUMGf1LyY?=
 =?us-ascii?Q?MDPkxI+kTFhIvK0xqSJgnsh62B2UPXAqJDSErQlikZwqtTCrtY7c7N9MX23Q?=
 =?us-ascii?Q?W4bn9f8HDdUY6bI/0rZPogZDfrdsHPhXq7339zMKFwOcKKOOc867G/UxSsv9?=
 =?us-ascii?Q?Joe1Nle6TX4kGwqFFNwtoabPwIloVzjP2Hz1GzEfwzp4Mza8xaWniEbCcyZ7?=
 =?us-ascii?Q?PKftNGsbYddLE32OZcPtHA1YidOWXlUdYeQblZEo9spwy1ScrTKWhpTfgOow?=
 =?us-ascii?Q?d1vJIsZLj6Bcwgf7SJ+jaMheRyHiOgySHF/t6qdsYuwLc8GR2mpvluE224aM?=
 =?us-ascii?Q?WssuaogUfjL9tBRyqRLuVpChjmQ28gKHS7qdRjARR0BBEaym7J5CR0sIk8Cg?=
 =?us-ascii?Q?t6EjBDyIt4QdV9h7jOr02YkBBuBGuny+ZZfFtEpqw+anLY3sPg0gBZw8tVXy?=
 =?us-ascii?Q?ETQ20icEBivgZgH/1XdZ3a26Njq2+upj9JWF7+NmwCvBFYaUrOdvYlmS+Dwq?=
 =?us-ascii?Q?OkwZtLwUNz2D3rQlS3ORQyF2liHJskhQwKZaQASi2iRy2iIyOkuEGt87Vsta?=
 =?us-ascii?Q?/bByozclDe6sZHTnoAlo/F6xRDlJKt2n7DUeUSQb88/HBJ46e9OMiQVReUgC?=
 =?us-ascii?Q?RdKMcqihwW+pH7xxy5nBu89+XFRi9ritRI5QHXjnwJ8CQKkWc0Vch143Bdeh?=
 =?us-ascii?Q?jVrkK9UcWPY7Wfri5zssljgC0UTQrOddzjWGoFsQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383ceaa4-5346-4b6e-c19e-08db29e70546
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 08:34:00.2327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: usfMItCRS+M7NItF/J3GQl3UbMdTWryY3/pTGo7E7oi+SAQq5kYvc8ZZPLQC3TUz3XCPvQN0apWP1249IXbPEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7318
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 21, 2023 2:01 AM
>=20
> On Mon, Mar 20, 2023 at 09:12:06AM -0700, Nicolin Chen wrote:
> > On Mon, Mar 20, 2023 at 09:59:23AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Mar 17, 2023 at 09:41:34AM +0000, Tian, Kevin wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Saturday, March 11, 2023 12:20 AM
> > > > >
> > > > > What I'm broadly thinking is if we have to make the infrastructur=
e for
> > > > > VCMDQ HW accelerated invalidation then it is not a big step to al=
so
> > > > > have the kernel SW path use the same infrastructure just with a C=
PU
> > > > > wake up instead of a MMIO poke.
> > > > >
> > > > > Ie we have a SW version of VCMDQ to speed up SMMUv3 cases
> without HW
> > > > > support.
> > > > >
> > > >
> > > > I thought about this in VT-d context. Looks there are some difficul=
ties.
> > > >
> > > > The most prominent one is that head/tail of the VT-d invalidation
> queue
> > > > are in MMIO registers. Handling it in kernel iommu driver suggests
> > > > reading virtual tail register and updating virtual head register. K=
ind of
> > > > moving some vIOMMU awareness into the kernel which, iirc, is not
> > > > a welcomed model.
> > >
> > > qemu would trap the MMIO and generate an IOCTL with the written head
> > > pointer. It isn't as efficient as having the kernel do the trap, but
> > > does give batching.
> >
> > Rephrasing that to put into a design: the IOCTL would pass a
> > user pointer to the queue, the size of the queue, then a head
> > pointer and a tail pointer? Then the kernel reads out all the
> > commands between the head and the tail and handles all those
> > invalidation commands only?
>=20
> Yes, that is one possible design
>=20

If we cannot have the short path in the kernel then I'm not sure the
value of using native format and queue in the uAPI. Batching can
be enabled over any format.

Btw probably a dumb question. The current invalidation IOCTL is
per hwpt. If picking a native format does it suggest making the IOCTL
per iommufd given native format is per IOMMU and could carry
scope bigger than a hwpt.
