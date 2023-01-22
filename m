Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9E676AF3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 04:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjAVDCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 22:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjAVDB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 22:01:59 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6800A1EFF4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 19:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674356518; x=1705892518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nj6zehYy5GuC6qXXqpGsQ7wcwG490Oh08ooIx2ALaLc=;
  b=I/Vc/m4v/O1Wxt0BI3YEU/swigMRsNONTCrPA4tVDmwWEoTublW0qy1T
   eOTRrr4rxXas0EavT6mVzrJpqQ+J3Jh2c2YgR+JXE1TTSyQgjapof7kPS
   jqvB4n556aAGohVGoh3PRhSet4vukF3m1oyUukOHJwBDWy9RJfMlRt/lR
   7vRbL0Emf7J4ofid/0GvTXNGgOW1Ap4MWTQd57BI+iHonOZv+JTEoxgKL
   xuDH+szvozw5LxLSIQ083DsIcrhuRPgAG/lzowgXnW3Hny5doYfFuTijg
   F+kf+qZDC+XS1zEZtZr5paFdUPzUze/xb44KEmawhBze9ZCRaC/A9iu7u
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="324548553"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="324548553"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 19:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="729556626"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="729556626"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jan 2023 19:01:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 21 Jan 2023 19:01:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 21 Jan 2023 19:01:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 21 Jan 2023 19:01:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXcF5531fDT1Rs4qN+uLG/7i4YcuZy3YgrwHIs1RghYRbfhvK2tkiMqRyC4lumzjx68E9tjlrVwFXp6NokwjGTi6zrulf1P+WZ7P3GtHg7BeyFJyADlUmhsZTycF2No+ZKnG2aEzLA9GfHfn98Nkt7DnruTjGxt0sgGKLEYKAdXKkuGGUUp3h1Ywe8L3vTgpCarQpA3rQqIgBMKiAVbiGaNcsHrFrDsU4XtINP2QVMcBFSYPSuNUsB92RH0iG3xgVWyUDVIBY5IjO8WvezqtBaMNK8i0NCEpMoqzKZVKg3HiMsiijOHADrTBU3Wt3AMJEW7q7O6cpduzqxCPAukrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nj6zehYy5GuC6qXXqpGsQ7wcwG490Oh08ooIx2ALaLc=;
 b=HR32anDjMd8s2WCGWlqvyGe8UW8tUZlxga8jaBW/pJ8OhdjFVb6uMOkYkB5PCVPlQDpxvPAyVukzKgccFxVPvEUgSBG3Aj0LT2Fz8duVS+KF5GzXYdgWON1XihkYl0Dmo1qpSHSmn1cPwm/MeHkZ501M1hYFbtGLRB8z9V360+UmHIBR5nsj2A2/uCoqThsO8Fy3W1zchXnZ09RXl4MZETptaxxW5LHHv+n3yaFrxIeQOAkaMlIW60403ItRcB31oXOqC/e4oJKYOdqLoS8xKutwzAzONX+F/TUHrA7mv69QJzDAYgvgZ/+wApBBXShWMPGq5u9UC3JU87pvKUFp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DS0PR11MB8069.namprd11.prod.outlook.com (2603:10b6:8:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sun, 22 Jan
 2023 03:01:54 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811%5]) with mapi id 15.20.6002.026; Sun, 22 Jan 2023
 03:01:54 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Brian Gerst <brgerst@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "H. Peter Anvin" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: the x86 sysret_rip test fails on the Intel FRED architecture
Thread-Topic: the x86 sysret_rip test fails on the Intel FRED architecture
Thread-Index: AdksoOwgh+CixkbaRlyKVQgPVVpsjwAVg5YAABeOzAAAGLETAAAKgakAAAo61yA=
Date:   Sun, 22 Jan 2023 03:01:53 +0000
Message-ID: <SA1PR11MB6734368CB5479E2D1C03C978A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <5703e698-a92a-2026-e5d4-3c6340578918@intel.com>
 <CAMzpN2iC9_ZfEmQA0469RQqoZ7NsNCCafy3FsZAt6O0gdB9Oig@mail.gmail.com>
