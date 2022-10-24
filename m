Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C6C609822
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJXCQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJXCQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:16:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC36470E53
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 19:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZy5sCZO8KSgFMsNVQG+GSTytYTTyCAV+70CBg9qLfKq0vI2CGH5b5GNuExmZfeFlJmOQz5Q4FbcVD7rWMxoiYi7O+JDbPdTYLWi/Ji/fZrJdtd5u4Gg2xB2kIb//NhTPI2OTvoaCYOZKgYKPFTUNcsXtEw8Qtf0A4IhCqO7F3q5EREPrMVP6Raz8SfW14mb6WbYE8D6MRI5Hgycc/LuHm4DBkbXmU/Lq0nCiKDygWeWbmFpqmVbBoW7FNRxp9k2XeMPpYMR5NkPRzpZ5nSeJhOUG9K1Qay8aBNw+x96eV53mUCiE2G0FXvY+xWFDrdwrTv7gsmZH/DlpAbLpF01eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFsKJPMHmkTRAbtCEujGDittUzzTkzSVZmUIIXSAXJ4=;
 b=l+Pu1Ql1EeJ3h9PVrbANnSCq4ptjRbI2srZ6hMrqtUmRW3jc1FlZNhIGW0ax0n1Qm5JXpOIW0T1I5FHJmIX/gKfNW1+BvDskeXQL5BcBolWnsQ5CiXUnEfAWPTJGgFex/B32AJBxLvPx/Xv6dty2MmU2/Uo4yiWK6my8Qu8uXRu7vSwtVctB0NCQXHjVtRaXmrplXUBoJjTh9rwB6TaZSdrbcr0iOuxzm7FiICFMdGHHxLyeMs8bnpz0OcNGJslNMK5FxltGA7qkRrZOTDO7Oq1hTu3QVPrbKnk383f8cpZsWGe2xmSgFNzNGbtFoJRfgFKu9g40GGZjJP4uGo0qJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFsKJPMHmkTRAbtCEujGDittUzzTkzSVZmUIIXSAXJ4=;
 b=Uq+RATcNB38lKvF/8xTvQPB9WQPgtmNgClkgL+zNu3x7YXu2WcHoIFiwjfIE62nEggVlq5tylFNJT16zAjyqvYkO/JN/zLvhT9Yc/LPyTA0rt0+KnzffXNQtwC1DemezmHqJp3HWFrgvvu4RY/QuQgQwf/YikcRtAcZ02rUqvEDH6v0rG/8N9nNyWu61R5yafoRlA2LYAkBgyUGJCCbDYrRblleMG0VE3Gwq8AIbyHtnIYa1E0K0yeV3SGgEEslR/SK2eVyPi18DKMevFk8Y8xuRAD/9qWE3bOGPUnkhg98vRIMX0gF+JG7qDLFy24eGfSZtrZzLSNkueWJr2LGucQ==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR0601MB4130.apcprd06.prod.outlook.com (2603:1096:820:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 02:16:10 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::5d1a:4f09:b125:9670]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::5d1a:4f09:b125:9670%7]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 02:16:10 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
Subject: RE: [PATCH v2] vDPA: rename get_vq_num_max to get_vq_size_max
Thread-Topic: [PATCH v2] vDPA: rename get_vq_num_max to get_vq_size_max
Thread-Index: AQHY50vG98uWpiwLxUepDlRUWf/jUa4cymsAgAACbaA=
Date:   Mon, 24 Oct 2022 02:16:10 +0000
Message-ID: <TY2PR06MB342493C73F9119E847765796852E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20221024015510.1917-1-angus.chen@jaguarmicro.com>
 <CACGkMEsag0xGcGxPnaou3wiO8iJBL4Pxecj6Vd-KEN7otQX5aQ@mail.gmail.com>
