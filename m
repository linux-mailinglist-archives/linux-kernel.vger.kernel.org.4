Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1D06F8340
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjEEMqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjEEMqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:46:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FD21AECD;
        Fri,  5 May 2023 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683290799; x=1714826799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L0C39dKqXXaTblVgrAdHL/mBzbKzecTJA8doF+wINGg=;
  b=BBNROnFEPZD6cK74TH8feT5DgchJj03oGkpH0/6OygFpLxUvapTIS9j4
   rKpPWR0Sr5qdhgonIVrUPX51c0qVbaguh16RUQAY3ek5FWF/A8o2mUi/h
   tDKRr6V4/Ey3HhGp3RuGkoknASbb9A4xw3sj5TjSGcqMhC5B8jJ1IixuP
   KfF7Jdt52Map5F5higQFPP5cjHy8lv/HvJNpA95gCzx5Gcv/GDx/Qxtbm
   YHqHefAFYJY366zVOsnh8Cjfxy2n8CK7rM9pTpj40QD2MstSDbO/F7OGR
   XYCpfal5oCOmydB1foub8MD9MdNmWd32ghL/8R2TgQjp6l7Hprx74Xx7d
   g==;
X-IronPort-AV: E=Sophos;i="5.99,252,1677567600"; 
   d="scan'208";a="150544945"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2023 05:46:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 5 May 2023 05:46:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 5 May 2023 05:46:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJwkPic18j+X+d6UCNRDqrbGLwHG0Sl5xQa09T+TuDT0Yn4oI6CSKetef5utriBTXhRphWroCOZTbJ2k0qq8pU1aaeuL/tp6t1cfqgYU+8LJgZEO9us8ohvrLPcBKoOwSm0cqvRqA3D+mu0kLGO0CPnEsJASPVIVe+djhS220ysuR6NHd7MqfMNtknl0MbKRbnDGFmywt7IMGFQGFzA9GlYVrp40qJZ55wCPv2rh8fuyTQQd9fxMippl3opunihvRenZYQ83MRuPJ28LHL1K/EgwKiqS7nELjNkBHtR8u+TORBtv8qDHR0ANIz4fVvA5y6KRPV/etBoUv7Lu2ILfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0C39dKqXXaTblVgrAdHL/mBzbKzecTJA8doF+wINGg=;
 b=e2QyqJqKPhfk74bStuoxFfaf55oBDQqXtt4BKSzMRi7xe3vWBUvbS80sqLD7zlzCH/tbquM2zAHMNs3I71j4DzCSnqIz6YIvm/M2Wn0qYEBHFoUFs72DS2Uh9B6nRYyjI+1ye/VImF+AnsilhUcA6LErps0sIgoCnqgm6OpoRHD981YV9YZl3xNo6bhlaLrN/DPwzlmfE4+8+FPWYrKDsRlnFbIYa/h0GyqQusjT/kcTfmi9jtAiEIk4pFNEdVjduH6ZYJZw3SejxPD3uFzO/23OUg5yvlKv1IItiLW8/36Sh6YUX+OeFMC/oi9LhwY5vuOmWxSOHiS5mLsdUbknuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0C39dKqXXaTblVgrAdHL/mBzbKzecTJA8doF+wINGg=;
 b=VEOFuCBJHxVNxo3Pv6fLooLOIVcWTUrH6U8mfsWJIYdYx/u3gEajSQ39XLlqiM8MSbHT8OlZoBlo5dPWfHmTinfS+1CTnqyWnrf+Y9r476psguU96NAKR3naRyWqBESl4Stdraum9tCLNhkZRLv2z/gsx+cUtSBfGoNaKREmMoc=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by PH7PR11MB6449.namprd11.prod.outlook.com (2603:10b6:510:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Fri, 5 May
 2023 12:46:32 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%2]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 12:46:32 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert to
 yaml
