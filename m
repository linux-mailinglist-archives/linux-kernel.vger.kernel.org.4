Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653F16C1BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjCTQii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjCTQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:38:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300832F046;
        Mon, 20 Mar 2023 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679329961; x=1710865961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tr6nF2FSqWW/AEaHg9Xs8l6QB50f1mwRSFX9WLNj9Xc=;
  b=cAvR4KbThn6iqc/i4f6ZSG+Q0nvc6Lkr9la2l4gP8v2ZsTd/a6xBQxsX
   e0OlrRDFPSMRJPfX5teL8sXoek4vJb02/+ClemqmicvlGTE5qqkZOWn7o
   BK53PgkwvCq1LKnKwf+znmEPieS4d7wrwe+JHJNZtObhHbeOX/C65t26P
   haUUXawcf08pls8rx+OqdkkaYdtYwLnFL3wHvacxNCZvMydolgVhVCVGv
   1fM27aa9Ei25ZFPX6IkHoDD8pPemqaARx4sz3/4tpOuw/KLZtifBb9//g
   zTjjjs68FRUkjorTGKWyy2UawWQ6SGo2zZNnSuRQ862caqDncMXjwalXX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="340257985"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="340257985"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 09:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="713636488"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="713636488"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 20 Mar 2023 09:32:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 09:32:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 09:32:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 09:32:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpEh5SSgH2K+bNRakjfR5dtO9rrICFSHLyGmzvEhxePP52Lcf8S+rMnGqN2dUKj2gUaTGdhdPkzbktJXBOuSVf0G0SvOc7jJGQ2uT3JyAhb+6VocvpLIxxQjHsGngMsQTKtFREqUqDciKjyY9a7DvQ7UFTkiPPB99v//yrVzDxWu8EaZ5swtAXg+giooHaimaMy98uLK1MmE1WY+iOaOP1uvfQj1cJCbOy2mWwt0n7of3tZyAcy6O1FZm9mEiaaZCckt5MX/0qQdKxFf/lCgEYi1/39b7p2INOZXm55RL93I0OlbnsOXv2nfWyJzAikxay0HK3HyheXazR9FvZFb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tr6nF2FSqWW/AEaHg9Xs8l6QB50f1mwRSFX9WLNj9Xc=;
 b=AV9w4Wd20L1hRxElfZ73K+3qnXY0/0itpNaqfpiAd7MV5MW820zfvSMp+U2n+fPRNfzn8/HWzdvti+bLdOrV+MWKhgZj1p6CsH+Hn3GzbhtdHm9yEb+pvMwHIvdnGkxGK8J33YJFEIvQGLemKHon4Thx6dlNDlpcqzvXOk57ZPF6HmccsESw6Gq9xKMf0InOvGJJQ0zrzN+EKLZI0l7vJl0x6m7whbZr0va5JthhDFj1r9nIBNKmKpWYnToWulEJ0witA3sxgoAXddro0atAvjw1KDX1WLTZPdtclT4A5OAF1mNMQcYFuGSvJL2UIQxqSyRRvesV3ev5dhFaDepydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5168.namprd11.prod.outlook.com (2603:10b6:a03:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:32:35 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:32:35 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jaylu102@amd.com" <jaylu102@amd.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: RE: [PATCH] ACPI: APEI: EINJ: warn on invalid argument when
 explicitly indicated by platform
Thread-Topic: [PATCH] ACPI: APEI: EINJ: warn on invalid argument when
 explicitly indicated by platform
Thread-Index: AQHZWKLi/0R39JELJU+i6OTnfLpOoa7/fDzwgAN44wCAAOuOAA==
Date:   Mon, 20 Mar 2023 16:32:35 +0000
Message-ID: <SJ1PR11MB60831F4A66DB77095B4314FDFC809@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230317073310.4237-1-xueshuai@linux.alibaba.com>
 <SJ1PR11MB60836145DD10108B1FE13A4FFCBD9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <91796ce2-2f63-4b07-3e44-dc2a2a98615e@linux.alibaba.com>
In-Reply-To: <91796ce2-2f63-4b07-3e44-dc2a2a98615e@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5168:EE_
x-ms-office365-filtering-correlation-id: 0db57fd5-753e-4e35-9fa0-08db2960b659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDU4l1AqC++3AXEX1YTY2LxnG3EWFsUcnALr3EXzq4lcv0BbKFlkjvrcjftYSQ+O3LUcf9JnZZP+8GLoQF0w6e8VnHe9D4ScQHINEyVRbqSmQToCI2ALdEGK0n6vdd3vLXUKSTzA8vxDwoQAu/eZeYDysVl04pg8AusWaFZSNEbnj+t3+4+RGWd2pvMmcty6ugZQLANfX0RdT+9nrvaUBMDr9Eehc80Acd6UFtEp86UI4IpKdGE7QlVMbw3KhWhwMRxcBVkvfr4bWf+wkiJpWRfCWfvP9dco86woA5UP9v4xw8Rqb6wztIIWnZrey1iWI+uzUnIpPGdMVn+qNJYUGakOv4q+y+ewoIzPym2iV4iJgPRzmn3U5PA2T5b68cG2FiXMdwiXlL9POcNFJQf9PJuC8CNoOhL4EMX+OGNddLqCR5JtdP98remqbdRESUhYJFbTR18Y8k2JkpmoKqzcM/89lUC/S7xopXTnGDMAMFtRiaqefgTK4ECOf22gNnvlMxZuED5ykxtdToqYcQPrnKyyZHRbrtFVZ2xj/5+pxnVRPnAH0xQ0JInhzpJeivHUk2hwQWpQ0bNj49rOfs1JexpxKc7fyZ3D2TbgW/KSsS17irfpTSWVI5x6M3SBGfZlFq4VEmqLaa3jiprjFN1qRHi96caSn97efWiQ29ZDnHq+NZDeCKsbkTOHMfmbLm/YypAdO4Bybd4+bwzXM+qckg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199018)(66476007)(6916009)(66446008)(4744005)(8676002)(76116006)(4326008)(66556008)(66946007)(41300700001)(6506007)(5660300002)(7416002)(83380400001)(52536014)(26005)(186003)(8936002)(64756008)(9686003)(54906003)(316002)(38070700005)(71200400001)(478600001)(7696005)(2906002)(55016003)(33656002)(86362001)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGc1U2YwbFE0UGgydEFpSnJQYU9aK3NQRW15dnFzQ1pZQlpzUkJlbTVFVFpq?=
 =?utf-8?B?K2h0VTdiRGhZVmphWWl6RzIyK3hTd0o5S1pwRit1YVNZRUh2OUxUS1hIcy9O?=
 =?utf-8?B?ZDVBKzg2N3lrVThUa0g4bjFLOFRheUdpQUdqdGJmMjBJckZSK1lEdmRkclIr?=
 =?utf-8?B?RkUzaTlYWEtaRVRCVmY1L0w3SEN2NzNTNHYxdmlsZ05qR0ZneWI1bmJUSkNi?=
 =?utf-8?B?SjErSlJjNkZFUndyeWtRVmF3cVB2THZrMXdLeE9JendQQ2g1ZjZ3L1pYQ1hz?=
 =?utf-8?B?bStPZk5ZT05rYnZQY3pCMXgydzZXU2JYR2M5Z1Z0TXZCaWp2UXVvcWdKTE12?=
 =?utf-8?B?TlY2Z2lPOW01c3lrVHJBMjErSm1PeFArYi9wK3YrYTQ3RTFrQ0kyTUIwT1pU?=
 =?utf-8?B?RmgyS2JrcVFnQzFvMERNUmJZUGVIc3NoSE1zWHBFcm95RndxYjAvUFY2SjZh?=
 =?utf-8?B?dlFCdzVtMXJIS0E4R2phNkhxR2VZbXEzYXQ3ZzJjdFN6ckVlRGdxVTlLMURU?=
 =?utf-8?B?TnI2djViQjBIV2FncGJhQk5GV0g5SVQvT3R6bDhrMm5rT1pMQmcrR1FtMUN0?=
 =?utf-8?B?OFJxdmpGeGhmTHJwaWNkR21renhJbXA4SXp6amJxV1VvalJEeU5lS0l5My9S?=
 =?utf-8?B?NG9pa1g4a09LWmNiYmUwemttSW5Sa1dLL1dkTTEwM2ZFeUxNR3RLV1drRlFQ?=
 =?utf-8?B?UVlVdVJNdllMcjN0bWlwaktJL1pOcHc1c2Y1UUFLQlVTMUZONitsZVJZelZq?=
 =?utf-8?B?bEhWY3ZOMk91WUNmYVFaV1pyNFY3bjFDRzhnTU9PcXZKeGpvRnB2ZCtURHB1?=
 =?utf-8?B?YUxlTDU0aEYzbmlnT0dWOEFkYy9kaVU5SkZEem5DdjE3bjd4R0xjOTJOZnFJ?=
 =?utf-8?B?ZTdMZng5VEFrL1RKd2F0OXkzVE5qTGdIWnN2dnArTU9vd0xRVHc3QUhmOUlr?=
 =?utf-8?B?TjZTdC9GYkxLT2NXSWEzSGozSDhrNklvNDZKRlhPd3hRWWpPbW15c2k5VkFL?=
 =?utf-8?B?eUZoTDJURWlscEJtQ2g1UlNHRGxTQVp4RlRRb2gwenFOc1BDSFluczdzMUpo?=
 =?utf-8?B?c1pmbWJlMTgzMG5kNmNldVJMcjNIVFNhNGVxb1ZMb0g2OHNYZ2puWS9CYlUz?=
 =?utf-8?B?UEoyT0NBVWdtMVY0MnZUeVNJbytJd05xNHZFWmMyMUkyRW92em1ZM3RkOWFU?=
 =?utf-8?B?VUN3V1E4NGs2M3p4dm5ZL3VqNEJpREwxZ2o5WFVwUHVtNUt2aHJvRDFXNTJX?=
 =?utf-8?B?OGpoOFkvd1pZUXRWVGZJRHlPWHYyK2g0Q3pCU0prUVBqN1pkV1VUdmp0UWli?=
 =?utf-8?B?M2x6S0t1V052MTNtTWJkc1pxa1ZkazZWSVhPTVoweDlnREcwYzJUQkJBL1Q3?=
 =?utf-8?B?TzZsOFZmZks1V1NSTzlIUU9SdkRLcHdEWllnaFY5Y3ZQWEhxNTJCbFV6YzZa?=
 =?utf-8?B?MmsxbGZVYjFEQTRyUm1ZdGJrRUoxUmZKaHhNTE9xSUVETWk1WE9Ha2JLRTFx?=
 =?utf-8?B?aEdHSy9oTk5lSS9nckxKcEpGMy8vZ2VTdGZWZFRXa3Uyc0w0NkVyWlprWWxj?=
 =?utf-8?B?dzF4dDZmenFxeVM5elFQOFg1N0lFb1pHcVBOR3dNTWdhYVhQWTlaRDRmYTBw?=
 =?utf-8?B?dUU0MDZ2a2dGZVp6K1EyU0QwZG1aaHlxWkt1OEpxK0tMYWx1cW1iTXdpd00v?=
 =?utf-8?B?eDBLVkJrWU9hSkFLZjhCWExMemdzcjVaS3JLRGE5cFlySXNYYjBKd2JoRlgy?=
 =?utf-8?B?emM0eWVTR1R3QVUxM0lOUzRLZHJWWnl6UGhCNWVTek1BUGxEQUppdDN3aUJm?=
 =?utf-8?B?RWo5MlJ2ZkdPWno1aHZtVFd6WUZRdi9pdEJOOW5mMmlSL0RJbkFaR3BVcGpT?=
 =?utf-8?B?YmFZeFBhcWxpcXJVM0VtTWJuZHVoakJvNUQrR2hJSENNdHlQU09CWkFFRGNU?=
 =?utf-8?B?S3RjM3Q4RDFUZ0svQ3U3TzBnQTBDRXp1UWtUNHBhSUJ2VHk2Ky8ya1pML3pV?=
 =?utf-8?B?R01adTJpNksrek4xY0UySmlERG5qNjZrbWROaHVPNmVGQTBzeU85WWhXVnRR?=
 =?utf-8?B?akNySmUrRFhlNmpxcDFVSkxRc3I2VjNWZ0dWYjNKa2RjQXJLTWpHV1IrUFd2?=
 =?utf-8?Q?HAR0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db57fd5-753e-4e35-9fa0-08db2960b659
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 16:32:35.5514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bKUwDEajOcGBA7bEIsGl8mwvXXEwiYisEGcxt861ZS6rcnOatk283oaRtRf7/ptofoboT5bAPGUZy9npZpZ47g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
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

