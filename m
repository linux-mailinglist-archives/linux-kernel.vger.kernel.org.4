Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC8F737EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjFUJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjFUJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:07:21 -0400
Received: from mo-csw.securemx.jp (mo-csw1116-1.securemx.jp [210.130.202.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F9E1B4;
        Wed, 21 Jun 2023 02:07:18 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 35L96dMH016034; Wed, 21 Jun 2023 18:06:39 +0900
X-Iguazu-Qid: 2wHHyxo70MWcSh3MfZ
X-Iguazu-QSIG: v=2; s=0; t=1687338399; q=2wHHyxo70MWcSh3MfZ; m=9EM2ghOp1P0drEmyH+MGAP3NfUhyu7IpijY0tybqI/g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1110) id 35L96bi7000911
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Jun 2023 18:06:37 +0900
X-SA-MID: 3062036
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZP/12quoPhLCVAnjc4B+adT08Zki4yUsJfNptVLGSBtollxUKSvGm0VK3j6AN/bMPURUAP9PFb4p3/Xs92Gyj9VtnMnhIOsYnxDDzAaUccrVBQ4VbroOs2MxHHnEYYUAKb8tns9oWkRopfpO6vXgjuykpjM/U5SmCm3F/f0R+cEWk6oSBmpR54T99fIWbuzrSejTfbOYxnrzHj+Ce9z0PfjUm2u6u1BugT2ZnLc+Hw6kqlNNeKQqimODHteDXvv/ATOffTeYaBMCWDYuDsH7yTliB+0aFa8VI5zMwGBey7w6SgCodJZ6LXoer2C/VoFGTplXl8T8YoX2TkryxVH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0qVd8NVlAEPEBglkmy9AeYLxqg6pXIO9oLTvDM3Md4=;
 b=ecmGk3ZxTSF7ttM7lA1t4ekNUByH7u0d3YK7/wDGVRveEYKoKgUIcDKRy7mpDVz8qNgTUcxlWBoXRZy1GdjphQ1H7BITKFNgtSceQW8L7tmOZY4GzWBRbQcBYKGZ2vARxBkKgET5jp5VE3O6yn1GW9cg+bSAUWqWic6fThDwfKfokSCXp+oHruNOn6Tuk7uI+YLpGLzaF60JNrB6tP2DLNLg80ZV6qm+adQ1iCx4vWMh0hTVZTF9Ydu8Lxm1MYswo9pqadrYC7j3OahRG6pDE/wUicIxH6XBVYeyGQSol4AZf3f0ju8SFljO1+KXFDLjFiW0qhrrRZEfYJPpLfolJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <krzysztof.kozlowski@linaro.org>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <laurent.pinchart@ideasonboard.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 1/5] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Topic: [PATCH v6 1/5] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Thread-Index: AQHZoyTsyUQl/gyxtUS6Kn+OUA/2k6+TQdaAgAG0XGA=
Date:   Wed, 21 Jun 2023 09:01:34 +0000
X-TSB-HOP2: ON
Message-ID: <OSZPR01MB6197054787F87A0E2DD4E7CB925DA@OSZPR01MB6197.jpnprd01.prod.outlook.com>
References: <20230620031111.3776-1-yuji2.ishikawa@toshiba.co.jp>
 <20230620031111.3776-2-yuji2.ishikawa@toshiba.co.jp>
 <eea945ce-9b9e-42d6-0387-48ec0c88cc89@linaro.org>
