Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2843F719B80
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjFAMJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjFAMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:09:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A09D7;
        Thu,  1 Jun 2023 05:09:03 -0700 (PDT)
X-UUID: 1593dc1a007511eeb20a276fd37b9834-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hXFuPhnC/0NZoNTacquZjJpvo5hnEka6wcbkSEHlAXM=;
        b=hUQy6k3YbPrJIpWRhghvmfIk6n/nm8vICQ5C35pkFOs/6ssLc+Qozs3cUC+6I5ueyQd4hJYnX/wlxwfxgjA7ZzyX+J5IvNI2hNBjtUq+Pb5bvJqYokMTPb45Asqu8Oo7ZpYHa0ntgr3vpkZM5ORUV90/WbCF/drpf+0CIGXPZH4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:148c8747-034b-4895-a221-17946d90ec57,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:848d443d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 1593dc1a007511eeb20a276fd37b9834-20230601
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 892752523; Thu, 01 Jun 2023 20:08:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 20:08:55 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 20:08:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYHMWCI6M4Hkz+4J1tbcA5NVL88lFMLjIy+zwWlS3QEETk2vMrImfial5TE2s6OL58VsMsjAuyPjrnf1AEzwGbpzdFTp/fz/P/VioDi+/d/3rzHwNQ9kl4kvkqYl3qHXbortjuP5JXNhndukzqKT62axm5eG+rbV2t+2+mdFXuO4CLQ4YXlOW/HlIrRDz74Itkz5iPaPRzBo1kk2MRmB1gWh4yiItQ88xWnZmu09ii3kEc0kcu2tNGFqhugItsK+X3bcbVOauTcmfHpDTMMnHHDjU0e1yZCUgjAWGqOjeb4yRoINVKml7BrWGQC1VFtVAXYd5nREASwui3QOnm4yaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXFuPhnC/0NZoNTacquZjJpvo5hnEka6wcbkSEHlAXM=;
 b=i29gjiGiUui9W/1YUG1Wjr9gex2tl4w/jNxV0BtAxUw7xAaDGMZYu0WpccMEfoFDCHIZf6gZU6Y1oaOYKPEpmhLuCMEiamF9C15RlFvhJsRF3L9i2MjfFpZc5Y09r2eY4CikyREOurdcteSt7kv+zVIBjg2q4DeL6jJJ2InWYX8C0FzfRBwjgDQKgmBfwj5VJ1xGOKjb17Xnf2vMXdu7HzgjJrYk5PdO3+klJ36JdlGe6DdUGT9G2hCBBoi1Ew/kbyK6Dih6UurgVjw4w9Ewjjj370C6W52enxcRTpnLvJrFhh7m/ftn5QvvoxaLKYCWHE69VwTQ2A2CuTfd6gMf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXFuPhnC/0NZoNTacquZjJpvo5hnEka6wcbkSEHlAXM=;
 b=WDEL3I2zB1EJ25AC+/KnW6NROXei/QeqwBhRof3NAtcx3S/yedrfcDMvRgbEqae+4O57haFs249aFO28iEyraMywT07Rm5ETEfsbwd1jaND4jbXjQKOxEib2Ln8inXDrBe5fOXLNacfuUV3An+vUzHE4w8AK+hBLMfwIljAsNks=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by TYZPR03MB7348.apcprd03.prod.outlook.com (2603:1096:400:427::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Thu, 1 Jun
 2023 12:08:53 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%9]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 12:08:52 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH v2] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZguL8DXJ4wwqPNE+3vDjAEU6xMa9fzDYAgBRRdwCAAA2JgIABPfCAgABw3wCAACPbAA==
Date:   Thu, 1 Jun 2023 12:08:52 +0000
Message-ID: <5844a9f47e4f9e23185da856cb24085a234cd7dd.camel@mediatek.com>
References: <20230510015851.11830-1-wenbin.mei@mediatek.com>
         <0df3968e-da34-b36c-4cb4-92d66508a46a@collabora.com>
         <e682b8b66261a71601707a4e74af2829f86800dc.camel@mediatek.com>
         <7f5e14e5-a814-efd7-6082-c4eff697c536@collabora.com>
         <59568b9e6d50135787932cf8e92624914f29e27b.camel@mediatek.com>
         <c26f8cab-9509-1e8a-600f-4f61f38c8b17@collabora.com>
