Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A92B6B6D44
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCMCFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMCFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:05:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8F52B633
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 19:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678673131; x=1710209131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5bEvqUS4ZRqnfTpTkOnS33bMldq2ZwPTra2vd0Va0+U=;
  b=AnoXgI/gDfwVEsxdc/j9Jd1dzlibbXsvtLSH+6Hs88q5n5Ue81XsQ6aJ
   7LZe6I55IRZB0rLfxnxe7F5Yhe0oT3L9kMb/o7eqdbxEJq3joWqD4galL
   hdv3WV+E+0fsyjkewHLKWWrDJKauFplpWQYo/bLAicsDXviIPyGQqfXO2
   dcUah7UijCn7+NwPWG9S3MbI2bB06/QORVs3DtBy0y+E7sGv6oP7FMJ/j
   Dbf69xeHs0DBN2VyLNybadWOrpmN9QGLNudKbuU9HU8WkbWvEcQgkK5+U
   sVfm0SuMMxNlTs/Oc0S1bpf1k7G5rNF2P8GcSeC/BQauiVw4mpX2mVT5G
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="316692874"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="316692874"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 19:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="678514469"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="678514469"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 12 Mar 2023 19:05:30 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 19:05:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 12 Mar 2023 19:05:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 12 Mar 2023 19:05:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRyh2MMOIup29As1Oepqc06u0Yf5aq84v755k7mjE6L/dr9FSNS1lk/RoTGp8gjlAHBmsYkFSTsuTISDbteUoPcZFG1nhpSvtKD/5SS6hHHzgmC4nY9YVsHVpgSvZIGoiwGIMwuIRyIPcIuDwWfIj3tWNO6r1obItb7uSvL0Vs34kTZTBFYjg+NAfC7rkMaSBJ6qEKdhs5b+efGesXIUP1WccdFWiWSYjJ+hsZz/kPYrhksx5oXeyN8dt65YQYeK6FLH3HtxBK+2rxdm+FGxDxe3fwRpQU8jDsl7Vz+kjmDzqAOLtMujxeKnE0Wukf3SlhmFK7a3CU2mkcP7Wrb/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bEvqUS4ZRqnfTpTkOnS33bMldq2ZwPTra2vd0Va0+U=;
 b=aM5kBr5yeELxelm+vN3sWS+Xo3KqTJ8d5pwKFtKZyyV7q+Dqpub8i1bsKmF9gEV5rAHqtV9ruduYR5ozkw95PT0ciKqllwsnwNd++m66Vc+D5UEHm3jkZWdwAFtJTeohHrFzvXWQjuh5p/d3eYr6pEJBE1ejst7SkyK8cW5l482CNrFrI7m0ZSnNqtCYwFBLj4Lb3MIg372+AowxBgmUlKyIi22QzNcr9prjuxUtc4ox/REiWCOi0cg5vBlgHhNn7U+HOZBOnUEhu5DT4aNOIO+H07z9LCpykXOFs/YYSJ4lOHXq6weqbjJECPm6gAzWF6SS/y6m+PKVzvfaUX1cGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by PH8PR11MB6753.namprd11.prod.outlook.com (2603:10b6:510:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Mon, 13 Mar
 2023 02:05:25 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 02:05:25 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/1] x86/topology: fix erroneous smp_num_siblings on
 Intel Hybrid platform
Thread-Topic: [PATCH V2 1/1] x86/topology: fix erroneous smp_num_siblings on
 Intel Hybrid platform
Thread-Index: AQHZRNuJwoou/HmBw0y9tNToRhRqM67XsZ6AgAFjLwCAHwIHAA==
Date:   Mon, 13 Mar 2023 02:05:25 +0000
Message-ID: <a9f40d7aac8c03ce19f6e9004efa2817a66770b7.camel@intel.com>
References: <20230220032856.661884-1-rui.zhang@intel.com>
         <20230220032856.661884-2-rui.zhang@intel.com>
         <Y/NYC+hjcU0NWC6p@hirez.programming.kicks-ass.net>
         <23112ed6f8dd1d8973b896fbd714c1499a92ffe1.camel@intel.com>
