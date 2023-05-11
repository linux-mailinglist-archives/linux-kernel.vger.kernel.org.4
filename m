Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400356FEC37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbjEKHDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbjEKHCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:02:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EBE7EFB;
        Thu, 11 May 2023 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683788547; x=1715324547;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o2m8dqERer3jxB8g6qh/Nxwkte+feOdgGFyh4HkuM8c=;
  b=ZiUaS2y03z6HlPZa/SDDmxErwnzDiiGATlkIeZ5bQcCPg+Z0bdgTrXY5
   LcjplGlZD3PE4M16qD6p3fsaEbB2f0+YTEoWW4E4eiDO6JaT/NSDZXvxX
   kPBNI+P6NJfBsJnACvykLfvctwuwdhywUVM05oB4bs6HceR2cnPVwtqgM
   nRiCJkeh0xfbMcvhLxVezzowe2Mjn9vsg4qj3ra2K0hxuKgokMUEQJhUG
   90fSFionK5UjLxjmT0G4jtVSKxMV7XoSy81+eSJ7jyQoYWkP3ybcxOoy3
   sBNipQSHFAbjyN4+ZDeoCMfqxcTfzkPXLbDVf0KfSlPlYNZumDo54I8Aq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="416008432"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="416008432"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 00:02:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="764611623"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="764611623"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 11 May 2023 00:02:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 00:02:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 00:02:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 00:02:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu9m/ZYEhJLRbwr5J24eJj6aZYRr0S08BrFuujD0u5YGztwFHrjDleuEDY/lm9HzkVj2WiSLc5viif/v5LcWLQ+Dky7ELaM7GjbvKgYo/yZUuffiR2mEo1lvBHN32YbfSQKsDAxMLFCoint5ywiRYgZQBwYUyUeXrSR+YGDpMcr2LkneZ+uOHmlQFs4tkcrSzk5RDSNzlfQ9OrgB15+3uujQaEYm8v5TQGPjthuLTdHeFMYKc3MQ7EzRkkVV+HBH9JwY12+LUuppcHeBwPXBSCAP53neL90iWbQ+XZvk9Ux2TxNR9YDWtdM6pqStwoZR9JdlxpHuXSXINNetm3IWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2m8dqERer3jxB8g6qh/Nxwkte+feOdgGFyh4HkuM8c=;
 b=jZxbsN+yLj+oO7L5T2+YFX5LOBxYj8WH2kvzrt2hsCiw9U93g4Bp60pK0K8HGgWQKCM0tYvbkb/aWDgDeiazxjZGcSRtP/rrakZ4eBOWGWETnSvbDvVY4vZiWV0kWsJ6XQ8fB8dNPB8iKFc3KyRdaN1fTUusMrmfxJazpfOIWi8O+B38O2b9w3X5h45kBVI2FMqbCaA3Hxadaom3B4ueP9pwmr+24Y98TNEkZKyjmPX7neCP92pDl7BA8lA4oRRDJL3hIuD5eYDkXTBtzNj6ecq7UaqX9we5ZMq9w4fiaHO0gkOB3SQUl5P+xBa8UrFvvMXp3W+9K+esWeQ0ymp1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by MN2PR11MB4741.namprd11.prod.outlook.com (2603:10b6:208:26a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 07:02:00 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982%4]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 07:02:00 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after
 kfree_scale_cleanup()
Thread-Topic: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after
 kfree_scale_cleanup()
Thread-Index: AQHZg2KlduYd6z/enEeC6gWcmPig2q9Uip+AgAATm4A=
Date:   Thu, 11 May 2023 07:01:59 +0000
Message-ID: <IA1PR11MB6171FA965F8FF915621482E789749@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
 <20230510171238.2189921-3-paulmck@kernel.org>
 <CAEXW_YTHNbzdSn3RpJwnwKZOJX=rGdMabfsCw0ZuMZhsXZMjQA@mail.gmail.com>