In-Reply-To: <CACGkMEsag0xGcGxPnaou3wiO8iJBL4Pxecj6Vd-KEN7otQX5aQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|KL1PR0601MB4130:EE_
x-ms-office365-filtering-correlation-id: b97dc2d5-bd5f-4fb6-0067-08dab565b7be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zGa4SW2NJEC1eua7Pg7gGf/8Pas6pzi0fl0MIO/EPdyxnpo/N4YAbs00bXvkJsG7ykIrfP1jvi3BmKiUCjYT0C37T9Bw876DkSqVKsv/JvuLnDckv6KQI9gT9X8ay8BIKjdYOH3gpxo3XVHtQYZTSvnG1o/WBoeKz1PQJ6BhZe89Od39Z1JTD4PmOwkRFVzl3uSZu7Do1rDXcXQWBkLf86Fn8CAZuu88BW62sZotN23OlKxkOyS2Q+EkOd6ABI5vN8K3kj+bQ3swIKpeYTC0c5aG7dWrX64rquzP+XszKGtnf+LMWCyEIkyIlcPbVnby1jnhpbiBKPEcUJusaCC2GDTzheyr0usJkw2H1/leJW+sXJTtEJ1Mjz/a3woxA+y6MFydvVqAr5TsZdlvYvXY1tTtKXDA1dmxTO30JdgDoEjXvpmSRm1TNCrwHYOOSQVM+zdNlFwd5cLypkKpE2laVxPI5+66EC+Io2IkhDvgyjbvm0GKYU9u/EtTrS45vjoFc/ntcQRpLRYc8ZzKN246Rwp7TxtCGh08FqRDM7YhtgDtjO5FvPwfmwWASTVU5jwJQ0/jKJo9G69i+WMFdzzyFEUmLXN6gYI0qf2TwftY6pfM7jy5Mwv1owG14pMV+GJk/GPoLs/bRCpfu9BsB31sKPTD2fSRfjyk/t2LdUVGLnmkYGOJQMmMBxllDiJEMX+AlHQ42XCP6OgnpFJxxzr8Ch3lKGqzH7Ms3HjWOkB+5zN+Y4H0/1vSLM0PftG8WicStD6XLsMuavJvlql5iquAdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(366004)(346002)(396003)(136003)(376002)(451199015)(66446008)(44832011)(53546011)(38070700005)(64756008)(86362001)(4326008)(5660300002)(8676002)(186003)(122000001)(83380400001)(9686003)(478600001)(26005)(71200400001)(38100700002)(7696005)(55016003)(2906002)(52536014)(8936002)(316002)(33656002)(76116006)(41300700001)(66556008)(66476007)(6506007)(66946007)(54906003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ykh2dEE1UEoyeHc4di83QitnRFh0WGdacEZBR25ZSTFGN09lYWgxbnRQZ2Y4?=
 =?utf-8?B?TDV0MWsyd2RhMlUrUWRoN21HR1AwbnBkTWpBL29sdXY0ZHExOTZySzlMWWRZ?=
 =?utf-8?B?eWE1RlZablZFbHFVajdpRVYxTzhBYkhiUzMwbDFsTGptcjNMVHR1RnYrNVZO?=
 =?utf-8?B?N1JSVmRKa2pLZWVDVVpOY1I0cThnSkhhWjAydDN6T2dxa1AwVEExL0E0V3Ni?=
 =?utf-8?B?VzlIWURmVHVSWjByK09rYXV2OUlZbTh3YWhRVlh1clRDbUpPZEdWYXQ3Y0lW?=
 =?utf-8?B?bVd3aXpvM0V2L0hGbDlKRjJmd2xOcTgwZnZqeGNwKzduSFFKNEg0MDhzbUky?=
 =?utf-8?B?UWN2RytVYUxmWmVYMjJCRS8vdUpXeVQ5bUpVMTRvUXlIVDlsRi90WnoxQ0pE?=
 =?utf-8?B?WEwwZndiQTJjWnlEbS9tNTdueGl3dUppZ2lxOEVtSVZzYUN6WDAzL1BuYlNW?=
 =?utf-8?B?b1V6UHQrTlo0QWxZNktVbHdtTmw3WDZpNUJYS2tBdmVvcFUvVlYwTnZPRXZ2?=
 =?utf-8?B?ZjhtQjc1WW1HRWhQODJ6Z254NnBVdyt4Yk5iVkJRNlpCV2dMQVZrZ2VKVnhw?=
 =?utf-8?B?K0p2NkVTZk5pVjBNZmt4eEt2WkFRdVYwTnN2TWd0Q2p2V2s4ckdQbmIzQWRk?=
 =?utf-8?B?U3hwdUFNcG9YS1FYRk9Pbmw1K0QzZlBWenlsbzVobVNWMmZTakc4UzZwVXFM?=
 =?utf-8?B?d0dLcWdXR0l4TkxPekdMSHQrdXAwVnQyNFBsWWVZdnlQZVl2ZXkyMGlNbFpt?=
 =?utf-8?B?ZmJZS2Z4cDVDL0RjTSt5WFY5SWVEMFBVS2N5NWpiUTYrRTZoK3FoY09HR1V3?=
 =?utf-8?B?UUNRNzIzaFN3L21ZRHk2U3NXSC9UMlRXbmhXMUVzVHJGaTFRdm56MkhCdWRP?=
 =?utf-8?B?b0NSTm1LVkhZa1ppZFZqQ2pNSmVDdE9rd0FNZU5Ea1pJQ1ROVmJKVFZKM0RO?=
 =?utf-8?B?aXV2ek4yUGRjMHkyaXdUWnVod1FObUdYRnZKMTdja3JSaUF4NjQ5Sm1Ib2dZ?=
 =?utf-8?B?ZjBsWTU3UE02WFFYdFhrdE50MFFRY2NrUDNqcmZRLzhjejhwcEYxdmlwNUlh?=
 =?utf-8?B?cGN4WnVsM1NnTEVhTlNoMWVwTUVVdnFHMnNGTXZlQXVYelJzRWlUWDYyNEda?=
 =?utf-8?B?eDA3Z1M3WWtaNTNJZERGYlNCYk90eGRkVFlGQ05kL1doaDVVaHl3SldQRU1a?=
 =?utf-8?B?S1YwQjlXdzY4NFFNVXNneHJtd0svRUZKUVlUNEsxRmNUVGlIOVBWTGN3a1dG?=
 =?utf-8?B?ZnkwVHB3ODFEeFhRemNkc0QxRXJZVXJ2SmpWRWJ4YmZvQWM4TkIvNit4cWZB?=
 =?utf-8?B?aXR6WWx0UXg3OVFjS3FyODBtaFV6aFRlOG9vaWg1QnA2QXAxY1EvcGM3R3l6?=
 =?utf-8?B?T2tRSi9MVktkTkdZaVdSSkVnSVUvcVpnR2I4QzRENCtYVlpnckJzOVlESTFQ?=
 =?utf-8?B?ZDVWSkJxaW5NOWovKzB0L2tIN3lpbVFzRnI5eHpwK2d5OTRrQzR3bi9rYllm?=
 =?utf-8?B?Wk1NczhhbmxnQTZwRUNyOHVTYTkyVDN3c2Zxd0ZsQi94d29VVWJzY3QvMGts?=
 =?utf-8?B?OHlWV0EyN3F2T0Z2c0taellldUF1Rkpqdk1Pc05hZHpuQ0k1VkdmaWsyNjVE?=
 =?utf-8?B?Z25hZFlrZFVuMEpHc2c0YmxJajUyaW1DUGQwbXNBUXRYeW9UZitGb21wZmo2?=
 =?utf-8?B?NXZKMzdTZ3Q2cXhBM3JvSy84SmhhNGpWWUxhRVUvVjJyd1FFRC8xTE9IV3d3?=
 =?utf-8?B?MmpBb2pQam8wQjFMODluWjd0SzhRczd4N2ErdHBIbmlWbTNsa3RlTGJpcGc3?=
 =?utf-8?B?Y3dHdDFYT3hYMkFVbGd6UFJUbTBRNFpTWUYvMUVRM3B3YWlyVzRwSFFKNUhR?=
 =?utf-8?B?WXIvbjF2b3B2aHIzd1huUHRIMVZUbXRoM2Q2MlZ0ODFWTHcvY25ZRmI4MHlZ?=
 =?utf-8?B?QTFCN3ZkMTB3VEFRamVFSzE2ZkRLNHhQUjdlU0hSa2tFMk4yQWNDdG02Um5p?=
 =?utf-8?B?aEQvNXBQQTJwQkVuSVFNL1EyZ1dmdHkxZzdZUzFRSHpYMDNYdmlHcjdGSmpV?=
 =?utf-8?B?Z0RWVi9TS09zdlFzMUl6ZnBtNFUvNmJGWllkVzFFRHo2WExNSGo1Y0NNQ2ww?=
 =?utf-8?B?R0NzeHRmdjVveTMyRHRqM2tBUG1KdnVoTjdCd3ZhUk5jckFWazEzRGkxSjBB?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97dc2d5-bd5f-4fb6-0067-08dab565b7be
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 02:16:10.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jUQLEmGEZOIXKZkWYGEdQTQAVzGRTdmmcKJTH1HigRafaUP7Q+/qEZNLPzZLYdxrnNxAJuDX0a3YgEFdD+ss5H0JXhFwJt5L6MICnGqdFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzb24NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjQsIDIw
MjIgMTA6MDEgQU0NCj4gVG86IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29t
Pg0KPiBDYzogbXN0QHJlZGhhdC5jb207IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW5nc2hhbi56aHVA
aW50ZWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHZEUEE6IHJlbmFtZSBnZXRfdnFf
bnVtX21heCB0byBnZXRfdnFfc2l6ZV9tYXgNCj4gDQo+IE9uIE1vbiwgT2N0IDI0LCAyMDIyIGF0
IDk6NTYgQU0gQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IHdyb3Rl
Og0KPiA+DQo+ID4gVGhlIGdldF92cV9udW1fbWF4IG9mIHZkcGFfY29uZmlnX29wcyBpcyBtZWFu
IGdldCB0aGUgbWF4IHNpemUgb2YgdnEsbm90DQo+ID4gdGhlIG1heCBudW1iZXIgb2YgdnEsaXQg
aXMga2luZCBvZiBjb25mdXNlZCxyZW5hbWUgaXQuDQo+ID4gQW5kIGdldF92cV9udW1fbWluIHJl
bmFtZSB0byBnZXRfdnFfc2l6ZV9taW4sDQo+ID4gc2V0X3ZxX251bSByZW5hbWUgdG8gc2V0X3Zx
X3NpemUsDQo+ID4gcmVuYW1lIGltcGxlbWVudCBvZiB0aGlzIG9wcyBhbHNvLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+
ID4gLS0tDQo+IA0KPiBOb3QgYSBuYXRpdmUgc3Bhcmtlci4gQnV0IG51bV9tYXggY2FtZSBmcm9t
IHZpcnRxdWV1ZSBzdHJ1Y3R1cmU6DQo+IA0KPiAvKg0KPiAgLi4uDQo+ICAqIEBudW1fbWF4OiB0
aGUgbWF4aW11bSBudW1iZXIgb2YgZWxlbWVudHMgc3VwcG9ydGVkIGJ5IHRoZSBkZXZpY2UuDQo+
ICAuLi4NCj4gICovDQo+IA0KPiBzdHJ1Y3QgdmlydHF1ZXVlIHsNCj4gICAgICAgICAuLi4NCj4g
ICAgICAgICB1bnNpZ25lZCBpbnQgbnVtX21heDsNCkkgbm90aWNlZCB0aGlzIGFsc2/vvIxhbmQg
SSBhbHdheXMgY29uZnVzZWQgYnkgdGhlIGRlZmluaXRpb24uIFRha2UgdmlydGlvX3BjaV9jb21t
b25fY2ZnIGZvciBleGFtcGxlOg0KDQovKiBGaWVsZHMgaW4gVklSVElPX1BDSV9DQVBfQ09NTU9O
X0NGRzogKi8NCnN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgew0KCS4uLg0KICAgIF9fbGUx
NiBudW1fcXVldWVzOyAgICAgIC8qIHJlYWQtb25seSAqLw0KDQpJdCBqdXN0IGEgc3VnZ2VzdGlv
bi4NClRoYW5rIHlvdS4NCj4gICAgICAgICAuLi4NCj4gfTsNCj4gDQo+IFRoYW5rcw0KDQo=
