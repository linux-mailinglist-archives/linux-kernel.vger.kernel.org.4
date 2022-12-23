Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90678654CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiLWHd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWHd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:33:27 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805E816488;
        Thu, 22 Dec 2022 23:33:19 -0800 (PST)
X-UUID: 9a129994fdda405cab6f27b089c86115-20221223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JgmAaltwjbSynYz37Pt5RtVZxBGKNvjUnRBHPTm6JZQ=;
        b=uKVJ589Z0+1QIx28W5UYF9XXiQxQG6M6Tdze2KvHeDp3D8Ieiwi77Rr59pvr4TW92b92KOrA1lTW73rouzAfRnVqQy3WwhiQfYvw9nilyu5YopXCuzI2l5wUInOKlcEpf8xVUiWu/QpkClPlfQ4scF/AnqAZ/UjDaKRe1GORmOo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a0433ad8-abf3-45c4-94e5-9a8ab0405271,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:3a459852-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9a129994fdda405cab6f27b089c86115-20221223
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <garmin.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1015033780; Fri, 23 Dec 2022 15:33:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Dec 2022 15:33:11 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 23 Dec 2022 15:33:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxIH9OtDN4CBkgXnEvMSWzJko7zX3a2arh1KyNRyLknn1Qac8fK2NXF1ZJc0am8+h1QnFKUIDsSbgGvvX5POkVyxGTV763uLeAKWmu4KloWZAUyOuUBES3HwR3uhizMvUXmf8Wws4EXoiPxheQ6ymNtJ4Mg3anyUkrt3AU2vSN8xPom+l8mv5R3GuHxySkYzWvjtvetksblgHLK8K0BO/tjQZWSXAujSOZG3HHm2VTnSh9djsNzpkmEEbLSGbez/RddRCMO0x40pK4T7inFjycobMGjbwBTaR92hlhs+JQFCNQaIEs1xlBQes5vvqxySZCqpI97yuLAenIRo1p7yYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgmAaltwjbSynYz37Pt5RtVZxBGKNvjUnRBHPTm6JZQ=;
 b=Pl+XiHMPEoPAY38HTNgXzNdaT29qDC2M32qZbwiAnqF2Sgl+WkWIuVX1u2ZpNQaieg6vK9o112ewBoKqhYc3Zvk38gvSbKlreYHkxBAui81wKrYJ2k+48zRfBOyT1Apn1uKsPYd9UsRPKqw/rP9DD/JAFEfKW0RWIo2B2RsCEGwqB1FYgcRh6pcf2k7U8OfShthXxKfmL5Y9AUX0yoJacoPtqfhFSpY2Fch+XlG0iuY2/yaNiyFGRipwocdOM6PHAmWtgtkRKQcv1Ay+g4xrxV5F1x2bX+Zy48QeCtnCbSiI7PQ/Qz5NIClHxRzxwfIHnU6njqq2E8yCYRJHmyoWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgmAaltwjbSynYz37Pt5RtVZxBGKNvjUnRBHPTm6JZQ=;
 b=pYMtaBRPOT2uZI0EIq3zq0HN8pSmE+fSJy3GCjHiKq2vhiT7WbrtNmgZE/kGbWtE2Be4prZo+ddILcD6J7zD3c4xGMxIwJxCl3pRCU7boeXdb3psxu5i1C+Qp28tynQP3CVdbs6FN9ii/HawNPqp3ouriY203HwAm53G1Uk8cpA=
