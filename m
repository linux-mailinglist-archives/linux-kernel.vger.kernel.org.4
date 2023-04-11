Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172DD6DD0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjDKEIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDKEIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:08:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF09D10EB;
        Mon, 10 Apr 2023 21:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681186127; x=1712722127;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XjENDCTJu2gLAbO7dJNoj9Ymnx6xDa/hrSAuw9pLKa0=;
  b=a6m5WhkYgB3qO5jM0tkFw/QHLzieJ+TVCVrgEIv4kfDmP9IQGjuo5HUC
   HBAzkPdIEEJRaR2wcKm0PJLSFAhRkHDM0r4aXbMJYjc6lXpZU0v0aLxDY
   yXdu5PZpDiG4s7LPmo672YOqPmwGwrIWDmedgCytPMXYyUGkJN1l9+OSG
   uY2ylKt8ytMgplSr1pR/kiY4UH8CcKzGMgeqpr2JsnjZC+W6efzqwfVX4
   6ropKIHAO4vbVuYLx8Pbek4AWxWGIt7zINujqYNft8bWWiMK0FMOu1Gc4
   GFiMSV8gCBnE8bTMscwjsgpHV4JYP6vhrTJzoFQbAtIGpciRy8BSIjAs2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="345305426"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="345305426"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 21:08:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="777760296"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="777760296"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Apr 2023 21:08:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 21:08:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 10 Apr 2023 21:08:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 10 Apr 2023 21:08:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m36dLDyAwgsRGw7mpXa74ZU9wl2XNdWO4ErVQx25P3jYJPE4gnkW/ZQzJBwxukw66IBVWUXs1HgYsTJUbY3x0Olmp6ESFhlRG71YOV1F0lnRb9gu6k80dILxj3Y26EQRSq2mbujqhzo6SMNLcAK0gO1VR5a/fVde4ejYEHuk0EryyydnFsjSlAPXmWlR1zegYfvXciOX16+Fv/P1iw7L9LZ51RzJ3gu2+/JCSDmtwOpUcSZLY/5tcSQYkg2wxr/XwMoheFQzrnTUL0hcTZ2PYjmkHqOQ+h0VmARiSV6fC7LHXiTZQEjRUWSig+mgTbVwJ7Hs2KfSHvEhxK7zaTLh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjENDCTJu2gLAbO7dJNoj9Ymnx6xDa/hrSAuw9pLKa0=;
 b=NnFjx39hjdeNaTPQ6PXvRjiJD7FjFo6qZI32dmd/7GfNKg9wrF8ljiWiOg/NdpaHDd3NyrlkSghB5LouSu6rmqRVDSQDpyaeS83icBmZiOwvDVBnwlhV/oee0y6joy4QOB8RyGXIjw/WmyQFl5b50E+glC0zwD9mcfTu4AT0yStQT5qIbzAj52FhPRlzMoxziQ0Jm4K1QqGjXJcoCJ+xBAu9ZfrblUqW2sKiZ38vfxItcRsftVj81uYCX6pedhbF+FcaM4GsGOy46NXgH9nu/IMNqiG4thyuFXVFMq8MEFbvz3Viah1LIlJeqaKP6glSEw2iEWGtNUiU/Rc3JNH39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Tue, 11 Apr
 2023 04:08:44 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0%5]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 04:08:44 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "urezki@gmail.com" <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu/kvfree: Make page cache growing happen on the correct
 krcp
Thread-Topic: [PATCH] rcu/kvfree: Make page cache growing happen on the
 correct krcp
Thread-Index: AQHZaiXmMhx2A7mvH0636uWzxC9RcK8lPpIAgABCqSA=
Date:   Tue, 11 Apr 2023 04:08:44 +0000
Message-ID: <PH0PR11MB5880D8EC717B08233E822845DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230408142530.800612-1-qiang1.zhang@intel.com>
 <628ee057-d957-431b-be4a-0bf893bf56ef@paulmck-laptop>
