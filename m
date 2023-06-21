Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F0673885B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjFUPGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjFUPGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:06:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7838E213E;
        Wed, 21 Jun 2023 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687359626; x=1718895626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x8gXMNffuaEuwVB74/qdKsKvxOu/tH0yMnW4Dnzea7g=;
  b=VLEqwzEncol+B2Ci4orPtnWTYELs/hVgxuau4gvAIiGVWdRw6RX5T8Sg
   0xiJ2TcM3cgTGSZFWkkW17VfA1q1odRf8jXM/Q57/wh06YaQS7RYvBsD6
   Xl29NgBdmNeNHSqLrGu38FfFNn+x36eWWKFlstGxHK6OJbkLWuFquplkP
   1I0lMnYRwvc8kjQEzMvnxzl2o8QOiBklMmT4OyV13Y59wOZCDbjrZHxEv
   4XHITkfenDuCQkF6kA1Urfa2KfHmvoLXSormXRSwVlitUyPUNEoXN2sqZ
   CcezrB6SDZYVeCgSJPjrBT6yDjy/t1LnVbk3FoZaqpJp5MQwvBGkGtpnz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="426149157"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="426149157"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:54:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="664693501"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664693501"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2023 07:54:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 07:54:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 07:54:26 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 07:54:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgWW1a0cFf4BJLwlaOMlmTAEsUXxD6DH3coxn1uvsqRsk1UAmf4BagqG0AQ1uBGJM5ErIBSr5IFv8uFar0DWCM/YIH1VcadjGCKbDyGgokrBKbxOnvduQBJ1W4IKFAT3zuB8DKr6tUWp004CI/YXZChE5SxPPQxFzoEdaS5o8385v4Faiy7w+op6tAop/4067+p3V8vVBEnXgrrLr/BlFDD/zNkDZK+kOyShef7qFFVo8xnvTE1js9/oQND0vCQe/W4/LGSM4bkujF2w2cE/5AVQFl+35Cu/oKIb9ZgEEaR2l5HyyyLVyBQC3gFcW/T8l97pij0CriUptWxXjw2WaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8gXMNffuaEuwVB74/qdKsKvxOu/tH0yMnW4Dnzea7g=;
 b=oGVGgw8K+skhW5TsA6ztnCznnfGpUkuFypGsHRpqBg4ZWrSgSen1i6GmSKqJGUHSKX3uEJ21a1DzWbwPdRo66vdoLyTX+3f2KHpPUp/2HzffN9E+Ryyo+gcVMperIZK2n72Za2sMZ+8eY2nKsnnlRmqxF4kaeZEHf62JIjDNRNgl6sPuJDgr6sRy2OgjmfL8xfVAxTINm1U3OHV4I1nzNx5KMm7GbYQ7c6kTJZS61mDXynRGNw3vZlqSw9yEtF0+Cxg6nxr0KneBzanMWB/ISvQPEDg8LhvM7jJxbbRndXuflC01QVBwdlTt4ZWBS/r/Z07bdztd9EyYkFsBGNmWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com (2603:10b6:a03:4ed::18)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:54:24 +0000
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf]) by SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:54:24 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] thermal/drivers/int340x: Remove
 PROC_THERMAL_FEATURE_WLT_REQ for Meteor Lake
Thread-Topic: [PATCH 4/7] thermal/drivers/int340x: Remove
 PROC_THERMAL_FEATURE_WLT_REQ for Meteor Lake
Thread-Index: AQHZo8s5PV97RiSFBEKmyfb43nKvua+VWOkA
Date:   Wed, 21 Jun 2023 14:54:24 +0000
Message-ID: <ba3c27f437c3576a8564c3618206706e1a5bb7f1.camel@intel.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
         <20230620230150.3068704-5-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230620230150.3068704-5-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0086:EE_|PH7PR11MB7595:EE_
