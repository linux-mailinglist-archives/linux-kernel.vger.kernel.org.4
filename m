Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254C865C8DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbjACVYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjACVYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:24:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFDFFCDD;
        Tue,  3 Jan 2023 13:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672781043; x=1704317043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PuiZtYtS9/n9911i2Pdw9QoQ7L2tzXXTpLObQ1cQRpc=;
  b=U8ZNGvLvk78V7dFev/MBii1H78oyAtdSsopR+qu/u/nt0cHk1nwqWTio
   JQpcTFLwOjzv0ZE1JLiFdPiDk05SY+PyzHzXG3e/06Q7nxJR3PfRwEctf
   D+YgSrFWvF2/762ZUzVTGwFRoADmGI74qKj6puQdjof8Jv5BaLRGY4rrc
   jcAauWi4z0+HSJ+2wvy9Jmzr1Buchi6G92Wqyf2KRDYZAgVq50frOvH/N
   b9H8rlQoN4w16VUGwjK88O42zIV7S+n/vW6PG23TXID3lbcPBJKPvzw+r
   xW8js7yc5Xe2pnI1VVTIL5xdjjOviu+BnZ2LuG2Q9yjPcnIfAc3GKCC4o
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="408016812"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="408016812"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 13:24:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="656898884"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="656898884"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jan 2023 13:24:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 13:24:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 13:24:02 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 13:24:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3ZhCNd7dlmx/Y5bPRB62wSGojRjZILXWuEIUFThrAMblsZ61fYt2/tAbqNPytt2ZdtA89jAv4opZAwJel14qOd8jrXYBMLRsGI7bnMHnsZr5lWnq6b6OvqmIIHZrWVAV4OjceSmJrraGW0YtbDEgcfGD15Fam3CK6XYmpWGWTnyAlJiW2nzrfblSRxA5kgRnQ8VH/H+UBhd0x8RUP60oMahmw9bkF3YJqEgcMHFLHJMaFNzECmkmdPiwOcaf9MgM1wnGomyQgNZBQxJR8q7JjpTUKZoHryyPk461RLFT3hNkKtrGHB5MFME/uuv/tCK2xLn/IQSkm5Ql9KIPxHpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuiZtYtS9/n9911i2Pdw9QoQ7L2tzXXTpLObQ1cQRpc=;
 b=GiVjUQflBo20s1U/7OG1L3Es7Gse8d00MWLYHGfxUy6e5Iewkr/z7CqMKXcDTjiQ25MQcgaLF0qWYgpvBB+vYVAdXr1Md9eJFScxLEW6MLtdhepVZxJIEzN7CmZel0y8npqR6DbTfyiRfVMuSWaPlxVABK0ELoJuq0+v+T81FsKEy0hdlnxKJ8r7W+SnzNAZxJGFBXSjMoA/RshcgOh/tWH1/snfmfzbM36s0I5CFety2/WzLijNnPodUg4oy3irjr1vdOYTxdNmPFSMsvDHr61pzgcm9ghZ3QYUQQn7eY+lQOqavZgQxd/INfJ6I2T3R45fgtEqCeIJXy+9/DosOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 21:24:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 21:24:00 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
CC:     "Brown, Len" <len.brown@intel.com>,
        "kvijayab@amd.com" <kvijayab@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Mario.Limonciello@amd.com" <Mario.Limonciello@amd.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bpetkov@amd.com" <bpetkov@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "santosh.shukla@amd.com" <santosh.shukla@amd.com>
Subject: RE: [PATCH] x86/acpi/boot: Do not register processors that cannot be
 onlined for x2apic
Thread-Topic: [PATCH] x86/acpi/boot: Do not register processors that cannot be
 onlined for x2apic
Thread-Index: AQHZHFU/90Ciuxi6gUqzVTlaWT7ada6NOfAA
Date:   Tue, 3 Jan 2023 21:24:00 +0000
Message-ID: <SJ1PR11MB6083AD01A91B546343259939FCF49@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221228114558.3504-1-kvijayab@amd.com>
 <0e299876606352ca868d7b71991c66a1c1d361cb.camel@intel.com>
 <CAJZ5v0hzo7zSWjbC2h4S+B1ZShmrz8q_TtuUTGRGarhdh2HA+w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hzo7zSWjbC2h4S+B1ZShmrz8q_TtuUTGRGarhdh2HA+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB7145:EE_
