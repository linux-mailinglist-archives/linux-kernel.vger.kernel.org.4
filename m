Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137995FF78A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 02:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJOAN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 20:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJOAN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 20:13:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C7F61106
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 17:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665792836; x=1697328836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FVS0ED0QBgjnjnj76HhPpWEi4IJ+6pf5/4TddxOKQvo=;
  b=XL3uWGQFeD3qYEJjBcLEyBcXM3VZPuiKuD4qRmWabQxSw15WhCqFrcQ3
   v05oPRqEI7MpVJmLpQ/TU5AePIkyl96Avgnufn+rj9Rm2+vzrOgyxw+PY
   fD4urtITk8XaNkVX4foJ5l+Y1kP+vYx/AMwQCyIdrTI2O0OGntRvRDbdE
   twrOO6YoopCQKYdvTKdUcrhZM1dgMVfCG4VZZ+MCKItP5K1NCfKQEWuNr
   bpVsZhv8tieOGJuZBnMfHfKNt1ek15sr6Fyqs4hFzNdJA+nQbh2MB605K
   28dDp4RhgsostiU5H0UovdBKJ7SgcYqu3tswi1nk6DOnHveNOsjW9ZMaV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="307156722"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="307156722"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 17:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="622698485"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="622698485"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 14 Oct 2022 17:13:55 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 17:13:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 17:13:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 17:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZr/K2SLz7kEArFOLcPqencAcvwfLVHhv5psvQJaeCQGXvxxL/31XcfxqhremL9ZuQa5GTmEL2Op+yigofmW94uCZd1EBe42SI+7aGN3OldHuObMvd1NMBy10xXdwO9kHb7GTMMvQd0yNyshwN+1z0Xft6n8GWOFYILTtomNqECjgvdOX+FnKIdsvG7ZTdht9v6qnb+HCW5jYYnCLV06uub0uKNYafd4uARW3V0tMolSwixty42K6nIsqWQbOLcEwadKc/ZQ3BiplMF0MWoZNVMkpPI5zey3u+JTIALEUANhgyrMBZszXnflxx1xW8ZyRWEdb293LHq2tuXf2o66GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVS0ED0QBgjnjnj76HhPpWEi4IJ+6pf5/4TddxOKQvo=;
 b=ZUJj9ETqYNmeqT/l2uy9hFdq+6Ai9/tQ/0IFhSuaVhmYuDgum7OMf9GtT0ZRNZyuDg7fBtuaYLceGi6y25/6u/3u2qNBVuD3vKp073fC5KwzDq1IOAB/UeV2r/BRlszM/yLmKNvgtdh16BIPX5CfG4en85XqptVCZR506IY3hUhmVvwzvEQCj2sWqD3k06HpWm9KE766wea8wSbuvsqhRLczRhbH3nHizZMmgIFKSXAoJsdVO6XReVWCwhPXjfi1VipPBUUvyzZthQvWtL8BHJecekbMGjRaec7yuaqQDumHinVrDxIGyINIsuwgfBg3IhvrWZUEHtQE8hKmU/ha3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by DM4PR11MB5311.namprd11.prod.outlook.com
 (2603:10b6:5:392::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 00:13:48 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5723.029; Sat, 15 Oct
 2022 00:13:47 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Subject: RE: [PATCH v3 3/6] x86/gsseg: make asm_load_gs_index() take an u16
Thread-Topic: [PATCH v3 3/6] x86/gsseg: make asm_load_gs_index() take an u16
Thread-Index: AQHY30G6L1hdm6yeRUaH7rv8z0Rz0q4N0mWAgADBeeA=
Date:   Sat, 15 Oct 2022 00:13:47 +0000
Message-ID: <BN6PR1101MB216120D24ECD8A5C7DB9C64BA8279@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221013200134.1487-1-xin3.li@intel.com>
 <20221013200134.1487-4-xin3.li@intel.com>
 <86f60a8edf0e458c86cd84970364cfa2@AcuMS.aculab.com>
In-Reply-To: <86f60a8edf0e458c86cd84970364cfa2@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|DM4PR11MB5311:EE_
x-ms-office365-filtering-correlation-id: 1b1874da-1fd3-4a72-a44b-08daae422133
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cP+0bqqJl0LXVSvQ2JnVSLroM8bfOO5kMi82VwP/B/WejrTUR5bTWCtCY7htQ3FMuJJwqndigMmjCURruS0B9SpsjPTAh/h0iAUiEHip3HZjpcNTPzpZ/XiazjOmDmd1JDKTl+uKzQ19HCkCuoksp2Nex2GJMudunDgQBFCfql3DcwzjU/umNNzeenpTTyBMlLs2CIBs/ugFPCp0bS2xCz238xEO0lO0quZz1dxo/5x4HXdmb1yBr+oawJX4mVnq0T3i4rg4f08nXcHUbnFHRKL7jSv7XGY3k+OefvRx/t8zj6NHOWSwLveruUZz82LzVxiIYT0VsNPebVdvt7TwbvE3+/ONq/vda3u5Ru56YPDuy9KeeNkHOsQA7/siuwxxDmLAIHoabJNAZO23jQ27pMMe7+naSE2H+iemgMJp4ABiG2qkisCP0Hu1E4SBQXbhlcE7dUyDVrv93Mkv3j+XxQP5EqUSKhH9oEtCwNGtQQkZhKOJhqa9CBcpAL0DbBgEF7JqBka8Wo8gmFLXa9HiRCKRaOendnkIJ0KQb4TOe5viV00tH2/yGnkwMCdvY1fQs/ZuAnpHx7sVmQ7f0JYwGWvzI3M6d3q+U5MRS5oMq3ob5vv4QZw1U/t7vuajdRCMWpAczOQLU9cXJvJz2Mo9qt+Pins9RpFC82+scyqJyrETGj1MN14UBgkAuDOmXSYXgJomT44yVhgOhhRoTxft6Catif/TDDUNDy+ybahUCNc12cziHHY5zRKCAJHYkgX1YUl0Aw24njUizhSIEgtgEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199015)(86362001)(33656002)(38070700005)(38100700002)(122000001)(82960400001)(2906002)(7416002)(55016003)(5660300002)(4744005)(9686003)(26005)(7696005)(186003)(6506007)(316002)(41300700001)(478600001)(54906003)(110136005)(64756008)(76116006)(66556008)(66476007)(66446008)(8676002)(4326008)(66946007)(52536014)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emhlZGVQazJvcnVwWDI5YVY2SUl1eHovajRlQTQvUkYyVGNLQkZHMGlhT25v?=
 =?utf-8?B?UU56czNpbkpCNDlrZW0waGphSUJ6NW9SOERCZlVSd1JEdnZia0l6bFEvQzJp?=
 =?utf-8?B?dnQrQXBPTVF4SmFkbk1kNVE2OGJBOUJhUlpMWExyUlZZVzFpZ2JHTVU4M3Nk?=
 =?utf-8?B?RzhsbERsQTg5Mm1sZyt3SWpvajRkRmZ5RUI5cHluc0FoMEs4cHNxV0tXWTFv?=
 =?utf-8?B?d3lrM3ZnRWRhRGxDUkw1YnlsR1VSU2ZPZTdIQzZBMHV6dGhZTmhtUWZ4bUY4?=
 =?utf-8?B?WEZlbGIvUkZNNVZDZGxaV1A4dnZmVU45azhBK3dwUy9WemtSYTgvakNEL2ov?=
 =?utf-8?B?MTlMNWtVMGJ1dk43WXRnVnZ1UHlWNmtlY3BoWnR4bWJ0VXAyUlVyMWRxK0JU?=
 =?utf-8?B?U2tGTzc1V2dzUlRHRHNWOGszMzlTOVVETS9EaHZ5K2w5V2JqUnkzT0hYcEtZ?=
 =?utf-8?B?ckE3Um9sRFdVaVNEOG1MaWdKZTZYelUvSEJQWFNFYzI1S0hLWlZ2TGxiQlFE?=
 =?utf-8?B?N3drYkhmdGc2U1duc0dlM0xidlNlbEswMFJGQ1RYV1RPL1d0YktORS96b1la?=
 =?utf-8?B?dUFPaGtwdDVFUElJRTE1YnZTTk1rSlQvZUo3UTdqa3IzZmg1aGdabUM2bkpi?=
 =?utf-8?B?eGFOZEVPbzJsdmR5UnM3TEVpQUJhUlV4bVk5bXlKTWg5RXlZclc1R1A0dUNE?=
 =?utf-8?B?QWNtMGtmRDA1dHljYkZZblMvQkNlMUU2aUhWM3lNYm8wd0Nsc0RsVUR2YndF?=
 =?utf-8?B?ejBhQ2xPWVZKaytKRDl4TGRyY3BLYU5HcnBXMUxwY2xSZmNuVGVWTGwwRFEr?=
 =?utf-8?B?amZzRDNZRGQwUlhEbG8waFc4RnE5aW1QRi9NOGdOSHRuOVJvU0YwMGo0VkZZ?=
 =?utf-8?B?TFhkMCt2eE42VnlxM0hidkoxVXFjM1dNMnUydDN1STRRa3Z0ZEJoRHc4VnY3?=
 =?utf-8?B?czFsVGhLVUkwS3JnNjJ3RncxUFU5Z0VXbWxVdmhraTljekROOE1rMGNJc1Mw?=
 =?utf-8?B?dXJ3cWl0YUs1cTV0b1JDT3pNdit0TmUwN0h3eVhWYlVZR3pKQlFnbkdJUlpv?=
 =?utf-8?B?b1Z0QTR5d3JHbU0yVllnejFCZnFqWVAxK3grR3NLOVh3cG1jMFkySkV0U3o0?=
 =?utf-8?B?NGFQV21QTjFpUjM1S3pHaDBSWEVjUTRvQmhXY3RHSzNEbFA5cnZWaG1xRDkr?=
 =?utf-8?B?T01pUEx0SGI5T0dtd1M5ZlMxa2MyQmorc042NWpVbDhhdHFYdHMxeEEwZ00x?=
 =?utf-8?B?WkQ2TlFLY3oza0M1MnV5UEJYeFJZcHJQV2RxcldwUlRkaWZaSXB4RHg2TERU?=
 =?utf-8?B?L2pFczREcXlXWHZzNzhXaHIzZEZvVzRocmhrVVRJVXVab0JTUXg1Y3JBaUNH?=
 =?utf-8?B?WTd5alZHZE9OdEpXdmxXeVozSFlEeng1dVpRSHJZbEZ0T3pIdFArbUFQUmxP?=
 =?utf-8?B?MFk4SjUxMXpYTEZKMmttMVRySGlyQlZ2RFBJQnhNdExWbGZCc2cvSlRDU3pU?=
 =?utf-8?B?STZ2M3pkMUdVT2UxSUQrREgvSFNkMkNjaEFoSGRsbDVxY0NTTGdvYUpGY1JG?=
 =?utf-8?B?c01ObVRSMjlBQkZiSGRpUG5zazkxYmNDTkdCR2pETnJnSjdoZ2VySy9BaTFj?=
 =?utf-8?B?Q2kzQWhiamxUT0J0QXFieURYb3RERWQ5Ymx4eHpIREhiUERLM3lBUm1acGhV?=
 =?utf-8?B?SDZ2dXBacXpyTUlZNXdrcm96Qmp1UHRBUW9pOWN2ZkxFdEoxMEtQa0tiS0JT?=
 =?utf-8?B?ZzN2cXBNVkNjUW82dXBpem5objRnWlVJd2RiLzNud0cyRHlBa1A5NlUvS3JV?=
 =?utf-8?B?VzN2R3A1TmttR2NUWFpMSElkZWltVHFsQXMxR1ozTk5sTDdGZGhuVEgxL1hK?=
 =?utf-8?B?emVwdm1YcFo3RjJLdHNTeUpwQjJhYTMyTkgxNWs3amhScW1QZzdlcUNCMDN4?=
 =?utf-8?B?T1JIY0MxVmFKR0doZzRXNDNRenBsL3prMFRoc1gzU25hQTBJZklIZ2x6Qmpp?=
 =?utf-8?B?WXJBWndMNnZZRUFrM3dIRzd2eE82QnFmcVFwazB6dGJHNDBNNFlnYXJGZlds?=
 =?utf-8?B?dkQwbmRSNnZ0SmdObDBadmtKYnordWJhNzJNdStFTDJDRGNSdjY3NXRROEY5?=
 =?utf-8?Q?HP/I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1874da-1fd3-4a72-a44b-08daae422133
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 00:13:47.3984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcKt6BT8RmPIVvkL1hvn42k6dOjqheLRAvPuoMGEpVFu756DNnNyaa7IsaAoQjcwPdPAxRDIuhFN98Tlt8uS0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5311
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gRnJvbTogIkguIFBldGVyIEFudmluIChJbnRlbCkiIDxocGFAenl0b3IuY29tPg0K
PiA+DQo+ID4gTGV0IGdjYyBrbm93IHRoYXQgb25seSB0aGUgbG93IDE2IGJpdHMgb2YgbG9hZF9n
c19pbmRleCgpIGFyZ3VtZW50DQo+ID4gYWN0dWFsbHkgbWF0dGVyLiBJdCBtaWdodCBhbGxvdyBp
dCB0byBjcmVhdGUgc2xpZ2h0bHkgYmV0dGVyIGNvZGUuDQo+ID4gSG93ZXZlciwgZG8gbm90IHBy
b3BhZ2F0ZSB0aGlzIGludG8gdGhlIHByb3RvdHlwZXMgb2YgZnVuY3Rpb25zIHRoYXQNCj4gPiBl
bmQgdXAgYmVpbmcgcGFyYXZpcnR1YWxpemVkLCB0byBhdm9pZCB1bm5lY2Vzc2FyeSBjaGFuZ2Vz
Lg0KPiANCj4gVXNpbmcgdTE2IHdpbGwgYWxtb3N0IGFsd2F5cyBtYWtlIHRoZSBjb2RlIHdvcnNl
Lg0KPiBBdCBzb21lIHBvaW50IHRoZSB2YWx1ZSBoYXMgdG8gYmUgbWFza2VkIGFuZC9vciBleHRl
bmRlZCB0byBlbnN1cmUgYW4gb3V0IG9mDQo+IHJhbmdlIHZhbHVlIGRvZXNuJ3QgYXBwZWFyIGlu
IGEgcmVnaXN0ZXIuDQoNCkFueSBwb3RlbnRpYWwgaXNzdWUgd2l0aCB0aGlzIHBhdGNoIHNldD8N
Cg0KPiANCj4gCURhdmlkDQo+IA0KPiAtDQo+IFJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzENCj4gMVBULCBVSyBS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0KDQo=
