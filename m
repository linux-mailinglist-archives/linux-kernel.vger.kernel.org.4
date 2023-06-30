Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074517434C2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjF3GNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjF3GNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:13:09 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D612683;
        Thu, 29 Jun 2023 23:13:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoIrJPXFXjtC2T+xDgVNerIQxTfzG8DBmxAO9T6c70UWSIwFhLPHPYLAId+BzOIbhMqfFCQUe1zI9DjRwg/wXqodlaZbhN1C3UT1Q6HJYES+TkA80oZydlxDtyywQRXRgsFkn5FkQ1gl8I+6CVp839Agmu/Srby0i36Aq+OVXiqkJgr1k4T/mgOFKbkhTBCn+uPXr4rZiJPRrKtqwVUkA4CsxI2HahIPe0xUnllGG1pEmzWY1KoTW73KTuASDYScYAA9Nrp5kqFyo4Fdtx4mtAQ1RoHM+YTy2zJy/jge/aQWhZ5fPw3oP0op82uPCGtVS6x5xmfoinJ6t7FQIY8lLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68AEoLHaw7K5lA//P6P+EhZ+PRqLgrvIVdEXZScmZ04=;
 b=A35boGNQzzmQYP8TzhewSec1kMHmR7FjRIpHfqpOwdy+XkobPZ9uOM1AlT9/tdjIkMH7+2VL/LikLktfqXZEa/uIa8k2ZXOBXwurPitfGaq2BtqA00zlfm7Swl3FuDlzKrpYaiyDOdlvMcWzApzY4lmSaTaGt/nyweZ3Fx1q4pecKLqdWns78e+upOpq9tuL1wSZAvZtOPLZgKiH0tpXqrMlIRutQSyjSC+KPGx074+ySqzAEyjEyT6MEluZDwFRXzyxXtOcWI1VwnheUuo7CntyTHkkk51yEYtb9Rl6kAij+pi88yG37F3L6H7boKBxLfc22Xyd4VGb1QpKc4AeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68AEoLHaw7K5lA//P6P+EhZ+PRqLgrvIVdEXZScmZ04=;
 b=g7yJvAXjbED1ph5lBb7CRBfcgRZzhy3VTB9gTV6RnivWZ2J4zzNFrSzcNW7gmw9j6CmFvV1zhLDQT4t15zBpxzpALJXpMaZ/CdWZtGfyG+H2wNqRHuCccP4esbHVoNQBw9fSNqX9eGAbT2TMFHfZML8Vp/fpptPGWnUl2BHgcNaiEzeMfUFNc1UIXFQRM/8NYOuPSIP1WfGgqG2oNzdFjUt5ARhE32fanFQo2HcT0TEuFXA8/1Uk1UAKDjb8ogGm/+Do9cobRp67qUH0RFujHeDmxKVSDIzmx8IqZqSc16Dq8boH/1xIn2qnHoUHipLKdnhyLisJ9tzGq4dzYmqp9A==
Received: from TYZPR06MB6567.apcprd06.prod.outlook.com (2603:1096:400:465::12)
 by TYZPR06MB5733.apcprd06.prod.outlook.com (2603:1096:400:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Fri, 30 Jun
 2023 06:12:59 +0000
Received: from TYZPR06MB6567.apcprd06.prod.outlook.com
 ([fe80::7bcf:584c:587c:6340]) by TYZPR06MB6567.apcprd06.prod.outlook.com
 ([fe80::7bcf:584c:587c:6340%7]) with mapi id 15.20.6500.036; Fri, 30 Jun 2023
 06:12:59 +0000
From:   Dylan Hung <dylan_hung@aspeedtech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH] dt-bindings: clock: ast2600: Add I3C and MAC reset
 definitions
Thread-Topic: [PATCH] dt-bindings: clock: ast2600: Add I3C and MAC reset
 definitions
