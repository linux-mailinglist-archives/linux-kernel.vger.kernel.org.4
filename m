Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76FE654A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 02:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiLWBhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 20:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiLWBg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 20:36:57 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464E424BEC;
        Thu, 22 Dec 2022 17:36:48 -0800 (PST)
X-UUID: 89e08e98689d4d3d89cf98783dee8eb2-20221223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=aSHgc+4Pz2qCrFUQbi5+CI8OI6Y5td6RtfUU2/cCQkQ=;
        b=t9l0yHUEVZ8fz6OgZiUJB+isdcmhTLDlYP6ahHYKI9CfTtmoV+wWBvQfPNVUxRAKSO4l76Z++3K9toJOr+p3/JsqJ3XPY0elIlsWwXXTnDRpIqczIM9kCu6fMWjcbzMFgkOYg5RqH2BwB8Rbb30ZGY4Q7eug0WgswMKgi+LI+b4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:405cd1c0-1534-4927-b07b-0f0d76874003,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:e7a2288a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 89e08e98689d4d3d89cf98783dee8eb2-20221223
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <garmin.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 270900153; Fri, 23 Dec 2022 09:36:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Dec 2022 09:36:44 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 23 Dec 2022 09:36:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mT2yCycy9yeHH1OTGJww+qnkJnn36jCBsOtK8SpABC6ga7QC8WQwQ7ch3T0Y15bJwCNS1NHuYEUvoWa6mP6G4DhgUDydF+nzRSYr5QPZrxXDXwJ+7uE3+kSn3zQ4Dn7lwFP0QICwdk9duJHZQz6uKpNzrO7ynkjMlRQQqzppBxtYoSDHWLykUNZlPP6FIiQ2SpGkey4hCbu/UJsFTuaQ7YGtHwtctZr2Sd4arjzR4nO9FQMeCN0U+D4BsoeAiJLvZ+yJl8MUNqa+rAn9+0G7Xk2dHqzC2a1XvSdO4GKeMhC9KQvMV+b1x0TL4XyUmTSpm0DkvPOTlvvfJWK19ouJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSHgc+4Pz2qCrFUQbi5+CI8OI6Y5td6RtfUU2/cCQkQ=;
 b=cL2QI7NzvjrpK6MSmaF/+mkWNgCP/q3BQvSMnwzIRcc9lEI9nBPvn/cUjQnfR/bfiPN4+s9QhcDrmoqsXKJctfoUoUY3LFF276oiY/OMheLaIFqZNSD+iM/KCNV+roneBoPgOzGzmgo4jsuJquo4luhpXrXrV2yk1tXs1W9B04VMRuMcazwF0wn/udsSVMFgkTGyjWNU3ytBWcs7Rr/K3OOJXMmvKk1vqwhXa3A8QesbTbnMU9ZCIbzTUY52R3svIFKd3qO6p924rjhbpyRoYRwYghrFEmVYafg3SQXHz2Q9MtMpMG1FQHd3htsA/VhLydJ+A5cwBQuIragOZA8PUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSHgc+4Pz2qCrFUQbi5+CI8OI6Y5td6RtfUU2/cCQkQ=;
 b=LjY64a8o45HpWi/+XsXsF1FVeD2OikNL4HEiURUUxCEu6xqdDcs2cjBnF5zp8Zo+q+ozONDSiQi1VuaLRs73Z7/cnOE1lj+wL4jG06YGb0acLVCs22Z9ZSkIOFX+Eo3FOyC07jHA9N8q2sCA1eUMpV5OM2znjdb8BS4mbxRRZMg=
