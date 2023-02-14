Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1A0696246
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjBNLVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjBNLVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:21:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88C4BDEF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:21:31 -0800 (PST)
X-UUID: 975cb676ac5711ed945fc101203acc17-20230214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OiyuEJollz/qw7J7zjwiHEpmD/ZbX56bFzIYMI+MDLM=;
        b=XnC+kIb4B8/DLGi5tCGk0pymibwXHXENldtKawfDcLRcgQNajp0kiT57bLBopJPbsJEI6xF2QzNBYiJgAeQ3DyGM+vROJOERupziLsdWjZ7KhY7LTMZdBKxEeM7DHQL9Uc0bISIuzMGafMrjFvjcapjy2jYFwp3naEh5yEYqbEQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:cddffcd7-4f81-4eed-bfbb-5ce8d84fb98d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:c051f7f2-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 975cb676ac5711ed945fc101203acc17-20230214
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1623062918; Tue, 14 Feb 2023 19:06:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 14 Feb 2023 19:06:10 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 14 Feb 2023 19:06:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2eNgblcC7ARJYlKrA6PiUe6y+/k5oAV5Gsrz0dMp6VUY1P2aV/OIYRpvxUZsbJRGrpnIeiD59ed7qbViDRTRuj/ljp+xfWUT3YOjkFNg98TgJrPWtwST6oV7C6tCILgUC56hbSPB4B35J5SFTDyFVs5dZUTRYHop9bSVYIAnA//JceidR1bjcjJkpndeXBNgCCmIewkXIOD8un3EpdkO6WYroX9itocl10y30tJk4d0g2pBbTPcWQ5b35bvSHJgij/CtsO0K/xS7m/3jZOdBLXRvLgxOudTFk7E9j4u3eEk7EtGYWJijflR9K0QahlLjMJLpmzBNPtZBZuxBvyR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiyuEJollz/qw7J7zjwiHEpmD/ZbX56bFzIYMI+MDLM=;
 b=kAQkXPqL3EBTCddkmxsWl3j/7bXAsfYZmIO211cF8I6Kfbqnr5o4e7etu2jrnD1UCzDR1QWAVPZO+aHEQzQxyxUAeJCuwSvkiziiToOAYeQEQZ+oa1CHQf5hx35fFRKMzddNoXMfaFWqCD/NDon3ffPKLskW7GAvtvvJ5vGGgftGjD0yK0u7qIeN30E5vk6VC10x/WEhK5Dp25emS14HHSwtN2JT97dZ23TNIYMOsa8T52AW2smgxrhDlXx2p1CgO4BozvUlZQEWAOOwc3Ek11dNlxe1LDFR1L+U37dvJndhYuTM28Crr7SZ96oQ+z6aX6FQLiqGRA6+HOriP1pn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiyuEJollz/qw7J7zjwiHEpmD/ZbX56bFzIYMI+MDLM=;
 b=RlGqfadleAL+kI4gdhpW3AMxxqfsrRm7WvuQymk7Tplmpea512g8yGjxiwdYzn5KxcNEIUpSPoAinThwNNm0M3prKDw084dKSvPr17FEmDA9X9pDaevmnv3LY5cVifVcrNcO0QNHzjuVujwDn6yOfZrAJCWEDN6E1MkWZtDNg3Q=
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com (2603:1096:820:64::14)
 by TY0PR03MB6353.apcprd03.prod.outlook.com (2603:1096:400:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 11:06:08 +0000
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::c973:4dd1:c6b8:cef0]) by KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::c973:4dd1:c6b8:cef0%8]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 11:06:08 +0000
From:   =?utf-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= 
        <Walter.Chang@mediatek.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "macro@orcam.me.uk" <macro@orcam.me.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH] clocksource/drivers/timer-mediatek: Make timer-mediatek
 become loadable module
Thread-Topic: [PATCH] clocksource/drivers/timer-mediatek: Make timer-mediatek
 become loadable module
