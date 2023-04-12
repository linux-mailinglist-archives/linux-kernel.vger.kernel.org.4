Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42A86DED43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDLILg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDLILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:11:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ABA6583
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681287091; x=1712823091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SNm/PUQ5KHY7yagCwRBEDYaxLszPchDH4qVQ6SNodi4=;
  b=TlagVRCNmSBppxRJStdDh9QVvrxA/NqEHWzk05YHBq3NCad0HZ5lgU+H
   qj0WMycFHARTRLHOfwW0CEaeUdciscbrnqCuWsohmgCR1GK5flE3B5f92
   sFBtbjp7oM6BZSD/8c8/cqScOp1iJxNtD2ASDcMSdwIpDadecBYF+LIe5
   pbzAdldQFS7b0aLe7oCq/PwDoCrldYGxUIXpNwwOszwnrhSxea5beV+M+
   zpocJuI7JpmSpYH2e9qlYjfuWHTQPVZXMiuQOMqGm4WtCKSqJYyOpeU8W
   /sNy/nx4UfwfPrfZcn74T0F1ArxEb3WLXcIIfQOYjQpjlOPJBnEjqLnPs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="327943822"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="327943822"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 01:11:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="800216613"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="800216613"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 12 Apr 2023 01:11:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 01:11:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 01:11:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 01:11:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFvj0QgddyioR7NeGJE4oikYozuZJ9SBen3g0gQYrNsSh1TIBYDmKcSBC6G6Ky0WofnbBe4/SUtPfLiumpY+D/Q5JmQR9z85oPnFhXk3g9RoXfIVVVCKPSBzqEfKumlZIO2CC6Fr9LIcDeEdVuyTgcspKpC4eqa8ve5a9zP//H2qhBTuVxIl4JR/8ORuZWLt3T14ICk0rIzgapfCh75IfH5LtgHbvkqkF0/srIh0B9yPxi+rSNWwVhLfQgUD9ynQ0Nx7UU2g3lbDrGo0k+amj54V3IuPklEcYS5wQkancTbIgqy5qFNSREin3H+IJVm1xcTZesJLohRhfuDmtDhm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNm/PUQ5KHY7yagCwRBEDYaxLszPchDH4qVQ6SNodi4=;
 b=mW/5/fBXd1qobsiQPIuAc4tQuc+TT2uVhuQJGbpe9GLETetS1Foy+jGAV/y4qfKsFPGqCx6CL62nRll0Oi/iEIU2svaUQlf0HrxduPJfMGFjqomiB0vKzSJN+Hq7KGJtlbkDEwNnLAmXecrtjbWJ/z1e9W+DzM/DIyVZP283xF7um436HE5K9dIrSqQYpaaVGEUHCyPSiObsKuL4nDSR6H3jALhxtVtSKl3cQ7nf6TnmtVIiNihANmPSgE7l3ItXBrtvo5Pl7h9LdGwlGnnbDAkh8tTBbI7KW5eGoADzFT9xUL1WayO9+lBHiXXl0Wr+bYW8oJQfVsdrCj5dvRCXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CY8PR11MB7799.namprd11.prod.outlook.com (2603:10b6:930:78::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 08:11:28 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6e3:782b:3976:5005]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6e3:782b:3976:5005%4]) with mapi id 15.20.6277.034; Wed, 12 Apr 2023
 08:11:28 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Baolu Lu' <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Thread-Topic: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Thread-Index: AQHZbEGojtyGOKmCbkWK3iAeEIvlja8mnwgAgABFjQCAAF7iAIAAD7TA
Date:   Wed, 12 Apr 2023 08:11:28 +0000
Message-ID: <MW5PR11MB5881E600E63CEEE70F1CC44A899B9@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
 <20230411064815.31456-12-baolu.lu@linux.intel.com>
 <ec1536af68e6478a9b10a0d884cc988d@AcuMS.aculab.com>
 <6d9ed10d-12ee-792f-fc34-60a8e432c5d2@linux.intel.com>
 <b6ab9a30960d41c9b42e5880b89277e3@AcuMS.aculab.com>