In-Reply-To: <eea945ce-9b9e-42d6-0387-48ec0c88cc89@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6197:EE_|TYCPR01MB10632:EE_
x-ms-office365-filtering-correlation-id: 7b751c47-2fad-42be-1b1c-08db72361cd8
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRDWQFaMsp06paPytJbV4kxBScSjiBjA8cWAs3GrPwKf5ws+YI5ql2mCVyej9AgpNzVdryGk7d+XSVylXxWaAzlCS6Uf0hupRDlz1KCpOci2jXbmNP5DJqoslk6gxrY5rHQUFvczcutTBdotPfptcuL9uDbqoeuxE8zqOSMR6oz6XZRkPdJQd4YwhXwama2qad5iJDYAq73ag+5PPF1NBoMHzWwDbrprTtrw0nw74i+tZSHaHC6h6UaoygYf2+Z+Vryqvy9H0OvIXBITYpYVLdmbUZHqZKtQGwYrZN8c3PzNihVTa2jVCa2bVipNNkcCQgrAGLNxYOXNB/qVqDxG5bwLU9xywcf4s1B3hnkixJZmxqSPNqxhVoikQow0BNHs15SZjtoQOxFuok6w2afgORaZ1PfBbkZEHWPj0Tiei+X9V9yUMCZWUHNqbB1JFjnW60qJ2BRqegZ5wgULTdWOGFYZ5BhC8x+xnkgn1/2N2CInx0ZG07aPSXkfBnEpd6j4dMO+Ht7dYmMuGlM/7FezpJSLMfC+UYvfBb897PKwu1V0Lf9sOc7BktaDTeFbw244RRE65Teq6UMA/L9noRSbULx/oqIHIrp7BP02VR/FPIOdi0tZ6AoomB2qN/GXxFHcVgC64esatxB2drGiHMcoKCvi9OguB0CJTQQM9JUU+s0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6197.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(122000001)(38100700002)(33656002)(86362001)(38070700005)(55016003)(71200400001)(4326008)(66446008)(41300700001)(66476007)(6636002)(316002)(26005)(66556008)(64756008)(186003)(66946007)(5660300002)(110136005)(54906003)(7696005)(52536014)(9686003)(53546011)(6506007)(8936002)(2906002)(478600001)(7416002)(8676002)(76116006)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkVFZ3BIeWpMOGE5QVFnRXdsMmtkaXhHQ1hLUlkrT3NXaC9hTzFsVjhKMDVN?=
 =?utf-8?B?Tm41VytzT2FMSmlvcHVNRVZlSmNqb1RPbnlvcktjbjNKaUhiUVM5d0dHRDlV?=
 =?utf-8?B?SnBBUGxqMDg0SGdlWWh2UkZUWUFkeG1oZnNWdGxhWS9mQktnaDBEYVFPbkRN?=
 =?utf-8?B?dHcrRlc0d0ZIc3p3dGxaTERkTEkzSGZMZE5yVVZIMGU5b0trU0xqYURlN1Qv?=
 =?utf-8?B?aUJmekJSYkExV1lzME9MYlN0dkppd3NhVk5XTHZic1BrOEV5V3NPRURtZ1Fa?=
 =?utf-8?B?dEdacDZmVHRKOS9wRy9uZ3RSTEFVczNEUmNoRWN4WXc4eWorU2ZpaGlHMkRa?=
 =?utf-8?B?RVhRZldxOGwxTytlRHlUbWE1VUZtMnB5SFNiYVRlU05Hc0d3SHpYMDVsNkN2?=
 =?utf-8?B?d05JMFhaOHg0SEJiOFZ0MjlCai9IbVI3VncwOGFUR2k1QXBtWDZWYWFvU1dZ?=
 =?utf-8?B?NEZaM1A3VlhRa2E5ZGVvT3ZYeHVNUS9OdFRqQi9NeGViUUxKa29sRVVEOWts?=
 =?utf-8?B?WUxMNmN1WHM3SitrQVMxSFIzM0lFQnlnK3NJbWlOekZtS0N5cGxqRTNFRVFx?=
 =?utf-8?B?aGJJRGxabzBZVWhVcW1uMmJqR1JoVXUrV0lHWm5wWE04VTZzWXFxVncrbGRI?=
 =?utf-8?B?eGdFRVIyNkZQOU85eVJKT21sWFRCNlMvRGJtN1BiOUlReSt5dGFvemJESVhx?=
 =?utf-8?B?ZzJJekpsYkJOR1J2SE12UFU4SmFkRU9Tb2F5Umh4S2l2eFJkUU5IM0NNbEJ2?=
 =?utf-8?B?NmZsMVMyS3l4QWExRUgvMVRzM1Bpd3N1ZjFLTWdpM293RHZPeEZUajZHS0ZM?=
 =?utf-8?B?RGNiVkVuU1ZxMHI3Q2lMMDZoRWZacW1xOWZkaVE3K09nS2VqbkorTjJ4R2R5?=
 =?utf-8?B?STBWQXJ6WktzTTNIeTFuV0ZMWDJCTmhZNXZYRlQwZE5qL016RjZpSmVTQVla?=
 =?utf-8?B?MHh2em4rV0oyaHJOSkxhM1QvandCQWRUVjJ1dU10ZE9QaGVERVhYeGlGV3VB?=
 =?utf-8?B?cHZ3SWYyZmkxdG1WekVIVkpNSDU4czNCZTZvUEp2STRSK1IxV1EvWjFHVGRF?=
 =?utf-8?B?OTZvZmdwaUVnVkZzNmxLY3A0MDRVbFYvSlRrZjZpTFRnL0NRaFJOQkNqWUFx?=
 =?utf-8?B?RjFQMHdOcXgvQ3Y1QXJXNFB1OUh6V3ozNXloT3hrRWYxTG43aTVSdjVjMC8x?=
 =?utf-8?B?ZjNTc2tsTTFjWTU1cFNQZDIrdVQ4NGVHTUZ0Z1lXUnA2eE9qMlhPRUtnYzNO?=
 =?utf-8?B?R3grcXpEYlgxcjNvYlNGY2xzZUgvSkFmVEVYU2F0WTNPMWNkaTlrdzdRZzda?=
 =?utf-8?B?VmVpKzNuRHJ2WDM3UjYrcDZvZTA1UTBTbkRtYURRRysrclRYSm5Pd1pQYUdB?=
 =?utf-8?B?Wk1Nc1ZDVzlrckZBMHU1bW9DOEU3bXhPT1FGekZzM3VERnZUOSttaGZYVERQ?=
 =?utf-8?B?UUtIc0grdFlpdnA3SkRBTGc5cTVpZExFNlFGdTdkL012d0oyblg5NnZsT0Rl?=
 =?utf-8?B?b0ZuNEprTVFNU0xDM3ltRzB3bjhHeEo4amF6VGs1WUZUTU44RitGWVFjeWZU?=
 =?utf-8?B?UVFwS0tFdUtKdGJZS3BhQ3VLeXRTNzZYcGtRNmV0MzM5OGU3MTVFRGl1a3pM?=
 =?utf-8?B?czZuRHlnRklBRko2NHVCK3BXZVZNazczbXhpcjlpL0tHMjJyckhFRFJpTVBo?=
 =?utf-8?B?QlNhMGs3MWtlbmllaU1Ea3pva1dCM3ZsMTFXcUZSR0xkOGtJQ1haZmRTS1N6?=
 =?utf-8?B?b1dmbFUyU2RsSVFXdFRuTHBBOU1wTi9WSDU0bG1QM01jTWtGbFZPMXVYSWFI?=
 =?utf-8?B?cmI4c3EyaWNuRmhSeWdJYUdGN21TYUx0ckNlaHUzWnJEZFdnUEpVTHBHcVFs?=
 =?utf-8?B?cTFrOE5EdE1XMzVlVi9tYVgwcnA3cE9HTVVVa1FXMXJOYWZ5ejRtQUhMK3FH?=
 =?utf-8?B?aWJCOXUxRUJNQzhwMm9EVjdrRmszaVhtbW1mRi9EVk1BdnYzQ3ViODhTS2w5?=
 =?utf-8?B?UFk5U2xjMlNHZFBtLzFvUk8rQU51SEJSdmJsWCtqQWk3NjlpbkhodUNTd0JO?=
 =?utf-8?B?Z28rQUp1UDlEbmYyRGVYekVXMDFDSE9OdmN3aVNjSVJqRk5pRDgweFNQMVV5?=
 =?utf-8?B?RmpPTlRhNjBkb0thenNYK081dmgzcXpoLzU0WUJOUVdndzFjNWRCekx2MjZm?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QnZCYk5Td2IvL1c0WGlTYkZ0TTZnUXNLL2NsWGFvRWZKQ1l0V1VEN0d5ai9I?=
 =?utf-8?B?UmdRTEszU0NKWTJiajlEU1k0Sk0waTFlVE9Za2ExeDNyQnRJVXV6NTcyOHNv?=
 =?utf-8?B?dFd0bGRsVHhxVzVmaVRud3M5NWRHUWdXZzZEMFRMbE9iakVIYUZONFh0RTl2?=
 =?utf-8?B?S0hCWHRmL0NmMFRzd3VrM2JTTnd1bGduS3RUdWNyRTVoS0JwU3Zka2hkWk1s?=
 =?utf-8?B?bEIvT0JkVWphbXNsRDZvSU51ZDhRajdHbVNIK2FGdW9ISFVlWjZQazIza09q?=
 =?utf-8?B?ZDlUNnk0YmxrblYzbHFHZ0d3bi9MbnZVWVcrTGsxNnNad3dBUytnM3B2S0FZ?=
 =?utf-8?B?NjR4N2tidytxT1Z4amZpMklySnBKWmZtM2U0cGlJY01nZkFRd05uTk1SOXFs?=
 =?utf-8?B?YllHVnVhbEFKNjNwcW1ER0hIdjN5SUxSTndPSVVRaTgzdFA2WkpTZUZvaFFB?=
 =?utf-8?B?RTRGM0JGRzZLR3J1aEROMmNLeGw5SnpvcSt3RzdvRFlhcUluTTRGYjdLd1Ux?=
 =?utf-8?B?NzZXd3hvM2ZNUE9sTmVTMGd5UGUwYWZUWmpYTzJGSDlzQTN5VHFHemIzNUdm?=
 =?utf-8?B?N2Nhd1VHRXhDS0dCNWZPV3dreHRma1dBOS84NzExSXNvQUZzZ3ZLZUhiVXlr?=
 =?utf-8?B?NlpzMndXeGplUjhFdXJnNmkzaFduZmcvM2tYY2lWVTNnTHlLTlgxeVhDTWtO?=
 =?utf-8?B?aE42WjgvTXRBSDBvQUNXNTR0blVoKzFPQk1wSTlJVGVQUEdPMisyNlBPbmYz?=
 =?utf-8?B?UzBjVEFSd1JrdUlCTnVTV3p6R0FhWTBaeEwweGlQbWdlM1VoT2o5WGQ4M2ZY?=
 =?utf-8?B?TnhtWmlrK3IvWW96d0RVbmNVYnd4Vjlta0s4eUtxdWp5cEpvVGVEeEw5NTI0?=
 =?utf-8?B?Y3pWaGFlQ1dFNXhnd1UvYVNRQjQ0S2JFWlNYWWN4RlZQRlNBT2QreXBNd3Iw?=
 =?utf-8?B?ZmdFUVBLTm54d1QzNHpsMXF0SlVpaXZ5VDdOUmVuc3dSOEFROTRMYTZJcllG?=
 =?utf-8?B?enZ4eU8rWjNRUXpxV29nTlFhZnVtb1p2SWNVZUFVek1ndm8rR3lxaUtmM3Ra?=
 =?utf-8?B?UWtGQW5YZTNWVzNVUnE0NVBpdG1CRkplS3Z4SGlROXdQN1drNlJnYXVMMW1h?=
 =?utf-8?B?UDNMOElnR2NYLzVWR0FTVFRqZE8wam5jdkhmeEZJenJWZ1E2ejY5VGNNYms4?=
 =?utf-8?B?YzA5QkR0d1Z6OG9ZVCtOYkNudEhPbzEydGZ3Z1V1cWRiV2UxVE5WRTYxTnJx?=
 =?utf-8?B?aHlEZzQ2dVFYREdhZ0REamY0alZFU3ZZTnVPeC9ZSms4cEJSTEFCcy9TZk8v?=
 =?utf-8?Q?YPPSBG7ezH4Hzg91aR/ZqVYCYDAT6KBcsT?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6197.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b751c47-2fad-42be-1b1c-08db72361cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 09:01:34.0689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhFH7qt/DIjjDNfXOu8JGBf595KiggFs8HqOPzpz2hGCA7PtZ2omhH3BEfc2JUozMMWdoPwrZo/NNC8hpfbeoeMRNC+pY0rWSUqMSshVnag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10632
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
S3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBT
ZW50OiBUdWVzZGF5LCBKdW5lIDIwLCAyMDIzIDM6NTUgUE0NCj4gVG86IGlzaGlrYXdhIHl1amko
55+z5bedIOaCoOWPuCDil4vvvLLvvKTvvKPilqHvvKHvvKnvvLTvvKPil4vvvKXvvKHplospDQo+
IDx5dWppMi5pc2hpa2F3YUB0b3NoaWJhLmNvLmpwPjsgSGFucyBWZXJrdWlsIDxodmVya3VpbEB4
czRhbGwubmw+OyBTYWthcmkNCj4gQWlsdXMgPHNha2FyaS5haWx1c0Bpa2kuZmk+OyBMYXVyZW50
IFBpbmNoYXJ0DQo+IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+OyBNYXVybyBD
YXJ2YWxobyBDaGVoYWINCj4gPG1jaGVoYWJAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2Jo
K2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4gS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93
c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5lbC5vcmc+
OyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8pO+8qe+8tO+8o+KWoe+8pO+8
qe+8tOKXiw0KPiDvvK/vvLPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4N
Cj4gQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDEvNV0gZHQtYmlu
ZGluZ3M6IG1lZGlhOiBwbGF0Zm9ybTogdmlzY29udGk6IEFkZCBUb3NoaWJhDQo+IFZpc2NvbnRp
IFZpZGVvIElucHV0IEludGVyZmFjZSBiaW5kaW5ncw0KPiANCj4gT24gMjAvMDYvMjAyMyAwNTox
MSwgWXVqaSBJc2hpa2F3YSB3cm90ZToNCj4gPiBBZGRzIHRoZSBEZXZpY2UgVHJlZSBiaW5kaW5n
IGRvY3VtZW50YXRpb24gdGhhdCBhbGxvd3MgdG8gZGVzY3JpYmUgdGhlDQo+ID4gVmlkZW8gSW5w
dXQgSW50ZXJmYWNlIGZvdW5kIGluIFRvc2hpYmEgVmlzY29udGkgU29Dcy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFl1amkgSXNoaWthd2EgPHl1amkyLmlzaGlrYXdhQHRvc2hpYmEuY28uanA+
DQo+ID4gUmV2aWV3ZWQtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlybzEuaXdhbWF0c3VA
dG9zaGliYS5jby5qcD4NCj4gPiAtLS0NCj4gPiBDaGFuZ2Vsb2cgdjI6DQo+ID4gLSBubyBjaGFu
Z2UNCj4gPg0KPiA+IENoYW5nZWxvZyB2MzoNCj4gPiAtIG5vIGNoYW5nZQ0KPiA+DQo+ID4gQ2hh
bmdlbG9nIHY0Og0KPiA+IC0gZml4IHN0eWxlIHByb2JsZW1zIGF0IHRoZSB2MyBwYXRjaA0KPiA+
IC0gcmVtb3ZlICJpbmRleCIgbWVtYmVyDQo+ID4gLSB1cGRhdGUgZXhhbXBsZQ0KPiA+DQo+ID4g
Q2hhbmdlbG9nIHY1Og0KPiA+IC0gbm8gY2hhbmdlDQo+ID4NCj4gPiBDaGFuZ2Vsb2cgdjY6DQo+
ID4gLSBhZGQgcmVnaXN0ZXIgZGVmaW5pdGlvbiBvZiBCVVMtSUYgYW5kIE1QVQ0KPiANCj4gWW91
IGlnbm9yZWQgdGhlIGNvbW1lbnRzIGZyb20gdjQtPnY1LiBJIHBvaW50ZWQgdGhpcyBvdXQuIFlv
dSBzdGlsbCBpZ25vcmVkDQo+IHRoZW0uDQo+IA0KPiBZb3Uga2VlcCBzZW5kaW5nIHRoZSBzYW1l
IHdyb25nIHBhdGNoIGlnbm9yaW5nIHJldmlldy4gVGhpcyBpcyBub3QgYWNjZXB0YWJsZS4NCj4g
DQo+IE5BSw0KDQpJJ20gc29ycnkgZm9yIGZvcmdldHRpbmcgYXBwbHlpbmcgYWR2aWNlIGZvciB2
NCBhbmQgdjUgcGF0Y2hlcyB0byB0aGlzIHN1Ym1pc3Npb24uDQpJJ2xsIGFkZCBmb2xsb3dpbmcg
Y2hhbmdlcyB0byB0aGUgdjcgcGF0Y2guDQoNCiogUmVtb3ZlIHRyYWlsaW5nICJiaW5kaW5ncyIg
YXQgdGhlIGNvbW1pdCBoZWFkZXIsIGFzICJkdC1iaW5kaW5nczoiIGlzIGFscmVhZHkgc2V0Lg0K
KiBSZW1vdmUgdHJhaWxpbmcgIkRldmljZSBUcmVlIEJpbmRpbmdzIiBmcm9tIHRoZSB0aXRsZS4N
CiogRml4IHRleHQgd3JhcHBpbmdzIG9mIHRoZSBkZXNjcmlwdGlvbg0KKiBVcGRhdGUgY29tcGF0
aWJsZSB0byAidG9zaGliYSx2aXNjb250aTUtdmlpZiIgDQoqIFVwZGF0ZSBjbG9jay1sYW5lcy5k
ZXNjcmlwdGlvbiAicy9saW5lL2xhbmUvIiANCiAgKiB0aGUgc2FtZSB3aXRoIGRhdGEtbGFuZXMu
ZGVzY3JpcHRpb24NCiogcmVtb3ZlICJ1bmV2YWx1YXRlZFByb3BlcnR5OmZhbHNlIiBmcm9tIGVu
ZHBvaW50LiBwdXQgImFkZGl0aW9uYWxQcm9wZXJ0aWVzOmZhbHNlIiBpbnN0ZWFkLg0KDQo+IEJl
c3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCkJlc3QgcmVnYXJkcywNCll1amkgSXNoaWthd2EN
Cg==

