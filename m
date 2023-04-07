Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2C56DA96C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 09:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbjDGH0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 03:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbjDGH0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:26:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B099BAF18;
        Fri,  7 Apr 2023 00:25:14 -0700 (PDT)
X-UUID: 4972b5a0d51511eda9a90f0bb45854f4-20230407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2RXqy8r8Rk21b9Z8TE9f3FJYkjS/s05H6QWV8jhcgkc=;
        b=FrL8ivagtTBiYibVA8mHROIkwvf6ph1NwkLG8vjCQouXHA2Ni3DulQ2qL6y++iIU+DBalo4WUeRlxu63g66pKgWebMGEStDCxdBP3sgskD80NH3Dq+dCLGDJbfRpM5k0jRBYy0c9jJVOTkPFrXG0ZE+KCfznCbgariTcnXI4o28=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:d240211b-0961-4640-bd39-64cfd7ab9d66,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:d240211b-0961-4640-bd39-64cfd7ab9d66,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:d5307fb5-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:23040715245364FBV1FL,BulkQuantity:0,Recheck:0,SF:19|38|17|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 4972b5a0d51511eda9a90f0bb45854f4-20230407
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 360786794; Fri, 07 Apr 2023 15:24:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 7 Apr 2023 15:24:50 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 7 Apr 2023 15:24:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJVyy0MN4cs4BTSrBAuHbnWBG4AksXN1k6lRFUwwo5egqUw7erTRwn7mDDudelEbwuY7ds3+VJT77/Dt8Mq+YNq+s0VHUR77+ax450DPC0jIfsK3noEcBQ+uVfhqRchue4/zvqUvEvv2shEt4dxIsCFtjhJb42TOnl2siGZ35I/56mJKbjXMe8W8pcIrpw2aaIXsfpzE8sHvKTjmjizltj+hNY50MWwjHYxuI3xWR1Pv1BeCkX/5DXa8Eoq720u8ibwVjqMsyQuuVpfBtHkeEgJHKcwOLYq96Y0YY/jkxpEI9oiKB8Up365OEUkR7tqD0r1X1NkSnI2oeZg9kDmF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RXqy8r8Rk21b9Z8TE9f3FJYkjS/s05H6QWV8jhcgkc=;
 b=SDx6dvDAB34e3XhRtwsgWNoiR4lFxkLRVe5UyGubBJWRhY0FhMxVWV4hn6i93+KxHLeYaQTxmb4xTE4W1TOfNyfjFuy3qb6vDyMiUO3TewQYJ/9MAMYyO4db8EjKyM3PHWdFatQKUCDgb8HA7+G6OYrTzjG2jPNsHTq9zyYuQ38hhOiT1ft+zgkRPaACYyiS+fSi8If7belfpJiTr0KXTMYq35vLz27pYESkJQ5HQbs0cRgSBTyh0cMKTJGB+hGF93makG7s6HDTafAmzgXjCvoRkzM0eJ26g4sfscng7LnDcOE6XB8D5ph1pibZ/D53bGK8Tq7oC/2z4/JzQmPCCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RXqy8r8Rk21b9Z8TE9f3FJYkjS/s05H6QWV8jhcgkc=;
 b=UlzLjzxVPPseNjc3n7jrOU5lI1q4CTKGdTd6AjF9FsYaPRJVJoKNBfzAmftjqTf1oNurKon4O15jfme9Ol5uVu9+P1RUv9ZZ35LDh/K9liKTApALB47rz6nVDLLrG9EqIw5wdeW9Q2newZAHl8pVKpeBoWE2V3bC33kzDdzg6K4=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by PUZPR03MB6885.apcprd03.prod.outlook.com (2603:1096:301:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Fri, 7 Apr
 2023 07:24:48 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::82b9:eab9:b4e3:8464]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::82b9:eab9:b4e3:8464%7]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 07:24:48 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        =?utf-8?B?VGlhbnBpbmcgRmFuZyAo5pa55aSp5bmzKQ==?= 
        <Tianping.Fang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/7] usb: mtu3: give back request when rx error happens
Thread-Topic: [PATCH 1/7] usb: mtu3: give back request when rx error happens
Thread-Index: AQHZZddXFpkvr0lWZECE7OMyd+pUOa8ZhNEAgAXzjwA=
Date:   Fri, 7 Apr 2023 07:24:47 +0000
Message-ID: <35f22881945530524e2f9da41e7d592812aa9ff4.camel@mediatek.com>
References: <20230403025230.25035-1-chunfeng.yun@mediatek.com>
         <6626cb88-9d9e-593f-f4c9-44c3035bad43@collabora.com>
