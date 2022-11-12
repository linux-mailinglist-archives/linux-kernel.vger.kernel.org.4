Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9CA626B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 19:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiKLSeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 13:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiKLSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 13:34:13 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C92314D1D;
        Sat, 12 Nov 2022 10:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668278052; x=1699814052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RtJQ4ZDK6GDUZoELso8j5ykg/LIA/l6B8iZnihbcmL0=;
  b=kPKfn6AFd5mW2KfP8a4voppHu1MhPXZ0b890gtkMTOZCtflrAG4dffHh
   wy0fp5qmwU0vHF8+qRgUEqZZslunCOqaAndEMc2K3FAnBsQcVYVi7k7V8
   YGtkSMxyA3bEzE3Qh7siEThwqkPzVK/j7MJ04ME1D4RhYYRwnin37rGFz
   N6C6i9ivZQlAxCy3z0C1AIZmkdx6GtBe1bSOkxwEPLTwz2EJZvBrtw7su
   ooXjZoMtOhYhY9jPSeVS13m/mhro0u9TWEOuBUfMES+LPgq4lXkgcmSeb
   hB5ZyoMjL4KJLTNtdJCXU5hjbQOu3oZyefAEy9h1l2eY/DlG3uJ8X+jaR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="310460519"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="310460519"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 10:34:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="632309843"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="632309843"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2022 10:34:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 10:34:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 12 Nov 2022 10:34:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 12 Nov 2022 10:34:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzEmNjX5zbgQrwRofL6/a2SEoE/SG59SzLeNEnnKgwhX2jCbbK4az3yjJiA3azy2V0Je7O1dh+9yBSiGYKD0wdF4gAWDj0WRazsWrR2bpeHuR9VyDxklzCadHm94fyWte4JE3/nmtEXo2/MBr3bFqNdiNfdraJrPHpYD/Zhcur8vDrxiPFr9g7xEmpTO9kpG48MadWPvVcfBvW/C3udIRZKBxPbVD2rjlVg1P55HOqm7S+PioOikQPzNTzbYLRQEvxrzdiISQrcdewH24us+GB5lgyvhckTkrIu+yTU89ZSCzW+24t5UvLF45W+UOEgiM3TYeNmOgRgiSUGiyWjl9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtJQ4ZDK6GDUZoELso8j5ykg/LIA/l6B8iZnihbcmL0=;
 b=UdGlBskC0HIs4LFBoaCChereBt+efDkQtuWvHFvmoY8A7xr1zv8UmbNYLVWQBKs6nGjRlyZduXD0xdwH+uzVOPEFkcu0FEvWwndNoJSprD9XWpBU/8U6nc3yRRZwldHkNPS3dB2odRfV7v+jR/LgpU6MkLIAWSJ/ITEtIHj05Muj8HvOAQS4B4gG+SuOixbof5fsA7NrFXnO5UuXYG+YLGgEphzMhowvTZuWU2W7lfl65mPr4tj6jGPYbQ3aKCMBjQ9I9bzAGtgxhkMYeur34YwBTYV+H3P/CrYEN+iV28Rf84+hv4egL7pwgUrw9iG0Qr6bs7god4XbcFCkjgHQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5320.namprd11.prod.outlook.com (2603:10b6:208:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sat, 12 Nov
 2022 18:34:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014%4]) with mapi id 15.20.5813.012; Sat, 12 Nov 2022
 18:33:59 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Thread-Topic: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Thread-Index: AQHY8vv3UouK3GalXk6mzwRA6fUNf647gQ8AgAAjoWc=
