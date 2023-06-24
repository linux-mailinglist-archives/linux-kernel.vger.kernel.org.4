Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3479673C69A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 05:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjFXDme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 23:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjFXDma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 23:42:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB40D26A0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 20:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687578146; x=1719114146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pNtbgArw7X89YC3rFVoGfF0Hs43uc8z01aU3rIeSyQA=;
  b=nxeXM8vZpzxQvYCkUYxYmPqoJY1BW7YouyankKneZ6XqQ0r4vgBLekg6
   d6NHUS+zLbImRmUmYRC0r/+TEl7EkVb2fOge2Ht3GRFmvoYqLG3TOt61H
   atjF3w544PhsfYB/1MlaqZKyzE6QSW1y5HwWuPsIWkmb+8fGPP4jMDYZJ
   +/DCv4CF4k80SCzJ4MLXRToOY1XdCdkiuudi0F+ez7JC7ldAYugVQbBca
   nylgI3y0b97ALEuw+eEEh1kxyGFxWvacFdYqmRedwTLe+5oNQa8vp6Hv2
   1gi70GIWqeUJAnwEMrgl+22ZXcYUFNdPCGBimq0ZGCquLUtZbcxPtxx63
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="360942364"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="360942364"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 20:42:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="665703143"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="665703143"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 23 Jun 2023 20:42:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 20:42:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 20:42:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 20:42:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ns4lAlSkOhaXt5cCr/BFhLrpn0SuacTkI3yXrvHVgJ22/M/XJ3dK3DV7Ag4jhsC6MHvrvNhiSm8ip0nYesahrixhtW9HXcbksf2xvZWojnP3VgHEtc6UUlPu/0l6LUJOBvIfQmo2fay49lXPTKLa9tK4FK/+9PJnG/H6MIkD3+OI9JFugLz6Cs7+/4XQ0U6kLfgG1cl5wtOYPQ854R+WNeg5GenDwjR20vbjdrQqslUcUqXgQr7UEjdlbuRJfMzVV6uUbqbuUQgSGfbJh5opr0cxllK8DVNcDT8mMjMSQTXkoYw0jmLPWc+qxP+zZDNotboe6NvEl7hJmUvBXYp1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNtbgArw7X89YC3rFVoGfF0Hs43uc8z01aU3rIeSyQA=;
 b=Y2lrlflHVk0KzrTFTiyDo4emXx/80zNmAuuljDNmRflCWvE0eCeRaPUEYokYCM9Ti2xvRV5hfo1SdSmS8FbDk8ADHoNsygdiit2OcYCU1b+jDVEMBU3BxPSqikePIWWSHVOE/xn9GGW3eW6k9LXDe7ZFDePIHXYyOiyUkI6uFt4oQE7CrmL6cQmUfkoVKt3wwIuS2OmU17dm0JrbuyuffypVocHHaKmXSdxTArRQqn9zZgJArriBQUYaoGnTtoHXVj5CJJ1y6TyfWO1Mt0pSg8nmxMxW9xnmQvBd37KHL6TK9sRcgphEF3HxaQesnlXG7Bu4Rv6IiQxY94diWScr8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by IA0PR11MB8377.namprd11.prod.outlook.com (2603:10b6:208:487::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sat, 24 Jun
 2023 03:42:22 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049%4]) with mapi id 15.20.6521.024; Sat, 24 Jun 2023
 03:42:22 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Thread-Topic: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Thread-Index: AQHZpOcz4yOfuGedVUe15UWfk8cDPK+WjIqAgAAxu4CAAAfJgIABXnCAgAAJrwCAASC+IA==
Date:   Sat, 24 Jun 2023 03:42:21 +0000
Message-ID: <PH0PR11MB567334A09B2D4A1D3DDC09F2CB20A@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <0d1b3c55-4b11-9e63-e388-191d39d88df1@linaro.org>
 <20230622122114.592791-1-kah.jing.lee@intel.com>
 <25439c1e-c9ef-0dc6-8d91-883d7734d0fd@linaro.org>
 <PH0PR11MB5673A862187810E9986E3C8BCB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <125c849f-3746-864f-8b8f-6e0a33aca439@linaro.org>
