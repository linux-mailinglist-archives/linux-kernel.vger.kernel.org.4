Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134AD6C8D9C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCYLvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYLvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:51:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A07814E8C;
        Sat, 25 Mar 2023 04:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679745100; x=1711281100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A56cEH0/xC+wD+YPK8KnpT+/yhJSUUm4NH/2drKtDOc=;
  b=gJ5y8lZJHHPa85USoDOvvA7yd0PyCYz0rdBvGmas81wYPJprlWj/xFue
   fSIrxxNpVlFYwSam7cOMs2gaAdtGA0mGEENthSVd5kWwzrYxygW1ubizB
   wOYrhu7hViYKQQJKQgcWVwbHo8Ltilze3TxAihKlBH4JwLD7p34TjTiwm
   dXmH81xOqe3581OU6MP6zeR4swPjlMgdw9HDD9TsxpDyHGBOj7k7vpGDK
   FoiLUCAP5eyYGKWZ/Isb8QLcs4BOtL9C3muB1d2yqEbnj9MRoUHlhL/2M
   XXo/5WwH18+87PhdFay/qD1L6eE1Cbpw8PT2LFIGkz6/T4l7CAlQFDZ35
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="328392701"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="328392701"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 04:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="660357328"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="660357328"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 25 Mar 2023 04:51:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 04:51:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sat, 25 Mar 2023 04:51:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sat, 25 Mar 2023 04:51:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+1XokJ9v+21m/dgP+GsR0iXTvHW4/fi/5f+sBZAtKs+uInXicqDEQAld/4pbxEIyFFrvs0FUM0EP2l7pcZYqe1vEVKsVH6ynYBS/RHia4RWWMc67lDSHvS0KHgY2eM/0OowYs4bCnpDEm4d3qZRKGOEdu+BTqYLaNmpBHNKLhqjNui5PnRPdnYXyXZ5ismU1Yzni4pfDXsoF5DltTMEImqaHAJb/f90ETKSsz1fslvinFskNj2FQ3RV5bIfKZtulpeBSEHwVKvmqRapumTOBI/ZpeFki/nRzGQwPDuv4TICYOT0BgQeT1oxqy7OXANfu18vljNNPyX3qs4UbRuJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A56cEH0/xC+wD+YPK8KnpT+/yhJSUUm4NH/2drKtDOc=;
 b=lw6sxDldYoK50BAZnaqxlMyUlwhpGLdngiMVqnu/A70WNrVbbGsKfZ0G4BvaAVWV8TqzqCuIcgE5x0zKdAhFks0GEhkARUGIFylr1kQeMF+VizFFxt8m1LoJt/Ol1xG68OnBvRzeH+PrGmvGfbDMc9Nrv2T74/x4B78vp/fQFksJmKgd5PCl/Y6xyG6kt2HQc9kGJsChRU3aKlzVo5VKtjun2lYV7dYP3Pqoob/MIy0c1/0MLlagDDmXsVmOx+qrY6qR6OXBLrJ67a8WInpjXefDWJ5RhQfCgfhzl2j1ZRVSZCuN55EOah87WwsfKBrm82ilPBpcvxHPuCVMBlMpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by PH0PR11MB4821.namprd11.prod.outlook.com (2603:10b6:510:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sat, 25 Mar
 2023 11:51:36 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::5db6:f849:ad21:108a]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::5db6:f849:ad21:108a%7]) with mapi id 15.20.6178.041; Sat, 25 Mar 2023
 11:51:35 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     "cocci@inria.fr" <cocci@inria.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH resent] mei: Fix exception handling in
 mei_cl_irq_read_msg()
Thread-Topic: [PATCH resent] mei: Fix exception handling in
 mei_cl_irq_read_msg()
