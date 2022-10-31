Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238BC6130D4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 07:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJaG7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 02:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJaG7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:59:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69698BC3A;
        Sun, 30 Oct 2022 23:59:05 -0700 (PDT)
X-UUID: cdd0131db1814b51a02976895fa6600b-20221031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KTM7a+rTK4iK4RB118j0Yvi7S9iR30nxZPJCqtVN8Ok=;
        b=JstBsk4fWE3SZ3/5TrNiJlayJnctRksmGdxiEWyA77XOCpPxdYjiZrOsCwUAsgef1VaB3IY53nuG4Vfu2NB3mc/xP3/QjRhWmA2hlneT6/TS9hss4ZP8Nyu+V2tiNfteJqcvJGsqjlNOYm0/DxpRiL1uEtKTCcw6jH/1BmTxXyA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:9861b1bf-976c-446a-8786-9bcdcb1deb68,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:5fc4efea-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: cdd0131db1814b51a02976895fa6600b-20221031
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <mengqi.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1272242467; Mon, 31 Oct 2022 14:58:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 31 Oct 2022 14:58:57 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 31 Oct 2022 14:58:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYXqPXtElgPcRCmkQgSCWbbk3gsiUxom16AfsN3ASgi2qEqOGky/mYxxg3BLtT5YT7ILfEgYXeeW3Sppa0yTbH5kr/LzIu+CFFC5lghk/6p7MVjFnqpt3ujY1/7D27aR2J+9w22wWyxYYhPk6Wv3XhfQKOAWZTClQoGkHf1heSnnmdZoUPpFAqa40NspotprPLjHzjDNWmhINSfLZ1J06hcnF7cMAZYU46EILKYizkl3Fo6GZwRjWHbV1pGhVcTKgvUz5s1DszI1kFHRvpd5takS/+szPMvIVOE9fH3gP694QuBTSH/XFLbEwA6TfqwdmFR7482OmCATdmV4culWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTM7a+rTK4iK4RB118j0Yvi7S9iR30nxZPJCqtVN8Ok=;
 b=gArl3lu1SgufYZS2HOG5Bec0k1E17+NaxOTyC4Ho6CNkYEd6apJMvnr7y9rplIVWw6oltLW5Pk7N4hKJyjz55aSoTHj1lVB/pXRzd/nWGr7DZHPRP2y87Hv+/gyscqSa3h8C5Set2nvDQYvAILujo1ZU9EBPSRQAU1PveHOsKI7DUEv/f/X3R843MpH9Hlp2GUyhYkrxUvrTw3Q3QHgUPabJOuKUeheMBPvuAT0NxTR3rTGgXjuEeZFjyrVQH67KYkAsMXZRvhNM7DAVE8A7Kobr9G2IPe1eNiLK4nzBE4eMnW4k9I17W3DwK3AI+Z+jjxlNaqnPhD2UWqoPkBmhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTM7a+rTK4iK4RB118j0Yvi7S9iR30nxZPJCqtVN8Ok=;
 b=TQUcBIcTJh5Dlv+/1M0FY8ugMD0O7DCcbgxtXxBz+wOJh5/BblktGGWzOOdj2ZOJXHMuEfnyQ33U3/R0aLpzHBx8RhXtEjV7vN/kUXCZcrlSLAxcSgs0yy854kamdPiBP3tLic4F0HzsHsAex4pwwBEJvzotCxYCwX3L0k0MCBY=
Received: from SG2PR03MB6261.apcprd03.prod.outlook.com (2603:1096:4:175::12)
 by SI2PR03MB5787.apcprd03.prod.outlook.com (2603:1096:4:152::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Mon, 31 Oct
 2022 06:58:55 +0000
Received: from SG2PR03MB6261.apcprd03.prod.outlook.com
 ([fe80::2023:6096:cfad:9e4]) by SG2PR03MB6261.apcprd03.prod.outlook.com
 ([fe80::2023:6096:cfad:9e4%3]) with mapi id 15.20.5791.017; Mon, 31 Oct 2022
 06:58:55 +0000
From:   =?utf-8?B?TWVuZ3FpIFpoYW5nICjlvKDmoqbnkKYp?= 
        <Mengqi.Zhang@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] mmc: mtk-sd: add Inline Crypto Engine support
