Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D023F625256
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiKKEQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiKKEQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:16:17 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BF71CB30;
        Thu, 10 Nov 2022 20:16:12 -0800 (PST)
X-UUID: 39dbc440c6064b8281d115352b6ba998-20221111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=j2aR61Ga73WFOalM7hF3lIFwZxbK3xFI3rswnXQDS+I=;
        b=goRi7saXzfp/RkOw7aQ6wUz/Ly5pnSI8B1If3ZcVhcdlHCcjVzvD2UgsZ/nXXeqdM1evkkO1Fw693jUOl9rqv6I5dmrfJxeJQ1RUo/rGy+bR4ofZiW6GPg2p6FNSMJiSbpL7NaYPB1f/oD8qOKnHfoR77N/UitnCxJWL4xzrW94=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:de213943-b847-46a5-b2e4-225fb8426649,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d12e911,CLOUDID:671c415d-100c-4555-952b-a62c895efded,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 39dbc440c6064b8281d115352b6ba998-20221111
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <bayi.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2130459077; Fri, 11 Nov 2022 12:16:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 11 Nov 2022 12:16:05 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 11 Nov 2022 12:16:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hImWbHezFetq957k5cxGHtCJyjr0fOXilutn5gopFSn9U9Gl0CVo7JV49y3wujBfj9/qHe8efjjF3W3sTHhsIJWR9xMENG6HVFG7ilLrSz+mE6oeTgihcA35/jXPqACDC7O+p7SKWoKahd/BmobR0eY8ndfVcXHOwIkzfPy47TP9+h/adrpt3Sjx1vrh+RKrCegFCf4MhN1c848oOJbPPqAVGRaTs4OCrm4LgaF79rffdG7axTUNMhdfIEU5MhT2ywowy7G62lnMjREK6UNrwAfR/yaxaMFxTwWIDcZO5fpF0Imb8VMrJksi637riImmzOiCGyxF0jGmExDG0doSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2aR61Ga73WFOalM7hF3lIFwZxbK3xFI3rswnXQDS+I=;
 b=RBqey3sPHe/Uo9UVJ+rdJy26KBVXDQ6tE77Kq+NBneyzTZNrvqmtWj4Z2WW85q0wTm4IFVfrGxlaFc4KKehBEmchb1bbEUbqFN1KfdvDW740gKM/YncFq0NDRJBT7nSMeVccBBtQYRJjwNAgnR6x1bZslL8AtfVnUQA2RuE6mbA47mxTU2XWsXFuhJmj5rEMVSK6/XYtotHLRr1BO9G/PS/imwgY3wxxX2BZC9Ds+fQpCRghDmrnHLSIqyQmFia2Xi8Bwu6ayuMU8YOh3OPvNbb+BDkANfSBcVC8LsKRDfk6jylth+eR15Ipxy2MO9+75d9alD6bzPf7g8N1eIT+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2aR61Ga73WFOalM7hF3lIFwZxbK3xFI3rswnXQDS+I=;
 b=TZkrm0cXsgJQsFCxqZ3JG3dhJReKqq92pnJl/G5V4ppuemZ0H4mtfEjj26T2UiTae7nnFNVdO963eazEHyRRVwQfwDttLSENv+z+17TMwtB7l5IZzCBO0SKMZOljGes3AbIuGVKPTKPxFyTtXEthDBQj/gxkcDWtsYLI0eRD0TU=
Received: from PS1PR03MB4747.apcprd03.prod.outlook.com (2603:1096:300:86::18)
 by TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 04:16:03 +0000
