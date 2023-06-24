Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9C73C694
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 05:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjFXDba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 23:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFXDb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 23:31:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D18170B;
        Fri, 23 Jun 2023 20:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687577485; x=1719113485;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bZ5I6OqUTtTPv5puEjv/SNtG4BKEQprN3qVvHimBn1M=;
  b=nFh5dWDXysXO9AI9/qwh6CqwARN2NTSrPjsAnyWvqxzIYQ1JHMRcFgB2
   P66/X119+cIqkgtiKaM5vxxs7s/WQcAUe7Dv6DYgTqyN490kYNvdNf2d0
   XdlGmCIWQ5MVhPEy+UKCtV6MHX3fuAc0iqn8/k4IW8LxwzpT2tUG4pFpv
   lJUmkshwgFi2SqzCDVHQZPXWEaxZ1RV0XTivoNBwvixOJthwmmacKKnUH
   QfseKO2fHhRKZAvYNSmCESHVFPX8zBuigIma0Rf2WH4lK1gogfLIGDCjM
   fPoeS6c4KcoffHEgb97jhqUnn5042Qidob0fHKGMWc31WTw3L340fBVIT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="363459146"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="363459146"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 20:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="709647749"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="709647749"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 23 Jun 2023 20:31:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 20:31:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 20:31:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 20:31:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fid96oInzC/KWzWIIYKJON3kbWXHf3lOYsRSJ+JGkqXdbP5RVGqp7dQk/XS/ThvFPOqcUSIza48AMk2AnnwN4zEXnDV7YAhjm9CG1fEg46POONyuXdwE2TxrBaKChG8y7yyKSD85IcvF46Np0P4nb8/wgGmP5da/BycK/4AZ6HHWPHQaau+Gb+nvzi0CqNX7CiTcx3G/YlA6AS9d3yqwsPB8peYWEmuEN4xp76euOBFElJx4Di/KiFhxSWul/ZUFgnosl3Q+k9ePpaF5eSyJibc/bp+7pL+Qq0eaq5B4sp7YCBHpY1cCum0wSzIgNRj12A4FxsoaEVqmZ0jsO0/ndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZ5I6OqUTtTPv5puEjv/SNtG4BKEQprN3qVvHimBn1M=;
 b=QXIIjncPxj+GaIHDtdLclODMId+LOCzDreotqcboLE+DWSYiCG/fCiLcQ40EqAhGTSmk7lveb5uZT6HmrkbxmzqSsqfbHv6WF8v+DMT/4UX91M9IRSdEYydr3BU0wS2wcvAHU8Ktl3pVPoCAdNXE2HQJtVXkqXPycqn1/VhrJy8TW/9owlKGK6Wgvb6Z17IPe5vqup1XVMfYsYzhBpVX4l1glMqArwkQ9SD9JD9phNS2HtkPOcrIdUo4UrzVF8RlGbtcxtckECjvMk9cuztWqUL/ULXGMDoRe0r8m2wy8fp7BgT4Ezstt/XenrxNRsvgJtnHqcRsd0kmvR+h8BAiVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by CH3PR11MB7274.namprd11.prod.outlook.com (2603:10b6:610:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 03:31:22 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049%4]) with mapi id 15.20.6521.024; Sat, 24 Jun 2023
 03:31:22 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "cocci@inria.fr" <cocci@inria.fr>
Subject: RE: [v2 1/2] arm64: dts: agilex/stratix10: Updated QSPI Flash layout
 for UBIFS
Thread-Topic: [v2 1/2] arm64: dts: agilex/stratix10: Updated QSPI Flash layout
 for UBIFS
Thread-Index: AQHZpcJzgflj2mqslEWKoW+ce1VMz6+ZTGlg
Date:   Sat, 24 Jun 2023 03:31:21 +0000
Message-ID: <PH0PR11MB5673299ABB58E14675CE52B0CB20A@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <20230622123432.593548-1-kah.jing.lee@intel.com>
 <ee1779cc-fe9e-d529-3188-4feef8f27b98@web.de>
 <PH0PR11MB56730E97D182D413C9B555E1CB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <c15e650e-6aee-d3e1-3fe1-7e5d34813a04@web.de>
