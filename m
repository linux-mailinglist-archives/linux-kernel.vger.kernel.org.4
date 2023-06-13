Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D2D72DA72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbjFMHH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbjFMHHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:07:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39E0268C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:06:40 -0700 (PDT)
X-UUID: d5e621de09b811eeb20a276fd37b9834-20230613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Jw95RLs2zM8ZEyb0S2VMu+ldUCbhVLAPdFCYSODB93Y=;
        b=EYixz2Xhxg9ZcpnVhMsf7Llf2sSYSv6Hz78UooILk/l52FsUi1YjScEPaBCQecLsMNK/b/3CWj9LXBGRvAlzoLEvnVjT/f2PZ4AZUNxuAXH+N5T5/Zn1tHe0T+qrLUwmf8nqT/nh1d6grXSftVp+mA4jGGP29wazCoEcOP2GprI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:b337d20f-bd15-418d-b1cd-79b9fe78728f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:f765733e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d5e621de09b811eeb20a276fd37b9834-20230613
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 342922520; Tue, 13 Jun 2023 15:06:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 15:06:35 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 15:06:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJjFWfgKtnmHMgIRW7DU078ZH5oRWvLIFT2G8+/wbxZ6mfhHW3vkdrEZjyf2DS3Df1t8C2AWSnZIKKNj4wobjHTaShrFK6Ln5BQS8/MRKGMRFRujdREHOHiqs/mc75nkK+bS4/na0ijxnui74rrW/mXVSiWPtXpwDtK0GHTBasLPZG3bCYhU8E/OAiIJDctR/KH6d/kTppFrpSyfzSgNPV1WbgRcAZqkjMqfVHx/dMcvQha7IDqU1WwHq3gCT0YsijDzUGhBlr5Bc70Na0DDxcqThcVbHszQm3CQtrJDZNwJRDMi2O43kM0PCbR3WeOixQgim7xWi9TpWnjoQCMKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw95RLs2zM8ZEyb0S2VMu+ldUCbhVLAPdFCYSODB93Y=;
 b=PCAB/Y1Pj11ykkbUTBl0fYf5rS6fKNEs6h7868/zJRC58ie/y6wPhJuRco1EBkJUOvvhoVqDwgdM7TRCGH4fd2PPJv2IHXtSVV5yNfAFuHrMWKLqgXvYuMxr57kfKXhPM6ZxVd8LxbO7u4j7Gs6U70SzJcujNQ9WwIjhSoMXby90dTJX3zP2w6qtrWqeSrLtKmrOXQ7nf5IgsX58yROz6HL5l14EgS/gqYq1ppajGhumnMoMIKGbJ9mKR7nDPsv5M2WzopcyTnPrAlnviu5y2Cbjb6JtzhVD8QmHhwHZt+noH7xjK3wjPCTch5i3kxyQ3sf8mBv7mmZy52gacroN5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jw95RLs2zM8ZEyb0S2VMu+ldUCbhVLAPdFCYSODB93Y=;
 b=Zk0U7Pd+RiaDwgGB0BdIF0YwBvdKGoiQcYdNI0ynMazgJ7mtzzJTKf8jdJmAZU2h7klL8wws8e/N0sWnQGCc+zWDVhnZwejAaSOGVR2Opze//vsGnda38D+7rikcrd6OeDLyan8VTOp0Wp+aD/9qdKXowuMElqHA3nU4yshNbqc=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TY0PR03MB6949.apcprd03.prod.outlook.com (2603:1096:400:277::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 07:06:32 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8b05:4869:405a:924d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8b05:4869:405a:924d%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 07:06:32 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH 1/5] drm/mediatek: Remove freeing not dynamic allocated
 memory
Thread-Topic: [PATCH 1/5] drm/mediatek: Remove freeing not dynamic allocated
 memory
