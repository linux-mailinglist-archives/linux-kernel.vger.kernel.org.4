Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46326518B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 03:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiLTCPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 21:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLTCO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 21:14:57 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D94DB7CC;
        Mon, 19 Dec 2022 18:14:55 -0800 (PST)
X-UUID: d046082adc394e44a23c87bf7dd3a545-20221220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EGBAXbbjOLwdloSHLvM5PWALo76P5cOb0nJZhNfUM6M=;
        b=S0cgOb1W7DRQME/vhMOk6WgGCyk1TNzU+Bnbm9F1oNkYvP6GuzfnAxdIthWK4qjQaZHszsRdGcea5STM4rGUYVlATZlirrs10GXMSkZ2oMZ1gVuUI3GWaU3YFcg/OHVffK4WXgb+zHWZaA0cZTvRD1BZdX7PvQK3Rut4rWbtkk0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:b3554d86-c8e3-4266-b117-ce2a0042c6a3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:9d1a63f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d046082adc394e44a23c87bf7dd3a545-20221220
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 32209513; Tue, 20 Dec 2022 10:14:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 20 Dec 2022 10:14:48 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 20 Dec 2022 10:14:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHEuE35AOITdXKcYugRHRUr6T1QU1w68jxyVd6GY78BEmDMYw8I8bL2CIsJg+zhlRSotGncwGK4j0qBrBpWlBXWsuaY6NIdKWlELyDb2MezsaPWSGwIutlHHBnVzvSRCxI1dhl+omzxjjRVj/E06IvMpAeKrbrwFyoi6fft0jqxfvAF0+nBfaFaDXzAssxDooIfmqiGVGWrQiO/QIDZ7UPagXEBDpfvRujTMAZUSItlJHvPrGlusY8RhtwsQbdfdn8uMIgQveYsNn5ZqUG7qx9DH9miMLu+0+RHBrTnl49jBlOuAVMwsvDuMy88D1th2l9WKRyffG8cydEB1jRrjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGBAXbbjOLwdloSHLvM5PWALo76P5cOb0nJZhNfUM6M=;
 b=Zn1n7Y8PN27BFsRP2Typzzj4nZJmlSpGzNu6LtmdszK6vByxhFOADQnsYIXIGEneT/hB8XCPTRawt6dVnnajswQqQwLettpIOO3leQcL55fwdYw3PeXTY3lr0nj+eq5L0RYOHv0JXmXcZOS3v9/MJZwvOn6SRKM49cPQiJ5GoLy+qad6ZZ3UiQSTsjXWGnIRPPLdDhujswoyxMo4M9ZUu3QX6YljZC5gsNLc/xmpvKUqOB2rQ2uSZj9UwEzOQHzWyj+HEMXvQtFxYEcAqOaBYe0Y5niDVyAfQqe+RybT4aiy8Gmz1lAjAA6x+u4ItWjO/q5Jydb+oG4p69w9CsWnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGBAXbbjOLwdloSHLvM5PWALo76P5cOb0nJZhNfUM6M=;
 b=BiZqGU3vtAn8ddwxIqU/m2emNgy4C7CnbPp+IMIGiM5Wd6GIf2t9P4J0GtWpClzFTeSLakw3HV2HJEBdEMVXHVoW5tgahm60wwIGD25kpQ+ZLhzG2yOD+MuItFWFMtdI99M9IEeIhIsrPFM4Iej7Buc6jSgxWrkLCZveHsRsNtM=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by SEZPR03MB7123.apcprd03.prod.outlook.com (2603:1096:101:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 02:14:45 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d%3]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 02:14:45 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v4 0/8] add support MDP3 on MT8195 platform
Thread-Topic: [PATCH v4 0/8] add support MDP3 on MT8195 platform
Thread-Index: AQHZCiFC6wxJGsqypUqp9QXhkHnrwq5wgO6AgATk2oCAALebAA==
Date:   Tue, 20 Dec 2022 02:14:45 +0000
Message-ID: <abfa4b935938a0b00bcccbc10e1a748f49f3497c.camel@mediatek.com>
References: <20221207094921.15450-1-moudy.ho@mediatek.com>
         <5692faa0-6d7e-774f-9d6a-a495b44bdb3e@gmail.com>
         <dba479ea-968f-89eb-fc59-8235cbb2783a@gmail.com>