Received: from SI2PR03MB5888.apcprd03.prod.outlook.com (2603:1096:4:145::6) by
 TY0PR03MB6606.apcprd03.prod.outlook.com (2603:1096:400:204::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 01:36:42 +0000
Received: from SI2PR03MB5888.apcprd03.prod.outlook.com
 ([fe80::914:6297:ee3:511e]) by SI2PR03MB5888.apcprd03.prod.outlook.com
 ([fe80::914:6297:ee3:511e%9]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 01:36:42 +0000
From:   =?utf-8?B?R2FybWluIENoYW5nICjlvLXlrrbpipgp?= 
        <Garmin.Chang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 10/19] clk: mediatek: Add MT8188 mfgcfg clock support
Thread-Topic: [PATCH v2 10/19] clk: mediatek: Add MT8188 mfgcfg clock support
Thread-Index: AQHY541ZAf7JDkm4Xk28HY0vhZhl5K4h67WAgFkjM4A=
Date:   Fri, 23 Dec 2022 01:36:42 +0000
Message-ID: <3bfb16a13cea63a74e3612ff450a97e06bf8946a.camel@mediatek.com>
References: <20221024094254.29218-1-Garmin.Chang@mediatek.com>
         <20221024094254.29218-11-Garmin.Chang@mediatek.com>
         <5e71c0b1-d645-1900-282d-df7d13cc60f8@collabora.com>
In-Reply-To: <5e71c0b1-d645-1900-282d-df7d13cc60f8@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5888:EE_|TY0PR03MB6606:EE_
x-ms-office365-filtering-correlation-id: 140c4ad3-82cd-45c6-df43-08dae48624ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+6YxjoOwES7ZsyS8WK8GO38+KoSoKH/gzlyiciD7lZYeMwO14u8DGfQMHZTUmrFOa2+5j95/0UtCOMKRkdnZFt6YwtK2iei2KyRhWX8dWG/TuuL8zu5psIYjqrqfRa4XMo8tGvgXsyXIf0VcWnpAIUuL4sF2tlhGSRx1aMfEYSXmU0d+2IEmIfNlIfFfQUHqoXJi4mHt+m4hvDUOpOdvPRReKdSgcztB1Ot9nssoRN9dqUm/80OW1uakB+K0gzHJ6R9uX/L2/mI8p4bQRjMnGT9XokJ1Yt65EMiHi+bh+ddipEDPksSXFh7n0G08nRgW4tcLBnPTaERLP2xWU/kvwcWiHEQhBxCRE5XCysfqn9HHFo0iti9AuqLSP/kNtbD9ciOGOASoZ/6GLp1bdX8gorFr0dWJkfvqc4fmCc/pq/TIxTqjc29y+4k2NwLKBvHfAo9kvn5FvLr8SU4rmhdul1+ra7M6jm12nq3oz3/4oxiingVW9+AxAwmjOREnnRl0RSA3+xKqbiXto8FpgTnfx/mP1bnW/fg443CssgcpBlQzY3eXTCdHFZ+2Fh/AB95IE3k5zfkrUWaIfEQdRKMbcwuYc9dC1egtJRRjBGUWqPBtc1wuaWyKfaGfFX5j4Gv14fAZgbx79o884rNtp+ZytQyr9PcvgQUyJJ8OUlHPRJ5DJ+0JXEKMCZ/FNCyF/FoYntpsg4JpEHgUy62uB+PrJGBoErKHzNp5ZMUDPihfXHHQXvIu4Ne0rH/4NdRzt94q0zGjViFj0FylNH+vOVi5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199015)(83380400001)(86362001)(2906002)(7416002)(8936002)(38070700005)(122000001)(5660300002)(41300700001)(4001150100001)(316002)(66446008)(2616005)(186003)(6512007)(66556008)(66476007)(6486002)(4326008)(91956017)(26005)(76116006)(478600001)(6506007)(8676002)(66946007)(54906003)(38100700002)(71200400001)(64756008)(110136005)(36756003)(85182001)(40753002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTB5djI0M2UvaTROL2dkOUxsVkdQWG1mcGVHVWplSzFyVWt1SFhQVUI0dUlI?=
 =?utf-8?B?Q3liQVBPMGdBc2crUm9oNzRlblhreXlJUC81SGxzTVZCRDFrd1dLMythc1g2?=
 =?utf-8?B?N3hpazFlV3ZVWFdrOFFRMllJZUIwd0t3ZVNhK3cvYldZVHhPV1cyUWtSQ2xx?=
 =?utf-8?B?d3VhekFBbk9waDhIQUtPN293K3NJaXo3MkdWZW5icHBzMldrbTNJZ2tsSVZs?=
 =?utf-8?B?UmFtOUwvRmFja3BJbEpwaXlOM201aXJOMTV4L2tEeFRmd3A1TWU4VlhLZWkr?=
 =?utf-8?B?b2ozajQ2M1RHamhXMFpTTFhZOTNSNEs2ZHY1L3BLaTl5MlF6dFFubUVZQTJt?=
 =?utf-8?B?TThyMkVrL3QyV20wRFo5VGJoMzF5MCtHR2FCZ05HU2lLb1VKWjRVdStBOUJY?=
 =?utf-8?B?bkhHek8vRHJIRjF1ZTZ3VHVZVmZiN2JPb0NFV2g4TDVtRU8vZElkMFZKb3Q4?=
 =?utf-8?B?R3pOUUtIMVVZRDFORzFGOURzRmxBTmtRNkV5QWtndGlCdFBqZ1ljZ0xGbUFT?=
 =?utf-8?B?RnVlSXdCWjR2Z2F4MkFrK3Zva25iZ25zcURncUFRNWZ2MzNMa1EyUDZWWm54?=
 =?utf-8?B?NjFEN09BdWJTWWlyK2o2ZEVoT1hJSEVSVElvdDA5U0xwTDFDSzJrazUxVWFy?=
 =?utf-8?B?RWxrQ21RTEFXRGh1dWJhZkcvVDlaNTZVSjcxQy9ZMDB0MWRQTjh4YlRoYWR3?=
 =?utf-8?B?eDVHR0FnR0FLT3FhR1oweUtrYW9UazNJUWRlL1FSajc4emEranIvY1h0RlUx?=
 =?utf-8?B?MHovYXQwVHB6WTBTejJSdHhUUVFqYllHeDc1bXh3SGxOOFY5MEdsSWE4d29a?=
 =?utf-8?B?MDh6ZmF1NndHalhGZlRtT1JDa3hDY0V6Q2FzWWhwdDcxUVB3VHRJYnk5Y1Rz?=
 =?utf-8?B?eWpxLy95dm43c3lSOVVGeWFYSitHN2NaUUZGV0pLK2YyanpPdFZxM2NtbVdk?=
 =?utf-8?B?TFh3UUFUaExFNmxwZFp5STJwZFNkczVwNDEyODYyQzdzcGVLR21PcEZKc0cr?=
 =?utf-8?B?bjQ0bjB4VVlWWGFSM1RKYTFoOExmREF5UVljOVhjQlRYYys5TysreDBESm5M?=
 =?utf-8?B?YVR3UlR4cXZsbjZPRjVMV09FdCtFQ0VkcTJDVmc2Vkd2WEZSeVp2MmY3aVNM?=
 =?utf-8?B?N28wSEFNeVhTOEpOd2hOdWM0SlAzT2o3dnk3d0dvSm1ZWFdVV1o0WWwzaGsr?=
 =?utf-8?B?b0xPMGJXekhmU3pGUnd3d3lqTlMzNW8wRVZsV2J2M1BtYVRya25HbUhJeVdK?=
 =?utf-8?B?amRpcUZKN0traEZhVFA3a2NEaVhRK3hyYjZnbkNXRmVHR0s3elhpMEw0ZE9q?=
 =?utf-8?B?WXdaVVlIL1NjUXJUWXk4Vm9BZTJNVzByUjlDRXBIajV2dG85MVdQdm9lL2d0?=
 =?utf-8?B?elRGMFpJMlRoUGxjZVZic1hSZGZOSS9Dbm9hRTRNMDdJTy8vcnY1MWRsWDdS?=
 =?utf-8?B?akZ2a21LSGRBdHdYYlJHUWZIOFpUdk9jVkRWdkhHdlRXMjNGY1J5QnNxOFFx?=
 =?utf-8?B?WTN0enE0MjZOcUoyTFZXdStycms0RXhFZTN1OFlTVk1RNnk2UWIrWFY3dzlE?=
 =?utf-8?B?a3UrTjBrcTdFczY0YjJJL203K1FsaHJiUzdBbzRGYVZ0dkNRalhwZnJXcGZp?=
 =?utf-8?B?YWZhMTQyLzY1Y25jYVhwdG1vNTFQM3NkNm0vZGVoejIyZ1Y5SHU1V2V2VjB1?=
 =?utf-8?B?elJIRHBpTFhIbVluWnhMQmxsQnVGSUEyVFBXcnRlVmJuNUFNYzNmbnJkSEFv?=
 =?utf-8?B?RnBiV04zYnk0SEpDbzNKNGxlOWo4cDRpM1ZkQ3Jka1AwMUZsQWQrcVhQdWY4?=
 =?utf-8?B?WjNoNk1tTDhISFhxZjNNY09ZcHZCSVR6cnJnS2tyTklzME1nay9pSHdjbldM?=
 =?utf-8?B?YmRJNDlYMk02ZlF3WHBNV3I0c2lIcDVxRUZhMTA2TVkwRjhTNGFnMU0wd3V3?=
 =?utf-8?B?MnBSYmlEZCtWVnNUblovclltVXpibGtxSExTSTdVRXlIRDdkWU14Y0JLcDU3?=
 =?utf-8?B?elVRb2NjM1R3RXY2Mnc1SDl1bEFSNVdUTHFld3NJcWVQZncwZ08rY1ZIMVRT?=
 =?utf-8?B?M3VzbUhDMXY5cHBBeDNGVWFNL082bFVCSUpTSHFXU3N0TWo1UzFWR25RRUxR?=
 =?utf-8?B?UHZIMFhweDYxRUx0cEkxQzR0OGtMRG1tcHhMRkdwMWJ0YVFNYkdJbzU2R0Vx?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF9F28187C8A864F9050F679CCE6DCBF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140c4ad3-82cd-45c6-df43-08dae48624ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 01:36:42.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sn++XlzPQXmnrtxsFKjWzu/XFIxVxRtW1QVHM9Xap+5l0Zqrmd2CIwnlXQeeD3dA0iZw+O6czNa9rq2LX38urJhvgNb+BR3dH+2fCDU3mRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6606
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTI3IGF0IDEwOjIzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjQvMTAvMjIgMTE6NDIsIEdhcm1pbi5DaGFuZyBoYSBzY3JpdHRv
Og0KPiA+IEFkZCBNVDgxODggbWZnIGNsb2NrIGNvbnRyb2xsZXIgd2hpY2ggcHJvdmlkZXMgY2xv
Y2sgZ2F0ZQ0KPiA+IGNvbnRyb2wgZm9yIEdQVS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBH
YXJtaW4uQ2hhbmcgPEdhcm1pbi5DaGFuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBk
cml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAgIHwgIDIgKy0NCj4gPiAgIGRyaXZl
cnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxODgtbWZnLmMgfCA1MA0KPiA+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10ODE4OC1tZmcuYw0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9t
ZWRpYXRlay9NYWtlZmlsZQ0KPiA+IGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCj4g
PiBpbmRleCAyMWIwNWU4ODBhM2EuLmNkODg3MGMyODE0NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVr
L01ha2VmaWxlDQo+ID4gQEAgLTg1LDcgKzg1LDcgQEAgb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtf
TVQ4MTg2KSArPSBjbGstbXQ4MTg2LQ0KPiA+IG1jdS5vIGNsay1tdDgxODYtdG9wY2tnZW4ubyBj
bGstbXQNCj4gPiAgIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE4OCkgKz0gY2xrLW10ODE4
OC1hcG1peGVkc3lzLm8gY2xrLQ0KPiA+IG10ODE4OC10b3Bja2dlbi5vIFwNCj4gPiAgIAkJCQkg
ICBjbGstbXQ4MTg4LXBlcmlfYW8ubyBjbGstbXQ4MTg4LQ0KPiA+IGluZnJhX2FvLm8gXA0KPiA+
ICAgCQkJCSAgIGNsay1tdDgxODgtY2FtLm8gY2xrLW10ODE4OC1jY3Uubw0KPiA+IGNsay1tdDgx
ODgtaW1nLm8gXA0KPiA+IC0JCQkJICAgY2xrLW10ODE4OC1pcGUubw0KPiA+ICsJCQkJICAgY2xr
LW10ODE4OC1pcGUubyBjbGstbXQ4MTg4LW1mZy5vDQo+ID4gICBvYmotJChDT05GSUdfQ09NTU9O
X0NMS19NVDgxOTIpICs9IGNsay1tdDgxOTIubw0KPiA+ICAgb2JqLSQoQ09ORklHX0NPTU1PTl9D
TEtfTVQ4MTkyX0FVRFNZUykgKz0gY2xrLW10ODE5Mi1hdWQubw0KPiA+ICAgb2JqLSQoQ09ORklH
X0NPTU1PTl9DTEtfTVQ4MTkyX0NBTVNZUykgKz0gY2xrLW10ODE5Mi1jYW0ubw0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LW1mZy5jDQo+ID4gYi9kcml2
ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LW1mZy5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjNhNzVjZDc0NDNmZA0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LW1mZy5jDQo+ID4g
QEAgLTAsMCArMSw1MCBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vbmx5DQo+ID4gKy8vDQo+ID4gKy8vIENvcHlyaWdodCAoYykgMjAyMiBNZWRpYVRlayBJbmMu
DQo+ID4gKy8vIEF1dGhvcjogR2FybWluIENoYW5nIDxnYXJtaW4uY2hhbmdAbWVkaWF0ZWsuY29t
Pg0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KPiA+ICsjaW5j
bHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9jbG9jay9tZWRpYXRlayxtdDgxODgtY2xrLmg+DQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAiY2xr
LWdhdGUuaCINCj4gPiArI2luY2x1ZGUgImNsay1tdGsuaCINCj4gPiArDQo+ID4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgbXRrX2dhdGVfcmVncyBtZmdjZmdfY2dfcmVncyA9IHsNCj4gPiArCS5zZXRf
b2ZzID0gMHg0LA0KPiA+ICsJLmNscl9vZnMgPSAweDgsDQo+ID4gKwkuc3RhX29mcyA9IDB4MCwN
Cj4gPiArfTsNCj4gPiArDQo+ID4gKyNkZWZpbmUgR0FURV9NRkdDRkcoX2lkLCBfbmFtZSwgX3Bh
cmVudCwgX3NoaWZ0KQkJCQ0KPiA+IFwNCj4gPiArCUdBVEVfTVRLKF9pZCwgX25hbWUsIF9wYXJl
bnQsICZtZmdjZmdfY2dfcmVncywgX3NoaWZ0LA0KPiA+ICZtdGtfY2xrX2dhdGVfb3BzX3NldGNs
cikNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGUgbWZnY2ZnX2Nsa3Nb
XSA9IHsNCj4gPiArCUdBVEVfTUZHQ0ZHKENMS19NRkdDRkdfQkczRCwgIm1mZ2NmZ19iZzNkIiwg
InRvcF9tZmdfY29yZV90bXAiLA0KPiA+IDApLA0KPiA+ICt9Ow0KPiANCj4gVGhpcyB3aWxsIG1h
a2UgaXQgaW1wb3NzaWJsZSB0byBwcm9wZXJseSBwZXJmb3JtIEdQVSBEVkZTLg0KPiANCj4gSGlu
dDoNCj4gDQo+ICNkZWZpbmUgR0FURV9NRkcoX2lkLCBfbmFtZSwgX3BhcmVudCwgX3NoaWZ0KQkJ
CVwNCj4gCUdBVEVfTVRLX0ZMQUdTKF9pZCwgX25hbWUsIF9wYXJlbnQsICZtZmdfY2dfcmVncywJ
XA0KPiAJCSAgICAgICBfc2hpZnQsICZtdGtfY2xrX2dhdGVfb3BzX3NldGNsciwJXA0KPiAJCSAg
ICAgICBDTEtfU0VUX1JBVEVfUEFSRU5UKQ0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0K
DQogIE9rLCBJIHdpbGwgbW9kaWZ5IHRoZW0gaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiANCj4g
VGhhbmtzLA0KPiBCZXN0IFJlZ2FyZHMsDQo+IEdhcm1pbg0K