In-Reply-To: <628ee057-d957-431b-be4a-0bf893bf56ef@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BN9PR11MB5257:EE_
x-ms-office365-filtering-correlation-id: 091e74b7-314a-43c4-2293-08db3a427169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ljAYbDGOU+/1KPw6G1PkSm0pk+a6aeQM/wLqBM3lQpCgwPjdqpx+6tEyzq6VbPxD7R0x88CZfNOEXnF6lu9CQrsCUoVG/jyzJF6RJl6MA4uwGG/ZGgk0e5FjX43Sa5zPt3lqKu/7GvNletWLp9hXjO83A4HisI1rWup1W7M4sNRbEl7VUWcWb4VvuOE5V8K0R1/jlOLZO84R+WAfODxy1BZLxqO+0ZGZDcg0JgX0Tpp2qxTgVuf23OxyGjzfE0uGPZFba+lh8Goy93fex4e98/UBZb7Etyv9yYnVDQPuASQROdb45Uu+Yvg2/hprdBMyfnM7uQocuFOLGzk4veoj9Uwa0mDmH8Rx1xCCgCdlGgO3c7KkgN5yXfZvONnP4hjFf7zRqeZRn7ExboHAzkkUrcT0GpXQ4xhnFsuwYZO115BjUL8uqgLbmz5xtXUoCbK0hV9QVH2mcrqI6whP8qXNOIS9G/GGemBK8zxOgZoxGgbSgrBHL/BUfX6tG/ofqkBdGHg5C/sdbCUDIyGbCPJBAWICOJaQxHT/tM+zMZ3dGdF99XvBc9ffrOgRV+Ab9qCbhqYcO/XuC0Amg/Ka0+fs+8ssMSuD2M2khx6+v+/cFgvISKhzf/kAe7ziFTA6Q7QD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(7696005)(71200400001)(478600001)(55016003)(86362001)(33656002)(38070700005)(83380400001)(38100700002)(82960400001)(122000001)(2906002)(9686003)(316002)(6506007)(186003)(54906003)(26005)(66476007)(52536014)(8676002)(66556008)(6916009)(8936002)(5660300002)(41300700001)(66446008)(64756008)(4326008)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THMwZ1didXhyMlY1aEplL2EzSW5oK0d1WkxrTkp5K1RGNUVkYUQxNTQ1ZzZS?=
 =?utf-8?B?OWlHSlZvL3h3ckFkRVVNS3FYZlB5dmlqT0JESWJkRWx4eEJRcFFLYXpLZ2ZT?=
 =?utf-8?B?bGg3MUllVWhVc24rRVo3Vjg5dEh0K25vQ3RoaFhPS2NQQ1VQNll4cjlqTyt6?=
 =?utf-8?B?MkpiYnorSm03ZndLb2ZCbDQ3Mk1qU0xSM05jb0VuZUYyN3JGKy9oRzhIeHlh?=
 =?utf-8?B?d0RKeVFQc3A5Sk0zRGxnMHFlMXZmNlYycmhpTjZJTldXSnJTMm96NlFmdTNU?=
 =?utf-8?B?R1JoaWdwajM4blBjQWJqSC95MFBJaVE2b1VyMTUrbCtpWTlkMllYNGdqZEhP?=
 =?utf-8?B?MXYzTlJ0U1V1bWJzQytDemtLcEV3OXVqQTNFNm9lb3d3eUl5U3AzRjc5VTJ6?=
 =?utf-8?B?ZHlwTXQrc1paaWpGZFQ1RlhOMjBYSUZrU0czT1hZNUNNajBzZzhlV0pndjJv?=
 =?utf-8?B?VmJQdWFMU2VKZ1dkaC9pdUdoNW9Jc0JJZ1BkVjFYeDVTVUZGTE5EaXBpZW9V?=
 =?utf-8?B?NEgrL051Nm51SFFwUjZsMEpDT0IwRHJzZkFOVnNjczM2TFJjYjMxaXBNbnJt?=
 =?utf-8?B?TjFEdU1MU0E2N1dTb0N3ZXcrMHFPcmRVUm0zaDY3VXp5ckVtWXhMc1VzbVNK?=
 =?utf-8?B?Z29uZUYwUzI4d2hWSVJRSWRRUGF5OU84emMzS1VnWnl4Q05WVy9TQ3BydmMv?=
 =?utf-8?B?M1YvQVRDUEhaYllkWlkvQUM5R0lBek01N3hmSXVmUWphZjl0a3JwT2psQ0lT?=
 =?utf-8?B?NkU0cDZmWGZtTnVWZDg5RHZySStkZTVJUHJJMUxYTXNtelBieTVIL2hOZWxX?=
 =?utf-8?B?U0JNVm1zdXB1SFhCTmRPSXdYbW5TMm5BWW8veUlMdmtlczFmbkR0U2h5bkVT?=
 =?utf-8?B?RlVxQVliK2s1c25ZOWNtZURERWFIcFMwZWpEbSs3N214NFVmVklrTUlWV0NM?=
 =?utf-8?B?Nk8zSVZyL05GWWxVQkdOdDNRN3dyNm9uK01nOFRyL2plck9paFViMmYwbU5D?=
 =?utf-8?B?YVUxQ1dDWGtTbVRGSnY4NkJESkw1Z0J3dk44Q1dLRy81cFExbnNtZHJIQW5w?=
 =?utf-8?B?SmFUbHk0RktYQXIwKzFxb1B3c0Nqc1Q1Q0NGSUdhYjllL2VkcFdjR0U2WWVW?=
 =?utf-8?B?V0Z3TG9VWTZlVjBZdzFEZVFhd1VCWXhSQ0Y3amtNWFoxMDkzdkNJcXJZMlNJ?=
 =?utf-8?B?cUo5TWc0VGFMd1RmU1JBekp0QVhIMjRCMkllWEtTWnFObndNbnBZU29sNlhv?=
 =?utf-8?B?cnJvUDhQNWhHTzIyQnlnU1BxZVFrcThMMmx2d3d6Yy8rdEZmK0xTUVlHZWtj?=
 =?utf-8?B?MFFKU05aclZ3a2NOem4wcGlFWndJY3QvbUt1aHpjYWFmcWtFRU91UEhpeHNK?=
 =?utf-8?B?UW9jRmdna094YlVWbzNqYkNYQ0JkNklmY2FiMmppS2VsYmd1UkF6UW1qSGVs?=
 =?utf-8?B?Zldyb3pMUzZ0QzFuSHlwdmFlbU9mSHI3bTltYUY2bHdHVEk5N2tGU1diMWM5?=
 =?utf-8?B?ZFBMR244M2RKZG9jcWFQVTRBc0xOVGxYNlcxOGNQTW8wNGN0VTJEZlZ4TDNK?=
 =?utf-8?B?Q1Zwb3RUL1RNMENocitLMzVBVDVEWWZZME9PQWVHTm16YjEweXRZdVQ0RC9n?=
 =?utf-8?B?UDhLclJiQ0d1WHFFenc3dHhiSVpuMDdVQTJ0V2VuZ1hkaExnMFZGZUd1MjV3?=
 =?utf-8?B?bW9VeGJhOHA1RGk2dUJWVy8veTE3YmFQa3lLbXdnajJsR2s5aEM4TzRUeTNq?=
 =?utf-8?B?K1FydzV5amZIa3hPZk9FQW80NXo2ZFh4bU9hS2ZwTktPQjdKaHFOU2J4YTgz?=
 =?utf-8?B?R0MvME16eUhPRDVDUmNySmprODRIZUpCSEFFWEJ1UXdNVjA1LzI4OSthRnJT?=
 =?utf-8?B?YWw5UFFHbk92WDNwTVFKa1B1OXNzZnNYMnZkMlVVdTFFZm02ak1SRXh3MElD?=
 =?utf-8?B?QVlEMzY1Tmt4NzN1bmNvMmk3NlpHdUxibThSd1d0dldhbjJpbkRRaDVhcytW?=
 =?utf-8?B?ejFDbk5oSEg2SFNSeGNLZmU0YUE3dFdkZEZWWmR6L3FvOVVadzV0SG80NWRX?=
 =?utf-8?B?MnhtSzJBUzVRczE5UGNOL1VmcHQ1eDFxeXQrVjRZM2IycnUra3hOOXNGbXVL?=
 =?utf-8?Q?MEiY35O00TXiDJwktt8auUYuo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091e74b7-314a-43c4-2293-08db3a427169
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 04:08:44.7751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfMTt3YJuts04AOFIYulYXRnLhlFg+17eEBsNtg7ubyRdN/wp11AE4L1bIsFFMef+xCdM3rVlL9hpeFcsExdiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
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

