Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEDA7105A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 08:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbjEYGWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 02:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjEYGWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 02:22:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDBE187;
        Wed, 24 May 2023 23:22:36 -0700 (PDT)
X-UUID: 86f24998fac411edb20a276fd37b9834-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QRtbN9adNQKhqaekzbKv7kU34ilIIt4yyQu3wK/XFio=;
        b=TM2oJvjTet/rINvJ+Of4ZbCyb+O1YQs6yBcaHwTlchrwzm6X5y/5O3LtK1jR8TvKQc+XZnM/W/eG6wSKV+dDD9cm6ADSCMlEmF2bLUgkOa0dQ/zZM+yPiSAd/WH1I8upG2IAsM5SNRHmSaVUShCXYSPy5P6dSA9TXvrnpnOQerA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:e9c9890c-adb7-49be-9009-19cc034b8e44,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.25,REQID:e9c9890c-adb7-49be-9009-19cc034b8e44,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:d5b0ae3,CLOUDID:531e4f3c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230525142231SLYOJ6IY,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 86f24998fac411edb20a276fd37b9834-20230525
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 95800347; Thu, 25 May 2023 14:22:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 14:22:29 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 14:22:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k467jZi1r3jDA2wztU4WGKX69B94Rsk4EDadwePVVFr13hVwWFCyYHRaSPo5q688B6x01WcC95mfCfTCVA59HuE4wVF53QvMEXgN7XocGBMB8IfjDCGiMG+H6H2IDtMjKWUBABLTfH2S3X2NX46JBry5hmSvgR/bLQzh81kquUbHeIbGr1Ek+5kiXYCy33cO00LS635wP+OjJhp7mEqIL8Ymx607dhkO7UbJRk1R3GFkn9QIm5AHJ1iiGSPInweoets+6w37YbtfHKatX6Zim6rY++zt7/qxwv+qOoEHcFUvbKcFqa5romeUl2GuCMO31KLCw5HkV3WpcTc6YlJtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRtbN9adNQKhqaekzbKv7kU34ilIIt4yyQu3wK/XFio=;
 b=UZrmV3UBcBXh9slCHrsCRMZLz9qrETp1no91nlpWFBUsoMWqS0ishBGXuScpC2EdXkapbDIeORJmwONtLQKRdpVZ8NQbhWAb4nquJZiImW38WJqH5Mt5Ol8Lky8b1kYCMgmX76DoU3oYuY8Bk5G+wcbsE3lcG+4F4+Z6ha5YTg50RjUHKaA8m1mCK3FR6qo2G5TCTVWg+DBArDDXItDFdfxveIlgKa6OrkD6J16b9QmX8RrqV5QLREUHHSMY0v7+m1kd0PcvS+iFYZS3aLVUTubOSdPLLqVtsbnYSOaWX6XKcSPzHUim/nrVIlTrHbWu2idGiIA/tl9zNxSPrSSHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRtbN9adNQKhqaekzbKv7kU34ilIIt4yyQu3wK/XFio=;
 b=rIHw21JseiOiOWCqnXW7hAP7IDwCP6qTHeTTxipGseNl0CQLvbqaLcuGDJhxenFGYcBgRWBzsl0sskF6+gtDxd8We20oDeu40vJmxnNMF9ppHul7sUpvAymRyhHOzL3OHJOZT5v7gbyzXGKBl84KdCFYNiKvnG6H6pbOjxg0c2E=
