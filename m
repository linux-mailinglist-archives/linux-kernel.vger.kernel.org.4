Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F10D63BCD3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiK2JXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiK2JXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:23:00 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753003C6F5;
        Tue, 29 Nov 2022 01:22:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b22bBXOgNXzKiVDxehmyMHnVk+l91oC/KZwPZhuwxUeklbU4bRx6zqipRBskBioQC92UKMYI8Ksg7WqMwBaTS3wnaNJ11m6ab6IXijPDYUo50i2cNH672jxekBf8xAKHs7HJfsReGZhagAm+Pa4a6vd1qA2zYp0DsB947fcqTo5zkwngHUS+o0Vvugzxw5Mmh7qZXMKBKg1MfnnRnyWDkR2wIy2/hB+K3P6BhbpO7V/1nqr2PfUPTZKSJisgSdOaVXSRixNrfLw3mlRySWqJ03CLSUU/Ai7KzT2tiDmGOV0E7WEPfl7Cp7V+0c2pCI/Gdi8g+TbbDugmWIT5lPsXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8V/ziIJLn9ItGFW51TzZmUC4/1jHQMlbY4umM7kUqI=;
 b=AMo9FThDMZ3k1GlBokGr8NEVj5Ij7XQAPrSNFOm0WsBddOkdGHoXr13ari84EoisDfI8URDBqWU/tB7wD0jXBkNSpg/dq4wRE3SJkdIhKNblrZrn+LL5kdJLxgtwRyb0nqOLROAF+ak6a4DBGdwOl7hxS+MOsh9ivwCFtuyQBbqYu7oneAP+TQ5RLk2hbNbp+PFDPZI0DQ2o7kw2/sWbpKVrCMnrvIMFPzduNsGBLgWxCYL1B/bJqbgxqmwGiRQVn0I8yiXhO9rUIYMQffakX2bO+E9PKa2ZiMK/9Mz1nHpYpabGbyTkO/54Zb5kHX0jKTGOuboRk1opDDL/taOfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8V/ziIJLn9ItGFW51TzZmUC4/1jHQMlbY4umM7kUqI=;
 b=kRXvkYjbXNamZIU4Ysil1659MCKdbUCZqTJ45amzf1Jx0HS94YsLkejbwc6AQVX6iiw1v6VCaE/yqo1l53VOwKxALDXA2U7snT8QmJ6H1RSC67KypEzViUGKaq5wRkr5kHfyB0VwYBYkjImmDyLL8Cbs/rpk22P7Stl5KUAsOG4=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (2603:10a6:803:7::25)
 by AM0PR04MB6833.eurprd04.prod.outlook.com (2603:10a6:208:17d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Tue, 29 Nov
 2022 09:22:55 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::4393:f7bf:6546:5e21]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::4393:f7bf:6546:5e21%3]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 09:22:55 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] mmc: sdhci-of-esdhc: limit the SDHC clock
 frequency
Thread-Topic: [EXT] Re: [PATCH] mmc: sdhci-of-esdhc: limit the SDHC clock
 frequency
Thread-Index: AQHY/85PazG3BJ6Y50eA3qyAcQa4/65VkuUAgAAUC7A=
Date:   Tue, 29 Nov 2022 09:22:55 +0000
Message-ID: <VI1PR0402MB34856B28BFBACA9190B2AAD9F3129@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20221124064608.42019-1-andy.tang@nxp.com>
 <52030ce1-5781-cd62-e0bc-b70a011a024b@intel.com>
