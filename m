Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2758D69BB57
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 18:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBRRx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 12:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRRxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 12:53:22 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2031.outbound.protection.outlook.com [40.92.98.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C16FF26;
        Sat, 18 Feb 2023 09:53:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xxlb/IYnPbKLh16sbF4GxprGRzVB8ZlhUPhvrhTlGJMWsgsQvZcork/2DUBHnGkKZcBlx7ptVt91iAKPuyRLWHSYmAvrWOjB2VKjxy2He8Rbb/lDUoBo5eh+9kOTkKf5c6ZWpndoeUDtGNQ6BRCS+anvmKROByDrlPLjBdIEWfxswGOB/D61mcvDsOcQtXQ767EmiKbhGjHoKLN1JYDmyTY+WjSsF0HDt0sqTg7nqlU0znRwdM0N+0SBpNm+NPvkzsEi+XTIaXI6buoMLMI7c7np8gfUFgCTrXvi58RlHnhpBh8XeBBBmzf+4HwErFHGJObxgdh38QI9zUaGtZb4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMjebBM+6BVhSJZPBmafZYXRNaoG9rKs4yooUSgyKEA=;
 b=aY3sUWemIHafNB8S4y8kwaE16Ehf5v9C4/wxmvO/xDIFLbn3ZteAMBo9Y+KA9nk2ybNZFLFWBC68vlapjaMF+J9fdcVU5Vsp8RB2455pepegbtG4seD6o5BPljwNbNGRV26jdSJYMCv1jHEBCCOMYIiFuswJHbkmGyhXL1Dal1jrTu7SqgyC7BEfEHZFrkZ6ISA0tYjD/jJxcjh9Xr5uBoMbJNdIjLpT++C/67o9Tb+9Zv2qPtngWQhWwbiSN+O4cW/1izdNOM82OmSB6CP+4DRdqYNq2e96APrRkik03swIMBDE22DQvcTCePNtSZfmEeYD6ueCTqvQhraq6bjH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMjebBM+6BVhSJZPBmafZYXRNaoG9rKs4yooUSgyKEA=;
 b=YcgxrUfD6PSxijaq8CXvA9w+EOApHbY86hFZzeam4jZ4fEoW3D6mtpa9gPzq4xJ06Vm7b76vQE8aZJIP1s5mB2FyyJ1+gGLzoE7/zIaQNZMGUkZFHGrkQRyZZ8FcX+QgbdmzFNlRihbYNvR/WTqyQIFWYOqIiQxfa2+NG+UhOCtn8azTSHJuJF9241dsiOcwsQZPhZTsPQvIQ3jFj+Kd4v003h2/dkVj+cbmYP8RAobMLD1ONBxxvkXCNcjjC/AGEvfA9qq9q3AgIWRXW3DMUS6mCxxH0UodR9GC1mAB+sjxKIoUDvThnc22ktTj8PoIoL3NXdwu44CRo9MVVHBW3g==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB1751.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sat, 18 Feb
 2023 17:53:15 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979%8]) with mapi id 15.20.6111.018; Sat, 18 Feb 2023
 17:53:15 +0000
