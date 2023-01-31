Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702A56837E0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjAaUt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAaUt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:49:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A357AA5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675198197; x=1706734197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yOzgLfQ7Ebs+Rz4piU2G691aTW71WVBqOTID22Ntu9c=;
  b=Gmz4SopIvfm2SZsZR2ZZLn1KM6Jy7V0RzRnNyrcHxtKnv61qUujXvq8k
   2z8dvIHZD3JjzGDF8jaQfwMNGYuxhSwd9oZlaXAWPhZFx1fHFEDVan1v0
   Hqc/+1WmKFe5z9GMnAnVcUo8uaUO1/Rf8Ohu9h01CIhIELSWmnrP4YXQX
   ks1qejDoNWme6oAa1aD09yqbq59lXTZM14dM60DTh8TIiAkFizWZZcCyG
   uwUnRXU+EfxCytg1R69bP6cmyZzT2OyBRw1gyhTJIf6Dz0Nwo45AaunA7
   XvbLBf+oFQHwFChYP0h/qr36ecSqtc76t7KiXmrfmsCAuVeqOqlOUaqcY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="307613913"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="307613913"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 12:49:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="910048881"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="910048881"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2023 12:49:57 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 12:49:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 12:49:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 12:49:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZIcQacl/y4TpfoeZnRgpMg8J1egCjHBUbybsvUJJnZyHwG2e6hH4n5aUJNPDV59CzSmptkfDcgf8kStegt41ggwl/SSzr0wznB2RJCYyKTM/9LWnvxXlkwsZCsH6B9DepQmHey1uKl90d35lZquQIflDrucdq6z/8xiQwdnq/5Z1f1zdlt5pZi4Qs5vF54lcY5Si8AZULeX+zMW4Fz0XIXav7xkQYn89JY5fclFyt0R6o/VMaJOJ19w770BmRx+uMW2Ef8oWo9K+zN+lA4ymyme4KXpHnzFMvrqoYy4OMmpcOHIyJHlmHpTXuEt+Oz7MC8bAVQLCdlD+iL7ARzIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOzgLfQ7Ebs+Rz4piU2G691aTW71WVBqOTID22Ntu9c=;
 b=Vxtyc/8vZZSY2/RjF7diL5bpCBgX3VX4EG5jZShUnES3p8sG8dyMVOCIHwDV9ix2kWQJ9G3YXn6SRzro1JTB09cmIqfgmm24O7Hatpm3WTIeokkUlGCawpcvdEwKknb43RxByB/QP4k7FUYQ4MQqynjnxjMQ34VjfwnFC6JBDGP6R9vjn4T+uV0wQLoso7Hl3/2AVnWlIXEV2u8qUVHrehzyB0obv7b64BjvdFS7/g2XXg3kBR2wtaMjTSglU98Z4Xt55sMd0KHT1zTdIvx+QqHFAJq3XSStW5Z+BCcQUx71M13AqfftjucF3H2JpB9VOrpxu4dpl2EC8bssvzPbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5106.namprd11.prod.outlook.com (2603:10b6:303:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 20:49:52 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 20:49:52 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Stefan Talpalaru" <stefantalpalaru@yahoo.com>,
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
Thread-Index: AQHZNPN2NI5TxkYoK0abVR9vY8eccK64vecAgAALhpCAADU7AIAAAMCg
Date:   Tue, 31 Jan 2023 20:49:52 +0000
Message-ID: <SJ1PR11MB60837E6E6AE7C82511DC039EFCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-4-ashok.raj@intel.com> <Y9lGdh+0faIrIIiQ@zn.tnic>
 <SJ1PR11MB6083580526A7FFA11F110B77FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9l8yGVvVHBLKAoh@zn.tnic>
In-Reply-To: <Y9l8yGVvVHBLKAoh@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5106:EE_
x-ms-office365-filtering-correlation-id: 870522bc-18ce-42c7-3e09-08db03ccb397
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NPiauaeiJNYrZze/BO8EXb2RvkdLnGEjXsEzRl4tnBZ9xmDa0E5OQjLREAA3r3crqQhcWhjpQa+VTjraCPp3J/HZf5whhF45+lSsOA9W8JtpXswKHK1kj4vnQPFtGPU8MMdVCArA7CNM5yfod95ikF099wjRPl8gX+t0ND6fmqKD4QxVWrgF2iOSmdc8IhZYKW/471SvU0vR+CFxHYyC4bOZyYQV0fM3xZa/yFs1I8GFvQgINcWOzdyNVBWeAAeBZpVf3FYtukvrJePPyTpRIysUBpDW457T3J2jac+6/7VHZ+rASpcm2XLaym21ENLxZw7ZknOHwdfl9utPOtt8aHqdg7WNJVO4YZz048ERLhO7Qf2/C+l5F8+WYZ9ZoY38Y9hOHB7VQlmoif4uxjhox5UrYUofj+wr1EiPo9+AUEaAckP6SQGczfGunymLmWcVxq6rFDxqiE3fT18pIQEZCwxVmmOrP2zGpoAjhy5v/HckZ3Z2y8jlLBarYXCI7yVxM9QADtScAYXXIKSdKEvx3W9GZ8tKuJjKKBMvE7owJShK99zHWvCd0ro5jaPVcB2ncN3KsYNEM2njsKl/670c8GcaGZ3kNu2mvIKLITrfvGKZU1OGTAfUxTchkOrudaOo7MTc+XBww6HEpoSqVSrhBk+0LLeHjKe8UQxMrFGRiwqQa3ntq3+9SAykp5mNzSc2MgETHF2lfg7QWk0Sdq6NtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(54906003)(316002)(71200400001)(52536014)(8936002)(41300700001)(86362001)(66446008)(2906002)(7416002)(4744005)(4326008)(8676002)(6916009)(66556008)(76116006)(66476007)(64756008)(5660300002)(66946007)(38100700002)(122000001)(38070700005)(478600001)(82960400001)(9686003)(186003)(26005)(7696005)(6506007)(83380400001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUhRWTJjTGdvYnpmb0JnY2gxZVZveStXTWU2emdOeXczVE5PQVFUUVJrYWhu?=
 =?utf-8?B?MjBYRkJEd3ppbDl1ZHZGaFN0TEdlZG15aDBFVERuNVM1amwrbWhzZkR0d1o4?=
 =?utf-8?B?UEhaQ0FQRVFCUDZBY3Bmc3pNanF3QlZKcWJhbFFuMm12eDlYclhPVWxlVDJW?=
 =?utf-8?B?U0Z6U1kvYm9rQ0c4UWZ0V3FiNmd6M01lOFVzQk5SS0FIL2hjRkY4YVA0bGV6?=
 =?utf-8?B?bUVVWnlVK1NpUVRGa1R4TE9JVW90UnRQM01CNVY1Q2RuTFI5MjhnR3ZRWTAy?=
 =?utf-8?B?RTFjQVFXbE9jUlQ5YS9NaU1Lbnp0UXJmdWJFbFZFcmc2RXBaTXdWTzF4Kzcz?=
 =?utf-8?B?NHJNV2NGbUdtb1UvQyt2ajVvcjEyVnF0aFM0UGszN3FJZ3pWZXdxeTI5L0FX?=
 =?utf-8?B?eGovOWNpQ1lOaUQxV3dHRmIzbzRIMUtZdEJicXYrSWxpcTZoT0VsN0RoU2F1?=
 =?utf-8?B?ZC8rNWlSbmM5ektkYzRhTlNzRG1TVDJSR3dpTU40M2ZsYm1WeVlNTFF6b1o2?=
 =?utf-8?B?bmFtS1l0Wlk0RzBnMTVkdVhZMjBEZzBPZXlNdk9Ra2JDLzdrNmplNWI1VUxX?=
 =?utf-8?B?QWtWdlE1czdhZlpYRmUrMWUwNXozMi9Nc0NhbHhLSys4TDB6blo5bEhHOXdz?=
 =?utf-8?B?K2xRZ05hbnY4V29uWFVSc3RVTktVRlhQaThsTEMzOE9GYnQrMzY0dW5BcStv?=
 =?utf-8?B?VVNrMDBLZlRKem95cDZhdG4vbitWRzl5RzJKMzdaM040VnRacHBqTHh0ckhM?=
 =?utf-8?B?WXREQ0hrVWhPTGxKT2xoOHdGTFFmUjFXM0xIdTc3ei9oWjdVWk9kWjBlU2dN?=
 =?utf-8?B?RUxUMlhaQ0daMnBYdHY0VGFkcXdseGxjK2ZCb2llV0VibmpBWFFqZFRpck1N?=
 =?utf-8?B?SElKZjVNajcrUDkwL3BDekpnZDIwSlo2aHdOL3hFOVg3V1pOeTBZTktQczVq?=
 =?utf-8?B?M1d3ZU83RnBnWVBJTkxEQVFodk9GaVd6U1FOZ3FKYXl0WlduNEpvK1RvSmFj?=
 =?utf-8?B?OHpZTXZkZTBiTzF4MnhpYm1PN1V1TjZRL1ZUdzdEbmhqbmZLQ3ZMTmduZ3dw?=
 =?utf-8?B?UTZZcHJTOTdxRUtxVjBmcVdxTU5Dam5XTXRHLzBTcXU5QzAzcVAzZ0RMWEpp?=
 =?utf-8?B?b0JvZ2pCVjFyaWpLRXRZNjNxSW0rUnJQR3ptcVNwZVRwRzMzeVhEa1AyeFJ0?=
 =?utf-8?B?cmNpY29JbitJalpjWXY1VXU2bHZ2bkJocEhlMSt2Ni9Cc0Z3MXkwQXprc2hz?=
 =?utf-8?B?V01zWThDcGJvcmpmVGdaTTQ4OEpqN1BtYUNrSGFKNlNYWjI0bW5vQTFvR1h4?=
 =?utf-8?B?SitQUW1KSytzSjVhNi9ueVJoOURXd3Ayb253YUkvYXUrQ1k4Tk1VcFRhL0dj?=
 =?utf-8?B?RHlTUHNVMmVEczc2V0lQQTdwWGFjTHErcTRzcHl3UDlRbGlWdUFaRnFYek5u?=
 =?utf-8?B?ck1nOUpqdnhYanpoaFMzcWlJNDlVY2cvZDNRWjA1OFpMbVlDMzhCekJyZ1Vk?=
 =?utf-8?B?cFNUR1ludFRPSFl6VUNZZnZETEZhV2xwWUJxT0ZzM1MvOHVNdThJcmhEdUN4?=
 =?utf-8?B?UmFNUXZ2dnpvb0ZEd25KK0M2eHltazkvSkl2Yk5oTjlLaDhyYlI0cDZMbkgz?=
 =?utf-8?B?OG96NTlhME9mWVNxWm1hNjdMUzloVXRvSWJFeHFWTjg2cGRwNDgvWnI4NGlu?=
 =?utf-8?B?MjVDMGNjaFRMZVhBcUtocGZ1VDZYN3UzbjQvRWcrU1NMYm1mOTZjaGNMNFEz?=
 =?utf-8?B?aDBsaUIxeHFRQVZPYnh1YWoyekpqNG5IQjZ6MWxMRnRpcC9kZEJOZkM2K3FR?=
 =?utf-8?B?bkNpMmxRTHJQQzJZaGNiMmFoaWh0Ly9YcFhWTDIweE5TSVVRY0dqTlBzYm1X?=
 =?utf-8?B?dVRrQXBZdEtlUWFFSU9LenlhdmRzUGdyZUJCdlFSdzA4U29Od1JVS2o1M3Mz?=
 =?utf-8?B?VzNCdmx6WVZ4V0xLR3hubXFzZFU5TUphQitiZDBHejdxZUdNSURtLzBFeUxQ?=
 =?utf-8?B?Q0piL05nZHNZY1ErZ0U2ZlVsWFNwbkpiajNidjd6OVlSY2VVanpWTWpSeEpJ?=
 =?utf-8?B?ejQ3RS9QelRXbGlSbXB3dnYyZ2sycElNaGFUelVWeS9vNUhEbmRZUVFkU3Nj?=
 =?utf-8?Q?MYiM3ZB27B+j5mfGDtvC5pgOk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870522bc-18ce-42c7-3e09-08db03ccb397
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 20:49:52.3989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pfRhnZcuaHlFLosfLg1Hmg7eLFMqz9G3+zOAiq/hksm8rBcwXBFxFm+hBwun93ytVz+7s5DRqc6cpelzY78CMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIHByZXN1bWUgeW91J3JlIHRhbGtpbmcgYWJvdXQgbGF0ZSB1cGRhdGUuIElmIHNvIGFuZCBp
ZiBpdCBmaW5kcyBhDQo+IHBhdGNoIGluIHRoZSBjYWNoZSwgaXQnbGwgZG8gdGhpczoNCg0KWWVz
LiBUaGlzIGlzIGFib3V0IGxhdGUgdXBkYXRlLg0KDQo+DQo+IGFwcGx5X21pY3JvY29kZV9pbnRl
bDoNCj4NCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIFNhdmUgdXMgdGhlIE1TUiB3cml0ZSBi
ZWxvdyAtIHdoaWNoIGlzIGEgcGFydGljdWxhciBleHBlbnNpdmUNCj4gICAgICAgICAgKiBvcGVy
YXRpb24gLSB3aGVuIHRoZSBvdGhlciBoeXBlcnRocmVhZCBoYXMgdXBkYXRlZCB0aGUgbWljcm9j
b2RlDQo+ICAgICAgICAgICogYWxyZWFkeS4NCj4gICAgICAgICAgKi8NCj4gICAgICAgICByZXYg
PSBpbnRlbF9nZXRfbWljcm9jb2RlX3JldmlzaW9uKCk7DQoNCldoYXQgaGFwcGVucyBoZXJlIGlm
IHRoZSB1cGRhdGUgb24gdGhlIGZpcnN0IGh5cGVydGhyZWFkIGZhaWxlZCAoc3VyZSwgaXQgc2hv
dWxkbid0LA0KYnV0IHN0dWZmIGhhcHBlbnMgYXQgbGFyZ2Ugc2NhbGUpLiAgSW4gdGhpcyBjYXNl
IHRoZSBjdXJyZW50IHJldiBpcyBzdGlsbCBvbGRlciB0aGF0IHRoZQ0KdGhlIGNhY2hlIHZlcnNp
b24gLi4uIHNvIHRoZXJlIGlzIG5vICJnb3RvIG91dCIsIGFuZCB0aGlzIGh5cGVydGhyZWFkIHdp
bGwgbm93IHdyaXRlDQp0aGUgTVNSIHRvIGluaXRpYXRlIG1pY3JvY29kZSB1cGRhdGUgaGVyZSwg
d2hpbGUgdGhlIGZpcnN0IHRocmVhZCBpcyBvZmYgZXhlY3V0aW5nDQphcmJpdHJhcnkgY29kZSAo
dGhlIHNpdHVhdGlvbiB0aGF0IHdlIHdhbnQgdG8gYXZvaWQpLg0KDQo+ICAgICAgICAgaWYgKHJl
diA+PSBtYy0+aGRyLnJldikgew0KPiAgICAgICAgICAgICAgICAgcmV0ID0gVUNPREVfT0s7DQo+
ICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gICAgICAgICB9DQo+DQo+IGFuZCBhdCB0aGUg
b3V0OiBsYWJlbCBpdCdsbCB1cGRhdGUgdGhlIHJldmlzaW9uLg0KDQotVG9ueQ0K
