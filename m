Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B9367325A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjASHXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjASHXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:23:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6661D39B8D;
        Wed, 18 Jan 2023 23:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674112991; x=1705648991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BoJSNuvcgXH+o+NmtEIu2irkUTOirlVul8tVHASUxdk=;
  b=FwlZwd+CpONy7myGh1tKs8PwykHPINCeduSzjow8BLyQER6UQ6+37gyb
   Fn9LHeEvNtqgVtwgRxxxMQygp23FjfXdW2C3tVEmpKBrqdxPkV8jpRRFl
   udgHahB29GMlq9lqNncbTO4LNq1+VVmBNkDupu6StM+ubq+px0wl54ju6
   Othd6pQ+NpYR015BmKfHstbVEEdZTKVJcnoKAnDDBUvWJHTbAgLQzCTOe
   oiXXgyyRhAVI2bLFHF0RDrKHe/qtrcUGwCXnfDSucOvXl8ZCirKI6oEXt
   RLA90c+hHy/UDBCmCd7aTUBMfJaK7WW8eA0CoF8MUmtgo8Z+JQEPlwzdl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="389713134"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="389713134"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 23:23:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="833894142"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="833894142"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2023 23:23:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 23:23:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 23:23:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 23:23:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj0Z7YlpC40Rm0pJNaXNPPjPW0X3eOK1Kvqa1HOt2Kv+oWnU7rTsHl87CcWRkyHGP4uhaOnSo+eq0r4ad4+gkqwkeX64oG7LG6GjDsK2ugFhFUFcQ60k9BVywUiIDSLa8sk6A9EOHPmRmHd9i7948fWvePnQ8KDrrmvncDS7fMEgVVry1MOK+MqhSXyFeIK4fzHVL+QNLs7Fo1HgdspIfQTd/eEeD4PljGWt9kBdEfj6+XEuufqOEDIk9HsttZ0CMO/kcGy2LAOljAnEyVMPclvWkvK/nfS2q72S8CdJthDJ4rLjTjOVMV/yMd0JPKYQHZheST7+9csD4tNoR/g41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoJSNuvcgXH+o+NmtEIu2irkUTOirlVul8tVHASUxdk=;
 b=jty291LeThRpop5OnyRuCrD7lFIZ3JddHq9XZZr4d/yETu5j3Hrv/nNAqOsrUKVlMazp+nJ/6xPLuqskCABw8HaEvrgdjLlf2oGKiyXkBQTQGvzs+cqiO3QN1Y+0d292Hnk+Q2Wg5MjL0tm32cPpDsb8+/3qpfbVc8vniPHm+jRBzAHqIKlZfcFhxNEQhMVCkjYfaYsy5HcYmo451WSbRIMAEnJb11p5Zx8pD63T8GJfmyhxTWCxJWwa/iQOBPvRM02fXhFR/pXNAwgwck2xpziGabPnrsDyRyqLFQISODMO1IEOT1jjPvWwWxIAq82e7KEv1f+qArnlioje789CJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB6550.namprd11.prod.outlook.com (2603:10b6:8:b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 07:23:00 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%5]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 07:23:00 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
Subject: Re: [PATCH 5/5] thermal/core: Sort the trip points when registering a
 thermal zone
Thread-Topic: [PATCH 5/5] thermal/core: Sort the trip points when registering
 a thermal zone
Thread-Index: AQHZK4F47zkPXqRA50m46Kv1AcfKwa6lVrIA
Date:   Thu, 19 Jan 2023 07:22:59 +0000
Message-ID: <f515876ea2e43e734b8d4ac7feda7f17ee04894f.camel@intel.com>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
         <20230118211123.111493-5-daniel.lezcano@linaro.org>
