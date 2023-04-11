Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887C16DDE4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDKOmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjDKOmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:42:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3656A44A6;
        Tue, 11 Apr 2023 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681224159; x=1712760159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X8N6RslLiERIM8cxbDJVINbiV1/T43HdEIHF4lMjs6A=;
  b=gqv4shfvwFV/VSMxMr2hC1YunvPM/9oBlR9WSRvJw//jZx3ovlI1fm9l
   Nyl+FdYJ0lgQWAw2ZShSLiAqW9glaMlbqfjcu6I48ZJm5dHWD/iWPWJXi
   JiCGtw0K/sJoq4ALzDDpDHY6+ie3DGz5vfFMwVONR8GT1I6RLkAxRy80h
   qaU/ZK2c0O1W4/DQSDMH8IjH1GVsOl98uYChOXgo6DEua5ZZJgcGyePwS
   bfmsD9Dy/VmHbN1OSD1XFcV9ZrJxyxoDTlfpykVKrucDLnkT3w8Kmei5v
   qUVNs9xsZsf0eOJYICfdiGs+QDrOaJF2dRSbEk2xGvZLRRzfVM899wvEO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="323996607"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="323996607"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 07:42:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="812589405"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="812589405"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 11 Apr 2023 07:42:29 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 07:42:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 07:42:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 07:42:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZALClurdGXaZZLolI/7FL5gGOtvEVXU2e5HY3zCpU2rvn7oxe4JqJ7hWvdAxUSdKe4Wu2wT1MZ37c3kfnw+VCsHp2Hq67Mu0FiRhp3bTC/U9sFhC50I0Fy2fs9ACcBmVj0WsdTsFbqNNgl2Fv36hUdKCD2RtfnWWB4RdoORd3crcZZOU9gSLXGMwJMxUGB0B8Bv9KjobPWYzqprwMHvxWrQW3tCQSdZ1CS3yH91GJlagL0Mawv+lzUURXRR/0yCSBeFGbxZUdhoJvKnUC+INgurAsjV4j8jnpdCTAuzcC9x3k67eC1NKPiCuN8HEmuFGdmIz6Z+KXSE9UQijNRV2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8N6RslLiERIM8cxbDJVINbiV1/T43HdEIHF4lMjs6A=;
 b=lYvgUfhrrRBnH4W5gYu2p5tWAC2B1PZ3YKp2UkEPoxohgyoectSUUZD0oq3IHRIK1ZaHMYkc7KoG0MY4zQ9tSRVRk9aaHbMfo+PFFO8YGJlmG7rsNWPJiFxdci77D5gk7+wXDZIPlJD5S72VmlrpSuDicOhYShpKF38S+WT9dkSkMB2sVIgFTHlKs9PV4cEZruFl5TEO+rPydfYzBWnZ7lu8XXI5T+/nsmv3CRUU8FuTsaLjxdVxm11O/qOcwJVGvZosuHy62PvGAlx61gtbdg5onp1lFQSb6eyz4jF3SGypmJYy/faeiblLnQ4H1qTzv+D1FlTtbt/WQMR16GrHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Tue, 11 Apr
 2023 14:42:27 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0%5]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 14:42:27 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Topic: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Index: AQHZaiXby4kI/lAQlUSTC1cR7UMpS68lNdWAgABJBmCAAK/VgIAAAf6g
Date:   Tue, 11 Apr 2023 14:42:27 +0000
Message-ID: <PH0PR11MB5880C4B181B6237402B1FBA7DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230408142517.800549-1-qiang1.zhang@intel.com>
 <b96953b0-0ac5-477a-a2f0-c211dc17d5dc@paulmck-laptop>
 <PH0PR11MB588072A12543FD617C833AF9DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDVt5eUAlp4VmbFy@pc636>
