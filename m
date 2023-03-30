Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36AC6CF8D5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjC3BsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC3BsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:48:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E796230D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:48:15 -0700 (PDT)
X-UUID: ed3f9718ce9c11edb6b9f13eb10bd0fe-20230330
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=O718QuwDdGD7g3+tvqJx5TS8WXT0UvWOQrkuA+/Hg4Y=;
        b=j7tXGVuZjv8LFnO2+k8ZWyACmVAv5E5JPoVPCU2QM7MiOKLa+gMhHW1QHy2e22fI7ObVbJX0dDmVWuZ/BNqih3pWNtxBuu2V7Nj0+vrUdT4BqcOn8ucNTDDC0GTltNZSaRkDNbp47dx+FwBKCJ5aBpn6vI/zeGHJo+oRR65/Iek=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:e3d19f4f-d61f-4bed-85f0-8065db9f0240,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.22,REQID:e3d19f4f-d61f-4bed-85f0-8065db9f0240,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:120426c,CLOUDID:27e8c8b4-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230329161527950RABSD,BulkQuantity:21,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: ed3f9718ce9c11edb6b9f13eb10bd0fe-20230330
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1722015781; Thu, 30 Mar 2023 09:48:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 30 Mar 2023 09:48:09 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 30 Mar 2023 09:48:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV5MWi3TMaC7MFfMtEobV7R2hz/EemJGTg1Gj2raD+A8J/kg/flUK2rYFkKoYise5+aQIRP0s5ViVJxGTpkIpOADfftutlr6EeewgG8Y7quh2UDzZhH8LNxZs27DpqZv3X6jxBC8SfhijifF8TnSCpViSqVzwfodzZy6pL8ZrpnRJDffprMfFL/AmqrCJQRaVc0J1Occ0GX7Z0jarfi/1eyEIGT7EKgqYbl+9PlcYsPd4u16Vlkzx36zgyXSpLyD5L96XIVkwnlIbmGiIw7Dm5eFeIDnAYcbe8xE3kLPpSJepQjNmcAqGoga0C5qe62iYoCldKrsNvrU2ccCLgZrug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O718QuwDdGD7g3+tvqJx5TS8WXT0UvWOQrkuA+/Hg4Y=;
 b=aAv8H2dPjbwSMFXYhzTcgv2stBnIOHClEhCEPyMEkfLwZrHPkAAJFdES8dQe4FRKh650b1vXcfdpPl/RYs9kWv+lvLYE+VGHbZdnNevnqJHAYmhuFCs9dL0aUnA0tAcmhBfrIT6g5e2bsw7Q6dzcRieHy3jkKQocglwCIq1SRFsa0jn39Omz1dQJY87gWhsWfmQKwpD3JkYSEJPo4C95Hmz+QFCGduYYTjbUdZLnknLgpXwz2PbEtLZWeaDY2msswrSX3ilXgRiwkrnro9rYxrYRgr6SoibuTeJwQVkBazPdI8/rwFUU4aU28DUAqJGstC42/P+mRcZJ4r6CIrAy/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O718QuwDdGD7g3+tvqJx5TS8WXT0UvWOQrkuA+/Hg4Y=;
 b=vKT2YqL8jPaMnaKDE4JcE3Y2qAWWazJgGke54zSQEuOsg9gLq7JeVaTrU3fEMg9Yd5U4oWUSSwv+FdW5Pc7YrodZkm+cZ/nZ7rwgOU0xGna3KpGbikuRWk4LaYvXXOKQOmovfdkTx2gYBqSGK54B/295vBKpZQkqI0qlukZJcMM=
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com (2603:1096:820:8::11)
 by SI2PR03MB6661.apcprd03.prod.outlook.com (2603:1096:4:1e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.34; Thu, 30 Mar
 2023 01:48:04 +0000
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::597c:4d5f:dec6:a362]) by KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::597c:4d5f:dec6:a362%7]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 01:48:04 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] drm/mediatek: Add ovl_adaptor get format function
Thread-Topic: [PATCH v2] drm/mediatek: Add ovl_adaptor get format function
Thread-Index: AQHZYeIpXkYQYJmhbUKp9fmC80UAga8RaXIAgAEmHoA=
Date:   Thu, 30 Mar 2023 01:48:04 +0000
Message-ID: <516871854ecb827e2fa359c0584ab2c470df3a4f.camel@mediatek.com>
References: <20230329015916.21684-1-nancy.lin@mediatek.com>
         <ceb353983d48c5a0a967de7ea256dbe6a5de6bed.camel@mediatek.com>
