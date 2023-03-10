Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E076B344E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCJCff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCJCf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:35:26 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FBBEFF47;
        Thu,  9 Mar 2023 18:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678415725; x=1709951725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f3FXrYOVMvxsSAIuzaZCAbXqAgYqcYXoetP4QrJAj40=;
  b=VECDbTSk3I80y7OLa6JF2y2Nw99cKfB5zDvm+MT3c8BoI21x7Jm3z8zJ
   PFs8eakD4SNLYWCoBB1Syf1LwznmbXZvC24X11F47+A3Bq+SmzsIe9GSM
   f0bprpMsy/sdHBDK6/IMcU5eTK4kwpKghYKdrNk4chtH51ELxtSV5upFH
   jGSApjGB6gozPtDVkOq2PuY5ZwrMeBgYhK8XMJ3EM8mGT6FXCXKZsH7fu
   rDK6ssOvOwws0Y2LH8NqEpS2JzVN7KTOo3W9Fxtu21ZfO9+BPLPW13vu6
   QWBj52sLBiosRm8LM5n/4Auh3LivYhghVNfawKUlZoCwOZ7a0tP61oBoo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="422896563"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="422896563"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 18:35:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="746544871"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="746544871"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2023 18:35:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 18:35:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 18:35:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 18:35:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij9s5eHg8Qssctg4SHMxsElM2d1HSZWpF5C+Iasg6KdO5ZTZPsR00O9jlDeYcxVNnjr/rMUqgsmOwPy50NJGaS40/W4EWQ/PVkyYAbrDDbglLPd2owY1ebbnp/0LBR6F+r0sH5QZKLwQTYiM5U5jrbZIFhc7o7e8JbmK7BoWqJyDHirQjnUJ0b9N6WDxMMGe5oF1L1DaySOELLW/ic4HC8c+q2LLZvSeuCzh6dXCs/8RG8nxCz5nM5k4FEyddrx+yCwhgKJ9M4RQ39WdUQBz/+G0s388wJ+aqQ6C4EIkuQvK9praVkWflPINfPtuokERsomWKsQCysZdoya2BLZg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3FXrYOVMvxsSAIuzaZCAbXqAgYqcYXoetP4QrJAj40=;
 b=nAFCPc/TMj7XrPGejvIT3fYhFvnLihyYlQh65yzOu2HBx08wp+umgkSF1QZ9PU/CIhb8oEnc1VFKxFpIB6Da+ktL1AL/AjHzHIkbqT0AssGZ3kkHd7/hjKs4ikjTjF9F4b3NRU9faA/EHSo4pirjiehLO7RwpAaPW0f+EiKysBnYWKwIQlu7ntmWaRNGoUJEJVZslNud+4iwdEc3zYJejBux/pLjCPZdQ/ffrbDCfeAFa/tNmhbUY0mZmyzIyRY+b523YvOIDR2bdjFWS7tinS60D7u7lI7MKpoAPo5hBKSCqk1f1ikNpNNKRhcXscxf+peEK7ekWcRsrHgIgvmPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by MN6PR11MB8170.namprd11.prod.outlook.com (2603:10b6:208:47c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 02:35:22 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 02:35:21 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Akira Yokosawa <akiyks@gmail.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: RE: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Thread-Topic: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Thread-Index: AQHZThiYp3MlrzfqvEWnd0vYLxlOHa7pzeSAgAOQlXCAAHskAIABB5EggACT3wCAAxGoYIAAgFCAgAAmoACAACHtwA==
Date:   Fri, 10 Mar 2023 02:35:21 +0000
Message-ID: <IA1PR11MB61712EF72C4840B0F161775589BA9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <1a4b1362-defb-4464-9217-32e6d3d4a8d2@paulmck-laptop>
 <6e38d7d7-9991-b0a6-2855-0c8838cce142@gmail.com>
In-Reply-To: <6e38d7d7-9991-b0a6-2855-0c8838cce142@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|MN6PR11MB8170:EE_
x-ms-office365-filtering-correlation-id: 5a5cdabf-01e9-4c21-0102-08db2110188e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kul3neZVZTzcnhWaCd0Yu+5gg0Z0WKslGhz39pPEYwuxDA8QCndPuY54Vf+nB2tCNFRsK75PxhqOnhpiwTuYAs2GQ6j5a9xni8gAlZ4V4gJO4t/Ezx7ZlhEo2rPKS/6e5b9D6DNHnLOF6is9EV+DbRBCXyeqFY5vzj05ALntsiTnzvmWp/w6a3qijNgcctMLJLO9+JbDdjCY7y43RU3qyjgvyF039IDyh476xcGskG7dtlqWCvjqSynxHlM51vB2UTxecs4X5yYU5jONo6sQXn2eKZB1Ib01V5CuOekK+5a9QTzkS8JwUu9JhrHqM9lPkq4UktJ9X8VgUY9EMylvdM956bXPgHCbb2y68harnvUl/zoUqVOBaZ75oGr4Dj0VeYXGZydk9gnAp/NYh9uDKvAtK/4hWVb9OflzX3CpIu7m78xQsc1dfzpy/QqCAYEIebFSP1b5ADEkdgXVCJ9CcwaUjKIQNdfz49q/fNXbY2bvvhQOuyNttcG3dSOQgPvAc39DQfnyne0CV/7vzCF0oSQmAip2OIAVh8CcPiXYP3rCP/WJNQUXSy6Havj1jJgffm23AldWpi2H8OCAuWsHbwr9hwhRcS0VSRehFLhqDJjSaGrHOAZtRlp7iLQHJJY5/4E6QiWxNNx6MDQ58i0oeleE8s3Q6JDKghdhEFhXvho7TYJwj0Vw2p2D49Rbh2eK8tB5ZdGWLac9imB8VE2jzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199018)(41300700001)(66946007)(26005)(38100700002)(6506007)(53546011)(83380400001)(9686003)(38070700005)(110136005)(122000001)(82960400001)(186003)(71200400001)(478600001)(54906003)(316002)(66476007)(8676002)(7696005)(66556008)(76116006)(86362001)(4326008)(64756008)(33656002)(2906002)(66446008)(55016003)(5660300002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTJ2Nm1Pa2U1aG1iNFh3cFJWV2ozbkdpNUczSHczOTcwWU1HVDk0NXFZeWhM?=
 =?utf-8?B?TUFMaFQ1N0FyZWpHR2NSTHRpQ2xSdERYTjJZdXpGd1ZWWUhEMDl1Wm5LT0Za?=
 =?utf-8?B?NklhMW4vdmNPUjVQRWJxZDVMWVJVYkR1SU9DL01jQldFNTRiWkFtcXA3NVZX?=
 =?utf-8?B?WjdmdHd2UlZsSkU4aGNyVjNHSFJvc3N5Wm5kdkVqMWVWTFloRERFZjQ0aUJZ?=
 =?utf-8?B?MTlvVHdsSUNHZVZwcEF6bjFTU1VVVGdRQmtjYTBieDRpOEljRExGZjd1SUh3?=
 =?utf-8?B?SExoMXZLS3I1K0JIQXRYSVUyVW5wK1AxaUpYQ2srTGtibVhMV2twOElveEMr?=
 =?utf-8?B?bDJxSkk5YkUxWWt5RkNPUElJaDBqTWIwSmRycGhTTXVHTmdSM3BaZVprMVUz?=
 =?utf-8?B?L0owRnpSQTRBRnNyM3JwUlZMd2ZBNlVSbUNpQzB1d2FMVTlobDhKYzRldzdX?=
 =?utf-8?B?N2NkZ3JxaUQwR01sUkxlVFQ1RENZalkvUEZyU3kyRmlnWi9aVjhydzFER1dJ?=
 =?utf-8?B?WEJyNjlwaWM3Syt0UHhQN2lVWnl0eFFaL1hDOVZqOGFsanUxMVpEeEVQUnV4?=
 =?utf-8?B?NWYyN3I4VEpZMXFvTHkwRjVueHBCaDRqQVcrUGJCcHR6K00xSXA2TEU4NjVh?=
 =?utf-8?B?S3dYWW01eGlyU1FORy9xZzRwTDBERWF4ODBTajlJeGF5aXJtbkMwTGs4cFpo?=
 =?utf-8?B?aE9hKzBnM1I3alNJUDVKSFZEbXNSaUVBeVQ2Zm0rTUkrR0IydUkrR2tra1Mv?=
 =?utf-8?B?S2ZVdXljcW03TnUwQzVjcURaNVBRNWJVYlZrcDNsZHZ5ZXNZNlBkUXJXMFNu?=
 =?utf-8?B?UWw1ck8xT0NmT3VGSXA1cm95Nmc1SGlDRnJuUU5sV0w4OXhveGNBYWVLZCsy?=
 =?utf-8?B?amRBM2Jla1BnVG5TWVpUT242QmVCcUMvWStCczducFZyL0hMU2RpMWtDN2xy?=
 =?utf-8?B?V01NbHRzSWp4SXlUYWZUZEcvV28rdzBFSllFQk5EUmNPTnJhT29VMmFpQXYr?=
 =?utf-8?B?YjlMTGRodVRHcUdpN3kzSEFQWGxiUWNMWDNqZWdkTnE1cWpTb1dFb3VVbXdR?=
 =?utf-8?B?ZGVTT21LMWswQU1uckRLbTY0Y2pUclA5dEFqSzZQV3BGSzNvU0hZRlNBa3d0?=
 =?utf-8?B?aXB3NEwyZHJYOXhCYUlCTy9yTzFzVFUrN0FZZm54K1NaRE8zVVhybDJzNW1Z?=
 =?utf-8?B?b3k4aGlLTDZ2YUZISldWM0JRbVUyLzlLWUZUMC8zQ1pJdnE3d2lWMzhpS1Jr?=
 =?utf-8?B?bUJ4SngwTGpPdElJOFFoOFZUSmh3QUhzcnU3eEs2TW9ZdG9XQWFMcGpXUU8r?=
 =?utf-8?B?NWMzZTNjRFd5c01meTJiTGxibDVXMjZJOXFIRHpITDN0YUdLaitWU1lmclY1?=
 =?utf-8?B?Z0pFa3VMdHcvZ1JiTUFSdjVpcVFNdUoyYUJPU2VVZnRMK1lidzY2SjhFTnVi?=
 =?utf-8?B?SnUxYm9LWm41eDA1WDl2MHFUejR3eWJmNzBsVTBJMzNvTFdsYXN5ZnNuMTBO?=
 =?utf-8?B?T1lXRStSVzhTVXAzUmFpVDllejNzcit4L2FXbTF3cU55TmxCWGp1RncxSnU5?=
 =?utf-8?B?OGpPN2I1NFVSUlF2azBibldNdm90TmsvU3FucDVpZDNKRTBkRUIwRm4rdmNv?=
 =?utf-8?B?elYxRHBjVXk5dURGT2lkaUJyNUhKd25iaGJOOVhMS2U3TjArekdvdE5rSU44?=
 =?utf-8?B?NzRnQXJDUzBlb0laZUxaYmNDN0YyZkRtUjNBMDM2U1lOSGJtQlRqb3pkRU1C?=
 =?utf-8?B?TEtCQnQ3ZUZ5b3pmNld5dlVsUHdyRkpTR0REeHgvcERsOTNQM3JhY3dNbjdF?=
 =?utf-8?B?SDF5WFF6UkkvQ3lxOEFzSDJ0T29VWTJFazRJSEFNN3VJUU1lVk4rTEhsZXZr?=
 =?utf-8?B?UlgvWUpQYnlsRm5pNGRDRzh6YnZCTEZjenA0d2pMdzAxRkVGVnIzSXB4c3d0?=
 =?utf-8?B?WExzckhmVTF0TUNUNkV5bnBDTnZoTXJySERtVUJpMXBYUlQ0S1ZLU1ZpYXZa?=
 =?utf-8?B?R012UGxkZnI1bWFscjdaSEkxd295elZPRHlicjRjWEhORjJtK2IyRmRSZWxX?=
 =?utf-8?B?OUFMN1JOZ3hleTBrWkV1cFpsQnhhQ0tURHI5aGZKZ1ZyN2xGSGxmbTQ4WExM?=
 =?utf-8?Q?K/lW1Z+ufOfk2y3FrDME0CC+p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5cdabf-01e9-4c21-0102-08db2110188e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 02:35:21.7583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cuIxdc0AbEo0V5Ky5Pi3h97x8bvPMXJIRSUFj2Bqx3S/vgF7rhKQ3Hv1qTVC/qLb/77pXjlo5EE2cJCoASaZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8170
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBa2lyYSBZb2tvc2F3YSA8YWtpeWtzQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBNYXJjaCAxMCwgMjAyMyA4OjEyIEFNDQo+IFRvOiBwYXVsbWNrQGtlcm5lbC5vcmc7IFpodW8s
IFFpdXh1IDxxaXV4dS56aHVvQGludGVsLmNvbT4NCj4gQ2M6IGZyZWRlcmljQGtlcm5lbC5vcmc7
IGppYW5nc2hhbmxhaUBnbWFpbC5jb207IGpvZWxAam9lbGZlcm5hbmRlcy5vcmc7DQo+IGxpbnV4
LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHJj
dUB2Z2VyLmtlcm5lbC5vcmc7IHVyZXpraUBnbWFpbC5jb207IEFraXJhIFlva29zYXdhDQo+IDxh
a2l5a3NAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSByY3U6IEFkZCBhIG1p
bmltdW0gdGltZSBmb3IgbWFya2luZyBib290IGFzDQo+IGNvbXBsZXRlZA0KPiANCj4gSGksDQo+
IA0KPiBMZXQgbWUgY2hpbWUgaW4gdGhpcyBpbnRlcmVzdGluZyB0aHJlYWQuDQo+IA0KPiBPbiBU
aHUsIDkgTWFyIDIwMjMgMTM6NTM6MzkgLTA4MDAsIFBhdWwgRS4gTWNLZW5uZXkgd3JvdGU6DQo+
ID4gT24gVGh1LCBNYXIgMDksIDIwMjMgYXQgMDM6MTc6MDlQTSArMDAwMCwgWmh1bywgUWl1eHUg
d3JvdGU6DQo+ID4+ID4gRnJvbTogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3Jn
PiBbLi4uXQ0KPiA+PiA+ID4NCj4gPj4gPiA+IGEncyBzdGFuZGFyZCBkZXZpYXRpb24gaXMgfjAu
NC4NCj4gPj4gPiA+IGIncyBzdGFuZGFyZCBkZXZpYXRpb24gaXMgfjAuNS4NCj4gPj4gPiA+DQo+
ID4+ID4gPiBhJ3MgYXZlcmFnZSA5LjAgaXMgYXQgdGhlIHVwYm91bmQgb2YgdGhlIHN0YW5kYXJk
IGRldmlhdGlvbiBvZiBiJ3MgWzguMCwNCj4gOV0uDQo+ID4+ID4gPiBTbywgdGhlIG1lYXN1cmVt
ZW50cyBzaG91bGQgYmUgc3RhdGlzdGljYWxseSBzaWduaWZpY2FudCB0byBzb21lDQo+IGRlZ3Jl
ZS4NCj4gPj4gPg0KPiA+PiA+IFRoYXQgc2luZ2xlIHN0YW5kYXJkIGRldmlhdGlvbiBtZWFucyB0
aGF0IHlvdSBoYXZlIDY4JSBjb25maWRlbmNlDQo+ID4+ID4gdGhhdCB0aGUgZGlmZmVyZW5jZSBp
cyByZWFsLiAgVGhpcyBpcyBub3QgZmFyIGFib3ZlIHRoZSA1MCUgbGV2YWwgb2YgcmFuZG9tDQo+
IG5vaXNlLg0KPiA+PiA+IDk1JSBpcyB0aGUgbG93ZXN0IGxldmVsIHRoYXQgaXMgbm9ybWFsbHkg
Y29uc2lkZXJlZCB0byBiZQ0KPiA+PiA+IHN0YXRpc3RpY2FsbHkgc2lnbmlmaWNhbnQuDQo+ID4+
DQo+ID4+IDk1JSBtZWFucyB0aGVyZSBpcyBubyBvdmVybGFwIGJldHdlZW4gdHdvIHN0YW5kYXJk
IGRldmlhdGlvbnMgb2YgYQ0KPiA+PiBhbmQgdHdvIHN0YW5kYXJkIGRldmlhdGlvbnMgb2YgYi4N
Cj4gPj4NCj4gPj4gVGhpcyByZWxpZXMgb24gZWl0aGVyIG11Y2ggbGVzcyBub2lzZSBkdXJpbmcg
dGVzdGluZyBvciBhIGJpZyBlbm91Z2gNCj4gPj4gZGlmZmVyZW5jZSBiZXR3ZWVuIGEgYW5kIGIu
DQo+IA0KPiBBcHBlbmRlZCBpcyBhIGhpc3RvZ3JhbSBjb21wYXJpbmcgMiBkYXRhIHNldHMuDQo+
IA0KPiBBcyB5b3Ugc2VlLCB0aGUgb25lIHdpdGggdjIgcGF0Y2ggaXMgZmFyIGZyb20gbm9ybWFs
IGRpc3RyaWJ1dGlvbi4NCj4gSSB0aGluayB0aGVyZSBpcyBhdCBsZWFzdCB0d28gcGVha3MuDQo+
IFRoZSBvbmUgYXQgdGhlIHJpZ2h0IGFyb3VuZCA5Ljcgc2VlbXMgbm90IGFmZmVjdGVkIGJ5IHRo
ZSBwYXRjaC4NCj4gSW4gc3VjaCBhIGNhc2UsIGF2ZXJhZ2UgYW5kIHN0YW5kYXJkIGRldmlhdGlv
biBvZiBhbGwgdGhlIGRhdGEgZG9uJ3QgdGVsbCBtdWNoLg0KPiANCj4gSXQgaXMgaGFyZCB0byBz
YXkgYW55dGhpbmcgZm9yIHN1cmUgd2l0aCBzdWNoIHNtYWxsIHNldCBvZiBzYW1wbGVzLg0KPiBB
bmQgdGhlIHNoYXBlIG9mIHRoZSBwbG90IGlzIGxpa2VseSB0byBiZSBoaWdobHkgZGVwZW5kZW50
IG9uIG1hY2hpbmUgc2V0dXBzLg0KPiANCj4gSG9wZSB0aGlzIGhlbHBzLg0KDQpUaGFuayB5b3Ug
WW9rb3Nhd2EgZm9yIHNoYXJpbmcgdGhlIGhpc3RvZ3JhbSB0byBwcm92aWRlIGFuIA0KaW50dWl0
aXZlIHZpZXcgb2YgdGhlc2UgZGF0YSBwb2ludHMgYW5kIHlvdXIgYW5hbHlzaXMuIDstKQ0KDQot
UWl1eHUNCg==
