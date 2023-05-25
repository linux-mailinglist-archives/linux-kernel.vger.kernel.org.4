Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A260710333
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 05:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbjEYDIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 23:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEYDIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 23:08:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF00A9;
        Wed, 24 May 2023 20:08:09 -0700 (PDT)
X-UUID: 5cf01e9cfaa911edb20a276fd37b9834-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gNZQ0zMLisIO/G1iJFZ6o2dj9gsy7vnWeydk97axLqI=;
        b=PKWM9C8XVpNHsuG7+1nb+U2NAXON8ci6a0fmTBqCkDdxd3L5nKjGGGPgDzV+rLe8nv36f9/Z3yGMa+bxzti/bqda3jDnSHtsEaTVvmAz966khlIg/TzDaIw/aJZTrj9vPpWNKbS7wn0FCcTzjjxX06nhrecugM4Bbed4e2X/nC0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:7735dc06-2bba-4349-ab3b-a32d7c50b00c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:7735dc06-2bba-4349-ab3b-a32d7c50b00c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:c8fd793c-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230525110805QTMN86RC,BulkQuantity:0,Recheck:0,SF:17|19|38|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 5cf01e9cfaa911edb20a276fd37b9834-20230525
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 475699341; Thu, 25 May 2023 11:08:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 11:08:02 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 11:08:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8uAh1XPMP26/KbM1bpmmge0FtNe4eJmQkYe1m0eg+5AgjrYjr82cG6/g+GXMZdEd40YXD/GHBN0ZFJ91WrAXbtd83jScNcAZk0wrJkRym4fYvjpZL40fyEATv0ENgNf+JtMdyTM8r7EYu7OhhIt63d1Ef5yWdh0Y47YtbYRxMgZmuRbWtPXmWKEh5OMej4bJ1i9awY6zq04Q7wfhQmTQ5SM1TpvxYeTyVwVuTNlsL9jzXOmUxCrSdktEhXaGcvqMqiiNSPy29z7inY/tb93on+opw9rlE/tsMcjf5aXxeivCxLyX/H6Z5hqMBAOvqoHQabJl4XExyUVY5a08HZM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNZQ0zMLisIO/G1iJFZ6o2dj9gsy7vnWeydk97axLqI=;
 b=ZWjilD9sixOWAAT3OuMegxODUadSfWrpoymniW+LDqzYY+xObZ8HAYebDry6bHzMlnNkM9UKA9iBexf7MQ5ml8r4JYa6/YgxDgdmZmpC2923cZlvPhwAm5DBlXmZ0utoXukSw+e+uqAqzolr+HOIRAIT4NSZB4gpx+xcPWZh3Gj70HvDaBFE8THFDuokypXZZBmsT1qzG2BdflXPqRTVxiHp4zlDsfNnLOXtHOu9PNHPwdZ2SsUC5kbdbnbXIlckz/QnitRxE3fGhdFVbmVtzI5lMSfQSHONkk20LHfVMtGqNNyuJ2Nfu08N2jbN/ZVVddjz2Xcr6Ce/N9a3GOw73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNZQ0zMLisIO/G1iJFZ6o2dj9gsy7vnWeydk97axLqI=;
 b=c/CMOUCoRXVTfVdi5kp3BwiDY361sI2daXUoXiNGH/RjoifbAlRkcv+L+QiUxsOnhjU9+a+ymmCrAHW7+YI3s7aHTHR7WnBGQ7L7l8kxp77JovvSzesmBzeJFqVE8lc92sNsSxJvzANzXz4LO7spjYVYMi/tS0ODmzOWQlTRN6o=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SEYPR03MB7779.apcprd03.prod.outlook.com (2603:1096:101:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 03:07:51 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6411.031; Thu, 25 May 2023
 03:07:51 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] ASoC: mediatek: common: soundcard driver add
 dai_fmt support
Thread-Topic: [PATCH v2 4/7] ASoC: mediatek: common: soundcard driver add
 dai_fmt support
Thread-Index: AQHZjR0k0X0YB/mgCUW7HWVQCmQB+q9peVuAgADYmAA=
Date:   Thu, 25 May 2023 03:07:51 +0000
Message-ID: <70fdc45e5b8b07f9b892a299eb0ba6e5255aa1d7.camel@mediatek.com>
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
         <20230523021933.3422-5-trevor.wu@mediatek.com>
         <cb2e035d-2630-2eca-3f15-b04e4d81c699@baylibre.com>
