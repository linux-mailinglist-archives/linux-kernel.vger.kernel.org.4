Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EFC728FAA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjFIGKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjFIGKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:10:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ED630D1;
        Thu,  8 Jun 2023 23:10:31 -0700 (PDT)
X-UUID: 52a7ecd2068c11eeb20a276fd37b9834-20230609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LgSU3wOnltepXXAsmfbv3h95qK+gbhxZV883h0QVJcc=;
        b=Q3Mcok4JdW3EqZlWq+vuwD0ndabu1UZ6r7Qoz1rRUiu3l/UISimGhWUNYB5SMuqB9ihNLu0Ye9D8dC1WuNvNttiRAG9vdgiKcn9uN6k8k65anKiKdd/wPBUNtSHEQi2DvjxONhVZeGllGEfQs3bYtbwMqfXBnoeuu7XDvA1WAdQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:f17cc0e0-4b2b-44f0-b8ec-3b9ba20e3ae8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:ba51e53d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 52a7ecd2068c11eeb20a276fd37b9834-20230609
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1110645599; Fri, 09 Jun 2023 14:10:24 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 14:10:23 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 9 Jun 2023 14:10:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP5R9zNgcdXm+qWBAFnKaZys+eJospk6vdLmr+7swe17ABxrtckpm8ivLrOjRtxoxW7y3s9nskEwKUHx/sehuMOX5shW9kHMZeFJRtrGzIWAvoGpcF8KS8XkkjLgWXEm9IrXlUUYWBigPkGqW4jCJgAWcXlFrZOODrZyv+I3dWTCdL18tjlf8iluZmC1I5L+Yo7KJ5RgEtCeGtvjLKSS3HTXEKQjvCa649couKlQiga9WXQAO3s2DY/PZExBQUhZcTv/cKBW4kKOivcYg7ipbMuEraazbbVwq7osCFRiV4SwRg7VxNRa+vpuePLogeeYGjc1IF7G4OjvTjlgsCGNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgSU3wOnltepXXAsmfbv3h95qK+gbhxZV883h0QVJcc=;
 b=AmTYUZnFhWp8aR/KLF1AnH+1h/fwKBqEYoGgCoYPwrmv0A9stVXkyAGksHN8W+6v5pTgjfpBDzotjImTYaCljMexulvghRd82ayDJHCL4/vfpL/1WAyBB2v1Ak+yFk9cvPaO5BwX7PvSVV1Dhe5svJHBs3S8ubyKD0Nkl65klzd34dUDCtW9AS02z4/Lju/nyurja9r3r2eBRq8VE4dFsja7PiZ/2hK6gci/wI1lN+mSEi5TnIlM3uI2hdgdlcmqNsAOc5s4GQ4/0c1rUItlJ+HfuxcobFqS7qJV90PypTTD2wC6MZwIdY9KKd+6neVxHkyfDSLBidlkfyAT5QabwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgSU3wOnltepXXAsmfbv3h95qK+gbhxZV883h0QVJcc=;
 b=ek4fOImc6kzNlMmqg43eS11F+GFLizllNLgSdjrJzdqDwjN4nN1IqTz7tTGfW8QlVEzMYHmakVoFc/MXMfsyqpZz/b+ZcrbmZtyD53MKPG312x4eP46g/q/O76UXny5akRJ8FTUobBehdCZP5UrV78hmvZnOOPNnYJpnb8mDk1E=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by SEZPR03MB6713.apcprd03.prod.outlook.com (2603:1096:101:7d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 06:10:19 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%9]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 06:10:19 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mmc tree
