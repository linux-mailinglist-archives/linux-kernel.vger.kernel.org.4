Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2131D699B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBPRd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBPRd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:33:57 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F56166FA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676568836; x=1708104836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UzbIOQNSNOGdkWlHafBkexNj5aSMrrOBqxZ5tF8sfPw=;
  b=IF3BhJ7GRleiKe8wtGZAMaZnsBMoqDlO19pn3ZRglZ7dRaSgqDpcMB4q
   6TC9LXqW5WB6zv6DWlU9pqRYanaTtn+oG4HDXUtYGN6I+tUAkdlAY0MDa
   VEIrzAl9volsmmGjDgzNb2DjuMMDoB1RsYQVaa3dCVdvNiQrzfvJbb2jh
   znoy3dkIm2CGA8Pdn8lkFBUUW+4WmfqYHrRXAVk5inMzpTtn0KhGoevYu
   EE0TYbE8EC/kiOteAV1N7mtKQGDSBMimQu+gLwnIT3DG0zj4HvaWQGGEh
   s/mGcIWu95eVcAqKxt12JbJhC56vBX5+++7UD+lvMkA2+yvp1ZFhD1aRs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333132020"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333132020"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 09:33:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="779440793"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="779440793"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 16 Feb 2023 09:33:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 09:33:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 09:33:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 09:33:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPdvChLQp5NPjBsb51s8nKF2Dd4fgluTYwFkuc+rEhRqX5CeI/bvIGGA4ddAhR7kFRRv15KAa8GbY4+SYYlhiIczMJRfzeRXLxTS4dZV5GJZwgCvnv0nTa1mYD8pR+GhEEjKeSRxH7nLWJ684zPWlXkO5UY1PQB571MBCzPKdgzukSIHW7s5lA2QaqXt4t0oYhPTTQp71RT0u4/lsAnTnaicEUyRtIMwS2b3Pa8SJKv+S/nBvx4E7HCNqcwVFlIM/2IGbzG/91p/sY4xkb+YespJDo4fDVlrSXXZPCb9RGguzau9BSYfiT9SVA0oI5kitGEKYhQlbvyFslsYyVnYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzbIOQNSNOGdkWlHafBkexNj5aSMrrOBqxZ5tF8sfPw=;
 b=g56sToyI5N+oKrGa/SXXLE2i9By1E7z1+uBGwWhHnkLsWJyUCtc4A4z4MJm0aG951Fm75ViK7Qxf90JzJUHVSPPZrMu8kcNHQ/eYW7OeJNPgYcQADeJB+qvyUOkYNcnSOw97n/ZUPwD/7NrP+6J3AJGG26GbygptCjWSE5lo0okdtaijMSzIv3X/ODTYvv0ZxvfSuEIlYIIz8+Gtos4WwayCk2mGtcBRUpTJ8Y2bUGvxbnzuL3OmEvm0JjCTdxpv2RWy2OIvJdjNkPBoOLmkfb29E/km8/5+/o3FaQB5/BTcaUy+t3THTwrAsoHgAf9cWsUX+yCDDPVvkOtzRFrJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 17:33:22 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 17:33:22 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill@shutemov.name" <kirill@shutemov.name>
CC:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH 1/2] x86/kexec: Preserve CR4.MCE during kexec
Thread-Topic: [PATCH 1/2] x86/kexec: Preserve CR4.MCE during kexec
Thread-Index: AQHZQajuqwnKk7a2c0Cd8swcb05FJ67RUvoAgACDOQA=
Date:   Thu, 16 Feb 2023 17:33:21 +0000
Message-ID: <69763ade82cd7718e709547c977f354dd324e6fe.camel@intel.com>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
         <20230213234836.3683-2-kirill.shutemov@linux.intel.com>
         <bcaf4b7121e20ba27dd2cc2b347feb35ae7bfa53.camel@intel.com>
         <20230216094340.bl3k5q6ine2luhoz@box.shutemov.name>
