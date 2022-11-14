Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61E628847
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiKNSZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiKNSZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:25:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F392BB25;
        Mon, 14 Nov 2022 10:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668450336; x=1699986336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+HInarxajE5C+6ayonsaWwYQQtZmufouL3AHQ16toWc=;
  b=LqMFrMoADRqvJytVgEWuRe3hbGZakG06RrxX9NruUh8f/7mQBzHGXaX3
   8O1EvHzjjii8SbU8p09kBpyz13THm5EmfzwHW5VXrvYdxSstb1LZ7fDKH
   qp8e6ULVA9r8+dj4wAlo5cRx86w6Cuj4pXXcnppsKZ5aXOR9ueuNDXSb4
   0SCaXCm0dSSh0u6Na4t3u/m4lCGFQ2qmkWs8YixF8/7vP/ZEcbRDJ8c3n
   UwLWu2mjDGfJC+zz63RGquaMeMS0eKhPwUEAgPxecM/IPIeG3LoHe8LvR
   zoDtAl/w48J8+uenILnBn+H73cKFpFrHF1fG5D65L+IFHcnld6ueOg1/a
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="376311905"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="376311905"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:25:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="763586961"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="763586961"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 14 Nov 2022 10:25:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 10:25:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 10:25:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 10:25:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imMl42BC8rw57u6efrptFBKz+MUZ7WEH7j39071mqTDJKN26/JFTc//JIwiGsHMmNFVCS6jwibzxvkZiH1TpaWKFPcS40N888vZIjtBpF6v9A127CQFRuzzvNpjEmQb+U/ZxtZ5NgULdIVDq1SqRtDq1uaIJKJYynw0WD7820GzcDd78MLhyJX+uF7BQZg4+RKDmQKwFPNa/n/Itr5eiJyVn6hheA44T+4tYMUTKtf8pXqvRjuWAgPrDP6C9H24fr2A8UOJb8Lkt/YF81fwVhHEWtcYQrQJM8TQCZIH+CfAJwejOhAzFhkGCQL/Vcck/JzLb+lkxYwNQq7NUvnBekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HInarxajE5C+6ayonsaWwYQQtZmufouL3AHQ16toWc=;
 b=YTaOeiRzKbfWKIp/iwlR9xRjVRzF//QaIo5BwZueAlnVdC3sz2gg5XzLXEl3DIIms7+q7WVgV+UeYCVxyCDugzK8bY4wssjed/gbDOo4GJfgqDfu4om0vZgiikJVrr1TqyG2hSgFh+PQYwHSR9IvbeOfy8CezTgOr6wmfTqTzJ62C1NAnhGM6wb9l0GZ3fWzajFqzZpWXbTlHeFeEtgchx6frwUMlSmUDMHQo31zwQdJHntXisCgDRp5C2Epk0nBFy6tAfgC9c9CqCt3uRdaU7D4rf0GkvBxi1AIGBZrjPr3XlOelrmhsWZfWWqu3ItFFEMWdBim//xYx2Wiazut2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5363.namprd11.prod.outlook.com (2603:10b6:610:ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 18:25:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014%4]) with mapi id 15.20.5813.012; Mon, 14 Nov 2022
 18:25:28 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Raj, Ashok" <ashok.raj@intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHY8vv3UouK3GalXk6mzwRA6fUNf647gQ8AgAAjoWeAANrsAIAARioAgAA5qoCAAAw+AIABuAMAgAACE8A=
Date:   Mon, 14 Nov 2022 18:25:28 +0000
Message-ID: <SJ1PR11MB6083EF42847118D2BB47528AFC059@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com> <Y2/JNAmSoYlLKq3A@zn.tnic>
 <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com> <Y3CevK2zhAmiUyG9@kroah.com>
 <Y3DZmKYV+8HBtZ+Q@zn.tnic> <Y3EJ93xzgC/1v0WV@a4bf019067fa.jf.intel.com>
 <Y3EUPKWDefnkeObR@zn.tnic> <45aa0f69-2523-3cba-8f41-b1351f16b78f@intel.com>
