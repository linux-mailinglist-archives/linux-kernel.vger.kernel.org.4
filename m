Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3D5700204
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbjELH71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbjELH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:59:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D54D10FE;
        Fri, 12 May 2023 00:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683878364; x=1715414364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Be7CSvIDnUxMjyJ6AjOk/YZjbrRhrb5SHFpza24adX4=;
  b=chdk0lhkxbab6oZCODc7xdQIj7b4b6tlI0eaKcWeH1z0Oh1cqxbVuR8V
   pueViL2a5Aqoyx1COU9Nr657Ol5iYowsGD3e70OadvRkKh9s1YfH+0DVk
   n35gbpPgBTr8EFfVfR669xG4vcOAGmkxJ3HvJfAjTVLzIkgpn6ymZI4At
   D2tOAf5vRmd9BuiWFBUD6WgdNAzWJfFejpSobG1g2jtyn9RF6+4iYayKZ
   7qpwP5jS4bWMM8MHalKB1/TRjnVATZgOg3EJmtcYdPZF0yp7RAdGIfB1e
   Cf31b/8bUnvaiqjkr6FkxzK6Vsvgb/dyJo77l0AkW8PrDSun7Rqrsg98y
   g==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="scan'208";a="215029714"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 00:59:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 00:59:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 00:59:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRrOhypQle0Spr3IzCb1b+yhb18F1PBLA0yvkzcPcPZzFOBr4U4Lhm5mTv9EoqR2EJF3gSJta4O5yEwgT+nh1gzCoOTkdm+Cgj3AR39ixEUGQ3vFrAA5jxvhjsjwJ3TeiXsdRvdI1vD5Tqx21OW6kwPOgIcOkRimW8e2qB8n9KMOnOjTo3i8HUdIhYUbVgTVBwm49Pzz53EV/pTJzRcyOTdG+uLmqq2ksleTX18alrfgAJDC3qXzPqVRAgd5krGRdogP5COGxY9UAx0D3eauGKUJnnBRFlPUd9LSJPu6PpHegFhXDlp9aa57wbJ1fflYA1Gp0XpCtN3jglGwmDF1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be7CSvIDnUxMjyJ6AjOk/YZjbrRhrb5SHFpza24adX4=;
 b=nQHqlzRiEbBC3Bz+2Oiyzk9KU8U0VYN8CzUS4O3W5uqPzUfqp97hnNoup329D3eenNNyPsAXtSwktZuniLbh6bJaphdbFHy6SaQDJeHLg7NESEaaswd93TyDOGf16KpWHBbjQWEHA+sIzdVTeSdiqgAdhtlnkS678x3MJpcM1RS4uh9n/+mt2HgzHGx6dfNXzSStdsTCGVcJrMX+pUTATAqbwHoZ9RvESCYOI/0xVFxIlKnJ1hm3h9j7nZzAFvJtH+XGa3mdIYCRXdz9sAlbgk2u0Bz040uJPbd/E18IwWOWWWKCmkw3X3bHrvGlg0WDVmKdLMl+liSRfwpZGPUCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be7CSvIDnUxMjyJ6AjOk/YZjbrRhrb5SHFpza24adX4=;
 b=ks/MXtpFqeysCjYcVUnHnncxiZL+X/wV3Sgavxz/E8FUWYfrlY5NZsgStLkM+5uNuOj10XeEf1ltt4ZsL60fdAhcBP/T81Kk9hR8LB8537bCJpd1MvfqHqL0dUSNpMumo3aHNecbLLNDFxyHdJUXuTHGAeDUvpDDiLDBuVlAOVk=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Fri, 12 May
 2023 07:59:21 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%2]) with mapi id 15.20.6363.033; Fri, 12 May 2023
 07:59:21 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>
