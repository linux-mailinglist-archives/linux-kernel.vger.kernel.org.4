Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AA6745649
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGCHpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGCHpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:45:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8932C2;
        Mon,  3 Jul 2023 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688370317; x=1719906317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ot10aTVE3VgtRjhEZqctsTvjWJRaVWs3JSBW6Z6TPgk=;
  b=EFX+M/l037sD5HOHdKWLCOjmSA/kR0AICybZOK0RVAblr4NrmvwJYz0G
   ycjGhe9cjlBC6rLA4IWa5xMJl/KT6bQpcMtaFo+To+HM5jI0VkyEI04CJ
   A/NxeegOYrhZHBmnOv3T2r2EWffixqf01cxdTyjOxRHD8a5RsR6CBs0Dx
   em70M/Ir4vKuPs2BE26mfWkjPkpwWLB+r5U3xbW+6r3SHvy9ChVTzB62C
   OyeKBzPJ1kMCzI4Rv1/KfWqsRBxNJdxxQkM2J1ecIs8yV8nIPyJnbzBQq
   PAjK5xAghF/y3pMBLaKEc6suVks+fDKn6BdmyxJYtPMTSMEUdHPDCl88F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="362856772"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="362856772"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 00:45:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="1048978230"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="1048978230"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2023 00:45:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 00:45:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 00:45:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 00:45:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJbcNDQR0kBNXHdYQZq0yYc2LHcVipLPTThM+MKoFk9sBvWqHnkSvYuBX81mMjWOne3M0Iwa5y3bBwdAKnrbV9wZ0RWogBlDi9zXzMO6hL7u4YrIB6t1ZxjHHqfgOkhR9eI0tm1Mth6yggky2ejmKCgqukFzeu6wijKI/msGZJi9NeT9lcXuKx39JmQpnLcRBVQKJpckWgDJ+sKnbngt8qUi0onYNsxj23ZjezTxmjPk7wtKZglRRo08CrhEYhg+WW8GaNAc+ZRAh8FkXxTT2jAfvZzri5vsY7rDTtVaPs2THjyWJLKQ0VGnyN6nsRLPVWSZqmd9Q6TvJdpBTsMJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot10aTVE3VgtRjhEZqctsTvjWJRaVWs3JSBW6Z6TPgk=;
 b=XvZ5s1LQnNOyLT7a2GQRTvK/MLNTBNyrQp1OdnYBuh6RX0BoT0DSwiJYUSfJbMB2QToMPN5a4Z1gZSkKEmH/s3dUTT3Xu4yycPId3Z8IJFEDgoz4jyQlbCTfu2NJrjRl6els3hJWm4izKFYddvGrr/45eHMO68ND5ys8XbVXKg0yTQFH/KB01zhc2xrAPUMvtVwRdQkdRHOLFQIWsLvR3rxZ8P5EHPGU//Banait5ytep+nObqVW0+7Us7NlfgB4K3rFxrWlSM7W3ydLoU+szdD2AzS4haiZB1TVDSfjDX0y7/ca1eMfyc1sPuGqLhfiJCHpXoMIyyze3Xvdb2ypcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by SA1PR11MB6613.namprd11.prod.outlook.com (2603:10b6:806:254::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 07:45:12 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 07:45:12 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Will Deacon" <will@kernel.org>
Subject: RE: [PATCH v3 0/1] Enable UBIFS support
Thread-Topic: [PATCH v3 0/1] Enable UBIFS support
Thread-Index: AQHZrYITF7EYAI0Jf0yr6gBnLiHSBa+nqV2A
Date:   Mon, 3 Jul 2023 07:45:12 +0000
Message-ID: <PH0PR11MB567352E337F1C0D099195E3DCB29A@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <20230703063309.1342330-1-kah.jing.lee@intel.com>
 <066c9c1b-68f3-8f4c-0e34-e31963b45690@web.de>