Thread-Index: AQHZpCUufmT2Rth+wkmDz+SvGV4yjK+VCR2AgA3iXHA=
Date:   Fri, 30 Jun 2023 06:12:59 +0000
Message-ID: <TYZPR06MB6567C8FC02D49C05439B6D549C2AA@TYZPR06MB6567.apcprd06.prod.outlook.com>
References: <20230621094545.707-1-dylan_hung@aspeedtech.com>
 <80cd8bb9-54ad-4c5c-f3ce-c8655cd2ff74@linaro.org>
In-Reply-To: <80cd8bb9-54ad-4c5c-f3ce-c8655cd2ff74@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6567:EE_|TYZPR06MB5733:EE_
x-ms-office365-filtering-correlation-id: aef9ffa2-9f18-45ef-aa8b-08db79310da4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B+/AuYd/DHU9iHx9pho5nMTVB3TUQEgT72+a1cP8LtrSOr0/1avMuKjXwfTskbIlDJmREsMfRkPbwPnMnJ9kKREFonzGoBJqKepPvtQamtkT6bUsugXn3h9IkA9PIjy5yGDItR5xg8YakFmAb+Buy+TXQbz8GeFXgn6begJn0pJw9igtPXy89auecgvoUxq8r590WRrIrxLh+nXe9ovOGfkhFIDuUTGDxfZJSMlS1vh6WKFrLyWjGJZ6Ztpd8beND/cW5vWfFJxiAp269/O0/P/GDVoB7rwRg4wMviRtJFRacAOQGmVZG56bnS3wuaKD/00SnTgwL74CmSu+Yjm6sw8fqWZXocbv9FaHdbY96nAagpBLfUSgW/+vLKtOlLAyvsG6R1TILYzRFnXzvcfr6O47XKR2bcXoAGDksvx9FQY09LaWMbq/H/s54GroSoq2KXTzk1oX+6BJH2jtY/AASU1TCmeYuv6bwVRAAJdPchj98KrGhwjnulK81xTow5wB0WSW4WHRfNXmeREs/m0FsOaWziRa7Tgc0yU1G+HKONOgFl/0oae00xlBEP1feuDXTES1BRrbntilJT09tEv08dR8hx4Vs/CkERt3mjYB0FoXOEKS/SY2Ygz+Wu+kDQ1M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6567.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39850400004)(346002)(136003)(396003)(451199021)(2906002)(186003)(55016003)(7696005)(71200400001)(122000001)(86362001)(107886003)(9686003)(38100700002)(83380400001)(53546011)(6506007)(110136005)(41300700001)(38070700005)(26005)(478600001)(316002)(76116006)(66556008)(66446008)(4326008)(66946007)(33656002)(64756008)(66476007)(5660300002)(52536014)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SC9HOEZuMjZ4eHBmZzluaXE4cDhKVG5aOWdIeHJuRmFlLzQ4NzRmTjBMOWxt?=
 =?utf-8?B?eDlwWUMyN2MyRzl2blBpeTVPRkZscXB0UzNYQzNkS084Rzc4Wi9wMWwyc1RH?=
 =?utf-8?B?UTUyZjFKM1NVS29YUkJvRFdPci9HTWlPaTlrbzJzQzdmK1B2VWtwdEE5cnpq?=
 =?utf-8?B?Sk9FKzZkYXh6S1phRDNGbFF4Vk5XZWFRQ05KQW1JNExHQVVXV0FZT0FOT29D?=
 =?utf-8?B?emN2ckZFcGtlaWxVcFg3MmV2SWFNL0JHS1JWNGdVbnVQbytkR1h2eDAycVN4?=
 =?utf-8?B?S1VGNWJpWFFUUHkzM3p1Z2xuQVNiWmE3Y2h4NitjTlJjZGMzMlQxaVVXd0Ir?=
 =?utf-8?B?VHlaTE5qRmJoZlVwMFJ6Y0dwci9jRCsrVWhndUIwN2luS2J4Mlc2TTVVU2c4?=
 =?utf-8?B?cWJ3SkJRSzA4OUVLb3VLY0JuZDZPWVFSL0tTb1VUblNsQVVUc0ZYenVGSkJ3?=
 =?utf-8?B?OUhOWHdWbS9KWGJseDBzalhRczFtaXVPWm1iMnd6NTJZcHI0aDBHcnBYUFZx?=
 =?utf-8?B?aGh2MThiR2RCUEgwdjRjczdtWUZzcFVEajVaV09rSnVBME1KUmQvWE85bkcv?=
 =?utf-8?B?TGowVEpJNDd6QzJFVFVIRFMrdmZvbnhoZHp4eU9xUHN5QXJtOEFob3l4bEhz?=
 =?utf-8?B?SjRYa0lCL2g4QW81WTJzaThRbitNc1JyMlREZzRGMG9kRmhyblJ4R2NTN1Fo?=
 =?utf-8?B?M0xLakZzbWZnYTlVZ080VS9iQmhmMERjakV5azYyZ3JpRmNQa0JvVWJXWmRz?=
 =?utf-8?B?aUdzcFFDZFJYTXlHSTFyTnpTWGRVSFo4QnV5dVFLTnJUZkdwd0hNMmxFMmV0?=
 =?utf-8?B?MWhCZVNlUS9QWnJVbVlnTGxhS0NVcEhBWW9PMUc3TkdCbkNlZDZLcUJ3YmZl?=
 =?utf-8?B?R3M4dFJ3WnFEMjU4cXJialdwcnlnSWhjbENFcnYyVGIwSU1sUVFnbzNhamJX?=
 =?utf-8?B?TUIzNUx5MzJ3YTAxKzRwUDFlaFBoaFNSNm9Gb0FtY01MdEYrVFhKLzNhdzUv?=
 =?utf-8?B?TjA1UUhtcVYybittT2VTbXo2Z3NQa1RhWnZhWWlIcHVNVEtTQXpqblo3aDlw?=
 =?utf-8?B?dmpxN3B0aGtmL1FoTVdlM2dhQTZFRk5NM0I4NlQ5cnU2TE1aV1ZiQXByejl3?=
 =?utf-8?B?UUV4b0REUkZHNk0yeXBzaU1tMDlzZ1IxblY3NFZ1TzFrTVBTTUxNSlB0alAv?=
 =?utf-8?B?NG5jTmF0OUFNVVpPQWRsTnEyTFhjZEJ5YjBad1pkeEo2SDFEbE55MEpRRW1L?=
 =?utf-8?B?cEo0a0tBM2JtemdZMkRsYWpYUE55bDhQUGxOc0poK2pJcVdOOVI3eWVhWnRX?=
 =?utf-8?B?UTRWb01rVjNOMW0wWW91S1c5Y293aXhycXFoVGJWYkhRWE1CejdtaGQ5K0Qx?=
 =?utf-8?B?TW5EbkVxUmU5b1hYYXh5c1RsUlpOQVBIVjZiMlF6MFY3L1JQWCs5QTNtcnIz?=
 =?utf-8?B?UXJ3SWhyQXUvQjBRN1BmWlczSEt4aHpvNzN6RzFLVW9oc3pwVVRnZjVXUGVr?=
 =?utf-8?B?a0hFQjJUQUdZZnphdVNndEEwL21uY1lGOUZjbGxkYmhTaCtyeEFLTEMxLzB3?=
 =?utf-8?B?eGxOTkR3WFNBYzQrZVhrV1JZdzhhWE5YS0VzOVZKUlhTbVBvMlFHRzdsUVg5?=
 =?utf-8?B?VUMzQU0yYW5aRG5HcmZNWHVCak5iUVhnK0FKRVdNMmtGTE8wazB6ZUQ4cmJE?=
 =?utf-8?B?NTZ5STc4MVFBYkVjVk05bGNjNGxkTFZNMkh3UnFJQ3VQRnpKS2krWVVFNHJX?=
 =?utf-8?B?MTV1QUNvR09tWG9YVEdKeHNCdmZxeXJEaWFGM1MzcW1rTHJ1T1FFRE5ZYndQ?=
 =?utf-8?B?N0xPUjA2YU9ZeDVIcHRQalRVSCtiTTcram5sOG5OSzZnZzN0WmJUZ3paOW9Q?=
 =?utf-8?B?OEU3bHJ1aTI1ZmEvRVlCQTdEUjFNV0lFODcvU3h3M05MRGhJWDlidkhXV0lF?=
 =?utf-8?B?R2htR2ZPRVRETkV4V2k2S2wwdUIzVnd0RWlKUk4zVldXenNmOVJOc1hiZlE0?=
 =?utf-8?B?anZENmVWT0VDUjgyM0hqcGllQ3AxQklIaTdJWUYxa3RjNHN0OGdKc1J4akVr?=
 =?utf-8?B?b3F0d001aDNZMzlwYzNmcGlpdUVYV0dQQVBPRWhkbFFnN05sRUpwUzduUjc0?=
 =?utf-8?Q?hwEN7yNgNku+4b6dV27j4KTEj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef9ffa2-9f18-45ef-aa8b-08db79310da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 06:12:59.2283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Smd8hCt8PfM/1fXYrlcEabqVStSx+CLSv9EC9pvugOH3u03rp8qvFGXDk8Zk5KGLoBk7msvoHOHte/awN1Se5W8TxD6AKJwxSzoRIp6hdv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IFttYWlsdG86a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnXQ0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bmUgMjEsIDIwMjMgNjoxMSBQTQ0KPiBUbzogRHlsYW4gSHVuZyA8ZHlsYW5faHVuZ0Bh
