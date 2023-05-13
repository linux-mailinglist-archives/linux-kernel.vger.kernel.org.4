Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE8C7015E9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbjEMJwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjEMJwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:52:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FB7CE;
        Sat, 13 May 2023 02:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683971570; x=1715507570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6ot1p3p67Fh24LOjMzZtSk3E4eNMp32f2IlqECeRX6k=;
  b=M22Qvckc0irRnwjfzwdutSP83k5VO0HXHlxLptyzEOImcDJIRC7R4eDP
   WxR7b/fsTy8dMJSExT88k0eskcctXhaWethwTEx6Q7xyL3vVZnxchmke9
   AL3y16dTdNS+wjtGilSzSAvC1tEXvasifqW+XLZaa+rLjsxuG+ohP9Z1i
   e2w/+1lVqMT7cVveoWQfw7seJaDLBStY9utcFLeDzC5taUPIcIrlmXQdU
   iOjsyQ59M5LI4EYsA/ezW1i3caJG3bbED9LpFHoRV84sakfgD5I2LdvF9
   vsHycnPB67XSR+8GHIlEazspvpyC5vcu+GGY9ZA22jb/NtQrpHGtyO9cn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="340277786"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="340277786"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 02:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="677932167"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="677932167"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2023 02:52:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 13 May 2023 02:52:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 13 May 2023 02:52:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 13 May 2023 02:52:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHwL5GdrERze84lypY4zu1IDDDFoNMc4XmVWVSIa8ViPve1S6C1imDX8RAlvl5ULF/7+F+nUEHz8aAV/+53qX9LgJR21UFixBllrHH6VccDqSH3ZfbhACDwgig/tfXTVeCUqbqejfPghz0IZ9fH3+6Ms6ICwazUPZ7TSEvVA2pqHnn2sV/lsOehz8WN0/G8BD5bS9ugtFfJ2jQActJCfebj4ocV76BtsQP6KEbgyjKTspHUP+FuUrihaYFN2DFT+zEcT+n9b9KoQjmK3jrmYFEr/l09DBvPenUYzSsNs9pgkjMxi3gJg61tbN7LnIPVD46S+XFi+P/LpDJcy0kLyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ot1p3p67Fh24LOjMzZtSk3E4eNMp32f2IlqECeRX6k=;
 b=GXl/YLcE9Nml1fPDn8bzLJIZgu1qxCGYvLzVA2obh6+4zM5wkVTyYhJlgKdtnPJmSMHflSabr3t2BQ467seylc9D+M6TrBJLqEz9caVcIprWMwJlLwtG5dEMtuzBT/gp37O+82RG9JdYe+NT7k/WmUa/bBkHtGThIWEkKCLSSwhIv8ay1qXYvb+zI9u23hJL93+IIoPkqnewVZefsH/CwjDdvRtTHSbpUA99lOmB1mwGG/fL1d5+vK0OV2rlDQs2G9GqvwHl+sgUQy+p/nGcEY5hzPVWiCUNYEi5QPer1k8mZFmdfnWpSLVqtDpZC/K/QoH6P5DhPzmJq0qphAUM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by CH3PR11MB8139.namprd11.prod.outlook.com (2603:10b6:610:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.27; Sat, 13 May
 2023 09:52:47 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982%2]) with mapi id 15.20.6387.023; Sat, 13 May 2023
 09:52:47 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after
 kfree_scale_cleanup()
Thread-Topic: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after
 kfree_scale_cleanup()
Thread-Index: AQHZg2KlduYd6z/enEeC6gWcmPig2q9Uip+AgAATm4CAAHvjAIAA2thggAAU/ICAANAYgIAA/3nA
Date:   Sat, 13 May 2023 09:52:46 +0000
Message-ID: <IA1PR11MB6171866D6AEE79DD3413157E897A9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <IA1PR11MB6171B1AD7716B95B0B2C683889759@IA1PR11MB6171.namprd11.prod.outlook.com>
 <30F06C03-6950-4E2B-B3CE-3939B3CDD295@joelfernandes.org>
 <4d508096-300c-4d16-9c39-18598d00b500@paulmck-laptop>
