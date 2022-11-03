Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7E26177BB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKCHjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCHje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:39:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2121.outbound.protection.outlook.com [40.107.117.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AE1CC8;
        Thu,  3 Nov 2022 00:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRoosNJrUbfWqH23eCYcVr9B3OZ9dJllQe3V9Mm0QlYf76515NLW8HLBuqnfmBivh5ZW9MTxsswcpTWdm0bRvrf4KSv7Vcs6J0zYrLK3b0c/i4W20JTDMKxpB/y8VokS0IvBzm+1Kzv7QykBiBnWlAgA0JMw3J6fgOLcPKCPFVgog/shqsxDhY66jbNfFlW6FPPCozYuXKfFo3u1Eczc+PDqPNjT9T8fgEJ/C0vRK0Nq1yFLy3Xftugkoa7zMRxKynLkEiDftd8/dgO1AxlRTx8x/qCCgwiOLuJKRapHYHoiji0fjjkTyUtE0zjtydNtvgr1Q2n7Ypfsza5n6+Lo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLCBDnA27CYnmvry0zuG5rVwOtP/0GBpfmMCfpE5fJE=;
 b=NSwDkz/a81z8b9jnQKIxMrrpJ064Xfgm6FB50tYMu7rndJVimmAN6VetdxFibTo53CfeeOF2Kc0wbAS9fpvK4ggQAQP8TlJhItswBKqPQuZvq2EttHOU4yv2wmWGu2Sy83dVEhO8dOAKcEqwFA3aZwbiIYfdjqfZ1bt1H/vsdy16N/jBhAp1S2lNzthQkSjekWRZbcMOzpnAdo9qFIUAHtUi7z/k6K3RiP7cYkrTOA62W6aceXe5A5hFNTHD5K1q1zZG/8CCeH9WT5w2ZpdYFhzkmRYIupYzqBCIDSEJGEPfuQyiFUTiP/xSaRNozhD7dOLqVN1f3OK1f5twGreSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLCBDnA27CYnmvry0zuG5rVwOtP/0GBpfmMCfpE5fJE=;
 b=GxIZL9Z1UtrgD231Qa6vo29jC5sBELfuceCv/8UEVUQLAsNGrXYF4h3idfBK6EuhuJVVwjILtulJ06i4KYgsyT5KnXBgl5r7j+VQJN6wTR7LyzFZQRUta1K5S7a58muBh6B+yW9jDNoMn3PJRzmTTeqDnbongYv3jpERyan/2fOain4nLx45OE+J1vR4djd5CUw36+dAcUF8VjGU5Z32CTALgaK/BF6lMFOO80CGtDxGsCyFEogB+/nzkZyO5qoGS/KBnpa/hWfQSspLcLFysC7XQaeK1NGt+wKV/W8utX0T4QD3nFD1UpXPET5vig1jJRV3abv1NqkzlWh1HPTQyw==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 SI2PR06MB4443.apcprd06.prod.outlook.com (2603:1096:4:158::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Thu, 3 Nov 2022 07:39:27 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831%6]) with mapi id 15.20.5769.019; Thu, 3 Nov 2022
 07:39:27 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
