Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185AB69DC35
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjBUIiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjBUIip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:38:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C1223866
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676968694; x=1708504694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0RoZlm8j/DeytgEQvUmVWYiNuWs5OV85JlICoxIeJ2U=;
  b=WYKr3HXnRZo8z1TlV3uWgIEaxiviIqDPLCqKd5cI0sWGxTsxOgMBJw31
   Q30ciuRo4d1qF18vexqMH9i7ZKYVtODBf2DrKpdkaQ9keQ1T5c8gSGReD
   LyT5vCvA7NQLVkMgz5fINkoYqBkR3NoE3FkDK5WK7eOqTsG8l2UHKcqvV
   7eT1e422k4izMdMgrVVPZadyoirk6eCFDQC9kL30KPkXSe/cvY9Q46eKR
   qvAaMWdisqbmwv6MGF81P2LTyTj1gWOAAGVnNQUdRKdx8DUAb+fRzR1HQ
   irrqquIaOWKWKK+EJ61lDQyviN9aNws5A7lvTlfaSeAnftmJtV4noS8WW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="312946704"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="312946704"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 00:34:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="673598308"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="673598308"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 21 Feb 2023 00:34:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 00:34:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 00:34:10 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 00:34:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw9WuJVXBPuOrDa2Juaahc+TNAK/ap6PXrNhkcX119U5dwb53ZIB3dZhrPU3ssVBdl9wVop8mwppQ09Gy2iftxTTv8pdpgOpdvba9107qqDkGxbgOzsoZ7qStfGLdUPMMACIQHaIRwqZvgVywS7uUtdRATrRZ+cdzSlJn+EY8RDfmEOIKrgrTBxFiThWHRCjZXHt9/wRZtq4n08unPZc/y+7vUz+HEQlXDmO1IU2UaXX+AL7fozooswLEhwol3SD2n7Cwj8ilGj0SgPiYWfpHhSecFKH5rzmJDtlU1J0mZWxRaCvI/Tnf762aBmXmCt5yuHef7hrl/kN557fPko73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RoZlm8j/DeytgEQvUmVWYiNuWs5OV85JlICoxIeJ2U=;
 b=HjUJ/17bsXKtORqtsnP0VWBGhAcmJLbS5366dmZ4qslM0UBy2aTY2n3N9bt6wdChPJlm3jmyEVB+aB1QKXNtlp0RZ2NCkp1CtzIoSVzX8UR/rlp0+9GJh1qtZ5ZKGFaIaJ1vGNCZyGdfn4WQW7Dsm3mbGLFoXXVAiTsGF/WMeqcfPpcgg9OTWTb1lf+FsR+DO55lPXyO1mwcRe8GYT4LNuj/wuAgH3Bv4KIswt8taVkSYFDX9T4dh7EgUoUgYBwikkXBJjMpcaO14CQStozodRXmM4HtOwe5k5FqfzVlMTp7EgvbQ27mSgYyDXbwUNMnW6j0wTtm6CfEJFyVjTBZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB7788.namprd11.prod.outlook.com (2603:10b6:8:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 08:34:08 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%8]) with mapi id 15.20.6111.018; Tue, 21 Feb 2023
 08:34:08 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/1] x86/topology: fix erroneous smp_num_siblings on
 Intel Hybrid platform
Thread-Topic: [PATCH V2 1/1] x86/topology: fix erroneous smp_num_siblings on
 Intel Hybrid platform
Thread-Index: AQHZRNuJwoou/HmBw0y9tNToRhRqM67XsZ6AgAFjLwA=
Date:   Tue, 21 Feb 2023 08:34:07 +0000
Message-ID: <23112ed6f8dd1d8973b896fbd714c1499a92ffe1.camel@intel.com>
References: <20230220032856.661884-1-rui.zhang@intel.com>
         <20230220032856.661884-2-rui.zhang@intel.com>
         <Y/NYC+hjcU0NWC6p@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/NYC+hjcU0NWC6p@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB7788:EE_