Message-ID: <TY3P286MB261112915A6811BB91E8DE6C98A69@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Sun, 19 Feb 2023 01:52:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230120184500.1899814-1-martin.botka@somainline.org>
 <20230120184500.1899814-3-martin.botka@somainline.org>
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v8 2/3] mfd: axp20x: Add support for AXP313a PMIC
In-Reply-To: <20230120184500.1899814-3-martin.botka@somainline.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------S4AL1D0X2EdZeLbkMPnwqbr2"
X-TMN:  [Hrs0mJ46lTVnRTyCIRi9/VoMfr0HYd3020ohlUmUgGIl/hxeJ/IXqa5PmHAogrbT]
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <3b8ace4d-7b4c-f4b8-8a4b-c24b70465cae@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB1751:EE_
X-MS-Office365-Filtering-Correlation-Id: 428b2a9e-2327-4ed3-1ed8-08db11d9025d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yq9rDyA8LxfybJDm5aLlr2Vkf2hTWAPOErkpTAeYVsVQdBWo0JbMEtc6r9tatjKi6LfqfJdG97RJbjrVYmDJWMkyIrOJnprFdGKdKGd5YUcOBSEOBId5mBfsTHeppUorRuWh7b7hL4Hwl1Z69M8eXKwemNaKeZk+DBcz8j9BSiZn5G3/TIota1VyFzzH0Nkp1cG7yYHbWwqhnfsG3wEU+riUd2JTH3n9vdOzfxO5iYyFj+1FXt2aHH35+5hHN+ri5LIUvF8/zxANajYiDzF42KPvJjcNlbbL9UpqTzaWsyQQNEv2KaOVLzx2wJhj/VRU+eDXfPAXJCY6sOPyLGY0CTeoXGtQwjXkEhyb9WtSKqSo8EXElhd4aijIRKPW6LoCry87VL+/7xfu1pAdzopfMPas/o7xKcEoGekhNevAZIC+YLypBfqMojF5fHZL+woxnsBYgZ81mVU62iiohfEBvGG/R2c9YzLPiEIxtE62CLY2I3TGAv06ajE81ih2Q62y7ByeB/0bUMHaTGzTiPn/z/uW/4/9Yt828Vlg571Evy1MLHJ2fAxM+5nGmEpJVW6LxNZyy+XUx4tk48do6UiSSiUZfEVRSsOqy/C5KoiSxaERru7dmccDiEzz4UaZG28RtXlyza5Y47qkjNQR8zVFsg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RThxcXFmN1ExbmlMKy95V1FzVU5vTUdaWFllOUw1UzZISU5ta3k1QzZ0ZTBO?=
 =?utf-8?B?VzZOWVdLbnBIdTUyaVg0c3RpSndmdmllS2hjQ1ZhL2JMR05JSTg2NmFkdy9P?=
 =?utf-8?B?WFZnWVpoOUFWVHZHS0FaclBPbTl4SWZHa0U4SHJpQXJqS2R6U2NmaElxQ2Zs?=
 =?utf-8?B?Wm5sYlZXanFLYWl0NzVFRDI3THRvUzQyMGthdVNUMWx1VTFUTVB1RFVxbzNJ?=
 =?utf-8?B?NWpUWWVlY0hJNzhTS2JCdG1VVHVKVEFjNjdVN2JxVk81ZERuekRucHFoTHVY?=
 =?utf-8?B?bXRjMkFra1NSbXFaN0pvTjA5TU15Nm5vQ3owZG9ISnIxV21idnlVNmNRUFFj?=
 =?utf-8?B?ajV2K1UwcStKYThkOVV5dHhZMTJ0TlhrYnh4QysvVSsrMUoycHdJclpvZGZZ?=
 =?utf-8?B?cDBJdVowc1p1OTgwUFJxQUU5bmtEUHJOMWpscERpOWdzOFhRR29qMldaK041?=
 =?utf-8?B?WFVvU1FVOGVrTzViVGVQQkZGOTY1TnJIeHVZRm1HNmlyK0ttNExaTStscUNt?=
 =?utf-8?B?T0VpTzJzTGRkdzFkSC8ybEl4ZVZsdG96WGVYWjZKcy96S2RiREx5cmpWb1VJ?=
 =?utf-8?B?VzgxZnFYVm40QzhrLy9UWUtxUk9QQSs1R2ZUalk1dlJnZExqR3B4L2FBSTRx?=
 =?utf-8?B?Q0p2UmtSWnppdXNJckVGUjBKRDhnUFZJVkZhcjRCeDhEMUdGRHBoWW9CVi92?=
 =?utf-8?B?OS9CT1BRUWxYZXM3ZThxcWlvQVVYSXBWOUZjMEhISjIvRDVZKzZMV0VnMEda?=
 =?utf-8?B?M2psWkZvUWFyR2VSWDM5cFVFTk5tSXFPTDExUDIrSlVxSXJmZWtJUk41TFdK?=
 =?utf-8?B?bFZCNHo4aFo1Q2dVRVE0OFI2eVVaMkJhSUJqaVRVUmE2SlRkcGdIRGY0K3d5?=
 =?utf-8?B?UzQ4REZCR3l0aEhoZTdCMHgxSWpWQUkzWE83UGhTRzByYVZtU2pCL1ZCeEcr?=
 =?utf-8?B?WmE3VjZGK2tjOWZhYisxbkg5aU1KVmR6eVVkYzZyckZlR3cxL0MvdUN0Sytj?=
 =?utf-8?B?aXgxYzZISzNGZDhlUmNYMzd4Z21aY0dNRlBBVlNQcStERkcyOEVwN1FMcGw5?=
 =?utf-8?B?TEJDVjBOMGcxUGlwb3ZJeVNDU09ENy9NOFc1MlB1d0plejdNbFFLUE41dHQv?=
 =?utf-8?B?bDNWdlBtUmIxSmFLc2psdlJnMzhETXRuNlBhNEM1ZWc3MVZUUExwbmx4SytI?=
 =?utf-8?B?UzUzajN3MjFkb2tlRnpHWUFGZ3JkaldMT2NpTGhpK0RtUi9CcExIWTRaWEFj?=
 =?utf-8?B?d1dROVVxelVTZGRvYVJsaTE3aUNIcjI5emdiVG8rZHp6VHBXVU9mYktBaGdp?=
 =?utf-8?B?WTI3OTJ3ZVg4VmdyZndGOEtCYysweS9ad25JdVZQdWcvVEVQZGY5ajk0T3VW?=
 =?utf-8?B?MUU5TlY4Zi9xNFZJSVNDOStQTnhYQkNFYUE3VlFya3dkRUJnR2c3WnhyYVd6?=
 =?utf-8?B?VFVhSHlOT1dFc3k5c1crbW5uNUdOK0dBRXJwVWgwb28wT0NFWlJRRlBzMEVO?=
 =?utf-8?B?Ny8zcktNbDhHNFF3L2RKdTZuYngxeVJSMlhGeVZCb2dHdWtuOVl4QzhOMlpW?=
 =?utf-8?B?VHZUbjh2MjNPNjNTcGUxdXJBYnZtejFBb0tzSjBVV29TRnhyRDRlZU1PNnU4?=
 =?utf-8?B?bUpncm9vaUlleGZ0MzJaZWw1SUlpUGo2a1dpSmw3MDRrL0VxWVZtUUJ6M01r?=
 =?utf-8?B?c3FDSHN1L0xiMndYQzd6RjBjYUFlOCtFbEFhV2V1cmh5aWpwcXNxVjhyS1h6?=
 =?utf-8?B?N0pMbk9TRjVLUzFXWjlYYlZJeCtHVjMrYlBxSWFLWlJxVVBOUUoxR2JUMHRS?=
 =?utf-8?B?MC9zdUdUQjZRZmcxMDd4Zz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428b2a9e-2327-4ed3-1ed8-08db11d9025d
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 17:53:15.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1751
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------S4AL1D0X2EdZeLbkMPnwqbr2
Content-Type: multipart/mixed; boundary="------------TBUA0CLKoXlNTVWS8eALatVH";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jami Kettunen <jamipkettunen@somainline.org>,
 Paul Bouchara <paul.bouchara@somainline.org>, Jan Trmal <jtrmal@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara
 <andre.przywara@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <3b8ace4d-7b4c-f4b8-8a4b-c24b70465cae@outlook.com>