Subject: Re: [v2 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Topic: [v2 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Index: AQHY7ddeW4ZmCSdnLkm5NlBsHfM2O64qZyqAgAEXnQCAAHTPAIABZaMA
Date:   Thu, 3 Nov 2022 07:39:27 +0000
Message-ID: <294877DF-1EFB-4E62-9603-3586A13BE471@aspeedtech.com>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-2-billy_tsai@aspeedtech.com>
 <20221101184033.GA1879756-robh@kernel.org>
 <C4090559-71D3-4DC4-A994-474D375DC4EF@aspeedtech.com>
 <CAL_Jsq+eiFO9JyJW=2SB-HLHJLrXggO+7kwG8G-6Zt=K2QnFUA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+eiFO9JyJW=2SB-HLHJLrXggO+7kwG8G-6Zt=K2QnFUA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.66.22101101
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|SI2PR06MB4443:EE_
x-ms-office365-filtering-correlation-id: a985685a-93b9-4d9a-9bf9-08dabd6e8928
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p39fbMgomOTCki/JVkoNvPDl2T9X29IGjU23phvM/dykbFzn+fdBapKcklZLG3vukVXQYGw5c0A4AA52ub4YfjD+Ijayn8FZRsg2upSouQv8raHF0QbItxmOOdk/PyQrluEtR/t3368tGRwa915/EA3zYHutA0TrVjlpSGsviXqM2d7E3A3M52Qa5bCgnQ77FfKTYVCoEW8VoTdfeQAUTSCDki9XGPnEwN6Cd/ERB9bkdABaNL9yda/zBGKNoAzOqK3k2p/cwOr3Q57eFh8gLC6BQbI3JsiHpZ1OVWDhea04ZNoLgFn+TZqRCykP4UcUVKGt2aExwnoiVfTeti2vSaEMEx0LhTyqiceShQT6rPe3U0Ni5ZJF5Jov5JYq+2SSaH0O413mI8QRTpji84ScMIH+hgGiFJovcwo7dkTlYihfwt4KAVa/SFGgu1TIhw2e55MPe4we1cCTnPPbyMGMzEMdmBqeoBlYKWft0ZU2UQ4cYs3wIb19uoqIQK7gRNqu8QJJsQPc90pL/3V2bqh2wLSzlihBss4lVF5j9GcVCsvbDYrq5pR9ObZyfq6uv8/KaWwKiBvA5ARyXRU8peecsQQJl/MhrXHLaH+m0Oo9UfQlgxiLIjw8dTh0ohZSWv5ukXQb9KUUyCO1pPA1kCyd+cOWyRKtUnHPWdtQA4Xc01HCVxhAz8j5OIZznHbSSw/uWN8tBIHspr8a+AEu9UKYKY8tgfDOMD9N/KBcTISEtwen9KlImh2n2igyaeEH/zpqurTsDSC79IIq3RpEdHZHPLTIndu8kbf3WtcGbC79EBu//oL7ADZr5UN79vDc9LOyrA7gUWrElW+svMTsbJC+RdG9P83wAz2DqI+mcyvYJ1RrT5oRdbM4RpBobHsIY1K2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39840400004)(346002)(376002)(136003)(451199015)(53546011)(26005)(6512007)(2616005)(6506007)(83380400001)(186003)(7416002)(71200400001)(316002)(54906003)(6916009)(966005)(478600001)(6486002)(122000001)(38100700002)(38070700005)(8676002)(8936002)(4326008)(64756008)(91956017)(5660300002)(66946007)(76116006)(66556008)(66476007)(41300700001)(66446008)(2906002)(33656002)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vlg4TzB5Y2lUalIrWi9wMXJ2bXdYVU4vMWJTcVZXWWRiK2xEcE5DbTViT0JU?=
 =?utf-8?B?NUxUS0pxVnlWb0x0OExmVm82QlMzQ01JRHl3OEo1Z0RwbWIxS1RObWZvTWlM?=
 =?utf-8?B?SkFONUZ0WDZWQUVVYXFNQi81VVE0eE1ObXlJbHRIK0hZMmZubmFWd3ZWdnZE?=
 =?utf-8?B?REg2bDBKWkp5R3lScjZtcVNIRnRuTS9FU1k2VHIxOUFNNEcxUG8yZjgwWnNF?=
 =?utf-8?B?N1d1d2VCeUJHcGxSL1ZpSmxLbHpIYittNmMwTmxKcE5Dd092NGdqVDYrU0xy?=
 =?utf-8?B?cEV0U1FoaHB6SWY3VklrczZXQm50RVJoTlRwc3FZbmltT2lXMHlHUVRZUmp1?=
 =?utf-8?B?NGhReVEyNUpQelVTRXhCWVRCV2xTNEx4MU9ZNlJxS3lkdloxcE96a1d4SUNO?=
 =?utf-8?B?aTVZeXRFSVQwY3lmQmljdCtuV0Z1bkRMM1J2L2NLK3dQSG1hZFo4eWMva1Rv?=
 =?utf-8?B?M0lBUnFRUUZhSU9KZWI1YXZOcHlHQjZTYjFYNGR6Y2NnN1djRDc4eFBQOGw0?=
 =?utf-8?B?VWhWYUpuemc2VzZlRzN1c1VXMGdLR2NOdzNCcnk4cDFOaFB3WkVKd0MrekhN?=
 =?utf-8?B?OXB4YlFwc08vRERaZzdWdkN0WitHeFR5ZFdYWmNVcG9pTUU2ek5CSFpvWEJN?=
 =?utf-8?B?c2gzbWVBT0xVZVdFSlhyQTBOTWxJR1JNLzlpUHpCRUhQZTZ4S2pxaFYyOE5j?=
 =?utf-8?B?bUlYaUNlK1N3VU9HSnJmVWN0UEhYMUpCdzZpZEJYMCtrZS9pcUxhME8zSjF3?=
 =?utf-8?B?VHA1NWoxMzR2c3F3WDkvVHhNaW82UUZHcFZTck5OL1hHeUFDM3d4U1NVd3FD?=
 =?utf-8?B?UzV3blp4anl6am1IZ3BlWUlkejlzNDNXNjBMbWZBRUZlWmFhSHJvUWRVUzNp?=
 =?utf-8?B?Qm1MWjJmKzZrRWJXS2RXcGtYRDcxQ0hmSTlVMzdGdFRTTEl2Qlg2Vmw1bzRt?=
 =?utf-8?B?bGFVT08vRGM2TW9aOHNGdW5mVUl4eVZsbklJUFJqRFRuZlZJSFFQVnlaU0I3?=
 =?utf-8?B?d29CZGs1dGNqaHI4bk9KeEVBMWdiT1Vpbzg5Rzl0Q2xGTkQyVnlUZDJabzht?=
 =?utf-8?B?aFlYeG02elFEQUU5b2xFcmFGVmgwcTBHVitFWlpNRHpXRjRuTU4zc0d2M2hv?=
 =?utf-8?B?ODVHNUQ1OGVYa3V4dE85SWdTOTlETnZSbHFjSGlQRHVPVUMrMDR3MFhVcVVH?=
 =?utf-8?B?MC85b01PTzVsbEdTR3lVSHFTZ01ib295UG0wclljcnRVSWkyYXVwS2w0VmJN?=
 =?utf-8?B?TTZTandrQzhlNGJFczNNSklPU0dTRzNXNmZZVHR0OEZJRDQ2ZW9Fci9jM3pQ?=
 =?utf-8?B?dEM2YlB1V2FiZkkySUhNL3Exbkl2dCt1S2hZdy9ZTzgxNXhtRnBrMGVoT3VV?=
 =?utf-8?B?RHdtVkRNdXBwL2pKNi9EcFE4c1lZNWhQVVFqUTlMbDlyR1JGRldTUUVoUEow?=
 =?utf-8?B?SEs4andYMkxrdDN0Nlp3SVJNK21EaXB1NTY2c0I2aDlzZktya0xFd24zVEJJ?=
 =?utf-8?B?N3VWaVBydlc5d1RTeW5EQ0hBejIwOVNMTytvSEYzYlRmZkxYdE5xL291NGky?=
 =?utf-8?B?azlrOUw0SVp1Q3ZsK0RPMC9MRmRjc0F2THFqVXJEOXJDMVBiMlIyRy93dG0z?=
 =?utf-8?B?aGt6MHcwYUl2UFJFK29GNDRERnJWdVcvRnlKMHVvdk1Pd096b0tKTjNSemN2?=
 =?utf-8?B?dUNLcjNtTDhRazNoWnJvKzcrckI4MVhsUXhVNVRaVmw5WTNwdUpNSms1MFcr?=
 =?utf-8?B?dnhDYmZmTE1zaGpoc0V6YUw0aHIxN2hKakhzejlRazRQZENUSzJCaFFQNEFq?=
 =?utf-8?B?UnBFRStucGpRa1hjdWp3dEVPQUhtQkl3dXVpa2l0OU1mODJ2dy90V2tpbm5X?=
 =?utf-8?B?S1RLZG1STzhxbFNzWllFOEdjaGJaM0srWmZwYW5yS1dYMWxXU3RkSEE0OU9u?=
 =?utf-8?B?cm1tRlJISnNpL1VDelB5bGJkNXIzdXByNlFVOS9QWWhRbUtycnYzeU1IdEpI?=
 =?utf-8?B?SFVsUEFuL21QUTBBTzlnWDRoTzdkMTZvR0x0ZmliRlp5cUJSV25rZDdRbmFy?=
 =?utf-8?B?S3lWSkRjenNvcDAyb1lBKzhWZzBkeVE4cGRKS1hLOXhGZTE5akhRYnBHUTZ2?=
 =?utf-8?B?SFFNNW9vVFpyZk1zbVhOMjdSODlpWmFpMzBKTE13YkVwdER4YVFJa3Riblda?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6995334DCF5C13499341B60569F7C44B@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a985685a-93b9-4d9a-9bf9-08dabd6e8928
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 07:39:27.1382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtwvRmb6o2nhuqiFpe43j+Yxpb3Utd6NcOTglUY0zayQdgGdyielMAWfNJip41GCAh6svPILos3GhmL1qsJyxhY//+zqbDgAaaBjjrI3IzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4443
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMS8zLCAyOjE5IEFNLCAiUm9iIEhlcnJpbmciIDxyb2JoQGtlcm5lbC5vcmc+IHdy
b3RlOg0KDQogICAgT24gVHVlLCBOb3YgMSwgMjAyMiBhdCAxMDoyMSBQTSBCaWxseSBUc2FpIDxi
aWxseV90c2FpQGFzcGVlZHRlY2guY29tPiB3cm90ZToNCiAgICANCiAgICA+IFRoYXQgYWxsIHNv
dW5kcyBsaWtlIHJlcXVpcmVtZW50cyB0aGF0IHlvdSBoYXZlIHdoaWNoIHlvdSBzaG91bGQNCiAg
ICA+IGVuc3VyZSB0aGUgZmFuIGJpbmRpbmcgY2FuIHN1cHBvcnQuDQoNCiAgICA+IEkndmUgYWxy
ZWFkeSBzYWlkIHRvIHVzZSB0aGUgUFdNIGJpbmRpbmcgaW4gdGhlIGZhbiBiaW5kaW5nIGV4YWN0
bHkNCiAgICA+IGZvciB0aGUgcHVycG9zZSBvZiBob29raW5nIHVwIHRoZSBQV01zIHRvIG90aGVy
IHRoaW5ncy4gV2hldGhlciB0aGUNCiAgICA+IHRhY2ggY29udHJvbGxlciBpcyB1c2VmdWwgZm9y
IHNvbWV0aGluZyBvdGhlciB0aGFuIGZhbnMsIEkgZG9uJ3Qga25vdy4NCiAgICA+IFNlZW1zIGxl
c3MgbGlrZWx5LiBUaGUgbWF4NjYzOSBhbHNvIGhhcyBhIHRhY2ggY29udHJvbGxlci4gU28gaWYg
b3RoZXINCiAgICA+IHVzZXMgYXJlIHBvc3NpYmxlIGZvciB5b3UsIHRoZW4gaXQgY291bGQgYmUg
cG9zc2libGUgZm9yIGFueSBvdGhlciBoL3cNCiAgICA+IGxpa2UgdGhlIG1heDY2MzkuDQoNClRo
ZSBsaW51eCBrZXJuZWwgYWxyZWFkeSBoYXZlIHRoZSBzaW1pbGFyIGJpbmRpbmc6DQpodHRwczov
L2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2h3bW9uL3B3bS1mYW4udHh0IA0KVGhlcmVmb3JlLCBJIHdhbnQgdG8g
cmV1c2UgaXQgYW5kIHRoZSBwd20tZmFuLmMgaW5zdGVhZCBvZiBjcmVhdGluZyBhbm90aGVyIHNp
bWlsYXIgZmFuIGJpbmRpbmcgYW5kIGRyaXZlci4NCkkgYW0gcmVmZXJyaW5nIHRvIHRoZSBmb2xs
b3dpbmcgZmlsZXM6DQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0
ZXIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9rb250cm9uJTJDc2wyOGNw
bGQueWFtbCANCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2tvbnRyb24lMkNzbDI4Y3BsZC1w
d20ueWFtbCANCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24va29udHJvbiUyQ3NsMjhjcGxk
LWh3bW9uLnlhbWwgDQpJdCB3aWxsIGFsc28gcmV1c2UgdGhlIHB3bS1mYW4gaW5zdGVhZCBjcmVh
dGluZyBpdCBvd24gcHdtLWZhbiBiaW5kaW5nIGZvciB0aGVpciBod21vbih0YWNoKS4NCmh0dHBz
Oi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1rb250cm9uLXNsMjgtdmFyMy1hZHMyLmR0cyNMMjAg
DQoNClRoYW5rcw0KDQpCZXN0IFJlZ2FyZHMsDQpCaWxseSBUc2FpDQoNCg0K
