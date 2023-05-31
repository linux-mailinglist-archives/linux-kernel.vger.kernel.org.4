Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678A4717862
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjEaHgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjEaHgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:36:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B80CE5;
        Wed, 31 May 2023 00:36:46 -0700 (PDT)
X-UUID: e10fbdbeff8511edb20a276fd37b9834-20230531
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Xtpa9OXAEEz1F7Y2dJs4B0fX5tD1rN2sU7I3lrgGu8o=;
        b=Uy5zaA5pQo54JzzmcmxtFfxpjlLy4oFnTV5B1YGQdxndvTMLBEAecN+hHAw9QhOK5OuEINLyhP37iqx/vpiqnunffXMiBTPE0Vw3Lw7V4oPqVDpgePh0Fnkw77DroBOj6gayQ/Hr1t4/onJuq35ZPjX7yP+Qj7SDD8AZTzJ5yBc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:bccca52c-0acb-4063-bbe1-51a7802c1144,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.25,REQID:bccca52c-0acb-4063-bbe1-51a7802c1144,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:d5b0ae3,CLOUDID:73388f6d-2f20-4998-991c-3b78627e4938,B
        ulkID:230531153321YT1RRT9C,BulkQuantity:6,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: e10fbdbeff8511edb20a276fd37b9834-20230531
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 453818833; Wed, 31 May 2023 15:36:38 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 May 2023 15:36:37 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 May 2023 15:36:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOdQ5rRtmo7pMhG+bDGsCYMMfvONWfrpmlPAI2ir/8VeAiLfzY1j571VdFh/yCDTc9Onivxgp+MsNzBUqqZDETzKz5qXHVTRRlqBHmDRiFuhJBE81uprRzZOKZTxvD2qHJcG8muA8MORChpu1RzcnrxPwulgiq1SCC8aevOx9chBruoahjqhUDPIbMoF71QHvvvNnx+k8f+vk0qywV0IiF7brcZv3nQEE5ubDaGQAhHSGwP41mXKi38EIG4xNZQmrmm5GF1xkiLO5a6pH4ySjTNATtfUZjIg+rq7ZjslYhVoURTnPOgcoyt2glJ6tSeAaIxugf9Qa3G3cwYYWKOnrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xtpa9OXAEEz1F7Y2dJs4B0fX5tD1rN2sU7I3lrgGu8o=;
 b=fn16tyuL7ZOPQmGOmHy3mAlhL/cNI42uHFlMjLwA7BHpc56hyDcOyHKcyxBqt/nMHesw84l1S8YU13fc3+3b8+coLtJ+3KMrQiUVEFzqUulSKw8VR448QhkyiZ2rAaHBuJFgmEfTYAeeoTRBaZmeQzqh7ntia1KtM9MQOvWueANllDassfp4qgyNX3vVq9xa8ctBU17TyN1qaich6seyHOZmQO7LgJ9p47NT3//6tIRN9f2iDzcOp3alxQO+OvYNJrgOUer9UYFfrh8NkvTJR1SvQCd2w/3YfoqH1gMQ71hRLP67QKeeAa8Rh/69IchOf71rWsaV4P09+II/Q9Gydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtpa9OXAEEz1F7Y2dJs4B0fX5tD1rN2sU7I3lrgGu8o=;
 b=tbZR+yBNSIUbn/y5aIegWSJyiv/sJFj8/IIaFg8wyiP655lnWQvW9VNPIPRb2XoZMCfs9y6pNoKV7z6dbxZ6HxXDnQyfqLXdjOQ4slL/dqpEj7mdIr8ChZ7MX0IKdoBfSaDASiy9lQMPE6D9w6XtDoDUWtjj+8OtO50SayXiW/c=
