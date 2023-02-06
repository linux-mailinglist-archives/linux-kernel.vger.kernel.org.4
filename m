Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47BA68B9C1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjBFKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBFKQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:16:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA1CA6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675678613; x=1707214613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JnESaoImsny34IdubWm6QGu8UNqBfoqtOjFqpFS1Z7w=;
  b=mv7jeOegsQ2pH2L0CsRTMW+hIZji2ROgWx9diWiSj3DUXw/686XQ5B+b
   RkVT9f5W/rHQg82P7LuUxHw7bzB1riecKyl6YIATPsc1jtl5uy9RgvvLl
   wbLS3Wir7squ8hQeKL1vyh1bZXEo5Z8trNhfYdS9fl4cGOMtpzYwMe5T4
   IeQ2Nep+GtE064TtiHNYA8BcOVlffSCM4bM6sFSwe6GBIoJ6dcvTAVROT
   ERBGZIK7lazZCti+6z1DeM8WJL2LVmbVFYi/GV29ZrNn/lq6Vc2F8Ms0S
   LpAlRH+oB/uhm6w9fXCUoNwkYkHrPeLj0mB7Rnd1Ud5cjPomxcHfKaPDQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="331307645"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="331307645"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 02:16:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="668376788"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="668376788"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 02:16:52 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 02:16:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 02:16:52 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 02:16:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll/xjA4tv/HnGycLrJiKZyfRUwDVMMchHhiv7nKp6ta7daIcPicyhgNHISQK7bavYq5HdpoyiaHyABMWHgQBraO6vgtFwUvjjSccQ89hGWqBiSp1Q+cbCCJHNXi3gCjHjTRytnQniOkWnJiuxA6eY70vNcaUQdXdtnvLd94CTuPzYTJWOcea4+By0j43kPmbdPwQNSDZtprxTGoSUDtirFcrF7RYS7+gc9etiADDhY/c0X0C6bVQpXeHJY/cIZndj3kLI9f/TH9SspSA4wje7EO8OxOGK79ytHQSHQRG6XAOy2mOkGCg9nqubdzix7cE0qs7IfUIO3M+5kVzrZTm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnESaoImsny34IdubWm6QGu8UNqBfoqtOjFqpFS1Z7w=;
 b=iJPKnKFYzxZKr9JIM832+6ZIGM3RZKgeIj2jZlRcKNzshjwVXW6Scavls+riNboNDLqdhpJ3EgQlCPVMP5i9Gh819aPzKPTGQuCiZkYNtuYyg2ncnyeAanvPbYXOcbJJi2QSyLAR9SBTX1BWrGbYRk4VOic7Dfmfqw6wV/XUYX9Wi503SqRKtfBLZdy5ez6j2uWDH8NF+xjY9Pjr1SQKgsiOgtr8NRI0CYZzjnsCfljvVwSbjsCnZWiXxTCoXgZl3KBTNYNky130iEndCgs757rHBERkKkIW7HmUe36CvL/qfqAovkJLGPTbJsFTRj8Ys011xUuUEWqMRPeeNFNYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3240.namprd11.prod.outlook.com (2603:10b6:a03:18::19)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 10:16:50 +0000
Received: from BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::c42:6379:b57f:4a59]) by BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::c42:6379:b57f:4a59%7]) with mapi id 15.20.6064.027; Mon, 6 Feb 2023
 10:16:50 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>
Subject: RE: PPS functionality for Intel Timed I/O
Thread-Topic: PPS functionality for Intel Timed I/O
Thread-Index: Adk0qfZfZVvAvtJ8SP+qSzpYuQsN4wAByXCAAACHHGAAAOuigAFW0rTQ
Date:   Mon, 6 Feb 2023 10:16:49 +0000
Message-ID: <BYAPR11MB32408E2D9758BD01EC65FB49E1DA9@BYAPR11MB3240.namprd11.prod.outlook.com>
References: <BYAPR11MB3240A86B426158623DB9983EE1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <fa3f1765-eb59-bf69-7f7b-14621caef6ea@enneenne.com>
 <BYAPR11MB3240801F21598EEFAEA79605E1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <1e02cc71-baee-1e75-9160-062d563af795@enneenne.com>