In-Reply-To: <CAEXW_YTHNbzdSn3RpJwnwKZOJX=rGdMabfsCw0ZuMZhsXZMjQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|MN2PR11MB4741:EE_
x-ms-office365-filtering-correlation-id: 0a1192b0-44cb-4ec6-f864-08db51ed9d4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B24WFMe7pipF6NAsOjOCNFhCAjWQxS2r77NC8xXJU4E7QXcT2nCdk2qOJuwFjznaJ5ZGSYhYiS8gfkuXbdj53WkLgB3WEqkgKm5TZ6rxLrQfRy93tB6QBvKgIPpwO+zS1gLM7kVZGX6S4p2bBqXDKWcLX9w010+uVvs1Z0QeipoNq3/xdy/MLEdKoMas/FlWrvSgmfD7O51/79cCkjElIN1EvLduxaPzvBr8pgO07SlqAItFigS4Hn48S87gBurB2rSOO1Ix4e9K1L2D60OsK3yNFsu9EZs2KdnIp7OmrAF8AY0tZ1SStz4dlVCoyBtrucNT4o2xh1R5Fhv4D4rvwrraUOsBoqepxQUb0XMdNiRAnbPOwy5RCeh8uZvl3jMOtV+IcqflMG1FZIKWMhQ1BrJcSMhSLFdhBSeNKgMXaMX+IyGUqrB7pL/Wrh7xDnS77Hg0QTF9WhMkKtKyplqBcsL9tRnPClKmAZ6eIdj2aUDUMK1P8Q2flPMGlr7pe87snJmvSbQN9azcDOn3mwQnV1gXAcJeMoFGJYujOjhgoGff8Hxt1WYSmzwPzgjNm8FN9O2t4JoaCQEPG1ajAG3yNfP5ZSmrvFvYgknlYpvCddfG832NSfY95JGpM02mAfa7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(38070700005)(122000001)(82960400001)(38100700002)(33656002)(86362001)(8936002)(5660300002)(26005)(8676002)(7696005)(52536014)(55016003)(478600001)(186003)(66476007)(53546011)(9686003)(83380400001)(2906002)(66556008)(316002)(41300700001)(54906003)(76116006)(64756008)(71200400001)(66446008)(110136005)(66946007)(6506007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RENXOUNGaHBHWnBibjM4Y2NpOVBwRjRxa2xFQkNmVzR5Z3JueEx3clNGWml0?=
 =?utf-8?B?VVRYRlBzSEpXNTlXcENvS0tkZlNCRDlVWVhWeGdENmJJSGRFT21oc1JpaHd6?=
 =?utf-8?B?UlgwVzBQbW0wVDlmaXY4UUNwSEhvWWk2YnRoWFV4T3dKRGlnbEwvdDRmc0pk?=
 =?utf-8?B?OS9VeWJaaFI1YlZVYm10TVJXSjZBbmIvVkpJbjBNOW10Y3U5R0lIUGdwTk9D?=
 =?utf-8?B?bktIUWxjSDN5Um0xWGQzdTl3SytaMG5KOWF0YVcwc2RzQnVrdFN0RVVZeE8r?=
 =?utf-8?B?dkNkTm9yOWVZK3NUSUN0RndZbTczRE5iaXJmZ2xNcHkwdnBvd1dnL3FWbkE1?=
 =?utf-8?B?djZCZ2MrUUFhNEQyTHNwdkkwVFowNm5tRVgyemF3V1pmL1lrekwvN0dBSkd4?=
 =?utf-8?B?VXIrdUgvYys4WHZ4QVNqZUVJQzFhcEFXL1BIVU1Ra09aOTRHOTBQYlc4MHF2?=
 =?utf-8?B?YjBvMFhxUjk2Y0R0dUMzdFJoNjdQLzA1YVVSMStsc014d244NWVJZXpNeHFZ?=
 =?utf-8?B?cUQva2pXNURsekw4d08wd3lJanFUallLN0FwVWtsUVptdEJ4TGYzdXltczg3?=
 =?utf-8?B?L01FdmF0TEx4K1MxeFluNUVjbjVPenJYdmZjT1dIY3RDVlZTSmZuY2l6cklQ?=
 =?utf-8?B?SGViVjhsNytlVDhGOExhYU5Fc2IwN2tRT3JsMEZ4aHEyUWl6cXp5OVBVMjFI?=
 =?utf-8?B?eUhMMXJCV3BYUHArbWFleVVnVTd2NlJTM2dZRUI2a1l3RzBhWHlRMHRKbWx0?=
 =?utf-8?B?b1RQNUZkVm1DdG00NmFpb3RJNnloOXZhV0lsODVOckYzbmh0aTgzYU8vMFRC?=
 =?utf-8?B?OXFXRGdZR2NlSTMxdEZ5eEIxK0VyNG40ZUF6TnB1UHByMVc0TEcrb0NVanRU?=
 =?utf-8?B?YzJybUVIek82RUsvU09yRlJxRDZjUXE0Ym5BdGdVTXhkbTNWS0pCZXBRMEZP?=
 =?utf-8?B?eFdkUDZtQ2luQ2xMb3I5MTVxUnZqK1A3cGhRR2VwbERJYzgzMlZBLzdoVVFj?=
 =?utf-8?B?QU5ZdlEwa1RSV09lYnd4cEh1VGp4by9kMWFsZnBIeTdCTGtOaWw3d003eEVz?=
 =?utf-8?B?NkZCeWZIanMwWmhYd3BBeDd3MXVTS1BoV3hUTGt5N0FKaldCbGpaYWV5NnRl?=
 =?utf-8?B?YTc0S0lJb0VQeDZqQ081d2R1bytZdFV2NGgzMktPM3lMTW5TZ3FtSi9BSlJN?=
 =?utf-8?B?NmhlQXE2VHQ4TjEyZ1VLbEppV2h6V0Z5TTVGUHl5OGE3WXZRUDRrRWNyTnc1?=
 =?utf-8?B?a1RpRmJHVG5nTlBxa0o0RXpFQ1VZK0cyWUhzZGhSU1FocGpiT0k0MXlkQTQ1?=
 =?utf-8?B?eFFnV3RiczFNYlpiOWgxR01MeHg5dmtKNDlzU3NuajVaS2xUaWtGS2xwS0RH?=
 =?utf-8?B?MzVweVdPc3lJWEFHL0o3L2F1L21sV3VpSlJYYjA5NEhzTDBnSnZ3OGpsM3Nx?=
 =?utf-8?B?ckdWMkthbEVmcDFTdXFQVGFYbmxxVlpxNjJhcHE1RHBVWmZ0Q0ZDTTFYb1g4?=
 =?utf-8?B?akdyYmg5K3NkRjZSV1d3akwxSzBLdmlOSkZaOTBjMS9XU0U3ZWNVTkFPQmJI?=
 =?utf-8?B?blo0RS9sRHptMDg3NVljcUZVTnZqTllpdEpDNXBSNFpGOThFa0loVDFaV0sw?=
 =?utf-8?B?S2FwWHN5YngyYlVWWEc5VTZ1aVo1bWQwekxZRW8zaUlybVdDbExmQWdIZUZ5?=
 =?utf-8?B?b0xNQ1lTUmJaS2JBZjFKL2hFWFFJU1hYN1ZsRW9qOE85U1VsS3J3d0FmaVhh?=
 =?utf-8?B?Zm5Ba2lTTnFzVUt6Y0ZCc1FINHRLS1p4NFF2b1hCUEpNd25Yb3p6N3dvSndm?=
 =?utf-8?B?cE1kdU16Zk1aL2FYaXhBb0FLNEx4TmNEODJsZnp2SG9wTGRMM0EydlVHTnhS?=
 =?utf-8?B?WVk3M3ZZUHVsdmdtNUJaLzJxcWxFTU5Ta0k4Z3ROb1NPcjk4akNCQ0tSaGlq?=
 =?utf-8?B?cXhaWWJIS1JsUlY3YTdiRHcwZzBPcUEwVWhBYzQ0VkUxOU9UeHFZbElQdTZt?=
 =?utf-8?B?Mngyb3Z3YkIzbVVPVEVYOVlhbVpPQVpCcHJQamVGME04K0hiWjlwQUVOVHRD?=
 =?utf-8?B?cWlKYmF2OHdwY1IvaytvRFFyazVhbUxvVFM4dGNHSkFLb1lWbDl2VTJRUzNm?=
 =?utf-8?Q?a9AJujFmV6hkJOxIqD9GG7Ppd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1192b0-44cb-4ec6-f864-08db51ed9d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 07:01:59.1062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HiuJxdXsjrlSbjh981h4wRnMjL5/YqbBvfDiPQlEu/hvOJQHWuIbxrzSl2COJeFxnmotRg75j2kQEw5q5mRtSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4741
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4NCj4gU2VudDog
VGh1cnNkYXksIE1heSAxMSwgMjAyMyAxOjIzIFBNDQo+IFRvOiBQYXVsIEUuIE1jS2VubmV5IDxw
YXVsbWNrQGtlcm5lbC5vcmc+DQo+IENjOiByY3VAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWwtDQo+IHRlYW1AbWV0YS5jb207IHJvc3RlZHRAZ29v
ZG1pcy5vcmc7IFpodW8sIFFpdXh1DQo+IDxxaXV4dS56aHVvQGludGVsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCByY3UgMy82XSByY3UvcmN1c2NhbGU6IE1vdmUgcmN1X3NjYWxlXyooKSBh
ZnRlcg0KPiBrZnJlZV9zY2FsZV9jbGVhbnVwKCkNCj4gDQo+IE9uIFdlZCwgTWF5IDEwLCAyMDIz
IGF0IDEwOjEy4oCvQU0gUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPg0KPiB3
cm90ZToNCj4gPg0KPiA+IEZyb206IFFpdXh1IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29tPg0K
PiA+DQo+ID4gVGhpcyBjb2RlLW1vdmVtZW50LW9ubHkgY29tbWl0IG1vdmVzIHRoZSByY3Vfc2Nh
bGVfY2xlYW51cCgpIGFuZA0KPiA+IHJjdV9zY2FsZV9zaHV0ZG93bigpIGZ1bmN0aW9ucyB0byBm
b2xsb3cga2ZyZWVfc2NhbGVfY2xlYW51cCgpLg0KPiA+IFRoaXMgaXMgY29kZSBtb3ZlbWVudCBp
cyBpbiBwcmVwYXJhdGlvbiBmb3IgYSBidWctZml4IHBhdGNoIHRoYXQNCj4gPiBpbnZva2VzDQo+
ID4ga2ZyZWVfc2NhbGVfY2xlYW51cCgpIGZyb20gcmN1X3NjYWxlX2NsZWFudXAoKS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFFpdXh1IFpodW8gPHFpdXh1LnpodW9AaW50ZWwuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4g
PiAtLS0NCj4gPiAga2VybmVsL3JjdS9yY3VzY2FsZS5jIHwgMTk0DQo+ID4gKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5NyBp
bnNlcnRpb25zKCspLCA5NyBkZWxldGlvbnMoLSkNCj4gDQo+IEkgd2lzaCBkaWZmIHdhcyBiZXR0
ZXIgYXQgc2hvd2luZyB3aGF0IHJlYWxseSBjaGFuZ2VkLiBUaGUgbWVsZCB0b29sIGNhbiBoZWxw
DQo+IGJ1dCBpdHMgZ3VpLi4uDQo+IA0KPiBTaG91bGQgSSBydW4gbWVsZCBsYXRlciAoSSdtIG91
dCBhdCBhIGNvbmZlcmVuY2Ugc28gbm8gYWNjZXNzIHRvIG1lbGQtY2FwYWJsZQ0KPiBtYWNoaW5l
cykgb3IgYXJlIHdlIHN1ZmZpY2llbnRseSBjb25maWRlbnQgdGhhdCB0aGUgbGluZXMgd2VyZSBt
b3ZlZCBhcy1pcyA/IDopDQo+IA0KDQpUaGFuayB5b3UsIEpvZWwgZm9yIHRoaXMgY29uY2Vybi4g
R29vZCB0byBrbm93IHRoZSBtZWxkIGRpZmYgR1VJIHRvb2wuIA0KSSBqdXN0IHJ1biB0aGUgY29t
bWFuZCBiZWxvdyBhbmQgY29uZmlybWVkIHRoYXQgdGhlIGxpbmVzIHdlcmUgbW92ZWQgDQphcy1p
czogcmN1X3NjYWxlX3tjbGVhbnVwLHNodXRkb3dufSgpIGZvbGxvd3Mga2ZyZWVfc2NhbGVfY2xl
YW51cCgpLg0KWW91IG1heSBkb3VibGUgY2hlY2sgaXQgOy0pLg0KDQogICAgICBtZWxkIC0tZGlm
ZiAuL3JjdXNjYWxlLmMuYmVmb3JlIC4vcmN1c2NhbGUuYy5hZnRlcg0KDQotUWl1eHUNCg0KPiAg
LSBKb2VsDQo=
