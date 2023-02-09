Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB50A68FD56
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjBICum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjBICtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:49:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD6C1B556;
        Wed,  8 Feb 2023 18:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675910785; x=1707446785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uAvNkHmuOVRYY2vCeNWGJCtGC/F1EQi8A/EBv5y5onk=;
  b=YVw0VgKUEL1ufyz+lg2EubQ7m3r465hoBpVPpo+FLWvD8R2ARu2CrGxz
   Kc5SDmgGvWPEBwYeZUxxLSaxFRZ5tR+NO+sVpBEibkpQK1e5vE2nJLbrc
   V+k0TY4RZDILZPOQKFcRSb/jVPOhrC4YpYb+0zMfygp72mQZi02qOxOyv
   Pq+ctEKZ1mCJC1dXbDKTVM+hCbfTutddgWOpChZzWQNUxfbYcXMyS9LGx
   61DjpZM5tJAXelPjO6QvsDxhq0hg2lXansYZ1+d2srVGA4LUGxiJptCh3
   lUn0R4QLTTx5JZEjNflK6ynzieXzHk/CjGxBkX2ADH1WYDqt5MuKBnNne
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="327686794"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="327686794"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 18:46:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="736144216"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="736144216"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2023 18:46:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 18:46:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 18:46:24 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 18:46:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc5/VBMb0d+niLpejgCsQu/+CUmKxDUT+dFO6Uv5FM5HnNkgguc+ikTPh6JSk1W5QWI+vm9alnRXdCnPHLHoV8ZAdgnHVZDQoJA6Nl+XJAJsMYYXQP7GTdz2UaSZ22OnEEMSdHqqotQnXy9Fmb1x0SKc7aSEI7I1wUS1cOuOPIzgU1SbdydeIOJCIR98Ue63hooh46ypSCB66Q9sW48KCj4+71iGcOnnAfbgy6f4TUxfQcXIUbCvbQ1MfoMJ4zoQZs3BSRkoktSyaPK9l5GyzjD1+//bREim2SXIXNsnaPPS+46F9iaDspKJtHF5bOLd+kDr4ZGvsIygLejSEQkP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAvNkHmuOVRYY2vCeNWGJCtGC/F1EQi8A/EBv5y5onk=;
 b=E7wzOhKBe1772+4STTFOPYfyJD9SgSxit3ehtOWO/KjE5JHGSFN9rOE5pTve8ohnHOg9jrU+dXEvDt3bLi2iuJB99e03pCXsseRI2P6SJ7WpODLrcaCxK8w5pEwsDilNHI0/ps/7SF/z0UAwE1EeYFvUls8FOethqKg5i3UcDqIBgQ7BHPKEX2HvLkfB69XbltHtANr8W+i8zu9AJS2I7wlOw5kWyG4N3yv0IntpQKmlgyvKzy2bvKiLOtSjox8hBmCkEd+q5IIW5pxZtlyp3YY48/jLju7IWktnY86c1KQtb/dpOq1aCsYadFgnY5dQ8SkL8w70n9clgliFttC5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ1PR11MB6299.namprd11.prod.outlook.com (2603:10b6:a03:456::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Thu, 9 Feb
 2023 02:46:21 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%3]) with mapi id 15.20.6064.031; Thu, 9 Feb 2023
 02:46:21 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Fix bind rcu related kthreads to housekeeping CPUs
Thread-Topic: [PATCH] rcu: Fix bind rcu related kthreads to housekeeping CPUs
Thread-Index: AQHZO22FMh0rC5XT2EOgEG21AYZTWK7FBzGAgADiLdA=
Date:   Thu, 9 Feb 2023 02:46:21 +0000
Message-ID: <PH0PR11MB58804AEC975FFCA4495021CDDAD99@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230208033408.3997610-1-qiang1.zhang@intel.com>
 <IA1PR11MB61717873D4697DBB04526F6489D89@IA1PR11MB6171.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB61717873D4697DBB04526F6489D89@IA1PR11MB6171.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SJ1PR11MB6299:EE_