In-Reply-To: <066c9c1b-68f3-8f4c-0e34-e31963b45690@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|SA1PR11MB6613:EE_
x-ms-office365-filtering-correlation-id: f63c0f90-ab2b-4492-8917-08db7b996eca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CBtYfFHp+PObm1SZbCoaD8c51pFFQZIPrfZ4lqt/63Vml6oxxwxNV27D0+GlKvRS1zBiaFxRyXQh0CMDbom4LQK4MJ4AYX6Wdk5zaexDxtRvsm5XJlwmpYWtSShkjGr+6EBnkN32lxRC1fpcNWua9XOwDg+AGSzySj6tVa1aN7KjcqYj8XQwQ/XaPute3t1DIWzaM+d47cq8cF785lg4eFyyCA/UJfLV4EA+GTpgt6gHG+6u9xpOeg/pb1R6aFfWfym2xrCr2EUym96LGAW4Ujy+BTjF3k+AW9zBhhO8Bo3ub/7LBDiF5z5O6UWS3/zk0gUcmls38O6jpbOtCeDXOeMQbM4TVnwcQBb/g99Ihb4dzWRRvt1pnUK+kKF7rhVYo13l8lZBmeJiUL+rz6S7gFm9cwtChsEUnKhcC04cofYJSuWrDA2k69k6iamjxGtWOKicTwbNm36S8eMfPGREaytuc+b0si/5xoIY+wWU97sw0eoUC/aq2+EXNyE8yKFKgsd4QR3aQjQLz6XxwYtOdeq83f9QGLRSV2N46goywGb2vLvID6RBDSNvMa7WHM4qu6+2hYJ9niJtHsHkATS0rA1UpuwPUtux2mAE8XP8VrlAi4XNfZigMa52bT57tzCs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(6636002)(64756008)(33656002)(66446008)(4326008)(66476007)(66556008)(66946007)(76116006)(316002)(478600001)(2906002)(8676002)(8936002)(52536014)(5660300002)(41300700001)(55016003)(9686003)(86362001)(110136005)(54906003)(38070700005)(38100700002)(4744005)(7696005)(6506007)(26005)(186003)(82960400001)(71200400001)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVRGc2M2a09ucVNLK2oyK0VoVGxScEhhQWgvKzcyTDdTanZWdzhCdjZPVkQv?=
 =?utf-8?B?T3krUUlQSkNJdDBodThSM1hTVW1ZVmVIUVRUajFlWDFpWnYyMmVYZGJ3ODN6?=
 =?utf-8?B?S3YzdmVTVkRReXBLUmQ2M1Z1NUpnRVlWeDFPUUlxd1N0eUJURERnalcxTnlY?=
 =?utf-8?B?RXJueDZMaVN3QVlUY2x6TXp1WTcrSVJBUEQ2aUUwOFpHUGdUQy9NWnZkZFhX?=
 =?utf-8?B?clVRVXpNNENiK2xwNmVqRTVOY250MEZ6aTJYZTc2NUpRcG1yZVh0bkFTZkQx?=
 =?utf-8?B?UnFxbVRBUExaMVlzbWdEYmpZZEtld1NRK3liaks4aW9TbnJLemg0U3EyakVs?=
 =?utf-8?B?K0FxM05VUTV1QkRqQ1VTTFdnaktmOTRlZVd5WmJET1pjVytiMGd5cVNRL1VH?=
 =?utf-8?B?cTZtQkNmWHV2a0ZDZmYrWjRlcHNxZjVPSzFjcXpmajYwb0xUZmVvQjNhMG43?=
 =?utf-8?B?dWNHL3B5SDNYQnE4YVAvSllJeEU0cXNvMWVLaUlHSXJqRTlOVWFUYUlnNWxI?=
 =?utf-8?B?cy8vbnRWUWxUU2NZUlkrcFRCMyt0S0syRXNlc3d4a3B3SGZETUNiWTIzc2Uy?=
 =?utf-8?B?dlludEJmZG9iUzVmWEZSckxVQzBNS3Z2VU0yajBsMXgzcDJCS2tmamdVZkFn?=
 =?utf-8?B?SGFXZ2xySi9nMFpLeFpVTEJJOXEzUGt6ZFRXandtNUdnVHRQd0NVSys4NWRo?=
 =?utf-8?B?SVVHK1dNNitMa2VTRTZkOWlKZkVzc0RJUDJiZC82RjB3bVZBUndHL0RBOVh6?=
 =?utf-8?B?Z3pqMWxOT21wK3VGVXA5WVhzaGU4YkxCc0dyb2NEUW9id1dnUVRvV25vdDRN?=
 =?utf-8?B?eU1pb1haNmpKaDRHNkJxWUZmUGtwWVZKOE0zNkE0MEFsa0ZpWkF3b0VKcEZj?=
 =?utf-8?B?dGtwLzNmSTJpZkMrQ0ZvanN6SENnenE3S25TR1kwWElmbTZpRHU1bEFYL0JB?=
 =?utf-8?B?V0JlWk42bTZudzFSN0wyOTRSaVcvNllYdDd4OTFIK3JrYURCS25hWkR6SzVQ?=
 =?utf-8?B?VG5lR2VYNmhVZ3E3RGlJcmRMQmpKemdlSXdaL21mZ0pqWVc1aERiSFBLb2J2?=
 =?utf-8?B?Y2NYVjlnVFRFNDJYajFqVW52aUtWZUpxZU9uTGtwUjZrekFMRTZ3UWlycHQ2?=
 =?utf-8?B?SmxadVpJaUNiMFgrNGZVeVpQNEJDWVhjYXdTWlgxTlFXcGdKcC9uckNaV2FX?=
 =?utf-8?B?akZ3Vm4wdk83ZjhxTWkzbDQwVzJ3Z1pGeGk3VkZCOFBlYjJURE1Fc0NqRHhR?=
 =?utf-8?B?OUZJeGRiWDBPVFR0b1ZmQ3FJU1huZ1crTm44dkN4TVh4RlVjczhaWkRSalJv?=
 =?utf-8?B?MS81c3ZNaFptdm1JeXpXTlF0OWptNlptQnB4bG4zS0E2VW8vdDJiRE9tUEdu?=
 =?utf-8?B?ZEpYUEI5aDVDK1ZYeitpeEZIbjY1SVh1bDlDZ0FPaW9jODQxQXpwZFpxaEFS?=
 =?utf-8?B?Ym1CdHNnVGxCb3RiVytRaUpxayttNlA1bGZQN21ydmtnenRwc1ZDSUNLSTYx?=
 =?utf-8?B?RXdBYUFXR1lwa2hscjFCWXptTytMTHdlcGIxSHZ1cEg2azFwRVE0eDJSamRF?=
 =?utf-8?B?SEVrQkJrSGl4T2paMmJ6elAxaXdnb0JlbUdkR2Uyd1Q3RDFrUExPS1NLaFkv?=
 =?utf-8?B?eXZuVEljVHdnT0JlQU4rUFhlVG1Rcjk1QUJVOWsxQ09NNzlubWV0OUE0Uitv?=
 =?utf-8?B?UGVsVkJiaGRwTkJCMjJ0aHkwOW8wbEtWYWxpNXB1bitSSmQyTHlaOHlLL0cy?=
 =?utf-8?B?c0hOTzIzVWJTUS9WWnVQOHhJc0U4SFhyK0ROOExaeDMrUXJMbE5xcUZKdjRt?=
 =?utf-8?B?RWdVUGRPaGlQZkJzRUUxM1BIUHlTZGdPNExlQWhvWTB4NVlrMGlBMkFPTjAr?=
 =?utf-8?B?a0NablhjeUk5UjNmbXNVZHVlM0g2bUZJQXY0aTdCWXdMYUs2aU5Oa3N0WTZj?=
 =?utf-8?B?b0xmZXp4NVpPK2Voa2hQaG0zS01SUHV5LzBlS0UrU3NUZ3VDbldhVWdaOGNG?=
 =?utf-8?B?TTZRbS9naGtOcTF4eGZodWRrQ1pyZUF1WGx3S1hiMEFsbm80ckpEKzg3ZDMz?=
 =?utf-8?B?YnY1TjRCM2VKc2F4R2ZrekNqOTUwVCtEeWlQdGNhKzBHd1dNMmFJd1JhTTM4?=
 =?utf-8?Q?ohEQau1e4fVb42wbJsyMPBLgR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63c0f90-ab2b-4492-8917-08db7b996eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 07:45:12.1538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJjBx0DnaNhFPRHhu02H3/LeHK+6VP0d8HPct4s/cMoO3t6Ydlj6ay/8MaUAty5O/1ytQFwIdKj8gbJuNK7AzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6613
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFRoZSBwYXRjaCBpcyB0byB1cGRhdGUgdGhlIHFzcGkgbXRkIHBhcnRpdGlvbiByYW5nZSBm
b3IgVUJJRlMgb24NCj4gPiBzb2NmcGdhIHBsYXRmb3JtIC0gQWdpbGV4IGFuZCBTdHJhdGl4MTAg
Ym9hcmRzLg0KPiANCj4gV2h5IGRvIHlvdSBmaW5kIGEgY292ZXIgbGV0dGVyIHJlbGV2YW50IGZv
ciBhIHNpbmdsZSBwYXRjaD8NCj4gDQpXaWxsIGRyb3AgdGhlIGNvdmVyIGxldHRlciBzaW5jZSBv
bmx5IHNlbmQgZm9yIHNpbmdsZSBwYXRjaC4gDQpUaGFua3MuIA0KDQo+IFJlZ2FyZHMsDQo+IE1h
cmt1cw0KDQpUaGFua3MuIA0KDQpSZWdhcmRzLCANCkxlZSwgS2FoIEppbmcNCg0KDQo=
