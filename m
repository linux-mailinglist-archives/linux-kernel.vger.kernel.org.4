Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A136A62550A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiKKIQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiKKIQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:16:18 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670B970182
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668154577; x=1699690577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y3IaNwiEysg/DVquFkT3tsnYp2Kx57MuE2wougyyp0U=;
  b=A4F0NQpAmtV5FjU5v00kNvWXOStkM2xy2WD7KJXgbWnjRjYG4Q4h5eyO
   xLPAiD6ZWYWL7XNyOIDykEEeF+kaN/CIFxCGaRXZCxEqMAuCGyCvmANPr
   83YptEPNQRORzKsMcZ2Rsi7im7Ojrrdx33heocLY4x/IgyqGUKo6u8pk6
   lMjmfHrsJnTnMsPeQcYyHRr0PV+JZzkl0hzWsGNfOR5O9ZInDqqrXXJFE
   bb/ciLpzL8+xt0QlzoQTba3me9gIl+39Sb4RYDKuRSHFfTikAaA7vldHA
   Zhc2xVzqfTPI+nQoVKdqy1QByOIqzm3/kPnFOhLQQDTqKsaGGyRYXPkqN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294912042"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="294912042"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 00:16:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="615418563"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="615418563"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 11 Nov 2022 00:16:10 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 00:16:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 11 Nov 2022 00:16:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 11 Nov 2022 00:16:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYHJNb7yyzCiK4USFC9VEev6hi84jPAn5toQ7duGABGtmSTM1/IcoXwi6sAkMdMDQ0qfy8OwHkXyamviitHJThvsFDHk7pdE5sRzGfXF8ZK8qbiV71sVZCMskLxEtU0SriUX7Qb8TQsqjdpauv7J7CMgJs3GvvE15gRh0QGO70adCVmV5dKe6f+5uxY3m2NTLzXysp/PBfQytkAAMKQziso1/3r8sWJuWD4zm7e/3Ct1DtyOnoZslwfDv4V+yBh/N+f8XSVZN1fyfIhYIgGRxwmbJ8xe1jjX5tz+wCqgvgMhUmwLrGaeGQ62spb+qPQnXzfgno3l1GNfIEmxJcMYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3IaNwiEysg/DVquFkT3tsnYp2Kx57MuE2wougyyp0U=;
 b=hQb7a5V2R1/t22aiumWjHye2YuTtt6rB909GJWZSEmNfB3nmfchjn8WVwksmnIbelIG8DhPc3Q0IC+yW+aEw3JKh4d0OtneBCBDNcxipOknMPpFLh3WNo5rW77VLPVpf9FlDeMtEkqEAmCH0VT8tdsSuJUavSHNzoALkbpx85hm75D416m9nkVxIxgm2vOV3JSvpXrmioFDYOqMiRhaeMIjHZrq02Ume20atZV3YolOcm1YsB2mp7ebNNLKyIp34GmrEF4LB+gAoIeWqANVIg6b1hNPwqMyjSAQT52BMQu3cx6q2fy8g2QBSS9wx5jEzKUYL1CY2QS051iE/jMHokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 08:16:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 08:16:07 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/8] iommu/vt-d: Improve iommu_enable_pci_caps()
Thread-Topic: [PATCH v2 2/8] iommu/vt-d: Improve iommu_enable_pci_caps()
Thread-Index: AQHY80V7dgdiF0sR3UOD9Dq2McMNxa45F8UggAA3+ACAABI7sA==
Date:   Fri, 11 Nov 2022 08:16:07 +0000
Message-ID: <BN9PR11MB5276C64B56A1D1C658825C0B8C009@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
 <20221108073408.1005721-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52766AB454992F154C301CB28C009@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d7f72290-c11a-64f7-c8ac-b752835d182d@linux.intel.com>