Date:   Sat, 12 Nov 2022 18:33:58 +0000
Message-ID: <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com> <Y2/JNAmSoYlLKq3A@zn.tnic>
In-Reply-To: <Y2/JNAmSoYlLKq3A@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5320:EE_
x-ms-office365-filtering-correlation-id: 47d1da29-3e31-4509-ffe0-08dac4dc76a2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JapcXgRZY2Nwa6txcUqBuJ73uEHRfbFdmQdpkf+Bo1D7kVm9UderNPno7HF/gFy8zE0A0VV+Iwc5uhruYCoDUvvLehb0YHqFtIH08IgT9QdNAB5d0q9hdD8ynae3zMbi2qhZwnmP8Yc4dFJ753wwtJyvlsRxFig0SZzd+cikgcsC88riU64bT2pkB5A1796Gq6H7J9DV/AcOF+JVTryha99MeMGoPyONgCKvmOX6dUTJCuuA5RL7qF2XaU7rZzTj2M7u56yBdA2OadAoauCxszeorLsJw+/GUZoqgI2fOtTmgSZow3GwT/LBs/VXTeLRV7XNxa5cBY69JOups81pEaW+l/nQUu4M7aPC7ppaXBYWD65eU+pAJjf7L5ThzddxEh+WAliVOJVjpbtAv8Hp3xarT9P4jQLuAWYbdzkGMdJZxKb00uFh+Ja9u915KrymCHHOBtNUnVAYpYR0+Nrn5EFdMfTETW4nw1uc53U4JrS3mQwYq4qmed59B0ESJw1owS+MsA5M1+Tf+ZiTK8G6sdl99CGU5kGaOPjRrC5sy8CtrGRSeYoT4WhA54Lh8RBGA9NEjbWkVrK1XJEO4B58ZfptXKO55cp1GooZHm354Ma5+8XTsXELJ8iC1Kp9cRkk8xCazyPHrYABrW/Gv9pKx8yr1OGSMa187E6vEIcUYuh0xdhZO7vo1hyawa+7mIZ2nkyxile1CwagZ2tbZPf01MB7WPNTihJ99Kq8ULEW4tkYORX4IOFBYnGCirA1nZrVvumzFfSvJNdpolP9abbWPbAT0xNH5GCEicgxcZ6MeEM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199015)(86362001)(64756008)(38100700002)(122000001)(82960400001)(38070700005)(4744005)(2906002)(7416002)(41300700001)(4326008)(8936002)(5660300002)(66476007)(66446008)(66556008)(26005)(6512007)(71200400001)(6506007)(8676002)(186003)(2616005)(316002)(54906003)(6916009)(66946007)(76116006)(478600001)(6486002)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emZUKzU5Y1JGeUxrSTl0WmNMWWtmMXdKdGwrOGlqdzlDMGFXck1SRkM5MWZi?=
 =?utf-8?B?Z2RhcEFCV2ZQek1Kd1BpTlhFNmxkUnM2SEJnVWk1N2hVQjY4ZzZsOGtCUis2?=
 =?utf-8?B?cElnVXVyQXFhTzFSQmRybGxyMDBCclVFUEp0Uzg5bWpqYVR1QmtzNnVDOUwz?=
 =?utf-8?B?dHJYcng2bko5UjlZMnRkcDlHejUxL0N4TzZhWllZMGYxZTFHOFoyam02enRo?=
 =?utf-8?B?RkpIT0hjNWlOSXN5Syt4TWRXSVVWeTFFd3R2VFFLS1BrZHlvVHUrWnRRY2hW?=
 =?utf-8?B?ZjI1YlFyUFM1Rk9ySFJEL3kxbkxpeHBNZFVnYmpWRFFvZmZXRHhCcjVCZ1pU?=
 =?utf-8?B?Q3BsN2dJeDEyZWJvVEQ4K3YxOWJTdURydmc1V21hSmlzRkk5djhhVzNRSGU1?=
 =?utf-8?B?VG5rVTJOVUxyZ0hPV0Y1MFpZaFVwQ1VEU1hJUWlsc2oyVHgvbjV4ZzRHVkI5?=
 =?utf-8?B?RkNYYVpESnJQajVJYkJKNU1JbjlKenFIZWVLVkFhT2JPdmdPOHg0T1hSUFR5?=
 =?utf-8?B?VTlXbmFYQTlIeTYvcW5JWHU5eVpFdzhuOVZ5Z2NxRUVMWFdEalhIK3hoNER3?=
 =?utf-8?B?M0hFbXNaUUh4dXdqZmlyTFd1blY4MXpNamdPajNwdm0wUUJxdlNkK2RBcS83?=
 =?utf-8?B?VVlBVUhYWGhGbm5tQjh4T1hSOEVpYlUreXdsRTVTUXpSUi9ndVRERHdDTkJa?=
 =?utf-8?B?Y1NpS0kvNnJ5MGJISW9ROTY2NmJRczF0aWYrMk42d3FVTk1IQUNLSGsyaUVh?=
 =?utf-8?B?V080Y0RVMVlEVmdneHNuTWlFdk44VHZpWTRVTWZRTk5vekNrL1BzVEplOTd0?=
 =?utf-8?B?SFVxNlU0S2FGMS8vek5Ca04yc0QrVlROQTVCMHhrRG9HZVZNS094WDNyek10?=
 =?utf-8?B?R0VFamNOM1BTR3NnRllubkI4djM2U01zSUpmVmsvdWtJTkhjbDJpUEJsUkFq?=
 =?utf-8?B?TXE2M1ZoSXo3WmNpN05YeG1sTlFyUVROeHE3L0txT2Z1ZERwZ1BYNm1xV0FB?=
 =?utf-8?B?U25KRlVtTHpYeU5iUzBOWGVSb0FTcUNmZys3eGVtUm5hb0RZMHFNUWxDV2xn?=
 =?utf-8?B?dCsvd1dXbzAwS1BBQnNjUUlFdVl4VXFocERNVFIydTE1RzE4ZWpSWGZvNTI0?=
 =?utf-8?B?TFhjS2JYSzROVlhaWlFZM0JObHRWQ2ludVF6S0wwNSttSGNtSjFPMlVIVHFs?=
 =?utf-8?B?UWVuZFB1Rm5WbWRYRmYvY25sTjJUazhIc2xtTTROb211SHFZY0tjajBWWXJs?=
 =?utf-8?B?RlpUTFlrTHdTTDJHa3J6Ull1TzJVZno4eFZEcWhMbWdQdkxoRUNVSHdMZ2Zl?=
 =?utf-8?B?Kyt3QkRoNi9samVqY2J4bGFyanZObWF0U0ZMNCtHZWJQeDJad2R1OE9sNUx2?=
 =?utf-8?B?QUVvc1BhT3VTZnkyWFYwQlA0NEVuaWxuQXRjcUM4bjJHdXpTM3Z2UHpNUWN1?=
 =?utf-8?B?c24rQ0szUVJ0WjNYWXNwSFUydzlvZDhpYjhsV1BUMlZJT3N6WXdoQmtQdjJ1?=
 =?utf-8?B?R1hmNmtYdkJoK0J5bVVTVE0vYTFTV3NIbUExb3UreC9YblZYSW5RZlB4TW9y?=
 =?utf-8?B?enNDU3VwdFI1Rm9HaU9CK01sNS9EamVZQWxWYS94ZFUyQWJYeTJGY1FtV0xY?=
 =?utf-8?B?Uk9SNWZvMldGdUxFRnRIcUhOQVEwT25aeHpDN25EdXhCMHl2eERwRFRyR1pD?=
 =?utf-8?B?NFBMbXkvUGw2RFQ1cDQ3UWxKc2pzeGExQmp5cWlMRzNhKzBURmNwWjl2dWg4?=
 =?utf-8?B?aWFJVVBZaGFQcTBmZkZWcGJNT2lXSGZGeEtlMUFmOTZsMFRzNWs3MVFDK2Zm?=
 =?utf-8?B?S0w0dDNnVFNMQkRHVHMxQUEzZUF1YzJDMzdFWDZ2U0lzb1NuUDh2eTQwZWNI?=
 =?utf-8?B?QUNnTnNSMHlDT05WUG0vSitBdDBjZ1dZeFF5MllmRkl2NWQ0Vlk0Vm9kYWNn?=
 =?utf-8?B?azhkcTN6TXp6UWNCdGJhNEZZeSt3UDhSci9uUGkyaGg2ckh3UHpXQnFzWUlU?=
 =?utf-8?B?TWdNNThmOXBwQ1hUcjkvRExFY2k0RVQ1Rk5zd29kWTE4UXhIakVtdU9EdkRp?=
 =?utf-8?B?bkFzZmRHVk9aSlRiaUJWelozcnhKTThSZGNjUUFxTFdUcWNXSWlLbzZmeTNI?=
 =?utf-8?Q?PJUYMxTib7Ce3KBZOYGxYVWWC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d1da29-3e31-4509-ffe0-08dac4dc76a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 18:33:58.7964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxzdyG1IfaW9/IDcFL3Pm3RYNDYxdyFMjoScHBstFDvHCP0/Q5YO45o+ynGYGLFa4WmD+pKciVR+DfKiv8g8xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5320
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IER1bm5vIC0gc291bmRzIHNpbGx5IHRvIG1lLiBNZWFucyBvbmUgbmVlZHMgdG8gZ28gYW5k
IGxvb2sgdXAgd2hpY2gNCj4gZmlsZXMgYXJlIHRoZXJlIGFuZCBlY2hvIHRob3NlIGJhdGNoIG51
bWJlcnMgaW50byBzeXNmcyBhbmQgc28gb24uDQo+IA0KPiBXaGF0IEkgd291bGQgZG8gaXMgbWFr
ZSBpdCByZWFsIHRyaXZpYWwgZm9yIHRoZSB1c2VyIHNvIHRoYXQgbGF0dGVyIGNhbg0KPiBzaW1w
bHkgZG86DQo+IA0KPiBmb3IgZiBpbiAkKGxzIC9saWIvZmlybXdhcmUvaW50ZWwvaWZzXzAvKi5z
Y2FuKTsNCj4gZG8NCj4gICAgZWNobyAkZiA+IC9zeXMvZGV2aWNlcy92aXJ0dWFsL21pc2MvaW50
ZWxfaWZzXzAvdGVzdF9maWxlDQo+IGRvbmUNCj4gDQo+IGFuZCBzaW1wbHkgc3VwcGx5IHRoZSBm
dWxsIGZpbGVuYW1lLg0KDQpXZSB0cmllZCB0aGUgZnVsbCBmaWxlIG5hbWUgaW4gYW4gZWFybGll
ciB2ZXJzaW9uLiBHcmVnS0ggd2FzIHVuaW1wcmVzc2VkLiBCdXQgdGhhdCB3YXMgd2hlbiB3ZSB3
ZXJlIHRyeWluZyB0byBvdmVybG9hZCB0aGUgbWVhbmluZyBvZiB0aGUg4oCccmVsb2Fk4oCdIGZp
bGUuDQoNCklzIGl0IGRpZmZlcmVudCBub3c/DQoNCi1Ub255DQoNCg0K
