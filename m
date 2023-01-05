Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A7F65E574
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjAEGPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjAEGPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:15:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEADA5133F;
        Wed,  4 Jan 2023 22:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672899337; x=1704435337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NbQFO7myz83qKFIK5bPQY1uVB1qjF3KLidvHVwfB47U=;
  b=X6ugTzfqD8HYslrJQ1D4Ep9OYL+VWigTVdNDo333TDGvpoeoFf1Nubtn
   zNSE2CQgoWL27R6gvVhNEzP+eQxmEkwCYhOMAwcrtnUHrSoTVE5ArV/+0
   L1upUO3jHoCgXAKWNrze89+BuR4LF0DadLkIREBG6g2k0kyGUZ4NBEaX2
   AoW3QKSAStP2/5UMn4TF+6z3ANCMAktBT09CiPNgzlBMJ97tJ8I/NCSh/
   Je1ymgq/h01cxEGQxvjJ2pXEw3xuBJ4qvZP/dsRJm0Lx2gZ33uWsd+Cef
   nOD6+o6qsIlDt9SCwVmju7uBD9hPfd2UlIoqHE+lL/BYLjQvMEiYkstvm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="408377733"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="408377733"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 22:15:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762990141"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="762990141"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2023 22:15:36 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 22:15:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 22:15:36 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 22:15:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRpeVwCevn6McQ0fEfoGIP9vrd7HynVCC5Cv6Nu2ycTTfrbWovLsFSO8UXVX95ZvqLSnKNPbBrEimFP+/c+nq3hAynG9SDlKf7VLnZ5q9LjLpHOBJCfCz/XApnTdAoz5YQRhEtueY2bZNQ364+4t0Topmw0cd7ncY60GJPWiqrafpgzyNa9xqy/P0CRrZz4Zkfgjk7d4rIV9CQs7f8415VfLOxLpfoxs/NoesOoYGksAg2sEhFH55VGT9wKvSAZq7dfs+V+G1nXL96DJ05fotTnnBxPFPJ8Xt46OqNg/hU5UTt2ShRSRPupoP/+FCBju3hqAW7K7IXC7rRawiK+v9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbQFO7myz83qKFIK5bPQY1uVB1qjF3KLidvHVwfB47U=;
 b=TNHsxBfYm+NwipaQaQJ/v2GMBL88lyD2TZWVAz4ZVGhUtdbsHJsCXnpjboLsSYmmODd5hnZXo34fltu7IXsUAJQCdSHEe1v4GetTHGoiBHULJYzGuike9eZejJcV2i9hGOkwNDSNb4T+rO+iUhkncgrWVPVu//B64tQiB2jdIs05gN74eqmy8G0sLSGYkcXTfPivsMZCJfHskYJMub48BvV8o6G6kMImoycnT3GGHPLrF0MUsPVDN3G29ohVEGRvU65amLeaOZkpoRhuNHVvA0tN1Xlf0igelUBdiY7wFo+E+bf3P0pnlEZHlQyn7fId8HirbXUoz/7GLyRQVb0AXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH7PR11MB6699.namprd11.prod.outlook.com (2603:10b6:510:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:15:33 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:15:33 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "chiluk@ubuntu.com" <chiluk@ubuntu.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
CC:     "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
Thread-Topic: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
Thread-Index: AQHZH5oVr1pMlqTWAEqPlNzN20DJJK6PeNqA
Date:   Thu, 5 Jan 2023 06:15:33 +0000
Message-ID: <b5e9c8911a46802ddb017554f266c92a7a0b2605.camel@intel.com>
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
         <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
         <CAMfi-DTwX2nvP58FRb6NaGMyWO0SBo9W=Fpdtr=XfNRzkqAwHw@mail.gmail.com>