In-Reply-To: <c15e650e-6aee-d3e1-3fe1-7e5d34813a04@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|CH3PR11MB7274:EE_
x-ms-office365-filtering-correlation-id: 5bc938c0-9fcc-47c2-64e4-08db74637b20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: REXrwb8AJMIhhwKEpuxwFeAQ/rW5v6uUwyy0Qzv1DXp0S/St00wWdzxiTNxGeW2IEHrnj4NyLn1dhSl9s5j1X++DvDjsVTxemnsX2MT5j/ibMfpZSdSitFm6oYAORkO/pfZ/SIJwqAwqSYkwN2GBB+A3OAUlIAcBuMaHqUntXzukjzv+XrsEPjk9KqQTqBUjlzA/6kJ1Jil+qjHBW+Okum7J9jMzGePrLyfvvLsDBXVmDQZUEV3aoTLxlEJNhBlWaHg/eLcwzqeai92ZTcOZ+sQ92QznhJmNdTUGt2djnCWYYG00kXeUk2o+xvH13p9quApm/HjZ60e3XCKmpkf5bElnaYFZlhJI51pkimsrMSg063P8A3STEOlSvoeFAF3fMpBYOoJmxREZLDSr9H2hQXDKHXoMbn6RZfycs1Sb56twCGsj5AnW2G2+WCbuFwswc0wZG2q1IM7XvX7DmY/VEput0OwYDqqf/guDWAc9JAJftm94YQSronEdvwgyUJdivw3uqvqR1Ged/nnlD0OhDlIoqj5F1hvqzSWdT2mVvAcAGRBKOvRB7sxDLfucVoEeZGepcIEZos7dNAOltBM2MV9EyUuUxlWDmj0KhMMQqlSmi+Vqg2riQQFMxHoGXAd9NT+aVXWI0N8SXWHBcEsltw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(55016003)(8676002)(316002)(41300700001)(8936002)(122000001)(26005)(186003)(15650500001)(7416002)(478600001)(38100700002)(9686003)(86362001)(7696005)(82960400001)(33656002)(2906002)(71200400001)(38070700005)(53546011)(6506007)(55236004)(921005)(5660300002)(52536014)(83380400001)(110136005)(54906003)(76116006)(4326008)(66446008)(64756008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmtEUnNVV3BQYjl3NnJqTzRvNXAwZFBQdXpNR1dUeXpFcjJ4OFcwZkRmb1BX?=
 =?utf-8?B?QXNjR3dWZFdFSU1kT2ZhMks4QnZ2azcrOEdhQ2JSR3RlYTFwZ2E2dG4reXJQ?=
 =?utf-8?B?M1FkS1g0Z2VkQWxxT2dMcmlUdUhtNmdQNm9OT0x2Yk1vNVgzWWhkNXJjZ3dG?=
 =?utf-8?B?SzgvMnZjWnBrc2FZSUowM2lqNzlFU3FHbFJacUZNMWdxWW43VGI2RjY1aWhT?=
 =?utf-8?B?dkRaZWpJa3VtOFlybld0YzZxdmFpRTZ6aXFsRW92M01vd3RFL0pkVTVCcGdE?=
 =?utf-8?B?QVdXVGkrT0dhOGIxQlVOM1BaSUtncFN2dDYvSHJuMTNIeWxxMGpTbEJxb3Np?=
 =?utf-8?B?UFJQNFlXRTVBWWlZSVJXU2pKWGhOMUtERHFzN2RmdnJyNDd3TGtYeGZ3Q2JR?=
 =?utf-8?B?cmkvcjNzaCsybEJwd3RkUm9SVHlSelArdEx2bGF5a3lMdmdxaC9lcnByRU10?=
 =?utf-8?B?NFJLWVRtZlNhVXRvNVU2eThuRlNJT2x6emJ2T1ArWHJ4MndMeWZNZDhPTDYw?=
 =?utf-8?B?YjJ0cjRSdVg2MFFrUzFaWTdGd2plWWVZaUVPdERGK0pkZHl5S2o2U1JnVWw2?=
 =?utf-8?B?b3NTTUtROGg3bjcvd1NYYWpKVFVGUEdZaXBsR1dra2dFZFdnNnA5SGkxcWxq?=
 =?utf-8?B?emtXSGh3emhBaEdZTlpRaUNOMWFrZ0VvMElZT0tPVjgxM2k4SHp3Q3dsTWMy?=
 =?utf-8?B?QnUxK0lHdElGc2R2U1llcjJ0VG9qRmt1N1JxWXNPcGlOUDJZRTM4ZkNiQlEw?=
 =?utf-8?B?eDNWVmlJUDF1Tzk2V203RmplZzNhRWdFRlVVSFJCbzNoSWdkTk9qSUJUTmpC?=
 =?utf-8?B?WDlsL3Vqd1dVU2xNWGxIM1kwYUEvWDlUWndBUTFWNGhBU2dMcFpoWW5TUVRq?=
 =?utf-8?B?NmlwclJETW5kclZSaHFaTHNwb1VwdlFhYXhQMElTVWtsMjNyYjN3UGVSZ3dh?=
 =?utf-8?B?TGN4RFFZbGgwRWh6UmRYYzFsSTA5WUd0SSt3VHdmMEtBUys0TlRJdkRmWXZt?=
 =?utf-8?B?Zm1TTnhuWDFXbmhzZ0Q4bVhDOG1TM1lwRE5qRVFEdGI0NE5ScExLbTdtMUJJ?=
 =?utf-8?B?MWF3KzdKd1YxUHVWT3Npa3JMQmZYY2ZoSlN4djFKR2ZWeDgxVS9PS2xSZnd6?=
 =?utf-8?B?YTFGQjFXVXBJRGFJU2VqTVN5MHl5anQvQTBEVUdvaDEyZVBtd2FPc2FCZ2Fx?=
 =?utf-8?B?SUVaQUIyVHo0a0NacE11SEFsRmJoNC9ySUptOGxDRm9tL1J2OTg3aWRzV0xN?=
 =?utf-8?B?YjdmVjdKYzlXbkVoaS91QW5JK3RUUEVhZUM1K0hKUk94d2lINkhuZnNvZ1Fv?=
 =?utf-8?B?bjRQV2xqYTBqNVVzVWVmRDVrc2tRTlpBZnRxSEVDdndPaUFSNzdpbXkxN1Fs?=
 =?utf-8?B?M0g2Z3JtWWlvMHZwN0dJVE5vSmdCQ2ZnTkZ5Z0gzTTcxbUhteWFHOEJETmYz?=
 =?utf-8?B?VjdXY1ZLZmNqZXRFMlRNN0FldGtiL3AwbklYeTI3REZybk9zNWVVcjNuaE5W?=
 =?utf-8?B?L2JPNy9RbVNsLzZVTDViVWN3OFhydWZXaTB5b0hiL0oxT2txSmhLZE9ZTC91?=
 =?utf-8?B?MnY1d0tZMFlTUUV0c0pBZENNVkFiQTBDbGcvQnF1NDN6OFZjamg1alJIYkQw?=
 =?utf-8?B?aFlRRWhzNnNWRld1QWV2YmhiVjRMVS85T1I1YnpGZy9TNUZwRGUvMHQxNnhn?=
 =?utf-8?B?aTRlSjBLdHd3UGpUVXFwSHNCMVJyL203eEVsdVpyc3RZZ2JQczN0OGtNU1Vu?=
 =?utf-8?B?SEw4RS9WVkY4UG9yajBzSUYxNWszWXc1Q3JnOFlVUEIydTZKc2w3ckxHSkpr?=
 =?utf-8?B?UkJOOWFHUmRIUkJqLzJ2NkE1ODlCUmt3THY5dk9EaVlUUTg3cysxWUc1YnN1?=
 =?utf-8?B?enpjb05ZTTJ5SEtqb3J3RnhtcWMrbitzRXpPdktxc2dmQUJic3FhemRyTE1K?=
 =?utf-8?B?ZjZvM1FPdlFzN3hhZXd2ZUFhZ2JzVEtqYzNrZ3JCaUc5NWdQVlY0bnJUNzlD?=
 =?utf-8?B?N0pIRkRLZmhERGVQYUptdWJVRHF2bGoxenNQRFh6QW5maUpocnRDeGtsNC90?=
 =?utf-8?B?eUJhZUVqUU1OZUxtZldoeVBrcE84RmlMekdqaGpKNHl6eWZRcDRYMW5WMEts?=
 =?utf-8?Q?9lXq+tn/EoyMiztieY10Euq3F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc938c0-9fcc-47c2-64e4-08db74637b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2023 03:31:21.9296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vCy4ImAHYomcFSGAoNYfYwHUMxzfv1B9Dy78r1J7JUgDMs8jfWaoW2qu2C7GyDnUTFBJGuiz0te380auKaRk9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7274
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrdXMgRWxmcmluZyA8TWFy
a3VzLkVsZnJpbmdAd2ViLmRlPg0KPiBTZW50OiBGcmlkYXksIDIzIEp1bmUsIDIwMjMgNzowNCBQ
TQ0KPiBUbzogTGVlLCBLYWggSmluZyA8a2FoLmppbmcubGVlQGludGVsLmNvbT47IFl1c2xhaW1p
LCBBbGlmIFpha3Vhbg0KPiA8YWxpZi56YWt1YW4ueXVzbGFpbWlAaW50ZWwuY29tPjsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbC0NCj4gamFuaXRvcnNAdmdlci5rZXJuZWwub3Jn
OyBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPjsNCj4gQ29ub3IgRG9v
bGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgRGluaCBOZ3V5ZW4gPGRpbmd1eWVuQGtlcm5lbC5v
cmc+Ow0KPiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxv
d3NraQ0KPiA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgV2lsbCBEZWFjb24g
PHdpbGxAa2VybmVsLm9yZz4NCj4gQ2M6IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyBjb2NjaUBpbnJpYS5mcg0KPiBTdWJqZWN0OiBSZTogW3YyIDEvMl0gYXJtNjQ6IGR0czog
YWdpbGV4L3N0cmF0aXgxMDogVXBkYXRlZCBRU1BJIEZsYXNoIGxheW91dA0KPiBmb3IgVUJJRlMN
Cj4gDQo+ID4gVXBkYXRlZCBpbiB2MyAtIENvbW1pdCBtZXNzYWdlOg0KPiA+IFVwZGF0ZSB0aGUg
UVNQSSBmbGFzaCBsYXlvdXQgdG8gc3VwcG9ydCBVQklGUyBpbiBtdGQgcm9vdCBwYXJ0aXRpb24u
DQo+ID4gRmxhc2ggbGF5b3V0IGlzIHVwZGF0ZWQgaW4gb3JkZXIgdG8gc3RvcmUgbm9uLVVCSUZT
IHJlbGF0ZWQgYm9vdCBhbmQNCj4gPiBmcGdhIGRhdGEgaW4gcXNwaV9ib290KG10ZDApIHdoaWxl
IGtlZXAgdGhlIHJvb3RmcyB3aXRoIFVCSUZTIGluIHRoZSByb290DQo+IHBhcnRpdGlvbihtdGQx
KS4NCj4gDQo+IEkgZ290IHRoZSBpbXByZXNzaW9uIHRoYXQgdGhpcyBjaGFuZ2UgZGVzY3JpcHRp
b24gaXMgYWxzbyBpbXByb3ZhYmxlIGEgYml0Lg0KPiBIb3cgZG8geW91IHRoaW5rIGFib3V0IGEg
d29yZGluZyB2YXJpYW50IGxpa2UgdGhlIGZvbGxvd2luZz8NCj4gDQo+IA0KPiBOb24tVUJJRlMg
cmVsYXRlZCBib290IGFuZCBmcGdhIGRhdGEgc2hvdWxkIGJlIHN0b3JlZCBpbiBxc3BpX2Jvb3Qg
KG10ZDApDQo+IHdoaWxlIGtlZXBpbmcgdGhlIHJvb3RmcyB3aXRoIFVCSUZTIGluIHRoZSByb290
IHBhcnRpdGlvbiDigJxtdGQx4oCdLg0KPiBUaHVzIHVwZGF0ZSB0aGUgUVNQSSBmbGFzaCBsYXlv
dXQgdG8gc3VwcG9ydCBVQklGUyBpbiB0aGUgbXRkIHJvb3QgcGFydGl0aW9uLg0KPiANCj4gDQo+
IFdpbGwgc2ltaWxhciBhZGp1c3RtZW50cyBiZWNvbWUgaGVscGZ1bCBmb3Igc3Vic2VxdWVudCB1
cGRhdGUgc3RlcHM/DQpTb3VuZHMgZ29vZCB0byBtZS4gV2lsbCB1cGRhdGUgdGhlIGNvbW1pdCBt
ZXNzYWdlIGZvciB2My4NClRoYW5rcy4NCj4gDQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0KDQpSZWdh
cmRzLCANCkxlZSwgS2FoIEppbmcNCg0KDQo=
