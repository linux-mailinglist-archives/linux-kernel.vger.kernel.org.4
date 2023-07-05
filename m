Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2828B747EB6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjGEH5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjGEH5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:57:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FB7E6B;
        Wed,  5 Jul 2023 00:57:30 -0700 (PDT)
X-UUID: 93bee48c1b0911eeb20a276fd37b9834-20230705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=xOm6W/TSLbgzz+5xj+0yXdsBregd6GOZH5u878Z4b5o=;
        b=UEQSHtTjWpA9lQKNrqGGLAK+vfDa2a6M75L4PkxTTlHryDBtoUdyqbW33VHLaf8K/ILDcooFkYy8cLbcwhbMhbhL6TGJy2lsaZV8rf6gQGIp+WJJrEsrUH+qneXaK4R4/2QoVKbdbOcohog1iwD4FzlcjiQRxDwFj1QUj+NAXk4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:3ed09440-95ac-4e7b-aaca-3720cf8322ad,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:3f61b882-5a99-42ae-a2dd-e4afb731b474,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 93bee48c1b0911eeb20a276fd37b9834-20230705
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1460389318; Wed, 05 Jul 2023 15:57:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 5 Jul 2023 15:57:23 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 5 Jul 2023 15:57:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvY+Cm3FIKd98bYPPPlxiUdme20p8hs1topDPq5Svdxx5MG4U6vGnn5tP7pMd8TycCINVN+WAdCnsUa+vuxdDQn1hfjtUlx5K44F6vzp7MHs2SUQvRQZLdCty5nXEktd6CDel0P91HacqoGlxXGR5LubOXUU+m04cGG5hfNUJlMcufL+2jwDvqgevSYiFNQyOHtR+fpBWXXOJheLdHFr2jJ8A65s/6HufY8+jwyqItIFCV3VddJm01Eb0wdo7e3EA/YDxmE0CTnYeIqMAdYdep5G1HA5nO/IqdJ6njuGSCevinWmH16xuY7NsMJ8qQNYINuNVcBZZHytZA3Mu/MVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOm6W/TSLbgzz+5xj+0yXdsBregd6GOZH5u878Z4b5o=;
 b=BJMERv4jPTUDS+1hVEZeSgdsV8dJVIxcXuoXCtDanmZENke0TxwhT3XPhEVEoz5AeogEVZl1ZzlFVOE4ho6E+kVYiQq413Mfcpy1Y6VLmZMFq8YVa0yDL5BygnF9aRGLeLRxZ0trkFCFia4GELrdi6Qz808Fc9hxoCGURDN70wCPGp+evACuDGOhykdYYCom+45RIW7j38YJbJJta2+Gns3qeojCJ45VDn8O/eTrHMUyz7u7InAJi1vpWOTfmguStoLuLR7RXjZ0+80MDaOcj/tDLxEorUK9TGgXF+3/P0s5wmyhJa3JUyDg/PjiaTka54B+BQ5KNhuI+UXcEy6cUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOm6W/TSLbgzz+5xj+0yXdsBregd6GOZH5u878Z4b5o=;
 b=sV8F7h2c49ShrBqVAh25rAs2waAfzfVNkfwJlZ7eBcuGau2APbyG2AhKEQRBiLMS/H0505sjJB5GqZVjSWKbRMSvUwwAM1nSgghubL5aN6+T6azBWnujJn6lwB6ZoHVLL6uyB80gsXczHT8O+2/FBqT/AET+MnPOgg+foBLXENI=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by KL1PR03MB7766.apcprd03.prod.outlook.com (2603:1096:820:e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 07:57:20 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::d577:e8be:3ef3:6bd1]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::d577:e8be:3ef3:6bd1%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:57:20 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 3/7] ASoC: mediatek: mt7986: support etdm in platform
 driver
Thread-Topic: [PATCH v2 3/7] ASoC: mediatek: mt7986: support etdm in platform
 driver
Thread-Index: AQHZp9biSGo7vHiIxky71xuMAfTTHa+pW78AgAGBNgA=
Date:   Wed, 5 Jul 2023 07:57:20 +0000
Message-ID: <9d53111707f1247447b34c40fe68d76cec317ddb.camel@mediatek.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
         <20230626023501.11120-4-maso.huang@mediatek.com>
         <255bb946-2198-93e7-7f38-7b8e00f7677f@collabora.com>