Thread-Index: AQHZXv3fKPUgi4Yvm0m/pyOFza0Shq8LYSXQ
Date:   Sat, 25 Mar 2023 11:51:34 +0000
Message-ID: <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
In-Reply-To: <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|PH0PR11MB4821:EE_
x-ms-office365-filtering-correlation-id: c10ae4f0-f1e7-4d2b-36d6-08db2d2748b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tjS5vjlPOxcp8vFyGrYUqQo6SMmEH6Z+t75eNxMZNSXMmZ13B0Cbq3kwb+HcX4V5IZ4bJWXJtvEWeKlskb3g9bf2StaSCIlwZvLhdbcf9QQ5QJsPUNgvJNgD4L7UlmjM7Tk0w/t48Jroie7CQ8EqZ4Vw8DZDzgw/fbp2cE1gPIiyJH+6RAtEzVE9GcaZ7vJI/vn7oujXPyxmir8ruI9u/59LkYbMyl5TkOEEb9y6t2nwRHK+XQdeIAR8Dz/oXC5GyDyrLPXOaj097H3TCg1DSLpqBmO13Ka1FQx+3z/KUv4zYhdHJC9fnmW9eZd0+DGsR7iB1649X6OOTP8QgubwnfDyx7i/uPnBtkngyw/ILrcAA/RPqWmOJE3xkXozdF/6OA54aphomC8MuPrsyY/FNtL/khgzH+ZQ0LALZc18kqskeiwxFAKh7sCzQsWsNlAKDz0UvxZB+uZkKkgnP/5T9TiuSP4TSnWAh82mnu0RmHuWMZmwbbl0AsIrZClLNeIrsgYSOLvHwIwRJz2HD3abLNdv5e7R4s31KZXFgRJJu+ZTZCEncmiN2n+pGOu2KbjMk5Xnl8Vu8M5wxT8lkA1IbNIh5l8UJyO8rFuUz9fqWY4GULqqWtcp4JUwjPOlE8Vn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(41300700001)(66946007)(8676002)(76116006)(66556008)(66446008)(66476007)(64756008)(4326008)(186003)(82960400001)(83380400001)(2906002)(7696005)(71200400001)(5660300002)(122000001)(52536014)(26005)(38100700002)(86362001)(9686003)(6506007)(8936002)(110136005)(38070700005)(316002)(33656002)(55016003)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THJHbkFkYkg5Rkt3L1p4Ny9Md3U1aU0wOTI4Y1RXc0lGRU9rZWgwS05GWllY?=
 =?utf-8?B?VVdpVmtsWk5NRUwraUZPa3dINVNMQ28xWjcvbFlHZmxuTThuWS8xdlMrcWg0?=
 =?utf-8?B?ekZVY1pCNUd6RFBiaXltS0JDSUt6anlJbFV4Z3IycjRhTHQ3Q0hMTE4vK0JI?=
 =?utf-8?B?VTdOR0VkVko0bHN4SGpLNkpMQ3h5L1p2ZENOK1hON3BJb0ROK0JDZmJuVm1F?=
 =?utf-8?B?RzhIRTZBeTlUZFl6QllQVEdZRndLb0VLY25leTlTKytXME8wNnV1RGRpY0lS?=
 =?utf-8?B?VVBaSUtzS2FUSjRyZW1CYlNLNjZMTFBuTHRPRVhtOFlCYjZmWVpIM0lIR2Rt?=
 =?utf-8?B?THNiRGU2UzNRZjFrOXc0L1I1STJ3TG14SStvU2R0RlBwcWRiRkE4Qm9WUmpq?=
 =?utf-8?B?ZjRFaTFTaEJUKzlHM3J0Ui9OdmxaM0NsM2gvczlxK0hsMERKUjlUVnFGSHZI?=
 =?utf-8?B?Uno0OUlUaXdMMlhXU2Zvb0g4dXBmYVB3NERRZjlmdE9VWWNORkxsV2xMY0FF?=
 =?utf-8?B?NElPZlRKc1hRa25JajFKWnVNRVlTR0JLLzhiOTAxMFdMTHRrZlNHN3RMUE1C?=
 =?utf-8?B?U3l3VDBUREphSDhMZTRtU0NsVEpaU2V3eFEzUklnb0YzOTBRaVRBUjM2ajgz?=
 =?utf-8?B?SUhqMGZzU2pIWmNmY2JVTy9HSFlsYTUrL1E4aXdjRnh5NC9UR2Fid2ZwZnBJ?=
 =?utf-8?B?ZUozOG15eHJrb2pzQ0tRUVpKRmU2ZnhwWWU4UGg3TWswdmh6S0NnSEF5U0s0?=
 =?utf-8?B?SncyekhMNnVHMXZSTC9SbFFGWFg3YWgvMWxlL1dvOGgyU2N2djJndnhobWx2?=
 =?utf-8?B?KzdQVEw0citVenVHOVhDRC9BRjlNc1ZjeGdZZUVhbW5hZjRZRmpzRDJzd0tU?=
 =?utf-8?B?V25uQjNsdlVKQWQwakpoa1RYVFJzQTNKaGxHeHlKbVRTWG9kRTZIK0NmWnA3?=
 =?utf-8?B?d3dUNHR4NWV4dkNjNDZpMURqbE41QUpSVlAwbGprbGptTVJ4aWd6a2dFTkJl?=
 =?utf-8?B?TEdnWVFsUWo3WUNNV3gxelFqMjBIN05mRktOM2tIZkdINEJVVHVMb0c2R0ZS?=
 =?utf-8?B?cldyN3p1YkpjVXc1YVp3d0pxUjU1QmEyd1pDZ0hrMDJMTVViZ1BKeVZFRWVk?=
 =?utf-8?B?bmlvUXdYYThNZnhFUGFBem1pRnBhaWNqaVRJbWRWVzFHZDdTWUhoZVREQmZX?=
 =?utf-8?B?YXpOSHJhNDRBSjN6dWJNa1Z4clY0UW1CV0QzdUoxa3dKZWc4cjQ1MzdFOXF2?=
 =?utf-8?B?ZzVzRGNZOS9zbVE5TGhtR0hkb1dUdWZCL0drY2ZUV3UxalIxV2dzWGNLMTYz?=
 =?utf-8?B?Nm1CYWxQOFE1czdLckU3Z0pzK3pKdDJIV1RETko0eGRTREo4QkZZa09tSFdh?=
 =?utf-8?B?RWlXUUd5ZW1CRHpYVE1DVms5aEVQZ0ZjZ2hIYlRid1BkT1BqMlQvUkx1WTNI?=
 =?utf-8?B?VlRaTzYrdXZISEs5eFBSSXhWZDdPcGNqZlhuamhHUUhKcmVyRXUrM2VVaGZT?=
 =?utf-8?B?UnBka0FWV0t0YVBjek4wTEZMaTU2a3JzQzlrN2o1dU1zOG9TY2wxNmhYSE1W?=
 =?utf-8?B?QWlTTmdyS2lVSlN1SXl4cVlYRTRDWFZvWE9jekZ4MDg5N0UxNUozelF4ODJJ?=
 =?utf-8?B?aXp5emFhNkduL2Z3K0tvVUdKK00vRFZTTTFaWk1ySzN4OFdXQVpDL1NsUDdp?=
 =?utf-8?B?SVg3akQzM3VyZlJDWVIyZ1JGdThrd1BDV1Y2dXNTM1NQQ3BIN0VRRkg2Z3pv?=
 =?utf-8?B?eDBPU2RxbVRudjhXTWZkOGZzSml0eFhvTURsZ2FsYS91SzZienNwd0kzVzRl?=
 =?utf-8?B?SGNyZGZQWkY3alVDQys4eDMyWG94Y2tnbmdvTE41aUxwZkRKZTFzVWVqaStV?=
 =?utf-8?B?WGl6WFR1RFJzQmZvb3BnZHQwSGNMeFVtTklNZThab0ROK09wTTl2UTR1OHo4?=
 =?utf-8?B?QUNMWGR2YnFhc0FFZ1M0djE3L2l3SWpnT2RhR2kzNGF1U0hlWWc5K0JpVU1H?=
 =?utf-8?B?YzFHWjBxbHphcVVsdmx6eGJNdGVhRDlUQ2hCazMwQzFxazBRbkV5NkpCTGpG?=
 =?utf-8?B?dFRvRGMwanl0MTNJVzlxSUtIV0xlS3kwejFWNXlTK20xTmxSc2NHSkZoelZv?=
 =?utf-8?Q?I39PTZtTWsttPICzXICXyfhHz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10ae4f0-f1e7-4d2b-36d6-08db2d2748b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2023 11:51:34.9423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qn20mn0xnSrMLU9ZmbRJpDQF/QCPwtPe+kEfRGwGLFd5K0p0yq36PYa1wI3RE6BLHkttskNfTIZHsishLhYfow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4821
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBEYXRlOiBUdWUsIDIxIE1hciAyMDIzIDE4OjExOjEzICswMTAwDQo+IA0KPiBUaGUgbGFiZWwg
4oCcZGlzY2FyZOKAnSB3YXMgdXNlZCB0byBqdW1wIHRvIGFub3RoZXIgcG9pbnRlciBjaGVjayBk
ZXNwaXRlIG9mIHRoZQ0KPiBkZXRhaWwgaW4gdGhlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBmdW5j
dGlvbiDigJxtZWlfY2xfaXJxX3JlYWRfbXNn4oCdDQo+IHRoYXQgaXQgd2FzIGRldGVybWluZWQg
YWxyZWFkeSB0aGF0IGEgY29ycmVzcG9uZGluZyB2YXJpYWJsZSBjb250YWluZWQgYSBudWxsDQo+
IHBvaW50ZXIuDQo+IA0KPiAqIFRodXMgdXNlIGFuIGFkZGl0aW9uYWwgbGFiZWwgaW5zdGVhZC4N
Cj4gDQo+ICogRGVsZXRlIGEgcmVkdW5kYW50IGNoZWNrLg0KPiANCj4gDQo+IFRoaXMgaXNzdWUg
d2FzIGRldGVjdGVkIGJ5IHVzaW5nIHRoZSBDb2NjaW5lbGxlIHNvZnR3YXJlLg0KPiANCj4gRml4
ZXM6IGE4MDhjODBjZGFhODM5MzliMjIwMTc2ZmNkZmZjYTgzODVkODhiYTYgKCJtZWk6IGFkZCBy
ZWFkIGNhbGxiYWNrDQo+IG9uIGRlbWFuZCBmb3IgZml4ZWRfYWRkcmVzcyBjbGllbnRzIikNCj4g
Rml4ZXM6IDE3YmE4YTA4YjU4YTAxYmJhYzM1NzkwZmZjYTQzODhjYTkyYjc3OTAgKCJtZWk6IGNv
bnNvbGlkYXRlDQo+IHJlcGVhdGluZyBjb2RlIGluIG1laV9jbF9pcnFfcmVhZF9tc2ciKQ0KDQoN
ClRoaXMgaXMgYSByZWZhY3RvcmluZyBub3QgYSBidWcgZml4LCBvciBhbSBJIG1pc3Npbmcgc29t
ZXRoaW5nIA0KDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJz
LnNvdXJjZWZvcmdlLm5ldD4NCg0KVGhpcyBsb29rcyBiZXR0ZXIgdGhhbiB0aGUgb3JpZ2luYWwg
Y29kZSwgYnV0IEkgd291bGQgZHJvcCB0aGUgJ0ZpeCcgd29yZGluZy4gIA0KDQoNCj4gLS0tDQo+
ICBkcml2ZXJzL21pc2MvbWVpL2ludGVycnVwdC5jIHwgMjIgKysrKysrKysrKystLS0tLS0tLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvaW50ZXJydXB0LmMgYi9kcml2ZXJz
L21pc2MvbWVpL2ludGVycnVwdC5jIGluZGV4DQo+IDBhMGU5ODRlNTY3My4uOTgwMGQzMGI3Njkz
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2MvbWVpL2ludGVycnVwdC5jDQo+ICsrKyBiL2Ry
aXZlcnMvbWlzYy9tZWkvaW50ZXJydXB0LmMNCj4gQEAgLTEzNiw3ICsxMzYsNyBAQCBzdGF0aWMg
aW50IG1laV9jbF9pcnFfcmVhZF9tc2coc3RydWN0IG1laV9jbCAqY2wsDQo+ICAJCQkJY2ItPmV4
dF9oZHIgPSBremFsbG9jKHNpemVvZigqZ3NjX2YyaCksDQo+IEdGUF9LRVJORUwpOw0KPiAgCQkJ
CWlmICghY2ItPmV4dF9oZHIpIHsNCj4gIAkJCQkJY2ItPnN0YXR1cyA9IC1FTk9NRU07DQo+IC0J
CQkJCWdvdG8gZGlzY2FyZDsNCj4gKwkJCQkJZ290byBtb3ZlX3RhaWw7DQo+ICAJCQkJfQ0KPiAg
CQkJCWJyZWFrOw0KPiAgCQkJY2FzZSBNRUlfRVhUX0hEUl9OT05FOg0KPiBAQCAtMTUzLDcgKzE1
Myw3IEBAIHN0YXRpYyBpbnQgbWVpX2NsX2lycV9yZWFkX21zZyhzdHJ1Y3QgbWVpX2NsICpjbCwN
Cj4gIAkJaWYgKCF2dGFnX2hkciAmJiAhZ3NjX2YyaCkgew0KPiAgCQkJY2xfZGJnKGRldiwgY2ws
ICJubyB2dGFnIG9yIGdzYyBmb3VuZCBpbiBleHRlbmRlZA0KPiBoZWFkZXIuXG4iKTsNCj4gIAkJ
CWNiLT5zdGF0dXMgPSAtRVBST1RPOw0KPiAtCQkJZ290byBkaXNjYXJkOw0KPiArCQkJZ290byBt
b3ZlX3RhaWw7DQo+ICAJCX0NCj4gIAl9DQo+IA0KPiBAQCAtMTYzLDcgKzE2Myw3IEBAIHN0YXRp
YyBpbnQgbWVpX2NsX2lycV9yZWFkX21zZyhzdHJ1Y3QgbWVpX2NsICpjbCwNCj4gIAkJCWNsX2Vy
cihkZXYsIGNsLCAibWlzbWF0Y2hlZCB0YWc6ICVkICE9ICVkXG4iLA0KPiAgCQkJICAgICAgIGNi
LT52dGFnLCB2dGFnX2hkci0+dnRhZyk7DQo+ICAJCQljYi0+c3RhdHVzID0gLUVQUk9UTzsNCj4g
LQkJCWdvdG8gZGlzY2FyZDsNCj4gKwkJCWdvdG8gbW92ZV90YWlsOw0KPiAgCQl9DQo+ICAJCWNi
LT52dGFnID0gdnRhZ19oZHItPnZ0YWc7DQo+ICAJfQ0KPiBAQCAtMTc0LDE4ICsxNzQsMTggQEAg
c3RhdGljIGludCBtZWlfY2xfaXJxX3JlYWRfbXNnKHN0cnVjdCBtZWlfY2wgKmNsLA0KPiAgCQlp
ZiAoIWRldi0+aGJtX2ZfZ3NjX3N1cHBvcnRlZCkgew0KPiAgCQkJY2xfZXJyKGRldiwgY2wsICJn
c2MgZXh0ZW5kZWQgaGVhZGVyIGlzIG5vdA0KPiBzdXBwb3J0ZWRcbiIpOw0KPiAgCQkJY2ItPnN0
YXR1cyA9IC1FUFJPVE87DQo+IC0JCQlnb3RvIGRpc2NhcmQ7DQo+ICsJCQlnb3RvIG1vdmVfdGFp
bDsNCj4gIAkJfQ0KPiANCj4gIAkJaWYgKGxlbmd0aCkgew0KPiAgCQkJY2xfZXJyKGRldiwgY2ws
ICJubyBkYXRhIGFsbG93ZWQgaW4gY2Igd2l0aCBnc2NcbiIpOw0KPiAgCQkJY2ItPnN0YXR1cyA9
IC1FUFJPVE87DQo+IC0JCQlnb3RvIGRpc2NhcmQ7DQo+ICsJCQlnb3RvIG1vdmVfdGFpbDsNCj4g
IAkJfQ0KPiAgCQlpZiAoZXh0X2hkcl9sZW4gPiBzaXplb2YoKmdzY19mMmgpKSB7DQo+ICAJCQlj
bF9lcnIoZGV2LCBjbCwgImdzYyBleHRlbmRlZCBoZWFkZXIgaXMgdG9vIGJpZyAldVxuIiwNCj4g
ZXh0X2hkcl9sZW4pOw0KPiAgCQkJY2ItPnN0YXR1cyA9IC1FUFJPVE87DQo+IC0JCQlnb3RvIGRp
c2NhcmQ7DQo+ICsJCQlnb3RvIG1vdmVfdGFpbDsNCj4gIAkJfQ0KPiAgCQltZW1jcHkoY2ItPmV4
dF9oZHIsIGdzY19mMmgsIGV4dF9oZHJfbGVuKTsNCj4gIAl9DQo+IEBAIC0xOTMsNyArMTkzLDcg
QEAgc3RhdGljIGludCBtZWlfY2xfaXJxX3JlYWRfbXNnKHN0cnVjdCBtZWlfY2wgKmNsLA0KPiAg
CWlmICghbWVpX2NsX2lzX2Nvbm5lY3RlZChjbCkpIHsNCj4gIAkJY2xfZGJnKGRldiwgY2wsICJu
b3QgY29ubmVjdGVkXG4iKTsNCj4gIAkJY2ItPnN0YXR1cyA9IC1FTk9ERVY7DQo+IC0JCWdvdG8g
ZGlzY2FyZDsNCj4gKwkJZ290byBtb3ZlX3RhaWw7DQo+ICAJfQ0KPiANCj4gIAlpZiAobWVpX2hk
ci0+ZG1hX3JpbmcpDQo+IEBAIC0yMDUsMTQgKzIwNSwxNCBAQCBzdGF0aWMgaW50IG1laV9jbF9p
cnFfcmVhZF9tc2coc3RydWN0IG1laV9jbCAqY2wsDQo+ICAJCWNsX2VycihkZXYsIGNsLCAibWVz
c2FnZSBpcyB0b28gYmlnIGxlbiAlZCBpZHggJXp1XG4iLA0KPiAgCQkgICAgICAgbGVuZ3RoLCBj
Yi0+YnVmX2lkeCk7DQo+ICAJCWNiLT5zdGF0dXMgPSAtRU1TR1NJWkU7DQo+IC0JCWdvdG8gZGlz
Y2FyZDsNCj4gKwkJZ290byBtb3ZlX3RhaWw7DQo+ICAJfQ0KPiANCj4gIAlpZiAoY2ItPmJ1Zi5z
aXplIDwgYnVmX3N6KSB7DQo+ICAJCWNsX2RiZyhkZXYsIGNsLCAibWVzc2FnZSBvdmVyZmxvdy4g
c2l6ZSAlenUgbGVuICVkIGlkeA0KPiAlenVcbiIsDQo+ICAJCQljYi0+YnVmLnNpemUsIGxlbmd0
aCwgY2ItPmJ1Zl9pZHgpOw0KPiAgCQljYi0+c3RhdHVzID0gLUVNU0dTSVpFOw0KPiAtCQlnb3Rv
IGRpc2NhcmQ7DQo+ICsJCWdvdG8gbW92ZV90YWlsOw0KPiAgCX0NCj4gDQo+ICAJaWYgKG1laV9o
ZHItPmRtYV9yaW5nKSB7DQo+IEBAIC0yMzUsOSArMjM1LDkgQEAgc3RhdGljIGludCBtZWlfY2xf
aXJxX3JlYWRfbXNnKHN0cnVjdCBtZWlfY2wgKmNsLA0KPiANCj4gIAlyZXR1cm4gMDsNCj4gDQo+
ICttb3ZlX3RhaWw6DQo+ICsJbGlzdF9tb3ZlX3RhaWwoJmNiLT5saXN0LCBjbXBsX2xpc3QpOw0K
PiAgZGlzY2FyZDoNCj4gLQlpZiAoY2IpDQo+IC0JCWxpc3RfbW92ZV90YWlsKCZjYi0+bGlzdCwg
Y21wbF9saXN0KTsNCj4gIAltZWlfaXJxX2Rpc2NhcmRfbXNnKGRldiwgbWVpX2hkciwgbGVuZ3Ro
KTsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gLS0NCj4gMi40MC4wDQoNCg==
