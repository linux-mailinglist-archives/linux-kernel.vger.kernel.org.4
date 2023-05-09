Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBAA6FBE99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 07:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjEIFPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 01:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjEIFPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 01:15:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67D7D2FF;
        Mon,  8 May 2023 22:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683609315; x=1715145315;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FBhnhmqUNO8TF+hRpPfPaD/x9ePUOXcszRON2YKhqm4=;
  b=hB4Y76b4uYvN0eMrDNw+nCmiPefnIisbzMWuimYkx4a1cGhUHkIXes6l
   +CeMD6slfdxZRRTLX+iF/KsJFT1Sr5IzJkKI81273W4eg4DAd9BwzpkM2
   w8dLH+BMKRkjM+gFe9lurFTlkA4uIFpDjNc4OmmoKE/lnQdAVmAKG/dCn
   qxz6Qc7rGxJszaDu4thYM9142yhpm7TyFvK6fjAEvZsu38MwEn2YTdCqG
   BGYKc2m7CXRcYWEjAQ/l8blDButQuui7qFlqFvt9ASJIs6Z8QHZ4HVIFh
   B+LlPBC2RNvcgyAGqcDKyiuaR7Uoit7xa4yV0ot8H4YRa8AvzA0PXVNNv
   w==;
X-IronPort-AV: E=Sophos;i="5.99,261,1677567600"; 
   d="scan'208";a="214363159"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2023 22:15:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 8 May 2023 22:15:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 8 May 2023 22:15:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXJnQ4CtFf2LxHXUWJXgC1X3XJO83u0F/zGCmjhzhqrUPFQvOOMFI3OM/v1POagTH5Kd8DG4S8llD4K695F1hSIlvFT52W1hjfYAOFyqhAefFDl1XdC82Nv7giYi38Xqgt7EkeEuX8K/XoH/phLdscTqj/SDi0uvsA0Ik54M4xLtKvUJ8Me+AJHrXpNSzSdMQczZREVf81qkgtjZkT+NW3/bkDpFrxThfSdOb3QhL2tJu4DHTVR/1IfnzdxwbZ2De12Zd01UDQBswhJl6TfFZ7t8vl+m2B5/DN1wzV6B8D+oscgxBKEGRtxddTshOcwS3z08O46i3R16WwhgMqU2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBhnhmqUNO8TF+hRpPfPaD/x9ePUOXcszRON2YKhqm4=;
 b=dyrGT91HQNw1z284SwRnH1rRM8l+G+9ovqJHBuYd5Osa1JK1nj5BU0LcYeuWXOLEzcqmxNjvs6Aly1HP9FZoMoPKGCr9/n6jtBfch24UTXRFR0rmdSBJcPxih6o+iIh80Qo48yqK0v3K3fas1ro+ivmkWnr3rhIPSbwjYO74uvWsZas9jfTxULQr9qDqJQAal3RpynAWRetJGzjUFYMTNe2r+PD9obVDl9yHSg5Q8M/VBiOzXywPR/iQIFkcgxofnOARiSNNccEa2/B80H8Y6OhoadmsXvKJ1anV3/KDFLnnVdzDFeBdV6IahGEwL4Ak4tMn4KVPUDunUUi/2WPcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBhnhmqUNO8TF+hRpPfPaD/x9ePUOXcszRON2YKhqm4=;
 b=ILSgzSm1iSwP8R5OMUyeEq/DqrBpkXUcEsi1vX46ZHYCkl33Dsz6hqVrTlgtiKIZ7oWrTAnlQGGzbLXJPWKpeUHWdWha1ksfSgDru/Eo1eSb9M8Wko2oftBr5CsyXsie+NFB3idnsKOqRQQCIcp4jcebn4nrlyLGBmiyheSmSM4=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by IA1PR11MB6467.namprd11.prod.outlook.com (2603:10b6:208:3a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 05:15:09 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%2]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 05:15:09 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