In-Reply-To: <255bb946-2198-93e7-7f38-7b8e00f7677f@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|KL1PR03MB7766:EE_
x-ms-office365-filtering-correlation-id: 44110889-a5f2-460b-e44b-08db7d2d75aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qEpLkrNy+PJCFyK+WbsukAMt+nNN8KK4OtmpBFpPI2WS4f4xO64JidN5tWG3PN3+yyON2JPigcQhi1aN0SGIv7TWu2QS7QPwqMznDtTyil0gTP33mukDqrnqLxKjdwS9Stgpnk66iG1Vw/HZsdEM3st+ZxNGf6TwRbQicjnHaN3Ut2Gdy61Hq9fiD7GwTrZnkhFrODyk1RVXcJIxWhQ6/r9qa8OW5tLrFfofM72WuXmWUMKBnRmLUZuUTbW+8sS/2qWegaQQeBjpf/qvFLdq373uRrVj5rvFAL01ldrllm6cJCBqxIix/Zg0H04kuvVyv3nBQxOcBkReeQjHKhudE1fsBZ6RTLLNdNmTWPNI0aToMkm+6p+aMwVjBJq7dwUbCR4oai3WUmL1uyzED3/2jbczHCYV8vqWWMZ0DRx3+/Lslqb7QMRbqBkLe+jgYyQO8egm6hsdpMmRwyEGwm7Jpv1gVkKJvbnRYuCR6MbiBYvXFhi78HHuvtxSFM6V3KMjk4RSjgKyHQinnIAD6N/k4TlByL6tzSGiXLWLHZljR/6PaRW+sEa8w/FlZGANpLeXy4jnoVa9qE0iG7mz9mXqTmnmmVeWiTmuxY75FJ9Z3d1hbXzAkMArUbxt+tvQA/Kl7G6jI/KQAEo2LrRHE2V6TQI40U+n+cKIUeKr96Bbbv+zyOaUcYJ6JcreFOTozS/C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(2616005)(6512007)(110136005)(6486002)(478600001)(71200400001)(6506007)(186003)(26005)(2906002)(64756008)(7416002)(8936002)(5660300002)(66946007)(66476007)(66446008)(91956017)(41300700001)(8676002)(66556008)(76116006)(122000001)(316002)(921005)(38100700002)(85182001)(86362001)(38070700005)(36756003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlRFcUxNZXhJeXJNbU9lUVl0aWl4NkpJRnR0d1NkR1IwZ3ZsTy92bWU1M01D?=
 =?utf-8?B?UUhOTGZna21SYk1ubVFXVEN5RGRhV1dCSURnb0Nya1dwYnc4aHVyejgwOENw?=
 =?utf-8?B?VWtsMUJ2bkcyZTU4dk1ucnhLMUc4eFlBYzNHajAxU3RrR1BoaEU0VUc0RzF0?=
 =?utf-8?B?RjVJNk9OaGxxYTVveTNRN2IxNXhmWHRjbXkrVjR1WVhVVmYwcUd2Z0VyNVl5?=
 =?utf-8?B?TlEyUFh5T3JSR2pUa2I5UEFvOE1hallnNkcwSjNpd1FTbk9ieXdXMUhHdFJB?=
 =?utf-8?B?Q3JlZG1CcUNUdjRDQ0Urd3R2QVB5eW43WnNIdS9VZW11SEYwQUxQcTdIMU83?=
 =?utf-8?B?ci9UK3c3Sm05N1U4V3NMdGI0UElZT3l0c0drREoyUXQrL2k2WVF6MFpKMnU3?=
 =?utf-8?B?aGdlMDJ3d1lZMmxsTnVJZFNMdFh4dkN4Z2RRbE5oSklVeVRXR2NXMWZESTFO?=
 =?utf-8?B?Rkw1QmRsR0UrYmt5dm0yak1reVBpaWN0QVA5a2R4NjhoNnA4VmorMmwycm50?=
 =?utf-8?B?YUFiSzAyT3dtTHUzVUIzUHoxd2ZjK3VDWitvMERwS1RaNTlWelpNMUNCOWhq?=
 =?utf-8?B?K29JN2EzQmJUKyt2bm9tYW4vVGFtL3dBVXcwazhzeVJlWDUyOHUyVEJHV0Fh?=
 =?utf-8?B?am95MWFzek1Qb0VUa1VFcGZtUW8weWw4RVdYSmhoekhwV1BYUGdTS1dIdnhi?=
 =?utf-8?B?cFdVeGVzaEJTbzB1RzJBMHRFSG1PT1ZlMXBaU1ZIck05aEdoTEVhZHkvZGtK?=
 =?utf-8?B?a1krMjJEc1Z4cTNtU25KLzdRUWJXcDU3NWJDbDA2MFhIMFdxMTRNOTM3dGZi?=
 =?utf-8?B?Y3NzT0NqVEJNODVSbEhUOC9QZEMvdDVLYlZLTWQ4cGtWak8rZ090Q3VTSXlq?=
 =?utf-8?B?ZHZwMi9iUzkxaEdXSDRQUTU5L1BLTk5VUWdwdjYvcVNTYmdlNjNYZ2tTNnBT?=
 =?utf-8?B?d2dCZTdGRlFoUVBYWnBPSmtaazNuREpsMjh3aHhGTlBoUVpxMDdKd3IvK2Vp?=
 =?utf-8?B?b0UzYUpOY1ZvZlJ5RXo3bkVzbE1Ba1diYzk5OHpTaytCd205MEx6b3l4OUV5?=
 =?utf-8?B?RDNSL0d6U0dxYkxsTFV2WVo0bjFlS1NWR09jak9EM1VqMndaRWhZeGpqR3lz?=
 =?utf-8?B?QXJDdlJGSkIvUEJvbG5NZUdkQ0R1aEcvZGxpM0VySlhRSmtjekd0RFFLbzJz?=
 =?utf-8?B?TjNNcGExN2FWWWN5ZWk3Z1JlckJiM2VrRW1Hb1BUd09wZlhRZnFOQXJFbWRQ?=
 =?utf-8?B?OWNHR05ZRGFuQytFaXVvUzc0c0lnQUVxQ3hWV1U4TjdtYW5GcmdSZnc3aUZD?=
 =?utf-8?B?OUR6VWNDREZuQVVEdGZnajg0UytBdjhxYUtnRWpHNnVmenpzOFRqb0Q1bjN4?=
 =?utf-8?B?SVV5TGZ0SlBSS1hiQjRPVFJENkpZNEkzVFR0eTFpcGo2MysxMWhmVFdvOGk5?=
 =?utf-8?B?VGZ6aFhxdFlUMVdGaU5jOExuakZpaHBiM1pFdko4UmxaWGk2Z09zQnQvVWxj?=
 =?utf-8?B?NzJOZWJGRWZ0QjZWTFN2QnhUcHUrdjFDUDhCT0Z4QjAvVWhKdHAyYXpIV1pY?=
 =?utf-8?B?a0NLRFJaYndTb2Z1MWFYSUhKdUZUUHhJK2t2cWxQa081b3VONUVnMGxpTkt6?=
 =?utf-8?B?K1BMdXRSUGdETi9URDF5dnpEZFNicWhpa1pkYm9HK2p5am5iZWVQdmtOVmtY?=
 =?utf-8?B?dGExZFp2dm9mZG1TTHZiR0JWSWMvQzYwbTVaS094Y2JGZElPN1F2RTFLTUxW?=
 =?utf-8?B?eHY1elhiUWNLY1lzWG1RSWxJamJUQkd0NmZhY0NsSEJKWUd0NTQvYlJZbUFs?=
 =?utf-8?B?dkc1dnMzSFVBTUUzMGxTTUtJNm1XZmlIbGRqNzJzUlRWYnI4bGlXS2hzZEYw?=
 =?utf-8?B?YW1VYlRUckpkV2E5SkVnRzhnaUUxZ0Rtczc5OEpUWVhlOEIvV01TREZ1VWdz?=
 =?utf-8?B?VEpDU1hRNGRJR1RQdWVFYy9iUVJqNGxSYlJKc0o2WktaVk0rSGxwTzBBdlFl?=
 =?utf-8?B?MGFHZzhhZTlBbXRSTXcxRW5jTE1obVdoU0gxTUI0cmNObGp3aUR1RXVyWGlo?=
 =?utf-8?B?VGlSY09HeEdDRGdYLzU5Y2JQYXo5NWNITGJVeFJjTGRhQVpDWG43OHhFc2R6?=
 =?utf-8?B?TEJNT1BzK3JsTVh6QmNSQkNoUFUyZ293UmFFK0VNMGJEUFdrQWRTK2JGRDRt?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20C59BDC34D20246A173F1EA03A283ED@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44110889-a5f2-460b-e44b-08db7d2d75aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 07:57:20.3762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GU1e2tsRDzDdaM2dGUTcOXksMYfM1wXxTaOK19AXPB9uFFOD/suu13dhxK/g9PQfoVQ7eDOStFHMjPtcV5QFMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7766
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTA0IGF0IDEwOjU4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAyNi8wNi8yMyAwNDozNCwgTWFzbyBIdWFu
ZyBoYSBzY3JpdHRvOg0KPiA+IEFkZCBtdDc5ODYgZXRkbSBkYWkgZHJpdmVyIHN1cHBvcnQuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFzbyBIdWFuZyA8bWFzby5odWFuZ0BtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1kYWkt
ZXRkbS5jIHwgNDIxDQo+ICsrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgNDIxIGluc2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2Mv
bWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1kYWktZXRkbS5jDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvbXQ3OTg2LWRhaS1ldGRtLmMNCj4gYi9zb3VuZC9z
b2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1kYWktZXRkbS5jDQo+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjY3MmRlYjU5ZWE0Ng0KPiA+IC0tLSAvZGV2
L251bGwNCj4gPiArKysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1kYWktZXRk
bS5jDQo+ID4gQEAgLTAsMCArMSw0MjEgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICogTWVkaWFUZWsgQUxTQSBTb0MgQXVkaW8gREFJ
IGVURE0gQ29udHJvbA0KPiA+ICsgKg0KPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjEgTWVkaWFU
ZWsgSW5jLg0KPiA+ICsgKiBBdXRob3I6IFZpYyBXdSA8dmljLnd1QG1lZGlhdGVrLmNvbT4NCj4g
PiArICogICAgICAgICBNYXNvIEh1YW5nIDxtYXNvLmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAr
ICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGludXgvYml0b3BzLmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9yZWdtYXAuaD4NCj4gPiArI2luY2x1ZGUgPHNvdW5kL3BjbV9wYXJhbXMuaD4NCj4g
PiArI2luY2x1ZGUgIm10Nzk4Ni1hZmUtY2xrLmgiDQo+ID4gKyNpbmNsdWRlICJtdDc5ODYtYWZl
LWNvbW1vbi5oIg0KPiA+ICsjaW5jbHVkZSAibXQ3OTg2LXJlZy5oIg0KPiA+ICsNCj4gPiArZW51
bSB7DQo+ID4gK0hPUFBJTkdfQ0xLID0gMCwNCj4gPiArQVBMTF9DTEsgPSAxLA0KPiA+ICt9Ow0K
PiA+ICsNCj4gPiArZW51bSB7DQo+ID4gK01US19EQUlfRVRETV9GT1JNQVRfSTJTID0gMCwNCj4g
PiArTVRLX0RBSV9FVERNX0ZPUk1BVF9EU1BBID0gNCwNCj4gPiArTVRLX0RBSV9FVERNX0ZPUk1B
VF9EU1BCID0gNSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK2VudW0gew0KPiA+ICtFVERNX0lONSA9
IDIsDQo+ID4gK0VURE1fT1VUNSA9IDEwLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArZW51bSB7DQo+
ID4gK01US19FVERNX1JBVEVfOEsgPSAwLA0KPiA+ICtNVEtfRVRETV9SQVRFXzEySyA9IDEsDQo+
ID4gK01US19FVERNX1JBVEVfMTZLID0gMiwNCj4gPiArTVRLX0VURE1fUkFURV8yNEsgPSAzLA0K
PiA+ICtNVEtfRVRETV9SQVRFXzMySyA9IDQsDQo+ID4gK01US19FVERNX1JBVEVfNDhLID0gNSwN
Cj4gPiArTVRLX0VURE1fUkFURV85NksgPSA3LA0KPiA+ICtNVEtfRVRETV9SQVRFXzE5MksgPSA5
LA0KPiA+ICtNVEtfRVRETV9SQVRFXzExSyA9IDE2LA0KPiA+ICtNVEtfRVRETV9SQVRFXzIySyA9
IDE3LA0KPiA+ICtNVEtfRVRETV9SQVRFXzQ0SyA9IDE4LA0KPiA+ICtNVEtfRVRETV9SQVRFXzg4
SyA9IDE5LA0KPiA+ICtNVEtfRVRETV9SQVRFXzE3NksgPSAyMCwNCj4gPiArfTsNCj4gPiArDQo+
ID4gK3N0cnVjdCBtdGtfZGFpX2V0ZG1fcHJpdiB7DQo+ID4gK2Jvb2wgYmNrX2ludjsNCj4gPiAr
Ym9vbCBscmNrX2ludjsNCj4gPiArYm9vbCBzbGF2ZV9tb2RlOw0KPiA+ICt1bnNpZ25lZCBpbnQg
Zm9ybWF0Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHVuc2lnbmVkIGludCBtdDc5ODZf
ZXRkbV9yYXRlX3RyYW5zZm9ybShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gK3Vuc2lnbmVkIGlu
dCByYXRlKQ0KPiANCj4gUGxlYXNlIGVpdGhlciBmaXggaW5kZW50YXRpb24gb3IganVzdCBkbyBp
dCBpbiBvbmUgbGluZSwgODYgY29sdW1ucw0KPiBhcmUgb2suDQo+IA0KDQpPSy4NCg0KPiA+ICt7
DQo+ID4gK3N3aXRjaCAocmF0ZSkgew0KPiA+ICtjYXNlIDgwMDA6DQo+ID4gK3JldHVybiBNVEtf
RVRETV9SQVRFXzhLOw0KPiA+ICtjYXNlIDExMDI1Og0KPiA+ICtyZXR1cm4gTVRLX0VURE1fUkFU
RV8xMUs7DQo+ID4gK2Nhc2UgMTIwMDA6DQo+ID4gK3JldHVybiBNVEtfRVRETV9SQVRFXzEySzsN
Cj4gPiArY2FzZSAxNjAwMDoNCj4gPiArcmV0dXJuIE1US19FVERNX1JBVEVfMTZLOw0KPiA+ICtj
YXNlIDIyMDUwOg0KPiA+ICtyZXR1cm4gTVRLX0VURE1fUkFURV8yMks7DQo+ID4gK2Nhc2UgMjQw
MDA6DQo+ID4gK3JldHVybiBNVEtfRVRETV9SQVRFXzI0SzsNCj4gPiArY2FzZSAzMjAwMDoNCj4g
PiArcmV0dXJuIE1US19FVERNX1JBVEVfMzJLOw0KPiA+ICtjYXNlIDQ0MTAwOg0KPiA+ICtyZXR1
cm4gTVRLX0VURE1fUkFURV80NEs7DQo+ID4gK2Nhc2UgNDgwMDA6DQo+ID4gK3JldHVybiBNVEtf
RVRETV9SQVRFXzQ4SzsNCj4gPiArY2FzZSA4ODIwMDoNCj4gPiArcmV0dXJuIE1US19FVERNX1JB
VEVfODhLOw0KPiA+ICtjYXNlIDk2MDAwOg0KPiA+ICtyZXR1cm4gTVRLX0VURE1fUkFURV85Nks7
DQo+ID4gK2Nhc2UgMTc2NDAwOg0KPiA+ICtyZXR1cm4gTVRLX0VURE1fUkFURV8xNzZLOw0KPiA+
ICtjYXNlIDE5MjAwMDoNCj4gPiArcmV0dXJuIE1US19FVERNX1JBVEVfMTkySzsNCj4gPiArZGVm
YXVsdDoNCj4gPiArZGV2X3dhcm4oZGV2LCAiJXMoKSwgcmF0ZSAldSBpbnZhbGlkLCB1c2UgJWQh
ISFcbiIsDQo+IA0KPiBzL3VzZS91c2luZy9nDQo+IA0KDQpPSy4NCg0KPiA+ICsgX19mdW5jX18s
IHJhdGUsIE1US19FVERNX1JBVEVfNDhLKTsNCj4gPiArcmV0dXJuIE1US19FVERNX1JBVEVfNDhL
Ow0KPiA+ICt9DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgZ2V0X2V0ZG1fd2xlbih1
bnNpZ25lZCBpbnQgYml0d2lkdGgpDQo+ID4gK3sNCj4gPiArcmV0dXJuIGJpdHdpZHRoIDw9IDE2
ID8gMTYgOiAzMjsNCj4gPiArfQ0KPiA+ICsNCj4gPiArLyogZGFpIGNvbXBvbmVudCAqLw0KPiA+
ICsvKiBpbnRlcmNvbm5lY3Rpb24gKi8NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
c25kX2tjb250cm9sX25ldyBvMTI0X21peFtdID0gew0KPiA+ICtTT0NfREFQTV9TSU5HTEVfQVVU
T0RJU0FCTEUoIkkwMzJfU3dpdGNoIiwgQUZFX0NPTk4xMjRfMSwgMCwgMSwNCj4gMCksDQo+ID4g
K307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgbzEy
NV9taXhbXSA9IHsNCj4gPiArU09DX0RBUE1fU0lOR0xFX0FVVE9ESVNBQkxFKCJJMDMzX1N3aXRj
aCIsIEFGRV9DT05OMTI1XzEsIDEsIDEsDQo+IDApLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBzbmRfc29jX2RhcG1fd2lkZ2V0IG10a19kYWlfZXRkbV93aWRnZXRz
W10gPSB7DQo+ID4gKw0KPiA+ICsvKiBETCAqLw0KPiA+ICtTTkRfU09DX0RBUE1fTUlYRVIoIkkx
NTAiLCBTTkRfU09DX05PUE0sIDAsIDAsIE5VTEwsIDApLA0KPiA+ICtTTkRfU09DX0RBUE1fTUlY
RVIoIkkxNTEiLCBTTkRfU09DX05PUE0sIDAsIDAsIE5VTEwsIDApLA0KPiA+ICsvKiBVTCAqLw0K
PiA+ICtTTkRfU09DX0RBUE1fTUlYRVIoIk8xMjQiLCBTTkRfU09DX05PUE0sIDAsIDAsDQo+ID4g
KyAgIG8xMjRfbWl4LCBBUlJBWV9TSVpFKG8xMjRfbWl4KSksDQo+IA0KPiBGaXRzIGluIG9uZSBs
aW5lLg0KPiANCg0KT0suDQoNCj4gPiArU05EX1NPQ19EQVBNX01JWEVSKCJPMTI1IiwgU05EX1NP
Q19OT1BNLCAwLCAwLA0KPiA+ICsgICBvMTI1X21peCwgQVJSQVlfU0laRShvMTI1X21peCkpLA0K
PiANCj4gVGhpcyBvbmUgdG9vLg0KPiANCg0KT0suDQoNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3NvY19kYXBtX3JvdXRlIG10a19kYWlfZXRkbV9yb3V0ZXNb
XSA9IHsNCj4gPiAreyJJMTUwIiwgTlVMTCwgIkVURE0gQ2FwdHVyZSJ9LA0KPiA+ICt7IkkxNTEi
LCBOVUxMLCAiRVRETSBDYXB0dXJlIn0sDQo+ID4gK3siRVRETSBQbGF5YmFjayIsIE5VTEwsICJP
MTI0In0sDQo+ID4gK3siRVRETSBQbGF5YmFjayIsIE5VTEwsICJPMTI1In0sDQo+ID4gK3siTzEy
NCIsICJJMDMyX1N3aXRjaCIsICJJMDMyIn0sDQo+ID4gK3siTzEyNSIsICJJMDMzX1N3aXRjaCIs
ICJJMDMzIn0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICsvKiBkYWkgb3BzICovDQo+ID4gK3N0YXRp
YyBpbnQgbXRrX2RhaV9ldGRtX3N0YXJ0dXAoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtDQo+ICpz
dWJzdHJlYW0sDQo+ID4gK3N0cnVjdCBzbmRfc29jX2RhaSAqZGFpKQ0KPiA+ICt7DQo+ID4gK3N0
cnVjdCBtdGtfYmFzZV9hZmUgKmFmZSA9IHNuZF9zb2NfZGFpX2dldF9kcnZkYXRhKGRhaSk7DQo+
ID4gKw0KPiA+ICttdDc5ODZfYWZlX2VuYWJsZV9jbG9jayhhZmUpOw0KPiA+ICsNCj4gPiArcmVn
bWFwX3VwZGF0ZV9iaXRzKGFmZS0+cmVnbWFwLCBBVURJT19UT1BfQ09OMiwgQ0xLX09VVDVfUERO
X01BU0ssDQo+ID4gKyAgIDApOw0KPiA+ICtyZWdtYXBfdXBkYXRlX2JpdHMoYWZlLT5yZWdtYXAs
IEFVRElPX1RPUF9DT04yLCBDTEtfSU41X1BETl9NQVNLLA0KPiA+ICsgICAwKTsNCj4gDQo+IEJv
dGggZG8gZml0IGluIG9uZSBsaW5lIChhbmQgb3RoZXJzIGluIHRoaXMgZmlsZSkuDQo+IA0KDQpP
Sy4NCg0KPiBBZnRlciBmaXhpbmcgdGhhdCwNCj4gDQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3Jh
LmNvbT4NCg0KSGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KSSdsbCBmaXgg
dGhlbSBpbiB2MyBwYXRjaC4NCg0KQmVzdCByZWdhcmRzLA0KTWFzbw0KDQo=
