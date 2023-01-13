Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4A96692C0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241125AbjAMJRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241118AbjAMJQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:16:29 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F306D6719E;
        Fri, 13 Jan 2023 01:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673601167; x=1705137167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dLTzb6tUdqQTI3lW1HoCM3eeRaL9I8bMUdutlzjRCIg=;
  b=Phi7rlVBbKGPUgdybPfbF4AC6yOmQ8491OckrCtRWr6/2Viv6dTq3UnP
   qcNnIAdaeeMr0qnQM/gbSmZ8FTGzIqW4keM6UfVVDCuMO0lO7AKx8M9EU
   GMguisF5XBPHcyEoakQLOLlp6uV6DAFAHSsqKVTpRdjs5g6HUGW6Jwjoj
   tawS60PhqpejNYhb4kj6rdAOi9JvfnsZ2THUHDWShp6702ru5xF2ixiAV
   1RfYmue1uPLA/RGAaSILeyNwUyQL0P6WPZN9h970MAJg4rOPfVCVm5VF6
   6cCVTVRVLQGTdgJOlccwjlgdGBY0RUoaoUL95YdHI6to4SCE/3YCecJJg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="322652967"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="322652967"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="986930381"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="986930381"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2023 01:12:45 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 01:12:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 01:12:44 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 01:12:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgQPnNfGe3n1bCbYE3ADWAC1Y0XqiSUgRiMyDlcGsGUMslL1kH4hFyz1TNHYnsTtbbfAv3K7T5fpCzivd+IX6thahcnR0NuZ2ANEA40E8Yu5dq8rUK64LfkBMff64mWOik5jcKMO7M43JYp+9dbNNGS8/+xhIue4aL9KZLtvbNbf8INGi4+RGL6pcQGkhjf7VC8sXwoz4POTNHu8iTu+lPy9qb9T1lGVqgeteLvYIoUEGGCDyy8FGc/d4WpC9s7F1Sc170soJqYLPrYRjQ6QXwjJyMjUZp4Faehuo1bvCalqssIT/dL5V7PEcRONRcGlCUtD8rOO2GmSBEhOCSiDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLTzb6tUdqQTI3lW1HoCM3eeRaL9I8bMUdutlzjRCIg=;
 b=RrCyhsL16Fn0B1dG2ihmAsprBRi8U7yi8DtXcUSd2+CtI43XIUlZEXJSDOaOl77u6O6RxdTnAENzOox+QSFaZNT9gteq37DhJuoCZ6/gN3dXecT+BOaxo4ZhS+Ukd//iqfnwXdVqKfaN+IrFB83eOzfWRUXG32w2u9QkXjpHGE2SrChDIQlXajFX5TmUP3lFLVIsWDa77wrMYZLD9lGBfLFpEz8XF47tEdM4lqkHZJ73aPzvIbfnzQC4JQ+7XWrELORcPyk6YfPQs8QdKDMGjxEzGO4alBdo1+ZPN01TH1eIRVbksTcH4qi2iEyR+8HDQQlUIWWFDrmH0lHUHrz5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 09:12:42 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 09:12:41 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited() be
 invoked very early
Thread-Topic: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited()
 be invoked very early
Thread-Index: AQHZJlrAbelW6ZjuBUWwM88Mxg3+Hq6bJV4AgADo4SA=
Date:   Fri, 13 Jan 2023 09:12:41 +0000
Message-ID: <PH0PR11MB588074A87AC454A7F0E42A5ADAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230112075629.1661429-1-qiang1.zhang@intel.com>
 <20230112190656.GR4028633@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230112190656.GR4028633@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA3PR11MB7461:EE_