In-Reply-To: <1e02cc71-baee-1e75-9160-062d563af795@enneenne.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3240:EE_|BL1PR11MB5953:EE_
x-ms-office365-filtering-correlation-id: ccd0d299-de3e-4056-1ec8-08db082b429b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKNuCzv+2MvI08mx7rvsHmxNPeUrGcy17uGkFYVBkTagpB8TWYZXXWfVKOU6OoFpwSBC8+YCIeh896Ud9hWF6KLSExn9gwapEi0mROa/+Z8gxgOWxSRxbx2NR0fjycg9sMIbWk2HudmA8rizY9dmZy5nRa4gLZUc0TPX7Nz1p/TJ5jq9lSJ1vTe+a0koGNtO84QB9p0uBBS8RU65VmZRKNg2Xc4w8WmqwqG+iu9Y5jQXNtECPhoh2Uyn2fSBQ2QBzapbyZqu521MoVG2HmutWfOcWFtyA+f5lhc3Rge/EveW2iJJ/IgCgeqHd7QZkdSBGPrUqqQfN1gjY+q9JvmZ90ExzJXcseMJTXY+8j8zD9sV4+hKDARLN+4AtdNgy6nEMOwHHT+rMa8TOzbd3HnIY8JQhJd4G9OnIJf83ivIHYlR9ch2bvdGaDx+LFG6/l1cESMaMLro2FjYDHn5Wb/wlUIrcjs9wpy7t9jTeRTAkJq58QHP8EM+QTS/Ynbv1xnmUlIjMQ+/gZp2XbptNTMgHz292OJt6fKMFWOi8dkfzVQoNN+05NtriGQP/DzDwj1bTuynCPmTSHPh7hHaVGc3f2omPmdQtDOwb8YZxqbYXWSYsOR/eHRrXqnTgj9ttVuckg7ncKZqPe1zRyXNqhiVRAhQbOVeYUuROnjEEIuS9UsLlnxdu2wd417C6vX83wL42L/R3I6g3d5fzu5tuTemsqI1f+wfdAAsNu63R8jU7ec=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(346002)(39850400004)(366004)(451199018)(107886003)(38100700002)(82960400001)(122000001)(76116006)(83380400001)(52536014)(38070700005)(66446008)(8676002)(5660300002)(41300700001)(66476007)(6916009)(4326008)(66556008)(2906002)(66946007)(64756008)(6506007)(8936002)(53546011)(966005)(478600001)(9686003)(186003)(26005)(86362001)(33656002)(316002)(54906003)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVBxTUk0S1Z5bUtzeXY4aDdUWEFjQUtBaWdyTUI3NVM3ck13aklCUDJsdnJm?=
 =?utf-8?B?ejJyR2pORVZsWlhVdU94a2dITlJIbDFTVVlucWhlTXArbHJlTTc1TWdwblRD?=
 =?utf-8?B?V3FQYzlZUVJUaWFrRklqaWZLTkx4WTFTN1hjVS81dllVbkpwTU1GS3Z6V21u?=
 =?utf-8?B?c0FvaVlZRFpsYVk2ZDRaR0NUT1N4RWhuTGdNVnNpMEYrNCs2N0JXZ2ZqVC92?=
 =?utf-8?B?ajNpNkpaTjhSbSt2eGtLN1Zlbnk0NWxrSlQ1UG1UNEZJeTZYdmM3bUJBRmVx?=
 =?utf-8?B?a3p3ZjZhMldxNTA4eUU5QlRBb0VIU21abmhTbGJNQzlrbEhNNUxKa05LdVBq?=
 =?utf-8?B?U3lnRkQ1L2twNXFiSzg5bXBVMUsycXBHMkRmZFJoWUNnNHdNNG9ia1lMTTJ5?=
 =?utf-8?B?Wk9DV09OQzI3QVZjbWtpajNVR2xTN09FbFlJa3dCWnlRSHdTVkx0bWtwc0Fv?=
 =?utf-8?B?YVBFY0c1VXhYQkRZVWRjVG9ranFqK2N6S2hlSUVCS1FseDJ6TnMxVDZUYWNZ?=
 =?utf-8?B?T1ZGMkJhS0V4TU50UDZYNDRIa3pnMFRvdVEwYXFEY2czeTVFZHdFMy81SXd0?=
 =?utf-8?B?TXJBbExaTTRLb3FtR1BITjU2c296VlNERWpkZ2F3N3g5SUExUkNucU94TUVX?=
 =?utf-8?B?TkZvYnlPTVBZRURLbzRRVWtXbGVlYnVEQlhuZUdibzBzVDhSZ1VyNTlkZTlj?=
 =?utf-8?B?V3d3UmxlVERqM3V2azcwV0tDdVFHbjBFWnJRWTBLZHRxYUpXSWZlck9MTmtM?=
 =?utf-8?B?ZTdKaVpuYlNVdW1HR2lubXdxb293cForSEJyTDVyYUZoUEFyZWNwb0s3SC81?=
 =?utf-8?B?RWRZSzh6bDVOZmdYcW5RT2tDUW80Q2VNMnY4ckhIQkt2bC8xU055UmZnVnAz?=
 =?utf-8?B?ZmZaQWJCYklQTlM2enk1aHVmZnVELzZwcEtsTFQ5L25PbUE3R3JDd2Q4Tzhr?=
 =?utf-8?B?U0F2aHNnK2E3em9jZzNLODdIZUdaTlJuNEcvWmpxN3FOSTdoZXZnaFBCWHBv?=
 =?utf-8?B?emR4ZVFEOFd0cGM2ZnNHbnRUd1Z3OGloL3pzbmZTd3BncTJKQnJEMkRhRGgx?=
 =?utf-8?B?REVQS1JpTFRPa0xoSnR0ZTJHSWdoTDNKVWdLcGt0dlM4ZFBmWlFyOVFSTTZy?=
 =?utf-8?B?bU1xZ1gvZ0VJeG53OVdkaW9RdVdOYXVGWWluVkNhUWRUVVpDTTNOV0VRZXA2?=
 =?utf-8?B?RzVQN25lUDB2Tkh4eW9wZmtRQkZpbnFJZjBMNEhOcWFDRkRLRVhKZ2I3d3pP?=
 =?utf-8?B?a0hwTnhNUWZUaGJNWW1aNnJoelhwK0NicXI0ZXU2U01kMVdLVXRMMGd4dTNB?=
 =?utf-8?B?QjM0cXBSMVZuVkVkcllQV2lYbmtyMEMzTUk2aFB6emN4Snlld3F2bm1qMUZE?=
 =?utf-8?B?MzVTM0VMMCtoWTUybGYzSVAxeWFFQWFvUGt1Y3hhcVE2NUlaQ2VZMmIyRmh3?=
 =?utf-8?B?ZWJ1RVdYV210NDQ5dDVkNGhySURuaE1VT2JOY3pnYVk1aklCQ0VidUx6UGtZ?=
 =?utf-8?B?R3NnZzlSRkR2ODdtSDlVY01oNWFFS3d3RnhMTnRaSVpkRjJRT09VUHd3U0tB?=
 =?utf-8?B?M3A4bmJKWDI0WFFhak5PYUdrTmRvbWJoanprcEMwK00vS2hYV0NmZk5heU5X?=
 =?utf-8?B?WmVtYlkwSW13WEVZc3dQeXVEU2MxN0V1ZmowUS9FN1V5d0NxRm5TRVQvSnFE?=
 =?utf-8?B?MmhsVjhrT0syUklLMWxjMytLcGZReVFmbHcvczlKSVo5eGcrRVI3Z2ExV1BB?=
 =?utf-8?B?eTNNNWRSOTE5TGtEUTVXS040NHhjM0g0Rm5HaC9LVmtrQUhUMHlZWWdJZm1s?=
 =?utf-8?B?SCtZMFdaNGFja3ptbnphQ3JzdVQ5RkRMYlNoeDE0dTZSODhrYU5salVCM1Bq?=
 =?utf-8?B?Tm16eWFKSTFjbTFFenNuaW0yc0tuNjQ3ZFozdXVnVVk2aUVxb251NzBzV2pC?=
 =?utf-8?B?d2Q2SlBJL1dkOHk1U1RvMWQvcGFnc0c0cUpCM29VaEJPeHpsSUlQRHh1UHVP?=
 =?utf-8?B?R1RkK2NQaFhVTWp4NUx1ODVGVFBVaFIvZmdHYm1lMnhRanVROHNMakxTRS9B?=
 =?utf-8?B?NUVrVm1VWThEYjdOdUdBazkvZ3VLNE8yZldBWkxZS21ETDdGK1UwYzQ0YlJl?=
 =?utf-8?Q?JuARcqx49uZZRzk7gUOvLD74T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd0d299-de3e-4056-1ec8-08db082b429b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 10:16:49.6979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iba2dWUxIsShp4Yh1JIOEkSUzpX8cW1OP5HpnqTrjeWLrkowN/xz93wBOeTYN1G716Kr2SW2N+C6ZrLDMBwUQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9kb2xmbywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2Rv
