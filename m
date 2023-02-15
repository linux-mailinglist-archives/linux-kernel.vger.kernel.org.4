Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5A6974E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjBOD1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBOD1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:27:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E47212B1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 19:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676431640; x=1707967640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oKVJu/pnGT2iyw4vjaEX++fxNi8p+cDokOynOdxaXyQ=;
  b=Dch0JbSbJ7A1G6yXCBpvll1FNOY8pR5sbPWjc9HpVaGy+JA/7mMXy/FC
   TSoovLkVxDqUJ7bPeiykbkv1DUxpWQEioVJTj00NLmwveKGHmu/5pRRKW
   5v/OdavOJ8iUnl37CsqEY4MtsMNcTbmSawAwuZbGKvkmwuIC8uyihevs1
   nZAZ+dW6scm0/UsotedNTU+zBIOmgEO7UgE7wjfvmVPizxwhe+HgfomqA
   2NjBzBSRlGkFG22jS8mU48q1MKyM2Y3ZiA7ootOUwbKVDtO3klq+fsnIa
   uEM0dR0jrfJF1IhaZW+Q5waMebegliegKOAd/4hsV2dvhZZ8BpO07GPCP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="310966196"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="310966196"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 19:27:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="699794570"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="699794570"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2023 19:27:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 19:27:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 19:27:19 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 19:27:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKn251vyuFI2FkIAn5B4LBRQ2+Z7fdVhlOOlQ0OSec+nZ7BOQCWd6Voegy7VsH5fgXH+ZZhwMJJcC6zhsiz4sYPjh/Cs+EEDRQoTYi9zVWjx8xP/SVRhq8ccNgGd3mKS6YXQ7jDqeDz1XQRs23T5ho69eoooMtjpExPJza36U8nfFVbDb/rYZcGryUAN5e8zs5MaNrAhwoIdL1PF056b0anJWvtyNyQcHPkVGlYh+dJKWLgm9e06AZGobXbH29/GUqzFPzstZAONOC2U9tLrCk6VgIXAOW7SPSJ7wr4CqCi1q/VsvLZsXmSi0wCQ5i0C6MBSSjEYiBnDBfPI+7XLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BccYb1Y0ug6FUUD97jVxf2mIvdI1buRV1WTbbcL4M6g=;
 b=SFzpD59CBflskY7ICgqKi9oN/+S4bkUrhyfvS2WMTdpj2D6OZtSqn3eYuhNI8AEnCEMQtzIgb1ltxmA+B09/ut+onti0WBvnH9u1OfqaukIR06cf895oQqpMeyByJKVVwQcmXGs/YJNOtOUL8aGvMcL1Orq/3seVP4Y0/UtQtHNoX3EeMuw+cZyVlvSAiY4Z84+rut4eSpXXy1SatLf9xJJzbw1ZtK+3xeLMUmtJe+VeXzl45ErcRcbxa2gGVsOVZ+5MsKv4vP2XrqBx2CU99cgGn/bzBjKYVdRAUOF61wcWuaFIfNehiwlAt8pbL7R0hUOTIa8ddZOd/FNtfZEwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Wed, 15 Feb
 2023 03:27:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 03:27:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 3/3] iommu: Remove ioasid infrastructure
Thread-Topic: [PATCH v2 3/3] iommu: Remove ioasid infrastructure
Thread-Index: AQHZQD9B3e6OiPlebUaHHKPShCMSFq7OLgmAgAB+ToCAAK2UQA==
Date:   Wed, 15 Feb 2023 03:27:12 +0000
Message-ID: <BN9PR11MB5276F0D583CE7365A088AFB28CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
        <20230214064414.1038058-4-jacob.jun.pan@linux.intel.com>
        <Y+tVMRzRQbcc7Guz@myrica> <20230214090437.5991644b@jacob-builder>