x-ms-office365-filtering-correlation-id: 01560cc8-841e-4d5f-04d6-08db0a47d3ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cEljlY2YUBAt269LKlQgi2EBa0cHL82+jG1xpFOUefwbluDJLhYTUW07p50GD2FQYwMRHa2rFqWKTvcGrBUKjBERgy1o4E23us0OhNG5qs0o+ZG5B3+wcipmfeuGPa/W86tVqmxFgr0VPC6ySNskktjV/0o2AzJrNmF/fChkXW88A967DrHcGmCeJyO1pUjmHdIkXhMRBnReY7oyrMUlcn6M6ud+IOz3w0NICzfYsqYxX4Jdxtc3veb+kK7MgmsRdi7ZYFsHKyuf1BfA2r21s1VNmjv4bmnSVQqq5/1rWMCQjBmmqQPaI0yRXnh4MhiW9ZJmHRGeN968XaRpAjD7b9BAu7tDu7Oe7y/SP5QCP62XkvLPg/FdMmsu2yJBgjpBzwGUrlDQTjJfs4FWfvfeDZbv/TYoJJygwB+jnSbOSOmZAbqr+D946HAQWVMxF7yxC9LsURpONa2mK8V+KpVvnc0X0v7jkAZq28DDkKi+MOH2IfXHkLlfJglYIQrBznQXIUcqybnjBSCzWGiHOTlvbB+jngFDcEJReK6kXPCEeX440QlVWjBH2RH9Jg3rX9P/EqC2ZcuOjxM9xkAoC5sbOfw2Ws4RamyZQSNiQkBlBb1/GuGG1jVZE3ZsPHcmkEe+sVoqF4YShnqElISOBXdBcuhQL/a372Jc/PWu7QcceC04vHn5pEYtjWIGbS8pUtcBIaUeEh38TaZOMIu+/r6AQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199018)(52536014)(8936002)(9686003)(41300700001)(26005)(186003)(86362001)(38100700002)(122000001)(4326008)(6506007)(38070700005)(53546011)(64756008)(8676002)(82960400001)(66556008)(66946007)(66476007)(66446008)(5660300002)(76116006)(316002)(110136005)(54906003)(33656002)(83380400001)(66574015)(2906002)(7696005)(55016003)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzNXR3YyZTFtZGEyRkFydHdCQWlXNHc1d1hkVjFXKzluenpBV01HMnRibWxV?=
 =?utf-8?B?cWYySmpzMnBJSHIrMFNuK0hGN1ZzWXdpRFRteXdtaXh6azBFZzlrM2lMWE9S?=
 =?utf-8?B?QkhzL3kxQk9VVGJPdTNIQW1icU5QZFNhTFBQVUUvRDUyQ0dhTjk2UjArUnVk?=
 =?utf-8?B?T3lJelFFOG9seEQ5R2hwSFpJQVlMcXE3YlM0aFhsTEtNZXo0WEtZK1B1QUpZ?=
 =?utf-8?B?cFJ6bUx3RStWS3FkOVZRcytMN3lkVlN2NW1vYXhOU0dpRG10YXVCR2ZhN3Er?=
 =?utf-8?B?dTRvSGpncFp3eGllbTdjaFdja25KYmhaV1dhNE82NFAyQVhOS1NDL2xFYnpX?=
 =?utf-8?B?Q2ppb3puQ0h6dzdHb2I0WWNOTmlZWXVEV01vd1FpU2trKzBrUktnNmZubFdQ?=
 =?utf-8?B?RUl3ZkNNcUFaMFhwenpmMVg1Z1JISUxZbzFzRlJLRW9mZFpTYzh6dm1lNXAy?=
 =?utf-8?B?OFJFcU42djYxMWtJck9FQVpWWHpWUGQ5aWV4Q0JYMUNyWFFLbStsNUI5alFj?=
 =?utf-8?B?WW93MTg1Q0VYNmNlclNiOEQ5ZkRtTVhMSFo5VFlleXJCb3VhMGRiTms2V2xR?=
 =?utf-8?B?Y2Rzbm1xT0tLVVJpbjZGcEI0WU1RRTFNTXNyTS9xMU1rMjdQY2ZJUmhlaGhD?=
 =?utf-8?B?cmNJb0EwMkhaWXBSV1I5UzVXcmNmTGhOVE5Ka3JiOFBMb0I0UGN1M0pDa1B5?=
 =?utf-8?B?UnlPMlhpRXdJcXBlbEo3THJEN0VaRDhaL045Q2xCZ3JqTHhSa3RMR0RyeGRk?=
 =?utf-8?B?YXdpYXEyMlA3c2VVOU9zY2RmYlhMUStvaVU2TFMzc3VzekpCRmkvdVV3UW1F?=
 =?utf-8?B?N05yc1JGZzVvWEFSVndtYUZzamZDdndUN2h4TWEzSTExVzh0QjF4ZkFyTVVa?=
 =?utf-8?B?b0VmNS8yRXByMVZiQXVYM24wQnRjRXNJSkVQazBnUGxieEtNdWdIUTRCT2Qv?=
 =?utf-8?B?SWUvRWxSSHVnRTdnNUhhaWFyRGw2S2ZsR0tadXEzaWxNM21raUorMXZhYjJy?=
 =?utf-8?B?ellJbjBTckxXaDhaZ2w5U0N4WGo3R0kvSmhxM1FJa0VLbmpHZzhIcXNzM1lm?=
 =?utf-8?B?cFQ1UVNNb1NVMVJOdFEvQzUwN0N5TnhCUlVHUXRleFBndUxPS0Y2L0lHM0lt?=
 =?utf-8?B?Vms1R1hjOGNER2ZtQk1ia094akxFMnIxS3FKVWZrbUF0RzFXQ0hzVXhaR3Ry?=
 =?utf-8?B?NUZCZjB5dDhScW00SEQzaDZVbldLRnZ2a3l0R3RadndRLzZNVkZkajk1aXlP?=
 =?utf-8?B?Z1ZCWCtPU1F0WThhczRldUFnczdKOUdGS1RRSlMyZTN5eFVjVFdmYWM3UytJ?=
 =?utf-8?B?NFV5L2RuOG1Yd2pDSi9wQlVKMS85SW5zbkk2SGlXNWRRYnVycEFISSswU281?=
 =?utf-8?B?QTBLN3NnUE4rSDFvZU9Rb0tqRWpJeVZDdlRGaUh1dXFFbmtyZUQzTnNlcmZI?=
 =?utf-8?B?QmdFbGZYek1sa2xLOUhBRnd3RWhlcVRYK0lFREgzWUlNMWxDNjR5SlFGdFA0?=
 =?utf-8?B?emNwRm95a0FaRXRBaUhia3NyTkNiY3FDUHAzMW15TWJEczhFMWhoVU43K0lW?=
 =?utf-8?B?ZGZyb1Y2bVl5bGs2RkR4UXVycmNHWFdHS3NVcUU5YkxEQzZ3WjFqbXYwUTJi?=
 =?utf-8?B?WHQxWGo5cXZwTnZTZGdXbkRzaVV6UXcydkRReVV4WktZWjdmclpDdjhuOWNs?=
 =?utf-8?B?QkhhbG1sWnpDZEVnL3JmcTZEci9GTkt0aFRzS3J6WVpGS3NxRXRuc1VHdkNY?=
 =?utf-8?B?V1VsclFSUzVJdXNIcmw0ZXJtb21LWlUrazd4UnVxaE5pUS9qVTl1ekk3U21O?=
 =?utf-8?B?MkNVOThNaFVKeVlPSGdqTVBkUGVmSXpkOUJrWi96QXhPT1NTSnY2ek5kRE14?=
 =?utf-8?B?WmFjR1k2NGx6dndUNUdFc3RSemdyM0dxL0gwcklFOEQwaCtOMk5jdWZRQ3lU?=
 =?utf-8?B?QWFtYmR6eEk0WXZKN1ZWLytsMDJqeWVSWmFkRk84akcwZzhXQk45SXNXSTZm?=
 =?utf-8?B?NDFhVFAxT0txSDAvQTZpSEUxTi8yV2I5eFRMd1ZFV1p6Z1hhVHFDUFVyU1NO?=
 =?utf-8?B?aUlUVFpOVWZSMWQyNGFHN2ViWXlmdlNoQlcwY2F2Q243TXpzQWgwaDJiVWIr?=
 =?utf-8?Q?4oMv1q7OE9qqnN6qAzF/idCHA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01560cc8-841e-4d5f-04d6-08db0a47d3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 02:46:21.2966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/8/jBBSCoe4FbH/Dh84enhtNxj2AzofIpKocD281ZY7CNnW7G5hVzMnhfRNTUnKRS6Yir4W+vwIUb8mI9pAaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6299
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+RGlkIHRoZSB0ZXN0aW5nIGFuZCBjaGVja2VkIHRoZSBDUFUgYWZmaW5pdGllcyBvZiBSQ1Ug
a3RocmVhZHMgYnkgcnVubmluZyAicHMgLWVvIHBzcixjb21tfCBncmVwIHJjdSIgWzFdOg0KPg0K
PldpdGhvdXQgWnFpYW5nJ3MgcGF0Y2g6DQo+ICAgIC4uLg0KPiAgICAwIHJjdV9wcmVlbXB0DQo+
ICAgIDAgcmN1b2cvMA0KPiAgICAwIHJjdW9wLzANCj4gICAgMCByY3VvcC8xDQo+ICAgIDAgcmN1
b2cvMg0KPiAgICAwIHJjdW9wLzINCj4gICAgMiByY3VvcC8zDQo+DQo+V2l0aCBacWlhbmcncyBw
YXRjaDoNCj4gICAgLi4uDQo+ICAgIDMgcmN1X3ByZWVtcHQgICAvLyBvbiBob3VzZWtlZXBpbmcg
Q1BVIDMNCj4gICAgMiByY3VvZy8wICAgICAgICAgICAgLy8gb24gaG91c2VrZWVwaW5nIENQVSAy
DQo+ICAgIDMgcmN1b3AvMCAgICAgICAgICAgIC8vIG9uIGhvdXNla2VlcGluZyBDUFUgMw0KPiAg
ICAzIHJjdW9wLzEgICAgICAgICAgICAvLyBvbiBob3VzZWtlZXBpbmcgQ1BVIDMNCj4gICAgMCBy
Y3VvZy8yICAgICAgICAgICAgLy8gb24gbm9uLWhvdXNla2VlcGluZyBDUFUgMC4gIFsyXQ0KPiAg
ICAwIHJjdW9wLzIgICAgICAgICAgICAvLyBvbiBub24taG91c2VrZWVwaW5nIENQVSAwLiAgWzJd
DQo+ICAgIDIgcmN1b3AvMw0KPg0KPlsxXSBUaGUgMXN0IGNvbHVtbiBvZiB0aGUgb3V0cHV0IGlz
IGZvciBDUFUgSURzIGFuZCB0aGUgMm5kIGNvbHVtbiBpcyBmb3IgdGhyZWFkIG5hbWVzLiANCj5b
Ml0gQWRkZWQgZGVidWcgbWVzc2FnZXMgaW50byB0aGUgdHdvIHRocmVhZHMsIGFuZCBmb3VuZCB0
aGF0IHRoZSB0d28gdGhyZWFkcyBkaWRuJ3QgcnVuIGFmdGVyIGFsbCBDUFVzIHdlcmUgb25saW5l
Lg0KPiAgICAgU28gaWYgdGhleSBydW4gYWdhaW4gYWZ0ZXIgYWxsIENQVXMgYXJlIG9ubGluZSwg
dGhleSB3aWxsIGFsc28gYmUgbW92ZWQgdG8gaG91c2VrZWVwaW5nIENQVXMgYnkgWnFpYW5nJ3Mg
cGF0Y2guIA0KPg0KPiBGcm9tOiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgOCwgMjAyMyAxMTozNCBBTQ0KPiBUbzogcGF1bG1ja0Br
ZXJuZWwub3JnOyBmcmVkZXJpY0BrZXJuZWwub3JnOyBqb2VsQGpvZWxmZXJuYW5kZXMub3JnDQo+
IENjOiByY3VAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFtQQVRDSF0gcmN1OiBGaXggYmluZCByY3UgcmVsYXRlZCBrdGhyZWFkcyB0byBo
b3VzZWtlZXBpbmcgQ1BVcw0KPiANCj4gRm9yIGtlcm5lbHMgYnVpbHQgd2l0aCBDT05GSUdfTk9f
SFpfRlVMTD15IGFuZCBDT05GSUdfUkNVX05PQ0JfQ1BVPXksDQo+IHJ1biB0aGUgZm9sbG93aW5n
IHRlc3RzOg0KPiANCj4gcnVucWVtdSBrdm0gc2xpcnAgbm9ncmFwaGljIHFlbXVwYXJhbXM9Ii1t
IDEwMjQgLXNtcCA0Ig0KPiBib290cGFyYW1zPSJjb25zb2xlPXR0eVMwIGlzb2xjcHVzPTAsMSBu
b2h6X2Z1bGw9MCwxIHJjdV9ub2Nicz0wLDEiDQo+IA0KPiByb290QHFlbXV4ODYtNjQ6fiMgcHMg
LWVmIHwgZ3JlcCAicmN1X3ByZWVtcHQiIHwgZ3JlcCAtdiBncmVwIHwgYXdrICd7cHJpbnQNCj4g
JDJ9Jw0KPiAxNQ0KPiByb290QHFlbXV4ODYtNjQ6fiMgcHMgLWVmIHwgZ3JlcCAicmN1b3AvMCIg
fCBncmVwIC12IGdyZXAgfCBhd2sgJ3twcmludCAkMn0nDQo+IDE3DQo+IHJvb3RAcWVtdXg4Ni02
NDp+IyB0YXNrc2V0IC1wIDE1DQo+IHBpZCAxNSdzIGN1cnJlbnQgYWZmaW5pdHkgbWFzazogMQ0K
PiByb290QHFlbXV4ODYtNjQ6fiMgdGFza3NldCAtcCAxNw0KPiBwaWQgMTcncyBjdXJyZW50IGFm
ZmluaXR5IG1hc2s6IDENCj4gDQo+IFRoZSBhZmZpbml0eSBvZiB0aGVzZSByY3UgcmVsYXRlZCBr
dGhyZWFkcyBpcyBub3Qgc2V0IHRvIGhvdXNla2VlcGluZyBjcHVtYXNrLA0KPiBldmVuIGlmIGNh
bGxlZCByY3VfYmluZF9ncF9rdGhyZWFkKCkgd2hlbiB0aGUgcmN1IHJlbGF0ZWQga3RocmVhZCBz
dGFydHMuDQo+IA0KPiBzZXRfY3B1c19hbGxvd2VkX3B0cigpDQo+ICAtPl9fc2V0X2NwdXNfYWxs
b3dlZF9wdHIoKQ0KPiAgICAtPl9fc2V0X2NwdXNfYWxsb3dlZF9wdHJfbG9ja2VkDQo+ICAgICAg
ew0KPiAJCWJvb2wga3RocmVhZCA9IHAtPmZsYWdzICYgUEZfS1RIUkVBRDsNCj4gCQkuLi4uDQo+
IAkJaWYgKGt0aHJlYWQgfHwgaXNfbWlncmF0aW9uX2Rpc2FibGVkKHApKQ0KPiAJCQljcHVfdmFs
aWRfbWFzayA9IGNwdV9vbmxpbmVfbWFzazsNCj4gCQkuLi4uDQo+IAkJZGVzdF9jcHUgPSBjcHVt
YXNrX2FueV9hbmRfZGlzdHJpYnV0ZShjcHVfdmFsaWRfbWFzaywgY3R4LQ0KPiA+bmV3X21hc2sp
Ow0KPiAJCWlmIChkZXN0X2NwdSA+PSBucl9jcHVfaWRzKSB7DQo+IAkJCXJldCA9IC1FSU5WQUw7
DQo+IAkJCWdvdG8gb3V0Ow0KPiAJCX0NCj4gCQkuLi4uDQo+ICAgICAgfQ0KPiANCj4gRHVlIHRv
IHRoZXNlIHJjdSByZWxhdGVkIGt0aHJlYWRzIGJlIGNyZWF0ZWQgYmVmb3JlIGJyaW5ndXAgb3Ro
ZXIgQ1BVUywgc28NCj4gd2hlbiB0aGV5IHJ1bm5pbmcgYW5kIHNldCBob3Nla2VlcGluZyBjcHVz
IGFmZmluaXR5LCBmb3VuZCB0aGF0IG9ubHkgQ1BVMCBpcw0KPiBvbmxpbmUgYXQgdGhpcyB0aW1l
IGFuZCBDUFUwIGlzIHNldCB0byBub19oel9mdWxsIENQVSwgdGhlIGN0eC0+bmV3X21hc2sgbm90
DQo+IGNvbnRhaW4gQ1BVMCBhbmQgdGhpcyB3aWxsIGNhdXNlIGRlc3RfY3B1IGluIHRoZSBhYm92
ZSBjb2RlIHNuaXBwZXQgdG8gYmUgYW4NCj4gaWxsZWdhbCB2YWx1ZSBhbmQgcmV0dXJuIGRpcmVj
dGx5LCB1bHRpbWF0ZWx5LCB0aGVzZSByY3UgcmVsYXRlZCBrdGhyZWFkcyBmYWlsZWQgdG8NCj4g
YmluZCBob3VzZWtlZXBpbmcgQ1BVUy4NCj4NCj5zL3NvLy8NCj5zL2hvc2VrZWVwaW5nL2hvdXNl
a2VlcGluZy8NCj4uLi4NCj4NCj4gVGhpcyBjb21taXQgdGhlcmVmb3JlIHJlYmluZCB0aGVzZSBy
Y3UgcmVsYXRlZCBrdGhyZWFkcyB0byBob3VzZWtlZXBpbmcgQ1BVcw0KPg0KPnMvcmViaW5kL3Jl
YmluZHMvDQo+DQo+Q291bGQgeW91IHR3ZWFrIGFsbCB0aGUgY29tbWl0IG1lc3NhZ2VzIHRvIGZp
eCB0aGUgdHlwb3MgYW5kIHRoZSBncmFtbWFyIGVycm9ycz8g8J+Yig0KPk90aGVyIHRoYW4gdGhh
dCwgDQoNCg0KVGhhbmtzIGZvciB0ZXN0aW5nLCAgSSBpZ25vcmUgdGhlIGNwdSBob3RwbHVnIHNj
ZW5hcmlvIGFuZCBleHAga3dvcmtlciBjcHUgYWZmaW5pdHkgc2V0dGluZywNCkkgd2lsbCBhZGQg
VGVzdGVkLWJ5IHRhZ3MgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MNClpxaWFuZw0KDQoNCj4N
Cj4gICAgVGVzdGVkLWJ5OiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4NCj4NCj4g
YWZ0ZXIgdGhlIGtlcm5lbCBib290IHNlcXVlbmNlIGVuZHMsIGF0IHRoaXMgcG9pbnQgYWxsIENQ
VXMgYXJlIG9ubGluZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpoYW5n
QGludGVsLmNvbT4NCj4gLS0tDQo+ICBrZXJuZWwvcmN1L3Rhc2tzLmggICAgICAgfCAgNyArKysr
Ky0tDQo+ICBrZXJuZWwvcmN1L3RyZWUuYyAgICAgICAgfCAgNyArKysrKystDQo+ICBrZXJuZWwv
cmN1L3RyZWUuaCAgICAgICAgfCAgMSAtDQo+ICBrZXJuZWwvcmN1L3RyZWVfbm9jYi5oICAgfCAx
MyArKysrKysrKysrKystDQo+ICBrZXJuZWwvcmN1L3RyZWVfcGx1Z2luLmggfCAgOSAtLS0tLS0t
LS0NCj4gIDUgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90YXNrcy5oIGIva2VybmVsL3JjdS90YXNr
cy5oIGluZGV4DQo+IGJhZjdlYzE3ODE1NS4uOGIzNTMwY2NhMjkxIDEwMDY0NA0KPiAtLS0gYS9r
ZXJuZWwvcmN1L3Rhc2tzLmgNCj4gKysrIGIva2VybmVsL3JjdS90YXNrcy5oDQo+IEBAIC01NDQs
OSArNTQ0LDggQEAgc3RhdGljIHZvaWQgcmN1X3Rhc2tzX29uZV9ncChzdHJ1Y3QgcmN1X3Rhc2tz
ICpydHAsIGJvb2wNCj4gbWlkYm9vdCkgIHN0YXRpYyBpbnQgX19ub3JldHVybiByY3VfdGFza3Nf
a3RocmVhZCh2b2lkICphcmcpICB7DQo+ICAJc3RydWN0IHJjdV90YXNrcyAqcnRwID0gYXJnOw0K
PiArCWJvb2wgcmN1X3NldGFmZmluaXR5X3NldHVwID0gZmFsc2U7DQo+IA0KPiAtCS8qIFJ1biBv
biBob3VzZWtlZXBpbmcgQ1BVcyBieSBkZWZhdWx0LiAgU3lzYWRtIGNhbiBtb3ZlIGlmIGRlc2ly
ZWQuDQo+ICovDQo+IC0JaG91c2VrZWVwaW5nX2FmZmluZShjdXJyZW50LCBIS19UWVBFX1JDVSk7
DQo+ICAJV1JJVEVfT05DRShydHAtPmt0aHJlYWRfcHRyLCBjdXJyZW50KTsgLy8gTGV0IEdQcyBz
dGFydCENCj4gDQo+ICAJLyoNCj4gQEAgLTU1Niw2ICs1NTUsMTAgQEAgc3RhdGljIGludCBfX25v
cmV0dXJuIHJjdV90YXNrc19rdGhyZWFkKHZvaWQgKmFyZykNCj4gIAkgKiBUaGlzIGxvb3AgaXMg
dGVybWluYXRlZCBieSB0aGUgc3lzdGVtIGdvaW5nIGRvd24uICA7LSkNCj4gIAkgKi8NCj4gIAlm
b3IgKDs7KSB7DQo+ICsJCWlmICghcmN1X3NldGFmZmluaXR5X3NldHVwICYmIHJjdV9pbmtlcm5l
bF9ib290X2hhc19lbmRlZCgpKSB7DQo+ICsJCQlzZXRfY3B1c19hbGxvd2VkX3B0cihjdXJyZW50
LA0KPiBob3VzZWtlZXBpbmdfY3B1bWFzayhIS19UWVBFX1JDVSkpOw0KPiArCQkJcmN1X3NldGFm
ZmluaXR5X3NldHVwID0gdHJ1ZTsNCj4gKwkJfQ0KPiAgCQkvLyBXYWl0IGZvciBvbmUgZ3JhY2Ug
cGVyaW9kIGFuZCBpbnZva2UgYW55IGNhbGxiYWNrcw0KPiAgCQkvLyB0aGF0IGFyZSByZWFkeS4N
Cj4gIAkJcmN1X3Rhc2tzX29uZV9ncChydHAsIGZhbHNlKTsNCj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9yY3UvdHJlZS5jIGIva2VybmVsL3JjdS90cmVlLmMgaW5kZXgNCj4gZWUyN2EwM2Q3NTc2Li4w
YWM0N2E3NzNlMTMgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jDQo+ICsrKyBiL2tl
cm5lbC9yY3UvdHJlZS5jDQo+IEBAIC0xNzgxLDggKzE3ODEsMTMgQEAgc3RhdGljIG5vaW5saW5l
IHZvaWQgcmN1X2dwX2NsZWFudXAodm9pZCkNCj4gICAqLw0KPiAgc3RhdGljIGludCBfX25vcmV0
dXJuIHJjdV9ncF9rdGhyZWFkKHZvaWQgKnVudXNlZCkgIHsNCj4gLQlyY3VfYmluZF9ncF9rdGhy
ZWFkKCk7DQo+ICsJYm9vbCByY3Vfc2V0YWZmaW5pdHlfc2V0dXAgPSBmYWxzZTsNCj4gKw0KPiAg
CWZvciAoOzspIHsNCj4gKwkJaWYgKCFyY3Vfc2V0YWZmaW5pdHlfc2V0dXAgJiYgcmN1X2lua2Vy
bmVsX2Jvb3RfaGFzX2VuZGVkKCkpIHsNCj4gKwkJCXNldF9jcHVzX2FsbG93ZWRfcHRyKGN1cnJl
bnQsDQo+IGhvdXNla2VlcGluZ19jcHVtYXNrKEhLX1RZUEVfUkNVKSk7DQo+ICsJCQlyY3Vfc2V0
YWZmaW5pdHlfc2V0dXAgPSB0cnVlOw0KPiArCQl9DQo+IA0KPiAgCQkvKiBIYW5kbGUgZ3JhY2Ut
cGVyaW9kIHN0YXJ0LiAqLw0KPiAgCQlmb3IgKDs7KSB7DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwv
cmN1L3RyZWUuaCBiL2tlcm5lbC9yY3UvdHJlZS5oIGluZGV4DQo+IDE5MjUzNjkxNmY5YS4uMzkx
ZTNmYWU0ZmY1IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvcmN1L3RyZWUuaA0KPiArKysgYi9rZXJu
ZWwvcmN1L3RyZWUuaA0KPiBAQCAtNDk1LDcgKzQ5NSw2IEBAIGRvIHsNCj4gCQlcDQo+ICAjZGVm
aW5lIHJjdV9ub2NiX2xvY2tfaXJxc2F2ZShyZHAsIGZsYWdzKSBsb2NhbF9pcnFfc2F2ZShmbGFn
cykgICNlbmRpZiAvKiAjZWxzZQ0KPiAjaWZkZWYgQ09ORklHX1JDVV9OT0NCX0NQVSAqLw0KPiAN
Cj4gLXN0YXRpYyB2b2lkIHJjdV9iaW5kX2dwX2t0aHJlYWQodm9pZCk7DQo+ICBzdGF0aWMgYm9v
bCByY3Vfbm9oel9mdWxsX2NwdSh2b2lkKTsNCj4gDQo+ICAvKiBGb3J3YXJkIGRlY2xhcmF0aW9u
cyBmb3IgdHJlZV9zdGFsbC5oICovIGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWVfbm9jYi5o
DQo+IGIva2VybmVsL3JjdS90cmVlX25vY2IuaCBpbmRleCBmMjI4MDYxNmY5ZDUuLjI1NGQwZjYz
MWQ1NyAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3JjdS90cmVlX25vY2IuaA0KPiArKysgYi9rZXJu
ZWwvcmN1L3RyZWVfbm9jYi5oDQo+IEBAIC04OTQsOCArODk0LDE0IEBAIHN0YXRpYyB2b2lkIG5v
Y2JfZ3Bfd2FpdChzdHJ1Y3QgcmN1X2RhdGEgKm15X3JkcCkNCj4gc3RhdGljIGludCByY3Vfbm9j
Yl9ncF9rdGhyZWFkKHZvaWQgKmFyZykgIHsNCj4gIAlzdHJ1Y3QgcmN1X2RhdGEgKnJkcCA9IGFy
ZzsNCj4gKwlib29sIHJjdV9zZXRhZmZpbml0eV9zZXR1cCA9IGZhbHNlOw0KPiANCj4gIAlmb3Ig
KDs7KSB7DQo+ICsJCWlmICghcmN1X3NldGFmZmluaXR5X3NldHVwICYmIHJjdV9pbmtlcm5lbF9i
b290X2hhc19lbmRlZCgpKSB7DQo+ICsJCQlzZXRfY3B1c19hbGxvd2VkX3B0cihjdXJyZW50LA0K
PiBob3VzZWtlZXBpbmdfY3B1bWFzayhIS19UWVBFX1JDVSkpOw0KPiArCQkJcmN1X3NldGFmZmlu
aXR5X3NldHVwID0gdHJ1ZTsNCj4gKwkJfQ0KPiArDQo+ICAJCVdSSVRFX09OQ0UocmRwLT5ub2Ni
X2dwX2xvb3BzLCByZHAtPm5vY2JfZ3BfbG9vcHMgKyAxKTsNCj4gIAkJbm9jYl9ncF93YWl0KHJk
cCk7DQo+ICAJCWNvbmRfcmVzY2hlZF90YXNrc19yY3VfcXMoKTsNCj4gQEAgLTEwMDIsMTAgKzEw
MDgsMTUgQEAgc3RhdGljIHZvaWQgbm9jYl9jYl93YWl0KHN0cnVjdCByY3VfZGF0YSAqcmRwKQ0K
PiBzdGF0aWMgaW50IHJjdV9ub2NiX2NiX2t0aHJlYWQodm9pZCAqYXJnKSAgew0KPiAgCXN0cnVj
dCByY3VfZGF0YSAqcmRwID0gYXJnOw0KPiAtDQo+ICsJYm9vbCByY3Vfc2V0YWZmaW5pdHlfc2V0
dXAgPSBmYWxzZTsNCj4gIAkvLyBFYWNoIHBhc3MgdGhyb3VnaCB0aGlzIGxvb3AgZG9lcyBvbmUg
Y2FsbGJhY2sgYmF0Y2gsIGFuZCwNCj4gIAkvLyBpZiB0aGVyZSBhcmUgbm8gbW9yZSByZWFkeSBj
YWxsYmFja3MsIHdhaXRzIGZvciB0aGVtLg0KPiAgCWZvciAoOzspIHsNCj4gKwkJaWYgKCFyY3Vf
c2V0YWZmaW5pdHlfc2V0dXAgJiYgcmN1X2lua2VybmVsX2Jvb3RfaGFzX2VuZGVkKCkpIHsNCj4g
KwkJCXNldF9jcHVzX2FsbG93ZWRfcHRyKGN1cnJlbnQsDQo+IGhvdXNla2VlcGluZ19jcHVtYXNr
KEhLX1RZUEVfUkNVKSk7DQo+ICsJCQlyY3Vfc2V0YWZmaW5pdHlfc2V0dXAgPSB0cnVlOw0KPiAr
CQl9DQo+ICsNCj4gIAkJbm9jYl9jYl93YWl0KHJkcCk7DQo+ICAJCWNvbmRfcmVzY2hlZF90YXNr
c19yY3VfcXMoKTsNCj4gIAl9DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWVfcGx1Z2lu
LmggYi9rZXJuZWwvcmN1L3RyZWVfcGx1Z2luLmggaW5kZXgNCj4gN2IwZmU3NDFhMDg4Li5mZGRl
NzFlYmI4M2UgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaA0KPiArKysg
Yi9rZXJuZWwvcmN1L3RyZWVfcGx1Z2luLmgNCj4gQEAgLTEyOTQsMTIgKzEyOTQsMyBAQCBzdGF0
aWMgYm9vbCByY3Vfbm9oel9mdWxsX2NwdSh2b2lkKQ0KPiAgCXJldHVybiBmYWxzZTsNCj4gIH0N
Cj4gDQo+IC0vKg0KPiAtICogQmluZCB0aGUgUkNVIGdyYWNlLXBlcmlvZCBrdGhyZWFkcyB0byB0
aGUgaG91c2VrZWVwaW5nIENQVS4NCj4gLSAqLw0KPiAtc3RhdGljIHZvaWQgcmN1X2JpbmRfZ3Bf
a3RocmVhZCh2b2lkKQ0KPiAtew0KPiAtCWlmICghdGlja19ub2h6X2Z1bGxfZW5hYmxlZCgpKQ0K
PiAtCQlyZXR1cm47DQo+IC0JaG91c2VrZWVwaW5nX2FmZmluZShjdXJyZW50LCBIS19UWVBFX1JD
VSk7DQo+IC19DQo+IC0tDQo+IDIuMjUuMQ0KDQo=