In-Reply-To: <ceb353983d48c5a0a967de7ea256dbe6a5de6bed.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5175:EE_|SI2PR03MB6661:EE_
x-ms-office365-filtering-correlation-id: dd4fb6e6-0845-43f3-b636-08db30c0cdae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cGOZxfj+1gyQGyMEdqg1kpKLeMpPayFvZcqS99+9YHeSkfMyf+GnSkaWxWPuwwsoEo6YH/2AO5eQqN6aMk3/c+o9efc8nZGdF/FDGBFP09DDR5gtuucbo88ul0md4BTF8JIxyLPEUbrQnEEyxGmnZx8fEjapwMBujEXQz95KCb7Le+I1WcGcL+RuiCcJ6cUmC7FFQIlG0wg9xSwgfKx9v13MU1+sUe0Z5MB8dnUUHTpdANyb1K5zJWC1C0dN2LOccychwd1+QB6i6600QWSMufD46w8/pRz/kfEyQWZbSQkb1f6IOx5z5IJI0Dw1tNUGRnpqEUlTc9JoJI07guQTOQpPEnV3hwXFC2aATlIp2/5C2hjwmnK3N9+hvd9Xq9HUzRIQMhSm3pj3x88W9ard2xeQTfZh6iQ6ycqdS2EvanQpz/71xX0EgmXPCzOCwmAL4J9KqhrUCAMqTYlZHuwWpkctAKC/09nmTqoNncEELBdT4NyDq6UGsifKo5nUZvn5Iw9UEPuvEHNfso0BFYPCgJ4oZI9LX64xECVbb1yFFFfQC+5KE4k/pTkLWoSi3KKiYSwTHc5nHQVWHtnMe187wK8HIBnIrV3m3ttfRAMGjgYu+GRaz5UV91yKbCX19nn/5hFjW9okOSSLvfXfljCx3C3dikuO0hgT1pB0QjTlKpY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5175.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(122000001)(64756008)(41300700001)(8936002)(4326008)(2906002)(38070700005)(38100700002)(5660300002)(26005)(6512007)(6506007)(6486002)(2616005)(85182001)(36756003)(186003)(110136005)(76116006)(66556008)(66476007)(91956017)(8676002)(66446008)(66946007)(316002)(86362001)(71200400001)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU9WdVpuRXFYQk5NenkreEU2cStpN2NJVWs1ZFFJR1RoRXJFanVkdXNaRWd1?=
 =?utf-8?B?MWtFdng3aDVSOVE5bVRxL2ZIeHBxS2U1MzNRelpTbnJwRzErMWtrRHpLc1lM?=
 =?utf-8?B?SU12RURQc2JnMWhiR2ZFMDVGaHhBOTdCbXF2KzNtTGJHeStaOGlNSzNLNktz?=
 =?utf-8?B?dFltdTA5dk92ZXpNTTFuSmV2VGkxR1pjeU9EaTl5VDlXUGs3UEN3VjhLK1JH?=
 =?utf-8?B?WlUzYnJaSXJzVEtYU2p6QTI1K3NSR25EV00rMG1kL3F1KzI4WEFQc2E2c1BQ?=
 =?utf-8?B?Myt4KzliRThkZzk3Z2xoU1VwYVpCSjZZQmN2aWY4WndtTW5ZTUl0RGFXWWpu?=
 =?utf-8?B?UzdNTHhFNUdlOWUxN2tQOFBZYlcxQzJVS3BteXF3SjM4ak1Ga0tLZTArVzhs?=
 =?utf-8?B?Y2F6SzVlY213eVNnRnRhR3Qzekc5RzBQWFdGd3g3Vzl2UGxrSDMxS2xjbWhj?=
 =?utf-8?B?Q0RMZWtuUmt0bE12MjFnT3d4VGVDbFhrZGpVd1c3d2Y0RnBUSVJZSlVCaUlL?=
 =?utf-8?B?M1NiNjBYak4wSkM2bXg3VklzZWR5V21URUdmYVRFd2lRUzFKRGR5eEVJeUF4?=
 =?utf-8?B?RFlqaU5MUjN2RGo5cVpDOEVXMm5oUXFmL3VKc0o1a3BhNTZHTzJLcFB6NExp?=
 =?utf-8?B?N1ZDRXhsWmlDOEZMbFFGUThtbGVjZEpmaXZJN2duTDByZUFvcS9oUDNSVDk1?=
 =?utf-8?B?WEkrVHhqaVNKeDNmSFVHeTdNVFVKM0lMYWE0ZlZmVnpKalRTQ1hWZ0ExWEti?=
 =?utf-8?B?OHBKaFMwR1VUSEJySUR5WmtFbFo4UFJLbHlUVmo2TnIzN20vc1FHM08yMXJR?=
 =?utf-8?B?eFpHRTBreFpIZGgxT25HOTBaRjBDTkhRVUV3WVZSNy9TcmhXZzBMZkNYWFFz?=
 =?utf-8?B?TXdTalBBVTRZWnlQeDIzQVRaTTJjNUJyNURiaUUyL1hZMjdCWHJ0RVk3ZTJN?=
 =?utf-8?B?T1BVL3JCUXovZkwrbnYyeVg2MkRoTUU0dXkxOXUycFNrM2EwbWN1Q2l3MDlG?=
 =?utf-8?B?M01wY1B3RFpIMHVLaUFiSThYRWdHWlZBN1FnbWQxZEtZVmJYWGNibG1XK2pJ?=
 =?utf-8?B?NEZyaTlmMEpSTXlDU003YWdTcjJUZlNFUXlyNzQwZndtVTdvNXk2ZTMyVlE5?=
 =?utf-8?B?YVdydVVzWllZTnZISVE4QkRiT3c0RkR6Wm1sVDBjUjErbVJucVg1NWp5WmtM?=
 =?utf-8?B?YkNpdU9DQzNHcTZEVVU2ai9BcnpBQmx3NUNpenUxT3liNHhlZzBXeEpWSHRI?=
 =?utf-8?B?cHlTZUFzT25xcEtGM1JUMWNoSUNyN3dDQU9Id01LTnZXN2RmOHRNUjNPQXhq?=
 =?utf-8?B?WS9GQVRqbmdLbGhlU3BNQk1tb2pJWEQyMjBPWS9MNDRjcnpkeG9oWDFEVzhD?=
 =?utf-8?B?OG5sUHpUSFMzWVZMdEsyWDVyTTM5UTVTNW01NkxLREgzNDA4QlJCSi9uem4x?=
 =?utf-8?B?Q3NqUTdMSWh3ZTVyelVLMi80TXVYdnpVS3ppM3JaZ1owaEdoeEQxVlVnSnRo?=
 =?utf-8?B?dFl3c2JTYzBjYVROdGNvaFdvRDJORHpvRU9pRXc3Y291UFRZWmV3T285SHZI?=
 =?utf-8?B?WDFSNDFlK0Q0QjNnMExScmJsV2NqdVJZY3lpNWJVSktxRVBrOE01QmFmRS8z?=
 =?utf-8?B?eU1hajdZVmtzVXk0ODJZUi9yWEFaYVRWWUdITDdzZXNxbmwySnBPWDliVkRW?=
 =?utf-8?B?NFJVWjQvTjUvWVRwb2ZJbEsxdmdWNlFSczJSblFEUk14d2pGaktaOGZCVzZU?=
 =?utf-8?B?VW5BL09xY2FWeE5JNXpERWlmTEJPV05mSlhaMFBuOGx6WEtOVlBPNERPS1Bh?=
 =?utf-8?B?dno2MEkrVmRHeUlJZ2NtMEVkM0FRd3BwbU9GbkNHeVdhREI5dlBVN2xmSmtq?=
 =?utf-8?B?eWhleXVMTklTTmN2d3RpdEd1dHVhZ0dvSmtZeG1aRk85UTV4aXBhRGo4N1E1?=
 =?utf-8?B?cTFnR2IvcHhaZENLSVMyeUthclVXcGJlVlJRTTQvUEUrclI5TGZDdkwwcFdX?=
 =?utf-8?B?TmpDd29yQWNKMjF5eXorVkUvRG02aUFhbUlSaDhWTmVlODFoTkdsRUZ3dXFw?=
 =?utf-8?B?Q0pkQmQrb08xMHJlYWZVNGR5K0p0UHhDRzdTbEdwM3lrbEVKR0hNNm50T0lG?=
 =?utf-8?B?eTVNMGFyVWZoaTlmQnQ1bFJpL3BsdVVZcTRnMDNOQVZjZ1V0VFhoaFZRd1o3?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD3B792BF2CB5C4E8A82251893B49EFE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5175.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4fb6e6-0845-43f3-b636-08db30c0cdae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 01:48:04.5493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Av/Zfv239q6vPA8a326o2LYzl/bakHog1Ted0m+IeuhBFgRXQpLT+OvOS6UVm4vdD344opDKB0Wp1lX1sJ29zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6661
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KT24gV2VkLCAyMDIzLTAzLTI5IGF0
IDA4OjE1ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gSGksIE5hbmN5Og0KPiAN
Cj4gT24gV2VkLCAyMDIzLTAzLTI5IGF0IDA5OjU5ICswODAwLCBOYW5jeS5MaW4gd3JvdGU6DQo+
ID4gQWRkIG92bF9hZGFwdG9yIGdldF9mb3JtYXQgYW5kIGdldF9udW1fZm9ybWF0cyBjb21wb25l
bnQgZnVuY3Rpb24uDQo+ID4gVGhlIHR3byBmdW5jdGlvbnMgYXJlIG5lZWQgZm9yIGdldHRpbmcg
dGhlIHN1cHBvcnRlZCBmb3JtYXQgaW4NCj4gPiBtdGtfcGxhbmVfaW5pdCgpLg0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IE5hbmN5LkxpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICAgIHwg
IDIgKysNCj4gPiAgLi4uL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyAg
IHwgMjQNCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcF9jb21wLmMgICB8ICAyICsrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwg
MjggaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9kcnYuaA0KPiA+IGluZGV4IDBkMjhiMmUyMDY5Yy4uZGEyZGUxN2I4NGU5IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiA+IEBAIC0x
MjQsNiArMTI0LDggQEAgdm9pZCBtdGtfb3ZsX2FkYXB0b3Jfc3RhcnQoc3RydWN0IGRldmljZSAq
ZGV2KTsNCj4gPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3Jfc3RvcChzdHJ1Y3QgZGV2aWNlICpkZXYp
Ow0KPiA+ICB1bnNpZ25lZCBpbnQgbXRrX292bF9hZGFwdG9yX2xheWVyX25yKHN0cnVjdCBkZXZp
Y2UgKmRldik7DQo+ID4gIHN0cnVjdCBkZXZpY2UgKm10a19vdmxfYWRhcHRvcl9kbWFfZGV2X2dl
dChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICtjb25zdCB1MzIgKm10a19vdmxfYWRhcHRvcl9n
ZXRfZm9ybWF0cyhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICtzaXplX3QgbXRrX292bF9hZGFw
dG9yX2dldF9udW1fZm9ybWF0cyhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICANCj4gPiAgdm9p
ZCBtdGtfcmRtYV9ieXBhc3Nfc2hhZG93KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gIGludCBt
dGtfcmRtYV9jbGtfZW5hYmxlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiA+IGluZGV4
IDA0NjIxNzgyOGFiMy4uYjVkMjhjMzkyYzU3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gPiBAQCAtMjUsNiArMjUs
MjAgQEANCj4gPiAgI2RlZmluZSBNVEtfT1ZMX0FEQVBUT1JfUkRNQV9NQVhfV0lEVEggMTkyMA0K
PiA+ICAjZGVmaW5lIE1US19PVkxfQURBUFRPUl9MQVlFUl9OVU0gNA0KPiA+ICANCj4gPiArc3Rh
dGljIGNvbnN0IHUzMiBmb3JtYXRzW10gPSB7DQo+ID4gKwlEUk1fRk9STUFUX1hSR0I4ODg4LA0K
PiA+ICsJRFJNX0ZPUk1BVF9BUkdCODg4OCwNCj4gPiArCURSTV9GT1JNQVRfQkdSWDg4ODgsDQo+
ID4gKwlEUk1fRk9STUFUX0JHUkE4ODg4LA0KPiA+ICsJRFJNX0ZPUk1BVF9BQkdSODg4OCwNCj4g
PiArCURSTV9GT1JNQVRfWEJHUjg4ODgsDQo+ID4gKwlEUk1fRk9STUFUX1JHQjg4OCwNCj4gPiAr
CURSTV9GT1JNQVRfQkdSODg4LA0KPiA+ICsJRFJNX0ZPUk1BVF9SR0I1NjUsDQo+ID4gKwlEUk1f
Rk9STUFUX1VZVlksDQo+ID4gKwlEUk1fRk9STUFUX1lVWVYsDQo+ID4gK307DQo+ID4gKw0KPiA+
ICBlbnVtIG10a19vdmxfYWRhcHRvcl9jb21wX3R5cGUgew0KPiA+ICAJT1ZMX0FEQVBUT1JfVFlQ
RV9SRE1BID0gMCwNCj4gPiAgCU9WTF9BREFQVE9SX1RZUEVfTUVSR0UsDQo+ID4gQEAgLTI5Nyw2
ICszMTEsMTYgQEAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfZGlzYWJsZV92Ymxhbmsoc3RydWN0DQo+
ID4gZGV2aWNlICpkZXYpDQo+ID4gIAltdGtfZXRoZHJfZGlzYWJsZV92Ymxhbmsob3ZsX2FkYXB0
b3ItDQo+ID4gPiBvdmxfYWRhcHRvcl9jb21wW09WTF9BREFQVE9SX0VUSERSMF0pOw0KPiA+IA0K
PiA+ICB9DQo+ID4gIA0KPiA+ICtjb25zdCB1MzIgKm10a19vdmxfYWRhcHRvcl9nZXRfZm9ybWF0
cyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gK3sNCj4gPiArCXJldHVybiBmb3JtYXRzOw0KPiAN
Cj4gVGhlIHN1cHBvcnRlZCBmb3JtYXRzIGRlcGVuZCBvbiB0aGUgbWRwLXJkbWEgaGFyZHdhcmUg
Y2FwYWJpbGl0eSwgc28NCj4gZ2V0IGZvcm1hdHMgZnJvbSBtZHAtcmRtYSBkcml2ZXIuDQo+IA0K
PiBSZWdhcmRzLA0KPiBDSw0KPiANCk9LLCBJIHdpbGwgYWRkIG1kcC1yZG1hIHN1cHBvcnRlZCBm
b3JtYXQgYXBpIGZvciBvdmxfYWRhcHRvci4NCg0KUmVnYXJkcywNCk5hbmN5DQoNCj4gPiArfQ0K
PiA+ICsNCj4gPiArc2l6ZV90IG10a19vdmxfYWRhcHRvcl9nZXRfbnVtX2Zvcm1hdHMoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4gQVJSQVlfU0laRShmb3JtYXRzKTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfYWRkX2NvbXAoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgbXRrX211dGV4DQo+ID4gKm11dGV4KQ0KPiA+ICB7DQo+ID4g
IAltdGtfbXV0ZXhfYWRkX2NvbXAobXV0ZXgsIEREUF9DT01QT05FTlRfTURQX1JETUEwKTsNCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAu
Yw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiA+
IGluZGV4IDFhMGM0ZjdlMzUyYS4uZjExNGRhNGQzNmE5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ID4gQEAgLTQxMCw2ICs0MTAs
OCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcw0KPiA+IGRkcF9vdmxf
YWRhcHRvciA9IHsNCj4gPiAgCS5kaXNjb25uZWN0ID0gbXRrX292bF9hZGFwdG9yX2Rpc2Nvbm5l
Y3QsDQo+ID4gIAkuYWRkID0gbXRrX292bF9hZGFwdG9yX2FkZF9jb21wLA0KPiA+ICAJLnJlbW92
ZSA9IG10a19vdmxfYWRhcHRvcl9yZW1vdmVfY29tcCwNCj4gPiArCS5nZXRfZm9ybWF0cyA9IG10
a19vdmxfYWRhcHRvcl9nZXRfZm9ybWF0cywNCj4gPiArCS5nZXRfbnVtX2Zvcm1hdHMgPSBtdGtf
b3ZsX2FkYXB0b3JfZ2V0X251bV9mb3JtYXRzLA0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgc3RhdGlj
IGNvbnN0IGNoYXIgKiBjb25zdCBtdGtfZGRwX2NvbXBfc3RlbVtNVEtfRERQX0NPTVBfVFlQRV9N
QVhdDQo+ID4gPQ0KPiA+IHsNCg==