PiBXaGVuIGludm9rZSBhZGRfcHRyX3RvX2J1bGtfa3JjX2xvY2soKSB0byBxdWV1ZSBwdHIsIHdp
bGwgaW52b2tlDQo+IGtyY190aGlzX2NwdV9sb2NrKCkgcmV0dXJuIGN1cnJlbnQgQ1BVJ3Mga3Jj
cCBzdHJ1Y3R1cmUgYW5kIGdldCBhDQo+IGJub2RlIG9iamVjdCBmcm9tIHRoZSBrcmNwIHN0cnVj
dHVyZSdzIC0+YnVsa19oZWFkLCBpZiByZXR1cm4gaXMNCj4gZW1wdHkgb3IgdGhlIHJldHVybmVk
IGJub2RlIG9iamVjdCdzIG5yX3JlY29yZHMgaXMgS1ZGUkVFX0JVTEtfTUFYX0VOVFIsDQo+IHdo
ZW4gdGhlIGNhbl9hbGxvYyBpcyBzZXQsIHdpbGwgdW5sb2NrIGN1cnJlbnQgQ1BVJ3Mga3JjcC0+
bG9jayBhbmQNCj4gYWxsb2NhdGUgYm5vZGUsIGFmdGVyIHRoYXQsIHdpbGwgaW52b2tlIGtyY190
aGlzX2NwdV9sb2NrKCkgYWdhaW4gdG8NCj4gcmV0dXJuIGN1cnJlbnQgQ1BVJ3Mga3JjcCBzdHJ1
Y3R1cmUsIGlmIHRoZSBDUFUgbWlncmF0aW9uIG9jY3VycywNCj4gdGhlIGtyY3Agb2J0YWluZWQg
YXQgdGhpcyB0aW1lIHdpbGwgbm90IGJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgcHJldmlvdXMNCj4g
b25lLCB0aGlzIGNhdXNlcyB0aGUgYm5vZGUgd2lsbCBiZSBhZGRlZCB0byB0aGUgd3Jvbmcga3Jj
cCBzdHJ1Y3R1cmUncw0KPiAtPmJ1bGtfaGVhZCBvciB0cmlnZ2VyIGZpbGwgcGFnZSB3b3JrIG9u
IHdyb25nIGtyY3AuDQo+IA0KPiBUaGlzIGNvbW1pdCB0aGVyZWZvcmUgcmUtaG9sZCBrcmNwLT5s
b2NrIGFmdGVyIGFsbG9jYXRlZCBwYWdlIGluc3RlYWQNCj4gb2YgcmUtY2FsbCBrcmNfdGhpc19j
cHVfbG9jaygpIHRvIGVuc3VyZSB0aGUgY29uc2lzdGVuY3kgb2Yga3JjcC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4NCj5WZXJ5IGdvb2Qs
IHRoYW5rIHlvdSEgIFF1ZXVlZCBmb3IgdGVzdGluZyBhbmQgZnVydGhlciByZXZpZXcsIGJ1dA0K
PnBsZWFzZSBjaGVjayBteSB3b3Jkc21pdGhpbmcuDQoNCg0KTW9yZSBjbGVhciBhbmQgZGV0YWls
ZWQgZGVzY3JpcHRpb24sIFRoYW5rcyBQYXVsIPCfmIouDQoNCg0KPg0KPgkJCQkJCQlUaGFueCwg
UGF1bA0KPg0KPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPg0KPmNvbW1pdCBhMGJiYjU3ODU1MzllZDg0NmY0
NzY5MzY4ZjI0YTI5NmQ1NGJjODAxDQo+QXV0aG9yOiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRl
bC5jb20+DQo+RGF0ZTogICBTYXQgQXByIDggMjI6MjU6MzAgMjAyMyArMDgwMA0KPg0KPiAgICBy
Y3Uva3ZmcmVlOiBVc2UgY29uc2lzdGVudCBrcmNwIHdoZW4gZ3Jvd2luZyBrZnJlZV9yY3UoKSBw
YWdlIGNhY2hlDQo+ICAgIA0KPiAgICBUaGUgYWRkX3B0cl90b19idWxrX2tyY19sb2NrKCkgZnVu
Y3Rpb24gaXMgaW52b2tlZCB0byBhbGxvY2F0ZSBhIG5ldw0KPiAgICBrZnJlZV9yY3UoKSBwYWdl
LCBhbHNvIGtub3duIGFzIGEga3ZmcmVlX3JjdV9idWxrX2RhdGEgc3RydWN0dXJlLg0KPiAgICBU
aGUga2ZyZWVfcmN1X2NwdSBzdHJ1Y3R1cmUncyBsb2NrIGlzIHVzZWQgdG8gcHJvdGVjdCB0aGlz
IG9wZXJhdGlvbiwNCj4gICAgZXhjZXB0IHRoYXQgdGhpcyBsb2NrIG11c3QgYmUgbW9tZW50YXJp
bHkgZHJvcHBlZCB3aGVuIGFsbG9jYXRpbmcgbWVtb3J5Lg0KPiAgICBJdCBpcyBjbGVhcmx5IGlt
cG9ydGFudCB0aGF0IHRoZSBsb2NrIHRoYXQgaXMgcmVhY3F1aXJlZCBiZSB0aGUgc2FtZQ0KPiAg
ICBsb2NrIHRoYXQgd2FzIGFjcXVpcmVkIGluaXRpYWxseSB2aWEga3JjX3RoaXNfY3B1X2xvY2so
KS4NCj4gICAgDQo+ICAgIFVuZm9ydHVuYXRlbHksIHRoaXMgc2FtZSBrcmNfdGhpc19jcHVfbG9j
aygpIGZ1bmN0aW9uIGlzIHVzZWQgdG8NCj4gICAgcmUtYWNxdWlyZSB0aGlzIGxvY2ssIGFuZCBp
ZiB0aGUgdGFzayBtaWdyYXRlZCB0byBzb21lIG90aGVyIENQVSBkdXJpbmcNCj4gICAgdGhlIG1l
bW9yeSBhbGxvY2F0aW9uLCB0aGlzIHdpbGwgcmVzdWx0IGluIHRoZSBrdmZyZWVfcmN1X2J1bGtf
ZGF0YQ0KPiAgICBzdHJ1Y3R1cmUgYmVpbmcgYWRkZWQgdG8gdGhlIHdyb25nIENQVSdzIGtmcmVl
X3JjdV9jcHUgc3RydWN0dXJlLg0KPiAgICANCj4gICAgVGhpcyBjb21taXQgdGhlcmVmb3JlIHJl
cGxhY2VzIHRoYXQgc2Vjb25kIGNhbGwgdG8ga3JjX3RoaXNfY3B1X2xvY2soKQ0KPiAgICB3aXRo
IHJhd19zcGluX2xvY2tfaXJxc2F2ZSgpIGluIG9yZGVyIHRvIGV4cGxpY2l0bHkgYWNxdWlyZSB0
aGUgbG9jayBvbg0KPiAgICB0aGUgY29ycmVjdCBrZnJlZV9yY3VfY3B1IHN0cnVjdHVyZSwgdGh1
cyBrZWVwaW5nIHRoaW5ncyBzdHJhaWdodCBldmVuDQo+ICAgIHdoZW4gdGhlIHRhc2sgbWlncmF0
ZXMuDQo+ICAgIA0KPiAgICBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRl
bC5jb20+DQo+ICAgIFNpZ25lZC1vZmYtYnk6IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2Vy
bmVsLm9yZz4NCj4NCj5kaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlLmMgYi9rZXJuZWwvcmN1
L3RyZWUuYw0KPmluZGV4IDI2OTliN2FjZjBlMy4uNDFkYWFlMzIzOWI1IDEwMDY0NA0KPi0tLSBh
L2tlcm5lbC9yY3UvdHJlZS5jDQo+KysrIGIva2VybmVsL3JjdS90cmVlLmMNCj5AQCAtMzMwMSw3
ICszMzAxLDcgQEAgYWRkX3B0cl90b19idWxrX2tyY19sb2NrKHN0cnVjdCBrZnJlZV9yY3VfY3B1
ICoqa3JjcCwNCj4gCQkJLy8gc2NlbmFyaW9zLg0KPiAJCQlibm9kZSA9IChzdHJ1Y3Qga3ZmcmVl
X3JjdV9idWxrX2RhdGEgKikNCj4gCQkJCV9fZ2V0X2ZyZWVfcGFnZShHRlBfS0VSTkVMIHwgX19H
RlBfTk9SRVRSWSB8IF9fR0ZQX05PTUVNQUxMT0MgfCBfX0dGUF9OT1dBUk4pOw0KPi0JCQkqa3Jj
cCA9IGtyY190aGlzX2NwdV9sb2NrKGZsYWdzKTsNCj4rCQkJcmF3X3NwaW5fbG9ja19pcnFzYXZl
KCYoKmtyY3ApLT5sb2NrLCAqZmxhZ3MpOw0KPiAJCX0NCj4gDQo+IAkJaWYgKCFibm9kZSkNCg==
