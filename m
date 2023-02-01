Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7D968656E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjBALaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBALaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:30:20 -0500
Received: from mo-csw.securemx.jp (mo-csw1516.securemx.jp [210.130.202.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CC3CDC6;
        Wed,  1 Feb 2023 03:30:18 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 311BTlfc001819; Wed, 1 Feb 2023 20:29:47 +0900
X-Iguazu-Qid: 34tMMX4CAVVtKHt57Z
X-Iguazu-QSIG: v=2; s=0; t=1675250987; q=34tMMX4CAVVtKHt57Z; m=ceg39FDtwk5abuBZ+AgTRLXUzDPg78S+qo6NA1wb1A8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1512) id 311BTjMM031741
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 1 Feb 2023 20:29:46 +0900
X-SA-MID: 50148724
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/87MW4LRDqyhdarzjQazO4FX8uD5Ajk1VvDxbL1V8bOX1mJUeVB9iXdceKvn/mtbK9FdfYiOfQZnLt0C2TnAIBFexhVULwhf4mbsVbqo3nqBWuItHjiDr4OX+xMhSolLtvZyFsLpxBWIEV4bR5GN8b4YZZ8AVWuPHv6+hwcEHAhUfcY+EkYOaCFtCP4/+A/kzix/i8eyYdclYAK0MDLLt3ymRUo7RNC6DTBJUK3aMDsEIRqnaFbuZSGYzhZayBT1Wvc4bwFKzIRvdIa9TPO8Z9SFPmtRpLxmg/sGun+MlENEsMtuEL2VKKoudJtIJ9/fuS2vErUx0hIgnq6sGVN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJnj2fxThUgW/FRHY0mrjZ2o+b8RJRYaRkXIpnQodNI=;
 b=KczdB2ogpcKVGvR7Svi42DHH+mPAiglz/un64CCqSvxrCZjxNMz0IfcOtaRKKEMHHD/ElwuM/Lr1HEvlmmRwEjPSnG5PdAIQ6BMiDT6oHqOOlCRG2XdRLyCGUrAyFBT964YowifWbksb3b3iY29HcWPpBhsmatm7gcbvmNqfv6pLsy9o0wWqrTu9j3MqG7OtxWqRVj263KQ89mnWcylnmJ+pIaMws4r1yqPWqnjgfl7lK9hidI9weQBPpjgG/Nllg1yeUsFsN4nGV7OcjSXZiwWVZyR9LJl4LXDP+LYtVKmz0/63zm2M1X7Hb1XmRZG+PaLFgGXEeHW/IQlbldi73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <laurent.pinchart@ideasonboard.com>
CC:     <krzysztof.kozlowski@linaro.org>, <hverkuil@xs4all.nl>,
        <mchehab@kernel.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <rafael.j.wysocki@intel.com>, <broonie@kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Topic: [PATCH v5 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Index: AQHZJWPq25Efj94upEGIV2ZkL1BZ0q6ixVMAgAAEm4CAAARDAIAAEbOAgAgD9ACAC9mb0IADO7yAgAAa+tA=
Date:   Wed, 1 Feb 2023 11:24:37 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201ADC7331C42BE6A9248AF92D19@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-2-yuji2.ishikawa@toshiba.co.jp>
 <Y8a+Hk2jFOjbkIvZ@pendragon.ideasonboard.com>
 <d1bb1148-e273-f5bb-bccc-ceca82bb6836@linaro.org>
 <Y8bFjhHkbNAKQK3t@pendragon.ideasonboard.com>
 <c2740d66-b51f-efc2-6583-a69bde950c68@linaro.org>
 <Y82NtJCtr+CZgS9k@pendragon.ideasonboard.com>
 <TYAPR01MB6201BCC60149D17F59AD870E92D39@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <Y9o01ctDujKRXw2J@pendragon.ideasonboard.com>
In-Reply-To: <Y9o01ctDujKRXw2J@pendragon.ideasonboard.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TYCPR01MB5791:EE_
x-ms-office365-filtering-correlation-id: 2ac15c4c-eaf0-434b-1aa3-08db0446e71a
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KanDyje6WgSI0g8XuXl/CTsx+sDqm4RbECmXC46F1jCb45Cn+VqSL4QnEDvhsqHFZgmROSrAyJP67gUoNQ2NdGzpSxA+iXc+BglBlMTHNE3VAlhAetTX4OQHBDqx7t/Ney/zLK73Fna+s8gFCqzoZ3lODnvY8AGcBh8hzWH7o8WjHUyayoZWdSL46GOHNF5xXaOkxbRlyHKlUUYYL4cARMnrKDF/sw4T5EO4vjJdeTwt7j6vEL4HGs6URHoX+5IYaVICgWges9cyQ7SuXEekTqG7BlgGxvm8cde1aqKlDPVmPUbrsNx+Y+8Wp4n0/76mzYB68iE3v0iWnjq5wXFROdas9r5IsD5jt6peBrPb9PV7iEYz0IDSfbChMIciQP9PC6LUx6+rIXh0wuQkz8AVSviXPrid74u8AM3h9aSkOROTG9WfpZ2kr4q6oBqMrlgDwYr7kZXpfkgXyZJIpYR0dthOBKJHpRmzkRS4xCi+gxVHxf4CYoRI8a38jg+QAoNnnibtjlMk4UidmRfmnTUNlSKa6T+aWiCCwvPllDoV60izFUR+Y3lXP+O0Q/hSb4zOXd7wTxfXfXNPgdTNG/MCUgnQEEkx2CrCzeBwUqIk+Kv90Vc0BtWr9i90URVMPsoPfpPXkGhz6qFl/h23uBlWxhgY8RSmpY/nIN0VOBbx03Utk9oXNNl+ZUy4OkNmj9WIWpiRJ1Xf9rXRLoIbt0AbjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199018)(5660300002)(8936002)(7416002)(52536014)(38100700002)(122000001)(55016003)(86362001)(33656002)(38070700005)(41300700001)(54906003)(186003)(7696005)(478600001)(26005)(9686003)(71200400001)(316002)(6916009)(8676002)(64756008)(2906002)(66556008)(66946007)(66476007)(76116006)(66446008)(4326008)(83380400001)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlNETTVIdDQ2dHR6ZGJsVllWMUF0d1VUYjNQTDRSeDBrbUN1UUh0dTQzNG5F?=
 =?utf-8?B?VHBNcitGUUVXSDkvMUtCSVZtZVpFSmU3b1JvbUdGRU42U1RJa1JqUnRBcnlY?=
 =?utf-8?B?S0xaSE1rTVJQcUxTNGFiaVJockczQ2I1TTFXdHBIbUUxb1ZTcjJMenVUMEty?=
 =?utf-8?B?cjVzb0J6b2dtZkZpSDlNNTBMNHIrOGxvMi9ieEEwL1pCenA2TGpFOU9lK1BF?=
 =?utf-8?B?dHNUNjQxOFFCeXI5QTJZZ3FYeVZEWm9ZeW13MFowU3BCSUFtY2dhVy9xZWc2?=
 =?utf-8?B?RUxjTFVuTW5FQ2NjbGZaaXkyNC9hSnA1Ynd2TkJ3NWp4UG1pREpZdHQ2UVdB?=
 =?utf-8?B?T3VPc2lMM3B1VTZTdFVvVjVJc0dweHhLb3dlUVkrYTE4bFYvTVQzaWVtMUdD?=
 =?utf-8?B?SVBEY05KbDlLR3gxWE5HNHdWeGorZjlDNUYzRThpY096WkxGZWZ4RnFyM04v?=
 =?utf-8?B?U0FTSVdrTWhGSWtuM1VoUGkzeWpiMG1pWTBCUmtReTc4SWJFWmltNUMyVmdo?=
 =?utf-8?B?cCtTdEl2U3Z3UlJMcmlXbjNEV3piZHMyNHgzTVFGNnJIN2ZOVlM1OUpWTGJC?=
 =?utf-8?B?QXZCY1N5R1FvVjljRVVJVWJVRTFORnluR3FFNXNLSnpFTjVLWVVOQ3pQRURB?=
 =?utf-8?B?THArZGJ1MzZYL2ZNZU52cFdrSmhjSXZnR0dhR3k4YVRWUkZCN0hpcU9wcnJ5?=
 =?utf-8?B?aEhydndaUFJ2NVIxclhBcU1xZ0pFSE9CLzZzYjZRUEdzZUN6SzVmcjdhWjFa?=
 =?utf-8?B?cGRvdkRFU25NY2FXRnBxZ1Ewb3IvQmRweEp0WDRkNTNRcE80ZUM3ZEpYM1Nl?=
 =?utf-8?B?SlpXT0NQcTFsU3VSd1d0SHFxK2tzRjNmWUVyLzdGcUVmWHBjUVArUzlsWnow?=
 =?utf-8?B?bkllYUQvejVEZUZLb0pDL1lzckhtelZFTVJDRGdKOWp1cjJzNlF2bUdUTjVZ?=
 =?utf-8?B?UGdzMmo1Snd1SmdFWFR3ZGxQT2g1UW85TlptbDVmemV2UEwvaW4vZm04emVD?=
 =?utf-8?B?eEY4RURDQmtNVXAwQm8yYllxTjJEeTE5WjN0QkF3VDNGZElzWkl4SDlnT0xp?=
 =?utf-8?B?a2dYSGs2R0NFQjNudTBrZlBSaGsrVmhTd1R1TzBZSW0zUWNvNXZ0WlpTYVVz?=
 =?utf-8?B?dFY1TlhyRU9RQmcvYkVKaW9yLzcrSVAyYS9iSHA0Vk12b2lzTmpsTmdkY3VE?=
 =?utf-8?B?SFp6UER2c2V1WXJaTWc3aHRjTEt4VHNyRHVmRW5vS0IzYllwcjhySUVxRzlh?=
 =?utf-8?B?UmlIWm44cTM5ZGtrTjBRbXBmWHJjazdvbWpTSDhLakZnaUk0bGQ4ZUlrVjZX?=
 =?utf-8?B?eEF1YXZFSWRDL25jL0JZbGVyQ2FYcVNlL3A0bTNCckM0NE11ek82b0cwWDRY?=
 =?utf-8?B?dnBKaW5lekdydUhreG9IVGFpR1RrLzVSM1U3UnhMTW1ST2Z0MlhUY0M5MDcz?=
 =?utf-8?B?bkFudC9RSk1KWHlHczRrcEpGSERXUXB4L0NucFVwQnoxbE8velR2Q1doaWoz?=
 =?utf-8?B?a1FISU5qU3ZUYUwwVjhGZ3YvT054MCtyaDZSUyt2YUtmeVZ4dWgycnBCVkxG?=
 =?utf-8?B?NlVsMnUxWS9HRmY4WFR2TUtCQW9KaEZNK21wdUs4U2dtR2w1N1lXQjRUU3hI?=
 =?utf-8?B?K3VCTDNWb0F2S2hINjRCM0o1WFNKZFFRZExYNmtGYkpaQlFOQWFYU0xrT0sr?=
 =?utf-8?B?aW5ndWx3WXp5eVoxSDh5aWVaczcxL1dCMzhWK09pQTBKOFp0cnV4bVRUMWs4?=
 =?utf-8?B?TlJuN3FTVTFYQzR3ZzZYUnVnOU1YMnlFR0FrRS9BbXRhSnV0Ym5acGgySndq?=
 =?utf-8?B?RUY1MlhRdEN6R1dRQ24zZ3gwakNkMXRwZ1ZTeW9jMkZ6UjB1cXV0dWFyUTVi?=
 =?utf-8?B?U0w4ZFNIdGdnMTJBQmtLU1Z2dmRxbDZCUXQvQWUxTm9pSERXNnVNYnU1YmU0?=
 =?utf-8?B?ejhUZDBBb0NnZnlPcUlrdFdXU1pZK1lmQlBOcExQWW5GVzRCcm1tWUNob2F4?=
 =?utf-8?B?RHNmL2E3MG84MFN5amF2YlFTa0h3V21CQ296WDVkSzRTcTJMeXlpbkFzQ2xY?=
 =?utf-8?B?S2F1QlZoWkg4SW43SDlQQU1MVGpndlFXV3ZRMWFXNDRFd3FtcnVEM2NVSHll?=
 =?utf-8?B?TVl2cG11S1I2UWVXSGRMQjR2eUt5eGNhRTdoTC85VFl4S3FXYi9FMC9zMEVh?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac15c4c-eaf0-434b-1aa3-08db0446e71a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 11:24:37.4057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2qvFws8FuHcRFC+ALUh2RSjrwZ2Du5XLKTvC1SNmxjlbVNBWEHN2q6yHy/P5FNfk1Cwgxf94LZvY5YZYCHB0RraeRMO1yvhr424gsf02z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5791
X-OriginatorOrg: toshiba.co.jp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhdXJlbnQgUGluY2hhcnQg
PGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBG
ZWJydWFyeSAxLCAyMDIzIDY6NDYgUE0NCj4gVG86IGlzaGlrYXdhIHl1amko55+z5bedIOaCoOWP
uCDil4vvvLLvvKTvvKPilqHvvKHvvKnvvLTvvKPil4vvvKXvvKHplospDQo+IDx5dWppMi5pc2hp
a2F3YUB0b3NoaWJhLmNvLmpwPg0KPiBDYzoga3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3Jn
OyBodmVya3VpbEB4czRhbGwubmw7IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gaXdhbWF0c3Ugbm9i
dWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpDQo+IDxub2J1aGly
bzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6
dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyByYWZhZWwuai53eXNvY2tpQGludGVsLmNvbTsN
Cj4gYnJvb25pZUBrZXJuZWwub3JnOyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NSAxLzZdIGR0LWJpbmRpbmdzOiBtZWRpYTogcGxhdGZvcm06IHZpc2NvbnRpOiBBZGQg
VG9zaGliYQ0KPiBWaXNjb250aSBWaWRlbyBJbnB1dCBJbnRlcmZhY2UgYmluZGluZ3MNCj4gDQo+
IE9uIE1vbiwgSmFuIDMwLCAyMDIzIGF0IDA5OjA2OjI1QU0gKzAwMDAsIHl1amkyLmlzaGlrYXdh
QHRvc2hpYmEuY28uanAgd3JvdGU6DQo+ID4gT24gTW9uZGF5LCBKYW51YXJ5IDIzLCAyMDIzIDQ6
MjYgQU0sIExhdXJlbnQgUGluY2hhcnQgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEphbiAxNywgMjAy
MyBhdCAwNjowMToyN1BNICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+ID4g
PiBPbiAxNy8wMS8yMDIzIDE2OjU4LCBMYXVyZW50IFBpbmNoYXJ0IHdyb3RlOg0KPiA+ID4gPiA+
IE9uIFR1ZSwgSmFuIDE3LCAyMDIzIGF0IDA0OjQyOjUxUE0gKzAxMDAsIEtyenlzenRvZiBLb3ps
b3dza2kgd3JvdGU6DQo+ID4gPiA+ID4+IE9uIDE3LzAxLzIwMjMgMTY6MjYsIExhdXJlbnQgUGlu
Y2hhcnQgd3JvdGU6DQo+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+Pj4+ICsNCj4gPiA+ID4gPj4+PiAr
ICAgICAgICAgIGNsb2NrLWxhbmVzOg0KPiA+ID4gPiA+Pj4+ICsgICAgICAgICAgICBkZXNjcmlw
dGlvbjogVklJRiBzdXBwb3J0cyAxIGNsb2NrIGxpbmUNCj4gPiA+ID4gPj4+DQo+ID4gPiA+ID4+
PiBzL2xpbmUvbGFuZS8NCj4gPg0KPiA+IFNvcnJ5IGZvciBhIGxhdGUgcmVwbHkuDQo+ID4gSSds
bCBmaXggdGhlIGRlc2NyaXB0aW9uLg0KPiA+DQo+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+Pj4+ICsg
ICAgICAgICAgICBjb25zdDogMA0KPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPj4+IEkgd291bGQgYWxz
byBhZGQNCj4gPiA+ID4gPj4+DQo+ID4gPiA+ID4+PiAgICAgICAgICAgY2xvY2stbm9uY29udGlu
dW91czogdHJ1ZQ0KPiA+ID4gPiA+Pj4gICAgICAgICAgIGxpbmstZnJlcXVlbmNpZXM6IHRydWUN
Cj4gPiA+ID4gPj4+DQo+ID4gPiA+ID4+PiB0byBpbmRpY2F0ZSB0aGF0IHRoZSBhYm92ZSB0d28g
cHJvcGVydGllcyBhcmUgdXNlZCBieSB0aGlzIGRldmljZS4NCj4gPiA+ID4gPj4NCj4gPiA+ID4g
Pj4gTm8sIHRoZXNlIGFyZSBjb21pbmcgZnJvbSBvdGhlciBzY2hlbWEgYW5kIHRoZXJlIGlzIG5l
dmVyIG5lZWQNCj4gPiA+ID4gPj4gdG8gbWVudGlvbiBzb21lIHByb3BlcnR5IHRvIGluZGljYXRl
IGl0IGlzIG1vcmUgdXNlZCB0aGFuIG90aGVyIGNhc2UuDQo+ID4gPiA+ID4+IE5vbmUgb2YgdGhl
IGJpbmRpbmdzIGFyZSBjcmVhdGVkIHN1Y2ggd2F5LCBzbyB0aGlzIHNob3VsZCBub3QgYmUNCj4g
ZXhjZXB0aW9uLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlcmUgYXJlIHNvbWUgYmluZGluZ3Mg
dGhhdCBkbyBzbywgYnV0IHRoYXQgbWF5IG5vdCBiZSBhIGdvb2QNCj4gPiA+ID4gPiBlbm91Z2gg
cmVhc29uLCBhcyB0aGVyZSdzIGEgY2hhbmNlIEkgd3JvdGUgdGhvc2UgbXlzZWxmIDotKQ0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gSSB3b3VsZCBoYXZlIHN3b3JuIHRoYXQgYXQgc29tZSBwb2ludCBp
biB0aGUgcGFzdCB0aGUgc2NoZW1hDQo+ID4gPiA+ID4gd291bGRuJ3QgaGF2ZSB2YWxpZGF0ZWQg
dGhlIGV4YW1wbGUgd2l0aCB0aGlzIG9taXR0ZWQuIEknbSBub3QNCj4gPiA+ID4gPiBzdXJlIGlm
IHNvbWV0aGluZyBjaGFuZ2VkIG9yIGlmIEkgZ290IHRoaXMgd3JvbmcuDQo+ID4gPiA+DQo+ID4g
PiA+IFlvdSBwcm9iYWJseSB0aGluayBhYm91dCBjYXNlIHdoZW4gdXNpbmcNCj4gPiA+ID4gYWRk
aXRpb25hbFByb3BlcnRpZXM6ZmFsc2UsIHdoZXJlIG9uZSBoYXMgdG8gZXhwbGljaXRseSBsaXN0
IGFsbA0KPiA+ID4gPiB2YWxpZCBwcm9wZXJ0aWVzLiBCdXQgbm90IGZvciB1bmV2YWx1YXRlZFBy
b3BlcnRpZXM6ZmFsc2UuDQo+ID4gPg0KPiA+ID4gUG9zc2libHksIHllcy4NCj4gPiA+DQo+ID4g
PiA+ID4gdmlkZW8taW50ZXJmYWNlcy55YW1sIGRlZmluZXMgbG90cyBvZiBwcm9wZXJ0aWVzIGFw
cGxpY2FibGUgdG8NCj4gPiA+ID4gPiBlbmRwb2ludHMuIEZvciBhIGdpdmVuIGRldmljZSwgdGhv
c2UgcHJvcGVydGllcyBzaG91bGQgYmUNCj4gPiA+ID4gPiByZXF1aXJlZA0KPiA+ID4gPg0KPiA+
ID4gPiByZXF1aXJlZDoNCj4gPiA+ID4gIC0gZm9vDQo+ID4gPiA+DQo+ID4gPiA+ID4gKGVhc3ks
IHRoYXQncyBkZWZpbmVkIGluIHRoZSBiaW5kaW5ncyksIG9wdGlvbmFsLA0KPiA+ID4gPg0KPiA+
ID4gPiBieSBkZWZhdWx0ICh3aXRoIHVuZXZhbHVhdGVkUHJvcGVydGllczpmYWxzZSkgb3IgZXhw
bGljaXRseQ0KPiA+ID4gPiBtZW50aW9uDQo+ID4gPiA+ICJmb286IHRydWUgKHdpdGggYWRkaXRp
b25hbFByb3BlcnRpZXM6ZmFsc2UpDQo+ID4gPiA+DQo+ID4gPiA+ID4gIG9yIGZvcmJpZGRlbi4g
SG93IGRvDQo+ID4gPiA+DQo+ID4gPiA+IGZvbzogZmFsc2UgKHdpdGggdW5ldmFsdWF0ZWRQcm9w
ZXJ0aWVzOmZhbHNlKSBvciBieSBkZWZhdWx0ICh3aXRoDQo+ID4gPiA+IGFkZGl0aW9uYWxQcm9w
ZXJ0aWVzOmZhbHNlKQ0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgd2Ugc2hvdWxkIGRlZmF1bHQgdG8g
dGhlIGxhdHRlci4gdmlkZW8taW50ZXJmYWNlcy55YW1sDQo+ID4gPiBjb250YWlucyBsb3RzIG9m
IHByb3BlcnRpZXMgZW5kcG9pbnQgcHJvcGVydGllcywgbW9zdCBiaW5kaW5ncyB3aWxsDQo+ID4g
PiB1c2UgbGVzcyB0aGFuIGhhbGYgb2YgdGhlbSwgc28gaGF2aW5nIHRvIGV4cGxpY2l0bHkgbGlz
dCBhbGwgdGhlDQo+ID4gPiBvbmVzIHRoYXQgYXJlIG5vdCB1c2VkIHdpdGggImZvbzogZmFsc2Ui
IHdvdWxkIGJlIHF1aXRlDQo+ID4gPiBpbmNvbnZlbmllbnQuIEZ1cnRoZXJtb3JlLCBJIGV4cGVj
dCBtb3JlIHByb3BlcnRpZXMgdG8gYmUgYWRkZWQgdG8NCj4gPiA+IHZpZGVvLWludGVyZmFjZXMu
eWFtbCBvdmVyIHRpbWUsIGFuZCB0aG9zZSBzaG91bGRuJ3QgYmUgYWNjZXB0ZWQgYnkgZGVmYXVs
dA0KPiBpbiBleGlzdGluZyBiaW5kaW5ncy4NCj4gPiA+DQo+ID4NCj4gPiBJIGNhdWdodCB1cCB3
aXRoIHRoaXMgZGlzY3Vzc2lvbiBhZnRlciBzb21lIGV4ZXJjaXNlIG9uIEpTT04gc2NoZW1hDQo+
IHZhbGlkYXRvci4NCj4gPiBJJ2xsIHJlbW92ZSAidW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxz
ZSIgYXQgdGhlICJlbmRwb2ludCIgYW5kIGFkZA0KPiAiYWRpdGlvbmFsUHJvcGVydGllczogZmFs
c2UiIGluc3RlYWQuDQo+ID4gRnVydGhlcm1vcmUsIEknbGwgZXhwbGljaXRseSBkZWNsYXJlIHJl
cXVpcmVkIHByb3BlcnRpZXMgKHJlcXVpcmVkOiBbImZvbyJdKSBhbmQNCj4gb3B0aW9uYWwgcHJv
cGVydGllcyAocHJvcGVydGllczoge2ZvbzogdHJ1ZX0pIGZvciBWaXNjb250aS4NCj4gPiBJcyB0
aGlzIGNvcnJlY3QgdW5kZXJzdGFuZGluZz8NCj4gDQo+IExvb2tzIHZlcnkgZ29vZCB0byBtZSAh
DQo+IA0KPiA+IEFyZSB0aGVzZSBjaGFuZ2VzIGFsc28gYXBwbGllZCB0byAicG9ydCIsIHdoaWNo
IGlzIHRoZSBwYXJlbnQgbm9kZSBvZg0KPiA+IHRoZSAiZW5kcG9pbnQiID8NCj4gDQo+IFRoYXQg
c2hvdWxkbid0IGJlIG5lZWRlZCwgYXMgdGhlICJwb3J0IiBub2RlIHNob3VsZCBvbmx5IGhhdmUg
ImVuZHBvaW50Ig0KPiBjaGlsZHJlbiBhbmQgbm8gb3RoZXIgcHJvcGVydGllcyAoZXhjZXB0IGZv
ciByZWcsIGFuZCBwb3NzaWJseSAjYWRkcmVzcy1jZWxscyBhbmQNCj4gI3NpemUtY2VsbHMgb2Yg
Y291cnNlKS4NCg0KQWxsIHJpZ2h0LiBJJ2xsIGFwcGx5IHRoZSBjaGFuZ2UgdG8gImVuZHBvaW50
Ii4NCg0KPiA+ID4gPiA+IHdlIGRpZmZlcmVudGlhdGUgYmV0d2VlbiB0aGUgbGF0dGVyIHR3byBj
YXNlcyA/DQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0KPiANCj4gTGF1cmVudCBQaW5jaGFydA0KDQpS
ZWdhcmRzLA0KWXVqaSBJc2hpa2F3YQ0K

