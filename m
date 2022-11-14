Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE4162897F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiKNTiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiKNTin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:38:43 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282DDBCA;
        Mon, 14 Nov 2022 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668454722; x=1699990722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4X8JlBdfix4PS6KQ5PrUN2Uz+es0n7jPVNOOOTjmZrc=;
  b=OlpSP3cNIMuqQ8QsgNlEzRZaRqItziawUbLdgs/vDNIsGaP475y+aa+M
   DEsZgi/LDribU6nvBq4hTfhYH+JV8uAWI6UyoQII0H5VNKuhyfZdFlpNP
   L0T0tw7tmB88CHG1k7SLM0YJ3vQ4hY9dw/38Dvgf1/yiz3rSgZxXPWucj
   mXcLRYwW3PaIHRS36leKtEUWLphmtbGtSWQ1uakH1fyrTZ14lRyUHzEkh
   dqspYkjxHqhJitcHs/56ap+P43xvVdWQv/WO3tgNg/t0ygGeV5MihaSaz
   0bo6WA2WFH7fTvB4JeYXEn/6cjORCOb/lqyF1gDkv7ofk04zFFiV/Jm3D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="374194705"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="374194705"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 11:38:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="671695284"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="671695284"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 14 Nov 2022 11:38:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 11:38:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 11:38:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 11:38:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWX/xXnTNRYWf89pQdn5JR/9Uc1Dz9D6dQBvhp0Cpye3SXidGjJEvSVIt1Y7wR7UNXYTTo7ZDIyqwfwGt3j95kKCZ/vUfwg+y5kFbRxL57mKNagvRPo5F/m7rtYxMIqaM7HxUexoOIZqD4IUYl22LFUmvmrL70s/N2uQ4oXsezTsgw1z4b2EoiFURD6sCI0C0zsUa1xYtFiROePpR0Edzf67BleyS6JGjuunfqAye7pxbsS667qE6KzEhKpcpcusUwaNYw3OP5kBw2LOgHuLKN40mGVq/Mkr713zBjMfk3ijzPrkCf089eFUacN5wJKADJb3Dsld9YaTslumgqj8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4X8JlBdfix4PS6KQ5PrUN2Uz+es0n7jPVNOOOTjmZrc=;
 b=Foa8QcXQqdMGsLcx+x4qDVuiWJ3vwHgVg3gl7/PasBK2PVAz/1+9znUAZkJre0q/c9s5w4i+7t6+qyxBDF77z9dodAS2DM8faCFM9iMzn5weRRh+LqFNIX0qzUIERX4BTh04lRJGQsFifKlNMkjiy4FW7B+3FjmDZbQ2v61xA2syek7pBvbUZFxREe8+SISbj7m3pzcqiE4ZqqsceN02yC/GbkQfVA6RUNGh+YLsxJtgCnbOdBxWM8lkiXHk0cN9WrUmfXdWHb7CsH6UicYP7sFnR1T2kV9liwnu0/NedJy0LjlKRMs3TB9gx0nsvMMn8sHjKbcnwYTzZbcmrymRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 19:38:35 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014%4]) with mapi id 15.20.5813.012; Mon, 14 Nov 2022
 19:38:35 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
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
Thread-Index: AQHY8vv3UouK3GalXk6mzwRA6fUNf647gQ8AgAAjoWeAANrsAIAARioAgAA5qoCAAAw+AIABuAMAgAAOBoCAAABzAIAAAzUAgAACwMA=
Date:   Mon, 14 Nov 2022 19:38:35 +0000
Message-ID: <SJ1PR11MB60837D7324618BDB33B98C24FC059@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221107225323.2733518-13-jithu.joseph@intel.com>
 <Y2/JNAmSoYlLKq3A@zn.tnic> <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com>
 <Y3CevK2zhAmiUyG9@kroah.com> <Y3DZmKYV+8HBtZ+Q@zn.tnic>
 <Y3EJ93xzgC/1v0WV@a4bf019067fa.jf.intel.com> <Y3EUPKWDefnkeObR@zn.tnic>
 <45aa0f69-2523-3cba-8f41-b1351f16b78f@intel.com> <Y3KRGx/yNfS78zQ2@zn.tnic>
 <SJ1PR11MB608361084E83E74EA348630BFC059@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y3KULFHC5JuBQdAZ@zn.tnic>