Received: from PS1PR03MB4747.apcprd03.prod.outlook.com
 ([fe80::55cc:c325:bcf6:ce1f]) by PS1PR03MB4747.apcprd03.prod.outlook.com
 ([fe80::55cc:c325:bcf6:ce1f%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 04:16:03 +0000
From:   =?utf-8?B?QmF5aSBDaGVuZyAo56iL5YWr5oSPKQ==?= 
        <bayi.cheng@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Thread-Topic: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Thread-Index: AQHY70U3L+QgZhq720C1cLpB3c3zja4s8viAgADXjICAAJv0AIAKtUCA
Date:   Fri, 11 Nov 2022 04:16:03 +0000
Message-ID: <794a0249500bf90a79f30a3522108e721fe06e17.camel@mediatek.com>
References: <20221103052843.2025-1-bayi.cheng@mediatek.com>
         <20221103052843.2025-2-bayi.cheng@mediatek.com>
         <10529948-a9b8-2121-7adb-0e94cf3cbf6a@collabora.com>
         <c612cc0eb4fc463a9bfd9094ff652ac9@AcuMS.aculab.com>
         <617c0b563a2602668fde7d96e1bc98648870d30c.camel@mediatek.com>
In-Reply-To: <617c0b563a2602668fde7d96e1bc98648870d30c.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB4747:EE_|TYZPR03MB5743:EE_
x-ms-office365-filtering-correlation-id: 2a063bec-3e64-4a5d-b1a3-08dac39b724e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2lyeAB+MIaqY2TKlp9EQAPFCym4sqZ0ssyb6TGfX7/tvZCP2EUOYFPHDxspG5sRg7FUNPwZ5Q0h+3Uxj8UmCFTXepqxFRy07CJzu8nZmtpauWxDxcn78c+9KNjca/5JbImuP2HYo7qCpvzLr2An7wQIdoTieLkLmGGEpmfaHuOmK6i4eNvFc9zC0GWnR02QUAysRgbGzbJOZYRfrqsvO0x/RGeONO19G3HkQ5Q64ZdHUNSCXD3FdBB396C5vjnXYs7YfFMY8tCK/Fc0qZJCzoDKh17QvEn0sCO/TO42GIW2szv5hC5NDx8g2xUcLhzIvr02KRkSACFx1z0KiCsGJiDxF9UN3tnDr0syGVZcqXPs1qKgeDF++zz9VVepW8qCrm80OqvucSt+vocos3eG1Qzj3HeSq3GmGxvhUT30FUGedWLfkKzBnNblFs1HLMJlhmUSya06KGofPiiwl90R+WRkP4UdJbfXzWS17edk3qB//ZS8ChactyCD11AAn9YVcPmgdWEbUd7WrxHiUHdrGJ0Z/B34J4XIM6e1IPjuxvUSxi7asMThYagFXtkjGt7bUNHziKXRSCgsELn+bcfviR/7kNgUDcF/qdvWB0O3iRPdfVScojONrLipPO1WJr/du/TqNSTLrHyFCYD3VHRjfLgjHhhM8s9Gk/xX8qDvMQqUor7TBE8dk7WEHLw5U7wvx+4K/rWdOUNw/xoPOGxzBFXsf/9RcgZqtj6JfkFQ7EYTFKLlLzZ8lr+h8Fj3oF1o3dxRtZ1vAoQDpmmxGTEn/CBY5CuxlqYvGyWinfd/cgm5EtEG/1MxJdw0HoAAZpl9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB4747.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(122000001)(38100700002)(2906002)(86362001)(107886003)(38070700005)(4326008)(6506007)(110136005)(2616005)(6512007)(91956017)(64756008)(478600001)(26005)(316002)(66946007)(66476007)(76116006)(8676002)(71200400001)(6486002)(54906003)(8936002)(5660300002)(186003)(66446008)(36756003)(66556008)(41300700001)(85182001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTM5M3ZydGRvMlNsNDJRQm5iZFZYbWQzazRpZ20vMHVVQjBhck1sQ1JCWW8y?=
 =?utf-8?B?Y1I4UzNaZEhhMEQ5dDBZSHYxUDFjenNMNmVKaFczdzBobWZWamI1ZG5iOG1Z?=
 =?utf-8?B?YjA1czR5UlF6SVlLaHVMODBmOUJsdXlGMlA2RUhkVHNuM2Vzd2FGajJNZUR4?=
 =?utf-8?B?aUFSdGFjUmVadDVMaTNzTEpEVHJ0Y1FENzVSa09JRTlGYkJDbFcvU01SWUth?=
 =?utf-8?B?NHlZOVFkTHZWOVhEelNCOU5RNEk0dTJieWUwUUtRcFk2ZXV0NnFXZEQrdGRY?=
 =?utf-8?B?c0FSY3F0ZkN4V0lLUG9PZWkwUitVNnlFNVViRERiWjlPY1V0K1dnYU4rSlB3?=
 =?utf-8?B?eE1INXZvMjRxeWNKdjFwZ0p3akNaQm1zMzBSTWtZL2M4L3JxZEhTU3preEFx?=
 =?utf-8?B?allSeEFBVmt1TmZ0Z2UxaU5JME9lVS8xOVkzc1RORzhkOEVPN1dtOHhYSE8x?=
 =?utf-8?B?djgyZnNHNHR6My9zOERSa2lpdUU0WGg1Q2xsUjVvRGJlN3pTYVhhNy9FL1hq?=
 =?utf-8?B?d1N3b1RnTnl4OFN5Y2MxVlZPQzJOTUJmeTVXMEt6OGxXeHFvN1dOSzVSSHUv?=
 =?utf-8?B?YmNtWk1zeHNGOHU4ZStMYUNOaHVjeW82MUdITG9TWFVMY3A5eEM5UEJja3pI?=
 =?utf-8?B?ekNIQ1ExUkhCa0U1YXc2TVJBQkVXdGJkN0RnUzN4cTBzdTdIMk9BbHd3Q2hF?=
 =?utf-8?B?cTNSb0dvQ0lJSWdTV0NyNCtZRkFjK0kxcWlzUllIR2NONGQyU1E0OTJ3clI5?=
 =?utf-8?B?R1ZUcHI1eHR3VzlmNlFlTXpKUjJLRzVQc1ZTNUcyQ1F6RElUTjA0L2dWUGFU?=
 =?utf-8?B?N0U4Y2hQZGh0d01IMEZpWk5VaDBDSnBpa1RjajBMRG9ZWDFVVUJETm5TdHhj?=
 =?utf-8?B?aFhYbzVCZk41ZUg2dU9YTW9FZGp6eDFwVUFDd3lMSzJrUXMyS1lsZzVDVUM2?=
 =?utf-8?B?YTk2WnF4Z0JBYzNkRk16OWZyK0NFRlFYMTNFd0k5TktqQ3R3KzNSOUlvRldZ?=
 =?utf-8?B?UDgyOTJqSHRHL2FSOWVPZ1JJREFOalVOdGFXaXBoWHB5QVRJK2hSTnJ3T0t4?=
 =?utf-8?B?YkNMTU9wNUdnU3BJT2JCUlppZ2ZqS1VmOEtCb0dBaTlmd1ZWOTBUcFE0bU9S?=
 =?utf-8?B?NzdObk1sWUFTTUpZK1ZQb20vOEdFTDhWSU50ZzRMQXJjS3hodVM5eEJIKzhD?=
 =?utf-8?B?RnIxVTFPSjBoamtxeTFSRlBoV2JKb1Qzb0dTUWVHZ20vS05GVjc5Zk15dEk2?=
 =?utf-8?B?dE9DeVlUY3dheTY3R05xMmU5cGUwMXhoUldEeDdnUU1OcXBaS1VjdTQ2TkZS?=
 =?utf-8?B?ellUTForUDZrVnlyS0NPeVhvQTZKeHhtbTg4YUJsbXZMMFM0SlgwUDI4SXd3?=
 =?utf-8?B?b3N3M3pESnd4aDd1SlEweTRYS1NWQWxqTzIwV3ZmTjhDRFo2QXZsckh3MUpw?=
 =?utf-8?B?cW5hNnNqbWN0a3BUNitBZ24zeDlNNFJFTTdSZ0Q5bzdWZ2Q4RlhhNllrdnV4?=
 =?utf-8?B?akU2eVptbXIxNHRCSWdkQkQxZ3hCVWp6ZVJnZVhpUDZsVGxhdExBWnhlWWRH?=
 =?utf-8?B?dTQ4b0hIQ0F2QkR0YW9rZmFEUk5vbzI3T0w2bHJxY2RqYms3MFYxcGswb3Vt?=
 =?utf-8?B?b0xqUW5FcmljcnQ4a04zYjV2VG9CU05YRUh6aGNIcjVkUnloZ01vL1ZSdWNY?=
 =?utf-8?B?SU9sM3Mxc2Z3aVM0RWF0TitBQi9MSDUweUpvMnJHRHVqWmptZjJqNjdNUnpr?=
 =?utf-8?B?YWo0Z1Y3cndRMzd1KzQxYW54eVM5ZzNuY3NYazNVWVRvcGtrTWFmcDlKZGU5?=
 =?utf-8?B?QlFCVlU0OTZjRG1mQnAwNlVIajRHR2lZMm45bGthSkFFdGxsS1crMGJHWWt3?=
 =?utf-8?B?ZnVIbXdWdThVWE9ONVQ4WWY2cFBJOVc0YVpwczJLT2RuenAyVndNNWVkdk5a?=
 =?utf-8?B?Ym5IWU5LNlN5ZDZLbDh4N1RCSkM4K3o2VTZYUkcyZ2NXUklaVEh4b1JOUjZ5?=
 =?utf-8?B?d1grR3NxeDRNbDVVQXRyeU9yaTh6bEhGYmMvbnNJMmdscHFsT3FmQnMrelgv?=
 =?utf-8?B?V0RHNzF1RjhidzZkcnFrdUlwcnBsV2d0aTJDYi83cGJuVVUwNWFhdG1TRjRa?=
 =?utf-8?B?ZnZtb1c0V05zQnBQRDVRK2lJMmpkZ3BGbGV0bm9DREdJazRNNE5rRGQwalRP?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <118A61B2F60AAD469C5413D83ACA6211@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4747.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a063bec-3e64-4a5d-b1a3-08dac39b724e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 04:16:03.1141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0soQIX2qnOJJ8F7GhopaakOjAP2J0rR5oWLDsy6MkBNmQPUfOD9XXnQpO5JjUREoZW/xGoBrcRlMKVbX2+h/hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5743
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTA0IGF0IDA3OjUzICswMDAwLCBCYXlpIENoZW5nICjnqIvlhavmhI8p
IHdyb3RlOg0KPiBPbiBUaHUsIDIwMjItMTEtMDMgYXQgMjI6MzUgKzAwMDAsIERhdmlkIExhaWdo
dCB3cm90ZToNCj4gPiBGcm9tOiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+ID4gU2Vu
dDogMDMgTm92ZW1iZXIgMjAyMiAwOTo0NA0KPiA+ID4gDQo+ID4gPiBJbCAwMy8xMS8yMiAwNjoy
OCwgQmF5aSBDaGVuZyBoYSBzY3JpdHRvOg0KPiA+ID4gPiBGcm9tOiBiYXlpIGNoZW5nIDxiYXlp
LmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSB0aW1lb3V0IHZhbHVl
IG9mIHRoZSBjdXJyZW50IGRtYSByZWFkIGlzIHVucmVhc29uYWJsZS4gRm9yDQo+ID4gPiA+IGV4
YW1wbGUsDQo+ID4gPiA+IElmIHRoZSBzcGkgZmxhc2ggY2xvY2sgaXMgMjZNaHosIEl0IHdpbGwg
dGFrZXMgYWJvdXQgMS4zbXMgdG8NCj4gPiA+ID4gcmVhZCBhDQo+ID4gPiA+IDRLQiBkYXRhIGlu
IHNwaSBtb2RlLiBCdXQgdGhlIGFjdHVhbCBtZWFzdXJlbWVudCBleGNlZWRzIDUwcw0KPiA+ID4g
PiB3aGVuDQo+ID4gPiA+IGENCj4gPiA+ID4gZG1hIHJlYWQgdGltZW91dCBpcyBlbmNvdW50ZXJl
ZC4NCj4gPiA+ID4gDQo+ID4gPiA+IEluIG9yZGVyIHRvIGJlIG1vcmUgYWNjdXJhdGVseSwgSXQg
aXMgbmVjZXNzYXJ5IHRvIHVzZQ0KPiA+ID4gPiBtc2Vjc190b19qaWZmaWVzLA0KPiA+ID4gPiBB
ZnRlciBtb2RpZmljYXRpb24sIHRoZSBtZWFzdXJlZCB0aW1lb3V0IHZhbHVlIGlzIGFib3V0IDEz
MG1zLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogYmF5aSBjaGVuZyA8YmF5aS5j
aGVuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgIGRyaXZlcnMvc3BpL3Nw
aS1tdGstbm9yLmMgfCA3ICsrKystLS0NCj4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc3BpL3NwaS1tdGstbm9yLmMgYi9kcml2ZXJzL3NwaS9zcGktbXRrLQ0KPiA+ID4g
PiBub3IuYw0KPiA+ID4gPiBpbmRleCBkMTY3Njk5YTFhOTYuLjNkOTg5ZGI4MGVlOSAxMDA2NDQN
Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLW10ay1ub3IuYw0KPiA+ID4gPiArKysgYi9k
cml2ZXJzL3NwaS9zcGktbXRrLW5vci5jDQo+ID4gPiA+IEBAIC0zNTQsNyArMzU0LDcgQEAgc3Rh
dGljIGludCBtdGtfbm9yX2RtYV9leGVjKHN0cnVjdCBtdGtfbm9yDQo+ID4gPiA+ICpzcCwgdTMy
IGZyb20sIHVuc2lnbmVkIGludCBsZW5ndGgsDQo+ID4gPiA+ICAgCQkJICAgIGRtYV9hZGRyX3Qg
ZG1hX2FkZHIpDQo+ID4gPiA+ICAgew0KPiA+ID4gPiAgIAlpbnQgcmV0ID0gMDsNCj4gPiA+ID4g
LQl1bG9uZyBkZWxheTsNCj4gPiA+ID4gKwl1bG9uZyBkZWxheSwgdGltZW91dDsNCj4gPiA+ID4g
ICAJdTMyIHJlZzsNCj4gPiA+ID4gDQo+ID4gPiA+ICAgCXdyaXRlbChmcm9tLCBzcC0+YmFzZSAr
IE1US19OT1JfUkVHX0RNQV9GQURSKTsNCj4gPiA+ID4gQEAgLTM3NiwxNSArMzc2LDE2IEBAIHN0
YXRpYyBpbnQgbXRrX25vcl9kbWFfZXhlYyhzdHJ1Y3QNCj4gPiA+ID4gbXRrX25vcg0KPiA+ID4g
PiAqc3AsIHUzMiBmcm9tLCB1bnNpZ25lZCBpbnQgbGVuZ3RoLA0KPiA+ID4gPiAgIAltdGtfbm9y
X3JtdyhzcCwgTVRLX05PUl9SRUdfRE1BX0NUTCwgTVRLX05PUl9ETUFfU1RBUlQsDQo+ID4gPiA+
IDApOw0KPiA+ID4gPiANCj4gPiA+ID4gICAJZGVsYXkgPSBDTEtfVE9fVVMoc3AsIChsZW5ndGgg
KyA1KSAqIEJJVFNfUEVSX0JZVEUpOw0KPiA+ID4gPiArCXRpbWVvdXQgPSAoZGVsYXkgKyAxKSAq
IDEwMDsNCj4gPiA+ID4gDQo+ID4gPiA+ICAgCWlmIChzcC0+aGFzX2lycSkgew0KPiA+ID4gPiAg
IAkJaWYgKCF3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJnNwLT5vcF9kb25lLA0KPiA+ID4g
PiAtCQkJCQkJIChkZWxheSArIDEpICoNCj4gPiA+ID4gMTAwKSkNCj4gPiA+ID4gKwkJICAgIG1z
ZWNzX3RvX2ppZmZpZXMobWF4X3Qoc2l6ZV90LCB0aW1lb3V0IC8NCj4gPiA+ID4gMTAwMCwNCj4g
PiA+ID4gMTApKSkpDQo+ID4gPiANCj4gPiA+IFlvdSdyZSBnaXZpbmcgYSBgc2l6ZV90YCB2YXJp
YWJsZSB0byBtc2Vjc190b19qaWZmaWVzKCksIGJ1dA0KPiA+ID4gY2hlY2tpbmcgYGppZmZpZXMu
aGAsDQo+ID4gPiB0aGlzIGZ1bmN0aW9uIHRha2VzIGEgYGNvbnN0IHVuc2lnbmVkIGludGAgcGFy
YW0uDQo+ID4gPiBQbGVhc2UgY2hhbmdlIHRoZSB0eXBlIHRvIG1hdGNoIHRoYXQuDQo+ID4gDQo+
ID4gVGhlIHR5cGUgc2hvdWxkbid0IG1hdHRlciBhdCBhbGwuDQo+ID4gV2hhdCBtYXR0ZXJzIGlz
IHRoZSBkb21haW4gb2YgdGhlIHZhbHVlLg0KPiA+IA0KPiA+IFF1aXRlIHdoeSB5b3UgbmVlZCB0
byB1c2UgbWF4X3Qoc2l6ZV90LCAuLi4pIGlzIGFub3RoZXIgbWF0dGVyLg0KPiA+IHRpbWVvdXQg
aXMgdWxvbmcgc28gbWF4KHRpbWVvdXQvMTAwMCwgMTB1bCkgc2hvdWxkIGJlIGZpbmUuDQo+ID4g
DQo+ID4gQnV0IGlzIHVsb25nIGV2ZW4gcmlnaHQ/DQo+ID4gVGhlIGRvbWFpbiBvZiB0aGUgdmFs
dWUgaXMgYWxtb3N0IGNlcnRhaW5seSB0aGUgc2FtZSBvbiAzMmJpdCBhbmQNCj4gPiA2NGJpdC4N
Cj4gPiBTbyB5b3UgYWxtb3N0IGNlcnRhaW5seSBuZWVkIHUzMiBvciB1NjQuDQo+ID4gDQo+ID4g
CURhdmlkDQo+ID4gDQo+IA0KPiBIaSBEYXZpZCAmIEFuZ2Vsbw0KPiANCj4gVGhhbmsgeW91IGZv
ciB5b3VyIGNvbW1lbnRzIQ0KPiBUbyBzdW0gdXAsIEkgdGhpbmsgdGhlIG5leHQgdmVyc2lvbiB3
aWxsIG1ha2UgdGhlIGZvbGxvd2luZyB0d28NCj4gY2hhbmdlczoNCj4gMSwgVGhlIHRpbWVvdXQg
dmFsdWUgd2lsbCBub3QgZXhjZWVkIHUzMiwgc28gdGhlIHR5cGUgb2YgdGltZW91dCB3aWxsDQo+
IGJlIGNoYW5nZWQgZnJvbSB1bG9uZyB0byB1MzIuDQo+IDIsIENoYW5nZSBtc2Vjc190b19qaWZm
aWVzKG1heF90KHNpemVfdCwgdGltZW91dCAvIDEwMDAsIDEwKSkgdG8gYmUNCj4gbXNlY3NfdG9f
amlmZmllcyhtYXgodGltZW91dCAvIDEwMDAsIDEwVSkpLg0KPiANCj4gSWYgeW91IHRoaW5rIHRo
ZXNlIGNoYW5nZXMgYXJlIG5vdCBlbm91Z2gsIHBsZWFzZSBsZXQgbWUga25vdywNCj4gVGhhbmtz
77yBDQo+IA0KPiBCZXN0IFJlZ2FyZHMsDQo+IEJheWkNCj4gDQoNCkhpIEFuZ2VsbywgSGkgRGF2
aWQsDQoNCkp1c3QgYSBnZW50bGUgcGluZyBvbiB0aGlzLg0KQ291bGQgeW91IHBsZWFzZSByZXZp
ZXcgdGhpcyBwYXRjaCBhbmQgZ2l2ZSB1cyBzb21lIHN1Z2dlc3Rpb24/DQoNClBTOiBXaXRoIHlv
dXIgcGVybWlzc2lvbiwgSSB3aWxsIG1ha2UgdGhlIGZvbGxvd2luZyBjaGFuZ2VzIGluIHRoZSBu
ZXh0DQp2ZXJzaW9uOg0KDQpDaGFuZ2UgaW4gdjI6DQogIC1DaGFuZ2UgdGhlIHR5cGUgb2YgInRp
bWVvdXQiIGZyb20gdWxvbmcgdG8gdTMyLg0KICAtUmVwbGFjZSBtYXhfdCB3aXRoIG1heC4NCg0K
DQpUaGFua3MuDQoNCkJScywNCkJheWkgQ2hlbmcNCg0KPiA+ID4gDQo+ID4gPiBBc2lkZSBmcm9t
IHRoYXQsIHlvdXIgYHRpbWVvdXRgIHZhcmlhYmxlIGNvbnRhaW5zIGEgdGltZW91dCBpbg0KPiA+
ID4gbWljcm9zZWNvbmRzIGFuZA0KPiA+ID4gdGhpcyBtZWFucyB0aGF0IGFjdHVhbGx5IHVzaW5n
IG1zZWNzX3RvX2ppZmZpZXMoKSBpcyBzdWJvcHRpbWFsDQo+ID4gPiBoZXJlLg0KPiA+ID4gDQo+
ID4gPiBQbGVhc2UgdXNlIHVzZWNzX3RvX2ppZmZpZXMoKSBpbnN0ZWFkLg0KPiA+ID4gDQo+ID4g
PiBSZWdhcmRzLA0KPiA+ID4gQW5nZWxvDQo+ID4gDQo+ID4gLQ0KPiA+IFJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24NCj4gPiBLZXlu
ZXMsDQo+ID4gTUsxIDFQVCwgVUsNCj4gPiBSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K