Received: from SI2PR03MB5888.apcprd03.prod.outlook.com (2603:1096:4:145::6) by
 PSAPR03MB6233.apcprd03.prod.outlook.com (2603:1096:301:9a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Fri, 23 Dec 2022 07:33:07 +0000
Received: from SI2PR03MB5888.apcprd03.prod.outlook.com
 ([fe80::914:6297:ee3:511e]) by SI2PR03MB5888.apcprd03.prod.outlook.com
 ([fe80::914:6297:ee3:511e%9]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 07:33:06 +0000
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
Subject: Re: [PATCH v2 04/19] clk: mediatek: Add MT8188 peripheral clock
 support
Thread-Topic: [PATCH v2 04/19] clk: mediatek: Add MT8188 peripheral clock
 support
Thread-Index: AQHY540V82b5w2/KkUGvVUv1SuWepq4h62CAgFmHHIA=
Date:   Fri, 23 Dec 2022 07:33:06 +0000
Message-ID: <18aad0e87316269b70c71d49692f2ef9a22fef62.camel@mediatek.com>
References: <20221024094254.29218-1-Garmin.Chang@mediatek.com>
         <20221024094254.29218-5-Garmin.Chang@mediatek.com>
         <8c0da3f2-0e77-e960-dab4-0a1d02e0d21e@collabora.com>
In-Reply-To: <8c0da3f2-0e77-e960-dab4-0a1d02e0d21e@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5888:EE_|PSAPR03MB6233:EE_
x-ms-office365-filtering-correlation-id: 36cb5181-7627-4b5d-c1e3-08dae4b7ef22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dizakv3sKfdTEJEWTiRdunh/r/FHs4wq5TWJfaEX4udwOX4qBhqGxE+sqSHgoGNoxSshZKMJZ4kXp3EccVIMfuRYYmf42+eS7y0ZmwFf7lfQlQVSSRA5fuLj1+7BsesshfwGimWXQPVAgMFi9Q7Lakbcr7/r3wWwKOHWo6rA69VXQcYqZly6JSStUvM54jDax615QCcXY5MrVCNpM8BlH0yvAkTbRe/VN5A3s/rjJrYlCUCvUVUjZXOrU2fhnzlyVPxYTBAYi/Hiuiv1Z+TpcBGmn++Tu5m85D0aBH383eY7hy75wiQ/fqrkP41BkR01vHkjtZY9DhxKtjrr506/9weC8UjO0ysipBLr/lLnUrERtqpBi/ReZDYyyBWQAw4vvgZq3miUEQNNi00SiPWzjI9e7//IbIHJUzGZQTCwptqiaZ6FV16a8l/VG5QZfaq//3190hrb6gR+9CjZ2HzICh//k9mi0T+QnLI7UCYjq/z+f/cbH1FIUiKNDHs+bnEmUVAaUp+FV91DQEkpFhfu0+tgahT7qd7UHlZiabyNEPPgTSDQKj0QahdCuxwR1okMzOBbmcvg7dNH1hIszNU0ZFWjrGoWX5UX+2ReuHynIl0QdEn4pNDNZfBYfNmbabSEPOHVOkjyG3LAXSk4yKNyL6T3Ropok9u1SzkVbOviRZqrJtXqzObCAR0nQGzxWiiU6fbYoZNTsKI7hF4lB3E48GUUb5xsr2wk/EG44SAW0kljY3El7emnbT+bjrlKgBW6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199015)(86362001)(91956017)(66946007)(64756008)(66476007)(76116006)(8676002)(4326008)(316002)(66556008)(66446008)(85182001)(38070700005)(8936002)(2616005)(5660300002)(36756003)(41300700001)(6506007)(6512007)(83380400001)(26005)(186003)(71200400001)(110136005)(2906002)(6486002)(122000001)(54906003)(38100700002)(478600001)(4744005)(4001150100001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0hHS3FCemVQZ2N0aFJQMXlIcmxubXROanhjWDZ0cFU3VFB5VUU1N0M2M2sr?=
 =?utf-8?B?Z1N3S0lDNlZWbmZEcHJrckxnSG1FalpDeXBsR3QwRDR4YnZOeStldVFMT1hD?=
 =?utf-8?B?dGkza3BES3RNZkpTOUZHR3ZXVVB2M1BKUnpXRUVoaFBjQ2RvOW1zMlVjSnZm?=
 =?utf-8?B?TGpjSDBlWFNqZmVzSjZZcDZsMEUvYXVhelo0aDVRajRNVUx6ZUJYLzU4UTRO?=
 =?utf-8?B?VzVTN3J5blFnbExEbkkrdmMzdWhmanFmZXlkK1JTTHNjVm9GY3o3bnNseGRP?=
 =?utf-8?B?VU5DK3J0RkhzWTl1by96SGwwT0Z5S3NaSUdYM3ZLUjlNckYxZjJkSzAwa2Jo?=
 =?utf-8?B?SUlvTEpKcDJ0UWNzZnNZL01GQVpHK3duZnExcU9xdjZBMHBWS3NObkdUSU9M?=
 =?utf-8?B?Q1BwQXRiYkVWR2dTYUtrVHBDSTBiNngzRmNPdjZBZnp4dk0yb2hacGkvdmJP?=
 =?utf-8?B?eTJPYWFwNmVpRjNqVG5hTDBBb3R2ZE01RDAvcytOK0Z2emtOaGJRRFltSjJy?=
 =?utf-8?B?OGxmWDdVMkJhTTk3RktlaVJjaUphS3hOcm03bGM4dTU0V3V5QTNud0hsbE9w?=
 =?utf-8?B?ZklmMUd3YTN1aVVwalF2N1liMmMxWEw2NDc1QjRpMHdHTDFWSGFyK1B2UDRh?=
 =?utf-8?B?ZitvMnhWbUZxRklVUEh6b29mVTNjSjBLZzNzMG9NT2luOHN2Y2ZwemxwRnVm?=
 =?utf-8?B?K0JqbDNUVlNWNElCZ2crNkh1dEdhNnFEak9JYWNXUmRmb2hLdjZXTUVUelg3?=
 =?utf-8?B?ZzZLZzl2ekFOM2w4ZWxYbitkdUxybVdZVDNKNFhReTZHUER1S0hpWXlzRTJ2?=
 =?utf-8?B?WVY1M0JqZmFYWXh2ZzQ4Mko1VVlIdXZHZW5oOVYzdmE4ODhSem85OGZMQVlL?=
 =?utf-8?B?NUMzYzZ3eFRUT3JYaEpnUHZOR21XWjR2QmZNaVNycjdzL1N6eGJQcHhDODQ0?=
 =?utf-8?B?a0E3b0JjemVWRFlVL0JLZGpYRms3czRXaVBwVmtuZ0pBSDBQWGxvbE4vb2E2?=
 =?utf-8?B?cXBpL1YraTNmSEZISk52aCtKdHpoN2l4S1ZZLzQxVmpDaTFJOWdjcXdKOXp2?=
 =?utf-8?B?S1VZcjhHeTVaSWVuSXNxNTlHQ1ZyRzJnV2VhODdwblIvZzN4TlRKd21FQXlm?=
 =?utf-8?B?ak5ZOU5vdnJHMjV3ZWhCWjhVeE9nTFFvYWlLU0FqWERyRjN6ZERjMEFqaEU2?=
 =?utf-8?B?U1cxMVdYcS80VGovSktxbW9ySEtwMkhxL3o1Zi9kdGNWSEl5Sk5Wb3g5d3BH?=
 =?utf-8?B?Mk9NUzMxczdDaHBCb2xFOHU1QW5zYTluN1hOYzFsK3NwaUNpNm9SbGRRbnEy?=
 =?utf-8?B?bUlMb092MHBITXVRRWtXUFNxMWpVVjBLTVc2Vk9qMm9RUjBhZXpCRUp5aUxz?=
 =?utf-8?B?ZkhKWnYyZmNYd2NkVWpETmxDY0RyaGNMWElJODJRTzNTZ2VnVVdIQWlnU1Fm?=
 =?utf-8?B?ZXNnN0J2T2tYTDNnM3dZeDArR0krRHdCS3phME4yZTFSMkw0N3k5YTBoTm93?=
 =?utf-8?B?cTBqNEJUYU5LQnpTRVJJcnFOMlAxNWlTcDhwWWg4V2tRdHA4OGtzV2dzVDV6?=
 =?utf-8?B?ZnduNkw0ZEhBZnNCVm1jOGVIQStYOXRHQ1lHY2NjL2EzWDVRTnM3MSs2Mmw1?=
 =?utf-8?B?YWNuZkNHam5scVdOUG9nUzc1T2Y4U3BUUTZKODdGejB0UVFBejRJTGJyVHR3?=
 =?utf-8?B?MVUyUUN5N1BGMUxpNUQxcFI3MVpaRXBSRXd0SWJUQnNOZkNuMzIxc1o3SGxF?=
 =?utf-8?B?b1JWT2Z2Y1RscUtOMWRkc0prRXo3WWdwaFVnTVlMbElxSFVWeUZLaFJkMzFG?=
 =?utf-8?B?ckh0QllFYm1vdFFxYW9Ha2JOcllwME8rRlVUdFRzOTlpWWw5K2tiakhsQWtW?=
 =?utf-8?B?V3hWWVFvaCtCTm9BQmVneEZGcVdwTktYSlRsNVUxUVZTcnhmY00vcUdBY1F2?=
 =?utf-8?B?THJrSjJjbDJIOEdwZXhDZFFIMDR5V0hYbklwdFF0RFkrUE4vQnRvZ3NtdU1Q?=
 =?utf-8?B?Y2VNL2FsS3IxMnVlaDBiWHByaVlmdnZGZ3VsU2Y3TGZOQjlFZ2JrTjZjWkNv?=
 =?utf-8?B?Z1MzZHZNckhsK0Zzdi84MTJ1aGxIS3RjMlVPaXdFU0lTZUpVR3UxNGZpWDNJ?=
 =?utf-8?B?VTJEUThYY1Vxb01yWU56V1cyTCtWcEhUMW1oVzJ0L01ZdzZyMXVXbmwzdE5q?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F02F80BB87ABDC469F0702B20939D7E1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cb5181-7627-4b5d-c1e3-08dae4b7ef22
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 07:33:06.8214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Run5ErEzk29FOGR+ni5WIOFSIkF1uGDq0AoYpZKN2B/11rjZtChJ3KmYXDnjQAfCZ2Ndl88MoqypkAapWhC9tuL1MaYY3icWBjM3VxjCtOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6233
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTI3IGF0IDEwOjIyICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjQvMTAvMjIgMTE6NDIsIEdhcm1pbi5DaGFuZyBoYSBzY3JpdHRv
Og0KPiA+IEFkZCBNVDgxODggcGVyaXBoZXJhbCBjbG9jayBjb250cm9sbGVyIHdoaWNoIHByb3Zp
ZGVzIGNsb2NrDQo+ID4gZ2F0ZSBjb250cm9sIGZvciBldGhlcm5ldC9mbGFzaGlmL3BjaWUvc3N1
c2IuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogR2FybWluLkNoYW5nIDxHYXJtaW4uQ2hhbmdA
bWVkaWF0ZWsuY29tPg0KPiANCj4gLi5zbmlwLi4NCj4gDQo+ID4gKw0KPiA+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9tYXRjaF9jbGtfbXQ4MTg4X3BlcmlfYW9bXSA9IHsN
Cj4gPiArCXsNCj4gPiArCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtcGVyaWNmZ19h
byIsDQo+ID4gKwkJLmRhdGEgPSAmcGVyaV9hb19kZXNjLA0KPiA+ICsJfSwgew0KPiA+ICsJCS8q
IHNlbnRpbmVsICovDQo+ID4gKwl9DQo+ID4gK307DQo+ID4gKw0KPiANCj4gSGVyZSBhbmQgZm9y
IGFsbCBvZiB0aGUgb3RoZXIgZHJpdmVycyB0aGF0IHlvdSdyZSBpbnRyb2R1Y2luZyB3aXRoDQo+
IHRoaXMgc2VyaWVzLi4uDQo+IA0KPiBwbGVhc2UgY29tcHJlc3MgdGhpcyBhcnJheSB0byBvbmUg
bGluZSBwZXIgZW50cnksIGxpa2Ugc286DQo+IA0KPiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCBvZl9tYXRjaF9jbGtfbXQ4MTg4X3BlcmlfYW9bXSA9IHsNCj4gCXsgLmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ4MTg4LXBlcmljZmdfYW8iLCAuZGF0YSA9DQo+ICZwZXJpX2FvX2Rl
c2MgfSwNCj4gCXsgLyogc2VudGluZWwgKi8gfQ0KPiB9Ow0KPiANCj4gUmVnYXJkcywNCj4gQW5n
ZWxvDQo+IA0KDQogIE9rLCBJIHdpbGwgbW9kaWZ5IGFsbCBkcml2ZXJzIGluIHRoZSBuZXh0IHZl
cnNpb24uDQoNCj4gVGhhbmtzLA0KPiBCZXN0IFJlZ2FyZHMsDQo+IEdhcm1pbg0K
