Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9315E6288E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiKNTIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiKNTHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:07:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDBA233B6;
        Mon, 14 Nov 2022 11:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668452872; x=1699988872;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yfa9qZtBy+/Ha50kkGudqyMk72GUyxmppDKrJaRUah4=;
  b=O0vfubOO7D+cRuAXjgLM8MDWRMo8DrqNnNdVlgD5DkAfZlWveZM2IoJp
   3lnNOpu0f92My2NKmZyxnkXa8HJnSotWG5vJHdctiKOVOrebaU/2R+oQ8
   1HR7hEwyGAKmbeU8UVUwLFTddsyzkCr7AufpDGWVQSCPFlHk2eWr/Mm0b
   vymUrV/FL7btgzSmox7dFyHREgHyMsL+bCbN/svuU9E4QIh6MG86m3QkG
   hjB3bjb/qXskONZN/DjBq7Z5gyIB4QEVRiZYPybmCpJ7fc9zmNZbRDhb0
   +7m7R3CFazWiHB8rN3Yc6I4f3RwYWuaUbp7PSl8DADLEdxkfzGbclTidn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="309685663"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="309685663"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 11:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="671685070"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="671685070"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 14 Nov 2022 11:07:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 11:07:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 11:07:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 11:07:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwmtbTOs7p5CxXt2miWedBtPID97ow/uIL632Y8EQ+AcDOJyNVipobGm4YOPh9V4EqwvbyFrRGrKc+2Ww+/2+Xugzh20OxHkuqgqzL5ai61HfBiSXTpx1DemlzWLxa6HlvkVLjrGrmfHdANQKJyQ1zhksA0LIhiP+57opBMEm4slVJT4TjP0vNW5sq2OBuBFgzqfG3D279AmdA12dsyLe3SZrbIUcVATJ0+2I5LaV0i2aCJ1rfIkBCgZCfFqYkj48A8k/k1GDsMoJdIYWcjkQqZbLRsQJv7Hx+SHDItmzHF+PlTj5/vvtenapF9oYJihBPSvIdZPfdYQ8d2bG9gSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfa9qZtBy+/Ha50kkGudqyMk72GUyxmppDKrJaRUah4=;
 b=ffYn97Fmb3mg6EPxbCXQSZSQFxP7x2gJh/dLVuaIa5s/KYKFKVYpYJZZi6XNehpeU594jq5jzG4T76pAL2Ar8KcXZU6ntU5HL1h75yLjhIOG6DbhmKod+sFlI8nJqNe5j4ZykR9L+jj/UCs2BpBAyk8svyhLoCadhSGyIwmubgThHp1GpunNF4hU/MI9WUVVrW9JmFkxUSmeP4aSz9NX5lS4QDRwHFPmbaNRZ+uezRsa26g6M08pHgcio6vQF+/a0DoM4gg2YnyAmAu6uiGijF2UfNsdWnzo69vuaKgtUZam83lDy8F1UasHkXfrqcaf3RP6xusFyb2UkdsimFbOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 19:07:48 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014%4]) with mapi id 15.20.5813.012; Mon, 14 Nov 2022
 19:07:47 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: RE: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Thread-Topic: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Thread-Index: AQHY8vv3UouK3GalXk6mzwRA6fUNf647gQ8AgAAjoWeAANrsAIAARioAgAA5qoCAAAw+AIABuAMAgAAOBoCAAABzAA==
Date:   Mon, 14 Nov 2022 19:07:47 +0000
Message-ID: <SJ1PR11MB608361084E83E74EA348630BFC059@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com> <Y2/JNAmSoYlLKq3A@zn.tnic>
 <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com> <Y3CevK2zhAmiUyG9@kroah.com>
 <Y3DZmKYV+8HBtZ+Q@zn.tnic> <Y3EJ93xzgC/1v0WV@a4bf019067fa.jf.intel.com>
 <Y3EUPKWDefnkeObR@zn.tnic> <45aa0f69-2523-3cba-8f41-b1351f16b78f@intel.com>
 <Y3KRGx/yNfS78zQ2@zn.tnic>