x-ms-office365-filtering-correlation-id: d132db6c-f493-4055-3844-08db13e66613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1kmsuQfjTypLJDXqdMxKOBCwlBahyHYMmAdcTC6ZTceNub4MEomgqM3NPhX4OX8XVGpCWW2XG9VK0MOe80v86Xld9pRMSNi26vwSbHlDlgSfB+wbNOcZOIOMA0SvR/PhIGNsOSpyJ4uQ1XCTZCQ4NSNCxms+5OCb2EqFWl8t33DIvRN91CAhZ2igvg9VGv3qPM8U3xMKamm0N0XGu7Orh9GAQwAaOyg+1RRuMEgitvsuw9YBqwKVjAlIeg4MHaP6p5Xni41ggByD5KHs8+YNyp5J0dvWEa7fBCDRLTdUuGh7Llg16iu9snrt8WPhwfKL7g92QlQTaI1aH2lZP0jbqMqlfiKmdELaFWOVq/xaFpAbNnsW01LOCv50wvkvHDnOoIEz7f5OVDgjrhxsaqBJtuY5nLM6jqG3Ps7xjjLdql8Rp7xhvAdBQ3vyekhCT6wDkUDN2gGo8KDfHiAXoTZgwoni67HVFbIXOyjFEb7twf8rIskAqd36fdDb/ENssnsONuYtRBfigfUVPkcpWnQq3bDsWkvcMTYdci+bxuSphxXk82zwyc4QvDL+mjyw5xRg2UdM4ARMWhfkeeZNfu7SPWeo6k8RC+zqHbllzD/REyZriv28kGpgdYzlcRW+vPED+M4hRy8ZSD3EKfsa/ceNkbWyN+UoRMcJNM/du7QH97kxFpNQxwCyf3nmJwHZ4D+7jUyJjoKbeMK7PUgyhD7/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199018)(2906002)(8936002)(5660300002)(83380400001)(6512007)(26005)(2616005)(71200400001)(6506007)(36756003)(64756008)(66476007)(66946007)(38100700002)(122000001)(82960400001)(8676002)(186003)(6486002)(86362001)(38070700005)(6916009)(66446008)(478600001)(41300700001)(76116006)(66556008)(91956017)(4326008)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUM1alE1Y3hraXdWdFhRaUVkVlFvZmdCc29vcTgzd1ovclQvU2kyRjRNQU5N?=
 =?utf-8?B?UUhMT1NWQytsSDZPdElCU1hRZlIva09yL3J2bWdtVUJ0OHJoS2N1dE05WFJs?=
 =?utf-8?B?NFFDRm9xS2NOeC9JaFN6Vk5UWjU2dUM5OXZ1di9NQzBkbTBKTU9lWXBqb2Ey?=
 =?utf-8?B?bkFhREo1NnlMM1pRbm53VDRKaURqd2RkM3hDK3Z6dEdsY092dndvK1JJY3Y3?=
 =?utf-8?B?N0EzdnA0bEJSSW5DKzk5RVVDMWFwbUJ4VWRHLy9tUVpodTVnaExTWWlEVzZB?=
 =?utf-8?B?UUJ6RlpGOUR3NHBZdjkrclBzajF4dWNKYUMvZUdpMG4vUG1pdjhiTDlWUFJN?=
 =?utf-8?B?NU1PeC9zSW82a1IwNUZGQnF4d2Fwd2oxWE1nS1ZWVHpxdStTcHdVeVV6YmxD?=
 =?utf-8?B?YnRPQkVpUkRZdlBocFdhTkt3akNnK1cycEw3Y3RDS0tycUVadmprR1B3SGxL?=
 =?utf-8?B?OXU2ZExIQ3RnV0ZldHU4YVRiWTZRdC9tV0I5QUZ2Wld6eXowSVZLMWsvOWc0?=
 =?utf-8?B?OVFxM29KK2oxbW1sTHdtZ0IwdU9SZnVtaWlYOHRQdlVvaUp1K1NVUDh4ejE0?=
 =?utf-8?B?aFVvSlZ1VXBRTk14Q2c3WjBla000RlVHMFY4S25YWU5Ta1BjNExiOVQ1bXgw?=
 =?utf-8?B?VUtPQU5rS3Q0eUZtaUl4RlB0TnJwZVVoWVVjcHFtWU8vb1Z2NGhBT3ZWWldk?=
 =?utf-8?B?TGlCT0hGdlhlTllMSjlSdXI0dUx4Rm0veWpwQ1FCMWxsUTNwOFVvQ1VESlpa?=
 =?utf-8?B?d1djVWE4TVJMcWlZWWNXRWhvUGpVdjdxdi9KbktxSlhteTZHQVZpL0xMZzd1?=
 =?utf-8?B?YXVaOTM3V3lUcFR3Y0ZSMlBsSHJLSVMxQldIRENlaEJidjhSaGZIczMxTnZF?=
 =?utf-8?B?MU0rMVNjNVhtMVZLTW9wZzBpUmVUTU52WnR4SDkwbUVDMWQ0WnluWlJrOWox?=
 =?utf-8?B?R1drK3Z0clFrSTB5cjEyeS9pU3B3czlka3BKSFlHQytlVXJXOFRDbERES25E?=
 =?utf-8?B?Kzh2aHI0cTdPZmF2aUF3MTdQNlQ5NWNHTDVZUVdjdFlVK2NUK0VIK085SmR0?=
 =?utf-8?B?UHBNeTcrc0tZTDVKYnZURWsrY2g1bk52bG81TktFSk1Zc3JzQ3lNL1hKY0tw?=
 =?utf-8?B?RExZd21aTW93Y0JYQTNmZVBuWFF5d1IzdkVTRzBxbGZMOWE0QnBldVpoN0oz?=
 =?utf-8?B?cjVpMm5WdXZORFlGK1BmUVNJVVdBSDFTVGJKTkxvaTdFTDVhWjU4MzZRU2gx?=
 =?utf-8?B?QUpaYUZ6S1pNZnNZalJaUTdOY3g5M0JQa01ZMFhuWmRUMVBNOE9TTWlhSFBw?=
 =?utf-8?B?cFV0ajhFamQ1Z1FJR09JQjhQNFU3cTdTZk55WUR4eWlJVEZ5T2l0TFpmdnJ0?=
 =?utf-8?B?N3NnenVUTzdVNEpLZktnaS9iY1ZPcFdKbzZKYXQ5dWVFZXBhSnU4Qjg1NjFw?=
 =?utf-8?B?YXJQVjkwRkU0SkdkbW1UZ2hab2xkdlJsZTlQMlhzV0dsKzhkSm0vNDBKc2Ez?=
 =?utf-8?B?K1laNXNSV0IzajB2UGduVFZLVTR4aU0wM3VQNnZYRDNLSzFMeFB3OVRzUnFQ?=
 =?utf-8?B?eU1SczVtUGgrMEoxbXF3K0tOby9UT3EvNTc2YlRJTFpmWWs4RzRvWnBlVlBq?=
 =?utf-8?B?amEzd1FPRU5MQW5TR0RjUm1xQzVwSC9LMTFJdGlDWG9nRzJqVnY0a0Nka1BD?=
 =?utf-8?B?S0VsZnVLcVplNmF1Tk9mRWR4dUxZa3prengvZUpvbmdwOTdwWWVNc1ZFTTNV?=
 =?utf-8?B?THZaMHM4Qld1Wmx5elNlc1l4cEYrT09lcVZuM0I1OGFtR0VwYVptaDhaSVRh?=
 =?utf-8?B?MHVkN1NnQ2NyRUpsVHI2c3pHVzY4UmlONWpoM0NaTDF6MlcrVUt3Sy9JNHVp?=
 =?utf-8?B?RFRGWVFCaTM4UnVkK3MrTEJVb3VjRTVYTW5veDJsQ0xvMHkvVnNzWDdCU0w1?=
 =?utf-8?B?bkc0cjNOcml2Ykx1dDh0NkQ0ZW9lS29YTTY3NTd4bk9YR0xYeTZtb2VkRFVQ?=
 =?utf-8?B?aml5ZUMxOHJ1SndBOUlIQnA3UkN0Q1lDSmpOenFLZmpWOWhsQjNtVDl4amMv?=
 =?utf-8?B?RGpSaFlBdFZMejY5MzVuSVFCZnlMNWdYUzhOU1hhTkNRa21MVy95WitEOTg5?=
 =?utf-8?B?T2sxSTVaMWEzMDJYeWt1aFdzS3VxdmVKaWpSbUtDUmsxVkc3UEl5Z1VlNXJF?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B374BDD1B59B842AA573A143CF9A682@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d132db6c-f493-4055-3844-08db13e66613
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 08:34:07.8529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWcqZYezSU9o0gMOL91/oDb7SmfIvIB8/TLwpp9V9ucqcIo/VfvpmxGvY7vRhU8oPNMi78f5burYx7U8W8DBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7788
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBldGVyLA0KDQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvdG9wb2xvZ3ku
YyB8IDUgKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS90b3Bv
bG9neS5jDQo+ID4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3RvcG9sb2d5LmMNCj4gPiBpbmRleCA1
ZTg2OGI2MmE3YzQuLjAyNzA5MjVmZTAxMyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L3RvcG9sb2d5LmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3RvcG9sb2d5
LmMNCj4gPiBAQCAtNzksNyArNzksNyBAQCBpbnQgZGV0ZWN0X2V4dGVuZGVkX3RvcG9sb2d5X2Vh
cmx5KHN0cnVjdA0KPiA+IGNwdWluZm9feDg2ICpjKQ0KPiA+ICAJICogaW5pdGlhbCBhcGljIGlk
LCB3aGljaCBhbHNvIHJlcHJlc2VudHMgMzItYml0IGV4dGVuZGVkDQo+ID4geDJhcGljIGlkLg0K
PiA+ICAJICovDQo+ID4gIAljLT5pbml0aWFsX2FwaWNpZCA9IGVkeDsNCj4gPiAtCXNtcF9udW1f
c2libGluZ3MgPSBMRVZFTF9NQVhfU0lCTElOR1MoZWJ4KTsNCj4gPiArCXNtcF9udW1fc2libGlu
Z3MgPSBtYXhfdChpbnQsIHNtcF9udW1fc2libGluZ3MsDQo+ID4gTEVWRUxfTUFYX1NJQkxJTkdT
KGVieCkpOw0KPiA+ICAjZW5kaWYNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gQEAgLTEw
OSw3ICsxMDksOCBAQCBpbnQgZGV0ZWN0X2V4dGVuZGVkX3RvcG9sb2d5KHN0cnVjdCBjcHVpbmZv
X3g4Ng0KPiA+ICpjKQ0KPiA+ICAJICovDQo+ID4gIAljcHVpZF9jb3VudChsZWFmLCBTTVRfTEVW
RUwsICZlYXgsICZlYngsICZlY3gsICZlZHgpOw0KPiA+ICAJYy0+aW5pdGlhbF9hcGljaWQgPSBl
ZHg7DQo+ID4gLQljb3JlX2xldmVsX3NpYmxpbmdzID0gc21wX251bV9zaWJsaW5ncyA9DQo+ID4g
TEVWRUxfTUFYX1NJQkxJTkdTKGVieCk7DQo+ID4gKwljb3JlX2xldmVsX3NpYmxpbmdzID0gTEVW
RUxfTUFYX1NJQkxJTkdTKGVieCk7DQo+ID4gKwlzbXBfbnVtX3NpYmxpbmdzID0gbWF4X3QoaW50
LCBzbXBfbnVtX3NpYmxpbmdzLA0KPiA+IExFVkVMX01BWF9TSUJMSU5HUyhlYngpKTsNCj4gPiAg
CWNvcmVfcGx1c19tYXNrX3dpZHRoID0gaHRfbWFza193aWR0aCA9DQo+ID4gQklUU19TSElGVF9O
RVhUX0xFVkVMKGVheCk7DQo+ID4gIAlkaWVfbGV2ZWxfc2libGluZ3MgPSBMRVZFTF9NQVhfU0lC
TElOR1MoZWJ4KTsNCj4gPiAgCXBrZ19tYXNrX3dpZHRoID0gZGllX3BsdXNfbWFza193aWR0aCA9
DQo+ID4gQklUU19TSElGVF9ORVhUX0xFVkVMKGVheCk7DQo+IA0KPiBTZWVtcyBvaywgYnV0IHBl
cmhhcHMgeW91IGNhbiBzdGljayBhbiAnaW50JyBjYXN0IGluDQo+IExFVkVMX01BWF9TSUdMSU5H
UyBpbnN0ZWFkIGFuZCB3cml0ZSBhIHNpbXBsZXIgbWF4KCkgLS0gYW5kL29yDQo+IGNvbnZlcnQN
Cj4gc210X251bV9zaWJsaW5ncyB0byB1bnNpZ25lZCBpbnQuDQo+IA0KeWVhaCwgaXQgaXMgZG9h
YmxlLiBJJ2QgcHJlZmVyIHRvIHVzZSB0aGUgY3VycmVudCB2ZXJzaW9uIHRvIGtlZXAgdGhpcw0K
Zml4IHNpbXBsZXIgaWYgeW91IGRvbid0IG1pbmQuDQoNCj4gUmVnYXJkbGVzcywNCj4gDQo+IEFj
a2VkLWJ5OiBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCg0K
VGhhbmtzIGZvciB5b3VyIEFDSy4NCg0KLXJ1aQ0KDQoNCg==
