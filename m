Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89D72A6F4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 02:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjFJAMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 20:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjFJAMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 20:12:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA4B30CB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 17:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686355939; x=1717891939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DufxVMy9Te6MCuCSdfMPP0RlyBcBk11UIFC8c+b9iqU=;
  b=b/mNrtaIYVUvOqeNoNoasl06WMholdiVQ9Rr8f9BhTJhOhBnzLyoPDrP
   S7s7qRdI0Ib6gTunlfbaF2beleNaTBQWqK78K6lEasIrAXiU9zpYU4ODr
   jBhjyCK21Z3e0wk+Ww+ponOvnmRiUESDyMClJ7gSf95w/pQJAgZ7+GIB6
   +Ktg4DbSC/oRe7ER7fxps9bT6Rq2svH4ogWyp8532gnsPxE+9C6gmxyVr
   B84ZYqlfZfNTwkB28zPk5VqEtPKOJRwGC7iC7fw/WlwwXwXYPAUvmICnR
   1ZYuUAzrf4FzWArIlfq4DMiZajyK+a4nwBbh4EZKVJNIqeef6GGEOcEV3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="386079586"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="386079586"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 17:12:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="780486735"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="780486735"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2023 17:12:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 17:12:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 17:12:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 17:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag0lavMrp4cJnWWczFEOa+uVxhfhoO2npLL7lYC/arE4yUn88vwHd/fp/yhPoqS7T/ySm1cJvNX/yiqjuSry/wDl5nRpf4DfVMO44dQ0xD6Q9C6M3vRCF3IRVgfkWy3JKF10QnEf3ki09NIE5Wf3ewBVXl4pBvemCJQT5UBhbUfoYP57xJaZ9sH/34YhBHE/3UDNpiPcCPptf+2cldNV0hNiAEfaQNE89t12CSVgIZiDcw6XHfAxxNVeLeanZZAX5Yd2tgVGSjwCjgwIriyqBLHczPReGRhU3jJ+DWOM2zTnanqI03tIWf3rTAd2u9f/zfyMqynrteQNUk87OsvsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DufxVMy9Te6MCuCSdfMPP0RlyBcBk11UIFC8c+b9iqU=;
 b=Uf2pRf5ETCumAg+GzYEMEBUdxaaTpwiSSUPP6r8gujyMQb+mDo20h5KepTMkoX9e7+KLkChuKrRf9nMk4MmzkpwWhZfavNTsaAgVeT8H8aM/jEYRHFPyyS49Of6ESXUcI1I2v4/7SbQW9XfxeZ0LlNfXtQTurZQrDdZ4bkyjRd2J8i3d0BFNiAmpNSb1lzwbLSOOMsJ4fx4JJX+VgOhtkcZy/eFfoMmbdWludF9Kappe1NnVulHsaiSxA/3kGu381pgPS5o/XxrFQnRrhXSac6S415S63uMc4bHsyxhlS+s+7bbrdvGnNm3AWqxQJXGVLQEf+aGGTp186SqxAFZhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Sat, 10 Jun
 2023 00:12:13 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::7f9a:95b2:479f:82ed]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::7f9a:95b2:479f:82ed%4]) with mapi id 15.20.6455.043; Sat, 10 Jun 2023
 00:12:13 +0000
From:   "Ma, Yu" <yu.ma@intel.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     "Liam.Howlett@Oracle.com" <Liam.Howlett@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>,
        "Deng, Pan" <pan.deng@intel.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "Li, Tianyou" <tianyou.li@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH v2] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Thread-Topic: [PATCH v2] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Thread-Index: AQHZmUurECJuEzqoAE2zotVyE9hBN69/acvggANh4wCAAFOM4A==
Date:   Sat, 10 Jun 2023 00:12:12 +0000
Message-ID: <SN7PR11MB759041E7DB7877D148091D68E156A@SN7PR11MB7590.namprd11.prod.outlook.com>
References: <20230606125404.95256-1-yu.ma@intel.com>
 <20230607145009.58899-1-yu.ma@intel.com>
 <SN7PR11MB7590D5959AF7179137A314FEE153A@SN7PR11MB7590.namprd11.prod.outlook.com>
 <ZINtij2HhIu9h9Wx@V92F7Y9K0C.lan>
