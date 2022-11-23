Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7047A6361F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiKWOhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiKWOhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:37:34 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE2CC3E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669214247; x=1700750247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2fVK+rRfcSecpt+14t7OQ8I/DI03jqEj5mumkuxNgzA=;
  b=JL0oxbn+gPPA9lpBsI8yEwJWEckEbznpCKBVGvdV1PcEhmoN1tPu6jMw
   Pd+SFv6BF5/0m1hYzOxTJ4BGJTUbyyUdO0b2AoqJs0ea05maZxzESRgPb
   PGvlRPs5UZ/diRQI6+GXoV8jMJOe5PR5MUl71z/2hDTygmfuCjp8jmDek
   FMD64sS3yhqR+wHx40VZ6THusL32i97om/CQYgNj9uFXMXtBmiEfWSVfQ
   PTAAwtZ99XKMA3COm3YGv7gvqFq4bfMPuGi83vkQ0Xnq/Ml2kffsv26Qc
   DYHN69MqthPJQYLHi8hrv+JWdoZ5MB0B7xE10f4w99XklXxYtcPqzbvCf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="297437697"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="297437697"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 06:37:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="970880393"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="970880393"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 23 Nov 2022 06:37:26 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 06:37:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 06:37:26 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 06:37:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPSuXRN7Wcd3jqo9VglyV2xx0ofe224d1wfV5fv1iVCBzmKY9iK3j5V//wmGDM276VweWM2TTY+rx8KM0ONV24OV2rJIDdtGpaFi2R/b4vOzquTQUzQm8nBGyC4IYs6aZ2CCDn81sHhP5A7hZyiqtmSTXIa4dpuW/CkhXBatDIZ7+FOaUKe0XLni1amjFnvq+5Te3/vb54p7F3FoYRWXP95QdvmFDKHZWmgq/gJMI4dUyb6qJs0sPg4aQOm7W3Zu2oO55ilx79f79ot9jiTD1fwXpmXWS3VbIh77QDonX5CvIgSta65tx1Kwm1LWBCB5ZWUdxDZ9E8EJJyIAH4Sl0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fVK+rRfcSecpt+14t7OQ8I/DI03jqEj5mumkuxNgzA=;
 b=krCCm96SD+HLOJe9ubCIzppeEliKxsWnCj1yMqlJ+Z69Syoa/yRfp/LZ2Xf9Hpkds+oiHOB98SLtABCT/qh6YdLvvngj2UdUxnpLXrVkHp8MZgaXZWG0H5iYL3CkLlQXGqy6FN9nOR1cyLCNDN3iPQv8NL2NFbMD95+XKcNWL3huN1aJ8mDBtk3z1cxxVSIyRLLBYvO0eUup09/o1AtUxIqI2xe1ItDVA+22tWKKeGTiA68HK8D1NWA00LaCponRugumtMfT+NfidAvEPGu5J87KIVKaFfCNStpmP+hLmJbOR9kAEStvz1zwsZj+BBmQISV678cfDydgqMSviiu+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3240.namprd11.prod.outlook.com (2603:10b6:a03:18::19)
 by MW3PR11MB4732.namprd11.prod.outlook.com (2603:10b6:303:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 14:37:23 +0000
Received: from BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::4bae:9f39:e66:96cf]) by BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::4bae:9f39:e66:96cf%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 14:37:23 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Dipen Patel <dipenp@nvidia.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "timestamp@lists.linux.dev" <timestamp@lists.linux.dev>
Subject: RE: Intel timed i/o driver in HTE
Thread-Topic: Intel timed i/o driver in HTE
Thread-Index: Adj6qih2Gsi7knz7SkKtEKSdboc8IwBFScgAAOFR9zA=
Date:   Wed, 23 Nov 2022 14:37:22 +0000
Message-ID: <BYAPR11MB32405F4FA22BB47BD03C8F18E10C9@BYAPR11MB3240.namprd11.prod.outlook.com>
References: <BYAPR11MB3240F382BD180FF90C7DF0B9E1069@BYAPR11MB3240.namprd11.prod.outlook.com>
 <7de35859-97ab-8e88-f590-d5851b81773b@nvidia.com>
