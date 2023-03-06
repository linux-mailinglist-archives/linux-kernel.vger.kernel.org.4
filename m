Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C45C6ACBD4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCFSC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjCFSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:02:22 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559596BDD9;
        Mon,  6 Mar 2023 10:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678125713; x=1709661713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aZTKQFZ2VEfrd3x1sAP29vw7NJ2JVd8HcwxmMdZ9HHQ=;
  b=NzavSE9s7daXbmsHgsFxmuo34pNq8acZMywJNkmVd9iInFM43upDTQzC
   7VIdWM3Jy2W7Lx6QWOYJDWwNdx4YR7SepMdBXEwQTKGd9Zbd2jyQbq6ns
   tf2ezurTjDS5Y8SI9go8PRkpCJumvmVyGhfzlGH19i1z2cYKfAo+Njci4
   1Vkg4rSrILInUy5ErGd96Tvvltxdh6k4v7Bnhxvps1I6EU55g/Px7LyRg
   x/WQnFUKffjamfymcOiXGO0w9DYdEoyzHWuhNdh0RHt1TafI4RU/0Azk/
   9N0Gy9uuYlEF2LyyK4Rm8rqVzaSDeoW8dwdcWRCyn3wB9gIg3HBJEYbSq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="337146514"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="337146514"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 09:59:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="800070596"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="800070596"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 06 Mar 2023 09:59:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 09:59:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 09:59:39 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 09:59:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6T5oqlQD18Af3pJTyOA1IuMfKqOeLHSFrZdq/kmKcb7T4hRTVMj+gqyfG1GNr07WdR5/OEkWExzx3owuDKx1VW6IrzYjly9OiSVLF281BDJXpbrODx3jq91gWT0K3IGY46tJLUb5+7xvBZ2M60nK4dtp+6XSXWW11TcU4VlKODhHk4iZKBj6bMsZ02Fg+5exEMnpdE/dtH+rtopS7Ncd5f3zEbkYcm6PJ+PU7Cor3VP7C6JFZZHMREtUlPVQ/o0WICQOXqjl0ZablufS6Sv82c5Kuew9It7LH0Oq/O9jr4Ia/dLzBPkWL49w0767TTteVemhkwK7+qtFUCN/c53wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZTKQFZ2VEfrd3x1sAP29vw7NJ2JVd8HcwxmMdZ9HHQ=;
 b=TsIXITmGyhXimbiu49FZ8pQS0xBNU2Uwzo3JJeAmyQ5Q3Wk9v2RXAFNCt8YYVq7ocoelRb8gn0ZQSo8aCVnFefJwqzT+4dB2oD5Cl5jRKa20LdDX+cyltudriGKEDPazrHYvQmQsjrEM5rtgxjHVnLJ3TPWkxii2QeRSFrfP9lZYb3MnULRhvkZrIlHCbNaz6eOdiw6fDC5pQSWBHOvviLZOmw+njJqZvYRnFbYUQJS4u8RQ74iFC9iek470BaAl6R0UNyvPshW/65qjvBzWUk0U51N6IFXE6aoEjmkVrqISZXVlgzg8+fGzPN9uj+/GX3IccIPsRVt+QlPeBQ42bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8)
 by SA0PR11MB4589.namprd11.prod.outlook.com (2603:10b6:806:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 17:59:36 +0000
Received: from MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::7ef3:9d23:97f6:8455]) by MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::7ef3:9d23:97f6:8455%5]) with mapi id 15.20.6156.025; Mon, 6 Mar 2023
 17:59:36 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "rajat.khandelwal@linux.intel.com" <rajat.khandelwal@linux.intel.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>