Thread-Topic: linux-next: build failure after merge of the mmc tree
Thread-Index: AQHZmnKSA4S/gLsG4USCEIbR87aPJa+B/TyA
Date:   Fri, 9 Jun 2023 06:10:19 +0000
Message-ID: <6c300ab4abfe311a1d21d8d64b34cf38b3c9d639.camel@mediatek.com>
References: <20230609113418.4044d159@canb.auug.org.au>
In-Reply-To: <20230609113418.4044d159@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|SEZPR03MB6713:EE_
x-ms-office365-filtering-correlation-id: 486aa845-a080-4465-24aa-08db68b033e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d1pDfq/1JnPJ1ENDS0BrsqXc+Yw1L1DXdiHBi9b35/MCmY8f9FOmdNns0bed8/IXG884hAHOC9dGVSEYDUDl5fWf729QM6OY67iEw3lYMxZFZONVcoo+JYkQEE1mLcHcaa+KaVKz8lixolGVAwAwZn4lzMDSAV6dbYaU/SV4zsnT9w6GCYkLKIUnYVfLtgTxBGjG/OXPKoLtnQWFrr0DFgExaA2gmMBFVx45hgS5sC6WGQ/RxpBnQc4BIHuos37DfIeaXMgZ5BWJ/o6DeaOQbvEvebZ1BGsANiD1lOV/AofEf4rHkQE4aGz8girziOo/yFjlAA+mL2ZrmPKV4zpm1ZmSZjU7bH7Sp2dcELAjdKiZXRQ32k7qgTVrIKghbYVa9MTo6JYW2a+htKFYxQQFMMdwVNh0l8Fpl13ODgTrMZXNqjePD5cohwYWPtmZW+xtookuHbWHISTFUH8lsIg2FeG/z1se1wYeYtDfsGO7aI1ADcOkgTNw49UFxFxO3t2CTiIf72+qV0mlTBwRNd+h8NersM1ClCDHx9/xOrPq7wAIUjGXwo9GaVHsqoz5EJJYFQGLuCX8Z21EzC7MT39KRIURHQA/S05MFSq1mTMbHdytntXWPZvAWGISrFiExjoO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(122000001)(66446008)(4326008)(66946007)(66476007)(76116006)(54906003)(91956017)(316002)(110136005)(66556008)(2616005)(478600001)(71200400001)(41300700001)(6486002)(38100700002)(2906002)(64756008)(38070700005)(8676002)(5660300002)(8936002)(186003)(26005)(6506007)(6512007)(85182001)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1FRMVJGVm9hOGZZV3ZRRjREVGVPNFcrOEdvSDUrclRLZThaNlRSR000TzZF?=
 =?utf-8?B?YTlwOXliaGdTUHlvMk5qcldyRkdjazJEaU91QUNZV0VtZ0NsbEV1Z3htTmpU?=
 =?utf-8?B?ejFtSWxkKzB1c1h3M3Q4MStyQ0VNKy9vZkp0am5qQVVYcFhJN0todDRLbG5a?=
 =?utf-8?B?azlwUXFmYkdxUHVSbkY1bm9vc3NkMlN0cmlXbjdwRysxVW9kTWU5ZXh3RWN5?=
 =?utf-8?B?dis3VVpKYXh6SUlmTFkzbklwZ1ZFOUF0VWRvODlYYW5uaFNZZXcxMUJ4eTRI?=
 =?utf-8?B?eHdzMjFtcVpTU29nbEFSZzNla0xsdCtxQXVtc0NndzNLcnVvMDZxVkQ2Zlg1?=
 =?utf-8?B?MWttdXY5ZnRCbm8xU1N6ZGsyVXBjRktIUmdOL1VvYkxwT05sdVFRaGhUYnlJ?=
 =?utf-8?B?UlpNVDFXbTJJbFZyVWIxS1ZRbjQ3Q1NaREZrN1EzNjc5aEpQTU8xZDNDdVRi?=
 =?utf-8?B?QnFvTFJYaTlMZVNBYm44VC9KamliS3FTSkJlZU00cjhha2FXK2V0QW95cGdt?=
 =?utf-8?B?dTYveXRQMFptTnVpbHh3VFRTQVpIUjI5dFVNWmFXb3hwWUY3aGM0bVg0aXdH?=
 =?utf-8?B?czlnQXBHenk1cGE5aHc4dnVybFVvdFRqRVhRT0FZMlF1SkVVVkN5cDJLVGJh?=
 =?utf-8?B?VWtubEtpdXVNcy9SMXdseXJ0RSt1TGhVTUVJdi94Q1VROGhUVmFhb1ZBWWJx?=
 =?utf-8?B?cFY5STVRcDR1c2J4UHZKN1gyTDNSbjVESXZqZ244MTVwdkFYdDBsRFhSS1hv?=
 =?utf-8?B?TWNNcjY5RVB1eEZiL242cjZ0ZkQ2N1F5bUhFREVycUErNlRuRllYYUNGa0Qz?=
 =?utf-8?B?OHFESndTSHdTLy9EWjhPYko1THN1c3VEZnFRNSsvSGhLRHJkdlVJUXFzRVo3?=
 =?utf-8?B?d3VXQi9uOEVGeTZTaC8ydE9TbDgzMUNjblZ1NVVlWEVUN2RhWVM1aWZ3TVpz?=
 =?utf-8?B?TkNOd3ZuR2cyZjRQVC9xUFJuOGlQQVNVSFVkUXVISHFVNVFwclRhSUVwSDZN?=
 =?utf-8?B?VjE0emhLZHFBMVN5eWgzNjQrRGIrcWd5ODFzQ0ZSSUZiTjF1SG1UZTNmNWt5?=
 =?utf-8?B?VTg2NGVlb3lQc3lINjRsTWxvVTdIMDNyMnhBeUs0UEJBWXhrTDVPK1JzT011?=
 =?utf-8?B?ODFuQkY0R01OMjM0cC9aSkZjdkRpNDN1ZTArRXZVdmMwdnNBdjdCY0JBdVVh?=
 =?utf-8?B?TWtHMXI2YWwrdGx4VnRMbUFHS2dRelorYmJyWXZkd2dabE9ObldVVXljaHRl?=
 =?utf-8?B?b3l4aUcyVWoxelhubTlNaGhJSGtDVWh2Wnd0WUl3bllsa3RNM0QwQ3Flb3pt?=
 =?utf-8?B?MDhjVlhMZGdRWXltVk9zWG1DWkllWEQ4cFNkejhvdWN0N1dyKzFKS3M0YXky?=
 =?utf-8?B?S0IxaEExVVBici9NOWFyeE9rWXh4WEQwS3ZvVEk5YjB4T2hqUktueUN6c29z?=
 =?utf-8?B?VFBRa0VZRm9DcHo0b2RucTZWU0NMcERYTXUzaCtJYjF6ZFlOUG5RMTV1S1o0?=
 =?utf-8?B?M2t2VmJkSFkzYjZFRUltT3FCSmR3NUpKV1ZsQnNHTzhEVWdBZUcvMjNNR0wz?=
 =?utf-8?B?QlcrTVZmcElSamRvWVcwUzJOaDJiSXlpQWhhV1owbHB0YXFlUzR5SDdBcEJX?=
 =?utf-8?B?ZTRIam1ZdUR6ZGRzQjhJOGQ3Qk5jbDlPK2NRMTNZOUdLZzM0M0VPRDdJcGhy?=
 =?utf-8?B?Q2wrYlMrTHhvWWErbHFXMXR5eVJzVDl1Q3hZWjV3N0F6YW9ZMU8rVlVEWmVO?=
 =?utf-8?B?MGFSelEwUStEWVRJclN4NHNSOWpwWWtDOWtWKzZqSWF5amt3N2lzYmtRLzdu?=
 =?utf-8?B?TExwNzd6cEdIaUlpa09xdGZBNEhrdC8yMVRNK1VONW96RjJzTTJPaUhEbWtJ?=
 =?utf-8?B?OFAvSEkwL2dPODNPcHlCVE5lWVBLTHd1TXNtSnRmeGVWMTMvNEQxSWFKNllq?=
 =?utf-8?B?UmtPeEczOWpKalZhYU14aTBUMXFua1oxeVJobGx0Tmxvem92NEJlSm8yN0Jy?=
 =?utf-8?B?MkxwREgydEZyVlpkeEU4QU1rT3JBM21mNWJENGVjb2t6NG9XKy8zdGg2YmI1?=
 =?utf-8?B?czB1S25kNjh0b2I2dEVWcWdtT2hqVGk5UkVRMDZQejErL2k0RFVtMjlQVmNE?=
 =?utf-8?B?SlZURE9zbEI2NTdCSDZJMFhrOEhZRHJzTGlqeTh0MkhFVHd0RzVXRjgxRVFo?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0FD18CE27F2A149846B2DF2D8AF4618@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486aa845-a080-4465-24aa-08db68b033e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 06:10:19.6969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B29TMot6wiIe18uoFWa+mnhs9NKg2WYB8ezv6uEh+f6g/KA5oRG2tHFyxMfTh6ApQVoz7VG3+gPuTTxWj0o+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6713
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTA5IGF0IDExOjM0ICsxMDAwLCBTdGVwaGVuIFJvdGh3ZWxsIHdyb3Rl
Og0KPiBIaSBhbGwsDQo+IA0KPiBBZnRlciBtZXJnaW5nIHRoZSBtbWMgdHJlZSwgdG9kYXkncyBs
aW51eC1uZXh0IGJ1aWxkICh4ODZfNjQNCj4gYWxsbW9kY29uZmlnKQ0KPiBmYWlsZWQgbGlrZSB0
aGlzOg0KPiANCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvbW1jL2hvc3QvbXRrLXNk
LmM6Mzg6DQo+IGRyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmM6IEluIGZ1bmN0aW9uICdtc2RjX2Nx
ZV9jaXRfY2FsJzoNCj4gZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oOjI3OjQxOiBlcnJvcjogaW1w
bGljaXQgZGVjbGFyYXRpb24gb2YNCj4gZnVuY3Rpb24gJ0ZJRUxEX0dFVCcgWy1XZXJyb3I9aW1w
bGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+ICAgIDI3IHwgI2RlZmluZQ0KPiBDUUhDSV9J
VENGTVVMKHgpICAgICAgICAgICAgICAgIEZJRUxEX0dFVChDUUhDSV9DQVBfSVRDRk1VTCwgKHgp
KQ0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+
fn5+fn4NCj4gZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYzoyNDY4OjE5OiBub3RlOiBpbiBleHBh
bnNpb24gb2YgbWFjcm8NCj4gJ0NRSENJX0lUQ0ZNVUwnDQo+ICAyNDY4IHwgICAgICAgICBpdGNm
bXVsID0gQ1FIQ0lfSVRDRk1VTChjcWhjaV9yZWFkbChjcV9ob3N0LA0KPiBDUUhDSV9DQVApKTsN
Cj4gICAgICAgfCAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+DQo+IA0KPiBDYXVzZWQg
YnkgY29tbWl0DQo+IA0KPiAgIDM2NGRhZTNlODBhNCAoIm1tYzogbXRrLXNkOiByZWR1Y2UgQ0lU
IGZvciBiZXR0ZXIgcGVyZm9ybWFuY2UiKQ0KPiANCj4gSSBoYXZlIHVzZWQgdGhlIG1tYyB0cmVl
IGZyb20gbmV4dC0yMDIzMDYwOCBmb3IgdG9kYXkuDQo+IA0KSGkgQWxsLA0KDQpTb3JyeSBmb3Ig
dGhlIGluY29udmVuaWVuY2UuDQpNeSBsb2NhbCBidWlsZCBpcyBwYXNzLCBidXQgSSBmb3VuZCB0
aGF0IHRoZXJlIGlzIHNvbWUgcHJvYmxlbXMgd2l0aCBteQ0KbG9jYWwgZW52aXJvbm1lbnQsIGFu
ZCBJIGhhdmVuJ3QgY292ZXJlZCBtYW55IGNvbmZpZ3MuDQpJIHdpbGwgcHVzaCBhIGZpeGVkIHBh
dGNoLCB0aGFua3MuDQoNCkJlZ2FyZHMsDQpXZW5iaW4NCg==