In-Reply-To: <125c849f-3746-864f-8b8f-6e0a33aca439@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|IA0PR11MB8377:EE_
x-ms-office365-filtering-correlation-id: 7ffa0a7a-4fa9-4cfc-406e-08db74650474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ZjHwaH8Cdqy4mcnqfDrh3fatTi92LipZ7Dm87YvIS9lQLhkrNznTKRiQAqXmaqpY8ChTyrx8TlKHfpBWimGdMXbKzgN87kKnhqNE0MsVD2gWmvVBrWZesTkMBoVm9puktI04ysQirqBYrod/TgQUT3yp8utjiDQohvh2E6nhIOPJefFOvVwExg3T/11+aBc+Wwb4W0Nn/N0qhEPl2kvUYBFfACUe6HYwdL8FJ3Sqd1JaLcFNWJLasVsKLGz4O9UU3JG78zHSMMyD+UFcRHtETuP/Z4tsZ7I8pCjBl1K/3/b7RmOFIZtIQVs/2toOl88CXDrwKEK/igC/033gFF3EZgBDMT1wjL/vbIn6mXJVFhv4MIrkAcktunz/7g5ALgqmcJYrADGqqai/s0FzNXynGXYm5g3IhDbiASEJN7r7dzoE96JUvm6PG+ht87I8zq8qbB7rwmQ3l0IpkDZcfyzF7+xpAPwHg1R/XhceWaPTyNSHmX7pz830hSOyX5HlYpK0MzvVyBf+loKxsBflT9tHzBWIogMt8ZFnC7dsqj8J6fV8O9PdnTpNkOq6pVRj0yOq2QfmX8syUZbfpHi9vz9Ne2ks6cr91k6ac0J13+zzL4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(7696005)(110136005)(966005)(478600001)(9686003)(53546011)(2906002)(66446008)(71200400001)(6506007)(55236004)(186003)(26005)(64756008)(8676002)(38100700002)(76116006)(4326008)(66476007)(52536014)(41300700001)(8936002)(66946007)(66556008)(316002)(122000001)(5660300002)(86362001)(82960400001)(55016003)(38070700005)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVNtb09YQ3YvUGxobFFrSVArMVJwYkg1S2Jhd2Y1VWVkL2JTbFRFd0t1TjJ1?=
 =?utf-8?B?bkt2ZUFxLzZVeEovSDJjdjgzRjBXQk9xZ0RmQVdJdDE2NkJVdWZHMm9vNThF?=
 =?utf-8?B?OUlTT2VBOE1HVVdDdlNxZExCeHVtYjUrOUx3QTVWcHZkdDBWalc1TFBnSjg5?=
 =?utf-8?B?ejNCWGNFYjhwM3VsLzkxNmZTL1ZjMTdSME9nQlFRK2YyTjYyNm9PZnRCTDBO?=
 =?utf-8?B?RzJISTRtMXBCbE1iQXNrMWZxK01XVGk1bmM2Zll6TkEzOTNpMDdwUDJoaFNr?=
 =?utf-8?B?UWdRemJEN1puWFFwU3V2bndIcVNBZWlqbytLM1FTbjJxeU1veW1qMENqK0dw?=
 =?utf-8?B?QzVVQ3FUMGU4SVFGaisrSEI2anpyNlhxSFFhQ3lkcFZkSlRPOHAwZkJwMjJS?=
 =?utf-8?B?RTBuNDBJd3I0NnY0VUhlbSs5dXQ1THBMQjdxRHQ2TlFNTmtoVmVLODh5YytH?=
 =?utf-8?B?S2hXdDdIdkNRczFLSUxrY2RQSjRYOUlEcGJoV2FUQVAxekRiR0ZjRFA0ZUhs?=
 =?utf-8?B?Tm5VOEZvemxRQjVoWTVmVS9VdEdvYVdObWVSZkdEYjhtSEU3eWtsVjl1WnF2?=
 =?utf-8?B?UlZSRUdYNHoxcjczYzR2ZFJWWGZ0VWdNQ2srUlFQcmxreDYzYlFBMnZhLzgz?=
 =?utf-8?B?dFcraHVHU282Ym9kZC8zVWtBY1YzYmRuRElLaFpwUVVJOUZtV29aZ0hqSHNC?=
 =?utf-8?B?MHRPallzcGtCMm9IS1BIMUJKZ29GVEFLcGtDOXJ5ZjY0VkhpbUtjZk96dHlo?=
 =?utf-8?B?VjMwSFBMQkpqRTNWbktWVDZzRkdWTndYNTZESC9IQU5iUGJ1djVuaEdwWTNW?=
 =?utf-8?B?U3hlQldKeWJacDdqaTBBL3pMSmVNWEkzQXN3MUQ3cHUvSEh1K3RFYXJocms5?=
 =?utf-8?B?c05XQklDL21RNnBwYVRLbWVxTWROWkp2bWY4YldETCtqY1QzWW52WWFLYVZi?=
 =?utf-8?B?YUtGcEVPdFBtTGNXeDhnc1cydnp1Rjh3a2JNR1BrcWRwTGd0dEt4SjZQYWVL?=
 =?utf-8?B?YjdGYklqMTRScWd3dHVCc1QzTm1HZW9maWVmZ1BOdGdacHlDQzBaYThhaGd1?=
 =?utf-8?B?RENlRmpyODRUNkxURGl4R25BL2Q2QVZjVGMydlY4Tkt3K2RsblVjUkNhYTd6?=
 =?utf-8?B?dFcwRFNXOHBGazFuSXZSdWora3lPbC8wNy82VCtHaEphTlhldlBBeEZBbkVZ?=
 =?utf-8?B?WXljd25kWUdjdDIrZ2U0cmNHMjZ1cit6ZU9ubUlsdzdBSFNHM1NzQlh3ZllO?=
 =?utf-8?B?aXJmQXdqYUV5cWJyWjZoNlkrZFdCQnExUXpqdjg4N0hHc3A3MkJNOFFlckhJ?=
 =?utf-8?B?OHlRMkREU0xsWkpWR1RoKzJ0OGFlMGlHOER5blF2Q3liZWh6NndZbW5RSGtX?=
 =?utf-8?B?clFEZTVVY0hGMC8vSkNCeDQrREpURjhkcFhSNTRGOVdRVGRuZEFGRno1cVJH?=
 =?utf-8?B?VlJCMHRZUGZFTGtHZTlKTGVlanduWThMTXFkZGJ6ZTlMVXIxQ1h3WEdGR1R1?=
 =?utf-8?B?M25zemc3QTBsMzBkTERXMkt4Y3ZiWUg0TDM1djhDZHgvcVdzVy9qMGN6dnpL?=
 =?utf-8?B?SEVpdjFGelcxdmtUSzgzNkJxYVc5b1BCV2pyNStuT1JudkNOUjFERXhEaEcw?=
 =?utf-8?B?djRZVEJhSEQ2SzdiZUpIempObHA1Qm10bFZqRU12N1VPZjFpLzlhV1oyeUpF?=
 =?utf-8?B?QVFEL3NoQ3pWRzJ0b09JeXgvNCtmeXZYZ1dXdlJGVnl4azE2T0JnL2dsOXd3?=
 =?utf-8?B?YTVmSjdUQnc0YVRJdEdKSnR3cTBMZUtJd1VnNkFPNVNiWTc0K3RHMEFQZGo5?=
 =?utf-8?B?b0JHMzRkenhlaExBQkZ0Z2xLaG16RHVlYlZvRURPNXFWS2V6Q3kvcDYydHlk?=
 =?utf-8?B?TFpOTjlwcU1qTnRXalhJRFZnTWhjT2pxTTJSdXJMeGxrZ2VkMlJ0RnhUYTF2?=
 =?utf-8?B?SDNMUjJsZ2pRQ1loQVplS1BMNXlhSklwWmJDeHhuWFU0K0RJcEZPb2RIb0ky?=
 =?utf-8?B?ZC9PWXN4ZWlFUXByZWRyMnZWbU8vSGx6R2FtSk5ta1h6SGRDa0JqZjNpLzJI?=
 =?utf-8?B?Vi9VTXFWYTQ2Y1N4VVpFaEtpSzVqQzErZVJkdSt5dVNXUVhUTXRHU3VsYWMv?=
 =?utf-8?Q?VwMUy5aCF+tsYzp4+I8mjeKM2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffa0a7a-4fa9-4cfc-406e-08db74650474
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2023 03:42:21.8057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTiDXKyMWwQgulMWq7QISI5Elv/s9ZX3W5INRpCY0tJaPoewnCSv+UncZ1gDuZso+iXtb7MQzTyXVtjS2Hha7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8377
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgMjMgSnVu
ZSwgMjAyMyA2OjE4IFBNDQo+IFRvOiBMZWUsIEthaCBKaW5nIDxrYWguamluZy5sZWVAaW50ZWwu
Y29tPjsgRGluaCBOZ3V5ZW4NCj4gPGRpbmd1eWVuQGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8
cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtvemxvd3NraSA8a3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJuZWwu
b3JnPjsgQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT47IFdpbGwNCj4g
RGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBhcmNoOiBhcm02NDogY29uZmlnczogRW5h
YmxlIFVCSSBhbmQgVUJJRlMNCj4gDQo+IE9uIDIzLzA2LzIwMjMgMTI6MDMsIExlZSwgS2FoIEpp
bmcgd3JvdGU6DQo+ID4+Pj4+DQo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFsaWYgWmFrdWFuIFl1
c2xhaW1pDQo+ID4+Pj4+IDxhbGlmLnpha3Vhbi55dXNsYWltaUBpbnRlbC5jb20+DQo+ID4+Pj4+
IFNpZ25lZC1vZmYtYnk6IEthaCBKaW5nIExlZSA8a2FoLmppbmcubGVlQGludGVsLmNvbT4NCj4g
Pj4+Pj4gLS0tDQo+ID4+Pj4+ICBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIHwgMiArKw0K
PiA+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4+Pg0KPiA+Pj4+
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KPiA+Pj4+PiBiL2Fy
Y2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgaW5kZXggYTI0NjA5ZTE0ZDUwLi4yM2E2ZWJjYjFh
OWUNCj4gPj4+PiAxMDA2NDQNCj4gPj4+Pj4gLS0tIGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNv
bmZpZw0KPiA+Pj4+PiArKysgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4+Pj4+
IEBAIC00NzAsNiArNDcwLDggQEAgQ09ORklHX0lQTUlfREVWSUNFX0lOVEVSRkFDRT1tDQo+ID4+
Pj4gQ09ORklHX0lQTUlfU0k9bQ0KPiA+Pj4+PiBDT05GSUdfSFdfUkFORE9NPXkgIENPTkZJR19I
V19SQU5ET01fVklSVElPPXkNCj4gPj4+Pj4gK0NPTkZJR19NVERfVUJJPXkNCj4gPj4+Pj4gK0NP
TkZJR19VQklGU19GUz15DQo+ID4+Pj4NCj4gPj4+PiBOb3QgbW9kdWxlcz8NCj4gPj4+IFllcywg
d2UgbmVlZCB0byBib290IHdpdGggcm9vdGZzIHdpdGggVUJJRlMuDQo+ID4+DQo+ID4+IFNvIHlv
dSBtaXNzIGluaXQgcmFtZGlzay4NCj4gPiBDdXJyZW50bHkgd2UgYXJlIHVzaW5nIHRoZSBib290
YXJncyB0byBtb3VudCB0aGUgcm9vdGZzIGZyb20gUVNQSSBOT1INCj4gZmxhc2g6DQo+ID4gWyAg
ICAwLjAwMDAwMF0gS2VybmVsIGNvbW1hbmQgbGluZTogZWFybHljb24gcGFuaWM9LTEgdWJpLm10
ZD0xDQo+IHJvb3Q9dWJpMDpyb290ZnMgcm9vdGZzdHlwZT11YmlmcyBydyByb290d2FpdA0KPiA+
IElzIGl0IHBvc3NpYmxlIHRvIG1vdW50IHRoZSB1YmlmcyByb290ZnMgd2l0aCB0aGUgdWJpZnM9
bSBjb25maWcgZHVyaW5nIGJvb3Q/DQo+IA0KPiBJIHRoaW5rIHllcy4gcm9vdGZzIGRldmljZXMg
YXJlIGZvciBleGFtcGxlIG1vZHVsZXMsIHNvIGZpbGVzeXN0ZW0gY2FuIGJlIGFzDQo+IHdlbGwu
DQpXYXMgZ29pbmcgdGhyb3VnaCBtdGQgdWJpZnMgcGFnZSAtIGh0dHA6Ly93d3cubGludXgtbXRk
LmluZnJhZGVhZC5vcmcvZmFxL3ViaWZzLmh0bWwNClF1b3RlZDogJ0luIG9yZGVyIHRvIG1vdW50
IFVCSUZTIGFzIHRoZSByb290IGZpbGUgc3lzdGVtLCB5b3UgaGF2ZSB0byBjb21waWxlIA0KVUJJ
RlMgaW50byB0aGUga2VybmVsIChpbnN0ZWFkIG9mIGNvbXBpbGluZyBpdCBhcyBhIGtlcm5lbCBt
b2R1bGUpIGFuZCBzcGVjaWZ5IA0KcHJvcGVyIGtlcm5lbCBib290IGFyZ3VtZW50cyBhbmQgbWFr
ZSB0aGUga2VybmVsIG1vdW50IFVCSUZTIG9uIGJvb3QuJw0KDQpJdCBzZWVtcyBsaWtlIHdlIG5l
ZWQgVUJJRlMgY29uZmlnIHRvIGJlIGNvbXBpbGVkIGFzIGtlcm5lbCBidWlsdC1pbi4NClRoZSBr
ZXJuZWwgbW9kdWxlIHdvdWxkIHdvcmsgaWYgd2UgbW91bnRlZCBVQklGUyBhcyBmaWxlc3lzdGVt
IGRldmljZSANCmFmdGVyIHJvb3RmcyBtb3VudGVkLCBidXQgbm90IGFzIHJvb3Rmcy4NCkxldCBt
ZSBrbm93IGlmIHRoYXQgdW5kZXJzdGFuZGluZyBpcyBjb3JyZWN0Lg0KVGhhbmtzLg0KPiANCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNClJlZ2FyZHMsIA0KTGVlLCBLYWggSmlu
Zw0KDQoNCg==
