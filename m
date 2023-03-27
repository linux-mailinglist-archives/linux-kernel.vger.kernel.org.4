Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1597F6CA245
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjC0LVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC0LVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:21:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD5423B;
        Mon, 27 Mar 2023 04:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679916094; x=1711452094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E+yGTZoWvobsLTrGVR9g33YIDA7YpaTHQh9Z5u3tFeE=;
  b=TNnTLqD24UAxmltH4MBQ0OU0uTH5cA9z2KHtxo++973F+hcB25y7uThv
   ZMCqIPEb1/l4bvPTk8aXTeMHlV1fSleHjwTyBOkH4JCF5Gc+FSa+hqdnM
   U4xfZ8aZFE40PrLL1fvvz8GSb2JBYo6L1uqcFqmqMjspDBMTyAnswgxv7
   qNFJe/iReIxTIU4h7RU6d2lVZTQqn1JJAWLY4aJnBzPwiXhGGjSXqmLfW
   v1a/fD56VtH5WLe+Si/5FXQcvDxSeCfqpsQLGd+kqfQ3KfhcEt64PmXlB
   3l8lBjINjyGGSQLKTtLZajTQwgxPYECo48i0TTn/vhuwS4ptQq00STuRH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367985273"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="367985273"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 04:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="857617658"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="857617658"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2023 04:21:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 04:21:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 04:21:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 04:21:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbPKY439Y8fvgG3kknl1QOAz0y5lGTM/2stQsxc2QtJ7Kdp/6AROA7BjJg+DM1BH3K2818W0xRribQ6+M56KzMYNnExAu0rXZ3NgJpR7BX6TmDUnozo2awAe0HX5aYViFJHy4hmRClNiAaUyWsRGIhOlYj5ZzX6mPvPeMtThI80Dau6coH/jd0Kqu262UWN54q72fe9gvxvJIZHd0WRSk7h77pQWFrSjcEb/it819bxqJixhZ+a+4HhtQ3q+iEVS7FouAhed+DCdWMnhTMK0tG8L9R6dxdSfgY1967XAlvRJQTz9BEm1XyBaVoVSVWiDrcPQgJtfhmWRsPDdJppS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+yGTZoWvobsLTrGVR9g33YIDA7YpaTHQh9Z5u3tFeE=;
 b=drx/rjMD69ku9kmRI/uoQilKpDYkryEoJR2Y3jUcNIZBrXtQCXS4tjDMKCmQx01gNlpRjfsCUjd2nBznxqtQYsYRJRf7NzoSmxmp9f4FLqcJ+GfzecTP303Wgb2CoCMqZQWURv6R/iQda0TBhU4ptA8tZFe1TkFi31Oc8T/PSLsaBYkNAR5b1ob/HQnhMcCygSJQk6ITYNbwfeezH4+qvQkMy2y7d3y2uPqFve+I12B46Wp+8dLNy/+BSYbxCh+HMTiCJYqfZvOBR38aT/zX+b4omOj/Agb29OMSG9pYcmcVE7t2bT6ppMEPT/S79YR2zJH6D5beccZHiPguvoJE2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH7PR11MB7664.namprd11.prod.outlook.com (2603:10b6:510:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 11:21:23 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 11:21:23 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: RE: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Topic: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Thread-Index: AQHZW9/cQoPnlerMcUKFbHJCjrW4W68FRAeAgAAUR4CACSeJoA==
Date:   Mon, 27 Mar 2023 11:21:23 +0000
Message-ID: <PH0PR11MB58805561777B77DC69E87711DA8B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230321102748.127923-1-urezki@gmail.com>
 <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
 <ZBnKKZsSpI8aAk9W@pc636>
In-Reply-To: <ZBnKKZsSpI8aAk9W@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH7PR11MB7664:EE_
x-ms-office365-filtering-correlation-id: 86c4f9bc-74fe-4cd9-a174-08db2eb5658e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: djzxrxbf74Ydo2GLulG9cPY0bNQ2+z0FNmuKYnUqX3a9tQmycKX01dqB/wT7yvKYzAbuberLpVvkWVDKzMHHmg/RUf0Lzsvw533W0Zwi+Lhd1LIzr/pTxblV/Ai2OQVAIE+/efLbYvWjj9laY0lax/pbg/6a9eqUkwgfqh2r63NybWZrl2zcigDEGc7eTuWKkjnj9iegHQkf+bHkyhJHuZYDZcm0faEQBqRRZxBd0oAeWjidpnqNNA4jwIQkMcgZNEz+f7lsC715s1kW73KtoB2g3veepJQRLRT6GipkYswNFv24iyyBgNYIC8WCwTs5SXdD8+IgVQXmfhLVdFkfvW1LyT6GNZqgHv35yp7tNZsC+gxjs9/8BjJjWe9q4WPv0UOLTuz8CaDvFR24ioNL25OFBfNTSerHsHqEV0DpfJ/BH7nkVc/86xZ0dDTZGrpewez3Ld0ttPiGB39S2ikizG5cy8AMqSKfLgV2H13bo1F0J7+ZeXsbIPb6zb06wArPVUTLsjSc8mH/RDaX9k595YbrKMxR9YoLSMX0Ob9qQFTPykFiQukFmUjDRvGcSid3Qi5J19ImIHsu1qfBw7N34j0Skm+ZWmcvdk3uD6w13E8mSdpjOdEdnufNR1v5ahlr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(122000001)(7416002)(7696005)(71200400001)(8936002)(52536014)(5660300002)(186003)(6506007)(9686003)(26005)(55016003)(2906002)(86362001)(33656002)(83380400001)(82960400001)(38070700005)(6636002)(4326008)(8676002)(54906003)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(41300700001)(478600001)(38100700002)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFArMFJRditmNkJzREw3bzNnNWwydk1tczl3QmlJanIxQmlWTm1qeUxHTWdh?=
 =?utf-8?B?eTljQlFEOUNzbTMwZ1BQdDBYQmxWckZtbVhYSUlvRDQvQUJ1R3JENDJpYmg4?=
 =?utf-8?B?bG5xOEg4ZVFudDJtNVFVRkoxck45eldNOVkxN0lQc1N4WEEwcEc0TlIyWVov?=
 =?utf-8?B?bjFCRmp6R2pCMUE4WnUvNVNmMnZHVS9ZWC8yeTdMeCsvcTcrbWZ2SlQ2eEsw?=
 =?utf-8?B?VFppWlRvaVJvVW9zNkFibTNXay9yZnpBbjlWYk94RXAzQ2U1eTdPb3lHYVRS?=
 =?utf-8?B?UmlqVmpYbnYvWW5teDI4YUJCM0lQUDZwMDhQVGFlaTM2TDFXWmNFM256R1Z4?=
 =?utf-8?B?Q21iOXdmVWFDN21sb2YvZ0JvRjM1T2RZSVVhSGhObDNzNWZGQUVhajU4RGpv?=
 =?utf-8?B?UWVuVlNZd0Y1Ym1lV09wQTY1cUU4RnV3Y1RPREMzejRrWWZSZUcwK1BzTGZ6?=
 =?utf-8?B?Umo1dDkydzR6dmlpeUYzME1NL05NZlRVYzRIMmtzeml5Y1JFWTQ3TVVjenRV?=
 =?utf-8?B?QjNXUlFxQXQ3OHRybGtMVXNKUVdLWGltQy84TUxiSDJEM3pJdS83bnhJTmZP?=
 =?utf-8?B?WE5XVndYM2RMd2RRWTNJdE5XT3d3NnlCa1JsUHpHeG1XR0dXbzN0QmlWaStr?=
 =?utf-8?B?bEpYa2hCbHBCem9YYkxaQk5Vd3o5WDRUNmc4cFF0WDRNeDBYMm5VYnBoQVV2?=
 =?utf-8?B?T21RSzU3aDVpeXlsLzdsVUZvZFpqRW02ZXo2ZjcxZGpKYnBURm9ZT0lDVktv?=
 =?utf-8?B?ZzNwNWhXcFB3b0FqWnVidG5CUGN6V1FCb2xJbFk1TXBSd0Z5bUtmUFdEWWI0?=
 =?utf-8?B?djJWcjcvenBEMFR4U002anNrNkRhRU0zUUYvYlNaSU1hYmVuaHBDNW5iNjls?=
 =?utf-8?B?UENQc1VOTjBMSzZsVVhFeHdpa1AyUkJzVmw2ZlR0eSthQklHTVk5NmJYMjFi?=
 =?utf-8?B?T1BTK1pnamNiRGw3SUVBMm5XblFDdVlhdWh3V2NFK2R4aXN2S3VFek1CeVZo?=
 =?utf-8?B?NVJUaEsyc28wN1NtZzVmRXpVQWlubW5MdXdNMDQ3K0dGWUNOSDVLSzdkUEU2?=
 =?utf-8?B?VHpodVVUcWNsT3dFaFNnKzZzUHF0WWUydlltQjcrb01yZkVvMU1DUitPMVpE?=
 =?utf-8?B?ZkdTdW1YbXljcURScmtiekc1SjJLNUwzbGoreXVLcGhvK1JTaGgwVTFHam5m?=
 =?utf-8?B?R2hKTXprODdQV3RQd3FySzJaRW9YcnlySlpHazllcGpUWnpWU21GbnZJdU90?=
 =?utf-8?B?VmRpTjVVamR3d0FPVTRBeE1zampWcUFNbldWN2RjNHZzYTlvM2pWdUhRR3lW?=
 =?utf-8?B?MWJ2NVBPbkM3SWMzR2FTNlkrVUZoekJleFQ1K3VhTFFkWm84cURRd0VBZDAz?=
 =?utf-8?B?UmVOSElzcm8rcFgzVHFNYU9qQ2xLWXp1cVJRTDhReGhDYmZzNFA5NTVFNmc1?=
 =?utf-8?B?d2xrNGtNNjZEL1BwZ1BkSG9NTmhPOGdNdkNSdnk2VVdsMDlxdmY0OGZyM2Yx?=
 =?utf-8?B?WW1qSWU5SFpndkg3ZmVJYnBwbHNZZUtkYmFTVHMrYVN5SElqZFhjOGRPOTBl?=
 =?utf-8?B?NHJYbWh5ZG8zYXg0WFFLUXp2NEcvR3hZekJQN2Vja2Zzc2hQbUp1VTJCRTZ2?=
 =?utf-8?B?cGJ5NUxqK211UUZtRm9XN2tyOHRncUc5Wml3UE5xL0UzRG03bUdaNmIvc2JN?=
 =?utf-8?B?ZHZpaDhUNVlHL0oxeENhdlprRUEwTHl0amZUcFpBb0UrU2MyZVd0V1k4SVVQ?=
 =?utf-8?B?UElIUG1kMU5ZMy91dWVTS0JnNHhsZXRYcU5odzV2amdqVzRBdjJvRWo5Y29m?=
 =?utf-8?B?ZVVzM0t2Y2NBUnUvcVdqeE81NE05RWhCSkNXclRGcWRLdVdvRDRoTHhiMWV6?=
 =?utf-8?B?LzE4MzlpR2xZNWZuYllsdEQwVWdrWW9UZnBOd3hCSkEyUnI0SDBVY2JVNjB2?=
 =?utf-8?B?bzBWZHRRUXlqeURURVNQU0MrYmFjVVIxUUhoUDd3VGtTWnY2bW5HR0h0T05D?=
 =?utf-8?B?aFQxODl3TzdwVVRlZDZmUkI1NjVQd3hWUjdxQ3Y3OVpEUk9lTGYxVnBNWFR3?=
 =?utf-8?B?VUFOK21TM0FlT1U1N0hSNlVhQ3RDQUQ1QUtVNkdSZnNpdTZzOVY4bUREcElq?=
 =?utf-8?Q?PYMoVFBMQEByAtfH+uKL/aBg+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c4f9bc-74fe-4cd9-a174-08db2eb5658e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 11:21:23.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBZCq8xE/MS9b6fXOHmCgR81HNtutV5uWIoR1atudARX2/HaIEaOp3PoPAgSNUTR/BukBXiwMDLVvjYm9ra+SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7664
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

PiA+IEZyb206IFVsYWR6aXNsYXUgUmV6a2kgKFNvbnkpIDx1cmV6a2lAZ21haWwuY29tPg0KPiA+
IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDIxLCAyMDIzIDY6MjggUE0NCj4gPiBbLi4uXQ0KPiA+IFN1
YmplY3Q6IFtQQVRDSCAxLzFdIFJlZHVjZSBzeW5jaHJvbml6ZV9yY3UoKSB3YWl0aW5nIHRpbWUN
Cj4gPiANCj4gPiBBIGNhbGwgdG8gYSBzeW5jaHJvbml6ZV9yY3UoKSBjYW4gYmUgZXhwZW5zaXZl
IGZyb20gdGltZSBwb2ludCBvZiB2aWV3Lg0KPiA+IERpZmZlcmVudCB3b3JrbG9hZHMgY2FuIGJl
IGFmZmVjdGVkIGJ5IHRoaXMgZXNwZWNpYWxseSB0aGUgb25lcyB3aGljaCB1c2UgdGhpcw0KPiA+
IEFQSSBpbiBpdHMgdGltZSBjcml0aWNhbCBzZWN0aW9ucy4NCj4gPiANCj4gDQo+IFRoaXMgaXMg
aW50ZXJlc3RpbmcgYW5kIG1lYW5pbmdmdWwgcmVzZWFyY2guIDstKQ0KPiANCj4gPiBGb3IgZXhh
bXBsZSBpbiBjYXNlIG9mIE5PQ0Igc2NlbmFyaW8gdGhlIHdha2VtZV9hZnRlcl9yY3UoKSBjYWxs
YmFjaw0KPiA+IGludm9jYXRpb24gZGVwZW5kcyBvbiB3aGVyZSBpbiBhIG5vY2ItbGlzdCBpdCBp
cyBsb2NhdGVkLiBCZWxvdyBpcyBhbiBleGFtcGxlDQo+ID4gd2hlbiBpdCB3YXMgdGhlIGxhc3Qg
b3V0IG9mIH4zNjAwIGNhbGxiYWNrczoNCj4NCg0KDQoNCkNhbiBpdCBiZSBpbXBsZW1lbnRlZCBz
ZXBhcmF0ZWx5IGFzIGZvbGxvd3M/ICBpdCBzZWVtcyB0aGF0IHRoZSBjb2RlIGlzIHNpbXBsZXIN
Cihvbmx5IHBlcnNvbmFsIG9waW5pb24pICDwn5iKLg0KDQpCdXQgSSBkaWRuJ3QgdGVzdCB3aGV0
aGVyIHRoaXMgcmVkdWNlIHN5bmNocm9uaXplX3JjdSgpIHdhaXRpbmcgdGltZQ0KDQorc3RhdGlj
IHZvaWQgcmN1X3BvbGxfd2FpdF9ncChzdHJ1Y3QgcmN1X3Rhc2tzICpydHApDQorew0KKyAgICAg
ICB1bnNpZ25lZCBsb25nIGdwX3NuYXA7DQorDQorICAgICAgIGdwX3NuYXAgPSBzdGFydF9wb2xs
X3N5bmNocm9uaXplX3JjdSgpOw0KKyAgICAgICB3aGlsZSAoIXBvbGxfc3RhdGVfc3luY2hyb25p
emVfcmN1KGdwX3NuYXApKQ0KKyAgICAgICAgICAgICAgIHNjaGVkdWxlX3RpbWVvdXRfaWRsZSgx
KTsNCit9DQorDQordm9pZCBjYWxsX3JjdV9wb2xsKHN0cnVjdCByY3VfaGVhZCAqcmhwLCByY3Vf
Y2FsbGJhY2tfdCBmdW5jKTsNCitERUZJTkVfUkNVX1RBU0tTKHJjdV9wb2xsLCByY3VfcG9sbF93
YWl0X2dwLCBjYWxsX3JjdV9wb2xsLA0KKyAgICAgICAgICAgICAgICAgIlJDVSBQb2xsIik7DQor
dm9pZCBjYWxsX3JjdV9wb2xsKHN0cnVjdCByY3VfaGVhZCAqcmhwLCByY3VfY2FsbGJhY2tfdCBm
dW5jKQ0KK3sNCisgICAgICAgY2FsbF9yY3VfdGFza3NfZ2VuZXJpYyhyaHAsIGZ1bmMsICZyY3Vf
cG9sbCk7DQorfQ0KK0VYUE9SVF9TWU1CT0xfR1BMKGNhbGxfcmN1X3BvbGwpOw0KKw0KK3ZvaWQg
c3luY2hyb25pemVfcmN1X3BvbGwodm9pZCkNCit7DQorICAgICAgIHN5bmNocm9uaXplX3JjdV90
YXNrc19nZW5lcmljKCZyY3VfcG9sbCk7DQorfQ0KK0VYUE9SVF9TWU1CT0xfR1BMKHN5bmNocm9u
aXplX3JjdV9wb2xsKTsNCisNCitzdGF0aWMgaW50IF9faW5pdCByY3Vfc3Bhd25fcG9sbF9rdGhy
ZWFkKHZvaWQpDQorew0KKyAgICAgICBjYmxpc3RfaW5pdF9nZW5lcmljKCZyY3VfcG9sbCk7DQor
ICAgICAgIHJjdV9wb2xsLmdwX3NsZWVwID0gSFogLyAxMDsNCisgICAgICAgcmN1X3NwYXduX3Rh
c2tzX2t0aHJlYWRfZ2VuZXJpYygmcmN1X3BvbGwpOw0KKyAgICAgICByZXR1cm4gMDsNCit9DQoN
ClRoYW5rcw0KWnFpYW5nDQoNCg0KPiA+IA0KPiA+IDxzbmlwPg0KPiA+ICAgPC4uLj4tMjkgICAg
ICBbMDAxXSBkLi4xLiAyMTk1MC4xNDUzMTM6IHJjdV9iYXRjaF9zdGFydDogcmN1X3ByZWVtcHQN
Cj4gPiBDQnM9MzYxMyBibD0yOA0KPiA+IC4uLg0KPiA+ICAgPC4uLj4tMjkgICAgICBbMDAxXSAu
Li4uLiAyMTk1MC4xNTI1Nzg6IHJjdV9pbnZva2VfY2FsbGJhY2s6IHJjdV9wcmVlbXB0DQo+ID4g
cmhwPTAwMDAwMDAwYjJkNmRlZTggZnVuYz1fX2ZyZWVfdm1fYXJlYV9zdHJ1Y3QuY2ZpX2p0DQo+
ID4gICA8Li4uPi0yOSAgICAgIFswMDFdIC4uLi4uIDIxOTUwLjE1MjU3OTogcmN1X2ludm9rZV9j
YWxsYmFjazogcmN1X3ByZWVtcHQNCj4gPiByaHA9MDAwMDAwMDBhNDQ2ZjYwNyBmdW5jPV9fZnJl
ZV92bV9hcmVhX3N0cnVjdC5jZmlfanQNCj4gPiAgIDwuLi4+LTI5ICAgICAgWzAwMV0gLi4uLi4g
MjE5NTAuMTUyNTgwOiByY3VfaW52b2tlX2NhbGxiYWNrOiByY3VfcHJlZW1wdA0KPiA+IHJocD0w
MDAwMDAwMGE1Y2FiMDNiIGZ1bmM9X19mcmVlX3ZtX2FyZWFfc3RydWN0LmNmaV9qdA0KPiA+ICAg
PC4uLj4tMjkgICAgICBbMDAxXSAuLi4uLiAyMTk1MC4xNTI1ODE6IHJjdV9pbnZva2VfY2FsbGJh
Y2s6IHJjdV9wcmVlbXB0DQo+ID4gcmhwPTAwMDAwMDAwMTNiN2U1ZWUgZnVuYz1fX2ZyZWVfdm1f
YXJlYV9zdHJ1Y3QuY2ZpX2p0DQo+ID4gICA8Li4uPi0yOSAgICAgIFswMDFdIC4uLi4uIDIxOTUw
LjE1MjU4MjogcmN1X2ludm9rZV9jYWxsYmFjazogcmN1X3ByZWVtcHQNCj4gPiByaHA9MDAwMDAw
MDAwYThjYTZmOSBmdW5jPV9fZnJlZV92bV9hcmVhX3N0cnVjdC5jZmlfanQNCj4gPiAgIDwuLi4+
LTI5ICAgICAgWzAwMV0gLi4uLi4gMjE5NTAuMTUyNTgzOiByY3VfaW52b2tlX2NhbGxiYWNrOiBy
Y3VfcHJlZW1wdA0KPiA+IHJocD0wMDAwMDAwMDhmMTYyY2E4IGZ1bmM9d2FrZW1lX2FmdGVyX3Jj
dS5jZmlfanQNCj4gPiAgIDwuLi4+LTI5ICAgICAgWzAwMV0gZC4uMS4gMjE5NTAuMTUyNjI1OiBy
Y3VfYmF0Y2hfZW5kOiByY3VfcHJlZW1wdCBDQnMtDQo+ID4gaW52b2tlZD0zNjEyIGlkbGU9Li4u
Lg0KPiA+IDxzbmlwPg0KPiA+DQo+IA0KPiBEaWQgdGhlIHJlc3VsdHMgYWJvdmUgdGVsbCB1cyB0
aGF0IENCcy1pbnZva2VkPTM2MTIgZHVyaW5nIHRoZSB0aW1lIDIxOTUwLjE0NTMxMyB+IDIxOTUw
LjE1MjYyNT8NCj4gDQo+WWVzLg0KPg0KPg0KPiBJZiBwb3NzaWJsZSwgbWF5IEkga25vdyB0aGUg
c3RlcHMsIGNvbW1hbmRzLCBhbmQgcmVsYXRlZCBwYXJhbWV0ZXJzIHRvIHByb2R1Y2UgdGhlIHJl
c3VsdHMgYWJvdmU/DQo+IFRoYW5rIHlvdSENCj4gDQo+QnVpbGQgdGhlIGtlcm5lbCB3aXRoIENP
TkZJR19SQ1VfVFJBQ0UgY29uZmlndXJhdGlvbi4gVXBkYXRlIHlvdXIgInNldF9ldmVudCINCj5m
aWxlIHdpdGggYXBwcm9wcmlhdGUgdHJhY2VzOg0KPg0KPjxzbmlwPg0KPlhRLURRNTQ6L3N5cy9r
ZXJuZWwvdHJhY2luZyAjIGVjaG8gcmN1OnJjdV9iYXRjaF9zdGFydCByY3U6cmN1X2JhdGNoX2Vu
ZCByY3U6cmN1X2ludm9rZV9jYWxsYmFjayA+IHNldF9ldmVudA0KPg0KPlhRLURRNTQ6L3N5cy9r
ZXJuZWwvdHJhY2luZyAjIGNhdCBzZXRfZXZlbnQNCj5yY3U6cmN1X2JhdGNoX3N0YXJ0DQo+cmN1
OnJjdV9pbnZva2VfY2FsbGJhY2sNCj5yY3U6cmN1X2JhdGNoX2VuZA0KPlhRLURRNTQ6L3N5cy9r
ZXJuZWwvdHJhY2luZyAjDQo+PHNuaXA+DQo+DQo+Q29sbGVjdCB0cmFjZXMgYXMgbXVjaCBhcyB5
b3Ugd2FudDogWFEtRFE1NDovc3lzL2tlcm5lbC90cmFjaW5nICMgZWNobyAxID4gdHJhY2luZ19v
bjsgc2xlZXAgMTA7IGVjaG8gMCA+IHRyYWNpbmdfb24NCj5OZXh0IHByb2JsZW0gaXMgaG93IHRv
IHBhcnNlIGl0LiBPZiBjb3Vyc2UgeW91IHdpbGwgbm90IGJlIGFibGUgdG8gcGFyc2UNCj5tZWdh
Ynl0ZXMgb2YgdHJhY2VzLiBGb3IgdGhhdCBwdXJwb3NlIGkgdXNlIGEgc3BlY2lhbCBDIHRyYWNl
IHBhcnNlci4NCj5JZiB5b3UgbmVlZCBhbiBleGFtcGxlIHBsZWFzZSBsZXQgbWUga25vdyBpIGNh
biBzaG93IGhlcmUuDQo+DQo+LS0NCj5VbGFkemlzbGF1IFJlemtpDQo=