CC:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
Thread-Topic: [PATCH v3 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc:
 convert to yaml
Thread-Index: AQHZhKeoWLpsVy9E/kqhputCiz2VHg==
Date:   Fri, 12 May 2023 07:59:21 +0000
Message-ID: <de935920-49ae-0e3d-7d41-17b622e586f8@microchip.com>
References: <20230509052757.539274-1-claudiu.beznea@microchip.com>
 <20230509052757.539274-3-claudiu.beznea@microchip.com>
 <e463eb68-3ea0-5230-76fd-4a2ee66bf397@linaro.org>
 <773d0d90-29c7-b1bd-bd16-898b435eafb6@microchip.com>
 <b3c7db03-6614-47d9-a9e0-a8e51c836d86@linaro.org>
 <a4d934c6-ec28-50d0-b9bb-9b11fee7ebb6@microchip.com>
 <1c2aa022-348a-8ac2-1a26-eedf57aadb77@linaro.org>
 <71a1e8de-932d-09a1-efeb-af459fee9423@microchip.com>
 <8f21f892-de54-9bc7-d4b9-f36aaa6b4a7c@linaro.org>
 <e8e2de0e-ca7b-44e3-7853-5693a7926a2b@microchip.com>
 <20230511-strike-viper-f4171c88a040@wendy>
In-Reply-To: <20230511-strike-viper-f4171c88a040@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|PH7PR11MB5817:EE_
x-ms-office365-filtering-correlation-id: 37e44efd-94e4-430d-37ac-08db52becb3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4R4JD4+IGaQY7wonXkouBViSs71a90pb+of/qkyzYdpurMXwXRuZl9xqZTa+7HP2Dslvj79iPca4dhFE0b3yLi8xdS8Gv5SGTBg40U3E98nGg8sffbenVQC080eD/F8+EK0A2FeMdntBnCqz/IfQIcckqHtoceXTU45vZIHkzKT2Rf0QxG/+53hI9I4Q9L5S/p2wNLyUHY96TQlfxhuEHj4sYUjMGMlurg1DCFqvgMSCJmHbmOG3MGI7Ln2Na07BTDvFKcdgc6fBAQmpFO/d5IdrQSCgMPltbJZaOcVILguWxsaUu10hgdzv6N7ShTDn7a6ol18FRYyngzcZ45E9Z5BiL6MRb4ZZKetGfMjTEv8To0valuanBbu5ftf4mdbQNsqbNdyjbn1KHedHR1dldg2f3iMZ5SOxSS8FYyME+DMijKPr49u86KgH0bTWX9q53gyXYon4NiYCKMPwSHrPEvJSQUDZC63bbsL9F3vIYLIp3EUisFLdQ93aDEdlGRVy6MJJ3lFIKGT3P9bRV6nX7u9CpDlgfx6/HvLewQV8iirIODmjBRgkELGH6JZQwcLVYHK+PyJK9cJ1L9zYfu+zlfplRRW2z4wGXE4/WSb6RF9enB/GNe3+7Mj0npAEhvOmbYHPUjkd06igGn1XUgBo1Sov+PhM2gV3LMyqVe0q2KyWCSC+cUHCytSxcDDYdGfp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(31696002)(122000001)(71200400001)(36756003)(6486002)(83380400001)(53546011)(2616005)(86362001)(6506007)(186003)(26005)(76116006)(5660300002)(2906002)(38100700002)(54906003)(37006003)(41300700001)(4326008)(66476007)(91956017)(478600001)(66946007)(6512007)(66556008)(316002)(64756008)(6636002)(8676002)(6862004)(8936002)(38070700005)(66446008)(31686004)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUtHeXJabkFHYjRXK09Lb1psWEI0WW1acGttR0hTRnhydWlXb2lEN05vOTJL?=
 =?utf-8?B?aWpzL1JibG9iTEZtcnlGcDFMY0hjblNuR05HVHhLK05NMCtGVDVRWmQxa1h3?=
 =?utf-8?B?UXZadFFoZCtCZTQ4cmRWQjRPNEFxN0VqZUx0bjlrTnNHZXBaZ0xCN284ZmJR?=
 =?utf-8?B?akhuSkVKN3gwUTZ0cGVGZVI4cnJSY3FBM1B3N0FHRnpQVVNFUlc4Wit2NnN3?=
 =?utf-8?B?YlRkUlhBMDNLOUpPUUw5OVJtZE51OVI1d0hDQkVYVCs3dWpjWlJyMDdVWmxx?=
 =?utf-8?B?aGZFdS9vaWo0MUJHRENVaXNlTUhiU1ZIVEE1a08yQktVMWhZOThFY1ZvWmU4?=
 =?utf-8?B?OVUvSXpGM29tOC8wTG5La2F2RFBWNkdBaFh1S2dlM0t2cGUwOUhOWXEyVS9E?=
 =?utf-8?B?aURVOW93Qm54b2EzaUdLLzdXSmVlQXN5WnZMV0cyZXlSbVUvai9IU0pNMm5L?=
 =?utf-8?B?UUJ6NHF6YXJHdHJ0UXJSeUc5cHJIZzQ0QzVuM0NZSEt1K1NWeHVnTWYwQjFs?=
 =?utf-8?B?NkwwTDBCby9hSWdDaTI2RjRWM1NjRkdWaTgvdVdsNURvZzlxaHR6UVBZYUc2?=
 =?utf-8?B?MHBhcG9yLy93VTdDWW45SDFaZk1TOHhieVpMSWh4TkRWTFQ3TXN5QWN4SXlC?=
 =?utf-8?B?UkQxMXk0NHhVdjE3WWNyV253RVo2VWpreW1UcFM2cko0bGt1UkphVGJIYlp3?=
 =?utf-8?B?am83bHpEdzJFUUU1NXNqekNnd2lYN1dkQzdYcHZpYXRtVWM5T1ZTcG53d1dN?=
 =?utf-8?B?ZVQvZmU1WUNLTnEyVDU2WDZuQ0hXOTFITDFRc0RnQ2hRKzczcmtob0RtLzlm?=
 =?utf-8?B?NEU0Vm5icyt3eFR1WmZ5cnVFWEhxeHJJTHZNSlBaNzZmK0JuTmYycVZ6czFa?=
 =?utf-8?B?TVByVDFVVGp2UFo4VlltWWtxUWpRdXpuZ0FhYm03YnJGM2NmTE5UeFlJeGhh?=
 =?utf-8?B?MjNiYVB4WGFNMFJlQ05NRWhweUlKNFU1TmloUVVTOXRmYnVIaUFJTEZjVkF0?=
 =?utf-8?B?QXFIcWE1ZXJ2Wm9vZytYQXJwalI1RXVIRGRVdXpWMFRSNWRqTXpGN2c3bjZa?=
 =?utf-8?B?VVJ2bldNdDhHVmc0aTlZeks3d3IvVlJzdlRVMVV5aXBvMGhhRSthak84SjJr?=
 =?utf-8?B?a1ZnVjNRNXJwSlhXVTR6QmdnUEtXS0Irck43WU5NRlFubFREWmRiUm5hdEc0?=
 =?utf-8?B?cE8wRWZLaUJhdTM2R2tzNjlRV05wZVdLaTdZakxiOE1lVzd4R2t4MmdOZlVD?=
 =?utf-8?B?V3FYWmJGMVNObk5TWlY2NVlyY0NJTm8xSi90d3IwV2RLYWlMT0tZWWpzR0hU?=
 =?utf-8?B?NzZDamMxeWoxYTRDRGJ3TFJzdnZBSHpGcnpjWGk5K2ljeGpWZHFmdExtTENF?=
 =?utf-8?B?ZElKV09Pb1oxT0ZuQ2hEVkJiM21JUEtLSTFwaVVaMlA5SCtMM2l2RmJGZkJj?=
 =?utf-8?B?dmdpM1hxaXhOcUEzVkhPQ3JXVU9idDBJZ2lVd1RiOFNYVHJwcTVOMm42elI5?=
 =?utf-8?B?NW1rOWl0WWo2QlE0YU54RnNiRjY5VHZuNjhqTnpMc1Qxc2V5dHJzdkJ0MUZY?=
 =?utf-8?B?YnMzN3lwKzgwRk1QNzM1dFFWVVJnb2pMcS8yUllhd2g1UUhZbzhJVGYybXBx?=
 =?utf-8?B?OHYrZGFLMU9qSHJRaWJWeHhVOWpSRGQvY1I5Zm5aWUxSanpmdkt3dmUyZEUy?=
 =?utf-8?B?K2FIM3BnWGhnNDNQZU1GeWFlemFkOTFPR3MvUTBoYUM2ZDREWkRGK2pueSt1?=
 =?utf-8?B?ZFZXWXROcEZVUndwOFhxRWVaNUhSOHdzRzdRYUhRZUNyS0wrV0lNamdMWklV?=
 =?utf-8?B?R3J6ZzlVaittTGpleE12V0U5ZGpCd0tzdGVrYktlZ2xPVnRrSko5SmYzbUMy?=
 =?utf-8?B?MUxjdXJHQmcycEMwUnBUaGVVYWJKME02ZlBmMm5SdWh1RVpjWGZBTDc5c2tl?=
 =?utf-8?B?UmdSUnBpdGF3cGUwZDgyZUlldzM5emk1cmhLYUYwUGM0bkxGZW5ITVkxai9X?=
 =?utf-8?B?Z0FzWXZseXVSamVDSjRTaHgyZ1lYaUQ3VENHVUY5WjZCdS8xZ3c2cE83UXQw?=
 =?utf-8?B?YW15NHpaOU5LWkFwd1FOaDRQVXYyWUI1bWdGb3liUGROVzBtTExTTnZhUXEx?=
 =?utf-8?Q?SC8mD5pnCGvMSuOWgJqrPk9zE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8555593DF0B9AC439DDD62D631A2C253@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e44efd-94e4-430d-37ac-08db52becb3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 07:59:21.0082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9eA+S2pUgV2xbrIw7DiuQlTWMjgcNaUc5fPCKxRCiEoBkmy4L8TRxfgXOQBWtXfq8K+aGtklD1xRTDSgDnVyWoALZ5rgQXCTaI9VfVQme4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEuMDUuMjAyMyAxMTo1OCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBUaHUsIE1heSAx
MSwgMjAyMyBhdCAwNjoyOTozOUFNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29t
IHdyb3RlOg0KPj4gT24gMTAuMDUuMjAyMyAxMzoxMiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90
ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIDEw
LzA1LzIwMjMgMTA6MzEsIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+
IE9uIDEwLjA1LjIwMjMgMTA6NTgsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4+PiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4+DQo+Pj4+PiBPbiAxMC8wNS8y
MDIzIDA5OjE0LCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+Pj4+IE9u
IDEwLjA1LjIwMjMgMTA6MDYsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4+Pj4+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+Pj4+Pg0KPj4+Pj4+PiBPbiAxMC8w
NS8yMDIzIDA5OjAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+Pj4+
Pj4gT24gMDkuMDUuMjAyMyAwOToyNSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+Pj4+
Pj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4+IE9uIDA5LzA1LzIwMjMgMDc6MjcsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPj4+Pj4+Pj4+
PiBDb252ZXJ0IEF0bWVsIFBNQyBkb2N1bWVudGF0aW9uIHRvIHlhbWwuIEFsb25nIHdpdGggaXQg
Y2xvY2sgbmFtZXMNCj4+Pj4+Pj4+Pj4gd2VyZSBhZGFwdGVkIGFjY29yZGluZyB0byB0aGUgY3Vy
cmVudCBhdmFpbGFibGUgZGV2aWNlIHRyZWVzIGFzDQo+Pj4+Pj4+Pj4+IGRpZmZlcmVudCBjb250
cm9sbGVyIHZlcnNpb25zIGFjY2VwdCBkaWZmZXJlbnQgY2xvY2tzIChzb21lIG9mIHRoZW0NCj4+
Pj4+Pj4+Pj4gaGF2ZSAzIGNsb2NrcyBhcyBpbnB1dCwgc29tZSBoYXMgMiBjbG9ja3MgYXMgaW5w
dXRzIGFuZCBzb21lIHdpdGggMg0KPj4+Pj4+Pj4+PiBpbnB1dCBjbG9ja3MgdXNlcyBkaWZmZXJl
bnQgY2xvY2sgbmFtZXMpLg0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gVGhhbmsg
eW91IGZvciB5b3VyIHBhdGNoLiBUaGVyZSBpcyBzb21ldGhpbmcgdG8gZGlzY3Vzcy9pbXByb3Zl
Lg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+ICt0aXRsZTogQXRtZWwgUG93ZXIgTWFuYWdlbWVudCBD
b250cm9sbGVyIChQTUMpDQo+Pj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+Pj4gK21haW50YWluZXJzOg0K
Pj4+Pj4+Pj4+PiArICAtIENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAu
Y29tPg0KPj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4+ICtkZXNjcmlwdGlvbjoNCj4+Pj4+Pj4+Pj4g
KyAgVGhlIHBvd2VyIG1hbmFnZW1lbnQgY29udHJvbGxlciBvcHRpbWl6ZXMgcG93ZXIgY29uc3Vt
cHRpb24gYnkgY29udHJvbGxpbmcgYWxsDQo+Pj4+Pj4+Pj4+ICsgIHN5c3RlbSBhbmQgdXNlciBw
ZXJpcGhlcmFsIGNsb2Nrcy4gVGhlIFBNQyBlbmFibGVzL2Rpc2FibGVzIHRoZSBjbG9jayBpbnB1
dHMNCj4+Pj4+Pj4+Pj4gKyAgdG8gbWFueSBvZiB0aGUgcGVyaXBoZXJhbHMgYW5kIHRvIHRoZSBw
cm9jZXNzb3IuDQo+Pj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+Pj4gK3Byb3BlcnRpZXM6DQo+Pj4+Pj4+
Pj4+ICsgIGNvbXBhdGlibGU6DQo+Pj4+Pj4+Pj4+ICsgICAgb25lT2Y6DQo+Pj4+Pj4+Pj4+ICsg
ICAgICAtIGl0ZW1zOg0KPj4+Pj4+Pj4+PiArICAgICAgICAgIC0gZW51bToNCj4+Pj4+Pj4+Pj4g
KyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOWcxNS1wbWMNCj4+Pj4+Pj4+Pj4gKyAgICAg
ICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOWcyMC1wbWMNCj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAg
ICAgLSBhdG1lbCxhdDkxc2FtOWcyNS1wbWMNCj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgLSBh
dG1lbCxhdDkxc2FtOWczNS1wbWMNCj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxh
dDkxc2FtOXgyNS1wbWMNCj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2Ft
OXgzNS1wbWMNCj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAtIGVudW06DQo+Pj4+Pj4+Pj4+ICsgICAg
ICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTkyNjAtcG1jDQo+Pj4+Pj4+Pj4+ICsgICAgICAgICAg
ICAgIC0gYXRtZWwsYXQ5MXNhbTl4NS1wbWMNCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IEkgbWlzc2Vk
IGl0IGxhc3QgdGltZSAtIHdoeSB5b3UgaGF2ZSB0d28gZW51bXM/IFdlIG5ldmVyIHRhbGtlZCBh
Ym91dA0KPj4+Pj4+Pj4+IHRoaXMuIEl0J3MgdXN1YWxseSB3cm9uZy4uLiBhcmUgeW91IHN1cmUg
dGhpcyBpcyByZWFsIGhhcmR3YXJlOg0KPj4+Pj4+Pj4+IGF0bWVsLGF0OTFzYW05ZzIwLXBtYywg
YXRtZWwsYXQ5MXNhbTkyNjAtcG1jDQo+Pj4+Pj4+Pj4gPw0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEkg
aGF2ZSAyIGVudW1zIGJlY2F1c2UgdGhlcmUgYXJlIHNvbWUgaGFyZHdhcmUgY292ZXJlZCBieToN
Cj4+Pj4+Pj4+ICJ2ZW5kb3ItbmFtZSxoYXJkd2FyZS12MS1wbWMiLCAic3lzY29uIiBhbmQgc29t
ZSBjb3ZlcmVkIGJ5Og0KPj4+Pj4+Pj4gInZlbmRvci1uYW1lLGhhcmR3YXJlLXYyLXBtYyIsICJ2
ZW5kb3ItbmFtZSxoYXJkd2FyZS12MS1wbWMiLCAic3lzY29uIi4NCj4+Pj4+Pj4NCj4+Pj4+Pj4g
VGhlIGVudW0gZG9lcyBub3Qgc2F5IHRoaXMuIEF0IGFsbC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gU28g
YWdhaW4sIGFuc3dlciwgZG8gbm90IGlnbm9yZToNCj4+Pj4+Pj4gaXMgdGhpcyB2YWxpZCBzZXR1
cDoNCj4+Pj4+Pj4gYXRtZWwsYXQ5MXNhbTlnMjAtcG1jLCBhdG1lbCxhdDkxc2FtOTI2MC1wbWMN
Cj4+Pj4+Pj4gPw0KPj4+Pj4+DQo+Pj4+Pj4gTm90IHcvbyBzeXNjb24uIFRoaXMgaXMgdmFsaWQ6
DQo+Pj4+Pg0KPj4+Pj4gU3lzY29uIGlzIG5vdCBpbXBvcnRhbnQgaGVyZSwgYnV0IGluZGVlZCBJ
IG1pc3NlZCBpdC4NCj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBjb21wYXRpYmxlID0gImF0bWVsLGF0
OTFzYW05ZzIwLXBtYyIsICJhdG1lbCxhdDkxc2FtOTI2MC1wbWMiLCAic3lzY29uIjsNCj4+Pj4+
Pg0KPj4+Pj4+IGF2YWlsYWJsZSBpbiBhcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOWcyMC5kdHNp
ICs0NQ0KPj4+Pj4NCj4+Pj4+IE5pY2UsIHNvIG15IHJhbmRvbSBjaG9pY2Ugd2FzIGFjdHVhbGx5
IGNvcnJlY3QuIE9rLCBzbyBhbm90aGVyOg0KPj4+Pj4NCj4+Pj4+IGF0bWVsLGF0OTFzYW05ZzE1
LXBtYywgYXRtZWwsYXQ5MXNhbTkyNjAtcG1jLCBzeXNjb24NCj4+Pj4+DQo+Pj4+PiBJcyBpdCB2
YWxpZCBoYXJkd2FyZT8NCj4+Pj4NCj4+Pj4gVGhpcyBvbmUsIG5vLiBTbywgSSBndWVzcywgdGhl
IHdyb25nIGhlcmUgaXMgdGhhdCB0aGVyZSBjb3VsZCBiZQ0KPj4+PiBjb21iaW5hdGlvbnMgdGhh
dCBhcmUgbm90IGZvciBhY3R1YWwgaGFyZHdhcmUgYW5kIHlldCBjb25zaWRlcmVkIHZhbGlkIGJ5
DQo+Pj4+IGNoYW5nZXMgaW4gdGhpcyBwYXRjaD8NCj4+Pg0KPj4+IEkganVzdCBkb24ndCB1bmRl
cnN0YW5kIHdoeSB5b3UgaGF2ZSB0d28gZW51bXMuIFRoaXMgaXMgbm90IGEgcGF0dGVybg0KPj4+
IHdoaWNoIGlzIGFsbG93ZWQgYW55d2hlcmUuIEl0IG1pZ2h0IGFwcGVhciBidXQgb25seSBhcyBl
eGNlcHRpb24gb3IgbWlzdGFrZS4NCj4+DQo+PiBJJ20gbm90IGF0IGFsbCBhbiBZQU1MIGV4cGVy
dCBhbmQgdGhpcyBpcyBob3cgSSd2ZSBtYW5hZ2VkIHRvIG1ha2UNCj4+IGR0X2JpbmRpbmdfY2hl
Y2svZHRic19jaGVjayBoYXBweS4NCj4gDQo+IFBpY2tpbmcgb25lIGl0ZW0gYXQgcmFuZG9tLCBk
byB0aGUgZGV2aWNldHJlZXMgY29udGFpbiBzdHVmZiBsaWtlOg0KPiAiYXRtZWwsYXQ5MXNhbTln
MzUtcG1jIiwgImF0bWVsLGF0OTFzYW05MjYwLXBtYyIsICJzeXNjb24iDQo+IC8vQU5ELy8NCj4g
ImF0bWVsLGF0OTFzYW05ZzM1LXBtYyIsICJhdG1lbCxhdDkxc2FtOXg1LXBtYyIsICJzeXNjb24i
DQo+ID8NCj4gDQo+IElmIG5vdCwgd2h5IGRvIHlvdSBub3QgYnJlYWsgaXQgZG93biB0byBzb21l
dGhpbmcgbGlrZToNCj4gLSBpdGVtczoNCj4gICAgIC0gZW51bToNCj4gICAgICAgICAtIGF0bWVs
LGNvbXBhdGlibGUNCj4gICAgICAgICAtIGF0bWVsLHdpdGgNCj4gICAgICAgICAtIGF0bWVsLHNh
bTkyNjAncyBwbWMNCj4gICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFzYW05MjYwLXBtYw0KPiAgICAg
LSBjb25zdDogc3lzY29uDQo+IA0KPiAtIGl0ZW1zOg0KPiAgICAgLSBlbnVtOg0KPiAgICAgICAg
IC0gYXRtZWwsY29tcGF0aWJsZQ0KPiAgICAgICAgIC0gYXRtZWwsd2l0aA0KPiAgICAgICAgIC0g
YXRtZWwsc2FtOXg1J3MgcG1jDQo+ICAgICAtIGNvbnN0OiBhdG1lbCxhdDkxc2FtOXg1LXBtYw0K
PiAgICAgLSBjb25zdDogc3lzY29uDQo+IA0KDQpJJ2xsIGNoZWNrIGl0IG91dCwgdGhhbmsgeW91
IQ0KDQo+IENoZWVycywNCj4gQ29ub3IuDQoNCg==