In-Reply-To: <7de35859-97ab-8e88-f590-d5851b81773b@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3240:EE_|MW3PR11MB4732:EE_
x-ms-office365-filtering-correlation-id: 106ac658-91fc-4f74-77da-08dacd603bca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: etjTrR3vd+Du2cokhXDl2vggmwrk5Qha1LOxdvrkU1rSOU1ga2XDyPid7mj0WaUDL9uTjKTijOgHITko36Se0wEOJWLE77A11Jj+L7dhm+nwhZ1l2AJRVHepKk9rmAtrkwcqMEaiqLKAwRpXbTQ4OGaHTEyr1kUK/jrFXebmQ+RpCmexkffkWHXkrdKSBa42X6dg/DK0hTu8SW+gkR5rppJjWzJKdhCeKps25QXkU9gofwNd/38VYZv6cer2OUKCufob5Ov+t9aDFEtzFuFIZglInDUt+dROwtg0vXIphld3t5UAWiT2dAPK9qDXBL3aniDRvU8JYFru5k/Zm7s+E0oT3gVQAOdVanyDXZJEuo/3QyQ+2HGaOT21Khy2rhl6jMhwGNuqvH6f2Ypvho/Xjxc1W7EfkI4KKrA4ju/+uQ7Hz/tpWepYPJ+rKBu5Ir8Ubd4x83voIwaoSjeffskSpozuIAeB3rfjuVujlbmcXfDugccDSnU2d4icvbgAixBTEZMjSLs6GX3klcJ4neAyQ/Rswvj+CzMmtiMhfUVm/qK8x99+QcBjdPmXVkEbhL4AtxO0wjfGd7AWUMHDWDDZV0coa1Rj3EA0t7M7qMsz89AiVath9pxp6baMX+rvgTsWtbrCgRNU7nFT5Yn0hGm7VjyY2f2Uc8K+PGBtdyF1Cr5GtJF03rftAjmrKOVts86fputL8Dbhrh3R/ZRprz/2Sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199015)(33656002)(122000001)(82960400001)(38070700005)(86362001)(38100700002)(66476007)(186003)(316002)(54906003)(26005)(66556008)(9686003)(478600001)(53546011)(71200400001)(66946007)(4326008)(64756008)(8676002)(66446008)(7696005)(76116006)(41300700001)(110136005)(6506007)(52536014)(83380400001)(8936002)(2906002)(5660300002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0lLT2crNXlXbzYrMHZ5M3VxNHBWNkFlbDZNZ3cxRXh6WU5tTlBNZ1NVOFpx?=
 =?utf-8?B?NktUOUNSa1NCR2VZUlZMcVBXTTBGdDc0SnY5TmREbm54UjUxYkZOUklNanJx?=
 =?utf-8?B?TFpDNzNpaGdzYTdNbkU0T2duQzVyQ0Zxci9NVG9YYXpsVllXUXovR3hUT0Qw?=
 =?utf-8?B?NTdtMEVSVnRGZFY5YTdpU3lFQjNGcG9wMkloVGliUzhOclU5SXRpOG1Qd0Js?=
 =?utf-8?B?U0ozYVpwUURob1c0QlcwUjNybDVZbFZIbVlWeVM0bS9UMjFSaWVtM2p5OUUx?=
 =?utf-8?B?aFM2TlE3ckh1bWVkZ2w1c0F3MCtoeHFnaGN0RUlMdHVoaUR4S253aSs1bXA1?=
 =?utf-8?B?N0lqeSs5cDFKY2hJZG9DRHE1NUI3YWpXaTk0TGNsVDRPbTIyVkpFOG5xdk5Z?=
 =?utf-8?B?cVg4d0FkMkFKNGJTcytudEpFRVVsZHBZbGczTTV4cS9XTm1TR3FkMUJJS0tR?=
 =?utf-8?B?S3dLMGM0NEFXNVN3WmhLNzRybHJLMUVRa1dKTzJEb2dRWHhFOGVhK2FZQytO?=
 =?utf-8?B?VEh1ZWhpa2xZaUFMeDhvM0RkbDlQbWNzcDVURkdhVkV4YkNUWGkyMWg5RjBS?=
 =?utf-8?B?YXBMenBHRjNuWWl4a2ZqdHpDNEF6c1lCMG9sMnBuUlFVNzZFTzY0c0RWV2FM?=
 =?utf-8?B?Z0Zmemx1a1QvV2FNcmZiWVpNdnRlSW5DQjdFK0pZM1E5ZjNKZVdDSERBY2JN?=
 =?utf-8?B?Wi9EWmRqNmFST2xZa2pzclVsRlY1YVZsRlFIRkxoaS9odTZ0Z3RnU1locENq?=
 =?utf-8?B?Z2daUnYyeERvYzA4WDdIOXA2RmZjTXo3MUFZRmpET0JkVzMyeE5xL3VxcEpB?=
 =?utf-8?B?cjBaOGF4ay8wRktlUlJKQ1NGRVduWDZUTU0zVEhzNFNkektGcnVKRXRSMG8x?=
 =?utf-8?B?SjY5RUovbjg1RSs1ZVQrMUd1ckR4MjE2WW1WVVFoUk9RcW9aTVBpemtaZnBm?=
 =?utf-8?B?T2E2RHhQY1Fjajd1cHRtKzhRbWUvbkUwNVl4cXBrdXdySGVid2dXbGU3YS9F?=
 =?utf-8?B?NjVXb1NaditGRjVqNzRjYXJEd1ovbFpSS1Q4QjdEazEySGV6UWxWOFUrd0N1?=
 =?utf-8?B?ak9qSkNLa3owcnY2T2FQVnJOKzBRbTJwYzQrem9QYzZzc3BFaERNc0NBM3pp?=
 =?utf-8?B?SlVIejJWVis2TmI0b1Q4eFlxQ3BDOHJvYVoyN1cxQ2loR3M1bDRwcEVDK0hn?=
 =?utf-8?B?cmQzbTc4RVNONkc5UTZJZXNvaFRCdERWcytpY2JQejNFQm1uMkY0RWp3QTJI?=
 =?utf-8?B?bXl5aFFub0luYmd5SktXWTFDd3I0TWJaNlFLZGhRRkZ6RTFBZWE2NDFvYWd1?=
 =?utf-8?B?R3pzSnZyaXFXTVl1SHJsaHdGYTlDeHVWODVVQkVIS0lRY1pudDNBUWJXb0R3?=
 =?utf-8?B?R2VXYVdKUkRnbEZOVWxzbXF6LzFWZFBGbERWbzJ3amR5azBzWVZkRkZoUTRq?=
 =?utf-8?B?TXpoZitLNzNMZm9WSCt0OUluL1k3YVB4WmdsSkpOcFZPWnJpZTBJcC82UTRa?=
 =?utf-8?B?eU16b3FvY0NNeHpDY0JkUzNoUllPY0NsSDNtRTFoKzFuaTh1Wm5yMkRJdUlG?=
 =?utf-8?B?ZTgvbVlJck54MlYzM3dSYmpiM01xUHkxWkhlMThYWHk1VG9MNFlPNDRJRXNq?=
 =?utf-8?B?aDBrNk0vSGV4NGwwcDVsblB0dmpZNVRKYk9IbWg0R0ZqczlmTHpZdGhCbWtM?=
 =?utf-8?B?K3dHaEU3VDYwZ2tIQ0ZPMmdzNjlFb2Qyd1dNRnA1S1cwVlpDc1ZXWWpudU5L?=
 =?utf-8?B?V0g1bm1GcDduWFdORWNuQmRpOWhZb1cyTEoyMUtzaDlobnRkWVkrd2lWMFlv?=
 =?utf-8?B?WTZaSzg0Zk1adEhTcVdIZVdtWXFlL1ppaThoc2hDQVZBWXYrV3YybnBJUXJr?=
 =?utf-8?B?RFNaQ2tyUnFUN3RwL1ZVNy91NWtoL0F4cmRua1htbGIwenQvazZmcTExK1A1?=
 =?utf-8?B?SXpYZE1qdnhhajc2MFJPaFF4bEVoQW56aXZBTlIvWmxNU0xLWEFaL1NrR09s?=
 =?utf-8?B?Vnd0Z2dSbFdoWjV3eHdDYjZLemZ1cmtMeWtnWjdBYkwwSHBIVGx4L3BKVFJo?=
 =?utf-8?B?aVYxc3F5b3pZTjk5c2RFMzhPRDhlOXEyZ29pYnY0RnVBRVVESEoveVBaNGI2?=
 =?utf-8?Q?fBBayH59M6j8L5dAVfnVXrvDB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106ac658-91fc-4f74-77da-08dacd603bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 14:37:22.9400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufR6J2Twlgaonmcbc16ZSvhVtnWlxgplth7J7V4zhp4lBg3Yt0qEKtqWr1uxEqsjHiy9IYZE2fJ4kcPcN1XcAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4732
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERpcGVuIFBhdGVsIDxkaXBl
bnBAbnZpZGlhLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIE5vdmVtYmVyIDE5LCAyMDIyIDg6MDQg
QU0NCj4gVG86IE4sIFBhbmRpdGggPHBhbmRpdGgubkBpbnRlbC5jb20+OyBsaW51cy53YWxsZWlq
QGxpbmFyby5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEhhbGwsIENo
cmlzdG9waGVyIFMNCj4gPGNocmlzdG9waGVyLnMuaGFsbEBpbnRlbC5jb20+OyBHcm9zcywgTWFy
ayA8bWFyay5ncm9zc0BpbnRlbC5jb20+Ow0KPiBTYW5nYW5uYXZhciwgTWFsbGlrYXJqdW5hcHBh
IDxtYWxsaWthcmp1bmFwcGEuc2FuZ2FubmF2YXJAaW50ZWwuY29tPjsNCj4gRCwgTGFrc2htaSBT
b3dqYW55YSA8bGFrc2htaS5zb3dqYW55YS5kQGludGVsLmNvbT47IFQgUiwgVGhlamVzaCBSZWRk
eQ0KPiA8dGhlamVzaC5yZWRkeS50LnJAaW50ZWwuY29tPjsgYW5kcml5LnNoZXZjaGVua29AbGlu
dXguaW50ZWwuY29tOw0KPiB0aW1lc3RhbXBAbGlzdHMubGludXguZGV2OyBkaXBlbnBAbnZpZGlh
LmNvbQ0KPiBTdWJqZWN0OiBSZTogSW50ZWwgdGltZWQgaS9vIGRyaXZlciBpbiBIVEUNCj4gDQo+
IE9uIDExLzE3LzIyIDEwOjQ3IEFNLCBOLCBQYW5kaXRoIHdyb3RlOg0KPiA+IEhpIERpcGVuLA0K
PiA+DQo+ID4gVG8gc3VwcG9ydCBJbnRlbCB0aW1lZCBpL28gZHJpdmVyLCBpdCB3YXMgc3VnZ2Vz
dGVkIGJ5IExpbnV4IGNvbW11bml0eSB0bw0KPiBlbmhhbmNlIGh0ZSBmcmFtZXdvcmsuDQo+ID4g
SG93ZXZlciwgd2Ugc2VlIHNvbWUgbGltaXRhdGlvbnMgdG8gc3VwcG9ydCBjb21wbGV0ZSBJbnRl
bCB0aW1lZCBpL28NCj4gZGV2aWNlLg0KPiA+DQo+ID4gMS4gVGhlIGN1cnJlbnQgZnJhbWV3b3Jr
IHN1cHBvcnRzIE52aWRpYSBJUCwgd2hpY2ggaGFzIHR3byBJUCBibG9ja3MNCj4gPiAoaHcgdGlt
ZXN0YW1waW5nIGVuZ2luZSBpbnRlcmZhY2VkIHdpdGggR1BJTykgSW50ZWwgdGltZWQgaS9vIGlz
IGEgc2luZ2xlIElQDQo+IGJsb2NrIGhhbmRsaW5nIG11bHRpcGxlIGZ1bmN0aW9uYWxpdGllcyBs
aWtlOg0KPiA+DQo+ID4gCWEuIElucHV0IHRpbWVzdGFtcGluZyB3aXRoIGV2ZW50IGNvdW50ZXIu
DQo+ID4gCWIuIFRpbWVkIG91dHB1dCAgLSBzaW5nbGUgc2hvdCBvciBwZXJpb2RpYyBwdWxzZSB0
cmFpbi4NCj4gPiAJVXNlcyBUU0MoVGltZXN0YW1wIGNvdW50ZXIpIGZvciB0aW1lc3RhbXAgb3Ig
Z2VuZXJhdGUgZXZlbnRzLA0KPiB3aGljaCBjb3VsZCBiZSB0cmFuc2xhdGVkIHRvIHN5c3RlbSB0
aW1lLg0KPiA+IAljLiBJbXBsZW1lbnQgUFBTIGZ1bmN0aW9uYWxpdHkgdG8gZXhwb3J0IHRpbWUu
DQo+IElzbid0IDFjIHNpbWlsYXIgdG8gMWIsIHdoZXJlIElPIChtb3N0bHkgR1BJTykgaXMgcHJv
Z3JhbW1lZCB0bw0KPiB0b2dnbGUvcGVyaW9kaWMgcHVsc2UgdHJhaW4gYXQgMXMuDQo+ID4NClll
cywgRnVuY3Rpb25hbGx5IHRoZXkgYXJlIHF1aXRlIHNpbWlsYXIuIDFjIGlzIHJlbGF0aXZlbHkg
c2xvdyB3aGVyZSBlYWNoIGV2ZW50IGlzIHNjaGVkdWxlZCBieSB0aGUgZHJpdmVyIHRvIGJlIGFs
aWduZWQgdGhlIHN5c3RlbSBjbG9jay4NCjFiIGlzIHJlbGF0aXZlbHkgZmFzdCAoaW4gcGVyaW9k
aWMgbW9kZSkuIHdlIGFyZSBjaGVja2luZyB0byBzdXBwb3J0IHRoaXMgaXMgaW4gYSBzaW5nbGUg
aW50ZXJmYWNlLg0KDQo+ID4gVGhpcyByZXF1aXJlcyBuZXcgZnVuY3Rpb25hbGl0eShpbnRlcmZh
Y2UpIHRvIGJlIGRldmVsb3BlZCBpbiBodGUNCj4gZnJhbWV3b3JrIHNwZWNpZmljIHRvIHRpbWVk
LWlvIGRldmljZS4NCj4gSSBjYW4gc2VlIDFhIGlzIHN0cmFpZ2h0IGNhc2UgZm9yIHRoZSBIVEUu
DQpZZXMsIGN1cnJlbnQgaW50ZXJmYWNlcyBjYW4gc3VwcG9ydCBpbnB1dCBtb2RlLiBTaW5jZSBm
ZXcgSW50ZWwgdGltZWQgaS9vIGRldmljZXMgZG8gbm90IGhhdmUgaW50ZXJydXB0IHN1cHBvcnQu
DQpUaGVyZSBpcyBhIG5lZWQgdG8gZW5oYW5jZSBjdXJyZW50IGZyYW1ld29yaywgdG8gc3VwcG9y
dCBwb2xsaW5nIG1vZGUuDQo+IA0KPiBGb3IgMWIsIHRoZSB0aW1lc3RhbXAgcGFydCBjYW4gYmUg
YWRkZWQgYXMgaHRlIHByb3ZpZGVyLiBJIHNlZSBvcHBvcnR1bml0eQ0KPiB0byBlbmhhbmNlIGh0
ZSBmcmFtZXdvcmsgdG8gcHJvdmlkZSB0cmFuc2xhdGlvbiBmYWNpbGl0eSBiZXR3ZWVuIHRoZQ0K
PiBkb21haW4sIHN5c3RlbSB0aW1lIGluIHRoaXMgY2FzZS4gSG93ZXZlciBwcm9ncmFtbWluZyBp
bnRlcmZhY2UgdG8NCj4gZmFjaWxpdGF0ZSB0aW1lZCBJTyBvdXRwdXQgY2FuIG5vdCBmaXQgaW50
byBIVEUgdGhlIHdheSBpdCBpcyByaWdodCBub3cuIE1heSBiZQ0KPiBvbmUgcG9zc2libGUgd2F5
IGlzIHRvIGVuY2hhbmNlIEhURSB3aXRoIEFQSSBzb21ldGhpbmcgbGlrZQ0KPiBodGVfY29uZmln
dXJlX3RpbWVzdGFtcF9wZXJpb2RpYy90aW1lZCBjb3VsZCBiZSBwb3NzaWJsZSBpbiB3aGljaCBj
YXNlDQo+IEhURSBkb2VzIHNvbWV0aGluZyBtb3JlIHRoYW4ganVzdCB0aW1lc3RhbXBpbmcgdGhl
IGV2ZW50Lg0KVGhpcyBpcyB0aGUgcG9zc2liaWxpdHkgd2Ugd2FudGVkIHRvIGNoZWNrLCB0byBh
Y2NvbW1vZGF0ZSBkaWZmZXJlbnQgb3V0cHV0IG1vZGVzLg0KU29tZXRoaW5nIGxpa2UgaHRlX2Nv
bmZpZ3VyZV90aW1lc3RhbXAgb3IgaHRlX3JlcXVlc3RfcHVsc2UuDQo+IA0KPiBJIGhhdmUgdG8g
c2VlIGhvdyBpbiBHUElPIGNhc2UgdGhhdCBwcm9wb3NlZCBBUEkgd29ya3Mgb3V0LCBpZiBpdCB3
aWxsIGJ5cGFzcw0KPiBncGlvIGZyYW1ld29yayBldGMuLi4NCj4gDQo+IEFkZGluZyBMaW51cyBX
IGludG8gdGhlIGRpc2N1c3Npb24uLi4uDQo+IA0KPiA+DQo+ID4gMi4gVGhlIGN1cnJlbnQgaHRl
IGZyYW1ld29yayBoYXMgYSBwcm92aWRlciBhbmQgY29uc3VtZXIgY29uY2VwdC4NCj4gPiBDb25z
dW1lciBpcyByZXNwb25zaWJsZSBmb3IgdXNlciBzcGFjZSBpbnRlcmFjdGlvbi4NCj4gPiBDdXJy
ZW50bHkgTnZpZGlhIGlzIHVzaW5nIEdQSU8gZm9yIGlucHV0IHRpbWVzdGFtcGluZyAgKGJ5IGFk
ZGluZyBodw0KPiA+IHRpbWVzdGFtcHMgaW4gZ3Bpb2xpYi1jZGV2LmMpDQo+ID4NCj4gPiBGb3Ig
SW50ZWwgdGltZWQgaS9vIGZ1bmN0aW9uYWxpdGllcywgY3VycmVudCBncGlvIHVzZXIgaW50ZXJm
YWNlcw0KPiA+IGNhbm5vdCBzdXBwb3J0IGV2ZW50IGNvdW50ZXIgb3Igb3V0cHV0IG1vZGVzLg0K
PiBDYW4geW91IGVsYWJvcmF0ZSBvbiBldmVudCBjb3VudGVyIGFuZCBvdXRwdXQgbW9kZT8NCklu
IDFhLCBldmVudCBjb3VudGVyIGhvbGRzIHRoZSBpbnB1dCB0cmlnZ2VyIGNvdW50IG9uIGNvbmZp
Z3VyZWQgcGluLg0KT3V0cHV0IG1vZGUgaXMgY2FzZSAxYiBhbmQgMWMuDQo+IA0KPiA+IFJhdGhl
ciB0aGFuIGppZ2dpbmcgaHRlIGNvbnN1bWVyIGludG8gb3RoZXIgc3Vic3lzdGVtcyB0byBzdXBw
b3J0IHRpbWVkDQo+IGkvbyBkZXZpY2UuDQo+ID4gQW55IHBvc3NpYmlsaXR5IG9mIGRldmVsb3Bp
bmcgYSBuYXRpdmUgY29uc3VtZXIgaW4gaHRlIHN1YnN5c3RlbSwgd2hpY2gNCj4gY291bGQgaGFu
ZGxlIHVzZXIgc3BhY2UgaW50ZXJhY3Rpb25zIGZvciB0aW1lc3RhbXBpbmcgZW5naW5lcy4NCj4g
eWVzLCBmZWVsIGZyZWUgdG8gc2VuZCBwYXRjaGVzIHRvIG1lIGFuZCBjYyB0aW1lc3RhbXBAbGlz
dHMubGludXguZGV2LCBJDQo+IGd1ZXNzIHlvdSBjYW4gcmVnaXN0ZXIgeW91ciBJUCBhcyBvbmUg
b2YgdGhlIHByb3ZpZGVyLg0KPiANClRoaXMgbmF0aXZlIGh0ZSBjb25zdW1lciBpcyBhbHNvIGlu
dGVuZGVkIHRvIGhhbmRsZSBpb2N0bCBiYXNlZCB1c2VyIHNwYWNlIGludGVyYWN0aW9uLg0KVXNl
IHRoZSBzZXJ2aWNlcyBvZiBlbmhhbmNlZCBodGUgcHJvdmlkZXIgKHdpdGggYSBuZXcgY2hhciBk
ZXZpY2UgdHlwZSBjcmVhdGlvbikuDQoNCj4gVG8gZXhwbGFpbiB3aHkgR1BJTyB3YXMgdHJlYXRl
ZCBzcGVjaWFsbHksIHRoZXJlIHdhcyBhbHJlYWR5IGEgdXNlciBmYWNpbmcNCj4gZnJhbWV3b3Jr
IGksZSBncGlvLWNkZXYgYW5kIHJhbmdlIG9mIHVzZXJzcGFjZSB0b29scyB3aGljaCBjb3VsZCBi
ZQ0KPiBsZXZlcmFnZWQgZm9yIHRoZSBIVEUgR1BJTyBjb25zdW1lcnMuIEhvd2V2ZXIgdGhpcyBk
b2VzIG5vdCBwcmV2ZW50DQo+IGtlcm5lbCBzcGFjZSBHUElPIEhURSBjb25zdW1lciBmcm9tIHVz
aW5nIEhURSBjb3JlIGRpcmVjdGx5Lg0KPiANClNpbmNlIHRoZSBjdXJyZW50IGdwaW8gZnJhbWV3
b3JrIGlzIGluYWRlcXVhdGUgdG8gcGVyaW9kaWMgb3V0cHV0IG1vZGVzLg0KSSB0aG91Z2h0IHRv
IGRpc2VudGFuZ2xlIGZyb20gZ3BpbyBhbmQgZGV2ZWxvcCBhIG5ldyBodGUgY29uc3VtZXIuIFNv
bWV0aGluZyBsaWtlIGh0ZS1saWJjZGV2LmMgIA0KDQo+ID4NCj4gPiBJIGNhbm5vdCB0aGluayBv
ZiBhbiBleGlzdGluZyBzdWJzeXN0ZW0gdGhhdCBoYW5kbGVzIEludGVsIHRpbWVkIGkvbw0KPiBm
dW5jdGlvbmFsaXRpZXMgMWEsIDFiIGFuZCAxYyAobWVudGlvbmVkIGFib3ZlKS4NCj4gPg0KPiA+
IFJlZ2FyZHMsDQo+ID4gUGFuZGl0aA0KPiA+DQo+ID4NCj4gPg0KPiA+DQo+IEJlc3QgUmVnYXJk
cywNCj4gRGlwZW4gUGF0ZWwNCg==
