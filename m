Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F06664FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjAKUq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 15:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjAKUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:46:51 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9232C2DC5;
        Wed, 11 Jan 2023 12:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673470008; x=1705006008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VRBQrMehJVMgtTXC746n6KTlyqjlq2u7DUg27ImfvdA=;
  b=f4BQxBgaQBVG6aw97853Prs6f2imgVn9DX8XbfygmPlaV0OSPaRsfUdE
   WlJs5tIL21WqhIfg9WBEUt3ALfijqLfTao+xlS8PlmC8I01McD+4g/2T0
   J8MxDmQhfXpPJGEG2q96tkFKubMG/2Ou5Hc46yscoKCo5CclZqHNlaL7B
   MO/3mUD6/fog+DdIR6GtvndVH3M45JCRcXvsEq0+YZcbV5vFLWoCOCmKN
   QKf7qA67JW+s68/ihxB1TUJfRn3ejuSy4meiFPZUsmQhpfYR37UxeEexJ
   uOKIxb9QtwkY1Q6KQ+pQIJzTEXDLUnbMYIW5kSMGLOhDgpwRmKe/NE8fN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="311351734"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="311351734"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 12:46:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="688073688"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="688073688"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 11 Jan 2023 12:46:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 12:46:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 12:46:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 12:46:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kxj7DesgC+uYXLGNtDVsPEMy1OW6PEmdbNofdySPmMC9xGE5m2jReybyQCEuoIGYqDBTadeIcM6eIsVXJ+xhbBf54gXeCyQbIKIRY1wq6RB7CFdw0VwOH+Dqp8FrElrDRNzHEOwQJy+7+5t07be02/TQ/aDVF/hyBvsr1s6w531f+YWhrFMCUJXBtIr1o2ZLPN+2VxCSasROsEs+rSq+2yKo8CB/GqxYe0oHQIMnY+OGcRtxSthHUu/blLeBcGTL3CXwMRaYeMV7ufh1YQRKEE/WUW3dY2mv6QBbFHVdUIpON2cOt0wOerPoV1dcS/IH48YH5HOaFDZmiJ4g5HdS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRBQrMehJVMgtTXC746n6KTlyqjlq2u7DUg27ImfvdA=;
 b=F7OnCEzx3nN8ZiGmhPrVaB1kdcQjbn/wogMrYJveQ/GQWSDA4j247W7l7HRxqDUn5Lo4ZfkKzCBnB4/UfPn/POt02AqR1cxqB7/xjaGtdrleuCunbyGfvVS2i+l46Cen+bSvZHKrGxf2WxQMy3VCxiZHDmJY9VektDbrQSB4XLr+rBQ38IeK345hY/fF9VSUNK+CSS7y5osUtUVjw/un4a0KYEDNqeq2Dw84YmHBbP32HYORTHF+m8oPy45kqSkFl4e+VcoWy37T04AknAU3D91uhvOj/grLGsdFGih1nNafdkYS2BPrANAzMoJKqmVDhmNCr9dSVIIv1ndffJlXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA1PR11MB6806.namprd11.prod.outlook.com (2603:10b6:806:24d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 20:46:38 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 20:46:38 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH v2] x86/hibernate: Use fixmap for saving unmapped pages
Thread-Topic: [PATCH v2] x86/hibernate: Use fixmap for saving unmapped pages
Thread-Index: AQHZJTksM0Lkm+QZIUqyvtSWxlR3AK6Zrh4AgAADCIA=
Date:   Wed, 11 Jan 2023 20:46:38 +0000
Message-ID: <cd2a9ccec0d88821fb0c7580f7ae934f2de71ddf.camel@intel.com>
References: <20230110211839.19572-1-rick.p.edgecombe@intel.com>
         <CAJZ5v0jnp3jLdD1wN1NjMfxrt+gYZ+im_quHdgsOrWve0XQaWg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jnp3jLdD1wN1NjMfxrt+gYZ+im_quHdgsOrWve0XQaWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA1PR11MB6806:EE_
