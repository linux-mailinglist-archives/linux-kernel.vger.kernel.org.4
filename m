Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B74D5FE7E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 06:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJNEKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 00:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJNEKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 00:10:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7F214D8F5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 21:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665720646; x=1697256646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=laYbaQp76P49ul3VukM5KkC1ohHUB+Z2XofaZ/ap7cw=;
  b=a17usrky70eXCZbzXb0/xHBNgT1w0BWZ78CNIjdaFqadRguqWMmS1s5+
   +jXr1+NZh7+5/dNGtGswM55VOMETHuCo8GL3dvfMEACJ+TqLBWREdW1PM
   91VkrDhdT7YZNzCTmYfL45MXz73rKAyfUkzt5NnVBYJPo26F080kYDWEZ
   b9wd4I2EnQ+HZKcHV7PaUGEB7dj2ra6bZPbxnUuN3S3AcQVt0Ofgidr+F
   9BP8jT+nhNKLu0WVec/Cg+/XBtUUaxHNPAVrNEASwnfAqItzHj2QwbTp/
   aNUKR0Wib+oc6BjMSDAe4EBwYKEJGQnGkFwl5KKZqCsfcWMvDsf/HwyQM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="304014845"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="304014845"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 21:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="872589634"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="872589634"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 13 Oct 2022 21:10:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:10:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 21:10:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 21:10:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKg+iHXSV9VARvyXquti5XrO48sw8Rkyh78OBGalPsyaFu0mVHRPi8+uyyNcTdEspiQpQXA39erh3K7br0qYaX3Yi90qOAbMjJQl1sKjFMC5JkfYGbEDty6eay9XqYgtEYzrKZ9IogVLIzPTrjZXnr9m4oUuGobGhWJ/ILb2bdmFINX3Yvi8YANzQ3/bWxvtjpdC4hG00ku9Tje78bsw/ayB5PMrdNgPts5VAOpcrOM7skzsbjGFo0mxx44vbXXYVe/mO7ijcPU+4vZelaxsKEowLOuOUWwpBspdWn+OdOdyz90T+2LH8ZZLC51eZLJdloF0PcPLYBeeR974u5Um8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laYbaQp76P49ul3VukM5KkC1ohHUB+Z2XofaZ/ap7cw=;
 b=MeShT3g7P879FoVUkg+4C9rLjnNCdebtyymblsqSn6UObD74+Wh1ua/Sts8o+iV4GEvBDNbMDOlCz5m1H1d7op5hKEyLaFi5DJBW/LQPaJMaygxuBS2rHdv0S3PyF+1Enkj1U/YV645dM2198FKy9SbdNEyq7kMvBqZDU/4tB0s8Udgfr0BGmeckd8WbOGel1Ssxpd7tBmCXlgTEI+Yo4G2DG3qxYo9zlBPnsPD4M6jU2dW/fMELEords2rodNJp6vLH58iBjf1l8qZPpSvZRN+IrSpZjyELOCSR/9GehugQzFub1sPg1qi6AO0ow2L+54XtuFF0Ywd7vD55MsBNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3717.namprd11.prod.outlook.com (2603:10b6:a03:b0::12)
 by SA2PR11MB4908.namprd11.prod.outlook.com (2603:10b6:806:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 04:10:43 +0000
Received: from BYAPR11MB3717.namprd11.prod.outlook.com
 ([fe80::e3a9:2e44:76bf:8c28]) by BYAPR11MB3717.namprd11.prod.outlook.com
 ([fe80::e3a9:2e44:76bf:8c28%7]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 04:10:43 +0000
From:   "Yao, Yuan" <yuan.yao@intel.com>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Thread-Topic: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Thread-Index: AQHY3cA8G+rUHXTHGkezKzq8f0LSDa4LpX7QgADfOACAABA+AIAAA1uAgAADCwCAAKpNAIAAAwBw
Date:   Fri, 14 Oct 2022 04:10:43 +0000
Message-ID: <BYAPR11MB3717D733EC448197D0321FF695249@BYAPR11MB3717.namprd11.prod.outlook.com>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
 <BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com>
 <9b198ed3-4b2d-c857-710b-3f7115bbcf74@intel.com>
 <78f2021e-339f-9dfb-2aee-51f58ea77ec9@intel.com>
 <9be1413b-ce30-acf8-86fb-3e302dc98396@intel.com>
 <dd5815fa-ec61-b7d1-c0b3-70cd0f33bbee@intel.com>
 <084b98d1-1021-14fd-0d7b-3b85ffee3035@intel.com>
In-Reply-To: <084b98d1-1021-14fd-0d7b-3b85ffee3035@intel.com>
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
x-ms-traffictypediagnostic: BYAPR11MB3717:EE_|SA2PR11MB4908:EE_
x-ms-office365-filtering-correlation-id: 5ec519c1-df22-4df4-e3da-08daad9a1012
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hyD4kPm3oZO8F+16LzeC6MfMAIHIi5JdG/nKKoguOoo3WlU3IsLT64wz2Jtul02YnhkcmJvzYD5OV1rVqyDa6ubzphEuZFHN46Uz1GHp42z3CJkf+Zm/SYA394ETBy1erqRVv49fORZbrFpZtww9f6ZAujuOU1oX7kEH5Emug3yMOMQHSpFe+c4BM1KcrHJbofsZzaX+S6qRxzNxP9Mxse3+t7gFlt1XiJbUIlyqFZ71aIU4WfwplpcEk5ft0f2hynW5vu+y2V0YFOO/fVDZ5gJwGGMxoYp+BZ8dnU59HOO0Cvvju+T9A/V0KQOenkX2q1gVC/3x4endIVMthl8b3jY1GYPXeiepnDYwyCm0LJdoln23W3jcRBE2JmiJZUTSmqXuMgZ/aVn8PBDXPi1B+2UCSQwKp0JP0ZrVm3JoanoGAwhc8sQL+9G7/T4AryyanIfc5OFA43bJailsaKtm3Tc7VvtfHHQw3ybNHhZP1ki1seEf/PIhtdD1Ozjo5zW7jGhm6WIwv1En4Xkpm9KG+28koAQPuxEwB5LCFYpEsetHdR3/GCRArwpURvMn9p6/yhFZcLs8KqcKkvWNf2ELLRBqkuPPG2gQ4KaQw0jqv7PfVkknwaImZLjHozLFiRcdJwWYKQ3R8n13zqGoNvMswFGXhOkIJ4Ip8UMNUoUcPGnwNWvXDZduNE+2IikhRiNuRmSk1YeYvurpOoVWiRedC3mZ9xoNSxviZstoC7CtynjbwhzP1f7uIDyKAJvf8S9oD5t4f7ZAr3gEwO2n0GY19g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3717.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(478600001)(71200400001)(122000001)(38070700005)(54906003)(86362001)(110136005)(38100700002)(83380400001)(66476007)(66446008)(8676002)(76116006)(6506007)(66946007)(4326008)(7696005)(64756008)(26005)(66556008)(52536014)(41300700001)(55016003)(316002)(186003)(2906002)(82960400001)(5660300002)(8936002)(9686003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2ZyRWY5QlROR3RkUGcvNWRKRk1KWi9KVVQ1TzJqTWw3WFc5MUZETlR2Si9Y?=
 =?utf-8?B?Q1NlMGZFRDBoWTBZbGNEM1NESmY4ay9HS3h0K0pqaEhSV2U1b0VvZzc1M25C?=
 =?utf-8?B?eUltVmh6QlBQYUwybGFVeUxsM3prenVkZ3BEdDg0WUNiNDVPaEJBMGJFU29n?=
 =?utf-8?B?cjZpNkc5MDF0c3NQVXIvVjU3YXlZUldFM043R1JyU3ZINUd0ekFTZUJETTYv?=
 =?utf-8?B?TGlKVEV0T2JKYmtEdkR5YmlJYnZacUpEaDRKdnByaEpMS2ZxeS95WjNoMlV5?=
 =?utf-8?B?bDFidFdZY3l4OXl1OTJNSUJ4OXczMmVmL0JpUTlJQlQxTGwvTjdVeEVYbC84?=
 =?utf-8?B?Z3RsS3NyM0x2RDRab09RMy9GOFRaY0pKZm1JN3NkZUwrc0NxdXhUcXo5RXpv?=
 =?utf-8?B?M1BTc2pSV2hKU1kvTWZkaG9qaVpzNFRhSWlscEFySlhTN0dQZWt0akp4djRr?=
 =?utf-8?B?U1c4Sy90MnY2ZmFFaTVPOTQyYUF5ZkpBQ2JPK3dWS081MCtkZUJVV3RlQ1Y0?=
 =?utf-8?B?Q3JGNDFoWmxVbjJDZEFLOVArTThPL0lkM2p1c29Ec0hiVEZlN1R1RUpVNld0?=
 =?utf-8?B?VytDeEcyUEVtNjZaRzR1MU1OZzB6K2RUa2pLZ1F1aWZiUCtwMXYwNnl4dlV4?=
 =?utf-8?B?S3gzK3ZSVkdVTHh1MWFNVDNPa09MOTVLTFovNFpmNW10d2syU0ZCVUhtL08v?=
 =?utf-8?B?eXFvd3QyaWUyOEF6eUtaL1psbnlMYVEwRDJPVnNva05ob20weEZxREhLc2pu?=
 =?utf-8?B?elJrZzczdjMyRE05TmxkOTZJWGE1a3l2MTkwN2t3YlRtcWx6SHd1bUU3T0FX?=
 =?utf-8?B?djZCN2ZyQkhTREtzSThQQlRKOG9kQythVS9MR29jaUNBQk1HbDZOZkM4cUFX?=
 =?utf-8?B?Z3dGRjlSS2FoUUpyS0I2bHhUU0dINGVmdDlPNmRpeWZLUW50bXBtZno3TXpp?=
 =?utf-8?B?dXh2dEJScU1WOGs0Y0FqdHo4djNtYkJGS3RWTVhEaThHZlNLYU42V0lzWnZI?=
 =?utf-8?B?cDZHS2lsV2tqelZiNUsxVGpxb1N0a2Jzc2ZSUG5ZTWduc25zNmRzTkM0c3lH?=
 =?utf-8?B?QXBnbXcxR01MdFFoeFNHaVFWSlV3bkI4WlUvWk0wV1o0bm5qa0tHc3F3UHNU?=
 =?utf-8?B?ZlFrOENVREFtS0hOUDU3ckNLRTRzMEJVSDhxbUFwVzdTNWVNQ2FOV1NWYWE1?=
 =?utf-8?B?S01KMTUwbk1kZHEvS3JKQXQ4cmsvOWxRc0xTenR0YjE2aGFjcUVtTXEvenAx?=
 =?utf-8?B?YXlXVHFXNnZvTnp0SEVNaGgwTkVueGJ2WHBHNCtPK0dLZ04vU2c5MEJ2bjBV?=
 =?utf-8?B?aE1DK0dqcmtCZW91TC9VVU9sNi9kOGVSRVVFalFES3Uxc0NLZ1BETmxwZ0hR?=
 =?utf-8?B?a2VWMW13d0ExZDl4N1Z5SEpLZytyS3F5Rk05ZzNLU252Vm1JOVNGZFJHclpy?=
 =?utf-8?B?bVFzL2RjdUhhK2krSlM2S3c5UzVQalNjeVE3UE1kS3ZqMURxOThGZ0hMbXlY?=
 =?utf-8?B?c1EyMmlDNUo0M0tkRGN6NHVEd2FtSTd3NVJvdzQ2MGRxZmlQWm1Id0d2Z05D?=
 =?utf-8?B?ZkFyRTRvMURBQjM5T3hIOUowZnMzdUttRXVMZWFVeUdHY1NnVUc3WU9xTkQw?=
 =?utf-8?B?eVlXdElEU0tPaERNbFhLR0JqYTIxM2xwQ2M1SXZpcXNCbC9LYTlTSFh6OUQr?=
 =?utf-8?B?TTRXRTJ6MUxmbUtqVkZlL1hLcmtDc0hxRk1wV0dHL3R0Yks1aUpDN1B2SEx4?=
 =?utf-8?B?ckVGUWE0YUFrSUV1RHkxc2Z5a0tjSWRuQ2VXRmZiZlNNRnhzY2gwR2xXZHBQ?=
 =?utf-8?B?TTJyN2lNL0ZGa2hpcUhnTDlrazNwMVdCR21CTktVTnBHcXBsTnVsMzU1WTJN?=
 =?utf-8?B?azZhMFZlYk1XT01ORmhNMmVLekZMRzlZNGZsV3pOVDk2a1NEcGtEYktLUmk4?=
 =?utf-8?B?NGROVGo2S2ZSeHhJVEtYSXN0T3FGSWxMVVFqR3B2cXZtOGpFRGp1WnRHOWcx?=
 =?utf-8?B?UjlFMEtta2FidTR5M3Bsb09teDVSckFnci9CMWR1a0RqQ1hkMzNKdkEvcGxY?=
 =?utf-8?B?TS82MTZJUkpxOTVUdHMwNmwwYmRTa2kwSUZpZ01iWmQwUnZyYkFkZlFvYURP?=
 =?utf-8?Q?MF0ATiQqYGcRFn7bIy0FDWybc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3717.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec519c1-df22-4df4-e3da-08daad9a1012
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 04:10:43.2120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgVxwMfed/KMbjHMXSwYy+BSAi13WiojQjqM67HOi6CNKbrfA43N4Dj62GszfIsSguIdedy7OvxJjtwKsEExGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4908
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
Zy5zZW9rLmJhZUBpbnRlbC5jb20+DQo+U2VudDogRnJpZGF5LCBPY3RvYmVyIDE0LCAyMDIyIDEx
OjU0DQo+VG86IEhhbnNlbiwgRGF2ZSA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPjsgWWFvLCBZdWFu
IDx5dWFuLnlhb0BpbnRlbC5jb20+OyBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50
ZWwuY29tPjsNCj5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+Q2M6IHg4NkBrZXJuZWwu
b3JnOyBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj5TdWJqZWN0OiBSZTog
W1BBVENIXSB4ODYvZnB1OiBSZW1vdmUgZHluYW1pYyBmZWF0dXJlcyBmcm9tIHhjb21wX2J2IGZv
ciBpbml0X2Zwc3RhdGUNCj4NCj5PbiAxMC8xMy8yMDIyIDEwOjQ0IEFNLCBEYXZlIEhhbnNlbiB3
cm90ZToNCj4+DQo+PiBBIGJldHRlciBjb21tZW50IGZvciB0aGF0IHdvdWxkIGJlOg0KPj4NCj4+
IAkgKiBTb21lIHVzZXJfeGZlYXR1cmVzIG1heSBub3QgYmUgcHJlc2VudCBpbiB0aGUgZnBzdGF0
ZS4NCj4+IAkgKiBSZW1vdmUgdGhvc2UgZnJvbSAnbWFzaycgdG8gemVybyB0aG9zZSBmZWF0dXJl
cyBpbiB0aGUNCj4+IAkgKiB1c2VyIGJ1ZmZlciBpbnN0ZWFkIG9mIHJldHJpZXZpbmcgdGhlbSBm
cm9tIGZwc3RhdGUuDQo+DQo+WWVzLCBpbmRlZWQhDQo+DQo+QWxzbyB0aGlzIHhzdGF0ZSBjb3B5
IHJvdXRpbmUgbG9va3MgdG8gbmVlZCBzb21lIHVwZGF0ZXMuDQo+DQo+SWYgYW4geGZlYXR1cmUg
aXMgcHJlc2VudCBpbiBmcHN0YXRlLCBhbmQgaW4gaW5pdCBzdGF0ZSwgdGhlIHZhbHVlIGlzDQo+
cmV0cmlldmVkIGZyb20gaW5pdF9mcHN0YXRlIHZpYSBjb3B5X2ZlYXR1cmUoKS4gQnV0LCBpdCBo
YXMgbm8gc3BhY2UgZm9yDQo+ZHluYW1pYyBzdGF0ZXMuIEFsc28sIGZvciBleHRlbmRlZCBzdGF0
ZXMsIHRoZSBpbml0IHN0YXRlIGlzIGtub3duIHRvIGJlDQo+emVyby4NCj4NCj5UaGVuLCBwZXJo
YXBzLCBpbml0X2Zwc3RhdGUgaXMgYmV0dGVyIG5vdCB0byBiZSBhY2Nlc3NlZCBpbiB0aGUNCj5m
b3JfZWFjaF9leHRlbmRlZF94ZmVhdHVyZSBsb29wOyBpbnN0ZWFkIG9mIHVzaW5nIGNvcHlfZmVh
dHVyZSgpLCB0aGUNCj5mZWF0dXJlIGNhbiBiZSB6ZXJvZWQgbGlrZSB0aGlzOg0KPg0KPmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jIGIvYXJjaC94ODYva2VybmVsL2Zw
dS94c3RhdGUuYw0KPmluZGV4IDEzYjgzYjExYjNkOC4uMGZkZmQwMzkzOGI2IDEwMDY0NA0KPi0t
LSBhL2FyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRlLmMNCj4rKysgYi9hcmNoL3g4Ni9rZXJuZWwv
ZnB1L3hzdGF0ZS5jDQo+QEAgLTExNTAsMTEgKzExNTAsMTEgQEAgdm9pZCBfX2NvcHlfeHN0YXRl
X3RvX3VhYmlfYnVmKHN0cnVjdCBtZW1idWYgdG8sDQo+c3RydWN0IGZwc3RhdGUgKmZwc3RhdGUs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICBwa3J1LnBrcnUgPSBwa3J1X3ZhbDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgbWVtYnVm
X3dyaXRlKCZ0bywgJnBrcnUsIHNpemVvZihwa3J1KSk7DQo+LSAgICAgICAgICAgICAgIH0gZWxz
ZSB7DQo+LSAgICAgICAgICAgICAgICAgICAgICAgY29weV9mZWF0dXJlKGhlYWRlci54ZmVhdHVy
ZXMgJiBCSVRfVUxMKGkpLCAmdG8sDQo+LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF9fcmF3X3hzYXZlX2FkZHIoeHNhdmUsIGkpLA0KPi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBfX3Jhd194c2F2ZV9hZGRyKHhpbml0LCBpKSwNCj4rICAgICAgICAgICAg
ICAgfSBlbHNlIGlmIChoZWFkZXIueGZlYXR1cmVzICYgQklUX1VMTChpKSkgew0KPisgICAgICAg
ICAgICAgICAgICAgICAgIG1lbWJ1Zl93cml0ZSgmdG8sIF9fcmF3X3hzYXZlX2FkZHIoeHNhdmUs
IGkpLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeHN0YXRlX3NpemVz
W2ldKTsNCj4rICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4rICAgICAgICAgICAgICAgICAgICAg
ICBtZW1idWZfemVybygmdG8sIHhzdGF0ZV9zaXplc1tpXSk7DQoNCkFoLCBJIGRpZG7igJl0IGF3
YXJlIHlvdXIgcmVwbHkgYmVmb3JlIHNlbnQgbWluZSA6LSApIA0KDQpEb2VzIGluaXRfZnBzdGF0
ZSBzYXZlcyB0aGUgImluaXQiIHN0YXRlIGZvciBhbGwgbm9uLWR5bmFtaWMgY29tcG9uZW50cyBp
biBpdHMgYnVmZmVyID8gaWYgbm8gdGhhbiANCnRoaXMgY2hhbmdlIGlzIGJldHRlciwgZWxzZSBy
ZWFkIGZyb20gaW5pdF9mcHN0YXRlIGZvciBhbGxvY2F0ZWQgYnVmZmVyIGFuZCBvbmx5IHplcm8g
dGhlIG5vdCBleGlzdCBidWZmZXIgaXMgcHJlZmVycmVkIHRvIG1lLg0KVGhlIGhlYWQueGZlYXR1
cmVzIGlzIDAgYmVmb3JlIHRoZSBndWVzdCBmcHUgaXMgdXNlZCB0byB4c2F2ZXMgYXQgbGVhc3Qg
b25jZS4NCg0KPiAgICAgICAgICAgICAgICAgfQ0KPg0KPlRoYW5rcywNCj5DaGFuZw0K