In-Reply-To: <c26f8cab-9509-1e8a-600f-4f61f38c8b17@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|TYZPR03MB7348:EE_
x-ms-office365-filtering-correlation-id: 6af31c32-bc8a-48f3-7bbe-08db6298f753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z7f+QHg87awXCCIPuebkLFCkM+E9m/j8Y2RRwGuoP5e/nA4Cha/UuQtmHAIstl4lgCpfmrrp7MkqyVX3GlShN/1t09VLBuZX6asfJ3d2tZQ1saZ//XAyfIrMN5DlNO7g8XvoFp21jcOn4JPXNKhSdGzi8OVXyETW4sQL3jnqeBVq2v13DoIuLT/75oZL2NDqjbaEMui02Z81Y3cSsdReUrFJ0LxkWIATq9AWrJsPLmuJZ4Ahsf5O9FqHiWvXWBO64dlP1kvS8jIcR+QPTEInaVf8sUukaFP1MFPvpWS/IR46PrGFaKLNlimGVYno5rnkieclmwRCEiigpWEhVHgwgKWpkd39MQnwBNmSr9v4bV7M/v7h0caFN5zoLQvB9KpCKPdhLBDZ1oLntj4dLyS0eBVl0hldGh0zhJdFFcAw/BMoXZ8STf+4buGeJoTI74/pslSUUBKegK7J1z6qHKN+ODs2944hNuXgiGdU5ye5z9r1sngVu3h0XQkIi8Wb7hPN4kBhb1cK2MufBJegLnjyu9CbwxB4R7PpzDa7324SAfp46GlQPxNI9tM49EZl9kmGDZnrZNPNmKeSdUL9b+eTTeAeGzpwe60ixHuHYL22Pdv6p+5S+s3ytviuP9cbLxQI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(36756003)(54906003)(478600001)(110136005)(71200400001)(5660300002)(64756008)(66556008)(8936002)(66946007)(85182001)(38070700005)(86362001)(8676002)(2906002)(316002)(66446008)(66476007)(76116006)(122000001)(4326008)(91956017)(41300700001)(38100700002)(186003)(6506007)(26005)(6512007)(107886003)(83380400001)(6486002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmxFRndBNlNLK3l0NWp5cHpJZkhUc0dxQVBUOFpqN2IzdlRtUGF6bEd2TktL?=
 =?utf-8?B?L254azkvOVltSFJmQlVXbFVLTGpqUzBVdEUzSks3YkZDYisvN2d1cUw1d0dO?=
 =?utf-8?B?bkxDR2ZwejBwck1ManNqYk5ISEpXNk1ydXlKQ001ZTFxMCtvcWFSRjhSYXFy?=
 =?utf-8?B?dTZEeTQyWnp6NHZzeVlybHR5YWRxUVJQaGlKZnVGZG5CVUJWY1ZuZmVaZ1dC?=
 =?utf-8?B?STEwM054UDlGTGV5T2hhaUZkZ2M5OUZSeEpqckxuNXFWL09vbWdUbVBsVitp?=
 =?utf-8?B?VWtXS2RXUGZ2RHQzTDhrQitUNFlMeVlCOW9uUFFadFIwSWFuQ3o1U2Z3WUM3?=
 =?utf-8?B?NDZOdlZ5RnFuSGFVb0FiS3VidXMyNHBxWjlsNE1TbjdLcFI3Y1VkWDRRNFF0?=
 =?utf-8?B?TnhpSmc5OWR5ZHZhZG1UUFo5Z1ZCeThyU25ObEpZRzk2dDQ3bFd2UUNXZHIx?=
 =?utf-8?B?Wnd0VVpEbnFMSy94OC8rWmlRTGpaRUdsNFJNV0RjdDZlYWc1emNvTUpJTnYr?=
 =?utf-8?B?emNBSVU4em5Jd3gxSUx3V2ovRlh4Y0NxSEQ4Zko4ZWhtNG96L0lldlNlWGkr?=
 =?utf-8?B?M0xONjEvaWFzVEl4ZUx1ai96YlFTT1dNNzJPbmphUmdKbE8rL1FtNzlWUExD?=
 =?utf-8?B?SysvZUdhaU56dVdzMWFUL1lGSy9HMy9iUi9RbHE2Vi8rNnBVRit5N3pFeHRz?=
 =?utf-8?B?Zmhaa2lkalBYbjJEbDdsZ1B5TU9nQnBQR3YvNVlxdWdiQzdDZzhHVThrYTd1?=
 =?utf-8?B?dDZzQ0piTmxySm1BdHYwcWY2NkxZNGp6c0NHcGpndklsMWx6L25Kc05jVW1w?=
 =?utf-8?B?Um9rTnpQZzNDNmQ2UFBHZmhRc01KZlQydUJPRUJyNkcvWTFMbzd1b3I5SDV3?=
 =?utf-8?B?blltMFZBYWx4Y3pWS3FEYXlpWVFYWlJlVElDRXphdytsNG50amxpeWl3dFhm?=
 =?utf-8?B?MUlDbHJBRTFPc0d6S1dnM1EwWlVWa2pRYi9kK2xMUmNxak90eTNTLzNiNVJp?=
 =?utf-8?B?U1RPTmlzN09KNkdTc2tDM1Y5dlZrcnEwbjUyTDhQTXhma0E2eVorZE9ZZGwx?=
 =?utf-8?B?SlQvdnNpWDBTVG96bDRQc2ZEd2lUZGE0elptK0thT1JJV3pOdTJDa1dObHlr?=
 =?utf-8?B?ZlB0aU5mWmpIeDJXdldyamJHR1BFalJ3ZGgzVUMwNS9ITmtmbk41RnJmRVJC?=
 =?utf-8?B?L0MybTdTZWtHMFpBUWRtU24zbyt5L1h1OFhTY2xnZy85SWpFWDdVYm04eHRJ?=
 =?utf-8?B?OUVZbjdxbERSbVFvL08xMnlKdUZCOEpqcUNmZ08vTEpWQ2k4aEthY2gwTVhI?=
 =?utf-8?B?VkthTWFENUdERkRjUktNTlIreWdVZk80cXhxWE5RNzBiMlRJQnFnUnVhRG9w?=
 =?utf-8?B?WXJNaWlUQytyM0pzUGp1MlFJSUxCc2x3cXY1WU0wRVk0ZjV3UDhia21NN2p5?=
 =?utf-8?B?NVpVQTJRQ2RsS0RETEJGRHdDZE01Q0x1cVUyWHlPU3E1TFd0aFNNNjI0WFJw?=
 =?utf-8?B?L3kyYzdYdHZnbXJycHJFYmZyVDBUTFNsaG10Ry82YWF2d09SL3VnSDRFMER6?=
 =?utf-8?B?UlYvQkVSNFJYTXFJa0pOMCtZelNiaWdZM1ZUMEJvbE4yNlBTMkJqMHd0U3Ny?=
 =?utf-8?B?WWlEd2luaE1RdWVWUFdUVmRPRk0yaE9DYzBtVm9uNmJCYk1Nb3ZyTFdRYThL?=
 =?utf-8?B?QzFhRERzK3NxWTROcFA3dTVtM0cvbXNiOFVROHdUVmhVWlE5ZnhiMTVKbTFl?=
 =?utf-8?B?Y1BIRnBlMFhYSUpGK09CVjlid082dlN5cGNvZkhVVDhwNlZhUmtpdlhabDFU?=
 =?utf-8?B?Q1BQbXdhUTVPSWl0ckZ1RGNHTkVJTXloc0VNSThHaFljSEdSSTR1RmVScHg4?=
 =?utf-8?B?WlQyTmdZeTNpRGcrZzJ5UVFNeUJDNFE3aDlTN1pQUnNVQmpSdkROZkh1R3VV?=
 =?utf-8?B?WUt1Sk03aFUxVDhFRThQZGFiaGJwS2tjdVQzQkRIR3cwam4zMEtITTM4cEZt?=
 =?utf-8?B?OUV6V0k1TkNOLzFITCtzZnJrZUc1bWRaV2NabjFaMzdQcWRzTjRRR1dHVldG?=
 =?utf-8?B?S2RUVXJEOWFGTW9VMG9CSEdRcGZqYzM2UHdtdjF4TndCMCtERmtQY21SNDV0?=
 =?utf-8?B?SDIrYXl4M1RtSkRmcXZsS1U0d2prOG5kSUdHYlVaWDl3NExPQ01ySDRCRkt5?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74255BB0E328484B9F732C89547EF7B5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af31c32-bc8a-48f3-7bbe-08db6298f753
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 12:08:52.7048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: waJt8lnk0ixWW4ge1SmUBnZJF8rMIs0iK6kB/VllhAl0uXi8AABMyDOiXGJw/uQlE9sCARxhKdS1IXzdyPtyyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7348
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTAxIGF0IDEyOjAwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAwMS8wNi8yMyAwNToxNiwgV2VuYmluIE1l
aSAo5qKF5paH5b2sKSBoYSBzY3JpdHRvOg0KPiA+IE9uIFdlZCwgMjAyMy0wNS0zMSBhdCAxMDox
OCArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gd3JvdGU6DQo+ID4gRXh0ZXJu
YWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMN
Cj4gdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4g
PiANCj4gPiBJbCAzMS8wNS8yMyAwOTozMiwgV2VuYmluIE1laSAo5qKF5paH5b2sKSBoYSBzY3Jp
dHRvOg0KPiA+IA0KPiA+PiBPbiBUaHUsIDIwMjMtMDUtMTggYXQgMTE6MTMgKzAyMDAsIEFuZ2Vs
b0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+IHdyb3RlOg0KPiA+IA0KPiA+Pj4gRXh0ZXJuYWwgZW1h
aWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gdW50
aWwNCj4gPiANCj4gPj4+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+ID4gDQo+ID4+Pg0KPiA+IA0KPiA+Pj4NCj4gPiANCj4gPj4+IElsIDEwLzA1LzIzIDAz
OjU4LCBXZW5iaW4gTWVpIGhhIHNjcml0dG86DQo+ID4gDQo+ID4+Pj4gQ1FIQ0lfU1NDMSBpbmRp
Y2F0ZXMgdG8gQ1FFIHRoZSBwb2xsaW5nIHBlcmlvZCB0byB1c2Ugd2hlbiB1c2luZw0KPiA+IA0K
PiA+Pj4+IHBlcmlvZGljDQo+ID4gDQo+ID4+Pj4gU0VORF9RVUVVRV9TVEFUVVMoQ01EMTMpIHBv
bGxpbmcuDQo+ID4gDQo+ID4+Pj4gVGhlIGRlZmF1bHQgdmFsdWUgMHgxMDAwIHRoYXQgY29ycmVz
cG9uZHMgdG8gMTUwdXMsIGxldCdzDQo+IGRlY3JlYXNlDQo+ID4gDQo+ID4+Pj4gaXQgdG8NCj4g
PiANCj4gPj4+DQo+ID4gDQo+ID4+PiBUaGUgZGVmYXVsdCB2YWx1ZSAweDEwMDAgKDQwOTYpIGNv
cnJlc3BvbmRzIHRvIDQwOTYgKiA1Mi4wOHVTID0NCj4gPiANCj4gPj4+IDIzMS4zM3VTDQo+ID4g
DQo+ID4+PiAuLi5zbyB0aGUgZGVmYXVsdCBpcyBub3QgMTUwdVMuDQo+ID4gDQo+ID4+Pg0KPiA+
IA0KPiA+Pj4gSWYgSSdtIHdyb25nLCB0aGlzIG1lYW5zIHRoYXQgdGhlIENRQ0FQIGZpZWxkIGlz
IG5vdCAwLCB3aGljaA0KPiB3b3VsZA0KPiA+IA0KPiA+Pj4gbWVhbg0KPiA+IA0KPiA+Pj4gdGhh
dCB0aGUgZXhwZWN0ZWQgM3VTIHdvdWxkIGJlIHdyb25nLg0KPiA+IA0KPiA+Pj4NCj4gPiANCj4g
Pj4+IEFsc28sIHNpbmNlIHRoZSBjYWxjdWxhdGlvbiBjYW4gYmUgZG9uZSBkeW5hbWljYWxseSwg
dGhpcyBpcyB3aGF0DQo+IHdlDQo+ID4gDQo+ID4+PiBzaG91bGQNCj4gPiANCj4gPj4+IGFjdHVh
bGx5IGRvIGluIHRoZSBkcml2ZXIsIGFzIHRoaXMgZ2l2ZXMgaW5mb3JtYXRpb24gdG8gdGhlIG5l
eHQNCj4gPiANCj4gPj4+IGVuZ2luZWVyDQo+ID4gDQo+ID4+PiBjaGVja2luZyB0aGlzIHBpZWNl
IG9mIGNvZGUuDQo+ID4gDQo+ID4+Pg0KPiA+IA0KPiA+Pj4gQXBhcnQgZnJvbSB0aGlzLCBieSBq
dXN0IHdyaXRpbmcgMHg0MCB0byB0aGUgQ1FIQ0lfU1NDMSByZWdpc3RlciwNCj4geW91DQo+ID4g
DQo+ID4+PiBhcmUNCj4gPiANCj4gPj4+IGFzc3VtaW5nIHRoYXQgdGhlIENRQ0FQIHZhbHVlIHJl
cXVpcmVtZW50IGlzIGZ1bGxmaWxsZWQsIGJ1dCB5b3UNCj4gPiANCj4gPj4+IGNhbm5vdA0KPiA+
IA0KPiA+Pj4gYXNzdW1lIHRoYXQgdGhlIGJvb3Rsb2FkZXIgaGFzIHNldCB0aGUgQ1FDQVAncyBJ
VENGVkFMIGFuZA0KPiBJVENGTVVMDQo+ID4gDQo+ID4+PiBmaWVsZHMNCj4gPiANCj4gPj4+IGFz
IHlvdSBleHBlY3Qgb24gYWxsIHBsYXRmb3JtczogdGhpcyBtZWFucyB0aGF0IGltcGxlbWVudGlu
ZyB0aGlzDQo+ID4gDQo+ID4+PiB0YWtlcw0KPiA+IA0KPiA+Pj4gYSBsaXR0bGUgbW9yZSBlZmZv
cnQuDQo+ID4gDQo+ID4+Pg0KPiA+IA0KPiA+Pj4gWW91IGhhdmUgdHdvIHdheXMgdG8gaW1wbGVt
ZW50IHRoaXM6DQo+ID4gDQo+ID4+PiAgICAgKioqIEZpcnN0ICoqKg0KPiA+IA0KPiA+Pj4gICAg
IDEuIFJlYWQgSVRDRk1VTCBhbmQgSVRDRlZBTCwgdGhlbjoNCj4gPiANCj4gPj4+ICAgICAgICB0
Y2xrX211bCA9IGl0Y2ZtdWxfdG9fbWh6KElUQ0ZNVUwpOyAvKiBwc2V1ZG8gZnVuY3Rpb24NCj4g
PiANCj4gPj4+IGludGVycHJldHMgcmVnIHZhbHVlKi8NCj4gPiANCj4gPj4+ICAgICAgICB0Y2xr
ID0gSVRDRlZBTCAqIHRjbGtfbXVsOw0KPiA+IA0KPiA+Pj4NCj4gPiANCj4gPj4+ICAgICAyLiBT
ZXQgU1NDMSBzbyB0aGF0IHdlIGdldCAzblM6DQo+ID4gDQo+ID4+PiAgICAgICAgI2RlZmluZSBD
UUhDSV9TU0MxX0NJVCBHRU5NQVNLKDE1LCAwKQ0KPiA+IA0KPiA+Pj4gICAgICAgIHBvbGxfdGlt
ZSA9IGNpdF90aW1lX25zX3RvX3JlZ3ZhbCgzKTsNCj4gPiANCj4gPj4+ICAgICAgICBzc2NpdCA9
IEZJRUxEX1BSRVAoQ1FIQ0lfU1NDMV9DSVQsIHBvbGxfdGltZSkNCj4gPiANCj4gPj4+ICAgICAg
ICBjcWhjaV93cml0ZWwoIC4uLiApDQo+ID4gDQo+ID4+Pg0KPiA+IA0KPiA+Pj4gICAgICoqKiBT
ZWNvbmQgKioNCj4gPiANCj4gPj4+DQo+ID4gDQo+ID4+PiAgICAgMS4gUHJlLXNldCBJVENGTVVM
IGFuZCBJVENGVkFMIHRvDQo+ID4gDQo+ID4+PiAgICAgICAgSVRDRlZBTCA9IDE5MiAoZGVjaW1h
bCkNCj4gPiANCj4gPj4+ICAgICAgICBJVENGTVVMID0gMiAod2hlcmUgMiA9PSAwLjFNSHopDQo+
ID4gDQo+ID4+Pg0KPiA+IA0KPiA+Pj4gICAgIDIuIFNldCBTU0MxIHNvIHRoYXQgd2UgZ2V0IDNu
UzoNCj4gPiANCj4gPj4+ICAgICAgICAjZGVmaW5lIENRSENJX1NTQzFfQ0lUIEdFTk1BU0soMTUs
IDApDQo+ID4gDQo+ID4+PiAgICAgICAgcG9sbF90aW1lID0gY2l0X3RpbWVfbnNfdG9fcmVndmFs
KDMpOw0KPiA+IA0KPiA+Pj4gICAgICAgIHNzY2l0ID0gRklFTERfUFJFUChDUUhDSV9TU0MxX0NJ
VCwgcG9sbF90aW1lKQ0KPiA+IA0KPiA+Pj4gICAgICAgIGNxaGNpX3dyaXRlbCggLi4uICkNCj4g
PiANCj4gPj4+DQo+ID4gDQo+ID4+PiBJIHdvdWxkIGltcGxlbWVudCB0aGUgZmlyc3Qgd2F5LCBh
cyBpdCBwYXZlcyB0aGUgd2F5IHRvIGV4dGVuZA0KPiB0aGlzDQo+ID4gDQo+ID4+PiB0byBkaWZm
ZXJlbnQNCj4gPiANCj4gPj4+IHRjbGsgdmFsdWVzIGlmIG5lZWRlZCBpbiB0aGUgZnV0dXJlLg0K
PiA+IA0KPiA+Pj4NCj4gPiANCj4gPj4+IFJlZ2FyZHMsDQo+ID4gDQo+ID4+PiBBbmdlbG8NCj4g
PiANCj4gPj4gSGkgQW5nZWxvLA0KPiA+IA0KPiA+Pg0KPiA+IA0KPiA+PiBTb3JyeSBmb3IgbGF0
ZWx5IHJlcGx5Lg0KPiA+IA0KPiA+Pg0KPiA+IA0KPiA+PiBGb3IgTWVkaWF0ZWsgbW1jIGhvc3Qg
SVAsIElUQ0ZNVUwgaXMgMHgyKDB4MU1IeiksIElUVkZWQUwgcmVwb3J0cw0KPiAxODIsDQo+ID4g
DQo+ID4+IGFuZCB0aGVzZSBmaWVsZHMgYXJlIHRoZSBzYW1lIGFuZCBhcmUgcmVhZG9ubHkgZm9y
IGFsbCBJQywgYnV0DQo+IHNpbmNlDQo+ID4gDQo+ID4+IE1lZGlhdGVrIENRRSB1c2VzIG1zZGNf
aGNsaygyNzNNSHopLCBDTUQxMydpbnRlcnZhbCBjYWxjdWxhdGlvbg0KPiBkcml2ZXINCj4gPiAN
Cj4gPj4gc2hvdWxkIHVzZSAyNzNNSHogdG8gZ2V0IHRoZSBhY3R1YWwgdGltZSwgc28gdGhlIGFj
dHVhbCBjbG9jayBpcw0KPiA+IA0KPiA+PiAyNy4zTUh6Lg0KPiA+IA0KPiA+Pg0KPiA+IA0KPiA+
IA0KPiA+IFlvdSdyZSByaWdodCwgSSd2ZSBtaXNyZWFkIHRoZSBkYXRhc2hlZXQsIGp1c3QgcmVj
aGVja2VkIGFuZCBpdA0KPiByZXBvcnRzIFJPLg0KPiA+IA0KPiA+IA0KPiA+PiBJZiBDSVQgaXMg
MHgxMDAwIGJ5IGRlZmF1bHQsIENNRCBpZGxlIHRpbWU6IDB4MTAwMCAqIDEgLyAyNy4zTUh6ID0N
Cj4gPiANCj4gPj4gYXJvdW5kIDE1MHVzLg0KPiA+IA0KPiA+Pg0KPiA+IA0KPiA+PiBJbiBhZGRp
dGlvbiB0aGUgYm9vdGxvYWRlciB3aWxsIG5vdCBzZXQgdGhlIENRQ0FQJ3MgSVRDRlZBTCBhbmQN
Cj4gSVRDRk1VTA0KPiA+IA0KPiA+PiBmaWVsZHMsIGJlY2F1c2UgdGhlc2UgZmllbGRzIG9mIENR
Q0FQIHJlZ2lzdGVyIGlzIFJPKHJlYWRvbmx5KSwgc28NCj4gd2UNCj4gPiANCj4gPj4gY2FuIGln
bm9yZSB0aGUgY2hhbmdlIGZvciB0aGUgQ1FDQVAncyBJVENGVkFMIGFuZCBJVENGTVVMIGZpZWxk
cy4NCj4gPiANCj4gPj4NCj4gPiANCj4gPiANCj4gPiBZZXMsIHRoYXQncyByaWdodCwgYWdhaW4g
LSB0aGlzIG1lYW5zIHRoYXQgeW91IHNob3VsZCBnbyBmb3IgdGhlDQo+IGZpcnN0DQo+ID4gDQo+
ID4gcHJvcG9zZWQgaW1wbGVtZW50YXRpb24sIGFzIGZ1dHVyZSBNZWRpYVRlayBTb0NzIG1heSAo
b3IgbWF5IG5vdCkNCj4gY2hhbmdlDQo+ID4gDQo+ID4gdGhhdDogaWYgeW91IGltcGxlbWVudCBh
cyBwcm9wb3NlZCwgdGhpcyBpcyBnb2luZyB0byBiZSBhIG9uZS10aW1lDQo+IHRoaW5nDQo+ID4g
DQo+ID4gYW5kIGZ1dHVyZSBTb0NzIHdvbid0IG5lZWQgc3BlY2lmaWMgY2hhbmdlcy4NCj4gPiAN
Cj4gPiANCj4gPiBUaGF0IGltcGxlbWVudGF0aW9uIGFsc28gZG9jdW1lbnRzIHRoZSBmbG93IGFi
b3V0IGhvdyB3ZSdyZSBnZXR0aW5nDQo+IHRvDQo+ID4gDQo+ID4gdGhlIGFjdHVhbCB2YWx1ZSwg
d2hpY2ggaXMgaW1wb3J0YW50IGZvciBjb21tdW5pdHkgcGVvcGxlIHJlYWRpbmcNCj4gdGhpcw0K
PiA+IA0KPiA+IGRyaXZlciBpbiB0aGUgZnV0dXJlIGZvciBkZWJ1Z2dpbmcgcHVycG9zZXMuDQo+
ID4gDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiANCj4gPiBBbmdlbG8NCj4gPiANCj4gPiANCj4g
PiANCj4gPiBUaGFua3MgZm9yIHlvdXIgcHJvcG9zYWwuDQo+ID4gDQo+ID4gDQo+ID4gSSBoYXZl
IGRpc2N1c3NlZCB3aXRoIG91ciBkZXNpZ25lciwgYW5kIHRoaXMgZmllbGRzIG9mIENRQ0FQJ3MN
Cj4gSVRDRlZBTCBhbmQgSVRDRk1VTCB3aWxsIG5vdCBjaGFuZ2UuDQo+ID4gSWYgd2UgYWRkIG1v
cmUgY29kZSBmb3IgaXQsIHRoZXNlIGNvZGVzIHdpbGwgYWxzbyBhZmZlY3QgdGhlDQo+IGV4ZWN1
dGlvbiBlZmZpY2llbmN5LCBldmVuIGlmIGl0IGhhcyBhIHZlcnkNCj4gPiBzbWFsbCBlZmZlY3Qu
DQo+ID4gSSB0aGluayBpZiBpdCdzIGp1c3QgZm9yIHJlYWRpbmcgY29udmVuaWVuY2UsIHdlIGNh
biBhZGQgbW9kZQ0KPiBjb21tZW50cyB0byBtYWtlIGl0IGVhc2llciB0byByZWFkIHRoZSBjb2Rl
Lg0KPiA+IERvIHlvdSB0aGluayBpdCdzIG9rYXkgdG8gYWRkIG1vcmUgY29tbWVudHM/DQo+ID4g
DQo+IA0KPiBUaGlzIGlzbid0IGEgcGVyZm9ybWFuY2UgcGF0aCwgYnV0IGFueXdheSwgaWYgeW91
IHRoaW5rIHRoYXQgaXQgd2lsbA0KPiBiZSBhdCBzb21lDQo+IHBvaW50LCB5b3UgY2FuIHJlYWQg
dGhlIHR3byByZWdpc3RlcnMgYXQgcHJvYmUgdGltZSBhcyBwYXJ0IG9mIHRoZQ0KPiBNTUNfQ0FQ
Ml9DUUUNCj4gaWYgYnJhbmNoLCBhbmQgdGhlbiBjYWNoZSB0aGUgaW52YXJpYWJsZSB2YWx1ZXMg
dG8gYHN0cnVjdA0KPiBtc2RjX2hvc3RgOiB0aGlzDQo+IHdpbGwgbWFrZSB5b3UgYWJsZSB0byBu
ZXZlciBwZXJmb3JtIHJlZ2lzdGVyIHJlYWRzIGZvciBJVENGVkFML0ZNVUwNCj4gaW4NCj4gbXNk
Y19jcWVfZW5hYmxlKCksIHJlc29sdmluZyB0aGUgZWZmaWNpZW5jeSBpc3N1ZS4NCj4gDQo+IEV2
ZW4gYmV0dGVyLCBpbnN0ZWFkIG9mIGNhY2hpbmcgSVRDRlZBTC9GTVVMIHRvIHR3byB2YXJpYWJs
ZXMsIHNpbmNlDQo+IHRoZSBpZGxlDQo+IHRpbWVyIHZhbHVlIGxpa2VseSB3b24ndCBldmVyIGNo
YW5nZSBkdXJpbmcgcnVudGltZSwgeW91IGNhbiBkaXJlY3RseQ0KPiBwZXJmb3JtDQo+IHRoZSBj
YWxjdWxhdGlvbiBmb3IgU1NDMSBhdCBwcm9iZSB0aW1lIGFuZCBjYWNoZSB0aGF0IHZhbHVlIGlu
c3RlYWQsDQo+IHNvIHRoYXQNCj4gaW4gbXNkY19jcWVfZW5hYmxlKCkgeW91IHdpbGwgaGF2ZSBz
b21ldGhpbmcgbGlrZS4uLg0KPiANCj4gLyogU2V0IHRoZSBzZW5kIHN0YXR1cyBjb21tYW5kIGlk
bGUgdGltZXIgKi8NCj4gY3FoY2lfd3JpdGVsKGNxX2hvc3QsIGhvc3QtPmNxX3NzYzFfdGltZSwg
Q1FIQ0lfU1NDMSk7DQo+IA0KPiB3aGVyZSBjcV9zc2MxX3RpbWUgaXMNCj4gc3RydWN0IG1zZGNf
aG9zdCB7DQo+IC4uLi4uLi4NCj4gdTMyIGNxX3NzYzFfdGltZTsNCj4gLi4uLg0KPiB9DQo+IA0K
PiBhbmQgd2hlcmUgeW91ciBwcm9iZSBmdW5jdGlvbiBpcw0KPiANCj4gc3RhdGljIGludCBtc2Rj
X2Rydl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiB7DQo+IC4uLi4uLg0K
PiANCj4gaWYgKG1tYy0+Y2FwczIgJiBNTUNfQ0FQMl9DUUUpIHsNCj4gaG9zdC0+Y3FfaG9zdCA9
IC4uLi4uLg0KPiAuLi4uLi4uLg0KPiByZWFkIGl0Y2Z2YWw7DQo+IHJlYWQgaXRjZm11bDsNCj4g
aG9zdC0+Y3Ffc3NjMV90aW1lID0gY2FsY3VsYXRlZC12YWx1ZTsNCj4gLi4uLi4uLi4NCj4gfQ0K
PiANCj4gLi4uLi4uLg0KPiB9DQo+IA0KWWVzLCBJIHRoaW5rIGl0J3Mgb2theSBmb3IgbWUuDQpB
bm90aGVyIHByb2JsZW0sIElUQ0ZWQUwgcmVwb3J0cyAxODIgZm9yIE1lZGlhVGVrIFNvQ3MsIGJ1
dCB3ZSBjYW4gbm90DQp1c2UgaXQgdG8gY2FsY3VsYXRlLCBhcyBpIHNhaWQgZWFybGllciwgc2lu
Y2Ugb3VyIENRRSB1c2VzDQptc2RjX2hjbGsoMjczTUh6KSwgQ01EMTMnIGludGVydmFsIGNhbGN1
bGF0aW9uIGRyaXZlcnMgc2hvdWxkIHVzZQ0KMjczTUh6IHRvIGdldCB0aGUgYWN0dWFsIHRpbWUs
IG5vdCAxODJNSHouDQpJZiB3ZSB1c2UgSVRDRlZBTCwgd2Ugd2lsbCBnZXQgYSB3cm9uZyB2YWx1
ZS4NClNvIEkgdGhpbmsgaXQncyBtZWFuaW5nbGVzcy4NCg0KQmVnYXJkcywNCldlbmJpbg0KPiBS
ZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+IA0KPiA+IEJlZ2FyZHMsDQo+ID4gV2VuYmluDQo+ID4g
DQo+ID4+IFRoYW5rcw0KPiA+IA0KPiA+PiBXZW5iaW4NCj4gPiANCj4gPj4+DQo+ID4gDQo+ID4+
Pj4gMHg0MCB0aGF0IGNvcnJlc3BvbmRzIHRvIDN1cywgd2hpY2ggY2FuIGltcHJvdmUgdGhlIHBl
cmZvcm1hbmNlDQo+IG9mDQo+ID4gDQo+ID4+Pj4gc29tZQ0KPiA+IA0KPiA+Pj4+IGVNTUMgZGV2
aWNlcy4NCj4gPiANCj4gPj4+Pg0KPiA+IA0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IFdlbmJpbiBN
ZWkgPHdlbmJpbi5tZWlAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+Pj4+IC0tLQ0KPiA+IA0KPiA+
Pj4+ICAgICBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgNCArKysrDQo+ID4gDQo+ID4+Pj4g
ICAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiANCj4gPj4+Pg0KPiA+IA0K
PiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJpdmVycy9t
bWMvaG9zdC9tdGstDQo+IHNkLmMNCj4gPiANCj4gPj4+PiBpbmRleCBlZGFkZTBlNTRhMGMuLmZm
ZWNjZGRjZDAyOCAxMDA2NDQNCj4gPiANCj4gPj4+PiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L210
ay1zZC5jDQo+ID4gDQo+ID4+Pj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+
IA0KPiA+Pj4+IEBAIC0yNDUzLDYgKzI0NTMsNyBAQCBzdGF0aWMgdm9pZA0KPiBtc2RjX2hzNDAw
X2VuaGFuY2VkX3N0cm9iZShzdHJ1Y3QNCj4gPiANCj4gPj4+PiBtbWNfaG9zdCAqbW1jLA0KPiA+
IA0KPiA+Pj4+ICAgICBzdGF0aWMgdm9pZCBtc2RjX2NxZV9lbmFibGUoc3RydWN0IG1tY19ob3N0
ICptbWMpDQo+ID4gDQo+ID4+Pj4gICAgIHsNCj4gPiANCj4gPj4+PiAgICAgICAgIHN0cnVjdCBt
c2RjX2hvc3QgKmhvc3QgPSBtbWNfcHJpdihtbWMpOw0KPiA+IA0KPiA+Pj4+ICsgICAgIHN0cnVj
dCBjcWhjaV9ob3N0ICpjcV9ob3N0ID0gbW1jLT5jcWVfcHJpdmF0ZTsNCj4gPiANCj4gPj4+Pg0K
PiA+IA0KPiA+Pj4+ICAgICAgICAgLyogZW5hYmxlIGNtZHEgaXJxICovDQo+ID4gDQo+ID4+Pj4g
ICAgICAgICB3cml0ZWwoTVNEQ19JTlRfQ01EUSwgaG9zdC0+YmFzZSArIE1TRENfSU5URU4pOw0K
PiA+IA0KPiA+Pj4+IEBAIC0yNDYyLDYgKzI0NjMsOSBAQCBzdGF0aWMgdm9pZCBtc2RjX2NxZV9l
bmFibGUoc3RydWN0DQo+IG1tY19ob3N0DQo+ID4gDQo+ID4+Pj4gKm1tYykNCj4gPiANCj4gPj4+
PiAgICAgICAgIG1zZGNfc2V0X2J1c3lfdGltZW91dChob3N0LCAyMCAqIDEwMDAwMDAwMDBVTEws
IDApOw0KPiA+IA0KPiA+Pj4+ICAgICAgICAgLyogZGVmYXVsdCByZWFkIGRhdGEgdGltZW91dCAx
cyAqLw0KPiA+IA0KPiA+Pj4+ICAgICAgICAgbXNkY19zZXRfdGltZW91dChob3N0LCAxMDAwMDAw
MDAwVUxMLCAwKTsNCj4gPiANCj4gPj4+PiArDQo+ID4gDQo+ID4+Pj4gKyAgICAgLyogZGVjcmVh
c2UgdGhlIHNlbmQgc3RhdHVzIGNvbW1hbmQgaWRsZSB0aW1lciB0byAzdXMgKi8NCj4gPiANCj4g
Pj4+PiArICAgICBjcWhjaV93cml0ZWwoY3FfaG9zdCwgMHg0MCwgQ1FIQ0lfU1NDMSk7DQo+ID4g
DQo+ID4+Pj4gICAgIH0NCj4gPiANCj4gPj4+Pg0KPiA+IA0KPiA+Pj4+ICAgICBzdGF0aWMgdm9p
ZCBtc2RjX2NxZV9kaXNhYmxlKHN0cnVjdCBtbWNfaG9zdCAqbW1jLCBib29sDQo+IHJlY292ZXJ5
KQ0KPiA+IA0KPiA+Pj4NCj4gPiANCj4gPj4+DQo+ID4gDQo+ID4gDQo+ID4gDQo+IA0K
