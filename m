Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAEA6A531D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 07:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjB1GkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 01:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjB1GkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:40:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B2222000;
        Mon, 27 Feb 2023 22:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677566417; x=1709102417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=boTCgY/POXrq+v/CTz6q3lBDSI/mMylrmmXpQnjib28=;
  b=WTC1n0RAwNGadLWGr42WYeSJnv9782YKuaxAJRDhBn8i05IxGiv3YNkS
   8AYj9MUTDyHsZWOpeVskoTZmuYM4YTB4Xs6JpBLhlyLVA9GZcojJsyQZg
   tX7n9rICdeV56zCDMyXIM23sFP1rkvTP3kHCj60kf+TFrHYsI0ciFUE8V
   uJO3/RQaLR1TbasIekWr7vVq/wYVofABanQp/4wkCAAeTLPStq/60vY3J
   9aXM6psqXVYZNiQA4I82DJfXFk6JhLqCCG95Wf4CWcr2epfc43+FtvAnj
   gdy4rsxPhQT38Y7eFgQT5hGuLCMwH3LPyhpD5kbH+H3OwS1oZbqxZ//7b
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="332786508"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="332786508"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 22:40:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="763056058"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="763056058"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Feb 2023 22:40:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 22:40:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 22:40:13 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 27 Feb 2023 22:40:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wx1rfPJi+f0ucp9yp2XM5/2T5W8txc53GJhv4eHVRai0EKkCQAlqAODv9tCrvduYpjvSy6ItyXltz/IEIf+PVsdMx1up2be7RxZ6Vr8o+qTniT9Yw7oYoU3lVOgevzhFIJS4AlN3v7GuoPawb1aNRpRD1nauAJJxHhsmFmTQZ5t9OS0Xum4mEKQH+gKUmSy8ai9mgVi5yFWE4heHzSqutbVhfVz5cxpf4Ff1C8RLLoLsMmBAYPMtWSILcfTrevIF1n19VZctWEKevUWjK1XcCBA8OmvuTC4NX8aR5w4NJ5leqDjSt6oPYkFJzD2SrKZGFpmqu4z3VK9lM0oXgSnmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boTCgY/POXrq+v/CTz6q3lBDSI/mMylrmmXpQnjib28=;
 b=C3AC6zQORNPgAj1F5nqlhaUr2xjiXrU6+w4AiV466BXC2GNkcgUEUJJG9jUg0smP2mJlk7trKSXW0gBi0mLguM0tr43XExHPGaQ+4LKeVHMRNT2jbdyuk/EqpMTSo1n4UITawqO84cd0uuOEaiP9MqhBe0UveKWM/QMjDdv8MSnvIK1C0tZ3wTvhGvriY9ZnBLfrLBYwKrsojgOwv2A5xNOAIGrY1HFHGejfw+y2qsUIq4tm655Ln3PiBipxSL5CxRTHg17TDgeSJ2U0a1CIMgk9wy3NqJu4Mzgkg9crAA2zof4LQMIvGoQaL2jxJdLM6lxkr2MHQLjYTaNqsWwEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Tue, 28 Feb
 2023 06:40:11 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56%8]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 06:40:10 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Thread-Topic: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Thread-Index: AQHZSMoUan4Z/tmfYUGikm7Xfdsdaq7iacDQgABhpQCAASAOAA==
