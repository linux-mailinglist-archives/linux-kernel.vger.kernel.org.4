Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49AC6C4290
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCVGA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCVGAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:00:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFF25BCAA;
        Tue, 21 Mar 2023 23:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679464833; x=1711000833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MVwGWfN2ZFRlyR9Mi3nRg9uKWqbgndnWYKuEPrgKY1o=;
  b=XW71TsBnggop2/dniJQWklqe1gUIgRfsZT+zGpeGpsAPXuCeS1KNw+5o
   QLwnGqE7Jf7QJ6E4bjU0VCOEGYVbpFCPRfsA6i2GNcfNV0ln3+klDzYOm
   NnX1TJ0zanyaGc9S+mrJ7pEkvJ+/zIyCXuJjKWvwPYrJrCJd/9Zctuauz
   MD7T+CkTOWLQbsFgLb9McRTjUaajU7T9ndeSyACM/PvbSSoztq6On1MpK
   wqRRG2xwrGZWUrcrftv8muzO4KEgqqQXC+wH3VaeSgRr9ofjxsbDJVExH
   sQFqVMnsGpXFzr3q6U32qLJM7lAdlYZiq7BM25EAak3QLd55d/sWTHK/O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="366871516"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="366871516"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 23:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="856001951"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="856001951"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2023 23:00:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 23:00:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 23:00:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 23:00:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+5vAOItf/MUinHHAX5k0icvlqnlWsg4bCC+aYBXVFTxUzh65xdJXQK2bKrsm4PdousypscBY7Z5on67EeqQ9EFeX9DgTjz9mwkgMqnHUXCe+Ih25iqa11bZVWGUlaPw0SbA5rxZ7tTP/HmoovZEz3ejv5/9X6ABubnfiKNpRMtdkNXZeEVkbxkX0AZaCnQh1oi6EfQBWXbrCBg/lmM2YvU6728iJku5b21LfFSy9konOfjTD9EMLiOjsvOqi89jU+3VKiwOf5lHiAqRoG3QEPTO6/71fKrclBUj7xgNyG6s+N/5lOnqlaX81fiTN5H+qaHHiWyhFfBghSlulsr7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVwGWfN2ZFRlyR9Mi3nRg9uKWqbgndnWYKuEPrgKY1o=;
 b=S/NSzwquEcb1weiPiH2FxiMAGgIzEaBGiZn3J0+jNVzrpAAioCvZMVHextdi7STJHCjnzxmfdNDYci5rsJORGsZO0vGf76RE3QzBV57EVjzLj8PRJta8lMu47uByojzdNFZlYFTpgUAWZwgHeIcbvwzFc0ViBlzj54JLtLM/NcqjlupX3jLMLfmroOsFFbrlodqvL/gt/GQ4F2sLk29RfFw2KRT2Dq+bR2/76AYTloty40X/OCUrskvae62qmk3v4dzWR9AVtCT5tyNDvBdR28A/+43oJLVny8TrYOBhwME5qhMuRsJPLj/ZEfZ21QLXPFicBSEr1Vw04dHrkE2Emg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 06:00:20 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 06:00:20 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/core: update cooling device during thermal zone
 unregistration
Thread-Topic: [PATCH] thermal/core: update cooling device during thermal zone
 unregistration
Thread-Index: AQHZXAxfdUPFzf4RiEeXZs2Dr6MYUa8FotGAgACsPYA=
Date:   Wed, 22 Mar 2023 06:00:19 +0000
Message-ID: <343627e3d1ce5c9b1df256d69e87dacbd898d1a5.camel@intel.com>
References: <20230321154627.17787-1-rui.zhang@intel.com>
         <CAJZ5v0hof_Hb0awv8-MkTwcKVQvrWvVvu-yBcFFw8C67Hzr6=A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hof_Hb0awv8-MkTwcKVQvrWvVvu-yBcFFw8C67Hzr6=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|PH7PR11MB6722:EE_
