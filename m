Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CC76F0077
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 07:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbjD0FkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 01:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0FkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 01:40:06 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2071.outbound.protection.outlook.com [40.107.9.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79D3E65;
        Wed, 26 Apr 2023 22:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7YGmQceRgmlFeNSGFYJ2OF17Y4A7GjQzQyh5x+x+bABlTlgqkSqJyP2PYh9ULwfI5+UhNuMNnOgqsK0acFfMARrWxPG7r2cd0KMiHAQ/mDMHSBZ2bcsasRbMO73XBCOomeFXgfIm/3wXty09XU3XfOpIqzvQg/gU0PJVukloRff4eZiekLhN8xH2iJevZwyQX3hFOhaYnaakYX/eFQcYFq6Kl8bwjts3qv7b44JMdY/RJ0Lh1CfSOyNDUO292ZdHDmKhBdkqjd6Haj1nZnlHSOE9wbvqsu3PogV8xUQ3gQEkudT6hYPwSKlSW/qvLcGiQ2ylwN3+8Ptccvp8z4JlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICCm3lv2GsbcdWwDv578wUIpHmEgFEDLs0uyHPkTIoI=;
 b=Tb6wIHtcu5p8VBwZgLeIVmje0qUButQf6qz5oL04e5zGmsxJFrvlvcjDLk67NP3HGgKk3VrA/rZQeX1K45tf7CcvxGS3HF5jlSpL/vO+aIoJhasP7vfIiIFVsnZ3W2/PS+r9lcCPVZZX9Q05Pkp7Ktn74nz5xkiWK+o9Frr14U6WRqEv5a79KyxUrHIQzlk8PlYOqPy5Nk9iu9MxxR7unqgyWu24xI2yqcLmGDej8PHUqYXtsKBPVZWnLus3/fPa+z+GldV8/mBJNZGbLXH6ohNEUGltfRUUGpOrpHxkMcqZsEV22hiFsOmh1x6UD3EX+4CqrJEDQyLEI3yGwNCIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICCm3lv2GsbcdWwDv578wUIpHmEgFEDLs0uyHPkTIoI=;
 b=rQCUvseFxe6JhzqZi7V5H21CYhxvH2q+jwESnJKM7kson4pQgbaKLJIsUTBFS8oTao14LOiMkahFPGp8ynj4PxDMjI6L/uNQBUexRRXmFVyAF0KEN2VYYIIxng360rNJQp8aBom7KG5cFl8YZsJipQ+2HNOaBz46SMaxOdHwhGs2e/z4g9Et5DZxuKjawGFrcM3U/xmiPc1Xr04oXPoHEKNK5mYFEli2PX8ebIhEU+xNk0V0pf23NVeMTOQ6M37+6Ochm8dYoK5IcgJp6n9MVLgd2Lt4mLK8dEUdZlZcLblNLLKQIFrqvTXEKKj7xW09cOQ9WSds+7N+35GbIMZtXw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2985.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 05:40:00 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8d19:d0c0:1908:3f25]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8d19:d0c0:1908:3f25%5]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 05:40:00 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andreas Kemnade <andreas@kemnade.info>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ": Tony Lindgren" <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: fix allocation of mixed dynamic/static GPIOs
