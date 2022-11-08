Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED296209F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiKHHSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiKHHR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:17:59 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2126.outbound.protection.outlook.com [40.107.255.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263DC317C0;
        Mon,  7 Nov 2022 23:17:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFoyehn4rlN3gA91MPRarG1E8xkA02Qz9fYml/snrvPRNYC6W0gkSLMo4RudGuQbfSUkreOcy686sWu29qsYVVlD/ICaLQQATVOAFbgg1cLUKOlNGOKmKvvz+pCsNVbuEeW0HCdiZ7tEz0LdLRp3UBeHA6eXzfgXFwXdD7kaz7r274cqti8bQX7dDKtSGOG0c1UZj0xosssFgleCfbInoFJ8yuXyUETqfWVvBIkLUaIlXbfPgwVAzynQldzs/8JaTfIj8jHKGerETywy5jaCGW8YCyO7vZbJm/7p+hmW5SiZHoYEapUx16C7vDhmWSRROfYYxHGLLptc0Ct7HK4GnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z02ORDOJklA+3twYPXE1aJ8PueqK99wXDa0ExeUjnFI=;
 b=JQComhAsVF9izJq3aHXuM/wbivC47daokovEHDGe3xbcmkWjNY5/vtPGtsgHpzxEpn7C+jtSsrafpW7QHMGle/PkjuhGudeFO4rNEbviSOqwzj8ebtMrY4ntJ0kCJnfc5cOa+jlwYc/mW51IHPezfOLLkhco3O1sxilVUBJ9WHZd3GkJXTXFmowKDwQM0jBHOlQAUQyqDd1Pt3GTP5AJpLm0dpPn05Uijv7z5jEWdXJIZjWsXCEdd6Aa02smJV15SsU/5/ORWHdSZ9LYi4Zl+yDlp6FaYpNYTff8JLV4XBr0DebH2g3gc3RCk1GBrIP3yX8KvGzZX/0AFF6L7jD9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z02ORDOJklA+3twYPXE1aJ8PueqK99wXDa0ExeUjnFI=;
 b=SjdHXF730BTsvJuQRpeBMral09LGbD3VV32GYDjglrOq8Z7U1f01SmOc96yMyEmLtcp/Ai26w5IjwyGVVSKjQMYC6Z09PdDTzTL3HtmjkT4776g+tNSdHnJqy2SDBf04BchQD3/QGrVbt7/26K7BlHZx1nWeAHacpRCAYLbZ31WY6IMRMoJ1RLNRDDStbtxuWbqOl8j1mLQZIXAAMXjRBUF8wi2WPri3dW/9BOZRulHezaGhywivqCSrOHf8Fz4rD9KCvQLgUaAwFvsXbsHfa+VT7LFJJFIFo5l0RSGYFPT62bRVscY0igSRUo4UEF8WtTktakZy/hvRX7Iekpgjxw==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 TYZPR06MB5907.apcprd06.prod.outlook.com (2603:1096:400:339::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 07:17:48 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831%6]) with mapi id 15.20.5769.019; Tue, 8 Nov 2022
 07:17:48 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: Re: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
Thread-Topic: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
Thread-Index: AQHY7ddiCLgpICHNHkaN+NgNt8n5/K4qDDAAgAGuNQCAACN3AIABPBaA//+EZgCAAJm3AIAADgqAgACn1oA=
Date:   Tue, 8 Nov 2022 07:17:48 +0000
Message-ID: <4EC60594-E1F5-4F05-A9E6-3BDCFAE62A65@aspeedtech.com>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
 <20221101131456.GA1310110@roeck-us.net>
 <271C521D-8F20-4C86-B3DA-9C0AD74242D4@aspeedtech.com>
 <20221102170138.GA2913353@roeck-us.net>
 <F1166366-99CC-4A36-A0A2-4965C787E60B@aspeedtech.com>
 <20221103043034.GA2113834@roeck-us.net>
 <E9E92BC7-CB1A-487F-9E5D-2A403A01CB17@aspeedtech.com>
 <20221103143059.GB145042@roeck-us.net>
