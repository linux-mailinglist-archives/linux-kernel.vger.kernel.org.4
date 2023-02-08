Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF4368EC9E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjBHKQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjBHKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:16:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85F457F1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675851390; x=1707387390;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tBSMQSqbQReu9zBDkJl8U9ShuBww/h4WkswHg1cqGY8=;
  b=EJYxx5r7adubDsP79Hi0zKYJC+OrGgog9EJpArYGFS1gX3SQh857UXj1
   4cOIT4Af3ByBhiJjfBUz0sLioz1JhDOcjfxQnUTQw3BjId6kCIAV8lo1M
   tGoZRGmPZrHF3OLldyq1emir+DUxKsJ+ePusGFgoB9+TWbaB9LKp2nZIy
   x0lQTz9YlzFQW+mklxHDJYiMVV4iLiiq0RESVJO4HxrzxwnLlnVfiyk/s
   JxwtY288qBJ9Y0BwDzP1t4MvTpjIa77Qg9WZUp263KOtoFqk2CXDpMUmg
   lhSItur4cLuG7TzPXa+KPJgU9IBZtw6Vlh3jmvBEMuJujbJB6310botlz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="357151222"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="357151222"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 02:16:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="755998595"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="755998595"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Feb 2023 02:16:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 02:16:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 02:16:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 02:16:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C99rbEBj0xg2YkKIOcyXWdCWPI+XrEli/5HRh7eBpp3BaR/aZVjY/wqRc3owtFLPxSYuA8qLewLQWoN4q90coUsKo7PrXzEXoxw42/5HPo0Y6C9kABQU7mus7DuV6XTXWUzcxiJUCsy4LqPtfvZ3TuUuMFsA+hWgazn04y6HbumNfPsqnH5Aj3vAitktMU9Xo59OWsJb0NF5Bpm9Z5XXMHVugcjnb4zjVUnduOGY8Hb5qBKO/MfZCil/JREQfizr7Rg58KISyQz0Oo4UHeUhytjQTbim+uiKUq0QmJxe8w+5yTSD+Y5HF5WVHQjsw1G4mNpvlMJdyPBNG6gvYaUmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBSMQSqbQReu9zBDkJl8U9ShuBww/h4WkswHg1cqGY8=;
 b=FgDAztsmmMcVhq3O+8oy0yJUmG7evEemAdjEQyNZczjt2+hTeXcXThhr4q0PEvU4T98wXcAOZl6vn3VWCWz+I/eZ9rFQlfiGTvMqW0za/TxYJ+bJuOw+6Un3ePtKKV5SiqnG5zIO3sLbkac4hNpKNKyOpZf32wJd9gPcysO+50vSZfWp01pntmYRbJI5lBLB1HCx4k3JnaZJOv7yix2pvV2jpBkRZcBWwgHWEUiEwRI1W3ckPsHqXXyNxTi261kIZ4qIJVImOJQwr5QrQFFdtZXJFOWk4VL3Jmm+7z8VxK+w9D2NRoXIQZpHhAstZgHhdOAT+3tWUeR0Czjsiwzo1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN0PR11MB5758.namprd11.prod.outlook.com (2603:10b6:408:166::18)
 by BN9PR11MB5557.namprd11.prod.outlook.com (2603:10b6:408:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Wed, 8 Feb
 2023 10:16:14 +0000
Received: from BN0PR11MB5758.namprd11.prod.outlook.com
 ([fe80::17f6:2dff:ce11:ff0d]) by BN0PR11MB5758.namprd11.prod.outlook.com
 ([fe80::17f6:2dff:ce11:ff0d%8]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 10:16:14 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwJ2YsAAAAu1hQAAHQE/AAAcTH2A
Date:   Wed, 8 Feb 2023 10:16:14 +0000
Message-ID: <BN0PR11MB5758C701F81E701851ECA729E7D89@BN0PR11MB5758.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com> <Y+HpmIesY96cYcWQ@kroah.com>
 <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
In-Reply-To: <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR11MB5758:EE_|BN9PR11MB5557:EE_
x-ms-office365-filtering-correlation-id: 2d6dce23-2206-4872-308f-08db09bd8291
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M1A+3cXt35wS3O8dRrcXMptWLcJgVb9MkCDcFj/JAWlt+eSYpfoetoBipIdO9ucRa1PJQaFb8wH3Wbe8jqQ0oiOlfiQNf8Gv7Waa2wIJr77Gdh8PaPfv21RSJ6HP5hM5MaIw6X5oZydGGcYJYD8a45y2psXmxhA5RBLa2N/Ui06S41u+qfy2K/dp7VAqXRS/7N63tSl5UrzMlFjldjh2dSHjuaxsRjOrsHetUWkWJsz/TmNO59b2Ns6C786S93XxxkZfWpkWrG2Dmck5upwimQjG0K6DtbVXnOCvrjwk7R27vlWkHCB7YJzt4P8bwixg3mdi5tR49XtQzL4SIsasHBSEa+MxrogVwUobSb5FJ1P+KRWZUkqz3Zoqw6pV0rEmvRo4pPKdeO4V9qomLs6fuCyWPbs+r8/0EPJXrkyQyLZgZODK03ovDvnGftjnWDLKsn6/CkZWqupx08xgxij/8LfdMNRuZzZ9mr3U8mjSSJSZO7NGibWEfBXmUfB/WY9Lf96Kl8FWPZj5FXT/r2wNXgP6brKnnbl+ovXQ2btIyFQlWZn3Lz+aYjOLPqI99qNmOJMi/+xYCVx8cnuZUfbFPLzF/Tj35Fvty7Kr1A2nVYKrwU9LCf8SRaFTBjwzww9EWS9PRjPkKbX6YPNPKiYuIHa+AAPIrbtabgplSrd4ltx9P+X9fUwn/N+o7qpYgb5maPao0XPJ7oD7vGqm3l6XAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199018)(6506007)(478600001)(26005)(9686003)(186003)(71200400001)(7696005)(110136005)(54906003)(316002)(83380400001)(66476007)(76116006)(66946007)(82960400001)(66446008)(66556008)(38100700002)(122000001)(8676002)(64756008)(4326008)(2906002)(8936002)(52536014)(55016003)(41300700001)(38070700005)(86362001)(5660300002)(7416002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW9MTWNWc1BNUDk3VDlUeHp6dTk1S1Vtam9aRjFyTW1KZ1NJaXBOK2IwaHhO?=
 =?utf-8?B?NDZnVzQ2RU9YNklsUDFuVzhDYkdndFQrempTQlErenJ3TC9WWERib2Z4RFl3?=
 =?utf-8?B?YnplOGFEQ28wc2QzUGRlbGgwUmFUSUhrdWI2ZDIvQ09EaGIxcG5oVjFNNWpz?=
 =?utf-8?B?TUl5b2svUDUvMzVpNk1aby8yWUo5Q2JhbVhib3h3TUpIb2xyZkR0SGRPY1Fl?=
 =?utf-8?B?eTJFdmxFZUk0VnJSc2Y0NmNhQmswaHZibFJ5VWEyaHgxSG5weU4zTkZhcFVW?=
 =?utf-8?B?SFdETlpsM0F4TFBpdEo1MlRCL2JjVFF4WHBsZlZQQWo4VDlQa3NoS0lEOUV0?=
 =?utf-8?B?VkxzZGJ1Qml0dkpQbmlKdDFMcGliVkJBK0NOdG44U2NSa2Z3d1dXY1pUSDRU?=
 =?utf-8?B?Zk1ETDU2QzM5UHFmUDU1OVZjdTdCYTdrQ2lZS1kxb0QyVys0RHozek1KS1lJ?=
 =?utf-8?B?dURkTXB5dFRSSjB1ZnB5VDdMRVltRnl2aUhpU1FMZjJiWGdVS0ZhUWprQVF4?=
 =?utf-8?B?UHRKV2U1QVdHQ0o5Uks5QlFhajNlTnRoeC82ckNWb2d1QlZPVWpiU1FrVWlP?=
 =?utf-8?B?aktacVNRNDFwMVZqWlAvaDFsV1ZEL3FYL2kwa25TMkZWZUdUZUhQWElPTTE2?=
 =?utf-8?B?YVl5TXEvdGsrV3ZPeGpXbFhVY1VzWVQzTDFyZEUyOWk1ZDRHei9yUkxoWUt4?=
 =?utf-8?B?Tys5UG5KTkVNNUJBMHUweDd1VGVrbFoyUFlJWENCZnh6NHhRcjBKVTdWL21O?=
 =?utf-8?B?QWRsRkFMelUvUTZRL0E3c3Q1NzdKUUx5M2tkVXpmRjZkazVGNElyS041b1I2?=
 =?utf-8?B?QWVHQU9XNjRaQWdPcEVLNkRFdkFpUXJwdVdPT2lQNy94c1NSczVKQXVYS3pM?=
 =?utf-8?B?dWNreUtlQTBWdmVuakhWRlFla2EybDFWWUd6bG5jRFFqVGdQczdBeFR4cFN1?=
 =?utf-8?B?N2lrazVnemg5NTBjejUzb1NsVUxoR0EyUXJHS1N1MldKTE5hZzR1dGtLQnZW?=
 =?utf-8?B?NTJ2T01KcUZ6WUYybmJHU3BqOVRkZ0VIM3ZDR1NOclBNakxhOGNiVE8xbzlX?=
 =?utf-8?B?TWdwV1dTMjVFekJzMnE0S1BydERwb01kUTgzdWd4dUtlMEtxdk15Yk04b2VT?=
 =?utf-8?B?WVE3Y2ZuRk15YzhKWTNWZHhuV0VYTHhZZ0JZUkZ5M2NNS3lOcFRlOFlqTDZk?=
 =?utf-8?B?UTd3TG9sbTF3NzdvNnBSanVzSjNMTzZqeTJrcmZUTG91UUZTZDBuUUZPZlAv?=
 =?utf-8?B?aVlhTldXenVQR21jVjY2cjRmMmZXYXRuYTJLNDZOMVU3elREVFlTVWl0Zlp1?=
 =?utf-8?B?Z0ZsODZPdHgrNElwNlpFVXE2eXp3VzhlS093bmZUM0JyZTZNT2ZVa0J3elZQ?=
 =?utf-8?B?UFlDdHdmdUg4RGV6bnJ0MmJ4M0dMNm5nSFJ3My9IcEpqdUNJbUJ0eDU0RTI3?=
 =?utf-8?B?WjFrZFFSSmdsL2lyWlNsYTY0blJQdFFMeERWRDYzVm5FVUxzMVZONWl3Y1Z5?=
 =?utf-8?B?UkRmaXJ0WGJyZSs2VSt0b2ovZVhGVi9LWVR4UUovOVZ5QmJaRmJmeC9KdFZh?=
 =?utf-8?B?QkwwV1lXbkVGcEd5RDBXeVlZZEM0a2RyNDl0UnlkN0VGcmkrTHVZZDM1bFU4?=
 =?utf-8?B?QWJKMUplN1VrenF4RktsWHY1clpaZDFBa3ArK0prNTNFVzFzVUdKME1iMFBK?=
 =?utf-8?B?QSs5RFBSakQzaDZ0ZzJHUHJ5SW4rZklHVzd4YlFNZlI0bmJHcE0yTG1kYndu?=
 =?utf-8?B?UzNCK0FvYjhpZk8yMWoxSTlTTEtza2ZzcUVHeExjOU00WVZJa0s4T2IyYy9X?=
 =?utf-8?B?dlgwcm1yRjlvMWY4Y3hwUE5FMTlSNHdnYWM1K0plY0RrSUVBaWxtNXhzTVg3?=
 =?utf-8?B?ci9FRys5clYrMmRMdlVoeGlneXRyRTIzT0JWU3lnODNZVjlic0JRL0N2VjJ2?=
 =?utf-8?B?WnFiTnl4ZSszR3JlR2d3bUk1NzhpaUFWV1krTkV3c2J4d1Eya29ObldsaHpM?=
 =?utf-8?B?eGZBVTJYK0RmeEhRSE8yQXRzUHRSZm11ZlFnb241WVB0Ry84WHVISDZYMUJv?=
 =?utf-8?B?MXRNV2ZLSE9rbW42MzhHekFTQWhlTzQ3R0QycHV5WWZqdHZoL3hveGUvRHNs?=
 =?utf-8?Q?bctYDwZtshhvUZH3KJpzeiuaS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6dce23-2206-4872-308f-08db09bd8291
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 10:16:14.6610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2sxpK0bSjrOBIXCPewB21t7leV3N7/h8lo+GewgRuKHGEjFGHH7AuzEVZnQNNSbj+pgdzSYpfKPkllaSCXsMPr4VfBBtgkCMAn1AYASXXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5557
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBObyByZWxhdGlvbiBvdGhlciB0aGFuIGl0IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZSBhIHNvbHV0
aW9uIHRoYXQgZG9lcyBub3QNCj5yZXF1aXJlIGtlcm5lbCBjb21tYW5kIGxpbmUgYW5kIHRoYXQg
cHJldmVudHMgX19pbml0KClzLg0KDQpGb3IgX19pbml0cyBzZWUgYmVsb3cuIEZvciB0aGUgY29t
bWFuZCBsaW5lLCBpdCBpcyBwcmV0dHkgc3RyYWlnaHRmb3J3YXJkIHRvIA0KbWVhc3VyZSBpdCBh
bmQgYXR0ZXN0IGl0cyBpbnRlZ3JpdHkgbGF0ZXI6IHdlIG5lZWQgdG8gZG8gaXQgZm9yIG90aGVy
IHBhcnRzDQphbnlob3cgYXMgYWNwaSB0YWJsZXMsIGV0Yy4gU28gSSBkb27igJl0IHNlZSB3aHkg
d2UgbmVlZCB0byBkbyBzbXRoIHNwZWNpYWwNCmFib3V0IGl0PyBJbiBhbnkgY2FzZSBpdCBpcyBp
bmRlZWQgdmVyeSBkaWZmZXJlbnQgZnJvbSBkcml2ZXIgZGlzY3Vzc2lvbiBhbmQNCmdvZXMgaW50
byAid2hhdCBzaG91bGQgYmUgY292ZXJlZCBieSBhdHRlc3RhdGlvbiBmb3IgQ0MgZ3Vlc3QiIHRv
cGljLiANCg0KPiBNb3JlIHByZXNzaW5nIGNvbmNlcm4gdGhhbiB3YXN0ZWQgbWVtb3J5LCB3aGlj
aCBtYXkgYmUgdW5pbXBvcnRhbnQsIHRoZXJlJ3MNCj4gdGhlIGlzc3VlIG9mIHdoYXQgYXJlIHRo
b3NlIGRyaXZlciBpbml0IGZ1bmN0aW9ucyBkb2luZy4gRm9yIGV4YW1wbGUsIGFzDQo+IHBhcnQg
b2YgZGV2aWNlIHNldHVwLCBNTUlPIHJlZ3MgbWF5IGJlIGludm9sdmVkLCB3aGljaCB3ZSBjYW5u
b3QgdHJ1c3QuIEl0J3MNCj4gYSBsb3QgbW9yZSBjb2RlIHRvIHdvcnJ5IGFib3V0IGZyb20gYSBD
b0NvIHBlcnNwZWN0aXZlLg0KDQpZZXMsIHdlIGhhdmUgc2VlbiBzdWNoIGNhc2VzIGluIGtlcm5l
bCB3aGVyZSBkcml2ZXJzIG9yIG1vZHVsZXMgd291bGQgYWNjZXNzDQpNTUlPIG9yIHBjaSBjb25m
aWcgc3BhY2UgYWxyZWFkeSBpbiB0aGVpciBfX2luaXQoKSBmdW5jdGlvbnMuIA0KU29tZSBjb25j
cmV0ZSBleGFtcGxlcyBmcm9tIG1vZHVsZXMgYW5kIGRyaXZlcnMgKHRoZXJlIGFyZSBtb3JlKToN
Cg0KIGludGVsX2lvbW11X2luaXQoKSAtPiBpbml0X2RtYXJzKCkgLT4gY2hlY2tfdHlsZXJzYnVy
Z19pc29jaCgpDQpza3hfaW5pdCgpIC0+IGdldF9hbGxfbXVuaXRzKCkNCnNreF9pbml0KCkgLT4g
c2t4X3JlZ2lzdGVyX21jaSgpIC0+IHNreF9nZXRfZGltbV9jb25maWcoKQ0KaW50ZWxfcm5nX21v
ZF9pbml0KCkgLT4gaW50ZWxfaW5pdF9od19zdHJ1Y3QoKQ0KaTEwbm1fZXhpdCgpLT5lbmFibGVf
cmV0cnlfcmRfZXJyX2xvZyAtPl9fZW5hYmxlX3JldHJ5X3JkX2Vycl9sb2coKQ0KDQpIb3dldmVy
LCB0aGlzIGlzIGhvdyB3ZSBhZGRyZXNzIHRoaXMgZnJvbSBzZWN1cml0eSBwb2ludCBvZiB2aWV3
Og0KDQoxLiBJbiBvcmRlciBmb3IgYSBNTUlPIHJlYWQgdG8gb2J0YWluIGRhdGEgZnJvbSBhIHVu
dHJ1c3RlZCBob3N0LCB0aGUgbWVtb3J5DQpyYW5nZSBtdXN0IGJlIHNoYXJlZCB3aXRoIHRoZSBo
b3N0IHRvIGJlZ2luIHdpdGguIFdlIGVuZm9yY2UgdGhhdA0KYWxsIE1NSU8gbWFwcGluZ3MgYXJl
IHByaXZhdGUgYnkgZGVmYXVsdCB0byB0aGUgQ0MgZ3Vlc3QgdW5sZXNzIGl0IGlzIA0KZXhwbGlj
aXRseSBzaGFyZWQgKGFuZCB3ZSBkbyBhdXRvbWF0aWNhbGx5IHNoYXJlIGZvciB0aGUgYXV0aG9y
aXplZCBkZXZpY2VzDQphbmQgdGhlaXIgZHJpdmVycyBmcm9tIHRoZSBhbGxvdyBsaXN0KS4gVGhp
cyByZW1vdmVzIGEgcHJvYmxlbSBvZiBhbiANCiJ1bmV4cGVjdGVkIE1NSU8gcmVnaW9uIGludGVy
YWN0aW9uIg0KKG1vZHVsbyBhY3BpIEFNTCBvcGVyYXRpb24gcmVnaW9ucyB0aGF0IHdlIGRvIGhh
dmUgdG8gc2hhcmUgYWxzbyB1bmZvcnR1bmF0ZWx5LA0KYnV0IGFjcGkgaXMgYSB3aG9sZSBkaWZm
ZXJlbnQgZGlmZmljdWx0IGNhc2Ugb24gaXRzIG93bikuDQoNCjIuIEZvciBwY2kgY29uZmlnIHNw
YWNlLCB3ZSBsaW1pdCBhbnkgaW50ZXJhY3Rpb24gd2l0aCBwY2kgY29uZmlnDQpzcGFjZSBvbmx5
IHRvIGF1dGhvcml6ZWQgZGV2aWNlcyBhbmQgdGhlaXIgZHJpdmVycyAodGhhdCBhcmUgaW4gdGhl
IGFsbG93IGxpc3QpLg0KQXMgYSByZXN1bHQgZGV2aWNlIGRyaXZlcnMgb3V0c2lkZSBvZiB0aGUg
YWxsb3cgbGlzdCBhcmUgbm90IGFibGUgdG8gYWNjZXNzIHBjaQ0KY29uZmlnIHNwYWNlIGV2ZW4g
aW4gdGhlaXIgX19pbml0IHJvdXRpbmVzLiBJdCBpcyBkb25lIGJ5IHNldHRpbmcgdGhlDQp0b19w
Y2lfZGV2KGRldiktPmVycm9yX3N0YXRlID0gcGNpX2NoYW5uZWxfaW9fcGVybV9mYWlsdXJlIGZv
ciBub24tYXV0aG9yaXplZA0KZGV2aWNlcy4gDQoNCiBTbywgZXZlbiBpZiBob3N0IG1hZGUgdGhl
IGRyaXZlciBfX2luaXQgZnVuY3Rpb24gdG8gcnVuDQooYnkgZmFraW5nIHRoZSBkZXZpY2Ugb24g
dGhlIGhvc3Qgc2lkZSksIGl0IHNob3VsZCBub3QgYmUgYWJsZSB0byBzdXBwbHkgYW55DQptYWxp
Y2lvdXMgZGF0YSB0byBpdCB2aWEgTU1JTyBvciBwY2kgY29uZmlnIHNwYWNlLCBzbyBydW5uaW5n
IHRoZWlyIF9faW5pdCANCnJvdXRpbmVzIHNob3VsZCBiZSBvayBmcm9tIHNlY3VyaXR5IHBvaW50
IG9mIHZpZXcgb3IgZG9lcyBhbnlvbmUgc2VlIGFueQ0KaG9sZXMgaGVyZT8gDQoNCkJlc3QgUmVn
YXJkcywNCkVsZW5hLg0K