In-Reply-To: <6626cb88-9d9e-593f-f4c9-44c3035bad43@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|PUZPR03MB6885:EE_
x-ms-office365-filtering-correlation-id: bb797f0f-8bad-4880-3158-08db37392b2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zXJ0RxOEbgDS+eu98I8BH65+JpAKNAZktCYP+sEiu9EwLcPFZ7bKGi4N6YSm8OMa4GpxM3O7vt3nRz7Mn0bh4z0JYMkAwG0UETYIwDV9/bI9tQY3K+Y8NBJ4aMF8P7/3AnGpUQ8jDycC4oLBfJSveNlXkg7tYIm2J84hP0U22dV3TJR9Icw1OYEbAW/H3IZIzP4VIhoI6p5jEQvGrI6FIittKt/dez6ywJq2kc8/2UN91N2SiEb976C0SUidUptjAJs2vuHyCHhiACv3CFr8V6STUf1HTMFHJ/t0UeEfAqQAkb5a6MtCxa7UfiOgOzVExe8B63igEcUXorgHnchdwsN4bQtbkPyRPrSjlFt/2LNdwvUBSSAEJHo/RhdSg3bdDHRfj3hogQiP8ixnxiVHqZP6l7bvs/zm/Tcwj68YmacrDK48c8gLq1sZDv26vxzPw/2CqkGN+LXS4CGwuiVqpA+nVbmFcOWC41KqymHu0/pmXkEOe5/CRwFgbMyRSOla0vvAlZvtX7k6UBogpxmvTN/rT4iqJ0y67xHrxwM6LEt1uxOks9d7uK2m36gB5s6U+vWG/WHomDAaolQGexZYG2/u+LBJDqfyIPnPCISy5o0TSjxUrCxcs25Ws11xM3sTwpGeQZ3xFeE8mK0JTQ4GJDsS80uP03apZPAKktQFbnyWnVIcJ6oUPBRGHyslCmCh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(478600001)(91956017)(66476007)(66446008)(64756008)(66946007)(316002)(66556008)(76116006)(4326008)(38100700002)(7416002)(122000001)(54906003)(8936002)(41300700001)(8676002)(110136005)(5660300002)(186003)(6486002)(6512007)(2616005)(83380400001)(26005)(6506007)(71200400001)(85182001)(2906002)(86362001)(36756003)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTl3c1N6eXBtNHgzMjVJcEV5aVJscTVDdXc0SUV3cy9lZ0o1UkdVQS9NbjBZ?=
 =?utf-8?B?NFVJaTAvR2xhYUU4azlJTHdieTAxc2tsbHltSlgwbU5VNjUveHdLOWQzY0s1?=
 =?utf-8?B?YlZWUjk5cktMaStGbllROGRsY0NZR3Nua1RHVm4zbEV2VThoeWdqY3pmbDFn?=
 =?utf-8?B?aUV5QU5DOVlTU3UxOW54aG8wMnlLTWxGdEJ3cktSQWtHUWZONkhOcUVGMjBK?=
 =?utf-8?B?U2owemNvVWpYUEx3d0pMTytiUHl2SmphQk1FK3Jrc1FPaFFHZis2dm9KenBu?=
 =?utf-8?B?bkFCTTZ2M1NpRVlQaHVGaGZ5eXd4ZTd2b3BuWkdNRDRvL1huWlBzNnRFRHBs?=
 =?utf-8?B?aDBwZEVsUEpqZzQ5WlZZRkJYcGQ3YitVQ2xaTEdnem9GRDZXNktrZlRRdStS?=
 =?utf-8?B?K2NNeEMraVFmZEFzbm9YcFBNNzlaN05mZ0lYRTFnemYvRjFrMjU0VVptVWEv?=
 =?utf-8?B?VFJMNk1RbUlKUDduN3VPa0R4MFpiME1Pb21mVXJvSkdmN3lhYnl2Vnp0aHFx?=
 =?utf-8?B?UGd6cDRrZTc5ZStuZE1yV3RrZVR0U3lqTmU5cGdSeUxHY2FwMmFKUDZzVWdZ?=
 =?utf-8?B?U2cydG5DOWtDYkpkeEJ6Ty9NV0JmUlpTUW44UWtyYkp5ai9BWWhFcmd6YmY3?=
 =?utf-8?B?ZzgzUmp4SjlpVVpidGZJQnR4OVBCNy9vdEtKMlh1TEVFYnpsdUVmSkdzRHho?=
 =?utf-8?B?d21JS09BWDA2b3VFQndacmJ2dnVKVlVnMEVua3BkaGVZYkh2djFSRXpLdHMr?=
 =?utf-8?B?U29pNFFvQ1RubmlsSm1XdEEzdUdCbEVYcEJsL0ZrREdXaEJKU2Fhd0tDbnV4?=
 =?utf-8?B?MmIrOHo0ZERqaklzeHZNcFk4QWhsb3lwSFpXM2lvMjhpTEhBQ1dpOHBlV1Ru?=
 =?utf-8?B?RzZGY1h3VktBUmlVQmt6TEEwaHB1dzA5MERlTXY5eUI0SjlBNHdUNk00dk56?=
 =?utf-8?B?amowRGJ5MzdJMjBCTkpUamVFUHc4dWRWd1hxV3lnQy96Yzg3dTI1eE5Mb05u?=
 =?utf-8?B?MnpHYjB5dGpERmEycTlnZTV2R0l2akVHM01wL25WNmw5a2U4Q0d5Z1BYcWpi?=
 =?utf-8?B?YVlQZFlKdmhmSlhabXIxNVp5VHRTMjJtMVV4djFhelZ4MDNERTVTWEhldWYx?=
 =?utf-8?B?NGVpemZKQVFHa3RianhuNUhOZmpWazZORndsbFhIckw2T3V3WDdYSkRpeHR0?=
 =?utf-8?B?WnlKNkptRjRtRWdUYTk5WUpEZ0FUVUQ0UTU3Y2svWGo4TlFyNHc3SUFyN1Mw?=
 =?utf-8?B?dFFacWNSbkhRandvUTFxQmpSQ3ZGOTdJNVhhaENjNmxjOUo0b2JCaS8vRVR0?=
 =?utf-8?B?TWxUM2JldjBSSythVE5VWDIwMmo2bnJhUHljQ2E4VVRyRGVMR1BwQWxNNTFN?=
 =?utf-8?B?M1BZcWRYUFpMendMUzhrRWZnaDZ6T1FCN0xJYnNnc1VsRHMxZnZZZ2tQd0c3?=
 =?utf-8?B?ZnFTVFF4VVZ0QTA5MnN6NlU3N0h0dThRaUdFL2JweWp4MUVoRmJmbVF2Q0FS?=
 =?utf-8?B?dENiV2pmNXdpMUtMcFdkN1d0RE5oUWM4SGJVSVYyZzBxUDRWdlNWWmxxUXRz?=
 =?utf-8?B?dW96OUZrckFtS09ObEFHc0FNc3VNdnRnVHo0ajJxRlQ4ckNHS1A3Rlo4VlMw?=
 =?utf-8?B?SHZHc3hnYW1OOXJVd0dwZ0NYYm5iQk5JRzRIWGJ6UWpIcEU4MFo1b0d1ZWpV?=
 =?utf-8?B?TFhuMFlDSUZVKzNMUEl3dFlOU3R0YmM3U2hLa1dENjBQWlFYUUVHTzdXbnJy?=
 =?utf-8?B?STJQOS85Ky9jZWxHWnNHaXZUQWx6K0VUcGdHME1HeE5rVGZ2d0pwWGZxNXZo?=
 =?utf-8?B?T2YwOHQ5bEVWcTR1Z1grN1psL1lxVXhZSC9DbTRCOGxsWjZjeHhqRmI5MVRr?=
 =?utf-8?B?YUZmeHlySTFrSDROR3BydjFGN3lYelRFNThCa2hkSXFpT1Z4SEJKK2hsZWRk?=
 =?utf-8?B?enI5VitMTWM4dmJxckJtb2lQNGhLb1pYYTVRYnNwa2tlTDRWU1Mxc3p6Qnl0?=
 =?utf-8?B?eGZwMmFkaUQzY3hlUEQxODBpQXQxbU1pa1RIMmZLVzlTbHZvKzd4OSsxendQ?=
 =?utf-8?B?ZjlpVFFpZmZKQ01adnVNYmV0Z2JCSFRUQVpKbFpUSGtUK04weTRzdXh0amtW?=
 =?utf-8?B?SWNrSWtmemRXY0JCRlI1MXliSmFsdm5WWWVvUDVBcHBPL1VrRUFhTG0xRE9v?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC7DB82440722044B545262FAD1B0609@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb797f0f-8bad-4880-3158-08db37392b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 07:24:47.9558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRJI+N2yZQalxwIH6Kwqt94wLvqxm83LhCEbvdWGe+7JKxoZmynYHwSeBcxTfdbXbgEQRvne5MNx5bWhDruHQyer3XP56dfdu9jHXBbDilc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6885
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDE0OjMxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwMy8wNC8yMyAwNDo1MiwgQ2h1bmZlbmcg
WXVuIGhhIHNjcml0dG86DQo+ID4gV2hlbiB0aGUgUnggZW5jb25udGVyIGVycm9ycywgY3VycmVu
dGx5LCBvbmx5IHByaW50IGVycm9yIGxvZ3MsDQo+ID4gdGhhdA0KPiA+IG1heSBjYXVzZSBjbGFz
cyBkcml2ZXIncyBSWCBoYWx0LCBzaGFsbCBnaXZlIGJhY2sgdGhlIHJlcXVlc3Qgd2l0aA0KPiA+
IGVycm9yIHN0YXR1cyBtZWFud2hpbGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZl
bmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiANCj4gIEZyb20gd2hhdCBJIHVu
ZGVyc3RhbmQsIHRoaXMgaXMgbm90IGEgbmV3IGZlYXR1cmUsIGJ1dCBhIGZpeCBmb3IgYQ0KPiB1
bndhbnRlZCBRTVUNCj4gaGFsdC4NCj4gVGhpcyBtZWFucyB0aGF0IHRoaXMgY29tbWl0IG5lZWRz
IGEgRml4ZXMgdGFnLg0KDQpJIGRpZCBub3QgdGFrZSBpbnRvIGFjY291bnQgdGhpcyBjYXNlcyB3
aGVuIHdyaXRlIHRoaXMgZHJpdmVyLCBpdA0KY2F1c2VkIHRoZSBpc3N1ZSBieSB0aGUgYnVnIG9m
IGhvc3QgZHJpdmVyLg0KDQo+IA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy91c2IvbXR1My9tdHUz
X3FtdS5jIHwgMzkNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9tdHUzL210dTNfcW11LmMNCj4gPiBiL2Ry
aXZlcnMvdXNiL210dTMvbXR1M19xbXUuYw0KPiA+IGluZGV4IGEyZmRhYjhiNjNiMi4uN2JlNGU0
YmUxYTZhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19xbXUuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19xbXUuYw0KPiA+IEBAIC00NjYsNiArNDY2LDM5
IEBAIHN0YXRpYyB2b2lkIHFtdV90eF96bHBfZXJyb3JfaGFuZGxlcihzdHJ1Y3QNCj4gPiBtdHUz
ICptdHUsIHU4IGVwbnVtKQ0KPiA+ICAgICAgIG10dTNfcW11X3Jlc3VtZShtZXApOw0KPiA+ICAg
fQ0KPiA+IA0KPiA+ICsvKg0KPiA+ICsgKiB3aGVuIHJ4IGVycm9yIGhhcHBlbnMgKGV4Y2VwdCB6
bHBlcnIpLCBRTVUgd2lsbCBzdG9wLCBhbmQgUlFDUFINCj4gPiBzYXZlcw0KPiA+ICsgKiB0aGUg
R1BEIGVuY291bnRlcmVkIGVycm9yLCBEb25lIGlycSB3aWxsIGFyaXNlIGFmdGVyIHJlc3VtaW5n
DQo+ID4gUU1VIGFnYWluLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIHZvaWQgcW11X2Vycm9yX3J4
KHN0cnVjdCBtdHUzICptdHUsIHU4IGVwbnVtKQ0KPiA+ICt7DQo+ID4gKyAgICAgc3RydWN0IG10
dTNfZXAgKm1lcCA9IG10dS0+b3V0X2VwcyArIGVwbnVtOw0KPiA+ICsgICAgIHN0cnVjdCBtdHUz
X2dwZF9yaW5nICpyaW5nID0gJm1lcC0+Z3BkX3Jpbmc7DQo+ID4gKyAgICAgc3RydWN0IHFtdV9n
cGQgKmdwZF9jdXJyZW50ID0gTlVMTDsNCj4gPiArICAgICBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJl
cSA9IE5VTEw7DQo+ID4gKyAgICAgc3RydWN0IG10dTNfcmVxdWVzdCAqbXJlcTsNCj4gPiArICAg
ICBkbWFfYWRkcl90IGN1cl9ncGRfZG1hOw0KPiA+ICsNCj4gPiArICAgICBjdXJfZ3BkX2RtYSA9
IHJlYWRfcnhxX2N1cl9hZGRyKG10dS0+bWFjX2Jhc2UsIGVwbnVtKTsNCj4gPiArICAgICBncGRf
Y3VycmVudCA9IGdwZF9kbWFfdG9fdmlydChyaW5nLCBjdXJfZ3BkX2RtYSk7DQo+ID4gKw0KPiA+
ICsgICAgIG1yZXEgPSBuZXh0X3JlcXVlc3QobWVwKTsNCj4gPiArICAgICBpZiAoIW1yZXEgfHwg
bXJlcS0+Z3BkICE9IGdwZF9jdXJyZW50KSB7DQo+ID4gKyAgICAgICAgICAgICBkZXZfZXJyKG10
dS0+ZGV2LCAibm8gY29ycmVjdCBSWCByZXEgaXMgZm91bmRcbiIpOw0KPiA+ICsgICAgICAgICAg
ICAgcmV0dXJuOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgcmVxID0gJm1yZXEtPnJl
cXVlc3Q7DQo+ID4gKyAgICAgcmVxLT5zdGF0dXMgPSAtRUFHQUlOOw0KPiANCj4gWW91IGRvbid0
IG5lZWQgYSAqcmVxIHBvaW50ZXIgZm9yIGp1c3Qgb25lIHNpbXBsZSBhc3NpZ25tZW50Lg0KPiAN
Cj4gICAgICAgICBtcmVxLT5yZXF1ZXN0LnN0YXR1cyA9IC1FQUdBSU47DQo+IA0KPiB0aGF0J2xs
IGRvLg0KDQpUaGF0J3MgZ29vZCwgSSdsbCBtb2RpZnkgaXQsIHRoYW5rcw0KPiANCj4gPiArDQo+
ID4gKyAgICAgLyogYnkgcGFzcyB0aGUgY3VycmVudCBHRFAgKi8NCj4gPiArICAgICBncGRfY3Vy
cmVudC0+ZHcwX2luZm8gfD0gY3B1X3RvX2xlMzIoR1BEX0ZMQUdTX0JQUyB8DQo+ID4gR1BEX0ZM
QUdTX0hXTyk7DQo+ID4gKyAgICAgbXR1M19xbXVfcmVzdW1lKG1lcCk7DQo+ID4gKw0KPiA+ICsg
ICAgIGRldl9kYmcobXR1LT5kZXYsICIlcyBFUCVkLCBjdXJyZW50PSVwLCByZXE9JXBcbiIsDQo+
ID4gKyAgICAgICAgICAgICBfX2Z1bmNfXywgZXBudW0sIGdwZF9jdXJyZW50LCBtcmVxKTsNCj4g
PiArfQ0KPiA+ICsNCj4gPiAgIC8qDQo+ID4gICAgKiBOT1RFOiByZXF1ZXN0IGxpc3QgbWF5YmUg
aXMgYWxyZWFkeSBlbXB0eSBhcyBmb2xsb3dpbmcgY2FzZToNCj4gPiAgICAqIHF1ZXVlX3R4IC0t
PiBxbXVfaW50ZXJydXB0KGNsZWFyIGludGVycnVwdCBwZW5kaW5nLCBzY2hlZHVsZQ0KPiA+IHRh
c2tsZXQpLS0+DQo+ID4gQEAgLTU3MSwxNCArNjA0LDE4IEBAIHN0YXRpYyB2b2lkIHFtdV9leGNl
cHRpb25faXNyKHN0cnVjdCBtdHUzDQo+ID4gKm10dSwgdTMyIHFtdV9zdGF0dXMpDQo+ID4gDQo+
ID4gICAgICAgaWYgKChxbXVfc3RhdHVzICYgUlhRX0NTRVJSX0lOVCkgfHwgKHFtdV9zdGF0dXMg
Jg0KPiA+IFJYUV9MRU5FUlJfSU5UKSkgew0KPiA+ICAgICAgICAgICAgICAgZXJydmFsID0gbXR1
M19yZWFkbChtYmFzZSwgVTNEX1JRRVJSSVIwKTsNCj4gPiArICAgICAgICAgICAgIG10dTNfd3Jp
dGVsKG1iYXNlLCBVM0RfUlFFUlJJUjAsIGVycnZhbCk7DQo+IA0KPiBQbGVhc2UgbWVudGlvbiBp
biB0aGUgY29tbWl0IGRlc2NyaXB0aW9uIHRoZSByZWFzb24gd2h5IHlvdSdyZSBtb3ZpbmcNCj4g
dGhpcyByZWdpc3Rlcg0KPiB3cml0ZSBoZXJlLg0KDQpJdCBjbGVhcnMgaXJxIHN0YXR1cyBiZWZv
cmUgaGFuZGxpbmcgdGhlIGVycm9yOw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCg==
