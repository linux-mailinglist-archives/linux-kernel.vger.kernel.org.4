Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31106833FC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjAaRez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjAaReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:34:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA63A45BFD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675186462; x=1706722462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Iql7upKEnaYGBRuF3p2bmhYkEcL2e2rn4C/uyRG6IE=;
  b=eq/QxKFl8mWlCbQgzy5co1z5qTr0vechU4gC13fSSi9aooWPYT+GDtVn
   R2c7FPNSxuT0MhpEQ+rm6eH+twwlAr/Me9nx3ZqLBikebvWORYf1KuXb5
   yNaVf8EZBz3n6bVA1lAT3iJcszR3pvHMb0rqqbxoqJmCSodt2IpWPgsc/
   Hq6JOHRAUniXdTV+lu1vSFeQkGbDCngguYWvCBAe1OHVRBT3QBILkSGB7
   EIl2gWmkKXtOO3VmH+CcA7M88tewvmzGtykwrwj48HMTDzAwypsdjuh0c
   FiHh1oCTn2f5L8sWI1qkDxk3+NL8mXn3HGiimUAtBGq8zgI0ouT5gb9vb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="325604668"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325604668"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 09:34:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="657966645"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="657966645"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 31 Jan 2023 09:34:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 09:34:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 09:34:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 09:34:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9EU4eFkdQWvbLGY9oTQo7g76Pv31fDYd9lbXVmEIXPQwh8mAAggtJ4DD6kshoPaAK+6LuSm93LUrT4wb+t5HPSjFRIbohTZNvmTaPBb6aJ3DySUyXqPKXACJCrUMq0MTJDzkItZ2gnkNDSMicQJP4VdqkBmKLbS5rBq5i4/63ecrApqSAOlNz60pTnzz02dm7hR1YbypS+ZxTWcj4Ob2TUO5pFl7XK03vbpzewhR3rdCGF99jA8of2IrM5X6B/y3e3SCp5pZAl8pN+zzf7mTQ7v3b3CQP7+J8M4ky0gqhLw4Vt0ceAgZwKjtuZNm0ms/uZzU4UZrThB1IqxFqfgsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Iql7upKEnaYGBRuF3p2bmhYkEcL2e2rn4C/uyRG6IE=;
 b=CKBBcaVGhaC20QF5U0+h4xEFKQ4R8UAD/lucJmQmk6u8+VcA0yJJrL7LuI+5uYfaxX5DFiNG+x6sLHsWCTTei63om1zZpOVmudplvB+ZK5kUoQFLvpUTXdd/PQo05LXn8e/CCL0KcwSFQcqmT16Ddxts/p1rLgSHjHPa8XwM5kLrBNjVoQoVa8FUvVXZz4IhzfSZ1pMSZ2cQQWyLIvuK8WDs/nGvDtV31tvXlAU7UXhLDxWwcqWU9JgqYfB9O1fTJLzderHoRFDC7UEJy4BIrcwkOWa3f0JXqpS0Kfo7ZB57FOTIDAl6HjSFsXaKjsZPcCUGr3CHDA2Fls40JudrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 17:34:14 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 17:34:14 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, "Raj, Ashok" <ashok.raj@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
Subject: RE: [Patch v3 Part2 3/9] x86/microcode/intel: Fix collect_cpu_info()
 to reflect current microcode
Thread-Topic: [Patch v3 Part2 3/9] x86/microcode/intel: Fix collect_cpu_info()
 to reflect current microcode