x-ms-office365-filtering-correlation-id: 14c23ef0-8bdd-4f41-7a59-08daedd0d4e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JtzUH3gRKABLL0iT/3mpdWCxonlzKPhkZYGkbh8EcRO/I1frcx05HNgyxaMH9dfwGwhJkaGeOUjLBG1VCD/h0LASF+KJVi08R3iJhGlxnl7k9TZOGglmWJAoBXOr/ELDdAw1ex3i8kK0abUrFddZJLfcdyLloJzPm53zHlSjpZGKuiDolQDGo6l097gNRRHpa7Xyz9nAG1ilEA5kw0rP3vvSQBVHmhGvNf/q39bwP78NGnA9JMvof+G6HIpKU6UF3ddICNBjtH8b+L4/ZzYjrkl3WoLNRgqPI9J4JWKg1agU5rFaRSpZa7JC9N+5OzI+s14mRQJzt7y/HmVvX8T9yABqBr0d3vaq4d9AbHKJQ16zoY+wilVEKYyoR2Xd6PDzQRElKJrYRldmyRK+h8CpxdW8X8dOtizSvAjS7wviTefZU3c9Vw6SHS7GPNcc/LQnMcdm7VQ69Q1JfeaqWfYAd8VKr4DTvYpdheHNj95E21Bhbgv4kbYgIjHJ65Lirb4rbqIagUOQuEV7pmzGFZ/0TF3TnZevzLxLvUK+PHqvhAsNcpHAIou8Kt+H40Xf9xzsM8BBlDpcAud1jRMsmkz9GxbeJZAl2d5Giq3/INHejQ4hhSVtImH5khNA+oyeI242ROQasuWq4xb7eNDUBSc3KwA/lEatpnVZOTegG3Ol87oHf8spptw5C6Zb8pcYroGl9lKTiqwXB0QppUbi6WZii8tm6PpI/3oltYFaI2+ceBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(4744005)(2906002)(8936002)(52536014)(7416002)(5660300002)(41300700001)(86362001)(33656002)(55016003)(38100700002)(38070700005)(122000001)(82960400001)(66556008)(7696005)(71200400001)(186003)(26005)(110136005)(54906003)(6636002)(9686003)(316002)(8676002)(478600001)(6506007)(64756008)(66446008)(66476007)(4326008)(76116006)(66946007)(22166008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0pSNEZnN0FhTVd4SFhCbytJL1pWc0dwRVVJaEllWm53MDRPS2RBdHAzcWt4?=
 =?utf-8?B?TENDMmZKRmt1ZFB5RGhzZXo5OEpaZ203aHNZeFNFS0IrZndGRnBSQ1hoMXZX?=
 =?utf-8?B?aXVlYVl6V1NLZVlLaC9oUUZWa2VkM3ZzWENNRVJPVE9XcGkwN0dEck5rSjNY?=
 =?utf-8?B?S1JheXlreWJmTU5wVlduN0RLaW9oOWtqYVU2MGdZdW1uaGlUdlVoV1UvNDgv?=
 =?utf-8?B?MTA2NEFMdGFoZlB3ZW1YRnlpeEJKS2k2Sk9ObEhUaENWYTBzTFNtdkFYd2Vy?=
 =?utf-8?B?Z0FRd3dsSXdmbm9sNmFITDdSUHlPUVMzR05zSkNONDBtMHRiT3FZM1ZwS2VJ?=
 =?utf-8?B?d0l5T0pVVlozM2p6UnpaNC9wckNTdXkweVUzaGVxdjRPM3NBcWRpaHpqdWNt?=
 =?utf-8?B?ZFB6OEMvOHpHS2pjZ2hhU2xjbFIxeTdoNUJxVFcyZzlKMnpSTmhGUVJqdVN6?=
 =?utf-8?B?b2RKSUtKaHVLeC9tc1g4QUtwZTdwanlMSDFZVGwrODRCWk5wSHAwVE5XazJ0?=
 =?utf-8?B?WVpEZENlcUI3M2J5ZWdrQ3VzTHZVRDhHaXNQU1UvaExKbkhMS0prY29HM20v?=
 =?utf-8?B?a0I3ekxLaVE3YzhrdlluMXdGb05LWUM4WWhSMUpjZHRSSWM5d045c1hXVEN3?=
 =?utf-8?B?a2FlaTZtVU94L0RuR3NORlB1bzdHdkRSeXF4R1pKUUZ3UWM0cytWWFQzbmta?=
 =?utf-8?B?VThLZkNaN20xUk5TazRBaE9LMGwvZkNGL0haMTBNMUpaYWhyMTRTZWtEcmph?=
 =?utf-8?B?a01lT1RIVjNMQnE4US9maW1teHNzNXY0a2xiUTVRWlVaTUVwQ1JJMEg1MFJk?=
 =?utf-8?B?ZlhQVlJoK1dvTDNUUlVnbTZYMW90Qk94bkpWaDlLWVFzTUllaGErTGVLcU5L?=
 =?utf-8?B?a29rWmdTUVFzSmhuSDNadnZuTkQveGV3eVdEVHN6RjZoRmdDRk0rWTdBeTRR?=
 =?utf-8?B?bEhHbGFubURZZEFIUjNsc0FWRk1lREQ3d2pPRG9IUmlmeDhoSDdtZ1RwdWlH?=
 =?utf-8?B?MXNqTEYyLzVZTHNHTWttUEx5dTJ3TFh3YUdXRDNmdm92eEdTWm1wM2dMeDc5?=
 =?utf-8?B?aUIvdkdzZmlJTWdsWWdwSnFtOGtZK1RjTnBKdERpcDRVckwwaG40ajlzSUYr?=
 =?utf-8?B?dVZkY0RsQTZ4UHZGVmNBSHlDK1RRT3Vvck16UlpsWFI3NWFKYlltZjhlRTlq?=
 =?utf-8?B?T3JzUWVreXpGY21EVkdQdjBiUC85SFFoaVI5cmp1VjNLYjh0NGIrWGdOYnpa?=
 =?utf-8?B?cVVoSmRicjFHMHM3TWMvbGtQWGhTelRoVjhJZytIY2lEek0wREZJb2FpVHJT?=
 =?utf-8?B?MHkyNEFMT3RjTlcxRGx0dTg3d3BJZlVoU1JQOWxHQTdTczc2UnRBUWIxZ082?=
 =?utf-8?B?c3lPZDZBWlpaSm9uRjdWZnVTSWVjeXR1anpnOXViWjNna1FSdVh6U1gyMHFS?=
 =?utf-8?B?ZnJ1ZE9Nc1cxUkxtSEs3VmR0T3JjQWZ2QVNzOUlYdTV2QmRKcDFrWEVwakp2?=
 =?utf-8?B?cThuRDBmZ2dNSHVuMUd2R3lEWmtuL0hyc3FsTTVLZzBlUWFETTlRSEY3WEhi?=
 =?utf-8?B?YTQ0VVRYUjFhdGpBVU5BeWNvL29ydFFVS3U1Z3VoUGxwZW5sNFlzN0hWSStD?=
 =?utf-8?B?M3RsczJJS3dyeHFTRVI5bUpOak41ek1PQm16MjYza0M1WDg1R1NRTXAwZGtV?=
 =?utf-8?B?K29TWjV3d1N1NGRaNmdWazdYejNPWHJBMzdXN2lmMUF2anliL3duSmk3TXFi?=
 =?utf-8?B?NWxhRktNVGhScWJhbTB0UHd4OFlETXY2Q3dZZFpZWStqNFhsM3d3TUdtSVpQ?=
 =?utf-8?B?OVE4NTF4Y0hSaERDVG82MzB4RkY5VDlOeVBrNTJaaUtwOWdzdmg1ZDBCR2Rs?=
 =?utf-8?B?MGhZa3ZDUFBWWVJqN1ZMMDFHQW1UZFFPSWVQRUIyV0xBVjJDUjhOamlFVXlO?=
 =?utf-8?B?MWtKTDdJZ0MzcDJDWEkrcUhsTmh2Rk9pV01kTjI2am5GYklaZGk0V1hXNE9Y?=
 =?utf-8?B?VUhRKzlPSjRLYWRlU2htN0NTcVRXYUpwNE0wZHpvZEtFY0FmMFMwSzlXZEZs?=
 =?utf-8?B?OWVwNk1vb0k5a1ZnUDJBM2g2MGVJUlBvTVVXTkNEVnY0akgzaFpWdm5LUEh1?=
 =?utf-8?Q?MfNAAFV96258nU7AVgZQPr3RY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c23ef0-8bdd-4f41-7a59-08daedd0d4e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 21:24:00.6642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6Z5sum5q8eiWBRVO42jW9yGhQfyrJzt9Yb0l0IDXEyaskuMpRXM7lUh35V/ruT8PCYbt5AWkJhOiVZ8y/ypdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gQSBkdW1iIHF1ZXN0aW9uLCB0aGUgTG9jYWwgU0FQSUMgc3RydWN0dXJlIGFsc28gdXNlcyB0
aGUgTG9jYWwgQVBJQw0KPj4gZmxhZ3MsIGFuZCBzaG91bGQgd2UgYWRkIHRoZSBzYW1lIGNoZWNr
IGluIGFjcGlfcGFyc2Vfc2FwaWMoKT8NCj4NCj4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgbWF0dGVy
cyBpbiBwcmFjdGljZSwgYmVjYXVzZSBTQVBJQyBpcyBvbmx5IHVzZWQNCj4gb24gSUE2NCBhbnl3
YXkuDQo+DQo+IFRvbnksIHdoYXQgZG8geW91IHRoaW5rPw0KDQpJJ20gbm90IG1haW50YWluaW5n
IElBNjQgYW55bW9yZS4gSWYgdGhpcyBjaGFuZ2UgaXMgb25seSBhYm91dCBzYXZpbmcNCmEgc21h
bGwgYW1vdW50IG9mIG1lbW9yeSBmb3IgImltcG9zc2libGUiIENQVXMsIHRoZW4gaXQgcHJvYmFi
bHkgaXNuJ3QNCndvcnRoIHRoZSBjaHVybi4NCg0KLVRvbnkNCg==