Thread-Topic: [PATCH 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
Thread-Index: AQHZf0+d7xYQyBphh0edH+sBnZTb1Q==
Date:   Fri, 5 May 2023 12:46:32 +0000
Message-ID: <a7a40eda-9487-833d-8b6a-788812e8b80c@microchip.com>
References: <20230504060729.689579-1-claudiu.beznea@microchip.com>
 <20230504060729.689579-3-claudiu.beznea@microchip.com>
 <a964eeef-1db0-0d8a-e2a5-9e4c5fd8b2f0@linaro.org>
In-Reply-To: <a964eeef-1db0-0d8a-e2a5-9e4c5fd8b2f0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|PH7PR11MB6449:EE_
x-ms-office365-filtering-correlation-id: 27ba0f64-aed5-4546-84a0-08db4d66c0e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWtQj9kQ1yYkBicwJF3GlkzE6L6bvO5BsDsHSGzBrQ62lfdyPNrhWH27BFkYOgh8WjYEH1yVHRSiRkvDVho26PHi+SDs6PpdLVw/c0jnChhFughsvnCy7rbXCnv9oAjkn/r3vq4UE4GDTXrUs3jBuv4XqnUc/b2uPu/sUxuv7/0hN1altT6Kny+UEwyH1eJfgXYCfwngM3ubo5tsJH6nsBs16bGraaHAvN/Is9hB4PG22hl/LUhrmzYtEIRcqd7YHkD2b/ty1RScTnaQR4OoOF/HGacsDyzbu4Hj/jMrCNm/71Pqqp5J72w2au5iuPQWEToXC9nbTXWAYBS3rD9yrhm1zGrTS390KoIp4DFrp87TTMUpxmpOS7tuTXifkBB29mQIN0yDNFbs/AQomzC/8mMe8lgC68k/pXsFx6oXag4f+3ZhMxpydo1llJl4zOqn5wnx6914cUpiUrOGTZypLl5BuasfeQ0vI7L4lQCGnYZwO4MLqcBRBd6rTKt/shiVVn8ZLfGIs4y0HdloaAKzB8CI5DpFAngwxzRnfdMZD1h9gJ9/EXTm8U1pxbveEf+Z3k6ZxwQ8iLpkTSNmvdkA7KnI0bF5kkrETvrfAbRXQ3vc1vUWc5brUtH+Bbfsn/64iVha6y5nlk0hnuW9pTPjuwZaOF5K5H2x8BvKxMHS4LvMxaDFjzICdv4RH9oP1Uq3qCN00ReCQsUnople9Na4F4YOAHz8cYF13IMBVKNwRFQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199021)(316002)(64756008)(66446008)(4326008)(66946007)(6486002)(2616005)(186003)(6512007)(26005)(53546011)(5660300002)(76116006)(66556008)(6506007)(66476007)(71200400001)(8936002)(41300700001)(8676002)(478600001)(7416002)(2906002)(91956017)(110136005)(54906003)(36756003)(38100700002)(122000001)(38070700005)(31696002)(86362001)(83380400001)(31686004)(87944012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTVVTDB3bEhwV3BRVWZsZGg1amJMY0VSSkRJTXFxdVl4VEZyZ3lTWFhYbHR6?=
 =?utf-8?B?TTJSTDNoeXFzbU15QnkxY3lKclMyMTBWUjFZUGVEM1hxWmZlTituRS9EUEU5?=
 =?utf-8?B?NVhjR2ZCN3FFaXNWTzI0YVZYQkRRK3BrQUY5aVpEK3BMNEJNeUFJWlIvYXNk?=
 =?utf-8?B?bnJXaVVBZm85YmZuQXV6TTBlOFFlMzkvRGVqR21XVnV5QnJXZkRhK3hPN2FS?=
 =?utf-8?B?RFpydE1BWXk3d29Nd3NDSFR5eThLTVN1MzYrdTNDdUJKeGlVRURBZXZJMTQ3?=
 =?utf-8?B?V29OTkNzRlBuTllkTWlOcmZOc3ByVTRLTTRiR1ZPNjRaMDg0Qk1KenRXaWQz?=
 =?utf-8?B?YzlXbXlhMXVUVDVJSXNBTzJLZEl0MDZiRTMrYUVzbXVTSGpuWnN0UTkxTi9V?=
 =?utf-8?B?cm1DanlTc1hUQzRHNldWTk1OVXlWQ0ZGaEY5TjYzTW9JY1cxcVdBQXBMRG5L?=
 =?utf-8?B?dGRFZlVZOXhiT2pEQXBsejhWRDN1Q2w4aEJQUFFSRncwbUJvU3J3SUJNREJT?=
 =?utf-8?B?aTRmdk9wUXNUeFZPRGtiWHhFUmpIR29LOTBTZDZ4T2IvUkJxcEJETVZ5cWU1?=
 =?utf-8?B?SE42MHduNTBMdTltV2pCZjU5cVE1TXBzRElIbFF6TzgxSHdDSERUZzNKZWZ1?=
 =?utf-8?B?OVZtMWpzd3FYL21lTnRSL1FtUmRDQWx1T1pBR0NONllsbTk4NzhsZENVTEJZ?=
 =?utf-8?B?TzROcDRrb2R1b2Z5a0piVGEyOTNGTlNOdVdROW9OYlN5bnF3S2hKbHNXZ3ZC?=
 =?utf-8?B?KzhzaWtWSnc1bTFQUUgxcXZEUEFRQjlMUURnK2hyZUF3c3BXeHhJaUFyOTZB?=
 =?utf-8?B?NWpJdXZaTXNGT1hyVS9IcTN3eEpGQW0rNFpKR0grRWtsSjVEdFdDek1za1Rn?=
 =?utf-8?B?ZVZWZDdhNlZ1cG5KbDJXUlFhNXh4VjR3eU5pcUd1b0lya3hpbjEzNkFtUDRU?=
 =?utf-8?B?Q1dId1NUYkRHNDExV0xuVnV5ZEkzNjBNQ1FFVHEwc3RwSFVoa242M2V3c0hJ?=
 =?utf-8?B?akduc2RkSkdFNWRObzhSNVAwR2d3S21NU3M2VEVlaTFTZ21VQ2pSTEtpaDRx?=
 =?utf-8?B?VUFHMGRybzIrVlphY2RUK2VKTmJXQW51SjRLZGpLL0lpaGY5aEgrUTNHVXps?=
 =?utf-8?B?aFE1dGlERytyaWVvdEJtbjMwa3R1anVESFlLQ09Pb2NNeWFUcFFBMnRjOG1I?=
 =?utf-8?B?ZU9HSU5OTzZXbXk0aVpuZU5zU1h3L3V5VlpOZFFNNTlyam9nTEFwRmU1cWJ0?=
 =?utf-8?B?VE85WWN4UDBmMVlCczBJT0c3ZGV0MDF6YkxKZWJTRHRTZk1FcS9VcG9veFpW?=
 =?utf-8?B?bzVjQTdoRHYvVXA2SHFLV3hiU3QvM3l2b245RHd2dHNQQnhpYWRDOUxoUEEr?=
 =?utf-8?B?SThmUi9VUWpZMXhxbHZzcVVUNE9ibm40VTIwSThVZ3pLaTkrNGZubytlZFNj?=
 =?utf-8?B?ZnJOM0c5ZlRZOUZ2bi9XTlhDV28vZGtLQVVXdWIvWlkwVUVkelpINloxUzV0?=
 =?utf-8?B?RlpwK2hwaVhTMEh5ZkxMOXIrZVQ3REdpMGI0VmFNSHRJbktkQ0VmV0tSSGtm?=
 =?utf-8?B?a1hjVG81WUl5WFRFWHVOLy80MGNCRDVkZ0F6UDgzRTFyZVFnMzhKa3BkbWZo?=
 =?utf-8?B?Zzk3M0UzUHJ2eFpMbDlLdCtoUTNNUjlNUTVxRXVDTFVGbmZsRTlNeVEraldH?=
 =?utf-8?B?anYwaUZOZ0szYU1PWDBsS3RyMG15VUFNMDlnbzBFR3o4Z0hvOFBNSTV1SFlC?=
 =?utf-8?B?d2V4Q2ozNXJnZzFQQlgvdGtGTzdXYWFxOVlEdUd6MEVkYng0N0F5Y1E3dVRa?=
 =?utf-8?B?VTFXR1JvaUtIZWdEeGkyUHg1N0FXMmJJTlhYY29qN2s5Z1JQQXlUeFkvbFFC?=
 =?utf-8?B?RGM5UEJTV1hDYXJGOGFGNXkyVE9HRWlwM2FHeHc5bFJidldudTRPVnZlakVw?=
 =?utf-8?B?UGpoUlZPRmgzSU8wQWREaEF6MEJqdC9jMzZudUJ4ZjJHTFoxUTF5TGlBTHFo?=
 =?utf-8?B?dndKSVRpQVN3cit3MFVoajA5b041UjhjMWFXcW11dWlMaXJZTzQzOWtLQnR3?=
 =?utf-8?B?SlE1OVE3UDJUK3BDWGg1T0NnbHdZUHM1S3FNdXg2MUFxcW9yRitVY0pHbWdt?=
 =?utf-8?Q?78sKMtkRFwOSiMhtFGaTW3J3R?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8ABE67ACDB7FA64488937AB5F372A9E4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ba0f64-aed5-4546-84a0-08db4d66c0e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 12:46:32.0639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jv6NCuybhCAxzRRqX/6sltR61U4vBOf0111216fITSJy6DyjFtIBRjExQx0rbozfg1Onx/3qzB2IWuNfuh+pzzQd6WG5genlWrzZUmtp8Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6449
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDUuMjAyMyAxNTo0NywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwNC8wNS8yMDIzIDA4OjA3LCBD
bGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IENvbnZlcnQgQXRtZWwgUE1DIGRvY3VtZW50YXRpb24g
dG8geWFtbC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5i
ZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4gVGhl
cmUgaXMgc29tZXRoaW5nIHRvIGRpc2N1c3MvaW1wcm92ZS4NCj4gDQo+IA0KPj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdG1lbCxhdDkxcm05
MjAwLXBtYy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2F0
bWVsLGF0OTFybTkyMDAtcG1jLnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRl
eCAwMDAwMDAwMDAwMDAuLmM0MDIzYzNhODVmMg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2F0bWVsLGF0OTFybTkyMDAt
cG1jLnlhbWwNCj4+IEBAIC0wLDAgKzEsMTYxIEBADQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlBTUwgMS4yDQo+PiAr
LS0tDQo+PiArJGlkOiAiaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvY2xvY2svYXRtZWws
YXQ5MXJtOTIwMC1wbWMueWFtbCMiDQo+PiArJHNjaGVtYTogImh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIyINCj4gDQo+IERyb3AgcXVvdGVzIGZyb20gYm90aC4N
Cj4gDQo+PiArDQo+PiArdGl0bGU6IEF0bWVsIFBvd2VyIE1hbmFnZW1lbnQgQ29udHJvbGxlciAo
UE1DKQ0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBDbGF1ZGl1IEJlem5lYSA8Y2xh
dWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlwdGlvbjoNCj4+ICsg
IFRoZSBwb3dlciBtYW5hZ2VtZW50IGNvbnRyb2xsZXIgb3B0aW1pemVzIHBvd2VyIGNvbnN1bXB0
aW9uIGJ5IGNvbnRyb2xsaW5nIGFsbA0KPj4gKyAgc3lzdGVtIGFuZCB1c2VyIHBlcmlwaGVyYWwg
Y2xvY2tzLiBUaGUgUE1DIGVuYWJsZXMvZGlzYWJsZXMgdGhlIGNsb2NrIGlucHV0cw0KPj4gKyAg
dG8gbWFueSBvZiB0aGUgcGVyaXBoZXJhbHMgYW5kIHRvIHRoZSBwcm9jZXNzb3IuDQo+PiArDQo+
PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIG9uZU9mOg0KPj4gKyAg
ICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFzYW05MjYwLXBt
Yw0KPiANCj4gV2h5IHRoaXMgaXMgc2VwYXJhdGUsIG5vdCBwYXJ0IG9mIGJvdHRvbSBlbnVtPw0K
DQpDdXJyZW50IGRldmljZSB0cmVlcyB1c2VzIHRoZSBmb2xsb3dpbmcgY29tcGF0aWJsZXMgKGFt
b25nIG90aGVycyk6DQotICJhdG1lbCxhdDkxc2FtOTI2MC1wbWMsICJzeXNjb24iIG9yDQotICJh
dG1lbCxhdDkxc2FtOWcyMC1wbWMiLCAiYXRtZWwsYXQ5MXNhbTkyNjAtcG1jLCAic3lzY29uIg0K
DQpJIGhhdmVuJ3QgZm91bmQgYW5vdGhlciB3YXkgdG8gbWFrZSBkdGJzX2NoZWNrIGhhcHB5Lg0K
SXMgdGhlcmUgYW5vdGhlciB3YXkgZm9yIHRoaXM/DQoNCj4gDQo+PiArICAgICAgICAgIC0gY29u
c3Q6IHN5c2Nvbg0KPiANCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGVudW06
DQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05ZzIwLXBtYw0KPj4gKyAgICAgICAg
ICAtIGVudW06DQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05MjYwLXBtYw0KPiAN
Cj4gVGhpcyBzaG91bGQgYmUgY29uc3QuIFlvdSBjYW5ub3QgaGF2ZSBoZXJlIGRpZmZlcmVudCBj
b21wYXRpYmxlcy4NCj4gDQo+PiArICAgICAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KPj4gKyAgICAg
IC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0gZW51bToNCj4+ICsgICAgICAgICAgICAgIC0gYXRt
ZWwsYXQ5MXNhbTlnMTUtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05ZzI1
LXBtYw0KPj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOWczNS1wbWMNCj4+ICsgICAg
ICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTl4MjUtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0
bWVsLGF0OTFzYW05eDM1LXBtYw0KPj4gKyAgICAgICAgICAtIGVudW06DQo+PiArICAgICAgICAg
ICAgICAtIGF0bWVsLGF0OTFzYW05eDUtcG1jDQo+PiArICAgICAgICAgIC0gY29uc3Q6IHN5c2Nv
bg0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0gZW51bToNCj4+ICsgICAgICAg
ICAgICAgIC0gYXRtZWwsYXQ5MXNhbTlnNDUtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0bWVs
LGF0OTFzYW05bjEyLXBtYw0KPj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOXJsLXBt
Yw0KPj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxcm05MjAwLXBtYw0KPiANCj4gT3JkZXIg
YnkgbmFtZT8NCj4gDQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLHNhbWE1ZDQtcG1jDQo+PiAr
ICAgICAgICAgICAgICAtIGF0bWVsLHNhbWE1ZDMtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0
bWVsLHNhbWE1ZDItcG1jDQo+PiArICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLXBt
Yw0KPj4gKyAgICAgICAgICAgICAgLSBtaWNyb2NoaXAsc2FtYTdnNS1wbWMNCj4+ICsgICAgICAg
ICAgLSBjb25zdDogc3lzY29uDQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0ZW1zOiAx
DQo+PiArDQo+PiArICAiI2Nsb2NrLWNlbGxzIjoNCj4+ICsgICAgY29uc3Q6IDINCj4gDQo+IEV4
cGxhaW4gd2hhdCB0aGUgY2VsbHMgYXJlIGZvciBpbiBkZXNjcmlwdGlvbi4gSGF2aW5nICcyJyBm
b3IgY2xvY2sNCj4gY29udHJvbGxlciBpcyBub3Qgb2J2aW91cy4NCj4gDQo+PiArDQo+PiArICBj
bG9ja3M6DQo+PiArICAgIG1pbkl0ZW1zOiAyDQo+PiArICAgIG1heEl0ZW1zOiAzDQo+PiArDQo+
PiArICBjbG9jay1uYW1lczoNCj4+ICsgICAgbWluSXRlbXM6IDINCj4+ICsgICAgbWF4SXRlbXM6
IDMNCj4+ICsNCj4+ICsgIGludGVycnVwdHM6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+
PiArICBhdG1lbCxvc2MtYnlwYXNzOg0KPj4gKyAgICB0eXBlOiBib29sZWFuDQo+PiArICAgIGRl
c2NyaXB0aW9uOiBzZXQgd2hlbiBhIGNsb2NrIHNpZ25hbCBpcyBkaXJlY3RseSBwcm92aWRlZCBv
biBYSU4NCj4+ICsNCj4+ICsNCj4gDQo+IEp1c3Qgb25lIGJsYW5rIGxpbmUuDQo+IA0KPj4gK3Jl
cXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+PiArICAtIHJlZw0KPj4gKyAgLSBpbnRlcnJ1
cHRzDQo+PiArICAtICIjY2xvY2stY2VsbHMiDQo+PiArICAtIGNsb2Nrcw0KPj4gKyAgLSBjbG9j
ay1uYW1lcw0KPiANCj4gS2VlcCB0aGUgc2FtZSBvcmRlciBoZXJlIGFzIHRoZXkgYXBwZWFyIGlu
IHByb3BlcnRpZXM6Lg0KPiANCj4gDQo+PiArDQo+PiArYWxsT2Y6DQo+PiArICAtIGlmOg0KPj4g
KyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICBjb21wYXRpYmxlOg0KPj4gKyAgICAgICAg
ICBjb250YWluczoNCj4+ICsgICAgICAgICAgICBlbnVtOg0KPj4gKyAgICAgICAgICAgICAgLSBt
aWNyb2NoaXAsc2FtOXg2MC1wbWMNCj4+ICsgICAgICAgICAgICAgIC0gbWljcm9jaGlwLHNhbWE3
ZzUtcG1jDQo+PiArICAgIHRoZW46DQo+PiArICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAg
IGNsb2NrczoNCj4+ICsgICAgICAgICAgbWluSXRlbXM6IDMNCj4+ICsgICAgICAgICAgbWF4SXRl
bXM6IDMNCj4+ICsgICAgICAgIGNsb2NrLW5hbWVzOg0KPj4gKyAgICAgICAgICBpdGVtczoNCj4+
ICsgICAgICAgICAgICAtIGNvbnN0OiB0ZF9zbGNrDQo+PiArICAgICAgICAgICAgLSBjb25zdDog
bWRfc2xjaw0KPj4gKyAgICAgICAgICAgIC0gY29uc3Q6IG1haW5feHRhbA0KPj4gKyAgICAgIHJl
cXVpcmVkOg0KPj4gKyAgICAgICAgLSBjbG9jay1uYW1lcw0KPj4gKyAgICAgICAgLSBjbG9ja3MN
Cj4gDQo+IERyb3AgcmVxdWlyZWQ6IGhlcmUuIEl0J3MgYWxyZWFkeSBpbiB0b3AtbGV2ZWwuIFNh
bWUgaW4gcGxhY2VzIGJlbG93Lg0KPiANCj4+ICsNCj4+ICsgIC0gaWY6DQo+PiArICAgICAgcHJv
cGVydGllczoNCj4+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+PiArICAgICAgICAgIGNvbnRhaW5z
Og0KPj4gKyAgICAgICAgICAgIGVudW06DQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFy
bTkyMDAtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05MjYwLXBtYw0KPj4g
KyAgICAgICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOWcyMC1wbWMNCj4+ICsgICAgdGhlbjoNCj4+
ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgY2xvY2tzOg0KPj4gKyAgICAgICAgICBt
aW5JdGVtczogMg0KPj4gKyAgICAgICAgICBtYXhJdGVtczogMg0KPj4gKyAgICAgICAgY2xvY2st
bmFtZXM6DQo+PiArICAgICAgICAgIGl0ZW1zOg0KPj4gKyAgICAgICAgICAgIC0gY29uc3Q6IHNs
b3dfeHRhbA0KPj4gKyAgICAgICAgICAgIC0gY29uc3Q6IG1haW5feHRhbA0KPj4gKyAgICAgIHJl
cXVpcmVkOg0KPj4gKyAgICAgICAgLSBjbG9jay1uYW1lcw0KPj4gKyAgICAgICAgLSBjbG9ja3MN
Cj4+ICsNCj4+ICsgIC0gaWY6DQo+PiArICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgIGNv
bXBhdGlibGU6DQo+PiArICAgICAgICAgIGNvbnRhaW5zOg0KPj4gKyAgICAgICAgICAgIGVudW06
DQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLHNhbWE1ZDQtcG1jDQo+PiArICAgICAgICAgICAg
ICAtIGF0bWVsLHNhbWE1ZDMtcG1jDQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLHNhbWE1ZDIt
cG1jDQo+PiArICAgIHRoZW46DQo+PiArICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgIGNs
b2NrczoNCj4+ICsgICAgICAgICAgbWluSXRlbXM6IDINCj4+ICsgICAgICAgICAgbWF4SXRlbXM6
IDINCj4+ICsgICAgICAgIGNsb2NrLW5hbWVzOg0KPj4gKyAgICAgICAgICBpdGVtczoNCj4+ICsg
ICAgICAgICAgICAtIGNvbnN0OiBzbG93X2Nsaw0KPj4gKyAgICAgICAgICAgIC0gY29uc3Q6IG1h
aW5feHRhbA0KPj4gKyAgICAgIHJlcXVpcmVkOg0KPj4gKyAgICAgICAgLSBjbG9jay1uYW1lcw0K
Pj4gKyAgICAgICAgLSBjbG9ja3MNCj4+ICsNCj4+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFs
c2UNCj4+ICsNCj4+ICtleGFtcGxlczoNCj4+ICsgIC0gfA0KPj4gKyAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+PiArDQo+PiArICAgIHBtYzog
Y2xvY2stY29udHJvbGxlckBmMDAxODAwMCB7DQo+PiArICAgICAgICBjb21wYXRpYmxlID0gImF0
bWVsLHNhbWE1ZDQtcG1jIiwgInN5c2NvbiI7DQo+PiArICAgICAgICByZWcgPSA8MHhmMDAxODAw
MCAweDEyMD47DQo+PiArICAgICAgICBpbnRlcnJ1cHRzID0gPDEgSVJRX1RZUEVfTEVWRUxfSElH
SCA3PjsNCj4gDQo+IGludGVycnVwdCBsb29rcyBhIGJpdCBvZGQuIEFyZSB5b3Ugc3VyZSBpdCBp
cyBjb3JyZWN0Pw0KDQpUaGlzIGV4YW1wbGUgaXMgZnJvbSBTQU1BNUQ0IFNvQyB3aGljaCB1c2Vz
IGEgdmVuZG9yIHNwZWNpZmljIGludGVycnVwdA0KY29udHJvbGxlciAoQXRtZWwgQUlDKSB3aGVy
ZToNCi0gMXN0IGNlbGwgaXMgdGhlIGludGVycnVwdCBudW1iZXINCi0gMm5kIGNlbGwgaXMgdGhl
IGludGVycnVwdCB0eXBlIChsZXZlbC9lZGdlIHNlbnNpdGl2ZSkNCi0gM3JkIGNlbGwgaXMgdGhl
IElSUSBwcmlvcml0eQ0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1DQoNCj4gDQo+PiArICAgICAgICAj
Y2xvY2stY2VsbHMgPSA8Mj47DQo+PiArICAgICAgICBjbG9ja3MgPSA8JmNsazMyaz4sIDwmbWFp
bl94dGFsPjsNCj4+ICsgICAgICAgIGNsb2NrLW5hbWVzID0gInNsb3dfY2xrIiwgIm1haW5feHRh
bCI7DQo+PiArICAgIH07DQo+PiArDQo+PiArLi4uDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0KPiANCg0K