In-Reply-To: <ZINtij2HhIu9h9Wx@V92F7Y9K0C.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|BL1PR11MB5303:EE_
x-ms-office365-filtering-correlation-id: 1844b1d9-b4ae-4b4d-7031-08db69475734
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jloH0sW6I93alTUdwubsxSHvftlvYcB0lKf68fa6JzZM4NnGGakzQW8WMBk88L4kZ9m0VdhIjfyNQ7ogEEqEMkkjzSUPE5QzsKp2mfyyDgtULrOms/NKsYE6xVH1QAsKhWlJ5M0o8w3vbnL17GAIz0U7Nf7tx8R8TcKZWkQjhe7Wt4Bn2yU+YEzVZwa66hpo+cFwgF4ypAHfBkQc37q1IZrKuWZVKgi70wAchL0DMgvjRv0soA3lUpQ2agHgr4COwRMDj2cO5jSIDaDrjBxckRplIpv4pHiCruVwS24o5ZkhdF0IyxvM3wdJKk2KSpGQch0Jbc/XXc0ctZa3igdddmQred8zxgoZAEv0THnW7TIZR4jQCMnf3T7txXuFMiteO52kpbqjx0YsexU9gyksz0ZSPbtqRENxRQbeWtsZvBYhy4Du7Y5sGIOiHTKGuhIoVIqyBNm0oK7mSBwsr2WzWGz9qN+dX+Nf/TD1IpYGVnwD2bu4ERwOGsumFi3Bsx9uC4gB/PSiipkMwENDarnOgyDJUI6zu9tO0KdcyGHKgQhelaWRcJxfvA1k8Yhgp6GvemkzkIgdjx3Wa/h3GnFW+l8oRpkt/vrt5yEcY3VmFH6k8P1gaaez2HU+imCuDYYR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(66946007)(66476007)(76116006)(316002)(64756008)(66446008)(71200400001)(54906003)(6916009)(66556008)(4326008)(478600001)(33656002)(38070700005)(86362001)(83380400001)(6506007)(9686003)(186003)(26005)(41300700001)(52536014)(8936002)(8676002)(2906002)(5660300002)(82960400001)(55016003)(7696005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWdpT3creEFremUxTGw0T3I0ZW5Pem1CTGJ4bDRoa0pQL0N5ZGlRNGhkTG04?=
 =?utf-8?B?bFhwTnZCa3hGSGZtcTFuVlJBNEdTRkRFeWlkNlpiT0xUVzhsemdxaDJ6T0Rw?=
 =?utf-8?B?d3I1MXBza1YyeGYyU0lHWDdWWUFEb0VFaXFINUhEMkJ2MUVWOEE5bENwNnhu?=
 =?utf-8?B?T0JocExVMXJ2QXRlU0NXVldiTmY0THJOYkRTZy9vRXdnTnRhWm1DYUVkVExI?=
 =?utf-8?B?QTViL29DaGVJNFMvTFVEcFJUZ0VQc2p3ZlpwL3VZQlRGajFqa2Q1VlZkVWlx?=
 =?utf-8?B?MHZ6LzU0TCtmYW1jNnU3Y3J5UndvTzllQlBrV3gyWHdtK282Vm5VWFZRU21F?=
 =?utf-8?B?eDhiZUpTUnVwaXZ5RDc4d09ad0NGU3VQL0V0TXY5cWZFa2pnbFFjcmg5bHJt?=
 =?utf-8?B?dnBXcVZ3MzM4WWZPT1pKRG9GVmtDV081OGN5OUZHMFVZK0pmSEdVWmMvbW9z?=
 =?utf-8?B?cFF0ZFFWUmFBczhidzJIbnNaM0ZlcTc2ei9wM0hwQlJ6ZnloWWlONEoxRjJY?=
 =?utf-8?B?VUE0YWQwbklKSXlaU3poZEFseUxibTlTVkNsd1VmZU5DYnhvM1ZmNUdvUklT?=
 =?utf-8?B?dWcwOUtMZFMrNDBoN01TajZQT1BaTThFQ05TMUQzQVlsWnlGeDNVb3piZVA1?=
 =?utf-8?B?ZW1JcHdzQXF1K3Fyd2ZiR1lOL0xOc29xSmgySXlxZHVYZk95bGdzbWNLZGFI?=
 =?utf-8?B?VXlhbEF1NVh2UUVzSHQ4a3pzNHBpTHBXaGNsRmtMUkliV1BMZjZ3bjZQUXNk?=
 =?utf-8?B?cTMvc3Z4aUE1RzgxSXVLZXRJUWtleHZYMU9oNEJ5YlVYbGU4ckowSVVtVmxL?=
 =?utf-8?B?dGFuVktCbnZUSHAzRDYwOFRVMm1mMjFmV1p3aGhFVHZla05kRVFkYVBrQjhC?=
 =?utf-8?B?b1NSS3RNT0lMMVlBNkVKejkrK0VGQ0xkMVZ4WWxPUG5LU2Noc3pBazNiVmkr?=
 =?utf-8?B?MmhpUVZZVXNtK2JCU2Y2a1ZuUEFpbGNVRk5XbkdrdU9jNmlFNjJMSS81K1JZ?=
 =?utf-8?B?NGg4NkFRYkpBVkFIMlV5WFFwREd4ZXhhQTNiUVV2MG0yTHpvenc2S2VvYWta?=
 =?utf-8?B?WXlEeGhHL2Z4a1g0UWxZTEVHY2FRZGU2ZzVYNVJ2NWJ6NitFS0UvMmJFSVEv?=
 =?utf-8?B?YUh6R3hPdjBGQ3NLZk54R0Rvcy9mOUVkNWVxdmlPYy9tZ3RKR01WcXcxSGxZ?=
 =?utf-8?B?U1N5clNiSTdBKzVpNWpXYW4zUWVCQ3lxaGZOUUswaXVrUDVCZVJRcS9ZdGxR?=
 =?utf-8?B?U05kZ2wyRnZ2YjVoa1VLbjFkbEZOSVU3UUdBbENoWnk1S3lxQ0hLSzVNNjl2?=
 =?utf-8?B?TGRnQ0EweUpKai9RdG01V1dXaExsK3p0YitpRzZya2FVSUo1OERVQnFVSlN0?=
 =?utf-8?B?M01zTEwrQmtxR1lyUDY1U1lpR2w3QzlXVlBiVWN1dE9Zem44ZTJ4Wk9LYmp1?=
 =?utf-8?B?ZWRRN0hDSFZUdkJxWDczVEpXbW9rMkhOenpEKytaUnZCWW9Ra0Y0cFlvVXA4?=
 =?utf-8?B?M0NCeVowa25KdTVhM1R1NVJNaXV6R3lxcnh4U05GWG1UNlhiTEpSeDA4MVpz?=
 =?utf-8?B?V0I0djYrQjVBR2U2WVkzY0t4UUVjTU0xcEs0VDA1Mk5VMS96Mjg0a2p3MG0w?=
 =?utf-8?B?SG1KUjFEd1lpMmNzSkowVUZSMWd3S1pJZ21tRmorRW82VVFLL01XMmY3YlZG?=
 =?utf-8?B?MVl3clhrRE9DdVFuMEw1K0luNkJFSmx6azZRZHpXcUVHdHNCOUJKTjNoTHEx?=
 =?utf-8?B?M3lwaW8rdmNKdUo3WG55dnlHUW9LRk5OL1RUeFNQOWFDVkZ4TGNNN2k5eVVU?=
 =?utf-8?B?NXhxdW96Q2haTWNnSEV2V1BjMUhiY3JXU0pKNkFzMjZEVVNyYVlLOHBhSmc4?=
 =?utf-8?B?MFFJTThXTWtKUXBxejl5UGdKWU45amtTRnVxTi96MG93ODl2a3NUMUMvc0tN?=
 =?utf-8?B?TFJveFVab1RYemRXMUFORXJFOUJlWVRpMWdaSVpJNWN6ZnpOYTF0Q082dG5s?=
 =?utf-8?B?VVRDV2RFTHJ2SThiekJJUE1iYlhUTWNDaVRMRld2a3NGb3o2NmtQczZHVlVZ?=
 =?utf-8?B?N1Z0d3A2VGZzK1Mvd3Z0b3RPRXBLbkhrRVNQRW1YQWlkUjl0NjZoVUd3Tjhn?=
 =?utf-8?Q?bNoU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1844b1d9-b4ae-4b4d-7031-08db69475734
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2023 00:12:12.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5G4UBaayzAG4ylThD1esdcRfAU1IRZkKGrlatcJv7YKq7LBDhKn6Isl13q8ck0o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
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

PiBIaSBZdSwNCj4gDQo+IE9uIFdlZCwgSnVuIDA3LCAyMDIzIGF0IDAzOjAyOjMyUE0gKzAwMDAs
IE1hLCBZdSB3cm90ZToNCj4gPiBUaGFua3MgTGlhbSBhbmQgRGVubmlzIGZvciByZXZpZXcsIHRo
aXMgaXMgdXBkYXRlZCBwYXRjaCB3aXRoIGNvbW1lbnQNCj4gYXJvdW5kOg0KPiA+DQo+ID4gPiBX
aGVuIHJ1bm5pbmcgVW5peEJlbmNoL0V4ZWNsIHRocm91Z2hwdXQgY2FzZSwgZmFsc2Ugc2hhcmlu
ZyBpcw0KPiA+ID4gb2JzZXJ2ZWQgZHVlIHRvIGZyZXF1ZW50IHJlYWQgb24gYmFzZV9hZGRyIGFu
ZCB3cml0ZSBvbiBmcmVlX2J5dGVzLA0KPiBjaHVua19tZC4NCj4gPiA+DQo+ID4gPiBVbml4QmVu
Y2gvRXhlY2wgcmVwcmVzZW50cyBhIGNsYXNzIG9mIHdvcmtsb2FkIHdoZXJlIGJhc2ggc2NyaXB0
cw0KPiA+ID4gYXJlIHNwYXduZWQgZnJlcXVlbnRseSB0byBkbyBzb21lIHNob3J0IGpvYnMuIEl0
IHdpbGwgZG8gc3lzdGVtIGNhbGwNCj4gPiA+IG9uIGV4ZWNsIGZyZXF1ZW50bHksIGFuZCBleGVj
bCB3aWxsIGNhbGwgbW1faW5pdCB0byBpbml0aWFsaXplIG1tX3N0cnVjdCBvZg0KPiB0aGUgcHJv
Y2Vzcy4NCj4gPiA+IG1tX2luaXQgd2lsbCBjYWxsIF9fcGVyY3B1X2NvdW50ZXJfaW5pdCBmb3Ig
cGVyY3B1X2NvdW50ZXJzIGluaXRpYWxpemF0aW9uLg0KPiA+ID4gVGhlbiBwY3B1X2FsbG9jIGlz
IGNhbGxlZCB0byByZWFkIHRoZSBiYXNlX2FkZHIgb2YgcGNwdV9jaHVuayBmb3INCj4gPiA+IG1l
bW9yeSBhbGxvY2F0aW9uLiBJbnNpZGUgcGNwdV9hbGxvYywgaXQgd2lsbCBjYWxsIHBjcHVfYWxs
b2NfYXJlYQ0KPiA+ID4gdG8gYWxsb2NhdGUgbWVtb3J5IGZyb20gYSBzcGVjaWZpZWQgY2h1bmsu
DQo+ID4gPiBUaGlzIGZ1bmN0aW9uIHdpbGwgdXBkYXRlICJmcmVlX2J5dGVzIiBhbmQgImNodW5r
X21kIiB0byByZWNvcmQgdGhlDQo+ID4gPiByZXN0IGZyZWUgYnl0ZXMgYW5kIG90aGVyIG1ldGEg
ZGF0YSBmb3IgdGhpcyBjaHVuay4gQ29ycmVzcG9uZGluZ2x5LA0KPiA+ID4gcGNwdV9mcmVlX2Fy
ZWEgd2lsbCBhbHNvIHVwZGF0ZSB0aGVzZSAyIG1lbWJlcnMgd2hlbiBmcmVlIG1lbW9yeS4NCj4g
PiA+IENhbGwgdHJhY2UgZnJvbSBwZXJmIGlzIGFzIGJlbG93Og0KPiA+ID4gKyAgIDU3LjE1JSAg
MC4wMSUgIGV4ZWNsICAgW2tlcm5lbC5rYWxsc3ltc10gW2tdIF9fcGVyY3B1X2NvdW50ZXJfaW5p
dA0KPiA+ID4gKyAgIDU3LjEzJSAgMC45MSUgIGV4ZWNsICAgW2tlcm5lbC5rYWxsc3ltc10gW2td
IHBjcHVfYWxsb2MNCj4gPiA+IC0gICA1NS4yNyUgNTQuNTElICBleGVjbCAgIFtrZXJuZWwua2Fs
bHN5bXNdIFtrXSBvc3FfbG9jaw0KPiA+ID4gICAgLSA1My41NCUgMHg2NTQyNzg2OTZlNTUyZjM0
DQo+ID4gPiAgICAgICAgIG1haW4NCj4gPiA+ICAgICAgICAgX19leGVjdmUNCj4gPiA+ICAgICAg
ICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lDQo+ID4gPiAgICAgICAgIGRvX3N5c2Nh
bGxfNjQNCj4gPiA+ICAgICAgICAgX194NjRfc3lzX2V4ZWN2ZQ0KPiA+ID4gICAgICAgICBkb19l
eGVjdmVhdF9jb21tb24uaXNyYS40Nw0KPiA+ID4gICAgICAgICBhbGxvY19icHJtDQo+ID4gPiAg
ICAgICAgIG1tX2luaXQNCj4gPiA+ICAgICAgICAgX19wZXJjcHVfY291bnRlcl9pbml0DQo+ID4g
PiAgICAgICAgIHBjcHVfYWxsb2MNCj4gPiA+ICAgICAgIC0gX19tdXRleF9sb2NrLmlzcmEuMTcN
Cj4gPiA+DQo+ID4gPiBJbiBjdXJyZW50IHBjcHVfY2h1bmsgbGF5b3V0LCDigJhiYXNlX2FkZHLi
gJkgaXMgaW4gdGhlIHNhbWUgY2FjaGUgbGluZQ0KPiA+ID4gd2l0aCDigJhmcmVlX2J5dGVz4oCZ
IGFuZCDigJhjaHVua19tZOKAmSwgYW5kIOKAmGJhc2VfYWRkcuKAmSBpcyBhdCB0aGUgbGFzdCA4
DQo+ID4gPiBieXRlcy4gVGhpcyBwYXRjaCBtb3ZlcyDigJhib3VuZF9tYXDigJkgdXAgdG8g4oCY
YmFzZV9hZGRy4oCZLCB0byBsZXQNCj4gPiA+IOKAmGJhc2VfYWRkcuKAmSBsb2NhdGUgaW4gYSBu
ZXcgY2FjaGVsaW5lLg0KPiA+ID4NCj4gPiA+IFdpdGggdGhpcyBjaGFuZ2UsIG9uIEludGVsIFNh
cHBoaXJlIFJhcGlkcyAxMTJDLzIyNFQgcGxhdGZvcm0sIGJhc2VkDQo+ID4gPiBvbiB2Ni40LXJj
NCwgdGhlIDE2MCBwYXJhbGxlbCBzY29yZSBpbXByb3ZlcyBieSAyNCUuDQo+ID4gPg0KPiA+ID4g
UmV2aWV3ZWQtYnk6IFRpbSBDaGVuIDx0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IFl1IE1hIDx5dS5tYUBpbnRlbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+
ICBtbS9wZXJjcHUtaW50ZXJuYWwuaCB8IDggKysrKysrKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdp
dCBhL21tL3BlcmNwdS1pbnRlcm5hbC5oIGIvbW0vcGVyY3B1LWludGVybmFsLmggaW5kZXgNCj4g
PiA+IGY5ODQ3YzEzMTk5OC4uZWNjN2JlMWVjODc2IDEwMDY0NA0KPiA+ID4gLS0tIGEvbW0vcGVy
Y3B1LWludGVybmFsLmgNCj4gPiA+ICsrKyBiL21tL3BlcmNwdS1pbnRlcm5hbC5oDQo+ID4gPiBA
QCAtNDEsMTAgKzQxLDE2IEBAIHN0cnVjdCBwY3B1X2NodW5rIHsNCj4gPiA+ICAJc3RydWN0IGxp
c3RfaGVhZAlsaXN0OwkJLyogbGlua2VkIHRvIHBjcHVfc2xvdCBsaXN0cyAqLw0KPiA+ID4gIAlp
bnQJCQlmcmVlX2J5dGVzOwkvKiBmcmVlIGJ5dGVzIGluIHRoZSBjaHVuayAqLw0KPiA+ID4gIAlz
dHJ1Y3QgcGNwdV9ibG9ja19tZAljaHVua19tZDsNCj4gPiA+ICsJdW5zaWduZWQgbG9uZwkJKmJv
dW5kX21hcDsJLyogYm91bmRhcnkgbWFwICovDQo+ID4gPiArDQo+ID4gPiArCS8qDQo+ID4gPiAr
CSAqIFRvIHJlZHVjZSBmYWxzZSBzaGFyaW5nLCBjdXJyZW50IGxheW91dCBpcyBvcHRpbWl6ZWQg
dG8gbWFrZSBzdXJlDQo+ID4gPiArCSAqIGJhc2VfYWRkciBsb2NhdGUgaW4gdGhlIGRpZmZlcmVu
dCBjYWNoZWxpbmUgd2l0aCBmcmVlX2J5dGVzIGFuZA0KPiA+ID4gKwkgKiBjaHVua19tZC4NCj4g
PiA+ICsJICovDQo+ID4gPiAgCXZvaWQJCQkqYmFzZV9hZGRyOwkvKiBiYXNlIGFkZHJlc3Mgb2Yg
dGhpcyBjaHVuaw0KPiA+ID4gKi8NCj4gPiA+DQo+ID4gPiAgCXVuc2lnbmVkIGxvbmcJCSphbGxv
Y19tYXA7CS8qIGFsbG9jYXRpb24gbWFwICovDQo+ID4gPiAtCXVuc2lnbmVkIGxvbmcJCSpib3Vu
ZF9tYXA7CS8qIGJvdW5kYXJ5IG1hcCAqLw0KPiA+ID4gIAlzdHJ1Y3QgcGNwdV9ibG9ja19tZAkq
bWRfYmxvY2tzOwkvKiBtZXRhZGF0YSBibG9ja3MgKi8NCj4gPiA+DQo+ID4gPiAgCXZvaWQJCQkq
ZGF0YTsJCS8qIGNodW5rIGRhdGEgKi8NCj4gPiA+IC0tDQo+ID4gPiAyLjM5LjMNCj4gPg0KPiAN
Cj4gVGhhbmtzIGZvciBhZGRpbmcgdGhlIGNvbW1lbnQsIGJ1dCB3b3VsZCB5b3UgbWluZCBhZGRp
bmcNCj4gX19fX2NhY2hlbGluZV9hbGlnbmVkX2luX3NtcD8gVW5sZXNzIHRoYXQncyBzb21ldGhp
bmcgd2UncmUgdHJ5aW5nIHRvDQo+IGF2b2lkLCBJIHRoaW5rIHRoaXMgaXMgYSBnb29kIHVzZSBj
YXNlIGZvciBpdCBib3RoIG9uIHRoZSBwY3B1X2NodW5rIGFuZA0KPiBzcGVjaWZpY2FsbHkgb24g
YmFzZV9hZGRyIGFzIHRoYXQncyB3aGF0IHdlJ3JlIGFjY2Vzc2luZyB3aXRob3V0IGEgbG9jay4N
Cj4gDQoNClRoYW5rcyBEZW5uaXMsIEknbGwgc2VuZCBvdXQgdGhlIHVwZGF0ZWQgcGF0Y2ggd2l0
aCANCl9fX19jYWNoZWxpbmVfYWxpZ25lZF9pbl9zbXAgb24gYmFzZV9hZGRyIDopDQoNCj4gVGhh
bmtzLA0KPiBEZW5uaXMNCg0KUmVnYXJkcw0KWXUNCg==
