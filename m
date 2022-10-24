Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3751860BFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiJYAfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJYAfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:35:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28322F379C;
        Mon, 24 Oct 2022 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666652484; x=1698188484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RoufeO9wEAxd9O3tDmYlLEfHOyDcD//1OLGEXMd5a2Q=;
  b=FspmMtSVRKu40ZTcprIdDu/f6c6LxJkxkLVTWYiONIxhOJ0XX/yh5oBf
   Nm+SNDncFTwKMZv2oVjuYKzocKQ36TX5SaXiD/Yy8HylMVTqOdINoTlP2
   j4iQ6vlhwF43cexzKHzP/y0Y6gEFQOT6b5vbxyZd4jG1FB/c720YcwXRY
   eltWTKE7rBZY6E8REQhZHF/4vPkQQiDBVe+9eBLw0FIZxGqVHP+qQoNG1
   MDm7mGLUAFp//em+BbK7r+5TLbev9OGWwujAU0ix2dPrMIVytdHrQoxJS
   /DJmt2/dilF8cYrPgsdUwEyXO72/j1o2qYmLOMcvUDRSIqOozrduBz1Gt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="307533038"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="307533038"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 16:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="694726919"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="694726919"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 24 Oct 2022 16:01:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:01:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 16:01:23 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 16:01:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAUB0bKdSgT7vGxu4l1Vu7rdbH1hnN38nby4I4U7J/X93G271dEShXKxHPmj9lWQpyYn3Uf9Wgkzc0Xf+ENIQti4V5BqVV/5pLQhmMe1M/jy0/l8oAEhwue9y16W9S6SB3U3Vined1XfKYwtLyiqk8/OlXRQp6AAb1k46RrPrHbQS7dqiG2Wr9ORvrgNFXLSDEFac/7m79dBfxcwGjdcuUi3YoheMAa+3Mm7LQQCWsSjjkAwTbpAH4V4sE+w/1OiZ6CDmecGDz/ggPyb9yHg3cykVw+rDM7GspTNuK2nmbMcshaGmBiaDI0tb8Ms2GINcKZCvseeSyNECjLwkvToFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoufeO9wEAxd9O3tDmYlLEfHOyDcD//1OLGEXMd5a2Q=;
 b=BrU5J4ZXb274kmbm2h0RlNuTdWV+VGARyjo1wJDOA+MfH8uKIPakxvo51V5z32Ld8fewXlOarnB/rg0MEMcwckWm8coNzhajMNn1GZohHih9r9//+K6h8VjO1ayvDJh/LzKBUsqYIwro4jQfqQCYLkt0+1gDr/0IR4opvnQnWTfhyQLq7Cb/bAOkAQivxeoZKRahJ/If6E+J6m2OPrX55NunjI8tgMYonInJU7rpP4YOwvNuOxn01KjxFTZ/Mi2rih9vBq2xRZf7ep07SgoBVz7WmCTr3fqtX+cjttRuOoU8SK1ms6wAKeWdvPxr09s5wa7xSEh6w0lX5MKBIznV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5615.namprd11.prod.outlook.com (2603:10b6:a03:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 23:01:21 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%6]) with mapi id 15.20.5723.033; Mon, 24 Oct 2022
 23:01:21 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
Subject: RE: [PATCH 03/14] platform/x86/intel/ifs: return a more appropriate
 Error code
Thread-Topic: [PATCH 03/14] platform/x86/intel/ifs: return a more appropriate
 Error code
Thread-Index: AQHY5YytAwM/DYnC50+zpM1ZuCkJ7a4eLNiAgAAAxtA=
Date:   Mon, 24 Oct 2022 23:01:21 +0000
Message-ID: <SJ1PR11MB60837A038C5D87ECF3768735FC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-4-jithu.joseph@intel.com>
 <238b55b0-7fe6-4923-ef8c-fb1cc1cd1c66@intel.com>