In-Reply-To: <23112ed6f8dd1d8973b896fbd714c1499a92ffe1.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|PH8PR11MB6753:EE_
x-ms-office365-filtering-correlation-id: 9ca87541-35ed-44cf-8091-08db23676924
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wnR0V7aURpfkhf0JuJZ3rKs+SLGDSeHUlLs6sH5n3+mntRNUpAVX8+WqbsX6N89/Dldx5iItg++6ubqSGx/+bZWME1x20HlRrUVRRDyVSFGyWLbK/AlX2Mh1oAbpoix8M50F0K6nN7PpyWze1jXDZrZKWrOo7OodFIJn/znkAfGxrBLKE3YM/6LhTQK47D8eVjci1kkrbYaTpLPSsUHUVBpy0P1wLQ1cWbbjcC0T4nod1FfMSbaDo656WELhZoZHLdGjO0r1ngsj8Qcw0TTVRuUAZRIDrjDVg4S/E7q4n3rINFp15vOtd4ywvXozPSnwvTAQWbUw+qNoFlr+sS2vvdn6YLDKy722O8qXtj6qFzUallMcdBHVfFrj1y8UvvYoBCwL2R5wtbRGgGu8zkpVNZxO6DWcnj+XTrNuLu4szEqkk8xEldTD6cQ8e8sKgRWwoDXNkvThZDbPL8N6/3apalhweTD0x6x2iYlgqLXUtMo+owsv5eSUfa2Me5k/4j0zr6GDuRzDHRxOQDbX1sQFARxL0XwEnl2X4FDPyenOUPrKnZG5Bdk7W6ODUXxUev34DWqZFO4mpU2CbksjG6gefbg+a9hF9vJF5I937WzzqA9Wqpp08Gnp2j/Yoml+12/NZK0Z/M+gVldpttcTAw+7USj4lITt2LdP9YJXL5ehu74D7jlgRHGpxo+6hZuAdPObmn4RPSDNR4XFjOt7qaWXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199018)(36756003)(83380400001)(82960400001)(26005)(186003)(71200400001)(2616005)(6506007)(6512007)(5660300002)(8936002)(6486002)(66476007)(76116006)(66446008)(86362001)(66556008)(8676002)(6916009)(4326008)(64756008)(2906002)(66946007)(41300700001)(316002)(122000001)(38100700002)(478600001)(91956017)(54906003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aURhM3lPSENIVTRGK0dDdDdIVzlETmovcDNWN0ZJT3pPVEZjWERvNGhyN3dt?=
 =?utf-8?B?Y01FL3ZwODNJRHFUd0lFWitVclFnL3dxK1VucGJhRjViMk0zb24zL0Q3cisv?=
 =?utf-8?B?RDNPUysrR2ZWN2NvMHI4cTRJVkpvenA0cWp2bUgrTmVwdkJ4eFdyTW4vSGNL?=
 =?utf-8?B?M0RFZElPZ1VxUmxiLzdyNURrYWhuK0FSUk8vODgvc08rb0FzQUVCYWRjUXpo?=
 =?utf-8?B?Y2lJV0ZqdVRrMDBHbUxQWmlXb0xHRitpb1VubzRQalFPeEV4YXFLTlE0VmJR?=
 =?utf-8?B?WFFyRXFXVE9BRWZUbjMvd0ZzY2FGU3pxU0dqbHQreUFGU2xJWTFaZ2hlcHo1?=
 =?utf-8?B?WCtHdW9qNHFWOHkyNGVQWHZJalV2Wkc1dVQybncyLzJzenVPS3lrNzgzWEtF?=
 =?utf-8?B?NzIwOU1vNzB4TldGWlEwQURmODVsZ0s0S0RzaWtYRzhDTURyN3ROaUVpU1o0?=
 =?utf-8?B?SGU3RWIrclhKWnRTelAwVFZsQTJDcEh4VW9kZUNaNzhPaUt0elRBS2hIZlk0?=
 =?utf-8?B?WHFNNmNac25MekRCRDJzREsvMCtMa0tRWFhKTXFKeUxzMHdKY1FON2h6eHZ5?=
 =?utf-8?B?bS9OaTJNa05EdDE3d2RGM29DRTBwYkdFcGI3MXltR0Fnc1lmOG0wNWV5bDRC?=
 =?utf-8?B?WmJiVkRPODRVdjQ2eTcybEJieTM2SFROVWdPYXJxK25WbHlocWc4alBvZ3M4?=
 =?utf-8?B?NHVPMFZQOUxaWXJvNG4xWktOUjB1K1piN1VOc1ZBSU9pUUs2UWxyeUhIRGpa?=
 =?utf-8?B?NEYydENwTGhoTDV0MHJXSkNhNDR4U0xDTzVLSUpnNE5xbDNSQmZ5NENRZ25T?=
 =?utf-8?B?MWhvczUvWTJ2ZHByYSszN09JTnV2S1lHQldkKzVRMEh1YlhPV2ZhYTFGMVF6?=
 =?utf-8?B?T1VmMWdaLytPaFl6MDZsSkJqcmpERzYyLzgvRUhkYmNvblhEdE5aVU1oZjZS?=
 =?utf-8?B?S3o3OUYzdU83bncrTUVMY0NSYWxZeFBpVlp0WmZuZVBxU1FlOVp3MEswWVAz?=
 =?utf-8?B?NzIvRDFNNi9PSVlGQXpmQmlVMTQ1WVRYL0Zod0JBdU9mc2JQUElRWmxCVklH?=
 =?utf-8?B?QjcxN2t5a24walgrMDI1VVp5NkplT3A4UCt0SWhQekVla05xRjk3N2ROSE9j?=
 =?utf-8?B?N2pXMmduRDVqaHJUeUx1V0xEaU1tNm9NWDhjUHk1eXF3MXJRVzRCdzVNWFU2?=
 =?utf-8?B?Q29CQmhJNWs5Q2FOdHdJVUZQMDVBUC9EQmplQng1VEMxNURpL3d0RlljREUx?=
 =?utf-8?B?ZldvUDVFQmN1TG51eldyQ1ZvaUM3Tm1Ja2ZTYUtRZDI1b3NNR1MwREp4dGZS?=
 =?utf-8?B?T0ZOdzZCL1AxZkViWStsL05xRDhuZ3VXQ0NUaUtOVno0alRzSmQ4d3N6WEhW?=
 =?utf-8?B?MVEzbnRjOU9jczZ0WXg3Q1M3MVFiWDNTdU1BZlViRk83azEwMHBLUkN2dVpx?=
 =?utf-8?B?SjBVSlFSVEFVaVoydGViazIzaFRxMVQyMzNVaE5mUWlVbWhtNEVIZFczSXJP?=
 =?utf-8?B?RUk3bzRUdGppNVk2aWR5dkpPdnRPdUVZL2paQ2RDeTZ4TEZKNk9raDZEdXBu?=
 =?utf-8?B?ZS8zeGM1a0JCeDNDd1ZKWllFNXd4eWpPNmNPbmdvbUtUM1NwY2hnek1hTENO?=
 =?utf-8?B?SEEyRUV0Sk1SQUpNcGdiVkVUcU5VaHVwRklFQmRNUHZxTWh0V0JGejV6NnEw?=
 =?utf-8?B?SjIwbHBxQ3c1cWpVdEpBdkJHU09YZFlxcXN2QkMrVmw3NGx5emEreUw5ZktZ?=
 =?utf-8?B?NjJodmplZEd1SDUyZHdWMVJwVFV4MzZYS3ZHK1VqaVB0cUtpaU9kL2NQZnNO?=
 =?utf-8?B?N3Z0QnQ4ZUpwQ25KRnVIMUhxbnQwbmlPU21ZOGlpdjVwS0dQVENSMlFwTVVl?=
 =?utf-8?B?UDczclpNODhZb3k4V1VwVlZsb1NENGFNR1N1bWNQMGw5VGxkZGNtcXFCaVJw?=
 =?utf-8?B?OU5PWCtoNVVvWm1JUSs4MmVNV2ozQy9FRkh4dGZkc2FLMUlhVzdBWnM2bVVo?=
 =?utf-8?B?eG1jS0VuNmhYcDFQc0dkSWRNcFplMU9USStrYTFYU3lWMTY4UDFuQVplbXJY?=
 =?utf-8?B?NlU4c0U3SDJibnZTeWx3MHYyQmJnNHZLTTNCdi8vMmJnRTMrYnVhenVXeTM1?=
 =?utf-8?B?UzZ5Mk5yQXVFWjFMVkxlMFRwZFQwZmtVbmMxVzQwTzBQSFUraDBGZjhIc0l0?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53B26BBE9F96A448A47F1331620814AF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca87541-35ed-44cf-8091-08db23676924
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 02:05:25.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZGwe8R86f5amDWz07iTUhCSnIlUMoc7lBAuZ0IOnn4CbVcYh2rdVNtsBKil9MqjvOBVgfbrgmE/EWukiyYXAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6753
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTIxIGF0IDE2OjM0ICswODAwLCBaaGFuZyBSdWkgd3JvdGU6DQo+IEhp
LCBQZXRlciwNCj4gDQo+ID4gPiAtLS0NCj4gPiA+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3RvcG9s
b2d5LmMgfCA1ICsrKy0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5l
bC9jcHUvdG9wb2xvZ3kuYw0KPiA+ID4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3RvcG9sb2d5LmMN
Cj4gPiA+IGluZGV4IDVlODY4YjYyYTdjNC4uMDI3MDkyNWZlMDEzIDEwMDY0NA0KPiA+ID4gLS0t
IGEvYXJjaC94ODYva2VybmVsL2NwdS90b3BvbG9neS5jDQo+ID4gPiArKysgYi9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L3RvcG9sb2d5LmMNCj4gPiA+IEBAIC03OSw3ICs3OSw3IEBAIGludCBkZXRlY3Rf
ZXh0ZW5kZWRfdG9wb2xvZ3lfZWFybHkoc3RydWN0DQo+ID4gPiBjcHVpbmZvX3g4NiAqYykNCj4g
PiA+ICAJICogaW5pdGlhbCBhcGljIGlkLCB3aGljaCBhbHNvIHJlcHJlc2VudHMgMzItYml0IGV4
dGVuZGVkDQo+ID4gPiB4MmFwaWMgaWQuDQo+ID4gPiAgCSAqLw0KPiA+ID4gIAljLT5pbml0aWFs
X2FwaWNpZCA9IGVkeDsNCj4gPiA+IC0Jc21wX251bV9zaWJsaW5ncyA9IExFVkVMX01BWF9TSUJM
SU5HUyhlYngpOw0KPiA+ID4gKwlzbXBfbnVtX3NpYmxpbmdzID0gbWF4X3QoaW50LCBzbXBfbnVt
X3NpYmxpbmdzLA0KPiA+ID4gTEVWRUxfTUFYX1NJQkxJTkdTKGVieCkpOw0KPiA+ID4gICNlbmRp
Zg0KPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+ICB9DQo+ID4gPiBAQCAtMTA5LDcgKzEwOSw4IEBA
IGludCBkZXRlY3RfZXh0ZW5kZWRfdG9wb2xvZ3koc3RydWN0DQo+ID4gPiBjcHVpbmZvX3g4Ng0K
PiA+ID4gKmMpDQo+ID4gPiAgCSAqLw0KPiA+ID4gIAljcHVpZF9jb3VudChsZWFmLCBTTVRfTEVW
RUwsICZlYXgsICZlYngsICZlY3gsICZlZHgpOw0KPiA+ID4gIAljLT5pbml0aWFsX2FwaWNpZCA9
IGVkeDsNCj4gPiA+IC0JY29yZV9sZXZlbF9zaWJsaW5ncyA9IHNtcF9udW1fc2libGluZ3MgPQ0K
PiA+ID4gTEVWRUxfTUFYX1NJQkxJTkdTKGVieCk7DQo+ID4gPiArCWNvcmVfbGV2ZWxfc2libGlu
Z3MgPSBMRVZFTF9NQVhfU0lCTElOR1MoZWJ4KTsNCj4gPiA+ICsJc21wX251bV9zaWJsaW5ncyA9
IG1heF90KGludCwgc21wX251bV9zaWJsaW5ncywNCj4gPiA+IExFVkVMX01BWF9TSUJMSU5HUyhl
YngpKTsNCj4gPiA+ICAJY29yZV9wbHVzX21hc2tfd2lkdGggPSBodF9tYXNrX3dpZHRoID0NCj4g
PiA+IEJJVFNfU0hJRlRfTkVYVF9MRVZFTChlYXgpOw0KPiA+ID4gIAlkaWVfbGV2ZWxfc2libGlu
Z3MgPSBMRVZFTF9NQVhfU0lCTElOR1MoZWJ4KTsNCj4gPiA+ICAJcGtnX21hc2tfd2lkdGggPSBk
aWVfcGx1c19tYXNrX3dpZHRoID0NCj4gPiA+IEJJVFNfU0hJRlRfTkVYVF9MRVZFTChlYXgpOw0K
PiA+IA0KPiA+IFNlZW1zIG9rLCBidXQgcGVyaGFwcyB5b3UgY2FuIHN0aWNrIGFuICdpbnQnIGNh
c3QgaW4NCj4gPiBMRVZFTF9NQVhfU0lHTElOR1MgaW5zdGVhZCBhbmQgd3JpdGUgYSBzaW1wbGVy
IG1heCgpIC0tIGFuZC9vcg0KPiA+IGNvbnZlcnQNCj4gPiBzbXRfbnVtX3NpYmxpbmdzIHRvIHVu
c2lnbmVkIGludC4NCj4gPiANCj4geWVhaCwgaXQgaXMgZG9hYmxlLiBJJ2QgcHJlZmVyIHRvIHVz
ZSB0aGUgY3VycmVudCB2ZXJzaW9uIHRvIGtlZXANCj4gdGhpcw0KPiBmaXggc2ltcGxlciBpZiB5
b3UgZG9uJ3QgbWluZC4NCj4gDQo+ID4gUmVnYXJkbGVzcywNCj4gPiANCj4gPiBBY2tlZC1ieTog
UGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IA0KPiBUaGFu
a3MgZm9yIHlvdXIgQUNLLg0KDQpIaSwgYWxsLA0KDQpEZXNwaXRlIHRoZSBkaXNjdXNzaW9ucyBh
Ym91dCBmdXR1cmUgaW1wcm92ZW1lbnRzIGluIHRoZSBjb3ZlciBsZXR0ZXINCm9mIHRoaXMgcGF0
Y2ggc2VyaWVzLCBpcyB0aGVyZSBhbnkgZnVydGhlciBjaGFuZ2VzIG5lZWRlZCBmb3IgdGhpcyBv
bmU/DQoNCnRoYW5rcywNCnJ1aQ0K
