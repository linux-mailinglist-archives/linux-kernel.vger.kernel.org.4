Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947BE6C7B03
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjCXJT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCXJTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:19:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897A349F7;
        Fri, 24 Mar 2023 02:19:19 -0700 (PDT)
X-UUID: f0c44aeaca2411eda9a90f0bb45854f4-20230324
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=U/OE3egTWl9ZYubRdjWpDXblfX/im2Skx2E+ULf/9wA=;
        b=ZsbnH+z3XmTw3QCZDI0r0VPHP/3uFNdiIXEaAAgdgNLDTfeAyVdMZBe25tztH2cjcNoZ3lPHpcqp8QWrZY9bkO+B1aMSwBET6r7KoiGa6ItW0dKB7EJu0z4TygGUkv9nneAybpn1OwtfSVur39MsWE9utXwpt+QhWdQ2ENIDdyM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:34d14738-cbb6-472a-848f-d2320c6f44e9,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:120426c,CLOUDID:940d6129-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: f0c44aeaca2411eda9a90f0bb45854f4-20230324
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 644992583; Fri, 24 Mar 2023 17:19:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 24 Mar 2023 17:19:11 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 24 Mar 2023 17:19:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIA1zS2anuN4M7PDCEdTET/wXTrI2n4i9YcjlE7oTS0J2eG8dXfmh7nsveyneHaTo9B6pTT92//nXbDzH0biUXhcq3Vv+Ol03/87nmxabQ7LKjxXfMzvLx1ba01dYQ/PJOO5r4DFvGcJ+fQvMXUapEIx1T94SIm2p5zP82vAp0sul0W1J9heD+ff3RBSKpkE4LTpthvnZelb7z89B2lrqIOnaYsVRvQVOHfgEJXt+D7L+OrsCkWwvX+ACKZsMsRRRsFNGcwFiXzZkWHPL2KHlFP9frcmTsO4hKXuCTw0OoH3tNfy/YvGeuRON6TMgA0qJrCd2R0WyJmZOYKtz44sIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/OE3egTWl9ZYubRdjWpDXblfX/im2Skx2E+ULf/9wA=;
 b=Ll/RS70a1V+5G6BcZh6p+cb1UZ/E3sjEqHmOKgZQwEC5rsDWx3JIV8ft4ENVRdibMgyDnk1RBfWwDb8hoG3X2lSLl1OnKKUcs6ZNJ8e/xUbVh10CKQZkEBGLInMV01Tfj9+0UGr5yOfoco+ylfX9esK5iJVL8W9YbiyICSllm5w8n+lWyFLPL9gdSixOJyogxkHLGppgbWlOKb9HLzc5NIoXiR9WF/gLR16z22s2TOQAkkwsKHl8T2VhdQrRrq3KtjNbctzeMYMjrnO0Egm3TyJThB2/nF86OrioxlYBr19V4U7kKTQCdB4UapBvO7KwSfjuMh2395j0BP7Ijkm6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/OE3egTWl9ZYubRdjWpDXblfX/im2Skx2E+ULf/9wA=;
 b=TLP3Vv2CFY5dWrY+7z4JRzRpI5MO50+JIAGHmEqhP9FMHv7L3lZAYoAU1pjRkEOkaNp1Mdx4tiQ9NS5GaFwvKGKL0kwTAvf3RUKn/HXN5Cx/b1o+Qwa/cjJw7v2sJJst+K9y3xHkEdbIrk0DYBU0K/ovVgVINz0tRqv39lz1tcI=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 KL1PR0302MB5346.apcprd03.prod.outlook.com (2603:1096:820:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 09:19:08 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1%5]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 09:19:08 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "yong.wu@mediatek.org" <yong.wu@mediatek.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        =?utf-8?B?Smlhbmh1YSBMaW4gKOael+W7uuWNjik=?= 
        <jianhua.lin@mediatek.com>
Subject: Re: [PATCH 1/2] media: mediatek: vcodec: Remove decoder 'dma-ranges'
 conditon when set dma mask
Thread-Topic: [PATCH 1/2] media: mediatek: vcodec: Remove decoder 'dma-ranges'
 conditon when set dma mask
Thread-Index: AQHZXWMIYwua/6t4P0Wnz7B9mSuUJa8IDi8AgAAGYICAAZQJgA==
Date:   Fri, 24 Mar 2023 09:19:08 +0000
Message-ID: <5ee29f9f6c15c104c7c786f5dfd3bc3639041b4a.camel@mediatek.com>
References: <20230323083810.21912-1-yunfei.dong@mediatek.com>
         <5202922d-9cc3-8aac-4193-ee463b255846@collabora.com>
         <7e25543e8aff9f15e0baddb2b88c3fcb1d8d3b1a.camel@mediatek.com>