In-Reply-To: <4d508096-300c-4d16-9c39-18598d00b500@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|CH3PR11MB8139:EE_
x-ms-office365-filtering-correlation-id: 545c93a6-827c-426d-0249-08db5397ce16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KCBKFeg42mVgnjxBEq1eKK3P1Fuu4Iho/aIBAt+KFlDN3Oyda50/uHwMxnj0XagMYJ8Xek2gbH42PjZxQsAfr/UZ70u6SsNKpCH3fZWtxDZfUABU/DdZlYzXhZkq0cln0lsbq2GCi5GpD662LfM5pIrRnVyr3H7qMlFNror+1RiSaI59OJxUvJT9fyOQPe+pFgrMoOjHzRUSLI2/+ipiD1N1+GhL3WoCpLQ+UqeYs/HVei8+4d0DYsq+FdgJB6RxwvxvMIyMA4booeI9ZbjW6hxRKVXgm5sRuSZcCvF8lSHq4Z7GWAg/R/ybEEQsIf4cPKEa7dVsHL2DPGWMPKjskU7QU+luzi4BSO/1Qg9ZrkPEkXH90MWx35kOpHZE1thWjlvS3+antqum/+5rqIBigCjX8V09IeC7Bfu9DgrJ3WNT7K9KrjFJ1IFdRPzINiRrfWF6sv8fXELWCp7ZkxjGKQHmcXsY+Caqcjnch6mWrzUltyOPAW9Q3TCXgCaARUCZEbnkytJA33MRCPZOD5H8iowecnv9fUb1++WTnVt4yIs1bvGWfkP00kKH75ZO82MSvh56YuPHKoclMmQ8qM8/3bR6juE4xx30Jn0LZj/yyra5sJUJydZcb3YsxC1i3wae
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(55016003)(2906002)(83380400001)(66476007)(76116006)(66946007)(66446008)(7696005)(66556008)(64756008)(110136005)(478600001)(54906003)(8936002)(8676002)(9686003)(52536014)(6506007)(186003)(26005)(5660300002)(316002)(41300700001)(4326008)(71200400001)(38100700002)(38070700005)(82960400001)(122000001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVN4alQ3dFhzbjU0M1YyellycWk3UFdGMHpsUktwem1PNlpzS1JPT3dpMlNa?=
 =?utf-8?B?Zm93N3h6SnB3a3FTZDhTNS81cnZ4ek9IVnNQR0xtMXB2OUhDVXY0QS8ySEFZ?=
 =?utf-8?B?ZjlPYVFmOG9uNldhK3FRWWdTSnBCektKcHdxV2szOGRIdFJXWDVmOTRkMlNQ?=
 =?utf-8?B?Z3M4aGZkOW1GbU5DWU93ZDhzdzRFY1dha0hXZXFaS1ZJWFVuVUsrTjh0WTVK?=
 =?utf-8?B?ZG9PR2tiK2tGUUVQTVdDcHJtWW9Kd2VRT25zQnpxSm5JdGRiYzhZV3pIVUNS?=
 =?utf-8?B?aDVNOVlmcllqbnMzZnQrdzlBWWZDUHhvbmdYS1dxM3psMzA0N0k4MXF5NXdx?=
 =?utf-8?B?a2c3Vm1CSlY5ZW9uaU02MTIrelpDUldoUlVFR1VVakU4RGJYZU9FYWk4NFln?=
 =?utf-8?B?MWM5Q1E3NENualN6cGt6TUY3emN3cGdSV3ZXZ09pWG9ZSlBhVUYyUXV2V3NI?=
 =?utf-8?B?MHpmdU5qZDNLbU55aExsYmtKUzZXcjFBZlBVTjFNTW1nS05QQklZL0FhNGg2?=
 =?utf-8?B?WjZOQzlETjdBbjF0Vm5GZXhXdk1xNWdNc0F6OUFLV1ZaWEkwOFV2K2dSbDR4?=
 =?utf-8?B?RkNMcmw5L1orZ2YyZVloa3lYc1lTTjRoT1VZdUJySEE1d0E5NjZ1TC9jeXdT?=
 =?utf-8?B?UkRqUk1pdkZIaXFXc0FrM0EzVXB3dldjeW5zMkRrSjB4TVJWN21WQzM5MmRX?=
 =?utf-8?B?U2VyT0wwOXlGdExoelNMWC9xQWR1emY2VW1SSzM2cDJBOGNLYXpwMTJlTVJq?=
 =?utf-8?B?c1lQR1AvUU1RSGhiZEFkQWN3aFpWT3oyalArWmNqK0Zqd05XY3BSVkdwZEZI?=
 =?utf-8?B?UzBSd1lPWWhya09XaGxwWFlSY01SU2NyNFJmMGliOHpnblpLUGhLYm8rVTdR?=
 =?utf-8?B?Q05zQWdDMHE3cCtGK2ZuUjJjMVRUQkNxeDlhNFFraEluVG5EbStPMDRWb0Rr?=
 =?utf-8?B?QnhOOFdIVzErOUh3aHlPZlZrM1dKRVBHT1BiUFVObGVxeGJsaFNTaFc1c2Nl?=
 =?utf-8?B?NEN0SXg5VTFSRFg1U3A3Z1JGdUVjUDRISkM4UnVTZmVuRWtLQzR5NUtiMmI2?=
 =?utf-8?B?QVJYckJZRDBpcTZFbE44VEQ5cDJqcGNCZnA5Q1lqNXNxVGRjam13aCtPakxr?=
 =?utf-8?B?MWx0VUFxeTVLQmo5R0pzcVBXTThGU0VJdmpCWnV0dkZiL0VPeUhtSkJQeWYr?=
 =?utf-8?B?bk95bVkyemQ2dTY5N2NhQi9qd3NPN2pYUGd3d0gzVS9BaEVGSGxIaXBJQWZh?=
 =?utf-8?B?d2VTSzNHbnJvdE1wYTA3OVZlMzZXTVZzS3ZGamhSNkViVTlYektZelE3OUJv?=
 =?utf-8?B?Sm1PZndqU29QTmpkQ3hrbGdzNXhneDBxSktzZ29UVjcyQWQvT1V2aWVSbGxo?=
 =?utf-8?B?OWwvSmN0bjFaYUZlYWxXd1N1UDdIaHNHQkNoMldQTUhISnJVOUYrWFQ3K3BC?=
 =?utf-8?B?ZGt0N1R1c1dYSkZoWVBrLzN6WXlPSEZ4ZVpwSnArRkVJeHlGelVMODdOWHFp?=
 =?utf-8?B?WmhkTk9pVnZSMnpKQVFWSTV2RFNtSHMzZlRMTUdwYWlXN1lQTFZ4bUJPV3ll?=
 =?utf-8?B?em9wZVBvalJ0NnVZV0lVYnF3UE5vcWdKQ28zb1haOVptYnhhOW8vcEM5em9l?=
 =?utf-8?B?cFVGclhIekNhR3hrbHpySytpZEJFd3oxUU9RR0FkN2haYVpFcFFLVUQ3QnpR?=
 =?utf-8?B?U0ZGV2cwVGFkSDZUQzF4akUwNG5Ea01JMDZSbXlCV3hkdi8yKzlsU21hSTE5?=
 =?utf-8?B?WVVtSmYxaXRsTmgwUTlKUlFzQ3puS1NXby9nRWpsYkQycFJHNE9BenlYZUNq?=
 =?utf-8?B?dmlEcW84UjdoRTV2T0NxYkJQeWkxbks1TnVuY05sT2pzOWVrakNJVVJLWDV3?=
 =?utf-8?B?UVR1dVZtR0FGN0Fya3FUdGF0THVidHhtK3J3K1ZsMDFXeVAzb2xuNnNONUlU?=
 =?utf-8?B?bVA1QVJDMUprOUt5Ry9mZU9FMjRhU0lJNVh0bjRralVoY3VFb0poU0gyZjJN?=
 =?utf-8?B?SjFXRDBZQWhjT0VEK1p6OWNLSG56SUxEd1ZjLzRPUjJlNWtpd3FrekRDVkps?=
 =?utf-8?B?S2xUczNSaGhxTmZua1dOb1YzbmtoRjFuK0pvSXN2OXp5S0hHNjNEZ1BJTTFO?=
 =?utf-8?Q?xJvVUjGZ5LZXb0MZZ+h4sgV/z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545c93a6-827c-426d-0249-08db5397ce16
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2023 09:52:46.5192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czmAqUP+QqOEbICY3S8ipC02DQjogAxmVJHbJmOJzjPnAd0z1wJItPe7ehi61qPD/kCx8NF5mEGTMWbagsfEWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8139
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+IC4uLg0KPiA+
ID4+Pj4gSSB3aXNoIGRpZmYgd2FzIGJldHRlciBhdCBzaG93aW5nIHdoYXQgcmVhbGx5IGNoYW5n
ZWQuIFRoZSBtZWxkDQo+ID4gPj4+PiB0b29sIGNhbiBoZWxwIGJ1dCBpdHMgZ3VpLi4uDQo+ID4g
Pj4+Pg0KPiA+ID4+Pj4gU2hvdWxkIEkgcnVuIG1lbGQgbGF0ZXIgKEknbSBvdXQgYXQgYSBjb25m
ZXJlbmNlIHNvIG5vIGFjY2VzcyB0bw0KPiA+ID4+Pj4gbWVsZC1jYXBhYmxlDQo+ID4gPj4+PiBt
YWNoaW5lcykgb3IgYXJlIHdlIHN1ZmZpY2llbnRseSBjb25maWRlbnQgdGhhdCB0aGUgbGluZXMg
d2VyZQ0KPiA+ID4+Pj4gbW92ZWQgYXMtaXMgPyA6KQ0KPiA+ID4+Pj4NCj4gPiA+Pj4NCj4gPiA+
Pj4gVGhhbmsgeW91LCBKb2VsIGZvciB0aGlzIGNvbmNlcm4uIEdvb2QgdG8ga25vdyB0aGUgbWVs
ZCBkaWZmIEdVSSB0b29sLg0KPiA+ID4+PiBJIGp1c3QgcnVuIHRoZSBjb21tYW5kIGJlbG93IGFu
ZCBjb25maXJtZWQgdGhhdCB0aGUgbGluZXMgd2VyZQ0KPiA+ID4+PiBtb3ZlZA0KPiA+ID4+PiBh
cy1pczogcmN1X3NjYWxlX3tjbGVhbnVwLHNodXRkb3dufSgpIGZvbGxvd3Mga2ZyZWVfc2NhbGVf
Y2xlYW51cCgpLg0KPiA+ID4+PiBZb3UgbWF5IGRvdWJsZSBjaGVjayBpdCA7LSkuDQo+ID4gPj4+
DQo+ID4gPj4+ICAgICAgbWVsZCAtLWRpZmYgLi9yY3VzY2FsZS5jLmJlZm9yZSAuL3JjdXNjYWxl
LmMuYWZ0ZXINCj4gPiA+Pg0KPiA+ID4+IE5pY2UsIHRoYW5rIHlvdSBib3RoIQ0KPiA+ID4+DQo+
ID4gPj4gQW5vdGhlciBvcHRpb24gaXMgdG8gY2hlY2sgb3V0IHRoZSBjb21taXQgY29ycmVzcG9u
ZGluZyB0byB0aGlzDQo+ID4gPj4gcGF0Y2gsIHRoZW4gZG8gImdpdCBibGFtZSAtTSBrZXJuZWwv
cmN1L3JjdXNjYWxlLmMiLiAgR2l2ZW4gYQ0KPiA+ID4+IG1vdmUtb25seSBjb21taXQsIHRoZXJl
IHNob3VsZCBiZSBubyBsaW5lIHRhZ2dlZCB3aXRoIHRoaXMgY29tbWl0J3MNCj4gU0hBLTEuDQo+
ID4gPg0KPiA+ID4gSnVzdCBoYWQgYSBnb29kIGV4cGVyaW1lbnQgd2l0aCB0aGUgImdpdCBibGFt
ZSAtTSIgb3B0aW9uOg0KPiA+ID4gLSBVc2VkIHRoaXMgb3B0aW9uIHRvIHByb3ZlIGEgbW92ZS1v
bmx5IGNvbW1pdCBxdWlja2x5IChubyBsaW5lIHRhZ2dlZA0KPiB3aXRoIHRoYXQgY29tbWl0KSAo
dGhlIGZhc3Rlc3QgbWV0aG9kIHRvIG1lKS4NCj4gPiA+IC0gVGhlbiBqdXN0IG9ubHkgbmVlZGVk
IHRvIHF1aWNrbHkgY2hlY2sgdGhlIHBvc2l0aW9ucyBvZiB0aGUgbW92ZWQgY29kZQ0KPiBjaHVu
ayBieSBteXNlbGYgKGVhc3kpLg0KPiA+ID4NCj4gPiA+IFRoYW5rIHlvdSwgUGF1bCBmb3Igc2hh
cmluZyB0aGlzLiBJdCdzIHZlcnkgdXNlZnVsIHRvIG1lLg0KPiA+DQo+ID4gTG9va3MgZ29vZCB0
byBtZSBhcyB3ZWxsIGFuZCB0aGFuayB5b3UgYm90aCBmb3Igc2hhcmluZyB0aGUgdGlwcy4NCj4g
DQo+IEhlcmUgaXMgb25lIHdheSB0byBzY3JpcHQgdGhpcywgd2hlcmUgIlNIQSIgaWRlbnRpZmll
cyB0aGUgY29tbWl0IHRvIGJlDQo+IGNoZWNrZWQgYW5kIFBBVEhTIHRoZSBhZmZlY3RlZCBwYXRo
bmFtZXM6DQo+IA0KPiAJZ2l0IGNoZWNrb3V0IFNIQV4NCj4gCWdpdCBzaG93IFNIQSB8IGdpdCBh
cHBseSAtDQo+IAlnaXQgYmxhbWUgLU0gUEFUSFMgfCBncmVwICdeMCogJw0KDQpDb29sIH4uIFRo
YW5rIHlvdSwgUGF1bC4gIA0KSSB0b29rIHRoZW0gYW5kIG1hZGUgdGhlbSBpbnRvIGEgc2NyaXB0
IGJlbG93IGZvciBmdXR1cmUgdXNlIDstKQ0KDQojIS9iaW4vYmFzaA0KDQpTSEE9JDENCg0KaWYg
WyAteiAiJFNIQSIgXTsgdGhlbg0KICAgIGVjaG8gIlVzYWdlOiAkMCA8Y29tbWl0LWlkPiINCiAg
ICBleGl0IDENCmZpDQoNCmlmICEgZ2l0IGNhdC1maWxlIC10ICIkU0hBIiAmPiAvZGV2L251bGw7
IHRoZW4NCiAgICAgICAgZWNobyAiJFNIQSBkb2VzIG5vdCBleGlzdCBpbiB0aGUgcmVwb3NpdG9y
eSINCiAgICAgICAgZXhpdCAxDQpmaQ0KDQpnaXQgY2hlY2tvdXQgJHtTSEF9XiAmPiAvZGV2L251
bGwNCmdpdCBzaG93ICR7U0hBfSB8IGdpdCBhcHBseSAtICY+IC9kZXYvbnVsbA0KDQpQQVRIUz1g
Z2l0IHN0YXR1c3wgZ3JlcCAibW9kaWZpZWQ6IiB8IGN1dCAtZDogLWYyIHwgeGFyZ3NgDQoNCmZv
ciBQIGluICR7UEFUSFN9OyBkbw0KICAgICAgICBSPWBnaXQgYmxhbWUgLU0gJFAgfCBncmVwICde
MCogJ2ANCiAgICAgICAgaWYgdGVzdCAtbiAiJFIiOyB0aGVuDQogICAgICAgICAgICAgICAgZWNo
byAiJFNIQSBpcyBOT1QgYSBtb3ZlLW9ubHkgY29tbWl0Ig0KICAgICAgICAgICAgICAgIGV4aXQg
MQ0KICAgICAgICBmaQ0KZG9uZQ0KDQplY2hvICIkU0hBIGlzIGEgbW92ZS1vbmx5IGNvbW1pdCIN
Cg0KPiBJZiB0aGVyZSBpcyBubyBvdXRwdXQsIHRoZXJlIHdlcmUgbm8gbm9uLW1vdmUgY2hhbmdl
cy4NCj4gDQo+IE9yIGp1c3QgZG8gdGhlICJnaXQgYmxhbWUgLU0gUEFUSFMgfCBncmVwICdeMCog
JyIgYmVmb3JlIGRvaW5nIHRoZSBjaGVja2luZy4NCj4gDQo+IEFuZCB5ZXMsIHlvdSBjYW4gZGVy
aXZlIFBBVEhTIHVzaW5nICJnaXQgc3RhdHVzIiBpZiB5b3Ugd2FudC4gIDstKQ0KPiAJCQkJCQkJ
VGhhbngsIFBhdWwNCg==