CC:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
Thread-Topic: [PATCH v6] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
Thread-Index: AQHZS40ppP3mFSPZdE+sDSQ+vFXEgK7uE7eA
Date:   Mon, 6 Mar 2023 17:59:36 +0000
Message-ID: <4c01c9e7ef9455c791fdad9de13ce706b4c3e3e2.camel@intel.com>
References: <20230301155757.1293131-1-rajat.khandelwal@linux.intel.com>
In-Reply-To: <20230301155757.1293131-1-rajat.khandelwal@linux.intel.com>
Reply-To: "Box, David E" <david.e.box@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4522:EE_|SA0PR11MB4589:EE_
x-ms-office365-filtering-correlation-id: c2970b87-0081-472f-b000-08db1e6c8c46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tiflKkBJYPOZzaGwx2nDmC8iEt+X6kGk2JlBJ2ozulYTyuK9kuyY1S9RBYsBw1iHOMD04tgfe+L20l/5qimVm18RKZzcW+i8KLkXraCnhKi853xmL27Baq224iyizkB7QW1RR0i3uqlwumHSGNMuyRAUcDvKNXW0NPb8XFNZgcuCVTGYY4UIIYiK0ty+WwsCla6XMRfjkW3ZZelza7DtmSsaINDRfisgu6uGNLAVg6l6u+0DTtAJkHy7gHBHfQXTCiMdZaSJRfDg8lOAzieuROBqj5EcBaUVsKlDyJNRtTi8epqnUz/D7tPK60lqUXPtTcLFOykt0PgCDDL7Esm0PoYt9NsRKHOY7UID0pcrpjkCPG7w9FjdLrVJQjmO97itrC07FJjm9ivG7ssJyfFZLhBakF7vxOGIxN9fi8gNJCAyXsx3aXW+11bE9ltf8PLAgEe5HpkXFHwwmUru6tAhw7QTdF+pCYkbgRbmBU+P0hBajxWJHtlRnC5T3O4tBCDWWMYknVOp2YTta40E6scDJpUbeTW/0YVSRMO88/IRNzGsHH87UvXC666fGIQ6EgmBYA4vjSrOLlpkAYf4XSbAUIYEiGQZPkBLUyPQ1ayEDajtKR9+OHHUzxDeSzN5Lg0Ww6mgcUtpmY+lA96SFjDIQDlx4EOjpF6wl5HsRStzfDlv76OscWAv5n4gsJ5LqnlaSbduCq9rwVteRCXGeeQ4iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199018)(8936002)(5660300002)(66446008)(76116006)(91956017)(66946007)(66556008)(2906002)(66476007)(8676002)(64756008)(4326008)(3450700001)(54906003)(110136005)(316002)(478600001)(71200400001)(36756003)(6512007)(6506007)(6486002)(26005)(2616005)(41300700001)(122000001)(82960400001)(86362001)(83380400001)(38070700005)(186003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWtjS1diN1lKYXAyWTlkT25OOUQ2bkxDbDlJcklWZFNlWHlBWGcxdWw2REZa?=
 =?utf-8?B?MERXbER6bU1Pam5FTUNaWXNpZmp0elk2ZzFKcE9jZGMxMFNSUElTYXFkV0RP?=
 =?utf-8?B?SS96STl4SytaM2VLNzFqNHAyUnBOaUxWRkloeGVTWjJDdEFhc2htTnZpTWs5?=
 =?utf-8?B?UlZGTlVBclhaUzkxTUFOTDRFVjdJOWowOTArRVh4U0NQNTY5SzNMQW9KS0RH?=
 =?utf-8?B?UHlORHRLZG1KY1RQYmFRWm04RjU5RDRTVG5aU2xkWTg0b1VQZ0lnQTd1WlB2?=
 =?utf-8?B?enFqRmMvODVIMWNZQ3dvNGhaZzNoTjluVDlwdkV6U0g2SzJ6MTBNa0dFSjR0?=
 =?utf-8?B?VkJGN2FkRjNjLzcwdGVOOFVib2RNUHpFSnV0dEdMYUxORTRDLzNlNzBQajRZ?=
 =?utf-8?B?UTlNL205SG5TdXlZK2xBVHVsK3FydURMYlRyeW1uYWIwT0NlcHRhaUNyNWw0?=
 =?utf-8?B?VEoyaWhhR0RndGZ5bG5qV0FwSDhXVmNYaHBWK05FMitWZjFJY1FycmwvTms1?=
 =?utf-8?B?MWY5QVhZd3R2Q01weHBaTE9ydS9YeDRXb2pPSUt4MlhENnhOYzlnNzN4bDh4?=
 =?utf-8?B?dGhCakk1dmJPOWIrbHJoYlZSZ0YxVFc2ZVFZeE0xRHdhUkEySE5Md2hWT1dD?=
 =?utf-8?B?NzBTNDVRNUlhM29ubkpHSlhWaE50VTNUaWJWY1FwNStKRVBLelNqVk50ZHIx?=
 =?utf-8?B?YlhwQzlCWkFFZGF1Qm5QYzhCZkJGbmJvckNiU1I3R3d0QjNXdG14YkxadFdo?=
 =?utf-8?B?Um5sdU9JeElvMk0yck4wTWxyRk9nTVZLL2J5aTk5ODhWSWQzZG1hU1VEQWZ2?=
 =?utf-8?B?d0JSOCt2MDhkd0RPRXdCT1RXMWlwbTRzZTQySERrSXdTcjJmR3VNTHJXeXJU?=
 =?utf-8?B?bDJnM3JxKzhQd0I4eEpmYkZKNERQTWFJcU5ZOVhZaVBnaXVON0R1RjF4SFov?=
 =?utf-8?B?bGR2Smt6T1phUWNVL1NkU3I5bEptZThPREExWFZvdnY4WDlITjdtVXlheGtP?=
 =?utf-8?B?QWo0U0JXL3NmUk93dElOWUFPd0pnMUtMOUZCK0ZoRUw4ZnVvdzEvT2tmVXJ3?=
 =?utf-8?B?MmNQR0tHRHgxckNocFFIOW9UdkdOZHRQSXMwVUlKSGUvQTU5eDhYVno4SmVF?=
 =?utf-8?B?Nm4yNHk0cUpMdGtSQ3RlVDV1UzYrZU55ODFpTTliRkhybm5OTlA0YmlWcTZF?=
 =?utf-8?B?L2h3TDlPdGt6UjRnY3haV0lJakthdm8ydnFaenFIM2FPYmxyL3htN0F1UlRD?=
 =?utf-8?B?L1RFUGJGWUZjbnAzck1uWGJTdUowZlFLVU9HaWI4MGxkWFZMeUoxQjRRN3ov?=
 =?utf-8?B?RlB4OWVtOVdLYUZUT3VRK3AyRHJiRkdJUDF3OTFsUkpYdXpSUU5icHpZcmx1?=
 =?utf-8?B?Z1VwZFQ0bE41WXNZdjlocTNuVlRCQUo0Z0lQK0xieW5WMGJpRnQ4NWFPVzZB?=
 =?utf-8?B?R3VUOWVxWWgwc0lkOFBPTmp0MW96UXo2VTYwZmlQbStMSFI1c1RxVkI4MDlS?=
 =?utf-8?B?TEdzRlF5dlhYdkg4eUxTZTgyNkFPcDM4bW0zVmxPTlNod0VpVlRtWlMyWmlz?=
 =?utf-8?B?dWp5UFlObHhQKzhoREVsYjk4Tzl3dXZIMkpPZ0FSNkcweHV5dFVRaDhJK2N5?=
 =?utf-8?B?dm4xSmtja2VhZUp3WnlBRW9RUFVxZ2RlRm8xak5PNExRWWQrcEJyOVorY0pJ?=
 =?utf-8?B?aUoyTjVWNVF6TU9WU0pWcy9XZnhaOFpaQVMxUTlGc1htWlVlMkFzL0w5ai9U?=
 =?utf-8?B?NXdXaG9KWERqTWRBcTNUMTlZZzljRjB0ekxXck1xQmFSRWZodmpHVi9VWDVB?=
 =?utf-8?B?ZGFMekE0aVFMK2ZnOVUxZDBmaVBOdGdLWC9BUmlhVVhwOTFzN0sySE4wRytI?=
 =?utf-8?B?c3hHdzZLRVF1YU0vOHVJUTFFOXl3ZWIrWmwrSWgrcFBWdDV3SkFaNWYwMWs4?=
 =?utf-8?B?N3RROTRjK2w0ZGg3TnpzcmQwUDlvM1NJamZPellZeGpqU3hienZveFRmNFU4?=
 =?utf-8?B?SHRUaTFURkplaWlDeFZDVmw4dnh0ek42WXlsMWVMcG9pRlkxL0dMYjRLZVla?=
 =?utf-8?B?SzVHbUxiMFNzK25obEJXQVo5RnlxRDU3am4vd21ueFkxZ2drVDU1Q0h0eVFo?=
 =?utf-8?B?M3NVZTArbi9uakNaUEFySUxQTFdLNXlwLzJQQUJNZnp4WmpuUSt6ZW93QUp6?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F12AC1F9D44854EBA622A548D579ACB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2970b87-0081-472f-b000-08db1e6c8c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 17:59:36.1644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTCQ5mSBvqeakWInUUkIXZ67+L8WrdbKW1dvhCN6vYzrxPS7ZF1aIyTNWPjb2MvyREH9Ba36lGrCaBFZr4NatA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4589
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFqYXQsCgpXZSBoYXZlIHNvbWUgY2hhbmdlcyBjb21pbmcgZm9yIHRoaXMgZHJpdmVyIGlu
IG9yZGVyIHRvIHN1cHBvcnQgbXVsdGlwbGUgUE1DCmRldmljZXMgb24gdGhlIHNhbWUgU29DLiBB
cyBwYXJ0IG9mIHRoaXMgd2UgYXJlIG1vZGlmeWluZyB0aGUgb3V0cHV0IG9mIGx0cl9zaG93CnRv
IHByZWZpeCB0aGUgSVAgd2l0aCBudW1iZXIgb2YgdGhlIG1hbmFnaW5nIFBNQy4gRm9yIGV4YW1w
bGU6CgpQTUNbMF06U09VVEhQT1JUX0EJTFRSOiBSQVc6IDB4MAlOb24tU25vb3AobnMpOiAwCVNu
b29wKG5zKTogMApQTUNbMF06U09VVEhQT1JUX0IJTFRSOiBSQVc6IDB4MAlOb24tU25vb3AobnMp
OiAwCVNub29wKG5zKTogMAouLi4KUE1DWzFdOlNPVVRIUE9SVF9BCUxUUjogUkFXOiAweDAJTm9u
LVNub29wKG5zKTogMAlTbm9vcChucyk6IDAKUE1DWzFdOlNPVVRIUE9SVF9CCUxUUjogUkFXOiAw
eDAJTm9uLVNub29wKG5zKTogMAlTbm9vcChucyk6IDAKCldlJ3JlIHRoaW5raW5nIHRoYXQgaXQg
d291bGQgYmUgYmV0dGVyIHRvIGhhdmUgYSBjb2x1bW4gaW4gbHRyX3Nob3cgZm9yIHRoZQppZ25v
cmUgc3RhdHVzLiBUaGlzIHdvdWxkIG1ha2UgZXZlcnl0aGluZyB2aWV3YWJsZSBpbiBvbmUgZGlz
cGxheS4gQSBsaXN0IHdvdWxkCm5vdCBiZSBuZWVkZWQuIFRoZSBzdGF0dXMgY2FuIGJlIHJlYWQg
YmFjayBmcm9tIHRoZSBsdHJfaWdub3JlIHJlZ2lzdGVyLiBXb3VsZAp0aGF0IHdvcmsgZm9yIHlv
dT8gVGhhbmtzLgoKRGF2aWQKCk9uIFdlZCwgMjAyMy0wMy0wMSBhdCAyMToyNyArMDUzMCwgUmFq
YXQgS2hhbmRlbHdhbCB3cm90ZToKPiBDdXJyZW50bHksICdsdHJfaWdub3JlJyBzeXNmcyBhdHRy
aWJ1dGUsIHdoZW4gcmVhZCwgcmV0dXJucyBub3RoaW5nLCBldmVuCj4gaWYgdGhlcmUgYXJlIGNv
bXBvbmVudHMgd2hvc2UgTFRSIHZhbHVlcyBoYXZlIGJlZW4gaWdub3JlZC4KPiAKPiBNYWtlIHRo
ZSBzeXNmcyBhdHRyaWJ1dGUgcHJpbnQgb3V0IHN1Y2ggY29tcG9uZW50cywgaWYgdGhleSBleGlz
dCwgYW5kCj4gcmV0dXJuIEVFWElTVCwgaWYgdHJpZWQgdG8gc2V0IGFuIGFscmVhZHkgaWdub3Jl
ZCBjb21wb25lbnQuCj4gCj4gU2lnbmVkLW9mZi1ieTogUmFqYXQgS2hhbmRlbHdhbCA8cmFqYXQu
a2hhbmRlbHdhbEBsaW51eC5pbnRlbC5jb20+Cj4gLS0tCj4gCj4gdjY6IERlc2NyaXB0aW9uIHdy
aXR0ZW4gaW4gaW1wZXJhdGl2ZSBzZW5zZQo+IAo+IHY1Ogo+IDEuIElnbm9yZSB0aGUgTFRSIG9m
IHRoZSByZXNwZWN0aXZlIGNvbXBvbmVudCBhZnRlciB1bmxvY2tpbmcgdGhlIG11dGV4IGxvY2sK
PiAyLiBBZGRpbmcgZXJyb3IgY29kZSBkZXRhaWxzIHRvIHRoZSBjb21taXQgbWVzc2FnZQo+IAo+
IHY0OiBNdXRleCB1bmxvY2sgZHVyaW5nIGVycm9yIGNvbmRpdGlvbnMKPiAKPiB2MzogSW5jb3Jw
b3JhdGVkIGEgbXV0ZXggbG9jayBmb3IgYWNjZXNzaW5nICdsdHJfaWdub3JlX2xpc3QnCj4gCj4g
djI6IGttYWxsb2MgLT4gZGV2bV9rbWFsbG9jCj4gCj4gwqBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9p
bnRlbC9wbWMvY29yZS5jIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCj4gwqBkcml2
ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5oIHzCoCAyICstCj4gwqAyIGZpbGVzIGNo
YW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5jCj4gYi9kcml2ZXJzL3BsYXRm
b3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5jCj4gaW5kZXggM2ExNWQzMmQ3NjQ0Li4xNmNmNmM2MzRk
YjggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUuYwo+
ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmMKPiBAQCAtNTMsNiAr
NTMsMTcgQEAgY29uc3Qgc3RydWN0IHBtY19iaXRfbWFwIG1zcl9tYXBbXSA9IHsKPiDCoMKgwqDC
oMKgwqDCoMKge30KPiDCoH07Cj4gwqAKPiArLyogTXV0dWFsIGV4Y2x1c2lvbiB0byBhY2Nlc3Mg
dGhlIGxpc3Qgb2YgTFRSLWlnbm9yZWQgY29tcG9uZW50cyAqLwo+ICtzdGF0aWMgREVGSU5FX01V
VEVYKGx0cl9lbnRyeV9tdXRleCk7Cj4gKwo+ICtzdHJ1Y3QgbHRyX2VudHJ5IHsKPiArwqDCoMKg
wqDCoMKgwqB1MzIgY29tcF9pbmRleDsKPiArwqDCoMKgwqDCoMKgwqBjb25zdCBjaGFyICpjb21w
X25hbWU7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGxpc3RfaGVhZCBub2RlOwo+ICt9Owo+ICsK
PiArc3RhdGljIExJU1RfSEVBRChsdHJfaWdub3JlX2xpc3QpOwo+ICsKPiDCoHN0YXRpYyBpbmxp
bmUgdTMyIHBtY19jb3JlX3JlZ19yZWFkKHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYsIGludCByZWdf
b2Zmc2V0KQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmVhZGwocG1jZGV2LT5yZWdi
YXNlICsgcmVnX29mZnNldCk7Cj4gQEAgLTQzNSwyNyArNDQ2LDE4IEBAIHN0YXRpYyBpbnQgcG1j
X2NvcmVfcGxsX3Nob3coc3RydWN0IHNlcV9maWxlICpzLCB2b2lkCj4gKnVudXNlZCkKPiDCoH0K
PiDCoERFRklORV9TSE9XX0FUVFJJQlVURShwbWNfY29yZV9wbGwpOwo+IMKgCj4gLWludCBwbWNf
Y29yZV9zZW5kX2x0cl9pZ25vcmUoc3RydWN0IHBtY19kZXYgKnBtY2RldiwgdTMyIHZhbHVlKQo+
ICt2b2lkIHBtY19jb3JlX3NlbmRfbHRyX2lnbm9yZShzdHJ1Y3QgcG1jX2RldiAqcG1jZGV2LCB1
MzIgdmFsdWUpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBwbWNfcmVnX21h
cCAqbWFwID0gcG1jZGV2LT5tYXA7Cj4gwqDCoMKgwqDCoMKgwqDCoHUzMiByZWc7Cj4gLcKgwqDC
oMKgwqDCoMKgaW50IGVyciA9IDA7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygm
cG1jZGV2LT5sb2NrKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGlmICh2YWx1ZSA+IG1hcC0+bHRy
X2lnbm9yZV9tYXgpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gLUVJ
TlZBTDsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfdW5sb2NrOwo+
IC3CoMKgwqDCoMKgwqDCoH0KPiAtCj4gwqDCoMKgwqDCoMKgwqDCoHJlZyA9IHBtY19jb3JlX3Jl
Z19yZWFkKHBtY2RldiwgbWFwLT5sdHJfaWdub3JlX29mZnNldCk7Cj4gwqDCoMKgwqDCoMKgwqDC
oHJlZyB8PSBCSVQodmFsdWUpOwo+IMKgwqDCoMKgwqDCoMKgwqBwbWNfY29yZV9yZWdfd3JpdGUo
cG1jZGV2LCBtYXAtPmx0cl9pZ25vcmVfb2Zmc2V0LCByZWcpOwo+IMKgCj4gLW91dF91bmxvY2s6
Cj4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9jaygmcG1jZGV2LT5sb2NrKTsKPiAtCj4gLcKg
wqDCoMKgwqDCoMKgcmV0dXJuIGVycjsKPiDCoH0KPiDCoAo+IMKgc3RhdGljIHNzaXplX3QgcG1j
X2NvcmVfbHRyX2lnbm9yZV93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKPiBAQCAtNDY0LDYgKzQ2
Niw4IEBAIHN0YXRpYyBzc2l6ZV90IHBtY19jb3JlX2x0cl9pZ25vcmVfd3JpdGUoc3RydWN0IGZp
bGUKPiAqZmlsZSwKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHNlcV9maWxlICpzID0g
ZmlsZS0+cHJpdmF0ZV9kYXRhOwo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcG1jX2RldiAqcG1j
ZGV2ID0gcy0+cHJpdmF0ZTsKPiArwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgcG1jX3JlZ19t
YXAgKm1hcCA9IHBtY2Rldi0+bWFwOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBsdHJfZW50cnkg
KmVudHJ5Owo+IMKgwqDCoMKgwqDCoMKgwqB1MzIgYnVmX3NpemUsIHZhbHVlOwo+IMKgwqDCoMKg
wqDCoMKgwqBpbnQgZXJyOwo+IMKgCj4gQEAgLTQ3MywxMyArNDc3LDQ5IEBAIHN0YXRpYyBzc2l6
ZV90IHBtY19jb3JlX2x0cl9pZ25vcmVfd3JpdGUoc3RydWN0IGZpbGUKPiAqZmlsZSwKPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKGVycikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiBlcnI7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBlcnIgPSBwbWNfY29yZV9zZW5kX2x0cl9p
Z25vcmUocG1jZGV2LCB2YWx1ZSk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHZhbHVlID4gbWFwLT5s
dHJfaWdub3JlX21heCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1F
SU5WQUw7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJmx0cl9lbnRyeV9tdXRleCk7
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50cnkoZW50cnksICZsdHJfaWdu
b3JlX2xpc3QsIG5vZGUpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGVu
dHJ5LT5jb21wX2luZGV4ID09IHZhbHVlKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIgPSAtRUVYSVNUOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfdW5sb2NrOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDC
oMKgwqBlbnRyeSA9IGRldm1fa21hbGxvYygmcG1jZGV2LT5wZGV2LT5kZXYsIHNpemVvZigqZW50
cnkpLCBHRlBfS0VSTkVMKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIWVudHJ5KSB7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVyciA9IC1FTk9NRU07Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X3VubG9jazsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+
ICvCoMKgwqDCoMKgwqDCoGVudHJ5LT5jb21wX25hbWUgPSBtYXAtPmx0cl9zaG93X3N0c1t2YWx1
ZV0ubmFtZTsKPiArwqDCoMKgwqDCoMKgwqBlbnRyeS0+Y29tcF9pbmRleCA9IHZhbHVlOwo+ICvC
oMKgwqDCoMKgwqDCoGxpc3RfYWRkX3RhaWwoJmVudHJ5LT5ub2RlLCAmbHRyX2lnbm9yZV9saXN0
KTsKPiArCj4gK291dF91bmxvY2s6Cj4gK8KgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZsdHJf
ZW50cnlfbXV0ZXgpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoZXJyKQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZXJyOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBwbWNf
Y29yZV9zZW5kX2x0cl9pZ25vcmUocG1jZGV2LCB2YWx1ZSk7Cj4gwqAKPiAtwqDCoMKgwqDCoMKg
wqByZXR1cm4gZXJyID09IDAgPyBjb3VudCA6IGVycjsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4g
Y291bnQ7Cj4gwqB9Cj4gwqAKPiDCoHN0YXRpYyBpbnQgcG1jX2NvcmVfbHRyX2lnbm9yZV9zaG93
KHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqdW51c2VkKQo+IMKgewo+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCBsdHJfZW50cnkgKmVudHJ5Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBtdXRleF9sb2Nr
KCZsdHJfZW50cnlfbXV0ZXgpOwo+ICvCoMKgwqDCoMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50cnko
ZW50cnksICZsdHJfaWdub3JlX2xpc3QsIG5vZGUpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc2VxX3ByaW50ZihzLCAiJXNcbiIsIGVudHJ5LT5jb21wX25hbWUpOwo+ICvCoMKg
wqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJmx0cl9lbnRyeV9tdXRl
eCk7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoH0KPiDCoAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5oCj4gYi9kcml2ZXJzL3Bs
YXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5oCj4gaW5kZXggODEwMjA0ZDc1OGFiLi5kYTM1YjBm
Y2JlNmUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUu
aAo+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmgKPiBAQCAtMzk2
LDcgKzM5Niw3IEBAIGV4dGVybiBjb25zdCBzdHJ1Y3QgcG1jX3JlZ19tYXAgYWRsX3JlZ19tYXA7
Cj4gwqBleHRlcm4gY29uc3Qgc3RydWN0IHBtY19yZWdfbWFwIG10bF9yZWdfbWFwOwo+IMKgCj4g
wqBleHRlcm4gdm9pZCBwbWNfY29yZV9nZXRfdGdsX2xwbV9yZXFzKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpOwo+IC1leHRlcm4gaW50IHBtY19jb3JlX3NlbmRfbHRyX2lnbm9yZShzdHJ1
Y3QgcG1jX2RldiAqcG1jZGV2LCB1MzIgdmFsdWUpOwo+ICtleHRlcm4gdm9pZCBwbWNfY29yZV9z
ZW5kX2x0cl9pZ25vcmUoc3RydWN0IHBtY19kZXYgKnBtY2RldiwgdTMyIHZhbHVlKTsKPiDCoAo+
IMKgdm9pZCBzcHRfY29yZV9pbml0KHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYpOwo+IMKgdm9pZCBj
bnBfY29yZV9pbml0KHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYpOwoK
