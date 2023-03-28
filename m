Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055216CB444
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjC1Cqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1Cqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:46:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110019BA;
        Mon, 27 Mar 2023 19:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679971610; x=1711507610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9eJAk4LQPNpGFLnyPyQp4L6c+v0UPcowT2wrJwA1XLo=;
  b=DeXzUA9ANxudNIGongapxSvLvvlrVXXLJ/uChG8p2BHYkIT96Tx3/RH6
   VVs6m+hGMGuNFJGgEtKN6cWk/BKIbk168zLXl+sUcDWbqh6i1Bef9Lb4p
   vvweljjbF0XJV+MnkJqR80IfitZDhx22X+wCR1Z0u54rchuCHMPuxxTZg
   V7yMTKsYL0VIdjje3+96qvjfq5Go6RWpjxR7T4g9WDbwLO+0wBcfog87/
   1ChwCOQXZzdP2R93AYzlw8E7Pzbw5lWAq49/6HZbQHgvAb9RJ5gNJGI5k
   NCFDnHyzYDHoCDSzeY8MNptZcajKPokKbbjFGH1VezVeRWoD9WbhGRcNG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="340477780"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="340477780"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 19:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827293054"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="827293054"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2023 19:46:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:46:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 19:46:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 19:46:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVP7y67jfomu7VAYTbt+67OWPNGOhgq4cAG4gA4CZPa0mpDDSWb/sLFi+PPCBOZwetSNDKlkAp0yvTR/VaE1T/mfN1ols2LPwAeF5u4K5ujmAlc1I+cbUspvh4kTZysS9pTLw5iFj2gK0eQLcctx3TpOXpb2tSouzTupEs/UKvecPYth+Cb+GJchcNugFcjkbB5KIx/fOvV6RL2QVfXJfkjNv7k8x7s6scQFa+gYJG+zK7/42h4EmKHoxP0KWfKkHH77hKLtxZ2sTVB1Fzj6tt6wh8cSGXlooZHQM32LPJ6syS1/4nM31T/9ZpTRcXAQJVA2LcXJUFfLnzf65auu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eJAk4LQPNpGFLnyPyQp4L6c+v0UPcowT2wrJwA1XLo=;
 b=OTk00KbuwgozsfCPc8daWLpMXLnvUNHX3lkZgACataEcUWmiKqgHhyH/PxQ+O7ZbIdiEh16eeW3Dj5ELcB0Hgq9+/ROfnI4xMlqKuN3BUWjeakPDoIyi8nDfYN1kR+jRhAZ+iZew8tSHeeLhqUOb3sxlJtMoIhBxXICQbgLtuvC+KQM9joG4Mh7ZVknXF5fkZh+HjvjGKkQGza7zv2MyKTQ8adpqsi++glkC1hUYp87meDbue1kmMfjf3E2iaHGP8mUeNP8c9dO7KFyJLnzTMzKpzpTxuLFk8yK9gWLosXtKvkiDlSv2/Z6K68GGrZORKpR/GqP+Eu2N7Rob+0+/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 02:46:42 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Tue, 28 Mar 2023
 02:46:42 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] thermal/core: Reset cooling state during cooling
 device unregistration
Thread-Topic: [PATCH 2/5] thermal/core: Reset cooling state during cooling
 device unregistration
Thread-Index: AQHZXh9xqEpW/nDCyUCGOxFmhxFRx68J6moAgATQMgCAAAZlgIAAwcsA
Date:   Tue, 28 Mar 2023 02:46:41 +0000
Message-ID: <ba48eb3b3f4b82d33faa9233dc151f65d6380ed7.camel@intel.com>
References: <20230324070807.6342-1-rui.zhang@intel.com>
         <20230324070807.6342-2-rui.zhang@intel.com>
         <CAJZ5v0gze1wBEMcuEu4Aa9343rh-3=Bu+pdSYuY3stMd8QGf0A@mail.gmail.com>
         <528f7e58507df4b6137856828e371bb8913b8b59.camel@intel.com>
         <CAJZ5v0gL_7VPdcgkmuTz=afYSbGsWZi5wW9vUvyAgverjxsNdw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gL_7VPdcgkmuTz=afYSbGsWZi5wW9vUvyAgverjxsNdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|SA0PR11MB4735:EE_
x-ms-office365-filtering-correlation-id: b0a8125b-0855-4502-1f6d-08db2f36a971
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hOSzX0cm0oOj2eJZNyRqAOp4Ezjhfsqr9qd6Muo0jbtMTu7/yG9VE8JhjSWiJXi0Oxh5DW/+lSpTzuodvhY2uTvkzKIvrnQg//T58GY3PY+mj+TAW39wWxTiNFxUpq3ZZBD6V4y6qXhDYyZMP/lnyJS8yvULZcyAGZG8ldFtox96f2ozXjiKplZ61Vi+GHPi9zMklNzw2cIH/KLkLI4fiPW9Ti1kfKgBG8noyv8rmCruCxvIMdrw7bCLyjio78jE1dS5KPsqKRJpAxCJn0BFEOK0xiTItFe4tLfd8xA8JG90KmPns4cBsrOR+71FW88YE4BgKLEmTrnyOP+8eZ2N28928UNr4gBHw5SZhDzPnPOs7KrWftokY3Ls1wu7KDwDzqf2uE36MGUvGmmgYSrANcH1aHp69FRY7ioLPOBHsjmUbyUjqgBrAcPI+hrvfjFQI6j9KboHg1UfBi1SUPR41zOvMIe4p1DTeCvYBgeWrjkFoyGD7tRHcLySo9i2LuBpxrNxRMcmYzthPKdP7Sm54uHvn7z9jEAIbJ7td0epXEF7wRFJTwrL5TJA2UYnxzMuA788UEo0JtWow9eSzTaS77Kp+BnJeJ+/eqSyE44YjCwPuGpbA5EIutZiT94KydP5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(316002)(54906003)(478600001)(8936002)(122000001)(36756003)(38070700005)(82960400001)(86362001)(5660300002)(66446008)(76116006)(2906002)(64756008)(4326008)(38100700002)(66476007)(6916009)(8676002)(91956017)(66556008)(66946007)(41300700001)(186003)(6506007)(26005)(53546011)(6512007)(2616005)(83380400001)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkxhLzVCZlorcXJGRE4vQUNmQzJVUkZtaHdYeC9XOWtueTIwZUtQdXNZR2hU?=
 =?utf-8?B?WWwxN1R0VUliVHJ4VloremtCYmsrVVg2RmFzQ250T0lmMVd5b0Rya1RzeVh3?=
 =?utf-8?B?c25VQ1gvMks2QzJPL2hHYkFyK2RCZ25aWGRsS1prR0JDc2xaa0xlKzhLUmRs?=
 =?utf-8?B?R3lnRnplZlNtQi9sT21QOEkzd0IySk8xM1pCeEZCdjlEbDJ2ZDlrbHZpd3l6?=
 =?utf-8?B?VVBnRnBYS2lRUXZTREtiNHkyU2k2bUdrVDcrWjhiK0FacUtyblRtRmNUOW9t?=
 =?utf-8?B?K1NzbzRSaFlPY3UyODc4NHZYK1YwR2FOSzgrU1hwZHdEZXBER1BRT25xYVcz?=
 =?utf-8?B?TiswRm9wT09xMzZHU2RmamoyU3dPMlhoN1FLSzBjVW1Ic2ZaUUFvOFhOUEdH?=
 =?utf-8?B?S05KeWx5RXpEUlFrRzhBUHUwbjA5VkdiSXZHSXN1UEJIa3hMTW5JNWYvSnJs?=
 =?utf-8?B?MjNUd2R4L0JhN3NLK2hEUmRzRWVtWWh5VWhyRGQ2RE9jUkZITnVlTmNFc01s?=
 =?utf-8?B?QW02MmRpeW4wakNKVGl5bmFNVVQ3VCtub3hDWnV2TmNDN2xPYnNjY0pVZGxS?=
 =?utf-8?B?ZGRyaGFRNFdrK2N3MXlHU3RFckJkUDZ0UCt1Nk5HcFpabkQvMmdQYURFL0Nj?=
 =?utf-8?B?Z0ExVEJHT28vUk5OVDZSenRyNEJwVnJSTUtzbnZvYjltME1jeEc4cTNlbmZO?=
 =?utf-8?B?dm8wZWRmeEFUK1gwZkhJTjREZVUvOVRKRysxcUs5STJhamwyN25xaXptQkM2?=
 =?utf-8?B?UEl6NGRQc0hvQnk5alJkNkFvWUlaallTbEczZ0ZWb3RVNmhiUzZYSzZ4VFA5?=
 =?utf-8?B?K0t1TVJDV1VUYzAzL212UUVHcDdmakcwN0FmbkNkSXBtVXQ1dTgxaWxZSEhK?=
 =?utf-8?B?eStvdHQzOHQzaE51RkJ3cXJTOFpQc1Bma1VDYnBrSE0reFpqRENZVkpqYzd3?=
 =?utf-8?B?Ny9YMHFEeUw1MWVaV2o1bkFNekxhM0dNRzhnR3dkNFdWbDdhQ09yTFYxYVhL?=
 =?utf-8?B?c0pLNXBVR25TLzloVEEyVjh6THJKaWxJdktDVmh4UXlkdkVHKzFoUUpCQmd2?=
 =?utf-8?B?LzJXckdjTWZ6V1huZ2dCQUFjeVNMUEF4N3ljNWtmNmYwM1NrdVJGMjU3N29U?=
 =?utf-8?B?UEtSekIzUFNVR29FRXk5cndBN055Q3ltbmZCY05XZXBjRkhRN3RTZGVSSWk5?=
 =?utf-8?B?ZW5URUpVMUdZZ1dIWmg3a0FQUG9zcGplYXFwNVFVVDB2UWpMaDVxaVp3UFBG?=
 =?utf-8?B?Y09yazB6RGFNbVRGcG43eE9uejNJdWYrcXJLaTRDQ1B1UlJIMnBtYnNwUDZm?=
 =?utf-8?B?QWtvYysyQVh0MjJpSmRPaEZJZGEyY1M2c1hNbFZ0azAzbVFXN0NQd1Vwc2Zo?=
 =?utf-8?B?L2cya2syWElKQUY5cjIweWNvY216UnRUbUNzdHo2MzZTMDU0K0g0ck9teVBL?=
 =?utf-8?B?eFlaWTVTWVBxeUxQVkRuNDBNKzFjQnpoOU5EbVNyRlhBSHZwbTJvMFpSVysz?=
 =?utf-8?B?ODRTMTQ5d0Z5SEtpYXkxU2ZJeFpWVDF6QlhUZDZTdWpSdktmWTdqUXlPMnBo?=
 =?utf-8?B?QmcxRk5BK3FwSEk1YlNDNEM1and2V2VQQXgrRHdTWFFScGtKWE5ML2dOZlJI?=
 =?utf-8?B?d3pnS3BEN3lqVVdQcUx6eEZ5Z09Qekl0emJ5a1d6SjI5Vlg0dlhCVllHRHUv?=
 =?utf-8?B?RUFZYURBa0VLa09wRGJtZE9ZYnBEak5qdVJXdzE0UDE0bTdiNFV4OGFGbExD?=
 =?utf-8?B?cEhIZXNPdjQwM0MxTTVkMk9nUHMzZ09jS3I0Q3o5TjR6ckNBclRyRExGUlRT?=
 =?utf-8?B?M0FNbFE4QXg2TWVncDlLMi9TSHdiV05ReW5FenFLOVppS1QzT0MxcVp3L1BM?=
 =?utf-8?B?NlR1cjFBRmhUZ3RlZ2Erc3VWanZnaVY4TUd3ankxNk53NE55Y0F3MjlxNEY4?=
 =?utf-8?B?VGhEdUNGcUVHUGhqTXg0Vk5aV0FXbzJHRXgvRXhPUnZRVlNrS29PVDZWVVN2?=
 =?utf-8?B?d0hWSURhb0lDa1dTYk03KzFpdDcydDk1K2FGUXVIdzRJQmFuMXFWTWRqTDQy?=
 =?utf-8?B?bGhDUXV1Qytaei9FOUhLNGNNNlRvek9SR3RhTGFVdXNKeThhaUhlaUFGdkc0?=
 =?utf-8?Q?YnS7AAwG5UJ4e6ElgPI7D3LZp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B6040E091DB734897C58EAB07CFA381@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a8125b-0855-4502-1f6d-08db2f36a971
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 02:46:42.0090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BESlY9OEvGPAhPf4gEuIxXiJObXCAikGFGY34aSIWY7Va2aoQde5J5eqU9xZI3E1+9dMYp8aopmkyvgCVSfeug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTI3IGF0IDE3OjEzICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gTW9uLCBNYXIgMjcsIDIwMjMgYXQgNDo1MOKAr1BNIFpoYW5nLCBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMy0wMy0yNCBhdCAxNDox
OSArMDEwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiBPbiBGcmksIE1hciAyNCwg
MjAyMyBhdCA4OjA44oCvQU0gWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiA+ID4g
d3JvdGU6DQo+ID4gPiA+IFdoZW4gdW5yZWdpc3RlcmluZyBhIGNvb2xpbmcgZGV2aWNlLCBpdCBp
cyBwb3NzaWJsZSB0aGF0IHRoZQ0KPiA+ID4gPiBjb29saW5nDQo+ID4gPiA+IGRldmljZSBoYXMg
YmVlbiBhY3RpdmF0ZWQuIEFuZCBvbmNlIHRoZSBjb29saW5nIGRldmljZSBpcw0KPiA+ID4gPiB1
bnJlZ2lzdGVyZWQsDQo+ID4gPiA+IG5vIG9uZSB3aWxsIGRlYWN0aXZhdGUgaXQgYW55bW9yZS4N
Cj4gPiA+ID4gDQo+ID4gPiA+IFJlc2V0IGNvb2xpbmcgc3RhdGUgZHVyaW5nIGNvb2xpbmcgZGV2
aWNlIHVucmVnaXN0cmF0aW9uLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWmhh
bmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gSW4gdGhl
b3J5LCB0aGlzIHByb2JsZW0gdGhhdCB0aGlzIHBhdGNoIGZpeGVzIGNhbiBiZSB0cmlnZ2VyZWQN
Cj4gPiA+ID4gb24gYQ0KPiA+ID4gPiBwbGF0Zm9ybSB3aXRoIEFDUEkgQWN0aXZlIGNvb2xpbmcs
IGJ5DQo+ID4gPiA+IDEuIG92ZXJoZWF0IHRoZSBzeXN0ZW0gdG8gdHJpZ2dlciBBQ1BJIGFjdGl2
ZSBjb29saW5nDQo+ID4gPiA+IDIuIHVubG9hZCBBQ1BJIGZhbiBkcml2ZXINCj4gPiA+ID4gMy4g
Y2hlY2sgaWYgdGhlIGZhbiBpcyBzdGlsbCBzcGlubmluZw0KPiA+ID4gPiBCdXQgSSBkb24ndCBo
YXZlIHN1Y2ggYSBzeXN0ZW0gc28gSSBkaWRuJ3QgdHJpZ2dlciB0aGVuIHByb2JsZW0NCj4gPiA+
ID4gYW5kDQo+ID4gPiA+IEkNCj4gPiA+ID4gb25seSBkaWQgYnVpbGQgJiBib290IHRlc3QuDQo+
ID4gPiANCj4gPiA+IFNvIEknbSBub3Qgc3VyZSBpZiB0aGlzIGNoYW5nZSBpcyBhY3R1YWxseSBz
YWZlLg0KPiA+ID4gDQo+ID4gPiBJbiB0aGUgZXhhbXBsZSBhYm92ZSwgdGhlIHN5c3RlbSB3aWxs
IHN0aWxsIG5lZWQgdGhlIGZhbiB0byBzcGluDQo+ID4gPiBhZnRlcg0KPiA+ID4gdGhlIEFDUEkg
ZmFuIGRyaXZlciBpcyB1bmxvYWRlZCBpbiBvcmRlciB0byBjb29sIGRvd24sIHdvbid0IGl0Pw0K
PiA+IA0KPiA+IFRoZW4gd2UgY2FuIGFyZ3VlIHRoYXQgdGhlIEFDUEkgZmFuIGRyaXZlciBzaG91
bGQgbm90IGJlIHVubG9hZGVkDQo+ID4gaW4NCj4gPiB0aGlzIGNhc2UuDQo+IA0KPiBJIGRvbid0
IHRoaW5rIHRoYXQgd2hldGhlciBvciBub3QgdGhlIGRyaXZlciBpcyBleHBlY3RlZCB0byBiZQ0K
PiB1bmxvYWRlZCBhdCBhIGdpdmVuIHRpbWUgaGFzIGFueSBiZWFyaW5nIG9uIGhvdyBpdCBzaG91
bGQgYmVoYXZlIHdoZW4NCj4gYWN0dWFsbHkgdW5sb2FkZWQuDQo+IA0KPiBMZWF2aW5nIHRoZSBj
b29saW5nIGRldmljZSBpbiBpdHMgY3VycmVudCBzdGF0ZSBpcyAic2FmZSIgZnJvbSB0aGUNCj4g
dGhlcm1hbCBjb250cm9sIHBlcnNwZWN0aXZlLCBidXQgaXQgbWF5IGFmZmVjdCB0aGUgZ2VuZXJh
bCB1c2VyDQo+IGV4cGVyaWVuY2UgKHdoaWNoIG1heSBpbmNsdWRlIHBlcmZvcm1hbmNlIHRvbykg
Z29pbmcgZm9yd2FyZCwgc28NCj4gdGhlcmUNCj4gaXMgYSB0cmFkZW9mZi4NCg0KUmlnaHQuDQpJ
ZiB3ZSBkb24ndCBoYXZlIGEgdGhpcmQgY2hvaWNlLCB0aGVuIHRoZSBxdWVzdGlvbiBpcyBzaW1w
bGUuDQoidGhlcm1hbCBzYWZldHkiIHZzLiAidXNlciBleHBlcmllbmNlIj8NCg0KSSdkIHZvdGUg
Zm9yICJ0aGVybWFsIHNhZmV0eSIgYW5kIGRyb3AgdGhpcyBwYXRjaCBzZXJpZXMuDQo+IA0KPiBX
aGF0IGRvIHRoZSBvdGhlciBjb29saW5nIGRldmljZSBkcml2ZXJzIGRvIGluIGdlbmVyYWwgd2hl
biB0aGV5IGdldA0KPiByZW1vdmVkPw0KDQpObyBjb29saW5nIGRldmljZSBkcml2ZXIgaGFzIGV4
dHJhIGhhbmRsaW5nIGFmdGVyIGNkZXYgdW5yZWdpc3RyYXRpb24uDQoNCnRoYW5rcywNCnJ1aQ0K