In-Reply-To: <ZDVt5eUAlp4VmbFy@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CO1PR11MB4771:EE_
x-ms-office365-filtering-correlation-id: ebedb012-3e75-4b15-a955-08db3a9af87d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TUJ/Ya3yFMOxjv7bbGHsEqU71e6tmOQ+V0lXsPfjs0XrCMVljT9Xvg3c+STTqiL172rxlbo+ji0NuYnhl7E3d9Z829xjPoWaHO58HC7gVlUTlU/badI9i1SjsUeeHR5KKO6zntU9jnAJT0pnFfeTLAU/vK6YFuidRUsplb3/JfXad9X4j6SE8Vq050bnJk0CJDMUDWEIcbf/8OZQesv4M9EWnop1hFOVB0VpcE6oD1vkXyYchnwn6MEpIWCW7+JSIQdCN+N6h7jLKXJZDmuNsgATX7+HxC9pIsPIOxvlifquIxzOXM0PxQCG87rVuLsWLCoQ+nUYSPY1rMpNnVWLCGp24c+FJz+hsdVg877NulMS1ou1YX8WgX3LoHHrZ1B7ezJM5o5ayDjKv96qL9CQX7yZZsnlJHbESGawlmMvH6zpNH41JbMjFnTHcQbHrd1PwVyH23/bMEYYcudiJeFduB1Dhgm+GcjOJxfN8dUd/sTJKLdbhDfi0sunKrM4V+73Nnbj9YMYpV1QCEetDMTUtt3zWf/0pkrxh2f08ms7UrfLJ31AeDZm4dh84dzhziLIDYM8R+AcOEJdH5nIPCKsW+pkHdDulV+s7YWMn8jZG3XkmnxrxN20nHimVJ3IoAw1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(9686003)(64756008)(4326008)(66556008)(76116006)(8676002)(54906003)(66946007)(316002)(66446008)(6916009)(66476007)(6506007)(186003)(83380400001)(38100700002)(71200400001)(41300700001)(55016003)(478600001)(26005)(8936002)(7696005)(52536014)(38070700005)(86362001)(2906002)(5660300002)(122000001)(33656002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ald4QXNvOVFQMEltUkhXeTN4YUtobXUza2xDRVRoemh0Q29MTUJ3d25EakR5?=
 =?utf-8?B?UWFjYjNPUTFmbWdFdnhSaEw1clhyanlSRHNBTFQwUC9oN2grUG1nSlNFQXpm?=
 =?utf-8?B?cGNzbFdDR1F6WC9oNXVUSm13dlNVMW16NklEOTJTM1lWNkhtYU52UTRpSVRZ?=
 =?utf-8?B?WDliZmxBb1VkNmtJdi84VWFHSWlFWnBQdGZGNTFKajJ3VEZLMWtHQzBoeTFz?=
 =?utf-8?B?M1hQQVlyL0tuc0g5ZllPdTh5TXRjK3RSbDA3aU4rck5SQk16YmNNUDNtYTVL?=
 =?utf-8?B?TU9lQVdEclN2dWFhQmVuUDU2cEczU1FsL0lPalQxaWU0M2U0dnpnWkljZE5p?=
 =?utf-8?B?MDdnMmczNXlocmFlMEMyNlI4dVV3b2pBNGZ2SEsyalRzOFVoczQ3M25Mbnlh?=
 =?utf-8?B?VTM3L1l2MW9OYmxYMlpUNWtVcHBkMjhjOXF3RlZwL2wxQWNzcjZWUm8wU2xr?=
 =?utf-8?B?c2pUVHhFc2tlaVhsNStiKzZmZk1ESlVldnVkQmR3aWszOEhrZW5ZcVFDSW8w?=
 =?utf-8?B?SU1qbnVQTklrbUFrVXhhbFBheVRHTE5iUEYvVlFWcFIvUnE1MGhyV25JNUZk?=
 =?utf-8?B?UzRiQnNNenQ0bEJkYWV2U25XT3dpajVJa0t3c1doeDA2dXlwcXZQbmVBcHRu?=
 =?utf-8?B?YklQNGNxVmNFVEMwQ2RCbm9RTEcxNHlEbSsxandPMW9CS0xBQ3hZMFNjRXRF?=
 =?utf-8?B?OGtNb3dCUlNEWFpZUFVKWTZrQ2VlNmdCNDVwWWFLZVJ6azE1a2Y3Q0NkQTI0?=
 =?utf-8?B?dmdmOU0xaFJqUUtLTnpIZ0c3cnI2NjdFQURQdVJiY2FyaXNUOFhVbVZRcFFr?=
 =?utf-8?B?VDUwVno4THNETXpydndERjlQblRhZHRzb0p4enl2Q3JtVk4xMUF4aGFldkcw?=
 =?utf-8?B?Y3pBVlc2VVBGbG0zOHVtR01mN0loZmsvbm8waG1VMStORHIxb2FTQzdxY2FY?=
 =?utf-8?B?MFdqclFtazd0YWRDckxlUDRQYVBoN2RITWd5SXZ2NnpoUG5OQ3FDdllDWEZV?=
 =?utf-8?B?YnRGYktzZUM4S1B5QWsvVFBYaDdHTlhpM0Z4NDZpUjhaZEtKalhmWFpjUTFm?=
 =?utf-8?B?bE52MlhPRjB6UTlNMzJ6WU41M2JOQjI2U3FoVjA0ZXptenhxamJuWkZJSzIy?=
 =?utf-8?B?Z01Rb0JHUWRXSjc1NFozdU9wVlBpa2t0dGV1Y3c4eVZiVDg2S3ArQnB2R2g2?=
 =?utf-8?B?SHdleWJSdGFkWS83REpJc1hMNVgweUhNTmI0eDAvWXV6WTRsQVRSdGRLcHEx?=
 =?utf-8?B?Wkh4UGoycDhzckxLMHZyZUNYVGJtRmllSHIyUldZL1k1Y2pON3RFRm1pV1Ru?=
 =?utf-8?B?QXFMajlQanQybzVQZC9lTzk1UCsxVGVFWHpCeXlYSDh0K3IwTWFSeWNIczE5?=
 =?utf-8?B?ZjZMZzBKbzJZTUlvUkhFTWZyRzkyQllCU3Y4eHZ1VTBxT0lFNW1hbkNiQWRR?=
 =?utf-8?B?SEJkK1d4ZnBNOFd3SWlaRTZ6N3lTNHV2ZEVsWTVoRE1QT08ySEtxZmNvWThy?=
 =?utf-8?B?QkpzNmRCTjVCQ3VueG1YOVliYTljSkNtanphVDZtdmoza0kzNm83QU9xTWZY?=
 =?utf-8?B?alVicXN0ZTYxeFV6clJLWTBkNUdrclY0eVVJVDhjaTNVK1ltbm90YzJoeUZ5?=
 =?utf-8?B?TW1MM0tJQjZESTE5MSs5UWF2SW1RMFVsU0NLVTNqejVQTlA4d1ZsTnE4TGtC?=
 =?utf-8?B?OUJxek10cUdNMlBwZWUyV2w1WUYwcU5aWWh1Nk1uNnMrazlQN1R1YUxNNkwr?=
 =?utf-8?B?d1hGc3hCNUgwdVREVVZobGZMZSs4RjV6SDR0ZE9JODBpSlVHS1FhYUdGYlZu?=
 =?utf-8?B?WGNOclRPNSt4WlNaWFNKeTduL28waTNDbzlMeEErZkFxZ25yTUhxdm5mSDlX?=
 =?utf-8?B?ZlVtaFRhdFkvVGZqZFhGR2p0RjBodVVYOXFQVmJ2ZnpkS1owK251alp4c0R2?=
 =?utf-8?B?WXpWTEUyTlhlKzRxNWs4b3dUWXRjYnR6SnNPSG5QWFluRlhsZUZFZ0plSkpP?=
 =?utf-8?B?ZlRtRzZjS2ZqMXdoSU1HU2cvcDY0NklwM1dxUXJ2VGcwQjR6MXZ4cXNra0Nw?=
 =?utf-8?B?TU1lVi9QT01OMyt0VXdDb3NIeVlsQ2k0aE5FSjVuK2VyRU5SS09iMElRQ2tV?=
 =?utf-8?Q?+D0sSJVgcuom/Rn5HUSY0DubT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebedb012-3e75-4b15-a955-08db3a9af87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 14:42:27.1297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ch2bF7FbHfLLI0e4rPt81M3jMrv/2v+7Vc/0XNiSXRxixlp6whYnNLoMejTI5k/d7nlB9zF/qfvsr9xGdqFacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEN1cnJlbnRseSwgaW4ga2ZyZWVfcmN1X3Nocmlua19zY2FuKCksIHRoZSBkcmFpbl9wYWdl
X2NhY2hlKCkgaXMNCj4gPiBleGVjdXRlZCBiZWZvcmUga2ZyZWVfcmN1X21vbml0b3IoKSB0byBk
cmFpbiBwYWdlIGNhY2hlLCBpZiB0aGUgYm5vZGUNCj4gPiBzdHJ1Y3R1cmUncy0+Z3Bfc25hcCBo
YXMgZG9uZSwgdGhlIGt2ZnJlZV9yY3VfYnVsaygpIHdpbGwgZmlsbCB0aGUNCj4gPiBwYWdlIGNh
Y2hlIGFnYWluIGluIGtmcmVlX3JjdV9tb25pdG9yKCksIHRoaXMgY29tbWl0IGFkZCBhIGNoZWNr
DQo+ID4gZm9yIGtyY3Agc3RydWN0dXJlJ3MtPmJhY2tvZmZfcGFnZV9jYWNoZV9maWxsIGluIHB1
dF9jYWNoZWRfYm5vZGUoKSwNCj4gPiBpZiB0aGUga3JjcCBzdHJ1Y3R1cmUncy0+YmFja29mZl9w
YWdlX2NhY2hlX2ZpbGwgaXMgc2V0LCBwcmV2ZW50IHBhZ2UNCj4gPiBjYWNoZSBncm93aW5nIGFu
ZCBkaXNhYmxlIGFsbG9jYXRlZCBwYWdlIGluIGZpbGxfcGFnZV9jYWNoZV9mdW5jKCkuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPiA+
DQo+ID5NdWNoIGltcHJvdmVkISAgQnV0IHN0aWxsIHNvbWUgcXVlc3Rpb25zIGJlbG93Li4uDQo+
ID4NCj4gPgkJCQkJCQlUaGFueCwgUGF1bA0KPiA+DQo+ID4gLS0tDQo+ID4gIGtlcm5lbC9yY3Uv
dHJlZS5jIHwgNCArKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlLmMgYi9r
ZXJuZWwvcmN1L3RyZWUuYw0KPiA+IGluZGV4IGNjMzRkMTNiZTE4MS4uOWQ5ZDM3NzJjYzQ1IDEw
MDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jDQo+ID4gKysrIGIva2VybmVsL3JjdS90
cmVlLmMNCj4gPiBAQCAtMjkwOCw2ICsyOTA4LDggQEAgc3RhdGljIGlubGluZSBib29sDQo+ID4g
IHB1dF9jYWNoZWRfYm5vZGUoc3RydWN0IGtmcmVlX3JjdV9jcHUgKmtyY3AsDQo+ID4gIAlzdHJ1
Y3Qga3ZmcmVlX3JjdV9idWxrX2RhdGEgKmJub2RlKQ0KPiA+ICB7DQo+ID4gKwlpZiAoYXRvbWlj
X3JlYWQoJmtyY3AtPmJhY2tvZmZfcGFnZV9jYWNoZV9maWxsKSkNCj4gPiArCQlyZXR1cm4gZmFs
c2U7DQo+ID4NCj4gPlRoaXMgd2lsbCBtZWFuIHRoYXQgdW5kZXIgbG93LW1lbW9yeSBjb25kaXRp
b25zLCB3ZSB3aWxsIGtlZXAgemVybw0KPiA+cGFnZXMgaW4gLT5ia3ZjYWNoZS4gIEFsbCBhdHRl
bXB0cyB0byBwdXQgc29tZXRoaW5nIHRoZXJlIHdpbGwgZmFpbC4NCj4gPg0KPiA+VGhpcyBpcyBw
cm9iYWJseSBub3QgYW4gaXNzdWUgZm9yIHN0cnVjdHVyZXMgY29udGFpbmluZyBhbiByY3VfaGVh
ZA0KPiA+dGhhdCBhcmUgcGFzc2VkIHRvIGtmcmVlX3JjdShwLCBmaWVsZCksIGJ1dCBkb2Vzbid0
IHRoaXMgbWVhbiB0aGF0DQo+ID5rZnJlZV9yY3VfbWlnaHRzbGVlcCgpIHVuY29uZGl0aW9uYWxs
eSBpbnZva2VzIHN5bmNocm9uaXplX3JjdSgpPw0KPiA+VGhpcyBjb3VsZCBzZXJpb3VzbHkgc2xv
dyB1cCBmcmVlaW5nIHVuZGVyIGxvdy1tZW1vcnkgY29uZGl0aW9ucywNCj4gPndoaWNoIG1pZ2h0
IGV4YWNlcmJhdGUgdGhlIGxvdy1tZW1vcnkgY29uZGl0aW9ucy4NCj4gDQo+IFRoYW5rcyBmb3Ig
bWVudGlvbmluZyB0aGlzLCBJIGRpZG4ndCB0aGluayBvZiB0aGlzIGJlZm9yZfCfmIouDQo+IA0K
PiA+DQo+ID5JcyB0aGlzIHJlYWxseSB3aGF0IHdlIHdhbnQ/ICBaZXJvIGNhY2hlZCByYXRoZXIg
dGhhbiBqdXN0IGZld2VyIGNhY2hlZD8NCj4gPg0KPiA+DQo+ID4NCj4gPiAgCS8vIENoZWNrIHRo
ZSBsaW1pdC4NCj4gPiAgCWlmIChrcmNwLT5ucl9ia3Zfb2JqcyA+PSByY3VfbWluX2NhY2hlZF9v
YmpzKQ0KPiA+ICAJCXJldHVybiBmYWxzZTsNCj4gPiBAQCAtMzIyMSw3ICszMjIzLDcgQEAgc3Rh
dGljIHZvaWQgZmlsbF9wYWdlX2NhY2hlX2Z1bmMoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0K
PiA+ICAJaW50IGk7DQo+ID4gIA0KPiA+ICAJbnJfcGFnZXMgPSBhdG9taWNfcmVhZCgma3JjcC0+
YmFja29mZl9wYWdlX2NhY2hlX2ZpbGwpID8NCj4gPiAtCQkxIDogcmN1X21pbl9jYWNoZWRfb2Jq
czsNCj4gPiArCQkwIDogcmN1X21pbl9jYWNoZWRfb2JqczsNCj4gPiAgDQo+ID4gIAlmb3IgKGkg
PSAwOyBpIDwgbnJfcGFnZXM7IGkrKykgew0KPiA+DQo+ID5JIGFtIHN0aWxsIGNvbmZ1c2VkIGFz
IHRvIHdoeSB3ZSBzdGFydCAiaSIgYXQgemVybyByYXRoZXIgdGhhbiBhdA0KPiA+LT5ucl9ia3Zf
b2Jqcy4gIFdoYXQgYW0gSSBtaXNzaW5nIGhlcmU/DQo+IA0KPiANCj4gTm8sIHlvdSBhcmUgcmln
aHQsIEkgbWlzc2VkIHRoaXMgcGxhY2UuIA0KPiANCj4gLS0tIGEva2VybmVsL3JjdS90cmVlLmMN
Cj4gKysrIGIva2VybmVsL3JjdS90cmVlLmMNCj4gQEAgLTI5MDgsNiArMjkwOCw4IEBAIHN0YXRp
YyBpbmxpbmUgYm9vbA0KPiAgcHV0X2NhY2hlZF9ibm9kZShzdHJ1Y3Qga2ZyZWVfcmN1X2NwdSAq
a3JjcCwNCj4gICAgICAgICBzdHJ1Y3Qga3ZmcmVlX3JjdV9idWxrX2RhdGEgKmJub2RlKQ0KPiAg
ew0KPiArICAgICAgIGlmIChhdG9taWNfcmVhZCgma3JjcC0+YmFja29mZl9wYWdlX2NhY2hlX2Zp
bGwpKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPg0KPlRoaXMgaXMgYnJva2Vu
LCB1bmZvcnR1bmF0ZWx5LiBJZiBhIGxvdyBtZW1vcnkgY29uZGl0aW9uIHdlIGZpbGwNCj5maWxs
IGEgY2FjaGUgd2l0aCBhdCBsZWFzdCBvbmUgcGFnZSBhbnl3YXkgYmVjYXVzZSBvZiB3ZSBkbyBu
b3Qgd2FudA0KPnRvIGhpdCBhIHNsb3cgcGF0aC4NCg0KVGhhbmtzIHJlbWluZCwgcGxlYXNlIGln
bm9yZSBteSB2NCBwYXRjaCwgICBob3cgYWJvdXQgdGhlIGZvbGxvd2luZz8NCg0KZGlmZiAtLWdp
dCBhL2tlcm5lbC9yY3UvdHJlZS5jIGIva2VybmVsL3JjdS90cmVlLmMNCmluZGV4IDQxZGFhZTMy
MzliNS4uZTJlODQxMmU2ODdmIDEwMDY0NA0KLS0tIGEva2VybmVsL3JjdS90cmVlLmMNCisrKyBi
L2tlcm5lbC9yY3UvdHJlZS5jDQpAQCAtMzIzOCw2ICszMjM4LDkgQEAgc3RhdGljIHZvaWQgZmls
bF9wYWdlX2NhY2hlX2Z1bmMoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgZnJlZV9wYWdlKCh1bnNpZ25lZCBsb25nKSBibm9kZSk7DQogICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgICAgICAgICB9DQorDQorICAgICAgICAgICAg
ICAgaWYgKGF0b21pY19yZWFkKCZrcmNwLT5iYWNrb2ZmX3BhZ2VfY2FjaGVfZmlsbCkpDQorICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgfQ0KDQogICAgICAgIGF0b21pY19z
ZXQoJmtyY3AtPndvcmtfaW5fcHJvZ3Jlc3MsIDApOw0KDQoNCg0KPg0KPiAgICAgICAgIC8vIENo
ZWNrIHRoZSBsaW1pdC4NCj4gICAgICAgICBpZiAoa3JjcC0+bnJfYmt2X29ianMgPj0gcmN1X21p
bl9jYWNoZWRfb2JqcykNCj4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gQEAgLTMy
MjMsNyArMzIyNSw3IEBAIHN0YXRpYyB2b2lkIGZpbGxfcGFnZV9jYWNoZV9mdW5jKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yaykNCj4gICAgICAgICBucl9wYWdlcyA9IGF0b21pY19yZWFkKCZrcmNw
LT5iYWNrb2ZmX3BhZ2VfY2FjaGVfZmlsbCkgPw0KPiAgICAgICAgICAgICAgICAgMSA6IHJjdV9t
aW5fY2FjaGVkX29ianM7DQo+IA0KPiAtICAgICAgIGZvciAoaSA9IDA7IGkgPCBucl9wYWdlczsg
aSsrKSB7DQo+ICsgICAgICAgZm9yIChpID0ga3JjcC0+bnJfYmt2X29ianM7IGkgPCBucl9wYWdl
czsgaSsrKSB7DQo+ICAgICAgICAgICAgICAgICBibm9kZSA9IChzdHJ1Y3Qga3ZmcmVlX3JjdV9i
dWxrX2RhdGEgKikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgX19nZXRfZnJlZV9wYWdlKEdG
UF9LRVJORUwgfCBfX0dGUF9OT1JFVFJZIHwgX19HRlBfTk9NRU1BTExPQyB8IF9fR0ZQX05PV0FS
Tik7DQo+IA0KPiANCj5JTUhPLCBpdCBzaG91bGQgYmUgc2VuZCBhcyBhIHNlcGFyYXRlIHBhdGNo
IGV4cGxhaW5pbmcgd2h5IGl0DQo+aXQgaXMgbmVlZGVkLg0KDQpBZ3JlZS4NCg0KVGhhbmtzDQpa
cWlhbmcNCg0KPg0KPi0tDQo+VWxhZHppc2xhdSBSZXpraQ0K
