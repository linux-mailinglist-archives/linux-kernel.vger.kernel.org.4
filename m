Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE162D29C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiKQFUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKQFUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:20:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E101DF2D;
        Wed, 16 Nov 2022 21:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668662411; x=1700198411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pqaMrzBUPsmMAX6GxVmj2/3TQV/qVeCFuZadKXU7DAo=;
  b=gjQvOaEt2ppQWKQ+jlhULaJqz+5lAHy4mBHGnUaile9XG/rVQmLtrtvD
   Zb/CDnLgCrMRQtT08y7ZhVGJhQq0G47k/U9OSjxlXvMGJlqDPQfWC7+bL
   ffTNgPg47bTXmGi46yXeqLFsheGUOVNWXS6uQ3WfCA7b+VgPF037T+Tyu
   hV3mqJVLXPpAgGGwPgHfg9W2aTaCnTJKBDvEIWKAyJhA7ZCGYTmhUyg2z
   5Ta5t5xXUua+nwhONaiG3ub1atMVC5o4aM6Gcrr3kYf4KKcr7jvkGGtLZ
   nmxfqc9gH/Jdn9VLkGW9joalOYeeXLrvTmKbC0VGUzBOmEgOKhMm928o+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296124194"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="296124194"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 21:20:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="639657721"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="639657721"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 16 Nov 2022 21:20:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 21:20:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 21:20:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 21:20:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV9gEmST9d8aC8H3mWyDLXRQJj9XiQMQnPqpc+kuVBLEPcE2UkiyytY/tUuD2tBdBvypTp1Nd1H3rG3/qGJyNK4x0DgBXVUzLm0MRx7jtJmAbqffoLhQjTfbMugQ/MnUgt097t0wwUgamYWvgMJUaE5XbrY9Wdw5TiYlGjoajkqV5j+n1Pvr53h0rpnJDLCxdKIBcfN8Sc2/I1h4zPbI7FirqxkROt4KxKSor4I5VUSuztaIcerW90SjA460HTiA+tyXkkB1sg9frLGchgPFeXWxUxPsqe0gTonauB8Rgz3O1PAWPu8jgTduPVnGRS2LOEu/RBservxLT154oBliAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqaMrzBUPsmMAX6GxVmj2/3TQV/qVeCFuZadKXU7DAo=;
 b=IB/cxw8OdqkoAHXpnxZW3qhQa+Y6t9/PyjCJqzghKB9cpjo0Hi0iOLJPdyYC166AUlSJZfzdTT45sRoSrYiRaZk+HBjmIqntJiIfkwUSfzhpSM5gjlFBmgRNYyYsIGJJYFMUYBujFJ9PklqCig94Gs06ipgRN+iEqzJmuz/ThVP2FPKBeuMnsT5N8ldu6BlZAOGtylSgb+kFq7bv7519uHdjjhQKSzKTRKOS+jat/+0KZOZ4yHVPn4L7jnq8wLSe4QfI6K2yXcOtUFumeYEUUcXuGal/SF53DqGs4Z91Ir7HYYOA/d+reSRBuY+gA3YbEkgPXrtVXMGme4/xU0RzNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB5629.namprd11.prod.outlook.com (2603:10b6:a03:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 05:20:06 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 05:20:06 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Make vmalloc_dump_obj() call in a preemptible
 context
Thread-Topic: [PATCH] rcu: Make vmalloc_dump_obj() call in a preemptible
 context
Thread-Index: AQHY+cU0eV754NRDJEa+ClyLZjedI65CWFyAgAA5J3A=
Date:   Thu, 17 Nov 2022 05:20:06 +0000
Message-ID: <PH0PR11MB5880515EC312E9BA1FCF6A28DA069@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221116141511.3695680-1-qiang1.zhang@intel.com>
 <bbcb265f-0731-47c7-3a04-976504b95915@huawei.com>
In-Reply-To: <bbcb265f-0731-47c7-3a04-976504b95915@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SJ0PR11MB5629:EE_
x-ms-office365-filtering-correlation-id: d8866eea-6c83-4f7d-e349-08dac85b63a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7bXNGeVdhjWg7IO5g3k5bMyn2VcGbTas6EqCrrEOMyl/4gh0xHIJp7j5THDn1u4mb1l9Zzzw73jud+w7DqxrpBLa1AngTzhttZizRPlGvU+Q1ZOFQ/NYlAFl9azdVMPFzp7l8lXf3OswUjajthW1kYpbhuwUchKn0Xuh0ENtu6F58jo9L6XHKSijvU81s+VBcj1xOmx9VHlnS22aHtcmB8TB62KKYkxWogFNC74oZvbM83dKY6VROFzgyYi5U0IrWp3zJorDtrgorhOc4CCHema/OtMaVfDvW2+UJmeN9PDfxefUj2bnrpo4bg8gfkYq9Kr10abp3tG5ntEZa8yDGFxhy+YU2eQq6wkROLuEt6pOvEkyFA+9r/zlxaFrP2WplZSLcPIaMBav1l4UMekAtiXjmvkr6Z3sZfBZrVq9ERtu8IPIVTs/5ITr+LhgnoGkfqwSnvgtZ+SDqtVwh93+BPCdtrW8pBX0rk/3OMfHRzcZNG1WPR8/2QMzzZA+RSI66gq2rH5+/dms1cBjdfRNiOVIE2dppyUrrMBq22QdUvXMRtCn4s0gb1jAGEGxKhH81ijVBB9b3z0mdkInRRsKtQDbWyJi+awZORkeD/qbVJ95LOZ2Ik06zXl7JEMU7QVeF7NtWLaaA+owHAUA/aLkFxR0dQr4IKqn+xZMkoTQrtJ+lemKyCPKPQ814S3l/DK1FYKlThsRzDD8moqZjAlug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(26005)(86362001)(38070700005)(38100700002)(82960400001)(122000001)(33656002)(186003)(110136005)(2906002)(9686003)(53546011)(6506007)(52536014)(5660300002)(8936002)(83380400001)(478600001)(55016003)(41300700001)(71200400001)(7696005)(54906003)(4326008)(76116006)(316002)(66556008)(66946007)(8676002)(66446008)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjVMaWVLcURkUHZqd0l4VWlRZGZra0taenk5ZGxJcmpXYXQ4V3hoYWc0Z1Zu?=
 =?utf-8?B?eXFEY2U3NnJLdjV1WWZYdFBjbjRwZWNOalZYR09tMGdQbFdkWEVwd3ZZZHk2?=
 =?utf-8?B?cENoV0M1UmY5RGJpNlRESURTRzgzNDBIb285b3RlR3JIWnY2Ujh6S1RndHRG?=
 =?utf-8?B?SEJ6RjNrbDY1TXlxRHFQZmljbmJ3STQ1cEJkbVdjUzhaQ3dSckIvZHhJc2NS?=
 =?utf-8?B?Y2NzMmt3S3pWOHBhOWZsVWlWUkxtcm5aZHJmdXpZQm82Q01GQ2phMkNCdnJI?=
 =?utf-8?B?RUVpODcwYkg3QktTVUMrWTdpUDU1d3V6ZmxlS1YrTlB5eWZkcTZiS21sdkNO?=
 =?utf-8?B?SFJMdU9tUHoydGRnL1pRTGRHdytwa3drV2tDZGxGN3lWMXkrOHI0dElaMHEw?=
 =?utf-8?B?UWlwVXhyemVUb24wZ3pCd0lGQnRhN3VrTDUyQlFOZm9ZZjJlV2dMYzIrY1Z6?=
 =?utf-8?B?TytXMk1LWlZ6V3ExcWtzMGZsUFVGRVNvb0gxWWV5Z0pKWU1GUFNuamZIUzFO?=
 =?utf-8?B?Y1VmWmtjNWFOcnQ4YUFIQXN0R2k2UVZKQXpIcnhLMGowWHVJMXFGRVJidUx2?=
 =?utf-8?B?U1hwbjNMMC9pU0hvUk5qdjJWSjM3Y3lhL01WbzB3aWgrMVZJTjRSSFlqMGNU?=
 =?utf-8?B?K1JTcHNDWEpHMzE1WlB5ZnpzUXJic0NhWWh0bkIza2QvRFBrWko3ZjR0Y20y?=
 =?utf-8?B?SXZJWEI4OVpUWXJwd1czYTZUbHVUdWVpQjh6ZTRSTXFhc3hNdnFrTXZCRGJC?=
 =?utf-8?B?eGdkRlVZbWNJcCs5L0h6Z0drbVpoTDAxeW5FbU1DUVlkT1FpR054Z0VydkNU?=
 =?utf-8?B?N3VHWkk1a0xGWHlkY2U4WmlIL1dQZnhGK1NybjNpTXlNK3c5aTlYRmpRNVl1?=
 =?utf-8?B?bElHNTc3Mm9FSlovdG9NSkhXczJaUE1GRVdxdDFBU0tXVVArTUdJamVYUUNa?=
 =?utf-8?B?eFd2cHlMbHJRZktDeDlmWHlKR3hVTGd0ZVJOQjFpWGpnL2Yza0JEUGpETmZB?=
 =?utf-8?B?ckhuSk94OTV5MHh3bE1FTDZpZ01CMlBGd1dKN0RjbUVOOG54NFEyRWtUZWFt?=
 =?utf-8?B?empFdFF2dnZYbjZLMzlxbndJL0FOR0t4K3VJd3ZzUFA4ZktKT2lQT0lCaTJs?=
 =?utf-8?B?UFZCNTMxbHdodFp3Rk1OMTg1WWdsS3c3VTJTbEZLcjdPbHNTZFdoTnU2N3Zs?=
 =?utf-8?B?WTA4am0vZDN6N0NZVWdyKysxZm8yS2lsVUtIUEZ0OUt5YUtVdml4MTNDSndl?=
 =?utf-8?B?bTFwMUFMM3VyOVFOQWVCUHpLYWRMNWpjTG1XMi9ON1d3WnlUZDlRd3BKTHZI?=
 =?utf-8?B?dnJNS1JBUC9sQnRjNzNyRy9CNXdidlFVSnZWRjNaeXlqRlZCWExlMXduWnlE?=
 =?utf-8?B?QjJmbzI3VWFtN050UGZiOVA4cmltQmRSbUdvRzhVWGczVlBrZG9icGVlSTJP?=
 =?utf-8?B?UFhZWGJxaUtxYjF2U0d1WVZweVkva0JNTlZNMlhnanlEcTNpTzlsVTdjY2FJ?=
 =?utf-8?B?dk1VUGl6NEM4M2RxKzVTZWd6azA1THdwaWhUeGFYdWJCdVVCVlZLdC9FS2wv?=
 =?utf-8?B?UGp2ODlobmxvSGpMR2VIdkxoRTExeEEvK0hkZXc2ZnptVFNaL2R5QnVQVFNh?=
 =?utf-8?B?OVp0L1Uwc1hVZ1Z1TGtWNDVpODQ1SmJJSmhFWXBjY3BnT250NlhqMlk5US94?=
 =?utf-8?B?cHZJRk9VMDhXS1JOUW5SSnNBenhoMWkrbFl3YXRjZTJHK2pjMjVDTzMyaHJz?=
 =?utf-8?B?OEo3RGxhRUhMaXhKRFBxTVNxaWJudW05K3FHUnV4Z252K0ZuOW5TSWxRSTRV?=
 =?utf-8?B?emZNY3pIZ1p6VFpRNEdMVkRMSDRBM2lSVzhlUGlScURPVGlhVFg5dlFyTFRs?=
 =?utf-8?B?UXQzMHRXSjJZRGQ3L3VZeFQ3TS95cVZMVDI2VEx5d25qd3J4WGh1U2VWeW1T?=
 =?utf-8?B?TUN1Ull6ZFpaMVZEekRzaW9DRVVOdERoR05xTVQ4LzEwbHhaaGVaellub1Mz?=
 =?utf-8?B?UnV6dlJ5L0lvVGRDUlYrV3h6c3h0eTlVZkdlNHhKL2ZhekE4bzVRQTBFaVIy?=
 =?utf-8?B?YStDblh4UnRCajd0VHBrQkxLM3RtVHJGWDV2bUxjY2tSK2dlOUhCUURlYmJZ?=
 =?utf-8?Q?Fj1L8VZkINC6isuOxdGyyN+pQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8866eea-6c83-4f7d-e349-08dac85b63a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 05:20:06.5585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riRxvlCQ8TAE47MDSWbhOkeqWgENjMkzgZAutzvFC5YXv/f79U00hxY7OMFsgyFgvNMSD1bzbJ330PT9PpU13A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5629
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwMjIvMTEvMTYgMjI6MTUsIFpxaWFuZyB3cm90ZToNCj4gQ3VycmVudGx5LCB0aGUg
bWVtX2R1bXBfb2JqKCkgaXMgaW52b2tlZCBpbiBjYWxsX3JjdSgpLCB0aGUNCj4NCj5QbGFuIHRv
IGNhbGwgbWVtX2R1bXBfb2JqKCkgaW4gcmN1X2RvX2JhdGNoKCkuDQo+DQo+IGNhbGxfcmN1KCkg
aXMgbWF5YmUgaW52b2tlZCBpbiBub24tcHJlZW1wdGl2ZSBjb2RlIHNlZ21lbnQsDQo+IGZvciBv
YmplY3QgYWxsb2NhdGVkIGZyb20gdm1hbGxvYygpLCB0aGUgZm9sbG93aW5nIHNjZW5hcmlvcw0K
PiBtYXkgb2NjdXI6DQo+IA0KPiAJQ1BVIDANCj4gdGFza3MgY29udGV4dA0KPiAgICBzcGluX2xv
Y2soJnZtYXBfYXJlYV9sb2NrKQ0KPiAgICAgICAgICAgSW50ZXJydXB0IGNvbnRleHQNCj4gCSAg
ICAgIGNhbGxfcmN1KCkNCj4gCQltZW1fZHVtcF9vYmoNCj4gICAgICAgICAgICAgICAgICAgdm1h
bGxvY19kdW1wX29iag0KPiAgICAgICAgICAgICAgICAgICAgIHNwaW5fbG9jaygmdm1hcF9hcmVh
X2xvY2spIDwtLWRlYWRsb2NrDQo+IA0KPiBhbmQgZm9yIFBSRUVNUFQtUlQga2VybmVsLCB0aGUg
c3BpbmxvY2sgd2lsbCBjb252ZXJ0IHRvIHNsZWVwYWJsZQ0KPiBsb2NrLCBpdCBhbHNvIG1ha2Ug
dm1hcF9hcmVhX2xvY2sgc3BpbmxvY2sgY2FuIG5vdCBhY3F1aXJlIGluDQo+IG5vbi1wcmVlbXB0
aXZlIGNvZGUgc2VnbWVudC4gdGhlcmVmb3JlLCB0aGlzIGNvbW1pdCBtYWtlIHRoZQ0KPiB2bWFs
bG9jX2R1bXBfb2JqKCkgY2FsbCBpbiBhIHByZWVtcHRpYmxlIGNvbnRleHQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+IC0tLQ0KPiAgbW0v
dXRpbC5jIHwgMTAgKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS91dGlsLmMgYi9tbS91dGls
LmMNCj4gaW5kZXggMTI5ODRlNzY3NjdlLi40NjVmOGI4ODI0Y2EgMTAwNjQ0DQo+IC0tLSBhL21t
L3V0aWwuYw0KPiArKysgYi9tbS91dGlsLmMNCj4gQEAgLTExMjQsOCArMTEyNCwxMiBAQCB2b2lk
IG1lbV9kdW1wX29iaih2b2lkICpvYmplY3QpDQo+ICAJCXJldHVybjsNCj4gIAl9DQo+ICANCj4g
LQlpZiAodm1hbGxvY19kdW1wX29iaihvYmplY3QpKQ0KPiAtCQlyZXR1cm47DQo+ICsJaWYgKGlz
X3ZtYWxsb2NfYWRkcihvYmplY3QpKSB7DQo+ICsJCWlmIChwcmVlbXB0aWJsZSgpICYmIHZtYWxs
b2NfZHVtcF9vYmoob2JqZWN0KSkNCj4NCj5wcmVlbXB0aWJsZSgpIC0tPiAhaW5faW50ZXJydXB0
KCk/DQoNCkhpIExlaXpoZW4gDQoNCiFpbl9pbnRlcnJ1cHQoKSAgbm90IGluY2x1ZGUgZm9sbG93
aW5nIHNjZW5hcmlvOg0KDQp0YXNrIGNvbnRleHQ6DQoNCmxvY2FsX2lycV9zYXZlKCkgb3IgcHJl
ZW1wdF9kaXNhYmxlKCk7DQpjYWxsX3JjdSgpDQogICAgICBtZW1fZHVtcF9vYmooKQ0KCXZtYWxs
b2NfZHVtcF9vYmooKQ0KCQlzcGluX2xvY2soJnZtYXBfYXJlYV9sb2NrKQ0KbG9jYWxfaXJxX3Jl
c3RvcmUoKSBvciBwcmVlbXB0X2RlbmFibGUoKTsNCg0KZm9yIFBSRUVNUFQtUlQga2VybmVsLCBz
cGlubG9jayB3aWxsIGNvbnZlcnQgdG8gc2xlZXBhYmxlIGxvY2suDQoNCj4NCj4gKwkJCXJldHVy
bjsNCj4gKwkJdHlwZSA9ICJ2bWFsbG9jIG1lbW9yeSI7DQo+ICsJCWdvdG8gZW5kOw0KPiArCX0N
Cj4NCj5Nb3ZlIGludG8gdm1hbGxvY19kdW1wX29iaigpPw0KDQp5b3UgbWVhbiBtb3ZlIHByZWVt
cHRpYmxlKCkgaW50byB2bWFsbG9jX2R1bXBfb2JqKCk/DQoNClRoYW5rcw0KWnFpYW5nDQoNCj4N
Cj4gIA0KPiAgCWlmICh2aXJ0X2FkZHJfdmFsaWQob2JqZWN0KSkNCj4gIAkJdHlwZSA9ICJub24t
c2xhYi92bWFsbG9jIG1lbW9yeSI7DQo+IEBAIC0xMTM1LDcgKzExMzksNyBAQCB2b2lkIG1lbV9k
dW1wX29iaih2b2lkICpvYmplY3QpDQo+ICAJCXR5cGUgPSAiemVyby1zaXplIHBvaW50ZXIiOw0K
PiAgCWVsc2UNCj4gIAkJdHlwZSA9ICJub24tcGFnZWQgbWVtb3J5IjsNCj4gLQ0KPiArZW5kOg0K
PiAgCXByX2NvbnQoIiAlc1xuIiwgdHlwZSk7DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTCht
ZW1fZHVtcF9vYmopOw0KPiANCg0KLS0gDQpSZWdhcmRzLA0KICBaaGVuIExlaQ0K
