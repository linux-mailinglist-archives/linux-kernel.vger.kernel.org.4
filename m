Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF86B6E3DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 05:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjDQDLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 23:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjDQDKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 23:10:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3331986;
        Sun, 16 Apr 2023 20:10:48 -0700 (PDT)
X-UUID: ea909b2adcca11edb6b9f13eb10bd0fe-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Y7qmAhb6VsFtseLci8xkGRlrVdW9a7zOyhwkPBgV+tc=;
        b=LUkii2Hv2KoyKH3G2dXMonywXga+aA08TQmaLpd5b2yiSSZycGCvkOWtOc8554HhhJGAKACvzlwsds/VmbW30UxOo3Ea5LtRRwbSk+gRSoTPH1wvGAM+BKtZPl09Dn0S4bcpDTxtYngwe0r6Cdxqp9DSkLC5UybkV0Ot3BlK6Fg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:0600209a-ded0-4197-b767-5d8b6062f09e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:3a774184-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: ea909b2adcca11edb6b9f13eb10bd0fe-20230417
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 868492570; Mon, 17 Apr 2023 10:52:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 10:52:38 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 10:52:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRWvzi4wEcMHn7bS47cWw3I+qCS8aU+YcdDlv/KxHtvoDwjF2cxA6ps/BQDqIikaC1FtNfzxeZSwoXksIPeNk3rZIAZElwNYDR0jKV/oaeHy/198ljMuxngxPj5MiTeBXWtQFB8DUYOv58NZLYEEDu9JkmZzboZ7AQpnkurFJVs/gcLgSP9nI+NDDpNJ5ti9YNLx276plqlRuZjnlz9gP/IStkDDEPuGwCXhNpMjUmyFjm/hjnhgc+ILVSnmmEQdGnbZqsGRsZ4D5Y0XwORQL7lxM3emdqm98rO+E+hZIE9ECvhr5TWzrfX+rM7T+g/OBdWnhat/gMiBQKqO9JfJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7qmAhb6VsFtseLci8xkGRlrVdW9a7zOyhwkPBgV+tc=;
 b=Mp9e5MF6op5sY98K3dazHICeMc+4fW6zL/2/Tqkz+mmRupSveRDca1vA/F0fyVJ1NU3jAezbKermx5v33uLwmmPVZF7fWivWaGqnuCf7UTfDwUimIN+fHL2thhfi67zIX5gWRcq4R3hUeOxtzp5VUtEFFwngFMCyFRlSbK3gpWWKCxAzpks0TJkxcWPJxvwawQNY2EVwpy2JPWKc+4CwUXY6zHrtkjmEWvEP7M1IdzN4Pa0uUTfqnFG318/5MoYcAsV9bJFxOSJ1CWppdhBl/xuj8sR4bq96mYGWexnq7+Aqx9rERcFVthkdPjWzxZBTxK+erA1RqGW9Ynns2pXfTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7qmAhb6VsFtseLci8xkGRlrVdW9a7zOyhwkPBgV+tc=;
 b=YzzQBPTtvU1KAQsRXj3DIkqE+m3n/GZVhsrDnQF8rju6kcWvCksUBc9/vM1bnyB59s4i+hG2evdW+nERRj/WjY1TdDejvfb0wTNRuGOHPSWdETtiZnW/G2q/Et5AHQUr/so+9C5dmybwBuKI+OVRW9J5980nitJq+lAVo/lvYsQ=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by KL1PR03MB7198.apcprd03.prod.outlook.com (2603:1096:820:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 02:52:36 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 02:52:35 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
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
Subject: Re: [PATCH 3/7] ASoC: mediatek: mt8188: revise ETDM control flow
Thread-Topic: [PATCH 3/7] ASoC: mediatek: mt8188: revise ETDM control flow
Thread-Index: AQHZbfVXHv1qNhspr0S8mreZJU45ZK8pOLuAgAWarAA=
Date:   Mon, 17 Apr 2023 02:52:35 +0000
Message-ID: <228e990dcb46d5640f03deeeec720f6a4d4715b3.camel@mediatek.com>
References: <20230413104713.7174-1-trevor.wu@mediatek.com>
         <20230413104713.7174-4-trevor.wu@mediatek.com>
         <e36598dd-4f83-90b4-1744-61d18744b02d@collabora.com>
In-Reply-To: <e36598dd-4f83-90b4-1744-61d18744b02d@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|KL1PR03MB7198:EE_
x-ms-office365-filtering-correlation-id: e763fec2-7968-4c99-1cb1-08db3eeecc68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJ4wN/P2WtSLcBZxr26ZPxmJ7qt4piR5KJ4O3GOGT1chMEYHXswh/CNgmPx7mYhI6lRxs1wmAX+F4K7L7G3QvgtkSiaooW8KZz0UEhKWmb4s2cOTIQVK6N9AhARl5amo4NHFPJrlXvVpwksxw7WzohyUay1YbJ4r+AmbAHbcV8+oyFQ4CbUpBOqkm8oFeYc2bEdjrZb4RkzORRH0PYBJcTVNrbykxTlBU51KfCkzyXllNBVRjydYTEgXF+N8DeQ0Z52Oash3IaKjMOIQAy6Q+w8MnjPOeFU5VDod6wI1511orPjebNmjn7bVrQo+ZRZQH9xej1btKbHkfrKeDTmKuRqMAi7AcuFlOk7MaBPG97W5d0FFcOsHqsS09EfjSK8g94nohJhOYdKW0mJvJ2TkpFNsIi1QB2x1lcq1K74IUuY3ASCHtEUNE+B0OcSATUOf/r/IN1EcM8MfiJMreUm1RIPPXmcHhk6IUvFMt88d4aiAEQ1INacl2yPm5b/dc40I9thfg2GTp0kd+JHWNr2K0OR2kbetjJic8rff+pRisPfkekbpnsL0x3h05EzvWMO0iPfRZmGgXrAn0z87szIDpHNg8NN9krtwJLbOMXSaLWpO7hcOkf9M/lYrZ886bkOkmWRh5GDpvVhVMhX8jgRZ4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(6486002)(54906003)(86362001)(110136005)(478600001)(71200400001)(36756003)(2616005)(85182001)(26005)(6506007)(38070700005)(38100700002)(6512007)(186003)(122000001)(316002)(4326008)(2906002)(64756008)(66446008)(66476007)(66556008)(66946007)(41300700001)(91956017)(76116006)(8936002)(8676002)(7416002)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFMrK0ZiYU9WUlY1dGxQcktZbXR5YXZ3TFVPK09makxZcTF0ak5Ba1ZSbTZT?=
 =?utf-8?B?WGF4UTk3cjRLVEdkbHlubE9EeXEzWlJzNlJ3RXdyeGx3M1FFR0xOb0RzeHh6?=
 =?utf-8?B?YlhyRTlQMlhLZTcwSXVxeGsvR2F0OFNBOUZtaWpaeVkwd0JPektUL2RzSVdu?=
 =?utf-8?B?Z2pVQTZTYVFIVDR2Vkwrc3RHNzRmdXlVT2RZQnlSMk1DUzhYbEhtcGZnQThJ?=
 =?utf-8?B?TmVqTU5NU3FBTTBtVGVNNTl5Nk5ZV0V6cXc4bG9PMVQrQjVnZHFWUVVMaGRa?=
 =?utf-8?B?bWRUdWxCTnNhYzRNM2F6c09OZlNKbjIwSC9FK1ZsQjcrYWFnRW5nUWFvTmF5?=
 =?utf-8?B?RFpMbUdMK1dWTFpZZDJ4WUxCaUNUZFgzdlBidFNVaVoxNGs0OVd5YXJ6NjZ1?=
 =?utf-8?B?aDlCOFplZmZ5VVBQSjlKSElxN2gvaDJrYU1WL3dxVUJXNHluT01SRzRIdWhz?=
 =?utf-8?B?OE9UZCt5bWRicUxpeW9zMlhxS2hZYWdFSjJyZGJ4dmJXVTRzMVBJdkdHbHVD?=
 =?utf-8?B?dFVJQkZlOVBsV0JZUE1yQVZjSGRUWUdoOFFwMUdncXlJRWw4aGYrNzJ3MVlI?=
 =?utf-8?B?aUhyWUt1Y0RTeXRjVFJaMkJQOXNLbTVERUF0M095UUlpblI5TGt4WlFWajAx?=
 =?utf-8?B?U05TaGVEUXhWWm00Y0owcnRMQUxDTFl4bStRN3JrOUR5MTkrRFMyOFpBU2tx?=
 =?utf-8?B?MS9vcWY4VlNoYnBCSHZPbVBkcm5CWC9aVVFVK0lCbFZBVkJhNmFUSkJYYUJo?=
 =?utf-8?B?R1hkTGgvdjdrenlMMk5ZcDJVNHVsRUo4SDNkTjdNWFZma1NEcWZsYURHM1pT?=
 =?utf-8?B?NW80aFdyNHRxS1JWNTdQMDJHSVVEd3RlVUsxQ0E4Mm1KU0tobUdwMHZscnY4?=
 =?utf-8?B?RmN0QUtpVjcwQ295SnhPUjZ4b053dko1VWFTc2s5cmx6aDZTdlpaV0ZZUkhN?=
 =?utf-8?B?TEV5NVQrckJtNjlIcVVLSEZvTW9CNkUwbmozSVRSMmhORkV3b1JBckFtWDRu?=
 =?utf-8?B?Q2M1bnE5Tm5KbUhaaTF1Tm9mdnNqMzRta3kzZXJydWhuYXVPS2hJMHhMMHR1?=
 =?utf-8?B?VWc4WVl6Sjc5cjJHOVBoamtxNm0rVGxVN0dHVC94OEE2bU9hbThuNC9DMzYz?=
 =?utf-8?B?aXBYL2NuOG8zeUxTMHlqRWIzcDJaanBDbUhLQ0thdTlwZlZGT3JRYW1wV2hZ?=
 =?utf-8?B?Ni9YSGJWM0I4TFJFcE4ycGxJeWE0cmNNaHBBaGcyY3IxSlRETVM0eFlrSU51?=
 =?utf-8?B?TGFmRVBSTWtMMWtsSFkxTFUyZ3orVDdoVTBEVTNIYlgzSUJhamtSSkhRWHBm?=
 =?utf-8?B?bWRUbUxQdEFwWjVMc1JCMWdpZXRjWDNYa1RIeTFXcWoyYmFDUmlKUkxoZEkr?=
 =?utf-8?B?Y1hJZ083dVMvZ3c1L2xVRVcySjl0L09kem5tcUZSb1NaTlhLcys5czg0Z2h2?=
 =?utf-8?B?Y3BRRCtCTzVtZ2FsR0hhSTJ2K1NrQVFZMGtRT3dpTkx5VXFQV3JMRWo2VkFB?=
 =?utf-8?B?UEdadEhldmxLT0ZJQm5WVTNmQXlkYkpmMTl2cVo4OEdkL1JuK3BvdmJjUDV6?=
 =?utf-8?B?LzdZNXB1U0lvOUk4ZkNzcHJrRVpEaTliY052dWFkWXloOWFVOXBaZUV1R1hM?=
 =?utf-8?B?RStGdEwwaXMvcE1USG54Q2NRSFpUYUhBN3pzMVFGaktkN2VVN2FOZGljYVh0?=
 =?utf-8?B?T0prUVZrdVJJWXBsQTFwc3J3d3p1U1B3MHhoT3M0dGROeE1sNGZsN09jQjBt?=
 =?utf-8?B?d1RYL1pyNkVKc1BtVXZUSnlmWWQvSDNTWjBFbC9FN3FzcWNQRVM5Y2dobngr?=
 =?utf-8?B?aXROdHhWM2JEYld0VDVkZVhBWlNySlBFRCs5aDdYcURzT0tqRktVVnFBUGhq?=
 =?utf-8?B?WkJ5dGcwbGNqcGdlNE55TE5mbjZabXZWODR1TWZLVVd0NU02YkVaL0hwcnVJ?=
 =?utf-8?B?a0ZHMzFGZWg5NnZ1ZFJVdytqc1JKS2tIMEJ4bnRzTGZ5R1U1clIrRHBZUUU3?=
 =?utf-8?B?end6R2VtMS91QnBJS3htS3cxc1lCWkdHclNMbHp6RWUrbXJaWlBBZ3BqdmFD?=
 =?utf-8?B?bFVpUksyc2VoUEZLUnVSOGxSMHF1UTM4M2dTZEw2amowcFVRQWpZRXptQVd0?=
 =?utf-8?B?R0sySWpYa200UmlsL1JIQUIweW9NUUNpZlZKbFl4QTY0WmpNOUxJVTVVMjE2?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F14E93AE21D9964780979968A9629D13@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e763fec2-7968-4c99-1cb1-08db3eeecc68
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 02:52:35.5180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qro/iKU2yS2toPCChtHSGRRnDISMtM6s3HflsTmB1FFhO+FVFxgK6EYy61CfcpDw+e9w1RI9n+zX8UNZduzjJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7198
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA0LTEzIGF0IDE1OjE3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gDQo+ID4gK3N0YXRpYyBpbnQgbXRrX2V0ZG1fbWNsa19jb25uZWN0KHN0
cnVjdCBzbmRfc29jX2RhcG1fd2lkZ2V0DQo+ID4gKnNvdXJjZSwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHNuZF9zb2NfZGFwbV93aWRnZXQgKnNpbmspDQo+ID4g
K3sNCj4gPiArICAgICBzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldCAqdyA9IHNpbms7DQo+ID4g
KyAgICAgc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjbXBudCA9DQo+ID4gc25kX3NvY19kYXBt
X3RvX2NvbXBvbmVudCh3LT5kYXBtKTsNCj4gPiArICAgICBzdHJ1Y3QgbXRrX2Jhc2VfYWZlICph
ZmUgPQ0KPiA+IHNuZF9zb2NfY29tcG9uZW50X2dldF9kcnZkYXRhKGNtcG50KTsNCj4gPiArICAg
ICBzdHJ1Y3QgbXQ4MTg4X2FmZV9wcml2YXRlICphZmVfcHJpdiA9IGFmZS0+cGxhdGZvcm1fcHJp
djsNCj4gPiArICAgICBzdHJ1Y3QgbXRrX2RhaV9ldGRtX3ByaXYgKmV0ZG1fcHJpdjsNCj4gPiAr
ICAgICBpbnQgbWNsa19pZDsNCj4gPiArDQo+ID4gKyAgICAgbWNsa19pZCA9IGdldF9ldGRtX2lk
X2J5X25hbWUoYWZlLCBzb3VyY2UtPm5hbWUpOw0KPiA+ICsgICAgIGlmIChtY2xrX2lkIDwgMCkg
ew0KPiA+ICsgICAgICAgICAgICAgZGV2X2luZm8oYWZlLT5kZXYsICJtY2xrX2lkIDwgMCIpOw0K
PiANCj4gU2luY2UgeW91J3JlIHJldHVybmluZyAwLCB0aGlzIGRvZXNuJ3QgYXBwZWFyIHRvIGJl
IGFuIGVycm9yIGFuZCB0aGlzDQo+IHByaW50IGlzDQo+IHVzZWxlc3MgdW5sZXNzIGl0IGlzIHVz
ZWQgZm9yIGRlYnVnZ2luZyBwdXJwb3Nlcy4NCj4gDQo+IFBsZWFzZSBjaGFuZ2UgaXQgdG8gZGV2
X2RiZygpLg0KPiANCj4gPiArICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsgICAgIH0NCj4g
PiArDQo+ID4gKyAgICAgZXRkbV9wcml2ID0gZ2V0X2V0ZG1fcHJpdl9ieV9uYW1lKGFmZSwgdy0+
bmFtZSk7DQo+ID4gKyAgICAgaWYgKCFldGRtX3ByaXYpIHsNCj4gPiArICAgICAgICAgICAgIGRl
dl9pbmZvKGFmZS0+ZGV2LCAiZXRkbV9wcml2ID09IE5VTEwiKTsNCj4gDQo+IGRldl9kYmcoKQ0K
PiANCj4gPiArICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4g
KyAgICAgaWYgKGdldF9ldGRtX2lkX2J5X25hbWUoYWZlLCBzaW5rLT5uYW1lKSA9PSBtY2xrX2lk
KQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuICEhKGV0ZG1fcHJpdi0+bWNsa19mcmVxID4gMCk7
DQo+ID4gKw0KPiA+ICsgICAgIGlmIChldGRtX3ByaXYtPmNvd29ya19zb3VyY2VfaWQgPT0gbWNs
a19pZCkgew0KPiA+ICsgICAgICAgICAgICAgZXRkbV9wcml2ID0gYWZlX3ByaXYtPmRhaV9wcml2
W21jbGtfaWRdOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuICEhKGV0ZG1fcHJpdi0+bWNsa19m
cmVxID4gMCk7DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gMDsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtdGtfZXRkbV9jb3dvcmtfY29ubmVjdChzdHJ1Y3Qg
c25kX3NvY19kYXBtX3dpZGdldA0KPiA+ICpzb3VyY2UsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHNuZF9zb2NfZGFwbV93aWRnZXQgKnNpbmspDQo+ID4gK3sN
Cj4gPiArICAgICBzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldCAqdyA9IHNpbms7DQo+ID4gKyAg
ICAgc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjbXBudCA9DQo+ID4gc25kX3NvY19kYXBtX3Rv
X2NvbXBvbmVudCh3LT5kYXBtKTsNCj4gPiArICAgICBzdHJ1Y3QgbXRrX2Jhc2VfYWZlICphZmUg
PQ0KPiA+IHNuZF9zb2NfY29tcG9uZW50X2dldF9kcnZkYXRhKGNtcG50KTsNCj4gPiArICAgICBz
dHJ1Y3QgbXQ4MTg4X2FmZV9wcml2YXRlICphZmVfcHJpdiA9IGFmZS0+cGxhdGZvcm1fcHJpdjsN
Cj4gPiArICAgICBzdHJ1Y3QgbXRrX2RhaV9ldGRtX3ByaXYgKmV0ZG1fcHJpdjsNCj4gPiArICAg
ICBpbnQgc291cmNlX2lkOw0KPiA+ICsgICAgIGludCBpOw0KPiA+ICsNCj4gPiArICAgICBzb3Vy
Y2VfaWQgPSBnZXRfZXRkbV9pZF9ieV9uYW1lKGFmZSwgc291cmNlLT5uYW1lKTsNCj4gPiArICAg
ICBpZiAoc291cmNlX2lkIDwgMCkgew0KPiA+ICsgICAgICAgICAgICAgZGV2X2luZm8oYWZlLT5k
ZXYsICIlcygpIHNvdXJjZV9pZCA8IDBcbiIsIF9fZnVuY19fKTsNCj4gDQo+IGRldl9kYmcoKSBw
bGVhc2UNCj4gDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiArICAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgIGV0ZG1fcHJpdiA9IGdldF9ldGRtX3ByaXZfYnlfbmFtZShhZmUsIHctPm5h
bWUpOw0KPiA+ICsgICAgIGlmICghZXRkbV9wcml2KSB7DQo+ID4gKyAgICAgICAgICAgICBkZXZf
aW5mbyhhZmUtPmRldiwgIiVzKCkgZXRkbV9wcml2ID09IE5VTExcbiIsDQo+ID4gX19mdW5jX18p
Ow0KPiANCj4gLi4uYWdhaW4uLi4gYW5kIGV2ZXJ5d2hlcmUgZWxzZS4NCj4gDQo+ID4gKyAgICAg
ICAgICAgICByZXR1cm4gMDsNCj4gPiArICAgICB9DQo+ID4gKw0KPiANCg0KDQpPSywgSSB3aWxs
IHJldmlldyBhbGwgZGV2X2luZm8gYW5kIHJlcGxhY2UgdGhlbSB3aXRoIGRldl9kYmcgaW4gVjIu
DQoNClRoYW5rcywNClRyZXZvcg0KDQo+IA0K