In-Reply-To: <CAMfi-DTwX2nvP58FRb6NaGMyWO0SBo9W=Fpdtr=XfNRzkqAwHw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH7PR11MB6699:EE_
x-ms-office365-filtering-correlation-id: 0002dd4f-d4e0-443b-5471-08daeee440ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XcksPMXU6RCuy49Te1ta/B/LBBOyPNb0Xalk5VIFyA6ZapZphu+KwdvPtsA6OGmod/YxdV2CnAyOjf8vWfrzoMx2G46CfU5/qOa2rS7+BEkKtH/qIU3yRlXme51zRa29tq2nUokjIuqzgaH6yBe7oZ8iBFXIpqq8l6J7R0eFxeirtGzBYwLwZek35DLY9Ivcgjw9e0JOl48BVEQTgHPceg53xT0MjG3pyor4fVnAj2LeGe1f1nTAIB1bPpNmIXzlB66dGBhnzheNUWkGqFtu5Ds3Zez61NBFfxfhBWqL2Gatv2sc1TaAYOie4mfCRCAhYJS1dE3E+GxVOVYm79xRms1PcJceYQA/NqBvBQFMxN/EkNkLbFtr4Fk1t+ZR9OzACY03KUKHzh26RzucHJea51M2uILL38VjxDXHu+rCxzK5xhMkG1nIKOqDq7k/kslp8welEqDtphvFTyVfFhSWfL89Wx5wqJZ0tzxVUn2Wq7PBH1mfRsD9UMR8X5E3ismDi1SBh8scr+XScGKA7ax1oRKzFkwdhQyL2HWOV9Ek5enHvFLhL45rJ3N4Atc9R915PBw1WhZIbRIZpEBvhiaTmcljhM83Op0ixaAsC55aXG3JexJtZkHeDzo5V+8AVGa3zfNxn/Q2a0uRNi112yzOiBWC9QR0+fdWR9zAvVD4DBovEF+zP0ytKSU91akhzph68czzGHs1H1NOIMaShE6M7SzCtuwwWop+cq3aTvsw9M8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(6506007)(53546011)(36756003)(478600001)(71200400001)(6486002)(82960400001)(38070700005)(122000001)(38100700002)(6512007)(186003)(83380400001)(26005)(2616005)(86362001)(966005)(110136005)(8936002)(91956017)(76116006)(5660300002)(8676002)(66946007)(66476007)(66556008)(64756008)(66446008)(316002)(4326008)(6636002)(41300700001)(54906003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T21PNXl3MFRMR0hWckwzU0N6eDZQdjNwR3FqRW1IY3pFOWp5VlFmc09VT1JO?=
 =?utf-8?B?aXEvbVo4OXRybjlRQXFoQWxmVS9VNzBkRS9HamJCNFFKb3ZIZzRCTUZXUFNh?=
 =?utf-8?B?RGM3Z3ZHb2Y5VGFHOFRoTzZBWlpBMmc5V3Z6QitXeEphbnNVWmxtN3YzaDVq?=
 =?utf-8?B?OWRtN2hYWkQ1RS92RG9TR1JVQ25pYnhUWlY3cnM2a2FuaXlSemtEdENxZm1M?=
 =?utf-8?B?WU5DWXlEUkVCY1drc3R0ZXl3dTZhS3c5eU5KajNJa2JqVG4zQXBkeXA1QWNp?=
 =?utf-8?B?b05yREpjdVhlMUpCQjlnMDlKOGFuOUhlaEdlblVyRlRucU1QYXJja2x2NENH?=
 =?utf-8?B?WGd5ZStpRnF2eUpMRWQzd0R0VkpyU3Nla2JUdlFPVTA2eFRCbGF5MUF6Wm1w?=
 =?utf-8?B?MHNxY1lpR3N1Z3FjRWwrZVp2dU9OTjdMbnhwRVp3SUxVSDBobnZBZm9Hb1N4?=
 =?utf-8?B?dmRKUkJOUVZNTHR6bGQvMFJTaXIwcWd0VjErZ3ZUa3NueXMzTGJNaXhvdnpy?=
 =?utf-8?B?MG5BSW82WTdhZkVkT2pEL1dBVUhEek56WDg5WEF4VWExd2NZdWhXcmljSklJ?=
 =?utf-8?B?ZjJzYmh0M3pxSmtETWUzRFRhbkdoM3NoaEFsWnNMR3VNVkx1MUR3NzdUekJ3?=
 =?utf-8?B?WUtQRjhzTTE2dDlGdXh4M0NNeEFZWURoOTMxZ0pzWlRaRmxtcGZpVWduVkVZ?=
 =?utf-8?B?eEcxc2hWeEFZeHh3T284MUgvcnNoS2txVlQxT1N0TVNFbnl4TVZQYms3OEFr?=
 =?utf-8?B?RFUrQ1NuTjNQZHpNekVGK3Z2WmY1QVFmbmlmT1FrU0NKYnA3NlBhcWw1M3hr?=
 =?utf-8?B?bzg5TllHSHpvTWVnWGtLc0dVb2VMdHUvRGNHNEpPVE05ZDZlVTRTelRnSTVC?=
 =?utf-8?B?THJ3UzNPTzJhMFE0T08xclBHaVdZRVpQODlnSmlwTE1kVFpyZzJ6eXRLMnN6?=
 =?utf-8?B?Y0dZcTNiU2N1UVRHYU1sUzhEYU41NFovSmhqZ3pKUWozRmMxOXdoMGNEUTcz?=
 =?utf-8?B?dUt6ektRNE9sZU9WTUw3bWQ5TDBlZFBxVW9yNXBHSHFldTlhcXZXcHRjbWVh?=
 =?utf-8?B?bjN2VzRncHBzLzZHVjdsVDdiNlludnBxenlYanpmc040WDZVNEF1QWJvS2ZH?=
 =?utf-8?B?NnlTMWs1WWI3bE5iTXhzNlZSem9wWTl0TnJvSDVzTks5UjlHQ1g3WjVGa1JD?=
 =?utf-8?B?OUJ1dGRldm0zL3VGdVB6bnNSY3ZKYUZiQkFndFd4OGxNTWdUaWlMWncyeWVn?=
 =?utf-8?B?SXZGNU9OQkJwWDBNbmplK2RNOEc4d2M1QUlGOUExSEVoODV2STlOUVlNcGM4?=
 =?utf-8?B?QnlIZXZJOU01MzJJK1lNcldubFo5d3ZUQUFYYlpTTFBRc25sUjJ3VkxQRWJG?=
 =?utf-8?B?ekFOMGpiUXNHTG5hbHhEVXgrMEN3RzRBUFlFZTNMS2t1Vk8zTnJIdEkyaVU2?=
 =?utf-8?B?SDhVMy9ra0MwYXdWaVJlNU83UG1yUElFTVkvTjVwbmdjM0FaR2N5MkVyYUNi?=
 =?utf-8?B?czdRZTlJZGErc0RLZ2xCS3g3Y1RVWXlQTGRRZ2ZhQSswU0llU2lFNXdOdWZM?=
 =?utf-8?B?ZHFCKzcvSEU2TmFYNGtTUWF1VTR4eG8rcUhnWU1KT0JhQXluRk05Q3JwZHJ1?=
 =?utf-8?B?R29sTEVNRWdsbjFmSnJTendqOExrM0RKenNpcjB2enh1d0RyaVhMcWQxclRJ?=
 =?utf-8?B?T0hGWEs3T05HcjR6OE1IVlJZT05xbUZLMWZhanR2U3ovdVJaU3hiNmx4RjlH?=
 =?utf-8?B?OXNBN0g3TE0yZXFxRWJpcG96YXNSQ005dHpBRkRkMkp5UGw3UlNFRlUyazZQ?=
 =?utf-8?B?alY2Z2xmSDIweTBFOUpkalVuditsUGtjbzhlQVVHdlNPNVBTT3R3eDFxNUxS?=
 =?utf-8?B?RDAranR4UDRRSnIxOTJxUUhaNU9TY1YrQVI1VThwajBEdzNXTFhJVXVObWJu?=
 =?utf-8?B?Q0llSEFZNHErQUVUejBtamVEVTRBZHhXOUZUVjVuK3h4N1ZmZENJd2pkbFc2?=
 =?utf-8?B?cS85VTluVHRYYXZZV0FGb0NxTElGbDR5MVg4amUveU5yMFEzbVM4aVFVZUVB?=
 =?utf-8?B?YlR1R3RZMy9tOHZLRWh4Z0hmY0M2cjEvL01zeHdNeTM0eVA4UzNGdUdad3hk?=
 =?utf-8?B?VlF6MmJuN01waURxNVhsWFJHckNYM1R1VTFmbkZCWTdjZkM1TC9wNENkb0lY?=
 =?utf-8?Q?2+OZyf0s1xW339BCbNmx/fE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE6006F72B97A64497B8D3A8ACD49FCF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0002dd4f-d4e0-443b-5471-08daeee440ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 06:15:33.5193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZ/JP5ABISllttysJfB/7ma/9zfIq6QxWXrtYHwnr15p5K9BnMb1sdwQq/7U2IrZvPFYzHXSMq29YNQw5Wt0y1cLU4NoYz45Krl9laIsjAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6699
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2ZSwNCg0KT24gVHVlLCAyMDIzLTAxLTAzIGF0IDExOjM3IC0wNjAwLCBEYXZlIENoaWx1
ayB3cm90ZToNCj4gT24gVGh1LCBEZWMgMSwgMjAyMiBhdCA1OjMzIEFNIENvZWxobywgTHVjaWFu
byA8bHVjaWFuby5jb2VsaG9AaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIDIw
MjItMTItMDEgYXQgMTE6MTQgKzAxMDAsIFRob3JzdGVuIExlZW1odWlzIHdyb3RlOg0KPiA+ID4g
SGksIHRoaXMgaXMgeW91ciBMaW51eCBrZXJuZWwgcmVncmVzc2lvbiB0cmFja2VyLg0KPiA+ID4g
DQo+ID4gPiBMdWNhLCBJIG5vdGljZWQgYSByZWdyZXNzaW9uIHJlcG9ydCBpbiBidWd6aWxsYSB3
aGVyZSBJJ2QgbGlrZSB5b3VyDQo+ID4gPiBhZHZpY2Ugb24uIFRvIHF1b3RlIGh0dHBzOi8vYnVn
emlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE2NzUzDQo+ID4gDQo+ID4gSGkgVGhv
cnN0ZW4gd2VhcmluZy10aGUtcmVncmVzc2lvbi1oYXQsIPCfmYINCj4gPiANCj4gPiBJJ20gbm90
IHRoZSBtYWludGFpbmVyIG9mIGl3bHdpZmkgYW55bW9yZSwgc28gSSdtIGFkZGluZyB0aGUgbmV3
DQo+ID4gbWFpbnRhaW5lciBoZXJlLCBHcmVnb3J5IEdyZWVubWFuLg0KPiA+IA0KPiA+IEdyZWdv
cnksIGNhbiB5b3UgdGFrZSBhIGxvb2s/DQo+ID4gDQo+IA0KPiBAR3JlZ29yeSBHcmVlbm1hbiBh
cyBJJ20gc3VyZSB0aGlzIGdvdCBidXJpZWQgb3ZlciB0aGUgaG9saWRheXMsIGNhbg0KPiB5b3Ug
dGFrZSBhIGxvb2sgYXQgdGhpcyBhbmQgYWR2aXNlP8KgIFRoaXMgaXMgZGVmaW5pdGVseSBhIHJl
Z3Jlc3Npb24sDQo+IGJ1dCBJIGRvbid0IHRoaW5rIGEgbG90IG9mIHBlb3BsZSBhcmUgbm90aWNp
bmcgaXQgb3IgZG9uJ3QgeWV0IGhhdmUNCj4gNmdoeiBhY2Nlc3MgcG9pbnRzLsKgIEkgY2FuIHdy
aXRlIHVwIGEgcGF0Y2ggcmVtb3ZpbmcgdGhlIG9mZmVuZGluZw0KPiBjb21taXQgKDY5OGIxNjZl
ZCksIG9yIEkgY2FuIGFkZCBhbiBpd2x3aWZpIG9wdGlvbiB0byBpZ25vcmUgdGhlIDZlDQo+IEFD
UEkgYml0LsKgIFdoaWNoIHdvdWxkIHlvdSBwcmVmZXI/DQo+IA0KPiBEZWxsIGhhcyBiZWVuIG9m
IGxpdHRsZSBoZWxwIHdoaWNoIEkgcHJldHR5IG11Y2ggZXhwZWN0ZWQuDQo+IA0KSSdsbCB0cnkg
dG8gZXhwbGFpbiwgdGhlIHByb2JsZW0gaGVyZSBpcyBub3QgdGVjaG5pY2FsLiBBZnRlciBzb21l
DQppbnRlcm5hbCBjaGVja3MsIGl0IGFwcGVhcnMgdGhhdCB3ZSAod2lmaSBkcml2ZXIpIGFyZW4n
dCBhbGxvd2VkIHRvDQpkZWNpZGUgaWYgNkUgc2hvdWxkIGJlIGVuYWJsZWQgb3Igbm90LiBCZWNh
dXNlIG9mIHRoZSBsZWdhbCByZXN0cmljdGlvbnMsDQpPRU0gc2hvdWxkIG1ha2UgdGhpcyBkZWNp
c2lvbiBhbmQgZW5hYmxlL2Rpc2FibGUgNkUgaW4gdGhlIEJJT1MuIFRoaXMNCmNvbW1pdCBvbmx5
IGdldHMgdGhlIHZhbHVlIGZyb20gdGhlIEJJT1MgYW5kIGNvbmZpZ3VyZXMgdGhlIGZpcm13YXJl
DQphY2NvcmRpbmdseS4gU28sIHVuZm9ydHVuYXRlbHksIGxlZ2FsIHJlc3RyaWN0aW9uIGlzIHRo
ZSByZWFzb24gd2UgY2Fubm90DQpyZXZlcnQvb3ZlcndyaXRlIDZFIGVuYWJsZW1lbnQuLi4NCg0K
PiBATHVjaWFubywgYXMgeW91IHdlcmUgdGhlIGF1dGhvciBvZiB0aGUgb3JpZ2luYWwgY2hhbmdl
LCBhbmQgSSdtIG5vdA0KPiBmYW1pbGlhciBlbm91Z2ggd2l0aCBBQ1BJLCBpcyB0aGUgYmVsb3cg
Y29kZSByZWFkaW5nIHRoZSBlbmFibGUgYml0cw0KPiBmcm9tIHRoZSBCSU9TIEFDUEkgdGFibGUg
b3IgaXMgdGhpcyBzb21laG93IGNvbWluZyBvdXQgb2YgdGhlIG5ldHdvcmsNCj4gY2FyZCB0aHJv
dWdoIHNvbWUgVUVGSSBleHRlbnNpb25zP8KgIEknbSB0cnlpbmcgdG8gZmlndXJlIG91dCB3aGlj
aCBvZg0KPiBEZWxsIG9yIEludGVsIG5lZWQgdG8gdXBkYXRlIHRoZWlyIGZpcm13YXJlP8KgIEkg
dGhpbmsgc29tZSBMZW5vdm8ncw0KPiBoYXZlIHNpbWlsYXIgcHJvYmxlbXMsIHNvIEkgc3VzcGVj
dCBpdCdzIGEgQklPUyBBQ1BJIHRhYmxlIHByb2JsZW0uDQo+IA0KPiDCoHJldCA9IGl3bF9hY3Bp
X2dldF9kc21fdTMyKG12bS0+ZndydC5kZXYsIDAsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERTTV9GVU5DX0VO
QUJMRV82RSwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJml3bF9ndWlkLCAmdmFsdWUpOw0KDQpJdCBjb21lcyBm
cm9tIHRoZSBCSU9TIEFDUEkgdGFibGUuDQoNCj4gDQo+IFRoYW5rcywNCj4gRGF2ZS4NCg0K