In-Reply-To: <cb2e035d-2630-2eca-3f15-b04e4d81c699@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SEYPR03MB7779:EE_
x-ms-office365-filtering-correlation-id: 45fdc78d-8f37-400c-829c-08db5ccd3a2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sfAZE8iivX75auulU5I4G3jhhtUUrJ5c4rxfTlRVyG2z54SLu+vhXIxNCSxk7c92rxMLtMg0EFV3OFUy1qhpwTqLyBXi1Qvv8WziNnKOQFvefr9V8cT89Asxpb377415jKlYUr7hSaa3oSeCECToNkfEiAzqHXzKyivd6OSypfHdkGS6Oz4TKpPloChDLZt/qv/ZlwvRqgZ/mau90sCsoLhFReD8TC4uuKvOATM3IPkgpWvoynxZZ6mmMXu1j4T1gOlCbA+uJXtephTIaFtPR8tJdp3ZPrpwcSyx6MEw/IzIWBfgpXpenltxPCgXQA+r/gJ3UBqQrO65ZJAwFczY5RsA5mhxr6UmUbDkRi53rFrWA3VGa706LHZ6yPiFvTWu17xgO9cOjzMxDBE/lH37pYlcol2Es8HZlxMcD48O/QmmQ69X96x3/a/UgofWeMKMdjZArf7gg/B8ey0E94hx9rEDGm0CijrAds+aJOYx7NYNSeHSslcyd1WzKpqupa+2TGreaOQe/uGltDVoJHMNr3dhhIKgpY7CZQ0W/1P0SIynA1R2Kb8dXnkcz7NYpUbSLYi2YJBUO17mieJi5DgsrQXus7BvhYzsCdSQpkd9UOuyO7Q+Az7TEJSxNDtSrk/MTA8nmRRZbiB4cN+dnqB3LX7GyJKZPHHFH9t6AFuSpc2zguq95aL/X48850Jh4tvOEdDQri1M7MhPJORlVB2QOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(110136005)(478600001)(66946007)(86362001)(66556008)(66446008)(66476007)(122000001)(921005)(54906003)(38100700002)(83380400001)(38070700005)(85182001)(2906002)(6486002)(36756003)(2616005)(91956017)(76116006)(64756008)(316002)(4326008)(8676002)(8936002)(7416002)(71200400001)(66899021)(53546011)(26005)(186003)(5660300002)(6512007)(41300700001)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXVjQjEyQ2RPcStQcXByVGs5KzlHdko3L3FhODBwcysxNzFpVGZzbENjZHd0?=
 =?utf-8?B?NkhCaG5XOHVDczVtSE1EblVvWTMvUWY4Y0FEZUV6VGw5dlVvdFhTWnBMY1RR?=
 =?utf-8?B?MGdRbk9Hdm5RM1FXNitxUzh5Um1rUnZ1bnhhemZuZ3R3NDB3VXl5UGltb3Jz?=
 =?utf-8?B?V09aTUNmb3lvMUJWQm5zdk8wZFovd2s5K29KZUlucTdsNTl3ZFBMalloZExr?=
 =?utf-8?B?LzlDWU5HTDVJWEluVk1GK1B6dUxLTm5MV0IwY0J3RnNpTmo4ekdHZUIrUndl?=
 =?utf-8?B?S0VDV20vOG1GbTdadVhPMGxEVnczMXZMRDlpN2ZMNG9YSytkOXRqV2MyVmMv?=
 =?utf-8?B?M3hsNWFjSGhaUFFhOGpWRnhGVGtDQ09oUjZ2VDBJUGhiVStnQmFZQnRTaHg2?=
 =?utf-8?B?TGxDN0xsc1F1T3lXM0trdlhiWlc0dUxPaXlHdk4xWit5cHQvUFBsZ2ttMGZp?=
 =?utf-8?B?ZEJIbHdtN3V2eXFyR3BHWkovK1pINGdZOHNVNFlWRmVTbzBZempmQlM1aGFk?=
 =?utf-8?B?WWhWbGpidStnWXpRN05IYlArZFkwSmJpakxPT0wzbGMzNnIvdDdBS1FoTFgw?=
 =?utf-8?B?UHIxYnR4U1RGVUppYXBMQW9CaEJOWVh4MzZIbkRGQk1YYnlLeUFpVXQrKzBK?=
 =?utf-8?B?dnFlRkhYdkVjdkpmSnNFSHMzNnNvM0YzNzZ4N3BVdkp6ZnB5eGlSeVdsOXR4?=
 =?utf-8?B?RVBkZ2QvclBKejFLdkZmTVZkR0l6OTk5V0E2RjRaWHQydDF5QkFLMnJLcHoy?=
 =?utf-8?B?SzB1V2VEMEJLTi9id0oxSjZ4OUY4MlBoZTIvSHF0eGlMQVJTcjNKZ3ppUkR3?=
 =?utf-8?B?UitHbHErRU15RnNtWEVsU0JRQmZ6M1VFZHk1VnR4N21VMDBrd2h3dFVJOVBr?=
 =?utf-8?B?VHgzVFkybC81L3o2dVhjOUFuc09zNGxhcWpFbm9vRUNaZ1JvRDRwSkN4bi9K?=
 =?utf-8?B?QTJuQ1Z6SmhEYlhuZFd6eG55Y0NjdFhuOHduRm9xWnhqamJNMnNmQ3ljU1pO?=
 =?utf-8?B?Q05yZHNNem9VUGlXUGhHelQ0OTgxK1pHRTFtVVRrZDFxOG9vMGdiYmJSRlJQ?=
 =?utf-8?B?S1dKN2VxY0J3SDBJOWdPVTMzeUljWE45WkVuZ1V5a1hwdEJOQU12QWU0enZ1?=
 =?utf-8?B?bXJ3Mnc1QzFMVytXY2RPKzA5bHpxZ0EzYWpwdXNVblp5OHdjMG9YLzR2NkdG?=
 =?utf-8?B?dE5vRDBLeFJuWmdOMEdhNGhTQ0F3Yi95ZjBQVFgzaFJSSHhudDFRSVpPd3p2?=
 =?utf-8?B?dm8vUWQyb0ZIaDJYc0ZQQXF3eWppdlZudjRlNjRxazdVRnNXM2pqZzRiTnp3?=
 =?utf-8?B?aTU2Y05iekRaWWpnQkU4U3VVUzFRWFJNWnptYVNpcEUzT0FGVElFYUpZQ0pq?=
 =?utf-8?B?RG5vbitqQUcrNDhtNHJqMUZlK3U3a3k2MktjUGlUMnFLcktqamhtNnNuSldt?=
 =?utf-8?B?ZXFoL1hZY1FsdEVnd1ErS2tublZiL2c0cVlsa3pMWkRRRU5CMzhjK1J6eTJl?=
 =?utf-8?B?R1NFZW5tQ1c2aG5PYmFwcGhyQ1RkSlY2YkFTcmhSeW1BQ2loeTZ6TDBOWHh0?=
 =?utf-8?B?Nk1nOVA3Y0lSS3I3aG9zQXFXM1FGNWhZMldVaUFZSnQySUIzVUVUTjg5aFBw?=
 =?utf-8?B?eWdhZXF4QkNwRTVnWU5pUDcveFROQldhMEJseHpDRnJQTk1GS3o5VG4yR3gz?=
 =?utf-8?B?bXhyMGNEOTJiZytIRGlqay9wR0xzNGdjZVhtU1RRUHNSMDZEQmxaOFRkeGM1?=
 =?utf-8?B?VXFGSnZDYWY2K3VJMzJGUFBycVEvZWYzdjAxMS9Mb2p3eFpLaGJ5TyttdjNT?=
 =?utf-8?B?dFBPbVh1eXljaGhQcVhIRVN5dE9pY3FCUFVNbXFnZkpqbys2a05uU2pYWGRh?=
 =?utf-8?B?RXV6NVRKWjFReEUzUW16c0lsZkhOSEV5TXBOVVZkdkhJT3V5TkJCaXF6QnM3?=
 =?utf-8?B?UEprQ3BLU2NqVU1teDBhWUhwRGdRUWZPd1hOUkYxNm9Rc1liVXk4MnFQSHo3?=
 =?utf-8?B?N1ZHSXJvZkFabXRiVkd5WmVIRG5vVVA3Z3NOcXphRURlNmJwMEQ3UDRPaVh2?=
 =?utf-8?B?SnVmZVhuSnJyZDNxNnVjTXc2MGFNWHg0dElHcDRCd0xBUDlMRHJMWXBMdEZl?=
 =?utf-8?B?SjdjSEZuSG1DUno2VXV0K2labHZYaGprUmM3dTVFSEVUYTV0SGN5eWd1K0pF?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <411F576B4DC2454C81F1D954C0C73712@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fdc78d-8f37-400c-829c-08db5ccd3a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 03:07:51.6815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bg2RsEvw3IIuggvfxfXJNRe0dRlKa9Hh3JXm45gcfyOBTGY43JmUOYhcwkhlG3+F/f8z1uLuJRzdRAuDGnTWTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7779
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTI0IGF0IDE2OjEyICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gT24gMjMvMDUvMjAyMyAwNDoxOSwgVHJldm9yIFd1IHdyb3RlOg0KPiA+IFRoZXJlIGFy
ZSB0d28gY2hhbmdlcyBpbmNsdWRlZCBpbiB0aGUgcGF0Y2guDQo+ID4gDQo+ID4gRmlyc3QsIGFk
ZCBzZXRfZGFpbGlua19kYWlmbXQoKSBmdW5jdGlvbiwgc28gZGFpX2ZtdCBjYW4gYmUgdXBkYXRl
ZA0KPiA+IGJ5DQo+ID4gdGhlIGNvbmZpZ3VyYXRpb24gaW4gZGFpLWxpbmsgc3ViIG5vZGUuDQo+
ID4gDQo+ID4gU2Vjb25kLCByZW1vdmUgY29kZWMgcGhhbmRsZSBmcm9tIHJlcXVpcmVkIHByb3Bl
cnR5IGluIGRhaS1saW5rIHN1Yg0KPiA+IG5vZGUuDQo+ID4gRm9yIGV4YW1wbGUsIHVzZXIgcG9z
c2libHkgbmVlZHMgdG8gdXBkYXRlIGRhaS1mb3JtYXQgZm9yIGFsbCBldGRtDQo+ID4gY28tY2xv
Y2sgZGFpLWxpbmtzLCBidXQgY29kZWMgZG9lc24ndCBuZWVkIHRvIGJlIHNwZWNpZmllZCBpbg0K
PiA+IGNhcHR1cmUNCj4gPiBkYWktbGluayBmb3IgYSBzcGVha2VyIGFtcC4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gICAuLi4vbWVkaWF0ZWsvY29tbW9uL210ay1zb3VuZGNhcmQtZHJpdmVyLmMgICAgfCA0
OQ0KPiA+ICsrKysrKysrKysrKysrKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9tZWRpYXRlay9jb21tb24vbXRrLXNvdW5kY2FyZC1kcml2ZXIuYw0KPiA+IGIvc291bmQvc29j
L21lZGlhdGVrL2NvbW1vbi9tdGstc291bmRjYXJkLWRyaXZlci5jDQo+ID4gaW5kZXggNzM4MDkz
NDUxY2NiLi41ZTI5MTA5MjA0NmIgMTAwNjQ0DQo+ID4gLS0tIGEvc291bmQvc29jL21lZGlhdGVr
L2NvbW1vbi9tdGstc291bmRjYXJkLWRyaXZlci5jDQo+ID4gKysrIGIvc291bmQvc29jL21lZGlh
dGVrL2NvbW1vbi9tdGstc291bmRjYXJkLWRyaXZlci5jDQo+ID4gQEAgLTIyLDcgKzIyLDcgQEAg
c3RhdGljIGludCBzZXRfY2FyZF9jb2RlY19pbmZvKHN0cnVjdA0KPiA+IHNuZF9zb2NfY2FyZCAq
Y2FyZCwNCj4gPiANCj4gPiAgICAgICBjb2RlY19ub2RlID0gb2ZfZ2V0X2NoaWxkX2J5X25hbWUo
c3ViX25vZGUsICJjb2RlYyIpOw0KPiA+ICAgICAgIGlmICghY29kZWNfbm9kZSkNCj4gPiAtICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiANCj4gSU1PLCB0aGUgZGVidWcgb3IgaW5mbyBw
cmludCBzaG91bGQgYmUgd2VsY29tZSBoZXJlIGJlY2F1c2UgdGhlDQo+IGJlaGF2aW9yDQo+IGNo
YW5nZTogZGFpIGxpbmsgaW5mbyBwYXJzZSB3aWxsIG5vdCBzdG9wIGlmIHRoZSBjb2RlYyBub2Rl
IGlzIE5VTEwuDQo+IFRoYXQgY291bGQgaGVscCB0byB1bmRlcnN0YW5kIHdoYXQgaXMgaGFwcGVu
aW5nIGR1cmluZyBpbml0Lg0KPiANCj4gDQo+IA0KPiBSZXZpZXdlZC1ieTogQWxleGFuZHJlIE1l
cmduYXQgPGFtZXJnbmF0QGJheWxpYnJlLmNvbT4NCj4gDQoNClRoYW5rcyBmb3IgeW91ciBzdWdn
ZXN0aW9uLiBJIHdpbGwgYWRkIGEgZGVidWcgbWVzc2FnZSBoZXJlLg0KDQpUaGFua3MsDQpUcmV2
b3INCg0K