In-Reply-To: <20230216094340.bl3k5q6ine2luhoz@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN6PR11MB8241:EE_
x-ms-office365-filtering-correlation-id: 82956a96-761e-430f-2651-08db1043e66e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fq+iEKOAHnrtG9Xg2MzjlSvoPEUUEfMxjVL+ySykCSFZLMcRieWISVe+QJM27W+rJkLhA9xeHigndayjcEfqpjmQ9+Ps2zfTStwVo4B8i/JGWDBe6CprU/65b0c2GIEWSAJ2fFiitpfWZCAs9Hb1l8KBEEtJzONVpdeQqaV7wSIpPz1DuNH2+Ljpa0F9G+bVlwk5RqOgN44MJ1RyvkqFYi36/e/5VK9L6wSM+VQEU4oDPqW0o7qBDuwEZMD+T0TaNJAR4UM1WuqAEtUpf8NAlwf74spV0XGyl1sqI7zGNSRB2U7/7bOY9NDymLwyZ1mRM/Wc2wMNZiZFp+NvRspLkaY2ZWYYtKKa2TuT54k7AKQ1AlkY5Nv7frLRvBKbryZhtxnVNRMpXmWigyIOblhWp72v9kJvO/oJ8+Le7LnIId5guQS5/8xZYCXcNYY07alpSWpYXzFrt37m8phItlL8H8a5OToJplm27TobgwPaGEIrA+RoRebGOnCnqMmglyNJnorD9E7QwS+ScTlzLWy14MPXlA3gi+3r242F6sMd4HlVGeLJvp46JogJbhkepRIcNgnFOzEcjH0jAPMx8goEeFCfA0vyhkCw1MN9uThkHthM+mllDl+xKweUT819tAsHpxGsiXPQX0gg40ESO7JLOEc/GfPlkAxIKJMv02RRhs2Q7wr2WFZlC/9z8geUKel/WfXuMt1gIx5d8bfHqktHxhzATINTehfKJL9NoShUR1E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199018)(5660300002)(8936002)(2906002)(54906003)(66556008)(76116006)(64756008)(8676002)(6916009)(478600001)(41300700001)(4326008)(66946007)(66446008)(71200400001)(66476007)(316002)(36756003)(82960400001)(2616005)(38100700002)(122000001)(6486002)(6506007)(86362001)(186003)(26005)(38070700005)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVZOUGtyWHRKcXBkckxEbGJJVGxnV2FpeGtHZU13TjhyYUNMVEgyNTdZMDlm?=
 =?utf-8?B?OXlrVUZjRlN3QmttbFhGeVJDQ1BPU1VUUVVvRHRlU0NaNC9za29UbWRTd0V3?=
 =?utf-8?B?MzNxNHhFV1ZHVGZuQWY4L2J4NUVoYmgvVkplZWJBLzdQNXNYeS9SaGVuTDVy?=
 =?utf-8?B?SWNHV25FNUhqdEp0L0dRUy9qQzVSeXh3WTAxWTJxc0w4ZUdUUXN1L3pnNVRE?=
 =?utf-8?B?TnhNNFdoT3AzVUh0RFN5bzAyd2JkRFNick80cFVvY2hWVWg4MlhoazFvRy8y?=
 =?utf-8?B?aFRzcnBoenlPemNIdnB3UG4vL3h1a1phekZ1Mkhjb0wxelZMUkRENUFSZWNh?=
 =?utf-8?B?RDlwK2dNZWxDSTJ3bmdWeFB3aTJzbXVTYWp2bFh2YmJQQzdzRHJ5VTRla3Vr?=
 =?utf-8?B?YUpwWU5UdzUrTDNvVS9tcGxEQTcrVnI3N0RoWjFORXcyVGc0UDBhVzV2UXc1?=
 =?utf-8?B?RmVxMkJ1T0t0WnJiVWpFcFA1RDdQbzBJRWVMZjN4ZkpxUXpabWVuUWc1dktJ?=
 =?utf-8?B?Uk5vZTBXRk5DMUkzdk9BbXhTaGZzYjlWZmJ4NTY5eXlMRUlXWlRMZHdzUCtH?=
 =?utf-8?B?VFdQMC94Z1JVbTRlUWFiRFV4K0FIZERIc054Z3hnK0trbUpNYlhwSkxYOE0y?=
 =?utf-8?B?eFlaRDBsZy81VDBaQTFIemp2OXU3Y3lWVmNrL2lhdUJLK2xnL1Z1RmV3ZUQ5?=
 =?utf-8?B?WWRJQklhMUltYVdUaFdwM2kxWDMrRUpHM3pTWGxBZ1R6azU3SjMycXBvZGpx?=
 =?utf-8?B?Sm85K1IwbkVlWUJJUW9yd0VYMjA0bEE0algrSHVSN1FUYUpWM1VQTXNLUGlJ?=
 =?utf-8?B?ZXFZUXN3T1oyUWM1dmdYTStqZG8wdVNRdVQ0YlQvNUNNYnNwdmRpS2E4S0c5?=
 =?utf-8?B?SGJNRERMWXhoa2tKYlNJa1M0dGxUZXp1cEdqd0o1VVlQcWtCRXpIcUE4djVP?=
 =?utf-8?B?bk5JTXNiOGVXU1lQcmJ6ZUdtVVVKbjhZUnArZHFHODFlMEp0c0h4SmZpT05R?=
 =?utf-8?B?RThBcERlVExYbjN5eFcrcWlWNnhGYldnTDJQV2tKbTJ4clFWaXlCbkRyenV5?=
 =?utf-8?B?QUU0UFdyYzdZenlRcSs5SENLclZOMXB3V3V3eGpWZ3o2ZWk3djQyeTRuWmhk?=
 =?utf-8?B?Rkk0OWxwMTBVTU43cWhLRWp3Nk5HaWZzUmdrdFZuUS9BSys2Ym5hUnNQSFhQ?=
 =?utf-8?B?QnR4U2V6YlpTMjZRSUdZdDVoS0tCUTFDYVFiM0tBSkd4Z3B2bFdheVliQmtV?=
 =?utf-8?B?cHB2UHl0NUY3YnNFQjl4VU9pcHVlbi84QlVXSEswOVBzNnB1cE9KUS9zd3Zq?=
 =?utf-8?B?WE9UWE1yV0hpUDFyaUUzek1TU3ZnWS9YMlFvWm5YR3FKWkl1UTRkZm9Pa0VL?=
 =?utf-8?B?TVh1ZDQ0N2pQdVBsVWdxNkUwMWlOZDRQUkFYNTk1blVoT3FtczN6b21XQW9O?=
 =?utf-8?B?dElJQmNuaUNEY0JCbU0rbTdiUHJYaUtvaVlHYVo2eThONWVtVnZRSVRpd0ZI?=
 =?utf-8?B?SnpSV1A1UFJhMHNRamg0czZOZ1JOSVlLOXpLSUcrUUtDU0NGTjh5eUYrdDhX?=
 =?utf-8?B?dHRURlVYcG9TWnV3cC9TaVdOZXI3NzFwR2hTbDBzWHlXYlB4TGxTdEdwVy9q?=
 =?utf-8?B?Q0xXMFdPWElGQUY4YlhRQjhEL1pqTG9ES0pnUGpEdEd5eTZrWmRwaUowZjVY?=
 =?utf-8?B?WG5XWTFLbUR4cHRUYiszUjJOSGdUVXJBYTRldzhsWUxLZGZKSVBrMVdHZ2Iy?=
 =?utf-8?B?VDRsbjI4Mnk5Q3J2UUZ2cXhVM0ZGalNrWXNhTW1XdjlNcnZ1MlVMU1ZsbGc2?=
 =?utf-8?B?QVlCcjk1Sm4yUHZWeGtHNU44bE85akxkc0gzMGdrVjgzM1cyZjV3QlRFdXVD?=
 =?utf-8?B?b1RlUmpsb2tuN2tXc1d0bnV1SmJGVFQ0M0ZVcUZGL2VncDdCaGErREpxbHg3?=
 =?utf-8?B?ditHaHlqdWtIRjVjbk5sOFllMTdpcVdhdDFFVGVkcC9KT3UydjF1M1pjb1lq?=
 =?utf-8?B?eXI0djE4QWlvZDJtTVEwS0lEaVlnd0xNblRQQ3VCVEhYVGlrMEI5MHlsYVBy?=
 =?utf-8?B?cFp1RW9EV3Mzd0ZxM2hPREp5WjNYSTY2UlFsblNpUEV2cHhqYWk1amlkNFRR?=
 =?utf-8?B?K0dqdnphaDdOaWlvYTJ6T3JPTm1KVUEySkx5SzBobWxDZlo3Y1h5eGZLZU5h?=
 =?utf-8?Q?FO+ADvilWe+FWS08Gg+4X6o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F231D9F98DC9CA48AFED3C4061758D6E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82956a96-761e-430f-2651-08db1043e66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 17:33:21.7263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1kzRrYIsPivixRu8JccDEFQKYDBLUX0qbyOTHzwHrxi9Rkro5gfIoY+j6yMgAvOT3gMyyhjRyYdni93D16Ai+lzAhXr1zkIWSonkGRH19k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8241
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

