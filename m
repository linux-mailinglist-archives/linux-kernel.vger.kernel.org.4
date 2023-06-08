Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240FA728960
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjFHU06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjFHU0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:26:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658BC30C1;
        Thu,  8 Jun 2023 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686256007; x=1717792007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3vU2euHGoqUZlmmAN+O9IsdnFIgqA7WOt+VX6iWK4lA=;
  b=giZIsZ3+rnJFQD9Vd09uY058BXMWkPIS3I3erkcR0qVFEEpH4+UecT6K
   ryEVyToYqvfXQXXBdBKUziY9XRNqlZSuNGH/hnTWuMHxCJKMuOo9d+rno
   opGH/ntDNDVLjxeztmUvKRRxTjhIyeahKVHrmA9Ke1ROcZQCZL6SUx1AL
   B8buoH4hBeLGFS9S8rLsTAE10lAtZct8/RImPuTc6ON1dPCIwY/S+6+SG
   2TgLPz156RzT32pNUBXGOndLGJO6KlkBd2CbJkTX/I6Ga5KTl7yH4l1cH
   NOoDw2tSUsAqgVjFZzEgs2B5KtXFMuMNruFjwuYiVAp+qeby7fiHPUobC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="385776496"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="385776496"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 13:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="834350148"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="834350148"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 08 Jun 2023 13:26:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 13:26:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 13:26:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 13:26:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbC7vetP1p1o4exFNVYvA49QMkp50gN0xP2lDvemhRitCYRRbLuNL6GveYYEgGECpnUUh3kbPUdq5ezwqZLIz4wJGTukBS7gF8lED75fKWKKU0WKED0b5SZeWn+qaczKvkbI9W7c/k8PJwHGngpgvX6AgmyG+DlaCeOLrIwLwMcwbAYQ6VaIzu3DjuVcqFeiSpAiAwTU3C2IMpx4m1rjqeAbCL3RumRQvP+ZPyDOvijtdl1omBupSoECrt7K47KOr7roXXF6GgN7ARLBq0EYDfw/ZHybPeEUs7ObieZ5pj9Mr3nTXRxG8W7pIn88+dauQDFeFf4Oj1+1ExgL0bfaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vU2euHGoqUZlmmAN+O9IsdnFIgqA7WOt+VX6iWK4lA=;
 b=Vrpe3SVZHcSRdHQcFwA6onbsE7CgDifSv33KFlfiYZIwJzppA1Ms5LUdAQokrE5U+u9i/6pM2aMUPMKn7FrTFv8sqh0aAb+pjkACeNGG9tzj8RNCOgxXJN5QVJmYIVn1+QXh9F8mPsDBO0LXojAX2sjZeC3U5ivclwSvmmmdFQUQ4Szb2gntbQNEgf0ZqMmn1gWemuUDQd1iGgqSbRwoj/YDWj9EX1qcaQCIS8b+UKGSAj3oL61A3+vWA5W9pl9JFzdrMlvwBd0DUS9A/59JceLwSeiNGxduku7Nt1QbwGOczFyWXLkt5lWE59+c5YZdx/LdRASL4r9TkSwAwj0T+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1SPRMB0002.namprd11.prod.outlook.com (2603:10b6:208:3d5::10)
 by IA0PR11MB7377.namprd11.prod.outlook.com (2603:10b6:208:433::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Thu, 8 Jun
 2023 20:26:43 +0000
Received: from IA1SPRMB0002.namprd11.prod.outlook.com
 ([fe80::f79f:b1c4:89a1:25df]) by IA1SPRMB0002.namprd11.prod.outlook.com
 ([fe80::f79f:b1c4:89a1:25df%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 20:26:43 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH v2 1/4] cxl: add a firmware update mechanism using the
 sysfs firmware loader
Thread-Topic: [PATCH v2 1/4] cxl: add a firmware update mechanism using the
 sysfs firmware loader
Thread-Index: AQHZl+s7AtYa6Ply606ZWi23sy9bL6+BAOeAgABbRYCAAAMOgA==
Date:   Thu, 8 Jun 2023 20:26:43 +0000
Message-ID: <298ed811de7148da70609ac2c6ef81f025690620.camel@intel.com>
References: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
         <20230602-vv-fw_update-v2-1-e9e5cd5adb44@intel.com>
         <20230608154905.00007551@Huawei.com>
         <6666972e336a6749f24ce3aab7dddad63a796974.camel@intel.com>
In-Reply-To: <6666972e336a6749f24ce3aab7dddad63a796974.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1SPRMB0002:EE_|IA0PR11MB7377:EE_
x-ms-office365-filtering-correlation-id: 2bfaabd4-3cad-41d9-04ee-08db685eacc4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6yZcMFnEdLWFTGZhUvHOW0O6tNH3nH8Fa7tPMjEHo0pG7VWLVoQFLNqvkfqPzo3norsyaOJshgQQPkT/TkmMvwZdM150BrAwa+KeufxHw+urf3V+3dEYX7lAkgF3FxNE1I8xDXf/IXB0c8q+NX7qknqcjnTH/4MQuP84XxyY/A7IVT7MsTkGAXX0jkoML1pE84mLgiMqMM/dXhBHbjURfFraIAyzXgDPQP+R5kZ2DgSB9X/wo30z9WOcKb6y9LI9vf5TjC2t0s16CKYP6EuQ7s/o1TOc6cGcG/iuVSTUOwnuZ3rO9ojKS5xnX7jU6yRT9wptudkejPAxs2DlVQlpHbhpYqFTegVMj/Qje21IMcZtwda9JfCaid9DsM5MKRowY+uNb/mwglbwUws2Kj877xk+6WZg1hZ+91vUItjlYzQVuQiU4VYMg83lsNCZ6n8728jLKBIBj9FyfLwkGV35VHvQK/jXdEOo7NpdS1sYFlHfKxnclTKioYcZoNze3+bHDm5ZlKL8+Oc01U0MpLuZb8/X/9iXXYoXg0bU7npwT+6B2Nv0n0joa6Go4GUsCfBjs8+m+6ONd0X0EIQQQ+Eumoh3LoiDH2r+w9TIqBR0w+mLLop1yTbZ7IKHhq1WwyqP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1SPRMB0002.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(6506007)(6512007)(186003)(2616005)(26005)(6486002)(71200400001)(91956017)(82960400001)(122000001)(76116006)(66946007)(66556008)(66476007)(66446008)(36756003)(64756008)(4326008)(478600001)(38070700005)(8936002)(8676002)(86362001)(5660300002)(6916009)(38100700002)(54906003)(316002)(4744005)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDVkbGFYcmpmYjUwN1dmNFg4Vkc2cTFGWExRb1VWc1YvcjJXV1kvdll2UGlV?=
 =?utf-8?B?SEI2V0ZIR3YrVVZHWVZPM0RHemtWck4xY1dnbWxYcTZTQmRXcUcrcEtTTlgy?=
 =?utf-8?B?K0NMRFJlOXoxeTJOV0tlUHc3V1FRK0ZBRmdKaUs2VlhuR0wxOHBXOFN5b2U4?=
 =?utf-8?B?ZXQ1VnMyVlNsVStmR1Jib1NpMWVxTFJxemJwZHJGWG1ZUW5iV280c1NXaE9l?=
 =?utf-8?B?V0xmT09qZi9ueUtyeFZTMVBlUmJNbkh4WC82bVZtdFVXWGhqcXB2RWdXY2hO?=
 =?utf-8?B?aThSNGhwNUt0TWNIdFdqYS82ZWloQ1JZSzE0MDhxdzM5UEJvNENmdTV3TEdu?=
 =?utf-8?B?aXZ1K3dLdnpEdVpWWnRUc3gvSmtYK3lNVDVFWmV0UWN4Ukp0bGErbEVUbkVw?=
 =?utf-8?B?UG5BMlphLzQ0UGdyTFdFNkl0b3hJUEYwMzFFQXBrcnlvUXNxZklzVDJJYjFl?=
 =?utf-8?B?ZHdWQzRjTE9aR2h0eGkrTWlsYUZpRHN1dWt0NHJKVjJBUllmUStzMTVuVlEz?=
 =?utf-8?B?S3BDbmUxVlFpb3lHNFNWVGZJYXIzbmZ5TDREU201L1NNTkdZb01CWE52NlNt?=
 =?utf-8?B?UTNaQllDZ2NVbW5paVQzbTkrTzFTTHFpd2NjQnR4a29zdlM1WnF1UENqNXZ5?=
 =?utf-8?B?ZjB0Yi9JRmVYb0VMNTFvOU45c21WMnFzcHJSbGNYVllJcFZJVFRHc0xIUDRS?=
 =?utf-8?B?YlIzVWtPRFVaM0RaUnpLeTVXbmRnUmtkWG4rajhkZXRrWXFCcWNJcnlSMUlG?=
 =?utf-8?B?aG1jMnltektjaHhRTlh5WklNRmZKelFVczRUY2MzSDV5OUhzOW8vUE0yd3dz?=
 =?utf-8?B?VzhDUThCNkU1Z0FXSDFpVk9OeGREbDZWQ0VQb24wU1lzMzJOenFrbmNGTlVE?=
 =?utf-8?B?VDhyYXY2d0xlMTVkYXA5bTFTdkJmMXdvU0pNd2JXbzZYbUYrUkJuZnRkd3pi?=
 =?utf-8?B?eHkvMllta1JuajBwSzN2ZEY5QnJ6MVF2bStkY1dSbXBKd3c0N25hcWpLSXgw?=
 =?utf-8?B?T2NBdDZqdUhzZ0tzaDlYcFlSNVFNUWluMXJoNjhFKysxOXJFL2ZHUlpLM2Nv?=
 =?utf-8?B?TTBOVkxqUGQxYktYYlp1YUV4cTliTlk3OTQvN29YbWtkblU2aUpSSkpINERL?=
 =?utf-8?B?dFpNcHE2L1E1VEZwVGtrdE1DbHRSSUlrZnZ5bnZOSUxUcTd0ZnVMeW5EdlAr?=
 =?utf-8?B?ck5yYVdYV3pFSmhPOXFyc1VwSWZhbGgxMWhNWnozRWcrOGtRWG4zSzVDZE9m?=
 =?utf-8?B?TC82T1hUTlJiTUp6NXZlb3hYQVd1NmptWDNqeHpuTk5RRU52aVhZVmlIMlIr?=
 =?utf-8?B?WFhWSzU4a0NyZVhUSUdkcktaQW1EdkVUNS9xaHdmMmJKaEJISnptWkFJaVd3?=
 =?utf-8?B?MHhHM2l6SEY2VEdGa1lWYmtER1BkQm92aDJyaVpBSmd0WHFid3pwbVlEQ3Y1?=
 =?utf-8?B?c0R6RFlYSHVwTzBvMSs1ZVNCRTlrTUV4cTJYbUg3SmZ1WE9Nd1htMDVFZUpk?=
 =?utf-8?B?K3hTZi9qWVYyY1FFMjg1QnBjdFNuRGZWWDg4VmJPOUJxZml4SHJDVTk0THpS?=
 =?utf-8?B?V1ljSGtnb1g0MkFlUkhteTRFSkFMZzBnQzdKUDhqNnlIS3c4THFjREx2eUgz?=
 =?utf-8?B?eXN5OGdhOENPNFJNWlJ4c281SFdwOXBneXRNNmJsRGRrUk0wK2FiTXd1YWpE?=
 =?utf-8?B?YzIzbmtSeDFya0ZDODk3Zk1yQlNRclpBNHRIaDJ2Mmoxa3piVkhPSVpFZjR4?=
 =?utf-8?B?cnR5a0wvU2xydFh0cHhkUFJYRWJ5aldDVEs4OFgrQVNSRzE3ZGdTSkR2Y1c0?=
 =?utf-8?B?R05DUTFWdDNGWld1NXlTS0cvS0ErbWhGL0k5V1NIMWVjQ2FPdlhyYWkwczZo?=
 =?utf-8?B?b09DbzJscnJkREhRNjZQN21tQTlTc05qWTNKcm10Tm53M1dmQ2w0bW1BTS9o?=
 =?utf-8?B?b3dzY3R4UkFLSVYxSWJ2N0ZoZmhVeFNvcDBPUDZMWEkxazZoK0NNTWpkc3lE?=
 =?utf-8?B?NHduajdXNU9IdmQ5aFVLZEorRW1wa1Z0TFkyQWFyNzUzdjJuN0ZQV21NNlVV?=
 =?utf-8?B?TWVGRDcwQklaZXBWaW9UM01Ka25td3hnRXFFdXExajJ5ZkY0bmtpQTZ1MTNu?=
 =?utf-8?B?S0swYm1jU3p0bzA3Z21LYStqQXMyaTUrZGpUU3g0d2tGQk9lZThjamFESmUr?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61521B2E93F5F44A9D27BA77169EFB07@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1SPRMB0002.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfaabd4-3cad-41d9-04ee-08db685eacc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 20:26:43.7402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQ8wfKyXeGysH8T5PtmXOTVLNSTUVyly7HFaV6QCqc/jmxmEl8t0nMZLxwA+JOoOFWxZWyDB4fRv2bG7TWajbeFWHWg0KYIf1pB4DoprY3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTA4IGF0IDIwOjE1ICswMDAwLCBWZXJtYSwgVmlzaGFsIEwgd3JvdGU6
Cj4gCj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgZndsID0gZmlybXdhcmVfdXBsb2FkX3Jl
Z2lzdGVyKFRISVNfTU9EVUxFLCAmY3hsbWQtPmRldiwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGRldl9uYW1lKCZjeGxtZC0+ZGV2KSwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZjeGxfbWVt
ZGV2X2Z3X29wcywgY3hsZHMpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKGZ3bCkp
IHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoJmN4bG1kLT5k
ZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIgZmlybXdhcmUgbG9hZGVyXG4iKTsKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBQVFJfRVJSKGZ3bCk7Cj4gPiAKPiA+IEl0
J3MgY2FsbGVkIGZyb20gcHJvYmUgb25seSBzbyBjb3VsZCB1c2UgZGV2X2Vycl9wcm9iZSgpIGZv
ciBzbGlnaHQKPiA+IHNpbXBsaWZpY2F0aW9uLgo+IAo+IEZyb20gd2hhdCBJIGNhbiB0ZWxsLCB0
aGlzIGVuZHMgdXAgbG9va2luZyBsaWtlOgo+IAo+IMKgwqDCoMKgwqDCoMKgwqBmd2wgPSBmaXJt
d2FyZV91cGxvYWRfcmVnaXN0ZXIoVEhJU19NT0RVTEUsIGRldiwgZGV2X25hbWUoZGV2KSwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICZjeGxfbWVtZGV2X2Z3X29wcywgY3hsZHMpOwo+IMKgwqDCoMKg
wqDCoMKgwqByYyA9IGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGZ3bCksCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiRmFpbGVkIHRvIHJl
Z2lzdGVyIGZpcm13YXJlIGxvYWRlclxuIik7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyYykKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByYzsKPiAKPiBJcyB0aGF0IHdo
YXQgeW91IG1lYW50PyBIYXBweSB0byBtYWtlIHRoZSBjaGFuZ2UgaWYgc28uCj4gCj4gCkFjdHVh
bGx5IEkgY2FuJ3QgZHJvcCB0aGUgSVNfRVJSKCkgY2hlY2sgLSBzbyB1bmxlc3MgSSdtIG1pc3Np
bmcKc29tZXRoaW5nLCB0aGlzIGRvZXNuJ3QgbG9vayBsaWtlIG11Y2ggb2YgYSBzaW1wbGlmaWNh
dGlvbjoKCgoJaWYgKElTX0VSUihmd2wpKSB7CgkJcmMgPSBkZXZfZXJyX3Byb2JlKGRldiwgUFRS
X0VSUihmd2wpLAoJCQkJICAgIkZhaWxlZCB0byByZWdpc3RlciBmaXJtd2FyZSBsb2FkZXJcbiIp
OwoJCWlmIChyYykKCQkJcmV0dXJuIHJjOwoJfQoK
