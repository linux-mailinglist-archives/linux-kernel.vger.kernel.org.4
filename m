Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7A74E28C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGKA1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGKA1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:27:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5901A7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689035241; x=1720571241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PuHRSXJCgvDLfSm46/MOLDSj3hw4oShnpS3BpwWNSHM=;
  b=bShr5/dZdxpNxcbYK9YjaJWzr0t7NqCKPBNAjNqEeyvbNTxQXUtjKSkO
   erEgg1Lh4NGO88dbJ17dcYWPnbG4LFfl7STZiwQhxdWTHR/SlmEAnl6nX
   52LsGgBbcPskKhhRwjZ7Oz7EqDJnem6brVRSTNoJsZzDZ81nR+K4jh42R
   bp3e76mvKqgoJLhqiZH8VrLZsUMAng1DNQCCI4xAFoj347H67gaki80yx
   MjtORuAgVRZ1I6vFY4Y8doB121KPSjUArP7gVGTh1KwGhGnfg38YTCtML
   Z+TkLW/TuodmT+mR73lZhtqtPzLuiRb1g8Br/4esn7F5W31sHy7dBwNY0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="430574581"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="430574581"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 17:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="845067992"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="845067992"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2023 17:27:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 17:26:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 17:26:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 17:26:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6eGiZ2mjxuNVjcwAfkZ8uFdVbC54btA46R1j9VTRH4LXcw3bHoQoV8Qs0ub5mzfzlKO64JMQY5yh1m6vFBIVM1hNKBGipZcv6qH3x9/Rxp9NWVjc7G0FDf0hia0KmlpGOk4X3auo5xKGVp0sG80ObyroiIVh1qfu1yUSZXRHDHWZ/lVB50rC93H0ntKWRfaJQG5b4cqDGO4ZCHX/mazWYFfwdV0jnTcViaDAHNElEdkMTqIVkLJzssqboczDFD9oD1y67M//+BLX73LmqyX6tLCcNsADctyZlxhQazWWtDrZowKn/Yqv9ZohJ8gHuLW96xkXK1qRRKocsqajECvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuHRSXJCgvDLfSm46/MOLDSj3hw4oShnpS3BpwWNSHM=;
 b=aMYvCI25lSZJw8NfvkyvSPrNcho6liBOAKEpBml3pG1QhWHk6y8R53y+u5X0FRwAiN78t7Es6C+VWWGbvzzWoOh5jTm0yszSbshKM3MO9UrxpORzfWsL0e9QNRjDxZ9lL34q4v0v+AFiG6UjNfGRxu3nIdEeM0qoJ8telDNYmp3gT8kJyLuIlg40NKZs+9PtDW6cwNVRQxxsMJTcJim3EHrX4J2noYAnin5T7iR7ldudABLlR4TykTEi+apbQo2EvCr7kJT7vsZ8od6fMflALjLWH2Ju3FBGZkbtmmhKLXIU2xG1mZkmHPrsNnOO2fcJl1JOD/hVz3lukX+xSSOZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SA2PR11MB5116.namprd11.prod.outlook.com (2603:10b6:806:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 00:26:57 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::d462:72a2:39da:5ac7]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::d462:72a2:39da:5ac7%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 00:26:56 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Michael Shavit <mshavit@google.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Thread-Topic: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Thread-Index: AQHZmHAAx5RbbLZUakKJUTzXs8dX169+AmQAgAAYP4CAASOlgIAr2NewgAhWl4CAAG5csA==
Date:   Tue, 11 Jul 2023 00:26:56 +0000
Message-ID: <MW5PR11MB58818828160F5AA41756D45A8931A@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com> <ZH9oQMmI8CezMCnx@nvidia.com>
 <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
 <MW5PR11MB588179952AEDB50D9259549C892FA@MW5PR11MB5881.namprd11.prod.outlook.com>
 <ZKw38RrJ0FG8zbqt@nvidia.com>