Subject: Re: [PATCH v8 2/3] mfd: axp20x: Add support for AXP313a PMIC
References: <20230120184500.1899814-1-martin.botka@somainline.org>
 <20230120184500.1899814-3-martin.botka@somainline.org>
In-Reply-To: <20230120184500.1899814-3-martin.botka@somainline.org>

--------------TBUA0CLKoXlNTVWS8eALatVH
Content-Type: multipart/mixed; boundary="------------hTd5BW0A0MdPrCBuQ2ugjAJK"

--------------hTd5BW0A0MdPrCBuQ2ugjAJK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTWFydGluLA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCByZWdtYXBfcmFuZ2UgYXhwMzEz
YV93cml0ZWFibGVfcmFuZ2VzW10gPSB7DQo+ICsJcmVnbWFwX3JlZ19yYW5nZShBWFAzMTNB
X09OX0lORElDQVRFLCBBWFAzMTNBX0lSUV9TVEFURSksDQpObywgYWNjb3JkaW5nIHRvIGRh
dGFzaGVldCwgMHgwMCByZWcgaXMgcmVhZC1vbmx5Lg0KPiArfTsNCj4gKw0KPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCByZWdtYXBfcmFuZ2UgYXhwMzEzYV92b2xhdGlsZV9yYW5nZXNbXSA9
IHsNCj4gKwlyZWdtYXBfcmVnX3JhbmdlKEFYUDMxM0FfT05fSU5ESUNBVEUsIEFYUDMxM0Ff
SVJRX1NUQVRFKSwNCg0KQXMgVHNhaSBzYWlkLCBubyBtZWFuaW5nIHRvIHNldCBhbGwgcmVn
aXN0ZXIgdG8gdm9sYXRpbGUuDQoNCkFsc28sIHBsZWFzZSBjaGVjayB0aGUgZGF0YXNoZWV0
IEkgbWV0aW9uZWQgaW4gcGFydDMgcmVwbHksIHNlZW1zIGl0cyANCm5ld2VyIHRoYW4geW91
cnMuDQoNCkJlc3QgcmVnYXJkcywNCg0KU2hlbmd5dQ0KDQo=
--------------hTd5BW0A0MdPrCBuQ2ugjAJK
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------hTd5BW0A0MdPrCBuQ2ugjAJK--

