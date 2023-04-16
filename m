Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F556E35E6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjDPHti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDPHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:49:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2096.outbound.protection.outlook.com [40.92.52.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE782115;
        Sun, 16 Apr 2023 00:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAZp3cNGD+T2SviW+hWgO+n2JaP+EO0/Gnmv2fDRU4U2KjOJZY1LyHmW7KZLMP8aBkEYhFkoGd5F/vKEeRRSb1AVKUtszZYas9j3/4skhrrV9dDCrmEDu06i27bMQs/eaeJmar2PxH6APVGMF1GtsTocQwlCvp193ItSxP9N5vERNlAWdlO2NHnMyjxLp5av01p2PgSzil5HsmrIR8zhB/DwcR15Aat4GWYwIBhVs6qCnxNMgX/tAo3V6tdHEGUCQunLa3tkeFcZ6ih1TCXnTpralp3DN3/KYEWOIQ7fy0EEfLrJDMD5jILN7/fcFvq3fY9cb9kVoF4IoTdjqxaKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPHBxnpE85FO3RxP+hCJupeh2D78e4g4LWWwahGd090=;
 b=Hnk4hulp7InMYnPrPvli2xQncGFXLMa08w26hURyjGJPlYNWD+6GiBBLMAiFswQYflb1jniBZDq9mIXdjBnqpfG2bmS0ZZYqv0NCktUELgIpmrgJrAN5DCS51mXOPEReE4gPgWsXMgM/yGqWUhYxTg/q9IHose5cUIW7Fgs9244RtroJ3iwLDbJ5mGAaJd6D1O8U91HHHAR3yg2T28r1slEWXdl/+Ryfb/v3Zltz/H2mpg8LT99dNiBu8yPU5VvAXL9gOHMg+Ezvfd97LW9neO97GnrETyAXiYi7WS+wCiPF3+ooBTGl4dWSNGNXc5N7LmCF72fQ6vD9/JK2+JICUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPHBxnpE85FO3RxP+hCJupeh2D78e4g4LWWwahGd090=;
 b=OeZKpg66iFStGqaFcSo3JY460iwFPP/m9IDCBHHATwgHwDIJ8kqe7jWm04dyewUECx4nxE0RYLghLH/pi8M8bZPar4rpPGKr4hlLGLL7dv1LMVJNZJKtQMgl4qGR4AhmHx/l5AX4NCXjYkUw6ituEFrNaLqU1Nf0A0KaKKKzlQRzteqSikpUVAkPjG31nJOUCl8y3nOFduUbptXU7aBcZ8z9qKLkhfR6yi9YHXbUETV0mQpZAYHoLsElCmvqg9g2o9InWwunxUZ/bTF91LclJYssaB+GsxSIfwFfz5VBneO32ARRe/SdOEF853YL9cpmHF9242zrXP5zgDvXqvcAOA==
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com (2603:1096:400:28a::14)
 by SI2PR04MB6161.apcprd04.prod.outlook.com (2603:1096:4:19f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Sun, 16 Apr
 2023 07:49:29 +0000
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::4705:d219:7cf0:46f4]) by TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::4705:d219:7cf0:46f4%3]) with mapi id 15.20.6298.028; Sun, 16 Apr 2023
 07:49:29 +0000
From:   "forbidden405@outlook.com" <forbidden405@outlook.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC 3/3] binding: mmc: hi3798cv200-dw-mshc: convert to
 YAML and rename to histb-dw-mshc, add compatible of hi3798mv200
Thread-Topic: [PATCH RFC 3/3] binding: mmc: hi3798cv200-dw-mshc: convert to
 YAML and rename to histb-dw-mshc, add compatible of hi3798mv200
Thread-Index: AQHZb6U5qoM59SOMh0GlsVP96IW1Eq8tihmAgACMEQA=
Date:   Sun, 16 Apr 2023 07:49:29 +0000
Message-ID: <77685e3c-b465-9f73-76f6-1a5c50a74337@outlook.com>
References: <20230415-mmc-hi3798mv200-v1-0-db5b91d939d4@outlook.com>
 <20230415-mmc-hi3798mv200-v1-3-db5b91d939d4@outlook.com>
 <08156ff8-b627-56a8-e079-eb336c193808@linaro.org>
