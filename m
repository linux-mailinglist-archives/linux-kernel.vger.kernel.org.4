Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D599C706819
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjEQM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjEQM2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:28:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BA21FC2;
        Wed, 17 May 2023 05:28:42 -0700 (PDT)
X-UUID: 587dbf8cf4ae11ed9cb5633481061a41-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ia02fT1ye3eYG1qN4Usl30L7xLv/w++Fw8G/ldWy/sM=;
        b=CTCV/WohPMAr1tWB7pdM6oHiYDm5AxtFqF0pQJnobZdfy8+Y8hm6sHZuWDoMc9YighbDvsWYyts2SC0PllNk2UukabdWdgEJUvMkKgKpyAqTsC2qaWK4gJ5v2g47/dZwbxIjZCapXI3TbcoWJ4/VHDwvtC6NdNQdVARr2XwWsZA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:edd1e40d-abd7-4728-80f3-3bd81c4c6ada,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:51647a3b-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 587dbf8cf4ae11ed9cb5633481061a41-20230517
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 531933841; Wed, 17 May 2023 20:28:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 20:28:35 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 20:28:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmmiiPd8W5PG0OGnKWaAvQH65p+YB3GRc9NIkei/mn1CKMlqfDCCIqk5j87ra4elVPbVRhJoIwMz11G8rKVulN/nsNeI9AKq5P+JT5vlE7x3PXkqg4Dv5VDK2LsRgWTqevZez/P3SHqUTNVG1n6dIlieXxlK0htIutgApSbYCecCPXw1yLsLcrFOH4U87BO3NnLHNkTN7L+RX6QN5tlL6wf8GTlS1QaNux6JvpSSd3+V1aAE8KzjUd98xtNPShcldyuuvp06W0v9gtVUZejO9eM0RDRpIUk6+NKLbsk4i35ar+EP4RdJBxsIw6oxfs2NlYeBn2iS2a/0opL5mPQBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia02fT1ye3eYG1qN4Usl30L7xLv/w++Fw8G/ldWy/sM=;
 b=IsXEJSDdLXVOHo9Pl6Vf8g/HGAiRfp2NLc8tMFe5aPteHgaTEfPGnsfl4+vNvJz80J7+ELMxRCoKOXW+UFJlpE/V2CF7VQWTvctlbs5dRhR3y9vBvbNAUMOBu9k9n5Rkj+Fod5Gv8xQi+r6vhAcUbTP9oDE77A1BFW61LprX/ONk/mnPpJtbvM24ooGOUD6eytXf0YTTCe2AhyNk8/uJutIH1gkJ4tV3mAX9Uyruqq/EX+AIIvjvCbEndxwehYH0bFIElZvwVQ84ptV18h4TE/lK0hBRDtlAM/2Su7FEgN+nu3qSBmB0YJNm3O9fGp5vvNHqt5D9wCpTHuBeVE4Qog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia02fT1ye3eYG1qN4Usl30L7xLv/w++Fw8G/ldWy/sM=;
 b=DIEVIlXi8MV06zFR72kyLzhx0pGoK1dqQZdJcR8gjj9gc9zmXx439ym5LuQiiaYHsbzw/BmsLqeTFAZ+YBg85kskrrS6AXS30MGLtI//ejpBxlVgvW1MnpogUUZoKy0i4Y3us6c2sq8tyIZc8p7nNe7+WrljjDjfGwEFoxCeHXQ=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SG2PR03MB6480.apcprd03.prod.outlook.com (2603:1096:4:1c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 12:28:33 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 12:28:33 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: Re: [PATCH 3/5] ASoC: mediatek: common: soundcard driver add dai_fmt
 support
Thread-Topic: [PATCH 3/5] ASoC: mediatek: common: soundcard driver add dai_fmt
 support
Thread-Index: AQHZiLENEdQhw/gqYUuYZp1PoAEFOa9eWXkAgAALVAA=
Date:   Wed, 17 May 2023 12:28:33 +0000
Message-ID: <aadcbb7e04f05cebe6ab85a5fe0540418624c54b.camel@mediatek.com>
References: <20230517111534.32630-1-trevor.wu@mediatek.com>
         <20230517111534.32630-4-trevor.wu@mediatek.com>
         <daac5c71-e6d3-04b0-f628-c53a4e12640d@collabora.com>
