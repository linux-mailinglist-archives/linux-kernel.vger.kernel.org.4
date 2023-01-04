Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE8265CCA4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 06:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjADFq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 00:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjADFqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 00:46:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAD512A8A;
        Tue,  3 Jan 2023 21:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672811213; x=1704347213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=67kvpn3P0VEdEQdjZYXcAcWzr/0HMFcHq36JDik8fcg=;
  b=dJjCgzn36f8STU2StRpfSU3GgYvEJYh63SEBQ8bMFOHU9Q3W3PxVoVwy
   byT8BDsWWZ35gHagzL3h2aRAxwUcwQXK5TYN9A3GipTvv/x2TvhzmBe74
   Nhqq5qMr+jZ7sz+yQnFYgLxpTnqh6MnGQaWL8gpL9BCvfip48q/YVv8K6
   gsGzHhSylP5kZLm5NrGR6f3Gau2RUNaSzp6s5lL741Qu1IaPTgS9M4gjh
   6BH8aRm/6ghd4XNZpHxQBSitejiSp8VpIoKkiWTE39ZmoAw4cRvCRRcKB
   y6w7dhlAZ7xVmBfEbCfdRtdfWaf6cnW9Ukldsn2kAOa/ctvcHSVEr/obP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="321909639"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="321909639"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 21:46:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="829067889"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="829067889"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 03 Jan 2023 21:46:52 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 21:46:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 21:46:52 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 21:46:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b24NjgegNlwBrRnctHn2i3I3mCEfanYHMne/QV89FO47QQrYtVwo2XyPeP5WgM/IohDYZGH4wwv4GBMiAqNQhO3GdTw6KNo0KJXqBc5+xCFxhP1EzhzBs1iCQwymhUQ3Rdr+iYs3krwd0/rJvCGAkq8Xf6CZlv+NggqZWiobgYApvhimnSklVcon3VSjvKv2L+ugtXNFF8tkzHYIwbc4xZK0s9JVFecFlrWxyFMCj6wWy+X5QM90Jj8H5f2XmVZVYD56yZkVQpA1cdYUXn2IWGAkSKuDLWxds/Lx0djOovrUigv+V1vi5Y+wnksTrQiCsRUhNA4bHokVyhEhoDC7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67kvpn3P0VEdEQdjZYXcAcWzr/0HMFcHq36JDik8fcg=;
 b=awHlLr8rcmxUpBFLdd30V55h6pYnzGTMkl5ZCpClOAYYebMP8Jm6vz3O115O5q5nGmNtFymtUkYe+XJGuNYwea74g8Z8sLgN27B+AR1L4e3FWLd7F2we74h5/r5vvWDuIKRDUCWYHAXnvKzY4LBp/cGdMqw++QB48Ttq47xJWSXhZchogFsnnZYTxFnsPKv4hGreuaddWNxCIANgME4FgDXwNdNdqg9fDym7lz6fJU8mPXe6lqSW8YCAsn+APdp7q00zA7KTLd2nk6AP9UdK6A/IAIf95JfqLnuuZ+mqxklUc8KHwNQVlKepqOKzncw3Fpab9N0jKVpInA8rVrFIwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BN9PR11MB5497.namprd11.prod.outlook.com (2603:10b6:408:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 05:46:44 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 05:46:43 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [RFC PATCH 1/3] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Thread-Topic: [RFC PATCH 1/3] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Thread-Index: AQHZH7+4ujbzaKffIEOfqYF4WlrIKa6Nu2Iw
Date:   Wed, 4 Jan 2023 05:46:43 +0000
Message-ID: <IA1PR11MB6097AA6AEDC9E37D487C284C9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
 <167278359522.34228.17439739885350817510.stgit@bmoger-ubuntu>
In-Reply-To: <167278359522.34228.17439739885350817510.stgit@bmoger-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|BN9PR11MB5497:EE_
x-ms-office365-filtering-correlation-id: 1eda2f9a-23e0-4402-6918-08daee170f73
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nDGzwgev/FlZlVfSzVk72ec69XzECgCRp0rL0VV2VHFBz73X/YqXp1kqhTZrbgT9WL0m13J04kOphBTWDXryC/Kq+4BKL4swUp8XGA/G6NDlWEMKd+KpA5NBhbSpNf3S8Bcz0mMjz9iPYYbcwb65xcT0MO5E78ZdEbfVmd19plSjVutPCcDCJo7P/X/a5fc4Fk/P67c+j9/ysTwzVHZwBcBRGxjqrM8TBVzn6xWyQs7+xbTRIkjsKBsQWFq2f/hlU7W3hseyg1nNofbIKMqcF5p+NRtiFZHWRPCoRPQsa7ivWo2s/muIK3XZHwhqDmjGM+857XErZSoltnuhBS6igzj3AUNkGZnzSMjhJbLVIr620sTuapJEdZw5EmDty5D8sVzH5CJeZVifw//E5EAMk9FyvRQYaTgzhF1klyUJsUKoyEiyHF3YxddW4OFnftm9XyWpn6fnRC2cp9FTv8HaBKmQlkOSDZEjZ7L8RSmayWQVkiDVkNsNl8dh65WPJxUKM7+a+UCnYCfcxS/B51HtVrMLc4SUij0Bxa1QWxOFt1HmYJhpZfJdb23lH6x3kRFB2ui5fJisDp2rP0padYFayBqa/pDBO2vKlxuOxn97JFaSyw8M2iI1BsXA1wayERO1rNKzNZbnUZHYlTPJw5d/U9rWlcTvfpgIO+3aJtRmM7VWqhBmvuOo+d5cmgaHHHtR6S0VPl/HzrD3EMebeTSfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199015)(26005)(66899015)(71200400001)(6506007)(7696005)(478600001)(186003)(41300700001)(9686003)(86362001)(54906003)(38070700005)(110136005)(6636002)(66556008)(66946007)(66446008)(316002)(66476007)(76116006)(64756008)(8676002)(55016003)(122000001)(38100700002)(82960400001)(2906002)(52536014)(4326008)(83380400001)(8936002)(5660300002)(7416002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXUyZUMyMkJSL2JwY3ljb3I0OHRuNXIrTS9OcE9GaXV6Kzk4N2VQcHZqcVY2?=
 =?utf-8?B?V1Y3alVFOUVaRWEvTWtnckVHelp4bzl5ejRzK1BhNWFJa2hCa3BCWEFVRHRL?=
 =?utf-8?B?ei9aTCtuT0tlL0FrV0VwTHV2RGwyb1N0TDJKMzV5WVR2QnBSWlBNcFd3YTNR?=
 =?utf-8?B?Q1hnazRaa2ZFKytSWGl3RDNoUklsQkRCQzQ3RElBOU1SQ05Hb0UwM0tuMTg2?=
 =?utf-8?B?cFVLMWpUMUY0cnV6NGRTQUVMWWtXcHlVcHdFZGloTDY4Y0NCaEwybnUybE1q?=
 =?utf-8?B?ZnpTY1A4c2ZNMUVPYktkRXdnNXo2dUQ5ZHBoNmRRZktCVVB4clVTczUxSkw5?=
 =?utf-8?B?K2x1ZTNwMVp6V0hnTS9EZzNKK3FKM3NxR09NTUdDbFZaQnhHa1RFaTZLNlBU?=
 =?utf-8?B?dVd0S3dBaGJHWkdlYXJnV0xPd2E4aVlmUHdpNzRuMTNxaDUrSTQxSGcxWDFG?=
 =?utf-8?B?cDJvcSttRzBXdnd0cDJ5a3VTRHFUOFA2M3A2cEdPMkpHelRPQzVIekF5a29X?=
 =?utf-8?B?ZlVqNnZobXY5VkNSQ29GNzlSdG1CTnZlQzdUQ2hGOEFVWFdzb0dJVURNNHYr?=
 =?utf-8?B?NVVKYk8rRllRMThHRWs5L1ZKZjN0ZzNuUFdKc2lIbExSbUU2NjhDTnh5bmtV?=
 =?utf-8?B?d2hEWDR6R0g1Mnd4UmM1ZkFhSUJsOGRGMEtiM1o5SEd5Zi9oVkYwNVpjQnFo?=
 =?utf-8?B?eS9wWVlkTXdGVy91NElEVU0yMkdIRFNXVFBqWitDNUJTOFF3T0xrdU0rK2Ew?=
 =?utf-8?B?ZFh2S2NJbFN1SUp4a1hUUG9IbzhWOGt2V240NWVTOW5GVTBSa09HQjlRWGJI?=
 =?utf-8?B?N0hjbGhPVktrVzFqWGlwdmdPZ3NSZUp6RWtzV00rWmpLOFdiYVg3OUxJWG1P?=
 =?utf-8?B?eWVYc1Z3azlob25mV2FFTktHUjVBbGRiWlJ1dlZ3RHU1RkY5bkdZQlh3OHdI?=
 =?utf-8?B?VUlIeWx6THorVG5VVlArS1prNm1Sem5MMVNLVWtackMraXRxS1B6eWNsLzJR?=
 =?utf-8?B?M3ZpQUlzK3pIcU1lV2JnTytwN2p4bHhuclREVDZZR2N6emh2eHlKaGdRS1Vk?=
 =?utf-8?B?bnhnaFlOeUhOaU15SkN0VlBibHhWd2JDck4ybG82WnpLV0NkSXd2QUNZdFk5?=
 =?utf-8?B?WUpES092V3pEbEJJZjF6QTJFczdxSEZQMXRZcHBYRERBUFljUldIWlU4WURn?=
 =?utf-8?B?UFZZZUliVVlKTFZCcGNBRkQ2aDByQnlqM0J5QXFLMmdEbnZNRkUzeC9qa2xG?=
 =?utf-8?B?UXFrdXorV2ZhMzJjaitrWXJER1FIOC9MUkx6TW1WYUJRS0txUW1FdEV1aWdI?=
 =?utf-8?B?MHU4azhnSFphMm1jdTdaeW41dEJUdmdCZ0h1SEFKZ3FuYkpXTnc0STM4V0k5?=
 =?utf-8?B?VVdLZUVNL0pPTU1MQmNrc1JlMThzOEh5bWM3bkFvWjBrc016UmkzM2tTd2hM?=
 =?utf-8?B?bTRxY1E4YnBzT1lWQzQ5UWNwWEpvSnJXV1JmUjNNQXNwMUdyWExTREp3N09L?=
 =?utf-8?B?TmE2ZnVpeElSMFl5TER0eUl3c1VsQ3BDdUtVbHp5Z0hhdUFRVVcxYnU3N3Az?=
 =?utf-8?B?d1NDdjZGQXhCZXBYQTh2NjBoTFk4UWVCK0dhUzlxSlU0MUR3UHpSQS80L29T?=
 =?utf-8?B?QlhzV3RBWGVZcEtqUFRzNWs3dWdwdUdUTTVCdytFNjcyVkVaeGtzYjlmRk14?=
 =?utf-8?B?dXlXVE1meDBSWFYrT28zQklKVjVNQURZeUxvMHdwd3lOZ3ZyUXB3WjdBaXVi?=
 =?utf-8?B?a2tVMHdqU3F6VjA1Ky9vVTlLbVZ4RFBuSHpqcStKNVJTYUY3UFNZZVdCZG43?=
 =?utf-8?B?N3VZRGJtVTMxcTQrcTlaMkh3ZkExazIyRk42elpYYzM0OTNpQ3hBUm5tcFk2?=
 =?utf-8?B?UFU5TWx2U0ROb0tmQkF3ZWxId0pHakpaSDR0enFab1g5WXhzREhTSU9INmlC?=
 =?utf-8?B?aGovU3pKYWZ0U3phYVBLOWRrMGd3MTJqZ09tajIvbzBQazZWRUd0aktJNHpI?=
 =?utf-8?B?czl5ZWtkUXFUOFBZanhoZmNRbHVybm56WEo0MjQ3UnluazlhY2xJTE5QNmti?=
 =?utf-8?B?SDFrVGszeUd5b3Bqb290MEttcWR2amtDTGFUY3B1Zm16NEFNOWFGWFFqbitk?=
 =?utf-8?Q?h5S5TtwSOKjU8zVNzynbRPmSt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eda2f9a-23e0-4402-6918-08daee170f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 05:46:43.6601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmBEl+SKPuNDvjMA87NsziP95SOqfMAdFzLbciiNVGYpTaML6AWxs2bpAV/a1O9TI6NC013zUGQRR3cvfinopw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5497
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJhYnUsDQoNCj4gUmlnaHQgbm93LCB0aGUgcmVzY3RybCB0YXNrIGFzc2lnbm1lbnQgZm9y
IHRoZSBNT05JVE9SIG9yIENPTlRST0wgZ3JvdXANCj4gbmVlZHMgdG8gYmUgb25lIGF0IGEgdGlt
ZS4gRm9yIGV4YW1wbGU6DQo+ICAgJG1vdW50IC10IHJlc2N0cmwgcmVzY3RybCAvc3lzL2ZzL3Jl
c2N0cmwvDQo+ICAgJG1rZGlyIC9zeXMvZnMvcmVzY3RybC9jbG9zMQ0KPiAgICRlY2hvIDEyMyA+
IC9zeXMvZnMvcmVzY3RybC9jbG9zMS90YXNrcw0KPiAgICRlY2hvIDQ1NiA+IC9zeXMvZnMvcmVz
Y3RybC9jbG9zMS90YXNrcw0KPiAgICRlY2hvIDc4OSA+IC9zeXMvZnMvcmVzY3RybC9jbG9zMS90
YXNrcw0KPiANCj4gVGhpcyBpcyBub3QgdXNlci1mcmllbmRseSB3aGVuIGRlYWxpbmcgd2l0aCBo
dW5kcmVkcyBvZiB0YXNrcy4NCj4gDQo+IEltcHJvdmUgdGhlIHVzZXIgZXhwZXJpZW5jZSBieSBz
dXBwb3J0aW5nIHRoZSBtdWx0aXBsZSB0YXNrIGFzc2lnbm1lbnQgaW4gb25lDQo+IGNvbW1hbmQg
d2l0aCB0YXNrcyBzZXBhcmF0ZWQgYnkgY29tbWFzLiBGb3IgZXhhbXBsZToNCj4gICAkZWNobyAx
MjMsNDU2LDc4OSA+IC9zeXMvZnMvcmVzY3RybC9jbG9zMS90YXNrcw0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KPiAtLS0NCj4gIERvY3VtZW50
YXRpb24veDg2L3Jlc2N0cmwucnN0ICAgICAgICAgIHwgICAxMyArKysrKystLS0tLS0NCj4gIGFy
Y2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jIHwgICAzNSArKysrKysrKysrKysr
KysrKysrKysrKysrKy0tDQo+IC0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9u
cygrKSwgMTMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi94
ODYvcmVzY3RybC5yc3QgYi9Eb2N1bWVudGF0aW9uL3g4Ni9yZXNjdHJsLnJzdA0KPiBpbmRleCA3
MWE1MzEwNjFlNGUuLmYyNmUxNjQxMmJjYiAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi94
ODYvcmVzY3RybC5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi94ODYvcmVzY3RybC5yc3QNCj4g
QEAgLTIwOCwxMiArMjA4LDEzIEBAIEFsbCBncm91cHMgY29udGFpbiB0aGUgZm9sbG93aW5nIGZp
bGVzOg0KPiAgInRhc2tzIjoNCj4gIAlSZWFkaW5nIHRoaXMgZmlsZSBzaG93cyB0aGUgbGlzdCBv
ZiBhbGwgdGFza3MgdGhhdCBiZWxvbmcgdG8NCj4gIAl0aGlzIGdyb3VwLiBXcml0aW5nIGEgdGFz
ayBpZCB0byB0aGUgZmlsZSB3aWxsIGFkZCBhIHRhc2sgdG8gdGhlDQo+IC0JZ3JvdXAuIElmIHRo
ZSBncm91cCBpcyBhIENUUkxfTU9OIGdyb3VwIHRoZSB0YXNrIGlzIHJlbW92ZWQgZnJvbQ0KPiAt
CXdoaWNoZXZlciBwcmV2aW91cyBDVFJMX01PTiBncm91cCBvd25lZCB0aGUgdGFzayBhbmQgYWxz
byBmcm9tDQo+IC0JYW55IE1PTiBncm91cCB0aGF0IG93bmVkIHRoZSB0YXNrLiBJZiB0aGUgZ3Jv
dXAgaXMgYSBNT04gZ3JvdXAsDQo+IC0JdGhlbiB0aGUgdGFzayBtdXN0IGFscmVhZHkgYmVsb25n
IHRvIHRoZSBDVFJMX01PTiBwYXJlbnQgb2YgdGhpcw0KPiAtCWdyb3VwLiBUaGUgdGFzayBpcyBy
ZW1vdmVkIGZyb20gYW55IHByZXZpb3VzIE1PTiBncm91cC4NCj4gLQ0KPiArCWdyb3VwLiBNdWx0
aXBsZSB0YXNrcyBjYW4gYmUgYXNzaWduZWQgYXQgb25jZSB3aXRoIGVhY2ggdGFzaw0KPiArCXNl
cGFyYXRlZCBieSBjb21tYXMuIElmIHRoZSBncm91cCBpcyBhIENUUkxfTU9OIGdyb3VwIHRoZSB0
YXNrDQo+ICsJaXMgcmVtb3ZlZCBmcm9tIHdoaWNoZXZlciBwcmV2aW91cyBDVFJMX01PTiBncm91
cCBvd25lZCB0aGUgdGFzaw0KPiArCWFuZCBhbHNvIGZyb20gYW55IE1PTiBncm91cCB0aGF0IG93
bmVkIHRoZSB0YXNrLiBJZiB0aGUgZ3JvdXAgaXMNCj4gKwlhIE1PTiBncm91cCwgdGhlbiB0aGUg
dGFzayBtdXN0IGFscmVhZHkgYmVsb25nIHRvIHRoZSBDVFJMX01PTg0KPiArCXBhcmVudCBvZiB0
aGlzIGdyb3VwLiBUaGUgdGFzayBpcyByZW1vdmVkIGZyb20gYW55IHByZXZpb3VzIE1PTg0KPiAr
CWdyb3VwLg0KDQpNdWx0aXBsZSB0YXNrcyBtb3ZlbWVudCBtYXkgZmFpbCBpbiB0aGUgbWlkZGxl
LiBIb3cgdG8gaGFuZGxlIHRoZSBmYWlsdXJlDQppbiB0aGUgbWlkZGxlPyBBYm9ydCBvbiBhbGwg
cHJldmlvdXMgc3VjY2VzcyBtb3ZlbWVudHM/DQoNClNlZW1zIHNpbXBsZSB3YXkgaXMgdG8gZXhp
dCBmcm9tIHRoZSBmYWlsZWQgdGFzayBtb3ZlbWVudC4gVGhhdCBtZWFucw0KYWxsIHByZXZpb3Vz
IHN1Y2Nlc3NmdWwgbW92ZW1lbnRzIHdpbGwgbm90IGJlIHJldmVyc2VkIGFuZCBhbGwgdGFza3Mg
d29uJ3QNCmJlIG1vdmVkIHNpbmNlIHRoZSBmYWlsdXJlLg0KDQpUaGVuIHRoaXMgaW5mbyBuZWVk
cyB0byBiZSBleHBsYWluZWQgaW4gdGhlIGRvYy4NCj4gDQo+ICAiY3B1cyI6DQo+ICAJUmVhZGlu
ZyB0aGlzIGZpbGUgc2hvd3MgYSBiaXRtYXNrIG9mIHRoZSBsb2dpY2FsIENQVXMgb3duZWQgYnkg
ZGlmZiAtLWdpdA0KPiBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jDQo+
IGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4gaW5kZXggZTVhNDhm
MDVlNzg3Li4zNDQ2MDc4NTNmNGMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
cmVzY3RybC9yZHRncm91cC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9y
ZHRncm91cC5jDQo+IEBAIC02ODYsMjggKzY4Niw0OSBAQCBzdGF0aWMgc3NpemVfdCByZHRncm91
cF90YXNrc193cml0ZShzdHJ1Y3QNCj4ga2VybmZzX29wZW5fZmlsZSAqb2YsDQo+ICAJCQkJICAg
IGNoYXIgKmJ1Ziwgc2l6ZV90IG5ieXRlcywgbG9mZl90IG9mZikgIHsNCj4gIAlzdHJ1Y3QgcmR0
Z3JvdXAgKnJkdGdycDsNCj4gKwljaGFyICpwaWRfc3RyOw0KPiAgCWludCByZXQgPSAwOw0KPiAg
CXBpZF90IHBpZDsNCj4gDQo+IC0JaWYgKGtzdHJ0b2ludChzdHJzdHJpcChidWYpLCAwLCAmcGlk
KSB8fCBwaWQgPCAwKQ0KPiArCS8qIFZhbGlkIGlucHV0IHJlcXVpcmVzIGEgdHJhaWxpbmcgbmV3
bGluZSAqLw0KPiArCWlmIChuYnl0ZXMgPT0gMCB8fCBidWZbbmJ5dGVzIC0gMV0gIT0gJ1xuJykN
Cj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwlidWZbbmJ5dGVzIC0gMV0gPSAnXDAnOw0K
PiArDQo+ICsJY3B1c19yZWFkX2xvY2soKTsNCj4gIAlyZHRncnAgPSByZHRncm91cF9rbl9sb2Nr
X2xpdmUob2YtPmtuKTsNCj4gIAlpZiAoIXJkdGdycCkgew0KPiAtCQlyZHRncm91cF9rbl91bmxv
Y2sob2YtPmtuKTsNCj4gLQkJcmV0dXJuIC1FTk9FTlQ7DQo+ICsJCXJldCA9IC1FTk9FTlQ7DQo+
ICsJCWdvdG8gZXhpdDsNCj4gKwl9DQo+ICsNCj4gK25leHQ6DQo+ICsJaWYgKCFidWYgfHwgYnVm
WzBdID09ICdcMCcpDQo+ICsJCWdvdG8gZXhpdDsNCj4gKw0KPiArCXBpZF9zdHIgPSBzdHJpbShz
dHJzZXAoJmJ1ZiwgIiwiKSk7DQo+ICsNCj4gKwlpZiAoa3N0cnRvaW50KHBpZF9zdHIsIDAsICZw
aWQpIHx8IHBpZCA8IDApIHsNCj4gKwkJcmV0ID0gLUVJTlZBTDsNCg0KcmR0X2xhc3RfY21kX3B1
dHMoKSB0byByZWNvcmQgdGhlIGVycm9yLg0KDQo+ICsJCWdvdG8gZXhpdDsNCj4gIAl9DQo+ICsN
Cj4gIAlyZHRfbGFzdF9jbWRfY2xlYXIoKTsNCj4gDQo+ICAJaWYgKHJkdGdycC0+bW9kZSA9PSBS
RFRfTU9ERV9QU0VVRE9fTE9DS0VEIHx8DQo+IC0JICAgIHJkdGdycC0+bW9kZSA9PSBSRFRfTU9E
RV9QU0VVRE9fTE9DS1NFVFVQKSB7DQo+IC0JCXJldCA9IC1FSU5WQUw7DQo+ICsJCQlyZHRncnAt
Pm1vZGUgPT0gUkRUX01PREVfUFNFVURPX0xPQ0tTRVRVUCkgew0KPiAgCQlyZHRfbGFzdF9jbWRf
cHV0cygiUHNldWRvLWxvY2tpbmcgaW4gcHJvZ3Jlc3NcbiIpOw0KPiAtCQlnb3RvIHVubG9jazsN
Cj4gKwkJcmV0ID0gLUVJTlZBTDsNCj4gKwkJZ290byBleGl0Ow0KPiAgCX0NCj4gDQo+ICAJcmV0
ID0gcmR0Z3JvdXBfbW92ZV90YXNrKHBpZCwgcmR0Z3JwLCBvZik7DQoNCkRvIHlvdSB3YW50IHRv
IGV4aXQgaWYgdGhlcmUgaXMgZXJyb3IgaW4gcmR0Z3JvdXBfbW92ZV90YXNrKCk/DQpPdGhlcndp
c2UsIHRoZSBmYWlsdXJlIHdvbid0IGJlIGNhcHR1cmVkIGlmIGxhdGVyIHRha2UgbW92ZW1lbnQg
c3VjY2VlZHMuDQoNCj4gDQo+IC11bmxvY2s6DQo+ICsJZ290byBuZXh0Ow0KPiArDQo+ICtleGl0
Og0KPiArCWNwdXNfcmVhZF91bmxvY2soKTsNCj4gIAlyZHRncm91cF9rbl91bmxvY2sob2YtPmtu
KTsNCj4gDQo+ICAJcmV0dXJuIHJldCA/OiBuYnl0ZXM7DQo+IA0KDQpUaGFua3MuDQoNCi1GZW5n
aHVhDQo=