In-Reply-To: <08156ff8-b627-56a8-e079-eb336c193808@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-imapappendstamp: TYZPR04MB5856.apcprd04.prod.outlook.com
 (15.20.6222.010)
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [JhIwKX7UoM2pdNMIuT+eUDc/DU3cyAuNvN4K8GiaXlYqDDdD9fVSJy+sawI9ww8T]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB6321:EE_|SI2PR04MB6161:EE_
x-ms-office365-filtering-correlation-id: 8d3d5f79-4c9c-446c-c803-08db3e4f1ba5
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kstKn08kswppTBmFt4X5py7l0vxoG2EvreF/q6eZVdmyQ9+htRxSjRK6jMwLWr9fnUvvQQabor/Ft5l4pgnKZgQqFaqnuB2lK/7gSMZKyiiAkC0CP2h5/Nt1TDc0lCD41izthWMFm29WyyQ53mbCukeOVp07BP2OiOO9mhxq2GX4e277sTlNMYDDY2exQ6wx4iTDtzJgWkj3p36/PzoAbBvoRoUZbUV0+E5RaoTDCBjKy/7GZoNqrMTc6Rjwxh2lItpBMJzJTjDcVKzaNtq1hoU1sDXAh05/rwu5vJgfQfblteQ/JW3LORn83H8igssgZopsJpUzoiLM70hmLiiZ4kktNAFlERXDauInW77+Ymb5uLLYJbbyc9n8vml6z9qv9C3kpl7KW9Uo0T+zjJJNvNTj8Lj6wrBMm/TNgnmJ5UNdkVmh/zWkdz8l9IXnM2w2sKQh9rBaMtMVH7sTZz3J+QJD74uKOeaWKYy0Fdn4zeu4kC7uL/ljcRgpANRsSy4pYfvnsjbuE42rtScH3knukRPcnX9C4JEG9ogxpE9p2uHMj/wyUJE87v/6v3CGHJsOlpt9d+ywZUW0bGviKMJ4qMA+zo6jSBuXAm5IuM0dz34=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QjFMbElDd2YxZnU1endkRldVbS84OFcrTXpRVVdmYjdBcTBYMG93cW40MGUr?=
 =?gb2312?B?SVVkSlhwUEN2VnIwY253TVdhNDFKT20xRkI1MkRXbXYwZHRlOE5ZQy85ZWw4?=
 =?gb2312?B?UXNYUXJibXlRUXk2NFZTNDNjNE0wK2lLQy9hTXZORVlmRkhBMjlLSEtEa0NJ?=
 =?gb2312?B?TDY3TXhnMzdSeTZQS1c4RWROaGdRenprRm9ZV3ByTXB1VU16cXV3QXNmelAy?=
 =?gb2312?B?MW8xOThuckZTUkdkVm1kdDh2S0lKdFR0d0ZBdnhIUUdKNlpvdndKTHBUb1Bs?=
 =?gb2312?B?RENrMVFQc20rbEJzVjIwdi9Kd3lBUk9URjJ2MFc4clhSbzBQUzBBZ1M0ZFYr?=
 =?gb2312?B?b1FtTDdDZXBsTVltajZTQ0VRcHRucG02bWpaRWZxOHowblNkVEJYeEJXY0Vi?=
 =?gb2312?B?NFlyemRXVXpGK1AydjZwRUlrTzNzbzh4K0lvZGFqNEQrV0pEL3VrRnE2bTky?=
 =?gb2312?B?dXpzOEs0VENya0FDMWc3a055WGVVZmpJdDhRYUMxTkkvYzdkK1l6SU1INzBx?=
 =?gb2312?B?OUVrS0gxbUFWWWMwcVAzTHIwZnNOWDRVbUhlV3QweFFOeFlxRHJsNFdWYjI2?=
 =?gb2312?B?T21kMWpNQjN5VWk1a09CR0RSWVlGcWFDSklNNlpJQWJMZUlWYzJIZXVLdzMx?=
 =?gb2312?B?QzZWTFE0cklxTUVmdjN4UTFTNEVSRTBiVWFUeUtrTldrQTFQT2FIVWhGcXpG?=
 =?gb2312?B?dnh0TDdzYmcyYTg1M2JrcmtYT2NVVUZwRi9RQ3FNL3VjMlBEK3NHSHg5ZE9u?=
 =?gb2312?B?TVg0V21jMmFtekZtMGpVYllBREl0MUpGeFNSSVhuamdadmF1dnBGZ01vc1Bo?=
 =?gb2312?B?SmlWMjZXY3hWcjJCK1RQWHZHVW5Wazd5ZHFHSHE4VUh5S3laaFhyZEp5bDFi?=
 =?gb2312?B?ckE1N1N5QmpLaHV3RjdjY2V2aVJHS2tibmdFV0ZsTC91MzZQNlowV25VbmZQ?=
 =?gb2312?B?d1Ixemp5b2YzQjNHTU5uT05hakQ4MU1tUk1RTkF2TVRYQnhReldxSVNaTStX?=
 =?gb2312?B?WHR1akNSWEpaa2ZkSllwMTdsOTF0R0lDdm9XOTI2alRJSDVJT2Q3MHZGSldF?=
 =?gb2312?B?MlBiQXhZa0MxbUJTQTZ4cTJaV0JmdTBjdzRtZEFsVm8zTjJ1TUVtc1BJeXNU?=
 =?gb2312?B?cjN1NklLckVVQVF1aVBzM25kTVBYYkRwQm1XNSs1bmJYNUF0L0hlNjBaY055?=
 =?gb2312?B?M3FOZDdVUG1aVmlZTVpNVGN0NEhEcmJDeU81TDdxaVQ3dnFNZzJjSnRoTkhj?=
 =?gb2312?B?SmpSaWI3MUNPejdsVXIycExGdUdtNGZaa05DazhhejIrY1FMTS9NVHZIczJn?=
 =?gb2312?B?RHh3UDhIdVZ3enRzLzJoZzNVQXZNa3dqdnlqU1ROU3RXV0xhNWJhUWNqRlJp?=
 =?gb2312?B?ajZ6MUh3VDJKZ3ZPVXU4MG9vUkU5b2pMQ1Z0Yjk0Ti92dzg5UDU4dEZOMEZl?=
 =?gb2312?B?dk1ES3dGakVzU2dNTEsyaHczVVRISFRCSzdFcTNtYUdobmpyc2lDSFFNb0o0?=
 =?gb2312?B?Z3FGSXkxeGV4ditzeVdXQ1lIaDVkZ1RYVEtkOGw2WkI1WURESndkUHVsRUpn?=
 =?gb2312?B?aTEzN1p2ZzFSRUZ5YXRmdzJ2djl1OUpwMVIvSTdMeEZza25heFFYTUxjUW0v?=
 =?gb2312?B?Y1plNTcwVVpSOWwzWXBGeWN5KzRMeFh3dVFnSFNRYmwyYm0xMVdHbEpTR2t6?=
 =?gb2312?B?dEVESTJINVM0WXdFRGk2Tm9IUEY5ZFlhUThEYUx4OTFhWGxNbkQ1U1dnPT0=?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <4481B87F3B8BDE44AA26EBB80A18766B@sct-15-20-4755-11-msonline-outlook-6ea25.templateTenant>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB6321.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3d5f79-4c9c-446c-c803-08db3e4f1ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2023 07:49:29.0067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6161
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNi8yMDIzIDM6MjYgUE0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6Cj4gT24gMTUv
MDQvMjAyMyAxNjoxOCwgWWFuZyBYaXdlbiB2aWEgQjQgUmVsYXkgd3JvdGU6Cj4+IEZyb206IFlh
bmcgWGl3ZW4gPGZvcmJpZGRlbjQwNUBvdXRsb29rLmNvbT4KPj4KPj4gSGkzNzk4TVYyMDAgaGFz
IGFuIGV4dHJhIGNsb2NrLCBhbHNvIGRvY3VtZW50IGl0IGhlcmUuCj4gCj4gVXNlIHN1YmplY3Qg
cHJlZml4ZXMgbWF0Y2hpbmcgdGhlIHN1YnN5c3RlbSAod2hpY2ggeW91IGNhbiBnZXQgZm9yCj4g
ZXhhbXBsZSB3aXRoIGBnaXQgbG9nIC0tb25lbGluZSAtLSBESVJFQ1RPUllfT1JfRklMRWAgb24g
dGhlIGRpcmVjdG9yeQo+IHlvdXIgcGF0Y2ggaXMgdG91Y2hpbmcpLgo+IAo+IAo+IFN1YmplY3Q6
IGl0IGlzIHdheSB0b28gbG9uZy4gSXQgc2hvdWxkIGJlIGp1c3QgY29udmVyc2lvbi4gRG9uJ3QK
PiBpbnRyb2R1Y2UgbmV3IGNvbXBhdGlibGVzLgo+IAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5n
IFhpd2VuIDxmb3JiaWRkZW40MDVAb3V0bG9vay5jb20+Cj4+IC0tLQo+PiAgLi4uL2JpbmRpbmdz
L21tYy9oaTM3OThjdjIwMC1kdy1tc2hjLnR4dCAgICAgICAgICAgfCA0MCAtLS0tLS0tLS0tCj4+
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvaGlzdGItZHctbXNoYy55YW1sICAgICB8IDkw
ICsrKysrKysrKysrKysrKysrKysrKysKPj4gIDIgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9u
cygrKSwgNDAgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbW1jL2hpMzc5OGN2MjAwLWR3LW1zaGMudHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9oaTM3OThjdjIwMC1kdy1tc2hjLnR4dAo+PiBk
ZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggYTA2OTNiNzE0NWYyYS4uMDAwMDAwMDAw
MDAwMAo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2hpMzc5
OGN2MjAwLWR3LW1zaGMudHh0Cj4+ICsrKyAvZGV2L251bGwKPj4gQEAgLTEsNDAgKzAsMCBAQAo+
PiAtKiBIaXNpbGljb24gSGkzNzk4Q1YyMDAgc3BlY2lmaWMgZXh0ZW5zaW9ucyB0byB0aGUgU3lu
b3BzeXMgRGVzaWdud2FyZSBNb2JpbGUKPj4gLSAgU3RvcmFnZSBIb3N0IENvbnRyb2xsZXIKPj4g
LQo+PiAtUmVhZCBzeW5vcHN5cy1kdy1tc2hjLnR4dCBmb3IgbW9yZSBkZXRhaWxzCj4+IC0KPj4g
LVRoZSBTeW5vcHN5cyBkZXNpZ253YXJlIG1vYmlsZSBzdG9yYWdlIGhvc3QgY29udHJvbGxlciBp
cyB1c2VkIHRvIGludGVyZmFjZQo+PiAtYSBTb0Mgd2l0aCBzdG9yYWdlIG1lZGl1bSBzdWNoIGFz
IGVNTUMgb3IgU0QvTU1DIGNhcmRzLiBUaGlzIGZpbGUgZG9jdW1lbnRzCj4+IC1kaWZmZXJlbmNl
cyBiZXR3ZWVuIHRoZSBjb3JlIFN5bm9wc3lzIGR3IG1zaGMgY29udHJvbGxlciBwcm9wZXJ0aWVz
IGRlc2NyaWJlZAo+PiAtYnkgc3lub3BzeXMtZHctbXNoYy50eHQgYW5kIHRoZSBwcm9wZXJ0aWVz
IHVzZWQgYnkgdGhlIEhpc2lsaWNvbiBIaTM3OThDVjIwMAo+PiAtc3BlY2lmaWMgZXh0ZW5zaW9u
cyB0byB0aGUgU3lub3BzeXMgRGVzaWdud2FyZSBNb2JpbGUgU3RvcmFnZSBIb3N0IENvbnRyb2xs
ZXIuCj4+IC0KPj4gLVJlcXVpcmVkIFByb3BlcnRpZXM6Cj4+IC0tIGNvbXBhdGlibGU6IFNob3Vs
ZCBjb250YWluICJoaXNpbGljb24saGkzNzk4Y3YyMDAtZHctbXNoYyIuCj4+IC0tIGNsb2Nrczog
QSBsaXN0IG9mIHBoYW5kbGUgKyBjbG9jay1zcGVjaWZpZXIgcGFpcnMgZm9yIHRoZSBjbG9ja3Mg
bGlzdGVkCj4+IC0gIGluIGNsb2NrLW5hbWVzLgo+PiAtLSBjbG9jay1uYW1lczogU2hvdWxkIGNv
bnRhaW4gdGhlIGZvbGxvd2luZzoKPj4gLQkiY2l1IiAtIFRoZSBjaXUgY2xvY2sgZGVzY3JpYmVk
IGluIHN5bm9wc3lzLWR3LW1zaGMudHh0Lgo+PiAtCSJiaXUiIC0gVGhlIGJpdSBjbG9jayBkZXNj
cmliZWQgaW4gc3lub3BzeXMtZHctbXNoYy50eHQuCj4+IC0JImNpdS1zYW1wbGUiIC0gSGkzNzk4
Q1YyMDAgZXh0ZW5kZWQgcGhhc2UgY2xvY2sgZm9yIGNpdSBzYW1wbGluZy4KPj4gLQkiY2l1LWRy
aXZlIiAgLSBIaTM3OThDVjIwMCBleHRlbmRlZCBwaGFzZSBjbG9jayBmb3IgY2l1IGRyaXZpbmcu
Cj4+IC0KPj4gLUV4YW1wbGU6Cj4+IC0KPj4gLQllbW1jOiBtbWNAOTgzMDAwMCB7Cj4+IC0JCWNv
bXBhdGlibGUgPSAiaGlzaWxpY29uLGhpMzc5OGN2MjAwLWR3LW1zaGMiOwo+PiAtCQlyZWcgPSA8
MHg5ODMwMDAwIDB4MTAwMDA+Owo+PiAtCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzUgSVJRX1RZ
UEVfTEVWRUxfSElHSD47Cj4+IC0JCWNsb2NrcyA9IDwmY3JnIEhJU1RCX01NQ19DSVVfQ0xLPiwK
Pj4gLQkJCSA8JmNyZyBISVNUQl9NTUNfQklVX0NMSz4sCj4+IC0JCQkgPCZjcmcgSElTVEJfTU1D
X1NBTVBMRV9DTEs+LAo+PiAtCQkJIDwmY3JnIEhJU1RCX01NQ19EUlZfQ0xLPjsKPj4gLQkJY2xv
Y2stbmFtZXMgPSAiY2l1IiwgImJpdSIsICJjaXUtc2FtcGxlIiwgImNpdS1kcml2ZSI7Cj4+IC0J
CWZpZm8tZGVwdGggPSA8MjU2PjsKPj4gLQkJY2xvY2stZnJlcXVlbmN5ID0gPDIwMDAwMDAwMD47
Cj4+IC0JCWNhcC1tbWMtaGlnaHNwZWVkOwo+PiAtCQltbWMtZGRyLTFfOHY7Cj4+IC0JCW1tYy1o
czIwMC0xXzh2Owo+PiAtCQlub24tcmVtb3ZhYmxlOwo+PiAtCQlidXMtd2lkdGggPSA8OD47Cj4+
IC0JfTsKPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
bWMvaGlzdGItZHctbXNoYy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21tYy9oaXN0Yi1kdy1tc2hjLnlhbWwKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXgg
MDAwMDAwMDAwMDAwMC4uMDVhNDM1MTg1ZTlkYQo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvaGlzdGItZHctbXNoYy55YW1sCj4+
IEBAIC0wLDAgKzEsOTAgQEAKPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAK
Pj4gKyVZQU1MIDEuMgo+PiArLS0tCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hl
bWFzL21tYy9oaXN0Yi1kdy1tc2hjLnlhbWwjCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJl
ZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMKPj4gKwo+PiArdGl0bGU6Cj4+ICsgIEhpc2ls
aWNvbiBIaTM3OThDVjIwMCBzcGVjaWZpYyBleHRlbnNpb25zIHRvIHRoZSBTeW5vcHN5cyBEZXNp
Z253YXJlIE1vYmlsZQo+PiArICBTdG9yYWdlIEhvc3QgQ29udHJvbGxlcgo+PiArCj4+ICttYWlu
dGFpbmVyczoKPj4gKyAgLSBZYW5nIFhpd2VuIDxmb3JiaWRkZW40MDVAb3V0bG9vay5jb20+Cj4+
ICsKPj4gK2Rlc2NyaXB0aW9uOgo+PiArICBUaGUgU3lub3BzeXMgZGVzaWdud2FyZSBtb2JpbGUg
c3RvcmFnZSBob3N0IGNvbnRyb2xsZXIgaXMgdXNlZCB0byBpbnRlcmZhY2UKPj4gKyAgYSBTb0Mg
d2l0aCBzdG9yYWdlIG1lZGl1bSBzdWNoIGFzIGVNTUMgb3IgU0QvTU1DIGNhcmRzLiBUaGlzIGZp
bGUgZG9jdW1lbnRzCj4+ICsgIGRpZmZlcmVuY2VzIGJldHdlZW4gdGhlIGNvcmUgU3lub3BzeXMg
ZHcgbXNoYyBjb250cm9sbGVyIHByb3BlcnRpZXMgZGVzY3JpYmVkCj4+ICsgIGJ5IHN5bm9wc3lz
LWR3LW1zaGMudHh0IGFuZCB0aGUgcHJvcGVydGllcyB1c2VkIGJ5IHRoZSBIaXNpbGljb24gSGkz
Nzk4Q1YyMDAKPj4gKyAgc3BlY2lmaWMgZXh0ZW5zaW9ucyB0byB0aGUgU3lub3BzeXMgRGVzaWdu
d2FyZSBNb2JpbGUgU3RvcmFnZSBIb3N0IENvbnRyb2xsZXIuCj4gCj4gRHJvcCB0aGUgbGFzdCBz
ZW50ZW5jZS4KPiAKPj4gKwo+PiArYWxsT2Y6Cj4+ICsgIC0gJHJlZjogInN5bm9wc3lzLWR3LW1z
aGMtY29tbW9uLnlhbWwjIgo+IAo+IERyb3AgcXVvdGVzLgo+IAo+PiArICAtIGlmOgo+PiArICAg
ICAgcHJvcGVydGllczoKPj4gKyAgICAgICAgY29tcGF0aWJsZToKPj4gKyAgICAgICAgICBjb250
YWluczoKPj4gKyAgICAgICAgICAgIGNvbnN0OiBoaXNpbGljb24saGkzNzk4bXYyMDAtZHctbXNo
Ywo+PiArICAgIHRoZW46Cj4+ICsgICAgICBwcm9wZXJ0aWVzOgo+PiArICAgICAgICBjbG9ja3M6
Cj4+ICsgICAgICAgICAgbWluSXRlbXM6IDUKPj4gKwo+PiArICAgICAgICBjbG9jay1uYW1lczoK
Pj4gKyAgICAgICAgICBtaW5JdGVtczogNQo+IAo+IEVudGlyZSBhbGxPZiBnb2VzIGFmdGVyIHJl
cXVpcmVkOi4KPiAKPj4gKwo+PiArcHJvcGVydGllczoKPj4gKyAgY29tcGF0aWJsZToKPj4gKyAg
ICBlbnVtOgo+PiArICAgICAgLSBoaXNpbGljb24saGkzNzk4Y3YyMDAtZHctbXNoYwo+PiArICAg
ICAgLSBoaXNpbGljb24saGkzNzk4bXYyMDAtZHctbXNoYwo+IAo+IE5ldyBjb21wYXRpYmxlcyBh
cmUgbm90IHJlbGF0ZWQgdG8gY29udmVyc2lvbi4KPiAKPj4gKwo+PiArICByZWc6Cj4+ICsgICAg
bWF4SXRlbXM6IDEKPj4gKwo+PiArICBpbnRlcnJ1cHRzOgo+PiArICAgIG1heEl0ZW1zOiAxCj4+
ICsKPj4gKyAgY2xvY2tzOgo+PiArICAgIG1pbkl0ZW1zOiA0Cj4+ICsgICAgbWF4SXRlbXM6IDUK
Pj4gKyAgICBkZXNjcmlwdGlvbjogQSBsaXN0IG9mIHBoYW5kbGVzIGZvciB0aGUgY2xvY2tzIGxp
c3RlZCBpbiBjbG9jay1uYW1lcwo+IAo+IERyb3AgZGVzY3JpcHRpb24uCj4gCj4+ICsKPj4gKyAg
Y2xvY2stbmFtZXM6Cj4+ICsgICAgbWluSXRlbXM6IDQKPj4gKyAgICBpdGVtczoKPj4gKyAgICAg
IC0gY29uc3Q6IGNpdQo+PiArICAgICAgLSBjb25zdDogYml1Cj4+ICsgICAgICAtIGNvbnN0OiBj
aXUtc2FtcGxlCj4+ICsgICAgICAtIGNvbnN0OiBjaXUtZHJpdmUKPj4gKyAgICAgIC0gY29uc3Q6
IHNhcC1kbGwtbW9kZQo+IAo+IE9ubHkgZm91ciBjbG9ja3Mgd2VyZSBpbiBvcmlnaW5hbCBkb2N1
bWVudC4gRG9uJ3QgbWl4IGRpZmZlcmVudCBjaGFuZ2VzCj4gaW4gb25lIHBhdGNoLgo+IAo+PiAr
Cj4+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlCj4+ICsKPj4gK3JlcXVpcmVkOgo+PiAr
ICAtIGNvbXBhdGlibGUKPj4gKyAgLSByZWcKPj4gKyAgLSBpbnRlcnJ1cHRzCj4+ICsgIC0gY2xv
Y2tzCj4+ICsgIC0gY2xvY2stbmFtZXMKPj4gKwo+PiArZXhhbXBsZXM6Cj4+ICsgIC0gfAo+PiAr
ICAgIGVtbWM6IG1tY0A5ODMwMDAwIHsKPj4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiaGlz
aWxpY29uLGhpMzc5OGN2MjAwLWR3LW1zaGMiOwo+PiArICAgICAgICAgICAgcmVnID0gPDB4OTgz
MDAwMCAweDEwMDAwPjsKPiAKPiBXcm9uZyBpbmRlbnRhdGlvbi4gVXNlIDQgc3BhY2VzIGZvciBl
eGFtcGxlIGluZGVudGF0aW9uLgo+IAo+PiArICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwzNT47
Cj4+ICsgICAgICAgICAgICBjbG9ja3MgPSA8JmNyZyAxPiwKPiAKPj4gKwo+Pgo+IAo+IEJlc3Qg
cmVnYXJkcywKPiBLcnp5c3p0b2YKPiAKVGhhbmtzLCB3aWxsIGZpeCBpbiB2My4KQnkgdGhlIHdh
eSwgdGhpcyBpcyB2MSwgdjIgZml4ZWQgc29tZSBtaXN0YWtlcyBhbmQgdGhlIGNoYW5nZWxvZyBp
cyBpbgp0aGUgY292ZXItbGV0dGVyLgotLSAKQmVzdCByZWdhcmRzLApZYW5nIFhpd2VuCgo=
