Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE6062B301
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiKPFzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKPFzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:55:04 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120D220D5;
        Tue, 15 Nov 2022 21:54:59 -0800 (PST)
X-UUID: 7add48cb536647509255c794805aae7f-20221116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wF0SH/H3D1XPfxxyd2+TFRCXjMixTnd/8CngWf6vwGw=;
        b=DJu/28ln5+1gPLalZSHDCI1xAsQM7Yw1vZB34qYbd9ck1z9ErWhuORusZxAljM+tSSSAARsoOBz394PueJMkpRV45e2Hfzsf/OdGAo8Wdp43m6GpO62NX5tvx4uXPjcDP+029xk7PhS1D9qnPEeA96lry+ftFN/RqvD3VY2gHr4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:e085c8db-2dbb-4300-8192-88ab2c8d7253,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTI
        ON:release,TS:18
X-CID-INFO: VERSION:1.1.13,REQID:e085c8db-2dbb-4300-8192-88ab2c8d7253,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION
        :release,TS:18
X-CID-META: VersionHash:d12e911,CLOUDID:2b7a16a7-42ae-4d60-a0e1-13055294f8c6,B
        ulkID:221114141301RLEV1400,BulkQuantity:36,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: 7add48cb536647509255c794805aae7f-20221116
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 920626801; Wed, 16 Nov 2022 13:54:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 16 Nov 2022 13:54:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 16 Nov 2022 13:54:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ6nCQVPoltW/mN1JedIXBNKWiXxuUKpYRTS6buZbmwpZPybepF/vH3EiuqOkb0fwX43JDvaFDhtHjoqFdy09hkI2eUKVQtBpoLxPDMq96aN+tBpjLCO6PygFW6eGENJD1OSd9XOLmJYf3/QYqPxh5l+fzIYe0DICLSOobUyGD5OavbkurIAzZcaqCS2WX/7FY6pamNkEmAVybsftEi6lIaBWwtVeP6IOB2utp7tq+GP/j7sDCGOiV3QvBEte0EHLhW1cWM+n3gUIIexuph8DPvyFS2SQ+Jo7ZHdcHEaBnkAnlFg2nHsetNZiJAsUkZxg+jb8ThZSn09iPAq0FPzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF0SH/H3D1XPfxxyd2+TFRCXjMixTnd/8CngWf6vwGw=;
 b=hxO5MV4b7uNARInYgKN6p5Y02gsHuv3wTFWtMBye/PZ369mggWCuu38tQjovdbhnl8ngFkVmosPR6xZW66pzYCU5ZHYZ8ZVUk11bReVX2l+c7ZkMkdjAN62Q2mq2kiOgdMUaeEGzMipW22xFYvnWlwy74Er8BEL+in7wwCNuL3LtqyF4u5Cz5VQOfB+br/tYXCwwOj8ERJ0wfadR29khRfC8iagvZbxbfJKHpDd2vY3uJnkY+KWI6r0IAxjq7oOMI+oP7WTUD6MonD/lYEpBuiu1yALOX1SH4KMdqgT9SyWezy1UJzgTkls+8/VunxD5DwvJ8C6rKljdmAm09bK49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF0SH/H3D1XPfxxyd2+TFRCXjMixTnd/8CngWf6vwGw=;
 b=Xy1RZvsfhdk2o6w3CmUeQ8NPzaS4rrcd7cNTn+nMFZpqxHthwGlwi5cBiEnW/YZDZaBtKQBnoNwnPdtOwC4drJ7WL/BLxT6uGpuCU6DjviJ0kPursgRU3RYkqJN1JZWAXu7xayucG3q0jnTft4J1JU2lB11wHz8tSnjhVDTBTbY=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SG2PR03MB6327.apcprd03.prod.outlook.com (2603:1096:4:177::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 05:54:50 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 05:54:50 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     =?utf-8?B?WGlhb3lvbmcgTHUgKOWNouWwj+WLhyk=?= 
        <Xiaoyong.Lu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?R2VvcmdlIFN1biAo5a2Z5p6XKQ==?= <George.Sun@mediatek.com>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] media: mediatek: vcodec: fix h264 cavlc bitstream fail
Thread-Topic: [PATCH v2] media: mediatek: vcodec: fix h264 cavlc bitstream
 fail
