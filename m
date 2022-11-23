Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ABD63689C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbiKWSVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbiKWSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:21:41 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951B8B36;
        Wed, 23 Nov 2022 10:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669227700; x=1700763700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZY7k3rIK9dY6lW+/9r/DjYYQxNFzS3O0VAHG25fC+Zo=;
  b=fJbE1zV6UdgejwkScRvDziBbfyuWBmzOVsmUHxAtKGY5O7/5M1EmXUZ0
   cGqT6SIIb+44Ig7RwYxaf18xz+KlniYeogYf3f6DcKP6IqPbU2wXXCL53
   jawAG6l+VTxNv9HFTT02XwUenovytR/5/EqjAMuB4zzcnWpbM66qQRICc
   gcfoZHfUH+lMSomJ56DrrJWv3Oq0MzokzRff9i636GzFk7sfb4o7rOUs8
   PeuYb097lnHwlpImgtNak7Nuf8xyOOynxnUXEWTkT4ykFiuCUGbWGKfTw
   6sjTD35rsPzQnVDl/7usxACQ2Ab4Y2RW1DUZX5UAbhuZQlJKubhURMtfV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="376276003"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="376276003"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 10:21:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="710683159"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="710683159"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 23 Nov 2022 10:21:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 10:21:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 10:21:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 10:21:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNG4rq4eDu6tlC5OOGHOQ+TLQaiyilQQe6WL1bEU+zL/oyk2rfn01SJtgEzuVNFkU99E1rr3AphUrk3K50SUktjPfLNKuNkfufIqwh1utXTWYBJXuy4FhZt3HMI6MhiBdv7e6/HDkYgnR7STMxIznUOZpa7diQfxoqMNPx1JIAC2y5V1ttlCjlgdoH1GX4WHU9n1nMpajotjMHySLkP4Q48FyIyNLCpqvF553gNfPZAxVxFzCAAzfLfNKX/XkVsBafntMoCquusW2RUgQlElC3Yu1U2RgCaEBHOE5iXevM8aV4nsoBdSaaFSXutD/VXpbj8ApV/8LKutfigKFhaUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZY7k3rIK9dY6lW+/9r/DjYYQxNFzS3O0VAHG25fC+Zo=;
 b=ZgzzPUxncOGz5iu2HhpVNS7UtlllnwlmOSPbKBie+P8c6NkuMjNMr7znNchT1sT7gewz4kUKgGAaIUuMC9qIAmYr0Ubp3qboZbyha+YhVWrbnZbhsyBUY0yp3F0W7hD0amdRe8+f5mBhvUIGG73rWEBuW7N601yeXrHcRz9yaSChOx8nkCJBtLuUNVp3WDchW3NeltR1G2FOkuW21kzDEuSQL2bFCS78aQ6I9kwyugxOJ4vf/h+mVpwlZ0LEaBI1cSbVdS52ZvQmExsyUwLexyw0nX4rby16ZtYIpz+FbwuEwZvniivyCSGp3/hnrhH9RQY5q3gH16IOzaPpEQWkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CY5PR11MB6090.namprd11.prod.outlook.com (2603:10b6:930:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 18:21:33 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%7]) with mapi id 15.20.5813.018; Wed, 23 Nov 2022
 18:21:33 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: RE: [PATCH v8 01/13] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Thread-Topic: [PATCH v8 01/13] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Thread-Index: AQHY8IgTVD5xZFf8fkCX/bf611jqJq5M7vJg
