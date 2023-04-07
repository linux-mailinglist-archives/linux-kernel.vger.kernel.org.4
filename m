Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2226DA882
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 07:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDGFdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 01:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDGFde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 01:33:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169AF7EE1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 22:33:28 -0700 (PDT)
X-UUID: b6724536d50511edb6b9f13eb10bd0fe-20230407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=J8F9Hehd9NIjyadS69WRJfaufKb1P+b2HLLv2RSAQLQ=;
        b=Yv/tLa0tQa5zbv+PrQpaFrlF/0xDCHnhkmaFLhMQ0rKAMXSlje5QvFfNXpDBQl//hS6lZ87ZEUQfbole+D4ppNz9jCexNmtCNuImbguBoU+xtm5x5L4pAcJSJxrR+4WJNkusJV1hmnbzAO3SYRIeYgWU0Vs/t3mkhUMccCu9e/U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:c5dfe318-e550-47c9-a8c5-9e57c988a223,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:c5dfe318-e550-47c9-a8c5-9e57c988a223,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:272909f8-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:2304071331022W1M8Y66,BulkQuantity:4,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: b6724536d50511edb6b9f13eb10bd0fe-20230407
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 534892513; Fri, 07 Apr 2023 13:33:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 7 Apr 2023 13:33:21 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 7 Apr 2023 13:33:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhT7Z5hLDqtA1UV3qT7cbw/XFAjTKyqLVmXqUV3J2x7y3MQmuTEcsgAA5lQnkv2FhO9d2Q6h1RC0aiZ0T2xkEXD2VNcEYvbKe72gzaoL/8Mmm/Fl7V6QfYfYxzfzm8xoKgUzI0O1RZOB+yQKpjWkD6GSYDuce+pTF2OCGqpsT3eMOxmQdWe58ZPYlb6CfrpvpUb3JrLTpHaWTzuB6dWBymBmeHl8FRl7wYSVNAfz5nP2PlhUUu1drtMMOZQ1vsVL++MyzY3NCnjSI+C48e0nRnyz6BbRDygY6BLK0M+car8QjxMF8oe+6KQ5sgMTNYEQXygRuM2kWOcxT6glmB5i5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8F9Hehd9NIjyadS69WRJfaufKb1P+b2HLLv2RSAQLQ=;
 b=WSi8KQ2LNC2poVc4U0y7cXZc3YzGKfdAWZfx6Syhh1RwPALZR6TznCNt0qDyreRW553xon4LSGbfHR7HGGyJoKcCq2Yb05K32KxVETMCx5+W5PeN3mu6LlbGrYt9EKKaaCDcCGEmyQR3kDuVmvDQ20WWsl7TNBp+/GLQ4fCLKKURtc346SZEWxUhpAlHbu03i28Ok4Q6RhVA/Aw9iLkxNli1E5ew0qdPlTYCzeJ3RLlAff0wC6XyjWSbISGHTAzprB/QS2KA7kqWzAdy9jUgRDqnepwWhGc+/V6xermP+cBQoinC4Whtw9cCGVs5Cc53xozGqK6fySm8PWeMkzg3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8F9Hehd9NIjyadS69WRJfaufKb1P+b2HLLv2RSAQLQ=;
 b=Tfd/s5lrzT35jeLum+f8Q7UcOBFt45qU6FhqLgKHCAnbXClo+zspb15RC43U6gMMsSIwhMdADs8vNqunmxUiMA0FpqGpPTEIzx/BT/CE8Us1y3QMxG9K7pJfoFcTJWsmlDPwb2ozvmwmAhroe5avusYHRtIHy5egGr+XifYZq/k=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by TYZPR03MB5760.apcprd03.prod.outlook.com (2603:1096:400:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 05:33:18 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::82b9:eab9:b4e3:8464]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::82b9:eab9:b4e3:8464%7]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 05:33:17 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 1/2] phy: core: add debugfs files
Thread-Topic: [PATCH v9 1/2] phy: core: add debugfs files
Thread-Index: AQHZV9cDPkGBtXB0Aki6NkGjBbxDxq8ZzCGAgAWpGAA=
Date:   Fri, 7 Apr 2023 05:33:17 +0000
Message-ID: <f2b614377834d3473933e16f70d07c66c26bb1d6.camel@mediatek.com>
References: <20230316071452.9161-1-chunfeng.yun@mediatek.com>
         <ZCrrhZzj98WdWkd3@matsya>