In-Reply-To: <52030ce1-5781-cd62-e0bc-b70a011a024b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR0402MB3485:EE_|AM0PR04MB6833:EE_
x-ms-office365-filtering-correlation-id: c507b5bf-4ba5-406e-6c9d-08dad1eb4c6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukZDfxxg6QA0WRivD+Q0+oTPGacUptgK6Hjr6W2oiiPLaAdT72vvX+o1IxsvaIOF+xWRqA3O6+dOp3K/8KKjOlo9PbK3bmLcWcmSUptnBHFcPId2b6MM09vC9DNFJ0TZsXv6dKF9CArUxfUITpGiXOqxtm0T+50y6dbtuvlkqqcFZfPJ0BsMWb+WrBbOBgK9ULKes2swIW1w2w654EW7hqR4fgEQjvLSj+jebrSDSBcIl2xLUmtBE5l3fkG1mqrWMZgfd+UYSE5+tf0V7fEJkuR3WirtAyjFb1Ido+GQQ/53rDtBdUeqKO4fz7a+6ZEV+3lMODen3yt6V3cLHDsRdW4kFqLdn52rC31/zA/eGJKcmGyb4H4wdbNSxfIWNu0QrQHfrtCqf/Esco5FTOaWieHFoYbOr+MW8yMb6hCNjYZnLczr12DErvnkmwjB+MEjE4a2iPpJPFPWVpLbQWZmAY7QDvqbkVR/Kyr1MS2dz1tpt1dcVtPn3PmBxBv+PCE9uG33p/ngPqkgeQ1y2yOCHPqLQjt1ICZv0z+8pNnrqVB3rMcUY+In3lo6Kq6BIy31BNFfM+aAIC8LU45WusVTt1BNSgdE6df5OvNG5W3iuFG6eryFF+vvVJYJbYaKGz/8vFf6gjqNw0ssEuSl4hqHmmuTDxnspQccAj6XAghMIM5YJeZw8ZfjQGLYnVz0oUnviQWrKzNY1SorgU6ly/IItg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199015)(316002)(2906002)(76116006)(478600001)(110136005)(66946007)(33656002)(71200400001)(54906003)(83380400001)(122000001)(55016003)(38100700002)(26005)(6506007)(86362001)(53546011)(9686003)(38070700005)(7696005)(186003)(44832011)(5660300002)(52536014)(41300700001)(8676002)(8936002)(66476007)(66446008)(66556008)(4326008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFplcDA5M2tiZncrVjhpMGtoU0ZQc0cvTk5NNjZpbE1TZzRpbCszM1RWOVBN?=
 =?utf-8?B?S3VMdXNROXZybDk0cTgyNHlhSC84c3J1QUpCYWlsa3Y1WFN2S3lZUFdKTGRB?=
 =?utf-8?B?TFdrWEhubFRMWmpFbklzSDFqLzRkbkRmcW1tSlNwL1BvdGNRaVpUTGtEZ0Fj?=
 =?utf-8?B?bXBLMmJCNGs3T3RUakI1WUk0bkgyenpNbzZvT09hNmIvL1RBZzQvUGZpMHlU?=
 =?utf-8?B?YnNBR0x2aEROWVRhVmFYWWRrN0lpWXpBTE42Wng5dTdwNjJhcEdzZUZNSVd5?=
 =?utf-8?B?ZmZkK0M5ZDVoaDZxcGNLd0tJY0dIczZOVTFNNDdxc1V4MUZaY1RLNGJzTUNY?=
 =?utf-8?B?bjJwMDdrVm9EaW1xV1RZTWRwQnhJSTJqallpNVhiS2JWTU45endFcU1QNGhU?=
 =?utf-8?B?VmFCTkhmSmVzVGppMEZKZHdGNHowTG5qNWRKZ3FXOEJiOXZwdnRZb3drTUI2?=
 =?utf-8?B?Nko4VmtsVTFUNUZjQllPYmhkZThMNnNmM1hOeklKeVVwSG1rZTEzV3djMURP?=
 =?utf-8?B?WjJ3bjNHUUhQeTRVNk5MQzNnOUs1WUp5UGVES1pTYlVrL0xBaDY3R0Y2RVM4?=
 =?utf-8?B?YTlWa3pjT3FrV2dGU2VERm05eGVCTklPZEF0Zml6WUJycXRUdnZrcm5RS1ln?=
 =?utf-8?B?QkEzVG5VZWhmNG16TlNQMDc0a2dGbDA1ZXBLS09WdHRid2F6UVJzOFZwVnhk?=
 =?utf-8?B?SnI1VzJKTlhGWU5HQVkraDlMUjdZbU1KcEpPSWYxL3h3MXpJNE5FQmlTUVBr?=
 =?utf-8?B?SjVld1IrYmp3bmtJV2pXZzU0U095SU9VMDdVSlRPMjdzL1VYTmdwMDVWZVBr?=
 =?utf-8?B?SFY0WStja2ZGcG5meVc1YWpFb3FzRnEzbEZ6L1g3bmY3SFlSRFIyRnpiaVJT?=
 =?utf-8?B?b2hLUi90cmJsb0x0RnY1bkMzTmVVdnlTMzZnVTlUSzhrSW83SDhQQ0ovK0JG?=
 =?utf-8?B?SGp3VmRmTUJlZTh2WVl5K2JtRENIQzU3K21MV3pWWHBsOTdNd0pxRVBSenNU?=
 =?utf-8?B?ZUlVUWI2cVViVEltUTNWTWxGaXI2MVZFU3FkZHgzSXdCTXhPT1NYTFJwa3JI?=
 =?utf-8?B?U3Y5NVoxbmZDYVJCUlViZ1ZZQnZUai9mZ3JmNWtJeXZqVzVKOElnQmsyOEVF?=
 =?utf-8?B?ZktnQkJVd216YzFIT0RqSm1xamsrVE93Nk9VdW1MM2RzWHVWY2NtMm0yOWlt?=
 =?utf-8?B?dU1iZTdTQi9RbE5DNlYrRzc4NEY0SWJYaTlsNDdLWVFlQ1NyZ0tLRExXUUlr?=
 =?utf-8?B?NzBHQmh3U3VqTUViQ0ZOOUZBdEpieUcrVHZWOHRWeHNKS0U5emZjSFFmNjZz?=
 =?utf-8?B?MXlLQVd0YSsyWlFDejZpT2JoSDFIVUZ0RXhSTXJKRUIrakhWeEFGbkpOZ0Mw?=
 =?utf-8?B?TlFJeDhXblVHTjhuTEJrcWovRlBrdjlEbHoyTGRZUCtxUXQrUjdqcm5FSHhk?=
 =?utf-8?B?NC9EQzFtNDdrbm1aamtFditwdVNBNG0wQ3dWRFl6b3pyOXhNOTZ5SEJlek5H?=
 =?utf-8?B?WHB2U2ZaUzRwWDVycnUvbWtXdDdPNmF1L1VSbnBGSG5GZzJBdStVcUhSSWdV?=
 =?utf-8?B?UWRyY2ZLa05ML0l1WTNjNXN1VVk4VFMwZytuYkhBVlM4VkIvRCtyNTlnanhG?=
 =?utf-8?B?Yzdnb2lQUTZRVE16emdRWWJlSGRYVFlhVlhSTEpjRzNjSFY2VDJpQk5jQUlt?=
 =?utf-8?B?enhpTXNuem5pSWJ0NmFqSllDcVdxZXk1VUZYN0JQZE1LdmtuV0tqUjYvR3Bk?=
 =?utf-8?B?NG1OY2hNWGNrbTRSRFVHV2VWZnpONy95bkdDTStYTWI2dHQxbUtldm9XZm91?=
 =?utf-8?B?WGt0enk1TjU2RmVmeDRtRjQ2alpCNzFDY2ZoMkl1ZWV6ZmxEUWhpVUh2Snd3?=
 =?utf-8?B?N1ZibXJmZ3dvYTNsa1V3WWd4QmRQV3UzTjVhRkVzeExuRVN0UnNmU0RZTVdj?=
 =?utf-8?B?bmFSdWw2VklBZVhoaCsyUFhCYlRqUVQzaDQ1ZmdDbVljMFZqVld2Vnd4MDV2?=
 =?utf-8?B?dEFSQ2tNSXR0cHVHV3pRUGNnSTdsUUl5b3JVeHRDOHh3Myt1aUczaHVRMzc2?=
 =?utf-8?B?MVZiTFdHZHZpdmYxZHFPdnpESjc1Y3p6azVOS2F3eXhnUVU2ZVpxUzhCc3Z2?=
 =?utf-8?Q?qiPC4gaCPcNJbugcWEdu91hQr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3485.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c507b5bf-4ba5-406e-6c9d-08dad1eb4c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 09:22:55.5480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AuCdWgwrfBLK/pIKzDd6h9roKC06Q7R1bVVQsbmS4XYYUFINEfRsqCrOwRXLYaqXFR4RP0/mYueBEI+hF5AmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6833
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWRyaWFuLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LiBQbGVhc2Ugc2VlIG15IHJlcGx5
IGlubGluZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4g
SHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gU2VudDogMjAyMuW5tDEx5pyIMjnm
l6UgMTY6MDUNCj4gVG86IEFuZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+OyB1bGYuaGFuc3Nv
bkBsaW5hcm8ub3JnDQo+IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0hdIG1tYzogc2Ro
Y2ktb2YtZXNkaGM6IGxpbWl0IHRoZSBTREhDIGNsb2NrDQo+IGZyZXF1ZW5jeQ0KPiANCj4gQ2F1
dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiAyNC8xMS8yMiAwODo0NiwgYW5keS50YW5nQG54cC5j
b20gd3JvdGU6DQo+ID4gRnJvbTogWXVhbnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+
ID4NCj4gPiBUaGUgaGlnaGVzdCBjbG9jayBmcmVxdWVuY3kgZm9yIGVNTUMgSFMyMDAgbW9kZSBv
biBsczEwNDNhIGlzIDExNi43TWh6DQo+ID4gYWNjb3JkaW5nIHRvIGl0cyBzcGVjaWZpY2F0aW9u
Lg0KPiA+IFNvIGFkZCB0aGUgbGltaXQgdG8gZ2F0ZSB0aGUgZnJlcXVlbmN5Lg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4gDQo+IEl0IGlz
IHByb2JhYmx5IG5pY2VyIHRvIHVzZSBhIGNvbnNpc3RlbnQgZW1haWwgbmFtZS4gIGNoZWNrcGF0
Y2ggZ2l2ZXMgdGhpcw0KPiB3YXJuaW5nOg0KPiANCj4gV0FSTklORzogRnJvbTovU2lnbmVkLW9m
Zi1ieTogZW1haWwgbmFtZSBtaXNtYXRjaDogJ0Zyb206IFl1YW50aWFuIFRhbmcNCj4gPGFuZHku
dGFuZ0BueHAuY29tPicgIT0gJ1NpZ25lZC1vZmYtYnk6IEFuZHkgVGFuZyA8YW5keS50YW5nQG54
cC5jb20+Jw0KT0ssIHdpbGwga2VlcCBpdCBjb25zaXN0ZW50Lg0KDQo+IA0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMgfCA3ICsrKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktb2YtZXNkaGMuYw0KPiA+IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1vZi1lc2RoYy5jDQo+ID4gaW5kZXggMDA1NDJkZDc0YzA3Li4xZmQ0YWUxMDg2MmQgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQo+ID4gKysrIGIv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQo+ID4gQEAgLTQzLDYgKzQzLDEyIEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXNkaGNfY2xrX2ZpeHVwDQo+IGxzMTAyMWFfZXNkaGNfY2xr
ID0gew0KPiA+ICAgICAgIC5tYXhfY2xrW01NQ19USU1JTkdfU0RfSFNdID0gNDY1MDAwMDAsICB9
Ow0KPiA+DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZXNkaGNfY2xrX2ZpeHVwIGxzMTA0M2Ff
ZXNkaGNfY2xrID0gew0KPiA+ICsgICAgIC5zZF9kZmx0X21heF9jbGsgPSAyNTAwMDAwMCwNCj4g
PiArICAgICAubWF4X2Nsa1tNTUNfVElNSU5HX1VIU19TRFIxMDRdID0gMTE2NzAwMDAwLA0KPiA+
ICsgICAgIC5tYXhfY2xrW01NQ19USU1JTkdfTU1DX0hTMjAwXSA9IDExNjcwMDAwMCwgfTsNCj4g
DQo+IGxzMTA0M2FfZXNkaGNfY2xrIHNlZW1zIHRoZSBzYW1lIGFzIGxzMTA0NmFfZXNkaGNfY2xr
IFNob3VsZCB0aGV5IGJlDQo+IHNoYXJlZD8gZS5nLiBjYWxsZWQgbHMxMDR4eF9lc2RoY19jbGsN
ClRoZSB2YWx1ZXMgYXJlIGRpZmZlcmVudC4gT25lIGlzIHRoZSAxMTY3MDBLaHosIHRoZSBvdGhl
ciBpcyAxNjcwMDBLaHouDQpFdmVuIHRoZXkgYXJlIHRoZSBzYW1lLCBpdCBpcyBiZXR0ZXIgdG8g
aGF2ZSBpdHMgb3duIGNsayBzdHJ1Y3QgZm9yIGZ1dHVyZSBjb21wYXRpYmlsaXR5Lg0KDQpUaGFu
a3MsDQpBbmR5DQo+IA0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBlc2RoY19jbGtf
Zml4dXAgbHMxMDQ2YV9lc2RoY19jbGsgPSB7DQo+ID4gICAgICAgLnNkX2RmbHRfbWF4X2NsayA9
IDI1MDAwMDAwLA0KPiA+ICAgICAgIC5tYXhfY2xrW01NQ19USU1JTkdfVUhTX1NEUjEwNF0gPSAx
NjcwMDAwMDAsIEBAIC02NCw2DQo+ICs3MCw3IEBADQo+ID4gc3RhdGljIGNvbnN0IHN0cnVjdCBl
c2RoY19jbGtfZml4dXAgcDEwMTBfZXNkaGNfY2xrID0gew0KPiA+DQo+ID4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNkaGNpX2VzZGhjX29mX21hdGNoW10gPSB7DQo+ID4gICAg
ICAgeyAuY29tcGF0aWJsZSA9ICJmc2wsbHMxMDIxYS1lc2RoYyIsIC5kYXRhID0NCj4gPiAmbHMx
MDIxYV9lc2RoY19jbGt9LA0KPiA+ICsgICAgIHsgLmNvbXBhdGlibGUgPSAiZnNsLGxzMTA0M2Et
ZXNkaGMiLCAuZGF0YSA9DQo+ID4gKyAmbHMxMDQzYV9lc2RoY19jbGt9LA0KPiA+ICAgICAgIHsg
LmNvbXBhdGlibGUgPSAiZnNsLGxzMTA0NmEtZXNkaGMiLCAuZGF0YSA9ICZsczEwNDZhX2VzZGhj
X2Nsa30sDQo+ID4gICAgICAgeyAuY29tcGF0aWJsZSA9ICJmc2wsbHMxMDEyYS1lc2RoYyIsIC5k
YXRhID0gJmxzMTAxMmFfZXNkaGNfY2xrfSwNCj4gPiAgICAgICB7IC5jb21wYXRpYmxlID0gImZz
bCxwMTAxMC1lc2RoYyIsICAgLmRhdGEgPSAmcDEwMTBfZXNkaGNfY2xrfSwNCg0K