Thread-Index: AQHZNPN2NI5TxkYoK0abVR9vY8eccK64vecAgAALhpA=
Date:   Tue, 31 Jan 2023 17:34:14 +0000
Message-ID: <SJ1PR11MB6083580526A7FFA11F110B77FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-4-ashok.raj@intel.com> <Y9lGdh+0faIrIIiQ@zn.tnic>
In-Reply-To: <Y9lGdh+0faIrIIiQ@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB5013:EE_
x-ms-office365-filtering-correlation-id: 9dd745f2-beb3-42f3-ff9d-08db03b15f10
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: luC4IXFzLIPU3fzW96cCSewQl9ngf+uMqTEJQp3aPaAB4dWIT0oCkeHJxIEdPAa2gg4ZToNoAmaneNsUp8e6m6mG27yNr6Tttp9ZFA8IfOpcnrpGGn7AcacBVFMGEEJ6K6ca2MiRDP2QZwLhmcy13UsOsT5C+FX9lZCjBx+sJRxocqgTrGATh2ZmXdrSDdOv6epshFGMkT53WpCBafZTgKVhwOuJksFgRieYDudoe/Y/OUhoixhSV5U7WJZMBmvb5iVVRLkSQQ0l36BIWd4cqbXB89VY0JSnRQogqk9QDp2e56991TKyc57btVvo0vod6seo/EjuM3DOOG+/ZcVO2QGQIQMszg2+bPuLcQs5VsajjowOnU5yXf8dNIi1bOkuIg7CfBKD0xQmsBP/Oc7ztPkvFYJxPejellhpAGkP6UPYUZDrN5bOMZ1wWtnzWB3bj7MUf1bC0m30kvR6WhF0w6z4nVf0+io78ckjXYt7EczuqW0DcJD0KBUPChOakY1kOcxaKCspCelMybblM9UgoE+PB4RN15RNR/aK193rVVMFOpMX5AiELarPBoIdaVSx44tYbB5pzLrcGPWIkpLpauVWAkRY6d7/wWNgQm2zX+6Qc9AwEPKd61552nLwJklSw48JgpfTEPquFXAMN0UkZWnviUfdRSG9T/ngdZcX/TEDHzBRr01BYM9KZd9j/yPqCKKw319hFgmVZXjwhLdyOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199018)(2906002)(86362001)(5660300002)(4744005)(52536014)(7416002)(83380400001)(33656002)(9686003)(54906003)(6636002)(71200400001)(26005)(66556008)(6506007)(186003)(8676002)(8936002)(66946007)(64756008)(41300700001)(4326008)(66446008)(76116006)(66476007)(38100700002)(122000001)(38070700005)(110136005)(316002)(82960400001)(478600001)(7696005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTdUNW5hSm1STmJZckMyTW4yNFcvTVZRZTR3UEdya2EwdFoxeGxPbG1zc2Vl?=
 =?utf-8?B?bVBUNzdQNTZXMzhLZHBKQzduOWU0ZG1xZFlrYmxNTis5LytEQmxVQUR4SGEx?=
 =?utf-8?B?WjgyZlRSdjdOZUt2Y3MzZVZnM0lTVGVIME84ZVBodmhYcE5PRTl6bW9HYUlR?=
 =?utf-8?B?dWRkb0t0Y0JvcEhGMFBqYzN0QTROck4zaGFKZHpzQ0pJeU5lNUgrRWU4bmdk?=
 =?utf-8?B?ZFBxaXZML1J1Q0ZPaUdjOHZ4UE5lRnJGZ25rZTZ2RTJNbFRzY0tiZ0JvN0w1?=
 =?utf-8?B?ZkJucE10MUZDVmwxZy9keFNvR0JtZkZ5OTJ1aWdXVVh4VTNiTUNlQVBXazhp?=
 =?utf-8?B?RDRBQitEMExLTmkyWGE2Y09FN3NTdEs2WGM3VXBYVmdyRWQ1S0NXVUpZcHA4?=
 =?utf-8?B?OGJpVHRkWjlwamdkZHlGdmZQeC83TWpsMlNYU3Q5azhCOUIwRFNESjU1eEFu?=
 =?utf-8?B?d1RIZzFmSW9uSXVhOE54UnpRaEdoQW9lZlZ0aUlzTjBKYStNV1RuR2Y1cjV4?=
 =?utf-8?B?dm9ySmkvTEdrdWpqK1JmSzZMSyswWFE0L3J3TC9DQzhycW1XMCtZNm1uS3Va?=
 =?utf-8?B?UEJhRmxsWnZRZFd0OUFzNkl6ZTlVUjlROTE5Vlp3ZU9qZTJzQml4TXlCaHNV?=
 =?utf-8?B?YUFWUTdtTzhTQ1pGaUVvZUJ5Z0VQbEEwVTlXd1ZsQlg5MTRUM0xTR3plVG1Q?=
 =?utf-8?B?RHFPSVJyOW5WSE5hSDBJeGRBNUROVUp3VlRwdkpvWHoxeSs3Qnl0ZEdBeXkw?=
 =?utf-8?B?MG1VdnBpc3drMVdncWx3STVpd0c5WkROSmJ2Z0g3ZmQ1NjFEY011eHBzempM?=
 =?utf-8?B?c09xSnJKd25WZFlCK29NY3cyUVhxbHVWb2lKY0lDa1l5Rm1XVWF0WDJseUxV?=
 =?utf-8?B?anpvUGpaTjVweXhSMkFvekZacG5GdXQvakMrTXp0T1NScXZlNVZhRi9yYnNE?=
 =?utf-8?B?M0VPYjhOUzZrSlJsa3hCMk1UKzhScENpTTZpYnlwdXVjTno5aDNEOFdBRUNt?=
 =?utf-8?B?cml2QysxWHRlMlR0aUN6K01HUmpmRytYWTlsUW5hN0crVDhkak9reUFUVWtQ?=
 =?utf-8?B?QWllTWk0dkVaMEg2UTFJOFp4WkRkZFNsT0x0TktZdUVoS2twYXJvdW01a1NE?=
 =?utf-8?B?aGExak92RFZsODl4ZHFvYjRld2EzNXQ2OUJFWUYvck4veCthbWhQbm5zeEJS?=
 =?utf-8?B?bi9zbld2SldZVGdRZ1J1bU9WbDdjcm15cE5kU0QvU1VoaGR4RkV0SFEyanZw?=
 =?utf-8?B?cGIwdG5Ea3JJKzd5RHlYL2hndHBqTjdPZENYR3k5ZVpvQVFaakpydTB5Nk1r?=
 =?utf-8?B?czhRekcrSWt1bzBKN0VQRjJpY1FqSFRDZVV4enhnMFhmU2tnZm9EWXl2ZW1s?=
 =?utf-8?B?LzRvNUcrVFVDbEt6T0JhYU83RzdnSkp0TmMwQ096TUFlS3YyVFBtUlJCazdP?=
 =?utf-8?B?elFSVDhoRmtDNlNKNndYUjYrSGRuZWM2dnR5ZGw0MDZKWGJxVkJwL3lZSVdt?=
 =?utf-8?B?M2cyZmlEZHl3ODkrTjNwSHNIMnAwZ3d3OWJ1aHJiaHR4aGtxWk1nVjQ3MGpF?=
 =?utf-8?B?eU83S3NoVllkS2FXTHVlQWQyZTBRZlVhRTJLa2llZEZnM3RiYXUzc2oxOUNq?=
 =?utf-8?B?VFQyRDlPK2drdSt2alVkYnIra3doWHdUcThJU0JEaEJYOGdUK0pQQ0l3VlYx?=
 =?utf-8?B?OTlwQUswQVpxcHFkM2xPTW1PeU1abW1UQWdTbWVzK05CK3ZxL0RIZjN2aHhD?=
 =?utf-8?B?SUJ5SzlxM3JneDRKLzFsN3o1UEZSckZpWXJ6SWZzdXB5bXpMV01CM3FXWW40?=
 =?utf-8?B?c0JFWnZIanZrUkVhVWVFK0FFU3laTHpHSTRCSkt6VWU3R3dmeEEzeWdhWmJu?=
 =?utf-8?B?ckE4eEF2eFB3R2I0TXh3bUVRU0h5dEg5bWpja0NyNU9lalI1aXUyWSt0TThN?=
 =?utf-8?B?NVZ5OS95di80d3pzYkRnUTA0Nm5tVDYzeW9kT0g2cFRSazFVdVRUMEFieGtt?=
 =?utf-8?B?YjNYSENpUVVKenRrOEtUbHFOVXhQSlNFR29mZ2pFMXkvdnMybFdSY1R5bzZH?=
 =?utf-8?B?cVRGTGFoOXNEekh3YitzNzRIWjZQSDZ2YUJqMkZMbzk4UXlxaUV1UXFYYUxi?=
 =?utf-8?Q?BR8pHHDnfFS5HMLafgFcKqbSF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd745f2-beb3-42f3-ff9d-08db03b15f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 17:34:14.1476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3AbtQl26/GXwXcaA3AgPovGWgfavIwi+MY/cIFBQcBo9NwGjCyHhzEKu4sDCuBSOxSUxO9AUzOri5f6BoEqQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gQ3VycmVudGx5IGNvbGxlY3RfY3B1X2luZm8oKSBpcyBvbmx5IHJldHVybmluZyB3aGF0IHdh
cyBjYWNoZWQgZWFybGllcg0KPj4gaW5zdGVhZCBvZiByZWFkaW5nIHRoZSBjdXJyZW50IHJldmlz
aW9uIGZyb20gdGhlIHByb3BlciBNU1IuDQo+DQo+IEJlY2F1c2UgdGhpcyBpcyBob3cgdGhpcyBp
cyBzdXBwb3NlZCB0byB3b3JrOiB5b3UgY29sbGVjdCB3aGF0J3MNCj4gY3VycmVudGx5IGFwcGxp
ZWQgLSB3aGljaCBzaG91bGQgYmUgZXhhY3RseSB0aGUgc2FtZSBhcyB3aGF0J3MgaW4gdGhlDQo+
IE1TUiAtIGFuZCB0aGVuIHNlZSBpZiB0aGVyZSdzIGEgbmV3IHBhdGNoIGluIHRoZSBjYWNoZSBh
bmQgaWYgc28sIHVwZGF0ZQ0KPiBpdC4NCg0KQnV0IHRob3NlIGdldCBvdXQgb2Ygc3RlcCB3aGVu
IGFwcGx5aW5nIHVjb2RlIG9uIG9uZSBsb2dpY2FsIENQVSBkb2VzDQphbiB1cGRhdGUgdG8gb3Ro
ZXIocykgKGluIHRoaXMgY2FzZSB0aGUgSFQgc2libGluZyBmb3IgdGhlIHNhbWUgY29yZSkuDQoN
CldvdWxkIHlvdSBwcmVmZXIgdGhhdCBBc2hvayBsZWF2ZSBjb2xsZWN0X2NwdV9pbmZvKCkgYXMt
aXMsIGFuZCBjcmVhdGUNCmEgbmV3IGZ1bmN0aW9uIHRvIHJlYWQgdGhlIE1TUj8NCg0KLVRvbnkN
Cg==
