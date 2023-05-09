Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCE96FBFC0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjEIG5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjEIG5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:57:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641BA187
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683615461; x=1715151461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UAOryDklU7xXPgu1cUjVazPThrilIHugixcg028juvE=;
  b=NE1sCT7+NgHpBrrgsKTgowhM0bu5BEukvcKJ+ZHaabd6T755e0/69Zjt
   QeA4J8s2aKrstxTU/vUfcEdaXbCF3HNHz/RUYmwuGcl4GxlMEp007VuWX
   MJX4avyNfilLuozKHNaqjrdo3Z3UUE5H6VBTLoLYIwyzUBc5zY8oz0CHM
   6VW5PWluRN4RjzBlGg6vbynud6EOtwSa95HI7KKm52pEgsGh7f3yHKgKs
   3W/JRUI2FqIFwyFhGyHlc53+SzNYwZQN3/+LTraImLbALOylpC6HyiRUn
   D5TfwCGcIXERa0uVlgrhYvXlF0lgWlcgOPuXZgzRGjmYGJwqlUeaF/WTm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="413091700"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="413091700"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 23:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="842985207"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="842985207"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2023 23:57:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 23:57:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 23:57:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 23:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfDrK8Yc/9FQbfLQdQqsdMROD74KSC2mJX35IDEB9plFe/Qdi9lsZebzaayQsHH91aguqFiP8PnZyO8GLIxdOEBH0ZSCkRrKYFXMhAokBF9UHtoh30ihdsbtgygz/hxqkxTi9WnOPwzOESCZ64Tex7qzavWQ8jlbo4cFWojOA+D3DziVE5l7MzAzS6H0Xx/ew/2itrqq+4siyvIuoNCcHoaP2HV9OSeEy5m2bpWTFrV/ZRzIy3xvNrmh1opOSVcKPoxeCUF4CpE0fJnxnPybftBOlnK/xpuWw0ycEbZlXbhBN+R/XNBfUMDICEvZotlLsN1fl98evKS0hslFIhwjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAOryDklU7xXPgu1cUjVazPThrilIHugixcg028juvE=;
 b=Qwm68cmGev/X2YoNFM/0XDCqiIaX4gEnRHGWEdJxWFxmaeunkcZRdCWTUm5JwcUx3EjReI5XHtICLzxCwwvspTj5tG91TcFGpzWyg4yvlScLYF52YSKa8i+3K1oQP5qb118i0V9n2Hav6cu25S53TtvQGqbCfYRQHBnbK7UxX3ywh34HHLrfwTIHUamcF2qcvzvgO3zwe883oAXlk1QGEBmv+Nz1YGBaUch28SP0z1GbkTfDVVExlpqn7ILjyN7hZkCwFjRYKXqqyUIrCImjpvgpvtu1LkYOlOl+niofJoba7N4WWy5QCkQfTR64HESSnUKN5Qnaez+HSzjVo0SX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by SJ0PR11MB5677.namprd11.prod.outlook.com (2603:10b6:a03:37e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 06:57:32 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 06:57:32 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
CC:     Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] locking/qspinlock: Fix state-transition changes in
 comments
Thread-Topic: [PATCH 1/1] locking/qspinlock: Fix state-transition changes in
 comments
Thread-Index: AQHZf+Q5H6HapMWcmkmbbiivYiqfDK9Qg9kAgACiV3CAABaEgIAAOucQ
Date:   Tue, 9 May 2023 06:57:31 +0000
Message-ID: <IA1PR11MB6171282A1E2CF22740398F8989769@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230506062934.69652-1-qiuxu.zhuo@intel.com>
 <10d3a11a-8591-e49d-e010-867a05078ff0@redhat.com>
 <IA1PR11MB617110DB70F92AFC0D40D26089769@IA1PR11MB6171.namprd11.prod.outlook.com>
 <3e580bf2-2c76-739e-7636-4aa03f5628bd@redhat.com>
