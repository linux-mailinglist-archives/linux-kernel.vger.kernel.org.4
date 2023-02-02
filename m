Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF1D687C56
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjBBLcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjBBLcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:32:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9093D8AC1C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675337524; x=1706873524;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZsJDbap0utNtPWYw23ZVTQJUdVPoX6Hb0ae9jiRpjK8=;
  b=Czvi+kz4Wg4gkW0WK2ht2gLiz4/1VbY2zi6CKtgx8q9soGBd4a34tK4H
   yw5Sut3WX66wcJgqNgYVK0DX6BFunVS0VHg5MvANi+H3+nFVkx4URQmvf
   VTV+UnM1zLyPgvjcGUo+Phe+pFWhAP/zJLPjGj43pRwP8velOF1A4Y1Bl
   19KQXdKs04rNopyl6FRPEYAyZk0boSdfa7rCh6YTRDvJbToPxaqs5Cbh3
   MFh+MmNOjMXMwbdrhxmadGXOsMspZy/EaFQsQn+o3tAkXiTqWuPwzqauh
   xzpbG1aF8iI6k8N0cHJOyxT/WCkZ28jTP4LJgyRLidHiywLCLKaNaD9w1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="327073665"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="327073665"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 03:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="773843386"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="773843386"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2023 03:32:03 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 03:32:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 03:32:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 03:32:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egCwkObzSKKgfYI3FbMk97yuIdlh8pzJchJT4hkKUhuvNSTIq0j0HcVwLlLg/K22QlqmrpjSIosVhndDqzOuqEbRzBdq4MgSV/39/bHbvDJYKv+NdBhufUe1p25WRbXJj9NVst5oMu8BiByttABLEe6ROASBx1KzoVYEf2oCzgyLhV/ogti38C3Jzc61MOvcJtuyE7sfIiScO6TZiidpkLduaTS9/EayCJct/3C2DX9g6Hdr5n75di9KyQ8x+7IhEoBJ3u3Bmx50lT9v9qn9OR1xmFJfPPIPi0SqSZgj1Ddt6IVw0+P3bGjzJn53AXaPudIVZLj9uNfH0X4l68fjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsJDbap0utNtPWYw23ZVTQJUdVPoX6Hb0ae9jiRpjK8=;
 b=ffLhIZGo9orn3+jwBFierYAsKJyk+majsQa0LddbbaABYdSkQW+9EYY7Z/Sdan6YLMmO9p1vbRuh5pbv3XazLR6Uk0R0WtqHBKKbS9ASyJuFCWX3H8pazl3Bq8jk6tRhgkify4cW8Jm3XMEaoXLzR4BNxtMCodnGcyPdqr4nd9H7h+ARuS9nqVpW8b2aOT/CgW+P7feP26DwvnB07hVSza5cGQcbchWeF1F5BXnFOECA/OjnWiHALQn5y6i6PtFEpmFF93mGUEsDmS2xTwD5xGd38L4G/6uVSw/DFnDulypO/Myo36gPB5eKZ6m5aOWYqllZR53x06SP2h5GXDV4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 IA1PR11MB6292.namprd11.prod.outlook.com (2603:10b6:208:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 11:31:56 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 11:31:56 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Christophe de Dinechin <dinechin@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwD7aSoAAC3pmnAAD22wgABWE1iw
Date:   Thu, 2 Feb 2023 11:31:55 +0000
Message-ID: <DM8PR11MB5750E9044F25A2C0A6EF6D27E7D69@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <m2pmaw5jv4.fsf@redhat.com>
 <DM8PR11MB57504761DE92CE1213549C27E7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
 <m2cz6uk3h9.fsf@redhat.com>
In-Reply-To: <m2cz6uk3h9.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|IA1PR11MB6292:EE_
x-ms-office365-filtering-correlation-id: aff4745d-a442-40be-85f8-08db051116cb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z4OlG8GPmMhBM2Ds56HGZI5C+dTnTCVkxH71TFy3c29/bxfuIeVB+q+H9xJ2OkBbt6i338ZXsGBB9MXauJTT6p0BPIerSajmxjKSOqvrX+Pb400t+yHTyFJ1OtcL6T7ZRFn7QzmQQTcvyBuAWIgLDJf7TOpOHJHG4fg6Dw79kmO+b/vKPadPBpM/DFX2qHwL+uSlr0xJ8aY98eFpxgP0mRcUgK6GB2PkLnTa+nhLwdDsc4R67dOtVBNwRi+nJs/QPviD6fOqQ3vSdDZmoddF0PkbLmLFgeZYtbuJmRZqRxi3OH15gtlpudVJFb4Flcur0vPOusb9yxkwA+b9rlX7ywPia8wUisb66SQlUUW5AqL9wTugkBG4eNBu9IFNvV69+xUFPwUT2zk0YyO4OwGKDlf24CKO8NeVymDujtVGrbN2zU7TYsHfQB1RQJk6r5C3gK4e0Rk3/CLdQ29UmYZMa4SOpCPB9aZ6CK3KgY/pAc5KwmFIFJ1//Zx8x7dpnFGaHo12m9PBy04KWgGCErXRpf1MtgRH7ZdHV7457FGBvzv1cKeSrk2wECOE2WgnNTWMgiKyr1rRf5iT47xPbtvGZ2dnkUDH3+I/ZNNQJaNwfuD4h3sof1AwKAU+iCoT7G4b0fZF6W1ubGdnsW0PAxsYdVK8wGmJgMg7BlvyE9syKSD8QmczxP4qjqE1AgT7mweyfP8SlKN8Vo4tjtnQ6qVn1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199018)(76116006)(8936002)(7696005)(71200400001)(478600001)(54906003)(186003)(26005)(33656002)(9686003)(6506007)(316002)(5660300002)(86362001)(7416002)(2906002)(52536014)(66446008)(4326008)(66946007)(6916009)(66476007)(64756008)(66556008)(8676002)(41300700001)(55016003)(83380400001)(38070700005)(38100700002)(122000001)(66899018)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enFKK3p1QTJKdzlZeitIZkFnblIwTUQwL3RMWDhIRmtzR3c2QVJBaXNVcWhv?=
 =?utf-8?B?RVBiTmZ3d1V3Z3M3SnJSWktFcHBGaGR2UEZXd1d0dnhwdEtkQVQ3V04vRTRm?=
 =?utf-8?B?aFFrUlV4Ynd0eEFpUVFQSm9adjMxQ29neDVPVk9FTWRaejVyZHRCY2hQakli?=
 =?utf-8?B?RkZ5RGZOTllWQkZuWWhheDIybnVUU1ZhSlFGdFBnSE5yMjVLcG1mbXhIRm1C?=
 =?utf-8?B?R1IwV09RMFFSUUpKOGNORThnSUpFd1Rta2pHbEpvZXZERC9rZjdxUzFrOHE1?=
 =?utf-8?B?QXJmMGdHSXhjY24wUjZtZ016eitXTDROV3VLZjhvMjRnRk1CcHBQendZNzIr?=
 =?utf-8?B?N1NQMUEwRlJqOFFWRnp0ZldGRjJBQ29ucThka0lNcTdJa2UzM0krUEVFL3Jz?=
 =?utf-8?B?YjZReDdWYXJuMkpzUE5zVmV6Q0RkWCtQRTc4cGJoM1R5MXdHL2lsVTlkei9C?=
 =?utf-8?B?d2pPU1Z4aDNiT1FQaGQ2OENPTTEwNnRBdlVka2xLWEdwNHBFaXp3cHo5dWVt?=
 =?utf-8?B?Smx5SWlvYlhKRjh5L21IZWU4cWVwaWtZUWV1dHB0dVpQQVk3cmxOL29oWENV?=
 =?utf-8?B?SDNTNWNwTDIydjFZRFVVc0lqMEc4S3FJamFxbjdxSFkwYUpOOTBaSnhnUHAr?=
 =?utf-8?B?ZmU4L0NMaitRWTJiMDQxMjdKZlgwdFlPZFFwV3J1R1dCUHRhZ1FWU3NzeTlp?=
 =?utf-8?B?TzlCS3M5RXVheHlnV2pBdGE5VHRvRWJrUjlKSUlPSllRRzJhZFoxenlVZU9s?=
 =?utf-8?B?OTBzYVQwaDVMcjU0NmlHbXpuRVpPNTBPL29RUGMvUk9tbmZZSG5tWndLT2JY?=
 =?utf-8?B?bzdNNUR5OW9CZkdvS0Z2M3lGNHk0K2REKzlDNWRHUmMwL2xmUHZLRS9PUTJE?=
 =?utf-8?B?TENTZnk4V3kwRThXVkx6VENCS04zRHRUclhNL09kSUVjMkZjeThyZlJTazlE?=
 =?utf-8?B?NzRsK3MzVm55SmU1RzArVjJvenN0L3JMR2czckNYdlA1S29tQWYxcjlQSSt2?=
 =?utf-8?B?ZlBMTVBzWWNPZCtZRnA3a2x4TjVjNGxrUWFjdmNxMGF2SDJ6ME1hRHRPM2tv?=
 =?utf-8?B?MmxWeWJOb01JZ2kyUW1BeWp2K2RMREZZcGgyMmdMOE9CeTlsMExwcnVSb1Fl?=
 =?utf-8?B?bC9MbVd5STNyeDJFWXJwVTJrc0xzUXJQanBqMnhOSm9jUFBUemppQWlPU2Vk?=
 =?utf-8?B?M2IzRlc1akFEM0l2SjA3eWNZUHdRa2tyQkFVTEdndUVQbmNtWnhhWmtTV2Ju?=
 =?utf-8?B?VTlnRFdCSFhpTDJxNGcyV2UxWFd2Tll2b2lYdTBVL01KakRyS0JxVXY5aStr?=
 =?utf-8?B?MXU1NFczK2NZZURmZmpseUpYZVB1Z1VUOEhUTXpINEVpVEt1L0h6bUVpd0J5?=
 =?utf-8?B?aDFDT3g1aUVSMTh6eUJDS01ZSFBsak04SGhja3hSNGc0YjFCY2RxbTEvMGVV?=
 =?utf-8?B?VlplaktuYXl2UEI5aGJTMHN6R0xwK0V0Y3grajViU0ZlSmZ2UWIydUh4M3JO?=
 =?utf-8?B?cXh5ZnZTWmNaSEt3aGxlc1RwZi9GU2Z2V3JEdnBQeFBhYkxWNGxjNXVrYTJu?=
 =?utf-8?B?YmprQW02YlowdXMzNFhRWlNUS1hRbVVnVGNTWkVFK2N2cGxFcURjN0ROeVl0?=
 =?utf-8?B?THkxa0p2ek1tUElNZDZtRnVzYzFjemVlRHgrN25GczF4dzFkeWJQZVpuTlJQ?=
 =?utf-8?B?bE5zcHhwWVZRV29PNGxNTjdqakNZY3daSGpLUXVpRm4zYXhqWWtwQ2lFQU1s?=
 =?utf-8?B?anJPTU54clBUTFVGUUdNQ3cvUXp5VzB5a3dQSWJIR0FPWHlnSDFxQUYxR1dJ?=
 =?utf-8?B?UkZPUFMwMjk4RFZlU1Biek5ISldSNk5mRThHMm5BR1ZOa05GaWhBd0FydWdn?=
 =?utf-8?B?akg1NlhCUkFFaUlaVjhTV2h1M2FmR2RjOHZjRnpMbXhFQlRVTTVjdDlQUjdV?=
 =?utf-8?B?TVNQbzZJZFZ5MGVhT3NSNGtPUUJxL2ZQYXZzWlAxTjFMbEl5c1VrbDh1ZVFN?=
 =?utf-8?B?VTUzdkY4RGgrd1Q2Skt1V0xZQVJsVEtGb1Y0WTcvYzd3UlhBQy9VcHMvdnI0?=
 =?utf-8?B?NkRYemZZbEpFU2dlYjJiWG5mYXJ5UExvRmxXSnIyOUJ4aVpoNzJiOUxhUXgw?=
 =?utf-8?Q?0GYA3yJ/0K87olwMYg9Ss7MbH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff4745d-a442-40be-85f8-08db051116cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 11:31:55.7764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mef1IPF2dNq+NtaLu3zAmJAXLQsYBDuPpNWdC7bUWpC7MQQyfgoQGH+6/t4MhGvIZc2I6Ku30EexTzULuBXeuo4AwZ6LDFc0/6QOzxl19c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6292
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDIwMjMtMDEtMzEgYXQgMTA6MDYgVVRDLCAiUmVzaGV0b3ZhLCBFbGVuYSIgPGVsZW5h
LnJlc2hldG92YUBpbnRlbC5jb20+DQo+IHdyb3RlLi4uDQo+ID4gSGkgRGluZWNoaW4sDQo+IA0K
PiBOaXQ6IE15IGZpcnN0IG5hbWUgaXMgYWN0dWFsbHkgQ2hyaXN0b3BoZSA7LSkNCg0KSSBhbSBz
b3JyeSwgbXkgYXV0b21hdGlvbiBvZiBleHRyYWN0aW5nIG5hbWVzIGZyb20gZW1haWxzIGZhaWxl
ZCBoZXJlICgoDQoNCj4gDQo+IFtzbmlwXQ0KPiANCj4gPj4gIlRoZSBpbXBsZW1lbnRhdGlvbiBv
ZiB0aGUgI1ZFIGhhbmRsZXIgaXMgc2ltcGxlIGFuZCBkb2VzIG5vdCByZXF1aXJlIGFuDQo+ID4+
IGluLWRlcHRoIHNlY3VyaXR5IGF1ZGl0IG9yIGZ1enppbmcgc2luY2UgaXQgaXMgbm90IHRoZSBh
Y3R1YWwgY29uc3VtZXIgb2YNCj4gPj4gdGhlIGhvc3QvVk1NIHN1cHBsaWVkIHVudHJ1c3RlZCBk
YXRhIjogVGhlIGFzc3VtcHRpb24gdGhlcmUgc2VlbXMgdG8gYmUNCj4gdGhhdA0KPiA+PiB0aGUg
aG9zdCB3aWxsIG5ldmVyIGJlIGFibGUgdG8gc3VwcGx5IGRhdGEgKGUuZy4gdGhyb3VnaCBhIGJv
dW5jZSBidWZmZXIpDQo+ID4+IHRoYXQgaXQgY2FuIHRyaWNrIHRoZSBndWVzdCBpbnRvIGV4ZWN1
dGluZy4gSWYgdGhhdCBpcyBpbmRlZWQgdGhlDQo+ID4+IGFzc3VtcHRpb24sIGl0IGlzIHdvcnRo
IG1lbnRpb25pbmcgZXhwbGljaXRseS4gSSBzdXNwZWN0IGl0IGlzIGEgYml0IHdlYWssDQo+ID4+
IHNpbmNlIG1hbnkgZWFybGllciBhdHRhY2tzIHdlcmUgYmFzZWQgb24gZXhlY3V0aW5nIHRoZSB3
cm9uZyBjb2RlLiBOb3RhYmx5LA0KPiA+PiBpdCBpcyB3b3J0aCBwb2ludGluZyBvdXQgdGhhdCBJ
L08gYnVmZmVycyBhcmUgX25vdF8gZW5jcnlwdGVkIHdpdGggdGhlIENQVQ0KPiA+PiBrZXkgKGFz
IG9wcG9zZWQgdG8gYW55IGRldmljZSBrZXkgZS5nLiBmb3IgUENJIGVuY3J5cHRpb24pIGluIGVp
dGhlcg0KPiA+PiBURFggb3IgU0VWLiBJcyB0aGVyZSBmb3IgZXhhbXBsZSBhbnl0aGluZyB0aGF0
IHByZWNsdWRlcyBURFggb3IgU0VWIGZyb20NCj4gPj4gZXhlY3V0aW5nIGNvZGUgaW4gdGhlIGJv
dW5jZSBidWZmZXJzPw0KPiA+DQo+ID4gVGhpcyB3YXMgYWxyZWFkeSByZXBsaWVkIGJ5IEtpcmls
bCwgYW55IGNvZGUgZXhlY3V0aW9uIG91dCBvZiBzaGFyZWQgbWVtb3J5DQo+IGdlbmVyYXRlcw0K
PiA+IGEgI0dQLg0KPiANCj4gQXBvbG9naWVzIGZvciBteSB3b3JkaW5nLiBFdmVyeW9uZSBpbnRl
cnByZXRlZCAiZXhlY3V0aW5nIiBhcyAiZXhlY3V0aW5nDQo+IGRpcmVjdGx5IG9uIHRoZSBib3Vu
Y2UgYnVmZmVyIHBhZ2UiLCB3aGVuIHdoYXQgSSBtZWFudCBpcyAiY29uc3VtaW5nIGRhdGENCj4g
ZmV0Y2hlZCBmcm9tIHRoZSBib3VuY2UgYnVmZmVycyBhcyBjb2RlIiAobm90IG5lY2Vzc2FyaWx5
IGRpcmVjdGx5KS4NCg0KSSBndWVzcyBpbiB0aGVvcnkgaXQgaXMgcG9zc2libGUsIGJ1dCB3ZSBo
YXZlIG5vdCBzZWVuIHN1Y2ggdXNhZ2VzIGluIGd1ZXN0IGtlcm5lbCBjb2RlDQppbiBwcmFjdGlj
ZSBkdXJpbmcgb3VyIGF1ZGl0LiBUaGlzIHdvdWxkIGJlIHByZXR0eSB1Z2x5IHRoaW5nIHRvIGRv
IGltbyBldmVuIGlmDQp5b3UgZm9yZ2V0IGFib3V0IGNvbmZpZGVudGlhbCBjb21wdXRpbmcuIA0K
DQoNCj4gDQo+IEZvciBleGFtcGxlLCBpbiB0aGUgZGlhZ3JhbSBpbiB5b3VyIGRvY3VtZW50LCB0
aGUgZ3Vlc3Qga2VybmVsIGlzIGENCj4gbW9ub2xpdGhpYyBwaWVjZS4gSW4gcmVhbGl0eSwgdGhl
cmUgYXJlIGR5bmFtaWNhbGx5IGxvYWRlZCBjb21wb25lbnRzLiBJbg0KPiB0aGUgb3JpZ2luYWwg
U0VWIGltcGxlbWVudGF0aW9uLCB3aXRoIHByZS1hdHRlc3RhdGlvbiwgdGhlIG1lYXN1cmVtZW50
IGNvdWxkDQo+IG9ubHkgYXBwbHkgYmVmb3JlIGxvYWRpbmcgYW55IERMS00gKEkgYmVsaWV2ZSwg
bm90IHJlYWxseSBzdXJlKS4gQXMgYW5vdGhlcg0KPiBleGFtcGxlLCBTRVZlcml0eSAoQ1ZFLTIw
MjAtMTI5NjcgWzFdKSB3b3JrZWQgYnkgaW5qZWN0aW5nIGEgcGF5bG9hZA0KPiBkaXJlY3RseSBp
bnRvIHRoZSBndWVzdCBrZXJuZWwgdXNpbmcgdmlydGlvLWJhc2VkIG5ldHdvcmsgSS9PLiBUaGF0
IGlzIHdoYXQNCj4gSSByZWZlcnJlZCB0byB3aGVuIEkgd3JvdGUgIm1hbnkgZWFybGllciBhdHRh
Y2tzIHdlcmUgYmFzZWQgb24gZXhlY3V0aW5nIHRoZQ0KPiB3cm9uZyBjb2RlIi4NCg0KVGhlIGFi
b3ZlIGF0dGFjayB3YXMgb25seSBwb3NzaWJsZSBiZWNhdXNlIGFuIGF0dGFja2VyIHdhcyBhYmxl
IHRvIGRpcmVjdGx5DQptb2RpZnkgdGhlIGNvZGUgZXhlY3V0aW9uIHBvaW50ZXIgdG8gYW4gYXJi
aXRyYXJ5IGd1ZXN0IG1lbW9yeSBhZGRyZXNzDQooaW4gdGhhdCBjYXNlIGd1ZXN0IE5NSSBoYW5k
bGVyIHdhcyBzdWJzdGl0dXRlZCBwb2ludGluZyB0byBhdHRhY2tlciBwYXlsb2FkKS4NClRoaXMg
aXMgYW4gb2J2aW91cyBob2xlIGluIHRoZSBpbnRlZ3JpdHkgcHJvdGVjdGlvbiBvZiB0aGUgZ3Vl
c3QgcHJpdmF0ZSBtZW1vcnkNCmFuZCBpdHMgcGFnZSB0YWJsZSBtYXBwaW5ncy4gVGhpcyBpcyBu
b3QgcG9zc2libGUgd2l0aCBURFggYW5kIEkgYmVsaWV2ZSB3aXRoDQpuZXcgdmVyc2lvbnMgb2Yg
QU1EIFNFViBhbHNvLiANCg0KPiANCj4gVGhlIGZhY3QgdGhhdCBJL08gYnVmZmVycyBhcmUgbm90
IGVuY3J5cHRlZCBtYXR0ZXJzIGhlcmUsIGJlY2F1c2UgaXQgZ2l2ZXMNCj4gdGhlIGhvc3QgYW1w
bGUgbGF0aXR1ZGUgdG8gb2JzZXJ2ZSBvciBldmVuIGNvcnJ1cHQgYWxsIEkvT3MsIGFzIG1hbnkg
b3RoZXJzDQo+IGhhdmUgcG9pbnRlZCBvdXQuIE5vdGFibHksIGRpc2sgY3J5cHRvIG1heSBub3Qg
YmUgZGVzaWduZWQgdG8gcmVzaXN0IHRvIGENCj4gaG9zdCB0aGF0IGNhbiBzZWUgYW5kIHBvc3Np
Ymx5IGNoYW5nZSB0aGUgSS9Pcy4NCj4gDQo+IFNvIGxldCBtZSByZXBocmFzZSBteSB2YWd1ZSBx
dWVzdGlvbiBhcyBhIGZldyBtb3JlIHByZWNpc2Ugb25lczoNCj4gDQo+IDEpIFdoYXQgYXJlIHRo
ZSBlZmZlY3RzIG9mIHNlbWktcmFuZG9tIGtlcm5lbCBjb2RlIGluamVjdGlvbj8NCj4gDQo+ICAg
IElmIHRoZSBob3N0IGtub3dzIHRoYXQgYSBnaXZlbiBib3VuY2UgYnVmZmVyIGhhcHBlbnMgdG8g
YmUgdXNlZCBsYXRlciB0bw0KPiAgICBleGVjdXRlIHNvbWUga2VybmVsIGNvZGUsIGl0IGNhbiBz
dGFydCBmbGlwcGluZyBiaXRzIGluIGl0IHRvIHRyeSBhbmQNCj4gICAgdHJpZ2dlciBhcmJpdHJh
cnkgY29kZSBwYXRocyBpbiB0aGUgZ3Vlc3QuIE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdA0KPiAg
ICBjcnlwdG8gYWxvbmUgKGkuZS4gd2l0aG91dCBhZGRpdGlvbmFsIGxheWVycyBsaWtlIGRtLWlu
dGVncml0eSkgd2lsbA0KPiAgICBoYXBwaWx5IGRlY3J5cHQgdGhhdCBpbnRvIGEgY29kZSBzdHJl
YW0gd2l0aCBwc2V1ZG8tcmFuZG9tIGluc3RydWN0aW9ucw0KPiAgICBpbiBpdCwgbm90IHZlaGVt
ZW50bHkgZXJyb3Igb3V0Lg0KPiANCj4gICAgU28sIHdoaWxlIFREWCBwcmVjbHVkZXMgdGhlIGhv
c3QgZnJvbSB3cml0aW5nIGludG8gZ3Vlc3QgbWVtb3J5IGRpcmVjdGx5LA0KPiAgICBzaW5jZSB0
aGUgYm91bmNlIGJ1ZmZlcnMgYXJlIHNoYXJlZCwgVERYIHdpbGwgbm90IHByZXZlbnQgdGhlIGhv
c3QgZnJvbQ0KPiAgICBmbGlwcGluZyBiaXRzIHRoZXJlLiBJdCdzIHRoZW4ganVzdCBhIG1hdHRl
ciBvZiBndWVzc2luZyB3aGVyZSB0aGUgYml0cw0KPiAgICB3aWxsIGdvLCBhbmQgaG9waW5nIHRo
YXQgc29tZSBiaXRzIGV4ZWN1dGUgYXQgZ3Vlc3QgUEwwLiBPZiBjb3Vyc2UsIHRoaXMNCj4gICAg
Y2FuIGJlIG1pdGlnYXRlZCBieSBlaXRoZXIgb25seSB1c2luZyBzdGF0aWMgY29uZmlncywgb3Ig
dXNpbmcNCj4gICAgZG0tdmVyaXR5L2RtLWludGVncml0eSwgb3IgbWF5YmUgc29tZSBvdGhlciBt
ZWNoYW5pc21zLg0KPiANCj4gICAgU2hvdWxkbid0IHRoYXQgYmUgcGFydCBvZiB5b3VyIGRvY3Vt
ZW50PyAgVG8gYmUgY2xlYXI6IHlvdSBtZW50aW9uIHVuZGVyDQo+ICAgICJTdG9yYWdlIHByb3Rl
Y3Rpb24iIHRoYXQgeW91IHVzZSBkbS1jcnlwdCBhbmQgZG0taW50ZWdyaXR5LCBzbyBJIGJlbGll
dmUNCj4gICAgKnlvdSoga25vdywgYnV0IHlvdXIgcmVhZGVycyBtYXkgbm90IGZpZ3VyZSBvdXQg
d2h5IGRtLWludGVncml0eSBpcw0KPiAgICBpbnRlZ3JhbCB0byB0aGUgcHJvY2Vzcywgbm90YWJs
eSBhZnRlciB5b3Ugd3JpdGUgIlVzZXJzIGNvdWxkIHVzZSBvdGhlcg0KPiAgICBlbmNyeXB0aW9u
IHNjaGVtZXMiLg0KDQpTdXJlLCBJIGNhbiBlbGFib3JhdGUgaW4gdGhlIHN0b3JhZ2UgcHJvdGVj
dGlvbiBzZWN0aW9uIGFib3V0IHRoZSBpbXBvcnRhbmNlDQpvZiBkaXNrIGludGVncml0eSBwcm90
ZWN0aW9uLiANCg0KPiANCj4gMikgV2hhdCBhcmUgdGhlIGVmZmVjdHMgb2YgcmFuZG9tIHVzZXIg
Y29kZSBpbmplY3Rpb24/DQo+IA0KPiAgICBJdCdzIHRoZSBzYW1lIGFzIGFib3ZlLCBleGNlcHQg
dGhhdCBub3cgeW91IGNhbiB0YXJnZXQgYSBtdWNoIHdpZGVyIHJhbmdlDQo+ICAgIG9mIGlucHV0
IGRhdGEsIGluY2x1ZGluZyBzaGVsbCBzY3JpcHRzLCBldGMuIFNvIHRoZSBhdHRhY2sgc3VyZmFj
ZSBpcw0KPiAgICBtdWNoIGxhcmdlci4NCj4gDQo+IDMpIFdoYXQgaXMgdGhlIGVmZmVjdCBvZiBk
YXRhIHBvaXNvbmluZz8NCj4gDQo+ICAgIFlvdSBkb24ndCBuZWNlc3NhcmlseSBuZWVkIHRvIGNv
cnJ1cHQgY29kZS4gQmVpbmcgYWJsZSB0byBjb3JydXB0IGENCj4gICAgc3lzdGVtIGNvbmZpZ3Vy
YXRpb24gZmlsZSBmb3IgZXhhbXBsZSBjYW4gYmUgbGFyZ2VseSBzdWZmaWNpZW50Lg0KPiANCj4g
NCkgQXJlIHRoZXJlIEkvTy1iYXNlZCByZXBsYXkgYXR0YWNrcyB0aGF0IHdvdWxkIHdvcmsgcHJl
LWF0dGVzdGF0aW9uPw0KPiANCj4gICAgTXkgY3VycmVudCBtZW50YWwgbW9kZWwgaXMgdGhhdCB5
b3UgbG9hZCBhICJiYXNlIiBzb2Z0d2FyZSBzdGFjayBpbnRvIHRoZQ0KPiAgICBUQ0IgYW5kIHRo
ZW4gbWVhc3VyZSBhIHJlbGV2YW50IHBhcnQgb2YgaXQuIFdoYXQgeW91IG1lYXN1cmUgaXMgc29t
ZXdoYXQNCj4gICAgaW1wbGVtZW50YXRpb24tZGVwZW5kZW50LCBidXQgaW4gdGhlIGVuZCwgaWYg
dGhlIHN5c3RlbSBpcyBhdHRlc3RlZCwgeW91DQo+ICAgIHJlc3BvbmQgdG8gYSBjcnlwdG9ncmFw
aGljIGNoYWxsZW5nZSBiYXNlZCBvbiB3aGF0IHdhcyBtZWFzdXJlZCwgYW5kIHlvdQ0KPiAgICB0
aGVuIGdldCByZWxldmFudCBzZWNyZXRzLCBlLmcuIGEgZGlzayBkZWNyeXB0aW9uIGtleSwgdGhh
dCBsZXQgeW91IG1ha2UNCj4gICAgZm9yd2FyZCBwcm9ncmVzcy4gSG93ZXZlciwgd2hhdCBoYXBw
ZW5zIGlmIGV2ZXJ5IHRpbWUgeW91IGJvb3QsIHRoZSBob3N0DQo+ICAgIGZlZWRzIHlvdSBib2d1
cyBkaXNrIGRhdGEganVzdCB0byB0cnkgdG8gc3RlZXIgdGhlIGJvb3Qgc2VxdWVuY2UgYWxvbmcN
Cj4gICAgc29tZSBzcGVjaWZpYyBwYXRoPw0KDQpXaGF0IHlvdSBpZGVhbGx5IHdhbnQgaXMgYSBm
dWxsIGRpc2sgZW5jcnlwdGlvbiB3aXRoIGFkZGl0aW9uYWwgaW50ZWdyaXR5IHByb3RlY3Rpb24s
IA0KbGlrZSBhZXMtZ2NtIGF1dGhlbnRpY2F0ZWQgZW5jcnlwdGlvbiBtb2RlLiBUaGVuIHRoZXJl
IGFyZSBubyBxdWVzdGlvbnMgb24gdGhlDQpkaXNrIGludGVncml0eSBhbmQgbWFueSBhdHRhY2tz
IGFyZSBtaXRpZ2F0ZWQuIA0KDQo+IA0KPiAgICBJIGJlbGlldmUgdGhhdCB0aGUgc2hvcnQgYW5z
d2VyIGlzOiB0aGUgZ3Vlc3QgZWl0aGVyOg0KPiANCj4gICAgYSkgcmVhY2hlcyBhdHRlc3RhdGlv
biwgYnV0IHdpdGggYmFkIGluLW1lbW9yeSBkYXRhLCBzbyBpdCBmYWlscyB0aGUNCj4gICAgICAg
Y3J5cHRvIGV4Y2hhbmdlLCBhbmQgc2VjcmV0cyBhcmUgbm90IGxlYWtlZC4NCj4gDQo+ICAgIGIp
IGRvZXMgbm90IHJlYWNoIGF0dGVzdGF0aW9uLCBzbyBuZXZlciBnZXRzIHRoZSBzZWNyZXRzLCBh
bmQgdGhlcmVmb3JlDQo+ICAgICAgIHN0aWxsIGZ1bGZpbHMgdGhlIENDIHByb21pc2Ugb2Ygbm90
IGxlYWtpbmcgc2VjcmV0cy4NCj4gDQo+ICAgIFNvIEkgcGVyc29uYWxseSBmZWVsIHRoaXMgaXMg
T0ssIGJ1dCBpdCdzIHdvcnRoIHdyaXRpbmcgdXAgaW4geW91ciBkb2MuDQo+IA0KDQpZZXMsIEkg
d2lsbCBleHBhbmQgdGhlIHN0b3JhZ2Ugc2VjdGlvbiBtb3JlIG9uIHRoaXMuIA0KDQo+IA0KPiBC
YWNrIHRvIHRoZSAjVkUgaGFuZGxlciwgaWYgSSBjYW4gZmluZCBhIHdheSB0byBpbmplY3QgbWFs
aWNpb3VzIGNvZGUgaW50bw0KPiBteSBndWVzdCwgd2hhdCB5b3Ugd3JvdGUgaW4gdGhhdCBwYXJh
Z3JhcGggYXMgYSBqdXN0aWZpY2F0aW9uIGZvciBubw0KPiBpbi1kZXB0aCBzZWN1cml0eSBzdGls
bCBzZWVtcyBsaWtlICJub3QgZXhhY3RseSBkZWZlbnNlIGluIGRlcHRoIi4gSSB3b3VsZA0KPiBq
dXN0IHJlbW92ZSB0aGUgc2VudGVuY2UsIGF1ZGl0IGFuZCBmdXp6IHRoYXQgY29kZSB3aXRoIHRo
ZSBzYW1lIGVuZXJneSBhcw0KPiBmb3IgYW55dGhpbmcgZWxzZSB0aGF0IGNvdWxkIGZhY2UgYmFk
IGlucHV0Lg0KDQpJbiBmYWN0IG1vc3Qgb2Ygb3VyIGZ1enppbmcgaG9va3MgYXJlIGluc2lkZSAj
VkUgaXRzZWxmIGlmIHlvdSB0YWtlIGEgbG9vayBvbiB0aGUNCmltcGxlbWVudGF0aW9uLiBUaGV5
IGp1c3QgZG9u4oCZdCBjb3ZlciB0aGluZ3MgbGlrZSB0aGUgI1ZFIGluZm8gZGVjb2RpbmcgKGlu
Zm9ybWF0aW9uDQppcyBwcm92aWRlZCBieSBhIHRydXN0ZWQgcGFydHkgLSBURFggbW9kdWxlKS4g
DQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hLg0K