In-Reply-To: <ZKw38RrJ0FG8zbqt@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SA2PR11MB5116:EE_
x-ms-office365-filtering-correlation-id: 4df0d9bb-7525-452b-2e05-08db81a588ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TcOkxDzOC7HBV52UBHCxKmie2biPSPipt/+7VC8fyFmAAodd4VnKc7HXf/xAZoYiA6N3XxASwsPc+SbzD7EeRqsWvlXMIlouRkX41au2dG3kMshQu1wu5e3flPjRPBGuiFDEG9JyrZnlkNju86YAEH8meyX9nxp/7vNVfIjz2Z0te9LUg1uo58kQ3R5es7Ch+leXsU5lRZUX2Z3Vdx1UDAQt9qg2Whz3aTN3AWSjf9RRubRV/YWGaSD8vV1kkKeMHwCee0ugkABhI3mvkyGBA2WAIm/eIbmTqr8N5FoBH5Pl4DzSD+u2psfFxqrhwN+bliI6FTGIFDY9+tXBsupeTxUuCIBxy+uRW/xDqYvKKTjRVxZ8rf/nWH13QZilbzBOyNR5tZN1xe+v2xQpDSyE/KnAZf+fNxanKlfhVGXLMfchWFhPtgGcTqvYEoxU8rduyng37sQ4q871x2N06o+JA/CS1iBoniur8dOsaNI7D66cn4RAVgmVYhOzroFEvbjVMBJ+CcujjuQuHayHnFv6pcrIfZWq8+wYiJ0joosC6ODMgFGSPS2enLYSCd1lFxoAj2dFGlbG8AfF5oxI6KCXxLmBrZ4vQyoIl1PkcmtOgDs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(33656002)(122000001)(82960400001)(38100700002)(86362001)(38070700005)(9686003)(55016003)(8936002)(41300700001)(5660300002)(186003)(52536014)(53546011)(7416002)(26005)(6506007)(8676002)(966005)(2906002)(83380400001)(54906003)(316002)(478600001)(71200400001)(76116006)(66556008)(4326008)(66946007)(66476007)(7696005)(64756008)(66446008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PAw88NvYfxJaJvVfO49McvF3VhBv8z1df4AHrIpvOnuJZ2Ht33JFDKWmcwRh?=
 =?us-ascii?Q?gg9Vph3HVeIJFR4Ulqz3v3uRyfNU/bGo6m7Rq1P76DVrDE+b72PgYdgYauKJ?=
 =?us-ascii?Q?cPxzWP0TInM4/CQ/fCvU4jabv2tZsCKqwC5OQNaTnC+S3us2OtSqMjIvxr4Q?=
 =?us-ascii?Q?2T8h7zd2PDcyWl/rqj6y5CzQ/mQc3stIZr6jJsf1Lkx7ho+C2zHhfYtLf3W3?=
 =?us-ascii?Q?ONvjj1Cn5siHrijRB46Pn4gvxczFSK21CTNBhHAZjCNjjfVEt/lvzuRh9vdE?=
 =?us-ascii?Q?Wi/CEpSWWqGltzKZik5/6z/+2j+Ua+PROpxxuKPs6yKXAJ7U44jh1T0g0C4h?=
 =?us-ascii?Q?hrhZKd2kaG3iPhwKSawMfQQosvG/SOAHKUCY+pRrX7eGSsSzmItr/S6apY+p?=
 =?us-ascii?Q?RxfjhabixHywfIkb8Aa70bE4z5uMw4AO9y1g0myD/ZXO4BOLptgcGiiUtSm6?=
 =?us-ascii?Q?3OMI+QiA83R9wR3bY7xWcRKhG3EJJ6esoQ4kfiqZbntoujH4xwzWL6/qqvCK?=
 =?us-ascii?Q?EZOVoDdxfnUXE0i1yNKDU/LniI8CCOmEiGmAMOXasAxTcbsYp9w3JvA4e4tg?=
 =?us-ascii?Q?vZN/4r2VU5ynqe4AsXtI7ro8YBwbABlwmT3IJVhWcU9crAXsFON/5paQAr64?=
 =?us-ascii?Q?H903RLmHlowZlCgzedFowjkTDXnJpJvk8/PHVu6ow2llHVSB65MDrUGJoWOr?=
 =?us-ascii?Q?GtUC8TkfDSY+PBsDsAmMFPWrxuskdPeP9sXUXS6taoQKKB3f5jjkY6niGiLN?=
 =?us-ascii?Q?NAP8iZVwu/+8vQHpxALYNCH8ApRii2pl/6NA/2UF1VOsauFEFivOrgTfXAWY?=
 =?us-ascii?Q?1cIm5sQUGz7cuaqFIVXdOFxUKTL1dyxLICGgNpSO5hClrVhyhuxNlh1ORCga?=
 =?us-ascii?Q?s9CAy6zUklTNpg3tNr4hXm7cibwjo3uyhf4TXbCOivF9VsrEQJncPbNXJ9RQ?=
 =?us-ascii?Q?ldosPtdmzzO7+/02udtKZ8M/Rr4Xvvl7UmnOncgjyIfIdpbDL/am3SmsRkyv?=
 =?us-ascii?Q?egUYFjW+VxCcPWaVygO8iW1JDky7msjOXwBpLQxYsx7FVJOIVvUpHMLV/2k6?=
 =?us-ascii?Q?EgmWcXnm+vKPQSO9qpor1cxPTLMf1i4+p3N7FO8yLWk+kbad3tdFM1hhuCsN?=
 =?us-ascii?Q?EPcXQ2XxcZhaUqtrr5hX4J0jUnfyLqwfYUXiYz5jz9zvgfEp1YocTQB+6vDK?=
 =?us-ascii?Q?WxXyiVvlFiCsW5GaOJcLcWWMG3UzTsljVhnSpWiIm0lglixbn99yFjO2iLhs?=
 =?us-ascii?Q?c3LlcbovmlTaWYtaBIWIEuZKY/dJ7bqVn1lrhKdRWaeLifrwlK5CypiD0jf6?=
 =?us-ascii?Q?wIaPjPRctKAfyqswJxQ54QF/0JXrbLU3FHIIlP7SbPX2p+6Yma8rCLo/MG2a?=
 =?us-ascii?Q?2Yxeu58FeAJ0dp5PCldF+kmSCBdp5Ijf/ygQw7Oyz72sPMLcoQ9uSRtImE/x?=
 =?us-ascii?Q?KZK4qbFKcdlDMzGi0hfqrknqwziNxd+baW+Ln4B+wyYQ2C6oP8PPN/PHwr0O?=
 =?us-ascii?Q?2H8JJZKKqkWT1uh5h6dlHO9eg92zzvXNq1hCJjC0+i+VpHy3S9/S9KIlsEX5?=
 =?us-ascii?Q?+fRvtcj/wLRdd2VlwjCQwDOIw0j5R0dOXFcXlzuY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df0d9bb-7525-452b-2e05-08db81a588ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 00:26:56.5194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtP23EmXb8KGARzKo6uCsFthG054bLnnrOhPAzB0DjbEQKG+EpZMKkkE4I7s5Y5NSti+y8tx/NNYie1FuuAOuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5116
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, July 11, 2023 12:55 AM
> To: Zhang, Tina <tina.zhang@intel.com>
> Cc: Michael Shavit <mshavit@google.com>; Will Deacon <will@kernel.org>;
> Robin Murphy <robin.murphy@arm.com>; Joerg Roedel <joro@8bytes.org>;
> jean-philippe@linaro.org; nicolinc@nvidia.com; baolu.lu@linux.intel.com;
> linux-arm-kernel@lists.infradead.org; iommu@lists.linux.dev; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with
> shared CDs
>=20
> On Wed, Jul 05, 2023 at 09:56:50AM +0000, Zhang, Tina wrote:
>=20
> > > Possibly what we should do is conver the u32 pasid in the mm_struct
> > > to a struct iommu_mm_data * and put alot more stuff in there. eg a
> > > linked list of all SVA domains.
>=20
> > If we are going to have 1:1 between SVA domain and pasid, why we need
> > a linked list of all SVA domains? Would a SVA domain pointer be
> > enough?
>=20
> Kevin asked this, we can't assume that a single SVA domain is going to wo=
rk in
> a multi-iommu-driver system, which we are trying to enable at the core le=
vel..
>=20
> > I've got a patch-set which takes this suggestion to add an
> > iommu_mm_data struct field to mm_struct. I'll send it out for review
> > soon. The motivation of that patch-set is to let the
> > invalidate_range() callback use the SVA domain referenced by
> > mm->iommu_mm_data->sva_domain to do per-iommu IOTLB invalidation.
>=20
> Huh?
>=20
> You are supposed to put the struct mmu_notifier inside the sva_domain
> struct and use container_of().
No. Just want to use iommu_mm to replace the old pasid field.
https://lore.kernel.org/linux-iommu/20230707013441.365583-5-tina.zhang@inte=
l.com/

The motivation is mainly to for performance optimization for vIOMMU, though=
 it could also benefit native world.

Currently, in invalidate_range() callback implemented by VT-d driver, due t=
o lacking sva_domain knowledge (i.e., intel_invalidate_range() doesn't know=
 which IOMMUs' IOTLB should be invalidated), intel_invalidate_range() just =
performs IOMMU IOTLB per device and that leads to superfluous IOTLB invalid=
ations. For example, if there are two devices physically behind an IOMMU an=
d those two devices are used by one user space application, it means in eac=
h invalidate_range() callback, two IOTLB and two device-IOTLB invalidations=
 would be performed, instead of one IOTLB plus two device-TLB invalidations=
 (i.e., one IOTLB invalidation is redundant). Things will become worse in a=
 virtualized environment, especially with one vIOMMU exposed to guest, as i=
nvoking IOTLB is much more expensive than doing it in native and conceptual=
ly there could be more devices behind a vIOMMU that means more superfluous =
IOTLB invalidations.

So, we want to add sva_domain related info to mm to remove the superfluous =
IOTLB invalidations.

Thanks,
-Tina

>=20
> This is another reason why I'd prefer we de-duplicate SVA domains at the
> core code level as duplicitive notifiers are expensive..
>=20
> Please don't add stuff to the mm just for this reason.
>=20
> Jason