Received: from SEYPR03MB6723.apcprd03.prod.outlook.com (2603:1096:101:69::5)
 by TY0PR03MB6799.apcprd03.prod.outlook.com (2603:1096:400:219::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 06:21:26 +0000
Received: from SEYPR03MB6723.apcprd03.prod.outlook.com
 ([fe80::40d1:e5cb:f331:fe3a]) by SEYPR03MB6723.apcprd03.prod.outlook.com
 ([fe80::40d1:e5cb:f331:fe3a%7]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 06:21:26 +0000
From:   =?utf-8?B?UWlpIFdhbmcgKOeOi+eQqik=?= <Qii.Wang@mediatek.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGVpbGsgTGl1ICjliJjno4op?= <Leilk.Liu@mediatek.com>,
        =?utf-8?B?VGltIEt1byAo6YOt5bu356yZKQ==?= <Tim.Kuo@mediatek.com>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] spi: mediatek: advertise the availability of Dual and
 Quad mode
Thread-Topic: [PATCH] spi: mediatek: advertise the availability of Dual and
 Quad mode
Thread-Index: AQHZjWle6tKZPgsuxUynqm5ryw8jba9nufOAgALNfYA=
Date:   Thu, 25 May 2023 06:21:26 +0000
Message-ID: <7a99a7da9edc93f4e231500b1b781188f894d775.camel@mediatek.com>
References: <20230523112608.10298-1-qii.wang@mediatek.com>
         <97af2a29-8aef-499d-9f07-bb262ec398cb@sirena.org.uk>
In-Reply-To: <97af2a29-8aef-499d-9f07-bb262ec398cb@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6723:EE_|TY0PR03MB6799:EE_
x-ms-office365-filtering-correlation-id: 2abcb41b-85af-4ba3-2787-08db5ce8450d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: URPKoLOuOzAoRESwGJN9PqO5wWB4IAvRDBCZ5Q7NrnKOolPIcTqZKSWD3Wge/RyPrd/9ts/5sBsbJRfueAd6rhDGJtgWQ7jiRtMTQzc9f6ai30lvpVkY+ZjFE4bnM5Jz8/gpeVo+Cdwtvw4qlODSPxLHvHR9/qvZqtRgFPhSlj+Nnhdn/83SSb481Q2jLIeKE1QdPvWChC8xyZdTv59exbpkwhpdLywvpyRSoz+8XoErKeu3e1lYPkFcum4Gn3Uk1BwuHoN9GA+eTZ8V4hEeavl6udbQhulqUFqpTD/nx5fbDKJpnrb1SlLjYoKU6fq+DyezlR/UUG3Py//yQT9TKRNNeE0k3dKQYzQ2dXnApUwTT2v8tawARAvu7a7ueK4ybLD85MVgoQP9em8lcp58gUObSiBWPAe45nJDgrQ3BaHLgkvoLdFO9Ri8+vq4dffO6nNY2GdaGrP0tiI3xm7AbIgZmY/LdsfpxVf6id7/HMDf20sEoN4saKCdZ6fTEW6TNOkXCxvT14mcE3aLsNypNCrKXRNwjmPZbPJkvVA91ouDKi6OA4b7uTklL8Fys4DKCXyZEBzlPT8hNqn/mx4Jx3BKoOKamQetErHIPgLXUZ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6723.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(71200400001)(6486002)(41300700001)(26005)(6512007)(6506007)(8936002)(8676002)(85182001)(38100700002)(36756003)(5660300002)(2616005)(83380400001)(38070700005)(2906002)(4744005)(186003)(86362001)(966005)(122000001)(6916009)(4326008)(91956017)(64756008)(66946007)(66446008)(76116006)(66476007)(66556008)(54906003)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?My92alVqSXU3ZGtZS1BtbHZ2Y3dFNHVCRmp2cUpKS09oNkY0aDVKQXZ1bFpB?=
 =?utf-8?B?bDhIUW1KK3A3L1FhT2pSc3VZV1d4aGFTTE5PZnZTR3BLUjNBczF3cXhOeEw3?=
 =?utf-8?B?WU5IMm5KTUtua0s1VFJKVkNQMG1xYWhEZ0Z2MzZXdlVsOEI5QzNvMFdPamJ1?=
 =?utf-8?B?OXRmc3F2eGhZRzZ0dnY4MVpHbGlXT0VlS2p4NkZuelQ3TXQzQmszZndtbEZ3?=
 =?utf-8?B?dDBPcTNhVkRGall1MXFEcVpjeVlMZlA5NHpEbllGNE1YK0xzbm55YkQwaWRp?=
 =?utf-8?B?VFNwOFZ0WEJpdmliUDg3eTBpMWFBaExGRHZqZmU4TEpVZENURWlsZEIzZDhw?=
 =?utf-8?B?Vll6V3d5TW1QL3dreVNkeFdpa1V2bEhHNk01RXJRajBzL0Fsd084WkFlaEcy?=
 =?utf-8?B?dGFTekdEVUlnVkN3eGphYUZtaVRIbFE5NnR5SXRaS2w3SUxVbzVTU1JWSm91?=
 =?utf-8?B?ZXNLQ0NtMFhFMkJ4MmR3UXpmOXlYckR6V0N5cVVzQ2RFQWZYcVBVZ29BeDdW?=
 =?utf-8?B?TGoza2lOWHoyRTdmbzl1OFRvUU9ldkl4ZWZuZjM3MHRkM3F1WDZ4b0wrdmp4?=
 =?utf-8?B?VDhuVFBLNy9ucVh2eWN0bFVnUG1aMHJ1NisrTWtuM1EwWXJOMDBqdnpXMFJM?=
 =?utf-8?B?djllZWtlcmVxYjBDYys5cGRTeDRIckRMVTFwV1hFYVUyUld0WWd4Smd1S2lw?=
 =?utf-8?B?VXA3Zk5JQXhjWE5qRVRVVFkvdUJNZHo3UmkwNWpIMlJFMkFsN1NEOVBLektG?=
 =?utf-8?B?aTh3Z0U0OWlhenQ3ME9ycjRTQ3hBcE1BTGRNcEFoM1RzSXhuR3M3VEpwMkpH?=
 =?utf-8?B?MWlpeWV0NVBZUElCWXNNa2R1ZVhCT0NUM1RYWTZyRXBIQVY1VVRidEt5V1hO?=
 =?utf-8?B?ZVpQekhxNHlMOHFleVJrd05zMytjcnJ2bVo1YUVEb1RKaGw2eXRDVDRzbnVV?=
 =?utf-8?B?cVVrYXBEc3RFRTZRRkhVZFZncWpwZ01nNVpVMXJjT2d3MTBpdGVsUWdTbThj?=
 =?utf-8?B?UWZKNk9zb0VhOEU5VHN2Ry9aaVJSSHF6QWUzZlAxVmdyekIwMmgvOUE2d0tO?=
 =?utf-8?B?YVZDcFJJMUxDbHJtU1IyaVc2NFVsUE1ma2pBWHJHYVJWVHVlQmJCZVdnbEE2?=
 =?utf-8?B?Ymo0enVacDd5SXJzY2E0d3hSL0JOMjdSdUQ3ZjZYL0RzQ3dIcGpZSHRwTjU0?=
 =?utf-8?B?b0dSc1hFUHRldkRRWi9na3FyZGdhaHZDNG9PME1kWnJsa0RIa2NpM3liN25t?=
 =?utf-8?B?aGFrL01ZbGQySUFFaWRFaEE4Y3hCV3lWLzJyQy9XZnVEc25mZHByWnhJQnd2?=
 =?utf-8?B?YzdNT3kyeElzTVhWcXFNWXNqSWhicy9XWGFBdDV0YklMQWVGWFJyOTc5MFlx?=
 =?utf-8?B?OFpvNGZwNUh4dnM3UW95cUl1OUZQQitSZlB2QzZPdC9VNUlrQ3E4dDZkczFU?=
 =?utf-8?B?a2lnT042ZFVhcVpycVBhZGRNR2VXU1dYTE1KZG5aS3B1VTBCTzZrQ3ZTanJn?=
 =?utf-8?B?UHZEWkV2U09Oak5oZFJsdU54RHNJZWFOVXFpMUJkajQrVzViVUZiMG44Um5h?=
 =?utf-8?B?SUdKU1QzY1EvV2gyUlVoVmJOdHVaN3crcTR1QTF2TzNhTHhCbFQwcllkOGJK?=
 =?utf-8?B?S1lPajgvK29aVXBxRzE5djVuN1R2MUovMG05MjJyaVVzUkhhNm5MU0xYUGhv?=
 =?utf-8?B?ZXVpdnUxWjBoK3JDRXJTRE9VTlQzd2Znd3BCVzlTTmhnSmp4ZTEwczN4ME9F?=
 =?utf-8?B?ZUd6OEF0OEpvajlZcXhoZzAwR2dESDViYWp2RCtDdWQwRlEwdW5RZFJXZnM3?=
 =?utf-8?B?MlJCRFh1SVNHMTU1QVJLSXk5dGUrRjhpb0xUZ0RCQzhQbURRdmJIMkNrTnhJ?=
 =?utf-8?B?NzgyYUhXYkJ0MjJ4L3dmTDVseXpENVJxaVJqVTZScjgrY1lLZTZDMzg3amJ5?=
 =?utf-8?B?UUdtU1RwYlpMT3ZGVS9paUg5QnNGTHg1WFZaenRYbElTVmpVcnlyRm8vdG81?=
 =?utf-8?B?dGVNTXMyNnRZUmo5cnpKd1RUaURqQ21HNk9wbTBuSHVTWFB3d2lYbnlzODBs?=
 =?utf-8?B?K2pucmNLVGVSVXk3ZjZGczdaRk5zQmFFYUgxaHdwcE8xTDF0c3JDUVRpNExw?=
 =?utf-8?B?Mm1OZmQxNHA0QnF6em1KaDdyN25qeXJVR1B3Q2ZxTVVBU3dIbjQ2NmVLK0RP?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0EC93EADAF4C946A2610D2604980F96@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6723.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abcb41b-85af-4ba3-2787-08db5ce8450d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 06:21:26.3614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: witAdwFzeMoKiBsNG0SaxFi5YkZYrkYOwOXKro8vNxkLgAKSANj37w4V7QZY+cpbzCAY1+zxi488O0QUDQJz8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6799
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SCC_BODY_URI_ONLY,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTIzIGF0IDEyOjMzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50
Lg0KPiANClRoZSBwcmV2aW91cyBwYXRjaCB3YXMgdGhpcyBvbmU6IA0KaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1p
dC9kcml2ZXJzL3NwaS9zcGktbXQ2NXh4LmM/aD12Ni40LXJjMyZpZD05Zjc2M2ZkMjBkYTdkODky
ZmZhZWRhYzBjNThkODIxOTIyZjhhNjc0DQo=