Thread-Index: AQHZaRzTAcuXVQUCF0umvPb9BnZJW6+HN3GAgAGBfoA=
Date:   Tue, 13 Jun 2023 07:06:32 +0000
Message-ID: <6c5fe5f4c6e82dec6613317933ce43ade11ff332.camel@mediatek.com>
References: <20230407064657.12350-1-jason-jh.lin@mediatek.com>
         <20230407064657.12350-2-jason-jh.lin@mediatek.com>
         <2ff94f781b17c25229d547e763f74ef43aac35f6.camel@mediatek.com>
In-Reply-To: <2ff94f781b17c25229d547e763f74ef43aac35f6.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TY0PR03MB6949:EE_
x-ms-office365-filtering-correlation-id: 463c4b34-7f5d-4c85-71b5-08db6bdcb7c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pFYt6okh15uZYAep6kTyZhXb0Kwjn3HHeRnxQC1ud20rWAwHDlTP5B14kzBennAMhJsbaCdzly5NdrMludD/GTfXtkXOFZU2k5wKmCWSkh5KUPSwTeo24VtX5DoW//w1lh/ym2idrKkG7xDhBYAo9HoDGadYitivLc59/OX6fIIHC4J8ZducOh4W2b5N7BHqgoZRirwJm8xebEZGZpvpbbb22usP8/OK3nQGB2aBTIIqdWnW4EYPnqzhRlfRUZTVCirJEIiL3JtLfeP4eGY1/G1MGgM4k2S0qOlKReWoW1WEXABs/eNGtP7xEGvSI0FNivJ773jNj5iwluOLTjWf2cpEKaC67XIIkmat1fsQrP4DDotNqXIgKOfQWM09VSV5vEd1dHnZt320FQdxuMV73qGaXNFIDbJ7/i9GqB3XkYyH28N2BdZN4DLNoKN0zzul0G1qnh9N7Jg4LZaOH23cWUkVTEQUoHiaQq9WjNWzW2r6uTRZ2lgxCRTbA9geZm7kq5LEqo1pPlu5XIIIP1WhiD31jhO1mTe5+ft2QPAbKWjy0yhP3veOHs7/p4LCOF+OB/q+NiBKapkUcXn1Xtpud28nekpHNUHvVsd/9WuiV14=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(54906003)(66946007)(76116006)(4326008)(91956017)(66476007)(66446008)(64756008)(66556008)(36756003)(186003)(478600001)(110136005)(2616005)(2906002)(8676002)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(38070700005)(71200400001)(122000001)(8936002)(5660300002)(83380400001)(26005)(85182001)(38100700002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm5HTzJralR3VjcwQWVFaDBXR0xyQXVXUWZhQklnaWpZWUYwSkZ2TndJVlZN?=
 =?utf-8?B?dFoxV2cxU2tyOFJRSFNGVEhmK01TUWtVaUR2R3JMNmV5ajlScG9GQ1Nybloy?=
 =?utf-8?B?WHhLNEJVWDc1N2JWRHNHT3pMUFpQNVovOHJOWkFMVTFPR2hsNHhIOGswTnZl?=
 =?utf-8?B?NEJVNHB3ZzV2Uk1PWlRpVHJrM05xYUZnNUcvTm9ySEYzS0pLTCtWYTQ4ayt0?=
 =?utf-8?B?S2dOb0s0MW5WczFTaG13K0pucFhBUVJjalFiM1gvbVNEa2htN1dkM0hxQ21M?=
 =?utf-8?B?ZlpkUksvLzVOMmhUNVEwK3JNbmxUVi9ZQXhadjFPaDh2NTE1VjZrc2drU1g4?=
 =?utf-8?B?SG5YR2lUdUQyWlZIZHpEc2s0a1JHSmI2ZGlkVnpjWTJLbkJWZ25LVmZMUGdn?=
 =?utf-8?B?Wk1OWklkclkyNS9QdEZKeGpmQXk4WEwyRjZKQlRRb1FydVh3MDZXOWpMUDVk?=
 =?utf-8?B?K0Z0TXN1VW9PSDJqSVRXVWdRdE5INVdDTFNzZEpZQk9iZzdGYUpEVDlId0I1?=
 =?utf-8?B?NUVjYWR2NHliMXBwVmo3U1N3VHMyV2QrTkJvZ1A4TURydWhQQklLNk1XWEFF?=
 =?utf-8?B?WGRadmxGOUZJelFuUXBlTXBvRmxJc1hXdlNUREdoeFU0NzVWeDBvakxOM0V0?=
 =?utf-8?B?N1IrNEs0YkVOODBuUVVYbTJoRlpFMzZiNGNjSFdYaVg1YzhsTnBhRk13UFhY?=
 =?utf-8?B?ZXpFUElRSU1MbGp2eis1Tmo1YTNrTmV3ckgzUExQemp2dHhrVkJaanFrcVJY?=
 =?utf-8?B?TVdEcEpxYy9JOFRLSmFQU2hobytLRFAxOHNEU3MzdzBua0llOFhYVUh4Mm1p?=
 =?utf-8?B?TDdUSEJXTXU4a242dE9HZjY2blBtVG5RY3lnVnM2VkllOGJzSkZWYUtCVm81?=
 =?utf-8?B?Zjk4RTEwbEJQdHBoWnpEZmtncVhseFpRZm9PVE9xa1orb1FBMktNUkJ2Nk5s?=
 =?utf-8?B?d215WGY1QzEzUnM1TGkzODJ1dWZuVXpBWFdHY2tzVnR6NkxXZC95WGJoU0pV?=
 =?utf-8?B?MVRibVAzMHZNZUVQV2t4ZEIralUvS3ZsQ2pxNXdiRFh3Z2N3RFgzazM4TUo3?=
 =?utf-8?B?NmlEZUpneGV4R29qMTU2eUJDVDF6clpJTzZLTHlMYTROWElDL25OcnNkNGUx?=
 =?utf-8?B?czFFQWllMlRaNEV0Z2Z4RXRmV0hhUUUzZDYzbHpTeCtZMlVzM3ZyRDlva1lJ?=
 =?utf-8?B?a0YxRnkybUFLUWh2WVlnaUVWdFVjZmE5WTdhZklLSGlQY3pCVWtiWnBueTdB?=
 =?utf-8?B?aXJ2OUE3N1ppMWZ2cUkwdW13bktVRkR6SmlJUTdpMFdTME85SmczOE5kNWt4?=
 =?utf-8?B?SWRJMjJpQmsvOW9yU0krQkV4V3U2c3puQXEyN0FSNG5MUmhtbzlOTTFxY3B6?=
 =?utf-8?B?Mm1LTVJPVG5jdEpRd1NLazhjaWFaQlNjSm15ZWtRbEJ4MVg3ZStoM1l1MmVi?=
 =?utf-8?B?RUZqYVMxanU0MkdRSTh2M2hXK2d5cGFCLzJMVU1LZURMc3dmQlo1L1lIK0RF?=
 =?utf-8?B?Snp4U3ZBdmJnZGZSOUFKK3h5RmNtVUF6Z1NxZmZVL3djbkJJRWg4T3owTmF2?=
 =?utf-8?B?YUx1dzU4cjArQVRvaFFVTmtScUswd2xwR01DcjlUcEplelhsZzZNcVZFMjkr?=
 =?utf-8?B?WE4zK0tlNDU3RHowM1YybGUyNmFKcWtJZ1ZUZ3V1RDhVT1piVWd2WTdRbnJo?=
 =?utf-8?B?MWJDRVJHQ29vWUtCN0lWdjhvRDIrOGllcXpISTdlTFU5K0gyejNMWmRuVGhm?=
 =?utf-8?B?cCtBY2lZb2JiaGNwdVVEZFpXeTdrZllNZEpjTW9IKy80ZWdDRmkzNFVpSDg5?=
 =?utf-8?B?aXcvcWc4bUh0Q1NMUjQya1VtdC9Ia1BGOVRybDNTbXJYMStod3dDMWlWMFcw?=
 =?utf-8?B?OHc3UVVEV011aHBXZ3N3WnVzNEt1M2djQlRCdEFvOWIyYkJYWENSdVgySkh4?=
 =?utf-8?B?K01VNjZTZ2FGbVBvc1g4ekFqajNtRXdodlhOcjBtak9nTlpPeEJodWk3WFd4?=
 =?utf-8?B?eElmN0sxSXdsNDVka2Z0dEM2QjhuWEI5TnBxK1g4UllzcHl4cFo2dllIckRC?=
 =?utf-8?B?ZE5oazJMbmNUaUZvdjd5U0xJY1piOGc4VWhlSmJLTU5adnIraVlQamwrN2Q2?=
 =?utf-8?B?TTM5L0VmcFpBU0gvVXlFMkJkcHV1ZEhaZDV5cURvalVGVlpHUHpNLzMwSWpr?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D26148B6B347C344AF1F8A7A27E48D24@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463c4b34-7f5d-4c85-71b5-08db6bdcb7c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:06:32.2899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4gIJpZi8ojWJRiRKm7oQIr9nzh51bUxe+kZgDqUbyZYJKxzR1wdKba3wc2poNDsQRVTEL3YfX6oesSW1+xV5DooTFfAaR8MrQG9DRKcxQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6949
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyMy0wNi0xMiBh
dCAwODowNiArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyMy0wNC0wNyBhdCAxNDo0NiArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IEZpeGluZyB0aGUgY292ZXJpdHkgaXNzdWUgb2Y6DQo+ID4gbXRrX2RybV9jbWRxX3Br
dF9kZXN0cm95IGZyZWVzIGFkZHJlc3Mgb2YgbXRrX2NydGMtPmNtZHFfaGFuZGxlDQo+ID4gDQo+
ID4gU28gcmVtb3ZlIHRoZSBmcmVlIGZ1bmN0aW9uLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiBGaXhlczogNzYy
NzEyMmZkMWMwICgiZHJtL21lZGlhdGVrOiBBZGQgY21kcV9oYW5kbGUgaW4gbXRrX2NydGMiKQ0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgfCAx
IC0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBpbmRleCA0YmM0NWNkYmRk
ZjEuLmM3YjAzZTU2NDA5NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9jcnRjLmMNCj4gPiBAQCAtMTQ4LDcgKzE0OCw2IEBAIHN0YXRpYyB2b2lkIG10a19kcm1f
Y21kcV9wa3RfZGVzdHJveShzdHJ1Y3QNCj4gPiBjbWRxX3BrdCAqcGt0KQ0KPiA+ICAJZG1hX3Vu
bWFwX3NpbmdsZShjbGllbnQtPmNoYW4tPm1ib3gtPmRldiwgcGt0LT5wYV9iYXNlLCBwa3QtDQo+
ID4gPiBidWZfc2l6ZSwNCj4gPiANCj4gPiAgCQkJIERNQV9UT19ERVZJQ0UpOw0KPiA+ICAJa2Zy
ZWUocGt0LT52YV9iYXNlKTsNCj4gPiAtCWtmcmVlKHBrdCk7DQo+IA0KPiANCj4gQWxzbyBmaXgg
dGhlIHNhbWUgcHJvYmxlbSBpbiBtdGtfZHJtX2NtZHFfcGt0X2NyZWF0ZSgpLg0KPiANCj4gUmVn
YXJkcywNCj4gQ0sNCg0KT0ssIEknbGwgYWxzbyBmaXggdGhlbS4gVGhhbmtzIGZvciB0aGUgcmVt
aW5kZXIuDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCj4gDQo+ID4gIH0NCj4gPiAgI2VuZGlm
DQo+ID4gIA0K