x-ms-office365-filtering-correlation-id: 5a4a8f06-ec78-4ab4-f157-08db2a9ab7a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6KiexPEp+VIbIS0TxnHBC+FSLg9+W3AaAypsfelG9kToeyIPqiz1MdjS27AMcJsrx+ZH0hrYklBMUspq0VQ7U2qglCaoKrp7rsIUHWb7BgGQME1Uj972K8QMxULBLpHmVB+xovy+4pM9tuZ9ivRqGvFN/CN4O+wtWTZcEw25Q4uM1pP/GbZXZwGVOZfR/ZqVSdtXorSHhoxn6jWOxbeyOO0S7AEj8Ke6SznljVxvkVjO6mKVGxxXhC41X/0Nb85KkRVPmKTTP6mf4/3BLopz8S8Zeh8+x55jSq53lk1lqc4JQbXq3oIL4zatkp7h+Qr3HRfjyI4AD9j8kaGqsjUXam+1D2eXweuQsZTBhYrD2hLc8G+7+HBIvZ6FfumAONFVY8VDJe5MLfBGQGV4PhPVtgm0YYhRUb4fRuJ9LeErpUZwI+g7+wSjsmXWZH6dhzSU/GfXvJjhj4CRDEHmNxzt4A8WyuJBZ5izEpcH3JN0IzLTDsjElApB9gtLtvtTvdjC8m5Hp8Y9u9WOZdMUJ43NquHTuxkW4O1RisgNw8mr3rZYgc3y5Bfo4jweKnuwEo5LSCBuLkpHd/4Mly6FlOcd6a3O7ghPgH+wfNc9+C62jtyNktq8RXYwBYw+eYCiLMOcYKY7Q9UxayNVxQFuzERM2fyug1BHRjB0UdMP2rf16HvcwvzwzBt+WOIesuRQXJZbiyOjFWTZ9xDsUOlmOer2Aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199018)(2906002)(15650500001)(6486002)(83380400001)(36756003)(6506007)(53546011)(6512007)(8936002)(5660300002)(86362001)(2616005)(26005)(82960400001)(41300700001)(186003)(316002)(54906003)(64756008)(478600001)(76116006)(66446008)(71200400001)(91956017)(66476007)(66556008)(38070700005)(122000001)(66946007)(38100700002)(6916009)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NERicDlhczI2dFNsV3Nlck9jWEJrYzZPZHVuMDdGWjJRZGgxb25BT2pjeWxS?=
 =?utf-8?B?b1U0bnJBYXkwMnRnNW43dzVkK241NGRqUnRpM3JGdzMwUzdUNWN6YSswOGhL?=
 =?utf-8?B?aTNjU3FJVFZiM3pabHgxWWNBTmwwZUVxeFpwMm9leVgyYWFiZkNpT2x1a0J5?=
 =?utf-8?B?NU11VHM3U1JTUnd2U1A1Z2RCTHVDYXFESHRpWTRmLzV5b2xNdUFjZW9kaUV3?=
 =?utf-8?B?Qmd6dThSQTBYQk4vQTVya3haSDErZzNBZ2lsNmF3bG1xaXJIVHU4d3VJRmpR?=
 =?utf-8?B?WkxDak90TXkxKzdxa01nM0ZyY29TQU5pc0puZHZvUkxEZ0t1RmNjcGsyYVRT?=
 =?utf-8?B?UlpneDJ3K1N2L0lMRERFblRzV3ZNU0VSalE3SnIxQy9RTVFiK0ZzbXVCTXJo?=
 =?utf-8?B?VTJCaGhWMEI2RzlYSVJPZUNzYUZOU0NkZ1ZHVXhzd3NGTy96a0dHc0cvZlI5?=
 =?utf-8?B?amN4TjRZNjlmM3lEL0lMRHQ0MS94VzRkcFFQVDlTQ1NFWnF1QjI2bFRYV0E3?=
 =?utf-8?B?WU5CUE9RZWsvbXIzOG9yTHc5SHA4RHp1aFNIVmZ2TXhjWjc3aHRHaE83cE9Y?=
 =?utf-8?B?MFBzVjM4VGduS0poWm04NHlCVUJRb09SVjBJcllrcHg4dkd0Z21JbjZhSVhj?=
 =?utf-8?B?ZGUxS3kvQjE5N0Zic29idXlBemtlQktmb0wrVjIwYkNJc2VKaXc1KzlLY2VW?=
 =?utf-8?B?R09xWFhwaERIMEhXYVFMaWFDaHVaQWlaMG1NZlBHL05kRFZQTHY4QzNmTlMr?=
 =?utf-8?B?TWhDeVp5RnBHS3dvQmRUbWxNeVJldXMvbG1xYzh6YXI4SU8wSmtXOTVPYTgr?=
 =?utf-8?B?cUZ3d2gvYlg4WFUrbjhXOFhBOTFINzRNeFRGQlMyaFFtNVJ6M0hQRW1WZ3ph?=
 =?utf-8?B?V2NZVW9XeC9kYnNNYU9KS3ZVbnRWcU02VHRWNWpXM0NHRkJjRXV3OGVjL2t4?=
 =?utf-8?B?N01Wb1RLQ3RTTW5NZHI5Qi9lQXpqNTNIcTVOSkxGTTBqcndCSCtCVnlQMTZj?=
 =?utf-8?B?cTJtbGl0bHkrNlJ1L3V1NzZyeVBvalRQRkdQQkl2YVhMWTV5b2p5L3g2amta?=
 =?utf-8?B?bVZFcDlkbEFhdXlJZFR1R1g5VVRJb2xURnNiYVoycDJJUEhiNGhRTTRneE9M?=
 =?utf-8?B?c2RNcWVocFhqQXBURW4xRGpKdkw1QXJSenRQTytTaXorSFFZQmYvYlFRVzBO?=
 =?utf-8?B?bVdtQmNYTHRGUXo1SG5HQjlpcHU0T29XdGpEc1FNc21IMURWUU15THpjRTVU?=
 =?utf-8?B?RGx5OERLRlZneUh5ZmpBUXRyR1JJcElHc2YzQ0U3b0N6c0s0ajVLLzkxMEpm?=
 =?utf-8?B?QWx3WDFFQnRzaUpDdi9QMDJzSjBmZ0RJbmhJcCs5emgvYVRma1lZSGFlWG4y?=
 =?utf-8?B?enp2VHc4NlF6LzJYTUV5OXhFd0xjc0lEbTEyQitZS2piczlESFZZa2svSXow?=
 =?utf-8?B?YzI3NlhtbVREZzEwb05aSkhZc2tCT0FFRFV5a3BnZ1NHb2FZV1pFeUV3YzMw?=
 =?utf-8?B?R3NFcmxUOHR5SkFEaHZjbDdzTmVJaUk3WnpaSHJDalZWOWdOMTUzeUMvV1lZ?=
 =?utf-8?B?ZWFWMHZLWmhobE5OUlM2S2J3eUFVM2NCbytRdyszVWwwbjNqVCtmR1N4RTZX?=
 =?utf-8?B?dFl1QmovMlBqTEkreFpTN2dnQUM2ZnZFbWJVTmJwdHgvTjV5UDNNNVFLSDRO?=
 =?utf-8?B?QzZjUmhlOExtNVpDZ1RVditkWXVvUklmU0VYUkozOE1TRzVCaXdXaHh3RGJX?=
 =?utf-8?B?Mm5xWWxCUCtVWGg0NGV0YldqRVRRS0M0L3d5dkpHTVhadTl6bml2by9BamdE?=
 =?utf-8?B?OE1LSTdHbjhwWnhRckVrbHkzS09nMW5JelpmaDJVUlhhMGxWNm5TdzNIbzJO?=
 =?utf-8?B?RDRFRExSR1I5QXpvenBBWUxhSDdDSTN4UU1yOG10OURqTEVzK3prRU5RK05B?=
 =?utf-8?B?K2JDT3Y5WmdFTXZ0SmMzZnQ4dFFsMStJMjJkMWhJTms3a3NjUkJDTllKdWFJ?=
 =?utf-8?B?Y0JGOUtQVHFCa3lVMUNrU20vZjErZmxZR1VIL3ZsTkhjVitlemtNaGZVMVNp?=
 =?utf-8?B?cXc5RW9kYS9MSWExQmZCWXVadVVFa0J0RGY1c2ZvaHU0S0FoVXdvRmwweWVY?=
 =?utf-8?B?bjFGNENOU1lPTDZEczlkczI1U0RwK2VSK0ppMVNMZzUzNmV1VS91OGk1dHZy?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ECFA2D3AE177E4B852027895876559B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4a8f06-ec78-4ab4-f157-08db2a9ab7a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 06:00:19.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tB+ckB7Zcr2Zaij3JGSe5RMr6BCLLHTsQeVOUpH/D2eox9cMDRRZqqcTe3am/O0EK3ooaZiuXw5OQBtOMXEISA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6722
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAzLTIxIGF0IDIwOjQzICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgNDo0NuKAr1BNIFpoYW5nIFJ1aSA8cnVpLnpo
YW5nQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gV2hlbiB1bnJlZ2lzdGVyaW5nIGEgdGhlcm1h
bCB6b25lIGRldmljZSwgdXBkYXRlIHRoZSBjb29saW5nIGRldmljZQ0KPiA+IGluDQo+ID4gY2Fz
ZSB0aGUgY29vbGluZyBkZXZpY2UgaXMgYWN0aXZhdGVkIGJ5IHRoZSBjdXJyZW50IHRoZXJtYWwg
em9uZS4NCj4gDQo+IEkgdGhpbmsgdGhhdCBhbGwgY29vbGluZyBkZXZpY2VzIGJvdW5kIHRvIHRo
ZSB0aGVybWFsIHpvbmUgYmVpbmcNCj4gcmVtb3ZlZCBuZWVkIHRvIGJlIHVwZGF0ZWQgYXQgdGhp
cyBwb2ludD8gIFdoaWNoIGlzIHdoYXQgdGhlIHBhdGNoDQo+IHJlYWxseSBkb2VzIElJVUMuDQoN
CnllcywgdGhhdCBpcyB3aGF0IEkgd2FudCB0byBzYXkuDQoNCj4gDQo+IEl0IGFsc28gYXZvaWRz
IHVuYmluZGluZyBjb29saW5nIGRldmljZXMgdGhhdCBoYXZlIG5vdCBiZWVuIGJvdW5kIHRvDQo+
IHRoYXQgem9uZS4NCj4gDQpUaGUgdGhlcm1hbCB6b25lIGRldmljZSBkcml2ZXInIC51bmJpbmQo
KSBjYWxsYmFjayBzaG91bGQgYmUgYWJsZSB0bw0KaGFuZGxlIHRoaXMuIEJ1dCBzdGlsbCwgdGhp
cyBpcyBhIHZhbGlkIGltcHJvdmVtZW50Lg0KDQo+ID4gVGhpcyBmaXhlcyBhIHByb2JsZW0gdGhh
dCB0aGUgZnJlcXVlbmN5IG9mIEFDUEkgcHJvY2Vzc29ycyBhcmUNCj4gPiBzdGlsbA0KPiA+IGxp
bWl0ZWQgYWZ0ZXIgdW5sb2FkaW5nIEFDUEkgdGhlcm1hbCBkcml2ZXIgd2hpbGUgQUNQSSBwYXNz
aXZlDQo+ID4gY29vbGluZw0KPiA+IGlzIGFjdGl2YXRlZC4NCj4gPiANCj4gDQo+IENjOiBzdGFi
bGVAdmdlciA/DQoNCnllYWgsIHdpbGwgYWRkIGl0Lg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBa
aGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdGhl
cm1hbC90aGVybWFsX2NvcmUuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiA+IGIvZHJp
dmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+ID4gaW5kZXggY2ZkNGMxYWZlYWU3Li45ZjEy
MGUzYzliZjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5j
DQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+ID4gQEAgLTE0Nzcs
NiArMTQ3Nyw3IEBAIHZvaWQgdGhlcm1hbF96b25lX2RldmljZV91bnJlZ2lzdGVyKHN0cnVjdA0K
PiA+IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6KQ0KPiA+ICAgICAgICAgY29uc3Qgc3RydWN0IHRo
ZXJtYWxfem9uZV9wYXJhbXMgKnR6cDsNCj4gPiAgICAgICAgIHN0cnVjdCB0aGVybWFsX2Nvb2xp
bmdfZGV2aWNlICpjZGV2Ow0KPiA+ICAgICAgICAgc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2Ug
KnBvcyA9IE5VTEw7DQo+ID4gKyAgICAgICBzdHJ1Y3QgdGhlcm1hbF9pbnN0YW5jZSAqdGk7DQo+
ID4gDQo+ID4gICAgICAgICBpZiAoIXR6KQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+
ID4gQEAgLTE0OTcsOSArMTQ5OCwyMiBAQCB2b2lkIHRoZXJtYWxfem9uZV9kZXZpY2VfdW5yZWdp
c3RlcihzdHJ1Y3QNCj4gPiB0aGVybWFsX3pvbmVfZGV2aWNlICp0eikNCj4gPiANCj4gDQo+IEkg
d291bGQgcmVhcnJhbmdlIHRoZSBjb2RlIGFzIGZvbGxvd3MuDQo+IA0KPiA+ICAgICAgICAgLyog
VW5iaW5kIGFsbCBjZGV2cyBhc3NvY2lhdGVkIHdpdGggJ3RoaXMnIHRoZXJtYWwgem9uZSAqLw0K
PiA+ICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShjZGV2LCAmdGhlcm1hbF9jZGV2X2xpc3Qs
IG5vZGUpIHsNCj4gICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdGhlcm1hbF9pbnN0YW5jZSAq
dGk7DQo+IA0KPiA+ICsgICAgICAgICAgICAgICBtdXRleF9sb2NrKCZ0ei0+bG9jayk7DQo+ID4g
KyAgICAgICAgICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkodGksICZ0ei0+dGhlcm1hbF9pbnN0
YW5jZXMsDQo+ID4gdHpfbm9kZSkgew0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGlmICh0aS0+Y2RldiA9PSBjZGV2KSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG11dGV4X3VubG9jaygmdHotPmxvY2spOw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIHVuYmluZDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH0NCj4gICAgICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICAgICAgLyogVGhl
IGNvb2xpbmcgZGV2aWNlIGlzIG5vdCB1c2VkIGJ5IHRoaXMgdGhlcm1hbA0KPiB6b25lLiAqLw0K
PiAgICAgICAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmdHotPmxvY2spOw0KPiAgICAgICAg
ICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiANCj4gdW5iaW5kOg0KPiANCj4gPiAgICAgICAgICAg
ICAgICAgaWYgKHR6LT5vcHMtPnVuYmluZCkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IHR6LT5vcHMtPnVuYmluZCh0eiwgY2Rldik7DQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLyoNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIFRoZSB0aGVybWFsIGlu
c3RhbmNlIGZvciBjdXJyZW50DQo+IHRoZXJtYWwgem9uZSBoYXMgYmVlbg0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICogcmVtb3ZlZCwgc28gdXBkYXRlIHRoZSBjb29saW5nIGRldmlj
ZQ0KPiBpbiBjYXNlIGl0IGhhcyBiZWVuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KiBhY3RpdmF0ZWQgYnkgdGhlIHRoZXJtYWwgem9uZSBkZXZpY2UNCj4gZ29pbmcgYXdheS4NCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgbXV0ZXhfbG9jaygmY2Rldi0+bG9jayk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBfX3RoZXJtYWxfY2Rldl91cGRhdGUoY2Rldik7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBtdXRleF91bmxvY2soJmNkZXYtPmxvY2spOw0KPiANCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICAgICAgICAgICAgICAgICB9DQoNCklNTywgdXBk
YXRpbmcgdGhlIGNvb2xpbmcgZGV2aWNlIGlzIHJlcXVpcmVkLCBubyBtYXR0ZXIgdGhlIGNvb2xp
bmcNCmRldmljZSBpcyBib3VuZCBieSAuYmluZCgpIGNhbGxiYWNrIG9yIGJ5IHN0YXRpYyB0aGVy
bWFsX2JpbmRfcGFyYW1zDQpzdHJ1Y3R1cmUuDQoNCkFjdHVhbGx5LCBJIHRoaW5rIHN0cnVjdCB0
aGVybWFsX2JpbmRfcGFyYW1zIGlzIG9ic29sZXRlZCBhbmQgbm9ib2R5IGlzDQp1c2luZyBpdCBu
b3cuIEkgd2lsbCB3cml0ZSBhIGNsZWFudXAgcGF0Y2ggdG8gcmVtb3ZlIGl0IGFmdGVyIHRoaXMg
b25lLg0KDQp0aGFua3MsDQpydWkNCj4gPiANCj4gPiAgICAgICAgICAgICAgICAgaWYgKCF0enAg
fHwgIXR6cC0+dGJwKQ0K