In-Reply-To: <CAMzpN2iC9_ZfEmQA0469RQqoZ7NsNCCafy3FsZAt6O0gdB9Oig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DS0PR11MB8069:EE_
x-ms-office365-filtering-correlation-id: 281bbf36-ca5b-4051-85f6-08dafc250419
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ck4qnys5kiRruJGcEyWVxQERSZw56Q2lRSxojElzFSXLC+rkOny2inHmAQ0V53hJGaGLSzxzQ68eIeXFCp9gG29+sORTEI1SDuOkURMPjsVceKh8vXVYUYYF85yuZAuAJAcHWT3b5AfTn9LF/KEgq2clD7t1RbtNRhRIyT8/qAsWL+z0A+gbBubPWPD5tzJbaojfrWUt5GW5x29nMUZgf5koXjqsFYgnqfY+MOhnfUZQiqfmADE+Hx4KHPPJfjgj7xTPBXJiyU6FAaH9qzB7YC0MSAPnc7VgUGGxwJ4hj5NTDpRNXDVcvhYBj90afSmyogXpxGufEuhV5iuEYDIM8bqjIEmNsMsDYzZSd+3kfTDRh2MszrAs0Vx52QSgF5Bpd72Q7fhvC6VklF5U0nO5bmAzdjUlqZ9VsQEZ+Ev7Qy+IHaUw4ZUCaO579+8GonOKGlFkWC42mm5kcVE40aJ2/AxhyMo99HXiogPTkrG+D8FTTEiNKPscQxvzGCjuzhzSKCroh0v3ojm4ZEcs+KN6nixGzx+Oi324rYQ/guxF1WTr7gJIDED4ImV1vQmXHss5Vcr1hXWVXI7uZt21zq6yMW2Tk9Chku4T1lW4lq3zk0UB43xw0SLOkeyqkQ+rhS98N77muNlcRcT6JiH1jt9npIsMSy6HbvrRn4iTWxq/KEi2VfNvd+GrTCJzkbac12qp4qKg3sIm8m4Oq/Iim55qJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(316002)(6506007)(110136005)(6636002)(54906003)(33656002)(122000001)(38100700002)(38070700005)(41300700001)(82960400001)(83380400001)(9686003)(2906002)(26005)(186003)(55016003)(76116006)(66946007)(8936002)(52536014)(66556008)(4326008)(64756008)(8676002)(66446008)(86362001)(5660300002)(66476007)(7696005)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nnh3SmsxLzIyb1hFVVNxQitySWV3bllmV2RFa1hscXZrZS9tQjNUNVdZRGJR?=
 =?utf-8?B?eGRSYmdtQ1YwTGlXVDhDVXMvNzZmN01ybHJnTldwYVBMMFN5bmxMS1U5dFVN?=
 =?utf-8?B?R1IrMWJucEV4Rkp0YmdnVEg5VGZlMW9HbE5EcEEzUEc3dWlhZjdMVGdiamZw?=
 =?utf-8?B?M1hscFVuelVUdlI0aENheFVmTDg2V2lHMDl4SlNzNEg4VWJQaFlvS1dBMGEv?=
 =?utf-8?B?R1NDcFY5R3BJaWczUVZjQXZzYWlkZkdwa2svNG1YTWNyaEZYbEc0cDlUMkMv?=
 =?utf-8?B?ZVQ4WWZBVHhsVzkvUEpPNWhOMjJUOFozR1pVdVExbFc4Sk5ScEYyZUIvTW16?=
 =?utf-8?B?amsySVgwYXA3ckVzQW1wQU8zeGlTU2tCbTNLeWw1N3hsc3dwVmcyQ0lsOGwz?=
 =?utf-8?B?a0xaSk9PMk1Bc0dXQ2pLZjVxeGpzWi9yZ2Q2ckI2c3hFWU1Ielc5a1V3L0pJ?=
 =?utf-8?B?d0xsSlYxM2VPQTR2aDVoYXg1d3EvcXJzVmtaS01McC9BdU13a2tNbk82RWFF?=
 =?utf-8?B?bzkzUGJQQjFua3dBeWk1WjREUnJjRURjNm9Bc3VsZmJOYVVyb1RCZnFsTjRh?=
 =?utf-8?B?V1EzRE45a0llT0ZUaVkyOHl3YTQ5NUpBSDBFQUxBeVM3ZTZRQnFXdDBia2dn?=
 =?utf-8?B?c3NrODFpN3hIcEFTM2hTV0lXWTQrdExuQ0hiR0Y3WjE1Z3dPZUtyUlJ4N0RH?=
 =?utf-8?B?SktIZWw1NElxallaUTYwRWIvSnFzZXlmdzFZa3YrN2xscWVVU3doRHh0U0s2?=
 =?utf-8?B?UllkS3ZlWncvMGJpRXF0WXVvcFJ0T0VxWjdZVE0vZEdIMlVyQld6UC9hdDdk?=
 =?utf-8?B?WGNpSzhyWHVlWU9BZFkyd0FGVnh4T0M2Sk5CMWQwTzVVTmNDN2xPNFRRSVpu?=
 =?utf-8?B?UlJJU1pPZmI4RXhoUnZvOG5WTnVLelJvN3JOWnV1eTQvZ0tVYklocFZCaHJt?=
 =?utf-8?B?SU96V056SXR4bXhNVERudGJOOTBaTVdkYmN4REduL1BheVBlVkpmSVJuenda?=
 =?utf-8?B?bFV6aXdqUW13ck1XL1dNMU9aQ05HUDZmMlovdVkxQk5yL3hiV3B0Y0JkUlE0?=
 =?utf-8?B?ZGhZaEtHd3ZQSFJMYStmRTZMNGNEcC9sY1Z6UnVUMkxJRW16UDRDRkRtMG1x?=
 =?utf-8?B?QVhnNDc3SlpHamhhdytaTno0QlVEbk5ReFQ3dUZMS0QyWkFrS0h1bkdGMWI4?=
 =?utf-8?B?cVdaVGJDRXg5a05HOFlkSFd6RGU3YXEzTUJkdmUwVmlTSEdKS0thZGc2alVI?=
 =?utf-8?B?RVRERVZla1NQcG41aFpVOVJEV2lkWkFNaE5KU2xJZzFkZU0xaEROY3g3eEp5?=
 =?utf-8?B?RUJSaDRsUU1kdTRuYmI5NjlhUDhsUEZ6andjazRaS2xOUnJxdkd0RVRtMnQ3?=
 =?utf-8?B?V1orUFMxRDdobkp5NG5FOXBGWVFlOWhIWFJKY0RrdEg2b1U0eVYveFNCa3Zp?=
 =?utf-8?B?ODhrUUI2M2JaalMzUmF1RHUvS3BKcGV5ZHNkVHk5UGJDS0w3RWpNWE1zTXBq?=
 =?utf-8?B?WXF3R0E0OTVac2lPM0MxVWhZR3NlelNTdWw0dFNDaVNCamlOYU1SMlI2N0hr?=
 =?utf-8?B?YTErK1d1K1NjeTVLeU8vYUcyb2pMekw5MDZXMWxRR3pKSnBiSi9obmZOdnQv?=
 =?utf-8?B?SXptNE1SS0NHbFMzL09Ba2IrMGFEcXY3UURQc2xTemVsdEJmQjBUckJQVk9w?=
 =?utf-8?B?Q3h0c3pBQWt3RHhEaGJueCtsclI4WTBKR2FMaFlOYnZJcXJYalk0bnNwSHpO?=
 =?utf-8?B?blg5WVAyRyt3a0xPd3ZsUDU4a2tJRW1iWjk2S2pEbW0wY2QxWnkwTzczS3Vk?=
 =?utf-8?B?VzBtam5ocmthN1ljcWtLRWN1dHUybjIzTE9Way9OUTZnQk1ON2lxaTU3RGdP?=
 =?utf-8?B?RXZGQW5ubDRMbzlRODFRTTZYTjdxZlFhZWdjY2JVa0pFZVNwVk9BWjNSMTdL?=
 =?utf-8?B?dnQwY0R5alFQeSswWVROdDU0bFNrZVQ3RkVKUFQwaUlMN2xWbjNaT1o5Zm5X?=
 =?utf-8?B?UXlZVk5rNmR5KzA5ZFNHR0xHckNHRkpwZXNadUtwZTlyN093ZVgyL1NWc2tU?=
 =?utf-8?B?eWJtcGNPZmtPM2M0R1I1TkN6bWtVNmhDSHl5S0U4QmJHTlVmMC9FYStRMU5S?=
 =?utf-8?Q?8qu4JqyACMJjFAts6NVDFcj9V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281bbf36-ca5b-4051-85f6-08dafc250419
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2023 03:01:53.8492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWZORpWh1IfileFnj+Vz/P5uXtbOkaKmp14vTMaLKD+lLtEmUro62DTpiviNXpC49XKZVPyZWE+e3lArp3kW8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8069
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4+IElmIG5vdCBpbnRlbnRpb25hbCwgaXQgbWlnaHQgYmUgc29tZXRoaW5nIHRoYXQgY2Fu
IHN0aWxsIGJlIGZpeGVkLg0KPiA+ID4+IElmIGl0IGlzIGludGVudGlvbmFsIGFuZCBpcyBnb2lu
ZyB0byBiZSB3aXRoIHVzIGZvciBhIHdoaWxlIHdlIGhhdmUNCj4gPiA+PiBhIGZldyBvcHRpb25z
LiAgSWYgdXNlcnNwYWNlIGlzIF9yZWFsbHlfIGRlcGVuZGluZyBvbiB0aGlzDQo+ID4gPj4gYmVo
YXZpb3IsIHdlIGNvdWxkIGp1c3QgY2xvYmJlciByMTEgb3Vyc2VsdmVzIGluIHRoZSBGUkVEIGVu
dHJ5DQo+ID4gPj4gcGF0aC4gIElmIG5vdCwgd2UgY2FuIHJlbW92ZSB0aGUgYXNzZXJ0aW9uIGlu
IHRoZSBzZWxmdGVzdC4NCj4gPiA+IFdlIGNhbid0IGNsb2JiZXIgaXQgaW4gdGhlIEZSRUQgZW50
cnkgcGF0aCwgc2luY2UgaXQgaXMgY29tbW9uIGZvcg0KPiA+ID4gYWxsIGV2ZW50cywgYnV0IHdl
IGNvdWxkIGRvIGl0IGluIHRoZSBzeXNjYWxsIGRpc3BhdGNoLg0KPiA+ID4NCj4gPiA+IEhvd2V2
ZXIsIGl0IGRvZXNuJ3Qgc2VlbSB0byBtYWtlIHNlbnNlIHRvIGRvIHNvIHRvIG1lLiBUaGUgY3Vy
cmVudA0KPiA+ID4gYmVoYXZpb3IgaXMgbXVjaCBtb3JlIG9mIGFuIGFydGlmYWN0IHRoYW4gZGVz
aXJlZCBiZWhhdmlvci4NCj4gPiBJIGd1ZXNzIHRoZSBTRE0gc3RhdGVtZW50cyByZWFsbHkgYXJl
IGZvciB0aGUga2VybmVsJ3MgYmVuZWZpdCBhbmQgbm90DQo+ID4gZm9yIHVzZXJzcGFjZS4gIFVz
ZXJzcGFjZSBfc2hvdWxkXyBiZSB0cmVhdGluZyBTWVNDQUxMIGxpa2UgYSBDQUxMIGFuZA0KPiA+
IHIxMSBsaWtlIGFueSBvbGQgcmVnaXN0ZXIgdGhhdCBjYW4gYmUgY2xvYmJlcmVkLiAgUmlnaHQg
bm93LCB0aGUNCj4gPiBrZXJuZWwganVzdCBoYXBwZW5zIHRvIGNsb2JiZXIgaXQgd2l0aCBSRkxB
R1MuDQo+ID4NCj4gPiBJIGRvIHRoZSB0aGUgb2RkcyBvZiBhbnlvbmUgcmVseWluZyBvbiB0aGlz
IGJlaGF2aW9yIGFyZSBwcmV0dHkgc21hbGwuDQo+ID4gTGV0J3MganVzdCB6YXAgdGhlIGNoZWNr
IGZyb20gdGhlIHNlbGZ0ZXN0LCBkb2N1bWVudCB3aGF0IHdlIGRpZCBpbg0KPiA+IHRoZSBGUkVE
IGRvY3MgYW5kIGNoYW5nZWxvZyBhbmQgbW92ZSBvbi4NCj4gDQo+IEtlZXAgdGhlIHNlbGZ0ZXN0
IGNoZWNrLCBidXQgYWxzbyBhY2NlcHQgcHJlc2VydmVkIFJDWC9SMTEuICBXaGF0IHJlYWxseSBt
YXR0ZXJzIGlzDQo+IHRoYXQgdGhlIGtlcm5lbCBpc24ndCBsZWFraW5nIGRhdGEuDQoNCkkgZmVl
bCBpdCB0aGUgc2FtZSB3YXksIGl0IGxvb2tzIHRvIG1lIHRoYXQgdGhlIGNoZWNrIGlzIHRvIG1h
a2Ugc3VyZQ0KUjExIGRvZXNuJ3QgbGVhayBhbnkga2VybmVsIGRhdGEgYmVjYXVzZSB0aGUgTGlu
dXgga2VybmVsIGRlbGliZXJhdGVseQ0Kb3ZlcndyaXRlcyBSMTEgd2l0aCB0aGUgdmFsdWUgb2Yg
dXNlciBsZXZlbCBmbGFncyBqdXN0IGJlZm9yZSByZXR1cm5pbmcNCnRvIHVzZXIgbGV2ZWwuDQoN
Ckkgd2FudGVkIHRvIHphcCB0aGUgY2hlY2ssIGJ1dCBhcyBIUEEgc2FpZCwgdGhpcyBpcyBhbiBh
cnRpZmFjdCB0byBub3QgbGVhaw0KYW55IGtlcm5lbCBkYXRhLiAgSSBndWVzcyBpdCBkb2Vzbid0
IG1ha2UgYSBkaWZmZXJlbmNlIGlmIHRoZSBrZXJuZWwgc2V0cw0KUjExIHRvIDAuDQoNCk1heWJl
IGl0J3Mgc3RpbGwgcmVhc29uYWJsZSB0byBrZWVwIHN1Y2ggYSBjaGVjayBmb3IgSURULiAgSG93
ZXZlciwgaXQgbWFrZXMNCm5vIHNlbnNlIGZvciBGUkVEIHN5c3RlbXMsIGJlY2F1c2UgYWxsIEdQ
IHJlZ2lzdGVycyBhcmUgc2F2ZWQvcmVzdG9yZWQgdXBvbg0KZXZlbnQgZGVsaXZlcnkvcmV0dXJu
Lg0KDQpUaGFua3MhDQogIFhpbg0KDQo+IA0KPiAtLQ0KPiBCcmlhbiBHZXJzdA0K