In-Reply-To: <20221103143059.GB145042@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.66.22101101
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|TYZPR06MB5907:EE_
x-ms-office365-filtering-correlation-id: 2d92fda0-1fc6-4108-eff1-08dac1595707
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QCe50A8hO6omYyZwpYCrYOU17l7eaHaTXFrVdcMusGqa+JNRin2VcZu5IlmkocpGErGmEdlQiNQwj/wIVaSTg3+gteg8q9D9b625L34YjQxf6iGpSLkjj5FG5IYa9GUOSKpqY+DC0dX3MjDP/+Ue2jzVHQSPddjiTObf1I2nzXVqxfS3+fVhyE4na/MX6YouVc2hGCMC6BE/clQuN4HCD5NJBEmtof6BDKbakGF5sz8cZs1ZxpH54Wmoup7gyeSdcwl6IiMrGofuUOcmP8tKdT3HE/XVNP0IPRSy0KvSi52/+QfPim4X9YqZcb7IOKb8BzwGgP1HHUbAyPDH6FlSall3IVlZHJe4lRDuV3r8FX2Bx9OjA6PS4+rKk6s9GDeOn+9toXvFURFDbpKF97n8g5gzZ6eRFn8dVYoiOhCcY9qGWkSwJs+ZEprEsnFf662gNFwVua4d1s7r2e+YG5GhB7MQnzAM7+nPxm/BP93OAbvA0Kg9NmUBtJsNyiGokI9UYK2QMlymEQaMDlgafWcnHeWt1ekV9+JvGyH6a6K/EsXRxVFvbYP0ANi/laiSUZx72UwCQh86gYXoxIOsXAqOwNo2e+pVJFMSMeuM10wKfGlHHJZGJCzS0ISMqDkH0x9LapmqT5pxkd1G+bymlUcNOuENnvj2rS2HjmWPGLuq0T7JaEaW3BxgsLmfsewfNZWOfr37gE942cbX7PbBuDOu5q0p0hS6WRMs5wAIxJaUaP+3fJrtLa/TCgw1v+HnDrNvLNKat2tOmeqR8bjOecw9DVaBiZeiH63+EOq5L8NV7Wg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(366004)(39840400004)(451199015)(83380400001)(186003)(316002)(38100700002)(6916009)(41300700001)(8936002)(54906003)(478600001)(6486002)(2906002)(36756003)(6506007)(53546011)(6512007)(33656002)(26005)(71200400001)(122000001)(86362001)(2616005)(5660300002)(66556008)(8676002)(66446008)(38070700005)(4326008)(66946007)(76116006)(7416002)(64756008)(91956017)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1I5cEZiVU5jRm9QWnBrcnMrUldZQmhOVzlhYW4yYWljQ0ZNSDVGVFRJeGxZ?=
 =?utf-8?B?bVRvbk9jTnE2bnVoQmcxQThhUXYvWitRclFSM0hrTkpLL0VwekJGWUo2UDha?=
 =?utf-8?B?dzRJNi9WUU9nQmppdnZqUXBYSHdpSVp0S1Y1ejJvUXFWbDMwSmRwVzFvd2Fi?=
 =?utf-8?B?TkJNanVFdlZRMCt4aG9rbEhjdFF1Rnh0dXJKb0tWbEV5b1dmTkE3WkR5OE1V?=
 =?utf-8?B?QmcxZGlDVEdXQncwdE13Q1hheXh5Rzc0ZVlpbHdqZyttZ1hWdmxvV28wY2lK?=
 =?utf-8?B?UjdoRmdnbFlxS0ZrUDBCd1RoTWhOaUg4eTRBWnJaWVorRzhLQzZsY1l4bWlF?=
 =?utf-8?B?OFl5Zk9CUCtaWlVIdVUrS2R0K3g0YVJWSGZrNFpkbGN0NHV5Q3d2VCt2U3pN?=
 =?utf-8?B?UXFINkR1YXg0bzVYdmlCTVRvZ0R2SGZqN1NhdUxNSnpTSUdLWHBKK3lMZFRr?=
 =?utf-8?B?MC8xcGNnUXpUekw5bXk1U0l4RU1sQWFDRlp4dU1zeXh6YTU3SnlWQ0dzeDB1?=
 =?utf-8?B?RHZDcEhKOU8yTXlyNTc4WExlZHpFdG5SKzBMOWwrd0x6dEhNNnB3akRHZ044?=
 =?utf-8?B?T0tOME5IUDRTOXF2b3lmTnVCLzR0aStkYm1vRnpJQTR3S3RNZzh0WTZkQzlF?=
 =?utf-8?B?anB0WEFhMkVNZzJ4RXVSaE1pTnBUTEh5bVFCeDhtRTArVXNHVGorQkR0eUxR?=
 =?utf-8?B?VFYxQ0lnbnVMeldlcjIrbU5MTFBuOFhkQy85N2xmQ1o5V3lJMWsyR2VFUk1p?=
 =?utf-8?B?RldHTWpaSndMblJYc1BGdndnbmprbHdkRERTbnY4TDZzMXF3Mm5ZVVc1WEdu?=
 =?utf-8?B?SisxaDF5ZitqbE02ckRBS0x4S2VKeW1oYUd6cHhBUEo2aG81UjBadGE4cG1Z?=
 =?utf-8?B?UlRzTmZlYTFqUzFqTWFoVi9qZW83d1ZZTllIdU4wbTNSMjBkYzB6ajJueFJ4?=
 =?utf-8?B?UGhmeHpOUXBKR2RUOUZBbDQzeDQ0ZExEMzhQY3pVUVdLaDJLcXk1YUZzMUVC?=
 =?utf-8?B?NkhNTzk1Rk1OOXNhWUV5bmE5RXhuYUxHZnNaVUtzNm4zR0VGK3hYSUNadk90?=
 =?utf-8?B?aUFlelZLcGcveGRjK1VaVWZ3eC9UNUR1Tmc1Y2pJOWtXM0JJVWgxOVlEamx2?=
 =?utf-8?B?MHZvQ202aTZYZHEzSHJBKzdtQUVMUEFudmZIUUNIbHdZcE05dVZjT01WTFFq?=
 =?utf-8?B?dkt0VmFUNUZCTXk2bEVaeUR0cnE3L2ZiZFRYdFV4OVR1UE9zYWpUcVdtTXdz?=
 =?utf-8?B?aktWc09rNjNJSGtRNWg4amRsU0xQamp4T2xYRnRRYTRsRWdWeDA1MTY0UUhi?=
 =?utf-8?B?bW1Cb28vNmlqMFp1cngyb0lRVXBOcnVxUmpLWDFxc25HYnF4UVR1UStwOWUx?=
 =?utf-8?B?ODFHNlhOYjNIUUlnZit3by9iQncvR294bVpISU5Jc1R1bWNJTDN0QkJaUWhq?=
 =?utf-8?B?TVorcy82cysxY3NvRG42dnl6WllYcHRzcjBTaHg1MUcxVS9oQmZVMGpKTzRl?=
 =?utf-8?B?Z2QzRTFSUFhQcUJyUFZ2QXYwejJBZnJXRzlUdDNrQ1NMQVBDSThSVG5EYnV4?=
 =?utf-8?B?YmpGTURmcGpWSFlieXJNVjE3V0p4UkxHckRrcnB3S1g3TWF0ZzhHbkRIYXBo?=
 =?utf-8?B?Z01LODUvam8rL2NzYzBUWWpSRmNUai9KaW5xaWRhWE9XamkySUNVT2o3Wkl3?=
 =?utf-8?B?dExBZzQ5TTk1ZVVvTlJIVUxzcElWNUw2YVMzVE9Hd0FHREN4ZitwbU53ZG9q?=
 =?utf-8?B?S3kzYWo4TjR0M2EwN1IraHVVSnFzZEZHZnhiOE0rTGYva0ZGZHd4RGtRNitt?=
 =?utf-8?B?eTZLS2FGcDRwZmdtajJDZUlOTjFveVhSb0o2TXFmVmF0amFUcHlRak81SUFF?=
 =?utf-8?B?UFZhM09IRkdFR3BXKzIwdEl3VUJQcmhyQWRteWl0enJaUEd4ZVp3aC8rWk5l?=
 =?utf-8?B?L1R3L05YK3lqazltN2lGSmV4ZVJGV053bDZxellYeElpNGszb1craWtnWWpT?=
 =?utf-8?B?VDhwTU1rNDFvQjdGcnVhdVRFeENtVDZVcUlVb3o1UlA1RE5XMU9OajNULzQ5?=
 =?utf-8?B?REpiR0srVFE4ZDVlR0cyTzVQTU1jQWZJN0k2RiszYjJjY1YzTHZIeW5mRFBU?=
 =?utf-8?B?T2w2d3M3NGRjN0JaMkFDOXVpQlFVSm5SVEkrY3VwN1FBSTBhQUU3NjhzZEJm?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AC886FA082A0C469D797E58D76E7CD1@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d92fda0-1fc6-4108-eff1-08dac1595707
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 07:17:48.2265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzS/pjPIGgU6kGFYZHQi1L4EaBVWwms1nrajXbQWNpvVRznNUcv4vDZJqGeynpQzke5pViR0KMbCZ1rnShacMEuUBy+er3YY8MBB5RkZMPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMDIyLzExLzMsIDEwOjMxIFBNLCAiR3VlbnRlciBSb2VjayIgPGdyb2VjazdAZ21haWwu
Y29tIG9uIGJlaGFsZiBvZiBsaW51eEByb2Vjay11cy5uZXQ+IHdyb3RlOg0KDQogICAgT24gVGh1
LCBOb3YgMDMsIDIwMjIgYXQgMDU6NDA6NDRBTSArMDAwMCwgQmlsbHkgVHNhaSB3cm90ZToNCiAg
ICA+ID4gT24gMjAyMi8xMS8zLCAxMjozMCBQTSwgIkd1ZW50ZXIgUm9lY2siIDxncm9lY2s3QGdt
YWlsLmNvbSBvbiBiZWhhbGYgb2YgbGludXhAcm9lY2stdXMubmV0PiB3cm90ZToNCiAgICA+ID4g
DQogICAgPiA+ICAgICBPbiBUaHUsIE5vdiAwMywgMjAyMiBhdCAwMzo1Mjo1OUFNICswMDAwLCBC
aWxseSBUc2FpIHdyb3RlOg0KICAgID4gPiAgICAgPiA+IA0KICAgID4gPiAgICAgPiA+IENhbid0
IEkgdXNlIGEgbWluL21heCBSUE0gdG8gbGV0IHRoZSBkcml2ZXIga25vdyBhIHJlYXNvbmFibGUg
dGltZW91dC9wb2xsaW5nIHBlcmlvZCB3aGVuDQogICAgPiA+ICAgICA+ID4gdGhlIGRyaXZlciBp
cyB0cnlpbmcgdG8gZ2V0IFJQTT8NCiAgICA+ID4gICAgID4gPiBCZWFjYXVzZSB0aGF0IG91ciB0
YWNoIGNvbnRyb2xsZXIgaGF2ZSB0aGUgZmFsZyB0byBpbmRpY2F0ZXMgdGhlIGhhcmR3YXJlIGRl
dGVjdGVkIHRoZSBjaGFuZ2UNCiAgICA+ID4gICAgID4gPiBpbiB0aGUgaW5wdXQgc2lnbmFsLiBJ
IG5lZWQgdGhlIHByb3BlciB0aW1vdXQgdG8gcnVsZSBvdXQgc2xvdyBSUE1zLg0KICAgID4gPiAN
CiAgICA+ID4gICAgID4gSWYgdGhlIGNoaXAgbWVhc3VyZXMgdGhlIGZhbiBzcGVlZCBjb250aW51
b3VzbHksIHdoeSB3b3VsZCB0aGF0IGV2ZXIgYmUgYQ0KICAgID4gPiAgICAgPiBwcm9ibGVtLCBh
bmQgd2h5IHdhaXQgaW4gdGhlIGZpcnN0IHBsYWNlIGluc3RlYWQgb2YganVzdCB0YWtpbmcgdGhl
IG1vc3QNCiAgICA+ID4gICAgID4gcmVjZW50IHJlc3VsdCA/DQogICAgPiA+IA0KICAgID4gPiAg
ICAgPiBQcmV0dHkgbXVjaCBldmVyeSBvdGhlciBkcml2ZXIgaXMgZG9pbmcgdGhhdCwgc28gSSBy
ZWFsbHkgZG9uJ3QgdW5kZXJzdGFuZA0KICAgID4gPiAgICAgPiB3aHkgdGhhdCB3b3VsZCBub3Qg
d29yayBoZXJlLg0KICAgID4gPiANCiAgICA+ID4gV2hlbiB0aGUgZmFuIHNwZWVkIGRyb3AgZnJv
bSBhIHZlcnkgZmFzdCBSUE0gdG8gYSB2ZXJ5IHNsb3cgUlBNLiBFc3BlY2lhbGx5IHdoZW4gaXQg
aXMgY2xvc2UgdG8gc3RvcHBpbmcuDQogICAgPiA+IFRoZSBtb3N0IHJlY2VudCByZXN1bHQgd2ls
bCBiZSBubyBtZWFuaW5nZnVsIHZhbHVlLiBUaGUgc2xvd2VyIFJQTSBuZWVkcyBtb3JlIHRpbWUg
dG8gc2FtcGxlIGl0LiBFLmcuLCBJZg0KICAgID4gPiB3ZSB3YW50IHRvIG1lYXN1cmUgdGhlIGZh
biB3aXRoIDYwMCBSUE0sIHRoZSBjb250cm9sbGVyIG5lZWRzIGF0IGxlYXN0IDEwMG1zLiBEdXJp
bmcgdGhpcyB0aW1lIHBlcmlvZCwgd2UNCiAgICA+ID4gd2lsbCBhbHdheXMgZ2V0IHRoZSB3cm9u
ZyB2YWx1ZS4gU28sIG91ciB0YWNoIGNvbnRyb2xsZXIgaGF2ZSB0aGUgZmxhZyB0byBhdm9pZCB0
aGlzIHByb2JsZW06DQogICAgPiA+IFRBQ0hfQVNQRUVEX1ZBTFVFX1VQREFURTogdGFjaCB2YWx1
ZSB1cGRhdGVkIHNpbmNlIGxhc3QgcmVhZA0KICAgID4gPiBUaGlzIGZsYWcgd2lsbCBiZSBzZXQg
d2hlbiB0aGUgY29udHJvbGxlciBkZXRlY3RlZCB0aGUgY2hhbmdlIG9mIHRoZSBzaWduYWwgYW5k
IGNsZWFyIGJ5IHJlYWQgaXQuDQogICAgPiA+IEluIG9yZGVyIHRvIHVzZSB0aGlzIGZsYWcsIHRo
ZSBjb250cm9sbGVyIG5lZWRzIHRoZSBwcm9wZXIgdGltZW91dCBiYXNlZCBvbiBtaW5pbXVtIFJQ
TSB0byBhdm9pZCB3YWl0aW5nIGZvcmV2ZXIuDQogICAgPiA+IA0KDQogICAgPiBJIGFtIG5vdCBn
b2luZyB0byBhY2NlcHQgdGhpcyBwYXRjaCBhcy1pcy4gSWYgdXNlcnNwYWNlIHdhbnRzIHRvIGhh
dmUNCiAgICA+IHZhbHVlcyBhY2N1cmF0ZSBkb3duIHRvIG1zLCB0aGlzIGtpbmQgb2YgYXBwcm9h
Y2ggaXMganVzdCB3cm9uZy4gVXNlcnMNCiAgICA+IHdpbGwgaGF2ZSB0byBsaXZlIHdpdGggdGhl
IGZhY3QgdGhhdCBtZWFzdXJlbWVudHMgbWF5IGJlIGEgYml0IChpbiB0aGUgDQogICAgPiA8IDEg
c2Vjb25kIHJhbmdlKSBvdXQgb2YgZGF0ZS4gTWFueSBvbGRlciBkcml2ZXJzIGV2ZW4gaW1wbGVt
ZW50IGNvZGUNCiAgICA+IHdoaWNoIGF2b2lkcyByZWFkaW5nIHJlZ2lzdGVycyBhZ2FpbiBmb3Ig
YSBzZWNvbmQgb3IgbG9uZ2VyLiBPbGRlcg0KICAgID4gdGVtcGVyYXR1cmUgc2Vuc29ycyBtYXkg
dGFrZSBzZXZlcmFsIHNlY29uZHMgdG8gcHJvdmlkZSBuZXcgcmVhZGluZ3MuDQogICAgPiBUaGF0
IGlzIG5vdCBhIHJlYXNvbiB0byBibG9jayB1c2Vyc3BhY2UgdW50aWwgYSBuZXcgdmFsdWUgaXMg
YXZhaWxhYmxlLg0KICAgID4gSSBkbyBub3Qgc2VlIHRoYXQgYXMgYSBwcm9ibGVtLiBJbiBteSBv
cGluaW9uIGl0IGlzIG11Y2ggbW9yZSBvZiBhDQogICAgPiBwcm9ibGVtIGlmIHRoZSBkcml2ZXIg
cmV0dXJucyBhIGNvbXBsZXRlbHkgYmFkIHZhbHVlIHN1Y2ggYXMgMCBvciBldmVuDQogICAgPiBh
biBlcnJvciBjb2RlIGJlY2F1c2UgaXRzIHNvZnR3YXJlIHBhcmFtZXRlcnMgZGlkIG5vdCBtYXRj
aCByZWFsaXR5IGFuZA0KICAgID4gdGhlIGRyaXZlciBkaWRuJ3Qgd2FpdCBsb25nIGVub3VnaCBm
b3IgYSBuZXcgdmFsdWUuIFRoYXQgd291bGQgYmUgX211Y2hfDQogICAgPiB3b3JzZSB0aGFuIHBy
b3ZpZGluZyBhIHZhbHVlIHdoaWNoIGlzIGEgZmV3IDEwMCBtcyBvdXQgb2YgZGF0ZSwgYW5kIHlv
dXINCiAgICA+IGNvZGUgaXMgdnVsbmVyYWJsZSB0byB0aGF0IHByb2JsZW0uDQoNCiAgICA+IEJl
c2lkZXMsIGZvciBhIGZhbiB0byByZWR1Y2UgaXRzIHNwZWVkIHRoYXQgcXVpY2tseSwgaXQgaGFz
IHRvIGJlIG1hbnVhbGx5DQogICAgPiBzdG9wcGVkLiBOb3JtYWxseSBmYW5zIHRha2Ugc2V2ZXJh
bCBzZWNvbmRzIHRvIHN0b3AgaWYgcG93ZXIgaXMgdGFrZW4gYXdheQ0KICAgID4gY29tcGxldGVs
eS4gWW91ciBjb2RlIGlzIGFkZGluZyBhIGxvdCBvZiBjb21wbGV4aXR5IChhbmQgdW5uZWNlc3Nh
cnkNCiAgICA+IGF0dHJpYnV0ZXMpIGZvciBubyBnb29kIHJlYXNvbi4NCg0KVGhhbmtzIGZvciB5
b3VyIGRldGFpbGVkIGV4cGxhbmF0aW9ucy4NCkkgd2lsbCByZW1vdmUgdGhlIG1pbiBhbmQgbWF4
IFJQTXMgYW5kIHJldHVybiB0aGUgdGFjaCB2YWx1ZSBkaXJlY3RseSB3aXRob3V0IGFueSBwb2xs
aW5nIG9yIGRlbGF5Lg0KDQpCZXN0IFJlZ2FyZHMsDQpCaWxseSBUc2FpDQoNCg0K