x-ms-office365-filtering-correlation-id: 7d6877fd-1767-4a37-458a-08db7267676e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TcvqHI7DD2l3lxWqEIPBrm3D5l1AxiyCUjwnsA9MahVueeyuGfbz/VYnQUjEctwEeQnjD+YyOBaCq93Nken0u4hncexwdKcblG/RbTm9FyWSHNYWnvA9HYQsLp2zBC9jG2XQbzEwy8TNFnIxLmPJNhJ7csC7b+PRUwmpFVRoX4QGXtn1TCCXcq9q8r/oNfbpnks9r9e9jGpWIFhPmBNNIJLXfAgKBDzRwOgcuU6cb2C4jgyHhs1jNEOiTPbuy5hyhvRkedM1/cxlNzIkFUoPuFlsyXRJtv9Ruq/Ggz6ZK6bh5flTZBpUgz60beva+kKLGusf7eYk2ISMzZMkFcdoF+PgwDv6hfouh5SZHzt/EoB/Ok1vlMCIzFVjVeEV/cfCqvWduxSlhWTPG7j3GKXc/RiFtZQkie4n1N4w3wP6kKoe0RTnBhe21HbTioZVySvKC8e73+qD9UGn/biMUnaarj+COug4NrNMHDtTU53PGl48foNmEqVgao6/i9TYEoUKGN15sKnuM8URp9juUabyf9bBgzPN+/S8It/W6Usj2MbTPw8g3AcTayYJPJAw3xf+/bHyLQ/WrodlZc3MFvHfSUp48QFdQbBBffT+1xtGXTdfQtDkPRPJyfRkNccDD4o/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(6486002)(83380400001)(6506007)(6512007)(186003)(26005)(2616005)(36756003)(71200400001)(38100700002)(316002)(4326008)(76116006)(66946007)(66446008)(64756008)(66476007)(66556008)(2906002)(122000001)(91956017)(8676002)(8936002)(86362001)(82960400001)(5660300002)(38070700005)(41300700001)(54906003)(478600001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUo2RmNkSG1VK0R1dHFzbmJFa203NXYxSWxsVmp4aTExMnVEbmpWZnExa0NW?=
 =?utf-8?B?cllNclFiQ3ZBRkdNUXlzM1ZnR0hiaVl0ZXI0UHZjb1JTU09HYkI4bHJ0SjJy?=
 =?utf-8?B?RVN1L2hBMjdqM0NxZXVBN25hNXIwQlduOG9uck9iZjJZcitPc2ZXai94YUZP?=
 =?utf-8?B?Nnd4ZEhIT29pRzVDa1NTR3JDRXZySXVxNmI0ZS9IOE4ycjhKUE9sOTh6alNQ?=
 =?utf-8?B?Q3hQTHVlMFIyZ1lZY1F4cmdaYjF3a3M3bnJIUWYzWGx0WDFodnhBSmxubURK?=
 =?utf-8?B?OUxhUnNJdjRWRkJpZlJXQ01DakRCaHUrdnl4Y0w3WlZRaTRTNks1eDROUHZ6?=
 =?utf-8?B?U1V5RnZsUVhQMHRyVWYrczdTMDlnTGlqMWJtRXU4OU5WSDJVVzlvZHY2Qmx5?=
 =?utf-8?B?bG9EMkpycXZDYUl0UDNaSkZLalZ1L3V2d1VZZjdJdHBvN3hlYzhlbFQyckNR?=
 =?utf-8?B?VEhkZjFUTGJvV29ER2hIT3kzWkpNS0lPYi9rcUFnbVZ6V0EwN1liM1RvYmRs?=
 =?utf-8?B?cm9Yd0pQNEgydkNIRWxUV1gvZDArN2xURmtVZXRkM25aeE5FQnQxU3RTMHN3?=
 =?utf-8?B?REtNS3UraStUbmJZVnFmcUhsLzN1dnZZVklFVHlFVTJycHcwMnNqTnFiRTda?=
 =?utf-8?B?aTRRT3ROY0VjTm5UTVE2SC9QVSs3MkdJRi80RGlUQ2lnWE9ERHZUeHVoOGdl?=
 =?utf-8?B?SHFFZDZxWEFDeW9PRFJSVFRmcE1ZUjVHSXloZlczRlpReWl4QlkwMlVlZTdF?=
 =?utf-8?B?bEJ1SjJIalIxUWpSMnFuaFVYcmkySlhBWER2Q2dTUjBMUk1Benh4N1N3VjIy?=
 =?utf-8?B?M2xrcWYwNStheSttWkxLZEdhM3RPcDFqaEY0UWY4ZTlIQ2lQVVFIU1J6SSth?=
 =?utf-8?B?bStHL0M3ckFSMjgvS1ErV1FlTEhCTWxyN1NzZ09UMlNUZ01QWUxXQTlkUExv?=
 =?utf-8?B?eGRRSnNCZG5rMzZYelBTY0VNbHpBTHhjaTdXcTd5UnZpY1I3Vnp3emxrYnJm?=
 =?utf-8?B?ODZ5TXBmV2NVK1BDY1pHdDhSQm16N0QwTFUyWit2K04va2ZndEVzSGRJZ3R6?=
 =?utf-8?B?M1A3YmhUYXJxbkJ0Tm15dzdLOVk1bVJHVUFyYWI1TkhadW1vaUNHbFZ2Q0la?=
 =?utf-8?B?VzU3cUl5VnNjR0dSK2p0MlJrd2ttaHlrM3IrU001bnhZYWRSZzhJL3I5SHdL?=
 =?utf-8?B?MG1vTmJsV1ZFNjhHUHdaUEc5c01Fa3A4bk04T1YxRkxyOVp6cUsweElHVjBH?=
 =?utf-8?B?NklRb0FmWlZkT25hSW1sbHQzMzR0SVdVcTJmMDd5Y1dqU1YreTdVRDZUTmNa?=
 =?utf-8?B?dVBwSEVVNWRiM28ySEtxbXNwYXl5MVpSV2N2dThYV0daaDRzZkFaQ3ZuMGpZ?=
 =?utf-8?B?L29za0pSTzVNRHh4WGNuQXZrR2VxWVBBSW5leVdYZjkyZDhvSVZBcEVielU2?=
 =?utf-8?B?MDFnaDV5TUJieFpyaG1MRU9pQklXUUlXUDdLVWhBMDZlV1J1L3NxcnVnOGNs?=
 =?utf-8?B?NmkrOThScVpsemJNZVlCTnlrQlRjYUlvcGg3TU1xbkFuUGVIb2tIbDBHTzIx?=
 =?utf-8?B?OXlIa05YdVhiUE52bVNBUW1LSHBReS9aV1dDZ3IyN3JWL3hlS3k5UjhPUEV4?=
 =?utf-8?B?eTdiSVpIeXpzazVwWUZwcjlXdlhodlY2dklhYlhwaGlHcThwSjNmTWw5VE5E?=
 =?utf-8?B?c1RjZStYKzNvV3k4UlZkb2wxZ0hVOG81YSs5Uk5BUHJ3VmUyNVNvVk9PV2Jn?=
 =?utf-8?B?UGNyTFowN1ZZUEt2Q1NmdVZveFpiSERlOWhqcUNEcGJVMVgvdDRCMlRVVm1F?=
 =?utf-8?B?WE9DTkZMRGVSMFVuS3dscnhFQy9HQTFpeGtsaldNQTZJWXFscnZwMTlRc1pC?=
 =?utf-8?B?cDJnWUxXRVRQdXo1V1dhQ213LzluNk4ySldTNE83VGZXTDlhYUt3NkhvbkQr?=
 =?utf-8?B?dWdBYlFBOWNzOWtnai9seTh1WlZtZG96UkxSSWI0dU9QR1pQOTJPNGJTRHVE?=
 =?utf-8?B?c1BjT0JJdUZLalBzOFNYNkdJNkVWWnZxeUNHN1NIMHVBZ040Q2tnc29LZGd5?=
 =?utf-8?B?TmUxbktmQWJQdVh6cTNnYUVHU2c2MC8xOGhrcGF0TThpa3loRG9qOGcyZTNv?=
 =?utf-8?B?SDJ4WDYrVFh3NTJXWms5djNQR1dqZFlUbzdtK1ptZXhZT3hmNFlGdW5iWXdE?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F7469035F3C184C9961D20B278BF1E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6877fd-1767-4a37-458a-08db7267676e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 14:54:24.5344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FEr8+bEsv57mZ8W8oBRL34+UT6TejvsHrS6Ev/Iz7wzmAnR9csB0yZr3zjbInbYcuQkKPTwDhlbkWuF2nFCLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTIwIGF0IDE2OjAxIC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOg0KPiBNZXRlb3IgTGFrZSBwcm9jZXNzb3Igc3VwcG9ydHMgZmlybXdhcmUgaGludHMgZm9y
IHByZWRpY3Rpbmcgd29ya2xvYWQNCj4gdHlwZS4gU28sIHJlbW92ZSBzdXBwb3J0IGZvciBwYXNz
aW5nIHdvcmtsb2FkIGhpbnRzIHRvIHRoZSBmaXJtd2FyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFNyaW5pdmFzIFBhbmRydXZhZGENCj4gPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwu
Y29tPg0KDQpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQp0
aGFua3MsDQpydWkNCg0KPiAtLS0NCj4gwqAuLi4vaW50ZWwvaW50MzQweF90aGVybWFsL3Byb2Nl
c3Nvcl90aGVybWFsX2RldmljZV9wY2kuY8KgwqDCoMKgwqDCoCB8IDMNCj4gKy0tDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdA0KPiBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29y
X3RoZXJtYWxfZGV2aWNlX3BjaS4NCj4gYw0KPiBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQz
NDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfZGV2aWNlX3BjaS4NCj4gYw0KPiBpbmRleCAw
NTc3NzhmN2JlY2UuLjNkYWIzZGJkYmJjNiAxMDA2NDQNCj4gLS0tDQo+IGEvZHJpdmVycy90aGVy
bWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9wcm9jZXNzb3JfdGhlcm1hbF9kZXZpY2VfcGNpLg0K
PiBjDQo+ICsrKw0KPiBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcHJv
Y2Vzc29yX3RoZXJtYWxfZGV2aWNlX3BjaS4NCj4gYw0KPiBAQCAtMzY0LDggKzM2NCw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZA0KPiBwcm9jX3RoZXJtYWxfcGNpX2lkc1td
ID0gew0KPiDCoMKgwqDCoMKgwqDCoMKgeyBQQ0lfREVWSUNFX0RBVEEoSU5URUwsIEFETF9USEVS
TUFMLA0KPiBQUk9DX1RIRVJNQUxfRkVBVFVSRV9SQVBMIHwNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
IFBST0NfVEhFUk1BTF9GRUFUVVJFX0ZJVlIgfCBQUk9DX1RIRVJNQUxfRkVBVFVSRV9EVkZTIHwN
Cj4gUFJPQ19USEVSTUFMX0ZFQVRVUkVfV0xUX1JFUSkgfSwNCj4gwqDCoMKgwqDCoMKgwqDCoHsg
UENJX0RFVklDRV9EQVRBKElOVEVMLCBNVExQX1RIRVJNQUwsDQo+IFBST0NfVEhFUk1BTF9GRUFU
VVJFX1JBUEwgfA0KPiAtwqDCoMKgwqDCoMKgwqDCoCBQUk9DX1RIRVJNQUxfRkVBVFVSRV9GSVZS
IHwgUFJPQ19USEVSTUFMX0ZFQVRVUkVfRFZGUyB8DQo+IFBST0NfVEhFUk1BTF9GRUFUVVJFX1dM
VF9SRVEgfA0KPiAtwqDCoMKgwqDCoMKgwqDCoCBQUk9DX1RIRVJNQUxfRkVBVFVSRV9ETFZSKSB9
LA0KPiArwqDCoMKgwqDCoMKgwqDCoCBQUk9DX1RIRVJNQUxfRkVBVFVSRV9GSVZSIHwgUFJPQ19U
SEVSTUFMX0ZFQVRVUkVfRFZGUyB8DQo+IFBST0NfVEhFUk1BTF9GRUFUVVJFX0RMVlIpIH0sDQo+
IMKgwqDCoMKgwqDCoMKgwqB7IFBDSV9ERVZJQ0VfREFUQShJTlRFTCwgUlBMX1RIRVJNQUwsDQo+
IFBST0NfVEhFUk1BTF9GRUFUVVJFX1JBUEwgfA0KPiDCoMKgwqDCoMKgwqDCoMKgwqAgUFJPQ19U
SEVSTUFMX0ZFQVRVUkVfRklWUiB8IFBST0NfVEhFUk1BTF9GRUFUVVJFX0RWRlMgfA0KPiBQUk9D
X1RIRVJNQUxfRkVBVFVSRV9XTFRfUkVRKSB9LA0KPiDCoMKgwqDCoMKgwqDCoMKgeyB9LA0KDQo=