T24gVGh1LCAyMDIzLTAyLTE2IGF0IDEyOjQzICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIFRodSwgRmViIDE2LCAyMDIzIGF0IDAxOjQ5OjM5QU0gKzAwMDAsIEVkZ2Vjb21i
ZSwgUmljayBQIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMy0wMi0xNCBhdCAwMjo0OCArMDMwMCwg
S2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPiA+ID4gVERYIGd1ZXN0cyBhcmUgbm90IGFsbG93
ZWQgdG8gY2xlYXIgQ1I0Lk1DRS4gQXR0ZW1wdCB0byBjbGVhciBpdA0KPiA+ID4gbGVhZHMNCj4g
PiA+IHRvICNWRS4NCj4gPiA+IA0KPiA+ID4gUHJlc2VydmUgdGhlIGZsYWcgZHVyaW5nIGtleGVj
Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPA0KPiA+
ID4ga2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gPiANCj4gPiBJIHdvbmRlciB3
aGF0cyBnb2luZyBvbiB3aXRoIHRoZSBwcmUtZXhpc3Rpbmcgc3dpdGNoaW5nIGJldHdlZW4gZWF4
DQo+ID4gYW5kDQo+ID4gcmF4IGluIHRoaXMgY29kZSBmb3IgdGhlIGNyMCBhbmQgY3I0IG1hbmlw
dWxhdGlvbnMuIERvIHlvdSBrbm93DQo+ID4gd2hhdA0KPiA+IHRoZSByZWFzb24gaXM/DQo+IA0K
PiAzMi1iaXQgT1JzIGFuZCBBTkRzIHNhdmUgb25lIGJ5dGUgcGVyIGluc3RydWN0aW9uLiBBbmQg
dGhlcmUncyBubyAzMi0NCj4gYml0DQo+IE1PViB0by9mcm9tIGNvbnRyb2wgcmVnaXN0ZXJzIGlu
IDY0LWJpdCBtb2RlLg0KDQpPaCByaWdodCwgSSB0aGluayBJIHJlY2FsbCBub3cuIFRoZXJlIGlz
IGEgNjQgYml0IEFORCBpbiB0aGUgQ1IwIHBpZWNlDQpoZXJlIHRvbywgd2hpY2ggb2YgY291cnNl
IGlzIG91dHNpZGUgb2YgdGhlc2UgY2hhbmdlcy4NCg0KQnV0IG90aGVyd2lzZSwgaXQncyBub3Qg
Y2xlYXIgZnJvbSB0aGUgcGF0Y2ggd2hhdCB0aGUgaW1wbGljYXRpb25zIGFyZQ0Kb2YgbGVhdmlu
ZyBDUjQuTUNFIHNldCBmb3IgdGhlIG5vbi1URFggZW52aXJvbm1lbnQuIEkgc2VlIGluIGhlYWRf
NjQuUw0KaXQgd2lsbCBjbGVhciBpdCBkdXJpbmcgYm9vdCBpZiB0aGUga2VybmVsIGRvZXNuJ3Qg
c3VwcG9ydCBtYWNoaW5lDQpjaGVjay4gU28gaXQgbGVhdmVzIGEgbGl0dGxlIHdpbmRvdyB3aGVy
ZSBDUjQuTUNFIGlzIHNldCB3aGVyZSBpdA0Kd2Fzbid0IGJlZm9yZS4NCg0KVGhlIHBpZWNlIGlu
IGhlYWRfNjQuUyB0YWxrcyBhYm91dCBob3cgYW4gI01DIHdpbGwgY3Jhc2ggdGhlIHN5c3RlbSBp
Zg0KaXQgaGFwcGVucyBiZWZvcmUgdGhlIG1hY2hpbmUgY2hlY2sgc3R1ZmYgaXMgZnVsbHkgc2V0
dXAgYW55d2F5LCBzbyBpdA0KZG9lc24ndCBodXJ0IHRvIGxlYXZlIGl0IG9uLiBJcyB0aGF0IHRo
ZSByZWFzb25pbmcgZm9yIHRoaXMgY2hhbmdlIGFzDQp3ZWxsPyBJZiBzbyBpdCBtaWdodCBoZWxw
IHRvIGFkZCBhIGxpdHRsZSBtb3JlIGFib3V0IHRoZSByZWFzb25pbmcgaW4NCnRoZSBjb21taXQg
bG9nLg0K