Thread-Index: AQHZPTetGp4KAT/tR0iesytE4Gh4FK7OTjyA
Date:   Tue, 14 Feb 2023 11:06:07 +0000
Message-ID: <e533bd12816ec5f1184fcf138f644f7719def962.camel@mediatek.com>
References: <20230210100058.19861-1-walter.chang@mediatek.com>
         <f2d66681-a7b6-2369-b9f7-f886f8ea6ae5@linaro.org>
In-Reply-To: <f2d66681-a7b6-2369-b9f7-f886f8ea6ae5@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5777:EE_|TY0PR03MB6353:EE_
x-ms-office365-filtering-correlation-id: 8194f035-b54e-4e3a-45e8-08db0e7b793a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /iNFjNOIny4Qk3l7H9Nu8jU9AcprzBHyNTVXQ9SP0weBNnVfPSPlH2fqWreuYNXal7GZgrLkaD0slQfRhV0/a7So7IBEKSrvXsd0oX4YpBEr3iRkCJObTy/GfEdlDzYdUu1txUMEPfrum9U533EcHt38uHaFGrPugjdfBN06+EwjwVIvhrM5RysajZ1EFhvY2gJcAqR6yP5vhuMfCVJk3W40onAiwueBMBn71Oi2ZU6gRd/TgeOHET3s14PAMEMWZvHuax5MUOuVaouGfnVqf0A4QwKifM4nxubywwg8BxKGr+G4TW7t9zRurR9OE41DR4CsiJckq8ZLS6vTtlEEXReQFkhqCIltfMFaWOV7c8A9A4OBVteIq9FVSaYzW1AMs8E20bADXpR1+oC7NOmu+G80KyNkMY1oMv6RTcLKT8gF6uuWnNp1QIActwBCOWjHC9LyffzwUZDPPx8UnWga7pzHfUJY+3N5ZmI9fvJnM5p7t6AhixR8IREkRhxuAtSmI0PSS3NLheNNm56qIWV77+hU1vzXzcSnMOtEVq9LmtQA7QBwaoOBewZ1VnTI1AamuZtp/nj9gL9zQt9aekiu/isk7glaEJbU6ECp0YlskEuD8+/Eb8mzGmTJrJpoDSOEMMyKIx9J055V+yXFS9yBfB7WURUiPvYlkdEmqorSNhSQfWjuZW5WwLBHvV999zslf1GiR6wcwnoRJfgn6KNrXe+ew3rZh3Xs2cUEuDxinho33YZ8sWrUhQI8jUHBRWKAaeihlO1rNHnTsmsg8P+1Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5777.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199018)(2616005)(186003)(26005)(6506007)(53546011)(6512007)(36756003)(85182001)(107886003)(8936002)(38070700005)(2906002)(478600001)(86362001)(966005)(5660300002)(6486002)(83380400001)(7416002)(76116006)(91956017)(64756008)(66946007)(66556008)(66446008)(66476007)(41300700001)(8676002)(4326008)(38100700002)(122000001)(316002)(71200400001)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUY5M2RObm5rRTZYckx1dlRIQkNaT1IyZnE4YnBPMDlDK3VtL0FWZ1VQWnlB?=
 =?utf-8?B?UXZEQUpWOEk2YzR4Ykx0NUQwTHcreVo4Y1lNSGtFWllyT0gzUnJmc24xNndX?=
 =?utf-8?B?K01GRHJHbGlUUlBQdnllUTZMdkZFSThiNTIxZjlnRWJlZVYwT2xQVktmVHVI?=
 =?utf-8?B?OFZPT3JrTno0SThhOFBFMFRJSzVRK1ZVTkcyTW56VUlqU3liK2VQcnBrTXRq?=
 =?utf-8?B?enZJM2o2UjF2NDB6S3NDWE1hRGJCQ25YYzVkSHZlcTc0WEhPYmVUcHZoL0dF?=
 =?utf-8?B?VHE4UHZ2dGFnWGdCRUUwWG9acDE5emhQMGx6RERQTXdWQjlZZVdzZ2JvU3R6?=
 =?utf-8?B?SkcyemdHWm1JL1V3SzIrREFyZHgydDhUTkt0SW94clJESDkyRDI4TDhiTk5Q?=
 =?utf-8?B?MDBqb2tJU0JaT1pzT3phQlNQZENaRUJiZWFXbk5hU3N3NFBrT2xrV2thS0FP?=
 =?utf-8?B?ZUhGL1FzWDZUbXYydEh6RVhVdXplVElod3Z1SDQ1UHdjLzJXTG0xSzFheVF1?=
 =?utf-8?B?bm1tR2RKdWFUdTNsc1pCQWVpWEs1YUNtRzBlQ0VBUmRuQzNqbFlLcUo0N29Q?=
 =?utf-8?B?ZWlVdW9sRE1uZXdHeVJaWEg5QXd6Sjhla1pSRDBRQ0xqRU4vSFRWQ2RmTnVu?=
 =?utf-8?B?emtrRkhGSVRpRG9VcjZabVBtSUx2ZzhQN3VhM2tQR01KWldxTEtjamtYeVND?=
 =?utf-8?B?bWJlOGdIdklCL0thaVhQSURBR01xNE1GVmNpMDJVOHY3bU9EdnRuM0ZtaExv?=
 =?utf-8?B?ZXNHRXJKM2svVXdKQ1VwVnk0WjF6dGV4MVVuSkVYbmZCK2RKcEpqSHJBU1Iy?=
 =?utf-8?B?WHpBeWlnbXFibi83U2JJLzNCMUdWOFJkWFA2Y1piUFR3TzRNZmxHTkMxbnM2?=
 =?utf-8?B?Y1I2NjRGV3hjc2F5bFBFNTlTQ2J4RUxmQjhLcjB0N2hWOWdlREdjaHg1Uisz?=
 =?utf-8?B?UzRnaHlzU1hVS1BMYlN5RUg4T1M1Y00xa0FEVTNIMml3bms5SzNVRVV6dW9V?=
 =?utf-8?B?dy82TVhUYjFHdFlEVzF6c2FRVDgzbTdQRHVyNzdGbVdoTEFsMktFZ25NRGZx?=
 =?utf-8?B?cDVBeVF1VGVmYlNjLzJjNnc1VkNteitMSHNYdFVPdERNalJETSt4R3haeGxB?=
 =?utf-8?B?NmZwb1psa1VaYlFLMGVNMi9ycjRkYXBNSGNydm80NE1NWGtnN3RrY002dkZW?=
 =?utf-8?B?elcxK20wUCtma1V6dkJFc3pQZkpCSmxSZnd4ZldzTzJOWS85NE11VTk5ZWxI?=
 =?utf-8?B?VGFZaVY2VzFKYjB4SUpTZnR6d2t4UWZ1VzNUUnJZblRGOW05aVVTTGUySlND?=
 =?utf-8?B?eXZ0eWtpY1lLcHJaUjhkWnVqc3RNbmN0VjZjUUl4OTBLZDRQU0NVbTlFV0Jp?=
 =?utf-8?B?ejB1ZUI3OFV3TWxqUXJNMmJaaGNkbTEveGErclJMVzY4Q21xT2diSHViY0Rz?=
 =?utf-8?B?NXduQ1lOOU1BSXhqRjhkRVZLTytKbUYxYTFiZ0dIeVkzdnAwQ1poUG91cU0x?=
 =?utf-8?B?N3cwalRseUNva2pVcWlzeHU2L3ZEZmRCZWg0QmhVRzRiQSt3OWFUTUtTa1FH?=
 =?utf-8?B?L2tmMTlCaFpPMnR6LzhkTzVwY1ZNQkhGeExBQTd6N053MjZqRVNieUJQKyt1?=
 =?utf-8?B?UlQ0b2k5NkZQQkhDZmJwa3RDOFVNTUlhMVp1QWUwekhZVjQ3RmJzMTZTbk9x?=
 =?utf-8?B?ZFR6RXVMbEFLZ2pJZURQQjZwaWJPVldLUURTaTlieWtUTFcweXFEa0xDSm9G?=
 =?utf-8?B?V3FkUDVVelMxNmJGU0lqVExXR1FobTZOM1NGVlFSYkpmcHMyUGQrSm9ocHNl?=
 =?utf-8?B?RUovRnNFRVF2ZHA1M2hBeXBjNnE0VXVpV1Z6YTRoYkQySGF0TG1ka1o4cHJh?=
 =?utf-8?B?TnB6YzJyVFA0Sk1qS282cHVZUDdFYk1jSkp6emNkckxKUUNJRkJNQjh4NWdm?=
 =?utf-8?B?VXZLZE1SR0ZhZTBHMjd3NXphR2d6Q3dnbEI1SzFES2N5TnpNY0dlYWxoOHdo?=
 =?utf-8?B?YVNxaEtmMGhseHcvaWNUbEczWHovVGFQWWR1cmZ1NC91NW82QzBDNVBURHVn?=
 =?utf-8?B?VnRJdm1sbGhWelRFRDFoMnhaUkUvb3QwNmtzWjV1ME5YSkNhZlNyd2JwSG9Z?=
 =?utf-8?B?OUZ6VTdOaGt3V3ZBTU1NdTc0UjBRZXI5ZVQxYW1zdVZzNkhtRGEzSEl6RlYx?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B42D721EE0394042B08C06453340368F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5777.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8194f035-b54e-4e3a-45e8-08db0e7b793a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 11:06:08.0217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pELSs5/MhuZHHQEArPOS8RjS+4qAIdHtCuCdTVYLQdA7oSoow1KdxA7605cSlHIV0iE2zCglER824lrEyfGEx9B8MmGAZZFLLHV/P6Qvro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6353
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTEwIGF0IDExOjA3ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMC8wMi8yMDIzIDExOjAwLCB3YWx0ZXIuY2hhbmdAbWVkaWF0ZWsuY29tIHdy
b3RlOg0KPiA+IEZyb206IENodW4tSHVuZyBXdSA8Y2h1bi1odW5nLnd1QG1lZGlhdGVrLmNvbT4N
Cj4gPiANCj4gPiBUaGlzIHBhdGNoIG1ha2VzIHRoZSB0aW1lci1tZWRpYXRlayBkcml2ZXIgd2hp
Y2ggY2FuDQo+IA0KPiBEbyBub3QgdXNlICJUaGlzIGNvbW1pdC9wYXRjaCIuDQo+IA0KaHR0cHM6
Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1
LjE3LjEvc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0
Kkw5NV9fO0l3ISFDVFJOS0E5d01nMEFSYnchZzF5aWdPTzZpSXBqbHI4MlVkMGRuMXlWUF8xeXFT
ZkxXSi0xR0ZDN084OG43bDdscmI5U2xZQXc1S0h6QTMzMzl6eWlWLXM3MlduX09ackFSamxhWTBS
TW1kbk9VeVEkwqANCj4gIA0KPiANCj4gPiByZWdpc3RlciBhbiBhbHdheXMtb24gdGltZXIgYXMg
dGlja19icm9hZGNhc3RfZGV2aWNlDQo+ID4gb24gTWVkaWFUZWsgU29DcyBiZWNvbWUgbG9hZGFi
bGUgbW9kdWxlIGluIEdLSS4NCj4gDQo+IEFyZSB5b3UgcGxhbm5pbmcgdG8gYW5zd2VyIG90aGVy
IHBhcnRzIG9mIHRoYXQgZGlzY3Vzc2lvbj8gSU9XLCBkb2VzDQo+IHRoZQ0KPiBzeXN0ZW0gYm9v
dCBmaW5lPyBXaGF0J3MgdGhlIGltcGFjdCBvZiB0aGlzIGJlaW5nIGEgbW9kdWxlPw0KPiANCj4g
PiANCj4gPiBUaGlzIHBhdGNoIGRlcGVuZHMgb24gdGhlIHByZXZpb3VzIHBhdGNoLg0KPiA+IA0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDIwODA5NDgxMy4yMDg3NC0xLXdhbHRl
ci5jaGFuZ0BtZWRpYXRlay5jb20vVC8jdA0KPiANCj4gVGhpcyBkb2VzIG5vdCBiZWxvbmcgdG8g
Y29tbWl0IG1zZy4gV2hhdCdzIHRoZSBwb2ludCBvZiBrZWVwaW5nIGl0IGluDQo+IGNvbW1pdCBo
aXN0b3J5IGZvcmV2ZXI/DQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW4tSHVuZyBX
dSA8Y2h1bi1odW5nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jbG9j
a3NvdXJjZS9LY29uZmlnICAgICAgICAgIHwgIDIgKy0NCj4gPiAgZHJpdmVycy9jbG9ja3NvdXJj
ZS90aW1lci1tZWRpYXRlay5jIHwgNDMNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL0tjb25maWcNCj4gPiBi
L2RyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZw0KPiA+IGluZGV4IDQ0NjllN2Y1NTVlOS4uNDEz
NDU4MjcwNTViIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZw0K
PiA+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvS2NvbmZpZw0KPiA+IEBAIC00NzIsNyArNDcy
LDcgQEAgY29uZmlnIFNZU19TVVBQT1JUU19TSF9DTVQNCj4gPiAgCWJvb2wNCj4gPiAgDQo+ID4g
IGNvbmZpZyBNVEtfVElNRVINCj4gPiAtCWJvb2wgIk1lZGlhdGVrIHRpbWVyIGRyaXZlciIgaWYg
Q09NUElMRV9URVNUDQo+ID4gKwl0cmlzdGF0ZSAiTWVkaWF0ZWsgdGltZXIgZHJpdmVyIg0KPiA+
ICAJZGVwZW5kcyBvbiBIQVNfSU9NRU0NCj4gPiAgCXNlbGVjdCBUSU1FUl9PRg0KPiA+ICAJc2Vs
ZWN0IENMS1NSQ19NTUlPDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGlt
ZXItbWVkaWF0ZWsuYw0KPiA+IGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1tZWRpYXRlay5j
DQo+ID4gaW5kZXggZDViMjlmZDAzY2EyLi44MDYwNDRlZjM5MWMgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1tZWRpYXRlay5jDQo+ID4gKysrIGIvZHJpdmVycy9j
bG9ja3NvdXJjZS90aW1lci1tZWRpYXRlay5jDQo+ID4gQEAgLTEzLDYgKzEzLDkgQEANCj4gPiAg
I2luY2x1ZGUgPGxpbnV4L2Nsb2Nrc291cmNlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9pbnRl
cnJ1cHQuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lycXJldHVybi5oPg0KPiA+ICsjaW5jbHVk
ZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvc2NoZWRfY2xvY2suaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiAgI2lu
Y2x1ZGUgInRpbWVyLW9mLmgiDQo+ID4gQEAgLTQ1MCw2ICs0NTMsNDYgQEAgc3RhdGljIGludCBf
X2luaXQgbXRrX2dwdF9pbml0KHN0cnVjdA0KPiA+IGRldmljZV9ub2RlICpub2RlKQ0KPiA+ICAN
Cj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gKw0KPiA+ICsjaWZkZWYgTU9EVUxFDQo+ID4g
K3N0YXRpYyBpbnQgbXRrX3RpbWVyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ID4gK3sNCj4gPiArCWludCAoKnRpbWVyX2luaXQpKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9k
ZSk7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+
ID4gKw0KPiA+ICsJdGltZXJfaW5pdCA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+
ZGV2KTsNCj4gPiArCXJldHVybiB0aW1lcl9pbml0KG5wKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX3RpbWVyX21hdGNoX3RhYmxlW10g
PSB7DQo+ID4gKwl7DQo+ID4gKwkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2NTc3LXRpbWVy
IiwNCj4gPiArCQkuZGF0YSA9IG10a19ncHRfaW5pdCwNCj4gPiArCX0sDQo+ID4gKwl7DQo+ID4g
KwkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2NzY1LXRpbWVyIiwNCj4gPiArCQkuZGF0YSA9
IG10a19zeXN0X2luaXQsDQo+ID4gKwl9LA0KPiA+ICsJew0KPiA+ICsJCS5jb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10Njc5NS1zeXN0aW1lciIsDQo+ID4gKwkJLmRhdGEgPSBtdGtfY3B1eF9pbml0
LA0KPiA+ICsJfSwNCj4gPiArCXt9DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0
IHBsYXRmb3JtX2RyaXZlciBtdGtfdGltZXJfZHJpdmVyID0gew0KPiA+ICsJLnByb2JlID0gbXRr
X3RpbWVyX3Byb2JlLA0KPiA+ICsJLmRyaXZlciA9IHsNCj4gPiArCQkubmFtZSA9ICJtdGstdGlt
ZXIiLA0KPiA+ICsJCS5vZl9tYXRjaF90YWJsZSA9IG10a190aW1lcl9tYXRjaF90YWJsZSwNCj4g
PiArCX0sDQo+ID4gK307DQo+ID4gK01PRFVMRV9ERVNDUklQVElPTigiTUVESUFURUsgTW9kdWxl
IFRpbWVyIGRyaXZlciIpOw0KPiA+ICtNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQo+IA0KPiBJ
IGRvbid0IHRoaW5rIHlvdSBydW4gY2hlY2twYXRjaCBiZWZvcmUgc2VuZGluZy4uLiBwbGVhc2Ug
ZG8gbm90IHVzZQ0KPiBodW1hbnMgZm9yIHJldmlldyB3aGljaCBpcyBkb25lIGJ5IGF1dG9tYXRp
YyB0b29scy4NCj4gDQo+ID4gKw0KPiA+ICttb2R1bGVfcGxhdGZvcm1fZHJpdmVyKG10a190aW1l
cl9kcml2ZXIpOw0KPiANCj4gRm9sbG93IGNvZGluZyBjb252ZW50aW9uIGxpa2UgaW4gdmVyeSBv
dGhlciBkcml2ZXIsIHNvIHRoaXMgZ29lcw0KPiBpbW1lZGlhdGVseSBhZnRlciBkZWZpbml0aW9u
IG9mIGRyaXZlciBzdHJ1Y3R1cmUuDQo+IA0KPiA+ICsjZWxzZQ0KPiANCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQpUaGFua3MgZm9yIHBvaW50aW5nIG91dCB0aGUgbWlz
dGFrZS4gSSBoYXZlIGZpeGVkIGl0IGFuZCBzdWJtaXR0ZWQgDQpwYXRjaCB2Miwgd2hpY2ggbWVy
Z2VkIHRoZSBkcml2ZXIgYW5kIGV4cG9ydCBmdW5jdGlvbnMgaW4gdGhlIHNhbWUNCnBhdGNoLg0K
DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzAyMTQxMDU0MTIuNTg1Ni0xLXdh
bHRlci5jaGFuZ0BtZWRpYXRlay5jb20vVC8jdA0KDQpUaGFua3MsDQpXYWx0ZXIgQ2hhbmcNCg==
