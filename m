Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEEE63A324
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiK1Idn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiK1Idm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:33:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40858617E;
        Mon, 28 Nov 2022 00:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669624421; x=1701160421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MOw8G3V/SoVoq2/bqHkzZdwWTB0+FwV++8ksun3ck4w=;
  b=MTp3WrVHqTLoCkorabk0RhIIGQOdRzXwzkhBhQJ0dS0u0rksZwrHDzne
   yYp9We1c+FAcxYBTFYxc78HKam8SR9NQBhV3eh2RAfRPtcy0Ic5MKNimG
   CqIwopmP+gZVPlry63qdBxfJMUGOADaN02gib+BbEFHC6AfXby5iiN3D7
   U+ye7/zAd+frYLyTjpp72lYokOEjlTsqBVdscGFTEpU+ILDaiw9rmW2hE
   cNO4ptQ2Jsj+b9G09kM3hH9XpwmfLhDDY6b0WjXnNQjzJZWG9j5ax28A3
   ZFcvMvjypVVK6wS0vsIOla6648gI4pNbIgccJ1A3Yxo1bMN1+cM2FJqA8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="294479822"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="294479822"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 00:33:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="706697114"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="706697114"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 28 Nov 2022 00:33:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 00:33:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 00:33:37 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 00:33:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvn47E/0TKmfeVafezpvP0VMUdo4UQKoEAaB+/tBCCrcrMnR0jTIXa/CdHmibUibdAMMO4sArAuWx59rwulPbG3w5boEYDFVn/L9Kb5M1e84XDpMBr+Ph3YgpwPZrwpmkWwhP2v8GzeINGaBsnUQ4UvGTzlEYXspKZ1CERWupXD2uK3mO0YcI9z9GYh9iYBZVb2y3iGj/mlKoJ/OomKsyHWcSEuSP/4q/b0M8Qcl4n3SCQB18QGZLK+AwyVxUiVMIAoezs3psvq0S1EP9ryt9Ir02KUnKTR3ZizwBnLXD0UtROS7fj5EsGutbNXZelv9tN63kE4DDk/Ore0KF2gBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOw8G3V/SoVoq2/bqHkzZdwWTB0+FwV++8ksun3ck4w=;
 b=h6JJxRxW60KQv3Kek4cy/AaMS6wSGIHVDHfhcUpLTnlUnNrdFqMW586cdHrdXSojVRX7dYBo0yN3shMLGDHxF71FyvxuTaDGjs6vdGLYe46acsw6XR6Cia6usOQRO9XFNLOYTkJQV7GEkkcUKfqFY42fQinYTeESY33HsyL5HIlFd67DTbYej7ngvks+nKtCPWc+GaAX2zTLDS6XOJmkRWT+TnXw4XKHP0/bnDvonxy45pOZ+0JLrShul+Zgu8oXxSfTKGssY7NzR6LEGtWyAwk2QIlqaen2VIW90mFivfOQ/QwzJ5qa2nXSNkwTnv5gyu4sqlUSFf+Qdcav3lX8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SN7PR11MB7418.namprd11.prod.outlook.com (2603:10b6:806:344::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 08:33:36 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%5]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 08:33:35 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] mm: Make vmalloc_dump_obj() call in clean context
Thread-Topic: [PATCH v3] mm: Make vmalloc_dump_obj() call in clean context
Thread-Index: AQHY+uTOpQ3AnwpdEUCtphQz9Z9WFq5LlqMggAhyVYCAAATS0A==
Date:   Mon, 28 Nov 2022 08:33:35 +0000
Message-ID: <PH0PR11MB58806345B34497A6262AFC82DA139@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221118003441.3980437-1-qiang1.zhang@intel.com>
 <PH0PR11MB58802C9BF5683925DF983A4FDA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <de550275-b8dd-e958-4f34-5ec545ed4f43@huawei.com>
