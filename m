Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6676696DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjAMMXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjAMMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:23:18 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFCD81C17;
        Fri, 13 Jan 2023 04:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673612370; x=1705148370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dM1LjeosG5vSMRY0OdvAsjOp9BeLZiIIqshplz3Z5OA=;
  b=hzHbUfDqfQEKcsMcvd9DL4A+/USxUHpnMqLXrm/EFFsih9aO2tJbXxKY
   0wzH6TW1zNQI2K6+gwDE9PzJLI1/m0XfZzbh10NVtMU7fvOpWjQl7y7qv
   oId7neeapZfRcMhnjVjfbxgQ9L4c4SKbZY8D7W4hyJYyE8QhovdRug7dG
   6KdS8agoLHA2w25cSHutAPHs5eufo96RLSqSXr6Em/cILVxssFxFccgEu
   D8kUBMHGOT+oPf08jm2YZcdxqiFXhEKXZfTgeqBSxRIDpjCsoRMKSRqCr
   izvWYkOgIexEc3aMnC4yh7yPCAVo7R10OfFX46MxF2ix1z3Y8PlSR25IH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="321676077"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="321676077"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 04:19:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="765999822"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="765999822"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2023 04:19:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 04:19:29 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 04:19:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 04:19:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ea20zictdWknJkdhpdYXMogZ/asmB3WX946tWIx17gx+7L60rkQQ2UwqxOkwqaZW7x80gkgcMeh99I5Q0jX60ZWMCeWOqa2JqVZRTb1cddlFG6Kv5DWROTBDiLE/hsQArBCclu39oDMsWd+F0HnB1Wsi0pB7D7/JqPxcmDjIL720uzplmR7BCpivtd78uXdcNX123rTZYiP6mQbjTixjBeI9bKk1ud5VtxdZE8vjEmMdVMlDaGHSpFXTyk/ZZbsoXTN7He3cpjhuHX6AkoD3vymixC+SfedwrOhw6/M6zAN+wwUbtq8R+Vi3ywKeOw1QLdEaP0sQTObLplwBwOjS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dM1LjeosG5vSMRY0OdvAsjOp9BeLZiIIqshplz3Z5OA=;
 b=Rg+eLQ0zL2NkyEA5VPYgPZatEkb4cMuIhQG5knYlAa5R3H8OW2vyWfQtbjy5OJBXv7d3LH9XICVUXmlRYx3ixxqAVg0eLhp0duwNp/5Q+0/iyjxeg2hEz/PxYgFHnposspra6vHGudOOniznNF9jx7u1opl+jKJcvhB480oUXOq21A1ibUWFwQzNOObQc9OqF8tCicPydoNMUtweIPWt01KqzY/HRltnxH6Cl9zCgaooL2TYYGl9HKyL/IPeNBpWC6CtcpG1NZ8QYKts7xxsp258xQj6z3OLyq4ohxpc74fZPgJxdMPXIfoGAIcod5iESAcupQHZdUM8MLPg1HZMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 12:19:27 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 12:19:26 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited() be
 invoked very early
Thread-Topic: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited()
 be invoked very early
Thread-Index: AQHZJlrAbelW6ZjuBUWwM88Mxg3+Hq6bJV4AgADo4SCAADQ80IAAAasA
Date:   Fri, 13 Jan 2023 12:19:26 +0000
Message-ID: <PH0PR11MB5880E5C88E308E8CD79F302BDAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230112075629.1661429-1-qiang1.zhang@intel.com>
 <20230112190656.GR4028633@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588074A87AC454A7F0E42A5ADAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588008A9BBAFA6BEEC8685ABDAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB588008A9BBAFA6BEEC8685ABDAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MW3PR11MB4746:EE_
