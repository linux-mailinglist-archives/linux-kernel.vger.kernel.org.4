Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE763B763
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiK2Bor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiK2Boi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:44:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF0B4384B;
        Mon, 28 Nov 2022 17:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669686272; x=1701222272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bbx2/ELYRaHdqgKiYqoAuHnbx2/ZLuepgwHIwCkUV4M=;
  b=j2w7fW2S2Q3PBNkpmU2HGqtNoELrH+exiWgCepqlva+2h2AbZD8pcpAi
   Jc+HarfFxXf7MC8sqIo1bhiCgENo+f315gAdSXBC/1CzoC1TJU+e9OxAj
   /QDqC9Pj47SMAdDv+FRTzQeCLS2N8EMZV63kbOP3e+fRornlrnYy3jQb4
   pXjTHCtFpSC5B+HPa3FBsP/sBY1U+Yd7Di4Dk626WcbY7yUIkD14C4mBA
   WHhaN4xg+YEPZW4tCLkPOS8wIknnrfJpSgBl8TVBPPJC0Q8suz8QQA1Q/
   3YwjSvjWj+BFGOuyUIJEVs4M03Tcu3YMJqro+Pi8HmjEWYLBHXrcbmwUn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="379257138"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="379257138"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 17:44:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="676258991"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="676258991"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 28 Nov 2022 17:44:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 17:44:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 17:44:32 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 17:44:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8GCAgbJBLGlaQEOzhqytXPAfwZ5OxJZyU23r1AViXXoR07xR0y/8VCycd5frpMqun4EF9Lz/Jm4vR2/W0pPepcimY3eEVhU63IZ+MdHsDzS+7um9/SUgl3++J/MJ0QvFhrksKm+R5cL+do4GzNwZI+EkMVrRBV8riy6FdgUanNHrngrlc2jd+mrSx/RXn4v0VYtC+GXq7x6YTXSdKgDxhQmsvN7AjBTeHHmG+euo6ql/XTomRfRWpieOmMORjoVLEvtJGLu3IBu88q1CyzggaJEkxj3ED0XL5O4yr+LGUS6+Ir39fYNCNHj5VrejzsysVrwrlqQCf4uPEaEVzsFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bbx2/ELYRaHdqgKiYqoAuHnbx2/ZLuepgwHIwCkUV4M=;
 b=S+YCZYKRmleg6QyXU6U92f/O4+hDUR8c7TR9XxtLVOdzyuNkzVLDeWshHeubVgCpJlYufbRlZI2uc4lwUcatDDgc5RzBaNJLCgKyfY77D3HsVrqLgf8r5OAdndDiL1tHkr1+WXurPJIvKeLRFyyFKqtWufiBV+3XfphfzlZxh9VswlhjKcf9h6aEOi/u2ybTfN57S626REq2QTapjGbCxaDNcZOQy9YgSVE2yRK5f7dNrZpUiGU/7HFQZxYtFu+RO2iNcJ4stpd8rifFajGTo/Mm9Mn+9T4kMLi7Wn/taBd4DP/7OHIZxs2Syu832GlctPybfLFSspYCN/TrcNw7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CH0PR11MB5267.namprd11.prod.outlook.com (2603:10b6:610:e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 01:44:30 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%5]) with mapi id 15.20.5857.020; Tue, 29 Nov 2022
 01:44:30 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Topic: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Index: AQHZAzXSKOjuTzu2RUKeoTlESXbs8q5VFkkAgAAK6HA=
Date:   Tue, 29 Nov 2022 01:44:30 +0000
Message-ID: <PH0PR11MB58806870B32DAC11E46E6C31DA129@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221128143428.1703744-1-qiang1.zhang@intel.com>
 <20221129010312.GS4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221129010312.GS4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CH0PR11MB5267:EE_