In-Reply-To: <b6ab9a30960d41c9b42e5880b89277e3@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|CY8PR11MB7799:EE_
x-ms-office365-filtering-correlation-id: 0907bbfc-fc86-4192-2fdc-08db3b2d8445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0HRRgAjOP4BQ0hK1huKisPQ7e7iapyp6WEno1NIHmXr05jTqoqQxSliYJ6bnKWvCrs6E1Z+L1ne+Imh0gMMUABczmpmn+3mVLhjBHI4p4l/Zyt9jPQYYjslsGPcSV66VCCn7zWX0GpKLXT/tPUMCuXzQLyRwBCUT/NJ0k4dom9NcmSERZSRW1m0vnm+EMvoOeTjL2GxbDx0TEdCznjSlyLCLAnzBT5jAjTpk6HF8uJKOzeR54AJyXlPmrTTgZOVjNayfkautWmzTRIeWb9PUb4TlPI6eaIsovItk5M5o+CfqXsuOOlAvjFiFZ4fpgFBWWq00N4iPxTbm4/aRrDiAEmmifZbwNZLmFMTnv7d/87jMuOmfesj3hq7gkmT1O65Unzl1oyrunVoP+yTBoKJCeNHxAIeMOIuekTjTsOmJ1qljRQTQ3+YiSrcHD1fQU1dc2FKQpw/LGHkqr84SwlekMp2xChty5qKCEZHahWmDis9w3SKbWmttpYcs6shxKL/o5SOwfFmYmcWJnsqpnGWjNPu5deEmKQSt0w5ajykvjES/xn4VHe07D9cI6NBOfUWwpyutlVLoXVeWg96UX6RIB9i+rC+yGgyoKxAnPhXDo6gdiQN+drHxmxOEES42Csa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(8936002)(55016003)(52536014)(7696005)(5660300002)(86362001)(4326008)(66556008)(8676002)(53546011)(64756008)(66476007)(66446008)(66946007)(76116006)(478600001)(33656002)(38100700002)(38070700005)(316002)(110136005)(122000001)(82960400001)(54906003)(2906002)(83380400001)(71200400001)(6506007)(9686003)(186003)(41300700001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0lLTUlBY2F5Qi9KcFBpdm1nUkd2WDhETmN4WTBMTHBBRWtHK2ZjVXgrOFNI?=
 =?utf-8?B?alI2RjFwOTJEU3Q5WXAydWFabWplWUhHNHVSTnQzU3FKZzQwMkQ5dDVhWmFT?=
 =?utf-8?B?VTRGMGF6cXFNdmVGUzJuWVNSVGVvdkJxTWxibHN1Rzh2MUREcW9SdGoyZjY3?=
 =?utf-8?B?NkFwNzZkci9xSGl1Z3FmRFcwYUNWS1dTUU84Vk5CaG9mU2gzRGVvK09TeXhY?=
 =?utf-8?B?NnN5czlMaktwRFg2aXIreUNRUk44MlFzZEhsL1J3OXQyNThON1g4ZkJrcER5?=
 =?utf-8?B?UVA3bDE2R1Z6ZUpMZGUrMWtmdzRaV1RTcGJNVWZzVitWT1oyRGRvYndkTDdz?=
 =?utf-8?B?QUdoMDhTVS9LWTNvanhaYmU5K3JaRW53L056bGMzSjZQcFMrTjN5V3MxSWla?=
 =?utf-8?B?SXI4ZHNkZkE3TUxJOWgxREVUUlRIejBDQm1zQVpGRGdoL29WNlQ0V2M3Q0Zu?=
 =?utf-8?B?NGppV2lqcDJPRXpFYWNBUEdkOXdMbWJnV0FTQkU1WFRqYVhSWFpFaHZIRU5s?=
 =?utf-8?B?YkNKcWlxZm40Y1RJWHo1U0JMQUdsakRUSCtqK3Fud2I3YmliNHRwaXdsQ3VR?=
 =?utf-8?B?bXBSZm5zd3dYTkFHa0YxT2lucUxSdVg5U2w1N3JVWG5adXZIcnh3YTgyS0Ri?=
 =?utf-8?B?d0hmK0NJelZJcGwxYmlQWVlrbURIL2ZTTmFKckF0alVpM0p2bmVjdGZmVHJu?=
 =?utf-8?B?d1J3T2RYY1Y0c0ZRVUplZGRwZEVVVklsbFF0d1BsaWZYVzgzNkhKdTFDOWFZ?=
 =?utf-8?B?TmdRUWZDTmpjUVl6blZyU2FxdXROaTloTy9Uc2NSU29KYXo3RzhnYlcwZmZ6?=
 =?utf-8?B?bFEzM3ZSOXJ4NHhSTWsvMnFDSXF4a3VkSDVhcjF3bnAxTWFpamZSL0owQTR4?=
 =?utf-8?B?VmptVUkrRUEzbUFCMldMaDZMMk5ZcE50ais5ZFhLMURhbVFocVpQU01tT1pH?=
 =?utf-8?B?Si90Y3NWMlYvVHp6VzY5czAwbzY1cjA2M1BaeDNXOTVIQWlQcmZxMjlTV0Js?=
 =?utf-8?B?MEVjUTZ5bnlHVy93M0wyQnpWaldiTFluM09lUy9kendxQXBScFc1ZmJxKzdo?=
 =?utf-8?B?TTNoYndPZnBXSFVVK2srVU5IVGFtY1lpdGNaZnl6NUVwQzV2SjN5YkVieCtW?=
 =?utf-8?B?NlhvV0EvZUtxZ0hIOXJ3eWlFZVRnbnJYWFVpeEhZV2JCSXFCelFkTVRXZ09D?=
 =?utf-8?B?QUZSY2FzTG5IUHZlU2VBOXNaMzhGQld0RDZ1bmhzd0RWWFFXSldXem52ckJB?=
 =?utf-8?B?YnJXUENXaXNydHZ4S2dPa3VEMkYwV2VYbHlGZHU2TjFlcFZ0M09XUHJvOFZa?=
 =?utf-8?B?Z29sTGxVOVBpRG5OeUpZSnY1b3RHSUJ6QmJHR0s1OFFJYS9CY2NkWHVsK0VJ?=
 =?utf-8?B?dytMTGxSWFYvcVJOSUR3WlB1Z2ZMVWw2dDFuK2J3TnNCOEVIK1gwaXQ4Vnlj?=
 =?utf-8?B?VjJkNDl2QUxQc0pRQ1lLSU40QjBWNzZPbmd5cy9QaHVsTnl0MzNOdzlhWFBQ?=
 =?utf-8?B?UWtHR01HSStSem1jZ0EwNkVmWjVrdkpHVGp2ZGtFT1VSdGhIT1pRVHBqdkNC?=
 =?utf-8?B?K3JJM1ZLT0NxWWNzb1hIS1kxd0Q1bHN0U2pVc3NxR3RnRnZ1V3FEZm9DV2ZW?=
 =?utf-8?B?NStmaEk3RkQwY2xnYWd5Ykl1OE53QmI5WEhUY1BhYUM4enJRdGFPMFltNk8x?=
 =?utf-8?B?SzFDWlI4Sml6QjFiZWdCbHpjSnRTNG1UOGt5WmNPblo0VC9mK3dIcUNCeWZs?=
 =?utf-8?B?eGdLVXNrVnJxREo0WllLTnlqYzRPUVFMVmkvb1orSVVKTHJGMnVndU0wcmtJ?=
 =?utf-8?B?aWY2WVJOd2I4WEFlMVZ0WHpZZ3ZkVnBXSVV5SW9HNEpLM2ZxSEkxZEhYMm1k?=
 =?utf-8?B?Q0UveHpaYTlaS3NiUHJ5VjE4SkxxLzdYa2tncG5qcmNQTHJwUkh0cDJnVmo1?=
 =?utf-8?B?WlhTNUhpRlFCQmY2ZWhCS2RtaDRYU2UxRnZXeW9lKzlPdE1mb3RhZHBNVjF6?=
 =?utf-8?B?TkpRT2YxWUJUcll6TWhlMW1ERzB1SEd1OUsxNUVpTFA5VnoyR0ZJQ3FIclJE?=
 =?utf-8?B?YmkwQWVDUDlVRXJXeUMvcEZlVnpaaU5hSUdxa3JaMzN6NGo1K05sYnZGUUFZ?=
 =?utf-8?Q?WgKaFMlH6T3Z0NsJ/SxUkOBbg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0907bbfc-fc86-4192-2fdc-08db3b2d8445
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 08:11:28.1147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wO219KCyJLKlC61lUxeIm6Yw0TyqTUpgTGAiF5eqPAIxGLYmxWWCSmQqyI9rcPuvogW3F4ZlDMZCgscSZduGeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7799
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQg
TGFpZ2h0IDxEYXZpZC5MYWlnaHRAQUNVTEFCLkNPTT4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJp
bCAxMiwgMjAyMyAzOjExIFBNDQo+IFRvOiAnQmFvbHUgTHUnIDxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+OyBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4NCj4gQ2M6IFZpbm9kIEtvdWwg
PHZrb3VsQGtlcm5lbC5vcmc+OyBaaGFuZywgVGluYSA8dGluYS56aGFuZ0BpbnRlbC5jb20+OyBK
YWNvYg0KPiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPjsgQ2hyaXN0b3BoZSBK
QUlMTEVUDQo+IDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj47IGlvbW11QGxpc3RzLmxp
bnV4LmRldjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6
IFtQQVRDSCAxMS8xN10gaW9tbXUvdnQtZDogRml4IG9wZXJhbmQgc2l6ZSBpbiBiaXR3aXNlIG9w
ZXJhdGlvbg0KPiANCj4gRnJvbTogQmFvbHUgTHUNCj4gPiBTZW50OiAxMiBBcHJpbCAyMDIzIDAy
OjMyDQo+ID4NCj4gPiBPbiA0LzEyLzIzIDU6MjIgQU0sIERhdmlkIExhaWdodCB3cm90ZToNCj4g
PiA+PiBTZW50OiAxMSBBcHJpbCAyMDIzIDA3OjQ4DQo+ID4gPj4NCj4gPiA+PiBGcm9tOiBUaW5h
IFpoYW5nPHRpbmEuemhhbmdAaW50ZWwuY29tPg0KPiA+ID4+DQo+ID4gPj4gVGhlIHBhdGNoIGZp
eGVzIHRoZSBrbG9jd29yayBpc3N1ZXMgdGhhdCBvcGVyYW5kcyBpbiBhIGJpdHdpc2UNCj4gPiA+
PiBvcGVyYXRpb24gaGF2ZSBkaWZmZXJlbnQgc2l6ZSBhdCBsaW5lIDE2OTIgb2YgZG1hci5jLCBs
aW5lIDE4OTggYW5kDQo+ID4gPj4gbGluZSAxOTA3IG9mIGlvbW11LmMuDQo+ID4gPiBXaHkgaXMg
dGhpcyBhbnkga2luZCBvZiB0aGluZyB0aGF0IG5lZWRzIGZpeGluZz8NCj4gPg0KPiA+IFRoaXMg
ZGVzY3JpcHRpb24gaXMgYSBiaXQgbWlzbGVhZGluZy4gQWN0dWFsbHkgSSBxdWV1ZWQgaXQgYXMg
YQ0KPiA+IGNsZWFudXAgcGF0Y2guDQo+IA0KPiBIb3BlZnVsbHkgd2l0aG91dCAnZml4JyBhbnl3
aGVyZSBpbiB0aGUgZGVzY3JpcHRpb24uDQo+IE90aGVyd2lzZSB0aGUgc2NyaXB0cyB3aWxsIHBp
Y2sgaXQgZm9yIGEgYmFjay1wb3J0Lg0KU3VyZS4NCg0KPiANCj4gPiA+IC0JCXZhbCB8PSAoMSA8
PCAxMSkgfCAxOw0KPiA+ID4gKwkJdmFsIHw9IEJJVF9VTEwoMTEpIHwgQklUX1VMTCgwKTsNCj4g
DQo+IE1vcmUgcHJvYmxlbWF0aWMgaXQgd2hhdCBpcyBiaXQgMTEgYW55d2F5Pw0KVGhlIG1hZ2lj
IG51bWJlciBzaG91bGQgYmUgcmVtb3ZlZCBmcm9tIGhlcmUuDQoNClJlZ2FyZHMsDQotVGluYQ0K
PiANCj4gCURhdmlkDQo+IA0KPiAtDQo+IFJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzENCj4gMVBULCBVSyBSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K