In-Reply-To: <dba479ea-968f-89eb-fc59-8235cbb2783a@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|SEZPR03MB7123:EE_
x-ms-office365-filtering-correlation-id: e3a85a8b-2b14-49e4-59ab-08dae22ff69b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +39uEh0thh/pLHv0Usi/NOiToW9hh5VMMHi7eubStx/MKEWl0d1RauLFrkCT2GoybxSmOSbySnYM0cGCSnmeGkFZpspwmOmyDWz+IPmh4PzdVw/UWQwD1Kv5x89BJFA5Rb8exbxCPaGLBNDG0IQPA7+mN+Er95fPoPWlLFB7nzUJ74S5qDhr6ljAn8g7LEZmz3DBtclZK8v8xwHZA9aufa0rMa0AgltTQenuUbEiES9AQx0VFgA21JBmyjp2Ez6kynn+Rn3UYvG3hg2XCLVzWzT14Th89wTK7lcKMcL7eC0sKZNmylzLbKBfal1sB/SIKfILSsv7QSfLZw4AriJopZ+QRGkfIlA/mP4jOqTDm775GL1U9D+GChBBge4Tl8JStktEpnflu37wiI7/tC681cAyT62z7l+WVk5K23ACK4iDMCgMuuVvYT172SUevrk1gRad3Eub3xvZ/0nARRoxqxCIu+d5HqVtGuPl33EHUJzcVCW7vSQa/8UOxJXoGqz+pUPyzwk1diDL0U7Q4WhmpIT/KxlwyoRUON3lXR8h0vNatW+mDWXzJYtmsqXx1MqOGE+UyGRZTgJOBrO4VD8Sf0pKduudcx5hK86qO7JcRmJV4bih6udNvGVXwvghUGyfc1dJrBOGSzqVWFtEBSabHF9sKEuH1P3aoE/0kDHNViRgWCo4B51r5BuGEGvNSW0vWdSJn1mh24s+s79Wa/G2f1vAmoiVj2XlKrFxEbRAKFEUYtx82gkU40gA3vOi/Op845zE+SjHX0QSZ2bjg67zR8JpYS8fZprHs+Ak1Z37JSI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(36756003)(85182001)(186003)(76116006)(66946007)(26005)(478600001)(91956017)(8676002)(4326008)(41300700001)(2616005)(71200400001)(2906002)(4001150100001)(64756008)(86362001)(5660300002)(6512007)(53546011)(66476007)(6486002)(66446008)(66556008)(8936002)(122000001)(107886003)(966005)(83380400001)(54906003)(316002)(6506007)(110136005)(38070700005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEJxcTU5UWxBTFRWNHFDTHhDemFuZE1aNkFLb2ovWjRjcmlNV0IxU2E2Q2VK?=
 =?utf-8?B?YUtRYjhVeFErNXBzdlRXaWlFZ01VT255T0ZBV01jYjZRb3p2MEN6cGk5Zmx1?=
 =?utf-8?B?aldiT1ErRjlLa2JJWDVYT21ZeENnbkMxQ29rS2dxMCtwc29UR2hVS3lmOXRt?=
 =?utf-8?B?bkFpbDhkV0ZqMXFHVHdzREdxTkdrdFJyUnh0YTZHOE1LSzUvSFBVdERRTFM0?=
 =?utf-8?B?clJIZVBVMmUwNjc0d0pTdmRUbEdpR0tBeHVqS0N3OUJ4MjBYaUJiSzBSSTJu?=
 =?utf-8?B?TkNUNWN0UU9RNzhRTWxqSldZV1lwaFBQQTRUcEF1Y1hVaGdCdXZuZnJSZTlj?=
 =?utf-8?B?bnhnUTg4VzhZRmhJNTJaemY2aUV5djRORitkbW1ZWU8xS3dsZ0pwVFA0U1ZQ?=
 =?utf-8?B?Sk5yMnZRWUhORzRIMS9pbk9yUXVLZDBVdlhtRG5pMGRlcUtSSFVkbUVlYm5L?=
 =?utf-8?B?eld5N2VOWkUydmVaRkxDNGQwam0yTTFwd3h5WDZrVFYwYTBOTzB5bUdKSXJB?=
 =?utf-8?B?WXhVaHkyZzVrVHBiUnhiYUEwdmhudWQ4ckNiLzFyQVpmRU9VYnIxTkZWcFdI?=
 =?utf-8?B?enZmRytDNVBIN1hyL1QzN0pwUkNsZ3JmS09ST0tSYkJSd1pMK0FaMEZ5R2pw?=
 =?utf-8?B?MThjT0RuQlp3NTZmQTkxbCtoQkhldnB4MDVEQmt0M25FcCtHcWFWRTRhalF3?=
 =?utf-8?B?RHBMeTF3UWFtamtDMkRmMnMrZWhvdWVtYllTQktYcG9aVnhWWjhKRzYybVp0?=
 =?utf-8?B?MEF5VUdOVFgwbm5uS0ZBUXF6aFhoNzJaRjdHb2lTVnA5WDA5QWNJQUVhVzFJ?=
 =?utf-8?B?WXhFblMxZWJOSTRSNzJEVDc4WGpENENDUW1EMHlvc0h5cmV2dDU4N21LVDEx?=
 =?utf-8?B?a3NndkpvYUFBcEZQTngwTG5XV2dlYll6a0RzenpiSzNMZmdjeGNNNFh1dTJU?=
 =?utf-8?B?WllKcGxmSTRKb1hGSTF1Zi9zaFc5RkhGNCtWcnE4RTJ2TWJKSTQ2MmtlaG44?=
 =?utf-8?B?dXIyYVZvUGZXRWNMUzA5b0Jod3hDaGxKTDRvLzBLcndTcGxMTlhRcFVYNFlC?=
 =?utf-8?B?QzV1VUp5V2tkVUxaVE14K3BPalVueVVibXZJbU9ueU42cndJUnZGSFV1TnJT?=
 =?utf-8?B?ZmoxMjQxRmJxVWdzSzZBTncyVjJrOW4waURtQ0JjR2RDRGVEVllUZGNZUWR2?=
 =?utf-8?B?VXBmaVBtL0Z4YXo0TjBTSVBFQ2REV05Nc1VVVDJqNC81VFUzemRTSS9lQjBw?=
 =?utf-8?B?Y2FqN2xmb29YNzJ0RnVmd01DYm95QnJQT0RxcGpLNmk4L3EvMWFTNGVNdUN1?=
 =?utf-8?B?QlhaSnNXMjFCWmFVTGxVUE8vL29zQ3BOd2l2SVJ0OW8yMy9lSlAxWXhIVVhm?=
 =?utf-8?B?NUVULy9WdERvTURlK2FtRW1zZnZmTkxBOENramRhTHNzd3kvekk3dlNIb3d5?=
 =?utf-8?B?YTB6OUhWcXcrTnpDTW13bkpQNkJ0b1N1T3FueEhDdEZUUFNybVlBc2tPK2F3?=
 =?utf-8?B?eFlpeEN2dFJVdnFONFQ4NEoyNUl1N2tWWlZtQnc3UDFUSFBoNU5wYlZsUThZ?=
 =?utf-8?B?WWJYSDJNRk04VHZ0QzdrYlM5Z1dmRDRnRndpM1dwS2hKTit3Z2J0OTVQckFC?=
 =?utf-8?B?dEZRQjJ2R2syKy82ZWc5ZnlrTnNwMi90ZS9GUFJSd3RlalBuYkQyOW5mMkUz?=
 =?utf-8?B?dzRjeWcrRVluRkMvTjRDYVBjRm82Z202SFZBc211SDNicXlGZVVCYW9SeFQ0?=
 =?utf-8?B?R2craERVallwVDFickFJOUFzaDN3d0NRNlR6OEk4MkVFb1ZQVDdIVVNITmly?=
 =?utf-8?B?TkxIWlNuZTIwd3l4WHlMdGUvYUVNWnVFRWQzNWRsUngvUFlKdkprY2xnSDha?=
 =?utf-8?B?R2I1U2kwNUdIZ3JuVDVpNkkxNi9xR0Q3T044UDVEQlRjRUVsaEZCK0pZZUgx?=
 =?utf-8?B?Y1ZVbFd4eEpEUjZ6SU9rSit1ZWFJdVFjMHNOTUlaYnljTVgrZHVjM0VqNWkz?=
 =?utf-8?B?TkYvU1Z4TEZieUMwVnIrb0pNd2hSTFlHNmNaL0pTN2VsM3p5WWQweUgxZVZ0?=
 =?utf-8?B?S2ZCMVpjZjMyRWJtN2ZsSzhlS2ZCbCthdlBSbHNqaDY2THJSS1Y2YVpBbitH?=
 =?utf-8?B?QnIyUnBxOVU1MXhCZVhpdk9ZZnJWWHRYcklJZVhKa3ZKRXVSTUN3cFJVK1A1?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41BD024A5532FF4BB7E2C24922C13FA3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a85a8b-2b14-49e4-59ab-08dae22ff69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 02:14:45.4594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pN9ElarMnCQURwmo3BUyfMD+UL+jnEXF8JH8J/Ic2hgRMOswuR6m3h/0z599MaToQ5XnqTcKSib7IMfUTegYNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7123
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEyLTE5IGF0IDE2OjE3ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTYvMTIvMjAyMiAxMzozMywgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4g
PiANCj4gPiBXaG9sZSBzZXJpZXMgYXBwbGllZCwgdGhhbmtzIQ0KPiA+IA0KPiANCj4gQW5kIG5v
dywgd2hvbGUgc2VyaWVzIHJldmVydGVkLCBwbGVhc2Ugc2VlIGNvbW1lbnQgaW4gMS84Lg0KPiAN
Cj4gUmVnYXJkcywNCj4gTWF0dGhpYXMNCj4gDQoNCkhpIE1hdHRoaWFzLA0KDQpNYXkgSSBzZW5k
IGEgbmV3IHNlcmllcyB3aXRob3V0IGEgZmFsbGJhY2sgY29tcGF0aWJsZSBsaWtlIHRoZSBtdDgx
ODgNClZET1NZUyBkb2VzPw0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
bGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyMjEyMDYwMjAwNDYuMTEzMzMtMy1uYXRoYW4ubHVAbWVk
aWF0ZWsuY29tLw0KDQpSZWdhcmRzLA0KTW91ZHkNCj4gPiBPbiAwNy8xMi8yMDIyIDEwOjQ5LCBN
b3VkeSBIbyB3cm90ZToNCj4gPiA+IEZyb206IG10azE4NzQyIDxtb3VkeS5ob0BtZWRpYXRlay5j
b20+DQo+ID4gPiANCj4gPiA+IENoYW5nZXMgc2luY2UgdjM6DQo+ID4gPiAtIFJlYmFzZSBvbiBs
aW51eC1uZXh0DQo+ID4gPiANCj4gPiA+IENoYW5nZXMgc2luY2UgdjI6DQo+ID4gPiAtIERlcGVu
ZCBvbiA6DQo+ID4gPiAgICBbMV0gDQo+ID4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3Qv
P3Nlcmllcz02ODEwOTdfXzshIUNUUk5LQTl3TWcwQVJidyFnaVpWeThUaUZOeWxnV0tPakk3NWZT
bWxlTjZVbGNrUHVpWHpGZjVqYmRWZ0ZiSGRJeEczZDNKdmtxcDdFa2E3M0kyVG1hdGFEX2Q1UWp6
Qm5rNi1zWVkkwqANCj4gPiA+ICANCj4gPiA+IC0gU3BsaXQgZHRzIHNldHRpbmdzIGludG8gdHdv
IHBhdGNoZXMgYmFzZWQgb24gYmVsb25naW5nIHRvIE1NU1lTDQo+ID4gPiBvciBNVVRFWC4NCj4g
PiA+IA0KPiA+ID4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gPiA+IC0gRGVwZW5kIG9uIDoNCj4gPiA+
ICAgIFsxXSANCj4gPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTY4MTA5
N19fOyEhQ1RSTktBOXdNZzBBUmJ3IWdpWlZ5OFRpRk55bGdXS09qSTc1ZlNtbGVONlVsY2tQdWlY
ekZmNWpiZFZnRmJIZEl4RzNkM0p2a3FwN0VrYTczSTJUbWF0YURfZDVRanpCbms2LXNZWSTCoA0K
PiA+ID4gIA0KPiA+ID4gLSBBZGQgY29tcGF0aWJsZSBuYW1lcyB0byBWUFBTWVMwIGFuZCBWUFBT
WVMxIGluIE1NU1lTIGJpbmRpbmcNCj4gPiA+IGZpbGUuDQo+ID4gPiAtIEZpeCBWUFBTWVMncyBN
TVNZUyBhbmQgTVVURVggZHRzIHRvIHBhc3MgdGhlIGR0c2JfY2hlY2suDQo+ID4gPiAtIFJlbmFt
ZSBtdGtfbW1zeXNfbWVyZ2VfY29uZmlnKCkgYW5kIG10a19tbXN5c19yc3pfZGNtX2NvbmZpZygp
DQo+ID4gPiB0bw0KPiA+ID4gICAgbXRrX21tc3lzX3ZwcF9yc3pfbWVyZ2VfY29uZmlnKCkgYW5k
DQo+ID4gPiBtdGtfbW1zeXNfdnBwX3Jzel9kY21fY29uZmlnKCkuDQo+ID4gPiAtIENsZWFuIHVw
IG10a19tbXN5c192cHBfcnN6X2RjbV9jb25maWcoKS4NCj4gPiA+IC0gQWRkIGEgY29tbWVudCB0
byBtdGtfbXV0ZXhfd3JpdGVfbW9kKCkgYW5kIGNsZWFuIGl0IHVwIGZvciB1c2UNCj4gPiA+IGlu
IG1vcmUNCj4gPiA+ICAgIHRoYW4gMzIgbW9kcy4NCj4gPiA+IA0KPiA+ID4gSGksDQo+ID4gPiAN
Cj4gPiA+IFRoaXMgc2VyaWVzIGFkZCBzdXBwb3J0IGZvciBNVDgxOTUncyB0d28gVlBQU1lTKFZp
ZGVvIFByb2Nlc3Nvcg0KPiA+ID4gUGlwZSBTdWJzeXN0ZW0pLA0KPiA+ID4gdW5kZXIgd2hpY2gg
dGhlcmUgd2lsbCBiZSBjb3JyZXNwb25kaW5nIE1NU1lTIGFuZCBNVVRFWCBzZXR0aW5ncw0KPiA+
ID4gdGhhdA0KPiA+ID4gbmVlZCB0byBiZSBjb25maWd1cmVkLg0KPiA+ID4gDQo+ID4gPiBNb3Vk
eSBIbyAoMik6DQo+ID4gPiAgICBkdC1iaW5kaW5nczogYXJtOiBtZWRpYXRlazogbW1zeXM6IEFk
ZCBzdXBwb3J0IGZvciBNVDgxOTUNCj4gPiA+IFZQUFNZUw0KPiA+ID4gICAgYXJtNjQ6IGR0czog
bWVkaWF0ZWs6IG10ODE5NTogYWRkIE1VVEVYIGNvbmZpZ3VyYXRpb24gZm9yDQo+ID4gPiBWUFBT
WVMNCj4gPiA+IA0KPiA+ID4gUm95LUNXLlllaCAoNik6DQo+ID4gPiAgICBkdC1iaW5kaW5nczog
c29jOiBtZWRpYXRlazogQWRkIHN1cHBvcnQgZm9yIE1UODE5NSBWUFBTWVMNCj4gPiA+ICAgIGFy
bTY0OiBkdHM6IG1lZGlhdGVrOiBtdDgxOTU6IGFkZCBNTVNZUyBjb25maWd1cmF0aW9uIGZvcg0K
PiA+ID4gVlBQU1lTDQo+ID4gPiAgICBzb2M6IG1lZGlhdGVrOiBtbXN5czogYWRkIHN1cHBvcnQg
Zm9yIE1UODE5NSBWUFBTWVMNCj4gPiA+ICAgIHNvYzogbWVkaWF0ZWs6IG1tc3lzOiBhZGQgY29u
ZmlnIGFwaSBmb3IgUlNaIHN3aXRjaGluZyBhbmQgRENNDQo+ID4gPiAgICBzb2M6IG1lZGlhdGVr
OiBtdXRleDogQWRkIG10a19tdXRleF9zZXRfbW9kIHN1cHBvcnQgdG8gc2V0DQo+ID4gPiBNT0Qx
DQo+ID4gPiAgICBzb2M6IG1lZGlhdGVrOiBtdXRleDogc3VwcG9ydCBNVDgxOTUgVlBQU1lTDQo+
ID4gPiANCj4gPiA+ICAgLi4uL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy55
YW1sIHwgICA1ICstDQo+ID4gPiAgIC4uLi9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvbWVkaWF0ZWss
bXV0ZXgueWFtbCB8ICAgMSArDQo+ID4gPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ4MTk1LmR0c2kgICAgICB8ICAyOCArKystDQo+ID4gPiAgIGRyaXZlcnMvc29jL21lZGlhdGVr
L210ODE5NS1tbXN5cy5oICAgICAgICAgICB8ICAxMyArKw0KPiA+ID4gICBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstbW1zeXMuYyAgICAgICAgICAgICAgfCAgNjQgKysrKysrKysrDQo+ID4gPiAg
IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1tbXN5cy5oICAgICAgICAgICAgICB8ICAgMSArDQo+
ID4gPiAgIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1tdXRleC5jICAgICAgICAgICAgICB8IDEz
NQ0KPiA+ID4gKysrKysrKysrKysrKysrKystDQo+ID4gPiAgIGluY2x1ZGUvbGludXgvc29jL21l
ZGlhdGVrL210ay1tbXN5cy5oICAgICAgICB8ICAgNCArDQo+ID4gPiAgIGluY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1tdXRleC5oICAgICAgICB8ICAzNSArKysrKw0KPiA+ID4gICA5IGZp
bGVzIGNoYW5nZWQsIDI3NCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPiA+IA0K