Thread-Topic: [PATCH v2 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc:
 convert to yaml
Thread-Index: AQHZgjU5Y14r4zodDEOFVMRE6bgYEg==
Date:   Tue, 9 May 2023 05:15:09 +0000
Message-ID: <8f979080-0e38-cd5d-e668-1e090b18e345@microchip.com>
References: <20230508104801.445261-1-claudiu.beznea@microchip.com>
 <20230508104801.445261-3-claudiu.beznea@microchip.com>
 <deb13eb1-7d6e-27a8-738d-70ba70358e71@linaro.org>
In-Reply-To: <deb13eb1-7d6e-27a8-738d-70ba70358e71@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|IA1PR11MB6467:EE_
x-ms-office365-filtering-correlation-id: 4758ff27-dd23-4678-2cdb-08db504c5bcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8IaAjUQR9MmpV0iM2MyGnFJKw9w81hzKgLh9tUrGQo0tfcbvtPv0WYX2y9CndwR18Y6hTD/LwHPdTiObVbliHE5Sk6y0kTDAuh8ZDOW1ip5Sf1+1YyWcO9z09G309t3nu+ryV3qlTchgPRSgAJRzxAhFr7A23Jk3skuUcX9+m14WVf4gxzWZvKihvTvZpeAgtIi5eEqyqx+QY/s7feqI96hZ7ISZUh1zapedzQpE91upM3xNCrA2hrIW5Ek7KiJVLfoCu+8voNj4kCVgpI7U7gPlJIBFiW4+eqT80cCc6+643JOzmaIEd9EyEOcI9s8OFiCmpsOiC+XoT47JH/EwlehKKe7Ybb9C6j6taNHFLCSus0SkjRHEncKIv+PNryvaJohWAPkV2vCYxA+v+Zsi6u4iERQ2IocAlv4IbpBBcej06S1pjKT0O7lpztV2ByDsHwX7LkspmQNZerzEDWs0VvkTECXUb96MzIP4N0Rc8nZ9+SGGOwVa0AuM/iGJ3I3ujjYE7IBzyaW5tSUutA2wDK4k7j5Dyvpg9rTIfvGWjSTa27SBF1lNHGbkpz9geGozQAMosMwRJoi4/TyAyBIFUOEpxLQBvPQnUhSB3bk0G7r4N2kYqtdSPKzHZrKlZKJTf73IeKhk0W02IAJiHSdaodATEo5Ouoy/RUJazeSxnL9ZYFYEQJ/dBcto3xeqf+SMWOrCHtj9No+DbCb7BDCD0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(2906002)(316002)(54906003)(110136005)(478600001)(41300700001)(8676002)(8936002)(71200400001)(76116006)(66476007)(4326008)(5660300002)(64756008)(66946007)(66446008)(66556008)(7416002)(91956017)(31686004)(6486002)(966005)(53546011)(6512007)(6506007)(26005)(186003)(36756003)(2616005)(83380400001)(38070700005)(38100700002)(31696002)(86362001)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFkrK1h1OVljTHlBV0hsMkJrT1V0ZmlsbVRZTUZXK1grSmZZWkFMaDJaMVJz?=
 =?utf-8?B?UmZJaWY1OFdycnFSeEswRUs5SFExejNpOWthQmFRTjZ2c2d6ZFgyTUw4bElv?=
 =?utf-8?B?TXk1NmdZL2wvZVdJYi8vRi9jSlNNZHZFQUR1STQ3N2VKUXZMcHNPZmZncGhP?=
 =?utf-8?B?b3lsV2gvRTU4S0ovbXVMTFJTRDhOc2dCMjJoRkxGNXFiTzcybjZnUWxpdk5L?=
 =?utf-8?B?NkpQQVpKakU0ZXAxcHVvREhUMWk4aDNaeitKNGRMZ2hiY1M0SHdwdDRhTXB2?=
 =?utf-8?B?V2tFa1BGN3pzVzN1R3F5cVhxU21oem5JVllhK1hoM2VZQzV3dFN1bUVPTFBz?=
 =?utf-8?B?dW9weFhlWnZCZXhuMlRYUkhVN1FidjhhZVVNRkgwUTFFRHlqL3RqV3VQUm5Z?=
 =?utf-8?B?Mlp1YnJ5UlNNUWhaTDJIaFlpMTMzOC9DMFV4R2dqN0RYZ1pPUVFtV1pFZVk1?=
 =?utf-8?B?cUFRTW5BWHhnK2RmM2VsU1lQVDBvMG9XWVZXb3ZXUmJhdEx4K2VUYWloQWN6?=
 =?utf-8?B?aVcxSzU0N0YyMFY2WGdxcE9FRktueEVSUHJMZlRGbzIxRnUwbmpkYlo5aGI0?=
 =?utf-8?B?L004Um0xN2xaSDVWelV3d3RuR2w4dExFOWxhQlVuT0w4cWJibmZlYnpRYWxa?=
 =?utf-8?B?ZDVvWEF5QkhSeXdKbmlNbGdSKyt1TWJBMU81TFNmNCt5MHRGc1NLdGJwNFNq?=
 =?utf-8?B?ZDdEdGhWZEhBL1RsVW14ckNtN0VTVHFod3FGTUxoSkRuK1hLa2RJVElEUHpo?=
 =?utf-8?B?WWxzSDdHRmNpYXM1djlLckJLamZhUkVWaFlTUUZkNVlleGZPZ2pLS2xsSVBL?=
 =?utf-8?B?R2Njb3VxYy90c01JMFZxcnJ6eUJKaWx6UVcwL2ljeS9oWTFNbnZMbnJXcXov?=
 =?utf-8?B?MzliTzdUcVh4WFBwOGZCOUdzcS9Uakd3a3BMemk5eFpVaHF4cUYzMzg4NjJG?=
 =?utf-8?B?UjVaN0NocjdRbkNMK1hHS285QlNMWWhjNm5lL2UrZU5qbytKVjArR3B6ZURL?=
 =?utf-8?B?Tno0S0pMeDNRUmFYa0lUUVI5WVZTMG5YZlphdXlFS25ocSswR0lEdENmMkEx?=
 =?utf-8?B?SmZtTG5NZ2ZvZ0o0OTB0R0RhMTBLaXpMMGFqU3VBS2F5QVZvSDZ1SkVyQ0RF?=
 =?utf-8?B?RStWNzRQOUQ5YWdXRU10T291TDNYbFZ6VldLK1JGdzVPOVU0TlNjenZybmpx?=
 =?utf-8?B?aWRwdXllNm1lK3FoOFVIclVBTmp1RE5ROVhqWkZwU2t2VE52TU5MOUdiMXFI?=
 =?utf-8?B?blZIdUhreCtKb1NGaXQ1L1ZObGcwVDVWaWdUbzRoOGhnd0NiclZhQ0pja0x3?=
 =?utf-8?B?YjZLa0xKaHdwWUtzVTkwRW5sTGY1bXg0K2hVRnJHNjVEVExBK0ZzaWpEdzkx?=
 =?utf-8?B?VndhMTdBRzFYSXpZczY0L2dyaVZvK3V4V200RE9ab2w4a3YvdmFwejE0Nzlq?=
 =?utf-8?B?MmRZTXVCMkZ0WFJwV0F3SFV2ZGpFUlV6Vk9wa0hZY1RGY0dYWE9LMUgyOXdx?=
 =?utf-8?B?MzlzeW5vdFhWbS9EMysvQ0c3azJqbDdCamRkYm5mcTAzalZ2VUNjM2ZJMUZL?=
 =?utf-8?B?YXZGeFlUTzVrMzVHVVRLbWhKZzZuUTl0Rkg1ZzJybkhyUzZYcHRnRXdlWG9p?=
 =?utf-8?B?akV2RUQxTUsvTVlQL3E0aXB4Nk52clk5TTdrQmRsZGRnMEh2L3phL1FZdUN1?=
 =?utf-8?B?WGhJMVB4N3dPQXJ2Z0RadU1HOEduN2wwMmJ5aTc5U1VCNnZEOUUxeHB6VnQ3?=
 =?utf-8?B?RVU5dFBDMGs5MG5NR0NQZFc4NVhBRkxjQzBwNVQ4aTl2Q3hzRTgyWEw0ck5o?=
 =?utf-8?B?aTYrdWxnanYyTWwrQ3ZTVmtEaWlRdzFmdGxRcElWMlhjeWEvdVZwbVZuTUlj?=
 =?utf-8?B?T3dwMk50enRaRnVPb2xzYWZqYkl1YmRpM25uUTdWQzJqK3FURklKeS9pc21q?=
 =?utf-8?B?b0svNm42NGlCZU9lcVZZbVRXUCtVejVNTTN4STAzTDRMVkNQRTlVZCtYRFBk?=
 =?utf-8?B?dU5jYXEzVmI4bDRzMUg2bmVHQ2RhdTZVTGVFeHhNbjBwS2RMV2NkU3hnbzQ4?=
 =?utf-8?B?RHBXbW5VS3hwYlFXWVZzK3VnSThjQjcwT2d0bnZYK3RUdytxM3oxU2t0dHFs?=
 =?utf-8?B?Ymo2NWEyenZCY2RhL3BFLzREcXJWdmlySXUxV3FzYmVXVi9mTFNla1p4ZTJo?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A20547340E6BF54C9E37CA9C89A74CE3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4758ff27-dd23-4678-2cdb-08db504c5bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 05:15:09.0680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVbRj3Nv+jEBOivEOBzn/PSa6dhfLpZqmIVt5xutEDVTQMx8joxsIbEMJQDgAI8y+1JvVHLecEMkE16Mgh0fRgcLW8oCKOg8ZMGHjZSdCBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6467
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDUuMjAyMyAxOToyNiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwOC8wNS8yMDIzIDEyOjQ3LCBD
bGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IENvbnZlcnQgQXRtZWwgUE1DIGRvY3VtZW50YXRpb24g
dG8geWFtbC4NCj4gDQo+IFBsZWFzZSBtZW50aW9uIHRoZSBjaGFuZ2VzIGFnYWluc3Qgb3JpZ2lu
YWwgYmluZGluZy4gQXQgbGVhc3QNCj4gY2xvY2stbmFtZXMgbG9vayBkaWZmZXJlbnQsIG1heWJl
IG1vcmUuDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1
LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvY2xvY2svYXQ5MS1jbG9jay50eHQgIHwgIDI4IC0tLS0NCj4+ICAuLi4vYmluZGluZ3MvY2xv
Y2svYXRtZWwsYXQ5MXJtOTIwMC1wbWMueWFtbCAgfCAxNTQgKysrKysrKysrKysrKysrKysrDQo+
PiAgMiBmaWxlcyBjaGFuZ2VkLCAxNTQgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQo+
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9j
bG9jay9hdG1lbCxhdDkxcm05MjAwLXBtYy55YW1sDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdDkxLWNsb2NrLnR4dCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdDkxLWNsb2NrLnR4dA0KPj4gaW5k
ZXggMTNmNDVkYjNiNjZkLi41NzM5NDc4NWQzYjAgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svYXQ5MS1jbG9jay50eHQNCj4+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdDkxLWNsb2NrLnR4dA0KPj4g
QEAgLTI4LDMxICsyOCwzIEBAIEZvciBleGFtcGxlOg0KPj4gICAgICAgICAgICAgICAjY2xvY2st
Y2VsbHMgPSA8MD47DQo+PiAgICAgICB9Ow0KPj4NCj4+IC1Qb3dlciBNYW5hZ2VtZW50IENvbnRy
b2xsZXIgKFBNQyk6DQo+PiAtDQo+PiAtUmVxdWlyZWQgcHJvcGVydGllczoNCj4+IC0tIGNvbXBh
dGlibGUgOiBzaGFsbCBiZSAiYXRtZWwsPGNoaXA+LXBtYyIsICJzeXNjb24iIG9yDQo+PiAtICAg
ICAibWljcm9jaGlwLHNhbTl4NjAtcG1jIg0KPj4gLSAgICAgPGNoaXA+IGNhbiBiZTogYXQ5MXJt
OTIwMCwgYXQ5MXNhbTkyNjAsIGF0OTFzYW05MjYxLA0KPj4gLSAgICAgYXQ5MXNhbTkyNjMsIGF0
OTFzYW05ZzQ1LCBhdDkxc2FtOW4xMiwgYXQ5MXNhbTlybCwgYXQ5MXNhbTlnMTUsDQo+PiAtICAg
ICBhdDkxc2FtOWcyNSwgYXQ5MXNhbTlnMzUsIGF0OTFzYW05eDI1LCBhdDkxc2FtOXgzNSwgYXQ5
MXNhbTl4NSwNCj4+IC0gICAgIHNhbWE1ZDIsIHNhbWE1ZDMgb3Igc2FtYTVkNC4NCj4+IC0tICNj
bG9jay1jZWxscyA6IGZyb20gY29tbW9uIGNsb2NrIGJpbmRpbmc7IHNoYWxsIGJlIHNldCB0byAy
LiBUaGUgZmlyc3QgZW50cnkNCj4+IC0gIGlzIHRoZSB0eXBlIG9mIHRoZSBjbG9jayAoY29yZSwg
c3lzdGVtLCBwZXJpcGhlcmFsIG9yIGdlbmVyYXRlZCkgYW5kIHRoZQ0KPj4gLSAgc2Vjb25kIGVu
dHJ5IGl0cyBpbmRleCBhcyBwcm92aWRlZCBieSB0aGUgZGF0YXNoZWV0DQo+PiAtLSBjbG9ja3Mg
OiBNdXN0IGNvbnRhaW4gYW4gZW50cnkgZm9yIGVhY2ggZW50cnkgaW4gY2xvY2stbmFtZXMuDQo+
PiAtLSBjbG9jay1uYW1lczogTXVzdCBpbmNsdWRlIHRoZSBmb2xsb3dpbmcgZW50cmllczogInNs
b3dfY2xrIiwgIm1haW5feHRhbCINCj4+IC0NCj4+IC1PcHRpb25hbCBwcm9wZXJ0aWVzOg0KPj4g
LS0gYXRtZWwsb3NjLWJ5cGFzcyA6IGJvb2xlYW4gcHJvcGVydHkuIFNldCB0aGlzIHdoZW4gYSBj
bG9jayBzaWduYWwgaXMgZGlyZWN0bHkNCj4+IC0gIHByb3ZpZGVkIG9uIFhJTi4NCj4+IC0NCj4+
IC1Gb3IgZXhhbXBsZToNCj4+IC0gICAgIHBtYzogcG1jQGYwMDE4MDAwIHsNCj4+IC0gICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQ0LXBtYyIsICJzeXNjb24iOw0KPj4gLSAg
ICAgICAgICAgICByZWcgPSA8MHhmMDAxODAwMCAweDEyMD47DQo+PiAtICAgICAgICAgICAgIGlu
dGVycnVwdHMgPSA8MSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPj4gLSAgICAgICAgICAgICAj
Y2xvY2stY2VsbHMgPSA8Mj47DQo+PiAtICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xrMzJrPiwg
PCZtYWluX3h0YWw+Ow0KPj4gLSAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJzbG93X2NsayIs
ICJtYWluX3h0YWwiOw0KPj4gLSAgICAgfTsNCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svYXRtZWwsYXQ5MXJtOTIwMC1wbWMueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdG1lbCxhdDkxcm05MjAwLXBt
Yy55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi41
OGI3MDI1MjA2MDANCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdG1lbCxhdDkxcm05MjAwLXBtYy55YW1sDQo+PiBAQCAt
MCwwICsxLDE1NCBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9u
bHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4gKyVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0
cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvY2xvY2svYXRtZWwsYXQ5MXJtOTIwMC1wbWMueWFt
bCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUu
eWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogQXRtZWwgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sbGVy
IChQTUMpDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIENsYXVkaXUgQmV6bmVhIDxj
bGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOg0KPj4g
KyAgVGhlIHBvd2VyIG1hbmFnZW1lbnQgY29udHJvbGxlciBvcHRpbWl6ZXMgcG93ZXIgY29uc3Vt
cHRpb24gYnkgY29udHJvbGxpbmcgYWxsDQo+PiArICBzeXN0ZW0gYW5kIHVzZXIgcGVyaXBoZXJh
bCBjbG9ja3MuIFRoZSBQTUMgZW5hYmxlcy9kaXNhYmxlcyB0aGUgY2xvY2sgaW5wdXRzDQo+PiAr
ICB0byBtYW55IG9mIHRoZSBwZXJpcGhlcmFscyBhbmQgdG8gdGhlIHByb2Nlc3Nvci4NCj4+ICsN
Cj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgb25lT2Y6DQo+PiAr
ICAgICAgLSBpdGVtczoNCj4+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTkyNjAt
cG1jDQo+PiArICAgICAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KPiANCj4gTm8gaW1wcm92ZW1lbnRz
IGhlcmUuIFdoeSB0aGlzIGlzIHBhcnQgb2YgdGhpcyBncm91cCBub3QgdGhlIG9uZSBhdCB0aGUN
Cj4gZW5kPyBJIGFscmVhZHkgdGFsa2VkIGFib3V0IHRoaXMuDQoNCkkgbWlzc2VkIGl0LiBJdCB3
aWxsIGJlIGhhbmRsZWQgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiANCj4+ICsgICAgICAt
IGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGVudW06DQo+PiArICAgICAgICAgICAgICAtIGF0bWVs
LGF0OTFzYW05ZzE1LXBtYw0KPj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOWcyMC1w
bWMNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTlnMjUtcG1jDQo+PiArICAgICAg
ICAgICAgICAtIGF0bWVsLGF0OTFzYW05ZzM1LXBtYw0KPj4gKyAgICAgICAgICAgICAgLSBhdG1l
bCxhdDkxc2FtOXgyNS1wbWMNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTl4MzUt
cG1jDQo+PiArICAgICAgICAgIC0gZW51bToNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5
MXNhbTkyNjAtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05eDUtcG1jDQo+
PiArICAgICAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAg
ICAgICAgIC0gZW51bToNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXJtOTIwMC1wbWMN
Cj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTlnNDUtcG1jDQo+PiArICAgICAgICAg
ICAgICAtIGF0bWVsLGF0OTFzYW05bjEyLXBtYw0KPj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxh
dDkxc2FtOXJsLXBtYw0KPj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxzYW1hNWQyLXBtYw0KPj4g
KyAgICAgICAgICAgICAgLSBhdG1lbCxzYW1hNWQzLXBtYw0KPj4gKyAgICAgICAgICAgICAgLSBh
dG1lbCxzYW1hNWQ0LXBtYw0KPj4gKyAgICAgICAgICAgICAgLSBtaWNyb2NoaXAsc2FtOXg2MC1w
bWMNCj4+ICsgICAgICAgICAgICAgIC0gbWljcm9jaGlwLHNhbWE3ZzUtcG1jDQo+PiArICAgICAg
ICAgIC0gY29uc3Q6IHN5c2Nvbg0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczog
MQ0KPj4gKw0KPj4gKyAgaW50ZXJydXB0czoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+
ICsgICIjY2xvY2stY2VsbHMiOg0KPj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPj4gKyAgICAgIC0g
MXN0IGNlbGwgaXMgdGhlIGNsb2NrIHR5cGUsIG9uZSBvZiBQTUNfVFlQRV9DT1JFLCBQTUNfVFlQ
RV9TWVNURU0sDQo+PiArICAgICAgICBQTUNfVFlQRV9QRVJJUEhFUkFMLCBQTUNfVFlQRV9HQ0ss
IFBNQ19UWVBFX1BST0dSQU1NQUJMRSAoYXMgZGVmaW5lZA0KPj4gKyAgICAgICAgaW4gPGR0LWJp
bmRpbmdzL2Nsb2NrL2F0OTEuaD4pDQo+PiArICAgICAgLSAybmQgY2VsbCBpcyB0aGUgY2xvY2sg
aWRlbnRpZmllciBhcyBkZWZpbmVkIGluIDxkdC1iaW5kaW5ncy9jbG9jay9hdDkxLmgNCj4+ICsg
ICAgICAgIChmb3IgY29yZSBjbG9ja3MpIG9yIGFzIGRlZmluZWQgaW4gZGF0YXNoZWV0IChmb3Ig
c3lzdGVtLCBwZXJpcGhlcmFsLA0KPj4gKyAgICAgICAgZ2NrIGFuZCBwcm9ncmFtbWFibGUgY2xv
Y2tzKS4NCj4+ICsgICAgY29uc3Q6IDINCj4+ICsNCj4+ICsgIGNsb2NrczoNCj4+ICsgICAgbWlu
SXRlbXM6IDINCj4+ICsgICAgbWF4SXRlbXM6IDMNCj4+ICsNCj4+ICsgIGNsb2NrLW5hbWVzOg0K
Pj4gKyAgICBtaW5JdGVtczogMg0KPj4gKyAgICBtYXhJdGVtczogMw0KPj4gKw0KPj4gKyAgYXRt
ZWwsb3NjLWJ5cGFzczoNCj4+ICsgICAgZGVzY3JpcHRpb246IHNldCB3aGVuIGEgY2xvY2sgc2ln
bmFsIGlzIGRpcmVjdGx5IHByb3ZpZGVkIG9uIFhJTg0KPj4gKyAgICB0eXBlOiBib29sZWFuDQo+
PiArDQo+PiArcmVxdWlyZWQ6DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gcmVnDQo+PiAr
ICAtIGludGVycnVwdHMNCj4+ICsgIC0gIiNjbG9jay1jZWxscyINCj4+ICsgIC0gY2xvY2tzDQo+
PiArICAtIGNsb2NrLW5hbWVzDQo+PiArDQo+PiArYWxsT2Y6DQo+PiArICAtIGlmOg0KPj4gKyAg
ICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICBjb21wYXRpYmxlOg0KPj4gKyAgICAgICAgICBj
b250YWluczoNCj4+ICsgICAgICAgICAgICBlbnVtOg0KPj4gKyAgICAgICAgICAgICAgLSBtaWNy
b2NoaXAsc2FtOXg2MC1wbWMNCj4+ICsgICAgICAgICAgICAgIC0gbWljcm9jaGlwLHNhbWE3ZzUt
cG1jDQo+PiArICAgIHRoZW46DQo+PiArICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgIGNs
b2NrczoNCj4+ICsgICAgICAgICAgbWluSXRlbXM6IDMNCj4+ICsgICAgICAgICAgbWF4SXRlbXM6
IDMNCj4+ICsgICAgICAgIGNsb2NrLW5hbWVzOg0KPj4gKyAgICAgICAgICBpdGVtczoNCj4+ICsg
ICAgICAgICAgICAtIGNvbnN0OiB0ZF9zbGNrDQo+PiArICAgICAgICAgICAgLSBjb25zdDogbWRf
c2xjaw0KPj4gKyAgICAgICAgICAgIC0gY29uc3Q6IG1haW5feHRhbA0KPj4gKw0KPj4gKyAgLSBp
ZjoNCj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgY29tcGF0aWJsZToNCj4+ICsg
ICAgICAgICAgY29udGFpbnM6DQo+PiArICAgICAgICAgICAgZW51bToNCj4+ICsgICAgICAgICAg
ICAgIC0gYXRtZWwsYXQ5MXJtOTIwMC1wbWMNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5
MXNhbTkyNjAtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05ZzIwLXBtYw0K
Pj4gKyAgICB0aGVuOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICBjbG9ja3M6
DQo+PiArICAgICAgICAgIG1pbkl0ZW1zOiAyDQo+PiArICAgICAgICAgIG1heEl0ZW1zOiAyDQo+
PiArICAgICAgICBjbG9jay1uYW1lczoNCj4+ICsgICAgICAgICAgaXRlbXM6DQo+PiArICAgICAg
ICAgICAgLSBjb25zdDogc2xvd194dGFsDQo+PiArICAgICAgICAgICAgLSBjb25zdDogbWFpbl94
dGFsDQo+PiArDQo+PiArICAtIGlmOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAg
ICBjb21wYXRpYmxlOg0KPj4gKyAgICAgICAgICBjb250YWluczoNCj4+ICsgICAgICAgICAgICBl
bnVtOg0KPj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxzYW1hNWQ0LXBtYw0KPj4gKyAgICAgICAg
ICAgICAgLSBhdG1lbCxzYW1hNWQzLXBtYw0KPj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxzYW1h
NWQyLXBtYw0KPiANCj4gS2VlcCBzaW1pbGFyIG9yZGVyIGFzIGluIGNvbXBhdGlibGVzIGxpc3Qs
IGUuZy4gYWxwaGFudW1lcmljLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4g
DQoNCg==