x-ms-office365-filtering-correlation-id: 7df49739-9e33-4597-28b4-08daf546531a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Eu0N0I1Ro/CQLkhfpGexYW0ZNVRYq8Yd9CpO3pGkyGcprEhNLoHhN9qLkfzO/a1JBw9MoWNs/R/wArWdSptNSy5w0BwEI340L+IFqaYMagLfRcUrBrb+03TGaMWjN0Eq2ds6kEaaphUFNp/2gqKKKLO03xaDCg6zeRjaws1y5MvvZGiUodCk9I7iSFOeeCItugQ5cPq5ekK93EQzPGxBAfJicdbqvlURVuoD5GdhucYb74VY3Tyr0I3bmGSFCLO09fHkux1TfHRZJ6ys2Qxy1RCgygTz4rWl0V1elBjgZkFmswYEe1Usiv93oT8qwglPivMqF6/uWw5H31nf4IMIz1aoBd/ADPzFPCFjHsbbuwhUpc7yUEhOo6WtKCEpA5DqV1bwsq6U0M2qDleobuaXekqcLNaQJ6BPyNXEwB2BN78Ik/xXdpIw0k2TSlTjBEi7WgqOyTzAJOsosEU3z8w+/uwEYmnHw6YAq83PGvaoa0mPZSKsJY8XSnEZqYUU0lGe7ZvtLgdzMeerKuMpGQD44NwUxNA6OkXoEVz9E+x2NC70cDloLBXvCdAdXq+h3PWsm2mvgK6OirQ4TYomp8aEhQ/xX5HprphbNHLfoo51NYTvlbua1KHFfeIFpXT1QgtPD2J01C/WQK//Q7GVmPxZ5rTYMiADHvp0EIRNt7+BUnGg8bikE606rypHNSaYLWLVRxhU7JWqHD5MW/p7jqWyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(26005)(6916009)(186003)(8936002)(122000001)(7696005)(6506007)(66446008)(9686003)(478600001)(33656002)(64756008)(66946007)(5660300002)(66556008)(55016003)(52536014)(66476007)(316002)(4326008)(71200400001)(38070700005)(41300700001)(38100700002)(82960400001)(54906003)(76116006)(8676002)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTRmRjBIYjlqZ2N3SU9pRGp3clJ0YnU3ZTM1MUFrZGY0UFRIOVJ1R3pMZWhs?=
 =?utf-8?B?azNUOWFmTXZ5U0lMclgwakhLeEU0c0pYSUpEb2NSTVZFZms5Wm1iVUUxVkcv?=
 =?utf-8?B?NExGcmlQSDJUSHlIeWk1QXlib0RzZEI2REoxQ2t6dW1PRmczUjZydHNxZkUr?=
 =?utf-8?B?Vy9Jak0zaUFnVXFJT3ppcEg5STQ4ZEgvTUtBdDkvQVBxeEgxMUVuZ0Izc0N3?=
 =?utf-8?B?VzduTzFSKzQ0NThuanFsMS81LzhyekkvV2w5czRXbWtzT0ROL2hzM0U5Ly9k?=
 =?utf-8?B?VGtZU2R2b3lTQ1hjMGpSYXk3Q01IQ1dpWXVpenZXdjAzMlFGZDRKeGxMZjFR?=
 =?utf-8?B?cks2Q1pQc09tN3FZOVNGQW84UGhLQU5uL0laNG1kVWN6MmlIMUZTM0NUOG1X?=
 =?utf-8?B?elFTdnF6cjVMRktpM2RBNStBRE53T2lFTWVaUVUyNktQRlVNeXMxbUpJYTNQ?=
 =?utf-8?B?SnpTdzFNUzZqdWFQcFltVjRzSGVwNlhNL2hrVGRNU1ZBQis5UTRLcVdJcWlk?=
 =?utf-8?B?c3ZWSTJrNWdkbHhiU0hOVk5PL2pJUjZFWDlQSm4ra2RCOG9IRXhJRXZYNjJ0?=
 =?utf-8?B?MytmOEFpcWI0L0htRGFUVFdNZUJLOHR3ell1S0xFQW1oTFkyMXpQSmttZkRK?=
 =?utf-8?B?aGl6N1RSWGhuZ2FVd1dyY1Jzd0UxdTFDVDFXQ1BzVmxKdmVRRXpHVzJFNVcv?=
 =?utf-8?B?eGRrSkMyb0QrRUM2WnVUVkVWaGpDTkE5VVNYYkMyZnYzSTYwOUdtSkhPRUN5?=
 =?utf-8?B?SDVQajNiZ2R2ZzRxeGRyR0FyMExxdGhUWG9XUE1QN3hTQVgxemM5djE5bmlJ?=
 =?utf-8?B?NXY0RXU4Z0l3M204aGk0WjFxZkxHY0doM2dYUWRIOCt0LzBMajljV1ZmalM3?=
 =?utf-8?B?SWxhN2t6L0tIYkpZZ3JoOTR4RjVvdEs5Tkg3eXl2bC9zK0J6WHhEQlZ1WldW?=
 =?utf-8?B?eUdMd3hKeUtpWTBhdFJjemQwUkM5ZFlZR3lJekk3ZEI1ekFTSm1CT3A2LzFX?=
 =?utf-8?B?UjFEWmYxRmNJeVFaOEFQV1E5dmNibWJDOEYyMEo4N0NTVkRjZ2MvVFlYK3V3?=
 =?utf-8?B?bm42Wkw3YzlCa0w5ZDVKWVdmSktHUnNPdW1oSHdYMXRIWldnZjFEL08rK1dO?=
 =?utf-8?B?dml0ZlE3Ykd5SUlaVFc2SEU2ai9CdTlaalBWNFViL25BcUo4LzN1VUE3RWNq?=
 =?utf-8?B?KzU0UWhQQ010UGxqZHNCT1dzTXZhYTBwSWVkK01uakhZTDNOQ3ZYd2YwTUVa?=
 =?utf-8?B?UmJ4TC9lNHlBdkFtQlJEeWZydEtDbFRYSktQMUJvdG1paXZVaitVNlo5a05k?=
 =?utf-8?B?c2VYbXFIVUR6cFRzaURYVEo1bE5QOS9HVThlUHRvVkVuWmgwUk9SczFtTHlN?=
 =?utf-8?B?VXNxRi9EZllrdHJmcVJPU2U0M3JkYTVRMlJPZXJQM2l4NkxpWk5DTTNoTDhK?=
 =?utf-8?B?T3N6N1NSMzJLbVlKL1NvVlo4M0tDd3J1NUdPKzM2d1lkei9USDFkU3VVczFX?=
 =?utf-8?B?VUcxT05UTGJ4UWF6YnFxSURBd01TcS9XNjc1Szd6d1B2ZHh2d2JVaGlQTStw?=
 =?utf-8?B?TVdYKzRaUmRSb3c5VGFzT1ZlUExlbE5nREEva0M5WFd6ZHpTNW5mZmNML1Ew?=
 =?utf-8?B?b0lmZlcyUFRkZ1AyaVBjL2w3b3I2d1Y1K1Z6dk5MdWYvZG4waVpkOE5qK3hE?=
 =?utf-8?B?UHlGUmwxQ1lyTHNjeUxzcElwWVpEc3Z0MWJkTk9Nblk2VGswTlM1eDdzQTVk?=
 =?utf-8?B?NGFteUwwVFNhN3grUEpWNENpbG1MOXBGNTF1TDFWOTFVTzNmanA3MS9tZ29T?=
 =?utf-8?B?UW15SzJDTCtoWS9sU1lqT2xlUjlMWWFkd25hUGZ6NjA2VzFhVHN5Y04wQm9s?=
 =?utf-8?B?ck1uYmhlUTFCNzhxNDhqTG4vbG1sZ2hScXU3Qmw4UjRBQW9pcUR4RFR6L29K?=
 =?utf-8?B?SUE0bTV4cWJxb3FVYjBqdFBGQVRGTTM5OGI5MXY1cU1CSG8raEN1TkdRVUtr?=
 =?utf-8?B?T0tDUE84M2ZqOFpQaVBpSDFNUGRhWEVuZ0YzSElycjBPOWxpU0xwbjFLVk5U?=
 =?utf-8?B?azhtWGlTQXZhK2JzUDlmM20vSzlZVmVzWExFSmtoeWF3NFBlTFc0TitSc1lI?=
 =?utf-8?Q?L+on1tjik3yCjWWkFT+IPZOAb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df49739-9e33-4597-28b4-08daf546531a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 09:12:41.6460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAAQMjFk3K1mMLeuWYt2Ker3it8YDQ7biiKfCuXaOn/6iksMnHdpIfA6h110tb1Znr6m0CAeNTT5CbJtbvPtIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7461
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKYW4gMTIsIDIwMjMgYXQgMDM6NTY6MjlQTSArMDgwMCwgWnFpYW5nIHdyb3RlOg0K
PiBDdXJyZW50bHksIHRoZSBzdGFydF9wb2xsX3N5bmNocm9uaXplX3JjdV9leHBlZGl0ZWQoKSBj
YW4gYmUgaW52b2tlZA0KPiB2ZXJ5IGVhcmx5LiBiZWZvcmUgcmN1X2luaXQoKSwgdGhlIHJjdV9k
YXRhIHN0cnVjdHVyZSdzLT5teW5vZGUgaXMgbm90DQo+IGluaXRpYWxpemVkLCBpZiBpbnZva2Ug
c3RhcnRfcG9sbF9zeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKCkgYmVmb3JlDQo+IHJjdV9pbml0
KCksIHdpbGwgdHJpZ2dlciBhIG51bGwgcmN1X25vZGUgc3RydWN0dXJlJ3MtPmV4cF9zZXFfcG9s
bCBhY2Nlc3MuDQo+IA0KPiBUaGlzIGNvbW1pdCBhZGQgYm9vdF9leHBfc2VxX3BvbGxfcnEgbWVt
YmVyIHRvIHJjdV9zdGF0ZSBzdHJ1Y3R1cmUgdG8NCj4gc3RvcmUgc2VxIG51bWJlciByZXR1cm4g
YnkgaW52b2tlIHN0YXJ0X3BvbGxfc3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCgpDQo+IHZlcnkg
ZWFybHkuDQo+IA0KPiBGaXhlczogZDk2YzUyZmU0OTA3ICgicmN1OiBBZGQgcG9sbGVkIGV4cGVk
aXRlZCBncmFjZS1wZXJpb2QgcHJpbWl0aXZlcyIpDQo+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8
cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4NCj5GaXJzdCBvZmYsIGV4Y2VsbGVudCBjYXRjaCwg
WnFpYW5nISEhDQo+DQo+QW5kIHRoYW5rIHlvdSBmb3IgRnJlZGVyaWMgYW5kIEpvZWwgZm9yIHlv
dXIgcmV2aWV3cy4NCj4JDQo+QnV0IEkgYmVsaWV2ZSB0aGF0IHRoaXMgY2FuIGJlIHNpbXBsaWZp
ZWQsIGZvciBleGFtcGxlLCBhcyBzaG93biBpbg0KPnRoZSAodW50ZXN0ZWQpIHBhdGNoIGJlbG93
Lg0KPg0KPlRob3VnaHRzPw0KDQpBZ3JlZSwgdGhhbmtzIGZvciB3b3Jkc21pdGhlZCAg8J+Yii4N
Cg0KPg0KPkFuZCB5ZXMsIEkgZGlkIHByZXN1bXB0dW91c2x5IGFkZCBGcmVkZXJpYydzIGFuZCBK
b2VsJ3MgcmV2aWV3cy4NCj5QbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGRpc2FncmVlLCBhbmQg
aWYgc28gd2hhdCBkaWZmZXJlbnQgYXBwcm9hY2gNCj55b3Ugd291bGQgcHJlZmVyLiAgKFRob3Vn
aCBvZiBjb3Vyc2Ugc2ltcGxlIGRpc2FncmVlbWVudCBpcyBzdWZmaWNpZW50DQo+Zm9yIG1lIHRv
IHJlbW92ZSB5b3VyIHRhZy4gIE5vdCBob2xkaW5nIHlvdSBob3N0YWdlIGZvciBpbXByb3ZlbWVu
dHMsDQo+bm90IHlldCwgYW55d2F5ISkNCj4NCj4JCQkJCQkJVGhhbngsIFBhdWwNCj4NCj4tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4NCj5jb21taXQgZTA1YWY1Y2IzODU4ZTY2OWM5ZTZiNzBlMGFjYTcwOGNj
NzA0NTdkYQ0KPkF1dGhvcjogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPkRhdGU6
ICAgVGh1IEphbiAxMiAxMDo0ODoyOSAyMDIzIC0wODAwDQo+DQo+ICAgIHJjdTogUGVybWl0IHN0
YXJ0X3BvbGxfc3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCgpIHRvIGJlIGludm9rZWQgZWFybHkN
Cj4gICAgDQo+ICAgIEFjY29yZGluZyB0byB0aGUgY29tbWl0IGxvZyBvZiB0aGUgcGF0Y2ggdGhh
dCBhZGRlZCBpdCB0byB0aGUga2VybmVsLA0KPiAgICBzdGFydF9wb2xsX3N5bmNocm9uaXplX3Jj
dV9leHBlZGl0ZWQoKSBjYW4gYmUgaW52b2tlZCB2ZXJ5IGVhcmx5LCBhcw0KPiAgICBpbiBsb25n
IGJlZm9yZSByY3VfaW5pdCgpIGhhcyBiZWVuIGludm9rZWQuICBCdXQgYmVmb3JlIHJjdV9pbml0
KCksDQo+ICAgIHRoZSByY3VfZGF0YSBzdHJ1Y3R1cmUncyAtPm15bm9kZSBmaWVsZCBoYXMgbm90
IHlldCBiZWVuIGluaXRpYWxpemVkLg0KPiAgICBUaGlzIG1lYW5zIHRoYXQgdGhlIHN0YXJ0X3Bv
bGxfc3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCgpIGZ1bmN0aW9uJ3MNCj4gICAgYXR0ZW1wdCB0
byBzZXQgdGhlIENQVSdzIGxlYWYgcmN1X25vZGUgc3RydWN0dXJlJ3MgLT5leHBfc2VxX3BvbGxf
cnENCj4gICAgZmllbGQgd2lsbCByZXN1bHQgaW4gYSBzZWdtZW50YXRpb24gZmF1bHQuDQo+ICAg
IA0KPiAgICBUaGlzIGNvbW1pdCB0aGVyZWZvcmUgY2F1c2VzIHN0YXJ0X3BvbGxfc3luY2hyb25p
emVfcmN1X2V4cGVkaXRlZCgpIHRvDQo+ICAgIHNldCAtPmV4cF9zZXFfcG9sbF9ycSBvbmx5IGFm
dGVyIHJjdV9pbml0KCkgaGFzIGluaXRpYWxpemVkIGFsbCBDUFVzJw0KPiAgICByY3VfZGF0YSBz
dHJ1Y3R1cmVzJyAtPm15bm9kZSBmaWVsZHMuICBJdCBhbHNvIHJlbW92ZXMgdGhlIGNoZWNrIGZy
b20NCj4gICAgdGhlIHJjdV9pbml0KCkgZnVuY3Rpb24gc28gdGhhdCBzdGFydF9wb2xsX3N5bmNo
cm9uaXplX3JjdV9leHBlZGl0ZWQoDQo+ICAgIGlzIHVuY29uZGl0aW9uYWxseSBpbnZva2VkLiAg
WWVzLCB0aGlzIG1pZ2h0IHJlc3VsdCBpbiBhbiB1bm5lY2Vzc2FyeQ0KPiAgICBib290LXRpbWUg
Z3JhY2UgcGVyaW9kLCBidXQgdGhpcyBpcyBkb3duIGluIHRoZSBub2lzZS4gIEJlc2lkZXMsIHRo
ZXJlDQo+ICAgIG9ubHkgaGFzIHRvIGJlIG9uZSBjYWxsX3JjdSgpIGludm9rZWQgcHJpb3IgdG8g
c2NoZWR1bGVyIGluaXRpYWxpemF0aW9uDQo+ICAgIHRvIG1ha2UgdGhpcyBib290LXRpbWUgZ3Jh
Y2UgcGVyaW9kIG5lY2Vzc2FyeS4NCj4gICAgDQo+ICAgIFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8
cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4gICAgUmV2aWV3ZWQtYnk6IEZyZWRlcmljIFdlaXNi
ZWNrZXIgPGZyZWRlcmljQGtlcm5lbC5vcmc+DQo+ICAgIFJldmlld2VkLWJ5OiBKb2VsIEZlcm5h
bmRlcyAoR29vZ2xlKSA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4NCj4gICAgU2lnbmVkLW9mZi1i
eTogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPg0KPg0KPmRpZmYgLS1naXQg
YS9rZXJuZWwvcmN1L3RyZWUuYyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+aW5kZXggNjM1NDVkNzlk
YTUxYy4uZjJlM2EyMzc3OGMwNiAxMDA2NDQNCj4tLS0gYS9rZXJuZWwvcmN1L3RyZWUuYw0KPisr
KyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+QEAgLTQ5MzcsOSArNDkzNyw4IEBAIHZvaWQgX19pbml0
IHJjdV9pbml0KHZvaWQpDQo+IAllbHNlDQo+IAkJcW92bGRfY2FsYyA9IHFvdmxkOw0KPiANCj4t
CS8vIEtpY2stc3RhcnQgYW55IHBvbGxlZCBncmFjZSBwZXJpb2RzIHRoYXQgc3RhcnRlZCBlYXJs
eS4NCj4tCWlmICghKHBlcl9jcHVfcHRyKCZyY3VfZGF0YSwgY3B1KS0+bXlub2RlLT5leHBfc2Vx
X3BvbGxfcnEgJiAweDEpKQ0KPi0JCSh2b2lkKXN0YXJ0X3BvbGxfc3luY2hyb25pemVfcmN1X2V4
cGVkaXRlZCgpOw0KPisJLy8gS2ljay1zdGFydCBpbiBjYXNlIGFueSBwb2xsZWQgZ3JhY2UgcGVy
aW9kcyBzdGFydGVkIGVhcmx5Lg0KPisJKHZvaWQpc3RhcnRfcG9sbF9zeW5jaHJvbml6ZV9yY3Vf
ZXhwZWRpdGVkKCk7DQo+IA0KPiAJcmN1X3Rlc3Rfc3luY19wcmltcygpOw0KPiB9DQo+ZGlmZiAt
LWdpdCBhL2tlcm5lbC9yY3UvdHJlZV9leHAuaCBiL2tlcm5lbC9yY3UvdHJlZV9leHAuaA0KPmlu
ZGV4IDk1NmNkNDU5YmE3ZjMuLjNiN2FiYjU4MTU3ZGYgMTAwNjQ0DQo+LS0tIGEva2VybmVsL3Jj
dS90cmVlX2V4cC5oDQo+KysrIGIva2VybmVsL3JjdS90cmVlX2V4cC5oDQo+QEAgLTEwNjgsOSAr
MTA2OCwxMCBAQCB1bnNpZ25lZCBsb25nIHN0YXJ0X3BvbGxfc3luY2hyb25pemVfcmN1X2V4cGVk
aXRlZCh2b2lkKQ0KPiAJaWYgKHJjdV9pbml0X2ludm9rZWQoKSkNCj4gCQlyYXdfc3Bpbl9sb2Nr
X2lycXNhdmUoJnJucC0+ZXhwX3BvbGxfbG9jaywgZmxhZ3MpOw0KPiAJaWYgKCFwb2xsX3N0YXRl
X3N5bmNocm9uaXplX3JjdShzKSkgew0KPi0JCXJucC0+ZXhwX3NlcV9wb2xsX3JxID0gczsNCj4t
CQlpZiAocmN1X2luaXRfaW52b2tlZCgpKQ0KPisJCWlmIChyY3VfaW5pdF9pbnZva2VkKCkpIHsN
Cj4rCQkJcm5wLT5leHBfc2VxX3BvbGxfcnEgPSBzOw0KPiAJCQlxdWV1ZV93b3JrKHJjdV9ncF93
cSwgJnJucC0+ZXhwX3BvbGxfd3EpOw0KPisJCX0NCj4gCX0NCj4gCWlmIChyY3VfaW5pdF9pbnZv
a2VkKCkpDQo+IAkJcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnJucC0+ZXhwX3BvbGxfbG9j
aywgZmxhZ3MpOw0K
