Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8D70783E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjERCxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjERCxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:53:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049521BC1;
        Wed, 17 May 2023 19:52:54 -0700 (PDT)
X-UUID: 12e13796f52711edb20a276fd37b9834-20230518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4nfBXvttgYvZ4ijEVcZtB+ewtbOmhcScK2a0/6dP2ME=;
        b=H+STxyFoYERtg6B0mukbZU2Vdeso2Uz2Hdt4RXMPC0nd5XLivRzzaGVuvJrg9WGpWGzkcOPdcn+Ujrog8hUl2SVSALQYUW150ffKO175SK0mhzg9qlwjLvO5/pgn7WNj0xZ/pZ2I3uJx9JGd+Hilzsau7ht3WaHeeJdo9XorPII=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:11b87b43-44d6-4cb4-b4b3-f42d541b4634,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.25,REQID:11b87b43-44d6-4cb4-b4b3-f42d541b4634,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:d5b0ae3,CLOUDID:12a135c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230517224322M5MJT5RU,BulkQuantity:8,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 12e13796f52711edb20a276fd37b9834-20230518
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 198978469; Thu, 18 May 2023 10:52:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 May 2023 10:52:47 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 May 2023 10:52:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdVeaY/ggYwhGq6/OxM9KXvu+6AeEbWdY0SkeQbeKun4b8/ECn3LztSmgmTKoMhJdbbme8st+/qCcavO8f2m94stTUQQmNnCmot8Yk4MQowfsEcUiq82RIfjJl5fflfTppzxQ8MTaJ4VG/iHfsep78qmX3VLAMItOPeQ5VJqOyyBE8VkKBv/eQDPaYhhyN5MhMIG1Kf6elqH/SSjCjL/okWgOKkKyp1r3VBusdnwnMtWdfVd9l0MpmN3YTwnaTpvg5yo40DLBQpPqESrUrMwB+M00HgerB/EkYjE5/2W9jqf4eATOCNP2LW6eS2DElslioBQh+pZuZ7pms61igpiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nfBXvttgYvZ4ijEVcZtB+ewtbOmhcScK2a0/6dP2ME=;
 b=mIdqzo+Ln5t8I84HL9fLfhgx7DAvCDnj4SbjLmKAkrQh7Kw0N7vnvv19LvUXBymuLCV/4BPu9UdcU28rrzE0BroCIuhkvXwcXQKkpwU0XyHj+umA/b6wdtbt+22oG0HibEM8cZqFeccvSul3g0YapHmPwiM6+k6LgNNaXlN2Ft7xN1YmWekVPr95jTS7sa3R73+iIlNMI+Hygv6X3b4TAgA0Dj4+wluBTLVh/gOdx1fT5V4kEGvZ9ONtewE7mAAcm8GN9aWMgWDIqH3xJXWKAM+v56cGV/ESxnqbpqVSdm4IN767l+l81I19vsZ6u18tI99q+/qFeL1S7e+6k64esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nfBXvttgYvZ4ijEVcZtB+ewtbOmhcScK2a0/6dP2ME=;
 b=Na1Ir2dZfORZvpwFzcxp+AYrV1dmECnpenFa4iBRbRaPp+GZGJ7IYqQT4VbNqSvob1ep2ELYjKn/fyk/lXurHEW5tKzUkKLtcY84bOrlWPmHhg3IiMUWUIXgOyQSPJq0YlPaZjGicipqyosAK0zL64amyy04V+uSqYicHWIMQfw=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by PUZPR03MB6103.apcprd03.prod.outlook.com (2603:1096:301:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Thu, 18 May
 2023 02:37:17 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 02:37:17 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
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
Subject: Re: [PATCH 5/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: update
 properties
Thread-Topic: [PATCH 5/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: update
 properties
Thread-Index: AQHZiLER+J8kyiQBOECFFm9zfiGEOK9einCAgADHfwA=
Date:   Thu, 18 May 2023 02:37:16 +0000
Message-ID: <d207670232288181171473d47536173a7aa47c75.camel@mediatek.com>
References: <20230517111534.32630-1-trevor.wu@mediatek.com>
         <20230517111534.32630-6-trevor.wu@mediatek.com>
         <9359c081-cd36-3e5b-a113-7600b4ba435e@linaro.org>
In-Reply-To: <9359c081-cd36-3e5b-a113-7600b4ba435e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|PUZPR03MB6103:EE_
x-ms-office365-filtering-correlation-id: a92319b3-2ce1-4f9e-ec22-08db5748cbbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w8QaBaC5uAJeIiSxaC2ZhycWE42iXgxE0i7DR4h8DKhrfdhzj0FFEdn2kmNreJ0NCErxhrMKA2MMUg5Y0FuxgB4162ETh6wo4n8Erwu85Ct/u6bn5fDQP8Iy4MWn5/QEba4GT5M9ldafndHWYEovyD8hXkVX4wMDE7VB+nsyLxLBhbm/DeaXKLNaGyOBNxyy66+brZxSUMzgWMJnyE1XUKttidCZo7J8bca9eZPivP1P+0wUGNLj2IxUS2pIv4MoUNMo5SOP43llmHjyLhoxnx/987g82fQKMstPA/OPoj98jA53e4GiH9qeY5QxWxU8YYRomseNb+qVNFZ6SFeY4FsKrpSNvg3wlBjl1JayPzb1YPoK8xemmPBho7gM9W+Px8F8NybDcLC/9j6ejYBH7mfczlnxTHCDMyEUG7ybr/QnxXTK0nF6+Lf370gj+dyznZjsTN46D7RgwMv+/N8sybZDBYZFlwLToAXXFY24vZQ5OcFA2hbzYqqPACVSzVGcVG234mqQUDLDpISpu3Ugdc2f74y5SOHG48V44ADPRsJwBnCwFAUuFTVn1NpUxPt2/qUH0ZrSZz04D3D/9OgHKwl2VXhnUU1LEKvntTRQZTYMeBSkCoKpqpNDHOOzSiO+t7GiBhDZpWqYSe5TmGXobpe7QW9OvmmXP5yAEST/b4o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(6486002)(38070700005)(15650500001)(36756003)(122000001)(921005)(38100700002)(86362001)(7416002)(83380400001)(2906002)(2616005)(71200400001)(41300700001)(6506007)(26005)(186003)(6512007)(53546011)(478600001)(8936002)(85182001)(5660300002)(316002)(66476007)(8676002)(54906003)(66556008)(4326008)(66946007)(66446008)(110136005)(76116006)(64756008)(91956017)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkFKM1pGQ1ZrbitKb0hOdWtUVVNpOEsyNmMwL2J5ZmtZd3BZcHo4di9CSTI2?=
 =?utf-8?B?YzJjaWZtZU9WSGlkSmg4dUowNVFQSmdaaWRDZUxwVE1ScjhDNjU3REQ0dDc3?=
 =?utf-8?B?QTNXWmJveFpta1VwQk5hU1FZaG1xMHNiV0MybkZpa2xxUjdCWVNORFVteEli?=
 =?utf-8?B?Mis2aDh2Rk84K3doWXV5NlN0azRXZng0NmI0SXdMRy9kMlRnWEh0M3Q0T1BC?=
 =?utf-8?B?bm5LdmxVdnNoUmZ6VGZRTDl3UmJNeGpZT241QW9LWGZKbkRMQStGb0xUL0gy?=
 =?utf-8?B?S29ZWUZ2TFpMaTZEaGFqaEszRXVVOHlsQkcwNEdLblhOWUNIc3h2blVxd1FD?=
 =?utf-8?B?RVJadXNKWUpDNm82MFEweVpjQjQ0U3YweVd4ZUt4SlpuM1pIWkhWdVMwcjZQ?=
 =?utf-8?B?N3JOUVJOdTZMSHJoLzV2UFFLcmUzVnM5K0t1dFh1YVJ5RS9TMGpJRkZOaDBn?=
 =?utf-8?B?dXIzdmxKYzdtQmV6ZVE0UTVrSXh3b2NFNWVUTStlZ0FKcUVPOXRJQkF2aDJ6?=
 =?utf-8?B?bW9DakNKNlZhU3gxa1M5WGIwSEEyVHY1dUVCcU9Qcng3Uy84a3lnd3lWTDFU?=
 =?utf-8?B?RThLak9hMm1QNGRWNUdkSTc5a01OdUY3bDduTHc3Zm9YSGxPWFMrTmR6NjVW?=
 =?utf-8?B?ZlVOU1hIM2FSaHFRV1VNVG9CN3ZGS3UwM2tPdWdXbVhqdFZKSklVY3RJemxT?=
 =?utf-8?B?OGNjQlJHYUd1eS9iS2lMd1FFRS9SajNaNk9jV2dFdCtua1JwTlpOeFB3TG9n?=
 =?utf-8?B?c2hwam1xR0FsTlpibm81OGVPSmhMdzdyaDdGVmtKYlYxbXVQZmxENDJTc2xt?=
 =?utf-8?B?MWxOSEtnaitKOFMxU0lBMEJEWnpqdkNZRW5kUTV3akVoS0NKWktGQ04yNDAx?=
 =?utf-8?B?Y0hxUkV0cUJGNTRQQTNNb3NySWROUTRSWkMzNDBVc2cxajJ1Ny8rMk5XMlMz?=
 =?utf-8?B?RWpWUnQybnhicUVVTy8wY1lUSVY4MzNHKzk4a0pQZzVpc1hOSkJNK202V1RN?=
 =?utf-8?B?WUtIbkJUVFlNbkhNMThuN21ZSUlBQmF1Z2pwZTRqa1RzQ1hYSjZKRzZBT0NX?=
 =?utf-8?B?QWhvdzZhL1BIYzFnVkFUU0lUNW5ZMzg0S1dsYmVONk53K3pkUzFoMmpaVDJn?=
 =?utf-8?B?Z09JQ0pxdkNaZTg1dDFYV1V3bG1hUnlnWEJoTmMyd2VJWWRUMUZIc2U3NHJS?=
 =?utf-8?B?K1ZNSnl3OVNqQlFmUjNaMnJ6bnNRdkdEM0J2UE41RUtmaEUvQU8za24vYk5n?=
 =?utf-8?B?MUNOelBlSFNUREhkRENMZElISXZnSVV6aXpPOTdZV2NIeis4VUJQYVFnUEVx?=
 =?utf-8?B?SFdqN1IwSXJWczVLWTgrVHdYdEYzMXlHZjhBUzcwWkxrcE1XS1h2MHNZVlRW?=
 =?utf-8?B?U2lFbkVkQUxwbzBkRzFpK1NCdHI1dzUyWEhuTDhFbFBWYTIrQVY0VVJxNW9G?=
 =?utf-8?B?ZHRybDV4RE1kL3NCOWdOUm8waDlEb3pRejJuRnh3M2hqajU4aW13MTFMUWZl?=
 =?utf-8?B?Y1hFcm9PWGg5RUZMNzV4SnpycVR1MmVpemxqV0YyMzVMSlY0MUM2N1hwcElh?=
 =?utf-8?B?eGFNbVltZzBHL2YwUThvbzBGMTdqSElJT052ZWViTmptTGp4UVR4NUM2dzNS?=
 =?utf-8?B?OHRoVlNxcWg0RWRMNEg3dk5VMXd6Sk1MTnVUKzExalJETWE4MHFnSy9Jc1Rq?=
 =?utf-8?B?KzFBQ2JJZkJXNFY4Vjhqb2xMV016eFVsWmhVNWZzeGtzTnJuTUVBYno3aW1j?=
 =?utf-8?B?SFp0eUJORUZpTzhMdGFBWm44SW5xaE15b3BSQ0pzdlIyWS9JK0c4M0FmdU9u?=
 =?utf-8?B?MUQwZlFnTno4YUtCYmZMd01NNkJmQzFFM2g4dm5lVmtJUE5DYWdwTmJCcUEz?=
 =?utf-8?B?b29HdlFtaW92Q0l4Nm1XMGcyeEZFUUlqaFIzenBCYmthTmlIREFOTHdsclVI?=
 =?utf-8?B?UXBTYUFobzFPN1p2cS9JdS9qY0FMMXpZK1kyWVVlM1gvUHR1VG4wNXo0dE5K?=
 =?utf-8?B?eUNkbmhEdHZRTW9aUSt5elZzaUJoVDN2RnJrQXR2MVBqY01oQkdlZkZGQ3pF?=
 =?utf-8?B?RXZJMHhocUVpZXpqMmpYcVhsNkxrRnpocHZ0VE1HMUhtY3lRR282T3AveHpm?=
 =?utf-8?B?Qkp3MzZzZTZUUjhxVnF0NFByRnp0eFZrbHBFZytKbFY4MlBPZGlhQWJLWXVh?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EEDC6E2D3787643B56877A51717ECA3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92319b3-2ce1-4f9e-ec22-08db5748cbbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 02:37:17.0254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHPIBIiuG2bV23ej788sSYeRuyjlDfsx44E9A9RqS1VWdflVyRg4z1bRypo5iFnc85T9Hz7ccQpwTHJiDJQIVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6103
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTE3IGF0IDE2OjQzICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDE3LzA1LzIwMjMgMTM6MTUsIFRyZXZvciBXdSB3cm90
ZToNCj4gPiBBZGQgY29tcGF0aWJsZSBzdHJpbmcgIm1lZGlhdGVrLG10ODE4OC1uYXU4ODI1IiB0
byBzdXBwb3J0IG5ldw0KPiA+IGJvYXJkDQo+ID4gd2l0aCBuYXU4ODI1IGNvZGVjLg0KPiANCj4g
U3ViamVjdDogZXZlcnl0aGluZyBjYW4gYmUgdXBkYXRlIG9mIHByb3BlcnRpZXMuIFJlcGhyYXNl
IHRvIGZvY3VzIG9uDQo+IGFjdHVhbCBjaGFuZ2UsIGUuZy4gb24gYWRkaW5nIE5BVTg4MjUuDQo+
IA0KT0suIEkgd2lsbCByZW5hbWUgdGhlIHRvcGljIGluIHYyLg0KDQo+ID4gDQo+ID4gQUREQV9C
RSBpcyB1c2VkIHRvIGNvbm5lY3QgdG8gbXQ2MzU5LiBGb3IgdGhlIG1hY2hpbmUsIGl0IG11c3Qg
YmUNCj4gPiBmaXhlZCB0byB0aGUgc2FtZSBjb2RlYyBhbmQgY29uZmlndXJlZCBvbiB0aGUgbWFj
aGluZSBkcml2ZXIuDQo+ID4gUmVtb3ZlDQo+ID4gQUREQV9CRSBmcm9tIGl0ZW1zIG9mIGxpbmst
bmFtZS4NCj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUganVzdGlmaWNhdGlvbiBmb3IgdGhp
cy4gSWYgdGhpcyBpcyBub3QgYQ0KPiBjb3JyZWN0DQo+IGxpbmsgbmFtZSBmb3IgTVQ2MzU5IHNl
dHVwLCB0aGVuIGl0IHNob3VsZCBiZSByZW1vdmVkIGluIGl0cyBvd24NCj4gcGF0Y2guDQo+IElm
IHRoaXMgaXMgcmVtb3ZlZCBiZWNhdXNlIG9mIGFkZGluZyBOQVU4ODI1LCB0aGVuIHdoeSBkb2Vz
IGl0IGFmZmVjdA0KPiBNVDYzNTk/DQo+IA0KDQpJbiB0aGUgcGF0Y2ggc2VyaWVzLCBbUEFUQ0gg
MS81XSBkaXZpZGVzIEFEREFfQkUgaW50byBVTF9TUkNfQkUgYW5kDQpETF9TUkNfQkUuIEkgd2Fz
IGdvaW5nIHRvIHJlcGxhY2UgdGhlIGxpbmsgbmFtZSwgYnV0IEkgZm91bmQgaXQNCnNob3VsZG4n
dCBiZSBjb25maWd1cmVkIGZvciB0aGUgbWFjaGluZSwgYmVjYXVzZSBtdDYzNTkgaXMgdGhlIG9u
bHkNCmNvZGVjIGZvciBBRERBX0JFIGFuZCBpdCdzIGhhcmRjb2RlZCBpbiB0aGUgbWFjaGluZSBk
cml2ZXIuIEFzIGENCnJlc3VsdCwgSSBkZWNpZGVkIHRvIHJlbW92ZSBpdC4NCg0KSSB3aWxsIHNl
cGFyYXRlIGl0IGZyb20gdGhlIHBhdGNoLCBhbmQgcHV0IHRoZSBuZXcgcGF0Y2ggYWZ0ZXIgW1BB
VENIDQoxLzVdLg0KDQpUaGFua3MsDQpUcmV2b3INCg0KPiA+IA0KPiA+IEludHJvZHVjZSB0d28g
cHJvcGVydGllcyAiZGFpLWZvcm1hdCIgYW5kICJtZWRpYXRlayxjbGstcHJvdmlkZXIiDQo+ID4g
dW5kZXINCj4gPiBkYWktbGluayBzdWJub2RlIHRvIGNvbmZpZ3VyZSBkYWktbGluayBwYXJhbWV0
ZXJzIHZpYSBkdHMuDQo+ID4gDQo+ID4gImNvZGVjIiBwcm9wZXJ0eSBpcyByZW1vdmVkIGZyb20g
cmVxdWlyZWQgcHJvcGVydHkgb2YgZGFpLWxpbmsNCj4gPiBzdWJub2RlLg0KPiA+IEZvciBjby1j
bG9jayBjYXNlLCBpdCdzIHBvc3NpYmxlIHR3byBkYWktbGlua3Mgc2hvdWxkIGJlIGNvbmZpZ3Vy
ZWQNCj4gPiB0bw0KPiA+IHRoZSBzYW1lIGZvcm1hdCwgYnV0IG9ubHkgb25lIGRhaS1saW5rIGJ1
aWxkcyBsaW5rIHdpdGggY29kZWMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJldm9yIFd1
IDx0cmV2b3Iud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vc291bmQvbWVkaWF0
ZWssbXQ4MTg4LW10NjM1OS55YW1sICAgICAgICAgfCAyNw0KPiA+ICsrKysrKysrKysrKysrKyst
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC0NCj4gPiBtdDYzNTkueWFtbA0KPiA+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC0NCj4g
PiBtdDYzNTkueWFtbA0KPiA+IGluZGV4IDY2NDAyNzJiM2Y0Zi4uMDVlNTMyYjVkNTBhIDEwMDY0
NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRp
YXRlayxtdDgxODgtDQo+ID4gbXQ2MzU5LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ4MTg4LQ0KPiA+IG10NjM1OS55YW1s
DQo+ID4gQEAgLTExLDcgKzExLDkgQEAgbWFpbnRhaW5lcnM6DQo+ID4gDQo+ID4gIHByb3BlcnRp
ZXM6DQo+ID4gICAgY29tcGF0aWJsZToNCj4gPiAtICAgIGNvbnN0OiBtZWRpYXRlayxtdDgxODgt
bXQ2MzU5LWV2Yg0KPiA+ICsgICAgZW51bToNCj4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxODgt
bXQ2MzU5LWV2Yg0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE4OC1uYXU4ODI1DQo+ID4gDQo+
ID4gICAgbW9kZWw6DQo+ID4gICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy9zdHJpbmcNCj4gPiBAQCAtNDIsNyArNDQsNiBAQCBwYXR0ZXJuUHJvcGVydGllczoNCj4g
PiAgICAgICAgICAgIHdlIGFyZSBnb2luZyB0byB1cGRhdGUgcGFyYW1ldGVycyBpbiB0aGlzIG5v
ZGUuDQo+ID4gICAgICAgICAgaXRlbXM6DQo+ID4gICAgICAgICAgICBlbnVtOg0KPiA+IC0gICAg
ICAgICAgICAtIEFEREFfQkUNCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
PiANCg==