In-Reply-To: <d7f72290-c11a-64f7-c8ac-b752835d182d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5316:EE_
x-ms-office365-filtering-correlation-id: 7b1f219d-3180-441a-285f-08dac3bcfbf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GS1X3Zs9N8GroUObSbjQh37miunkqu/O3hIIpvMc9tgF/SiW6oWtpaHh6CIuaR4xXHljwHuXNrp1TR8baaq2qd+dnJ6Z5aIHTdWXFC8Muyu4EXBaE3yu1B7LX0ScH3dPz+buZkyu7BqCIYBEYIoETu+xJqzKq4ZZ9MGzwx+caSjrSt34wzLBBaPrHl1pWJAgbqJ189KPj2CmQWfkQZziqKZWlUV6F0CAlMskpCGM6HHvAOWZr1r9r+wRF/KvMsKfJLopcY0uH39cLhpzFFv3e/hiBp51Q5FWDvdT7gvhTgPU/xoJRvUtsBbuUBW6qhgyi4mNDf/HV8+Gz70tQ5IupHvyyv0xhm6thQGSeevT1SUu6FlNCkZmxQzJZ5kKZSvVm4A6Mx0LPyjnnSsIlEuixImWz7EH4jiIasDW1a4paqszfvhHIWM6h0RtvxSQNaMb6f9QIxktJvomFQVi30FyRLfAMz8Dli7+ydSeFymtb6h8EoWz4g9JYVjGwmUOgNQQwHilf7MlX6VEin2eTqS0GOdK85CJyETZpAU2aCUfCsWemO0hyDPaY3zmlv3Iq8UhAsF88g2+2mCp0b8XaW0XMnzQMT1iege2ZK5sz8Lqm/BEHrpFLBeOO1Q9vDl+vUVUsXVbfUvExeQuq9vcaMk7x571IWQIdE+5qdy1qZk7BkBXf7tlWFtSCI/G4fzqWQdbEnA9brxaAuRP+p6gJ6+bQI9PjalLib6+YJr7KLqK1j2NdaqFMSdoidazQaM1Ro/SwEvOyrWv5CVwh1b8ns+G5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199015)(2906002)(83380400001)(186003)(5660300002)(41300700001)(8936002)(52536014)(38070700005)(33656002)(86362001)(55016003)(122000001)(38100700002)(82960400001)(110136005)(316002)(6506007)(7696005)(54906003)(478600001)(26005)(71200400001)(66899015)(64756008)(66556008)(66476007)(4326008)(66446008)(66946007)(8676002)(53546011)(76116006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d25XYWxtQll2aTBXZDI1WnVDYWd6MSt2TURCdlUxdElZekp6ZXdLeGExdEpF?=
 =?utf-8?B?aWZMYktCcVhieUdPbzd0RGVlRHdMNG5yZ2dHcUM2OWhSYlJQY3R2RHVTcHdh?=
 =?utf-8?B?TzdRak4vRW5icktpSVhXc3hhZ09mUVpjM3ZEbVAxd1JQN0k5bXhJYzQvTmxV?=
 =?utf-8?B?NHJGY3lwWFRRN3BJa09iczNtL3h6ZytHSWdxcitkeU1pWGFadUZnZEZQN1hk?=
 =?utf-8?B?WWx2aVhGd0pwRXVTcmJHcW5aVjIrTlI4N2NCVW5WcU1iaVN6VFlRWVF2R1BU?=
 =?utf-8?B?bXEyd2Y5NjF3T0JmQ3EwUHBxUU1vM0VtdE96YytOd3IyYXNUTTNrS2FWK1ll?=
 =?utf-8?B?RGYra3dTY3dlQXlDWWdqeEdiKy9ibnRjUzMxcE4xRVFSTzBBcFhnalF1SHN0?=
 =?utf-8?B?NkJoS05jK2xlZE5oSkxwSHNoVWFpdEV6UmZHbURySE5SNHk1NllaZHdITDlL?=
 =?utf-8?B?b1htTjFRNFZiVVgzSTFWM3Uvck03YWVFN3VYRDRvUVBKQjZLT3oxUU5WUE5v?=
 =?utf-8?B?bzhTOU1aVHlkYWpzVXVvU0NrTXlaR1RMallvKzYyOUthVW1nVmhQam5GQ2NF?=
 =?utf-8?B?b1V3Ly80cDdHcVN4a2k5aHh3SXdjRW1mYUxGcnZmaTlKeUJ6ZkpuOEhMTmJr?=
 =?utf-8?B?aElXKzl1Y1Q5V0x0ZXEvS0Q3ZWhIM3ZTUFdPUHE0RzFZanlTaDR1UzRDMDAw?=
 =?utf-8?B?UzhQZVNlbDdaVmNnYTVqYWtIVlp6N21Tem4xTVFlRk5YZHIwTy9MNEU2TWxM?=
 =?utf-8?B?TDI5aGVTOGVsMWwrb1Q5VUllOHVsT3hjamsvU3pPRjU5eUlnMFdQbGRzOGFs?=
 =?utf-8?B?cFNBMWtkYXJXZ0pNTGVmYVdNUzZJNmQ3TVcrQlBNTUd3S0g0SFVFMXlQTE5G?=
 =?utf-8?B?Zld0Q2d3UjJoZm9tR2w0LzQ0bkMzMGkvZGVadGx4ODZYby9mM1JCb2RVNjNW?=
 =?utf-8?B?MGI2NGxnR2xmTFhwOGdET0I4MFpBNi9nSlo1dXVjVE1QRmo0TWpqdndNTnJz?=
 =?utf-8?B?Ums3NE0wRUN6cDQ0SFd3b1YwNDZmb2IyRldzNDNyb1VQNlVQanRhVzdjS0Y0?=
 =?utf-8?B?Y29HcGE4WTlTZmJGeDhwNzJjYzVhTnFaUURzUlpDVHpFQjUvTnE5UnZZZElB?=
 =?utf-8?B?K210U2VnMlRMOVhkV0dVS3Nidm9GMnBtTGtFQUpHQy9JZ3NpWGlpT0VIS2xQ?=
 =?utf-8?B?Q0ZhdGtlMFIzWFRWcHY4SE95WWJGVGZVTkNDS01yK1NiM202SUcrR2JqN0tX?=
 =?utf-8?B?ckFBSEw4R3VNZHVBVTdWWGszZ0FmbUkzcFhaL3pvQUlvVnRQRVE0RGtSakdy?=
 =?utf-8?B?Wk9ubWh1WjNUZDNMRk1kMTBTMDBvYXpYN1psYnBjQ0FJcGthcXZzdVVTWEUr?=
 =?utf-8?B?ZmZpYmsyaXNTYUFOa3prSGZuVElDY2RCL0ZLK1ljQlpOUzdJeEdObEwyTmNl?=
 =?utf-8?B?ZUJNVlNoOFhCOUd3R3AzOENKcUJ0aHc2bVZFVXhidXdOMzRuVnJLdUo3YTRY?=
 =?utf-8?B?L3hJWGx1T0VQL3N4QWlocXBCZFA3RkIwaFM5VG9YNjk0SUZnZVBKRjdqdi96?=
 =?utf-8?B?WEY1S1gwTXZLV0pJdnVLdmRrbmFVV1RyVGVmVC9ZYmZDZkxnemZ1ODJUZVBE?=
 =?utf-8?B?YUJoS2VpdjkxWUtLOGQ5VXBMV0pZQXdscitnNUxISHFaMkRiV1lZbVVOaXJa?=
 =?utf-8?B?MjVRS29QUkk0bFkzSHBpNzJKbUVBNlVoT2VVdHA1K1A1WVpSL0hac1dUeEhm?=
 =?utf-8?B?WUh6endxUXVFaUtaYjhLQmc4WnpNQ1hDMUZCTDF3MDdUV1hBYmVtTFp0alhw?=
 =?utf-8?B?WVdLelNxOEMzQkxld1ZNM24zOHZIUThjV256aGlnMnNqUzdjOFFqYmZpMytU?=
 =?utf-8?B?WnZ4VlBDYWdxb1VvMWtVNzBqcVdsZHREU1BieVd3UVNHcys5cGRzaGFnLzJS?=
 =?utf-8?B?SFJkN2lSTXNjYm1vZzdWZ1RWaStKSFZLTjdnZEs1dGo2Slg1Mm40bHkzdlBH?=
 =?utf-8?B?c3BNck9kdTFlenZlT1JvcUl6dlNIWjBBcGhCZUNMdVk4NHBtbnlqVHVFb2x3?=
 =?utf-8?B?RHlxc3JNZHFReGZzblQxOTlrM3BEQ05ablpQU1Q5cmdEcnE3SXByaVljSkxa?=
 =?utf-8?Q?AdIj0JWYqMd2goMJjp+bH4pZO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1f219d-3180-441a-285f-08dac3bcfbf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 08:16:07.4279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZyJYiLrILwMvCCBFr5M3y/m9+JqabGaZLSDFwxAK9oHISYh4cmfpK4EEgf/3yyoG80bAmLzPkArsBwYt/k3OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE5vdmVtYmVyIDExLCAyMDIyIDI6NTkgUE0NCj4gDQo+IE9uIDIwMjIvMTEvMTEgMTE6NDUs
IFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXgu
aW50ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA4LCAyMDIyIDM6MzQgUE0N
Cj4gPj4NCj4gPj4gVGhlIFBDSSBzdWJzeXN0ZW0gdHJpZ2dlcnMgV0FSTigpIGlmIGEgZmVhdHVy
ZSBpcyByZXBlYXRlZGx5IGVuYWJsZWQuDQo+ID4+IFRoaXMgaW1wcm92ZXMgaW9tbXVfZW5hYmxl
X3BjaV9jYXBzKCkgdG8gYXZvaWQgdW5uZWNlc3Nhcnkga2VybmVsDQo+ID4+IHRyYWNlcyB0aHJv
dWdoIGNoZWNraW5nIGFuZCBlbmFibGluZy4gVGhpcyBhbHNvIGFkZHMga2VybmVsIG1lc3NhZ2Vz
DQo+ID4+IGlmIGFueSBmZWF0dXJlIGVuYWJsaW5nIHJlc3VsdHMgaW4gZmFpbHVyZS4gSXQgaXMg
d29ydGggbm90aW5nIHRoYXQNCj4gPj4gUFJJIGRlcGVuZHMgb24gQVRTLiBUaGlzIGFkZHMgYSBj
aGVjayBhcyB3ZWxsLg0KPiA+DQo+ID4gQ2Fubm90IHdlIGhhdmUgYSBoZWxwZXIgdG8gY2hlY2sg
d2hldGhlciB0aGlzIGRldmljZSBoYXMgYmVlbiBhdHRhY2hlZA0KPiA+IHRvIGFueSBkb21haW4/
IElmIG5vIGluIHRoZSBibG9ja2luZyBwYXRoIHRoZW4gZGlzYWJsZSBQQ0kgY2Fwcy4gSWYgbm8N
Cj4gPiBpbiB0aGUgYXR0YWNoaW5nIHBhdGggdGhlbiBlbmFibGUgUENJIGNhcHMuDQo+ID4NCj4g
PiBJIGp1c3QgZGlkbid0IGdldCB0aGUgcG9pbnQgb2YgbGVhdmluZyB0aGVtIGVuYWJsZWQgd2hp
bGUgdGhlIGRldmljZSBjYW4NCj4gPiBub3QgZG8gYW55IERNQSBhdCBhbGwuDQo+IA0KPiBJZGVh
bGx5LCB0aGUga2VybmVsIG93bnMgdGhlIGRlZmF1bHQgcG9saWN5IChkZWZhdWx0IG9uIG9yIG9m
ZikuIFRoZQ0KPiB1cHBlciBsYXllcnMgYXJlIGFibGUgdG8gY29udHJvbCBpdCBvdmVyIElPTU1V
RkQgdUFQSSBvciBrZXJuZWxkIGtBUEkuDQo+IEkgY2FuJ3Qgc2VlIHRoZSBiZW5lZml0cyBvZiBh
c3NvY2lhdGluZyB0aGVzZSBmZWF0dXJlcyB3aXRoIHRoZQ0KPiBleGlzdGVuY2Ugb2YgYW55IGRv
bWFpbi4NCg0Kd2UgZG9uJ3QgaGF2ZSBzdWNoIHVBUEkgb3Iga0FQSSB0b2RheS4NCg0KdGhlIGN1
cnJlbnQgYmVoYXZpb3IgYmVmb3JlIHlvdXIgY2hhbmdlIGlzIGRlZmF1bHQgb2ZmIGFuZCB0aGVu
IHRvZ2dsZWQNCmFsb25nIHdpdGggYXR0YWNoL2RldGFjaCBkb21haW4uIGFzIG9ubHkgb25lIGRv
bWFpbiBpcyBhbGxvd2VkIHBlcg0KUklEIGl0IGltcGxpZXMgdGhlIGNhcGFiaWxpdGllcyBhcmUg
dG9nZ2xlZCBhbG9uZyB3aXRoIERNQSBhbGxvdy9ibG9jay4NCg0Kbm93IHlvdSBjaGFuZ2UgaXQg
dG8gYSBtZXNzeSBtb2RlbDoNCg0KICAtIGRlZmF1bHQgb2ZmIHdoZW4gdGhlIGRldmljZSBpcyBw
cm9iZWQNCiAgLSB0dXJuIG9uIGF0IHRoZSAxc3QgZG9tYWluIGF0dGFjaCBhbmQgbmV2ZXIgdHVy
biBvZmYgdW50aWwgcmVsZWFzZQ0KICAtIGJ1dCBpb21tdV9lbmFibGVfcGNpX2NhcHMoKSBpcyBz
dGlsbCBjYWxsZWQgYXQgZXZlcnkgZG9tYWluIGF0dGFjaA0KICAgIHdpdGggYmFuZC1haWQgdG8g
YWxsb3cgcmUtZW50cmFudA0KDQp0aGlzIGlzbid0IGxpa2UgYSBnb29kIGNsZWFudXAuLi4NCg==