In-Reply-To: <de550275-b8dd-e958-4f34-5ec545ed4f43@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SN7PR11MB7418:EE_
x-ms-office365-filtering-correlation-id: dd1005e7-207a-4e98-ee8a-08dad11b3de4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YIdTojNrcQPv0gB/Lul/j1S0sG7yMfDbd2exbPkr2xphQzJv0DA5vYx+mr/+Fs4zuKpaKhsSuggimuVk3em/LtYo4N9PokKaXCwOAqNebbC363tQ3ssHYuFPH/SrGC3267r/BSWmJeDN1aSd3T8Iy2FaHTrRxa9cW6X6xfr2o7otIswA1Gyw95N17xlxXgAlmQmcv18EkLT63iBJTWnuJsBoeK+SOwX5J+4nbPECPe9mF8XViiB58PAIA9jujCr1npJPHwnTBgotQfn+NNmxQZL1ubaOJuMZqtE4UmGrsg4Dr27ddxz8cut5jKfzvG3hyq0vDJscUTZn8g6GlHL97FFIVpZ8nb8ojrgIbmL2Api+O/CpIdV4v7GP6RDyu2dE07p0zGYXjo09OUqtntc0to5B9iNYhTmXtZhkcQ2+T1rRoA8lOO5RPrj/HG5LbpvShPQf+JK6hkkpKqi+RvSGIX1116HZAD2DpTgj4+55vOrxG+/HNsBDyEg3ZChj7LXi8XVJXGdULeVU0ItIcnBc/Tkyn37HqekrsHOSd2es7FaR6p4QAvTCpwL7MXW19aoUXdziJRau4+nB/w/hgQ+u3RF//du70/UU0/gehWQvQTQ+wTDaM6jYK89+29JeHamwO11LV3u/afghX8u47/o4NoIM9XxZi9UFBWsFCo4whSp+Ite+a1P8yES1WGFGwTfYs8/OzoYoA6CRRq15FxV9iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(186003)(71200400001)(7696005)(6506007)(122000001)(41300700001)(2906002)(82960400001)(53546011)(38100700002)(8936002)(83380400001)(86362001)(55016003)(52536014)(110136005)(33656002)(316002)(38070700005)(54906003)(9686003)(26005)(8676002)(76116006)(64756008)(66446008)(66946007)(66476007)(66556008)(478600001)(5660300002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2xyUjVzbVpIaGV2ZkJGZDR5VEtkQ1lnc1ZiZ0M1djBoN21EUWsvWEltZTAr?=
 =?utf-8?B?VmFxV2NRRHlHSCtZZTcwUFlISmRCT1JTTER1bVhSOFl3N25DSDhLdjVzMU00?=
 =?utf-8?B?QXpJdjQ2RTZaaXJsU1Q2NnAyL3lvREJjL09ERDBzQUk0SGhXbzBHTlBWYy81?=
 =?utf-8?B?bTRZbk9Pck96RC9naW1naUwzYVF1NVFyVDZiL1BiWXhSUjJqYVJTb2poSWVk?=
 =?utf-8?B?OUNCVWk1S2E2Y1FWOGR2RVhETExldTlyNmlCTGlrUEQ5LzlCNDNxMkY0L09M?=
 =?utf-8?B?U3J2TkRtUUg2S09tZmlvTkZXTlFiOE9PeWhSSFUzMjVyK0VQTDYzZFlESjNT?=
 =?utf-8?B?UFFpUGR0QkFYenphdzRJblllR3RQZFpUbUh5ZmNSWUl3aVRZZFI4djR2TFg5?=
 =?utf-8?B?U0p6SlNHd0MzcWRuZFZpMys0c25yQy9mUGtndnZPQlNKS3RTQmM5ZkFIeTd6?=
 =?utf-8?B?c0FvYXd5NEtxK2RvaTVjc2pIdGFmeG4zaUVlcFdJZ1NUS25JQ3pCRmd5R1F3?=
 =?utf-8?B?eFZSUFV2VlA5T2tHSmNubXNGWERkZkVBS2VNdm10c1lhSVBkU25KeXl4b214?=
 =?utf-8?B?aUpYS1B1VEFDRUs0dXRMb1VpY0VCWlk4TzRoNmtDeWlVVmROaXdOOE8wTUhl?=
 =?utf-8?B?RDEvejM2SmwvT0sxWnJHaDlrNFI2aE9HSE5LN2dMclRVQVNwUGFJQ2IwTndk?=
 =?utf-8?B?Slpaa2J0ZzNIUkhPdFpvMUREVCtBR3ZIbGlrUE5DdVF5Z0szaWJNZ3JGNVBM?=
 =?utf-8?B?L3JNQnJ2Q0cvcDU3UndacURXL0FHT0FrY1Q2emYvVzJXSjVzaG5rdHBUaHh4?=
 =?utf-8?B?Qm1MZStoVnRDdC9TYlFXNHdIdEZQZHB3a2NXd285Y2RoeVFoTE8xL2xmVEww?=
 =?utf-8?B?TWxEcTQ5d2FqS2Iza1lhVVFwaWkyT01zbnl2U1kxNEE5OFRWQ0toanQ3NnRW?=
 =?utf-8?B?K3Y5TzhQakZBTkhXQi84TC9ZOXJWSVA4cnpObjdsTW90WGp5N05PTktpazBr?=
 =?utf-8?B?cVRQMC9VYmRqQjJ5aHBLWnYwSU9lT3V0QjZ0QXlRc2lWYjRFek9qcXNrbGFX?=
 =?utf-8?B?bVU3ckh0aUppUFpPWnRzRHRmNHJtVmVkUWhIM2VITmxzSng3cVJWMDI0L0Vq?=
 =?utf-8?B?TEFUaklKM1lWMjBVZmFLZzdHRjlOaWNwOEl0TTRINUpXcmlWalBnbENqQVY0?=
 =?utf-8?B?Y2phK0xmQ2t2OXJHOHEvdzV1TTNkSWVUYkdzU0ZjWjN4c0V0NjA4Z3V5YWM1?=
 =?utf-8?B?Y2xkNmVDWDhzbGVSdlVkbXVpRXBxT1E3b3Q2RzUzZ0d6MlMybGlQM1B2SW5R?=
 =?utf-8?B?clRBbCt4OXBHOWl0QU9FQjFXd1pVOEtTU0FucVQ3WWVPQTdzeEIwWlBIRERQ?=
 =?utf-8?B?akFZNEFMS1JuZjI1R0FUZUg3QXAwcFd3N3lxY28rWFd3d0cyZ3hmZ21ianZ0?=
 =?utf-8?B?QytWT28zT0laNXU2Y3oyU09NSXhtZ09EWjJGMGhJUXpkeXU5eWVOZU9OQVpP?=
 =?utf-8?B?cHlvbHFJelh1UURPdW00UUVGbm92WGN6YXNoZzQwdU5ZdEZGb3VlYlJRREQ3?=
 =?utf-8?B?V1NaTDFRdXF2bGdyYnJ3Tlc4QVdiWENscFRsMjNTK3VESlh0UDBCSTczTUl2?=
 =?utf-8?B?SGpycU13UHE4cm5UZEpSTFRtRVBXRVc0L1c3RUNOU3daNWs4VGdFdEVyN3ov?=
 =?utf-8?B?b3V0dUEvUiszOWRHVWpVYjVUMHpJR20wdUpFcmNnVnh2c3dHZVVzbE9GZmxX?=
 =?utf-8?B?L2NMY1c5QUwvdWYzN3VzeDkxSkxjMkR4VzFnR1I4UWpJNm9JWVhKeFcvTTR4?=
 =?utf-8?B?c2IyaFhTNWpSeTJVVnErSXpudGZaSnBJWEgraC9OTWpoSDRkWC8rVkg5S3o2?=
 =?utf-8?B?WDQrRnljUFo0UnE5MkF5K1cyV3daKzBxczJwc2wvdlRXWll4bTdJK2YvQnJF?=
 =?utf-8?B?T01OS2hkSVNCOGNoYkdTN2RjNHd3bURMMXVuMnZRQkJWbUFzSXcxT01pYnph?=
 =?utf-8?B?MXVGaUsxKzYvTW5BVGdqY3pQVytNdVVkaXg5UVhCU3NkeTFBbGJaaElway9n?=
 =?utf-8?B?bkVHMEhlSXhaUmpXZ1U2eXJJZ0hTeDJYSXBJOXdsTWZZdUFsN1FScVllbXlD?=
 =?utf-8?Q?s4NjQPKzrO4Xo/6pQQ3lCVpGP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1005e7-207a-4e98-ee8a-08dad11b3de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 08:33:35.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyX/mv/00Dsq5k5Lo3frMfCj2nrRG5Df8Va17NKfJ+UzGseoCnWnhI2G4+NT7BvJvDTgy+L93IEFsO9/y6M1tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7418
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMS8yMyA3OjA1LCBaaGFuZywgUWlhbmcxIHdyb3RlOg0KPiANCj4gR2VudGx5IHBp
bmcgIPCfmIoNCj4gDQo+IFRoYW5rcw0KPiBacWlhbmcNCj4gDQo+PiBDdXJyZW50bHksIHRoZSBt
ZW1fZHVtcF9vYmooKSBpcyBpbnZva2VkIGluIGNhbGxfcmN1KCksIHRoZQ0KPj4gY2FsbF9yY3Uo
KSBpcyBtYXliZSBpbnZva2VkIGluIG5vbi1wcmVlbXB0aXZlIGNvZGUgc2VnbWVudCwgZm9yIA0K
Pj4gb2JqZWN0IGFsbG9jYXRlZCBmcm9tIHZtYWxsb2MoKSwgdGhlIGZvbGxvd2luZyBzY2VuYXJp
b3MgbWF5IG9jY3VyOg0KPj4NCj4+ICAgICAgICBDUFUgMA0KPj4gdGFza3MgY29udGV4dA0KPj4g
ICBzcGluX2xvY2soJnZtYXBfYXJlYV9sb2NrKQ0KPj4gICAgICAgSW50ZXJydXB0IGNvbnRleHQN
Cj4+ICAgICAgICAgICBjYWxsX3JjdSgpDQo+PiAgICAgICAgICAgICBtZW1fZHVtcF9vYmoNCj4+
ICAgICAgICAgICAgICAgdm1hbGxvY19kdW1wX29iag0KPj4gICAgICAgICAgICAgICAgIHNwaW5f
bG9jaygmdm1hcF9hcmVhX2xvY2spIDwtLWRlYWRsb2NrDQo+Pg0KPj4gYW5kIGZvciBQUkVFTVBU
LVJUIGtlcm5lbCwgdGhlIHNwaW5sb2NrIHdpbGwgY29udmVydCB0byBzbGVlcGFibGUgDQo+PiBs
b2NrLCBzbyB0aGUgdm1hcF9hcmVhX2xvY2sgc3BpbmxvY2sgbm90IGFsbG93ZWQgdG8gZ2V0IGlu
IA0KPj4gbm9uLXByZWVtcHRpdmUgY29kZSBzZWdtZW50LiB0aGVyZWZvcmUsIHRoaXMgY29tbWl0
IG1ha2UgdGhlIA0KPj4gdm1hbGxvY19kdW1wX29iaigpIGNhbGwgaW4gYSBjbGVhbiBjb250ZXh0
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4N
Cj4+IC0tLQ0KPj4gdjEtPnYyOg0KPj4gYWRkIElTX0VOQUJMRUQoQ09ORklHX1BSRUVNUFRfUlQp
IGNoZWNrLg0KPj4gdjItPnYzOg0KPj4gY2hhbmdlIGNvbW1pdCBtZXNzYWdlIGFuZCBhZGQgc29t
ZSBjb21tZW50Lg0KPj4NCj4+IG1tL3V0aWwuYyAgICB8ICA0ICsrKy0NCj4+IG1tL3ZtYWxsb2Mu
YyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4+IDIgZmlsZXMgY2hhbmdlZCwgMjgg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9tbS91dGls
LmMgYi9tbS91dGlsLmMNCj4+IGluZGV4IDEyOTg0ZTc2NzY3ZS4uMmIwMjIyYTcyOGNjIDEwMDY0
NA0KPj4gLS0tIGEvbW0vdXRpbC5jDQo+PiArKysgYi9tbS91dGlsLmMNCj4+IEBAIC0xMTI4LDcg
KzExMjgsOSBAQCB2b2lkIG1lbV9kdW1wX29iaih2b2lkICpvYmplY3QpDQo+PiAJCXJldHVybjsN
Cj4+DQo+PiAJaWYgKHZpcnRfYWRkcl92YWxpZChvYmplY3QpKQ0KPj4gLQkJdHlwZSA9ICJub24t
c2xhYi92bWFsbG9jIG1lbW9yeSI7DQo+PiArCQl0eXBlID0gIm5vbi1zbGFiIG1lbW9yeSI7DQo+
PiArCWVsc2UgaWYgKGlzX3ZtYWxsb2NfYWRkcihvYmplY3QpKQ0KPj4gKwkJdHlwZSA9ICJ2bWFs
bG9jIG1lbW9yeSI7DQo+PiAJZWxzZSBpZiAob2JqZWN0ID09IE5VTEwpDQo+PiAJCXR5cGUgPSAi
TlVMTCBwb2ludGVyIjsNCj4+IAllbHNlIGlmIChvYmplY3QgPT0gWkVST19TSVpFX1BUUikNCj4+
IGRpZmYgLS1naXQgYS9tbS92bWFsbG9jLmMgYi9tbS92bWFsbG9jLmMgaW5kZXggDQo+PiBjY2Fh
NDYxOTk4ZjMuLjQzNTFlYWZiZTdhYiAxMDA2NDQNCj4+IC0tLSBhL21tL3ZtYWxsb2MuYw0KPj4g
KysrIGIvbW0vdm1hbGxvYy5jDQo+PiBAQCAtNDAzNCw2ICs0MDM0LDMxIEBAIGJvb2wgdm1hbGxv
Y19kdW1wX29iaih2b2lkICpvYmplY3QpDQo+PiAJc3RydWN0IHZtX3N0cnVjdCAqdm07DQo+PiAJ
dm9pZCAqb2JqcCA9ICh2b2lkICopUEFHRV9BTElHTigodW5zaWduZWQgbG9uZylvYmplY3QpOw0K
Pj4NCj4+ICsJLyogZm9yIG5vbi12bWFsbG9jIGFkZHIsIHJldHVybiBkaXJlY3RseSAqLw0KPj4g
KwlpZiAoIWlzX3ZtYWxsb2NfYWRkcihvYmpwKSkNCj4+ICsJCXJldHVybiBmYWxzZTsNCj4+ICsN
Cj4+ICsJLyoqDQo+PiArCSAqIGZvciBub24tUHJlZW1wdC1SVCBrZXJuZWwsIHJldHVybiBkaXJl
Y3RseS4gb3RoZXJ3aXNlIG5vdA0KPj4gKwkgKiBvbmx5IG5lZWRzIHRvIGRldGVybWluZSB3aGV0
aGVyIGl0IGlzIGluIHRoZSBpbnRlcnJ1cHQgY29udGV4dA0KPj4gKwkgKiAoaW5faW50ZXJydXB0
KCkpdG8gYXZvaWQgZGVhZGxvY2ssIGJ1dCBhbHNvIHRvIGF2b2lkIGFjcXVpcmUNCj4+ICsJICog
dm1hcF9hcmVhX2xvY2sgc3BpbmxvY2sgaW4gZGlzYWJsZXMgaW50ZXJydXB0cyBvciBwcmVlbXB0
cw0KPj4gKwkgKiBjcml0aWNhbCBzZWN0aW9ucywgYmVjYXVzZSB0aGUgdm1hcF9hcmVhX2xvY2sg
c3BpbmxvY2sgY29udmVydA0KPj4gKwkgKiB0byBzbGVlcGFibGUgbG9jaw0KPj4gKwkgKi8NCj4+
ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1BSRUVNUFRfUlQpICYmICFwcmVlbXB0aWJsZSgpKQ0K
Pj4gKwkJcmV0dXJuIGZhbHNlOw0KPj4gKw0KPj4gKwkvKioNCj4+ICsJICogZ2V0IGhlcmUsIGZv
ciBQcmVlbXB0LVJUIGtlcm5lbCwgaXQgbWVhbnMgdGhhdCB3ZSBhcmUgaW4NCj4+ICsJICogcHJl
ZW1wdGlibGUgY29udGV4dChwcmVlbXB0aWJsZSgpIGlzIHRydWUpLCBpdCBhbHNvIG1lYW5zDQo+
PiArCSAqIHRoYXQgdGhlIGluX2ludGVycnVwdCgpIHdpbGwgcmV0dXJuIGZhbHNlLg0KPj4gKwkg
KiBmb3Igbm9uLVByZWVtcHQtUlQga2VybmVsLCBvbmx5IG5lZWRzIHRvIGRldGVybWluZSB3aGV0
aGVyDQo+PiArCSAqIGl0IGlzIGluIHRoZSBpbnRlcnJ1cHQgY29udGV4dChpbl9pbnRlcnJ1cHQo
KSkgdG8gYXZvaWQgZGVhZGxvY2sNCj4+ICsJICovDQo+PiArCWlmIChpbl9pbnRlcnJ1cHQoKSkN
Cj4+ICsJCXJldHVybiBmYWxzZTsNCj4NCj4NCj5XZSB3YW50IG1lbV9kdW1wX29iaigpIHRvIHdv
cmsgcHJvcGVybHkgaW4gdGhlIGludGVycnVwdCBjb250ZXh0LiBCdXQgd2l0aCB0aGlzIGlmIHN0
YXRlbWVudCwgaXQncyBpbXBvc3NpYmxlIHRvIHdvcmsgcHJvcGVybHkuDQoNClRoaXMgaXMgdG8g
YXZvaWQgdGhlIGZvbGxvd2luZyBzY2VuYXJpb3MsIGJlY2F1c2UsIGNhbGxfcmN1KCkgY2FuIGJl
IGludm9rZWQgaW4gaGFyZCBpcnEgb3INCnNvZnRpcnEgY29udGV4dCwgc28gbWVtX2R1bXBfb2Jq
KCkgbm90IGR1bXAgc29tZSBkZXRhaWxzIGluZm8uDQoNCkNQVSAwDQp0YXNrcyBjb250ZXh0DQog
ICBzcGluX2xvY2soJnZtYXBfYXJlYV9sb2NrKQ0KICAgICAgIEludGVycnVwdCAgb3Igc29mdGly
cSBjb250ZXh0DQogICAgICAgICAgIGNhbGxfcmN1KCkNCiAgICAgICAgICAgICBtZW1fZHVtcF9v
YmoNCiAgICAgICAgICAgICAgdm1hbGxvY19kdW1wX29iag0KICAgICAgICAgICAgICAgICBzcGlu
X2xvY2soJnZtYXBfYXJlYV9sb2NrKSA8LS1kZWFkbG9jaw0KDQpiZWNhdXNlIG1lbV9kdW1wX29i
aigpIG9ubHkgdXNlZCBieSBSQ1UsICAgSSdtIG5vdCBzdXJlIGlmIHRoaXMgbW9kaWZpY2F0aW9u
IGlzIGFwcHJvcHJpYXRlLCANCm5lZWQgdG8gaGVhciBmcm9tIFBhdWwuDQoNClRoYW5rcw0KWnFp
YW5nDQoNCg0KPg0KPkhlcmUncyBteSB0ZXN0IGNhc2U6DQo+dm9pZCAqdHN0X3A7DQo+DQo+dm9p
ZCBteV9pcnF3b3JrX2hhbmRsZXIoc3RydWN0IGlycV93b3JrICp3b3JrKSB7DQo+ICAgICAgICB2
b2lkICpwID0gdHN0X3A7DQo+DQo+ICAgICAgICBwcmludGsoImVudGVyIG15X2lycXdvcmtfaGFu
ZGxlcjogQ1BVPSVkLCBsb2NrZWQ9JWRcbiIsIHNtcF9wcm9jZXNzb3JfaWQoKSwgdHN0X2lzX2xv
Y2tlZCgpKTsNCj4gICAgICAgIG1lbV9kdW1wX29iaihwKTsNCj4gICAgICAgIHZmcmVlKHApOw0K
Pn0NCj4NCj5zdGF0aWMgdm9pZCB0ZXN0X21lbV9kdW1wKHZvaWQpDQo+ew0KPiAgICAgICAgc3Ry
dWN0IGlycV93b3JrIHdvcmsgPSBJUlFfV09SS19JTklUX0hBUkQobXlfaXJxd29ya19oYW5kbGVy
KTsNCj4NCj4gICAgICAgIHRzdF9wID0gdm1hbGxvYyhQQUdFX1NJWkUpOw0KPiAgICAgICAgaWYg
KCF0c3RfcCkgew0KPiAgICAgICAgICAgICAgICBwcmludGsoInZtYWxsb2MgZmFpbGVkXG4iKTsN
Cj4gICAgICAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICAgfQ0KPiAgICAgICAgcHJpbnRrKCJl
bnRlciB0ZXN0X21lbV9kdW1wOiBDUFU9JWRcbiIsIHNtcF9wcm9jZXNzb3JfaWQoKSk7DQo+DQo+
ICAgICAgICAvL3RzdF9sb2NrKCk7DQo+ICAgICAgICBpcnFfd29ya19xdWV1ZSgmd29yayk7DQo+
ICAgICAgICAvL3RzdF91bmxvY2soKTsNCj4NCj4gICAgICAgIHByaW50aygibGVhdmUgdGVzdF9t
ZW1fZHVtcDogQ1BVPSVkXG4iLCBzbXBfcHJvY2Vzc29yX2lkKCkpOyB9DQo+DQo+VGVzdCByZXN1
bHQ6DQo+WyAgIDQ1LjIxMjk0MV0gZW50ZXIgdGVzdF9tZW1fZHVtcDogQ1BVPTANCj5bICAgNDUu
MjEzMjgwXSBlbnRlciBteV9pcnF3b3JrX2hhbmRsZXI6IENQVT0wLCBsb2NrZWQ9MA0KPlsgICA0
NS4yMTM1NDZdICB2bWFsbG9jIG1lbW9yeQ0KPlsgICA0NS4yMTM5OTZdIGxlYXZlIHRlc3RfbWVt
X2R1bXA6IENQVT0wDQo+DQo+PiArDQo+PiAJdm0gPSBmaW5kX3ZtX2FyZWEob2JqcCk7DQo+PiAJ
aWYgKCF2bSkNCj4+IAkJcmV0dXJuIGZhbHNlOw0KPj4gLS0NCj4+IDIuMjUuMQ0KPiANCj4NCj4t
LSANCj5SZWdhcmRzLA0KPiAgWmhlbiBMZWkNCg==