x-ms-office365-filtering-correlation-id: d16ee918-d761-4abc-258b-08daf56069db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pfpfwGmkdB6PnLMK3vvLHTPs/UKI683j7Nlvey4ECq7UD3D8of+RivZjtf7Go/5y6FwEwtmtiFKhFwa9kr4fIq5w5zzX3+aKMdQBQ89+3XLl50LiHMTLbYgLs8WWyqXfjYpANZi99robjXkLyHVgaZ9aRrs0jnD6KmU059qhwqjVpuokJ6gtD9PT1kTrkCbjVfQ3E2ERy527/fw0XM0KrNFtwJjXOLqEoWP7bUjrhzRRuad9iAsZoi0gfd2KfQx/F1CliC2Ndy/83V4t9hhZLwyDqJP4QxXZln0pM9lxCgkPmIemm3S2qg693eCypdGjLfnw0k5V/nXfXj9cClw+A4DMC++IlcPTKdGAEAbdlNKWc+oi3xsFP9n1GgFLWzHNQ2jOvfr+5n13kJMNgH9nAgML1A35NlIu2fpdNTRFZOTrq/zuDLgcXYkogj+pxLhqvLw71XNlRvuNU6YGbeo0gtjmk6vZ/TnCRK359MkV8clcY/G3s5Xzw6l2P8E9hsPGkD66TgxvXGJXNq7gLc3WzPx3oKbxQbbowjaocluJ9ok37XofK/m2Ae7GRvLeS1IumajZAIxhbSBwMdVpHtpN/ocpAC2hnDlm6g4EVU9NmkCkFfjD0ufrDIUTjUtqdWAWmhesdXFnFld77kGD2cIPglHaHYjqvUEIPseJtpTYqkLqlzYhvpxI96FWZIQvyw/5kt8L/XEardVf61qIrw86Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(6506007)(26005)(186003)(9686003)(2940100002)(71200400001)(7696005)(478600001)(38100700002)(82960400001)(122000001)(38070700005)(86362001)(55016003)(83380400001)(33656002)(64756008)(52536014)(8936002)(5660300002)(2906002)(66946007)(66556008)(316002)(76116006)(4326008)(66476007)(66446008)(8676002)(6916009)(54906003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zlo2VDNvWlBtd2xyWS9kaUJneDlobmY5R3R1TnZBMkJhM0txcGkwMllVOUxp?=
 =?utf-8?B?eU9LTGN2V0dqMmpwcWo3T21VZE9lem1sY0N4bE0yVzRoZTdwS2wxS3AxaVpP?=
 =?utf-8?B?YlQyUnA2SnhwZVdKUWdWV0IvdjZMQ0E2SW9hQy9qR2FpQmFydllKQVh5WkxW?=
 =?utf-8?B?alNONEVJWGVENVNvRm5CNU9VeEdSQzhXL2NtWEVadEV6d21LTzhheXRwNTFE?=
 =?utf-8?B?MXJCRzZzVGkvNDIxdjZtcGIxTjl5Y3VjNzlhWmV3RnVrYlhDay9pcENmSUFS?=
 =?utf-8?B?TnFRbnFBNys2UmoyK1F3Vi9MTjZKdUdOVjV1b0pzek9ha09QNFNmaWEySGdH?=
 =?utf-8?B?T1ZpZW4xRHo5K2Ywb0gyL0RsTmdvWDBleFh6VUp2NWV5QUphaXg2U0U1S2VB?=
 =?utf-8?B?RzJ1SGh3ekNwczBzUzBsOE9hWnZBNmxrT3BIUW5FU2NPVkJMY3dnejJRNmM2?=
 =?utf-8?B?WDdkL2NsZzVzY2JKZHowNWNWb2xRUnNIWUFTb3BmV3dySm0zS1ZmR1JwN1FW?=
 =?utf-8?B?enQyL3g5M3BsT1VWOFZhZUcrbkVGam5QY1N3MXNsMVAzZCtLdHl2MFhwQm50?=
 =?utf-8?B?eHdpZVhMQ3RIeFIvdDdzeGJ0bU5DdUdjbXBpWkRKK3FscU9odVhVV0x1akNL?=
 =?utf-8?B?aWthNDlQL0R3MlpuU09JZk9kSXV5dmFmaFRmenA4OG12UGRWclduVHJKMHZw?=
 =?utf-8?B?ZU0vczNDQVVjRGlTM3ZCdDIrclBDenFjU2d2Y1BCZHlCakV3Q2R4NVlOdUow?=
 =?utf-8?B?Y0tNSlBPVXhadVVWbC9teFR3YkJ3dWtWazRwcEtTUFUxdkxOUCs3a3lQcldj?=
 =?utf-8?B?UTRWRTVKcVFPK3FPeVB1SGlGVWxCSm5ZWlFvRENoYjlJM3cyaDlpdE1QRVJL?=
 =?utf-8?B?Y3oyaWhZUDlaOVgva1crdzh5bmphV1VSdmoydHdvNkU0VEhDMGMxNkQwejNr?=
 =?utf-8?B?OXhKbUpHVkZLMTFXbjk4KzUxSGJJZWdubHhwbExaMTdmTkdmamFQeDFFN1ll?=
 =?utf-8?B?RXN6NXR1QW5KQUpTcWdIVUY3dXZncVJ5bFVUMUYxMVF3dlVXQ3hPRVE5RGx6?=
 =?utf-8?B?QkxNODFsUVpNUXgvN0xiRjY4blZKeFJ0WVM1d3pXbGdVOG5yS09JWXErdnk5?=
 =?utf-8?B?UXlWVFlwcVdZdFo3QnlpQVoxUU50dlMwYnExS2VaRnYvcDZ6MndTZEsrZ2Y1?=
 =?utf-8?B?WkFWMHUzQ2c3NDVMYkpyZGFVMm8xTTBqV2hLbXNiSmlwQnoyUVRhcTNFcGdu?=
 =?utf-8?B?Ujd3Um1BOEdyVGpFelgyZE1iUjlCa3RsQmpJem5nSHFnRTF5Z3dtbkNvNTFJ?=
 =?utf-8?B?aGpuanJ1RjBDVzh6MGpWcTIwR2c4bkxxVHZ1RXN0SzFJZis5RjlZU0JZZk5x?=
 =?utf-8?B?VUJwMHdNTm8rUjVaZm5aZmkvZDdYOG13LzJXVG9JTVdnVEFvRXhDQlFGL0wv?=
 =?utf-8?B?bDNLTmF3M0RSRGhNYjVVai9PVnM2QzVESlZhQVpDTElQV1dGMVIxMTRaZlhO?=
 =?utf-8?B?WlpYckw4TDBsRXFpMWRIWlF0TzlYVzJPYWIvM2tpejdMcjMwYm5HMUNwV05N?=
 =?utf-8?B?Sjh0VHFLQ215WGdwNXRMNFBIdzFpcGUxQzZ2N01Nb1NmYVp4ZzVEUUZHRlA2?=
 =?utf-8?B?Z05ndkVMbXBMSXhQTzlscEVKQS9Ic1k5STY3OEVKR3EvcnhYcncxeWFvYnA4?=
 =?utf-8?B?ZUpaWVo2NVlOZ2lIczZDQUw0aXBKWkdLNmFkbDVTMG9FdW9EeFRSNGFDUnRL?=
 =?utf-8?B?Z0pIMnZkbFJXUm1ISFg5T1ZibW0xbHd5VFdaUE1IZVcrSG43VWhTZGR2NUc2?=
 =?utf-8?B?Rm8zUUw3OXlIZU52dCtHQjdNa2pUbnNKZlpFbHE1d1lCZU1oT1NWY1BoVThC?=
 =?utf-8?B?dE1rVDhqVFlSaEJTd2ZCUVFDdWJla255NmlaRnZFTVpXdStDNE42ZCs5MjNO?=
 =?utf-8?B?eE5xRGFrSkp5enJTbWM5L2N1UHpGMVNHTlRQZkNldmU0dS9rMWd2c0ExU1ZV?=
 =?utf-8?B?KzlWbFowSkZoNFVwWjF1Ui9ZT2h0ajY1OEZkNlRXdzMvV2lMbGpXZ0dtS01N?=
 =?utf-8?B?bDU1L2RaM1FJKzhhbkF6cS9JZmFzQVJQYXA5THVnalhqaHM2WkRUcXRlZlVP?=
 =?utf-8?Q?Ln6cMxSrEHGvc8vfbaPxKQOWL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16ee918-d761-4abc-258b-08daf56069db
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 12:19:26.7513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qvADyo3++5JgcQMS2XvsmHQTpaLemkow3Fl4BMWGQ4xPt7vkRHlEvzkVJHPkh6kRXNOy5zS2V+vd75J9IBSy4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEN1cnJlbnRseSwgdGhlIHN0YXJ0X3BvbGxfc3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCgp
IGNhbiBiZSBpbnZva2VkDQo+IHZlcnkgZWFybHkuIGJlZm9yZSByY3VfaW5pdCgpLCB0aGUgcmN1
X2RhdGEgc3RydWN0dXJlJ3MtPm15bm9kZSBpcyBub3QNCj4gaW5pdGlhbGl6ZWQsIGlmIGludm9r
ZSBzdGFydF9wb2xsX3N5bmNocm9uaXplX3JjdV9leHBlZGl0ZWQoKSBiZWZvcmUNCj4gcmN1X2lu
aXQoKSwgd2lsbCB0cmlnZ2VyIGEgbnVsbCByY3Vfbm9kZSBzdHJ1Y3R1cmUncy0+ZXhwX3NlcV9w
b2xsIGFjY2Vzcy4NCj4gDQo+IFRoaXMgY29tbWl0IGFkZCBib290X2V4cF9zZXFfcG9sbF9ycSBt
ZW1iZXIgdG8gcmN1X3N0YXRlIHN0cnVjdHVyZSB0bw0KPiBzdG9yZSBzZXEgbnVtYmVyIHJldHVy
biBieSBpbnZva2Ugc3RhcnRfcG9sbF9zeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKCkNCj4gdmVy
eSBlYXJseS4NCj4gDQo+IEZpeGVzOiBkOTZjNTJmZTQ5MDcgKCJyY3U6IEFkZCBwb2xsZWQgZXhw
ZWRpdGVkIGdyYWNlLXBlcmlvZCBwcmltaXRpdmVzIikNCj4gU2lnbmVkLW9mZi1ieTogWnFpYW5n
IDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPg0KPkZpcnN0IG9mZiwgZXhjZWxsZW50IGNhdGNo
LCBacWlhbmchISENCj4NCj5BbmQgdGhhbmsgeW91IGZvciBGcmVkZXJpYyBhbmQgSm9lbCBmb3Ig
eW91ciByZXZpZXdzLg0KPgkNCj5CdXQgSSBiZWxpZXZlIHRoYXQgdGhpcyBjYW4gYmUgc2ltcGxp
ZmllZCwgZm9yIGV4YW1wbGUsIGFzIHNob3duIGluDQo+dGhlICh1bnRlc3RlZCkgcGF0Y2ggYmVs
b3cuDQo+DQo+VGhvdWdodHM/DQo+DQo+QWdyZWUsIHRoYW5rcyBmb3Igd29yZHNtaXRoZWQgIPCf
mIouDQo+DQo+DQo+QW5kIHllcywgSSBkaWQgcHJlc3VtcHR1b3VzbHkgYWRkIEZyZWRlcmljJ3Mg
YW5kIEpvZWwncyByZXZpZXdzLg0KPlBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgZGlzYWdyZWUs
IGFuZCBpZiBzbyB3aGF0IGRpZmZlcmVudCBhcHByb2FjaA0KPnlvdSB3b3VsZCBwcmVmZXIuICAo
VGhvdWdoIG9mIGNvdXJzZSBzaW1wbGUgZGlzYWdyZWVtZW50IGlzIHN1ZmZpY2llbnQNCj5mb3Ig
bWUgdG8gcmVtb3ZlIHlvdXIgdGFnLiAgTm90IGhvbGRpbmcgeW91IGhvc3RhZ2UgZm9yIGltcHJv
dmVtZW50cywNCj5ub3QgeWV0LCBhbnl3YXkhKQ0KPg0KPgkJCQkJCQlUaGFueCwgUGF1bA0KPg0K
Pi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPg0KPmNvbW1pdCBlMDVhZjVjYjM4NThlNjY5YzllNmI3MGUwYWNh
NzA4Y2M3MDQ1N2RhDQo+QXV0aG9yOiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+
RGF0ZTogICBUaHUgSmFuIDEyIDEwOjQ4OjI5IDIwMjMgLTA4MDANCj4NCj4gICAgcmN1OiBQZXJt
aXQgc3RhcnRfcG9sbF9zeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKCkgdG8gYmUgaW52b2tlZCBl
YXJseQ0KPiAgICANCj4gICAgQWNjb3JkaW5nIHRvIHRoZSBjb21taXQgbG9nIG9mIHRoZSBwYXRj
aCB0aGF0IGFkZGVkIGl0IHRvIHRoZSBrZXJuZWwsDQo+ICAgIHN0YXJ0X3BvbGxfc3luY2hyb25p
emVfcmN1X2V4cGVkaXRlZCgpIGNhbiBiZSBpbnZva2VkIHZlcnkgZWFybHksIGFzDQo+ICAgIGlu
IGxvbmcgYmVmb3JlIHJjdV9pbml0KCkgaGFzIGJlZW4gaW52b2tlZC4gIEJ1dCBiZWZvcmUgcmN1
X2luaXQoKSwNCj4gICAgdGhlIHJjdV9kYXRhIHN0cnVjdHVyZSdzIC0+bXlub2RlIGZpZWxkIGhh
cyBub3QgeWV0IGJlZW4gaW5pdGlhbGl6ZWQuDQo+ICAgIFRoaXMgbWVhbnMgdGhhdCB0aGUgc3Rh
cnRfcG9sbF9zeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKCkgZnVuY3Rpb24ncw0KPiAgICBhdHRl
bXB0IHRvIHNldCB0aGUgQ1BVJ3MgbGVhZiByY3Vfbm9kZSBzdHJ1Y3R1cmUncyAtPmV4cF9zZXFf
cG9sbF9ycQ0KPiAgICBmaWVsZCB3aWxsIHJlc3VsdCBpbiBhIHNlZ21lbnRhdGlvbiBmYXVsdC4N
Cj4gICAgDQo+ICAgIFRoaXMgY29tbWl0IHRoZXJlZm9yZSBjYXVzZXMgc3RhcnRfcG9sbF9zeW5j
aHJvbml6ZV9yY3VfZXhwZWRpdGVkKCkgdG8NCj4gICAgc2V0IC0+ZXhwX3NlcV9wb2xsX3JxIG9u
bHkgYWZ0ZXIgcmN1X2luaXQoKSBoYXMgaW5pdGlhbGl6ZWQgYWxsIENQVXMnDQo+ICAgIHJjdV9k
YXRhIHN0cnVjdHVyZXMnIC0+bXlub2RlIGZpZWxkcy4gIEl0IGFsc28gcmVtb3ZlcyB0aGUgY2hl
Y2sgZnJvbQ0KPiAgICB0aGUgcmN1X2luaXQoKSBmdW5jdGlvbiBzbyB0aGF0IHN0YXJ0X3BvbGxf
c3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCgNCj4gICAgaXMgdW5jb25kaXRpb25hbGx5IGludm9r
ZWQuICBZZXMsIHRoaXMgbWlnaHQgcmVzdWx0IGluIGFuIHVubmVjZXNzYXJ5DQo+ICAgIGJvb3Qt
dGltZSBncmFjZSBwZXJpb2QsIGJ1dCB0aGlzIGlzIGRvd24gaW4gdGhlIG5vaXNlLiAgQmVzaWRl
cywgdGhlcmUNCj4gICAgb25seSBoYXMgdG8gYmUgb25lIGNhbGxfcmN1KCkgaW52b2tlZCBwcmlv
ciB0byBzY2hlZHVsZXIgaW5pdGlhbGl6YXRpb24NCj4gICAgdG8gbWFrZSB0aGlzIGJvb3QtdGlt
ZSBncmFjZSBwZXJpb2QgbmVjZXNzYXJ5Lg0KDQpBIGxpdHRsZSBjb25mdXNlZCwgd2h5ICBjYWxs
X3JjdSgpIGludm9rZWQgcHJpb3IgdG8gc2NoZWR1bGVyIGluaXRpYWxpemF0aW9uIHRvIG1ha2Ug
dGhpcyBib290LXRpbWUNCmdyYWNlIHBlcmlvZCBuZWNlc3Nhcnkg8J+Yij8gIGFmZmVjdHMgY2Fs
bF9yY3UoKSBpcyB0aGUgbm9ybWFsIGdyYWNlIHBlcmlvZCwgYnV0IHdlIGFyZSBwb2xsaW5nIGlz
DQpleHBlZGl0ZWQgZ3JhY2UgcGVyaW9kLiAgDQoNClRoYW5rcw0KWnFpYW5nDQoNCg0KPiAgICAN
Cj4gICAgU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPiAg
ICBSZXZpZXdlZC1ieTogRnJlZGVyaWMgV2Vpc2JlY2tlciA8ZnJlZGVyaWNAa2VybmVsLm9yZz4N
Cj4gICAgUmV2aWV3ZWQtYnk6IEpvZWwgRmVybmFuZGVzIChHb29nbGUpIDxqb2VsQGpvZWxmZXJu
YW5kZXMub3JnPg0KPiAgICBTaWduZWQtb2ZmLWJ5OiBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNr
QGtlcm5lbC5vcmc+DQo+DQo+ZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZS5jIGIva2VybmVs
L3JjdS90cmVlLmMNCj5pbmRleCA2MzU0NWQ3OWRhNTFjLi5mMmUzYTIzNzc4YzA2IDEwMDY0NA0K
Pi0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jDQo+KysrIGIva2VybmVsL3JjdS90cmVlLmMNCj5AQCAt
NDkzNyw5ICs0OTM3LDggQEAgdm9pZCBfX2luaXQgcmN1X2luaXQodm9pZCkNCj4gCWVsc2UNCj4g
CQlxb3ZsZF9jYWxjID0gcW92bGQ7DQo+IA0KPi0JLy8gS2ljay1zdGFydCBhbnkgcG9sbGVkIGdy
YWNlIHBlcmlvZHMgdGhhdCBzdGFydGVkIGVhcmx5Lg0KPi0JaWYgKCEocGVyX2NwdV9wdHIoJnJj
dV9kYXRhLCBjcHUpLT5teW5vZGUtPmV4cF9zZXFfcG9sbF9ycSAmIDB4MSkpDQo+LQkJKHZvaWQp
c3RhcnRfcG9sbF9zeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKCk7DQo+KwkvLyBLaWNrLXN0YXJ0
IGluIGNhc2UgYW55IHBvbGxlZCBncmFjZSBwZXJpb2RzIHN0YXJ0ZWQgZWFybHkuDQo+Kwkodm9p
ZClzdGFydF9wb2xsX3N5bmNocm9uaXplX3JjdV9leHBlZGl0ZWQoKTsNCj4gDQo+IAlyY3VfdGVz
dF9zeW5jX3ByaW1zKCk7DQo+IH0NCj5kaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlX2V4cC5o
IGIva2VybmVsL3JjdS90cmVlX2V4cC5oDQo+aW5kZXggOTU2Y2Q0NTliYTdmMy4uM2I3YWJiNTgx
NTdkZiAxMDA2NDQNCj4tLS0gYS9rZXJuZWwvcmN1L3RyZWVfZXhwLmgNCj4rKysgYi9rZXJuZWwv
cmN1L3RyZWVfZXhwLmgNCj5AQCAtMTA2OCw5ICsxMDY4LDEwIEBAIHVuc2lnbmVkIGxvbmcgc3Rh
cnRfcG9sbF9zeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKHZvaWQpDQo+IAlpZiAocmN1X2luaXRf
aW52b2tlZCgpKQ0KPiAJCXJhd19zcGluX2xvY2tfaXJxc2F2ZSgmcm5wLT5leHBfcG9sbF9sb2Nr
LCBmbGFncyk7DQo+IAlpZiAoIXBvbGxfc3RhdGVfc3luY2hyb25pemVfcmN1KHMpKSB7DQo+LQkJ
cm5wLT5leHBfc2VxX3BvbGxfcnEgPSBzOw0KPi0JCWlmIChyY3VfaW5pdF9pbnZva2VkKCkpDQo+
KwkJaWYgKHJjdV9pbml0X2ludm9rZWQoKSkgew0KPisJCQlybnAtPmV4cF9zZXFfcG9sbF9ycSA9
IHM7DQo+IAkJCXF1ZXVlX3dvcmsocmN1X2dwX3dxLCAmcm5wLT5leHBfcG9sbF93cSk7DQo+KwkJ
fQ0KPiAJfQ0KPiAJaWYgKHJjdV9pbml0X2ludm9rZWQoKSkNCj4gCQlyYXdfc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmcm5wLT5leHBfcG9sbF9sb2NrLCBmbGFncyk7DQo=
