Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D226451A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLGCB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLGCB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:01:26 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25DC532E7;
        Tue,  6 Dec 2022 18:01:24 -0800 (PST)
X-UUID: e357018755744ddaaab301870eb331e8-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uO6+aj0KpruzjHO8ZXpVrKEyOLf6tIX+XpXGJvQN7nY=;
        b=TaF7x04PSuUvCMVnEnADUoDWO6mSIwvtsadlAkQC8iirljO2N1eHXsNCHl4vX8AGLDszkcBFjVTaW3jRQ8UsjnDxfQr1LZ06rLsWX1Y83CzTI/p1HU3EoQ1mRakbRynjnWonKIL8erJ57D2+K2KEp00ohGs5F6XCVtn6dmVdb4g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:88d2c795-6297-4fad-96f0-ba247c9eaea6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:3720d9d1-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e357018755744ddaaab301870eb331e8-20221207
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2011148207; Wed, 07 Dec 2022 10:01:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 10:01:18 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 7 Dec 2022 10:01:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYZHw0oOYMSXYPL3IHkGqDcrny/NQSuOiHg0g0LhYd/TbqZVIZEgqmK7r3HGJj4aPkLPmaFTVW5nq7ngtO2Ny1KTRarsq+nXsMmWLw9e+GLTRtWDPeDSbGoUBI/S1xMyixyVEvGEG0bldHue++SKhO0iP73OaxceR5FhpbFGkn3RhJ0UjwBYaRdCjs/XMkJVp6AwLGXBPin1l0xren2cKKO1i8otA0SKM5h/kDreklzrWvR3neFC/w7kECNGfGoDpnyE8vwzewisWK+uB6vcfUKixyzypBRskQGL39Ro4z7OpAkq+sJUW5oijrTlvZ+q+AC0S5IrPS8LBR1FCcZzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uO6+aj0KpruzjHO8ZXpVrKEyOLf6tIX+XpXGJvQN7nY=;
 b=U6tHqvxA7+edp+IXhphDkf021WAmhNW/RBEXM705UcIS9uJm07KUcnqqvRo3GGxujGhF13q0O6+3gJNK+3vX/yY5g6GC3ZTTwOJ2hm4QoTYhZfc+AmsdUC/or7JU7L2gp874/+vqF85Js+2nKEk2BM/760Og6DUCQBQz7PySY63GJ0+OPjwaVfypRgVBW/b8xEJeq0hlouIKc5d70OvGw+bbiy/mVk7HAVEwGmCWi6uPzn6dOeGmcht9bMAMPUsqg8O7/FkQdyhzGCdBVxDZe5OtP9ygOiNKwaQHU4YfhomtQli5JvtC5uYRJpYjE7XFD9i1UaTM9DXiy85OsWixXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uO6+aj0KpruzjHO8ZXpVrKEyOLf6tIX+XpXGJvQN7nY=;
 b=kcCYpiZHLBvxC0D5xN0y0IdbB4c2ZLrKD+aOF9ccajb0PpfkB5Nq5FQMTcIdzWpcDPcuT102ihZ/DGamRQewDg+hFpd/PKRZze85IJGiMiDcV5X48OYem7O383lEEXPQyEx+4+dBupcUidtcaxM5NdIOJu2RMriJ6fPnBnZBKa0=
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com (2603:1096:4:84::10) by
 TYZPR03MB6953.apcprd03.prod.outlook.com (2603:1096:400:28f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 02:01:15 +0000
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7]) by SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 02:01:15 +0000
From:   =?utf-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <Benliang.Zhao@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>
Subject: Re: [PATCH v2 4/9] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
Thread-Topic: [PATCH v2 4/9] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
Thread-Index: AQHZCHbyAHieoWCHukSx2RlxcIaKz65fWMOAgAE52ACAADcpAIAA5OAA
Date:   Wed, 7 Dec 2022 02:01:15 +0000
Message-ID: <fb7a26a5c3456796e6388dd2b6e952303a984cf5.camel@mediatek.com>
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
         <20221205065756.26875-5-xiangsheng.hou@mediatek.com>
         <50ede482-7f03-ff55-5ad0-aa6249027cbe@collabora.com>
         <149100d0dc205a317ed352cdfb391f2147a2afab.camel@mediatek.com>
         <b55ee8fa-7ad6-3bf9-4983-41a90bd75ce4@collabora.com>