In-Reply-To: <daac5c71-e6d3-04b0-f628-c53a4e12640d@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SG2PR03MB6480:EE_
x-ms-office365-filtering-correlation-id: 26954eb2-9df8-47ce-a850-08db56d23ac2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rt5MUBVXNa6COlWhooWruC/Ej2ibV7l9NaT139No/LwSVBlgqBcNbYT4gsc26H/FVmz3TDuBfh9EhINMK1KU+0JfqFN7rr07DGepWQn1sjK6F9r03s9zYrjYGkpPYgnEsBbsQsDV30mqsd2mVTswi9lUFx7X+TBHSUpAQlQ9pE/k2167gnPB2V6CzkU9ZLqr/xcRvPzA3b8DbbYVV6p1xLmBZZ6KM1/L/mWY39WjjPxR0Wzlwm5PQQEgGPt3itLPmyJHrAnRy/KuckxM0v9+3gUkOOAKh8lzmgAYPfohj8qmXYloVxXmmwmxLv0GUWAY+zBAN10Il18n3fN426xTSy94B+kPiubvgfWoOX+QCqWi+Ozr2n9jI/XcNK73E3M6RPGZAR+MRCbyYnYmVVbzGrxtGwMnDrhX9uY6ns2hUXWiW4m+b+8zQJ+jeupBT5s2EE/v4cEHCXj2afOJWosL3yfotGylswSrXo21Zd0R4orhLcCbyzQ2tfVNaHRGbz9gbH/C+hWnDiFk4UqjA5C8FJ/+mfTpfJtUUre6HVpNOkk9yoNu0fbF40JMSG8nu8YEni0tr5LnBKAxBsYI/NfQCF844/mSmCYHlFGJtuDdGYVBArR3p1aWsnFo8Rd5b1OHQ2/BY/4hQ98m4A2bH8wcDQZ8pbOBWDBBWfLJiG9VFHffQPAICjmwyhr6WxoNYZJQGiMGAw/xEfAalMugFN5PiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(6486002)(4326008)(76116006)(66946007)(66446008)(64756008)(66476007)(86362001)(54906003)(110136005)(316002)(91956017)(85182001)(36756003)(478600001)(83380400001)(6506007)(26005)(2616005)(6512007)(66556008)(186003)(7416002)(41300700001)(8936002)(2906002)(5660300002)(71200400001)(122000001)(38070700005)(38100700002)(8676002)(99106002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVFEd3dWekJrL2ZxUGlkOGNxYXdGN0ozUXRnSjdBSGJnYkJBMjZyejJzNWpv?=
 =?utf-8?B?VCtZZ3lsb3Nja3NtN0xxVWNOaFNRNzVHbndNRVQ5c0VnelErOTdCR3VKWTA3?=
 =?utf-8?B?bkUzWm9ocUVnd2RSNEk5TjhOczVZbGNzd2JjRkFpeGROOVZPbCtMZW9zNUFo?=
 =?utf-8?B?NXh3S0F5NlZTK3dDUVpzRUNkcE81U01na1d4VUdHTGxmS0lUT0MrNXByZ3NZ?=
 =?utf-8?B?dXNMR3ZOVlZhbnkzc3phb2NTb0dWRXNZYTNXZ1RvZHhUUXVZREdBUFFNdXNi?=
 =?utf-8?B?MWhxRzlWQ05HQVJDVXdjOW5QdzN0enpFNW9VQmdiREdOTHRzeFVKMWFTM1hp?=
 =?utf-8?B?eFhGMHhEdzNySjdxVkFnZ3MvRjErOVFXMVRsQUtXNlNTb1NOVUpTQXl0bDFi?=
 =?utf-8?B?bTZkQktmeEVGbG9SWmRpVkJ1c1BxM09hcVFVcllqSTlpRGZxdU5TZGdqRjFm?=
 =?utf-8?B?NzZVNE5pQ1JXSmJIRFJKcCt0U05ZNnJZQnMrNlVMbHZGVk8rYkhXMlMwQmVY?=
 =?utf-8?B?Mk1jYml6aWhaczg3ZzJjV2RVbEx3WlRRM3AxWm5BUWgxWHE4VVZiTk4wL3Jv?=
 =?utf-8?B?QklMUWhsR3NMeDhoc2tGWFM0b3d2MlJocFZpay92SUJEZVdlMm53NDVZTWRJ?=
 =?utf-8?B?TmpONno4MmZTbTBVOTQyYW9VbUJVb0t3Sml5dDhEU1FyaW1UNlltQ1p5Rk1B?=
 =?utf-8?B?UEw3ejQvWWdURGd2QmJFRGsxcXc2TThCMFZtLy9DbGs0V0R4TVZHVW50Wld0?=
 =?utf-8?B?bDRlZnlrcW1FUk5JMGx3R2VCdkF6aGMzaUJxb2JZaVNIWUJ3c1k3bUk1RDAv?=
 =?utf-8?B?TmhmWkdpOGlaVFZsZWFVc1lxQjFaL09yMXhzVmRmS3RLNnF1SWNNNmF5SlNJ?=
 =?utf-8?B?cUY2cE9QN0RPTjlpR1Jxc0VSUWdBdldMNmRBZzdWeWVneitoQVkvdWppVHp4?=
 =?utf-8?B?SUUxdW1uenBUTFhQOGo4aHRzQ1ZCK0c4cTZLaGhwNXY5ZTdHVGVVUzN4b2hC?=
 =?utf-8?B?RkxFQmF1NDZpbFpRMDZrMEN0TSs2bjltYkpJSnZSWXFWMnpHV3B6TERRVmlI?=
 =?utf-8?B?b05nRisvZUQrcFVaRmdhNW5yV05YQ05KY0NpZXQ0cmpmYzk4LytuK3gyVWh5?=
 =?utf-8?B?dnoyN2orSm5VSFJDNnRaczg1ZWlacmVFYjhFb1BNc1FpNWdjMVY4VVZqMTBn?=
 =?utf-8?B?MjFhUGdnSHR5d1J2WGR3aVhVTnRDcjFGRStQYjNIZmNpTTZhZzV5cFUwMHFM?=
 =?utf-8?B?cUEyNGdzZkpoVEFVdHlpK1l2dlduN3kxQmxyUWhmNGR1WUlzbUt2MElldnM0?=
 =?utf-8?B?RFRyUHZUQXpWRFhPQWxlMTl6R2NRNWZKYThrbXFDZWFGdFZacmJTeEFJNGIy?=
 =?utf-8?B?SmxmVkJLckVPem1kZ2NjM0JtdmlzZkxlRHU0RUtCVWxaNFdTY2NKMkFRZlFy?=
 =?utf-8?B?MVQyb3BRWlVJVUJ2VS9yOUhkUmJTQ3BlUzNXNlBlbVJ6YjR4QU1vL1dJT3Zz?=
 =?utf-8?B?b21nakZKbFE1eG9FT2dWbVFGUVhjODVYTk9FQ3pKbzR1ZXN0czJaRy9aejgx?=
 =?utf-8?B?dlM2UlVSZHFDT2VPYitrUEtGTDlEeVlweE9PYnRYZWdGWndSWHNPMGtWUk5y?=
 =?utf-8?B?T1RhKzhZUGdEcDRLZkMzckZTNUNQdkdTUENjVGc0U1ZTR3psVlo1Qlhzbk9v?=
 =?utf-8?B?VmJ0M05GN0VNMmlVN0p5cFI0S0s1cjVHWVVzaUlxOW5pYXNRYi9SUGZjbEJC?=
 =?utf-8?B?QW1aMFdDWlBDdmE3UmVxcHJ6OUNXaDlvOGloMENCd1VBQXlwQWZwY0craHln?=
 =?utf-8?B?TVppUmNFNkNPUlFJVld6R2xPczV1RlFqOVZ5WVBlb1h6OG8wdXZXcmxMRVlN?=
 =?utf-8?B?L0hzbVlyZm8zL0ZmejJjSnNoUTNOcHdVYXN5Q2RpY0MzZnFIaGE1aG1rM2Ru?=
 =?utf-8?B?QVNvWHBpaWdmRmNWbkRwRkNCS3NQZG5ZYU5EeHZ4eDhiZTJjdmxjUmVNREFL?=
 =?utf-8?B?Skc0ZEJwakdRNTR6aE9WeE1IOFlCbnNXWk9lcmlYRHlKZldHS1I3QUEzWGRN?=
 =?utf-8?B?Znp1cjVTenBPZEN4b3hpeGk2Q3NudncwRWhwS1JaNk03ZGhVdk1vM0dWUGpy?=
 =?utf-8?B?VThneGxBTG9hSUZ0YlJxa1hDdUsvM21VUXJuMGN2RmpNMUdsbnI1TUdmRDlF?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF5DC235A8A23241A9CB8406E13AA9D5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26954eb2-9df8-47ce-a850-08db56d23ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 12:28:33.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kMCWui3aMyaqr9pc+B/9PCp2mBYByBiRCGCIPUxbkrRaCWMGXonS5ffptrikHKHfZA3Xf/y1KpBQikf9QnUDFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6480
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

T24gV2VkLCAyMDIzLTA1LTE3IGF0IDEzOjQ4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxNy8wNS8yMyAxMzoxNSwgVHJldm9yIFd1
IGhhIHNjcml0dG86DQo+ID4gVGhlcmUgYXJlIHR3byBjaGFuZ2VzIGluY2x1ZGVkIGluIHRoZSBw
YXRjaC4NCj4gPiANCj4gPiBGaXJzdCwgYWRkIHNldF9kYWlsaW5rX2RhaWZtdCgpIGZ1bmN0aW9u
LCBzbyBkYWlfZm10IGNhbiBiZSB1cGRhdGVkDQo+ID4gYnkNCj4gPiB0aGUgY29uZmlndXJhdGlv
biBpbiBkYWktbGluayBzdWIgbm9kZS4NCj4gPiANCj4gPiBTZWNvbmQsIHJlbW92ZSBjb2RlYyBw
aGFuZGxlIGZyb20gcmVxdWlyZWQgcHJvcGVydHkgaW4gZGFpLWxpbmsgc3ViDQo+ID4gbm9kZS4N
Cj4gPiBGb3IgZXhhbXBsZSwgdXNlciBwb3NzaWJseSBuZWVkcyB0byB1cGRhdGUgZGFpLWZvcm1h
dCBmb3IgYWxsIGV0ZG0NCj4gPiBjby1jbG9jayBkYWktbGlua3MsIGJ1dCBjb2RlYyBkb2Vzbid0
IG5lZWQgdG8gYmUgc3BlY2lmaWVkIGluDQo+ID4gY2FwdHVyZQ0KPiA+IGRhaS1saW5rIGZvciBh
IHNwZWFrZXIgYW1wLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRyZXZvciBXdSA8dHJldm9y
Lnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9tZWRpYXRlay9jb21tb24vbXRr
LXNvdW5kY2FyZC1kcml2ZXIuYyAgICB8IDQ5DQo+ID4gKysrKysrKysrKysrKysrKysrLQ0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL21lZGlhdGVrL2NvbW1vbi9tdGstc291bmRjYXJk
LWRyaXZlci5jDQo+ID4gYi9zb3VuZC9zb2MvbWVkaWF0ZWsvY29tbW9uL210ay1zb3VuZGNhcmQt
ZHJpdmVyLmMNCj4gPiBpbmRleCA3MzgwOTM0NTFjY2IuLjVlMjkxMDkyMDQ2YiAxMDA2NDQNCj4g
PiAtLS0gYS9zb3VuZC9zb2MvbWVkaWF0ZWsvY29tbW9uL210ay1zb3VuZGNhcmQtZHJpdmVyLmMN
Cj4gPiArKysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvY29tbW9uL210ay1zb3VuZGNhcmQtZHJpdmVy
LmMNCj4gPiBAQCAtMjIsNyArMjIsNyBAQCBzdGF0aWMgaW50IHNldF9jYXJkX2NvZGVjX2luZm8o
c3RydWN0DQo+ID4gc25kX3NvY19jYXJkICpjYXJkLA0KPiA+IA0KPiA+ICAgICAgIGNvZGVjX25v
ZGUgPSBvZl9nZXRfY2hpbGRfYnlfbmFtZShzdWJfbm9kZSwgImNvZGVjIik7DQo+ID4gICAgICAg
aWYgKCFjb2RlY19ub2RlKQ0KPiA+IC0gICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4g
KyAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiANCj4gPiAgICAgICAvKiBzZXQgY2FyZCBjb2Rl
YyBpbmZvICovDQo+ID4gICAgICAgcmV0ID0gc25kX3NvY19vZl9nZXRfZGFpX2xpbmtfY29kZWNz
KGRldiwgY29kZWNfbm9kZSwNCj4gPiBkYWlfbGluayk7DQo+ID4gQEAgLTM2LDYgKzM2LDQ3IEBA
IHN0YXRpYyBpbnQgc2V0X2NhcmRfY29kZWNfaW5mbyhzdHJ1Y3QNCj4gPiBzbmRfc29jX2NhcmQg
KmNhcmQsDQo+ID4gICAgICAgcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4gDQo+ID4gK3N0YXRpYyBp
bnQgc2V0X2RhaWxpbmtfZGFpZm10KHN0cnVjdCBzbmRfc29jX2NhcmQgKmNhcmQsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqc3ViX25vZGUsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzbmRfc29jX2RhaV9saW5rICpk
YWlfbGluaykNCj4gPiArew0KPiA+ICsgICAgIHVuc2lnbmVkIGludCBkYWlmbXQ7DQo+ID4gKyAg
ICAgY29uc3QgY2hhciAqc3RyOw0KPiA+ICsgICAgIGludCByZXQ7DQo+ID4gKyAgICAgc3RydWN0
IHsNCj4gPiArICAgICAgICAgICAgIGNoYXIgKm5hbWU7DQo+ID4gKyAgICAgICAgICAgICB1bnNp
Z25lZCBpbnQgdmFsOw0KPiA+ICsgICAgIH0gb2ZfY2xrX3RhYmxlW10gPSB7DQo+ID4gKyAgICAg
ICAgICAgICB7ICJjcHUiLCAgICAgICAgU05EX1NPQ19EQUlGTVRfQ0JDX0NGQyB9LA0KPiA+ICsg
ICAgICAgICAgICAgeyAiY29kZWMiLCAgICAgIFNORF9TT0NfREFJRk1UX0NCUF9DRlAgfSwNCj4g
PiArICAgICB9Ow0KPiA+ICsNCj4gDQo+IFRoaXMgaXMgYW4gb3B0aW9uYWwgcHJvcGVydHkgYW5k
IHRoaXMgZnVuY3Rpb24gc2hvdWxkIG5vdCBkbyBhbnl0aGluZw0KPiBpZiB0aGF0DQo+IHByb3Bl
cnR5IGlzIG5vdCBmb3VuZCwgc28uLi4uDQo+IA0KPiAgICAgICAgIC8qDQo+ICAgICAgICAgICog
Q2hlY2sgIm1lZGlhdGVrLGNsay1wcm92aWRlciIgdG8gc2VsZWN0IHRoZSBjbG9jayBwcm92aWRl
cg0KPiAgICAgICAgICAqIGluIFNORF9TT0NfREFJRk1UX0NMT0NLX1BST1ZJREVSX01BU0sgYXJl
YSwgaWYgc3BlY2lmaWVkLg0KPiAgICAgICAgICAqLw0KPiAgICAgICAgIGlmICghb2ZfcHJvcGVy
dHlfcmVhZF9zdHJpbmcoc3ViX25vZGUsICJtZWRpYXRlayxjbGstDQo+IHByb3ZpZGVyIiwgJnN0
cikpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gDQo+IC4uLnRoaXMgYWxsb3dzIHlv
dSB0byByZWR1Y2UgaW5kZW50YXRpb24gYXMgd2VsbC4NCg0KSGkgQW5nZWxvLA0KDQpBY3R1YWxs
eSwgdGhlcmUgYXJlIHR3byBwcm9wZXJ0aWVzIGhhbmRsZWQgYnkgdGhlIGZ1bmN0aW9uLg0KImRh
aS1mb3JtYXQiIGlzIHBhcnNlZCBhdCBzbmRfc29jX2RhaWZtdF9wYXJzZV9mb3JtYXQoKSwgYW5k
DQoibWVkaWF0ZWssY2xrLXByb3ZpZGVyIiBpcyBwYXJzZWQgYnkgb2ZfcHJvcGVydHlfcmVhZF9z
dHJpbmcoKS4NCkkgaGF2ZSB0byBnbyB0aHJvdWdoIGJvdGggcHJvcGVydGllcyBpbiB0aGUgZnVu
Y3Rpb24sIHNvIGl0IGNhbid0DQpyZXR1cm4gZGlyZWN0bHkgaWYgIm1lZGlhdGVrLGNsay1wcm92
aWRlciIgaXMgbm90IGZvdW5kLg0KDQo+IA0KPiA+ICsgICAgIGRhaWZtdCA9IHNuZF9zb2NfZGFp
Zm10X3BhcnNlX2Zvcm1hdChzdWJfbm9kZSwgTlVMTCk7DQo+ID4gKyAgICAgaWYgKGRhaWZtdCkg
ew0KPiA+ICsgICAgICAgICAgICAgZGFpX2xpbmstPmRhaV9mbXQgJj0NCj4gPiBTTkRfU09DX0RB
SUZNVF9DTE9DS19QUk9WSURFUl9NQVNLOw0KPiA+ICsgICAgICAgICAgICAgZGFpX2xpbmstPmRh
aV9mbXQgfD0gZGFpZm10Ow0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgLyoNCj4gPiAr
ICAgICAgKiBjaGVjayAibWVkaWF0ZWssY2xrLXByb3ZpZGVyID0geHh4Ig0KPiA+ICsgICAgICAq
IFNORF9TT0NfREFJRk1UX0NMT0NLX1BST1ZJREVSX01BU0sgYXJlYQ0KPiA+ICsgICAgICAqLw0K
PiA+ICsgICAgIHJldCA9IG9mX3Byb3BlcnR5X3JlYWRfc3RyaW5nKHN1Yl9ub2RlLCAibWVkaWF0
ZWssY2xrLQ0KPiA+IHByb3ZpZGVyIiwgJnN0cik7DQo+ID4gKyAgICAgaWYgKHJldCA9PSAwKSB7
DQo+ID4gKyAgICAgICAgICAgICBpbnQgaTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgQVJSQVlfU0laRShvZl9jbGtfdGFibGUpOyBpKyspIHsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgaWYgKHN0cmNtcChzdHIsIG9mX2Nsa190YWJsZVtpXS5uYW1lKSA9PSAw
KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGFpX2xpbmstPmRhaV9mbXQg
Jj0NCj4gPiB+U05EX1NPQ19EQUlGTVRfQ0xPQ0tfUFJPVklERVJfTUFTSzsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkYWlfbGluay0+ZGFpX2ZtdCB8PQ0KPiA+IG9mX2Nsa190
YWJsZVtpXS52YWw7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgIH0NCj4gPiArICAg
ICB9DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgaW50
IHBhcnNlX2RhaV9saW5rX2luZm8oc3RydWN0IHNuZF9zb2NfY2FyZCAqY2FyZCkNCj4gPiAgIHsN
Cj4gPiAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBjYXJkLT5kZXY7DQo+ID4gQEAgLTY3LDYg
KzEwOCwxMiBAQCBpbnQgcGFyc2VfZGFpX2xpbmtfaW5mbyhzdHJ1Y3Qgc25kX3NvY19jYXJkDQo+
ID4gKmNhcmQpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIG9mX25vZGVfcHV0KHN1Yl9ub2Rl
KTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAgICAgICAgICAg
ICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAgICByZXQgPSBzZXRfZGFpbGlua19kYWlmbXQo
Y2FyZCwgc3ViX25vZGUsIGRhaV9saW5rKTsNCj4gPiArICAgICAgICAgICAgIGlmIChyZXQgPCAw
KSB7DQo+IA0KPiBpZiAocmV0KSB7DQo+ICAgLi4uDQo+IH0NCj4gDQoNCkN1cnJlbnRseSwgdGhp
cyBmdW5jdGlvbiBvbmx5IHJldHVybnMgMCwgYnV0IEknbSBub3Qgc3VyZSBpZiBpdCB3aWxsDQpy
ZXR1cm4gYSBwb3NpdGl2ZSB2YWx1ZSBmb3Igc29tZSBvdGhlciB1c2FnZSBpbiB0aGUgZnV0dXJl
Lg0KQmVjYXVzZSBhIG5lZ2F0aXZlIHZhbHVlIGlzIGFsd2F5cyByZXR1cm5lZCBmb3IgYW4gZXJy
b3IgYW5kIHRoZQ0KcHJlY2VkaW5nIHJ1bGUgaXMgYWxzbyAicmV0IDwgMCIsIEkgcHJlZmVyICJy
ZXQgPCAwIiBoZXJlLiANCg0KVGhhbmtzLA0KVHJldm9yDQoNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgb2Zfbm9kZV9wdXQoc3ViX25vZGUpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgICAgICAgfQ0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxv
DQo+IA0K
