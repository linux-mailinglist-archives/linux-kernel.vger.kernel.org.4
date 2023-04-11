Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332186DD0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDKEE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjDKEEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:04:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9F81BE8;
        Mon, 10 Apr 2023 21:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681185893; x=1712721893;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JdSLOVJOJXisEbMEj1PVRdxm5FZmZmtNi+PpyTo9pB4=;
  b=JRK0O7SsOHb80pt9mlItUyPNxWLLeoBtBJilyaURz6tGTyr+a5eHl44S
   2xrEn36HuWRnMIUumgi2f4MEQ8qTJOvWp0duMfh5iA5MAPVaRP+vqAXv+
   14U78wR62X+o8PnbGanJ1FY9n5g5CjT72vUcuH3TkGTiuPz9H0vzG3QDt
   X+ghZBXlGAY4JpN6MheEXCsUVIRlVi6Qi3n+07RiFkLHVST9IS+83ZuAd
   /ktIgyqsu2RE+T/okGT9l/eIqd3zBmhuJPai0Pd0drxWii7qdsL/X5Z2U
   uIliQzukPl0/lf9tJraG7A6T2Jo7NFCVdQDy8nhLvoDpaLSrVwjJLnYMj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="327616835"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="327616835"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 21:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="752994976"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="752994976"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 10 Apr 2023 21:04:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 21:04:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 10 Apr 2023 21:04:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 10 Apr 2023 21:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRjICFv/8CE2Q1rvttFVnA01qSBB46nVbHbbGEC/mvFNnjci8me6IIXD+rWOrBIlS+Hxp4RsY83e80bu/mV/x0GlfJsN1kPJudxWgHO5xgVj1aZ7l8b2SJKhyrHRHRS/9fdYa7+ryxaSBDxHk+M0ErwJL5LcDA+VhqBDI8eTWQW0ygItD+FOhPiAyydNRsRiEFKzUowHO9Rtss7h4xJKgkS2dlDj3oqMRrBO1RWkGRaWQ/ayPZ3SilshXXt042ANExwPNUYjq54POT+RWx2rXoUSwOJytKHYv39o1Y1DPQNSd29nVNrqg6ELLkQbukxAIRWl2B5O6hU88fn4sxUbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdSLOVJOJXisEbMEj1PVRdxm5FZmZmtNi+PpyTo9pB4=;
 b=Ue+jLNT1nXDrQ3QN49iPFexsZUUxAr1L0r6vJw88TY0XuPpXhduYjQ6U91K4iCMAecEnzjF+QrRmutFBVhaBPBqVY0nWk9PsUjZW1WB66RVnP65IZ7pE4PIhQgjZGPn4cFK1hmboq3loJkVDWTCYP2ILv2VPrCsXPWTxm59LzalnEPhDzRML57i+HWNgphOun5sGEhQ+MZOXg7y5dxFyeDtVcwqzvWM4Yo3mrKRyxWPUc1o5C9mwDZg3ODyOpYSLwsrKtJVsmcg57FWmuIrOatEVjcM+t07sIV0Z4wrO6JZyn0lWH2jQ0PduBpS0m2JD2Ptc6AfdDT/MOU7M1w9vbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 04:04:45 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0%5]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 04:04:45 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "urezki@gmail.com" <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Topic: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Index: AQHZaiXby4kI/lAQlUSTC1cR7UMpS68lNdWAgABJBmA=
Date:   Tue, 11 Apr 2023 04:04:45 +0000
Message-ID: <PH0PR11MB588072A12543FD617C833AF9DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230408142517.800549-1-qiang1.zhang@intel.com>
 <b96953b0-0ac5-477a-a2f0-c211dc17d5dc@paulmck-laptop>