In-Reply-To: <45aa0f69-2523-3cba-8f41-b1351f16b78f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5363:EE_
x-ms-office365-filtering-correlation-id: 0bb16ad9-259f-4058-8e56-08dac66d9b74
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 908Xl21NX4sl3W1dEC+/EQeV6EkHghCnGsroIhqSYVNp8OkJz0X1nZzPcUTyQCL9faIMtlaxQwDAKBjbyoEbkX8r0mV7C+xx27Ja9UndrgS6Eo+gr/LPJ3QJvpwUq/V1GONB2DieozwKMvwSOAOOLXXysgQ+jLfnsRzFxe/VNYGq1vy8cLX4PXiSD6Y8gmUh80/TuiNAzq/xpFpehQef2wkZQro98WmQBNMDTkpPB/ovE1+yQvENGDdGErdzJ0aCBkkfTp4HH2jro3bJdhVJIP1+G/uRnXhpf2v8PdTkjitOu3DOfpOTbSoPz7/jyaLXKkv+wrIKJqUgpX8diYVrV6nKtmrbOJpYKU9R6sDL+8ll7ECFeUnAhLh2aAJK4urkysM/QV0QEDQuDMXEEQXaqyos5DEXHAd2UVEr5kjQ6sqXfIf9XqiQ4/9cgq72Z5/btKCgJ1GopYP1ero6sYePbZEMqdbQyG9v7uD0Dhebx9+ka6+lnWaPK4ncJmoflELLTrQ+WcYm6CYgmmup1DPTrflxdNkdKAPKV07KpNfpi+WS/zYMTKekN9FKCL1dLKl5KG2XgfSyNBwqpLpzuOmsgdV5k58pZFQAiJAbq8DOTjnb+RuLfJ10CVVxkB5EUtvFN+Vqq50zSks7BCX+xQo8Q2pDO0m87Uki/14F37LM8ws16wJT/XjWyBIDOreb4IWBG5eDahr0gWV6zNu3/6KVly0STa6opX0yWqbMR3y/FxMC66Ilc4o8cxISVDDUnYcDcdfOgZuJze5yKU4gKHKqDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(6636002)(33656002)(38070700005)(71200400001)(54906003)(7696005)(110136005)(6506007)(478600001)(26005)(9686003)(66946007)(8936002)(4744005)(66446008)(55016003)(66476007)(66556008)(76116006)(4326008)(64756008)(8676002)(41300700001)(52536014)(7416002)(186003)(5660300002)(83380400001)(2906002)(316002)(122000001)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFJCK3dQeEJQSzJNakc2VjBlMDVMU1NLRldsaHJMYUpJTUt5YUtyelRTUlpa?=
 =?utf-8?B?a2NjWEVoblV0TlllcjRFdEo4dFd3OGJDVlF4RTZueFBROG5FVEYxWG1wU0RU?=
 =?utf-8?B?KzdsdXBxNkJ0WGxjL1ZEVXNEcTRZRHdUdXlMMzU1eE5vNmFnaE9CbkdWNmgx?=
 =?utf-8?B?YzQwN2hLTkJTd1R3LzJwQjJaQ2ZBUHFjTDJZamNYcWtGeEh3cHpuYU9zVVRh?=
 =?utf-8?B?R2Z5V3d2ck81VFpCTDM2UXNlajlZcWNtdUpnOXBQQ0NrR3J5YUtlKzY3d0Jk?=
 =?utf-8?B?d0p3NkxLK0c5TGtGK3RnL2FwUHZQUUFmV05iMmh5OGlGbkhySDJub2RDQUYv?=
 =?utf-8?B?bXBtblpUWFJobXk2dVcvdUZIdFFxL21Hdlp0YXh2a3ZkK3h5aCtEanZXcThF?=
 =?utf-8?B?TjFvVXBxN24rcEtHeEU5RUpkMVRYZUFGbmlvQThmbTk1ek1reFZsY3Q5Tys3?=
 =?utf-8?B?UkhvTDBkQVpRbHQrYXhaUENMOWlvbUdXcnN1ekw2QklETXJKNTJuVFo3QUNq?=
 =?utf-8?B?bzFjR0cvL3k0UDhoZ3k2emxTYThYUnlya1d6WXJleHk3NXU5eElhYmZCMW9Q?=
 =?utf-8?B?VTJJcVJRejg2QU03a05ybHVNWDlSRXA4SS85Wk9RdFByVmFkbXNPNFFyZVdP?=
 =?utf-8?B?SFdUQXV3MUtxV2RhZDNjR21DZlFSVnptQkY2K1pYM09QRHFBdHVaQks3VGpt?=
 =?utf-8?B?c3JQeTZFNGM1dmpDS2lHYlhCaitMREpQSUhzMmZrenlpVnZDbFl2eDV2MHJj?=
 =?utf-8?B?WnZtc1gzL2ZzMS90eTFOTDJUSUVlblVRb3ZkMGtWc1IrQ0JrSmZ1U3MzMG5s?=
 =?utf-8?B?akUrc013U2FuUjFRdnQxang0MStzNlNoZ2g5R1RTdnErZHNnUTAxK2xnNFQ2?=
 =?utf-8?B?L3JqM2gzZWdZVTJDL0MvM2dyUHdMeVdoZDNncGZqczRDWTBkNGdxMlNyeVlt?=
 =?utf-8?B?SnVEMjZISFN2S2c2Q3hVRGJ0SDU3M2tRZWkrVWxNS2phUkNHYjFQMVdLTHN6?=
 =?utf-8?B?Skc2NWxXL3NId2VEeGVkVnJ4UWkwWlZnUTY5bDVla2V3VkRiODRjYm0raG16?=
 =?utf-8?B?UGRGcG5iSnhzOVR0a2tKYS9JeC91ek1JYXJablBaZWNZOXJxcTZBT0VTTTVR?=
 =?utf-8?B?c1NnNXJDY0xKMExRZnhoZ2xPSHdEa1pMZTN5b2MrdTNKcjlqVzlIdU9QNlor?=
 =?utf-8?B?M0pTeUMwMzZYc0xBNVVybXUyZlN2dnBkNWpxNFRhRk1WUEtUZFNzVFZOanFJ?=
 =?utf-8?B?bmMzbVpiVHExRkg0VU9nbGpOVm41WGNnYTFTeEQweUovTHJvaVFTRmkramtJ?=
 =?utf-8?B?dzA3QkQwUmRYUjJKSmtUYjZxb1piZm0vWXhlbnV0VkR4ZGN5NlRYdFB3OHMx?=
 =?utf-8?B?dlA5TmVOSzE0K2RzYjVvOW0xZ3FLRjcvWmVKOFBkR0dUL3A3WjZYUXhqekl2?=
 =?utf-8?B?aWpjdkdCOUhIY0NLb3l3QS9mVGZNK25uVVRLa1lHY2pCWG10a2tyUW9TSnha?=
 =?utf-8?B?bDF1SlI1blFucFVVNlk0MWNMbFdiTzZSb3gvREZ1VDczWUhKa1pZRTAxdGt1?=
 =?utf-8?B?Sk9Na1JibjJQbnRCUFZGdkFJRytlZGJVU2Y5ZEFyanhCdHZGQTlQaUNTMVZv?=
 =?utf-8?B?OWZUODNZdko1dUhXK2dlTnhQM1FSVzVOVUdMMC9mSWZDQTJmV0F5MnBtbFhw?=
 =?utf-8?B?OFUvTXRGa1Ivc2RTVXlqLzF2K3ZSMGZveWhycDBGNGcxSlV3N1E5R2pRR21T?=
 =?utf-8?B?ZWxZL0lzUVFHUmwxVXpYQWFHa1NGREF6K1EwVUlrUjN0NWhJYVVaOTFscDYr?=
 =?utf-8?B?ZjVySjNRUXdYVGI3Rm5mMFp1ZXFBMElOVzZWcC95dG1aT0xVa01mZmZFdmky?=
 =?utf-8?B?c0FvL01NNmY2QTk3NTh2M20vMXhQSUJHNkpDd3VoQk1UaUNmM0Z1OWNGNzVv?=
 =?utf-8?B?M01xUC9TZ0U1Wm9IckFpY1NsNE45VlNYeDJlRHp6M0tYNHZkVFlxQ0hydXZh?=
 =?utf-8?B?MEdUSzNVcXRlRGdIejZpNG4vWnk2bGp2RUhaQnFUa3hHK1BDTjVWdmNJM3lD?=
 =?utf-8?B?WnZzNk1TNjczU0ozbnVWOFlyOEt1dytvUldyVEcwU3U2YjB0TVNVaEowQU9h?=
 =?utf-8?Q?Yf0I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb16ad9-259f-4058-8e56-08dac66d9b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 18:25:28.7563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gj0Z5HLMQ6JS4dg7oKxvB08j7uFpSJ8FvSUJpg1aP/J4FUSSGU+T7kce/598BZvHvAgLQpK3Y4YOSTVvD0C6Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5363
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTbywgd2hhdCdzIHRoZSBwb2ludCBvZiB0aGUgc3NjYW5mKCkgdG8gY2hlY2sgdGhlICpmaWxl
bmFtZSogb3RoZXIgdGhhbg0KPiBzYXZpbmcgc29tZSBwb3RlbnRpYWxseSBleHBlbnNpdmUgcmVx
dWVzdF9maXJtd2FyZSgpIGNhbGxzPw0KDQpOb3QgbXVjaCBwb2ludC4gVGhlcmUgYXJlIHR3byBz
dWJzZXF1ZW50IGNoZWNrcy4gIEZpcnN0IHRoZSBkcml2ZXIgY2hlY2tzDQp0aGUgRi1NLVMgaW4g
dGhlIGhlYWRlciBvZiB0aGUgZmlsZSAuLi4gc28geW91ciBkYXN0YXJkbHkgdXNlciB3aWxsIGJl
IHRod2FydGVkDQpieSB0aGlzIGNoZWNrLg0KDQpJZiBhbiBldmVuIG1vcmUgZGFzdGFyZGx5IHVz
ZXIgZWRpdGVkIHRoZSBmaWxlIHRvIGhhdmUgdGhlIHJpZ2h0IEYtTS1TIChhbmQNCnJlY29tcHV0
ZWQgdGhlIGZpbGUgY2hlY2tzdW0pIHRoZW4gdGhlIGRyaXZlciB3b3VsZCBiZSBmb29sZWQsIGJ1
dCBtaWNyb2NvZGUNCndvdWxkIHNlZSB0aGF0IHRoZSBzaWduZWQgYmluYXJ5IHBvcnRpb24gaXMg
bm90IGZvciB0aGlzIENQVSBhbmQgcmVqZWN0IGl0Lg0KDQotVG9ueQ0K
