Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBD76C7591
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjCXCYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjCXCX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:23:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC23F940;
        Thu, 23 Mar 2023 19:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679624638; x=1711160638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lkznsG5d4JfwYjY5wzIWca513zWBiwNMoZhEPSXgqCg=;
  b=J6TxYuSXEtdaVEFZFHL7/33YrkRfX7PLzUiEeAEQVv9OCwP4vE+RMoLP
   0/PaMaWIKD/BRRtEZqeogvp1UXMEIe8aEJtO6THg0jyKW8L5HUgpu/6WT
   BKsMVYoJYY5H2ZtkvtGDVbQa0ML25gHQHh9AVzwk3LOD//XQ69RAef/nf
   zkdvcHsZV/elyebMX297iakiSCQrhgx3WgK5WdV2uteNy9St6bkkaH9UF
   CgvnosZr6sqPDpqbviS+pFOFFjxjhkKwAjYIHHB8kcmrRDasKADRwBCio
   i60y6sNgmDJbhs//vLcFT1RDuUTjDS9PKPtgD76CpVn+1Ml/PAiB/ZluC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="338401561"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="338401561"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 19:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="659887262"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="659887262"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2023 19:23:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 19:23:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 19:23:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 19:23:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3XTG30yYmAIfu2VF+hWAELkt8+RK3pJkCSlLXCX6ku1oDxcd1N8qCe5OvphdhKDD0asfH5F0X49j3AZz4Dik4GTd1RM55xtTCR/8b/uLquN31aJF4C08pTPRe0pSAxjrJbtvGbAvdm6acMjCfq4q52x9CoY9FcwIRIy4A4fJzOwqbOLiWxKs4PUjCR5jhkTfdpC0iIPRJgy7WoSUkk1oQKuuntslxTRyuRKqvd6hRoqO6Z6lWEsOixHzxVNR0AI+BJIykNKrZkcuW2OmbqHHVoB4X80RmrUcVU/HdvLlIRxI4nfzpRbBRvfdgVJwHSL7r0prc7jMqi2AfVhhYpu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkznsG5d4JfwYjY5wzIWca513zWBiwNMoZhEPSXgqCg=;
 b=fHuH+ypBAJoH7lhgDM2hTzMNwL/jt4ByjcoQ4QlhpQB/akIyHLWsmCMlfGmVv8rYcM/vDIDwHB0yczaNUile4oHAsWISAQvRY1eVCnZhnG3z/HF2A0yDoaaijiXUgwpj121blu4RKcsKooPTbk3+Ird+IN8aOPTPcQEbmB6Vm1FvDcsRPg76HB8v5/+mM0Pg9V3Uw3OivDmGBmmMeXO4jlr8KR/TJkLKMET1eM7C0Pn8SLzCNWrx8icLpQka2STHpgGGoYBXmcP4T8IgMuAk2ZN7YKfmumRQ9+QvRjfteqRiupY48j4qNRK/gp0s9qi26j39QhTlz7XcZVFiRqOXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CH3PR11MB7761.namprd11.prod.outlook.com (2603:10b6:610:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 02:23:56 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 02:23:56 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Add Zqiang as a RCU reviewer
Thread-Topic: [PATCH] MAINTAINERS: Add Zqiang as a RCU reviewer
Thread-Index: AQHZXTtrHSkC6Y8wKkKgXb1k+J8Hra8IvS4AgAB3BUA=
Date:   Fri, 24 Mar 2023 02:23:56 +0000
Message-ID: <PH0PR11MB588003A83F9F477339BA6B49DA849@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230323040729.145154-1-qiang1.zhang@intel.com>
 <20230323191526.GA628693@google.com>
In-Reply-To: <20230323191526.GA628693@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CH3PR11MB7761:EE_
x-ms-office365-filtering-correlation-id: d22b96cf-d0de-4c77-1704-08db2c0ed1a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5JKd49uq5mpeL0x/TuOzAhaFBJ0uW3PJ2RRW2yJTRtgkNGa/irmfodg6nut5ualnDtRsI2GCaoY2+Qn7KDPFRN7p/+DHUqCpq6xzwzaOekMwLUp2uzJSSck/KzIWRc4/+eexfEtdVy11AfXnjrYpxxQTOi76f68lVRW/2MBs7bULkh4YqtUaD5RxfMYiXu2JBNRbZcIFM5GZs/j0i/smBnnK4Gj4PrtSTukP8lVMVvvVd9iFOFIw1zubJPF0gWj81byHtzUwj9hIMcsrb9hoSK/uHLUlkZUZa+9DdyvdXOu637QX6gtitJ8GqxoqCdLXJopdkYnzUiQY+4xMdbDj5OkUwqlUoz6buTgDZ0HM0Ife0t2FutpNo2FI0I6R2r1xlgWhVgR0b9R3jE4ctXKI22TKrTMaiTL12lrD/fJESHSHkwgIYRx1pwCKjfaJSD3qaFIg95HolPBHAQdLHwZv1Zv+PCK/JybkaPnYsMUg5DdzFHLFMV/9eAHsGbARAkipKp574UaMGIkLEv0tLaFf/16gqlj4R/3jw9GEbbjXxV/8+N7aC7Qwe1NWm9iultzKcfCDjU01q8A5qllnJLcEVvJKIgOm/YYbs4TPmE7f2icw3n5wFqRXcA0aX3JUFdLxWhvuisJlPLJy6fe+95ACqszo4X8+in4TSLLR2eKxJP3gHTpIqitb4ZH5Rsg6Gt9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199018)(33656002)(41300700001)(66556008)(66476007)(66446008)(64756008)(4326008)(8676002)(76116006)(6916009)(66946007)(52536014)(8936002)(7696005)(966005)(316002)(478600001)(54906003)(4744005)(5660300002)(2906002)(82960400001)(71200400001)(38070700005)(86362001)(55016003)(38100700002)(122000001)(186003)(83380400001)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWM4SElLekxNbVRYenVXWmFmMjFkdGlReDU2WmVjQXFkYlJ3R3J5R2hoekZU?=
 =?utf-8?B?a0haSFExQkIraG1NOUE4c0M4RnltcnNMZ3hkeHhwUE9MUEZrQ01HWjgrcXk4?=
 =?utf-8?B?WXdUci81S1ppS0wxM0ZDMGZFNUl3SDRpVjgzcDdFY2NUUXBHSHhiVkVKU3Z3?=
 =?utf-8?B?bVJKRDcvSmNaRHlJQ0dCRjIxaU83VUxxbU9ITERmL3k1Zk4zUGdNK3E0eWMw?=
 =?utf-8?B?MzIrN2FsY1NjTkx6VXJ2Mi94dUFzR0grUjhJNzA3SU5FUzZYRzV4c2xIN0dq?=
 =?utf-8?B?Tmo1SzZTSHlhNjlPM3paWERWb3BuYWU5ay9zblNlVXE5Q0R3TlJOd3NycjZw?=
 =?utf-8?B?TmtRTkVCZUJ1UWtidmQ5VFd2emZoSGhWTkc4WS93aDVwZ2Qvb1dkZEoyWGZp?=
 =?utf-8?B?SUgrcTNrL2JrcCtUZHpyUnA1M1ppTjU4WklDUk1wUVlNOVpkS3J4MmhFbFhQ?=
 =?utf-8?B?YmFXaHhiOElxYXczQnJNVDduUzl3MmZXN3k5dVc0T05QZnFHVlVQSWNmUkw2?=
 =?utf-8?B?VmRHS2tqa05HNnNiUFBUUDY1dkQyWmRwNjdROFlUS3Z6dHBCK2p1WUQ5N1Vy?=
 =?utf-8?B?RjVyMlpteFZxSUhLSlFBWEtrdWYyMk1SYmtXU2RRc2FyQVp3ejdkSG5lTndo?=
 =?utf-8?B?SXliT0ZQY0Q5Y3M3Qk80dk1CN2hRSDdLV3o0ek4zSFpuLzNLQWFaaWUxR0dV?=
 =?utf-8?B?QjdJK3RpY2wyYzNTT2ErWFA5NFpadzM0NDRlWnlGZWR0SWNWRy9Dcmx1Ykhu?=
 =?utf-8?B?eGJuOXRuMHpsdkFxMlhzQndDaWlCdnVtbTd2amJEK2hnMTlsRDFHVFptVkJv?=
 =?utf-8?B?bENlZHlBSFNJRktEam1nUThpYTVVdWx2TTQwWllEa1N0NHpyT3I3R2VMQzBk?=
 =?utf-8?B?alBQWlQxZWowOWpiL0luVGpNQmdmZWNnVllqdUQ0ckNmSEczYjZ4dFlrUW5W?=
 =?utf-8?B?TWlGRFk1R2RIbFJ1SlArQU9sZXEyeThxSW9xWDlpbkQ0a1I3TUl1b2xXeEFC?=
 =?utf-8?B?V1JvbXo2TG93bEJPU3RDSlM5SVhqT09ZU2FreEx4c3ZBb1FIaUx3TmpVSyt4?=
 =?utf-8?B?MnRXbWdTcVdqNjNOeEthbFByMk5lMnU5MG4wRjEvRkk2Mnc0d01uRXNFS2N5?=
 =?utf-8?B?YjRFbkJJL1JTbGtKNDVQamE0K1N0anBtSGI2N0E2M2lIcVFOcHRaTmt2R1di?=
 =?utf-8?B?NUFpN3VBbXpQU1pPUUNtaU1vZEdUQ3MveitlVTBZVEZsVXBRVTJ1VmJZdW03?=
 =?utf-8?B?b0ZVeDdCRWF6YVN0UWJPMXQ4citaSTNGcktTbmNSalF0VDRqcjI1OEFmRFFD?=
 =?utf-8?B?aU9WNnJScFJtaGx0QUJ5WGloVE82N1J1Y1NyUEwzejA5dmx1L21XdmJEYlRF?=
 =?utf-8?B?Y1Ztd0JOTWE5SXgzeTBPbzNIYWlWNFQ4aWxpY0JSb0F2U05OZ1JveFVyQ2da?=
 =?utf-8?B?aVU2QkZxSElOdi9iaU9NalJUMkh6dkpCaEg0WENEU0V6SEtKY1NrbWlVR1Y2?=
 =?utf-8?B?QWUwRDlKb1NFM0tVeWd5LytLZFVpazdzY0VQc25WNmFwdzFkVnhnMjFLVFkz?=
 =?utf-8?B?bzlYZGFZUzVMZXQ3d0hVVi9ldUMxR2tkcnBBdXI4M3VtTmZDWXdTNVZpQzVq?=
 =?utf-8?B?T0gxN2tOUFl1Y3FESkV3Z3NnYnBxRWE5KzJNZ3E3ZzQzQWt2bzV6MHBVNGQw?=
 =?utf-8?B?Nm5QNXNZN29yWVRNWURseEI1ZVAzdjhvQjdaYWMxdzdmcWMrNjR3NTNpQnNt?=
 =?utf-8?B?QzJRWVpHai82c0pMTUFzT0E2Yk8yeWdlRmFWY2VDWkQwa3hDQnE4QjUvVTEv?=
 =?utf-8?B?a2tKYmlrUFlyRDl4RFVSMXVzVThpTEZ5L25hQVlzdldpU0EvOEg2TlpuR29W?=
 =?utf-8?B?dlRYakJjbklkZjJRbUlSeDRHUi9jc1FNcjFXd0FoSEpwQSt1MHA5V093WXNu?=
 =?utf-8?B?WDZIT2RZazJhcEs0TnJHWGVPQzFPUk5Zb2cwK05TR1VsU2l5NTFlUi9mVWIv?=
 =?utf-8?B?UnhCSDBXZmdMalRMN3dlOEVIa0xKUkZjZldNTVR2b056cHNVdHhwak1Wb3Bm?=
 =?utf-8?B?MEloeS8vVzlsQmpic2lvWDczTERCWU5ONjNsQVRiWG9ra3IvUnpIbUdtN1hM?=
 =?utf-8?Q?D4JDNwuyAZBJUwpOZD/GC88+I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22b96cf-d0de-4c77-1704-08db2c0ed1a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 02:23:56.0903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNmCZNBG2cpGv59asY7Yr9lY3yccgxpW38r+tbOnr92VEVVV2xetXmsqx2H1o7AvArNb9sLROmZWCD/zraFJhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIFRodSwgTWFyIDIzLCAyMDIzIGF0IDEyOjA3OjI5UE0gKzA4MDAsIFpxaWFuZyB3cm90ZToN