Date:   Wed, 23 Nov 2022 18:21:33 +0000
Message-ID: <IA1PR11MB609710A586D7688E6D178EF69B0C9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759199632.3281208.5709918293488898752.stgit@bmoger-ubuntu>
In-Reply-To: <166759199632.3281208.5709918293488898752.stgit@bmoger-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|CY5PR11MB6090:EE_
x-ms-office365-filtering-correlation-id: 8ff315e1-6055-4dc6-2225-08dacd7f8cef
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 51d1qv6ejCfJRXD4TyzAjhTwQuKxKgqdbTr0MlQmbPfvUqphGP6c+mgW4S9lB6dM+icsaFJWAbKZo6WQ2xP9IcQXCr6Pbs39VLcFHTuVz9DDl24AerHUFgHPy31inl463tVnIhB842thxE5Bw0G+Dpo1noIpyc4oXGu7cXeq0y7C+Ww1WiOMf0RU/1G4AD4tc1yt/QTDNx9B8EpgMpWg8goHMIxnau4fMnBiRRrtAQEc9DJ24nyTrCNRQuCivs+RfqazXoIH9/mEubUHlaj8Oh6sdb43g1enPqPOa3YtMkc3c0dGgLG9t1Ad5YuuV36xN1G4AImGgsMRbOKuGUa50xgQzV+Fmq9MN2DUBi5ICIdiJNG+zwrOY4dYN17q4cuLp5KFYD2U4kpdVBfQokAxL54mgk7lMjIatp+GSOeFUQ0Ub8R7G2jZ+JFPxptOmnOWkObW6UV0VLix0gwUmYdjx2OKDQrOgREpqTUlj4PFY15Gm+cgeQxh+6rAapX0aoKvU099G1ljyxnrOcU9xkj+3gJtmBWNoAunYKuV2lrHHFQwY/gSedgHG4Ksq5wOBr/L0bbCObq380mbhHWfuP5pP06YWekzigDPkWkbGxhgjUjOMT+DghvbPew8GsflxijKcmyxFDT99AoYUqLNCxykPnfee5CKX10cB9Wo6sVtPjHEgskqGtAii5rv6TtWeNYnds4IZCTUUIERLz99cTvUIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(55016003)(76116006)(54906003)(110136005)(66946007)(86362001)(316002)(71200400001)(8676002)(122000001)(4326008)(64756008)(66476007)(66556008)(66446008)(38100700002)(478600001)(38070700005)(186003)(5660300002)(9686003)(7416002)(6506007)(41300700001)(52536014)(7696005)(33656002)(82960400001)(2906002)(26005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUVqQVQyamdkUjRwRDlHblRYU0Q2ZllRbW0vNkFlTFB0YWhXNDV3c0Q0ODB0?=
 =?utf-8?B?MEF5ZzdxeGRmSWJxMGZGa2RxZm83bSt6U0tiVkJHWWJLRHFIQlhiYnB1TDRG?=
 =?utf-8?B?VmxmaHFyMUhMNndWZFZzM0JNOGk0YW9Xdngvc0VvZWZ6MzZ1ODF4aStSUC9x?=
 =?utf-8?B?OG5JMFh3VEwzaGJ3bXhwbHlPY216MUpzUllkMFlVS1lCbmZ5aU9qNXUzMUVL?=
 =?utf-8?B?ZFhGWEFRdE0ySWxWZ0xHalIrSE9oNmJZQ3ZldC9wSGxUNVN3Yk5vWS9Ka3NP?=
 =?utf-8?B?VmhqN3NoUHp5czJvUWp3a3VDNTBkMVZrb01QU0tWdUNoN3lYc1ZFdk5JNFFI?=
 =?utf-8?B?emlIYXBxZndaZ21KVENDRFVSdkd3ZHZDTFJnYjRwalZGdkZGWXdLVlhRTlN0?=
 =?utf-8?B?bWNYNkNibkIyMFpKSEc3TW03Ty9TNXNWbzhhNzJHcDh1ei92enFVMDM1ZDk5?=
 =?utf-8?B?S3BmUEZjM0JpZTdqbVYwRkxCeGMweWVRSTcyNjNnS0NSK2hlZlByaVBKM1ZC?=
 =?utf-8?B?RXpvRmdpbnpkV2V2SjhweHhMUmVGMEhsYnU0MzR1b2lVVHBjYXRxZTdRVThV?=
 =?utf-8?B?QkNJYVVkckM1SjVpYk1hMXdkSWZ3a204c2tlbGhIWjdJVnFXVGNsUnJ5UXBs?=
 =?utf-8?B?NWg0V2p1emtRNDRqcU4ybW0yUm8wSWRMREptcGM2K2JReHd6cWpFZkdxTmh6?=
 =?utf-8?B?VzZab3ljTzlQcHIySWJIWWlOOC9saERLRHQwMUF3ME54LzBaS0lxRVNKZ0NH?=
 =?utf-8?B?WFViQzl6NGx4TXZDcVdrU2M5dThvYzNJS2hja1JHYXJ5NDZUUUtNN1ZqQkNW?=
 =?utf-8?B?UmI5MW5qeGo4VVFvN0lnNGgvRUMrTGk2Sk90OUV2RHBIaXZodDIySkNiZVd1?=
 =?utf-8?B?emF0NDdIUU83ZlhZU0QxUTYwdmtqaEdqcXFLMEY4VGRjakNLQU5DRkRwZks4?=
 =?utf-8?B?QThzTW05R2p0UnlkaVpKNHBwamh0Qzdra1BWMWEyc2tJWEkvbi9vdW9ySkgx?=
 =?utf-8?B?SmNLZjNDc1d2NGhUcVBxajhHV1dpa0IyS3RsKzhBekR2TXdheHBaQmc4UzZS?=
 =?utf-8?B?VzJhc1pRcTFmVktVaTY5N29tekd3MTJCeTV1T2dzZjB6bENGMWJjeUVGUFU3?=
 =?utf-8?B?MlhkampZcjc0eEVhTWtUVlpwd3p5ZVMxNnR1SkZhZm1pdkJ2ZUEwbXhyVE5x?=
 =?utf-8?B?ekFSbUpUclp0bkFmaTQ4NW1kR1BkVnYxeWN3cUVkS0Y5QVNCTXBXdnZZbHgw?=
 =?utf-8?B?QU5KbzNIUFBEeHd2bVIxUXh6QUtMc3N3YXVGdlh1b0V3ME8zeDFrN0l2bVBt?=
 =?utf-8?B?cm9BTGVDWnFFUHoxNGFpK3lpN2FsVElyTU92djRyRk5PU2VoR3VKV0tzTEI1?=
 =?utf-8?B?NmlweHJHeEIzZlhSUFNsWWd2RmkzL3IrYTdLS0hVU0NLZk1ZNXNTbnJ6RkxC?=
 =?utf-8?B?WkppSTZzRjVOS0hZWFM3ZEtROHFVdFRseXVvcXBaeksrSVV5MnNqUXYxR2VE?=
 =?utf-8?B?RVBMaU43TzdzVXl4WXFrOGcwRGJRY2RuUFNnemxjRG8xdEZObVY3VDhNSEVa?=
 =?utf-8?B?enlmOUZIYmxqM29qa21EL3M5cXhjTDFIZjd2QWpKYmYzRlRVU2dZYWY2ZXM4?=
 =?utf-8?B?WUl6VTRPT1IzMUR5Uk9OUDlxWmZnRGhQY0dCK0ZBVWJVdFZwdXF2dXlPbk52?=
 =?utf-8?B?WGdoVk5NNmpHSTFvcEYzRHMwbTNtZCtvMWlnVUZmdENLSjlYbFRsOVljUFMr?=
 =?utf-8?B?cmdoaHduSFg5NGlFdDFiV0lraWZ1VzIrY0lpY0Z3aXRCUVRjb0c5MDhoZ0Np?=
 =?utf-8?B?UlJSc005ZCtseFF2SE04ZDBlZzdoOUZTaUZkZ056NEYySWQyTkpORW1LeUVY?=
 =?utf-8?B?OGtGTzhyV010cm5WM01Bd0kxU2hNcFVMU25QS1p3bGpLdzZqK0I0VGQzbHhB?=
 =?utf-8?B?R3JMSy92Y3NMNjhLTWc5c2h6WmRhTGthSkxoNVZCOU9WS2xDVndRUUN4bEZk?=
 =?utf-8?B?Si80TVFWaTQ1ZG5ZREdYcCtGQjF1QW5yWm5VM3FQenh3emF0ZzFyTThKOXRT?=
 =?utf-8?B?SGk3a0Y5Z0NIckk4TFpJQXR4V1FtZ3UxWmdndUI0WUNCcDhVZmdoampveHUw?=
 =?utf-8?Q?/s63ihpN9DA18Qcj/QiiNdYb5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff315e1-6055-4dc6-2225-08dacd7f8cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 18:21:33.5213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOvfRKCKxiv+Wi2zHZ46GceR2QPiekdnN2KwtZ0PcWzZjLG4yOnu9nLSPZtzM+LByZ8m6H1u6uSOmQs3TmVU9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJhYnUsDQoNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1
cmVzLmgNCj4gYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlcy5oDQo+IGluZGV4IGFl
ZmQwODE2YTMzMy4uZDY4YjRjOWMxODFkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9jcHVmZWF0dXJlcy5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1
cmVzLmgNCj4gQEAgLTMwNSw2ICszMDUsNyBAQA0KPiAgI2RlZmluZSBYODZfRkVBVFVSRV9VU0Vf
SUJQQl9GVwkJKDExKjMyKzE2KSAvKiAiIiBVc2UgSUJQQg0KPiBkdXJpbmcgcnVudGltZSBmaXJt
d2FyZSBjYWxscyAqLw0KPiAgI2RlZmluZSBYODZfRkVBVFVSRV9SU0JfVk1FWElUX0xJVEUJKDEx
KjMyKzE3KSAvKiAiIiBGaWxsIFJTQiBvbiBWTQ0KPiBleGl0IHdoZW4gRUlCUlMgaXMgZW5hYmxl
ZCAqLw0KPiAgI2RlZmluZSBYODZfRkVBVFVSRV9DQUxMX0RFUFRICQkoMTEqMzIrMTgpIC8qICIi
IENhbGwgZGVwdGgNCj4gdHJhY2tpbmcgZm9yIFJTQiBzdHVmZmluZyAqLw0KPiArI2RlZmluZSBY
ODZfRkVBVFVSRV9TTUJBCQkoMTEqMzIrMTkpIC8qIFNsb3cgTWVtb3J5DQo+IEJhbmR3aWR0aCBB
bGxvY2F0aW9uICovDQo+IA0KPiAgLyogSW50ZWwtZGVmaW5lZCBDUFUgZmVhdHVyZXMsIENQVUlE
IGxldmVsIDB4MDAwMDAwMDc6MSAoRUFYKSwgd29yZCAxMiAqLw0KPiAgI2RlZmluZSBYODZfRkVB
VFVSRV9BVlhfVk5OSQkJKDEyKjMyKyA0KSAvKiBBVlggVk5OSQ0KPiBpbnN0cnVjdGlvbnMgKi8N
Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2NhdHRlcmVkLmMgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3NjYXR0ZXJlZC5jDQo+IGluZGV4IGZjMDFmODFmNmUyYS4uNWE1ZjE3ZWQ2
OWEyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NjYXR0ZXJlZC5jDQo+ICsr
KyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2NhdHRlcmVkLmMNCj4gQEAgLTQ0LDYgKzQ0LDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBjcHVpZF9iaXQgY3B1aWRfYml0c1tdID0gew0KPiAgCXsgWDg2
X0ZFQVRVUkVfQ1BCLAkJQ1BVSURfRURYLCAgOSwgMHg4MDAwMDAwNywgMCB9LA0KPiAgCXsgWDg2
X0ZFQVRVUkVfUFJPQ19GRUVEQkFDSywgICAgQ1BVSURfRURYLCAxMSwgMHg4MDAwMDAwNywgMCB9
LA0KPiAgCXsgWDg2X0ZFQVRVUkVfTUJBLAkJQ1BVSURfRUJYLCAgNiwgMHg4MDAwMDAwOCwgMCB9
LA0KPiArCXsgWDg2X0ZFQVRVUkVfU01CQSwJCUNQVUlEX0VCWCwgIDIsIDB4ODAwMDAwMjAsIDAg
fSwNCj4gIAl7IFg4Nl9GRUFUVVJFX1BFUkZNT05fVjIsCUNQVUlEX0VBWCwgIDAsIDB4ODAwMDAw
MjIsIDAgfSwNCj4gIAl7IFg4Nl9GRUFUVVJFX0FNRF9MQlJfVjIsCUNQVUlEX0VBWCwgIDEsIDB4
ODAwMDAwMjIsIDAgfSwNCj4gIAl7IDAsIDAsIDAsIDAsIDAgfQ0KPiANCg0KU2hvdWxkbid0IFg4
Nl9GRUFUVVJFX1NNQkEgZGVwZW5kIG9uIFg4Nl9GRUFUVVJFX01CQT8gTmVlZCB0byBhZGQgdGhl
DQpkZXBlbmRlbmN5IGluIGNwdWlkLWRlcHMuYw0KDQpUaGFua3MuDQoNCi1GZW5naHVhDQo=
