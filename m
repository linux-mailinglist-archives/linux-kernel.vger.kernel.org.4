Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135795FE7DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 06:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJNEDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 00:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJNEDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 00:03:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71F110A7DA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 21:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665720226; x=1697256226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JX11foTL7eoQaZXvCKi/Kx6g6aaFOYxxCjZDVMACFbA=;
  b=QJfG2EIfOwdKXKzOcYQx9WCX9NKI97wCMR5s6W44n9r+UbCJFGWIwYje
   Nx+6krcUbxi2whGsEK88+Mzb+V57R0DmOaDr9+59KGfBRQn+kunPA9AOQ
   FMo46PDZ42rJ6kDGxOWGeyz77XcZxGiFd44+e5C22s+j+WPnhyxFZ4pe9
   0yw09eoBfSfjLZL8ykbonRB3YCzL9LG+yrGr925Wm5we33bxz6CEoJkxQ
   7gifQfKJpNagBKsii39c/EXQWxLfzDUdVWJxSj3APVWtk+muw4bK99GMC
   Muzvu611U73CPRrdnkvdfdxEABgdqly1KNRuGvaD/+34ppB62rRcA16i2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="304014082"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="304014082"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 21:03:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="956431780"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="956431780"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 13 Oct 2022 21:03:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:03:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 21:03:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 21:03:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igFDddGyjpeaUg74EoU4uAR/o1agSFofZyBIC9RC5kNEwzhorhGznLdFNvrsYRCWGyx2PZmoaQAqEfoYGCZwlZpYoy4OnN3DDTTv3tuM+o8CaQIgboyVIoKy0PD4clhdcI2UMZ60H+iDZbdFgIpRv018wzHtPUYfxm3W5ZojgYsxTtB3xtaqbThKAzj0l60e5ILz7IMS0Qfu+MKEhZRmhr+LbDbYS9vjqZEpGSbOXq4sK6SNxclsnWL357N+IAKvUU59H7VUwU4xyjtMu5VKeQXotQM7Gi3PC3P6c2/oo4ATohfvQ/PIBPZet3ZaHWJwcJB+vSeDDlk5MuhjVgV4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX11foTL7eoQaZXvCKi/Kx6g6aaFOYxxCjZDVMACFbA=;
 b=XTugskE/nIqB1ytfD7VxN1nWVjiGO5vZMHJwdnAI5cINDAG4eO6WC4d3sWHpq4wPp0Em0j9qrc3fJuDM2MdLI1Xko5aL2+2qzXdAAgRjrYxlfmRAMrzDMHMCmIWFoeYjmeVpl/AWQFOHMI1r7miQy9Xyi24p4ORBQgbYNKQA1S+YgKPSwN63ARAXlveGK6JjhMfSDul/pqT+tjUmESsXotys9m2wjQ120dj3muKjEi7s0hTFp7aMRd7j4Y+edNKT9JGAy665rlcZNX+e1MfnGFSA3vuFvlM8aoD3O5qe5ou2wnlwI36UBpuzjsBvqr1lrdemFlbBfzkH9OAq5MHsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3717.namprd11.prod.outlook.com (2603:10b6:a03:b0::12)
 by MW3PR11MB4698.namprd11.prod.outlook.com (2603:10b6:303:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 04:03:38 +0000
Received: from BYAPR11MB3717.namprd11.prod.outlook.com
 ([fe80::e3a9:2e44:76bf:8c28]) by BYAPR11MB3717.namprd11.prod.outlook.com
 ([fe80::e3a9:2e44:76bf:8c28%7]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 04:03:38 +0000
From:   "Yao, Yuan" <yuan.yao@intel.com>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Thread-Topic: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Thread-Index: AQHY3cA8G+rUHXTHGkezKzq8f0LSDa4LpX7QgADfOACAALZkQA==
Date:   Fri, 14 Oct 2022 04:03:38 +0000
Message-ID: <BYAPR11MB37177983537261502DDF93D195249@BYAPR11MB3717.namprd11.prod.outlook.com>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
 <BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com>
 <9b198ed3-4b2d-c857-710b-3f7115bbcf74@intel.com>
In-Reply-To: <9b198ed3-4b2d-c857-710b-3f7115bbcf74@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3717:EE_|MW3PR11MB4698:EE_
x-ms-office365-filtering-correlation-id: 0672916d-4130-4bb8-19f5-08daad9912e2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3mwJqW0XwFWP2SCPqTXxXrFj+h1fa0XIFI/iBywW2VrDUxdTVckHBl9VNcQP2lPHQDnV73Gw+SUrSJWhZ15VeuGh/IJnCsu40HJETJ1uYQoaAMvpTPsZFBxvOISyFcrupSgY0H3U3lVV1TlURxMYIsAdq78LYXBUrEUCJ3bldTLPD6uJkklZyurc5FUGPH/foCOMc+cDFQOLI0hCyJ2bz7HxOs85Cbrc2SLHjCO9pFSAv1dZAMbjTWu62F3WZK/AMradcyp03jCT3UHCHa24aPy7eYuZdz1eglyKAHOtjUsK1hR7WWJu+g8LuEuZd4JT7vH9T7C7ZLQm7iiqf5k6uJOlvIfm6MXv15JqKJjoz23twl0vnBA1eEedHVg4BQ1ulTx7GvmWsCQUOUdS9rM9PMjLHwr3Zt5SCfdFEhSko+WmwRHcVCaejR/6SuxkqhPTeV57sa2MEFu+Mk9IXZJAFdtYz7E6rvaPabhwhkfa7bsjhAN+xbRejRBEh/Gi0wytnnJNxmveWiQDJO5GDaguVuF2kNrO75gBSD97VrlHazl4Msa9sUWD0BPmVLgjTLzWyEIDodiHScFYvzGlXO8umvT3UnoyqYM6sEAwIeauBvnotxQZJi8F6wOyIVNlLrIIYHUNjtaMECHGRuHXeMAtSw8jHPxO/DS0o47/cnbQEErfeZ2nbxgfaYgs9MtGORu/OS7sbVLLrp6rMhfN4pp0dYhF4LQRmsgRTW3q+5d2t3951v/+QNjbJokBw4CUijS5T5SlBxG1f2piSz0WalUKGTxMOuyxx/zZlw8u73kAq8U3DVphNtzdF+1qlDS4ScxhHObaQM7/tmZuYhgQWN8LA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3717.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(82960400001)(38100700002)(38070700005)(86362001)(9686003)(76116006)(7696005)(6506007)(26005)(41300700001)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(71200400001)(478600001)(316002)(54906003)(110136005)(186003)(2906002)(122000001)(5660300002)(52536014)(8936002)(83380400001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGpwa2kwWTRONEpuMWZ5RXhZUFluQ3hUNHFXZ1JacTRNaWZzODB2ckNwWDdG?=
 =?utf-8?B?Sm1wa0FCNzBlK0ZnZW9CZThpQ1BxRTJkSk9lckN5OVZxQ0k4ZGpyYnlyQ0M4?=
 =?utf-8?B?a3pyYkhldys3eG1kL0Fkc3ZpUDVBOG56MEZCUDVyRG0xTTBDRklvZ0Z2UHJS?=
 =?utf-8?B?c2tIc3k4S2lBUnBlRGdnMkVXT2dsOTM0S3ZIWFBoeFZxMmJlbWR4QytIbzZD?=
 =?utf-8?B?a3VsdVJFZ1dUQ0FZQXJ1WVRVUllsaWxsa0QxeTRpL3gwZHNQMW93UDJlQlpI?=
 =?utf-8?B?a2traXdmMmZNLzQ1QW45SzlCL2FmdmVLY25oR1VKbFJDZHpyeG1jRnR3dDlY?=
 =?utf-8?B?S09rZ21QRHVaRHdGMks5MmpUV205dHhDZkkzOUs2R2VlMlM3WXNUR2htQWh5?=
 =?utf-8?B?RzREbSsvNngva0VLOVc3MmZFVVJBYjdqbXRBY1BlRnhUZFowWVhGc2x1amFV?=
 =?utf-8?B?UHRvbVoxeUpGRnlLUmtkcEljb3JmMjdwT3RBbmNNOE9wVnNYU1dwa2VKUGQr?=
 =?utf-8?B?U2Z4cW40NnZqcG1rYmtZY3pXbTA1eG5CSUlmTjJCQUdndnlaNDlMYUFyNzZw?=
 =?utf-8?B?V1NtQ3VqKzVnOEp6SWRFSXM1bmhsTHFtU2d2Z25hSTlPUHVoVEFic1NpK0RM?=
 =?utf-8?B?L0dhaURPemtFTm1QdWxURmlyOU5iUi9oYzFUdlFhTXVXM05KTko5Uit2L2dR?=
 =?utf-8?B?SGY3V1BZdTdSb0UrZlRWZEtxVGhNWmxISG4rSG1vYm53Yy9xQlpUMElScUJz?=
 =?utf-8?B?dHNpcStnM0V4TDlqS1FzaUVQZWtzZ2FaVmF3YWI5d0ZiNzRGWUdsUUJCK3pp?=
 =?utf-8?B?a2tXdjV0Zi82RnlQUGMySENmQmhxOUFYNjJCdTNwanVBdVA5NG8xQWNIalNX?=
 =?utf-8?B?RDdmUXJSRUIzejlDMWMvUm1UUmFBenArSHdoN0wxcjhEZjVhYXNlSU5hWmRy?=
 =?utf-8?B?RlB3RlQ3cGFVeVY2VlJVVnRhSTFVZzdiWU8zMG14Q0FrMmNORjJoNzh1RTNk?=
 =?utf-8?B?dWtMZ3I2WnFUOXZvMWRCQStVcEczblNsdjNxM0xkRnM4clZYeXFrWjc1aUtn?=
 =?utf-8?B?czdva3FoY0J0V3cwcnZ1ajhXczEwR2tlQ2VNUzl1YUdoNUhKWHl6NHRabFVr?=
 =?utf-8?B?Y0xTY3NBK2o0VXZ1eVVCOWg1QWtwTndLZnVsMHVJbDZGd29MaXJwWEZRcHk4?=
 =?utf-8?B?dkd3MXZCWmI5Kzh4WldKQzJ2TEVCTkdVazRqNVVEczZJNU5sTTdya2tYTldR?=
 =?utf-8?B?c1ZCdDdobmc0TVB2YmhYeCtzbzhaUmhWME5CdjNwOENIZVJkRGIvRlRlM0p0?=
 =?utf-8?B?UW0yVytMS0pJL1VwbThRMkFScFo0R0lGSC9Ody9BR2RjUDFoMmtKWno0cjEz?=
 =?utf-8?B?WVN5QTAzM25YdjJXR0tROWdjZmNDM2xCZ1pNWjMzOFNOTU5MYlRkcE9pT1pE?=
 =?utf-8?B?ZVJhaFpGOGNPUVZIaThCa09DYVZyS0pBZTdmYytjRU1CVDNOZlc4aW5mSWxs?=
 =?utf-8?B?dnV1QlpHRk81dVd1Q3Q3YldERDRBaWFiUFRWS1A1QXo0MW9LUjJzNnZsTzUy?=
 =?utf-8?B?RnhQNUxYd0lRSmlqTXd0YytlMDE4WFBwcEtJandUbUtMSDlLM1V1bTk4V0ty?=
 =?utf-8?B?VkY5bGluMktmNTQzSlN3V0ZaU1NBLytyNG5nOUJ1ZmYyKzNiN2xmUmpZejM2?=
 =?utf-8?B?UHQrY2RvdmRieDhMN3FwMlBMaHdkOWUxVlUzc250d1UzTHloTG1QTEpyQmNK?=
 =?utf-8?B?c1lmME03OUY4ZVcyOEtvTTFTQnhoUDFCZmZRaEJ1S21FdEp5MUlDajljYWFV?=
 =?utf-8?B?UlF5ZENaeDVXLytTUVA1VXBtWmo5L0o4TGhWT1owcy9qNGNmZjlKSFFjandy?=
 =?utf-8?B?a0VoYmlIMTNZTGg1UWtvT0xNSVV5WVd0Zk9vZUdGQ0J0MVZFNjhZdC9rd05X?=
 =?utf-8?B?TThRNFFhdW9EeWZTOXZkcjU2WXBzY25VZy9iZVNvMXJReGJQWmt1aEpmL204?=
 =?utf-8?B?RU11a0N3bE5ueFpLYUFlTStZQzNLbHVNYm9JOWNxNFNnMmdaN3FjbEkxUDVQ?=
 =?utf-8?B?elBMb2xDK0FNSXgzcHdGak81LzhmTTU3ZHZvQkVNK1dwK0dMd29ES2F3azJV?=
 =?utf-8?Q?WNqj1pS3SbLgtX0NSeD0wkF6u?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3717.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0672916d-4130-4bb8-19f5-08daad9912e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 04:03:38.4443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mi1tY7rGTcQ0jn+TtT4XuafI0xtfs8ncx4Z8tR/yLkIQj+NdXoXnslJfE/6nkU5dp8+khh1ZIPbcB5gJamp29Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4698
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQmFlLCBDaGFuZyBTZW9rIDxjaGFu
Zy5zZW9rLmJhZUBpbnRlbC5jb20+DQo+U2VudDogRnJpZGF5LCBPY3RvYmVyIDE0LCAyMDIyIDAw
OjIzDQo+VG86IFlhbywgWXVhbiA8eXVhbi55YW9AaW50ZWwuY29tPjsgRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj5DYzogeDg2QGtlcm5lbC5vcmc7IEhhbnNlbiwgRGF2ZSA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29t
PjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSF0geDg2L2ZwdTogUmVtb3ZlIGR5bmFtaWMgZmVhdHVyZXMgZnJvbSB4Y29tcF9idiBmb3Ig
aW5pdF9mcHN0YXRlDQo+DQo+T24gMTAvMTIvMjAyMiA4OjM1IFBNLCBZYW8sIFl1YW4gd3JvdGU6
DQo+Pg0KPj4gVGhlIHJlYXNvbiBpcyBfX2NvcHlfeHN0YXRlX3RvX3VhYmlfYnVmKCkgY29waWVz
IGRhdGEgZnJvbSAmaW5pdF9mcHN0YXRlIHdoZW4gdGhlIGNvbXBvbmVudA0KPj4gaXMgbm90IGV4
aXN0ZWQgaW4gdGhlIHNvdXJjZSBrZXJuZWwgZnBzdGF0ZSAoaGVyZSBpcyB0aGUgQU1YIHRpbGUg
Y29tcG9uZW50KSwgYnV0IHRoZQ0KPj4gQU1YIFRJTEUgYml0IGlzIHJlbW92ZWQgZnJvbSBpbml0
X2Zwc3RhdGUgZHVlIHRvIHRoaXMgcGF0Y2gsIHNvIHRoZSBXQVJOIGlzIHRyaWdnZXJlZCBhbmQg
cmV0dXJuDQo+PiBOVUxMIHdoaWNoIGNhdXNlcyBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJl
bmNlIGxhdGVyLg0KPg0KPldlIGhhdmUgdGhpcyBpbiBfX2NvcHlfeHN0YXRlX3RvX3VhYmlfYnVm
KCkgWzFdOg0KPg0KPgltYXNrID0gZnBzdGF0ZS0+dXNlcl94ZmVhdHVyZXM7DQo+DQo+CWZvcl9l
YWNoX2V4dGVuZGVkX3hmZWF0dXJlKGksIG1hc2spIHsNCj4JLi4uDQo+CX0NCj4NCj5BbmQgdGhl
IEtWTSBjb2RlIHNlZW1zIHRvIHNldCBkeW5hbWljIGZlYXR1cmVzIHJlZ2FyZGxlc3Mgb2YgdGhl
IGJ1ZmZlcg0KPnJlYWxsb2NhdGlvbiBbMl06DQo+DQo+CXZjcHUtPmFyY2guZ3Vlc3RfZnB1LmZw
c3RhdGUtPnVzZXJfeGZlYXR1cmVzID0NCj4JCXZjcHUtPmFyY2guZ3Vlc3Rfc3VwcG9ydGVkX3hj
cjAgfCBYRkVBVFVSRV9NQVNLX0ZQU1NFOw0KPg0KPlRoZSBrZXJuZWwgY29kZSBzZWVtcyB0byBi
ZSBhd2FyZSBvZiB0aGlzIGFzIGZwc3RhdGVfcmVhbGxvYygpIGRvZXMgWzNdOg0KPg0KPglpZiAo
IWd1ZXN0X2ZwdSkNCj4JCW5ld2Zwcy0+dXNlcl94ZmVhdHVyZXMgPSBjdXJmcHMtPnVzZXJfeGZl
YXR1cmVzIHwgeGZlYXR1cmVzOw0KPg0KPkJ1dCBpdCB1cGRhdGVzIHRoZSAneGZlYXR1cmUnIGJp
dG1hc2sgZm9yIGFsbDoNCj4NCj4JbmV3ZnBzLT54ZmVhdHVyZXMgPSBjdXJmcHMtPnhmZWF0dXJl
cyB8IHhmZWF0dXJlczsNCj4NCj5TbywgSSB0aGluayB3ZSBjYW4gZG8gc29tZXRoaW5nIGxpa2Ug
dGhpcyBoZXJlOg0KPg0KPmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5j
IGIvYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYw0KPmluZGV4IGM4MzQwMTU2YmZkMi4uOGVh
N2QwZTk1ZjFhIDEwMDY0NA0KPi0tLSBhL2FyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRlLmMNCj4r
KysgYi9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jDQo+QEAgLTExMjcsOCArMTEyNywxMiBA
QCB2b2lkIF9fY29weV94c3RhdGVfdG9fdWFiaV9idWYoc3RydWN0IG1lbWJ1ZiB0bywNCj5zdHJ1
Y3QgZnBzdGF0ZSAqZnBzdGF0ZSwNCj4gICAgICAgICAgKiBub24tY29tcGFjdGVkIGZvcm1hdCBk
aXNhYmxlZCBmZWF0dXJlcyBzdGlsbCBvY2N1cHkgc3RhdGUgc3BhY2UsDQo+ICAgICAgICAgICog
YnV0IHRoZXJlIGlzIG5vIHN0YXRlIHRvIGNvcHkgZnJvbSBpbiB0aGUgY29tcGFjdGVkDQo+ICAg
ICAgICAgICogaW5pdF9mcHN0YXRlLiBUaGUgZ2FwIHRyYWNraW5nIHdpbGwgemVybyB0aGVzZSBz
dGF0ZXMuDQo+KyAgICAgICAgKg0KPisgICAgICAgICogSW4gdGhlIGNhc2Ugb2YgZ3Vlc3QgZnBz
dGF0ZSwgdGhpcyB1c2VyX3hmZWF0dXJlcyBkb2VzIG5vdA0KPisgICAgICAgICogZHluYW1pY2Fs
bHkgcmVmbGVjdCB0aGUgY2FwYWNpdHkgb2YgdGhlIFhTQVZFIGJ1ZmZlciBidXQNCj4rICAgICAg
ICAqIHhmZWF0dXJlcyBkb2VzLiBTbyBBTkQgdGhlbSB0b2dldGhlci4NCj4gICAgICAgICAgKi8N
Cj4tICAgICAgIG1hc2sgPSBmcHN0YXRlLT51c2VyX3hmZWF0dXJlczsNCj4rICAgICAgIG1hc2sg
PSBmcHN0YXRlLT51c2VyX3hmZWF0dXJlcyAmIGZwc3RhdGUtPnhmZWF0dXJlczsNCg0KVGhpcyBk
b2VzbuKAmXQgd29yay4gIEF0IHRoaXMgcG9pbnQgS1ZNIGFscmVhZHkgY2FsbGVkIGZwc3RhdGVf
cmVhbGxvYygpIGZvciBndWVzdA0KZnBzdGF0ZSBzbyB0aGUgZHluYW1pYyBiaXRzIGFscmVhZHkg
c2V0IGZvciB0aGUgZnBzdGF0ZS0+eGZlYXR1cmU6IGZwc3RhdGUtPnhmZWF0dXJlcyBpcyAweDYw
NmU3IGhlcmUuDQoNCkFsc28gdGhlIGd1ZXN0IGZwc3RhdGUncyB4c3RhdGVfYnYgKGhlYWRlci54
ZmVhdHVyZSBoZXJlKSBpcyAwIGhlcmUsIHNvIGFsbCBkYXRhIHdpbGwgYmUgcmVhZCBmcm9tDQpp
bml0X2Zwc3RhdGUgaW5zdGVhZCBvZiBndWVzdCBmcHN0YXRlLCB3aGljaCB0cmlnZ2VyZWQgdGhp
cyBmb3IgcmVhZGluZyBBTVggVElMRSBjb21wb25lbnQuDQoNClRvIGtlZXAgdXNpbmcgaW5pdF9m
cHN0YXRlIGFzICJmYWxsYmFjayIgZm9yIHJlYWRpbmcgY29tcG9uZW50IGRhdGEgaW4gYWJvdmUg
Y2FzZSwgY2hhbmdlcyBsaWtlDQpiZWxvdyBzaG91bGQgd29yaywgYnV0IHRoaXMgcmVtb3ZlcyB0
aGUgdmFsdWFibGUgV0FSTl9PTl9PTkNFIGZyb20gX19yYXdfeHNhZV9hZGRyKCk6DQoNCmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jIGIvYXJjaC94ODYva2VybmVsL2Zw
dS94c3RhdGUuYw0KaW5kZXggZjlmNDU2MTBjNzJmLi4xNDcxZGU0NzBiNTggMTAwNjQ0DQotLS0g
YS9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvZnB1
L3hzdGF0ZS5jDQpAQCAtOTQxLDcgKzk0MSw3IEBAIHN0YXRpYyB2b2lkICpfX3Jhd194c2F2ZV9h
ZGRyKHN0cnVjdCB4cmVnc19zdGF0ZSAqeHNhdmUsIGludCB4ZmVhdHVyZV9ucikNCiAgICAgICAg
ICAgICAgICByZXR1cm4gTlVMTDsNCg0KICAgICAgICBpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChY
ODZfRkVBVFVSRV9YQ09NUEFDVEVEKSkgew0KLSAgICAgICAgICAgICAgIGlmIChXQVJOX09OX09O
Q0UoISh4Y29tcF9idiAmIEJJVF9VTEwoeGZlYXR1cmVfbnIpKSkpDQorICAgICAgICAgICAgICAg
aWYgKCEoeGNvbXBfYnYgJiBCSVRfVUxMKHhmZWF0dXJlX25yKSkpDQogICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gTlVMTDsNCiAgICAgICAgfQ0KDQpAQCAtMTA0OSw3ICsxMDQ5LDEwIEBA
IGludCBhcmNoX3NldF91c2VyX3BrZXlfYWNjZXNzKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrLCBp
bnQgcGtleSwNCiBzdGF0aWMgdm9pZCBjb3B5X2ZlYXR1cmUoYm9vbCBmcm9tX3hzdGF0ZSwgc3Ry
dWN0IG1lbWJ1ZiAqdG8sIHZvaWQgKnhzdGF0ZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICB2
b2lkICppbml0X3hzdGF0ZSwgdW5zaWduZWQgaW50IHNpemUpDQogew0KLSAgICAgICBtZW1idWZf
d3JpdGUodG8sIGZyb21feHN0YXRlID8geHN0YXRlIDogaW5pdF94c3RhdGUsIHNpemUpOw0KKyAg
ICAgICBpZiAoKGZyb21feHN0YXRlICYmIHhzdGF0ZSkgfHwgKCFmcm9tX3hzdGF0ZSAmJiBpbml0
X3hzdGF0ZSkpDQorICAgICAgICAgICAgICAgbWVtYnVmX3dyaXRlKHRvLCBmcm9tX3hzdGF0ZSA/
IHhzdGF0ZSA6IGluaXRfeHN0YXRlLCBzaXplKTsNCisgICAgICAgZWxzZQ0KKyAgICAgICAgICAg
ICAgIG1lbWJ1Zl96ZXJvKHRvLCBzaXplKTsNCiB9DQoNCj4NCj5MZXQgbWUgYWxzbyB0ZXN0IHRo
aXMgYnkgcnVubmluZyBLVk0uDQo+DQo+VGhhbmtzLA0KPkNoYW5nDQo+DQo+WzFdDQo+aHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXgu
Z2l0L3RyZWUvYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYyNuMTEzMQ0KPlsyXQ0KPmh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC90cmVlL2FyY2gveDg2L2t2bS9jcHVpZC5jI24zNDYNCj5bM10NCj5odHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJl
ZS9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jI24xNDQ4DQo=
