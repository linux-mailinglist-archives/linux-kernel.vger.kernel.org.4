Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2556DD366
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjDKGuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjDKGt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:49:57 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909DF30F5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axMVq7DHPFJpyWhy5kdmrxin7loCFGCiOv5hUcJynzAnIeT8Terxqz4S/FSK/abMHmFvVlZjNziW/K6gQrwSEQadxzY4QzJ4Il1MUz75xlyzVIzsIvmx5XATBF7T7wur+nBIhckCmxoiont/IFuwIgxYQYsHttQE4zNxzDKajHm+UNnENZFmUPe/9/8sGBQjfcF2nJyK61CiGbk48eqBJzmbsyfCoYpSZNVd3kyIfb5LjVIJkMAY2nSqgrqYhv0RDbplLxJmRgs3XMOAjgDsWcQ0RwOCDQaR9uh5WJBn9bXFXnFm7BClOQOBP+KSQ2tg11zHo8P0mwZ7XOBo7mGdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5UwuDw1pTVU/fhyGPkG2UOtVUOhvkpDthPXMLAe+nQ=;
 b=j7cWXqc4OBC7KJoxIdXPz7SJlOthb2lhWKwMHdzmptgWF/pzwPnfLu7D3yjBil+DIQ2MuCYx9CFnfB9rijOKk4CLrb1oUU81m4Da+LJoA/nzAvO+bCUis08p4YmoJCAw45a1Metr0Gi+8rdh9olNW9Z8Q4BaZ/Uc1KjARd6B59Uf/vOfTRgMhUU1dsvR4BzJo9m+b6JvNUyBPwSjKsw+ySr9fnmQD1Th6gvuk+Tz0KvktqspJsYs29dE+Cbkux5tACzDFTBdCaQHEF07SqzlLmTNTPKmbZv0FWnkeLXWNQoxoWCGLW5b7CG15zWkRDerQFoKlg0mSz1t1H6vTZHHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5UwuDw1pTVU/fhyGPkG2UOtVUOhvkpDthPXMLAe+nQ=;
 b=H4st8caw/BKnnxI4QM4ZFMrvJPORxghRr42IeE/6+3fU7pGzCkfN4b+1CPXhOAMFoAORYljlLnLUCtKd853Y5sGZkeRgGZr8HCd7IO6kIppW/ZxzZGbFW/sxRrs4LR9pm1rWOlsipHWoU7A96Cxl8UksqPXbZh2PXsXERrtzOWjsAymw7xMdwVCiqLmFfH98bjIAzud4xNZeU4ToLe2ey65u9TJ39LF10n8E3MM3LkMHudjInFC5bk+5FeeUk6aaMKK7Mos/b9U0y430+ynQCTDTF1sCh/w5FYEd28bTKgdIBBYu6qmPhQqD3iwPodA/UfVTjk51amhvXslER25usw==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR0601MB4353.apcprd06.prod.outlook.com (2603:1096:820:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 06:49:04 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6%3]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 06:49:03 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Topic: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Index: AQHZbBZh3jvrK38aOUOklBMw4wCkQq8lk3uAgAAOhKCAAAi3AIAAADGA