In-Reply-To: <20230118211123.111493-5-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB6550:EE_
x-ms-office365-filtering-correlation-id: 1b25fcad-2199-451e-f52e-08daf9edfe90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xizf4IvJtV70Sy+MR2ad4FAOBXTytjNMe4WcAhezJhc1tE71Dj0dBtjd2oGgB9lLLkxAJ7ErPQ4fq8QltC7hDZdHBKkk4cm+9WZZIemm5qpIqUGckJWvQ9MbF7JM2h4vFtHcBaFDs+Luc4fEWZSBPxKY/xFZSxY0tYvJNSj4kvUr4acKtphIFK3Dh3kMsHKV2z+hlRta3LoPUbLIKT4v+/ZcFD9KabJeqRLlum8zpRI3g2lUKgKjWBWhd11km0bkitB6bq/TK5qASXIBIJzTKpZKxV4rPd8GuNEzBtsQ03Ws5cG1icvfwH3mXLbKxQq6jKAcYpTP9inbXvax4anOcXtJp6Wy1Qwl1btOrqITl3fR1c6RdRMvJLUNoh1v7cDudpj36lj1VdmHyv+lA7R6b3fhWCVGBVNgyXwz/f3VC+IAA/ZTa3WGLe6aaq0oj0slHzdCeHc4TkOJdV+q8RRV9YjFeGFtF4Q1n8+fxMq7ceenozhpoEIg1nScxzGJQ3pVXm415maDd/DDReUIgPsWqHQKNls562aZmFzI9PoKMXZnWhcMt5IQwac1tDWkOFyqB0cu0onAYJqUP3QBUxm7XE8p+etqT5GxPRwG/CvTrxUpmu0nyCcJQvCmpeuYL4i1X9xAZv0KjAau1Qq59tNiRALiW5giNnc6ClS2+9Qq+XB4vOia494HgMeiweE9h9t7dSr5+myziGqqnDxjcMEJUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199015)(2616005)(66556008)(41300700001)(83380400001)(36756003)(8936002)(91956017)(76116006)(54906003)(64756008)(8676002)(110136005)(66446008)(66946007)(66476007)(4326008)(2906002)(38100700002)(82960400001)(38070700005)(122000001)(86362001)(316002)(5660300002)(71200400001)(6506007)(6486002)(6512007)(478600001)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmdlaVJXSWRMY3JmVC80SUI3SjJMSUFBcXQ5OXFRTWdxb2dPb3VaUzdueW1R?=
 =?utf-8?B?dyt6cWVUUVNIcllXY29QSVNTNVVWOFlTTUZldzJDRFJsWldCdmpJWDl2QWps?=
 =?utf-8?B?a1dCWmtMTWtRaGswQTd3OTd0RWFrOFFJM3NXTnFKblZOOHpNcng2Vll2cC9E?=
 =?utf-8?B?d0NQMEJuV2dhaEFueEthR2RKUzhnUHlJdkErR3R1eDFPcWlMUVhJdjZrWE8z?=
 =?utf-8?B?dkJralg1SS9CUlhvem15cFJ5cm9jaU15Z2JUZUJhM3hGRWZaYk1kdnhaV1Vw?=
 =?utf-8?B?bWVWVngva2R3dXorVmtrZ1dtMGgrUC9OQzhJVmFJWWxadlY4VU1RNnhvNnB3?=
 =?utf-8?B?bUpLYUhjaE1IWHVPY2V0NVRPcVZ1UEcyY1pxMkNCUGdEQXliVHFGV1ZXdGsr?=
 =?utf-8?B?L2VhVFdEYVRqSUFzWkQ0WmgzbGlzMGx0OHNqYVNSVXhyVmZyOWJ4bTl5TWJX?=
 =?utf-8?B?a1gzS1I4aHEveDczU3dwaW4vZGNPOTNMMUtXWk91emNCbXFzcGE5cGRMVjB3?=
 =?utf-8?B?MWpXdjllOWthcWMyaGtHNFV5aDBSb01ZTitXR0dqcFU2TVpNd3ZUZ0JPVUY1?=
 =?utf-8?B?U3NydldJU0Z1OXJFTmlrT2hLTDBFSHVjSk9nOUd5MzVsUGpUaEhoK2tUa2lY?=
 =?utf-8?B?ZTVxTDIxQzU0UThiOE1UcHRjZzVoSUtJeEtkY3IwaWJzYi91UmM5YUs3WHV3?=
 =?utf-8?B?OGFZM1FuKzlsVklUdlNWT2phKzh0YXdaUERZREROYWN5eUMzeUhTSENUZ0Qv?=
 =?utf-8?B?Tk1Bc3hLTTY1TU1DbURzTk9hQkc3VnJvSTZiNXRGT05lWlVvejhRVmJjbzM2?=
 =?utf-8?B?eTFVR0d5S2ovaTREUlVzMm84MG5jVnY0QjJpckhZU3Fmb3FkN01ORmM4ZVF3?=
 =?utf-8?B?aDdWZHNjZzNRWnJwcEtyR3VsLytyZUc4cVJ2akNvcm44SGM5TVYwQjc4OHVp?=
 =?utf-8?B?TnJCZTJUUFFqSUR0Wk15VEVTNEFsOE96SnpZeEJMRjB6L0dWNDRpU0tMVlBu?=
 =?utf-8?B?WkVrTEcvai8yVGwyUGNSK1JRSDdYMFdxWlZFRWI2S245Y0crNWlRQlBuWEw3?=
 =?utf-8?B?NE9pVUtWNFBvbVBsUVEydFhrOFNIckNKdU1IVVhDakdLbytnc0lvcERFL2ZB?=
 =?utf-8?B?RHB2ZEF6L21jWnRsTGR0WTlZYlhPdTZkUDA5bVNpVm8wMkhKRUVUV3VxYUFM?=
 =?utf-8?B?MkxxUHRpaFFxa3hsZ0lpMFZnVG5zM0VHcXplSDREVlpHZlhFbmhsMmZRcDR6?=
 =?utf-8?B?ajVhT3lrQUxhN3IvSG94L2xXSklOMjFyV2xzaFVDYVhzVHNyb3lBakVnNGJN?=
 =?utf-8?B?RTlnbzFNMzIvLzFsU2p4RU5qQVFDVUpFdjk0ajgzR09xOTVZYU5kU3Z0T2pj?=
 =?utf-8?B?VkpkZS9RWHdIQ3YvWE5OOTFGMzdIRE1yQjEwSEs3aDhYaWhhZTRybWJCeXp1?=
 =?utf-8?B?WEhjaGZBYUZuSHMzUGRJMHY2eW5URzR2YWllTmhPL0xITnJ0cjhxTVBHQkhj?=
 =?utf-8?B?MkQ0NmhwVlNOSG05MktwektUY1h3cE5ZUlRnZUdab2I0bWRmcWlvaUorTDlD?=
 =?utf-8?B?bkxwWjZXYis3L0lNWWlHbkUvTk1hM0dtaUtHTU9iQk9jTzUwOGhqcGRFNXI5?=
 =?utf-8?B?cGRUVHZsTmVmOFdKcGtHeFRaenYrMFlnbGlZa2pOeHcrM3V4ZSs2MndQZ2dZ?=
 =?utf-8?B?aExzaWh5SUNqcS9ENWNNRU1IUVJOQllmSURNL3BrM01EakxtdGYyRER0ejFF?=
 =?utf-8?B?QWZCYkduRC9SRlNzV2FHdnV0UEViTC9Pc0xETjlkclBObVlRSmZ4VGloV3hC?=
 =?utf-8?B?QWNYWnI5Z2xhZGRaV0dCTEdXWTd5dnBzaXVtYXpZRlVXaXM4enN0ZGNKbXBN?=
 =?utf-8?B?SEI0Z1ZOZ1c1WUpraWs2S01rSWZQUEdJclcyb056ZTZHbUI4MDlzUEVZd1JI?=
 =?utf-8?B?STQxNHVTSzNNakwvVys0dHNNNTJhd3lRRytEN1d4Nk9laDM5RXMvRTZFbnVE?=
 =?utf-8?B?enQyVUUweWx5VzZYU2FHWHNQYXJKK0lMVjdaSWFmd1VPbHF3ZjFBNVdEMElo?=
 =?utf-8?B?ODIrOUl0QytjMVNtRXZ3YVh1RzRXS0VHb2MwTHpkbzI0QWlNN2ZkOTBZQitD?=
 =?utf-8?B?NVczUDE1M2hQQW5maTVwYkFDSTBDWlV1ZnFpMjkxdEpMako3a3RlVmUzQS94?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EFF47413EB034498C645EBE8F303CB4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b25fcad-2199-451e-f52e-08daf9edfe90
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 07:22:59.9356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/y9YRUGwJkwJYpv8GRoZD/CRcbUp9MsbO9XrQFo7O30yTyX4k2UWH6EjtS8BmVjRDLIUGJE8zi5AY3zkf4/CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTE4IGF0IDIyOjExICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gTW9zdCBvZiB0aGUgZHJpdmVycyBhcmUgY29udmVydGVkIHRvIHVzZSB0aGUgZ2VuZXJpYyB0
aGVybWFsIHRyaXANCj4gcG9pbnRzLiBUaGV5IHJlZ2lzdGVyIGEgdGhlcm1hbCB6b25lIHdpdGgg
YW4gYXJyYXkgb2YgdHJpcCBwb2ludHMuDQo+IA0KPiBIb3dldmVyLCB3ZSBkb24ndCBoYXZlIHRo
ZSBndWFyYW50ZWUgdGhlIHRyaXAgcG9pbnRzIGFyZSBvcmRlcmVkLiBUaGUNCj4gbWFpbiBnb2Fs
IG9mIG1vdmluZyB0byB0aGUgZ2VuZXJpYyB0cmlwIHBvaW50cyBpcyB0byBwcm92aWRlIGEgY29t
bW9uDQo+IHN0cnVjdHVyZSwgb3JkZXJlZCwgc28gd2UgY2FuIGZpeCBzYW5lbHkgaG93IHRoZSB0
cmlwIHBvaW50cyBhcmUNCj4gY3Jvc3NlZC4gQXMgYSByZW1pbmRlciwgdGhlIGRldGVjdGlvbiBp
cyBmdXp6eSB3aGVuIHRoZSB0cmlwIHBvaW50cw0KPiBhcmUgZGVmaW5lZCB3aXRoIGh5c3RlcmVz
aXMgdmFsdWVzLCB3ZSBjYW4gaGF2ZSBkdXBsaWNhdGVkIG9yDQo+IGluY29uc2lzdGVudCB0cmlw
IGV2ZW50cy4NCj4gDQo+IFRoaXMgY2hhbmdlIHNvcnRzIHRoZSB0cmlwIHBvaW50cyBhcnJheSB3
aGVuIGl0IGlzIHJlZ2lzdGVyZWQgd2l0aA0KPiB0aGUNCj4gdGhlcm1hbCB6b25lLiBUaGUgZGly
ZWN0aW9uIG9mIHRoZSBvcmRlcmluZyBpcyBkZXNjZW5kaW5nIGJlY2F1c2UNCj4gd2hlbg0KPiB3
ZSBicm93c2UgdGhlIHRyaXAgcG9pbnRzLCB3ZSB3YW50IHRvIGNoZWNrIHRoZSBoaWdoZXN0IHRy
aXAgcG9pbnRzDQo+IGZpcnN0IGFzIHRoZXkgYXJlIGhpZ2hlciBpbiB0ZW1wZXJhdHVyZSwgdGh1
cyBoaWdoZXIgaW4gcHJpb3JpdHkuDQo+IA0KPiBBIHByX2luZm8oKSB0cmFjZSB0ZWxscyB0aGUg
dHJpcCBwb2ludHMgaGF2ZSBiZWVuIG9yZGVyZWQgaWYgaXQNCj4gYXBwZWFycyB0aGV5IGFyZSBu
b3Qgc29ydGVkIGluaXRpYWxseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBMZXpjYW5v
IDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdGhlcm1hbC90
aGVybWFsX2NvcmUuYyB8ICAzICsrKw0KPiAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5o
IHwgIDEgKw0KPiAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfdHJpcC5jIHwgMjggKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+IGIv
ZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+IGluZGV4IGQwNTc3Njg1MDg1YS4uMzk0
NzcwNTkxNzcxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMN
Cj4gKysrIGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+IEBAIC0xMjU1LDYgKzEy
NTUsOSBAQCB0aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVyX3dpdGhfdHJpcHMoY29uc3QNCj4g
Y2hhciAqdHlwZSwgc3RydWN0IHRoZXJtYWxfdHJpcCAqdA0KPiAgCWlmIChudW1fdHJpcHMgPiAw
ICYmICghb3BzLT5nZXRfdHJpcF90eXBlIHx8ICFvcHMtDQo+ID5nZXRfdHJpcF90ZW1wKSAmJiAh
dHJpcHMpDQo+ICAJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiAgDQo+ICsJaWYgKHRyaXBz
ICYmIHRoZXJtYWxfdHJpcF9zb3J0KHRyaXBzLCBudW1fdHJpcHMpKQ0KPiArCQlwcl9pbmZvKCJU
aGVybWFsIHRyaXBzIHNvcnRlZCBmb3IgdGhlcm1hbCB6b25lICclcydcbiIsDQo+IHR5cGUpOw0K
PiArCQ0KPiAgCXR6ID0ga3phbGxvYyhzaXplb2YoKnR6KSwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYg
KCF0eikNCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmgNCj4gYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9j
b3JlLmgNCj4gaW5kZXggMjYzNTAyMDZhOThkLi40Njg4MTA3ZmRhMWQgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3RoZXJtYWwv
dGhlcm1hbF9jb3JlLmgNCj4gQEAgLTExNyw2ICsxMTcsNyBAQCB2b2lkIF9fdGhlcm1hbF96b25l
X3NldF90cmlwcyhzdHJ1Y3QNCj4gdGhlcm1hbF96b25lX2RldmljZSAqdHopOw0KPiAgaW50IF9f
dGhlcm1hbF96b25lX2dldF90cmlwKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eiwgaW50
DQo+IHRyaXBfaWQsDQo+ICAJCQkgICAgc3RydWN0IHRoZXJtYWxfdHJpcCAqdHJpcCk7DQo+ICBp
bnQgX190aGVybWFsX3pvbmVfZ2V0X3RlbXAoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6
LCBpbnQNCj4gKnRlbXApOw0KPiAraW50IHRoZXJtYWxfdHJpcF9zb3J0KHN0cnVjdCB0aGVybWFs
X3RyaXAgKnRyaXBzLCBpbnQgbnVtX3RyaXBzKTsNCj4gIA0KPiAgLyogc3lzZnMgSS9GICovDQo+
ICBpbnQgdGhlcm1hbF96b25lX2NyZWF0ZV9kZXZpY2VfZ3JvdXBzKHN0cnVjdCB0aGVybWFsX3pv
bmVfZGV2aWNlICosDQo+IGludCk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvdGhl
cm1hbF90cmlwLmMNCj4gYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF90cmlwLmMNCj4gaW5kZXgg
MmVmNjFmZjdmZmMzLi45MjQ5OThmMDlhNWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdGhlcm1h
bC90aGVybWFsX3RyaXAuYw0KPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF90cmlwLmMN
Cj4gQEAgLTksNiArOSwzNCBAQA0KPiAgICovDQo+ICAjaW5jbHVkZSAidGhlcm1hbF9jb3JlLmgi
DQo+ICANCj4gKy8qDQo+ICsgKiBUaGUgdHJpcCBwb2ludHMgbXVzdCBiZSBvcmRlcmVkIGluIHRo
ZSBkZXNjZW5kaW5nIG9yZGVyIHNvIHdoZW4NCj4gd2UNCj4gKyAqIGJyb3dzZSB0aGUgdHJpcCBw
b2ludHMgd2Ugd2lsbCBoaXQgdGhlIGNyaXRpY2FsLCBob3QgYW5kIHRoZW4gdGhlDQo+ICsgKiBw
YXNzaXZlL2FjdGl2ZSB0cmlwIHBvaW50cy4gVGhlIGNyaXRpY2FsIHRyaXAgcG9pbnQgYmVpbmcg
dGhlDQo+IGZpcnN0DQo+ICsgKiBvbmUgdG8gYmUgaGFuZGxlZC4NCj4gKyAqLw0KPiAraW50IHRo
ZXJtYWxfdHJpcF9zb3J0KHN0cnVjdCB0aGVybWFsX3RyaXAgKnRyaXBzLCBpbnQgbnVtX3RyaXBz
KQ0KPiArew0KPiArCXN0cnVjdCB0aGVybWFsX3RyaXAgdHQ7DQo+ICsJaW50IHNvcnRlZCA9IDA7
DQo+ICsJaW50IGksIGo7DQo+ICsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgbnVtX3RyaXBzOyBpKysp
IHsNCj4gKw0KPiArCQlmb3IgKGogPSBpICsgMTsgaiA8IG51bV90cmlwczsgaisrKSB7DQo+ICsN
Cj4gKwkJCWlmICh0cmlwc1tpXS50ZW1wZXJhdHVyZSA8DQo+IHRyaXBzW2pdLnRlbXBlcmF0dXJl
KSB7DQo+ICsJCQkJdHQgPSB0cmlwc1tpXTsNCj4gKwkJCQl0cmlwc1tpXSA9IHRyaXBzW2pdOw0K
PiArCQkJCXRyaXBzW2pdID0gdHQ7DQo+ICsJCQkJc29ydGVkKys7DQo+ICsJCQl9DQo+ICsJCX0N
Cj4gKyAJfQ0KPiArDQo+ICsJcmV0dXJuIHNvcnRlZDsNCj4gK30NCj4gKw0KV2hlbiB0aGlzIGhh
cHBlbnMsIHRoZSBpbmRleCh0cmlwX2lkKSBvZiBlYWNoIHRyaXAgaXMgY2hhbmdlZCwgYnV0IHdl
DQpwYXNzIHRoZSBuZXcgdHJpcF9pZCB0byAuZ2V0X3RyaXBfdGVtcCgpLy5zZXRfdHJpcF90ZW1w
KCkgY2FsbGJhY2tzLg0KDQpUaGlzIHdpbGwgY29uZnVzZSB0aGUgZHJpdmVycyBhbmQgdXBkYXRl
IHRoZSB3cm9uZyB0cmlwcywgcmlnaHQ/DQoNCklNTywgd2UgbmVlZCBhIG1hcCBiZXR3ZWVuIHRo
ZXJtYWwgY29yZSB0cmlwcyBhbmQgdW5zb3J0ZWQgZHJpdmVyDQp0cmlwcy4NCg0KdGhhbmtzLA0K
cnVpDQoNCj4gIGludCBfX2Zvcl9lYWNoX3RoZXJtYWxfdHJpcChzdHJ1Y3QgdGhlcm1hbF96b25l
X2RldmljZSAqdHosDQo+ICAJCQkgICAgaW50ICgqY2IpKHN0cnVjdCB0aGVybWFsX3RyaXAgKiwN
Cj4gIAkJCQkgICAgICBpbnQgdHJpcF9pZCwgdm9pZCAqKSwNCg==