In-Reply-To: <3e580bf2-2c76-739e-7636-4aa03f5628bd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|SJ0PR11MB5677:EE_
x-ms-office365-filtering-correlation-id: f9880ab3-5d6a-43dc-a910-08db505aa8ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cyd9nZBzjMvyCnowUdnFlKRf5/Gs+Bsb2bCitB5m6YGDnadeMP4Z+ctDB8LJUihUYmNfpdAoAv+ecvVYovKGPQU+P9G2hugtoscd1Ym5azC9rI74yT5yeAZk4ONsrCgXQuJP7t9bL98GFxiowJ9n+iimqbyk74kUuj6bplz8Nj6wZDFKkx5qET7JXoL61Y0XnVzc4GxN7GwvliBiWkO6SVJB8WrJ9rOzyO4/mLXLGVDvwFos+eD2T7ELRVO9dkPLeLUAMUD1VlVCS4CyncXPnsZEXOV1NpSXDQxQz39hV9un6ChYUBbSN+LZOZOq5kDTtQBOvJD5OSTkSdiJ4C+9q+wbxmVt1H0tJFDQ6E15Q8UQCetwQC6tst0Iz8WbLHlC3lk2mc5u9vxx2aw+ihJ1UhAKyK5K/JOmWCs67oc86Hs5Ki6ZgsSXreZWhhZe9IpDgWgG6L67BVsQ88cyqtxb4XZ/vKmWZpN1bTkxc7UZuyD0YlzmsJruWGbdyfl6HdhXADU1tD22JDMH+sKs0CXmLePS5CfBqrS8zS5z37AkZZe2bvrHP5P/OD0IFCoH+QX/ohEJMvLOsdYDxqkNBYCz7V52Hi92CdU9cNT10zz/0pUCh6kL80Sz6CKUD79oUgjS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(2906002)(316002)(54906003)(110136005)(478600001)(52536014)(41300700001)(8676002)(8936002)(71200400001)(76116006)(66476007)(4326008)(5660300002)(64756008)(66946007)(66446008)(66556008)(53546011)(9686003)(6506007)(26005)(186003)(82960400001)(7696005)(55016003)(83380400001)(38070700005)(33656002)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTZtVlZmNmMrbGw3K2diSVRxZ3dCT2R2aThpWWV4REZvR29qdmtVY1JQYTNR?=
 =?utf-8?B?cmtzZk5WWi9yRDJhc2REOWVUQlVLOHpMZGpBYkg4bmJrTk5mREZmcEQ3M2xJ?=
 =?utf-8?B?VFdCdXNIYld6aGpFSjVMUDc0QzdSUTNTRGhEM1RRSFQ0dk5GTVJ4bDNYSWJ1?=
 =?utf-8?B?MGRvOXpESGdIYThpU2RkdXQrcmU0MUk1NFpHbHprMytMNjR0b0I2RW9rcDJR?=
 =?utf-8?B?SGR6cmZTT3dsSXBPdWJQZk5GRUx6VkkvditMRWVjWm43L0p1NnFJeVI2OUZk?=
 =?utf-8?B?M3YyRlVla0pHbUJKZmQ1Ym1BaXdlaDUrbXJlM2hlMUd4Q0FhUU04WEtuclhU?=
 =?utf-8?B?azNvcXhpNFVHbVNPaHpMaU9hY2RXd01Xa1hXTHd0VElxeGMrRysrNWNoczhz?=
 =?utf-8?B?YmVGT010dGFEbVQ4V3J5Y0E3UlZkZ1lWN2NoczgvYTJEZUVDTjA5VU5ucVpI?=
 =?utf-8?B?N2NwbkVXK1VXb0JSZ0htMklrQk02SHdBWEZsRTBVMVRVbmJWTE50Z0JKb1RO?=
 =?utf-8?B?MlJoWVU1anBFd0pUMkdoUVRucXh0Z0lBdndZdG9kbS91SE9QSnJkMW9SdGo5?=
 =?utf-8?B?TUFYdkNjMG9pdXF3MGJWOUF3azU2UXFkbWxVT1JvdjgvYUNuZVczbDM5VUVG?=
 =?utf-8?B?UDJRdW5yL1o3ajZxOVB1N2lvTWsrbnhzd0s3dHZieFRwMCs0Q09XQm9RRlpJ?=
 =?utf-8?B?QStoVlJSM3hPZXVxRkZxanJoaHZRaGQrbDNTTU5KdVhHMzhLV2xPNUZ6ek5E?=
 =?utf-8?B?dnZkMkVOYlNVeFhNdmkrclhNR2FZU1F2RjZHYUZQN3FlSGtCL0VJZ2dDcDBN?=
 =?utf-8?B?Rk1neUhKY2ZseDJSbDdMSmlXaUNhcXhPaGxrdGV5dzZuUGo0K2lZdDdBQy9n?=
 =?utf-8?B?Z0xDRGc3RUVJeHVCYnlOd21YL1NHUW5jOGtUd0RmdGh0L3AwNEtQOXR3emV2?=
 =?utf-8?B?ckdQbnhDeDhzS2ppa3gxdVBQcHFYdG12M2EvaVdHeXRFTytyamVQemR4aTZs?=
 =?utf-8?B?RGJvNTI1STZnOTY3NWhuSER5K3dnaEdCZWNZRGZycStKdGxBclJaaDRRWjRE?=
 =?utf-8?B?RmloMFRyU2wzbmpReXozOEc4TkVkb2MwcGsyY3BhOXhkc3lkYU5qMjd4N3BQ?=
 =?utf-8?B?Nm9QeEhFTlZGdWw3YUFKdi9DeFNiMUlPREFYNlZiTnVpZGYwTExwTmUyZWgw?=
 =?utf-8?B?bDFDOFBPQis4UnprbnpRdXBEVXJ1ek01c1NvRzB0Y2M1Q2ZHMSszWThtUUkw?=
 =?utf-8?B?dHlOUllYTUF6cUtsOENRK0RjdFBSRDZyTDY2QzcwZ0Q2cFc5UFVxTXRqQVZm?=
 =?utf-8?B?cU1FenhvRVU5SjAvUmpReFFGL3VablhKdHpnNEV1S0hQSWlGL25qOWJvQU9Q?=
 =?utf-8?B?NUNWU2U5SDNEZHJ6ZEZjTXdVVUxZQkdXZ2Y4L0pHUFBJeEtsb251QXRRWERP?=
 =?utf-8?B?OU9VSklLM0F3aXJicDFPSnZQaHBOQUZVazA1cms5eUdZU0l2eWN0LzdralBZ?=
 =?utf-8?B?K2VQd3ZvcGtlaDVPYjVNTzRJWThQd0hVT0RJQUQ0MUtTQ25CTlQ0L3VheVU1?=
 =?utf-8?B?QUZpSC9tMmxrRW14UHlkVk8xckR0ZHpJbHhGMVZwelhjaWRMNWRyK1pnZ2pM?=
 =?utf-8?B?OHRsaFZBNTZva1lxUWZ0Mzc2dlZyUmpPTjlOVGV3bmVIdDZ1S2hwRUxjLzMw?=
 =?utf-8?B?WSt6RVJ5ZlhJcHJjRmVpR2p1YWVpQ3VKaXVNVThVRFNpcWhpVkx6Wmx5b0Rt?=
 =?utf-8?B?R1huZC9lR3dNTnAvQ29MbFhueXM3cElXZnNEV1gzR3JWbUlDcTA3Vzh3Rmh3?=
 =?utf-8?B?bzRzQTl6bVdlcHh4ckJCenJaUmhlemc0ekNEdnRqcHU3TjM4eHhtTTErVUdN?=
 =?utf-8?B?ZjZmNEtzTncxenVQZlNvZjliVkhaeFFhMzBuVk9BRFFFTHhtMzJieUxvYTZX?=
 =?utf-8?B?TXpFczNQemNXMmNYSlNWYnFFeHBaN2d0QmJMUXVuWEpHTHNmYkhhUmJManFS?=
 =?utf-8?B?SlBFaDl6QUtCQndFSTBCMkdrQ3VJNU0wWmFRd2gxd0pqdlNGSWJiT1VGU1oy?=
 =?utf-8?B?N21jRmVxZzAwSHNOMVZEaVRCWTJDa0xYVXkvRGdYUm1aSTJkdlJFTE9pbW92?=
 =?utf-8?Q?OoyCyZLrFyuvwPWBGpTARQYdr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9880ab3-5d6a-43dc-a910-08db505aa8ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 06:57:31.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhhK5DE3kHphR2v3J8oE8s+jLsafEYEhIJQ8H5RYiTMW2YbNok37ueBVjOL1B6JC132zDQBsoxTfBigO+xBWzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTG9uZ21hbiwNCg0KT0ssIHNvLCB5b3UgYXJlIGZyb20gdGhlIHBvaW50IG9mIHZpZXcgb2Yg