In-Reply-To: <ZCrrhZzj98WdWkd3@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|TYZPR03MB5760:EE_
x-ms-office365-filtering-correlation-id: c4ffa194-9357-46af-85c7-08db37299735
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t26W3WoHVCv843SQS2TG4TVcCQtjlwISABI9ftmH7dLdvwUvMHZUJp8wZTO2KGzHs880pD/+bS/HYAgfcdHUN43ltisD9nkV/9RYniEiYD5JylBxa3A6Xdv6Ghk3D2cxlGtU0VhfmEOrzbsUs2ELKdOADcc4EFX0xBq/YenjUuMOj5U5MCIgB2gz8tNi/GnIBxbGYF6026F1kJKSxxHQDsZK6GE/a45zM8ZOBZfojNob0QV/eKVBnniK0fjn3SF3NP4UEZ62qKusqd6usc+QeBAHuW5WYv5zEyMrJyfc2w9gLsizq9AzQHIAHCBMBLDJHGX40PAYQsHQZJpxzr9drHD42E5/XZ8ai/S1fX34oFVeljyuil12prrlaAeYidFxDSfZgFDS4zjdbCFcRrJs43mPZzSGXWB1NIwNeYV19NWy2b6tvuwVi8HsEP5wwOvhd/4uJJkRNhZAHPZj161qKcKnFWfpfBgwq1GXj0SVlQvpCutDkxkuYUbBi+2yFGyjM7hl6WsUNHRA4q75crEDQJA4fMR8HfqgTnxgVYs6LnVy6bKItRC1VbMv6PWWEkuT19viiUimIZ5oFeoob/9uh/sc39qiIJQry//X0ZK8a7ci4ZGEXd8wse70CLQZtGUD0NCAmoYxI8XmxNQ6d+li4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(36756003)(86362001)(85182001)(91956017)(76116006)(316002)(41300700001)(66476007)(66556008)(64756008)(8676002)(6916009)(4326008)(71200400001)(54906003)(6486002)(66946007)(66446008)(38070700005)(478600001)(8936002)(2906002)(5660300002)(38100700002)(122000001)(186003)(6512007)(6506007)(26005)(53546011)(2616005)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2gvNUpJVEhzeWlCcHFWdDhGT1JNR3dXSHN5QWJINDgxYStaUnZpZzlLTVJ4?=
 =?utf-8?B?c05DMEg2WlplRC9WbmdvdUVIZU5NY0JMK050VlRwVXpUYlI5b1pmZTJpQzhF?=
 =?utf-8?B?M0RLSGJzZDJ6RlB5eldIVy90MFYrV20vREcvRzRvdFRjRm5qZ3BwTHhOcDkr?=
 =?utf-8?B?c050OWdwSGZIQWVISEEyVGphUlUrWFhjdVVSckUrKzNualRNS3V5UG1qcENv?=
 =?utf-8?B?emM1ZkIxL0RXZDEzN25CNllDWFFwcVB1QzBSalZ2UWdCeHRNSlhsTVBWL2Rk?=
 =?utf-8?B?OUFFbWxubllYNUQ2L0oxY0o5RUpPeS9xWVFPK0tuSjRkNWZVYlNQcVJ3Sk5Q?=
 =?utf-8?B?UlduckpLQUIwOXh1WVdoMzNuakVuaFNJN3dQVE1XVk4xblNoYUgrRnFycnpF?=
 =?utf-8?B?aGZCUUpLUW5mU2twZ3ZQdlZMbmk2WWZGRUhHUlU5Y3k1RGt0RkxDbnh4ZWtC?=
 =?utf-8?B?U1IzWEl0SW1GMnBwVDQ2b1ZXbG9xN1dKajVIWlB1bDV5aGcrTWNNaFIvRFNz?=
 =?utf-8?B?QXZ6ek40VVlrckhGV1ZRMFBMb0tOSDNXNFlPZWlBM1FvS3owL3dranJGT2ZC?=
 =?utf-8?B?UmR2UjJDZFpmMENyak9HcTIzZGZ3NkxVc2JsOEluTlErRzFCa3U4b2hqUFc1?=
 =?utf-8?B?bzhkb2U0SEcxaWNBelJlWExiNmZObVdsZHR0a3V0RlpBRk9OV0NjclErUkd0?=
 =?utf-8?B?UENIQVdvUitqU1ZJYjZKemovc04yUzd3WEhiY0NzL2xUczl0MDdaekV2di9l?=
 =?utf-8?B?QzRrUjZYY1BjMVFkMWphajgzWStwU2M3cnlrUThSTEsreG5OZ0tZenFVL2t1?=
 =?utf-8?B?RzVldGhhUWtoTXVxTTVqS1A3TnZpZVpneXg1bktNMTllUmJDb2wrQUpSTVAr?=
 =?utf-8?B?MHZtamVTWUpTbXJwOHRDS080ZlNIakdNRmhuaHNscXpiRjE1b3VxaHgrWVZB?=
 =?utf-8?B?dklrRzJHc2Z2UmFkTlJHUzFOU3NsSWRqTXFJL0NUTGk3MHZFWHZzRTVTQWx2?=
 =?utf-8?B?U0VGa00vSW5MRU9rcjhjbm4wNkNnem15MjZPYVBDaHAwcE1NR0QwdXl2OWwz?=
 =?utf-8?B?Ry9ZNGVabmFrMXJZYUFaN0hpb1M4bDlpbmY3RmIrbElORWIrbnA3TXFHRWJ2?=
 =?utf-8?B?emtrclNJeHY1UHNYaFlsV1NiWHA1ajBqYW5tOG1QS0RKWWxMeFlJcHZsZjU1?=
 =?utf-8?B?NUE5a3ZSOUQxZ3YwL2psVmplUWpCWVk5RXIxOXRXRG5pRTF0VmZUNUo5V2hZ?=
 =?utf-8?B?NTc5Y1kwY0hRZXQrblNZdTlzNVd0ZUpzcm9LMGxkNnJBdG1mM1dpZFk2VExx?=
 =?utf-8?B?K3VSSkRvOFkwZTZXYWxPU1I4MXR1aDN1Wnd2bFlZQ25QQ0Zqdmx1d0daNTlV?=
 =?utf-8?B?SEtWVVBESCszMVFqVjdkY3VnbEJ2YktISmJjTm01SzZlbFVhU3I4a2drMFlU?=
 =?utf-8?B?amFCRWJnUVRXWTVyUEptWTNsMEQweEViY2lpRjl4Q0s5dGROalpiRmM5Mm50?=
 =?utf-8?B?SDljMEVJTnM3SzkwMDZLbTdmN09ZQlBKOXcxck5sOHpQemRHTlU5MTdQa2d6?=
 =?utf-8?B?eGkzY1pIUElHWnpoUHVPUHVjNkJhL20yRWs0VUlWemU1dzJZSVI1ZDhyc1li?=
 =?utf-8?B?MlVBYzZjczIreFpibWhvQzljKzZiSEl1bkpYeDZwMFVFb0JhKytUeVpFc09V?=
 =?utf-8?B?UituT1lJaUJnS1B1Y0JyUmtGaEI1NFhRUmpISmdEdENUbnJUaUZMcmx2YlJS?=
 =?utf-8?B?d1g0NG4wQXU0R3ZWT2hFY3U5TnNiUjQvWWtJWjByYmFLREtldnNXOVNKZ2JX?=
 =?utf-8?B?WENPUkVYRG1hNE0xWXlSZGpHYkJuaFM1VGZyQXZwb2wwVmFreThraGN5SWY3?=
 =?utf-8?B?ekVlTU15b2J5RFVnaWMyY1Nsc2MzNW9RSXN3aVpkSDlLdHJyVElQSGVrbkc4?=
 =?utf-8?B?WWFRdlJPdmVZY0ZockR4YmFHVmFybGNWWWF0dGhHUzRGUkdSbXhzbzdKbDAz?=
 =?utf-8?B?M3pyZzd0OVg3aU5zemNRWTJ5Q1JUb08vMC8xalVtajBDZ3lLY09HN295SVYz?=
 =?utf-8?B?alhkTzhGSWNXbWRFZTRtTlAzTmFsa3BhMm5yQUhOdFdCQnE1Mm85Vzlpd2ov?=
 =?utf-8?B?UlRnMVlsZzEraHZ4ZUhSaEcwUGRMTFdxMTRiSGtYOW5DeFcwMW9FV1VKeEpH?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C610683473E50145A92EBEAD43AD8A3F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ffa194-9357-46af-85c7-08db37299735
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 05:33:17.2568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LldaiNNE5SeSlkjTexLwglVAqm9g/bgzqLPPk8DgKbm7sQFwJJGaoNquAr1bx7EvUKiDnEAz//8YjiAPVYpqsE/ckUsksZJ9H1v27oZK8eE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5760
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDIwOjM2ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50
Lg0KPiANCj4gDQo+IE9uIDE2LTAzLTIzLCAxNToxNCwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+
IEFkZCBhIGRlYnVnZnMgcm9vdCBmb3IgcGh5IGNsYXNzLCBhbmQgY3JlYXRlIGEgZGVidWdmcyBk
aXJlY3RvcnkNCj4gPiB1bmRlcg0KPiA+IHRoZSByb290IHdoZW4gY3JlYXRlIHBoeSwgdGhlbiBw
aHkgZHJpdmVycyBjYW4gYWRkIGRlYnVnZnMgZmlsZXMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
IHY5OiBjcmVhdGUgYSAncGh5JyBkZWJ1Z2ZzIHJvb3QsIGFkZCBhIGRlYnVnZnMgZW50cnkgaW4g
c3RydWN0IHBoeQ0KPiA+IHN1Z2dlc3RlZCBieSBWaW5vZDsNCj4gPiANCj4gPiBObyB2OCBzZW50
IG91dDsNCj4gPiANCj4gPiB2Mn52Nzogbm8gY2hhbmdlcw0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L3BoeS9waHktY29yZS5jICB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgv
cGh5L3BoeS5oIHwgIDIgKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3BoeS1jb3JlLmMgYi9kcml2ZXJz
L3BoeS9waHktY29yZS5jDQo+ID4gaW5kZXggOTk1MWVmYzAzZWFhLi4wNTcxNTM1Mjg4MWUgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9waHkvcGh5LWNvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
cGh5L3BoeS1jb3JlLmMNCj4gPiBAQCAtMTEsNiArMTEsNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvZXhwb3J0Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiAgI2luY2x1
ZGUgPGxpbnV4L2Vyci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZGVidWdmcy5oPg0KPiA+ICAj
aW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+
ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+IEBAIC0yMCw2ICsyMSw3IEBADQo+ID4gICNp
bmNsdWRlIDxsaW51eC9yZWd1bGF0b3IvY29uc3VtZXIuaD4NCj4gPiANCj4gPiAgc3RhdGljIHN0
cnVjdCBjbGFzcyAqcGh5X2NsYXNzOw0KPiA+ICtzdGF0aWMgc3RydWN0IGRlbnRyeSAqcGh5X2Rl
YnVnZnNfcm9vdDsNCj4gPiAgc3RhdGljIERFRklORV9NVVRFWChwaHlfcHJvdmlkZXJfbXV0ZXgp
Ow0KPiA+ICBzdGF0aWMgTElTVF9IRUFEKHBoeV9wcm92aWRlcl9saXN0KTsNCj4gPiAgc3RhdGlj
IExJU1RfSEVBRChwaHlzKTsNCj4gPiBAQCAtOTk2LDYgKzk5OCw4IEBAIHN0cnVjdCBwaHkgKnBo
eV9jcmVhdGUoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+IHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9k
ZSwNCj4gPiAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfbm9fY2FsbGJhY2tzKCZwaHktPmRldik7
DQo+ID4gICAgICAgfQ0KPiA+IA0KPiA+ICsgICAgIHBoeS0+ZGVidWdmcyA9IGRlYnVnZnNfY3Jl
YXRlX2RpcihkZXZfbmFtZSgmcGh5LT5kZXYpLA0KPiA+IHBoeV9kZWJ1Z2ZzX3Jvb3QpOw0KPiA+
ICsNCj4gPiAgICAgICByZXR1cm4gcGh5Ow0KPiA+IA0KPiA+ICBwdXRfZGV2Og0KPiA+IEBAIC0x
MjI2LDYgKzEyMzAsNyBAQCBzdGF0aWMgdm9pZCBwaHlfcmVsZWFzZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQo+ID4gDQo+ID4gICAgICAgcGh5ID0gdG9fcGh5KGRldik7DQo+ID4gICAgICAgZGV2X3Zk
YmcoZGV2LCAicmVsZWFzaW5nICclcydcbiIsIGRldl9uYW1lKGRldikpOw0KPiA+ICsgICAgIGRl
YnVnZnNfcmVtb3ZlX3JlY3Vyc2l2ZShwaHktPmRlYnVnZnMpOw0KPiA+ICAgICAgIHJlZ3VsYXRv
cl9wdXQocGh5LT5wd3IpOw0KPiA+ICAgICAgIGlkYV9zaW1wbGVfcmVtb3ZlKCZwaHlfaWRhLCBw
aHktPmlkKTsNCj4gPiAgICAgICBrZnJlZShwaHkpOw0KPiA+IEBAIC0xMjQyLDYgKzEyNDcsMTUg
QEAgc3RhdGljIGludCBfX2luaXQgcGh5X2NvcmVfaW5pdCh2b2lkKQ0KPiA+IA0KPiA+ICAgICAg
IHBoeV9jbGFzcy0+ZGV2X3JlbGVhc2UgPSBwaHlfcmVsZWFzZTsNCj4gPiANCj4gPiArICAgICBw
aHlfZGVidWdmc19yb290ID0gZGVidWdmc19jcmVhdGVfZGlyKCJwaHkiLCBOVUxMKTsNCj4gPiAr
DQo+ID4gICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgZGV2aWNlX2luaXRjYWxsKHBoeV9j
b3JlX2luaXQpOw0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgX19leGl0IHBoeV9jb3JlX2V4aXQo
dm9pZCkNCj4gPiArew0KPiA+ICsgICAgIGRlYnVnZnNfcmVtb3ZlX3JlY3Vyc2l2ZShwaHlfZGVi
dWdmc19yb290KTsNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIG1vdmVkIHRvIHBoeV9yZWxlYXNlKCkg
d2Ugd2FudCB0aGUgZGVidWdmcyB0byBiZQ0KPiBjbGVhbmVkDQo+IGZpcnN0DQpwaHlfcmVsZWFz
ZSgpIHdpbGwgcmVtb3ZlIGl0cyBkZWJ1Z2ZzIGZpbGUsIGJ1dCBwaHlfZGVidWdmc19yb290IGlz
IHRoZQ0Kcm9vdCBvZiBwaHkgY29yZSwgY2FuJ3QgYmUgcmVtb3ZlZCBpbiBwaHlfcmVsZWFzZSgp
DQoNCj4gDQo+ID4gKyAgICAgY2xhc3NfZGVzdHJveShwaHlfY2xhc3MpOw0KPiANCj4gaG1tbSB3
ZSBhcmUgbWlzc2luZyB0aGlzIGFscmVhZHksIHRoYXQgbWlnaHQgYmUgYW4gaXNzdWUhDQo+IA0K
PiA+ICt9DQo+ID4gK21vZHVsZV9leGl0KHBoeV9jb3JlX2V4aXQpOw0KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3BoeS9waHkuaCBiL2luY2x1ZGUvbGludXgvcGh5L3BoeS5oDQo+ID4g
aW5kZXggM2E1NzBiYzU5ZmM3Li5mNmQ2MDdlZjBlODAgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVk
ZS9saW51eC9waHkvcGh5LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3BoeS9waHkuaA0KPiA+
IEBAIC0xNDgsNiArMTQ4LDcgQEAgc3RydWN0IHBoeV9hdHRycyB7DQo+ID4gICAqIEBwb3dlcl9j
b3VudDogdXNlZCB0byBwcm90ZWN0IHdoZW4gdGhlIFBIWSBpcyB1c2VkIGJ5IG11bHRpcGxlDQo+
ID4gY29uc3VtZXJzDQo+ID4gICAqIEBhdHRyczogdXNlZCB0byBzcGVjaWZ5IFBIWSBzcGVjaWZp
YyBhdHRyaWJ1dGVzDQo+ID4gICAqIEBwd3I6IHBvd2VyIHJlZ3VsYXRvciBhc3NvY2lhdGVkIHdp
dGggdGhlIHBoeQ0KPiA+ICsgKiBAZGVidWdmczogZGVidWdmcyBkaXJlY3RvcnkNCj4gPiAgICov
DQo+ID4gIHN0cnVjdCBwaHkgew0KPiA+ICAgICAgIHN0cnVjdCBkZXZpY2UgICAgICAgICAgIGRl
djsNCj4gPiBAQCAtMTU4LDYgKzE1OSw3IEBAIHN0cnVjdCBwaHkgew0KPiA+ICAgICAgIGludCAg
ICAgICAgICAgICAgICAgICAgIHBvd2VyX2NvdW50Ow0KPiA+ICAgICAgIHN0cnVjdCBwaHlfYXR0
cnMgICAgICAgIGF0dHJzOw0KPiA+ICAgICAgIHN0cnVjdCByZWd1bGF0b3IgICAgICAgICpwd3I7
DQo+ID4gKyAgICAgc3RydWN0IGRlbnRyeSAgICAgICAgICAgKmRlYnVnZnM7DQo+ID4gIH07DQo+
ID4gDQo+ID4gIC8qKg0KPiA+IC0tDQo+ID4gMi4xOC4wDQo+IA0KPiAtLQ0KPiB+Vmlub2QNCg==