In-Reply-To: <7e25543e8aff9f15e0baddb2b88c3fcb1d8d3b1a.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|KL1PR0302MB5346:EE_
x-ms-office365-filtering-correlation-id: 1d55d30b-c2d0-4e48-3a86-08db2c48d28b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m4iEvkkLnqoir2BZg8dEID98ndgjDE86PM7fe8I3XFPPr2zRC+0CF4oIvKGyiesE4VdBYcU770xGxafA0+A//mMfNiqhGeQDqqFgykklqXYJKUe4cevnuCu2SvB5lVV7Ez36vDPLUXbAvUuCfotV8G+PCaZx26unoSeksUHaOSildoS15MOwb73y8OENfedxxVWo8DXyxBiH8gbOGrOkEh3ak8t+VpStBMmS2oEbGKYsrTaJh8Ic6xIlyhwVjTpkfYqacyEYKxJFUcawxgjwPcDl6/BE1kMAxKYrJ2yO1isBVeqvRtp34Ox9ZWH42d2w1nfkke/iIE4O9CgrExgmU6EUEnzQBXDqiAUqlLfcsRQsr+ugnT11Clx/XOZnSzsmATjpNurjxyfnoAJ8LRuEddLdSoHN6V0RuKGM0Z7Vfdj9GAnaD2bqyLaJI9VgiEfBPbompCGHrwAH1Jkp85VIOW25TrLTZccD/JigiMq7c7Of9tDpk8yOMJGI/PhsCih9jiTfBW4SwxbCxo3uVjjWZBYejhOKifkWdZqymsOcjQ/2EaUn17QuSMsX/CsMe/SRtlcy8dX7E98Q6EecKbCOC5Z3dImGNtT0LJ/Ex7vURRO+fBKQbji3kioZmopJPTGEcev5o35BRA4vGiN4OGvxZDKfcVfmYIhZmLoTzZn7mC9RLHxOP3ep9LNGsCs1zyM3JoHnMqCCiu5VQ8vPs5DO3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199018)(8936002)(76116006)(66446008)(66946007)(66476007)(66556008)(64756008)(41300700001)(4326008)(8676002)(86362001)(85182001)(36756003)(38100700002)(38070700005)(6506007)(6512007)(26005)(122000001)(83380400001)(186003)(2616005)(107886003)(316002)(6486002)(966005)(71200400001)(54906003)(110136005)(6636002)(478600001)(2906002)(7416002)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHM4WjFpNUhQL2w5UWZEVjN1NjU5ZnViY3U0eHE4ZlZhVWl4bTVLVFVBeW1r?=
 =?utf-8?B?REFkYWpiTFpsbCsvRVo0STVMSDJZYlNMTjhFcERScE45TUxaNVhXZXNxdkRL?=
 =?utf-8?B?N2ZqVDd4cnRmTy9DWDBGVzRxc21WUTI0UytsWHU5NWlSUGZxOGdFa2xCdXRl?=
 =?utf-8?B?cjA0VVUxUytVZ2Ntb0tDV0NjV08xN1NCZGZxTG9idTZnZDFZbmNSS2tKNFV1?=
 =?utf-8?B?QjMzaklFeHh2SklHdmY1OXk2dUlJWnZGT1V0VzdzMjRWTU5Da3FBV1poRUJz?=
 =?utf-8?B?TUlTUFFnT3hEVWlEcGxETHc0ZTFQTWlCRnkrV3RGQTJlajdQcnB4WmR6VDFG?=
 =?utf-8?B?UHFMclhhZUpLankxOVIxaEtZNEhmYWRrWDAyZzM4KzArWHZveVh4bkdWUVdz?=
 =?utf-8?B?TmFxY00xMHZseGlmRUh4VTJVWkdnTVJCcld2RUlueDRBQkFQdXNMN25jU09W?=
 =?utf-8?B?SnpTdWZTN25Yb0xtNkVqYVd3QlE3UGFsRmpYV1RKWmZNMjBxekZhL3ZNNEl3?=
 =?utf-8?B?MXJ0OEVRQW1QaklrdzNFRFFGTDNMR0FOeFErVXU4YjVNUm0vMHRjNUdTbnl0?=
 =?utf-8?B?cUNvMGVoUnM2Y2MxZktLclc4bXdyVDVZWEc0YUhZQU4rZVNsWVZhdzZLYmxF?=
 =?utf-8?B?QXJ3a2Nab0dUMU83T3oxdDlCOXM1Tmovby84SVRTRTFnRm5VZENzd3E5YkZq?=
 =?utf-8?B?L3I3NU92Y1cvcm5QU00zUzZCRGJyaElWZ3BycFZaRElORFNDVWQwMEluS01h?=
 =?utf-8?B?OFdLYUN5cW4wczN1Q291V1JSeDJPSlp4a2sxUEZYZXpRVGRjWWxjODl4VHBE?=
 =?utf-8?B?Wm55cWJQd21RbDVsZ09NWUZ0QjNKc1ZyRFY2WHRYczQrUmd1WjFFY0xSRjFj?=
 =?utf-8?B?NWkrdlE3RWlxK3ZJa2htVGRvbzdTeXRnVzRsK25HSVpQVjFXWSt3UzRBNHRV?=
 =?utf-8?B?OUVucjNzZFEwQkszM3BpTXk5T1B4dzBsZy9Ub0JhVUx6d0kwSVJ3b2dmdTdB?=
 =?utf-8?B?WlJBU0d3amNrWVhCRlRheExTanFkTkp0RXdzazFQOHRqT1RoMDJKdzMwaEUz?=
 =?utf-8?B?SUlhTnRHWTBnejZpWE5wTUUybUd5TFJTQ05ucHYrb1ZFbWR4Wmc2MUc4L21z?=
 =?utf-8?B?cFF4S0piVzBhUkx5K3dNWE9heE9INkVkWEIyc0o5RklwVStrMm1NUGFpSG55?=
 =?utf-8?B?bFd2VjZ1NElzc0xSdmZHVzZuNFAwM1ZVdnlFeEdpQnlCcWZHWFlpczZiWksy?=
 =?utf-8?B?emFxUmFKbm5mYVlBN0pFeUlrSkpQY3ZvL0lLb0tPSHdJTUt6UzdMY0xsbHdl?=
 =?utf-8?B?Rkw1c0FTTjU1RkVPU3NCcGUrYVpUajE2S2xha3BjN0pSMXBRVmpDMTJTaE5n?=
 =?utf-8?B?cXYvSitlaU9rS0pOZ045RFRtbWJyTHlrUEpqVDZVbEFVV0tCUkxhYmRZNXJq?=
 =?utf-8?B?RUpOczhMK2VwUUo1WFhtSDQyejNpdmd3d21OT21IckNWTHNsWEdUWHMyUnZT?=
 =?utf-8?B?eUdhcS8vTzN6UHR3Ujc5RlV4OFIxUjdTdmh5eTRhSi8rVHhPTXZkS0lmVUN4?=
 =?utf-8?B?dTBhQzdRS1h0TTZzbzBPQ0NTVFNNK3I1d1liYTBscmVGV1JNUDBWV1FoM2x4?=
 =?utf-8?B?YlZpSVdCMUgwSkg1K25sb3A1NnJYVVFraTZqSFNkbkRIT2plRWxTNURBdjlB?=
 =?utf-8?B?Wm1oR1haeENRZnByd3QwdUN6UlVxdTB3bTRjSmNrZEhDL0pEZFNkZEY4U240?=
 =?utf-8?B?RmR6ZFhHNTRqSVJCbnpqcTluR0gyMnVBUFU4SmF3NzdSSEk0Zk5ycVJrdWZZ?=
 =?utf-8?B?YU9nRnNoVjJKbFNDOWhkVjMvOFlGT2dSQS9BMWtpTFRHYytVY3Bmd2F3TWtL?=
 =?utf-8?B?THJnSDQxNzNyZ2ZrYm9RdXU1M3FSWGo2dloyNjdXVUpEZHVvRFJJZWhjUW1U?=
 =?utf-8?B?eFNYZ1hMaGxjTkNNM1N5bzRIS2dCcWE2Wi9tOERTekwxSzJST3Z4VVJTRVVs?=
 =?utf-8?B?bXVxQnRsWCsyQUF0MkRRR0xWSlVSSXJMOStYeVcrN3ZoWlJEU0xWb2Z2STli?=
 =?utf-8?B?TjJWeGYycnVOendZaGU4Z0ZtTGxneXlCU3NIQnhsY2Zhb0svRmtCSnBKQWlu?=
 =?utf-8?B?U0RNS0s4dlBnQXpwVUY0cVVadlM3VHY1eFNqb2NqanNOeEtaVEp4SGVubmpx?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B58D5CDD3D48F64FB887B52FCA94CC76@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d55d30b-c2d0-4e48-3a86-08db2c48d28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 09:19:08.4039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcPuSMUUKmGRUjMBSI07HhffjxcGl9J2H3e+bmjOnAZkY3whe4Llgc+eBJIEoZhBq2FqT8QAowICNveFzZ86cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5346
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTIzIGF0IDE3OjEzICswODAwLCBZb25nV3Ugd3JvdGU6DQo+IE9uIFRo
dSwgMjAyMy0wMy0yMyBhdCAwOTo1MCArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8g
d3JvdGU6DQo+ID4gSWwgMjMvMDMvMjMgMDk6MzgsIFl1bmZlaSBEb25nIGhhIHNjcml0dG86DQo+
ID4gPiBBZnRlciBjb21taXQgZjFhZDUzMzhhNGQ1KCJvZjogRml4ICJkbWEtcmFuZ2VzIiBoYW5k
bGluZyBmb3IgYnVzDQo+ID4gPiBjb250cm9sbGVycyIpLA0KPiA+ID4gdGhlIGRtYS1yYW5nZXMg
aXMgbm90IGFsbG93ZWQgaW4gZGVjb2RlciBkdHMgbm9kZS4gQnV0IHRoZSBkcml2ZXINCj4gPiA+
IHN0aWxsIG5lZWQNCj4gPiA+IHRvIHNldCBkbWEgbWFzaywgcmVtb3ZlICJkbWEtcmFuZ2VzIiBj
b25kaXRpb24gaW4gcHJvYiBmdW5jdGlvbi4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
WXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4g
UmVmZXJlbmNlIHNlcmllczoNCj4gPiA+IFsxXTogdjUgb2YgdGhpcyBzZXJpZXMgaXMgcHJlc2Vu
dCBieSBZb25nIFd1Lg0KPiA+ID4gICAgICAgMjAyMzAzMDcwMjM1MDcuMTMzMDYtMS15b25nLnd1
QG1lZGlhdGVrLmNvbQ0KPiA+ID4gLS0tDQo+ID4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvbXRr
X3Zjb2RlY19kZWNfZHJ2LmMgICAgICB8IDI0DQo+ID4gPiArKysrKysrKysrKysrLQ0KPiA+ID4g
LS0tLS0NCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQNCj4gPiA+IGEvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWNfZHJ2LmMNCj4gPiA+IGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWNfZHJ2LmMN
Cj4gPiA+IGluZGV4IGJiYTdiOTMyZjRmYS4uMmMzYTRjMmNkYWVlIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWNf
ZHJ2LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVj
L210a192Y29kZWNfZGVjX2Rydi5jDQo+ID4gPiBAQCAtMTM3LDYgKzEzNywyMCBAQCBzdGF0aWMg
aW50DQo+ID4gPiBtdGtfdmNvZGVjX2luaXRfZGVjX3Jlc291cmNlcyhzdHJ1Y3QgbXRrX3Zjb2Rl
Y19kZXYgKmRldikNCj4gPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ID4gICB9DQo+ID4gPiANCj4g
PiA+ICtzdGF0aWMgaW50IG10a192Y29kZWNfZGVjX3NldF9kbWFfbWFzayhzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ID4gPiArew0KPiA+ID4gKyAgICAgaW50IHJldCA9IDA7DQo+ID4gPiArDQo+ID4g
PiArICAgICByZXR1cm4gIShvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShkZXYtPm9mX25vZGUsDQo+
ID4gPiAibWVkaWF0ZWssbXQ4MTczLXZjb2RlYy1kZWMiKSB8fA0KPiA+ID4gKyAgICAgICAgICAg
IG9mX2RldmljZV9pc19jb21wYXRpYmxlKGRldi0+b2Zfbm9kZSwNCj4gPiA+ICJtZWRpYXRlayxt
dDgxODMtdmNvZGVjLWRlYyIpKTsNCj4gPiANCj4gPiBMaWtlIHRoYXQsIHlvdSdyZSBuZXZlciBy
ZWFjaGluZyB0aGUgY29kZSBiZWxvdy4uLg0KPiA+IA0KPiA+IEFueXdheSwgYXQgYSBmaXJzdCBn
bGFuY2UsIGl0IGxvb2tlZCBsaWtlIHlvdSB3ZXJlIHNlbmRpbmcgdGhlIHNhbWUNCj4gPiBjb21t
aXQgdHdpY2UsDQo+ID4gYnV0IHRoZW4gSSBub3RpY2VkLi4uIHNvLi4uIEkgd291bGQgcHJvcG9z
ZSB0byBjaGFuZ2UgdGhlIGNvbW1pdA0KPiA+IHRpdGxlKHMpIHRvIGZvbGxvdw0KPiA+IHRoaXMg
Zm9ybWF0Og0KPiA+IA0KPiA+IG1lZGlhOiBtZWRpYXRlazogdmNvZGVjOiBlbmM6IFNldCBETUEg
bWFzayBvbmx5IGZvciBNVDgxNzMgYW5kDQo+ID4gTVQ4MTgzDQo+ID4gDQo+ID4gKGJ1dCB0aGVu
LCB3aHkgbXQ4MTczLzgzIGFuZCBub3QgdGhlIG90aGVycz8gdGhpcyBkZXNlcnZlcyBhbg0KPiA+
IGV4cGxhbmF0aW9uLi4uKQ0KPiANCj4gVGhpcyBzaG91bGQgYmUgbXQ4MTczLzgzIGRvbid0IG5l
ZWQgdGhpcy4gQWZ0ZXIgY29uZmlybWluZyB3aXRoDQo+IHl1bmZlaSwNCj4gSSB3aWxsIGZpeCB0
aGUgInJldHVybiIgYWJvdmUgYW5kIGNvbnRhaW4gdGhpcyB0d28gcGF0Y2hlcyBhbmQgYSBqcGVn
DQo+IGZpeCBwYXRjaCBpbnRvIHRoZSBwYXRjaHNldCBvZiAiQWRqdXN0IHRoZSBkbWEtcmFuZ2Vz
IGZvciBNVEsgSU9NTVUiLg0KPiBUaGlzIGlzc3VlIHdhcyBpbnRyb2R1Y2VkIGJ5IHRoYXQgb25l
IHNpbmNlIEkgcmVtb3ZlZCAiZG1hLXJhbmdlcyINCj4gZm9yDQo+IHRoZW0uIHRoZXkgc2hvdWxk
IGJlIGEgdG9waWMuDQoNCkhpIEFuZ2VsbywNCg0KV2UgbWVldCBhIHByb2JsZW0gd2hlbiBjaGFu
Z2luZyB0aGlzIGZvciBqcGVnLg0KDQpKUEVHWzFdIHVzZXMgIm1lZGlhdGVrLG10ay1qcGdlbmMi
IGZvciBtdDI3MDEsIG10ODE4MywgbXQ4MTg2IGFuZA0KbXQ4MTg4LiBCdXQgb25seSBtdDgxODYv
bXQ4MTg4IG5lZWQgdGhpcw0KImRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoJnBkZXYtPmRldiwg
RE1BX0JJVF9NQVNLKDM0KSkiLg0KSXQgY2FuIG5vdCBkaXN0aW5ndWlzaCB0aGUgZGlmZmVyZW50
IFNvQy4gVGhlbiBkb2VzIGl0IG5lZWQgYSBkaWZmZXJlbnQNCmNvbXBhdGlibGUgc3RyaW5nIGZv
ciBtdDgxODYvbXQ4MTg4Pw0KDQpBbHRlcm5hdGl2ZWx5LCBBIG1vcmUgc2ltcGxlIHdheSwgTVRL
IGlvbW11IGtub3dzIHdoZXRoZXIgdGhlIGpwZWcgbmVlZA0Kc2V0IGRtYV9tYXNrLCBpdCBjb3Vs
ZCBoZWxwIHRoaXMuIEJ1dCBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcyBhIHJpZ2h0DQp3YXkuIFRo
ZSBtYXN0ZXIgZGV2aWNlcyBkb24ndCBrbm93IGlmIGl0IG5lZWQgc2V0IGRtYV9tYXNrIGFuZCBp
dHMNCmRtYV9tYXNrIGlzIHNldCBieSB0aGUgb3RoZXIgZHJpdmVycywgaXMgdGhpcyByaWdodD8N
Cg0KVGhhbmtzIHZlcnkgbXVjaDopDQoNClsxXQ0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20v
bGludXgvbGF0ZXN0L3NvdXJjZS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVk
aWEvbWVkaWF0ZWstanBlZy1lbmNvZGVyLnlhbWwjTDIzDQoNCj4gDQo+ID4gDQo+ID4gDQo+ID4g
UmVnYXJkcywNCj4gPiBBbmdlbG8NCj4gPiANCj4gPiANCg==
