Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92FC750211
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjGLIxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:53:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA15127;
        Wed, 12 Jul 2023 01:53:20 -0700 (PDT)
X-UUID: 8b9db3ae209111ee9cb5633481061a41-20230712
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HlvurA2nZ/SG0+FxRG7KN8uoNgcTftvRV2MByWytkds=;
        b=YRPK1GOthuK2Z7pfpAheO4zqT0VkFvg4XeTmcf8qfpm/SbQXtbblfIMsM7YD5zGKfCggR18huHjx+/PFdgAHyZKtmFRLDH2+ZabpkXCDHsLiRLHpzKa7OR5xwRkyykZhY5VWmF2touzueg+NHgRoWQEJpDEvQRlZ3y2A12QGNO8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:e783e217-789e-47f2-8a3c-10cd0e7c4148,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:d36a250e-c22b-45ab-8a43-3004e9216b56,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8b9db3ae209111ee9cb5633481061a41-20230712
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <chris.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 120982536; Wed, 12 Jul 2023 16:53:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 12 Jul 2023 16:53:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 12 Jul 2023 16:53:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxN5Fn2PKpVs0OmU1GU1QID9oNGwg23I6JAyYZxbMYBd/wlr1Q3mrUY+/LTSLjdU+WRC+JiOLMbD0IJ+tZmfNN6L7i/1oBX34ah/G5t7wFmNyfmWFJQnThn4DxJOl9tw1XgTLFdo+unLiIwWSVmg4NCO4kUb9Jhb3niOxRgMIdndBcnRUBN6BBmoNPL8Fw+gPoBcIkIGAKeiSIA3bqf0mEAKYvMcAQ7POXM5pAoKtDGIvebI8n2YYk56IbvMVN2BHl+/+LQw11ztF8H1Ih68zH0LV7ghN/5SWA+IfxmHmasJqa86RsvhCCfjhlFtW3mvVS/w7beEaXyybnn+YvhkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlvurA2nZ/SG0+FxRG7KN8uoNgcTftvRV2MByWytkds=;
 b=X7BP9p9basQ3CGTiyednk6tSAczFxA4RlLoD2VbCPznw6vOjGtCoKjAc96yjujawjjbLSUOFBJYQcVh+WTSLRpYGAn66IISLdUnfZ6ll9kdUNHigGaieoah6Gs6VUO1aTDthT3wq+3t/5uaYRoX0lpUJQhWJpsbywEHhC3HulhwWqI+y2Z0Am6aG/atbZotE1BPBFrr8IaezvizRjQufY8S9E3zQDqm/dzCzsDI9HJBClj6jH7p6j+HIiKsRUt9YidftYIRuytYEi8JpG552N/9FE/gF0ZGPkNHjm035R6wQ0ljywWMqwHGCcNzv5mBI3DDcG6hNhsX6b+egqnp9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlvurA2nZ/SG0+FxRG7KN8uoNgcTftvRV2MByWytkds=;
 b=D80N0pyfUblrM/5WH6tiuefn0CxNrkaQvl0CuX/oVDbaAqTWJMdgxgSgD7t3lwaEnmrBuK2mratuO6mDXrINw9NNEJG6NrbGt77A9PEIXeI/2+v4Ll4DbqioUmH8QKljev3Py7PvC7krunR/RZMOMmUvuh2Xnk1CGkkBPj1z+oI=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by TY0PR03MB6800.apcprd03.prod.outlook.com (2603:1096:400:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 08:53:14 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::8dfd:d707:163c:f0e7]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::8dfd:d707:163c:f0e7%3]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 08:53:14 +0000
From:   =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        =?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btmtk: Fix null pointer when processing
 coredump
Thread-Topic: [PATCH v3] Bluetooth: btmtk: Fix null pointer when processing
 coredump
Thread-Index: AQHZtIBo2hc7mLaVO02TO/SF7kFs06+1pnKAgAAtIYA=
Date:   Wed, 12 Jul 2023 08:53:14 +0000
Message-ID: <d8f82d97496c73c01521dbbce5455ad23521036c.camel@mediatek.com>
References: <20230712051857.13812-1-chris.lu@mediatek.com>
         <0cb29d27-a76f-47f2-86c3-f39ba25e8bc2@molgen.mpg.de>