In-Reply-To: <b55ee8fa-7ad6-3bf9-4983-41a90bd75ce4@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4565:EE_|TYZPR03MB6953:EE_
x-ms-office365-filtering-correlation-id: 8a967849-6283-420f-9832-08dad7f6ec6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vtnpBe4L8zcBRpFeG7XyPn7Swk2LIINXyuAHRNRQLMKrdAdv5VbTd2pdohTm8fKPaSe1u5nW+zkGirpYM8kLV62j53y46EhxDly4XoWDTtUTZB+QGaHKLuJlj+9uHf79MqJ+CDS4mO8YV+XYJVlb46Um74SRJYbZq7VRkGag5d2uqib4EC+KWMXU6Zi14X916cdWFScbSx+Yze2a2iWDE3I5JB42FtwgXjBgU3/vudNsRli71ev75RuByKKxkIwwbgOxFS509kyON3COYeHfGai+ktpTYihGQfK5pXc1KpNIcCW0Op0bU9mqJQ2M6m49B3qjy153DUD5bQvouohHUUeAeDq9PGxFAEMQL2gUr1cae5Ghscx/LDM9uD0/ILFXrRGrSSQ5PCbQJeWicOM80qbvoRymW+/rdzxXKuHyLXFRgXhJQW1idm3AJ+o43ybezY1cENpZbNr20wNCi+a90nr3doDw6375Ye15X7YooXpkC1HilJck8EZCVqykbWp8a/JQAJ+b/E4USKcORR+zt7E5e0kvnB7l3vpmqxIZX++yV8CBYI0QT/BiGFYZAgNk0Uolts47ljUIJw2sQm72oPat5LWEOeRHe10UesMCxKM9mlmKpBKNCXmxF2LBM055LTlqqD7mvfNMLYIQ0krneKvtJHCxSnBitwWCIqnDBUWlQtsLGmwb9DaBrVCtq6ld1VIb+olz/eZp3jVCP0xBNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4565.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(7416002)(6512007)(8936002)(26005)(38100700002)(6486002)(6506007)(107886003)(71200400001)(76116006)(38070700005)(36756003)(66476007)(8676002)(85182001)(66446008)(66556008)(4326008)(478600001)(64756008)(66946007)(5660300002)(41300700001)(122000001)(110136005)(2906002)(86362001)(54906003)(316002)(2616005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUQ0UjRpNUlQSlhyYSswdnJ0MzZDdVBiOU53bXdZWW51cDl1SGlsUEhmVmp5?=
 =?utf-8?B?VEZUTW9ZWGdDSDR1ZzQ1MVZBUmpzU1dHd0pyZHBuUEVxQlZqQUJoQlhYbWo1?=
 =?utf-8?B?TW42bmJEMUhSZVBGbXgxbzltVUdUYXp5Y2c2L0FpTlhhTjVPd1BNaTZiK3Ix?=
 =?utf-8?B?TFZMV2xxNHR5RVZVUFd3UDYybk93M05TdURTYkhVNUQyazBYeS8vSTZwdzRX?=
 =?utf-8?B?ZXhKTU5MTFU2UjM3YXE0aFZ6RFB4Zzhsd2Y5UEE2TEw3cXhUTzJiUHRFWWlz?=
 =?utf-8?B?UXNSSnFienViQ0czTTFIa2JFVGNHSmJ0dmdUWkQ1Yjdib2tQSGFzMUFwckJK?=
 =?utf-8?B?emFJZ0hPR2w3WlozSUMvUmxqNnBQQVl3aVo4YmpuMHV0a1VZVDFhdERFcnZn?=
 =?utf-8?B?MkZEc0RwbWlXMXdXUzcwNmEvQlFsMkRJNDhxb2xlMW9tZWRsK1UvNXR3RXBz?=
 =?utf-8?B?RUJEUmdodGcyU21haTlEcktqTk1WWXY0MXlSS2c3cEZpWC9MbnJ1R1BBMlpz?=
 =?utf-8?B?ZTdYbTV4aUY5aXVwSVdxZWcyeUVxM0JuaTNMV3Y0UFB0dE85NFpCR0NTK2hx?=
 =?utf-8?B?RVhjeVBZTm5EdGlOTjZsTzhYZjhTSTN0cVB0ZmV1VjBUSUNwYVdwT3BQbzE0?=
 =?utf-8?B?ckhycnI1NFFybXlVQUVTR0pWYTFMekRsYXQvSmpmcVZyVHJWS1dCczZCMmhq?=
 =?utf-8?B?Wmt0WnpYVUwvOXgzTzh5OG1KeFB1SWpvdnhld2laMGlPUVZxbUhuTHpTbVAz?=
 =?utf-8?B?Ui9sTHczNkhYMVJpaU4xL1UzZ1BxblYyTFNnUmdCTnkrU1VOVldXYlN4MFBY?=
 =?utf-8?B?ejNzZG5XaDAvNnBYdTJ3amxnTDl5V0cwam9lRjhmRFo3TkxNMEh2RWV3aTJH?=
 =?utf-8?B?bkV0RW1rQldxTTN4RjRTSitPYy90NWkxbmoyWHlUTG5HT00zQWNRazRtT1Qw?=
 =?utf-8?B?b1hPWG1sUU5YZXZqaTRwWUkwNGVZODJDV3V0VkF0SjRDOEI1YzhPL1YwbDVN?=
 =?utf-8?B?azQxQ0FSWnEwRWhsQ1U2cFF0RW54NFUvSTVBUThqUG1rYkNZVFNVamJROFVT?=
 =?utf-8?B?YUxBa0JCVDRHTUhieFFLVEw5QWdpcGMvci9IM0JDRWFiN3lxMlFVRXY0LzZW?=
 =?utf-8?B?aHk1U0txb294SVlxNExmME45ZnYybGZ6SGtuekIzb0hmdU4xVEFXcGwvRjRW?=
 =?utf-8?B?WWNkWWZNZFJ6cWlLZmhhcmJ2NVYvUDliZUNGSEJab1hFVnRqbndvcFBjS3hs?=
 =?utf-8?B?emFkNUh0SHk3a2U1Ukl3a1c1RHFiYVRJMnF0UkNDZWpjbEhvRUIzWGl1eEQ5?=
 =?utf-8?B?eXM2bldxaG53bnUzNUgzb1JlMVI3MUxudWZLc0RZazlEOCtYZHBKTjJFei9n?=
 =?utf-8?B?NmdKbjdmL2I2aXp3a2lEQXhIRy9xUVZDai81bHIxV2k4VkJCS0E5MGdUY0h2?=
 =?utf-8?B?dDl4TmNLK255ZkdLN0lyK3d6T0o3WGxiNGdNem5jeTl6Vms4UnpFRVM1cDNs?=
 =?utf-8?B?V1JncVJaQ2VTZ1RxRktBM0R4dnFCZGgzT0Y0NjJVNVRrT2V4NnpyQXMrS2xX?=
 =?utf-8?B?WEw1TnVEMTdEZnREUktvZWs2Tm45a1k4c2ZLVUJKTnJrY2hKckhKM2FFWTVn?=
 =?utf-8?B?K1VDckU4UllHRmVFZWdoeGZzVTZZUjRmVml3QzcreGRMMXlJSTZRTTlOWko2?=
 =?utf-8?B?bjVNK2dLQUNUQVVxS2h0TGljSjdNaThFVklhWHdjaFRxcjRNM2NLUVBQYVZ3?=
 =?utf-8?B?QTV4Q01BcU04VHhXTUU4M0NLYUE4VmkvbEJwTjN0RjNWb0hMNUVKOGZRdjd3?=
 =?utf-8?B?NldUU08zMEhtTThSSWFqSjlzdVU0VmJybGV1b3M5WGVLRTh5bTNFbEdtNHJo?=
 =?utf-8?B?WEt2c2xXK20wcnphVmtqaVZVczNTZi94QzlIazNPN1lhM1NxWWplWWVJamdy?=
 =?utf-8?B?ZGNDdGlMWWk2NEt2QlMwZXNsYXdyQ1p5bzZJMDVzUG5nUFZpZk5IMDJLRFA2?=
 =?utf-8?B?YXA2eXpaUzJWR0lLVHY0MUtLNjd5UENQRkIvYi9vbTZOLzJkRGpsRVk2Wnpt?=
 =?utf-8?B?K2J2VlpYZ3F4ZFFpRStYZnU0THdTR21KV2tWektleDhJRXJQcmdWVkZWUUd3?=
 =?utf-8?B?ZklrVmhPUWVBbzJ6YkZFcXd1ZDUybk9FNm5RRlpzNS9YNjUvOTVXRjJsRlVE?=
 =?utf-8?Q?V9X5k2kadAxDCFRGjvD0gbg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53B9E9EC66C99B46B3A14ECEF5C8D848@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4565.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a967849-6283-420f-9832-08dad7f6ec6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 02:01:15.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ra3brESua1XKGJAM95FTsiX+WLEtLZ4yEHv3fTDsCmCq5fiOykbMguSNjw63QCIqxqHOMdsybgoEA1+qKpeICSRIMUtvV+uIfQj9gUf6kgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6953
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEyLTA2IGF0IDEzOjIyICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDYvMTIvMjIgMTA6MDQsIFhpYW5nc2hlbmcgSG91ICjkvq/npaXo
g5wpIGhhIHNjcml0dG86DQo+ID4gSGkgQW5nZWxvLA0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyMi0x
Mi0wNSBhdCAxNToyMSArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiB3cm90
ZToNCj4gPiA+IElsIDA1LzEyLzIyIDA3OjU3LCBYaWFuZ3NoZW5nIEhvdSBoYSBzY3JpdHRvOg0K
PiA+ID4gPiBBZGQgRUNDIHN1cHBvcnQgZm90IE1UNzk4NiBJQy4NCj4gPiA+ID4gDQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IFhpYW5nc2hlbmcgSG91IDx4aWFuZ3NoZW5nLmhvdUBtZWRpYXRlay5j
b20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgICBkcml2ZXJzL210ZC9uYW5kL2VjYy1tdGsuYyB8
IDE4ICsrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgICAxIGZpbGUgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25h
bmQvZWNjLW10ay5jIGIvZHJpdmVycy9tdGQvbmFuZC9lY2MtDQo+ID4gPiA+IG10ay5jDQo+ID4g
PiA+IGluZGV4IDlmOWIyMDFmZTcwNi4uYzJmNmNmYTc2YTA0IDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL210ZC9uYW5kL2VjYy1tdGsuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL210ZC9u
YW5kL2VjYy1tdGsuYw0KPiA+ID4gPiBAQCAtNzksNiArNzksMTAgQEAgc3RhdGljIGNvbnN0IHU4
IGVjY19zdHJlbmd0aF9tdDc2MjJbXSA9IHsNCj4gPiA+ID4gICAgCTQsIDYsIDgsIDEwLCAxMg0K
PiA+ID4gPiAgICB9Ow0KPiA+ID4gPiAgICANCj4gPiA+ID4gK3N0YXRpYyBjb25zdCB1OCBlY2Nf
c3RyZW5ndGhfbXQ3OTg2W10gPSB7DQo+ID4gPiA+ICsJNCwgNiwgOCwgMTAsIDEyLCAxNCwgMTYs
IDE4LCAyMCwgMjIsIDI0DQo+ID4gPiA+ICt9Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICAgIGVudW0g
bXRrX2VjY19yZWdzIHsNCj4gPiA+ID4gICAgCUVDQ19FTkNQQVIwMCwNCj4gPiA+ID4gICAgCUVD
Q19FTkNJUlFfRU4sDQo+ID4gPiA+IEBAIC00ODMsNiArNDg3LDE3IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2VjY19jYXBzDQo+ID4gPiA+IG10a19lY2NfY2Fwc19tdDc2MjIgPSB7DQo+ID4g
PiA+ICAgIAkucGdfaXJxX3NlbCA9IDAsDQo+ID4gPiA+ICAgIH07DQo+ID4gPiA+ICAgIA0KPiA+
ID4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZWNjX2NhcHMgbXRrX2VjY19jYXBzX210Nzk4
NiA9IHsNCj4gPiA+ID4gKwkuZXJyX21hc2sgPSAweDFmLA0KPiA+ID4gDQo+ID4gPiBDYW4ndCB3
ZSB1c2UgR0VOTUFTSygpIHRvIGRlZmluZSBlcnJfbWFzayBpbnN0ZWFkPw0KPiA+ID4gDQo+ID4g
PiAjZGVmaW5lIE1UNzk4Nl9FUlJOVU0JR0VOTUFTSyg0LCAwKQ0KPiA+ID4gDQo+ID4gPiBQLlMu
OiBEaWQgSSBnZXQgdGhhdCByaWdodD8gSXMgdGhhdCByZWZlcnJlZCB0byB0aGUgRVJSTlVNKHgp
DQo+ID4gPiBiaXRzDQo+ID4gDQo+ID4gWWVzLCB5b3UgYXJlIHJpZ2h0Lg0KPiA+IEkgd2lsbCBj
aGFuZ2UgbGlrZQ0KPiA+ICNkZWZpbmUgRUNDX0VSUk1BU0soeCkgR0VOTUFTSyh4LCAwKSwNCj4g
PiBzaW5jZSBvdGhlciBJQyBkcml2ZXIgZGF0YSB3aWxsIHVzZSAweDNmIGFuZCAweDdmIGVycl9t
YXNrLg0KPiA+IA0KPiANCj4gSSB3b3VsZCBwcmVmZXIsIGluc3RlYWQsIHNvbWV0aGluZyBsaWtl
DQo+IA0KPiAjZGVmaW5lIE1UNzk4Nl9FUlJOVU0JR0VOTUFTSyguLi4uKQ0KPiAjZGVmaW5lIE1U
NzYyMl9FUlJOVU0JR0VOTUFTSyguLi4uKQ0KPiAjZGVmaW5lIE1ULi4uLiAoZXRjKQ0KPiANCj4g
aW5zdGVhZCBvZiBhIG1hY3JvIGNhbGxpbmcgYW5vdGhlciBtYWNyby4NCg0KV2lsbCBkby4NCg0K
VGhhbmtzDQpYaWFuZ3NoZW5nIEhvdQ0K