x-ms-office365-filtering-correlation-id: dc529d41-56ca-45da-b996-08daf414efa4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y1p2oroWIKX3vZAfXoAqGFNLnnAQ5SlrHabNigb0EQ3ivYsNR+CA0XxbOZ8jOttjgFE+vPLYtWRYfAA+Sqj9MmcVEszQ2xSukpOYw7y6+jr7yJLiB6z5wV5iitZh11746bOu3dZPibFqC723zi2psVWleqAGc9GAhYB0mlRvJVYOtwv2zH6I9fKX2wcFniuwVAwpEu3zg6WFbxE+aYWHy0D6ZTuPkrvzGOfgicyJe8Q+vKV4zavKPHiZb4vHp0KX0E6+vOVB/Uy5dTGayYEfnJ0FZCYd+6mJ5fGPvdVAVc6ORRteGgRkZBhuQqTWx382jBuOdhiZEBRnrqDtR4NZNt8ETOOp2aNfyFyXy/ev1jVumcVKZWyRHGin14dml2P6bNCjxyM6N7+/doY4riqUOFSUVkAHIxY9GIjC44Zwrd3x7aKZLlUTcEeS5HPAGXbWVk2BB9tXCzQ58/ED0UcOV5a/Nub/wYcqKBviPQLnjtQVguNNfAt2JSIiHvGMuHvB1fqW/+ISDyBVYCRHkYjU9iEmfiZA4zdvrruyv5irdcTFYSN+r7+dXrxrRML3Y8eusxrUyodrllr781nc0FA/FieIFwJiWL+SdcCOxkeHGLhL2ZWK2CtWsJ/jMd+PK7nDZgBTgoG0dLexszgHtLPwy1OBIJmAG4gpwiJiCs6+QmJIZr/q9oN7JRyV1Cw41F5t486Nk/FzJOqTOTEXEhfNma5gf8gH8ZAHMOIFu6VIDJUOnlZVpolaBNqfaL9wueXw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(6512007)(82960400001)(5660300002)(26005)(186003)(8936002)(38100700002)(6486002)(8676002)(478600001)(83380400001)(38070700005)(966005)(2906002)(2616005)(54906003)(316002)(64756008)(66556008)(66476007)(66946007)(7416002)(66446008)(6916009)(71200400001)(4326008)(76116006)(41300700001)(6506007)(36756003)(86362001)(53546011)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bCtDNFNGazdxd1p1azdOaTRVM3lkU2hKNlFJdHNyVDhBUGdJVXo2cFN4bEhM?=
 =?utf-8?B?R29mSkVkNGwzMjh4U1V4b1RsVitzQS8vaXplTzRMSjdwcE1RUTZBYll3UUxL?=
 =?utf-8?B?Ti9VeDhCS0VGdFZRVWtkQ0F0WUU3N2JBMVlRa0d1TnF0R1Rmc3l0TUtlM1NX?=
 =?utf-8?B?OEt2MlFaYlVtOXVjdWo3ZTBOcExhM1dFUWczZ255Z01RT2dnWmtvSm12VXp0?=
 =?utf-8?B?SU9jRjUwdE5lcVRtWm84eHJKa0dndXRhTmFGTytqbU12Z2wvZFFZcHQraEM1?=
 =?utf-8?B?Ylc5T0xnWHIxWStuMHhlbzQzUVlmTURRai9zU29LSmVnUUF5bngySW83cEll?=
 =?utf-8?B?d1BZSHFZVHFqRGEvcDh4dWVzRzR2L3NybFl2Sytxa0ZrRGdqci96Rzl5c1Vy?=
 =?utf-8?B?RG9TdU1CUnMxMUFiWkZYQzRsbCtxWWw0LzUzVUU4WEdUTHlOVDMyWkRpV3lI?=
 =?utf-8?B?cVNCZVppSE1VNzdhbXRyeU44RkVDd2E5YUpWemRWdzRiOWI0TnBodmVhb3c2?=
 =?utf-8?B?VnNiKys3VGhxYmthUkRLaW5vWmtNOEptN09WWjlpOVpwM1Z1V1E1YkNBZVc1?=
 =?utf-8?B?YTZLZDZsRkh3bklEQXFUemV2QnlGZ2RObVNDVnJocVpEUkxwRk5hTzVNdUJt?=
 =?utf-8?B?amN1VDhFSUt2YkNnUjRKdGwyOW5WalJsU0pqNkk3YUduelJ6eWNOUUNNSU5C?=
 =?utf-8?B?YWkwR053cnM0L0ErVnNwMGtpR0N3L2dUYjkvVGpETzQxMmdwR0x0QmFCSmli?=
 =?utf-8?B?MXdRd0RIVFhObHhKdVlsM0QwRzdGdU80Tko4SEJZd0o2NUx1Z1BLS2NqemhQ?=
 =?utf-8?B?bDR1WFNHdUNrWWw0WmQ2QUVBZjZ1Q1BpOFJhekZLS0gxZHNIWHFGdENvdFBE?=
 =?utf-8?B?K3p5ZjQ0Tm96dkU2K0c1SmlLR2RsOGdGNFNWMTRVbEV0eXR3ZGdxYjlLT1Ry?=
 =?utf-8?B?dmZLMzdBSFp1bFVER1FIM1ZkZHZXeTZoMTVMR0xCbkR3T2tGbG00dHUyZFh5?=
 =?utf-8?B?S2h5bE5aSHBKc1FFVkRGQUhUYkt1ZW5ncWVWRDBOMU55cVE4N2RFOGhWakNR?=
 =?utf-8?B?NStqS3hKamJXN3JKVVc4enh5YysrK3F5TngyUEc5aXVRK09xWXFrWnVIcnZh?=
 =?utf-8?B?a0YxSTZJL2tOUlJET2RrTVQ0Z2lPZHk1YnR0eGQyRENFVUxvUUgzT2RGR0o4?=
 =?utf-8?B?Zk5kOWhMZmlmRmgydDRjTzMzNi9lSXFWa25lSXZDQ3RrWXBhZU1LTTRTSm5K?=
 =?utf-8?B?enhQUVdTTkZUYUhWTlZ1biswV1Q4bnFhQjhZaHpNMzFrb0oyOEVKUnBuWmVJ?=
 =?utf-8?B?Q0Ywam13cXpIbGtIc3RCVDRRdUgxU01XRHMrYXhMV0JxNjBDUXpZVkptVVUv?=
 =?utf-8?B?Rm1YYzZkN0ErVk1Icmo1bWFDRUxBR2s2SytKWFNsbG0xbnZOMHJiV2FEZHZl?=
 =?utf-8?B?enBobkg4TEVoandlUTVpTEwrSzRQUHdCUXJoV09kWWtISDhmZDNmeFFDdmFa?=
 =?utf-8?B?Q20zZTFXbTUxQktzbXVaL0hySlpJM2RoZUZOaUhzNCsvMWQ0Rng4cFdsTjls?=
 =?utf-8?B?MW9FS2xtVlNFUnlwQ2xzWW14SFhEcG8zK2hpdTRxdTcvcGVzaW0rZzBpTVFU?=
 =?utf-8?B?Wm5TWWpjZDdQV1VqQndOYTlzckJRaXNXNDc2aXFaUUM3eS9sSk9xdSs1anhX?=
 =?utf-8?B?UzFOakJTU1lHWms4NUZzcUdDa2o5Y0V6OGRKMU1xN0hsZ3JTWk41bFJNdVND?=
 =?utf-8?B?MWxVN2NPSmw4V1gwNVpJb1hEcmgwdmxHUFhXaVpXRVYrY1luRUlmMW9nQXVi?=
 =?utf-8?B?NVduYUxJK0RUcFU4NytMSzI0czR1d29ZT1B4dTVOSVg2OWM5akRkVGFEN21V?=
 =?utf-8?B?djV5aDZ0dnROQUdIVEZvcEJnRklySW1iNjZuWHlJU3BRMkVLUytKNC82YlBG?=
 =?utf-8?B?djBveVJDdUU2MFNtSUZXSHJUTkltaE5zNjJpVDI2OEFOeDZ5bjI4L3FuSGNH?=
 =?utf-8?B?ekZCSjZFN3Y5b1ovWUpNWTlVbWhWbHFLeGNwWUwrUDYzbWxwT0ZnUXk5YkxY?=
 =?utf-8?B?MkdIMkxEbHhIMytzSCtzUU5XbEJqZzc5Q2dZQXJ5dWttQlUrOVNObEhJSENv?=
 =?utf-8?B?eXozS01BNHlxcUZ1d01EcDZnTXc1UmM2aHg0cW82RjF0K1l6SU81ZVlEYTJz?=
 =?utf-8?Q?g7QLoymaQe5j90YtjuS8CZ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1E293509B24634DB7E9E3BDD97A54B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc529d41-56ca-45da-b996-08daf414efa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 20:46:38.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqCUIqGcxuND/s86KHRD2UShpFo5NTLg2Ezp1GfLBa5kJrX2aEpfgXzwodUuOV7HwUImjc7uBnxSGS7yH+dqYfdtbwb/bmblU8o5b7Ck4h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6806
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTExIGF0IDIxOjM1ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVHVlLCBKYW4gMTAsIDIwMjMgYXQgMTA6MTkgUE0gUmljayBFZGdlY29tYmUNCj4g
PHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBIaWJlcm5hdGUg
dXNlcyB0aGUgZGlyZWN0IG1hcCB0byByZWFkIG1lbW9yeSBpdCBzYXZlcyB0byBkaXNrLg0KPiA+
IFNpbmNlDQo+ID4gc29tZXRpbWVzIHBhZ2VzIGFyZSBub3QgYWNjZXNzaWJsZSBvbiB0aGUgZGly
ZWN0IG1hcCAoIm5vdCBwcmVzZW50Ig0KPiA+IG9uDQo+ID4geDg2KSwgaXQgaGFzIHNwZWNpYWwg
Y2FzZSBsb2dpYyB0byB0ZW1wb3JhcmlseSBtYWtlIGEgcGFnZSBwcmVzZW50Lg0KPiA+IE9uIHg4
Ng0KPiA+IHRoZXNlIGRpcmVjdCBtYXAgYWRkcmVzc2VzIGNhbiBiZSBtYXBwZWQgYXQgdmFyaW91
cyBwYWdlIHNpemVzLCBidXQNCj4gPiB0aGUNCj4gPiBsb2dpYyB3b3JrcyBvayBhcyBsb25nIGFz
IHRoZSBub3QgcHJlc2VudCBwYWdlcyBhcmUgYWx3YXlzIG1hcHBlZA0KPiA+IGFzDQo+ID4gUEFH
RV9TSVpFIHN1Y2ggdGhhdCB0aGV5IGRvbid0IHJlcXVpcmUgYSBzcGxpdCB0byBtYXAgdGhlIHJl
Z2lvbiBhcw0KPiA+IHByZXNlbnQuIElmIHRoZSBhZGRyZXNzIHdhcyBtYXBwZWQgbm90IHByZXNl
bnQgYnkgYSBsYXJnZXIgcGFnZQ0KPiA+IHNpemUsIHRoZQ0KPiA+IHNwbGl0IG1heSBmYWlsIGFu
ZCBoaWJlcm5hdGUgd291bGQgdGhlbiB0cnkgdG8gcmVhZCBhbiBhZGRyZXNzDQo+ID4gbWFwcGVk
IG5vdA0KPiA+IHByZXNlbnQuDQo+ID4gDQo+ID4gVG9kYXkgb24geDg2IHRoZXJlIGFyZSBubyBr
bm93biBjYXNlcyBvZiB0aGlzIChodWdlIG5vdCBwcmVzZW50DQo+ID4gcGFnZXMgb24NCj4gPiB0
aGUgZGlyZWN0IG1hcCksIGJ1dCBpdCBoYXMgY29tZSB1cCBmcm9tIHRpbWUgdG8gdGltZSB3aGVu
DQo+ID4gZGV2ZWxvcGluZw0KPiA+IHRoaW5ncyB0aGF0IG9wZXJhdGUgb24gdGhlIGRpcmVjdCBt
YXAuIEl0IGJsb2NrZWQgbWFraW5nDQo+ID4gVk1fRkxVU0hfUkVTRVRfUEVSTVMgc3VwcG9ydCBo
dWdlIHZtYWxsb2Mgd2hlbiB0aGF0IGNhbWUgdXAsIGFuZA0KPiA+IGFsc28NCj4gPiBoYXMgYmVl
biBhIGNvbXBsaWNhdGlvbiBmb3IgdmFyaW91cyBkaXJlY3QgbWFwIHByb3RlY3Rpb24gZWZmb3J0
cy4NCj4gPiANCj4gPiBUaGlzIGRlcGVuZGVuY3kgaXMgYWxzbyBwcmV0dHkgaGlkZGVuIGFuZCBl
YXNpbHkgbWlzc2VkIGJ5IHBlb3BsZQ0KPiA+IHBva2luZyBhdA0KPiA+IHRoZSBkaXJlY3QgbWFw
LiBGb3IgdGhpcyByZWFzb24sIHRoZXJlIGFyZSB3YXJuaW5ncyBpbiBwbGFjZSB0bw0KPiA+IGNv
bXBsYWluDQo+ID4gYnV0IG5vdCBoYW5kbGUgdGhpcyBzY2VuYXJpby4NCj4gPiANCj4gPiBPbmUg
d2F5IHRvIG1ha2UgdGhpcyBtb3JlIHJvYnVzdCB3b3VsZCBiZSB0byBjcmVhdGUgc29tZSBuZXcg
Q1BBDQo+ID4gZnVuY3Rpb25hbGl0eSB0aGF0IGNhbiBrbm93IHRvIG1hcCBhbmQgcmVzZXQgdGhl
IHdob2xlIGh1Z2UgcGFnZSBpbg0KPiA+IHRoZQ0KPiA+IGNhc2Ugb2YgdHJ5aW5nIHRvIG1hcCBh
IHN1YnBhZ2UuIEJ1dCBmb3Igc2ltcGxpY2l0eSBhbmQgc21hbGxlcg0KPiA+IGNvZGUsIGp1c3QN
Cj4gPiBtYWtlIHg4NiBoaWJlcm5hdGUgaGF2ZSBpdHMgb3duIGZpeG1hcCBQVEUgdGhhdCBpdCBj
YW4gdXNlIHRvIHBvaW50DQo+ID4gdG8gNGsgcGFnZXMgd2hlbiBpdCBlbmNvdW50ZXJzIGFuIHVu
bWFwcGVkIGRpcmVjdCBtYXAgcGFnZS4NCj4gPiANCj4gPiBNb3ZlIGRvX2NvcHlfcGFnZSgpIHRv
IGEgaGVhZGVyIHN1Y2ggdGhhdCBpdCBjYW4gYmUgdXNlZCBpbiBhbiBhcmNoDQo+ID4gYnJlYWtv
dXQuIFJlbmFtZSBpdCBoaWJfY29weV9wYWdlKCkgdG8gYmUgbW9yZSBoaWJlcm5hdGUgc3BlY2lm
aWMNCj4gPiBzaW5jZQ0KPiA+IGl0IGNvdWxkIGFwcGVhciBpbiBvdGhlciBmaWxlcy4NCj4gPiAN
Cj4gPiBVc2UgX193ZWFrIGZvciB0aGUgYXJjaCBicmVha291dCBiZWNhdXNlIHRoZXJlIGlzIG5v
dCBhIHN1aXRhYmxlDQo+ID4gYXJjaA0KPiA+IHNwZWNpZmljIGhlYWRlciB0byB1c2UgdGhlICNk
ZWZpbmUgbWV0aG9kLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxy
aWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiANCj4gPiBSZWJhc2UgdG8g
djYuMi1yYzMgKG9yaWdpbmFsIHN0aWxsIGFwcGxpZWQpIGFuZCByZXNlbmRpbmcgcGVyOg0KPiA+
IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DQUpaNXYwaTZjeEdEK1Y2RytxLVlfTHAt
b3Y1MV96bWtacjhaR3BDdHFXVi1lPUJzTGdAbWFpbC5nbWFpbC5jb20vDQo+ID4gDQo+ID4gIGFy
Y2gveDg2L2luY2x1ZGUvYXNtL2ZpeG1hcC5oIHwgIDMgKysrDQo+ID4gIGFyY2gveDg2L3Bvd2Vy
L2hpYmVybmF0ZS5jICAgIHwgMTAgKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3N1c3Bl
bmQuaCAgICAgICB8IDEzICsrKysrKysrKysrKysNCj4gPiAga2VybmVsL3Bvd2VyL3NuYXBzaG90
LmMgICAgICAgfCAyMSArKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gPiAgNCBmaWxlcyBjaGFuZ2Vk
LCAzMyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZml4bWFwLmgNCj4gPiBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2ZpeG1hcC5oDQo+ID4gaW5kZXggZDBkY2VmYjVjYzU5Li4wZmNlZWQ5YTQxNTIgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZml4bWFwLmgNCj4gPiArKysgYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9maXhtYXAuaA0KPiA+IEBAIC0xMDgsNiArMTA4LDkgQEAgZW51bSBm
aXhlZF9hZGRyZXNzZXMgew0KPiA+ICAjaWZkZWYgQ09ORklHX1BBUkFWSVJUX1hYTA0KPiA+ICAg
ICAgICAgRklYX1BBUkFWSVJUX0JPT1RNQVAsDQo+ID4gICNlbmRpZg0KPiA+ICsjaWZkZWYgQ09O
RklHX0hJQkVSTkFUSU9ODQo+ID4gKyAgICAgICBGSVhfSElCRVJOQVRFLA0KPiA+ICsjZW5kaWYN
Cj4gPiANCj4gPiAgI2lmZGVmIENPTkZJR19BQ1BJX0FQRUlfR0hFUw0KPiA+ICAgICAgICAgLyog
VXNlZCBmb3IgR0hFUyBtYXBwaW5nIGZyb20gYXNzb3J0ZWQgY29udGV4dHMgKi8NCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvcG93ZXIvaGliZXJuYXRlLmMNCj4gPiBiL2FyY2gveDg2L3Bvd2Vy
L2hpYmVybmF0ZS5jDQo+ID4gaW5kZXggNmY5NTVlYjFlMTYzLi40NzNiNmI1ZjZiN2UgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC94ODYvcG93ZXIvaGliZXJuYXRlLmMNCj4gPiArKysgYi9hcmNoL3g4
Ni9wb3dlci9oaWJlcm5hdGUuYw0KPiA+IEBAIC0xNDcsNiArMTQ3LDE2IEBAIGludCBhcmNoX2hp
YmVybmF0aW9uX2hlYWRlcl9yZXN0b3JlKHZvaWQNCj4gPiAqYWRkcikNCj4gPiAgICAgICAgIHJl
dHVybiAwOw0KPiA+ICB9DQo+ID4gDQo+ID4gK3ZvaWQgY29weV91bm1hcHBlZF9wYWdlKHZvaWQg
KmRzdCwgc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ID4gK3sNCj4gPiArICAgICAgIFdBUk5fT04oIXBy
ZWVtcHRfY291bnQoKSk7DQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoZSBhYm92ZSBpcyBuZWVkZWQu
ICBUaGUgY29kZSB1c2luZyB0aGlzIGZ1bmN0aW9uDQo+IGNhbm5vdCBiZSBwcmVlbXB0ZWQgYW55
d2F5IEFGQUlDUy4NCg0KVGhlIHJlYXNvbiBJIHRob3VnaHQgaXQgd2FzIHVzZWZ1bCB3YXMgYmVj
YXVzZSB0aGlzIGZ1bmN0aW9uIGlzIG5vdw0KZGVmaW5lZCBpbiBhIGhlYWRlci4gU29tZW9uZSBl
bHNlIG1pZ2h0IGRlY2lkZSB0byB1c2UgaXQuIERvZXMgaXQgc2VlbQ0KbW9yZSB1c2VmdWw/DQoN
Cj4gDQo+ID4gKw0KPiA+ICsgICAgICAgc2V0X2ZpeG1hcChGSVhfSElCRVJOQVRFLCBwYWdlX3Rv
X3BoeXMocGFnZSkpOw0KPiA+ICsgICAgICAgX19mbHVzaF90bGJfYWxsKCk7DQo+IA0KPiBTbyBk
byBUTEJzIG5lZWQgdG8gYmUgZmx1c2hlZCBiZWZvcmUgY29weWluZyBldmVyeSBzaW5nbGUgcGFn
ZT8NCj4gQmFzaWNhbGx5LCB0aGV5IGFyZSBhbGwgY29waWVkIGluIG9uZSBsb29wLg0KDQpJdCBp
cyBvbmx5IG9uZSBmaXhtYXAgZW50cnkgc28gaXQgbmVlZHMgdG8gYmUgZmx1c2hlZCBhZnRlciBj
aGFuZ2luZw0KdGhlIFBURSB0byBwb2ludCB0byBhIGRpZmZlcmVudCBwYWdlLiBCdXQgdGhpcyBp
cyBvbmx5IGZvciB0aGUgY2FzZSBvZg0KdW5tYXBwZWQgcGFnZXMsIHRoZSBtb3JlIGNvbW1vbiBt
YXBwZWQgcGFnZXMgYXJlIGNvcGllZCBmcm9tIHRoZSBkaXJlY3QNCm1hcCBsaWtlIHVzdWFsLg0K
DQo+IA0KPiA+ICsgICAgICAgaGliX2NvcHlfcGFnZShkc3QsICh2b2lkICopZml4X3RvX3ZpcnQo
RklYX0hJQkVSTkFURSkpOw0KPiA+ICsgICAgICAgY2xlYXJfZml4bWFwKEZJWF9ISUJFUk5BVEUp
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICBpbnQgcmVsb2NhdGVfcmVzdG9yZV9jb2RlKHZvaWQpDQo+
ID4gIHsNCj4gPiAgICAgICAgIHBnZF90ICpwZ2Q7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvc3VzcGVuZC5oIGIvaW5jbHVkZS9saW51eC9zdXNwZW5kLmgNCj4gPiBpbmRleCBjZmUx
OWEwMjg5MTguLjBiMTliOTEwNTI2ZSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3N1
c3BlbmQuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvc3VzcGVuZC5oDQo+ID4gQEAgLTQ0Nyw2
ICs0NDcsMTkgQEAgZXh0ZXJuIGJvb2wgaGliZXJuYXRpb25fYXZhaWxhYmxlKHZvaWQpOw0KPiA+
ICBhc21saW5rYWdlIGludCBzd3N1c3Bfc2F2ZSh2b2lkKTsNCj4gPiAgZXh0ZXJuIHN0cnVjdCBw
YmUgKnJlc3RvcmVfcGJsaXN0Ow0KPiA+ICBpbnQgcGZuX2lzX25vc2F2ZSh1bnNpZ25lZCBsb25n
IHBmbik7DQo+ID4gK3ZvaWQgY29weV91bm1hcHBlZF9wYWdlKHZvaWQgKmRzdCwgc3RydWN0IHBh
Z2UgKnBhZ2UpOw0KPiA+ICsNCj4gPiArLyoNCj4gPiArICogVGhpcyBpcyBuZWVkZWQsIGJlY2F1
c2UgY29weV9wYWdlIGFuZCBtZW1jcHkgYXJlIG5vdCB1c2FibGUgZm9yDQo+ID4gY29weWluZw0K
PiA+ICsgKiB0YXNrIHN0cnVjdHMuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQg
aGliX2NvcHlfcGFnZShsb25nICpkc3QsIGxvbmcgKnNyYykNCj4gPiArew0KPiA+ICsgICAgICAg
aW50IG47DQo+ID4gKw0KPiA+ICsgICAgICAgZm9yIChuID0gUEFHRV9TSVpFIC8gc2l6ZW9mKGxv
bmcpOyBuOyBuLS0pDQo+ID4gKyAgICAgICAgICAgICAgICpkc3QrKyA9ICpzcmMrKzsNCj4gPiAr
fQ0KPiA+IA0KPiA+ICBpbnQgaGliZXJuYXRlX3F1aWV0X2V4ZWMoaW50ICgqZnVuYykodm9pZCAq
ZGF0YSksIHZvaWQgKmRhdGEpOw0KPiA+ICAjZWxzZSAvKiBDT05GSUdfSElCRVJOQVRJT04gKi8N
Cj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL3Bvd2VyL3NuYXBzaG90LmMgYi9rZXJuZWwvcG93ZXIv
c25hcHNob3QuYw0KPiA+IGluZGV4IGNkOGI3YjM1ZjFlOC4uMzQ0YzA3MWYyOWQzIDEwMDY0NA0K
PiA+IC0tLSBhL2tlcm5lbC9wb3dlci9zbmFwc2hvdC5jDQo+ID4gKysrIGIva2VybmVsL3Bvd2Vy
L3NuYXBzaG90LmMNCj4gPiBAQCAtMTM2OSwxNiArMTM2OSwxMSBAQCBzdGF0aWMgdW5zaWduZWQg
aW50IGNvdW50X2RhdGFfcGFnZXModm9pZCkNCj4gPiAgICAgICAgIHJldHVybiBuOw0KPiA+ICB9
DQo+ID4gDQo+ID4gLS8qDQo+ID4gLSAqIFRoaXMgaXMgbmVlZGVkLCBiZWNhdXNlIGNvcHlfcGFn
ZSBhbmQgbWVtY3B5IGFyZSBub3QgdXNhYmxlIGZvcg0KPiA+IGNvcHlpbmcNCj4gPiAtICogdGFz
ayBzdHJ1Y3RzLg0KPiA+IC0gKi8NCj4gPiAtc3RhdGljIGlubGluZSB2b2lkIGRvX2NvcHlfcGFn
ZShsb25nICpkc3QsIGxvbmcgKnNyYykNCj4gPiArdm9pZCBfX3dlYWsgY29weV91bm1hcHBlZF9w
YWdlKHZvaWQgKmRzdCwgc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ID4gIHsNCj4gPiAtICAgICAgIGlu
dCBuOw0KPiA+IC0NCj4gPiAtICAgICAgIGZvciAobiA9IFBBR0VfU0laRSAvIHNpemVvZihsb25n
KTsgbjsgbi0tKQ0KPiA+IC0gICAgICAgICAgICAgICAqZHN0KysgPSAqc3JjKys7DQo+ID4gKyAg
ICAgICBoaWJlcm5hdGVfbWFwX3BhZ2UocGFnZSk7DQo+ID4gKyAgICAgICBoaWJfY29weV9wYWdl
KGRzdCwgcGFnZV9hZGRyZXNzKHBhZ2UpKTsNCj4gPiArICAgICAgIGhpYmVybmF0ZV91bm1hcF9w
YWdlKHBhZ2UpOw0KPiA+ICB9DQo+ID4gDQo+ID4gIC8qKg0KPiA+IEBAIC0xMzkyLDExICsxMzg3
LDkgQEAgc3RhdGljIGlubGluZSB2b2lkIGRvX2NvcHlfcGFnZShsb25nICpkc3QsDQo+ID4gbG9u
ZyAqc3JjKQ0KPiA+ICBzdGF0aWMgdm9pZCBzYWZlX2NvcHlfcGFnZSh2b2lkICpkc3QsIHN0cnVj
dCBwYWdlICpzX3BhZ2UpDQo+ID4gIHsNCj4gPiAgICAgICAgIGlmIChrZXJuZWxfcGFnZV9wcmVz
ZW50KHNfcGFnZSkpIHsNCj4gPiAtICAgICAgICAgICAgICAgZG9fY29weV9wYWdlKGRzdCwgcGFn
ZV9hZGRyZXNzKHNfcGFnZSkpOw0KPiA+ICsgICAgICAgICAgICAgICBoaWJfY29weV9wYWdlKGRz
dCwgcGFnZV9hZGRyZXNzKHNfcGFnZSkpOw0KPiA+ICAgICAgICAgfSBlbHNlIHsNCj4gPiAtICAg
ICAgICAgICAgICAgaGliZXJuYXRlX21hcF9wYWdlKHNfcGFnZSk7DQo+ID4gLSAgICAgICAgICAg
ICAgIGRvX2NvcHlfcGFnZShkc3QsIHBhZ2VfYWRkcmVzcyhzX3BhZ2UpKTsNCj4gPiAtICAgICAg
ICAgICAgICAgaGliZXJuYXRlX3VubWFwX3BhZ2Uoc19wYWdlKTsNCj4gPiArICAgICAgICAgICAg
ICAgY29weV91bm1hcHBlZF9wYWdlKGRzdCwgc19wYWdlKTsNCj4gPiAgICAgICAgIH0NCj4gPiAg
fQ0KPiA+IA0KPiA+IEBAIC0xNDE3LDcgKzE0MTAsNyBAQCBzdGF0aWMgdm9pZCBjb3B5X2RhdGFf
cGFnZSh1bnNpZ25lZCBsb25nDQo+ID4gZHN0X3BmbiwgdW5zaWduZWQgbG9uZyBzcmNfcGZuKQ0K
PiA+ICAgICAgICAgaWYgKFBhZ2VIaWdoTWVtKHNfcGFnZSkpIHsNCj4gPiAgICAgICAgICAgICAg
ICAgc3JjID0ga21hcF9hdG9taWMoc19wYWdlKTsNCj4gPiAgICAgICAgICAgICAgICAgZHN0ID0g
a21hcF9hdG9taWMoZF9wYWdlKTsNCj4gPiAtICAgICAgICAgICAgICAgZG9fY29weV9wYWdlKGRz
dCwgc3JjKTsNCj4gPiArICAgICAgICAgICAgICAgaGliX2NvcHlfcGFnZShkc3QsIHNyYyk7DQo+
ID4gICAgICAgICAgICAgICAgIGt1bm1hcF9hdG9taWMoZHN0KTsNCj4gPiAgICAgICAgICAgICAg
ICAga3VubWFwX2F0b21pYyhzcmMpOw0KPiA+ICAgICAgICAgfSBlbHNlIHsNCj4gPiAtLQ0KPiA+
IDIuMTcuMQ0KPiA+IA0K