In-Reply-To: <0cb29d27-a76f-47f2-86c3-f39ba25e8bc2@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|TY0PR03MB6800:EE_
x-ms-office365-filtering-correlation-id: 913d0d28-480b-4f1c-b3f8-08db82b56db9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1VuKSEvHwxDTuw0uemf9SAlnuYklNlt2CPPvc5mvSHuHKmFI3ZXEVLJGzFmgyskvRRXMl2npdVEc9t8cv9DuriRhE2Zz8BpeZuPQj+TkH7F6PXWxZdK1uY4sb3aXk/d31S+IDZYnLjAKr3nQLdGX7Ji1ZriBorTyYxOZyvcqoe5RvsSzoFCVlmsZURw3TZV3ZNuVLzFNoBO0iFJ/cSYVzFQpT13H1SwFnWXswA3iHy4mVIoctAPr4svdFlEWbnw2b0oX3UJY2zIqKIX0CEnhh9htgPh4AONzgHaUF5wknG5P05ECwFLiugkwYvhMP5/EdciibWY5ACzL1jkjl6z/Wz5zhVFwHVGxwPnOFkEzPVClk3SZq9D43BpbfVWn/rMs+Nwt/l8BE/pGqXCsBHQz8UPuewScoP/6Oig6f3T4rxS3+2CNluP4YpG/3QHAbfkSzJcHY3wTUMt6AHCBU26Q4RVQvlD/8uiYnLDq/HD//FLz0G279tRk9VOG5zmhr1gsSITtCPMw2En3EQjYK2RAwTXoutVwwLkkFT9o2XiufC8fO5TjRSOqraa7agxE7sB/kkGdNRLOtgQuANeIKznHUpqrWFyEvpfFfUGPAQflfiN8B4JQefp7cxdHc8dYVG40KELJtWTzYC/rEcKLNv6wSRllrb6rp5u6eEpqjdMTpQc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199021)(86362001)(2906002)(478600001)(54906003)(71200400001)(8936002)(6486002)(85182001)(36756003)(66556008)(66946007)(66446008)(66476007)(76116006)(64756008)(4326008)(41300700001)(6916009)(316002)(6512007)(83380400001)(38100700002)(122000001)(186003)(5660300002)(6506007)(8676002)(38070700005)(2616005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2ZoRW5RWmp1YS9sbkdadmZzUDlxc1FNZGRqOFRlQmZUWGpDaVVjNVNnbk5x?=
 =?utf-8?B?Rml2bHYrV1c2KzE5RGtjb1ZNcmFnNkhNUnFVZDhTNEhzb3d5U21Hemo1eWFy?=
 =?utf-8?B?SmJZbUlMdS85eGlYM3h6UEFXSXMwSmtjTGFkdmplWWRmTGo3T2s1QmdQV3RL?=
 =?utf-8?B?VWpyNnZXclhwanNtMHp5RTM5YlZPd0Rub2hsSE9SVUlBWmFIZG1vOUtqdG1h?=
 =?utf-8?B?aC85bGtnL0U0Sk1YY2hEaXFkUkMvME0xeVBzOE1sSUo0cGltUVJUQXU3M295?=
 =?utf-8?B?VUptWTJaZjF6UHArdHVoSEN0N1g0ZVNocFlPWUpmQzRQcFZ2NUxlMlpBQUQx?=
 =?utf-8?B?MzNWU2dEWmM1bXJGM3pIaG5hTkkzTTkxcVNiM0QxaVp3UVVidDJveXA4VjhB?=
 =?utf-8?B?ZCtNTkpteHpRaTBmczhRb08zQU1MRVR0Um5iZGdERk5qaVppZHJ3TzdBajA3?=
 =?utf-8?B?djh3ODNkOCtQdjlVakxMYUhlL3BmY0cycVZXVFhOTkRYdjkwalVpcnA4b0Zk?=
 =?utf-8?B?L0Vsa3RXS3lHNE54U1FveHlxMXZBc0FWNDhPQS9tSTZaZ0RZdzFLblZXMGlF?=
 =?utf-8?B?YmpHUkdlUXUwL0RwTjk3OEs2RmFqUDZBMUZTdVkxZmZ1bUppa0crK0N1cWRs?=
 =?utf-8?B?T2lSRHdTSUdDOFhHQTFncXBkSVU3a25uYWtUeHY2ZXFTbjMrS2VHQUxKVSsw?=
 =?utf-8?B?Y3N1dlRtd25iRkcyZjFsTDZHMlNhUmxjbUFXOXFQUFNWMDNXM2p1Z1dabGpW?=
 =?utf-8?B?UG9zZllMWldyT0xFeUNuUlZyMU1YWXoyaGJPZ3pzd2RrU1JtNDFjODRtR1Qx?=
 =?utf-8?B?M2JLN1RxRGlNcTE5ZzJvMDd1ZDVhcWpDL3pKQk0vaHlZQXl0dk1ValBRdzY4?=
 =?utf-8?B?eE93M1NBS1NSRkV0VHRGNllzSU1wV042YTVhQWgxaUVFaUl3UUhaczdpLzZN?=
 =?utf-8?B?eUhmSXJhdUJSNUo4VldhQjQyRFJiNDlURXpNT01DQnBDVVhtVis5TUg0eERM?=
 =?utf-8?B?dTBJQ0daUXpBSkVFTjBsZis0Tlkvb0FWUzdkZlJHMHBRMThqVGJZV1hsWGJI?=
 =?utf-8?B?MXlmS0ZlQmRlSW1WQ0N4cmZiSXlqL1I5UzdXTXV6YjJBbndvYnVYOEN2amVW?=
 =?utf-8?B?V2hMSDFtRGRNaE9QbjdJUHdQc3k3Y3pxTlFUUnc5LzRWeEh1cHVzWnVLb21l?=
 =?utf-8?B?dm85bUkxSFlUdVZHR0RReGVhN1Y5UTRaQTJQbXVQR3lTMmZQSVh5RUdISUxU?=
 =?utf-8?B?TUpiaFYzTlpqK0M0cGY4bzBxcGlhck5qN2xrK3RhRDVOTU5BV0pqbklwcUN0?=
 =?utf-8?B?b3pWWlE2Nkx0YWUyUVM5SXNSc1pMUGdiLzNTWlY3bytJeFRXVzh6NUc3QmJx?=
 =?utf-8?B?bjRrVFNvRFU0d1FLZGhzMUlsQ1hEMkYzNWJydkFyZ1I1VUNkYlYrdytzaExz?=
 =?utf-8?B?dFBHUEpLb0FaM0NDUTRZR0lYc2t3RXcrRFBFQVliTytRY2k5Y1BFNk1aQmI2?=
 =?utf-8?B?RE1sbFpxb3B0a1pJQzhkT0RZdUZJTG84WXBxd3JRckVBQ084YjlDN2dudWVt?=
 =?utf-8?B?SFlPU09VTHJub29DTXA3UjNWN3NLalA4a3pkeS9TWFBZc0p1YmQwNVhQREtZ?=
 =?utf-8?B?dFJOR0pkU1E2N3hpVnlNMW4vaEE0S1NpWG9MdkZUK0d0UW5INTh0Ujh1TEhQ?=
 =?utf-8?B?M2JNQit3NklLYmdrYmtHZWZCVkNoaVJFSzFmSExjZDFKV3NyUWJBb2dFQ2xw?=
 =?utf-8?B?Z1Rpa3g3SGpZYVkrRGlwcHU2OEpKdVFwaFBkQWhOWFlYT2tlYU1TQmtXTXBW?=
 =?utf-8?B?UUYxMk9IdVRZQ29rMjRjTnM5VUQvUERwL0FjYk1oYk1DTEU4WHRHc1VBT01i?=
 =?utf-8?B?czh6ZUFFK3FrUE5TZ3ZsVEY5MHlxMXNWanRCQkQ5bjVZSGJLTDRoK3FGK1Yr?=
 =?utf-8?B?dlloTTgyVEFlaVNFZDZrT1MrSkdHSVZuamc0UER1NEliTmlvTUZzSHhRdXli?=
 =?utf-8?B?eXgrVXg5Q2YxR0FIalBYSzJHd2hpYXZySVh6andoZGJJN1NkWTZ0VjRaQTAr?=
 =?utf-8?B?RXNDaDN0d2VxZndRQm16MERTTWlFSzdtQ3ZaWDFyazM0WUVEbE5IM0oxOHhD?=
 =?utf-8?B?T1hPSFRZcEF2QXU0TG9qckRoTzV4V1ZqUXh4Tng1ajRlVENhUzh2ckJSS0Vp?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8BBF8E27BD90941BD40B37D318D2751@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913d0d28-480b-4f1c-b3f8-08db82b56db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 08:53:14.4111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMfURYJej7wKQyDqfkLu1BH38kMa8OarQ0KzS5qvE2GVz1sshpHCr8EBb3y2KYg1W+aJy0zY1eHyG2TtKiqfUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6800
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTEyIGF0IDA4OjExICswMjAwLCBQYXVsIE1lbnplbCB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBEZWFyIENocmlzLA0KPiANCkRlYXIgUGF1bCwNCg0KVGhhbmtzIGZvciB5
b3VyIHJldmlldyBhbmQgZmVlZGJhY2sgdG8gTWVkaWF0ZWsncyBCbHVldG9vdGggZHJpdmVyDQpj
b2RlLg0KDQo+IA0KPiBBbSAxMi4wNy4yMyB1bSAwNzoxOCBzY2hyaWViIENocmlzIEx1Og0KPiA+
IFRoZXJlIG1heSBiZSBhIHBvdGVudGlhbCBudWxsIHBvaW50ZXIgcmlzayBpZiBvZmZzZXQgdmFs
dWUgaXMNCj4gPiBsZXNzIHRoYW4gMCB3aGVuIGRvaW5nIG1lbWNtcCBpbiBidG10a19wcm9jZXNz
X2NvcmVkdW1wKCkuDQo+ID4gQ2hlY2tpbmcgb2Zmc2V0IGlzIHZhbGlkIGJlZm9yZSBkb2luZyBt
ZW1jbXAuDQo+IA0KPiBVc2UgaW1wZXJhdGl2ZSBtb29kOiBDaGVjayBvZmZzZXQg4oCmDQo+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IENocmlzIEx1IDxjaHJpcy5sdUBtZWRpYXRlay5jb20+DQo+ID4g
Q28tZGV2ZWxvcGVkLWJ5OiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+IHYyOiBmaXggdHlwbw0KPiA+IHYzOiBmaXggYm90IGNoZWNraW5nIGVycm9yDQo+ID4g
LS0tDQo+ID4gICBkcml2ZXJzL2JsdWV0b290aC9idG10ay5jIHwgMTYgKysrKysrKystLS0tLS0t
LQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuYyBiL2RyaXZl
cnMvYmx1ZXRvb3RoL2J0bXRrLmMNCj4gPiBpbmRleCA3ODZmNzc1MTk2YWUuLjBmMjkwNDMwYWUw
ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idG10ay5jDQo+ID4gKysrIGIv
ZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuYw0KPiA+IEBAIC0zNzAsNyArMzcwLDcgQEAgRVhQT1JU
X1NZTUJPTF9HUEwoYnRtdGtfcmVnaXN0ZXJfY29yZWR1bXApOw0KPiA+ICAgaW50IGJ0bXRrX3By
b2Nlc3NfY29yZWR1bXAoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVjdCBza19idWZmDQo+ICpz
a2IpDQo+ID4gICB7DQo+ID4gICBzdHJ1Y3QgYnRtZWRpYXRla19kYXRhICpkYXRhID0gaGNpX2dl
dF9wcml2KGhkZXYpOw0KPiA+IC1pbnQgZXJyOw0KPiA+ICtpbnQgZXJyLCBvZmZzZXQ7DQo+ID4g
ICANCj4gPiAgIGlmICghSVNfRU5BQkxFRChDT05GSUdfREVWX0NPUkVEVU1QKSkNCj4gPiAgIHJl
dHVybiAwOw0KPiA+IEBAIC0zOTIsMTUgKzM5MiwxNSBAQCBpbnQgYnRtdGtfcHJvY2Vzc19jb3Jl
ZHVtcChzdHJ1Y3QgaGNpX2Rldg0KPiAqaGRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4gPiAg
IGlmIChlcnIgPCAwKQ0KPiA+ICAgYnJlYWs7DQo+ID4gICBkYXRhLT5jZF9pbmZvLmNudCsrOw0K
PiA+ICtvZmZzZXQgPSBza2ItPmxlbiAtIHNpemVvZihNVEtfQ09SRURVTVBfRU5EKTsNCj4gDQo+
IEZvciBgc2l6ZW9mKClgIHNob3VsZG7igJl0IHlvdSB1c2UgYHNpemVfdGA/IEJ1dCB0aGF0IGlz
IHVuc2lnbmVkIG9mIA0KPiBjb3Vyc2UuIE1heWJlIHNzaXplX3QgdGhlbj8NCj4gDQp5ZXMsIGl0
J3MgYmV0dGVyIHRvIHVzZSBzc2l6ZV90IG9yIHNpemVfdCwgSSdsbCBjaGFuZ2UgZGVjbGFyYXRp
bnMgb2YNCm9mZnNldCBmcm9tIGludCB0byBzc2l6ZV90Lg0KDQo+ID4gICANCj4gPiAgIC8qIE1l
ZGlhdGVrIGNvcmVkdW1wIGRhdGEgd291bGQgYmUgbW9yZSB0aGFuIE1US19DT1JFRFVNUF9OVU0g
Ki8NCj4gPiAtaWYgKGRhdGEtPmNkX2luZm8uY250ID4gTVRLX0NPUkVEVU1QX05VTSAmJg0KPiA+
IC0gICAgc2tiLT5sZW4gPiBzaXplb2YoTVRLX0NPUkVEVU1QX0VORCkgJiYNCj4gPiAtICAgICFt
ZW1jbXAoKGNoYXIgKikmc2tiLT5kYXRhW3NrYi0+bGVuIC0NCj4gc2l6ZW9mKE1US19DT1JFRFVN
UF9FTkQpXSwNCj4gPiAtICAgIE1US19DT1JFRFVNUF9FTkQsIHNpemVvZihNVEtfQ09SRURVTVBf
RU5EKSAtIDEpKSB7DQo+ID4gLWJ0X2Rldl9pbmZvKGhkZXYsICJNZWRpYXRlayBjb3JlZHVtcCBl
bmQiKTsNCj4gPiAtaGNpX2RldmNkX2NvbXBsZXRlKGhkZXYpOw0KPiA+IC19DQo+ID4gK2lmIChk
YXRhLT5jZF9pbmZvLmNudCA+IE1US19DT1JFRFVNUF9OVU0gJiYgb2Zmc2V0ID4gMCkNCj4gDQo+
IFdoeSBub3Qga2VlcCBpdCBsaWtlIGJlZm9yZSwgYW5kIGp1c3QgYWRkIHRoZSBjb25kaXRpb24g
YHNrYi0+bGVuIDwgDQo+IHNpemVvZihNVEtfQ09SRURVTVBfRU5EKWA/IFRoZSBjb21waWxlciBp
cyBwcm9iYWJseSBnb2luZyB0byBvcHRpbWl6ZQ0KPiBzbyANCj4gdGhlIHZhbHVlIGlzIG5vdCBj
YWxjdWxhdGVkIHR3aWNlLg0KPiANCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBhdWwNCj4g
DQo+IA0KVGhlIHJlYXNvbiB3aHkgSSBzZW5kIHRoaXMgcGF0Y2ggaXMgd2hlbiBJIGJhY2twb3J0
IGRldmNvcmVkdW1wIGZlYXR1cmUNCnRvIHNwZWNpZmljIHByb2plY3Qgd2l0aCBvbGRlciBrZXJu
ZWwgdmVyc2lvbiwgdGhlIGNvbXBpbGVyIG1pZ2h0IG5vdA0Kc28gb3B0aW1pemVkIHRoYXQgaXQg
d291bGQgY2F1c2Uga2VybmVsIHBhbmljIHdoZW4gcnVuIGludG8gbWVtY21wLg0KQXMgYSByZXN1
bHQsIG1ha2Ugc3VyZSBgc2tiLT5sZW4gPiBzaXplb2YoTVRLX0NPUkVEVU1QX0VORCkgYCBiZWZv
cmUNCmRvaW5nIG1lbWNtcCBwYXJ0IGNhbiBhdm9pZCBudWxsIHBvaW50ZXIgaXNzdWUuDQpCZXNp
ZGVzLCBvbmx5IGluIGNvbmRpdGlvbiAnZGF0YS0+Y2RfaW5mby5jbnQgPiBNVEtfQ09SRURVTVBf
TlVNICYmDQpvZmZzZXQgPiAwJyBuZWVkIHRvIGRvIG1lbWNtcCB0byBjaGVjayB0aGUgZW5kIG9m
IGNvcmVkdW1wLiBEcml2ZXIgZG8NCm5vdGluZyB3aXRoIGNvbmRpdGlvbiBgc2tiLT5sZW4gPCBz
aXplb2YoTVRLX0NPUkVEVU1QX0VORCkgYCB0aGF0DQphZGRpdGlvbmFsIGNvbmRpY3Rpb24gaXMg
bm90IHJlYWxseSBuZWNlc3NhcnkuDQoNCj4gPiAraWYgKCFtZW1jbXAoKGNoYXIgKikmc2tiLT5k
YXRhW29mZnNldF0sIE1US19DT1JFRFVNUF9FTkQsDQo+ID4gKyAgICBzaXplb2YoTVRLX0NPUkVE
VU1QX0VORCkgLSAxKSkgew0KPiA+ICtidF9kZXZfaW5mbyhoZGV2LCAiTWVkaWF0ZWsgY29yZWR1
bXAgZW5kIik7DQo+ID4gK2hjaV9kZXZjZF9jb21wbGV0ZShoZGV2KTsNCj4gPiArfQ0KPiA+ICAg
DQo+ID4gICBicmVhazsNCj4gPiAgIH0NCg==