c3BlZWR0ZWNoLmNvbT47IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOw0KPiBzYm95ZEBrZXJuZWwu
b3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9y
ZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IEJNQy1TVyA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBkdC1iaW5kaW5nczogY2xvY2s6IGFzdDI2MDA6IEFkZCBJM0MgYW5kIE1BQyByZXNldA0K
PiBkZWZpbml0aW9ucw0KPiANCj4gT24gMjEvMDYvMjAyMyAxMTo0NSwgRHlsYW4gSHVuZyB3cm90
ZToNCj4gPiBBZGQgcmVzZXQgZGVmaW5pdGlvbnMgb2YgQVNUMjYwMCBJM0MgYW5kIE1BQyBjb250
cm9sbGVycy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IER5bGFuIEh1bmcgPGR5bGFuX2h1bmdA
YXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2sv
YXN0MjYwMC1jbG9jay5oIHwgMTMgKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXN0MjYwMC1jbG9jay5oDQo+IGIvaW5jbHVkZS9kdC1i
aW5kaW5ncy9jbG9jay9hc3QyNjAwLWNsb2NrLmgNCj4gPiBpbmRleCBlMTQ5ZWVlNjE1ODguLjA3
Mzc3NTg5ZjhmNCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2Fz
dDI2MDAtY2xvY2suaA0KPiA+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXN0MjYw
MC1jbG9jay5oDQo+ID4gQEAgLTkwLDcgKzkwLDE4IEBADQo+ID4gIC8qIE9ubHkgbGlzdCByZXNl
dHMgaGVyZSB0aGF0IGFyZSBub3QgcGFydCBvZiBhIGNsb2NrIGdhdGUgKyByZXNldCBwYWlyICov
DQo+ID4gICNkZWZpbmUgQVNQRUVEX1JFU0VUX0FEQwkJNTUNCj4gPiAgI2RlZmluZSBBU1BFRURf
UkVTRVRfSlRBR19NQVNURVIyCTU0DQo+ID4gLSNkZWZpbmUgQVNQRUVEX1JFU0VUX0kzQ19ETUEJ
CTM5DQo+IA0KPiBUaGlzIHdpbGwgYnJlYWsgYWxsIHRoZSB1c2Vycy4NCj4gDQoNCg0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