dGhlIENQVSAodGhlIGxvY2sgd29yZCB2YWx1ZSBpdCByZWFkIGxhc3QgdGltZSkNCmRvaW5nIHN0
YXRlIHRyYW5zaXRpb24gaW4gdGhlIHVuY29udGVuZGVkIHNjZW5hcmlvOiANCg0KICAgICBbMV06
ICBPbGQgbG9jayB3b3JkIHZhbHVlICh0aGlzIENQVSByZWFkIGl0IGxhc3QgdGltZSkgLS0tPiBO
ZXcgbG9jayB3b3JkIHZhbHVlDQoNCkknbSBmcm9tIHRoZSBwb2ludCBvZiB2aWV3IG9mIHRoZSBj
dXJyZW50IGxvY2sgd29yZCBwb3NzaWJsZSB2YWx1ZSB0aGF0IGl0cyBzdGF0ZSBpcyANCnRyYW5z
aXRlZCB0byB0aGUgbmV3IGxvY2sgd29yZCBwb3NzaWJsZSB2YWx1ZSAoSSBkb24ndCB0aGluayBJ
J20gdGhlIG9ubHkgb25lIGZyb20gDQp0aGlzIHBvaW50IG9mIHZpZXcgd2hlbiByZWFkaW5nIHRo
ZSBxc3BpbmxvY2sgY29kZSA7LSkuDQoNCiAgICAgWzJdOiBDdXJyZW50IGxvY2sgd29yZCBwb3Nz
aWJsZSB2YWx1ZSAtLS0+IE5ldyBsb2NrIHdvcmQgcG9zc2libGUgdmFsdWUgDQoNCkknbSBmaW5l
IHRvIGtlZXAgdGhlIHZpZXcgb2YgWzFdIGluIHRoZSBjdXJyZW50IGNvZGUgYW5kIGdldCBbMl0g
YXMgdGhlIGJhY2t1cC4NCkknbGwgc2VuZCBvdXQgYSB2MiB3aXRoIGp1c3QgdHdvIG1pbm9yIGNv
bW1lbnRzJyBmaXhlcy4gDQoNClRoYW5rcyENCi1RaXV4dQ0KDQo+IEZyb206IFdhaW1hbiBMb25n
IDxsb25nbWFuQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSA5LCAyMDIzIDEwOjMx
IEFNDQo+IFRvOiBaaHVvLCBRaXV4dSA8cWl1eHUuemh1b0BpbnRlbC5jb20+OyBQZXRlciBaaWps
c3RyYQ0KPiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0
LmNvbT47IFdpbGwgRGVhY29uDQo+IDx3aWxsQGtlcm5lbC5vcmc+DQo+IENjOiBCb3F1biBGZW5n
IDxib3F1bi5mZW5nQGdtYWlsLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIGxvY2tpbmcvcXNwaW5sb2NrOiBGaXggc3RhdGUtdHJh
bnNpdGlvbiBjaGFuZ2VzIGluDQo+IGNvbW1lbnRzDQo+IA0KPiBPbiA1LzgvMjMgMjI6MDMsIFpo
dW8sIFFpdXh1IHdyb3RlOg0KPiA+IEhpIFdhaW5tYW4sDQo+ID4NCj4gPiBUaGFua3MgZm9yIHlv
dXIgcmV2aWV3LiBQbGVhc2Ugc2VlIHRoZSBjb21tZW50cyBiZWxvdy4NCj4gPg0KPiA+PiBGcm9t
OiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIE1h
eSA4LCAyMDIzIDExOjI5IFBNDQo+ID4+IFRvOiBaaHVvLCBRaXV4dSA8cWl1eHUuemh1b0BpbnRl
bC5jb20+OyBQZXRlciBaaWpsc3RyYQ0KPiA+PiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdv
IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IFdpbGwgRGVhY29uDQo+ID4+IDx3aWxsQGtlcm5l
bC5vcmc+DQo+ID4+IENjOiBCb3F1biBGZW5nIDxib3F1bi5mZW5nQGdtYWlsLmNvbT47IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIGxv
Y2tpbmcvcXNwaW5sb2NrOiBGaXggc3RhdGUtdHJhbnNpdGlvbg0KPiA+PiBjaGFuZ2VzIGluIGNv
bW1lbnRzDQo+ID4+DQo+ID4+DQo+ID4+IE9uIDUvNi8yMyAwMjoyOSwgUWl1eHUgWmh1byB3cm90
ZToNCj4gPj4+IDEuIFRoZXJlIG1heSBiZSBjb25jdXJyZW50IGxvY2tlciBDUFVzIHRvIHNldCB0
aGUgcXNwaW5sb2NrIHBlbmRpbmcgYml0Lg0KPiA+Pj4NCj4gPj4+ICAgICAgVGhlIGZpcnN0IENQ
VSAoY2FsbGVkIHBlbmRpbmcgQ1BVKSBvZiB0aGVzZSBDUFVzIHNldHMgdGhlIHBlbmRpbmcNCj4g
Pj4+ICAgICAgYml0IHRvIG1ha2UgdGhlIHN0YXRlIHRyYW5zaXRpb24gKHRoZSBxc3BpbmxvY2sg
cGVuZGluZyBiaXQgaXMgc2V0KToNCj4gPj4+DQo+ID4+PiAgICAgICAgICAgIDAsMCwqIC0+IDAs
MSwqDQo+ID4+Pg0KPiA+Pj4gICAgICBUaGUgcmVzdCBvZiB0aGVzZSBDUFVzIGFyZSBxdWV1ZWQg
dG8gdGhlIE1DUyBxdWV1ZSB0byBtYWtlIHRoZQ0KPiBzdGF0ZQ0KPiA+Pj4gICAgICB0cmFuc2l0
aW9uICh0aGUgcXNwaW5sb2NrIHRhaWwgaXMgdXBkYXRlZCk6DQo+ID4+Pg0KPiA+Pj4gICAgICAg
ICAgICAwLDEsKiAtPiAqLDEsKg0KPiA+Pj4NCj4gPj4+ICAgICAgVGhlIHBlbmRpbmcgQ1BVIHdh
aXRzIHVudGlsIHRoZSBsb2NrZXIgb3duZXIgZ29lcyBhd2F5IHRvIG1ha2UNCj4gPj4+ICAgICAg
dGhlIHN0YXRlIHRyYW5zaXRpb24gKHRoZSBxc3BpbmxvY2sgbG9ja2VkIGZpZWxkIGlzIHNldCB0
byB6ZXJvKToNCj4gPj4+DQo+ID4+PiAgICAgICAgICAgICosMSwqIC0+ICosMSwwDQo+ID4+Pg0K
PiA+Pj4gICAgICBUaGUgcGVuZGluZyBDUFUgdGFrZXMgdGhlIG93bmVyc2hpcCBhbmQgY2xlYXJz
IHRoZSBwZW5kaW5nIGJpdA0KPiA+Pj4gICAgICB0byBtYWtlIHRoZSBzdGF0ZSB0cmFuc2l0aW9u
Og0KPiA+Pj4NCj4gPj4+ICAgICAgICAgICAgKiwxLDAgLT4gKiwwLDENCj4gPj4+DQo+ID4+PiAy
LiBUaGUgaGVhZGVyIG9mIHRoZSBNQ1MgcXVldWUgdGFrZXMgdGhlIG93bmVyc2hpcCBhbmQgY2Fs
bHMNCj4gc2V0X2xvY2tlZCgpDQo+ID4+PiAgICAgIHRvIG1ha2UgdGhlIHN0YXRlIHRyYW5zaXRp
b246DQo+ID4+Pg0KPiA+Pj4gICAgICAgICAgICAqLCosMCAtPiAqLCosMQ0KPiA+PiBUaGF0IGlz
IG5vdCB0cnVlLiBUaGUgcGVuZGluZyBiaXQgb3duZXIgaGFzIHByaW9yaXR5IG92ZXIgdGhlIE1D
Uw0KPiA+PiBxdWV1ZSBoZWFkLiBTbyB0aGUgcGVuZGluZyBiaXQgbXVzdCBiZSAwIGJlZm9yZSB0
aGUgTUNTIHF1ZXVlIGhlYWQNCj4gPj4gY2FuIHRha2Ugb3ZlciB0aGUgbG9jay4gU28NCj4gPj4N
Cj4gPj4gICDCoMKgwqAgKiwwLDAgLT4gKiwwLDENCj4gPiBZZXMsIHRoZSBwZW5kaW5nIGJpdCBt
dXN0IGJlIDAgYmVmb3JlIHRoZSBoZWFkZXIgY2FuIHRha2UgdGhlIGxvY2suDQo+ID4gQnV0IGFz
IHRoZSBzdGF0ZW1lbnQgIlRoZXJlIG1heSBiZSBjb25jdXJyZW50IGxvY2tlciBDUFVzIHRvIHNl
dCB0aGUNCj4gPiBxc3BpbmxvY2sgcGVuZGluZyBiaXQgIiBhdCB0aGUgYmVnaW5uaW5nLiBTbyBq
dXN0IGFmdGVyIHRoZSBoZWFkZXINCj4gPiB0YWtlcyBvdmVyIHRoZSBsb2NrLCB0aGVyZSBpcyBh
bHNvIGEgcG9zc2libGUgY29uY3VycmVudCBsb2NrZXIgQ1BVIHRvIHNldCB0aGUNCj4gcGVuZGlu
ZyBiaXQuIFRoYXQgbWVhbnMgYXQgdGhpcyB0aW1lIHBvaW50IGhlcmUsIHRoZSBwZW5kaW5nIGJp
dCBjb3VsZCBiZQ0KPiBlaXRoZXIgMCBvciAxLg0KPiANCj4gT0ssIEkgYW0gbG9va2luZyBmcm9t
IHRoZSBwb2ludCBvZiB2aWV3IG9mIHRoZSBDUFUgZG9pbmcgdGhlIHRyYW5zaXRpb24uDQo+IE90
aGVyd2lzZSwgZm9yIGFuIGFyY2ggd2l0aCB2ZXJ5IHdlYWsgbWVtb3J5IG9yZGVyaW5nLCBhbnl0
aGluZyBpcyBwb3NzaWJsZS4NCj4gaS5lLiAqLCosKiAtPiAqLCosKiBpZiB3ZSBoYXZlIHRvIGNv
bnNpZGVyIHdoYXQgYWxsIHRoZSBDUFVzIGluIHRoZSBzeXN0ZW0gY2FuDQo+IHNlZS4NCj4gDQo+
IA0KPiA+DQo+ID4+PiBGaXggdGhlIHN0YXRlLXRyYW5zaXRpb24gY2hhbmdlcyBhYm92ZSBpbiB0
aGUgY29kZSBjb21tZW50cyBhY2NvcmRpbmdseS4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5
OiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAg
a2VybmVsL2xvY2tpbmcvcXNwaW5sb2NrLmMgfCAxMCArKysrKystLS0tDQo+ID4+PiAgICAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+
IGRpZmYgLS1naXQgYS9rZXJuZWwvbG9ja2luZy9xc3BpbmxvY2suYyBiL2tlcm5lbC9sb2NraW5n
L3FzcGlubG9jay5jDQo+ID4+PiBpbmRleCBlYmU2YjhlYzdjYjMuLmVmZWJiZjE5Zjg4NyAxMDA2
NDQNCj4gPj4+IC0tLSBhL2tlcm5lbC9sb2NraW5nL3FzcGlubG9jay5jDQo+ID4+PiArKysgYi9r
ZXJuZWwvbG9ja2luZy9xc3BpbmxvY2suYw0KPiA+Pj4gQEAgLTI1Nyw3ICsyNTcsNyBAQCBzdGF0
aWMgX19hbHdheXNfaW5saW5lIHUzMg0KPiA+PiBxdWV1ZWRfZmV0Y2hfc2V0X3BlbmRpbmdfYWNx
dWlyZShzdHJ1Y3QgcXNwaW5sb2NrICpsbw0KPiA+Pj4gICAgICogc2V0X2xvY2tlZCAtIFNldCB0
aGUgbG9jayBiaXQgYW5kIG93biB0aGUgbG9jaw0KPiA+Pj4gICAgICogQGxvY2s6IFBvaW50ZXIg
dG8gcXVldWVkIHNwaW5sb2NrIHN0cnVjdHVyZQ0KPiA+Pj4gICAgICoNCj4gPj4+IC0gKiAqLCos
MCAtPiAqLDAsMQ0KPiA+Pj4gKyAqICosKiwwIC0+ICosKiwxDQo+ID4+IHNldF9sb2NrZWQoKSBj
YW4gb25seSBiZSBjYWxsZWQgd2hlbiBpdCBpcyBzdXJlIHRoYXQgdGhlIHBlbmRpbmcgYml0IGlz
bid0IHNldC4NCj4gPj4+ICAgICAqLw0KPiA+Pj4gICAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2
b2lkIHNldF9sb2NrZWQoc3RydWN0IHFzcGlubG9jayAqbG9jaykNCj4gPj4+ICAgIHsNCj4gPj4+
IEBAIC0zNDgsNyArMzQ4LDcgQEAgdm9pZCBfX2xvY2tmdW5jDQo+IHF1ZXVlZF9zcGluX2xvY2tf
c2xvd3BhdGgoc3RydWN0DQo+ID4+IHFzcGlubG9jayAqbG9jaywgdTMyIHZhbCkNCj4gPj4+ICAg
IAkvKg0KPiA+Pj4gICAgCSAqIHRyeWxvY2sgfHwgcGVuZGluZw0KPiA+Pj4gICAgCSAqDQo+ID4+
PiAtCSAqIDAsMCwqIC0+IDAsMSwqIC0+IDAsMCwxIHBlbmRpbmcsIHRyeWxvY2sNCj4gPj4+ICsJ
ICogMCwwLCogLT4gMCwxLCogLT4gLi4uIC0+ICosMCwxIHBlbmRpbmcsIHRyeWxvY2sNCj4gPj4g
QnkgdGhlIHRpbWUgdHJ5bG9jayBpcyBkb25lLCB0aGVyZSBtYXkgYmUgZW50cmllcyBpbiB0aGUg
cXVldWUuDQo+ID4+IEhvd2V2ZXIsIEkgZG91YnQgaXQgaGVscHMgYnkgYWRkaW5nICIuLi4iIGlu
IGJldHdlZW4gcG9zc2libGUgbXVsdGlwbGUNCj4gdHJhbnNpdGlvbnMuDQo+ID4+DQo+ID4gVGhl
IGFkZGVkICIuLi4iIG1lYW5zIHRoZXJlIGNvdWxkIGJlIGVudHJpZXMgaW4gdGhlIHF1ZXVlIGJl
Zm9yZSB0cnlsb2NrDQo+IGRvbmUuDQo+ID4gVGhpcyBpcyBqdXN0IGZvciBtYWtpbmcgdGhlIHN0
YXRlIHRyYW5zaXRpb25zIG1vcmUgY29tcGxldGUgOy0pLg0KPiA+IElmIHlvdSB0aGluayBpdCBk
b2Vzbid0IGhlbHAsIEkgY2FuIHJlbW92ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiANCj4g
VGhlIHRyYW5zaXRpb24gZmxvdyBkb2VzIG5vdCBzaG93IHdoZXRoZXIgdGhlcmUgaXMgZW50cnkg
aW4gdGhlIHF1ZXVlIG9yIG5vdC4NCj4gSXQganVzdCBzaG93cyB0aGUgc3RhdGUgb2YgdGhlIGxv
Y2sgd29yZC4NCj4gDQo+IA0KPiA+DQo+ID4+PiAgICAJICovDQo+ID4+PiAgICAJdmFsID0gcXVl
dWVkX2ZldGNoX3NldF9wZW5kaW5nX2FjcXVpcmUobG9jayk7DQo+ID4+Pg0KPiA+Pj4gQEAgLTM1
OCw2ICszNTgsOCBAQCB2b2lkIF9fbG9ja2Z1bmMNCj4gcXVldWVkX3NwaW5fbG9ja19zbG93cGF0
aChzdHJ1Y3QNCj4gPj4gcXNwaW5sb2NrICpsb2NrLCB1MzIgdmFsKQ0KPiA+Pj4gICAgCSAqIFVu
ZG8gYW5kIHF1ZXVlOyBvdXIgc2V0dGluZyBvZiBQRU5ESU5HIG1pZ2h0IGhhdmUgbWFkZSB0aGUN
Cj4gPj4+ICAgIAkgKiBuLDAsMCAtPiAwLDAsMCB0cmFuc2l0aW9uIGZhaWwgYW5kIGl0IHdpbGwg
bm93IGJlIHdhaXRpbmcNCj4gPj4+ICAgIAkgKiBvbiBAbmV4dCB0byBiZWNvbWUgIU5VTEwuDQo+
ID4+PiArCSAqDQo+ID4+PiArCSAqIDAsMSwqIC0+ICosMSwqDQo+ID4+IFRoZXJlIGlzIGFscmVh
ZHkgYSAibiwwLDAgLT4gMCwwLDAiIGFib3ZlLCBhZGRpbmcgYSBuZXcgb25lIG1heSBqdXN0DQo+
ID4+IGNvbmZ1c2UgcGVvcGxlLg0KPiA+Pj4gICAgCSAqLw0KPiA+Pj4gICAgCWlmICh1bmxpa2Vs
eSh2YWwgJiB+X1FfTE9DS0VEX01BU0spKSB7DQo+ID4+Pg0KPiA+Pj4gQEAgLTM3MSw3ICszNzMs
NyBAQCB2b2lkIF9fbG9ja2Z1bmMNCj4gcXVldWVkX3NwaW5fbG9ja19zbG93cGF0aChzdHJ1Y3QN
Cj4gPj4gcXNwaW5sb2NrICpsb2NrLCB1MzIgdmFsKQ0KPiA+Pj4gICAgCS8qDQo+ID4+PiAgICAJ
ICogV2UncmUgcGVuZGluZywgd2FpdCBmb3IgdGhlIG93bmVyIHRvIGdvIGF3YXkuDQo+ID4+PiAg
ICAJICoNCj4gPj4+IC0JICogMCwxLDEgLT4gKiwxLDANCj4gPj4+ICsJICogKiwxLCogLT4gKiwx
LDANCj4gPj4gVGhpcyByZWZlcnMgdG8gdGhlIHdhaXQgbG9vcC4gV2UgZG9uJ3QgbmVlZCB0byB3
YWl0IGlmIHRoZSBvd25lciBoYXMgZ29uZS4NCj4gPiBCdXQganVzdCBiZWZvcmUgd2Ugd2FpdCBm
b3IgdGhlIGxvY2tlZCBmaWVsZCwgdGhlIGxvY2tlZCBmaWVsZCBjb3VsZCBiZQ0KPiA+IGVpdGhl
ciAwICh0aGUgbG9ja2VyIGNhbiByZWxlYXNlIHRoZSBsb2NrIGF0IGFueSB0aW1lKSBvciAxLg0K
PiANCj4gQWdhaW4sIEkgdGFrZSB0aGUgdmlld3BvaW50IG9mIHRoZSBDUFUgZG9pbmcgdGhlIHdh
aXQuIEl0IHdpbGwgb25seSB3YWl0DQo+IGlmIGl0IG9ic2VydmVzIHRoYXQgdGhlIGxvY2sgaXNu
J3QgZnJlZS4NCj4gDQo+IA0KPiA+DQo+ID4+PiAgICAJICoNCj4gPj4+ICAgIAkgKiB0aGlzIHdh
aXQgbG9vcCBtdXN0IGJlIGEgbG9hZC1hY3F1aXJlIHN1Y2ggdGhhdCB3ZSBtYXRjaCB0aGUNCj4g
Pj4+ICAgIAkgKiBzdG9yZS1yZWxlYXNlIHRoYXQgY2xlYXJzIHRoZSBsb2NrZWQgYml0IGFuZCBj
cmVhdGUgbG9jaw0KPiA+Pj4gQEAgLTM4NSw3ICszODcsNyBAQCB2b2lkIF9fbG9ja2Z1bmMNCj4g
cXVldWVkX3NwaW5fbG9ja19zbG93cGF0aChzdHJ1Y3QNCj4gPj4gcXNwaW5sb2NrICpsb2NrLCB1
MzIgdmFsKQ0KPiA+Pj4gICAgCS8qDQo+ID4+PiAgICAJICogdGFrZSBvd25lcnNoaXAgYW5kIGNs
ZWFyIHRoZSBwZW5kaW5nIGJpdC4NCj4gPj4+ICAgIAkgKg0KPiA+Pj4gLQkgKiAwLDEsMCAtPiAw
LDAsMQ0KPiA+Pj4gKwkgKiAqLDEsMCAtPiAqLDAsMQ0KPiA+PiBUaGF0IGlzIHRoZSBwYXJ0IHRo
YXQgd2UgY2FuIG1ha2UgdGhlIGNoYW5nZSBpbiB0aGUgdHJhbnNpdGlvbiBkaWFncmFtDQo+ID4+
IGFzIG5vdGVkLg0KPiA+IFNvcnJ5LCBJJ20gbm90IGNsZWFyIGFib3V0IHlvdXIgcmVxdWVzdC4N
Cj4gPiBEaWQgeW91IG1lYW4ganVzdCBtYWtlIHRoZSBjaGFuZ2UgIiosMSwwIC0+ICosMCwxIiBh
Ym92ZSBpbiB0aGUgdHJhbnNpdGlvbg0KPiBkaWFncmFtIG9yDQo+ID4gYWxsIHRoZSBjaGFuZ2Vz
IGFib3ZlIGluIHRoZSB0cmFuc2l0aW9uIGRpYWdyYW0/DQo+IA0KPiBXaGF0IEkgbWVhbnQgaXMg
dGhhdCB0aGlzIHBhcnRpY3VsYXIgY2hhbmdlIGlzIGNvcnJlY3QgQUZBSUNTLiBTb3JyeSBmb3IN
Cj4gdGhlIGNvbmZ1c2lvbi4NCj4gDQo+IENoZWVycywNCj4gTG9uZ21hbg0KDQo=