Thread-Index: AQHY4uayXmm78Htl6U2l3cOFODO/Xa4+bRWAgALM/AA=
Date:   Wed, 16 Nov 2022 05:54:49 +0000
Message-ID: <70a85f8eb168cf57b2a38807d0ca852b27b67d80.camel@mediatek.com>
References: <20221018114122.26785-1-yunfei.dong@mediatek.com>
         <f301a43a-5d55-1607-b8d3-5cd057977397@collabora.com>
In-Reply-To: <f301a43a-5d55-1607-b8d3-5cd057977397@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SG2PR03MB6327:EE_
x-ms-office365-filtering-correlation-id: 8cb4e0f6-939f-41c6-ad08-08dac797130c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pkvll1x+C1yR4f89o3ADVYJKiQvAe4BsIVOVUIfGaL6R1dJbMDvInHDxg+45a+1zyjyF2KDRRsOMeLE75DRRI7sBK63Ld3HbScXDrkbxdGPw3nU6ZgRiFtWiTu9mi8nPNs870C7zeX4sDulFJMnLbfJM/HwyZ1D0EZpnghx245SQKRhuZH72v1aizKANfgelWGZSuilRd4kHh+cKyorhy4iqYc5S1w6+Ly2dKGDivn4OotFhRFlA/7acD5gYH89XM+p9XaTqp1pwpN+93gjn4DW1F20GcrkgNB49Vst4eKLWJNVF+B0PJUhlqtTu7CyiT93thfrkBUjAMQ2nqqPEy6EKPAdJroan7Re4aJGrpV2OHC6KUNk5nzToSUafdC4aXvQRgN4gorX05E6vFwGihgOlymRYyWRt2KO3biIWqf11mP8SQRUoMs25tPlZeRahIQX4r4VDup9xs+26Q8TLgcdBFxMo+h+gdsLK4E6om7HCetb2lRtF0Lsn8f5F0/6Y96zR6J6rhkrxSreTYdRSqfdJCWqTgF3eM2/8oP95HSKLuTvj8LyNwSBzlgzckzOQY4CzS7pz1SJv0IuiWkOTh1tT+/J/gjWFF8yEuCVa7XmM9ZU6d/rsle93xeio3G2vks5ARSHh3IVi8hA5FbUcEvJ/RBGuNVcdCDcGGonH9r3srLPbc3CQMMHz5AjoI57d+R6m8eRSfiYM70ataqdXtoSs2dTvrkPwF9Wj0gWwE0kOW7mYiCN3BHX0OPvDACexTTUFGg+JUutXEGiZA0Yw2PFW4i4VIacQBuBQVvS61Ii96H7WG7ZcmwVa/I2igI/rjiP8W/yMYLpqAuoXYMYf1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199015)(71200400001)(26005)(6486002)(41300700001)(6506007)(478600001)(91956017)(8676002)(4326008)(54906003)(316002)(110136005)(76116006)(122000001)(6512007)(38100700002)(38070700005)(66946007)(66446008)(66556008)(66476007)(186003)(83380400001)(2616005)(86362001)(64756008)(36756003)(2906002)(8936002)(85182001)(5660300002)(7416002)(4001150100001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzI1ZjZvS2pBU25KcFkxS2FZRklUM1g0eHduNUFSRnBuYVRpeU9MdDRCaUN0?=
 =?utf-8?B?dEkvbmNlc1J2NDZDcEtCQzdla1Nvb1lyR2pYb2pndEwxdXJpaCtTQjlDczdy?=
 =?utf-8?B?SnB1bDFORllVWUxjWU5YMVZ3OURUYThEK0szcGRDdFZueVN4bkoyWm1OQjNK?=
 =?utf-8?B?NjgybmYzei9nUVRRL0FYOHJUN0g4S0I2K0tpWjZuQmlJQjM3RnlnN2xwbWs1?=
 =?utf-8?B?R05seXpDS0I4NmZpVEtrN1YwVWRDUFlyc3Y0OWNJUTYzUWlsb3YwMVBnTVVZ?=
 =?utf-8?B?aElsdm83alR1U3YxanYvTVd0cVc3YTBNVm9IUGJhM1VpQkJiN3pkYm81anhk?=
 =?utf-8?B?TlpraTc0aEhFSzgvd0hCWmtoWVl6Y1FQU2E2SlROQVhsVjl3YXh5NEFmdysy?=
 =?utf-8?B?cWNnNllITU5zb0JVeUhUSlEwME1jaE1xdU11SjdRUkhuMmxsdG95Z2tCa2Fn?=
 =?utf-8?B?VnZSdHowcUpLS0U3eWZpeUR4OVpJTWo4dUI4eUR0YnFVOWR3dGtFNVExdlM1?=
 =?utf-8?B?b1FQVTFjODVFVThodnR1Z0lmL09TYnZ2RU80MVRYbFdmSVJldXlhc2hoWlpY?=
 =?utf-8?B?SE9xY0xQNmpzWHJzY0JjYWlZdEFJUUFMNDZDM0N1NGk1b1dnVDd6Z1B4dThn?=
 =?utf-8?B?VVlzaW1icEZLU3dwN1hHRGNyL2RpN2lKQ0pNYklDSGs3Yll2R1Mxc2hZN1Bk?=
 =?utf-8?B?Vk52OHNVNGNQNWU0SGV1S21LbzIyakl4ZUN0ajNvWmpmWGZURnQ1YU9YUHFE?=
 =?utf-8?B?SXlWV0V2N0FINmR2eDVmV3pMTWNEbC81YUhQMnVQNG5teEZkd2FHNmltVXZ2?=
 =?utf-8?B?N2JIeEFRdnlwdTdJa252Ri9lTlNucTloTGcyUU9VdXpXNG1TZHRxSmZFZzlF?=
 =?utf-8?B?VGV0SGRLaWxLUEVwSEpwdmFUTTQ1OXE1bWZBYTVSbGxSWDNyTTZHU2NpV1Zn?=
 =?utf-8?B?c0NRK3J3aEJ6dXB2bjhDUENKdEgxQTEvWUptcWVOcjdRNEUzWFBEQTVmNmEw?=
 =?utf-8?B?Z0ZOZWY4VkY1bU0ydWRRK05kdXBHQmNxTHk5KzhXS1U3Y3d3ckJhZjFBVmht?=
 =?utf-8?B?NCtJZkVYdGdlOEhKVHlmN0pUa2ZiaTRiVkFhSEJqb1lnSzJ2eXZVUGVGT1BE?=
 =?utf-8?B?Tkc0MmRuU0tXVGQ2TTllV1BPY0s2VloxSkZTWWx4QllDL0FYbVQzYXR6NVl6?=
 =?utf-8?B?NElXMGErNCtubmhGb29CWkNhUENjSHY0b2tPamVOdVZLZnA1TTRRWXd0dnAz?=
 =?utf-8?B?YmpIS2NzbkZVdGhtWmZmeE1lRHE5OE45VTNBQ0JwL3ExK2VtRDFTbGZjUndz?=
 =?utf-8?B?RUo3WUdhc3pHNDYrWHhyaTROMHRuc1dvYnJGS05JQzBCZ1NnNXJ3VDFORkE2?=
 =?utf-8?B?RjNYbUlzZzh3TEV4amE5RUR5MjVldS9rTk5qYjVOVUJScVJwMGtBeXJtd3NX?=
 =?utf-8?B?TjBSSVJTb3VPMFVmeGptK3RZUHNCS2h4ZEJvMUdJQTl3enNnL2NsdzFycTd1?=
 =?utf-8?B?ZUZVcytkNHpPaW1zUmIrd1VDOWhTMjBHdGR3d0VGa1NlTG4yMXJwOU15K0tG?=
 =?utf-8?B?U0xKZk1wMEV1YWh1cGJPZnF6cU8rR2FaYVdFaXh0Mmt4VldLc1NlOVN4Vjdk?=
 =?utf-8?B?NHJ6b2dXRmo2UmIxL2h1ZUdmb0hpankzTElyemRwdGt3WXBMZHlyWHo3Ympj?=
 =?utf-8?B?Q29zaDdud1JrQld4d04vUW9yTVlyZVZ1Z2xyd3A2OVAySFpod1Uyd1hXK256?=
 =?utf-8?B?Z0VMSHRlc0tBbzd0QlZYb2UyekN4d0lnb05YRk5aWjdOaVF6aU1ybmRiNXRY?=
 =?utf-8?B?QWlwWHNwUkgrY2xKNmpXQlRSZWxsa2hSWERiN2VnWkJ0TkVCd0Zvc08yV2J1?=
 =?utf-8?B?UXFrblpNdUgvK1FJeEVXejV2RHgyeGdLaW9hbEUxSW12NWhzQjg4TWlLcTRt?=
 =?utf-8?B?V0NsaVNiTllmTXBkU3U2VHQ5dmhoUk16ZEYxbThpaFZkeVJMY2FVUjRxUWw1?=
 =?utf-8?B?TkpScGJUdG1kNk0rdDRaR3IwN2VId3grQkZmQWxLaVIvZUZXK3NYRUlObHpI?=
 =?utf-8?B?TzVvTHBsSllJdm9DancwRkM3a3FHdHdoS3A0RDlqcWlVUGUrZ28xVXRZczZl?=
 =?utf-8?B?YjA5b1JzZStJaDZIZFFwdENKeXphOStrODZqaWs4RmlSQktZNEtQak5EMFU1?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5798529EC5626741BD027DA93C830940@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb4e0f6-939f-41c6-ad08-08dac797130c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 05:54:49.9620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZcKqou2+j6AxG+mAvL946whSisYLCP2/0M64KZiO3T1ZwfprG9CPnHgLhcyMmg2haXQTlwFxjDei/JgArj740UaYK5j5zg5Xz/MuRSWhSdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6327
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQoNCkZp
eGVkIGluIHBhdGNoIHYzLCBjb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8gcmV2aWV3IGl0IGFnYWlu
Lg0KRm9yIHRoaXMgZmxhZyBvbmx5IGJlIHVzZWQgaW4gSDI2NCwgYWRkIHRoZSBmbGFnIGluIEgy
NjQgaW5zdGFuY2UuDQoNCkJlc3QgUmVnYXJkcywNCll1bmZlaSBEb25nIA0KDQpPbiBNb24sIDIw
MjItMTEtMTQgYXQgMTI6MDggKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3Rl
Og0KPiBJbCAxOC8xMC8yMiAxMzo0MSwgWXVuZmVpIERvbmcgaGEgc2NyaXR0bzoNCj4gPiBTb21l
IGNhdmxjIGJpc3RyZWFtIHdpbGwgZGVjb2RlIGZhaWwgd2hlbiB0aGUgZnJhbWUgc2l6ZSBpcyBz
bWFsbA0KPiA+IHRoYW4NCj4gDQo+IHMvc21hbGwvc21hbGxlci9nDQo+IA0KPiA+IDIwIGJ5dGVz
LiBOZWVkIHRvIGFkZCBwZW5kaW5nIGRhdGEgYXQgdGhlIGVuZCBvZiB0aGUgYml0c3RyZWFtLg0K
PiA+IA0KPiA+IEZvciB0aGUgbWluaW11bSBzaXplIG9mIG1hcHBlZCBtZW1vcnkgaXMgMjU2IGJ5
dGVzKDE2eDE2KSwgYWRkaW5nDQo+ID4gZm91ciBieXRlcyBkYXRhDQo+ID4gd29uJ3QgbGVhZCB0
byBhY2Nlc3MgdW5rbm93biB2aXJ0dWFsIG1lbW9yeS4NCj4gPiANCj4gPiBGaXhlczogNTlmYmE5
ZWVkNWE3ICgibWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IHN1cHBvcnQgc3RhdGVsZXNzDQo+ID4g
SC4yNjQgZGVjb2RpbmcgZm9yIG10ODE5MiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogWXVuZmVpIERv
bmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiBjb21wYXJlZCB3aXRo
IHYxOg0KPiA+IC0gYWRkIGRldGFpbCBjb21tZW50cyBmb3IgZnVuY3Rpb246IHZkZWNfaDI2NF9p
bnNlcnRfc3RhcnRjb2RlLg0KPiA+IC0gcmUtd3JpdGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4gLS0t
DQo+ID4gICAuLi4vdmNvZGVjL3ZkZWMvdmRlY19oMjY0X3JlcV9tdWx0aV9pZi5jICAgICAgfCAz
Mg0KPiA+ICsrKysrKysrKysrKysrKysrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL3ZkZWMvdmRlY19oMjY0X3JlcV9t
dWx0aV9pDQo+ID4gZi5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zj
b2RlYy92ZGVjL3ZkZWNfaDI2NF9yZXFfbXVsdGlfaQ0KPiA+IGYuYw0KPiA+IGluZGV4IDRjYzky
NzAwNjkyYi4uMThlMDQ4NzU1ZDExIDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvdmRlYy92ZGVjX2gyNjRfcmVxX211bHRpX2kNCj4g
PiBmLmMNCj4gPiArKysNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNv
ZGVjL3ZkZWMvdmRlY19oMjY0X3JlcV9tdWx0aV9pDQo+ID4gZi5jDQo+ID4gQEAgLTUzOSw2ICs1
MzksMjkgQEAgc3RhdGljIGludCB2ZGVjX2gyNjRfc2xpY2VfY29yZV9kZWNvZGUoc3RydWN0DQo+
ID4gdmRlY19sYXRfYnVmICpsYXRfYnVmKQ0KPiA+ICAgCXJldHVybiAwOw0KPiA+ICAgfQ0KPiA+
ICAgDQo+ID4gK3N0YXRpYyB2b2lkIHZkZWNfaDI2NF9pbnNlcnRfc3RhcnRjb2RlKHN0cnVjdCBt
dGtfdmNvZGVjX2Rldg0KPiA+ICp2Y29kZWNfZGV2LCB1bnNpZ25lZCBjaGFyICpidWYsDQo+ID4g
KwkJCQkgICAgICAgc2l6ZV90ICpic19zaXplLCBzdHJ1Y3QNCj4gPiBtdGtfaDI2NF9wcHNfcGFy
YW0gKnBwcykNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnZjb2RlY19kZXYt
PnBsYXRfZGV2LT5kZXY7DQo+ID4gKw0KPiA+ICsJLyogTmVlZCB0byBhZGQgcGVuZGluZyBkYXRh
IGF0IHRoZSBlbmQgb2YgYml0c3RyZWFtIHdoZW4gYnNfc3oNCj4gPiBpcyBzbWFsbCB0aGFuDQo+
ID4gKwkgKiAyMCBieXRlcyBmb3IgY2F2bGMgYml0c3RyZWFtLCBvciBsYXQgd2lsbCBkZWNvZGUg
ZmFpbC4gVGhpcw0KPiA+IHBlbmRpbmcgZGF0YSBpcw0KPiA+ICsJICogdXNlZnVsIGZvciBtdDgx
OTIgYW5kIG10ODE5NSBwbGF0Zm9ybS4NCj4gDQo+IFdoYXQgaXMgdGhlIHJlYXNvbiB3aHkgb3Ro
ZXIgU29DcyBkb24ndCBuZWVkIHRoaXM/DQo+IA0KPiA+ICsJICoNCj4gPiArCSAqIGNhdmxjIGJp
dHN0cmVhbSB3aGVuIGVudHJvcHlfY29kaW5nX21vZGVfZmxhZyBpcyBmYWxzZS4NCj4gPiArCSAq
Lw0KPiA+ICsJaWYgKHBwcy0+ZW50cm9weV9jb2RpbmdfbW9kZV9mbGFnIHx8ICpic19zaXplID4g
MjAgfHwNCj4gPiArCSAgICAhKG9mX2RldmljZV9pc19jb21wYXRpYmxlKGRldi0+b2Zfbm9kZSwg
Im1lZGlhdGVrLG10ODE5Mi0NCj4gPiB2Y29kZWMtZGVjIikgfHwNCj4gPiArCSAgICBvZl9kZXZp
Y2VfaXNfY29tcGF0aWJsZShkZXYtPm9mX25vZGUsICJtZWRpYXRlayxtdDgxOTUtDQo+ID4gdmNv
ZGVjLWRlYyIpKSkNCj4gDQo+IEknbSBub3QgY29tZm9ydGFibGUgc2VlaW5nIG9mX2RldmljZV9p
c19jb21wYXRpYmxlLi4uIHRoaXMgbGlzdCB3aWxsDQo+IGdyb3cgd2hlbmV2ZXINCj4gYSBuZXcg
U29DIG5lZWRpbmcgdGhpcyBhcHBlYXJzLg0KPiBQbGVhc2UgdGhpbmsgYWJvdXQgYSBnb29kIG5h
bWUgZm9yIGEgZmxhZy9xdWlyaywgb3IgYSBib29sLCBpbiB0aGUNCj4gcGxhdGZvcm0gZGF0YQ0K
PiBmb3IgdGhlc2UgdHdvIFNvQ3MgYW5kIHVzZSBpdC4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vs
bw0KPiANCj4gDQo=