Thread-Topic: [PATCH] gpiolib: fix allocation of mixed dynamic/static GPIOs
Thread-Index: AQHZeIsM14bqQdx5QUm8jstSB2yPI68+pFKA
Date:   Thu, 27 Apr 2023 05:40:00 +0000
Message-ID: <f6b261ad-3267-db70-c173-154a12c42bea@csgroup.eu>
References: <20230426220338.430638-1-andreas@kemnade.info>
In-Reply-To: <20230426220338.430638-1-andreas@kemnade.info>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2985:EE_
x-ms-office365-filtering-correlation-id: 6dbb0c90-c5e4-4817-870f-08db46e1d7be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rm3IYSWpZt7rv4P8wdbR0IRDnG+H1+eD2nge3U2sTi+KDIouprX9fp7udrJg3vi2thomlM/psZtUyxNUrgJzbbaGBnlrhgwRnitJqbNfYGxds3IYG5od/CJPY9qjKDqu5qPe7pY3envjJytyuwHdRnNQuKeqZOiIr+OsSIh8zQfEkmJDH+8ewPqW2J5g54CGSZdIvsvT52qAPkhwd3oMoiEgDQo4FgD6D22jGeJFIpp+NYWc55XRNDydoKrzLXexL04zGElpfJGPtHi97cGr+6T92ENhGlZScOYPg8znDDZhV+r+mTt/oTsgmVNe3qUUQFsmrWBKJJ8qE8NQbq9iTYEAEZZCRT68E8Rbjx3fu04cmqfXCF+m9pMAIln5LZPj5FfCnUuARLt7SexrBt1KsgRusyxY5G5XHLctWVwqtLsVYHw0G3Np/sfdbvLUTBg5ePP+bElbrrpLsGb3F3zvC5Xh00KcNEdUGgfHkZPb3gt3gF5fofN/W/axc/48M0zajgXJyLaRFoOZfVhaeRQDk9cVzONMczBgcLXHoUYgDIcGrcFcUXYYDMg0VMcISF/OpehA3k9t3pZr9NQpM5SJb14BZmI/wqc771IZlePO2fQIpIyGIkuYfXJwSlbHMEpA5NLUKxwfS0ETk8UxBdSVFaLRNi5UdFhLivQWboPreWlbSySPtxDHU6LisUkoiSL8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(376002)(346002)(366004)(396003)(136003)(451199021)(2906002)(71200400001)(66574015)(2616005)(86362001)(36756003)(186003)(31696002)(6506007)(26005)(6512007)(91956017)(76116006)(66946007)(66556008)(64756008)(316002)(66446008)(66476007)(41300700001)(38100700002)(31686004)(966005)(6486002)(110136005)(478600001)(8936002)(8676002)(38070700005)(44832011)(5660300002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG9HTVBnbGtqdSt5NHJyRjlNYStQZGp3djdneDhuckdTckhRT0RNUEorTVhs?=
 =?utf-8?B?Zi9EMEVlMUNwQ3d3ams4cGFDc0p0SnRPR2gvaUNPSFF3QlFjS1hOaCtJeVRh?=
 =?utf-8?B?R1BERE5KR1FDSVE2a0VTZzFVbWhXS2xORHlBZ29ML0tHdEkwS1E2aDFCMzg3?=
 =?utf-8?B?RkV0NnRCUlBERUNGQmhFNkRRaFpDSW1BZHY2aVVwWjV2bkNBOGVYVVNmbXk4?=
 =?utf-8?B?OThJRE5rZTFjK3VDQ0tiMjBJSGY2Mld1QXJHdi9WM044YU5uZ3BYN0p0dlUv?=
 =?utf-8?B?RW55Wkp1SFRsRlM0TXNzMkdOZW5vTDIyZHY2dDhOdTV6WEhrYzl2UE9XMGRi?=
 =?utf-8?B?d2oydnc0YVBMa0FTMVcybS9uVTd5Y2ZKUXRjdnlCTWpDM3NOaHYyZE9pUWdU?=
 =?utf-8?B?d2tBSGJXNnloOEZTK0xDaG5LbnM0QVdOTy82a2MrajY3T1QwZkR6S2ZncXNN?=
 =?utf-8?B?aDJxN1FkVTUrM0ZyRjJSdFZkODlhZGx6Z044ZlZlY0cyeVRmRkxPZGt5MEZY?=
 =?utf-8?B?UzJXTXFxWkxqM0xuQXhYSjAzbHE1Wmp1T3pZVmRtMlozb0hkYkJTQ2YwSm12?=
 =?utf-8?B?Tk1wNi84RERsYXg5RVduNFVydU5BVEpORDVZM3JpZlBiSVlzK1dIcmFjZ3ds?=
 =?utf-8?B?Q25RQXNQREowcnh6SjRFZUJpTmJSTTdwSlVyWlg3ZnZpN3RITEJrR0hVQ1dO?=
 =?utf-8?B?ejV4dXFWK3VOQ1VzbllRRjg1NHJsMWFWNkpES0hTQVNIS3lNbTlRMWF6Mmls?=
 =?utf-8?B?a3d2SGhTRDd6c3QzOC93M2hIek10QkYyWk10WE1kc0Q4NHdvOEY3d29zMlRP?=
 =?utf-8?B?VTc3WG42TWg5VFBIZlVRcEowU3hpZWszQ0dndysya0svM0VvNjJRUXIxcVpi?=
 =?utf-8?B?YlNicVVsZE9LTmNLbmpvU2szN1ZkcEIyOHU1cndreFVuT0xIVy90emZESEtv?=
 =?utf-8?B?ZGROR2NIS3hGRTBycTBoSkRwZE02NDNOaitMMHhiWmhEWVUyb3JKK3UwRVph?=
 =?utf-8?B?N0plOUU4RE9HWjd5elh3TlcyL0tXWUdqQy9kRDlrcHlCTDFUUDJoM2YyYlp1?=
 =?utf-8?B?enFaUS9JbHZWUHVtMnhTN0IrcTVPUkRwSllZd2x2RFVHa1JrVDZVc2dvNEJ5?=
 =?utf-8?B?L0JVSCtxVjdEOUVIRVV3OVUrV1FEYlpkSVhRYVNXNnA0NXJldm5yRi9pNTlk?=
 =?utf-8?B?aFBTMkNjWWlweTkzMjVyM01CZk14bUNOd1VTODFOSTdiSWZwVm5JeURLQU9U?=
 =?utf-8?B?VGlsYkQ0TE45YXFxMEpMaVJ6MDIvSTJGMldMZy9GZFQ2bVJiZHdoMjFiM1Fx?=
 =?utf-8?B?a1ZBWEpQblpoNG1icVRIVXRIWHgyTFZVYnRuQVoyMlZwWTNNMUJ5aHdkSCtQ?=
 =?utf-8?B?QnEraWdTMCsxRUE5UCsvNHluRmsvZzE0ZzlnejA0NlljdEQwVExtbitJTWV3?=
 =?utf-8?B?T3EwbFk5b3BzbUo4TjlPbDltV1l2NUN0RXVCR3h2OVZ1TXRWUUxLNzN3TXkx?=
 =?utf-8?B?L1drY0tuNFY2V2ZuM1JDc2hNOHZJQ1dEVXNtTDhXTC85RElQMDI2Q2VYWm8r?=
 =?utf-8?B?czAvZzc2U1hFd1JqYlVadUpTeGdvQzZ0TXRxbmRYL3Q0aHRSOEYwaEZ6R0Zh?=
 =?utf-8?B?NXRhTEJvcmUwTzZWVk1DckNrQ1pTcE1ZMllYVE5vWVI5NjlMdzdQU01aMEFx?=
 =?utf-8?B?K0hzWU92ditjRy9WN0dnYWkyV1VWOW5OTVlsOEZIUm1Zc2wxVndQRk5Vayth?=
 =?utf-8?B?YjFWdjNEdDRueTd0WWcza0lvQlFxeC9IejBKNWlTaEV6cEcrZW5KQm9kZnpH?=
 =?utf-8?B?bGptQ3h1aHE5UjVxbGdudUxkVWlEWFIxcmo4ODlsSzFHeDNkcWU0OEN2RFZ3?=
 =?utf-8?B?U0lyM0NZVFVlNkJqZlVkOStFaXB4UkNzeTl6OUdZRlNQeDNkNHlKdWhqSlBH?=
 =?utf-8?B?Y1ZiS2JVcUtkNFpFeGUySGptei9NUzVoSG43dXhYZnhrWkEyaGxGamh3emNm?=
 =?utf-8?B?THY4UFJrTjN6QXBUaXFQa1BIbm5LQkk1MENZMS82cWkweS9oMEI3QVkxNldV?=
 =?utf-8?B?dHppVlRuaWRDRFgzRHpUWEhtNjJ5YTk4VTRkVDVNZFJhSDJXbjVFR1VTWG5E?=
 =?utf-8?Q?60gl5TkLiEtGaUvMPN35dOjw+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FE505D610E66847BE981D6677949D4E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbb0c90-c5e4-4817-870f-08db46e1d7be
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 05:40:00.3948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+bIkV+enUuLkf3une4SbF5Q6lrBPMR8cvOxzNwDTSD+tZmoQpWRsM7c4SOhYEwz5NwesHp1aVTHyxpKcFG+XjhrdFcuT1PVLMBwbbPwTeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2985
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI3LzA0LzIwMjMgw6AgMDA6MDMsIEFuZHJlYXMgS2VtbmFkZSBhIMOpY3JpdMKgOg0K
PiBbVm91cyBuZSByZWNldmV6IHBhcyBzb3V2ZW50IGRlIGNvdXJyaWVycyBkZSBhbmRyZWFzQGtl
bW5hZGUuaW5mby4gRMOpY291dnJleiBwb3VycXVvaSBjZWNpIGVzdCBpbXBvcnRhbnQgw6AgaHR0
cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IElmIHN0
YXRpYyBhbGxvY2F0aW9uIGFuZCBkeW5hbWljIGFsbG9jYXRpb24gR1BJT3MgYXJlIHByZXNlbnQs
DQo+IGR5bmFtaWMgYWxsb2NhdGlvbiBwb2xsdXRlcyB0aGUgbnVtYmVyc3BhY2UgZm9yIHN0YXRp
YyBhbGxvY2F0aW9uLA0KPiBjYXVzaW5nIHN0YXRpYyBhbGxvY2F0aW9uIHRvIGZhaWwuDQo+IEVu
Zm9yZSBkeW5hbWljIGFsbG9jYXRpb24gYWJvdmUgR1BJT19EWU5BTUlDX0JBU0UuDQoNCkh1bSAu
Li4uDQoNCkNvbW1pdCA3YjYxMjEyZjJhMDcgKCJncGlvbGliOiBHZXQgcmlkIG9mIEFSQ0hfTlJf
R1BJT1MiKSB3YXMgc3VwcG9zZWQgDQp0byBlbmZvcmNlIGR5bmFtaWMgYWxsb2NhdGlvbiBhYm92
ZSBHUElPX0RZTkFNSUNfQkFTRSBhbHJlYWR5Lg0KDQpDYW4geW91IGRlc2NyaWJlIHdoYXQgaXMg
Z29pbmcgd3JvbmcgZXhhY3RseSB3aXRoIHRoZSBhYm92ZSBjb21taXQgPw0KDQpUaGFua3MNCkNo
cmlzdG9waGUNCg0KPiANCj4gU2VlbiBvbiBhIEdUQTA0IHdoZW4gb21hcC1ncGlvIChzdGF0aWMp
IGFuZCB0d2wtZ3BpbyAoZHluYW1pYykNCj4gcmFjZWQuDQo+IE9uIHRoYXQgZGV2aWNlIGl0IGlz
IGZpeGVkIGludmFzaXZlbHkgYnkNCj4gY29tbWl0IDkyYmY3OGIzM2IwYjQgKCJncGlvOiBvbWFw
OiB1c2UgZHluYW1pYyBhbGxvY2F0aW9uIG9mIGJhc2UiKQ0KPiBidXQgbGV0cyBhbHNvIGZpeCB0
aGF0IGZvciBkZXZpY2VzIHdoZXJlIHRoZXJlIGlzIHN0aWxsDQo+IGEgbWl4dHVyZSBvZiBzdGF0
aWMgYW5kIGR5bmFtaWMgYWxsb2NhdGlvbi4NCj4gDQo+IEZpeGVzOiA3YjYxMjEyZjJhMDcgKCJn
cGlvbGliOiBHZXQgcmlkIG9mIEFSQ0hfTlJfR1BJT1MiKQ0KPiBTdWdnZXN0ZWQtYnk6IGFuZHku
c2hldmNoZW5rb0BnbWFpbC5jb20NCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBLZW1uYWRlIDxh
bmRyZWFzQGtlbW5hZGUuaW5mbz4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncGlvL2dwaW9saWIuYyB8
IDQgKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi5jIGIvZHJpdmVycy9ncGlvL2dwaW9saWIuYw0K
PiBpbmRleCAxOWJkMjMwNDRiMDE3Li4xOGI2OGQwYWVjN2RiIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwaW8vZ3Bpb2xpYi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3Bpby9ncGlvbGliLmMNCj4gQEAg
LTE4OCw2ICsxODgsMTAgQEAgc3RhdGljIGludCBncGlvY2hpcF9maW5kX2Jhc2UoaW50IG5ncGlv
KQ0KPiAgICAgICAgICBpbnQgYmFzZSA9IEdQSU9fRFlOQU1JQ19CQVNFOw0KPiANCj4gICAgICAg
ICAgbGlzdF9mb3JfZWFjaF9lbnRyeShnZGV2LCAmZ3Bpb19kZXZpY2VzLCBsaXN0KSB7DQo+ICsg
ICAgICAgICAgICAgICAvKiBkbyBub3QgcG9sbHV0ZSBhcmVhIGZvciBzdGF0aWMgYWxsb2NhdGlv
biAqLw0KPiArICAgICAgICAgICAgICAgaWYgKGdkZXYtPmJhc2UgPCBHUElPX0RZTkFNSUNfQkFT
RSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ICsNCj4gICAgICAgICAg
ICAgICAgICAvKiBmb3VuZCBhIGZyZWUgc3BhY2U/ICovDQo+ICAgICAgICAgICAgICAgICAgaWYg
KGdkZXYtPmJhc2UgPj0gYmFzZSArIG5ncGlvKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7DQo+IC0tDQo+IDIuMzkuMg0KPiANCg==
