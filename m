Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96B16C7A31
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCXIra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCXIr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:47:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC8310D5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679647645; x=1711183645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=opu/Zorni4Qfx6ZHGi4OHuupw7Kk3Lcmc+2pi7aoOMQ=;
  b=S+TVEadgVdYOsrJlPtLZwh4BfNysBLOjEKj5GXoeL5OxGi+daYWebvmk
   qY4oD//uYPJWbBGKfhjXOveLH4e2HAQG93/MncugTjLIJMay/PGbjG8PL
   bGGollPszXat33a/GJBEDT4Sh+kHkVimce2bAeDwNPREzzapRibQy6+vE
   MwtEWUbAp+0V5f+1sELU5SAhpK094l0H/hlfa7lcI9PnPG0UfmGmVJ8Bi
   G5MIDPhTJS9lY0B/emk//oYtOkOmh1XUdMlYxzThhVKxZcy/cSNZa5d7r
   fYARrQ3dxoOW/tbVf4+WbjFfDj42YsiLsZIr1KslZR3Z5ymdEW0+vPcI8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="426001078"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="426001078"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 01:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682610922"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="682610922"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2023 01:47:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 01:47:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 01:47:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 01:47:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGraiAe8JkGZFJpOTlM7Rjs36SwZU6daNur2nu2mTx1N6umllPpGqKre4LK0dE2Vc/m3gOSC0KQiKHj2FG7rWtKPExIzTh7MYE1yWO/yEbd4aZHMqXLjup/sE1FIswlYEr9E7jqGYIh4rX/k1+tkMXR4r/fwg3HqalEZf6KqyiwtFK7esFcBwdZR9FhqoCqMh0lKtvGXyCF1762u9pq2KkWhlOHKBxYon5PrwYuvqx/GSHda1An74Pu4IHOgdMjPBa2PXcsub2rmp8MhZxmWeF7wvDoIIbCfDOO/mqQDbfrVhe8X0/ZJse0coCL0CQtNrrvTiEaUp15f4cAZ9WvWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opu/Zorni4Qfx6ZHGi4OHuupw7Kk3Lcmc+2pi7aoOMQ=;
 b=VdUOQploIFPako9dZv8tqe9RDRxg8R1j2B3DWidRyq2EfnV8PWC/+UEAQLjRaBgjOq/61s3yxOxQikeO049l9TpfrkzPjOBRflzdK/1DFpp4z2dWBRRyCMKWC9Y0eVFKrzyLMw2X345wuKJh+aRAwSQUJWud+9D1hH6nsbyCjLUTvrvKEMtM+1Xw/9V/7agHbQS1+XUpJhOazqshwwEORivXY6GvTohw70VDdJF9dopv2hYGOpcm5klTCBEvMVTd0PZHHQP/Ldvjt8uUAvM9vfRgp9qCN/c/f0HpScuu+99RI+HCKK8P1Tm3LIaZL9frW9fvXdLe3WQ1SWOlOBzn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 08:47:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 08:47:20 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
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
Thread-Index: AQHZUnWe1bQRwtfhAUSI/T7BqHBa167yh7YAgAALsACAANbagIAAyRsAgAqMnjCABPKxgIAANdgAgAAeawCAAPG3IIAAOI6AgAR7m+A=
Date:   Fri, 24 Mar 2023 08:47:20 +0000
Message-ID: <BN9PR11MB527663094F21D3DCF8A3038C8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com> <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia> <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com> <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
In-Reply-To: <ZBmZj2pscX0hx2kQ@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB6045:EE_
x-ms-office365-filtering-correlation-id: 44d714f8-7bb9-4325-245e-08db2c446138
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ls5NTdN27fgOktj7Qay5AkWvk5LZfak8+dOEc1KLRohrLo7IHtwUSmq9AYYKnapdRR3Qgo9sWp//LwW2sHTrqvaN6Urcy5XpksMgYJTHK1TiUXNcyvSe7u5GLMue+mId5UADvq8C2NCD3Cfml7VVw+MugNs5ayPsHwCO9HeAjj2q/oXEDdRyl3Qn3WmvMIXckIEagrRuou1vPpaiMaXX2TCj/kAQtXTMOV1Jq7vYelnmCKatdwxTP/Wsl27g2k1msZbvls/HoYok3x4vfnEdeD0WbCWF1r6WltD7vJ1pkMbaWp/3g1M+fuyykDt+vs0oTwZlftw6XV2rcWT+9p/XyrSCfMtY8FyO8U0jfvQ+WNYv7Rj49DYtGpB3CqMZnXPrUKnFjK9D+qY/Eu/ZjTyM3MHEoDdANipXoezA9G9KI3g7Zxqmm4PsYLn6M8CjOccRlNmQyMUtwHvOER9MU7od5I54+rYqk1HjQcHxblj3OySkSYhkMED+mjypxBJ6E8SU2AXaIWf8zjHAwwwgBOb9NQVqVX/FpZaRtt8fPvjg51aPvJEGYVoan+e2aGmv372K333mUk1mpbGkmE7i46pvD9QxOV4OyKTfA00/He6FY7oxqxbBYwrLXsr3813pHHluZ6s5dlyTzhXugBN//5gSGH+p2JhNBy4E1CZDwaRLhZj6gHRceHapVejBpliMf2ybnx0wo+PKPLFLWn9kFdwyZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199018)(6506007)(26005)(186003)(9686003)(38070700005)(82960400001)(83380400001)(122000001)(55016003)(38100700002)(478600001)(41300700001)(7696005)(71200400001)(86362001)(52536014)(8936002)(5660300002)(7416002)(8676002)(6916009)(4326008)(316002)(66556008)(76116006)(66946007)(66476007)(66446008)(64756008)(54906003)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SghgwJweMMVkbfWVZkdrIrqk6TDANxaVnYXvT63DeV2StPY2EcrSmB4uQzns?=
 =?us-ascii?Q?otVdOEdHAFTlB7/uqTgAYfjSGIUYS5XdqBM+fm9SoSlAOivM+Sfi/99sNupC?=
 =?us-ascii?Q?c39rkyShsD5g+PqsoegbwM2Jmdd764lNSmZMypvf0wj2n5c5mZpmTX0rnqgr?=
 =?us-ascii?Q?u9iMh3RNIUzmu04M7tmyaAGUew9Hv05AGKWmqwjxJV1pUHiZHwOgKwijF2ds?=
 =?us-ascii?Q?UkSjksf85rreDKo/ZceK6BC25zwXeUKXMczOyOP/mO4fWXPSrt2cpwUYXtlC?=
 =?us-ascii?Q?3RIW8HjOOOJ9y8dwiVgPVjipvgAnOGBReG+/jod4lw0FK+miQqlrBXeMF3Tw?=
 =?us-ascii?Q?772zp/2T8GUtc9k0Kkpr6bf+wXL31KjvDPWRAbxRlpVoHIAPZBAYqvx5bnbW?=
 =?us-ascii?Q?BwBK173WRzsrHX31ZLjA3faEN6bGyHz0hNqYxnZm9vegjJYryy9PkK1odltp?=
 =?us-ascii?Q?lQEVWrdStlh+R4GqyKC0PHJ2pUPMNON/L91jLCRgAwcg+TtA1oX8KKnTswYi?=
 =?us-ascii?Q?K9lozZdAAwv/LX9sCVlEEApBptbRvcxnKQNSbPAwDTlkED+r1T+SVMCdKhR+?=
 =?us-ascii?Q?1okeeGZPjAG9JDz4fLtdzbqGJSYx/XotUm9hIm4zK+a5aHpdgcghJeoF4r6W?=
 =?us-ascii?Q?SlpvtvrXUmBZ3bLPZ046chEKf3aXsJ4bOR1W4tke5FOpHG6nGqH6dY6fIOhJ?=
 =?us-ascii?Q?QalkFKLICvsOshiV2Up3cX8wHYl7lsd1zdIh+v7SJpvmpvbowHkhgIBUDkpP?=
 =?us-ascii?Q?Q6LEi7EIpVoSn1ZeGR3551uOLJQgD+ZXLyLx63Y6A4dXgAiV0i3bzfoW55l5?=
 =?us-ascii?Q?qyTNFDelW7wX2VevNT6d/xuHhtA5vn556cbSQOdmA+4d3IRklmWnv/cDVfOP?=
 =?us-ascii?Q?OJ4XoHAzVphlSWcq+0C+vSDrvTZbMxpKkJJqedyqa4Ig1153Jn2BMjUv8Kl7?=
 =?us-ascii?Q?ppsHHvumYXtVt7Ab+fVXJA291nSj/CCPdRYT6JhrnDhT+xDIo58jObGYUFe2?=
 =?us-ascii?Q?OiQxsRL85IT0hmhuUbMTYIDQI9GKMgTqCVDtuOm/huHAMuHraeJiY34IxVmy?=
 =?us-ascii?Q?Ju7aMAArnuCiJtg0exzEd5gyhuWJRUQlTnUt4Lef8r1I5Ffo+NR0AEMUHppD?=
 =?us-ascii?Q?ocC7vqP7Gz1BMLKf3a22JKljAf9DlkmvQhKLXEJaZUBUAUYyA+07iy5bs9j9?=
 =?us-ascii?Q?My/QoYtHuzZEbjbkdUGNmYDA5QB8KviAh5vyhv20pQ6KnwCJFnfzjP0+UWws?=
 =?us-ascii?Q?VgPR6MAvjLGGoBbeMWSE2KltTPEG9yVGEfAysy6+vojpv5Q/OEj/zljQ98b0?=
 =?us-ascii?Q?hknBK1YF5Je99PZ2SoZguGlAYJwEsprayW/hxW9VUQvGnGB3Swes/YBFzFhy?=
 =?us-ascii?Q?Vpu2lXBO5Df+JL0Y/A0c7nSIdYKf9QJGzwc5Ourngx/M4v4U8DI6Ga7J1NRD?=
 =?us-ascii?Q?RIQrMUX2QNqXRSESK+2XLq/70FFGtSiBRzp5QnBHbzwAtIW2XAUWqgAS6FRM?=
 =?us-ascii?Q?c20GNaV37ovtzMMt9c3LLCr1z2zY5R2nRZGCugF8LSeosGwum1TXy1wlCSeY?=
 =?us-ascii?Q?YfZPN3PbyGAIbwPzm3JI99keM4pkVHf6j65g329w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d714f8-7bb9-4325-245e-08db2c446138
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 08:47:20.2899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWplkz2VmNBCQzvrL8vK0dc3/6O/XlxxX1JGRPG/21HaBRV8MSZrXo94UURh0KXAK5odmZdF/H2CWWGNPC1GLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6045
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 21, 2023 7:49 PM
>=20
> On Tue, Mar 21, 2023 at 08:34:00AM +0000, Tian, Kevin wrote:
>=20
> > > > Rephrasing that to put into a design: the IOCTL would pass a
> > > > user pointer to the queue, the size of the queue, then a head
> > > > pointer and a tail pointer? Then the kernel reads out all the
> > > > commands between the head and the tail and handles all those
> > > > invalidation commands only?
> > >
> > > Yes, that is one possible design
> >
> > If we cannot have the short path in the kernel then I'm not sure the
> > value of using native format and queue in the uAPI. Batching can
> > be enabled over any format.
>=20
> SMMUv3 will have a hardware short path where the HW itself runs the
> VM's command queue and does this logic.
>=20
> So I like the symmetry of the SW path being close to that.
>=20

Out of curiosity. VCMDQ is per SMMU. Does it imply that Qemu needs
to create multiple vSMMU instances if devices assigned to it are behind
different physical SMMUs (plus one instance specific for emulated
devices), to match VCMDQ with a specific device?

btw is VCMDQ in standard SMMU spec or a NVIDIA specific extension?
If the latter does it require extra changes in guest smmu driver?

The symmetry of the SW path has another merit beyond performance.
It allows live migration falling back to the sw short-path with not-so-bad
overhead when the dest machine cannot afford the same number of
VCMDQ's as the src.

But still the main open for in-kernel short-path is what would be the
framework to move part of vIOMMU emulation into the kernel. If this
can be done cleanly then it's better than vhost-iommu which lacks
behind significantly regarding to advanced features. But if it cannot
be done cleanly leaving each vendor move random emulation logic
into the kernel then vhost-iommu sounds more friendly to the kernel
 though lots of work remains to fill the feature gap.