x-ms-office365-filtering-correlation-id: beeaa6e5-aae8-4c69-7eb3-08dad1ab41f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oxTL4HW8gzUhSNBf6wz8JoMSFcbvjgVh1L/C4K5tIISPzPVCOXZUGQSJ4PdnjJR8lbht1DD/Q/kaJ2GyiRZTO3IF6wANVE2/rFzOOkBdA+4W3047kNr+HC5n34Mreu650ZqhWFo6HmXoCLv4wPpazS47fc6iq5YbGnlwRvlCxWQltnS86hFPDuJ7BPw9KD8ETp8vl5W4kqnIGmwipzRTaMfGtq8K3U7WON4WA2wR5LPcxrAEDSDYk+alm5sMXFyyvqbYjrf/KwjSfz/T3iuXRaK4ViGpD8+wnyeaj2F/zFheHYa0JAu78FW1+Ek3HKyWuX/vZ2rwaqDwxCWkvlUDXcs/MSzvxOFV09DrIEi4rPgtmiY9X8ZiUR3JcSEwiewTzlrcL/4AXStMl4NT6CsWHDCbLm4Ld7+FY4D4viypDsRHnKfywY570LysiAO3JDJVw562w3aaB9TFzaWPvNiVEb1gHGIRl3XJOQdgRTvQp2tGmo0Y+io7v35G6l9+sM01M8D5HZp6kDxrVAguHhrre9YrXnfO2k+M/qh5A0T9zAIiVza3ZvQHBCnVJCwAcAJzTuLCefbuk1z2Kbzygkest/Xprv9WXPYrYJA6luKz6YzLv7BoP8bd9F0CmsOM9VTrBizu++qFvC5tBQ4vs4/pXSw6PyOTrOHW+odb57dh0rJL2Mv/Z04m5DfC78Glhd/94RAGmSjTGHJa7JXdQwoL+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(54906003)(71200400001)(6916009)(33656002)(8676002)(52536014)(4326008)(5660300002)(41300700001)(316002)(66446008)(76116006)(66946007)(66476007)(64756008)(66556008)(8936002)(55016003)(38100700002)(83380400001)(82960400001)(122000001)(38070700005)(9686003)(478600001)(86362001)(26005)(186003)(7696005)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlB2by9IOHYvRmRuZjZsTERFN2dQUlFoRGtDa1E3cG5SU3dBcWZ5R2ZDQUFW?=
 =?utf-8?B?VUFMby9IWnlBZnAyNkd0TUM2eDJneDBPYW0xNGJmanZjVUdlaFEwb3ZQTk1C?=
 =?utf-8?B?Z3ZZMlJoYzF4ZUxRSWF2M3ZGZUlLZS9hdXVxMGRwVmhUUzhxS1g3M0JhRitQ?=
 =?utf-8?B?dHlwN003SERubmF3YWd5Rk0zVUVPbmw4bHJvSTZiL1F6WlVqbldaaGNXNk04?=
 =?utf-8?B?OGYrN21wZ1JEVzJJQng1MUVabXVDUGRpQVRqcWpuY21kUmZuV3NvbVVjejRs?=
 =?utf-8?B?TGRBSzE4d3FGZ0VBQmZuMllTaS9QRXRWVzdLVVpvTVM1alN2QWQ3NlRmR3Bx?=
 =?utf-8?B?WnBza1NTYXJjMHBMNlFUbWtnMUlOempjS1k4N3NWcjhWeldNV3B1Vkg5Ym1j?=
 =?utf-8?B?YnhqVEViSU5yYzkxTWY4VnBMYTVhWkc0N1dSWlY2cWhscjdRSVBvbUs4S01y?=
 =?utf-8?B?bkl4OFpOQUFyNGRKbndzRmQ1WDAwN2g4dlRQbmNEcjZXQWtxZ3N5SXNyZUJK?=
 =?utf-8?B?ZkZhLzBXZXBhTzZkUnZwcGwzS3ZlMm5kTmZFMDMwblRUZDVTcFVEREFvSFov?=
 =?utf-8?B?NXdoMFJHRGRKQkcyOTJkVE93NDI5Z0J3NElzZWl5ZjlxQ29sMjUvSHA0QWNB?=
 =?utf-8?B?UzlZWHhCQTl4UThtWTNJSXNFOVFYZGtFVlhYTjhsYjM4RlBGNXdtKzhqM3d1?=
 =?utf-8?B?elRjQ25jK2Q3TVc4NmZVVFdkQVNJK1VLbzVYQnVEV1k5TVFhelo0Y3hwUGZi?=
 =?utf-8?B?cGxDR3NqU2FxbWZ0bFdJOWd2Ym1uUjgwc2dlMHp2NDdWYmFuSk9oQW5kUFo0?=
 =?utf-8?B?ck1HVy82ZXAzVmVWOFVIVFJtdFVsM2FDUFprVGZkeHlqZFNLWEdXRWd6RnlJ?=
 =?utf-8?B?UllyeEtINCt1eDVMNHk1UFNXNUl4b3ZzUG5BWHp2Ym8wSVlxYkxVQVFoVkZB?=
 =?utf-8?B?bHZISTRWaERrUmlWMitZamlwazZjZVNmOFBidGw0ak9aNUJCelptYm9qb2Zi?=
 =?utf-8?B?NmNRWXp6NzAycXI3TmtXZi9IOElMMDZ4NVRkc25NdkZCTndiREtHVkhZTmY2?=
 =?utf-8?B?QkFrSExwaEFjZWhlWGtqRnJ3d3RaSW9ucEhkK0VHOXZsQjRSRzB4cUYweWdi?=
 =?utf-8?B?bnlYdWZSbmdjUHFDOHVxd2ZwVmV3Q2Z3WTBpUkxVMFNsV2ZvODdzZnNPUHYr?=
 =?utf-8?B?bGRNaXlhSkNnSHZMdFI1YWRMeUttM3p5ZkNvcGErV3RLN0xIMFZTNzJtZWIx?=
 =?utf-8?B?Vy9lSDdCNTQ1bHBiVUNVR2RHYkdYRitVUkQrbUw4SGpFQW54ZXN4UUg2SGV5?=
 =?utf-8?B?RVcxSnBTY0QzVFZNeVBjOUZNbmhtL1Fmd1Mxb08rMC8vWjFUOFFDSkJPd21k?=
 =?utf-8?B?Qkd1MnRnRnU0WlF4U2tHTkJwMFB4REs3d0tQVFdCanhhUWN1OWoxSG90VFl0?=
 =?utf-8?B?VXFNVFlQN0FROU16TlpXcnZOVUlTUy9BVlI3eC92MVIzYkhCRjV5ZWJsKzNt?=
 =?utf-8?B?OWVzZUNuMEIzVFc1WWp3TVFuek5ENmk5ME8xMkoyWng2cytEb0hDZWUxdERp?=
 =?utf-8?B?OTlsZEpxS3dDSURDY09yS2o5ZkhtTlF4RTRHUitkUW9zZFo4alVKeXNyNWJW?=
 =?utf-8?B?YW9FNWhMNjdyRUpicjhFVGptYnROcmpCakRWRDhZVkxMMDV0dEhmY1JHbUNZ?=
 =?utf-8?B?U3FMeGNCVnkvcTY0dU03cmJnNHdsY0FsNE1nWVpyMmFVRnlEL0lCWlM4UkdI?=
 =?utf-8?B?YnF1Q0FGOThSais3TmlTc28rU2c4QW1yY2J1Ymdld0dlam56aUc1eXBRYXM4?=
 =?utf-8?B?RzlXSk1wdFAyNGt3NExpaS8zcG5PNGpzQXBic0Z6Q25BZTdaU0MrUUIwT3ps?=
 =?utf-8?B?WUVWbWVsN2ROQWlwd0luVFBsaU9QMi93dHF6eTZFNTJBWHRmbmpMRGhoSkZn?=
 =?utf-8?B?d1RiVDFvZHNrY3hML21VVDVqak5iRThtUG9nbElnbkRSUEgvSm5wSFhXUTFD?=
 =?utf-8?B?SXpIMjdNa0lidmdnYmFGMUh2ckhzVFJVbit0UWtTRG12Wm9kVnU3SFpvNklj?=
 =?utf-8?B?RHZyOGxkNUVvS0gvU1puUm9ySEFwZnVUMWR6d0FVeGU0bktYTm1RZU1IaTFv?=
 =?utf-8?Q?dfeQkJMspPX186mIvhGvsX+6M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beeaa6e5-aae8-4c69-7eb3-08dad1ab41f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 01:44:30.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RS1H5jTNfhYfqGGtzX2vaRpnrz4Ha3Vh+vVeBp5v4C38wrXL4JrRD0gGgyFTk5rMSvgqYxPZ1uN/w8GwA9fLXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5267
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBNb24sIE5vdiAyOCwgMjAyMiBhdCAxMDozNDoyOFBNICswODAwLCBacWlhbmcgd3JvdGU6
DQo+IEN1cnJlbnRseSwgaW52b2tlIHJjdV90YXNrc19ydWRlX3dhaXRfZ3AoKSB0byB3YWl0IG9u
ZSBydWRlDQo+IFJDVS10YXNrcyBncmFjZSBwZXJpb2QsIGlmIF9fbnVtX29ubGluZV9jcHVzID09
IDEsIHdpbGwgcmV0dXJuDQo+IGRpcmVjdGx5LCBpbmRpY2F0ZXMgdGhlIGVuZCBvZiB0aGUgcnVk
ZSBSQ1UtdGFzayBncmFjZSBwZXJpb2QuDQo+IHN1cHBvc2UgdGhlIHN5c3RlbSBoYXMgdHdvIGNw
dXMsIGNvbnNpZGVyIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW86DQo+IA0KPiAJQ1BVMCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BVMSAoZ29pbmcgb2ZmbGluZSkNCj4gCQkJCSAg
ICAgICAgICBtaWdyYXRpb24vMSB0YXNrOg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNwdV9zdG9wcGVyX3RocmVhZA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtPiB0YWtlX2NwdV9kb3duDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC0+IF9jcHVfZGlzYWJsZQ0KPiAJCQkgICAgICAgICAgICAgICAg
ICAgKGRlYyBfX251bV9vbmxpbmVfY3B1cykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLT5jcHVocF9pbnZva2VfY2FsbGJhY2sNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJlZW1wdF9kaXNhYmxlDQo+IAkJCQkJ
CWFjY2VzcyBvbGRfZGF0YTANCj4gICAgICAgICAgICB0YXNrMQ0KPiAgZGVsIG9sZF9kYXRhMCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4uLg0KPiAgc3luY2hyb25pemVfcmN1
X3Rhc2tzX3J1ZGUoKQ0KPiAgdGFzazEgc2NoZWR1bGUgb3V0DQo+ICAuLi4uDQo+ICB0YXNrMiBz
Y2hlZHVsZSBpbg0KPiAgcmN1X3Rhc2tzX3J1ZGVfd2FpdF9ncCgpDQo+ICAgICAgLT5fX251bV9v
bmxpbmVfY3B1cyA9PSAxDQo+ICAgICAgICAtPnJldHVybg0KPiAgLi4uLg0KPiAgdGFzazEgc2No
ZWR1bGUgaW4NCj4gIC0+ZnJlZSBvbGRfZGF0YTANCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcHJlZW1wdF9lbmFibGUNCj4gDQo+IHdoZW4gQ1BVMSBk
ZWMgX19udW1fb25saW5lX2NwdXMgYW5kIF9fbnVtX29ubGluZV9jcHVzIGlzIGVxdWFsIG9uZSwN
Cj4gdGhlIENQVTEgaGFzIG5vdCBmaW5pc2hlZCBvZmZsaW5lLCBzdG9wX21hY2hpbmUgdGFzayht
aWdyYXRpb24vMSkNCj4gc3RpbGwgcnVubmluZyBvbiBDUFUxLCBtYXliZSBzdGlsbCBhY2Nlc3Np
bmcgJ29sZF9kYXRhMCcsIGJ1dCB0aGUNCj4gJ29sZF9kYXRhMCcgaGFzIGZyZWVkIG9uIENQVTAu
DQo+IA0KPiBUaGlzIGNvbW1pdCBhZGQgY3B1c19yZWFkX2xvY2svdW5sb2NrKCkgcHJvdGVjdGlv
biBiZWZvcmUgYWNjZXNzaW5nDQo+IF9fbnVtX29ubGluZV9jcHVzIHZhcmlhYmxlcywgdG8gZW5z
dXJlIHRoYXQgdGhlIENQVSBpbiB0aGUgb2ZmbGluZQ0KPiBwcm9jZXNzIGhhcyBiZWVuIGNvbXBs
ZXRlZCBvZmZsaW5lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdA
aW50ZWwuY29tPg0KPg0KPkZpcnN0LCBnb29kIGV5ZXMgYW5kIGdvb2QgY2F0Y2ghISENCj4NCj5U
aGUgcHVycG9zZSBvZiB0aGF0IGNoZWNrIGZvciBudW1fb25saW5lX2NwdXMoKSBpcyBub3QgcGVy
Zm9ybWFuY2UNCj5vbiBzaW5nbGUtQ1BVIHN5c3RlbXMsIGJ1dCByYXRoZXIgY29ycmVjdCBvcGVy
YXRpb24gZHVyaW5nIGVhcmx5IGJvb3QuDQo+U28gYSBzaW1wbGVyIHdheSB0byBtYWtlIHRoYXQg
d29yayBpcyB0byBjaGVjayBmb3IgUkNVX1NDSEVEVUxFUl9SVU5OSU5HLA0KPmZvciBleGFtcGxl
LCBhcyBmb2xsb3dzOg0KPg0KPglpZiAocmN1X3NjaGVkdWxlcl9hY3RpdmUgIT0gUkNVX1NDSEVE
VUxFUl9SVU5OSU5HICYmDQo+CSAgICBudW1fb25saW5lX2NwdXMoKSA8PSAxKQ0KPgkJcmV0dXJu
OwkvLyBFYXJseSBib290IGZhc3RwYXRoIGZvciBvbmx5IG9uZSBDUFUuDQo+DQo+VGhpcyB3b3Jr
cyBiZWNhdXNlIHJjdV9zY2hlZHVsZXJfYWN0aXZlIGlzIHNldCB0byBSQ1VfU0NIRURVTEVSX1JV
Tk5JTkcNCj5sb25nIGJlZm9yZSBpdCBpcyBwb3NzaWJsZSB0byBvZmZsaW5lIENQVXMuDQo+DQo+
WWVzLCBzY2hlZHVsZV9vbl9lYWNoX2NwdSgpIGRvZXMgZG8gY3B1c19yZWFkX2xvY2soKSwgYWdh
aW4sIGdvb2QgZXllcywNCj5hbmQgaXQgYWxzbyB1bm5lY2Vzc2FyaWx5IGRvZXMgdGhlIHNjaGVk
dWxlX3dvcmtfb24oKSB0aGUgY3VycmVudCBDUFUsDQo+YnV0IHRoZSBjb2RlIGNhbGxpbmcgc3lu
Y2hyb25pemVfcmN1X3Rhc2tzX3J1ZGUoKSBpcyBvbiBoaWdoLW92ZXJoZWFkDQo+Y29kZSBwYXRo
cywgc28gdGhpcyBvdmVyaGVhZCBpcyBkb3duIGluIHRoZSBub2lzZS4NCj4NCj5VbnRpbCBmdXJ0
aGVyIG5vdGljZSwgYW55d2F5Lg0KPg0KPlNvIHNpbXBsaWNpdHkgaXMgbXVjaCBtb3JlIGltcG9y
dGFudCB0aGFuIHBlcmZvcm1hbmNlIGluIHRoaXMgY29kZS4NCj5TbyBqdXN0IGFkZGluZyB0aGUg
Y2hlY2sgZm9yIFJDVV9TQ0hFRFVMRVJfUlVOTklORyBzaG91bGQgZml4IHRoaXMsDQoNCkFncmVl
IPCfmIosIEkgd2lsbCByZXNlbmQgdjMuDQoNClRoYW5rcw0KWnFpYW5nDQoNCj51bmxlc3MgSSBh
bSBtaXNzaW5nIHNvbWV0aGluZyAoYWx3YXlzIHBvc3NpYmxlISkuDQo+DQo+CQkJCQkJCVRoYW54
LCBQYXVsDQoNCj4gLS0tDQo+ICBrZXJuZWwvcmN1L3Rhc2tzLmggfCAyMCArKysrKysrKysrKysr
KysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90YXNrcy5oIGIva2VybmVsL3JjdS90
YXNrcy5oDQo+IGluZGV4IDRhOTkxMzExYmU5Yi4uMDhlNzJjNjQ2MmQ4IDEwMDY0NA0KPiAtLS0g
YS9rZXJuZWwvcmN1L3Rhc2tzLmgNCj4gKysrIGIva2VybmVsL3JjdS90YXNrcy5oDQo+IEBAIC0x
MDMzLDE0ICsxMDMzLDMwIEBAIHN0YXRpYyB2b2lkIHJjdV90YXNrc19iZV9ydWRlKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yaykNCj4gIHsNCj4gIH0NCj4gIA0KPiArc3RhdGljIERFRklORV9QRVJf
Q1BVKHN0cnVjdCB3b3JrX3N0cnVjdCwgcnVkZV93b3JrKTsNCj4gKw0KPiAgLy8gV2FpdCBmb3Ig
b25lIHJ1ZGUgUkNVLXRhc2tzIGdyYWNlIHBlcmlvZC4NCj4gIHN0YXRpYyB2b2lkIHJjdV90YXNr
c19ydWRlX3dhaXRfZ3Aoc3RydWN0IHJjdV90YXNrcyAqcnRwKQ0KPiAgew0KPiArCWludCBjcHU7
DQo+ICsJc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrOw0KPiArDQo+ICsJY3B1c19yZWFkX2xvY2so
KTsNCj4gIAlpZiAobnVtX29ubGluZV9jcHVzKCkgPD0gMSkNCj4gLQkJcmV0dXJuOwkvLyBGYXN0
cGF0aCBmb3Igb25seSBvbmUgQ1BVLg0KPiArCQlnb3RvIGVuZDsvLyBGYXN0cGF0aCBmb3Igb25s
eSBvbmUgQ1BVLg0KPiAgDQo+ICAJcnRwLT5uX2lwaXMgKz0gY3B1bWFza193ZWlnaHQoY3B1X29u
bGluZV9tYXNrKTsNCj4gLQlzY2hlZHVsZV9vbl9lYWNoX2NwdShyY3VfdGFza3NfYmVfcnVkZSk7
DQo+ICsJZm9yX2VhY2hfb25saW5lX2NwdShjcHUpIHsNCj4gKwkJd29yayA9IHBlcl9jcHVfcHRy
KCZydWRlX3dvcmssIGNwdSk7DQo+ICsJCUlOSVRfV09SSyh3b3JrLCByY3VfdGFza3NfYmVfcnVk
ZSk7DQo+ICsJCXNjaGVkdWxlX3dvcmtfb24oY3B1LCB3b3JrKTsNCj4gKwl9DQo+ICsNCj4gKwlm
b3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkNCj4gKwkJZmx1c2hfd29yayhwZXJfY3B1X3B0cigmcnVk
ZV93b3JrLCBjcHUpKTsNCj4gKw0KPiArZW5kOg0KPiArCWNwdXNfcmVhZF91bmxvY2soKTsNCj4g
IH0NCj4gIA0KPiAgdm9pZCBjYWxsX3JjdV90YXNrc19ydWRlKHN0cnVjdCByY3VfaGVhZCAqcmhw
LCByY3VfY2FsbGJhY2tfdCBmdW5jKTsNCj4gLS0gDQo+IDIuMjUuMQ0KPiANCg==