Date:   Tue, 11 Apr 2023 06:49:03 +0000
Message-ID: <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411024459-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230411024459-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|KL1PR0601MB4353:EE_
x-ms-office365-filtering-correlation-id: d24ef640-4114-470c-37ce-08db3a58d6d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /w/Zl6r68uHmsJcq4WFfLZBz+TWAdYGugeNXnKZNrscT4nc+biiwoh2Rq5agwKob70Eq83btcAUOTaouYeki7d54cZOvc1fPGOWYs+lhFu14XKhE9MJIQO+0SkJUe8gnT/kX/l6lYzahqesedWpBlVKBHWT9ujkxNF/TPDeacOEefpqv6tKvcNAnRvr2n29hc5jJJ23ahbmouatsYvYALVsHCq5+5VE4jnil3SfDO7G/ekx6MXaQ9DRAmLZENN32ZNsFzEa+7vP0+xOYqyAGY39XVP34qiB4Y3b2NHjcQjzirgxAD4qqmcfwPuchLkntkc1bVAA7HRREDK3OlcHQ/hZrxGfP76Te7VnvC/iHRuXeyWP4sEFWt/RhKlVVUHxELWmicbjpF6caNhNJWRQrMzUyKG+cUK1Sc+BzI6Hj/b/3tcyslbistcSN0L4BCtylBuAlZxof+2J2mmRsUNmnjI+P27FQynSrUIuuEO7wpzUDAeXVX3HI0mHQO0gWjdboKNZ9hELAdWT6qMOl1wTNT8BuhrzCqo0wMUzN/lXb2KqhOdZWKCLg+QFfKZQM5DBK5TrORi6KlSI4hVCRoKnUeT1b1JZPcXFURjlP2aDAcRcq38yo7RJh8Gl/qGOn9ag1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(39840400004)(366004)(136003)(451199021)(71200400001)(7696005)(478600001)(316002)(53546011)(9686003)(26005)(44832011)(6506007)(186003)(54906003)(2906002)(5660300002)(4326008)(66946007)(76116006)(66446008)(41300700001)(8676002)(6916009)(66476007)(64756008)(52536014)(8936002)(66556008)(38100700002)(38070700005)(122000001)(55016003)(86362001)(83380400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnhnV09CQWc0TmtPUUlYdVUxSmFOSFY5WXM4ZnZYU01QSWJMQXpzVUllTi9m?=
 =?utf-8?B?VFpLL3RNSzVOVnJoR3o4cS8weE9uMEU2cForSUpjMTd2Vm9wRVpZOXFiRWpl?=
 =?utf-8?B?a2pYTWZxWUQ1VjIrYlRBZ3dXT3RLby82Y3lNUlpNdkRFVWRGRVFxQ1NVNVFk?=
 =?utf-8?B?YS9JSUlJUTlyOFdxZUsrZ0hyNDJtbXFrdXZZWnptZG9wVkpHSHNoN3NHUVIx?=
 =?utf-8?B?QnhHamlWOXdxRktzYXdRZjZLU2tpSk9EM2NxN2puYW5EK2gzclhiYUlsN3BV?=
 =?utf-8?B?MHZWQUlsTGJ2bysyUkx3bXVuYThYeEFkVWhoQk1LVEMyaGxnbDBmTEVtVHcx?=
 =?utf-8?B?cS9FZ2lPdTFKVHYxWnRXZkdEUnRPNE9STjJvRnN2eVBLUkVhY3Q4QVEzZWtC?=
 =?utf-8?B?eUV5RlI3Sk9wR1h4eEp3Q2NVSExRM3YxcnVLQTBYWnVjVmNEdWhYNTFFam1j?=
 =?utf-8?B?YUdoNk1lc212ckcwOTFmM2grVW92Tm9yNDE3MDJEamJueUZVSE5uN2pGRm1o?=
 =?utf-8?B?VUtiQURqYVRWZjdvS0FuWVQxY1BIQmxMc3VJeFpvakFOR3p3YnplK1lZK0NI?=
 =?utf-8?B?NTE5MTIyRC81ZHhvQzFodFEyV2FyM1A1bWJhdUFwdFhZUXd5ZXlTdGx1QVA1?=
 =?utf-8?B?WHI3M2x2eUlCWlpMbzluemw5dzhOZWlLaGxoRy8yL0lkdzJNSDBaeHYwak4v?=
 =?utf-8?B?ZFljSHF4cUxFL3JMQTNQYWhNdm9xM2VVbmtZMFpYNFlpaUYwRFczVWZFYXhW?=
 =?utf-8?B?bUZ1c1lKNlhxYldMNkFrKzhZS3pJN3QzSmRzdklBeC9LbDVmdVdwUmcvbXlX?=
 =?utf-8?B?VGFUcS9LQ2ZqOFNXaUVDWmFRTXhzQXVqWThPZGJZYlV4eVI0SG9PT1drV1ZO?=
 =?utf-8?B?VTJPQk44TUFvL2llZmp4ZjR6cFBRTjByVE9oUHNpck80MVhIRVowOTJvV3o5?=
 =?utf-8?B?K2dnWkltZjVHb0NzYXY1bGZBd0dPaFlhSFRyMkVzOHBrUi9rMndzOXkrY1Ns?=
 =?utf-8?B?dzZNeG1KZUM4S3NxZ1BUZEVJVHJmMUZsV1ZGVFc0TTJFREE5UjNHVy9PblhI?=
 =?utf-8?B?b3gxODZJR21LSkU5aDZHQ2tvNUZKeDhxZDNJRUNSVHlrdEF1SkJxc2hDbW1o?=
 =?utf-8?B?T2lkd2FEc3VmelJhMUxlVkxNNERneSs2U2Rab0MrdW5oUXB5blltOTdFakxU?=
 =?utf-8?B?aVFvTkxYQnNydnE0YVhwSEVzb0RsWlVFdlo3dTlEL2JoN3Y5NzEzUCtpaXpX?=
 =?utf-8?B?alh1V0k0Z1ErRW43TG1abWtQM1htbG5GL0h1a3ZCdWpBaVI5aGJQaHJJQlhx?=
 =?utf-8?B?RmJ1OGtJTHd4QUZ0TVlrRWRhL2FEaXVET2w1SGpqQXduZVpIYjlxbVl4SXNo?=
 =?utf-8?B?b0g1K1F5RktMTEM3MkpodHMrM05ETC9GcEIxcXlmWVFYS3BUTmV2SGNmcTV1?=
 =?utf-8?B?cGxIVW1YTFBsVVJqN2RoN3ZFQUYyNnAxbUIvNnZUcHlyS2tPd0M5cFBQeWxS?=
 =?utf-8?B?VjRBY0hERDBoeS92dGlqKzAyRHV5dmNtaytKTXJVN0E0MzRwcTg3NS9NYlNt?=
 =?utf-8?B?aTUvMVdDeFd3ODVtL29BZUFxdmgxS0hhVjRlREVtbDFxV1VsOTkwSk5FQzZh?=
 =?utf-8?B?K2tmTXNkeG41UE4yeVJNYWgydFRGTDFoaDlkMjNMenY1Q0VQMGVBSUo3Z1l5?=
 =?utf-8?B?Q245eWh0MU16REdSbEZhVklURERsS254Y3pMUDFTSitLSE1ac3kvV25lTGdL?=
 =?utf-8?B?L0c1UFJRT0Vac0VkRFFFNnk1N3FDN21aYys5Z2k1UVh5eEF3dzVpWGViMk1K?=
 =?utf-8?B?bTNucUxMYyt5MGF0Y3lwNzBkazhEeVpCZEFvQWUyUkhKamw4MVA3dFZEYUJl?=
 =?utf-8?B?Ym81U0hRWGtpZnFpb3BkSmVuWGtLOU13QVNoTWJwZGxmZEJhMTgwOFlKaUFr?=
 =?utf-8?B?ejlUa2ZJcVlGbzYrc052TXRXbC9xSWpScmphbEI4d093aVhXcjdNeGVHNWM3?=
 =?utf-8?B?bStUOHdHN3ZIc1RkR1k5UDgvSHNBbGc5YVhtMEFlZTdSbHdHb3A0MVRFQkhV?=
 =?utf-8?B?QTVNMVFDQ29XNy9BakxDN0dHcWEyaU1EN3VySGNXdTNXRnNBV05GYjM3S29D?=
 =?utf-8?Q?vCZ0che6OwSvrAHht220VHpQY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24ef640-4114-470c-37ce-08db3a58d6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 06:49:03.8862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ght+xBRJy9UaTsBPcEDwNcyovAiiq3eNJ5dm5XfhfmXVsYWI/D2QCIkqwCXjW7bT8KtQB42Q2UxzaYVa3f6LFCm1A2y4l8M95k+mOlXRgMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4353
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTEsIDIwMjMgMjo0
NyBQTQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IENj
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsNCj4gdmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gdmlydGlvX3BjaTogV2FpdCBmb3IgbGVnYWN5IGRldmljZSB0
byBiZSByZXNldA0KPiANCj4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDY6MzY6MzlBTSArMDAw
MCwgQW5ndXMgQ2hlbiB3cm90ZToNCj4gPiBIaS4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxMSwgMjAyMyAxOjI0IFBNDQo+ID4gPiBUbzog
QW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+ID4gPiBDYzogbXN0QHJl
ZGhhdC5jb207IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiA+
ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRD
SF0gdmlydGlvX3BjaTogV2FpdCBmb3IgbGVnYWN5IGRldmljZSB0byBiZSByZXNldA0KPiA+ID4N
Cj4gPiA+IE9uIFR1ZSwgQXByIDExLCAyMDIzIGF0IDk6MznigK9BTSBBbmd1cyBDaGVuDQo+IDxh
bmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4g
PiBXZSByZWFkIHRoZSBzdGF0dXMgb2YgZGV2aWNlIGFmdGVyIHJlc2V0LA0KPiA+ID4gPiBJdCBp
cyBub3QgZ3VhcmFudGVlZCB0aGF0IHRoZSBkZXZpY2UgYmUgcmVzZXRlZCBzdWNjZXNzZnVsbHku
DQo+ID4gPiA+IFdlIGNhbiB1c2UgYSB3aGlsZSBsb29wIHRvIG1ha2Ugc3VyZSB0aGF0LGxpa2Ug
dGhlIG1vZGVybiBkZXZpY2UgZGlkLg0KPiA+ID4gPiBUaGUgc3BlYyBpcyBub3QgcmVxdWVzdCBp
dCAsYnV0IGl0IHdvcmsuDQo+ID4gPg0KPiA+ID4gVGhlIG9ubHkgY29uY2VybiBpcyBpZiBpdCdz
IHRvbyBsYXRlIHRvIGRvIHRoaXMuDQo+ID4gPg0KPiA+ID4gQnR3LCBhbnkgcmVhc29uIHlvdSB3
YW50IHRvIGhhdmUgYSBsZWdhY3kgaGFyZHdhcmUgaW1wbGVtZW50YXRpb24uIEl0DQo+ID4gPiB3
aWxsIGJlIHZlcnkgdHJpY2t5IHRvIHdvcmsgY29ycmVjdGx5Lg0KPiA+ICAgRW4sSSBmb3VuZCB0
aGlzIGluIHRoZSByZWFsIHByb2R1Y3Rpb24gZW52aXJvbm1lbnQgc29tZSB0aW1lcyBhYm91dCBv
bmUNCj4geWVhciBhZ28uDQo+ID4gYW5kIEkgZml4IHRoaXMgb3V0IG9mIHRyZWUub3VyIHZpcnRp
byBjYXJkIGhhZCBiZWVuIHNvbGQgYWJvdXQgdGhvdXNhbmRzIC4NCj4gPg0KPiA+ICAgTm93LHdl
IGNyZWF0ZWQgYSBuZXcgY2FyZCwgaXQgc3VwcG9ydCB2aXJ0aW8gMC45NSwxLjAsMS4xIGV0Yy4N
Cj4gDQo+IEkgYW0gbm90IDEwMCUgc3VyZSB3aGF0IGRvZXMgdGhpcyBtZWFuLg0KPiBTbyBpdCdz
IGEgdHJhbnNpdGlvbmFsIGRldmljZSB0aGVuPw0KSGkgbXN0LGl0IGlzIGEgcmVhbCBjYXJkIGlu
IHRoZSBJbiBjbG91ZCBjb21wdXRpbmcgLG5vdCB0cmFuc2l0aW9uYWwgZGV2aWNlLg0KPiANCj4g
DQo+ID4gICBBbmQgd2UgdXNlIHRoaXMgaG9zdCB2ZHBhKyBsZWdhY3kgdmlydGlvIGluIHZtIHRv
IGhvdCBtaWdyYXRpb24sd2UgZm91bmQNCj4gdGhhdCB0aGUNCj4gPiAgIExlZ2FjeSBtb2RlbCBv
ZnRlbiBnZXQgdGhlIG1pZGRsZSBzdGF0ZSB2YWx1ZSBhZnRlciByZXNldCBhbmQgcHJvYmUgYWdh
aW4uDQo+ID4gICBUaGUgU29jIGlzIFNpbXVsYXRlZCBieSBmcGdhIHdoaWNoIGlzIHJ1biBzbG93
ZXIgdGhhbiB0aGUgaG9zdCxzbyB0aGUgc2FtZQ0KPiBidWcNCj4gPiAgIElzIGZvdW5kIG1vcmUg
ZnJlcXVlbnRseSB3aGVuIHRoZSBob3N0IHVzZSB0aGUgb3RoZXIga2VybmVsIGxpa2UgdWJ1bnR1
IG9yDQo+IGNlbnRvczguDQo+ID4NCj4gPiAgIFNvIHdlIGhvcGUgd2UgY2FuIGZpeCB0aGlzIGJ5
IHVwc3RyZWFtIC4NCj4gPiA+DQo+ID4gPiBUaGFua3MNCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPg0K
PiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMg
fCA0ICsrKy0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19wY2lfbGVnYWN5LmMNCj4gYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5j
DQo+ID4gPiA+IGluZGV4IDIyNTdmMWIzZDhhZS4uZjJkMjQxNTYzZTRmIDEwMDY0NA0KPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jDQo+ID4gPiA+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMNCj4gPiA+ID4gQEAgLTE0LDYgKzE0
LDcgQEANCj4gPiA+ID4gICAqICBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0K
PiA+ID4gPiAgICovDQo+ID4gPiA+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4N
Cj4gPiA+ID4gICNpbmNsdWRlICJsaW51eC92aXJ0aW9fcGNpX2xlZ2FjeS5oIg0KPiA+ID4gPiAg
I2luY2x1ZGUgInZpcnRpb19wY2lfY29tbW9uLmgiDQo+ID4gPiA+DQo+ID4gPiA+IEBAIC05Nyw3
ICs5OCw4IEBAIHN0YXRpYyB2b2lkIHZwX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
KQ0KPiA+ID4gPiAgICAgICAgIHZwX2xlZ2FjeV9zZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYsIDAp
Ow0KPiA+ID4gPiAgICAgICAgIC8qIEZsdXNoIG91dCB0aGUgc3RhdHVzIHdyaXRlLCBhbmQgZmx1
c2ggaW4gZGV2aWNlIHdyaXRlcywNCj4gPiA+ID4gICAgICAgICAgKiBpbmNsdWRpbmcgTVNpLVgg
aW50ZXJydXB0cywgaWYgYW55LiAqLw0KPiA+ID4gPiAtICAgICAgIHZwX2xlZ2FjeV9nZXRfc3Rh
dHVzKCZ2cF9kZXYtPmxkZXYpOw0KPiA+ID4gPiArICAgICAgIHdoaWxlICh2cF9sZWdhY3lfZ2V0
X3N0YXR1cygmdnBfZGV2LT5sZGV2KSkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIG1zbGVlcCgx
KTsNCj4gPiA+ID4gICAgICAgICAvKiBGbHVzaCBwZW5kaW5nIFZRL2NvbmZpZ3VyYXRpb24gY2Fs
bGJhY2tzLiAqLw0KPiA+ID4gPiAgICAgICAgIHZwX3N5bmNocm9uaXplX3ZlY3RvcnModmRldik7
DQo+ID4gPiA+ICB9DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMjUuMQ0KPiA+ID4gPg0KPiA+DQoN
Cg==