In-Reply-To: <Y3KULFHC5JuBQdAZ@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB6802:EE_
x-ms-office365-filtering-correlation-id: 510b7841-dad8-4fb8-d581-08dac677d243
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EdQUrsX9bEz7yBReSZgEk7QKGeAkemnt6XHsZqgP6h8KJ5aFX4lhH7KUDY0ipJcqwaV1sSzsXqXfmlMzGwVNOiGxJ/Naumx9V0IfmJLxcYSqfBu7uiIPXY5wpf6zLCWTINy5HVMAJnG8yB/Ov65PW1SrvNVuQxNxjWq5WB4Hww+ByUyhKYCcYCwGdRo7jDML72b9qbc9p7mkJm/voVC4SfdwDiqz5dj0ai/mooG4PBlswUKzU/V2j8xCeLL3SShxCFAyEYojIDxCTJYFHgnPz3dZAzCKsmzQeMK2rKph3BP87EGTUEXJyf8lA//rDD6nPsLwx0pna0iy3DR26/QWHRW0JkSaIBIxXrvBhfdo/G7bX2ftw0gugX7wz6Q675bRZoFO6aVCC7HQLurVUXSNDIIQtRaX2OHUbXyZ4rft5jg5/rm786orJaHAX2nTi/co6op1iuV0JNjJl2sua+CiSE9GLAmhm57xVgubRgL6723XB6VzTk2DNnRDE8Rbx8bO3mN7evcuxBj4YuUOL1OWXnfRczV0zJ3TtWhLAiHrmZfwu81tBBI3klj+OsKxMJv15IH5Ob3fm+GnDUVFHVU1mMNQSBfRkX9xYh/Syz6UdG0//5/+GTTkylGsHMaSGUB8S8knQPhOS2clb7CMkkVTkc/PIZ6GLHzDTbqj+uHaOdqUxjdg42bzVoLUF6WW0cANT6UOYCOvkf3ovfvWb/Zi3g21my/ZD5p+19dW5hLd5BSz0ulM9TPLB/rlsiXtLDsEG6JtePAkAIo1sNJrswDNrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199015)(2906002)(83380400001)(38070700005)(33656002)(8936002)(4744005)(7416002)(41300700001)(66946007)(66556008)(122000001)(52536014)(38100700002)(5660300002)(66476007)(66446008)(76116006)(64756008)(4326008)(316002)(55016003)(82960400001)(6916009)(186003)(54906003)(86362001)(6506007)(71200400001)(7696005)(9686003)(26005)(8676002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amdKQzR3VXBDY2VUb1dnajhUQXFEVWdoTXdEemtkZmZSeE5IUDFMWVVjcUdk?=
 =?utf-8?B?K01tc2EwSmpMYmsyd1FVVlJpS0JkNTQ4SFN1UE9rbkdjcDFhakJORDQzaEpz?=
 =?utf-8?B?UzExVElnYjRTdW1hamcxM0M0TjYybmhYclJRZGNmMXpjQ2E5aU1zb2x0WjFk?=
 =?utf-8?B?YWxMSld3QURZVGtqa0ZQN0JqRVlCekRxMFFLMkZ1YkdpbjR4UVRzU1VMU294?=
 =?utf-8?B?dmxiN0pKWkU0TmJBT2xlMmZIK3JEZlNWNk5lWk5zcWIvOUZaV0hhaHUzMEhy?=
 =?utf-8?B?UTMzZU05bm1LZUVlOTRkR04zUXRqaWw4Z3lSWWVvYm1rMVd0NzFnQ2tUczRR?=
 =?utf-8?B?dldXRlUwVEkwbnVUdkkvYzdoUG83c0NHUnFPWnZ6TGpkeTg3SHQrUUFubXNH?=
 =?utf-8?B?Q3ZlTXM1dnlQR0c0RFpzcFBIMVR2QnB5SUJBWmhSSWcxdTZNOTRIT2xleDl1?=
 =?utf-8?B?VGp3V0x0UktLOElnVWF4ZC9QRVlxamEwVzdLRGNhbzJoa1ZZUkpsR001Vjgr?=
 =?utf-8?B?eWNUdnp3MGhGYjVFRkNWbjdENGU4SklYRThXNkhuTzhXK2ZGNFlNQkJDelRa?=
 =?utf-8?B?ajZMUVpsZ3VsV1l3Si9sOFBLN1ZWZnBsdHlPVjYrMGR5K0h3dW5sNnQ4ZWU3?=
 =?utf-8?B?dElGREo4Y0hZWEEvYzd0b3B1dmttNC95enRnZXBrQlljR0JuMWRxZC8zd2pm?=
 =?utf-8?B?ZlhqS0pVdjZ0ZGk0K0FFWnlDb2h4aVVvakVZZU40QmdoUWh6SzJqTWE4amZG?=
 =?utf-8?B?TzViTEhrQnRyR1g0S1krVFcxTTJHWU1RaVFyeHNIMWJud0lKZVdCaGJWbHRm?=
 =?utf-8?B?bThFa3NSb2FLRFlSMHovbEpwMDJLeWtTaGJSdTZzZS8yVFJFNy9zYlVaekxN?=
 =?utf-8?B?ZFpYSXNzemN0aG94V2F6dUtwZndjbzRUWEcxT2wzOUpDeG5WQzlSd2FWaldW?=
 =?utf-8?B?WENPTjh6SnhTN1RIM0MzZEZHa3lGWDNDdVFycVlUNXo3ZjI2YWl0cUhhWDNL?=
 =?utf-8?B?Q3A5M00yWG8yZkpzZHU5UTY1Y05jTENzYnB1STdzeGFpREF2N1kvK1F2MjRP?=
 =?utf-8?B?L1BJQ1M3cTl0SmtOQkhyTU1lSWhnYkRGMEVqNWlvR055bm1wTk1XN3ZKWUlr?=
 =?utf-8?B?bE9IenljeE1RUG5TM0FtYlIzc0JvNzRzalhxVVFZbW5MTXp5clpDY2ZzMVY0?=
 =?utf-8?B?cjRQSGRNUGxpV2FndEt2QzF3YmpESlprU3dVc1phWjZIWkxEM2c2VXFRTExP?=
 =?utf-8?B?YjY5bXJDSnZzTkg4MHlVMENKMHJ4dExjd3ROQ3N3Y1dHbVR0bWFrMzRheVRX?=
 =?utf-8?B?RWRXNW04Q3VVUHA4NHpVYUhGNk9xTmVGWDRZUDRFTUhXaFo0Z3UrSVZLVUd3?=
 =?utf-8?B?TFVPKy9iS2hBL2JZOE5LVWRDWHNycW54YzMzRnMvWW9COFNjZjdxb0ppV1E1?=
 =?utf-8?B?Q3pkVDZndG1FWit0VkpOZXNseDV4Yk9Nb0xWb1o1V0x3ajNlNzBlSmxZNkV3?=
 =?utf-8?B?WTJvZmtSOTZXZ1VGRTZmbGw2YXNqUlJTUE5Ha2RHRC9PMjN2UnpYS1dJcTV1?=
 =?utf-8?B?TUR6QnkvMEJTMDNlMHQyc0NXdUZLenZ1RFgxUkhoRWlKaDk1U2lsN0JrMVJy?=
 =?utf-8?B?aWExR2F3Vm9LcU5tcWdiWXV3WFR2dmpxVlAvWkRndU1XTUplUGRIZEVoMXlH?=
 =?utf-8?B?b2tkbDBTRzZYNndxUW80MittejlNWk5KOGR5ODM3SHcycGh5b25OZXJBMk9K?=
 =?utf-8?B?bnlCSDU5Y3Z5dXpYY3Y4dm5NNTVIQy9pbmZoZU9BVEtFZVlqWk9kTlZRYmhv?=
 =?utf-8?B?L25ZMHd3dnFsdWx5a2Q4S3ltZGF3TnFkdytlKzExOWs5ODM2alkwVFROSFNK?=
 =?utf-8?B?Q0Rsa0R5R293dXV4SjNUZ2xxemtNNE1WSmJRVzJISzEzamhIVmJNeEpoT0hW?=
 =?utf-8?B?ckVid2JIYzZPR3NWOGJlZFZWN0tjZit6NWRSdmF5cVJRalEvVmhic3VER2lX?=
 =?utf-8?B?ZUgyNlBjUktLbEsvR0ZrWUxUOThCbEVDQkErY0Z2RGhISGZsYlVYVC9IdThW?=
 =?utf-8?B?N1ZQc2lGdUtwdDk4Z1M1QmtqNmxnMVByK1VkcjAvUFQya0lidjR1M1R5VkQ1?=
 =?utf-8?Q?z3nMiAJvTtCBzxtg450nmb3Vw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510b7841-dad8-4fb8-d581-08dac677d243
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 19:38:35.6790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAP97Hqdp9D3fcTWug7lDJIkHG5dkVyKrUg9UhqaRAtWSdxBhjZefLbQcTEOVf2HTQPiIKw6Fq03MlMnkxBH6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBZb3UncmUgbWFraW5nIHRoZXNlIHNlcXVlbmNlIG51bWJlcnMgdW5uZWNlc3NhcmlseSBtYWdp
Y2FsLg0KPiBBbmQgdGhleSBkb24ndCBuZWVkIHRvIGJlLg0KDQpJIHNlZSB0aGVtIGFzIG9wYXF1
ZSB0b2tlbnMuICBVc2VyIGFza3MgdG8gbG9hZCAidGVzdCBzZXQgMiIgd2l0aCAiZWNobyAyID4g
Y3VycmVudF9iYXRjaCINCmFuZCB0aGUgZHJpdmVyIGZpbmRzIHRoZSBmaWxlIGZvciB0aGUgZmYt
bW0tc3MgdGhhdCBjb250YWlucyBiYXRjaCAyIG9mIHRlc3RzLg0KDQpOdW1iZXJzIGFyZSBwbGF1
c2libGUgdG9rZW5zIC0gZXhjZXB0IGZvciB0aGUgc2VxdWVuY2UgaW1wbGljYXRpb24gLi4uIHlv
dSBkb24ndA0KaGF2ZSB0byBzdGFydCBhdCBiYXRjaCAxLCBhbmQgeW91IGRvbid0IG5lZWQgdG8g
Z28gaW4gYW55IHBhcnRpY3VsYXIgb3JkZXIuIEJ1dCByZWFsaXN0aWNhbGx5DQpwZW9wbGUgd2ls
bCBydW4gezEuLk59IGluIG9yZGVyLCBhbmQgdGhlcmUncyBubyBoYXJtIGlmIHRoZXkgdGhpbmsg
dGhleSBoYXZlIHRvIGRvIHRoYXQuDQoNCkZvciBUaGlhZ28ncyB1c2UgY2FzZSwgbnVtYmVycyBh
cmUgYmV0dGVyIHRoYW4gZmlsZW5hbWVzIGJlY2F1c2UgdGhlIGNvbnRhaW5lciBydW5uaW5nDQp0
aGUgdGVzdCBtYXkgbm90IGhhdmUgYWNjZXNzIHRvIHRoZSBkaXJlY3RvcnkgdG8gZmluZCB0aGUg
ZmlsZW5hbWVzLg0KDQpCdXQgaWYgdGhpcyBpcyB0aGUgb25seSByb2FkYmxvY2sgdG8gdGFraW5n
IHRoaXMgcGF0Y2ggc2VyaWVzLCB0aGVuIHdlIGNhbiBzd2l0Y2ggdG8gZmlsZW5hbWVzDQphbmQg
bWFrZSBUaGlhZ28gZmluZCBzb21lIHdheSBmb3IgdGhlIGNvbnRhaW5lciB0byBiZSBnaXZlbiB0
aGUgbGlzdCBvZiB0ZXN0cyB0byBydW4gaW4gdGhlDQpmb3JtIG9mIGZpbGVuYW1lcy4NCg0KLVRv
bnkNCg==