Date:   Tue, 28 Feb 2023 06:40:10 +0000
Message-ID: <IA1PR11MB617118DAE8D72E2419558D6689AC9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <IA1PR11MB617175CA398D425B7489CE4889AF9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <764CA486-6FB2-4667-B8CB-56E3AC31FD58@joelfernandes.org>
In-Reply-To: <764CA486-6FB2-4667-B8CB-56E3AC31FD58@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH8PR11MB6803:EE_
x-ms-office365-filtering-correlation-id: cf92f92a-4e95-440f-6ac2-08db1956a3c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IDQ3RvJIvu54ZZHqb+WBGWST2bXvz8BFfnb/fMWdND7jdLZvyxJ1VmDgRP/yZd3z1ZfspfghRT75aobCsfcXhJdRoXntw7i1fBEH10BMUfaPLUoCwmQsd09ze8SsacL2e9fqCmmutBP8GYI32lbjfiY3VhNSMqj5/IyASqpRort0ZF7xK84g1yNj3Be+JVjhtilAuAE86bSb7CIfXggbIu9yqwrMCekpKe7juR51xRm3TjBwU2Si57ksEvBFe44a4KwYo2eF7DpsjseJwDVUiRaERiUodHQ5HOm/8+xhAJ5mHgfJroWfMy1u8l5g7vKIdsJTRh0mYZcn+A/EI+nlKt9z3XxhhTLK7rbts9stZ1ft1TxNWCtVRU2Q07gh73mQWMHwvEIIMK45204TNQYT8gog+7GZD2xntYg5g9kDggUqg6FCRQsNM2J3W5ANEP/tjzuI1/ozhayh4RUWbtWNXV3njja6iqvuxDsMz65No3IqMQOSEnYvOTjoXvz61tYcD21iwVRlPtGelFrten3Dh04VKrYb8cWIZbmiBrADbGGsEGi/9Hcy/LwCjHAER8Plf/NO8232Mmz99DnTUTaWCv9+UfyaUYaFoLvnxtkSFb55omu2c1tc0579DVhFugJT9gJWid3Gm7rFeew1mbToaNWlTF2RtmuiUemFzs4B0BU6Vcr5h0+Q1dPK/lyRfgyuknBqN4qD8837H7+JWwBBLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199018)(71200400001)(26005)(7696005)(6506007)(6916009)(66556008)(66446008)(316002)(8676002)(4326008)(64756008)(41300700001)(52536014)(66476007)(66946007)(478600001)(2906002)(8936002)(5660300002)(86362001)(76116006)(82960400001)(55016003)(122000001)(54906003)(38100700002)(38070700005)(53546011)(186003)(83380400001)(66899018)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VExYNDVQMzlzSmNHSFF1M2pydXBaMDkwNTRoSFBJSzhZek5nb3FWTU11YzI0?=
 =?utf-8?B?azlNYUoxMWdOLytCUGkrK0xqNVB0SUkzWFZzV2Z4eitTTzNBTklUQkhGQkFE?=
 =?utf-8?B?WUovQTczWjN1blQ5Z0J1Y0hndDVzRVJIZnVOa3NHVjRvZzBqRGMwaE5sdWlR?=
 =?utf-8?B?RTBqc09FR1F6d0EvQ21DQnROTytyQml3UzJrcGF0L3BSM1c2NStuajQ3MkZj?=
 =?utf-8?B?MkJKNzl2UFZiSW5RMU9sdDZXdTJQbHkxMllBTno0dG9SeXpYQUR4d1ZHeTZp?=
 =?utf-8?B?K2ZmVDJLc3JNME0zVVQ2aFhTb2xRVFlFSDF1YWp2eHpFZ0FkTHREUGJIUTB2?=
 =?utf-8?B?cEFKQW9WZ3VXang5dVpheUd0NEVUTTdBNGVhbVJzdHpzN21xbFNaVFBCWUY3?=
 =?utf-8?B?ZEUyaXpQdUxsdHJVdmRxdlNwdm1HSGFmcGV1K0pweHpVVGFIQVlrZ2tZeFp4?=
 =?utf-8?B?TEVBVU5JUUFKdVZPTkxaU3o3cXlCLzRsd3c1b0U1aXBXU0E5VWlQQmV6WWxa?=
 =?utf-8?B?QkNmUGhaY0c1VVFSTTJCU01hSDd0eE9xOVRSTGlzTjBHLzl0OXBDQjlSaGpC?=
 =?utf-8?B?YlJVUTd2MVYxZEMzL2ZES042aU1RVzFhbU83ajdaVnBpQUhnOTRXdFI1WkJp?=
 =?utf-8?B?QUVqSnNZTkQ3cStxUXY4eWhIc0V0SERKYnJYbjhLeGxEVklLSHRDbW44QUVl?=
 =?utf-8?B?ekFrTmVnYm9oQ0dBV3M0REZvOER2UnlkYWs3U2F4U1FzSDAyMDBHUkNkWXJ2?=
 =?utf-8?B?WXVmWUx3VSs0YklKMU1FWFo3YzdPdC8yM1VEc1pGNEhpMjI3WEZ2RWxBZ0dI?=
 =?utf-8?B?bjc3amd6VXdxTVExRWlldGxmUkVuUWlHcm16NlVCeGVpZ1hVQ09vcEhSMURv?=
 =?utf-8?B?UXFrRmZQempNVjlSc2hxUHJVVE4yNXRYWlU5azFqQW8zMjZIVHpaS0cxMWds?=
 =?utf-8?B?RnhyM2thZmUwMnZwSU5yME5CYnI5NkszUDBwNDhaWXRhd3RwOWJ2c3BhaHBJ?=
 =?utf-8?B?SXkvUGw2QzRxL204c05vR0ROQ3pONWRvL051ZzMrclFpMldRWDVYeUJGNk9M?=
 =?utf-8?B?TDYzbnorVnZEa01jOVIxTm5xUUZmd1AvTXZZbCtlM25lWEhWZ24wR3krVUpS?=
 =?utf-8?B?UzFscG9telF3WnIyd1pudUVNTTNNNDYrSHhST2Evc0tKK1N5U0NPZ08rQmFJ?=
 =?utf-8?B?Vy82VHhMaGFscjYya2xGT2c5Sm1ReGU2RlVUdHgyT25kUnFCbmxhbUhjcWtN?=
 =?utf-8?B?dzc0cTJ4UWJkUG1nNVNJaWtzTTJyRUdFTXVmckRqdkRVOVAzbXdpN2pBS1A4?=
 =?utf-8?B?NlBCUFVGZGFObVdtM2RzaFdobE04cFhXaW9WVFhzR24wZ1ZuLzVGY3NqQ3ls?=
 =?utf-8?B?SmZwTHBDSVFSWitJWjVFN1poSjd6aHZCR1I5RnZ6b3MycnFxTlN3Y1N2N3lr?=
 =?utf-8?B?bzJ3YUtRc2U0Z3Nlc1VtdlV5cFNOZmRNaGNhd3JDbjQvblVlbHlKUWxtZ2pw?=
 =?utf-8?B?ZTBreXVmQXlPSERqY2xNTUEwN1ZnampUZkZlY0NqalVoMFJ4cmlJT05lbWFS?=
 =?utf-8?B?SDByUUxraW9yY2pUWHZzTk0zY1Y4QWVEZm5rdWhMQ3RCMmVBK3c3NEdkelMw?=
 =?utf-8?B?YnZLN0hWMUtiVFFSQzJOQmlDZzFEK29JT1Rvb0MxdVBuZ3lIb09KMjMvem4v?=
 =?utf-8?B?Mm9lQnUyZU1zR3dCU3cyT0J5Yzc3WktRSGh2NUtLVG1jYVQ5QVhMZVphSVVu?=
 =?utf-8?B?cXNtS01sT3NxNGMyK0t6NTVKeld3ZUZhcDRmV29FQmtUT3ZjZFhvR3Y3R3JJ?=
 =?utf-8?B?Q0MvS3FXVXRoWk5QNEJuVnNCL0MydlN3d3dqTUdCS3FpalQ2N2VEbnVIM3Ni?=
 =?utf-8?B?SDE5VVVHc243c2xjTmI3TlpEUmxxby9mMUx6alJvYzBhYXZtbWNOOFcvT0dC?=
 =?utf-8?B?VU01Nk82ay95N3NNanlkMlNEWjdqWlBOcW53bkoza1VYb1l2dTh2Nlg0ZnhG?=
 =?utf-8?B?VmNrM2VpWTlVcXhvODJBZzBHZk4zMWJiaUx3R1R6bXQyTDhQNnVxOU9hYzZn?=
 =?utf-8?B?MGtyR3lWV3FRdlQvRk9uN09Wb0ZlQzVZNkkrc1l3VkMvZVdyendSKzFDRTJn?=
 =?utf-8?Q?MRhykVUxj5fYZOrvle0OQiy2Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf92f92a-4e95-440f-6ac2-08db1956a3c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 06:40:10.8160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DY9kOMTbg/hAUcs1B/MRxaVXnfWfEtAQZdmOqGV1Xw+ll2DsN6RwitgpM84flO/+O7Xrq49SRPhiTVegWmb+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6803
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4NCj4gU2VudDog
TW9uZGF5LCBGZWJydWFyeSAyNywgMjAyMyA5OjIyIFBNDQo+IFRvOiBaaHVvLCBRaXV4dSA8cWl1
eHUuemh1b0BpbnRlbC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBG
cmVkZXJpYyBXZWlzYmVja2VyIDxmcmVkZXJpY0BrZXJuZWwub3JnPjsNCj4gTGFpIEppYW5nc2hh
biA8amlhbmdzaGFubGFpQGdtYWlsLmNvbT47IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IFBh
dWwgRS4NCj4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz47IHJjdUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRkMgdjJdIHJjdTogQWRkIGEgbWluaW11bSB0aW1l
IGZvciBtYXJraW5nIGJvb3QgYXMNCj4gY29tcGxldGVkDQo+IA0KPiANCj4gDQo+ID4gT24gRmVi
IDI3LCAyMDIzLCBhdCAyOjUzIEFNLCBaaHVvLCBRaXV4dSA8cWl1eHUuemh1b0BpbnRlbC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gDQo+ID4+DQo+ID4+IEZyb206IEpvZWwgRmVybmFuZGVzIChHb29n
bGUpIDxqb2VsQGpvZWxmZXJuYW5kZXMub3JnPg0KPiA+PiBTZW50OiBTYXR1cmRheSwgRmVicnVh
cnkgMjUsIDIwMjMgMTE6MzQgQU0NCj4gPj4gVG86IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gPj4gQ2M6IEpvZWwgRmVybmFuZGVzIChHb29nbGUpIDxqb2VsQGpvZWxmZXJuYW5kZXMu
b3JnPjsgRnJlZGVyaWMNCj4gPj4gV2Vpc2JlY2tlciA8ZnJlZGVyaWNAa2VybmVsLm9yZz47IExh
aSBKaWFuZ3NoYW4NCj4gPj4gPGppYW5nc2hhbmxhaUBnbWFpbC5jb20+OyBsaW51eC0gZG9jQHZn
ZXIua2VybmVsLm9yZzsgUGF1bCBFLg0KPiA+PiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3Jn
PjsgcmN1QHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggUkZDIHYyXSByY3U6
IEFkZCBhIG1pbmltdW0gdGltZSBmb3IgbWFya2luZyBib290IGFzDQo+ID4+IGNvbXBsZXRlZA0K
PiA+Pg0KPiA+PiBPbiBtYW55IHN5c3RlbXMsIGEgZ3JlYXQgZGVhbCBvZiBib290IGhhcHBlbnMg
YWZ0ZXIgdGhlIGtlcm5lbCB0aGlua3MNCj4gPj4gdGhlIGJvb3QgaGFzIGNvbXBsZXRlZC4gSXQg
aXMgZGlmZmljdWx0IHRvIGRldGVybWluZSBpZiB0aGUgc3lzdGVtDQo+ID4+IGhhcyByZWFsbHkg
Ym9vdGVkIGZyb20gdGhlIGtlcm5lbCBzaWRlLiBTb21lIGZlYXR1cmVzIGxpa2UgbGF6eS1SQ1UN
Cj4gPj4gY2FuIHJpc2sgc2xvd2luZyBkb3duIGJvb3QgdGltZSBpZiwgc2F5LCBhIGNhbGxiYWNr
IGhhcyBiZWVuIGFkZGVkDQo+ID4+IHRoYXQgdGhlIGJvb3Qgc3luY2hyb25vdXNseSBkZXBlbmRz
IG9uLg0KPiA+Pg0KPiA+PiBGdXJ0aGVyLCBpdCBpcyBiZXR0ZXIgdG8gYm9vdCBzeXN0ZW1zIHdo
aWNoIHBhc3MNCj4gPj4gJ3JjdV9ub3JtYWxfYWZ0ZXJfYm9vdCcgdG8gc3RheSBleHBlZGl0ZWQg
Zm9yIGFzIGxvbmcgYXMgdGhlIHN5c3RlbSBpcyBzdGlsbA0KPiBib290aW5nLg0KPiA+Pg0KPiA+
PiBGb3IgdGhlc2UgcmVhc29ucywgdGhpcyBjb21taXQgYWRkcyBhIGNvbmZpZyBvcHRpb24NCj4g
Pj4gJ0NPTkZJR19SQ1VfQk9PVF9FTkRfREVMQVknIGFuZCBhIGJvb3QgcGFyYW1ldGVyDQo+ID4+
IHJjdXBkYXRlLmJvb3RfZW5kX2RlbGF5Lg0KPiA+Pg0KPiA+PiBCeSBkZWZhdWx0LCB0aGlzIHZh
bHVlIGlzIDIwcy4gQSBzeXN0ZW0gZGVzaWduZXIgY2FuIGNob29zZSB0bw0KPiA+PiBzcGVjaWZ5
IGEgdmFsdWUgaGVyZSB0byBrZWVwIFJDVSBmcm9tIG1hcmtpbmcgYm9vdCBjb21wbGV0aW9uLiAg
VGhlDQo+ID4+IGJvb3Qgc2VxdWVuY2Ugd2lsbCBub3QgYmUgbWFya2VkIGVuZGVkIHVudGlsIGF0
IGxlYXN0IGJvb3RfZW5kX2RlbGF5DQo+IG1pbGxpc2Vjb25kcyBoYXZlIHBhc3NlZC4NCj4gPg0K
PiA+IEhpIEpvZWwsDQo+ID4NCj4gPiBKdXN0IHNvbWUgdGhvdWdodHMgb24gdGhlIGRlZmF1bHQg
dmFsdWUgb2YgMjBzLCBjb3JyZWN0IG1lIGlmIEknbSB3cm9uZyA6LSkuDQo+ID4NCj4gPiBEb2Vz
IHRoZSBPUyB3aXRoIENPTkZJR19QUkVFTVBUX1JUPXkga2VybmVsIGNvbmNlcm4gbW9yZSBhYm91
dCB0aGUNCj4gPiByZWFsLXRpbWUgbGF0ZW5jeSB0aGFuIHRoZSBvdmVyYWxsIE9TIGJvb3QgdGlt
ZT8NCj4gDQo+IEJ1dCBldmVyeSBzeXN0ZW0gaGFzIHRvIGJvb3QsIGV2ZW4gYW4gUlQgc3lzdGVt
Lg0KDQogICBZZXMsIHRoaXMgaXMgdHJ1ZS4NCg0KPiA+DQo+ID4gSWYgc28sIHdlIG1pZ2h0IG1h
a2UgcmN1cGRhdGUuYm9vdF9lbmRfZGVsYXkgPSAwIGFzIHRoZSBkZWZhdWx0IHZhbHVlDQo+ID4g
KE5PVCB0aGUgZGVmYXVsdCAyMHMpIGZvciBDT05GSUdfUFJFRU1QVF9SVD15IGtlcm5lbHM/DQo+
IA0KPiBDb3VsZCB5b3UgbWVhc3VyZSBob3cgbXVjaCB0aW1lIHlvdXIgUlQgc3lzdGVtIHRha2Vz
IHRvIGJvb3QgYmVmb3JlIHRoZQ0KPiBhcHBsaWNhdGlvbiBydW5zPw0KDQpJIGRvbid0IGhhdmUg
YSByZWFsLXRpbWUgT1MgZW52aXJvbm1lbnQgdG8gbWVhc3VyZSB0aGUgT1MgYm9vdCB0aW1lLiAN
CkkgdHJpZWQgdG8gbWVhc3VyZSB0aGUgT1MgYm9vdCB0aW1lIG9mIG15ICJDZW50T1MgU3RyZWFt
IDgiIHcvbyBhbmQNCncvIEpvZWzigJlzIHBhdGNoLiANCg0KTXkgdGVzdGluZyBzaG93ZWQgdGhl
IHBvc2l0aXZlIHJlc3VsdCB0aGF0IHRoZSBPUyBib290IHRpbWUgd2FzIA0KcmVkdWNlZCBieSB+
NC42JSBvbiBteSBzaWRlIGFmdGVyIGFwcGx5aW5nIEpvZWzigJlzIHBhdGNoLg0KDQpGb3IgdGVz
dGluZyBkZXRhaWxzLCBwbGVhc2Ugc2VlIHRoZSBiZWxvdzoNCg0KMSkgVGVzdGluZyBlbnZpcm9u
bWVudDoNCiAgICBPUyAgICAgICAgICAgIDogQ2VudE9TIFN0cmVhbSA4IChub24tUlQgT1MpDQog
ICAgS2VybmVsICAgICA6IHY2LjINCiAgICBNYWNoaW5lIDogSW50ZWwgQ2FzY2FkZSBMYWtlIHNl
cnZlciAoMiBzb2NrZXRzLCBlYWNoIHdpdGggNDQgbG9naWNhbCB0aHJlYWRzKQ0KICAgIFFlbXUg
IGFyZ3MgIDogLWNwdSBob3N0IC1lbmFibGUta3ZtLCAtc21wIDg4LHRocmVhZHM9Mixzb2NrZXRz
PTIsIOKApiANCg0KMikgTXkgT1MgYm9vdCB0aW1lIGRlZmluaXRpb246IA0KICAgIFRoZSB0aW1l
IGZyb20gdGhlIHN0YXJ0IG9mIHRoZSBrZXJuZWwgYm9vdCB0byB0aGUgc2hlbGwgY29tbWFuZCBs
aW5lIA0KICAgIHByb21wdCBpcyBzaG93biBmcm9tIHRoZSBjb25zb2xlLiBbIERpZmZlcmVudCBw
ZW9wbGUgbWF5IGhhdmUNCiAgICBkaWZmZXJlbnQgT1MgYm9vdCB0aW1lIGRlZmluaXRpb25zLiBd
DQogIA0KMykgTXkgbWVhc3VyZW1lbnQgbWV0aG9kICh2ZXJ5IHJvdWdoIG1ldGhvZCk6IA0KICAg
IEEgdGltZXIgaW4gdGhlIGtlcm5lbCBwZXJpb2RpY2FsbHkgcHJpbnRzIHRoZSBib290IHRpbWUg
ZXZlcnkgMTAwbXMuIA0KICAgIEFzIHNvb24gYXMgdGhlIHNoZWxsIGNvbW1hbmQgbGluZSBwcm9t
cHQgaXMgc2hvd24gZnJvbSB0aGUgY29uc29sZSwNCiAgICB3ZSByZWNvcmQgdGhlIGJvb3QgdGlt
ZSBwcmludGVkIGJ5IHRoZSB0aW1lciwgdGhlbiB0aGUgcHJpbnRlZCBib290IA0KICAgIHRpbWUg
aXMgdGhlIE9TIGJvb3QgdGltZS4gDQogICANCiAgICBUaGUgY29uc29sZSBsb2cgKG1peGVkIHVz
ZXJzcGFjZSBhbmQga2VybmVsIGxvZ3MpIGxvb2tlZCBsaWtlIHRoaXM6DQoNCiAgICAgICAgICAg
WyAgT0sgIF0gU3RhcnRlZCBQZXJtaXQgVXNlciBTZXNzaW9ucy4NCiAgICAgICAgICAgICAgICAg
ICAgICAgIFN0YXJ0aW5nIFRlcm1pbmF0ZSBQbHltb3V0aCBCb290IFNjcmVlbi4uLg0KICAgICAg
ICAgICAgICAgICAgICAgICAgU3RhcnRpbmcgSG9sZCB1bnRpbCBib290IHByb2Nlc3MgZmluaXNo
ZXMgdXAuLi4NCiAgICAgICAgICAgWyAgT0sgIF0gU3RhcnRlZCBDb21tYW5kIFNjaGVkdWxlci4N
CiAgICAgICAgICAgWyAgICA2LjgyNDQ2Nl0gaW5wdXQ6IEltRXhQUy8yIEdlbmVyaWMgRXhwbG9y
ZXIgLi4uDQogICAgICAgICAgIFsgICAgNi44ODQ2ODVdIEJvb3QgbXMgNjg2Mw0KCQkuLi4NCiAg
ICAgICAgICAgWyAgICA3LjE3MDkyMF0gU3BlY3RyZSBWMiA6IFdBUk5JTkc6IFVucHJpdmlsZWdl
ZCBlQlBGIC4uLg0KICAgICAgICAgICBbICAgIDcuMTczMTQwXSBTcGVjdHJlIFYyIDogV0FSTklO
RzogVW5wcml2aWxlZ2VkIGVCUEYgLi4uDQogICAgICAgICAgIFsgICAgNy4xOTY3NDFdIEJvb3Qg
bXMgNzE3NQ0KCQkuLi4NCiAgICAgICAgICAgWyAgICA4LjIzNjc1N10gQm9vdCBtcyA4MjE1DQoN
CiAgICAgICAgICAgQ2VudE9TIFN0cmVhbSA4DQogICAgICAgICAgIEtlcm5lbCA2LjIuMC1yY3Ur
IG9uIGFuIHg4Nl82NA0KDQogICAgICAgICAgIGxvZ2luOiBbICAgIDguMzQwNzUxXSBCb290IG1z
IDgzMTkNCiAgICAgICAgICAgWyAgICA4LjQ0NDc1Nl0gQm9vdCBtcyA4NDIzDQoJCS4uLg0KDQog
ICAgIFRoZW4gdGhlIGxvZyAibG9naW46IFsgICAgOC4zNDA3NTFdIEJvb3QgbXMgODMxOSIgcm91
Z2hseSBzaG93ZWQgdGhlIE9TIGJvb3QgdGltZSB3YXMgfjguM3MuDQoNCjQpIE1lYXN1cmVkIE9T
IGJvb3QgdGltZSAoaW4gc2Vjb25kcykNCiAgIGEpIE1lYXN1cmVkIDEwIHRpbWVzIHcvbyBKb2Vs
J3MgcGF0Y2g6DQogICAgICAgIDguN3MsIDguNHMsIDguNnMsIDguMnMsIDkuMHMsIDguN3MsIDgu
OHMsIDkuM3MsIDguOHMsIDguM3MNCiAgICAgICAgVGhlIGF2ZXJhZ2UgT1MgYm9vdCB0aW1lIHdh
czogfjguN3MNCiAgIA0KICAgYikgTWVhc3VyZSAxMCB0aW1lcyB3LyBKb2VsJ3MgcGF0Y2g6IA0K
ICAgICAgICA4LjVzLCA4LjJzLCA3LjZzLCA4LjJzLCA4LjdzLCA4LjJzLCA3LjhzLCA4LjJzLCA5
LjNzLCA4LjRzDQogICAgICAgIFRoZSBhdmVyYWdlIE9TIGJvb3QgdGltZSB3YXM6IH44LjNzLg0K
CQkgDQpUaGUgT1MgYm9vdCB0aW1lIHdhcyByZWR1Y2VkIGJ5IDogOC43IOKAkyA4LjMgPSAwLjQg
c2Vjb25kDQpUaGUgcmVkdWN0aW9uIHBlcmNlbnRhZ2Ugd2FzICAgICAgIDogMC40LzguNyAqIDEw
MCUgPSA0LjYlDQoNCklmIHRoZSB0ZXN0aW5nIGFib3ZlIG1ha2VzIHNlbnNlIHRvIHlvdSwgcGxl
YXNlIGZlZWwgZnJlZSB0byANCmFkZA0KDQogICAgICBUZXN0ZWQtYnk6IFFpdXh1IFpodW8gPHFp
dXh1LnpodW9AaW50ZWwuY29tPg0KDQpUaGFua3MhDQotUWl1eHUNCg0KPiBJIGNhbiBjaGFuZ2Ug
aXQgdG8gZGVmYXVsdCAwIGVzc2VudGlhbGx5IE5PT1BpbmcgaXQsIGJ1dCBJIHdvdWxkIHJhdGhl
ciBoYXZlIGENCj4gc2FuZXIgZGVmYXVsdCAoMTAgc2Vjb25kcyBldmVuKSwgdGhhbiBoYXZpbmcg
c29tZW9uZSBmb3JnZXQgdG8gdHVuZSB0aGlzIGZvcg0KPiB0aGVpciBzeXN0ZW0uDQo+IA0KPiBU
aGFua3MsDQo+IA0KPiAgLSBKb2VsDQoNCg==