In-Reply-To: <238b55b0-7fe6-4923-ef8c-fb1cc1cd1c66@intel.com>
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
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5615:EE_
x-ms-office365-filtering-correlation-id: 8111c2b3-9d01-4fc8-4eb5-08dab613aad7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StM3MA1+5MULltzswPRf7lQ5S3iyLCB2/lQKdyYcyEkNoAcW/i1dgkqAmGzkYMUclekf/LMk2YZvxvMwMhNmmP5GqDKyjAqGLTCF7JNV4kuZfzrV2kmQ0qhFBs+5r4qHVblSRjQSq3JOQPjebK8gw3NMD5Lo+VzpiefmJDLCnTQ5c9PqsCrgrNkz19TmFJoQBQyzaHvPtb94katZnKsTC4M1XjOCgkbpTuFnOGWOL+W61wA35AFMuD7HAyq6OBkhtZrLEJtAG+kp9RbOizJ0kdtELsr6TnrUZpSvL8qa+o0yymzsLS4uZrDmoAtVYlWhgUFWnNNtlm6kEuxNM+EfKWFm8rlITJvh8axdOPl1jKNcQc/WVzIlbsw2kfzG4iA0MrwGBaYK+HpjdBumVnFuSA0F3TKGgGsP66a0fE1kZtL66PH69y5UZjAFL+YdaVcCXxvo3MNf8WtlexAnodW1tU5fiz+ZyDvcwbCGf/1cdmyfTlRJLMR6RdjJ8XpKObu/5CPsMVkLLCXJ5jz13JSZ/9kc59OIMi79F9bmqwtvrc4Of+avnTJWOEqshZ2nNSZcuZthRjYkPIfbBGYXtq+pylkE75gUCVo7qek5zwkDkMheXTmLe+7QLU2K6951JSR4fwTJNZ+mNSVTaJ6LzYtgeVxX1cTZ+I665O+T4ITB6c4XbJsq1VZrcrWaDl7sUmyI3hSKR1oxz5V1ENiP8JvhxQid+buS5Qi6ir54AqxE/76MgevJE4ZAvmbpu4ro6KWU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199015)(8936002)(5660300002)(41300700001)(7416002)(52536014)(26005)(9686003)(6636002)(66946007)(54906003)(110136005)(76116006)(66556008)(64756008)(66446008)(66476007)(8676002)(4326008)(6506007)(7696005)(316002)(82960400001)(38070700005)(122000001)(38100700002)(55016003)(186003)(2906002)(558084003)(33656002)(86362001)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGU1WHF2TDRxWTQ3a3ViaVprcGw2QjlrZFAzK24yVEl0Q2VKbS9ITUI5dENL?=
 =?utf-8?B?MnplTEFIcWJEOFZkdVpBTjc5ellybXljQlNub2ZiWUZXbGJpbVp0a21PL1NW?=
 =?utf-8?B?NFBld2djR3FRbmhhWFZ2S0x6ZWdMcDYxUmRhQTk2dkVINWZaQk8wdWFXSUNl?=
 =?utf-8?B?VHNiV1pqUjVMTmt5KzhCNlEwK1ltb1FJb0NZS015K3lDQzNQeTNJVmdRODhR?=
 =?utf-8?B?dWplcDFxNWFRMDYyMjU2bWoybFhrUXZDZ3FpU1ZOY2lVZEs5dHl4eXNuS0dI?=
 =?utf-8?B?V29GN1d3b3dEVXkxRjRXSlBnTUxZMm5hSWRidEc0cFhpVG1sS1VDa1FkKy96?=
 =?utf-8?B?MlRrVDFES0UvUHhJdGUrUzFVc3ZVQ3NqSVpvQlN4cjJwUjRYci82d0E3MkEy?=
 =?utf-8?B?K3E3d2R5MnIxUlJBdGVLUUxYTE5ReERyMUc5TW9aOTZhVm9yYjcxTzVVNDBM?=
 =?utf-8?B?MmloQjRLUnZDdXVkMThYTlptOWVnaStodUtSNDRqV204dG5LV3pTQlRsSTk3?=
 =?utf-8?B?dW9kbmJmL3Q5Y0pQWHJ6VDFwaU5wN3pRSDlTL3cvQnZKUUpKK2xBWkt2Z3Qv?=
 =?utf-8?B?SFdIbVZ4UUFRcjM2VkYzbWxWVmdmS3UrK0d5Si95WWh1MUkrOFJCNWlaSzJN?=
 =?utf-8?B?TzdTQ3FwVGlHMWZETk9LTnBheDBZRzRLYVdlcEJaOStjQ0RhSDFPbmhoOGVo?=
 =?utf-8?B?NHJpWjJNN2xBUFVYWFk5TnRqVEoxdFVvT0hQQkc1NWNyTVRORUpLaUJIeHNz?=
 =?utf-8?B?cU9VOXVROEhvMTJwVlBseElLaEhKUERHaVRDOGtHdHpqTVZqZVZEK2p3RXRC?=
 =?utf-8?B?TFd1MEJMSXlmanQyV0FJRHBjWWVmZEkrZitsQy9HOXp0VVp4TnE2dXp5STFC?=
 =?utf-8?B?Z2NIblMrM3hyMldLQ3NYZjdoa1RPVTByb0ltWnJFSjgxTEwwTEtzcFMyZFo2?=
 =?utf-8?B?WEVJTkExY1BKQUJ5a1poeTRLd1NEQ2lsWUREc1hMc2RhR1lJb2hqL1BKRjBo?=
 =?utf-8?B?U0VLanhVRmtndUR5YW1KTkRRczlxQUhobUNXTisxYWZwU1JrR29WdmlNZ0ZP?=
 =?utf-8?B?bjBPVnFNVTlOeG4xUzlNZk5kR3J4dS8zR1QxRHVIVHlYU2pLWEhKWXVOQ2py?=
 =?utf-8?B?VUgwcjJVRWFQdUhYaUM1U09FYVg2WFU4V2Y0OHM0ZjFzanNiRDdWb2tvMVB5?=
 =?utf-8?B?eCt2bVZ6aWpmejNVRTRxSVUrcnN4aExvdktMVmd3YVpyVDFEVVV2WVpEdzB4?=
 =?utf-8?B?K0kxdWhFd0wya2o5WEZ0SnR4aWRuVEcySmdvYW8vck9NMnVSMW5VdCtackRs?=
 =?utf-8?B?cVNWN21rcVlhcXhCRDBGUmN2c05yTHd4eVNJTUk4S0RwUkNjZWVPdFVkd1p1?=
 =?utf-8?B?Y241aWI1ZENsc2ZSNkV3ZjNXZ0kxWThoVVAzZGZCbXl2Zk9UUkRhVW4xbVo2?=
 =?utf-8?B?cnJWdFBuYXdxTi9tcVNwV0VkaW5OcG9DNnExQmtJUFM4cnlkQlFnOFFyYWFL?=
 =?utf-8?B?QjJiY2dyTXNGTGRSS2lFd0hMSE5lNmR4andrNEF1Ujk2bXdOV1BIMzd1Y1pa?=
 =?utf-8?B?ZHVkOW1QSGxqUEZZQzA4cUNzMmFoN3BPNlg3NmVVb2RMWGVDV1FIekVWeTF6?=
 =?utf-8?B?NE81NGZPRXFYNWhCN25iUjh4RDlFTWhWQ3JzQjloMDFBTVVJRC94NmdtYllH?=
 =?utf-8?B?T21ITnp3bW1lRHFLY2hFQkNSRlZsNGUxUkRaTE1TSHdHNU5qUlFsUFZva1NU?=
 =?utf-8?B?MjB0TXBkQTZ3YnlsM3U1cWpHdzNLRnZUako0OXlCRzFvcnZzT25PTDBPNjVS?=
 =?utf-8?B?aVd5TEtEaVdrZDI4bzdCNDczbGp6aWU5ZTVXSTdYOW9GSVdSOTNjRGRIbEpo?=
 =?utf-8?B?NmYzMm8yK21WZlFnWjRIVjcvVXQvbmc3SnZrNWE0ZlU5dDVIOWphM25jTXpH?=
 =?utf-8?B?YnVsZG8rWDdEYnVLbUlQVEJXL2ExWnlwR0h2d281YzlZMkJoc3Bub1pLcWQ3?=
 =?utf-8?B?OFlZZnorc3hDOW1XQUs5emNybnBBSXpTbll0QjhFNUlyV3d5OWFGNC9CdlFK?=
 =?utf-8?B?SW15S2FMa0NrQ1F6ajVZb2NXMmtjUmN1ek9IU0xUWmExRlJDbXZ0ZGNQRm9t?=
 =?utf-8?Q?f87CQX6xULJmPxyccfTrdOqoo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8111c2b3-9d01-4fc8-4eb5-08dab613aad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 23:01:21.2592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+x2oCVjIzAe80jzwpMR6C4oM5Oh0YuEXcTZv9TSqMc3OX3C0cw+fx/3CbFkqikIFcNUM+GjCMIKpfrcPx3wqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5615
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBEbyB0aGUgZmlyc3QgMyBwYXRjaGVzIG5lZWQgYSAnRml4ZXMnIHRhZz8gT3IgaXMgdGhlIGlk
ZWEgaGVyZSB0aGF0IHRoZSANCj4gZmVhdHVyZSBpc24ndCB0cnVseSBlbmFibGVkIHNvIGV2ZXJ5
dGhpbmcgYmVmb3JlIHJlbW92aW5nIHRoZSBCUk9LRU4gdGFnIA0KPiB3aWxsIGJlIGNvbnNpZGVy
ZWQgdG9nZXRoZXI/DQoNCk5vIHBvaW50IGluIGJhY2sgcG9ydGluZyBhICJGaXgiIHRvIGEgc3Rh
YmxlIHJlbGVhc2UgdGhhdCBzdGlsbCBtYXJrcyB0aGUNCmRyaXZlciBhcyBCUk9LRU4NCg0KLVRv
bnkNCg0KDQo=