bGZvIEdpb21ldHRpIDxnaW9tZXR0aUBlbm5lZW5uZS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFu
dWFyeSAzMCwgMjAyMyA3OjU3IFBNDQo+IFRvOiBOLCBQYW5kaXRoIDxwYW5kaXRoLm5AaW50ZWwu
Y29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2FuZ2FubmF2YXIsIE1h
bGxpa2FyanVuYXBwYQ0KPiA8bWFsbGlrYXJqdW5hcHBhLnNhbmdhbm5hdmFyQGludGVsLmNvbT47
IEQsIExha3NobWkgU293amFueWENCj4gPGxha3NobWkuc293amFueWEuZEBpbnRlbC5jb20+OyBU
IFIsIFRoZWplc2ggUmVkZHkNCj4gPHRoZWplc2gucmVkZHkudC5yQGludGVsLmNvbT47IEhhbGws
IENocmlzdG9waGVyIFMNCj4gPGNocmlzdG9waGVyLnMuaGFsbEBpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBQUFMgZnVuY3Rpb25hbGl0eSBmb3IgSW50ZWwgVGltZWQgSS9PDQo+IA0KPiBPbiAz
MC8wMS8yMyAxNToxMSwgTiwgUGFuZGl0aCB3cm90ZToNCj4gPiBIZXJlIGlzIGEgcHJlc2VudGF0
aW9uIGxpbmsgZm9yIFRpbWVkIEkvTyBkZXZpY2UNCj4gPiBodHRwczovL2xwYy5ldmVudHMvZXZl
bnQvMTYvY29udHJpYnV0aW9ucy8xMzg3L2F0dGFjaG1lbnRzLzEwNTEvMjAxMC9UDQo+ID4gaW1l
ZF9JT19MUEMucGRmDQo+IA0KPiBUaGFua3MuIEknbGwgdGFrZSBhIGxvb2sgYXQgaXQuDQo+IA0K
PiA+IEludGVsIFRpbWVkIEkvTyBQSU4gaGFzIGJvdGggZ2VuZXJhdG9yIGZ1bmN0aW9uYWxpdHkg
YW5kIGlucHV0IGNhcGFiaWxpdHkuDQo+ID4gV2FudGVkIHRvIGFzayBpZiBpdOKAmXMgYmV0dGVy
IHRvIGhhdmUgdHdvIHNlcGFyYXRlIGRyaXZlcnMsIG9uZSB1bmRlcg0KPiA+IGNsaWVudCBmb3Ig
aW5wdXQgYW5kIG90aGVyIGFzIGdlbmVyYXRvciBkcml2ZXIgZm9yIFBQUyBvdXRwdXQuDQo+ID4g
T1INCj4gPiBIYXZlIGEgc2luZ2xlIGNsaWVudCBkcml2ZXIgYW5kIHVzZXIgY2FuIGNob29zZSB0
aGUgZnVuY3Rpb25hbGl0eQ0KPiA+IChlaXRoZXIgUFBTIG91dHB1dCBvciBhcyBQUFMgc291cmNl
IHRvIGNhcHR1cmUgcHVsc2VzIHdpdGggdGltZXN0YW1wcykuDQo+IFdpdGhpbiBrZXJuZWwgc291
cmNlcyBQUFMgY2xpZW50cyBhbmQgUFBTIGdlbmVyYXRvcnMgYXJlIHBsYWNlZCBpbnRvIGRpZmZl
cmVudA0KPiBkaXJlY3Rvcmllcywgc28gSSBzdXBwb3NlIGlzIGJldHRlciB0byBkZXBsb3kgdHdv
IGRpZmZlcmVudCBwaWVjZXMgb2YgY29kZS4NCj4gDQpXZSBhcmUgcGxhbm5pbmcgdG8gYWRkIGEg
bmV3IFBQUyBnZW5lcmF0b3IgZHJpdmVyIGluIGRyaXZlcnMvcHBzL2dlbmVyYXRvcnMNCmkpIENh
biB0aGlzIGRyaXZlciB1c2UgcHBzX3JlZ2lzdGVyX3NvdXJjZSB0byByZWdpc3RlciBJbnRlbCBU
aW1lZCBJL08gZGV2aWNlIGZvciBwdWxzZSBnZW5lcmF0aW9uID8NCg0KaWkpIFRvIHN0YXJ0L3N0
b3AgcHVsc2UsIHdlIGFyZSBwbGFubmluZyB0byBhZGQgYWRkaXRpb25hbCBzeXNmcyBhdHRyaWJ1
dGUgZnJvbSBvdXIgbWFpbiBkcml2ZXIuIA0KU29tZXRoaW5nIGxpa2UgOiAvc3lzL2NsYXNzL3Bw
c1gvZW5hYmxlX3Bpbg0KVGhpcyBpcyBuZWVkZWQgZm9yIHVzZXJzIHRvIHN0YXJ0L3N0b3AgcHVs
c2UgZ2VuZXJhdGlvbi4NCg0KPiBIb3dldmVyIHBheSBhdHRlbnRpb24gdG8gdGhlIGZhY3QgdGhh
dCBhIFBQUyBnZW5lcmF0b3Igc2hvdWxkIGJlIHJlZmVycmVkIHRvDQo+IHN5c3RlbSdzIG1haW4g
Y2xvY2sgYW5kIG5vdCB0byBwZXJpcGhlcmFscycgY2xvY2suDQo+IA0KV2UgY2FuIHN5bmMgd2l0
aCB0aGUgc3lzdGVtIHRpbWUgZm9yIHB1bHNlIGdlbmVyYXRpb24uDQo+IENpYW8sDQo+IA0KPiBS
b2RvbGZvDQo+IA0KPiAtLQ0KPiBHTlUvTGludXggU29sdXRpb25zICAgICAgICAgICAgICAgICAg
ZS1tYWlsOiBnaW9tZXR0aUBlbm5lZW5uZS5jb20NCj4gTGludXggRGV2aWNlIERyaXZlciAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ2lvbWV0dGlAbGludXguaXQNCj4gRW1iZWRkZWQgU3lzdGVt
cyAgICAgICAgICAgICAgICAgICAgIHBob25lOiAgKzM5IDM0OSAyNDMyMTI3DQo+IFVOSVggcHJv
Z3JhbW1pbmcgICAgICAgICAgICAgICAgICAgICBza3lwZTogIHJvZG9sZm8uZ2lvbWV0dGkNCg0K
UmVnYXJkcywNClBhbmRpdGgNCg0K