--------------TBUA0CLKoXlNTVWS8eALatVH--

--------------S4AL1D0X2EdZeLbkMPnwqbr2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmPxEHQACgkQX75KBAfJ
sRnZhxAAlX0jpdmDy2tZHCY6tGSEG44M4uzEZtdlcKTGbells7/yvo5AfBx6gzw4
qCkzKvou7cNmcv7uPSgz6LI38A+mzadivvfRRq1B3elIiVK/y80uNN0DupXlpUTz
tf6f74DREb+dAjZxOe9F9qrMATbMIBHIJ+f4BspyKR4x6xXIQV8/uMtdi1SVzctP
JP3FzpbdI5cvCJXH3Dcby+/Aus/Rbv9ATSMVVJy4ThkcydiPQQ4nRfbQ6LjHEMBj
yHh2tuFHlc7nG8Zy7ObpcJpOjKQ98ZP4PhUOFQftW18qkJvWY4QPC4+DdLRB6fIs
i/dxm0YzTLAEjtoQBxHMfR2EAcVthbungWxLIEx0V6a6U8VJ5M5viKd0e8XlPBrO
Fz3X2EQBoXL79nkypcNhi9S7geoeeQDP/wxNsxk8WS3IVP7loNIZ4iwc2kTZ/bl9
kplulCd6Xl6II0Tk4ZAY6G+499xh0oDI/MIdN1yFsTUbkJSfQVxRc0LZjA0PYzfg
nlmVIjLBU9nBvMK9XZlAlZlR1b1Brk+DuWf5isaej7Rq3A/CQPuWle8OQINUJZ3e
5YoX8YdDtX11B5Bx0GyIUuKwyE7S0Qu31VWmDPZiqRIZ33Ov/r4oKIi5fJH6UemE
YI4Kard6FQrRndiwBa80/7SE1xpFxEv6SMVvkZio4Oe1iXXp+3w=
=HxGc
-----END PGP SIGNATURE-----

--------------S4AL1D0X2EdZeLbkMPnwqbr2--
