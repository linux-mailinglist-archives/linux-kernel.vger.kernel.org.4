Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B846D410D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjDCJrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjDCJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:46:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CE610AAF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680515164; x=1712051164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V7imFj76tsPZDxXtiCfirY37EtDBNehXPa7iRqg0IeI=;
  b=EV71xZ3QQuEtFiOB46eDqCqx7hnoNRKtRZk4LHEKPs868sWkounadzcg
   hbAU7IEBvnNQvS7tKVpFxvpn4QUY384PEVSSLcZa1QJ8DCHSivwFLTIyU
   mTmy0auhbDFcRflAsNwoWZJQ053QpRwXzGQsExLkcX1pzGtOtb98BY+tg
   aC6ElOe540yaHAlrGhrONDCrzcwtBDHe58Duky74SnUZ8glQW5Lw8s1pW
   9TnH25yFFgMZLXQj2hq/m4DGKXRPV/BbXZ1gI0Muk3Ag3KfTvd28QXmq/
   2XaCalZlSLhITWSQ4KcJZPmLl+WU9J4JANLpujCH2xaPErq1LkVHGO206
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="339347944"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="339347944"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 02:44:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="755174358"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="755174358"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 03 Apr 2023 02:44:49 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 02:44:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 02:44:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 02:44:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9i80uKxHO3VKdPcaY+uyDofHEoDUe65+KYuIFomMBH5flEYhE4Asyk0E3VE3cHn5kEx9p18j5Zsg8TnWYlal97+fF7Sy0NwxxWKa9YjVE+Milm/ebBQHzl5OKqIaqJf69slEVYaQum6WNFPQjZw0VWqd+yVvc3WkQ4+9iZG26YXahOegZo5VpUfYfPZvwSfsyrRsRPcJYHN8yE7fzDHQdE8raYlQf7Y48sH5O6A+XinlbjaYow+WzmXrBeXUJcEZh2Omf/yFHiB7GM00QpBlkvHcQ3l0PWzgH3UC7Gac/47e+vKmCjPdl4FQ3wf72BrcHvrVsjC5BVOPxLGc3ablQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7imFj76tsPZDxXtiCfirY37EtDBNehXPa7iRqg0IeI=;
 b=ZNOPtd7BKRHO7m/B3/L5uIeeIe49vkiAHG6tMM9XYIHhS2/2fTq80ylXRbjgsIC0BKxVslBoifpBvXv1vf1+x/wD5/gQbjNr2OaTK3BrzhhoL4lz/H7zls5Tc7Aj4uOkoGkAIkE3mhfyy09WtWx79CkkCKbm2k83uslxIUEwpDC/Su0p9fL6hJ00A63pgcnEFeafWKmcLQDiL0XsgFTUAnA9EzwHI15xmxe6poQ8onjDxz5J6ZXdEfceaR6B6rbgF5WOHbVFJeG0flOwLkSA3BI5xf75GRywO7hAdI9bgcNHCknlNEMCSiI9dIIvJXqv6fmttVY+RKyXLqpVru9pGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB8017.namprd11.prod.outlook.com (2603:10b6:8:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:44:46 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:44:46 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Gross, Jurgen" <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Thread-Topic: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Thread-Index: AQHZZGR61ijUNf30fEKIHhN53WCdS68Y3l2AgABPgQCAACZ1gIAAAjIAgAACiAA=
Date:   Mon, 3 Apr 2023 09:44:46 +0000
Message-ID: <bd721525c559748037b642a1b08eb466beb97749.camel@intel.com>
References: <20230401063652.23522-1-jgross@suse.com>
         <20230401063652.23522-5-jgross@suse.com>
         <74b1b65577e0e1c3e54a5a708af2f63df132227d.camel@intel.com>
         <45062273-9550-be39-3e53-cb8b35717fa9@suse.com>
         <ee5a89965a49dab6e6946fe6b6614db60a77c8ca.camel@intel.com>
         <d5df822d-a8bc-c08c-cab4-53a0e1df2ff2@suse.com>
In-Reply-To: <d5df822d-a8bc-c08c-cab4-53a0e1df2ff2@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB8017:EE_
x-ms-office365-filtering-correlation-id: 3094ee69-b350-4d57-bd88-08db34280f61
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W1a9e5M61c0iSGCmtZiiOsQN8etufTBxX3mv5WyLvUdEwLRAvOBSM2vgq+YPrJBPGa1a5g2jZxPfT6dJg4dV9LYo5uuT8skIIhqvbPQqiGUyE7BUNbSRIdI7+c+ubF28GnWDrf7GD4TUM8UfxcqJWYGs1S+1WEl3vrWUW6xhzpRNao9uAsVb8D7RLilyg1AJYHvIGQFgyqxgNJMh1LklEZ3ASUexlyohrsFGZ8EmQGir1qB7YcMDSyJ3+IL0+8hVOy27lzV/eMVFCVEzqW2SEPXhg7NPLtIyyak5SRVEr1mrckw36xplkB7JzI6IaU1gKHQulXBgpAGFNvb+40f+hM8IpxnJFXrQszDnmINZ5OqLPYS6tHqugLK6IXwSEMTItAMNoNSDvqrz3elAwmDgRfQ49hENlU2+W6rH3ep6ymKoGmnI+03kXUcW/UnRuVfCcdwFWj/mpc9CEdD3ad1z38G10HP5qwyIfaUUAnDpOJwnRfczcg4me62qlps4IcZAK9i7G20EwPoi4yc7Ra19RRgeMmtYKah4oZ9yIqHYsYl0Ks70In9a0IMXc/vnCjRVhlKEF049j1ifJYjuCNy8JXB7WQvF7W1JDO+Q1N1ziQETznpk0gP3PfE3AJnqXkYM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(2906002)(38100700002)(122000001)(5660300002)(82960400001)(38070700005)(66946007)(76116006)(66476007)(8936002)(66446008)(64756008)(66556008)(41300700001)(4326008)(8676002)(36756003)(91956017)(110136005)(54906003)(316002)(2616005)(53546011)(86362001)(478600001)(186003)(6512007)(6506007)(26005)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm9VWVpvRGl4akF6RzRCWjZWeE5kUnR2VnNHYThtYjlwL2dGdjFVOTRTbVJM?=
 =?utf-8?B?OFdOVU1hbzQ1YW5iVDArNDczNUtDOUZmMzA3TXpqcjhtdTZtNmw3UVRyQmFa?=
 =?utf-8?B?K3FyTTBjT1BnTEpmVEtOSHJleU1kbTJHQWdWeWNNSXE1b1F3SE1jeG84UWxQ?=
 =?utf-8?B?QldPU2YvU1dGOVRneU83V3ZicStGRkMwc09BMklTdnMwblhsRjlEcit2OUhz?=
 =?utf-8?B?TEdLZDVlMlB2N01JQjhiL0ZGWkFFY2Z0Tm9VbEJremovRk04b2g4T2QxemdV?=
 =?utf-8?B?dWdwV1ZXdTdmbzVyUy9NTXJpcThyRXBCVWMvenR6L0hCakFDZzlWUkRiYXV6?=
 =?utf-8?B?UUJ1OW9oTnIxSUxSeW4vS3gvUTFVT3JRaUJVelVmcEI1T01ZTUdNL2h4bDNV?=
 =?utf-8?B?cmg4Y3NpRnVRQkU2bTJGdVdObWZRN0RocHRMKzhsRUJBY0ZGM0YrOUZKdWlj?=
 =?utf-8?B?OGQyMSswNkhuVlZiS3BLYWtCRVJOdjFvOHZQNVQwRUo3cURna2lMU2dJM01a?=
 =?utf-8?B?Z29PdE85UWJxeERheFg3cFVLVnBCUEswak5MTitoQUg5TUE2b1dXKzhSVkZi?=
 =?utf-8?B?L2pXOWE1ODJ2NW1VMzAvRklUajRYSTY2cUxBNTVsdGltTXZGU3F6RjFpTGh2?=
 =?utf-8?B?MUc2QjN1SmM3aWMzV0pDOTBWc0F4dkZpQzdSN1RrcG5pbERQY2RCbHZPUzVY?=
 =?utf-8?B?M0g2Q3NuaEZISWV3cytzNE5ZZ1ZQVWdycTZaQkFBMmpYL2ZwdXhjdklSSGRi?=
 =?utf-8?B?TVdlODM2SmdRUHZYckcwcUw1Uk1rSVFjRWpkOU1GRDVWVGJ5SllESWdQbFlX?=
 =?utf-8?B?SEZncUhxd3VudXUzRTF2dHhTZ01JTzdmSWhkNXpYZEZ6b3pxamNVdUl2c0sy?=
 =?utf-8?B?MXEzN1lkT0hNQzFuaTZqTi9aOHdHSk1lNDN5NGJ4V2FEOVgvNkx0eVBieFd4?=
 =?utf-8?B?Y002WURxT2hXSDhYb0syWEdvWStLUi9URm0vcDlGYXVCZEYzbmJJa0FRWC8v?=
 =?utf-8?B?N2hNOFFRTzM3SUtzcXRKY3loNDZuaVhDeG5zOFZVa0NpcnNVUTlnV0x1VGlq?=
 =?utf-8?B?TXpFREVkRjRMazVBNlkrc2F1N2hNZ3dvRmFGUlJ4NGFRTFROQnE5NEYrcmJ6?=
 =?utf-8?B?VkZ6RWNEd3g5S2tVckIrYjB4Sm5yV3JrOXJtcEtVODBCLzFmOVhBVzhkUExY?=
 =?utf-8?B?S3ZlZEJxWmlWejQxTDh0VnF2RjlWaUxPMWNLQjdnTXZHN1lLZnVZcmxYQmZt?=
 =?utf-8?B?UDA1NFk3UXg4YzNvWlc0SkNGbDVzRzIzaFVCaEo4WEk2QmR0eVBOWUNqOGNU?=
 =?utf-8?B?eXpCWnUzWFh5VVZVQ1IvYzNMOElyYTFGNmhrM25lcXRKSmpYTVd5TjN3SjVK?=
 =?utf-8?B?dnIxUVN0dVhCMHc5SHVhZGpJNjg3bHlDR2JzckVMZFFEdW5ISWFQOWZHY3ph?=
 =?utf-8?B?K0NqK2hxMXhLK3FsVkF2ajhtUEpsc3g3Tm1HK3gzcFVpNzN0Nzh5VEIvQ0xa?=
 =?utf-8?B?OUdYaVd1L2U5R21zUDNmN1FOMTk3b0pxOExWV2p4b3pzcEZmbTRoSFJibzlF?=
 =?utf-8?B?c2VuK2FKK3dPeXl3WkpUNmRPdUxzOVk1OS96Z0pNOWJsQUtiMnhXekVSNWpP?=
 =?utf-8?B?ZzRISFlaNEdrSmlUU3dFakFiUEdQUHU5eWpEWE5Xa2Y0V095Y2FBdG9lUFUz?=
 =?utf-8?B?alR6U0VkcUsySGJzeEgrMndJamVRWjZLWXRIcmxyc1YwdEVLRnhMZkhRUVhs?=
 =?utf-8?B?ZlhPSktFaGFUNndtaXlkTHBSbktNd3pqNmdCUExJbzNCZlBTajU0dnA4R0ht?=
 =?utf-8?B?cytvNTFFV3RRcFVRUGJheDJTUXhkUTlPZ053WHBZK29BdXVBS1NpaVFsbVVK?=
 =?utf-8?B?OHRHM3FybHBTaVRZaXpGNXhYcVprWC9KWk8yamtwY2xkOFVhN1Q2ZHNqVUZl?=
 =?utf-8?B?QnMyTjU5N1daNnVRWjNCOEg5bnBRQmQ0MEpkQXQ3K0Vnb1FmQXVhR1pObUUw?=
 =?utf-8?B?STJVdDRVWjZSSXVDZWIxVjZneVVvZmN6SkQyelJNOWN4bnpUbVk2MExGTU5k?=
 =?utf-8?B?STRGQkUyVDNEV0dHcHF2TFlRazZzSUMrL3VBeWRrNDVQQm5KUnlZNHgzNnoy?=
 =?utf-8?Q?2tpMxKfxm6ldWs45OazMhSoMJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDA71E061D38D140881149A2EBDFEF28@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3094ee69-b350-4d57-bd88-08db34280f61
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 09:44:46.3956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7oFecSRMtasm/RJ1bkRDz6FTL6j83LP1e7dLiDBbwaL/0apICS3jotcafGnhD+PQlZ0gzrbmDm/XMZbhQKt7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDExOjM1ICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiBPbiAwMy4wNC4yMyAxMToyNywgSHVhbmcsIEthaSB3cm90ZToNCj4gPiANCj4gPiA+ID4gPiAg
IMKgLyoqDQo+ID4gPiA+ID4gICDCoCAqIG10cnJfdHlwZV9sb29rdXAgLSBsb29rIHVwIG1lbW9y
eSB0eXBlIGluIE1UUlINCj4gPiA+ID4gPiAgIMKgICoNCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRy
ci9tdHJyLmMNCj4gPiA+ID4gPiBpbmRleCAxYmViMzhmN2E3YTMuLjFjMTlkNjdkZGFiMyAxMDA2
NDQNCj4gPiA+ID4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jDQo+ID4g
PiA+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPiA+ID4gPiA+IEBA
IC02NjYsNiArNjY2LDE1IEBAIHZvaWQgX19pbml0IG10cnJfYnBfaW5pdCh2b2lkKQ0KPiA+ID4g
PiA+ICAgwqAJY29uc3QgY2hhciAqd2h5ID0gIihub3QgYXZhaWxhYmxlKSI7DQo+ID4gPiA+ID4g
ICDCoAl1bnNpZ25lZCBpbnQgcGh5c19hZGRyOw0KPiA+ID4gPiA+ICAgIA0KPiA+ID4gPiA+ICsJ
aWYgKCFnZW5lcmljX210cnJzICYmIG10cnJfc3RhdGUuZW5hYmxlZCkgew0KPiA+ID4gPiA+ICsJ
CS8qIFNvZnR3YXJlIG92ZXJ3cml0ZSBvZiBNVFJSIHN0YXRlLCBvbmx5IGZvciBnZW5lcmljIGNh
c2UuICovDQo+ID4gPiA+IAkJCQkJCQkgICAgICBeDQo+ID4gPiA+IAkJCQkJCQkgICAgICAhZ2Vu
ZXJpYyBjYXNlPw0KPiA+ID4gDQo+ID4gPiBOby4gVGhpcyB0ZXN0IGp1c3QgdmVyaWZpZXMgdGhh
dCB0aGUgKHZpc2libGUpIE1UUlIgZmVhdHVyZSBpcyBzd2l0Y2hlZCBvZmYsDQo+ID4gPiBhcyB0
aGVyZSBhcmUgbm8gd2F5cyB0byBtb2RpZnkgYW55IE1UUlIgcmVnaXN0ZXJzIGluIHRoZSBvdmVy
d3JpdGUgY2FzZS4NCj4gPiA+IA0KPiA+ID4gSSBjYW4gbWFrZSB0aGlzIG1vcmUgb2J2aW91cyBp
biBhIGNvbW1lbnQuDQo+ID4gDQo+ID4gU2hvdWxkIHRoZSBjb21tZW50IHNheSBzb21ldGhpbmcg
bGlrZSAoYmVjYXVzZSBpdCBhcHBsaWVzIHRvIHRoZSBjb2RlIGluc2lkZSB0aGUNCj4gPiBjaGVj
ayk6DQo+ID4gDQo+ID4gDQo+ID4gCUlmIHdlIGhhdmUgYSBzdGF0aWMgKHN5bnRoZXRpYykgTVRS
UiBhbHJlYWR5IGVzdGFibGlzaGVkIGZvciBzcGVjaWFsDQo+ID4gCVZNcywgd2Ugc3RpbGwgbmVl
ZCB0byBjYWxjdWxhdGUgdGhlIHBoeXNpY2FsIGFkZHJlc3MgYml0cyB1c2luZw0KPiA+IGdlbmVy
aWMNCj4gPiAJd2F5LCBiZWNhdXNlIHRoZSBoYXJkd2FyZSB0byBydW4gdGhvc2Ugc3BlY2lhbCBW
TXMgaW5kZWVkIGhhc8KgTVRSUi4NCj4gPiANCj4gPiBUaGF0IGV4cGxhaW5zIHdoeSAndHJ1ZScg
aXMgcGFzc2VkIHRvIG10cnJfY2FsY19waHlzYml0cygpLg0KPiANCj4gSSdkIHJhdGhlciBzYXkg
dGhhdCB0aGUgaW50ZXJmYWNlIG9mIG10cnJfb3ZlcndyaXRlX3N0YXRlKCkgaXMgYmFzZWQgb24g
dGhlDQo+IGludGVyZmFjZSBvZiBnZW5lcmljIE1UUlJzLg0KDQpTdXJlIGZpbmUgdG8gbWUgdG9v
LiAgVGhhbmtzLg0KDQoNCg==