Pj4gSSBkb24ndCBzZWUgaG93IHJlcG9ydGluZyAtRUJVU1kgZm9yIHRoZSAiVW5rbm93biBGYWls
dXJlIiBjYXNlIGlzDQo+PiBhY3R1YWxseSBiZXR0ZXIuDQo+DQo+IFRvbnksIGRpZCB5b3UgbWlz
dW5kZXJzdGFuZCB0aGlzIHBhdGNoPw0KPg0KPiBUaGUgb3JpZ2luYWwgY29kZSByZXBvcnQgLUVC
VVNZIGZvciBib3RoICJVbmtub3duIEZhaWx1cmUiIGFuZA0KPiAiSW52YWxpZCBBY2Nlc3MiIGNh
c2VzLg0KDQpJIG1peGVkIHVwIHdoYXQgd2FzIGFscmVhZHkgaW4gdGhlIGtlcm5lbCB3aXRoIHdo
YXQgdGhlIHBhdGNoIHdhcyBjaGFuZ2luZy4NCg0KPiBUaGlzIHBhdGNoIGludGVuZHMgdG8gcmVw
b3J0IC1FSU5WQUwgZm9yICJJbnZhbGlkIEFjY2VzcyIgY2FzZQ0KPiBhbmQga2VlcHMgcmVwb3J0
aW5nIC1FQlVTWSBmb3IgIlVua25vd24gRmFpbHVyZSIgY2FzZSB1bmNoYW5nZWQuDQo+IEFsdGhv
dWdoIC1FQlVTWSBmb3IgIlVua25vd24gRmFpbHVyZSIgY2FzZSBpcyBub3QgYSBnb29kIGNob2lj
ZS4NCj4gV2lsbCAtRUlPIGZvciAiVW5rbm93biBmYWlsdXJlIiBjYXNlIGJlIGJldHRlcj8NCg0K
SXMgdGhpcyBmb3Igc29tZSByZWFsIHVzZSBjYXNlPw0KDQpEbyB5b3UgaGF2ZSBhIEJJT1MgRUlO
SiBpbXBsZW1lbnRhdGlvbiB0aGF0IGlzIHJldHVybmluZyB0aGVzZSBkaWZmZXJlbnQgY29kZXM/
DQoNCldoYXQgd2lsbCB0aGUgdXNlciBkbyBkaWZmZXJlbnRseSBpZiB0aGV5IHNlZSB0aGVzZSBk
aWZmZXJlbnQgZXJyb3Igc3RyaW5ncz8NCg0KICAjIGVjaG8gMSA+IGVycm9yX2luamVjdA0KICAu
Li4gZGlmZmVyZW50IGVycm9yIG1lc3NhZ2VzIGhlcmUgLi4uDQoNCi1Ub255DQoNCg0K