In-Reply-To: <Y3KRGx/yNfS78zQ2@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5252:EE_
x-ms-office365-filtering-correlation-id: e2f82e66-cd8f-4d04-b30c-08dac67384d9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eeHWgVDqpJjABeGKKnabeVTuaPka6n+fkoPa0Ve6XRp4IumhaNw0dwb1xDeYrPE1QjgFQbFrPAqXIDBgHw1VH7OY+2DSdJ9/1BJu2HsrjxX/8XqPPaj0bURbr25K6Ams4lcKD9ThjANYavcPDEKicBveRpTGK2+xm/uyTebIjP3gFbkLZCNvvS6jiLR+Hf13XxIPLrA2yEuhPjSWeHPor2OHbHIHnXTnnQRhVk7kkN07RGFQP6E8SkcVERoadfqeGyK7RoywSct0awVFxxdYxgv25qpoBVmtl4BYjQqwRVtfWM+shMyGvkb98nElVQHdOa/Rot+fyXFCUOwAW3a12MONFX+MrJfu3z8vSj9vMajlf0/lFEt8eRhNRs/gLbOgx2oHT/hHaSDYKvDrks2DEFssse+vsQ5itYQDCoxIIoWZyXxmoszvmciNLIglZNK7Po2PmgcWwiLcu0IVbQ/26oQKBDs7TG74TFYFZSactR7J7uxiZV/JnMYDRQdpgbdofUk+uHjahCaRoEmVfqKmbraAoaXeUZEyVmVOEadcQtxqz4AiKVm3JxU4erdPh1LTKApBHxXzK6s+zNbcxIXclKQz6zb5DaQV5I7eHb7iX4mPoR/QRF/Z4PIX+XC8rS6e/w3KUyfXLJv8JRNNU31Xo+JvD64y7mud8EQvVThBPLGiuR846IGy6yZmmJmt8ZSNhabl46Ljf6kTjw9cZ3+k+iGONb/BDfUAYDljxVka3ErAaNyxkNs0Iz4HUJjLooXf8zmDqAqPdqvjKk5+93judQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(55016003)(41300700001)(71200400001)(110136005)(54906003)(2906002)(33656002)(7696005)(6636002)(122000001)(316002)(83380400001)(38100700002)(82960400001)(4326008)(66476007)(26005)(66446008)(9686003)(8676002)(7416002)(64756008)(86362001)(66946007)(5660300002)(66556008)(186003)(76116006)(6506007)(38070700005)(52536014)(8936002)(4744005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1E1bGRoeXpxVXh6c0dmYmZheDZIQlhYN0lTZnBWRlVIUStZTWphTnhBMis2?=
 =?utf-8?B?ZldESXVYb09vVFdOcEJDQUx0UzlKL1B1Mm1WQ2FBQkRBOXZGallFR2hGOGhu?=
 =?utf-8?B?SVZDdWlKclFvbEQ3bmt0ZkJPdWNyNEVqdzd4dmdyNldQWXk2OU5HMXJPc1Va?=
 =?utf-8?B?UHQ2ak9zVGhYeDM1R3pvSzJjdTRPZVBwVWVzV1FZUjl6dEMrNG9BWlo5amNT?=
 =?utf-8?B?V0wrVkZTNTloS1k0aDAvQ0VKYmJncWM1VmtXenJYc1VraHg0K25pOHptelZy?=
 =?utf-8?B?NUlFdFJTcEgwRXZoMjBCVms2OGxoZHZxT3dPbFdXelNBZUJUL2FnVVB3b1ZO?=
 =?utf-8?B?cXI2UklhQS84ZDFpUFZSR3lFTk9mWDBycGVXY0drSkEzckQxV1Zrek1IbTV4?=
 =?utf-8?B?dEJQcjNLYUVrMTNuaDg1ZkJUTE9JMXRLTXlkQUVsNGFRclJMTDRUQ3g3NHBT?=
 =?utf-8?B?RWFiQzZ4ZGdIS1VUdzlRd1drQ2JteWJvUVU0WkNNc0QwVlhUMjB5WFVML3d1?=
 =?utf-8?B?ZVpxZ1UxT0tZV3ZrS1ZENTFuTHBVbE1Qei93bE1Zamh5MnBRbjMxUExybEhY?=
 =?utf-8?B?T2pMRS9lODRZWkFpc1RFQ3k5V3lOYjZNZXR4Vzk2R2dxTnJlQldpM0dqOEtX?=
 =?utf-8?B?SkxPRFF2TVZnZ2Z2bGV6TW1PWjhBaXBtYVJLQmlDM1NaeU12akJNZlVEZ0dP?=
 =?utf-8?B?RGpObHJtOW5rR0Q2QnU1UjNJbFN0QVliQy9DU0tGd1FSY2VmQ0t6azBHMFFj?=
 =?utf-8?B?cmV6cU4rMHNQaFhsMHJsVitQVnc4RlV5UnJHWTlsajZ6YXI5YTN4OTdzNW4x?=
 =?utf-8?B?OEJYaEZzK25SVnpJSWViV2EyeThvN1piV1Z4N0VyVytleFA5QlJYTlVOMDA5?=
 =?utf-8?B?S2FrV3dYSVpoaVZhZzl6eUVKMUtZWkFyZTNPRWplYkxKR1FqcjNjYllqZVdr?=
 =?utf-8?B?Tlp6U0dJRnlzNTVGTDRRVTNVL0FraHp2dEtaanFwWklOUDdHb2dpZlpRUlQ5?=
 =?utf-8?B?SVFaTENXMHlXdXcxTk04bFZKQ0ZOTXRZK3MrT1RSMElpSUZrQ0RDdndibzJC?=
 =?utf-8?B?UXJ2RmpneVVUVVIwbStHYnFEd1h6OFYvcDlvekZxdlpMTjRtd09xSjhzSmlU?=
 =?utf-8?B?NCtKODN5bkhRVk5Cdnk4WWltSkphenBGbDN2ditpOXlVVTZoOUdmc0MzYUg3?=
 =?utf-8?B?ZTdkU0V1VkFINXlraTZEWXVDVUlJNHN0R0ZWZVRaSW1tcDFZUm4zajZQaGFW?=
 =?utf-8?B?SnRPMVJRazJtMXF0RldZWDNmVzJITTN3NnNrWUJqN2YralFVdHJqbnZ1NVdV?=
 =?utf-8?B?MVNOQmlrVWVvWDJTY3hzUkVaWUZoZDBid05neXNVTG1zRTBRYzlpUS9jU1o5?=
 =?utf-8?B?VlUwSloySE9vWnBnNGliMDBVRnNabkZzU2x0cFp0a213L3JUM08reFltNEF2?=
 =?utf-8?B?aU52bGJ1MExWMkcvWjAwdnBRTHJxRWRUQ0NEaE1wbldLWDZjeU5mUFBEREx4?=
 =?utf-8?B?WlZFNHJ0bjV6MkF2a0RjaTNrQXgrMzRZY0o5U1ptME1tdXM5UTVvQ0szaHNm?=
 =?utf-8?B?aHl6Z0JOQVBBM3BHQk5HdWR0WDR2eUFkdXpEWm5IU0NpdjZYcmhpMTBldVFK?=
 =?utf-8?B?SytyV056bksrL09PNTd2aExWdEN3VElZSEtvOTR1MGU4K2RKdHZVR0FtN2Yw?=
 =?utf-8?B?TmJpNS9xT3ZKeXIzWUxmMU1UQTBEMHhZQlhDaDhScXRKUlRmcGlucW8xaEZX?=
 =?utf-8?B?bFZKSFkxM3hWang4TmlZeEw2N3ZMZ0xSQXZFUHM3dHhQZytOeG8yL2ZjSkV0?=
 =?utf-8?B?a1JmK0tVMWg3Nm53M0NtaXRQbEhiNi82TTdPRFU2Mk5ycS9FZFZRd1EzRmVV?=
 =?utf-8?B?OTUrcFFiYTJzV1JJQ25BUTZFRlcxbThud000a1N6UXVtNEx5SmV1WGlJQW5P?=
 =?utf-8?B?VG1mUXA1QTFTQ3dMMWUxa29udlVhem9MMFkzRGdpdmFKemtFNWhFYitrYUdG?=
 =?utf-8?B?MGpHUTN4YlZvdG1TZy9RZURCTUQvSDZWTzhNTG1nYTRDK1pPZ2l5aTJNTjhL?=
 =?utf-8?B?RFNmdDJpT3ZKTStWMTZMZjhDMTRmcEhjVDIzY2pqbTVCcTlwZXAxeDVLdmhk?=
 =?utf-8?Q?+Hs8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f82e66-cd8f-4d04-b30c-08dac67384d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 19:07:47.8119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqpwnUQ2DLX1AkTXsSizY7K/ddPeX4rVEYbSY4N3gBifKsP5epiIwPFs8372qKDBTR+2x7CtF/u3rGOqcmMgZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBOb3cgc29tZW9uZSBjb21lcyBhbG9uZyBhbmQgY2hhbmdlcyB0aGVtIGFsbCB0byB4LXksIHdo
ZXJlIGJvdGggeCBhbmQgeQ0KPiBhcmUgPiA2LiBPciByZW1vdmVzIHRoZSBzZXF1ZW5jZSBudW1i
ZXJzIGNvbXBsZXRlbHkuDQoNCldoaWxlIHRoZXJlIGFyZSBzeXN0ZW0gYWRtaW5zIHdobyBtaWdo
dCB3YW50IHRvIGRlbGliZXJhdGVseSBzYWJvdGFnZSB0aGUNCnN5c3RlbSB0aGV5IGFyZSByZXNw
b25zaWJsZSBmb3IgLi4uIGxldCdzIG5vdCB3b3JyeSB0b28gbXVjaCBhYm91dCB0aGVtLiBUaGV5
DQpoYXZlIHJvb3QgYWNjZXNzIGFuZCBjYW4gZmluZCBhIG1pbGxpb24gb3RoZXIgd2F5cyB0byBi
cmVhayB0aGluZ3MuDQoNCi1Ub255DQoNCg==