Cj4gSSBoYXZlIHNwZW50IGFib3V0IHR3byB5ZWFycyBzdHVkeWluZyBhbmQgY29udHJpYnV0aW5n
IHRvIFJDVSwNCj4gYW5kIHNoYXJpbmcgUkNVLXJlbGF0ZWQga25vd2xlZGdlIHdpdGhpbiBteSB0
ZWFtLCBpZiBwb3NzaWJsZSwNCj4gcGxlYXNlIGNvbnNpZGVyIG1lIGFzIFIgOy0pLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPg0KPkkgYW0g
cHVsbGluZyB0aGlzIGFuZCB0aGUgb25lIGFkZGluZyBCb3F1biBmb3IgNi40IGJhc2VkIG9uIGRp
c2N1c3Npb24gd2l0aCBQYXVsLg0KDQpUaGFua3MgSm9lbCwgIGxvb2tpbmcgZm9yd2FyZCB0byBv
dXIgbW9yZSBkaXNjdXNzaW9uc/CfmIouDQoNCj4NCj5Db25ncmF0cy4gOy0pDQo+DQo+dGhhbmtz
LA0KPg0KPiAtIEpvZWwNCj4NCj4NCj4gLS0tDQo+ICBNQUlOVEFJTkVSUyB8IDEgKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5F
UlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCA4ZDViYzIyM2YzMDUuLmIzMDRkM2M3YjQ1YiAxMDA2
NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTE3NjQy
LDYgKzE3NjQyLDcgQEAgUjoJU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQo+
ICBSOglNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPg0K
PiAgUjoJTGFpIEppYW5nc2hhbiA8amlhbmdzaGFubGFpQGdtYWlsLmNvbT4NCj4gIFI6CUpvZWwg
RmVybmFuZGVzIDxqb2VsQGpvZWxmZXJuYW5kZXMub3JnPg0KPiArUjoJWnFpYW5nIDxxaWFuZzEu
emhhbmdAaW50ZWwuY29tPg0KPiAgTDoJcmN1QHZnZXIua2VybmVsLm9yZw0KPiAgUzoJU3VwcG9y
dGVkDQo+ICBXOglodHRwOi8vd3d3LnJkcm9wLmNvbS91c2Vycy9wYXVsbWNrL1JDVS8NCj4gLS0g
DQo+IDIuMjUuMQ0KPiANCg==