Received: from KL1PR03MB6285.apcprd03.prod.outlook.com (2603:1096:820:a4::10)
 by TY0PR03MB6773.apcprd03.prod.outlook.com (2603:1096:400:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 07:36:33 +0000
Received: from KL1PR03MB6285.apcprd03.prod.outlook.com
 ([fe80::5c8d:a40e:1569:2d14]) by KL1PR03MB6285.apcprd03.prod.outlook.com
 ([fe80::5c8d:a40e:1569:2d14%9]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 07:36:33 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH v2] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZguL8DXJ4wwqPNE+3vDjAEU6xMa9fzDYAgBRRdwCAAAHKAA==
Date:   Wed, 31 May 2023 07:36:33 +0000
Message-ID: <98a13576b874fb5dca6c9c2cdc298cb71fd3c2c4.camel@mediatek.com>
References: <20230510015851.11830-1-wenbin.mei@mediatek.com>
         <0df3968e-da34-b36c-4cb4-92d66508a46a@collabora.com>
         <e682b8b66261a71601707a4e74af2829f86800dc.camel@mediatek.com>
In-Reply-To: <e682b8b66261a71601707a4e74af2829f86800dc.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6285:EE_|TY0PR03MB6773:EE_
x-ms-office365-filtering-correlation-id: a25a92d8-659e-4cd9-2374-08db61a9c1ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7VoX8OLY2uvQcj77+z2vZAgO1U7arGKmMv7D7s5ZxpavLYs79nCHzR9j3DYLGvZcSO1mu4bBge45zjjF8sNbh6T+f0/bE9mm9jonvElLpMeAxQO2NZu3U9qedeEfa3fgj6gUD4cdsGGQGhCTcVd3a7k79f7VJOyAsoUur/T6p6QqtCQUiNvAAPlMTTjwys5/D01omWcfGLmL5YEiZ6QCmfJiPmKaikRkV8y39YniexaewwNTCB+nGRMaEJabS1zqt4LLtR4yqbNqtVyfRG9l2JOfyvLBwkwQrKwOCeRZVA5wB8wYzNx3lbvqgYGDIMD+GfK2Re6FCT/On6HlN8UQRd2nW5fODKnm/RWTs1A5x5yk7wDTNlzX4EZrnqqJ0Ji2zzbrrCNVZj8MspwnjG5/z1iYLYPNpCb2ZjaFgRKBEglV3sNm0OHaOMF5Zr41lNYkDrXhnyX8o91PqYIhlcw1jdW4ca6hl6WR2QEuAC8uWLqiGLvFabqlCS39+INxXWmbH/B/parb5zAj/j0AbWj6P85vrNSWO97EMY2mWAr8cAH3jWGZqHXSSpUS+1Pm+42t9OdFShSZKhR+OCi+gKje2vsTrXzR5KlqgTBZrPXso8lkpIMd15zXwr+O4XELPBdC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6285.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(122000001)(38100700002)(41300700001)(316002)(38070700005)(6512007)(4326008)(71200400001)(86362001)(2906002)(8936002)(6486002)(8676002)(2616005)(107886003)(91956017)(76116006)(66946007)(66476007)(66556008)(64756008)(36756003)(66446008)(110136005)(54906003)(6506007)(26005)(85182001)(83380400001)(478600001)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWxvNkRRRzExZkE5VjNmNmJlc0lLZyt4UWF6ZFloRXBQYUdWMUx3QjB6czM2?=
 =?utf-8?B?S0NpVE5tWlhhblNTMmEydEg5L3d1b0lIa3h4ejR3T3pIbXJZbGdNOWxER0Ir?=
 =?utf-8?B?YWp0S2ZzK0xMNStGT0ptZHE0ekV1cE1TN25oZmZkaytRdzBCeG1QbGZaUk9R?=
 =?utf-8?B?ZG9VaDhicitFY3diVFoxM0NMK1NnMER3ZEk3V3phL0VGRWNLNUJVZWk2WjBH?=
 =?utf-8?B?Q1A1N2hDRjJNZDdOeTZFSUdkNXBoRW9NWHhobXBpZ1BQQlhCUEQ5Vy81ck9I?=
 =?utf-8?B?ZElObFNWM1FWSVJhaGt0SDdibm00dExMU2lwVDIybUpRMW5hSXluVjZLYlRN?=
 =?utf-8?B?REdJTlRXangrb2g3MS85K3RyMnZ0N2pjTzUwODUycGVCMm5aSWl1Y0FlcDBl?=
 =?utf-8?B?MDRLMFZCMm90MVYwZi9oZzIzK3ZURFBEWklsbkhwOTZJeDRFUXJOZUp3cHJL?=
 =?utf-8?B?amlEZlU4Rk0zaTVuV2JWSERLeDFMK1RlREp2bFQ5NlV5OWk2WGFsZWZlWEdO?=
 =?utf-8?B?cm9tRS9Pa3Q2dDRuTlNyb3VJZHRmc0txMlVxMWtncTE2eVdaY3Q1TEJjUWda?=
 =?utf-8?B?ZERLNnFscUI5eHVsOGRTSXcyOEZoKzliNUdHclMwS2N4SWkvZnpoLytXWDJx?=
 =?utf-8?B?c054ek9IUEkyQVhkMWJFWnNMRng4enN6Zi81Z21EbkszcXJDSDZZOFBDbDZX?=
 =?utf-8?B?eksrN2pzRm1lUGYrTGVJR2ZabG5VRnJCMmVLWG9zc2hjcHpqOFNVN2IrM3ZI?=
 =?utf-8?B?R1RDV1d2QlUwRUQyWmJleTRBME9kMUNjaEU5Zko5OG1XRnAxMVhJUHVLYkxm?=
 =?utf-8?B?M2ZRMGo1UzU4RWtQK1VoaW1Tayt6N1BzMU50UkxPNk5RNU9UNEU4c3JHUEVh?=
 =?utf-8?B?REx6RUh3OXJMQ0Fwc0VXYlVzN2laRlFRTnBqbSsyd0ozRVNHeTBndDAyRlBT?=
 =?utf-8?B?dExpQWM4L2FLNWVxTUIzN3hTdDJGMDdoUUZhbEZ6RTEybVpjTHlMYkREODJy?=
 =?utf-8?B?YWEvZDRoci9HNXU2TjEwaTZrOVphc1Z3aU9pWFNjVTRxZUNLd2djS1ByNmt4?=
 =?utf-8?B?dldDYk91bjlDazRFaGtpb2pJRkZyMW9uaS9YNlhTazRFNkNGOWFwWHRDbFBE?=
 =?utf-8?B?M2V5UWpoWnNKeEdlWTRrenBMOHRhZGJ1MXNYVTdrQ0Z2UVlaRjcyeHRNRGZM?=
 =?utf-8?B?b3I4RTBjTm9hKzR2dHN1ZkNzbHdwV1A2SnVwK09ENVJvQnVML2xFWElQZCtE?=
 =?utf-8?B?YkQ2aEdGNlF1WHFmZENrYWhya2NBUHczbzFBbVptMjFpWE5wdUN4UXd6YmMy?=
 =?utf-8?B?Znd0NTBFdkd5cU1IT3gybHVRSnF1OEFNYkJHdHpDcFZjcURxbTF4TlZoWEQz?=
 =?utf-8?B?djh0bXk3Z0tMWTRVbzdRSEVZSDZQOTQ4NlVOVHF4bVR2VmRrS2RCSmNmSktM?=
 =?utf-8?B?ZloxWmRKZlgwdThGMnNZS0d6RnlIR1NRRFJGcEI1a3pFNWhWN3RMang5NW5P?=
 =?utf-8?B?WFFzOWNSQjRKTTEyTFZDb3lobDJMUTV1Z3lJUXJaVE14UFB1NjZiR2ZqWnpy?=
 =?utf-8?B?empKZ3hPZmUwRkpNRm1jeVZleWNxWXYvbjhHVisrSFdTaGFkNUJkS2V2S2l5?=
 =?utf-8?B?QmN1Wk1LMHBoQUt0STNBWWpObXlSV1hwbytySnFBaFl1eGo0VWlQeFFvMWpy?=
 =?utf-8?B?NHErWW9wZ2YzQm1tSGE5QTQvYWN2Zkxwb0NscnJJa3lDcDY1czdtTVo0dm9o?=
 =?utf-8?B?MUEveXBNNXVQOFpiZGpRV2pLSjZXdGNiYnBvZXNpanUwWWk0dTdieGFxSENz?=
 =?utf-8?B?Mzl5YkJ1a2w2eXE4QWpYbkh1dk5kOEtsTDdtS1RIYnBYUXY0MEpob05vVUQz?=
 =?utf-8?B?cU02VU1vbUJvZmZ2UGhxSURtOFVseEp1QndRbnp2OTNuTG1lN1NRQVkydlRN?=
 =?utf-8?B?NmM2c3V0ZXBSNFRBWVBFY2ZEZjJ2eVpzNTVFb3JDUlJoS3A4OHBVRE12TnMz?=
 =?utf-8?B?WStjTmVjNmtSeXFQdmdURWpQcmNQRnhrVVR0YUVwM01iUTcydE8wN3hCM0pq?=
 =?utf-8?B?KzBlZENkYVlFY092YzMwRkFtUURLdGFTTUppQUJnM0d4S2diaG1IWUhmZlFP?=
 =?utf-8?B?OHdnOCtpR3FNVW1yU0hHaGZaaTlRYzVkMVVBMndhcmRHbE5idG9LbGkzQ3Rs?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE4986928C75C14F846F4DEFFECD5086@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6285.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25a92d8-659e-4cd9-2374-08db61a9c1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 07:36:33.3490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qi+KemcTeC5IkH6l5/0xEYTjncV3NsJVQhO2gQtKgxRjM4Wuhzi6v6CsFgCdAv9pU+BDnYxgJyIq5tZgXIG9wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6773
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTMxIGF0IDA3OjMyICswMDAwLCBXZW5iaW4gTWVpICjmooXmloflvawp
IHdyb3RlOg0KPiBPbiBUaHUsIDIwMjMtMDUtMTggYXQgMTE6MTMgKzAyMDAsIEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gdW50aWwNCj4gPiB5b3UgaGF2
ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+IA0KPiA+IA0KPiA+IEls
IDEwLzA1LzIzIDAzOjU4LCBXZW5iaW4gTWVpIGhhIHNjcml0dG86DQo+ID4gPiBDUUhDSV9TU0Mx
IGluZGljYXRlcyB0byBDUUUgdGhlIHBvbGxpbmcgcGVyaW9kIHRvIHVzZSB3aGVuIHVzaW5nDQo+
ID4gPiBwZXJpb2RpYw0KPiA+ID4gU0VORF9RVUVVRV9TVEFUVVMoQ01EMTMpIHBvbGxpbmcuDQo+
ID4gPiBUaGUgZGVmYXVsdCB2YWx1ZSAweDEwMDAgdGhhdCBjb3JyZXNwb25kcyB0byAxNTB1cywg
bGV0J3MNCj4gPiA+IGRlY3JlYXNlDQo+ID4gPiBpdCB0bw0KPiA+IA0KPiA+IFRoZSBkZWZhdWx0
IHZhbHVlIDB4MTAwMCAoNDA5NikgY29ycmVzcG9uZHMgdG8gNDA5NiAqIDUyLjA4dVMgPQ0KPiA+
IDIzMS4zM3VTDQo+ID4gLi4uc28gdGhlIGRlZmF1bHQgaXMgbm90IDE1MHVTLg0KPiA+IA0KPiA+
IElmIEknbSB3cm9uZywgdGhpcyBtZWFucyB0aGF0IHRoZSBDUUNBUCBmaWVsZCBpcyBub3QgMCwg
d2hpY2ggd291bGQNCj4gPiBtZWFuDQo+ID4gdGhhdCB0aGUgZXhwZWN0ZWQgM3VTIHdvdWxkIGJl
IHdyb25nLg0KPiA+IA0KPiA+IEFsc28sIHNpbmNlIHRoZSBjYWxjdWxhdGlvbiBjYW4gYmUgZG9u
ZSBkeW5hbWljYWxseSwgdGhpcyBpcyB3aGF0DQo+ID4gd2UNCj4gPiBzaG91bGQNCj4gPiBhY3R1
YWxseSBkbyBpbiB0aGUgZHJpdmVyLCBhcyB0aGlzIGdpdmVzIGluZm9ybWF0aW9uIHRvIHRoZSBu
ZXh0DQo+ID4gZW5naW5lZXINCj4gPiBjaGVja2luZyB0aGlzIHBpZWNlIG9mIGNvZGUuDQo+ID4g
DQo+ID4gQXBhcnQgZnJvbSB0aGlzLCBieSBqdXN0IHdyaXRpbmcgMHg0MCB0byB0aGUgQ1FIQ0lf
U1NDMSByZWdpc3RlciwNCj4gPiB5b3UNCj4gPiBhcmUNCj4gPiBhc3N1bWluZyB0aGF0IHRoZSBD
UUNBUCB2YWx1ZSByZXF1aXJlbWVudCBpcyBmdWxsZmlsbGVkLCBidXQgeW91DQo+ID4gY2Fubm90
DQo+ID4gYXNzdW1lIHRoYXQgdGhlIGJvb3Rsb2FkZXIgaGFzIHNldCB0aGUgQ1FDQVAncyBJVENG
VkFMIGFuZCBJVENGTVVMDQo+ID4gZmllbGRzDQo+ID4gYXMgeW91IGV4cGVjdCBvbiBhbGwgcGxh
dGZvcm1zOiB0aGlzIG1lYW5zIHRoYXQgaW1wbGVtZW50aW5nIHRoaXMNCj4gPiB0YWtlcw0KPiA+
IGEgbGl0dGxlIG1vcmUgZWZmb3J0Lg0KPiA+IA0KPiA+IFlvdSBoYXZlIHR3byB3YXlzIHRvIGlt
cGxlbWVudCB0aGlzOg0KPiA+ICAgKioqIEZpcnN0ICoqKg0KPiA+ICAgMS4gUmVhZCBJVENGTVVM
IGFuZCBJVENGVkFMLCB0aGVuOg0KPiA+ICAgICAgdGNsa19tdWwgPSBpdGNmbXVsX3RvX21oeihJ
VENGTVVMKTsgLyogcHNldWRvIGZ1bmN0aW9uDQo+ID4gaW50ZXJwcmV0cyByZWcgdmFsdWUqLw0K
PiA+ICAgICAgdGNsayA9IElUQ0ZWQUwgKiB0Y2xrX211bDsNCj4gPiANCj4gPiAgIDIuIFNldCBT
U0MxIHNvIHRoYXQgd2UgZ2V0IDNuUzoNCj4gPiAgICAgICNkZWZpbmUgQ1FIQ0lfU1NDMV9DSVQg
R0VOTUFTSygxNSwgMCkNCj4gPiAgICAgIHBvbGxfdGltZSA9IGNpdF90aW1lX25zX3RvX3JlZ3Zh
bCgzKTsNCj4gPiAgICAgIHNzY2l0ID0gRklFTERfUFJFUChDUUhDSV9TU0MxX0NJVCwgcG9sbF90
aW1lKQ0KPiA+ICAgICAgY3FoY2lfd3JpdGVsKCAuLi4gKQ0KPiA+IA0KPiA+ICAgKioqIFNlY29u
ZCAqKg0KPiA+IA0KPiA+ICAgMS4gUHJlLXNldCBJVENGTVVMIGFuZCBJVENGVkFMIHRvDQo+ID4g
ICAgICBJVENGVkFMID0gMTkyIChkZWNpbWFsKQ0KPiA+ICAgICAgSVRDRk1VTCA9IDIgKHdoZXJl
IDIgPT0gMC4xTUh6KQ0KPiA+IA0KPiA+ICAgMi4gU2V0IFNTQzEgc28gdGhhdCB3ZSBnZXQgM25T
Og0KPiA+ICAgICAgI2RlZmluZSBDUUhDSV9TU0MxX0NJVCBHRU5NQVNLKDE1LCAwKQ0KPiA+ICAg
ICAgcG9sbF90aW1lID0gY2l0X3RpbWVfbnNfdG9fcmVndmFsKDMpOw0KPiA+ICAgICAgc3NjaXQg
PSBGSUVMRF9QUkVQKENRSENJX1NTQzFfQ0lULCBwb2xsX3RpbWUpDQo+ID4gICAgICBjcWhjaV93
cml0ZWwoIC4uLiApDQo+ID4gDQo+ID4gSSB3b3VsZCBpbXBsZW1lbnQgdGhlIGZpcnN0IHdheSwg
YXMgaXQgcGF2ZXMgdGhlIHdheSB0byBleHRlbmQgdGhpcw0KPiA+IHRvIGRpZmZlcmVudA0KPiA+
IHRjbGsgdmFsdWVzIGlmIG5lZWRlZCBpbiB0aGUgZnV0dXJlLg0KPiA+IA0KPiA+IFJlZ2FyZHMs
DQo+ID4gQW5nZWxvDQo+IA0KPiBIaSBBbmdlbG8sDQo+IA0KPiBTb3JyeSBmb3IgbGF0ZWx5IHJl
cGx5Lg0KPiANCj4gRm9yIE1lZGlhdGVrIG1tYyBob3N0IElQLCBJVENGTVVMIGlzIDB4MigweDFN
SHopLCBJVFZGVkFMIHJlcG9ydHMgDQp1cGRhdGU6IElUQ0ZNVUwgaXMgMHgyKDB4MU1IeikgLT4g
SVRDRk1VTCBpcyAweDIoMC4xTUh6KQ0KPiAxODIsDQo+IGFuZCB0aGVzZSBmaWVsZHMgYXJlIHRo
ZSBzYW1lIGFuZCBhcmUgcmVhZG9ubHkgZm9yIGFsbCBJQywgYnV0IHNpbmNlDQo+IE1lZGlhdGVr
IENRRSB1c2VzIG1zZGNfaGNsaygyNzNNSHopLCBDTUQxMydpbnRlcnZhbCBjYWxjdWxhdGlvbg0K
PiBkcml2ZXINCj4gc2hvdWxkIHVzZSAyNzNNSHogdG8gZ2V0IHRoZSBhY3R1YWwgdGltZSwgc28g
dGhlIGFjdHVhbCBjbG9jayBpcw0KPiAyNy4zTUh6Lg0KPiANCj4gSWYgQ0lUIGlzIDB4MTAwMCBi
eSBkZWZhdWx0LCBDTUQgaWRsZSB0aW1lOiAweDEwMDAgKiAxIC8gMjcuM01IeiA9DQo+IGFyb3Vu
ZCAxNTB1cy4NCj4gDQo+IEluIGFkZGl0aW9uIHRoZSBib290bG9hZGVyIHdpbGwgbm90IHNldCB0
aGUgQ1FDQVAncyBJVENGVkFMIGFuZA0KPiBJVENGTVVMDQo+IGZpZWxkcywgYmVjYXVzZSB0aGVz
ZSBmaWVsZHMgb2YgQ1FDQVAgcmVnaXN0ZXIgaXMgUk8ocmVhZG9ubHkpLCBzbyB3ZQ0KPiBjYW4g
aWdub3JlIHRoZSBjaGFuZ2UgZm9yIHRoZSBDUUNBUCdzIElUQ0ZWQUwgYW5kIElUQ0ZNVUwgZmll
bGRzLg0KPiANCj4gVGhhbmtzDQo+IFdlbmJpbg0KPiA+IA0KPiA+ID4gMHg0MCB0aGF0IGNvcnJl
c3BvbmRzIHRvIDN1cywgd2hpY2ggY2FuIGltcHJvdmUgdGhlIHBlcmZvcm1hbmNlDQo+ID4gPiBv
Zg0KPiA+ID4gc29tZQ0KPiA+ID4gZU1NQyBkZXZpY2VzLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBXZW5iaW4gTWVpIDx3ZW5iaW4ubWVpQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0K
PiA+ID4gICBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgNCArKysrDQo+ID4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgYi9kcml2ZXJzL21tYy9ob3N0L210ay0NCj4gPiA+IHNk
LmMNCj4gPiA+IGluZGV4IGVkYWRlMGU1NGEwYy4uZmZlY2NkZGNkMDI4IDEwMDY0NA0KPiA+ID4g
LS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9tbWMv
aG9zdC9tdGstc2QuYw0KPiA+ID4gQEAgLTI0NTMsNiArMjQ1Myw3IEBAIHN0YXRpYyB2b2lkDQo+
ID4gPiBtc2RjX2hzNDAwX2VuaGFuY2VkX3N0cm9iZShzdHJ1Y3QNCj4gPiA+IG1tY19ob3N0ICpt
bWMsDQo+ID4gPiAgIHN0YXRpYyB2b2lkIG1zZGNfY3FlX2VuYWJsZShzdHJ1Y3QgbW1jX2hvc3Qg
Km1tYykNCj4gPiA+ICAgew0KPiA+ID4gICAgICAgc3RydWN0IG1zZGNfaG9zdCAqaG9zdCA9IG1t
Y19wcml2KG1tYyk7DQo+ID4gPiArICAgICBzdHJ1Y3QgY3FoY2lfaG9zdCAqY3FfaG9zdCA9IG1t
Yy0+Y3FlX3ByaXZhdGU7DQo+ID4gPiANCj4gPiA+ICAgICAgIC8qIGVuYWJsZSBjbWRxIGlycSAq
Lw0KPiA+ID4gICAgICAgd3JpdGVsKE1TRENfSU5UX0NNRFEsIGhvc3QtPmJhc2UgKyBNU0RDX0lO
VEVOKTsNCj4gPiA+IEBAIC0yNDYyLDYgKzI0NjMsOSBAQCBzdGF0aWMgdm9pZCBtc2RjX2NxZV9l
bmFibGUoc3RydWN0IG1tY19ob3N0DQo+ID4gPiAqbW1jKQ0KPiA+ID4gICAgICAgbXNkY19zZXRf
YnVzeV90aW1lb3V0KGhvc3QsIDIwICogMTAwMDAwMDAwMFVMTCwgMCk7DQo+ID4gPiAgICAgICAv
KiBkZWZhdWx0IHJlYWQgZGF0YSB0aW1lb3V0IDFzICovDQo+ID4gPiAgICAgICBtc2RjX3NldF90
aW1lb3V0KGhvc3QsIDEwMDAwMDAwMDBVTEwsIDApOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgLyog
ZGVjcmVhc2UgdGhlIHNlbmQgc3RhdHVzIGNvbW1hbmQgaWRsZSB0aW1lciB0byAzdXMgKi8NCj4g
PiA+ICsgICAgIGNxaGNpX3dyaXRlbChjcV9ob3N0LCAweDQwLCBDUUhDSV9TU0MxKTsNCj4gPiA+
ICAgfQ0KPiA+ID4gDQo+ID4gPiAgIHN0YXRpYyB2b2lkIG1zZGNfY3FlX2Rpc2FibGUoc3RydWN0
IG1tY19ob3N0ICptbWMsIGJvb2wNCj4gPiA+IHJlY292ZXJ5KQ0KPiA+IA0KPiA+IA0K