In-Reply-To: <b96953b0-0ac5-477a-a2f0-c211dc17d5dc@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA0PR11MB4720:EE_
x-ms-office365-filtering-correlation-id: 33ec2cc7-8420-4ec9-d0a9-08db3a41e2b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LdssZHwHmLkgLN0nDGdfBFp5WLUund14+slw2a2RoedaIr6jqg76RaCk0AgyHEFYyVv/vkXSzTL9BBauvI1odwjYAZyDn0zEqJkiyprrVioQqwmuCNHr5fVNxCklO4TzoxodJnYkEuE7Zzh7hHLxhil9Sph55ijLKsTzhIQAmdqlnWeykTjmxw9vA0RcWk/5KJCNc9Wte5jA+HCzZdDH4IsXt2hcmYXBmwM2d6vv4br3KnpZCR7CQm0g9q5zYW8jk7ikxEwq+raDybT9BetRX0Ru0i7s7gL4GzKBcw8CAMu144zpSF84DOeGauecsm/qQoIPyph1bceQ2XfAqABN3GLLgER/U/jNzKxnayvCpEKLsy4nCNr+sg8BFRr5S5q7XQdlWRS38I8XHUcDQl0D3vCS9+pfojR3ba5S1lDlWBuZFxq4qt6khRxsu4z4qaO0TrnSfVjioOFQcE2MLjdk3LFIhlGn/XgZlHZeFHTwvO12qe1dDTILJwSDdAPwkf5qjfzCC5F2dRb2D9wz0z+HuUqA3Ks7Bab/Qhj0Y8YkVWh5EGIAokg2nPTzZ/b6rfahIZ4V8kYP20mjGt1h5+nAIKMbp5fZIVi0L6mJ8nn7qubCpHD8SNe31MgMeGLTjypI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(71200400001)(7696005)(478600001)(316002)(9686003)(26005)(6506007)(186003)(54906003)(2906002)(5660300002)(4326008)(66946007)(76116006)(66446008)(41300700001)(8676002)(6916009)(66476007)(64756008)(52536014)(8936002)(66556008)(38100700002)(38070700005)(122000001)(55016003)(86362001)(83380400001)(33656002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUdJN1d5bnpoY2daOG15MkNkR2svN0FWcFFxQ3YvUkZaT1h1S2xRZkJmVkxB?=
 =?utf-8?B?RDc3dSsrU3hzZG8vcEhuREJWVFg2VXZkY3RTV1QwUDNhWnZQUHNIN2x3Q25V?=
 =?utf-8?B?blNjTmtvNVRUZ3NiZDYwZzlwL1FYZy94M0gxS3pLOUJSZ0dGdTZGTm5UMGhJ?=
 =?utf-8?B?aUNOQmJZckJqeFN1KzN1Vkt5akV5ejRkSXN4c0gwcklkRGx4a0FDYjhjYzFn?=
 =?utf-8?B?a0IzdjgxR3NveUI3U0JKdFpnVTFnMjBrRVYvMnhLcEJhQUxWUU40Q1lxNGlq?=
 =?utf-8?B?bUx2SzdLV2pkMnRIYS9lSW1WUklWWGxTcC9IeXBJWmMrZlNJWWd2eUw3MDZo?=
 =?utf-8?B?NVk1TGd2SmV6YkhiY3BSTTJqemFpZ2k5RlkvK3FwdjJzbXA1Q3BKdDJaYmF5?=
 =?utf-8?B?eGg1cVhCZjRLVmFFdXFrS1ZCRFZMTFVybG1BeFZVZFNHVVBLWnFPYmwxN0tp?=
 =?utf-8?B?VTNOcmdrTmtiK1RRaUZxU0lsSDhWdFUySkVMK1paVCtmam9hNmF5RDZSalBV?=
 =?utf-8?B?QzNtNEhBMVdwUXlXUGQ0OHpyQys5WmtKc1p5Uk02dHlQN3VZeERVRlhtdEhN?=
 =?utf-8?B?Y1gydVJ6MWZLenkyUllqOXN4anVuTjIvcFRBUGRUTEJNRHMrUDhFRFhVdnhy?=
 =?utf-8?B?VUZ0YmxVeFhqVlpEaUlNSWp6VE5ESlFJRmxESmdlSkNFUkFWZW1UTTM0aTJU?=
 =?utf-8?B?a0pmN21SUnpYMGtlQTFoU3lxQmIzZ1BKY0dkcEdGN2ZJZVZ5YzRDSE1pRlZM?=
 =?utf-8?B?L1dHRUNHTkdDNkRsYzBLSUg1Zy8wbzVjWUZTbXlaQ284NkZuMm8wK0ZKa1R6?=
 =?utf-8?B?c2Z2MExieHpxOCs4c05CMy92VGlYVHErdllGbmRYTXN5b1RsNnJHQURhNWp2?=
 =?utf-8?B?MnV6dHMzZG9YYlZPY0kwbjRFSzROVklFcE5rVWZ6TFBiUmhJTVZlNldHc1RO?=
 =?utf-8?B?Vm1qZThLS1dDNlMvMWNxQVFuWkhGN3RDNzhpMjNHUGc3U1U5U2ZtQlZJSHox?=
 =?utf-8?B?WVJzWVhiUzdHM0tTOHJja2wyY2xwM3FrNG5TK29CUWJXWHE0WEdlRDYyUFVs?=
 =?utf-8?B?WWdnRnlXckVIdzAzcmdIemhyUFFyZWFMWFdxNm5TR1dMRmJBVFNjVjBlNmxE?=
 =?utf-8?B?VnVHT3NoUlR0andneGZzRXlxNCtpOG9zZkVtbFRDSldCTFM0azE1OVI0RUdV?=
 =?utf-8?B?WHczbXZHQ2tvcGZ4Qk5GcmthUHZxVWQxTUlkQzdYWUp1VjJPVUF5d0J3cjFF?=
 =?utf-8?B?RGI5UjZSVVFldlJPa1RtcTl3WEpDd2o4blBXMHZ5c3h3N2wrR2ZxSG1ENElu?=
 =?utf-8?B?VkR0M0xuVTgvbXJwMklMVHl1NHBibUJzeHNFaXhwS3I0blRHWHd1TUZkR2tF?=
 =?utf-8?B?RWRZTmc0MkFEN2RXRWJqRFR6OVEzZjJlbWV5eGRJOTYyVmpmTWk4YURZK2s4?=
 =?utf-8?B?SmlBcUtSZzFzMnRXdEV3T0dDL09KRUZDc0ZhWGRVMnBoUlh3MDBiZ0tWTXdk?=
 =?utf-8?B?dVlETXlJRWU3VTZncnliWGdEQ0xCV3RMQlI4VlpoSGkrLzQwaFZyWnFRbGtN?=
 =?utf-8?B?NGt3UmFnSCt4UjlOeEQ1dWNOTVhCY3NxR1JwUVF2ZnJPMjJWRFpoZE5YY2tZ?=
 =?utf-8?B?TGhqQWx4M1VOVmxPMEtJQ3NpMVVWNno2TnFXUG9kU1ZsOERWdXRWZnZuUHps?=
 =?utf-8?B?bVNWTlY3VlYyN2E4R292WVRWWkNHY1Y0Rk1objBON2p1dlJ2a3ZXUFpRZlQ3?=
 =?utf-8?B?Q05BNTNwS3dFczNPOFF3RGNWYWlzUXlxNmpENHR1UHhkb0pwZXNTU2p5TkxN?=
 =?utf-8?B?c1NpeGVJbjZudkZhNzljQVNacmNRMmxLQ2tsNjJUOWxUYVBneW16ck52TzFs?=
 =?utf-8?B?YW95OXl4TXJWM2YvL096K2ozZWRrdHZ1Z3BnWGcxUXBOa1dCdFBSZVc3Nzhm?=
 =?utf-8?B?aUo5WXpuVHdhWC8rMTZkTHN6NURWYllCbG11cWlLQ29VWXNaMzJkcmRxa1Bp?=
 =?utf-8?B?TkRDQTJYbkE3VWZUeCtUaVJxeG9kTXN0dXlTc1p2UldvNm5Ub0trMFh0eldZ?=
 =?utf-8?B?ZVpTOWExdDB5ekNOUmJSdHdVdGhBK2tXU0cwNGdQUUZXbWhUbHhzWUxkamRR?=
 =?utf-8?Q?P09iAGgCdxX/w7lw8OkY8ZDJh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ec2cc7-8420-4ec9-d0a9-08db3a41e2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 04:04:45.4073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YuNgq9b5B4ZrYZb/07QG/giWpdQ40W9xVLL8TaWfM0w/sTN5DAwgtxj4x4LQq8yAzOaXOaf4O/oI2zuJVktweQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBDdXJyZW50bHksIGluIGtmcmVlX3JjdV9zaHJpbmtfc2NhbigpLCB0aGUgZHJhaW5fcGFnZV9j
YWNoZSgpIGlzDQo+IGV4ZWN1dGVkIGJlZm9yZSBrZnJlZV9yY3VfbW9uaXRvcigpIHRvIGRyYWlu
IHBhZ2UgY2FjaGUsIGlmIHRoZSBibm9kZQ0KPiBzdHJ1Y3R1cmUncy0+Z3Bfc25hcCBoYXMgZG9u
ZSwgdGhlIGt2ZnJlZV9yY3VfYnVsaygpIHdpbGwgZmlsbCB0aGUNCj4gcGFnZSBjYWNoZSBhZ2Fp
biBpbiBrZnJlZV9yY3VfbW9uaXRvcigpLCB0aGlzIGNvbW1pdCBhZGQgYSBjaGVjaw0KPiBmb3Ig
a3JjcCBzdHJ1Y3R1cmUncy0+YmFja29mZl9wYWdlX2NhY2hlX2ZpbGwgaW4gcHV0X2NhY2hlZF9i
bm9kZSgpLA0KPiBpZiB0aGUga3JjcCBzdHJ1Y3R1cmUncy0+YmFja29mZl9wYWdlX2NhY2hlX2Zp
bGwgaXMgc2V0LCBwcmV2ZW50IHBhZ2UNCj4gY2FjaGUgZ3Jvd2luZyBhbmQgZGlzYWJsZSBhbGxv
Y2F0ZWQgcGFnZSBpbiBmaWxsX3BhZ2VfY2FjaGVfZnVuYygpLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPg0KPk11Y2ggaW1wcm92ZWQhICBC
dXQgc3RpbGwgc29tZSBxdWVzdGlvbnMgYmVsb3cuLi4NCj4NCj4JCQkJCQkJVGhhbngsIFBhdWwN
Cj4NCj4gLS0tDQo+ICBrZXJuZWwvcmN1L3RyZWUuYyB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9yY3UvdHJlZS5jIGIva2VybmVsL3JjdS90cmVlLmMNCj4gaW5kZXggY2MzNGQxM2JlMTgx
Li45ZDlkMzc3MmNjNDUgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jDQo+ICsrKyBi
L2tlcm5lbC9yY3UvdHJlZS5jDQo+IEBAIC0yOTA4LDYgKzI5MDgsOCBAQCBzdGF0aWMgaW5saW5l
IGJvb2wNCj4gIHB1dF9jYWNoZWRfYm5vZGUoc3RydWN0IGtmcmVlX3JjdV9jcHUgKmtyY3AsDQo+
ICAJc3RydWN0IGt2ZnJlZV9yY3VfYnVsa19kYXRhICpibm9kZSkNCj4gIHsNCj4gKwlpZiAoYXRv
bWljX3JlYWQoJmtyY3AtPmJhY2tvZmZfcGFnZV9jYWNoZV9maWxsKSkNCj4gKwkJcmV0dXJuIGZh
bHNlOw0KPg0KPlRoaXMgd2lsbCBtZWFuIHRoYXQgdW5kZXIgbG93LW1lbW9yeSBjb25kaXRpb25z
LCB3ZSB3aWxsIGtlZXAgemVybw0KPnBhZ2VzIGluIC0+Ymt2Y2FjaGUuICBBbGwgYXR0ZW1wdHMg
dG8gcHV0IHNvbWV0aGluZyB0aGVyZSB3aWxsIGZhaWwuDQo+DQo+VGhpcyBpcyBwcm9iYWJseSBu
b3QgYW4gaXNzdWUgZm9yIHN0cnVjdHVyZXMgY29udGFpbmluZyBhbiByY3VfaGVhZA0KPnRoYXQg
YXJlIHBhc3NlZCB0byBrZnJlZV9yY3UocCwgZmllbGQpLCBidXQgZG9lc24ndCB0aGlzIG1lYW4g
dGhhdA0KPmtmcmVlX3JjdV9taWdodHNsZWVwKCkgdW5jb25kaXRpb25hbGx5IGludm9rZXMgc3lu
Y2hyb25pemVfcmN1KCk/DQo+VGhpcyBjb3VsZCBzZXJpb3VzbHkgc2xvdyB1cCBmcmVlaW5nIHVu
ZGVyIGxvdy1tZW1vcnkgY29uZGl0aW9ucywNCj53aGljaCBtaWdodCBleGFjZXJiYXRlIHRoZSBs
b3ctbWVtb3J5IGNvbmRpdGlvbnMuDQoNClRoYW5rcyBmb3IgbWVudGlvbmluZyB0aGlzLCBJIGRp
ZG4ndCB0aGluayBvZiB0aGlzIGJlZm9yZfCfmIouDQoNCj4NCj5JcyB0aGlzIHJlYWxseSB3aGF0
IHdlIHdhbnQ/ICBaZXJvIGNhY2hlZCByYXRoZXIgdGhhbiBqdXN0IGZld2VyIGNhY2hlZD8NCj4N
Cj4NCj4NCj4gIAkvLyBDaGVjayB0aGUgbGltaXQuDQo+ICAJaWYgKGtyY3AtPm5yX2Jrdl9vYmpz
ID49IHJjdV9taW5fY2FjaGVkX29ianMpDQo+ICAJCXJldHVybiBmYWxzZTsNCj4gQEAgLTMyMjEs
NyArMzIyMyw3IEBAIHN0YXRpYyB2b2lkIGZpbGxfcGFnZV9jYWNoZV9mdW5jKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykNCj4gIAlpbnQgaTsNCj4gIA0KPiAgCW5yX3BhZ2VzID0gYXRvbWljX3Jl
YWQoJmtyY3AtPmJhY2tvZmZfcGFnZV9jYWNoZV9maWxsKSA/DQo+IC0JCTEgOiByY3VfbWluX2Nh
Y2hlZF9vYmpzOw0KPiArCQkwIDogcmN1X21pbl9jYWNoZWRfb2JqczsNCj4gIA0KPiAgCWZvciAo
aSA9IDA7IGkgPCBucl9wYWdlczsgaSsrKSB7DQo+DQo+SSBhbSBzdGlsbCBjb25mdXNlZCBhcyB0
byB3aHkgd2Ugc3RhcnQgImkiIGF0IHplcm8gcmF0aGVyIHRoYW4gYXQNCj4tPm5yX2Jrdl9vYmpz
LiAgV2hhdCBhbSBJIG1pc3NpbmcgaGVyZT8NCg0KDQpObywgeW91IGFyZSByaWdodCwgSSBtaXNz
ZWQgdGhpcyBwbGFjZS4gDQoNCi0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jDQorKysgYi9rZXJuZWwv
cmN1L3RyZWUuYw0KQEAgLTI5MDgsNiArMjkwOCw4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbA0KIHB1
dF9jYWNoZWRfYm5vZGUoc3RydWN0IGtmcmVlX3JjdV9jcHUgKmtyY3AsDQogICAgICAgIHN0cnVj
dCBrdmZyZWVfcmN1X2J1bGtfZGF0YSAqYm5vZGUpDQogew0KKyAgICAgICBpZiAoYXRvbWljX3Jl
YWQoJmtyY3AtPmJhY2tvZmZfcGFnZV9jYWNoZV9maWxsKSkNCisgICAgICAgICAgICAgICByZXR1
cm4gZmFsc2U7DQogICAgICAgIC8vIENoZWNrIHRoZSBsaW1pdC4NCiAgICAgICAgaWYgKGtyY3At
Pm5yX2Jrdl9vYmpzID49IHJjdV9taW5fY2FjaGVkX29ianMpDQogICAgICAgICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KQEAgLTMyMjMsNyArMzIyNSw3IEBAIHN0YXRpYyB2b2lkIGZpbGxfcGFnZV9j
YWNoZV9mdW5jKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCiAgICAgICAgbnJfcGFnZXMgPSBh
dG9taWNfcmVhZCgma3JjcC0+YmFja29mZl9wYWdlX2NhY2hlX2ZpbGwpID8NCiAgICAgICAgICAg
ICAgICAxIDogcmN1X21pbl9jYWNoZWRfb2JqczsNCg0KLSAgICAgICBmb3IgKGkgPSAwOyBpIDwg
bnJfcGFnZXM7IGkrKykgew0KKyAgICAgICBmb3IgKGkgPSBrcmNwLT5ucl9ia3Zfb2JqczsgaSA8
IG5yX3BhZ2VzOyBpKyspIHsNCiAgICAgICAgICAgICAgICBibm9kZSA9IChzdHJ1Y3Qga3ZmcmVl
X3JjdV9idWxrX2RhdGEgKikNCiAgICAgICAgICAgICAgICAgICAgICAgIF9fZ2V0X2ZyZWVfcGFn
ZShHRlBfS0VSTkVMIHwgX19HRlBfTk9SRVRSWSB8IF9fR0ZQX05PTUVNQUxMT0MgfCBfX0dGUF9O
T1dBUk4pOw0KDQoNCnRob3VnaHRzPw0KDQoNClRoYW5rcw0KWnFpYW5nDQoNCj4NCj4gIAkJYm5v
ZGUgPSAoc3RydWN0IGt2ZnJlZV9yY3VfYnVsa19kYXRhICopDQo+IC0tIA0KPiAyLjMyLjANCj4g
DQo=