In-Reply-To: <20230214090437.5991644b@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6375:EE_
x-ms-office365-filtering-correlation-id: 91350f43-238e-45cd-a277-08db0f048727
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TfesuITIHQ3/CAaiOz2UOuKDqnuQWwUvRGRULxkqOeLnKDBC1xM6xluXjIayUsIN8MuFQdHpDLVEl1bIhVcvN0kpNuvqhgq/LpYEZwLjbG/+y7Z1X2Rodq/7GuZhNYqYQEYajT9dVFpPLjmykniVyGfsFgAliUZe6XoZP42po84/GPd4VNtOjcoA1kXyNsh8g9Zim6HPJRlp7RADASs0fXnZNuyiJJqTjXdjiAiE2NaeIAcVhS5rBc7JmW2lQ7BwcS5HGB36XZ7WIPDnRgZaX+dhroQ0X6vGeeD5/xmaPCUvil23cBcNTBy7E4pfcVpY0HaAaafL1Yr/ZRTSH7C+vXUa2CGRLBgWlwsCdGcC20smoRgFPu79Nk42hfkj1mfVZWyu+uwUXwOptFxFyzJ19tQpUAKktr5rb9hiD4oQ5rNp3okG/YOE0/6odgVj9KKZdxn5THw2NEIukRBT0TOEizxbBs2QUNmnjmKazQA9sKcROkWSB9AxgdRggLCROa9oWMaF0mNtHvQ24xVEipu010FAXks5w1OLJeNNbhMLRNYPJ1dMLY+a2E12o7eHNwcWNoFayxWxzL3XU4QmwZ7eFtG5vSibqnP9TOCS8OHHIgNgf+mFLD0J98YGWqe0x9uWo+2UUyJhjWqNkokppuQY5tOrb9HS45gcZELBbhtwE2KJVI2JCkgcjmmOykrK411dq4SJVx93BQs9g9K4bRRt+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(7696005)(478600001)(71200400001)(86362001)(6506007)(110136005)(316002)(54906003)(9686003)(33656002)(66476007)(66556008)(66946007)(76116006)(64756008)(8676002)(4326008)(66446008)(38070700005)(26005)(186003)(2906002)(55016003)(8936002)(41300700001)(52536014)(4744005)(5660300002)(7416002)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?De58zQASYZtt8OmF7sEU+k3Rt0mWmjaqvpe1cK1OrXY6oNIhYczf0k/w50oI?=
 =?us-ascii?Q?g3WZiDQcl9grMzsaP6UlGgITxk4cJpMbDGZ9hY5GZ3UDDchSIQ4KhNtI8hWK?=
 =?us-ascii?Q?uBzj1bQ3AF1ymStx8o4fSEGbtS/oSBzlaab54R3TZjmMZk3L+JdHVbn20Qaa?=
 =?us-ascii?Q?5+fVXKmmWqrKI9BrvEBsdehAsXINQDW5nK/aCnBupYSsKjxO2Vw31G2zbOz/?=
 =?us-ascii?Q?2YhfJ2htqfdmFtGMWdlp3NTVz2sTug2nuWVAuo2QUXFmStyM1lLZxW9GZOj8?=
 =?us-ascii?Q?T5HwXSanaJSBzwFcjuvgP9Ohh7e1BbPRo6NgBmOkODdyR+FoXkfNtI2A2cT6?=
 =?us-ascii?Q?eQxb00cpvCakeL5E4Wiy6kknb7Wt3j7G0Vzn6sZ+CexQystB4NqtY4Phossa?=
 =?us-ascii?Q?YKLxnCx995XH1/04SJIeo5OEWcgSoirsIYJfdzxNfF+Nxt6mGOYg/xo5jXqq?=
 =?us-ascii?Q?yPoW6Zrle96i/yoUuJ2qG5559vDDUwiK5Op2y4zu0sHMTWhIuaibxd3gWzU7?=
 =?us-ascii?Q?dG2DCm+G4AMiFYaOY0TJSZkTZgJEaMKRki8NWWdYmnILiVgKJzPpbT1hkmLo?=
 =?us-ascii?Q?01Y2nmlGB2JynXq1Sgtoo0qmsJxB7tlD59CbZ82QrWORkl3Vfg/yk48I9bx4?=
 =?us-ascii?Q?+RulR+9QN52q+AVD4a1lkIbA63R4W/IdyNCwd1qWzOO22/+D/hh0IgM6gP4n?=
 =?us-ascii?Q?+/6jcuJxFsnSE9mNZyzOUlrFyTieosYi/ZJ8l4Hjt/YyqmBsMM6tIwvl0IpP?=
 =?us-ascii?Q?Lxu6gKPS6DPU4v7DeImT0LhJgFn1ot6b2fW/AUcPLeItrs4jXUFq2DDUyNht?=
 =?us-ascii?Q?Gt9bSjH/AyA2gV5Qbe0Dma7PMQA4330+MRl7PBWriypss+QimXz+baTzsjtQ?=
 =?us-ascii?Q?2Oij9pEQx/4CglupH+P8XE1oG7yw7Mbl5M1okKXDiKIbzATZDQRXBMkhB3WA?=
 =?us-ascii?Q?qtnPVj5JqMdAPaNKm41fUkhhJd4uRCX1Up9r9KEdmKJaxM4Sa5WN7XadZQJp?=
 =?us-ascii?Q?Jr81+WtA3KdYMMm741SNyrr1q7skcgvqC4xGranpRrNr1LCW6A20qH+q0nNT?=
 =?us-ascii?Q?hawRqIgnVpbnACkWEcwFzkg2gXeMljxEYnWyK98OQaYXKfeeEj+d/SSFrC5x?=
 =?us-ascii?Q?I9LO+uUY0ovrt7ald7wKbb9r07W98tF4sLCqinqpEFdzlbzNJl7xia0ulmz+?=
 =?us-ascii?Q?kcFhn3OLyKNb/X6CpYFEN6RY6wqylF52Onsl0THAU4AoXVmP+Tw54B2ozSxI?=
 =?us-ascii?Q?lZmssOktpyujHXEvb9BOfTkGTGpylps1vIF7GFPTYyK2Hz+9CHkjqYbtioDb?=
 =?us-ascii?Q?9SE76Ys19rDVSkg3S8S65M2UnTeqVQvY21KYRB8u5o3d95xbQsofuVfeHUIh?=
 =?us-ascii?Q?PPxSzOSBBlRF2zxZnjS7lXKrl/YTO5DFrtdSwlrnHnb9GeZuQdrfInu+xY21?=
 =?us-ascii?Q?lDHol5EfjsatOqrOtdJsNsBliGqeLsIXb/rPk33EnBEG4ikaj3IuNMObHRwX?=
 =?us-ascii?Q?p5ir9zde9g3BIOt6jJF5um629C2qM8YMOrZ7ZalHaHnyMpOoRnxpjUa//X/w?=
 =?us-ascii?Q?1QQBqURLjm6WjFqhtoGTZsuL7pnpixcOLugZmRSC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91350f43-238e-45cd-a277-08db0f048727
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 03:27:12.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZvbvdxubmgbH8Afmo/J+WjRbwalA02xU3WybKkGtvdm/eLqAMulkth7jSHOMhW6RKEf7426Xt1tWjIeWObD8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6375
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Wednesday, February 15, 2023 1:05 AM
>=20
> Hi Jean-Philippe,
>=20
> On Tue, 14 Feb 2023 09:32:33 +0000, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
>=20
> > On Mon, Feb 13, 2023 at 10:44:14PM -0800, Jacob Pan wrote:
> > > +typedef unsigned int ioasid_t;
> > > +#ifdef CONFIG_IOMMU_SVA
> > > +static inline bool pasid_valid(ioasid_t ioasid)
> > > +{
> > > +	return ioasid !=3D IOMMU_PASID_INVALID;
> > > +}
> > > +#endif
> >
> > This isn't specific to SVA, doesn't need an ifdef
> >
> until DMA API PASID support is in, this is SVA only? at least on x86?
>=20

the name is pretty generic and it doesn't need SVA specific logic.
