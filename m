Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B298636886
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbiKWSSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239580AbiKWSSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:18:03 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2ECB4A;
        Wed, 23 Nov 2022 10:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669227446; x=1700763446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RzoJOd2khrZRmGvTV7KS+/XkgylwbnnmOQD+3B/Sz7Q=;
  b=bDpfs2zWrNUwNRf8DGnUaDHbucXE6Z1xT3pbl91D3XQDibherK6PHYvt
   OGx/M/7NJu3H4CXl2pLGRCSGbW0j8Krjv4XfPcvjVm3OdmGHsF8g8rALC
   kcIwO5j1GVnHmG8XeYAaMgRRLDpXoX0zWnDnckp1XClXGyqjokE/6JNX3
   ueL+xU7cVWSdVjG4Z1/U8GLQkcieuvJexFSoM1ld1uDC7c/mxIFgdB+vU
   qa7VXIFH66ukeHB29OS/6ZvJ3GoHhaVXouTTcvJi/Xk5JWm+M47FATuA3
   G8qxnR8YgxzTaSswf4W9UzXn10uV4IVHTJBEakfABTd+oDcUD9BIOGxqH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311767359"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="311767359"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 10:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="705454774"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="705454774"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 23 Nov 2022 10:17:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 23 Nov 2022 10:17:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 10:17:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 10:17:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5CJWd8OtP+5lLYIh4NDQB+KC3i5q3VE/w0UuKIcZ5RrJxKVBLvVhAhYlG8BPyEegw6Se+M+XIfsOaeaJEltIJy9wCo2Zq6SX8dsat3T5nfVMmOj+x1P4DGQnXIpZJ+VncyTIMi6Sps9dxjgV5hKR+cr13WYKMxaNqIPDtE2FEUDsde+2VguhQ8CdvifHibf08SKlmuYMVFDQuxkdSQqUVRyJg19XYhkFvGFTfT+T33JAHNo1EsQaS3szV2J3C/xTRW8mlFHFRnTMJTRmFuPTcRg5y/1gtVjWhJZY3FZBNPrGc5/mJqscM7iKt32N6Q1Jmq6NppZmLcNK3LcEwpbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzoJOd2khrZRmGvTV7KS+/XkgylwbnnmOQD+3B/Sz7Q=;
 b=H02dlfn6FMeSk/tmE0oYvxlLJF50Q1C4JCDZyYm6p/SpVoMVmEt11zk81Of5mP4WwY7KC5NUeTjajsNmUHFdXP/Cd3lUHe1kiKDmqaeRGaV/VYMlfnaDMJuwVHtJ3rlQqYl9oxuK1uau9pDpLQtPIjKfW7Qp63n26d7nq1qCsvqWxEpguTMc/hR0hVS5+R7ZYwm5yU6TTAaorCXYRlVsmvNOsZIZnicEJyl9LkCVxhKwc9yKUZaoyI+LwYj44ipTJn3WjryQppWCLdbWVuoxwoEjiOIXePzucHsxSPLUh7gJw2AIXW5cPPaejGgPtRhMt6DERNuJgVLnmQvtFVab/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Wed, 23 Nov
 2022 18:17:23 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%7]) with mapi id 15.20.5813.018; Wed, 23 Nov 2022
 18:17:23 +0000
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
Subject: RE: [PATCH v8 03/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Thread-Topic: [PATCH v8 03/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Thread-Index: AQHY8Igkg6JDyXYZm0uYLFb6TdhVHK5M6qDw
Date:   Wed, 23 Nov 2022 18:17:23 +0000
Message-ID: <IA1PR11MB60979EB9FBE4C95381BF9F8A9B0C9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759201032.3281208.8545863740733338256.stgit@bmoger-ubuntu>
In-Reply-To: <166759201032.3281208.8545863740733338256.stgit@bmoger-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|CO6PR11MB5586:EE_
x-ms-office365-filtering-correlation-id: 6573b780-dbeb-44ca-511f-08dacd7ef7bf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cEsc7f+aevAsVKWyhoFVyl/bFZ62H7vrNiffBdjvP9fIEpxl8FPxOw+HlZwC423gtaw7oOosqescN80F/47X0XoAlepRM2AbOksp+wFlf8Er9NQdE3xQq48WA+EC0qNuQwEOhN+a6v7Zvw0buDw+tn40Ra0NvxQQkcL0JO6UnRXdsstQGmVmWsYE5lE2pFoTFP6AuUl475Cz1gl2DjVdBinkN0GhnyfSy34h4DUn/Stb0GR9Ki8KyWpw3PeibLSi9fHspd+1WnGNyLtbEHGlyZ6ewN8B9qfXp+kUr3l+qFagcgQQc0aCSCLoaRovP5F/P2elbWEcyw4LJPDK00vxFhit3XK1z8KuB9BYWdj7+NgH2YNW5V1Ut3aahDHtSNORHw1I2M9/91GZBEMj24LeLLgRNs2aC6FNNuLRKCVZUXdAHSULR/+PNjTWjOLFgDggG/1d3qeKzeTbt7ZNWxSg5f4VH4oIUsWS/h29aT6vvRA9AwY4+DO6pfDFVWw42jdpjnV2kdh6ODqhy/XHKNsP1u9k4z16l5XDKTfkMnak2n/vA57sF8/ssFi8VfC1M4IojnovJNAy7cLEE7J7+P7nrBIaxr/6019gHBESnhYwQtHTftsUdSZM1XUQuSbrEgq3RRBATxIhuDg5/oOcOfyq0IkjN/p1JNI6Jy5VCIx4q4SNxQWwztwsAcx7dF8bxsJ/Rk2Lfa40x2WmQM3GVH8QOsLk/qQHg843JGCajX1zvr01J6fAaUzDACcuqaoO0p6eSt2+r46eaQxyIn+tVunhiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199015)(83380400001)(86362001)(54906003)(6506007)(110136005)(71200400001)(966005)(55016003)(82960400001)(38070700005)(33656002)(122000001)(38100700002)(9686003)(186003)(8936002)(7416002)(5660300002)(52536014)(7696005)(478600001)(8676002)(26005)(66556008)(66946007)(66446008)(66476007)(4326008)(76116006)(64756008)(41300700001)(2906002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b042VFlaaCswdkJYaXpnRmNtSnVSSjVhUmY3RjZJcmFLUlJnL3QvcFcxbWlF?=
 =?utf-8?B?N20xaUl2TUprT2RCZXNBS09IU1MvT1RJcTZCNWpJM1UyL2ZQbC8wQnlIb2Iw?=
 =?utf-8?B?VUwxeFJaUTRNSzdWUWoxeXdBOTc5YXVQeEFZc1JoQ0VqanlkL25SRmplRVlO?=
 =?utf-8?B?OWJOczhJWUtUaWgzTTlic3RjbVBlejhlcVBDR3ByYTlsZDlOc21LbjlHcTRr?=
 =?utf-8?B?bjNxbmhmcEtZU1JEN29jUnFZb2U2TDRieDlQOXZVZlloUGpRTGpZbkl5Uzgz?=
 =?utf-8?B?b2o2OWJ3bVNoNytjZmwxbFJjZi9hZUpFZXR2eHljWDVrcVVlbzV0NXBmSGZm?=
 =?utf-8?B?Tlh0V2JYLzh5ZUJON01wczQ4NmJIU3N6V2dKRjBldTdYTXZGZEtYYmNFQ3J6?=
 =?utf-8?B?Um4wSkEwRm9hNS93aHJEMlhuTjV1d0xrWG1Jc1BiVjRIME4vMVBlZ3NXT2Va?=
 =?utf-8?B?Z01mVEJOdVdZa1RSbHI2R1NNSkljdVNOcHp6ZEtTZmZHV1FEcWJTYUl2Mk9F?=
 =?utf-8?B?U0kwNDQxclVPSWUyem0wRzhqM2FZOURTdjRocm9vUlBmMXBKelVmZnJHV0tS?=
 =?utf-8?B?M3doclFYVG1XVEZuREt6ZUJkSUcvNEpDRzVTd21melprLzVSR3A3cC95ckhJ?=
 =?utf-8?B?UHEyWTJXUFZHUUNVeGdvS3RWUmpJWDFJdStvUDJUcTlDL0pDU2tHTUNYOVdB?=
 =?utf-8?B?NUhXYmRiMmNUV3RSSW9qaHFmRGcvWnd1ekIwYkVDekgydHFiYUQ5N2VOUS9G?=
 =?utf-8?B?ZVk1MlNHeG0wS2JTWS8rMTN4ZUMxZ3RrWHV0Mkg3NHFaZmx4bVc5Uzc0WXc0?=
 =?utf-8?B?MHpIUjRGT2owZUxXeEJCRmgzTnZpOWQraGNNS0xzRnlwdXBIQ284L3c4OERD?=
 =?utf-8?B?RHg3MlVDOXVveWZhWUtpa0dKN0xjb2RMQWhMLzRwRHl1dkR6SzNielpQU1d1?=
 =?utf-8?B?aWJmWTdLWXl6Ri9tbDlxWHlDRXhHMU94SFlqbndrTVdNOEZpQWprcTg5azNP?=
 =?utf-8?B?aFNma2VnU1Z4OWVEYStuZmRwSWU5UGE1ODh4OFB1K0NKQ2RhTXJhWU9adlVC?=
 =?utf-8?B?NEpQam12VUZmaU13S0c0M2dzbGhTMlJqR1pxc21XbzBLUmVFSzBMZWVGMko1?=
 =?utf-8?B?R1B0VTJaQ2pnOWxRYmw4NTFJcnNMMFNhZ0lsZnp4VkZONmJ0Vlkwbmc1d3BK?=
 =?utf-8?B?endmSGsvQTh3TW9DT2NyanBSM2lETjBMYW41eDJORkVQMkJiSmx6QnQxOER3?=
 =?utf-8?B?aGNmQ2Rvb3BiYUltYnRvTGpRYUVQTmVsVlloRGZLQXpEMnV0U3JhcTBYaVBY?=
 =?utf-8?B?aEdZTFcxa1NjZDExUFgwaHdtMHhIYWJUeUw3N0Qwd2hXaExGcUlEM09WYjBQ?=
 =?utf-8?B?VTVhbm1kZHhOWi8rd2E0TURVUWEvUEtQbUM4cVpXeFRLczB1ZmxRU3AzQ0h0?=
 =?utf-8?B?cytMNlBaV0VpUzFlc2M1NXl1ekhDSnpWNXZBVDV1eDE0WXdQMU9DcXJ0aDBz?=
 =?utf-8?B?ZWk2OUJFTm5KaFJBQmRnb3JUb3lVUE9vV3h2VGZCUThHbmpwdzU5TTZtYU82?=
 =?utf-8?B?dTlkOGphVnlVMTBodVBLelFzS3JkK203Wnd2RlJENEdIQnhXczNTNmtKNndY?=
 =?utf-8?B?M0gvdExJVy9xRUlQd1VOVUtXSm10akJpTlRkRzJPWURZRWNHT1lkQkxLbFFI?=
 =?utf-8?B?c0lhZlQ0M0ZaN0oyYWE3R3JicnRsTVQvbVpzaytFZlpPWkpucnZEMlNCSUFj?=
 =?utf-8?B?YW5RRUp1eW8rSWN1bkI4NnlCeDFnT3VxQk5PY2FQNkFYcWFqRWVhaXcwUk5K?=
 =?utf-8?B?NXRkbVhEWFA1OVd1Mkd2N0g3TjdtZkdDSTJaZjZwaVlRZVdLaU9HUnRJQ2tW?=
 =?utf-8?B?aFI5TFJsYkVzVzlXbTFiVnUveFFKeXk0VUNZT3J0RW1UMS8rcjFtTU96WGI2?=
 =?utf-8?B?VjZySnJvQTEyUHRhZFZEYnJuRHRhOTMxY0k5RjBoSGtLOCtXVldvRkJuc3FR?=
 =?utf-8?B?YnA3T1JVZE5xeCtpc2QxNWcyczZLdjhHTFFNdmVPaFhkMFMxRjlKaUY5NWRB?=
 =?utf-8?B?aEl0ZWhBVXIxYVdicjR6dHYycmlMQU1JdWpnMjdmam80Ty9vUkc4VmRUSkp4?=
 =?utf-8?Q?APerV6KgIexSHB3Jz3cpQfrZz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6573b780-dbeb-44ca-511f-08dacd7ef7bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 18:17:23.2274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MrZXJ9HhKWYYSdLwGENAFiaod81p4airv/WFDORnWpHhVDi/I/VzkeuuEnXhdOi8BXx3yGJzJeIU2jnlaLjktA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5586
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJhYnUsDQoNCj4gTmV3ZXIgQU1EIHByb2Nlc3NvcnMgc3VwcG9ydCB0aGUgbmV3IGZlYXR1
cmUgQmFuZHdpZHRoIE1vbml0b3JpbmcgRXZlbnQNCj4gQ29uZmlndXJhdGlvbiAoQk1FQykuDQo+
IA0KPiBUaGUgZmVhdHVyZSBzdXBwb3J0IGlzIGlkZW50aWZpZWQgdmlhIENQVUlEIEZuODAwMF8w
MDIwX0VCWF94MCAoRUNYPTApLg0KPiBCaXRzICAgIEZpZWxkIE5hbWUgICAgRGVzY3JpcHRpb24N
Cj4gMyAgICAgICBFVlRfQ0ZHICAgICAgIEJhbmR3aWR0aCBNb25pdG9yaW5nIEV2ZW50IENvbmZp
Z3VyYXRpb24gKEJNRUMpDQo+IA0KPiBDdXJyZW50bHksIHRoZSBiYW5kd2lkdGggbW9uaXRvcmlu
ZyBldmVudHMgbWJtX3RvdGFsX2J5dGVzIGFuZA0KPiBtYm1fbG9jYWxfYnl0ZXMgYXJlIHNldCB0
byBjb3VudCBhbGwgdGhlIHRvdGFsIGFuZCBsb2NhbCByZWFkcy93cml0ZXMNCj4gcmVzcGVjdGl2
ZWx5LiBXaXRoIHRoZSBpbnRyb2R1Y3Rpb24gb2Ygc2xvdyBtZW1vcnksIHRoZSB0d28gY291bnRl
cnMgYXJlIG5vdA0KPiBlbm91Z2ggdG8gY291bnQgYWxsIHRoZSBkaWZmZXJlbnQgdHlwZXMgb2Yg
bWVtb3J5IGV2ZW50cy4gV2l0aCB0aGUgZmVhdHVyZQ0KPiBCTUVDLCB0aGUgdXNlcnMgaGF2ZSB0
aGUgb3B0aW9uIHRvIGNvbmZpZ3VyZSBtYm1fdG90YWxfYnl0ZXMgYW5kDQo+IG1ibV9sb2NhbF9i
eXRlcyB0byBjb3VudCB0aGUgc3BlY2lmaWMgdHlwZSBvZiBldmVudHMuDQo+IA0KPiBFYWNoIEJN
RUMgZXZlbnQgaGFzIGEgY29uZmlndXJhdGlvbiBNU1IsIFFPU19FVlRfQ0ZHICgweGMwMDBfMDQw
MGggKw0KPiBFdmVudElEKSB3aGljaCBjb250YWlucyBvbmUgZmllbGQgZm9yIGVhY2ggYmFuZHdp
ZHRoIHR5cGUgdGhhdCBjYW4gYmUgdXNlZCB0bw0KPiBjb25maWd1cmUgdGhlIGJhbmR3aWR0aCBl
dmVudCB0byB0cmFjayBhbnkgY29tYmluYXRpb24gb2Ygc3VwcG9ydGVkDQo+IGJhbmR3aWR0aCB0
eXBlcy4gVGhlIGV2ZW50IHdpbGwgY291bnQgcmVxdWVzdHMgZnJvbSBldmVyeSBiYW5kd2lkdGgg
dHlwZSBiaXQNCj4gdGhhdCBpcyBzZXQgaW4gdGhlIGNvcnJlc3BvbmRpbmcgY29uZmlndXJhdGlv
biByZWdpc3Rlci4NCj4gDQo+IEZvbGxvd2luZyBhcmUgdGhlIHR5cGVzIG9mIGV2ZW50cyBzdXBw
b3J0ZWQ6DQo+IA0KPiA9PT09ICAgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+IEJpdHMgICAgRGVzY3JpcHRpb24NCj4gPT09PSAgICA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
PiA2ICAgICAgIERpcnR5IFZpY3RpbXMgZnJvbSB0aGUgUU9TIGRvbWFpbiB0byBhbGwgdHlwZXMg
b2YgbWVtb3J5DQo+IDUgICAgICAgUmVhZHMgdG8gc2xvdyBtZW1vcnkgaW4gdGhlIG5vbi1sb2Nh
bCBOVU1BIGRvbWFpbg0KPiA0ICAgICAgIFJlYWRzIHRvIHNsb3cgbWVtb3J5IGluIHRoZSBsb2Nh
bCBOVU1BIGRvbWFpbg0KPiAzICAgICAgIE5vbi10ZW1wb3JhbCB3cml0ZXMgdG8gbm9uLWxvY2Fs
IE5VTUEgZG9tYWluDQo+IDIgICAgICAgTm9uLXRlbXBvcmFsIHdyaXRlcyB0byBsb2NhbCBOVU1B
IGRvbWFpbg0KPiAxICAgICAgIFJlYWRzIHRvIG1lbW9yeSBpbiB0aGUgbm9uLWxvY2FsIE5VTUEg
ZG9tYWluDQo+IDAgICAgICAgUmVhZHMgdG8gbWVtb3J5IGluIHRoZSBsb2NhbCBOVU1BIGRvbWFp
bg0KPiA9PT09ICAgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQo+IA0KPiBCeSBkZWZhdWx0LCB0aGUgbWJtX3RvdGFsX2J5dGVzIGNvbmZp
Z3VyYXRpb24gaXMgc2V0IHRvIDB4N0YgdG8gY291bnQgYWxsIHRoZQ0KPiBldmVudCB0eXBlcyBh
bmQgdGhlIG1ibV9sb2NhbF9ieXRlcyBjb25maWd1cmF0aW9uIGlzIHNldCB0bw0KPiAweDE1IHRv
IGNvdW50IGFsbCB0aGUgbG9jYWwgbWVtb3J5IGV2ZW50cy4NCj4gDQo+IEZlYXR1cmUgZGVzY3Jp
cHRpb24gaXMgYXZhaWxhYmxlIGluIHRoZSBzcGVjaWZpY2F0aW9uLCAiQU1ENjQgVGVjaG5vbG9n
eQ0KPiBQbGF0Zm9ybSBRdWFsaXR5IG9mIFNlcnZpY2UgRXh0ZW5zaW9ucywgUmV2aXNpb246IDEu
MDMgUHVibGljYXRpb24NCj4gDQo+IExpbms6IGh0dHBzOi8vd3d3LmFtZC5jb20vZW4vc3VwcG9y
dC90ZWNoLWRvY3MvYW1kNjQtdGVjaG5vbG9neS0NCj4gcGxhdGZvcm0tcXVhbGl0eS1zZXJ2aWNl
LWV4dGVuc2lvbnMNCj4gTGluazogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVn
LmNnaT9pZD0yMDY1MzcNCj4gU2lnbmVkLW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBh
bWQuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmggfCAg
ICAxICsNCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvY3B1aWQtZGVwcy5jICAgfCAgICAxICsNCj4g
IGFyY2gveDg2L2tlcm5lbC9jcHUvc2NhdHRlcmVkLmMgICAgfCAgICAxICsNCj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vY3B1ZmVhdHVyZXMuaA0KPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1
cmVzLmgNCj4gaW5kZXggZDY4YjRjOWMxODFkLi42NzMyY2EwMTE3YmUgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmgNCj4gKysrIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vY3B1ZmVhdHVyZXMuaA0KPiBAQCAtMzA2LDYgKzMwNiw3IEBADQo+ICAjZGVmaW5l
IFg4Nl9GRUFUVVJFX1JTQl9WTUVYSVRfTElURQkoMTEqMzIrMTcpIC8qICIiIEZpbGwgUlNCIG9u
IFZNDQo+IGV4aXQgd2hlbiBFSUJSUyBpcyBlbmFibGVkICovDQo+ICAjZGVmaW5lIFg4Nl9GRUFU
VVJFX0NBTExfREVQVEgJCSgxMSozMisxOCkgLyogIiIgQ2FsbCBkZXB0aA0KPiB0cmFja2luZyBm
b3IgUlNCIHN0dWZmaW5nICovDQo+ICAjZGVmaW5lIFg4Nl9GRUFUVVJFX1NNQkEJCSgxMSozMisx
OSkgLyogU2xvdyBNZW1vcnkNCj4gQmFuZHdpZHRoIEFsbG9jYXRpb24gKi8NCj4gKyNkZWZpbmUg
WDg2X0ZFQVRVUkVfQk1FQwkJKDExKjMyKzIwKSAvKiBBTUQgQmFuZHdpZHRoDQo+IE1vbml0b3Jp
bmcgRXZlbnQgQ29uZmlndXJhdGlvbiAoQk1FQykgKi8NCj4gDQo+ICAvKiBJbnRlbC1kZWZpbmVk
IENQVSBmZWF0dXJlcywgQ1BVSUQgbGV2ZWwgMHgwMDAwMDAwNzoxIChFQVgpLCB3b3JkIDEyICov
DQo+ICAjZGVmaW5lIFg4Nl9GRUFUVVJFX0FWWF9WTk5JCQkoMTIqMzIrIDQpIC8qIEFWWCBWTk5J
DQo+IGluc3RydWN0aW9ucyAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9j
cHVpZC1kZXBzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NwdWlkLQ0KPiBkZXBzLmMNCj4gaW5k
ZXggYzg4MWJjYWZiYTdkLi40NTU1Zjk1OTZjY2YgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tl
cm5lbC9jcHUvY3B1aWQtZGVwcy5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY3B1aWQt
ZGVwcy5jDQo+IEBAIC02OCw2ICs2OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY3B1aWRfZGVw
IGNwdWlkX2RlcHNbXSA9IHsNCj4gIAl7IFg4Nl9GRUFUVVJFX0NRTV9PQ0NVUF9MTEMsDQo+IAlY
ODZfRkVBVFVSRV9DUU1fTExDICAgfSwNCj4gIAl7IFg4Nl9GRUFUVVJFX0NRTV9NQk1fVE9UQUws
DQo+IAlYODZfRkVBVFVSRV9DUU1fTExDICAgfSwNCj4gIAl7IFg4Nl9GRUFUVVJFX0NRTV9NQk1f
TE9DQUwsDQo+IAlYODZfRkVBVFVSRV9DUU1fTExDICAgfSwNCj4gKwl7IFg4Nl9GRUFUVVJFX0JN
RUMsCQkJWDg2X0ZFQVRVUkVfQ1FNX0xMQyAgIH0sDQoNClNob3VsZG4ndCBYODZfRkVBVFVSRV9C
TUVDIHJlYWxseSBkZXBlbmQgb24gWDg2X0ZFQVRVUkVfQ1FNX01CTV9MT0NBTCBhbmQgX1RPVEFM
Pw0KDQpDUU1fTUJNX0xPQ0FMIGFuZC9vciBfVE9UQUwgY2FuIGJlIGRpc2FibGVkIGJ1dCBDUU1f
TExDIGNhbiBzdGlsbCBiZSBlbmFibGVkLiBJbiB0aGlzDQpjYXNlLCBCTUVDIHNob3VsZG4ndCBi
ZSBlbmFibGVkLCByaWdodD8gQnV0IHdpdGggdGhpcyBwYXRjaCwgQk1FQyB3aWxsIGJlIGVuYWJs
ZWQgYnV0IGl0IHdvbid0DQp3b3JrIHdlbGwgYXMgQ1FNX01CTV9UT1RBTC9fTE9DQUwgYXJlIG5v
dCBlbmFibGVkLg0KDQpZb3UgbWF5IHJlbW92ZSB0aGUgYWJvdmUgbGluZSBhbmQgYWRkIHRoZXNl
IHR3byBsaW5lczoNCg0KKwl7IFg4Nl9GRUFUVVJFX0JNRUMsCQkJWDg2X0ZFQVRVUkVfQ1FNX01C
TV9UT1RBTCAgIH0sICANCisJeyBYODZfRkVBVFVSRV9CTUVDLAkJCVg4Nl9GRUFUVVJFX0NRTV9N
Qk1fTE9DQUwgICB9LCAgDQoNClRoYW5rcy4NCg0KLUZlbmdodWENCg==