Thread-Topic: [PATCH 1/2] mmc: mtk-sd: add Inline Crypto Engine support
Thread-Index: AQHY4jOa8JAJQkyflEOYpQs1p9mmD64T6bKAgBQ+XgA=
Date:   Mon, 31 Oct 2022 06:58:55 +0000
Message-ID: <8b0f9631b06e5ff36b691389285e4168125735ad.camel@mediatek.com>
References: <20221017142007.5408-1-mengqi.zhang@mediatek.com>
         <20221017142007.5408-2-mengqi.zhang@mediatek.com>
         <438bf06d-c4f4-74b2-8903-e89dc52196a7@collabora.com>
In-Reply-To: <438bf06d-c4f4-74b2-8903-e89dc52196a7@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6261:EE_|SI2PR03MB5787:EE_
x-ms-office365-filtering-correlation-id: 3a9a8bf7-7a93-4bb2-ae29-08dabb0d608a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: texM8C9lUosxgjGp6Q8eoZGmLGs2Xz4VBlo/nQ4wbpVemwHkRkM5Za09nQiFGCVORYrpFrFQjJ7TYv00ic/u7ThMyAvROZLfduvm3qSD1iER66oV3Aw1qNRv/jBSVghNjsYu0jb6pjmmtK7rf5Q52LeukaqK7KTeTID72Gk6RlNVR/KbJhHGw95WXJH2vu5N0p7x7KQXM7WB/4V4l47hbq1qKBgr8gacAv4E7WH2ExfCQM+j3aYiVQj5ebQMQXU+My89fsvuYt1hLRvW2Vbgz6pSV17AesXsL3FodpDeOavN+zcB96Z1IzDy93jUMTYvAvE0w86SVPgarU3769p0/RLphvEEmEAJO9oqYWAXlGcNfCBvNmz/Ebb06OjLydw2jkWTLrmrEcIuwHUzy/XokkkvNi/ThFKTZ8dQMNYmS/B1AuMxNy7vqQvbvGlzfinBgKRIomc05mqh0LH01wvMohtG8zJGuac6Ze9aHIh0xRXugiLfUfSHWV6WPOa6SNopI4HMPCR5jlYD8m3Vbp2XcIHPJfHxJF36i0ZPtpoAdLTA5QpNzGLmTyXRx4plFVTFLyYecTQ9GiMc0Vce3w/Bt2s8v7ZP5/3d/3RUySlvNoUpAN2yIhdyB7hL+XyPLDWINgPBlCGoSxZMs6kFlLN9Ft86LbDTqbfSUVWt40yNtMGxJGfja4RhSnnArLkmU7Du5+QDjDMQSf/7JgyWEiV0M4k515fvB+qbo6Hh2ZoZTiOtQtj/gDK2tno0Shpijj5Vr8thteDRfCB2KKnQhrgIovRtMON/uFJKfmALQIeXWB4VwiZAAp0g2OKnNUA4BBdr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6261.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199015)(66899015)(85182001)(83380400001)(36756003)(5660300002)(4744005)(4326008)(4001150100001)(38100700002)(76116006)(2906002)(122000001)(41300700001)(6486002)(64756008)(91956017)(110136005)(316002)(66946007)(71200400001)(66556008)(66446008)(66476007)(8936002)(8676002)(54906003)(7416002)(86362001)(38070700005)(186003)(26005)(2616005)(6506007)(478600001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTJNZkl0MnpWRHkvU1lmdGtEcFlyQmlGZ0RDc3RaMzJPRkRacHZPU3FIMzBV?=
 =?utf-8?B?N3l4L2VNVjlNRzYyU1hSSHhWaThrVHNqYnJodmtlUXpQY3VtdnRRSXU5dWJU?=
 =?utf-8?B?NTFTQlFHVnJKZWQzbHpJV2h2djZBMllvakYvSFB4NkZkQk0xbW5CaGwvMGYr?=
 =?utf-8?B?SDBmT0RFbFFkVk5SaGpIY0M4RS9ZTDNROUxsN0JmL1VGckUxaUlsdWVvNGtK?=
 =?utf-8?B?cEhZTWhHbHJIRC9BRjBvSUk1OVZWQ1FsR0d1dlMwTHN2ZUtFMmtMQzVZeEtB?=
 =?utf-8?B?UXdrUVdkRGlpZG1EMmhxKzlteEFBUW1VVU9xNHdXQk9GU09TRGdvZEFrN0p4?=
 =?utf-8?B?dk9IZ0F6MTczUi9kYThjc2Eva0V6YnVBZnh1VFdXdXFHN0VrM0lLalZML0FF?=
 =?utf-8?B?K21ORWczdnRHOWU2TGExWHVIS2J6ODBVdktGaXlPc28wU0hkZmJJaXdXYjE5?=
 =?utf-8?B?VEtBUmtwRGdYZW5jWmhZZkNKVm5xckxjWDZMeTVYdVlFT0Y2cXNiSDBoQlRi?=
 =?utf-8?B?TFZMblNIcHFVT2RsUWM3MUc5Y0pwSitzZy9aa0lLR3hRZURjQ1BKSnMyN2Fj?=
 =?utf-8?B?WlJGUlpmZmlaQWlGa1JsNWkzdGVMZVdXbWFEVmY0OFoxdUs3dGs1SGxpU0xo?=
 =?utf-8?B?d0pBRnh3cmVweTBtZkVvcE5lRnd3a3dybmhoQjdma2p0Y2JTMk5sZ1NsTUIw?=
 =?utf-8?B?N1IxR0Z3NzFPeDNvdkpoWkpMdkRQa3VtcytiODVvQU8vQU0wM1NMYWQyQU9Y?=
 =?utf-8?B?N0FRbE5GWmF3Y0h4S2NUUllrVHM2Vi9GS1lWN1hKejRoYWN3Nlp6b0VtaGdh?=
 =?utf-8?B?Mk9RUEFIVzVYcnh3dzZQanAyT3VibXJoamRJZHptbzFhaEhxQ3BqMFZ5Tkhu?=
 =?utf-8?B?b29oYjd6eW81VzBpQWtaVjdUK0t4NENuTWFPbWlGSytSV2NsclRCNnluaStF?=
 =?utf-8?B?d0NwRitucmtmSHM2V0tiRG01TnRZcTk1T0J0a09TeDlXYWFsYlhwaEFpbHFR?=
 =?utf-8?B?eUhRWkkyeWdzT0lCODNLUHUraFpqYnNhYzhWRnN1bkloSGNWclRqTU1kcVg3?=
 =?utf-8?B?WUJkaGRINlZLN2U1ZzMzWm9wdmpuN0ZHRS91VCthekJPZHVZUzZRZEJnRW80?=
 =?utf-8?B?QnZGMisxdVdkamdPUVdPMFFsVVVLNWtGU3h1NUFpeW9pRzF0MnFNakM4cDVI?=
 =?utf-8?B?QXdsU05YZ1VSNVhGYXJTdzNLU1ZISHpQNnhRUE91Z3ZFVEFDaTdnKy95dzBU?=
 =?utf-8?B?ekUzckFYVUU5M3FtMEhVZHUyamJ5djVoeEtXcGxacitKZ2JIdHRqOHFXSVRD?=
 =?utf-8?B?bGRpR3JpZ3dtWEtOM2pxTlBOTEV2b0RxTWs1eVlXYmdld2tYWXh1VjZraFY4?=
 =?utf-8?B?cDBGZHBuaTRKQlNGWlFveTkzbzZmaWV0NXNWQUxmb1pQb3VmNC9DYzd5ZWR4?=
 =?utf-8?B?bG9UZy90UUdwdFM2NDJFQ3NQcGdCcUJyNC9oYUlaNVJrZUNvNnlqczdTSDhj?=
 =?utf-8?B?M2ZKallnOUtkRUJ0MUFoTGFWVDh4VGNTTVNQMXhNL1NCa2lxdDRuU0VRZWJV?=
 =?utf-8?B?eFpwYW1WS20wbjV6SDB0aWkzWlhSOWJKZjRnbDVtOXhNMWNFaXExcmQwaVRC?=
 =?utf-8?B?dG5RYXVkM0hidERBY3BjYmNLV2tYQUU5dmNZeXk4eDVLMy9NVG5QM2dzU201?=
 =?utf-8?B?cUx3NmdLM0syOGY3RW1rc2dJLyszdG5TTkxvQW1nc1NTMzJoNkVyczkwMVBL?=
 =?utf-8?B?Q2ZsZlRxNS83NkpVeVc0TUNZWm41b0FCQzVCd0VRSm5idEZDbnJZNDZwNHpE?=
 =?utf-8?B?WmpRUVdTbFA3Q2hDUVBWUGdQeVdwcEFuajhRWU5ySDNBdkR4OVlaaXJ1WnZL?=
 =?utf-8?B?M09nWmlSNHErTHplN3JaUVZRYTFkdkpZcGlMNklDckFNM1NST3paQm9VelR6?=
 =?utf-8?B?b1V1L3N6aGxzcDd2a25ZVzFISHd1WmJMY3d6YVBvdDVVQVVLOGlWNnh0aERB?=
 =?utf-8?B?MlljalIwYytkUHpnRHc2V3gxdFg0VjR4NVBLK2YzSTdoR25TM2lnSE5zUDc4?=
 =?utf-8?B?SFM5T2xYSUpCZDhaMlJVcWpBY3o5VDU5bTlwY2VUZENYVUQydStEQzQ2dlpu?=
 =?utf-8?B?WFRsZW1oQU9TWmtYbGRGaUdSRXRwSk1HamE4aVd1SVNqRTlERnNxdytEZnJt?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDE93F7D2FACD54A89187D391FF77AD0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6261.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9a8bf7-7a93-4bb2-ae29-08dabb0d608a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 06:58:55.4704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwA6X+qRtxvPwHrVGE9kObvS4Chch7IlJsRNrX80N0GQNo55p9/a04YnEmRk3Nvu+VBUKZoAHxttxGzdYeVKv90s0zKsf3YEskum+L+HpDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5787
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTE4IGF0IDExOjUwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTcvMTAvMjIgMTY6MjAsIE1lbmdxaSBaaGFuZyBoYSBzY3JpdHRv
Og0KPiA+IGFkZCBjcnlwdG8gY2xvY2sgY29udHJvbCBhbmQgdW5nYXRlIGl0IGJlZm9yZSBDUUhD
SSBpbml0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1lbmdxaSBaaGFuZyA8bWVuZ3FpLnpo
YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IEhlbGxvIE1lbmdxaSwNCj4gSSdtIGEgYml0IHN1cnBy
aXNlZCB0aGF0IGVuYWJsaW5nIElDRSBvbmx5IHJlcXVpcmVzIGVuYWJsaW5nIGEgY2xvY2sNCj4g
YXMNCj4gb24gZG93bnN0cmVhbSBjb2RlIEkgc2VlIHNvbWUgU01DIGNhbGxzIHRvDQo+IE1US19T
SVBfS0VSTkVMX0hXX0ZERV9NU0RDX0NUTC4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4g
d2h5IFNNQyBjYWxscyBhcmUgbm90IG5lZWRlZCBoZXJlPw0KPiANCj4gVGhhbmtzLA0KPiBBbmdl
bG8NCg0KPiBIaSBBbmdlbG8sDQo+IA0KPiBJbiBzb21lIE1USyBTb0NzLCB3ZSBuZWVkIHNldCBh
IGVuY3J5cHRvIGVuYWJsZSBiaXQNCj4gTVRLX1NJUF9LRVJORUxfSFdfRkRFX01TRENfQ1RMIGlu
IHNlY3VyZSB3b3JsZCwgc28gd2UgdXNlIFNNQyBjYWxsIHRvDQo+IGZpbmlzaCBpdC4NCj4gQnV0
IG5vdCBldmVyeSBNVEsgU29DIG5lZWQgdG8gc2V0IHRoaXMgYml0IGluIHNlY3VyZSB3b3JsZC4g
VGhpcw0KPiBwYXRjaCBpcyBmb3IgdGhlc2UgU29Dcy4NCj4gQXMgZm9yIFNNQyBjYWxsLCB3ZSBo
YXZlbid0IGZvdW5kIGEgcHJvcGVyIHdheSB0byBkZWFsIHdpdGggaXQsIHdlJ2xsDQo+IGRvIGl0
IGxhdGVyLg0KPiANCj4gVGhhbmtzLA0KPiBNZW5ncWkuWmhhbmcNCj4gDQo=
