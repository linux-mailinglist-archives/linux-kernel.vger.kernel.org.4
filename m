Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763785ED0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 01:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiI0XLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 19:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiI0XLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:11:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99C10FE0E;
        Tue, 27 Sep 2022 16:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664320309; x=1695856309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AyBM8kumOiBqswpyufScyfXstTCHAj3EaojIZ6CUrR4=;
  b=Bnmyf1BwlW/FhuCI21MkaPuNSRWrtwbsTCIx3aPEgeTblkeHGq4JtVQd
   JSsaxKuBJXE4Mp/eeLEJI0yzLhqiULPcSm8h/ShIokB2TcifeFEUuLxNj
   2LIU8+NMM9bhIOJZdrjgX/xU7UY9mJzjAhtGBBPI5pmP81cUVpsILoBKb
   5Khr6C0rZwLEP/JEUeeq/6SlTk2dW7o3KCbIYj0qvJbEtKTgfj4FTn73F
   CIfU/+neSSLurlvikrw9zGZXEBjx6hRVQewZufX2+dXTt/TsOm2WL206w
   Tb3B4E1N/XKbgzJ4iehDRop23z+XeCULBR8GGskUCDFqgkhSFeS+ZeXtT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="365497311"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="365497311"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 16:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="654901275"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="654901275"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2022 16:11:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 16:11:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 16:11:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 16:11:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDM2tuVJOzTwPGsxEjahZlOBLXk2Yr7lVW/Bq8qNOmpi0wZNywLgeE0L7XX38PaSjAJyWGXE9kOPhRWmUjukZTCScYSI8j+klPQbYQCVqyOTAz4U2aT6+7Zh3cL4FEB0QeFIeeVFw5R9awr5wGlN5qeTwzNzSo6prZMTSlcyw93X+AF35QnVPVs08c9fdBJdSMct+2qh17dxbMg7w/Am0BrsWpTjC6tBSpPDbpjudhRvqiOxk7+w4qh9Yp1qMsTSNN4MOmHFKx/IY5bVkCwVSOVW0sS+y268bQPwHLf9ngQAl/bdFAwAwBBACmNnUAjwo+5MQxW0PxQde5cXIMOZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyBM8kumOiBqswpyufScyfXstTCHAj3EaojIZ6CUrR4=;
 b=S4tctwopyh0/Ho6IhH7qlhnACSdTHh7HRWg7nojfquRPUvIbkWziqCohNtTjWzCuEUipiW9HlA6xE982diScwPLV+34SqeWzbVmjoK4FoZfxs7TWjDXi5zVmEBfUSlHf2ZgYqW77QpXsAJSgy55Cw/W3f4WTVrwqIZy3Wge7lObQwHctqqbh7NTJYVqN5QZZdCiBuO6hJQ4gE07wIaoRrYLXpwSH+5I9oVzXfj292zsjcDV05XjkksaT7yLi7SAQoKrvF9rXOY6kcib3RvB7mQOJABwuC3fwLWG7Tr9PIIs8mfRhEZEB6dQL88lXdMgn2ba6cHwLOfeLfjmEck0vMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MW4PR11MB7104.namprd11.prod.outlook.com (2603:10b6:303:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 23:11:47 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 23:11:46 +0000
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
Subject: RE: [PATCH v5 1/2] x86/resctrl: Fix min_cbm_bits for AMD
Thread-Topic: [PATCH v5 1/2] x86/resctrl: Fix min_cbm_bits for AMD
Thread-Index: AQHY0q4Um4gUlD4McEaPrimQQt64iq3z51GA
Date:   Tue, 27 Sep 2022 23:11:46 +0000
Message-ID: <IA1PR11MB60972C5A48D0003D3E6705259B559@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
 <166430978944.372014.15309570958318893913.stgit@bmoger-ubuntu>
In-Reply-To: <166430978944.372014.15309570958318893913.stgit@bmoger-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|MW4PR11MB7104:EE_
x-ms-office365-filtering-correlation-id: 89dfb243-5938-40b8-b361-08daa0dda686
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /G/7Sri7jST5kSgmrltsIu4vdowZO6DNSfaYpWcfsFd8id9QMUWXMLo9BiL9Aa5ZSD6UlXY94sC74EddyPIsH80yGFnnN/bMw7WjEGTajEJqlsxv37uNfrhh3py0ap7PkWY636wd5qYDXYLFclL1MZGqe+yIlBdwMd15lImpdz43wm4pURnc9bl0zOkrWx4dXHcRw34xsO128DxH4Nedp8wrpj9GN1Z2SpeijVORB7JZC7DO0gnnkHE/0O28lsC9xJ5pFf69XCYkYtihEYC2b3EGm4usjoRybLZRSt84g+5qdgbct/vNVaN4WlIv5AYnrJVaVE/yb1ojD/UqMGZSBN9kx9ny3qtlDa/V/FJ1LhHcvKs+IAlWJnS38mkg8FZrELe/3H2wC1OHOrpWCiOUIfhm8q9mPq/zKiIS7RUrhzQRR9D9EoYUgVK14p9jA2uYMS0OosBRZM9pt30d8pkiWkb6PZP1YZohMDkCOmbe1JPTIRZDnAwCxZbQrQwh4R0topswiTQaCuuQRTqVEmKUGxcltqxQmyfYEL3GWBuIQEAaPu3YaCSWPjfBAzWbpSChZUUYdg9ITOAyzn+jH2cPMforrBK6JiGrZ0dnmrzRqxoScmStj4ElD3MR1AdMK7wpUKrnTZu3Soauj/X4JYAvXecboItoBai9jUy62lfDqnS97cHgrPgHLd/J2HjUwBVQqmFpvAzp+jO9syBUrDcNlBukZbQo19cfD5DNrXQ64rDlKzJ0yz3qr2+LeX/XLmDihP3tKc+J8zO3otJZQD6cUAdLL+DAhJHM/OiWvMFv1HY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199015)(52536014)(8936002)(38070700005)(2906002)(86362001)(7416002)(71200400001)(7696005)(41300700001)(26005)(83380400001)(9686003)(186003)(478600001)(6506007)(966005)(4326008)(76116006)(66946007)(82960400001)(64756008)(122000001)(66446008)(8676002)(316002)(38100700002)(54906003)(66556008)(5660300002)(110136005)(66476007)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YStlWTA3T0R3MTIra3o5S0VaL01zYTNOc0ZOOVI1WHlwQk9KL0ErT3piZE00?=
 =?utf-8?B?dG9OR1pGdzFWTUs4bWNtM3Ard05Wd2xDZzFnTXVtUzR6Q1FxNVNzdE5YNGR5?=
 =?utf-8?B?R0Z6YVpRNHdlNTNNQkk4R01ic1NrTHMrbUxoWERULzRveCtQazIyc0kwbDl5?=
 =?utf-8?B?Yi9pdUFNY3FyNmIwbHQyTzF4N3pJUEhHQ3BrbTgrQ1hEcTh0YjJXY2lWT3ht?=
 =?utf-8?B?RVNnWG1wNnEwL0xlVmRZOE1PTUsrQ1ZIU0FyUzRvSk44ZWRVc1hYL1hlelBl?=
 =?utf-8?B?bHl3cDRWQmpqMzFOd2F5d0hjTVczaDQ3VENRUmRWN3NXdGlOMUtScjNnL05Q?=
 =?utf-8?B?Szl0dDlUajRIM2tqeVlTRmtScWgrOGN0bUMwVWtnWEUxMzg3dTlZZjdjT0p6?=
 =?utf-8?B?RlczenY3M3FmeEw4bUxVU1VUYU5Eald5Mjh0RldNL29SS252ZUJzZVFIdjdM?=
 =?utf-8?B?VVZ3Y05VUFZIUVJkZXJWUUNwU2hra0swZWRZdUFIZXZnTTQzcnJudHYvcnVJ?=
 =?utf-8?B?KzJzRW51MVgxNUx3TGp1YjBubVdBUTZ2RGRzSnVuMnlPbjQ2SmtvVWpXT3NE?=
 =?utf-8?B?RlFabEwva0EyRVUvZ1VHQ3hZL0lCV0RVdXJZYTZ0RmNHMzJlUEFqcGpHeWJ1?=
 =?utf-8?B?d3ZaOHBkUDBLWWNnZ2tJdU9uSVMySnJ6bk94aENUS3Ura1daVDNlcjNMdDVZ?=
 =?utf-8?B?eFgycVZvNDlPTWV0M1RrUXA0QlJsYXJYeWhwTWg4aDkvR1J1bGhnL2FXaWoz?=
 =?utf-8?B?ZG9ZTHJMdkhNY2NsY2JnZGxzV0t0QjZubDc3VlEwUDRtZDdJSzRxcnArNmt6?=
 =?utf-8?B?S0xBQmJpYTVENkpxeHg5T1ptVnhGZ1U5YWFSVEpYUW9EeUNuRkw0M1VXaEtp?=
 =?utf-8?B?enkyb0d6bkxuUjNub0w1M2NwUnR2UjJzWXdQM3FDVnJ1RHBLMGZJUDdwUldK?=
 =?utf-8?B?d2w5TmhUMzVhVjVMTE5ieEVYMi9tYkpRdWRTNTZYS1pnTlZ3RTRFVTExc092?=
 =?utf-8?B?YUN2c2QxdEVzcjZIMTUyVXg0UXZlMjRjdGpqbUdIeGg1UFl1dDk5ems5eGhF?=
 =?utf-8?B?RnBtZGxycWRNNy9RcnFGSmJrZzc5NHpxYWJUMjAzNVpacm4vemttcDVwaklN?=
 =?utf-8?B?SHlsY0k0VlVlNTF6dGVYTWdCeVJGNlhOSTZaYzZac0V0RzJPWXJ3NVp2SFZH?=
 =?utf-8?B?dTRYeUgvUDN3NEFZcDZRVTZjWlFhVHdJVytlckY4Ykp2Qzl4bkVHanJFVVl5?=
 =?utf-8?B?cHFoc1NvUi9PWlArQ0w0ZjVrSzZCTjhaaVUwQnRYMWJRVnpoZHlSWGJZSUdN?=
 =?utf-8?B?anhyUGo1ejU0cDB0RFpYL0x0bHJteC9iUWI2MldWK2xhazBTcFFUbEV6Y2Ju?=
 =?utf-8?B?U3lVdXRPb0EvL3ErcXF2TjhFR3ZJbk9JOVFnTWNxVHRvcXNEWndyTHZUWG5X?=
 =?utf-8?B?NGlKSC9Idy9kZkg0NFNDT0dNbFVOa2tXM094eUhIbXVzRmFrUkZEQVFaWjM5?=
 =?utf-8?B?TlJQYlA0eGpyLzZVSzJuQzQyc2JMTitoWmFWdkZLUHN2aXdMV0twSm4wUVg5?=
 =?utf-8?B?NzBYVW5HQ1NFdzlUUllMYzZSNUhXQ1ZQdEZ6YXJLLzlFZEdjK3dRZHZwckJK?=
 =?utf-8?B?Vk9kMzVTOVVRbzVhVW1KaWRtOE4wbEhWc3RIS1g0VWJKZHVYMFVUNEVucS85?=
 =?utf-8?B?WHFBZmVhTGkrQ0Robkk2ejg1Yks2ekgreG1nMTlKRUVPUUtZbFl6UmtuNTVY?=
 =?utf-8?B?WVRvNEcxdmUvbHB2eElzSkRjdjBIVXU4emRodnowblJjdzgyZjAwWk5aYTU1?=
 =?utf-8?B?QlRlNU5QeEJ5QmhBOXNMcTVZSnJQdEVLQW81R1Z4TVFhOXE1dFVacVJsL3FV?=
 =?utf-8?B?WEVKMGRSZk9uSlo2NUIwb3NrU1dDY1hWWlBZMHUyMkcwa3hRc2I2akVtUEJt?=
 =?utf-8?B?TjBHNmQwM3dWRkZJSWxBNzZNZ0M0V3pGcDFYbWlXZHpIM3FjVG1UMEFCYkov?=
 =?utf-8?B?eGxXZTUzVVZ6UU5SYUFxK3F1TXFOZWdlaHhqZCtpZ2pIdGZmbWlEWDFVNjJT?=
 =?utf-8?B?eWp5L1d2ZjZyenJlZG14emhPbEsyUDRLRDM0OXBaVm9YazNhMk4rU3RtODVa?=
 =?utf-8?Q?nBG8GwylIABkValy/ONXE5aP1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dfb243-5938-40b8-b361-08daa0dda686
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 23:11:46.7940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHCktIE/AJK/PdGYPvc7JR8PWi/jFitHN12kgRQXUPtQxIIb1FHAG6a2wreRBWoVs+Fw/kQv1VDio2G5EXhOkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7104
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBTUQgc3lzdGVtcyBzdXBwb3J0IHplcm8gQ0JNIChjYXBhY2l0eSBiaXQgbWFzaykgZm9yIGNh
Y2hlIGFsbG9jYXRpb24uDQo+IFRoYXQgaXMgcmVmbGVjdGVkIGluIHJkdF9pbml0X3Jlc19kZWZz
X2FtZCgpIGJ5Og0KPiANCj4gICAgICAgICByLT5jYWNoZS5hcmNoX2hhc19lbXB0eV9iaXRtYXBz
ID0gdHJ1ZTsNCj4gDQo+IEhvd2V2ZXIgZ2l2ZW4gdGhlIHVuaWZpZWQgY29kZSBpbiBjYm1fdmFs
aWRhdGUoKSwgY2hlY2tpbmcgZm9yOg0KPiAgICAgICAgIHZhbCA9PSAwICYmICFhcmNoX2hhc19l
bXB0eV9iaXRtYXBzDQo+IA0KPiBpcyBub3QgZW5vdWdoIGJlY2F1c2Ugb2YgYW5vdGhlciBjaGVj
ayBpbiBjYm1fdmFsaWRhdGUoKToNCj4gDQo+ICAgICAgICAgaWYgKCh6ZXJvX2JpdCAtIGZpcnN0
X2JpdCkgPCByLT5jYWNoZS5taW5fY2JtX2JpdHMpDQo+IA0KPiBUaGUgZGVmYXVsdCB2YWx1ZSBv
ZiByLT5jYWNoZS5taW5fY2JtX2JpdHMgPSAxLg0KPiANCj4gTGVhZGluZyB0bzoNCj4gDQo+ICAg
ICAgICAgJCBjZCAvc3lzL2ZzL3Jlc2N0cmwNCj4gICAgICAgICAkIG1rZGlyIGZvbw0KPiAgICAg
ICAgICQgY2QgZm9vDQo+ICAgICAgICAgJCBlY2hvIEwzOjA9MCA+IHNjaGVtYXRhDQo+ICAgICAg
ICAgICAtYmFzaDogZWNobzogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1lbnQNCj4gICAgICAg
ICAkIGNhdCAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9sYXN0X2NtZF9zdGF0dXMNCj4gICAgICAgICAg
IE5lZWQgYXQgbGVhc3QgMSBiaXRzIGluIHRoZSBtYXNrDQo+IA0KPiBGaXggdGhlIGlzc3VlIGJ5
IGluaXRpYWxpemluZyB0aGUgbWluX2NibV9iaXRzIHRvIDAgZm9yIEFNRC4NCj4gQWxzbywgcmVt
b3ZlIHRoZSBkZWZhdWx0IHNldHRpbmcgb2YgbWluX2NibV9iaXRzIGFuZCBpbml0aWFsaXplIGl0
IHNlcGFyYXRlbHkuDQo+IA0KPiBBZnRlciB0aGUgZml4DQo+ICAgICAgICAgJCBjZCAvc3lzL2Zz
L3Jlc2N0cmwNCj4gICAgICAgICAkIG1rZGlyIGZvbw0KPiAgICAgICAgICQgY2QgZm9vDQo+ICAg
ICAgICAgJCBlY2hvIEwzOjA9MCA+IHNjaGVtYXRhDQo+ICAgICAgICAgJCBjYXQgL3N5cy9mcy9y
ZXNjdHJsL2luZm8vbGFzdF9jbWRfc3RhdHVzDQo+ICAgICAgICAgICBvaw0KPiANCj4gTGluazog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDUxNzAwMTIzNC4zMTM3MTU3LTEtDQo+
IGVyYW5pYW5AZ29vZ2xlLmNvbS8NCj4gRml4ZXM6IDMxNmU3ZjkwMWY1YSAoIng4Ni9yZXNjdHJs
OiBBZGQgc3RydWN0IHJkdF9jYWNoZTo6YXJjaF9oYXNfe3NwYXJzZSwNCj4gZW1wdHl9X2JpdG1h
cHMiKQ0KPiBDby1kZXZlbG9wZWQtYnk6IFN0ZXBoYW5lIEVyYW5pYW4gPGVyYW5pYW5AZ29vZ2xl
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3RlcGhhbmUgRXJhbmlhbiA8ZXJhbmlhbkBnb29nbGUu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQo+
IFJldmlld2VkLWJ5OiBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQt
Ynk6IEphbWVzIE1vcnNlIDxqYW1lcy5tb3JzZUBhcm0uY29tPg0KPiBSZXZpZXdlZC1ieTogUmVp
bmV0dGUgQ2hhdHJlIDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTog
RmVuZ2h1YSBZdSA8ZmVuZ2h1YS55dUBpbnRlbC5jb20+DQo=
