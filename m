Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6E64B746
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiLMOXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiLMOXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:23:49 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8319D209A3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:23:42 -0800 (PST)
X-UUID: 48c62f68504744d799386cf80f4d32a3-20221213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5t5upXJEVKmjQUKnksk+mbp4FHD7k0hV1SItK3hVnXA=;
        b=GNQM6iQhKLdigIjLeUZ53bd0Uxsu8BFJjpb3OzBVit+ndD/Zju2qMjaKAj97IvkRuacZyh+UFqst2yO2NI6CGQE98IT2tUYefO8cZCsLwAr412KEgqGT0iwy+mf1Qc/OoVd+M7g3uvOHja53BTgESVNTWw5JJs0UWj+vnKoPEek=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:0d0a5a5a-33b1-48ce-af4b-c0e591c0023f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:ebad2a25-4387-4253-a41d-4f6f2296b154,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 48c62f68504744d799386cf80f4d32a3-20221213
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 689476558; Tue, 13 Dec 2022 22:23:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 13 Dec 2022 22:23:34 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 13 Dec 2022 22:23:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqQClmiRGGXG96Y6RZl/X9qWJUD1fmnbiD5MWSR0Ckyz5zlFouEWTWhD7QrSf25va8S0aQRmbt40zCziJ0j4ryRa7FWv/AQ+SJDLTc77ktA6N9iUAoRypJb8bTRXGQ9Kl2IkUhgE8csOcGe8QdpNWmoaAcU7JYjftyk5HlP4hQoOylK0mip0vYGIjXC5YA5wWHSxd+ccxcSoRysVS9XqjiWN9KUBTkz7NUF/CfTxH7cDJMJuPo3axFkS72ELrB2D+osFB/kmzgstgyFumCCePqlOEzyRkjizgzfwdh/9AOGKktTH1qaslq6yTDA2jyYHTuFM7T5f2GoV5NRdLTCb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t5upXJEVKmjQUKnksk+mbp4FHD7k0hV1SItK3hVnXA=;
 b=dkBBN/MVHVABB3EjyU+AUz+qqG/eKaR0i00HjZSwD7p8Fy6iBg9rWyh42fzt1mRJguVtYUzIxPMsy51Bx2Rvv35Z19ieFssFO5dmJ5r/k89aWzfZQDEP43m+8fxt2eDC8Hx2MshBrUHAdzq1KYOIQEFAEzHgdJfRSV55C2wU4bundX0HMf892jIJlQ7alpzdQ8OWEBR3rHxUNg6/4CdMEeDwVk7c2b1aTArcS+9tnKEUTKoZXB4BlkT8NiChpi4C/8lL4t1V43xVuaBnRuJLR95gg41DQsJLRN4XoBjxyu3kTbGUnxKOhXWQPDSaBBvacJlzJi4W+J8RVpYqOb/RnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t5upXJEVKmjQUKnksk+mbp4FHD7k0hV1SItK3hVnXA=;
 b=cNbhI7Sef9r6XUo6ONBfzuhroWy7mFwi1QbL0IlKW17+xLD2AAF3FqC9zJqYdWM/G8eIY7UF+OTlrh46NDLbZyv5iAtHp1IItkQE3xrgAJ5i2rK+GnkBIAayflMzoh4R0Nybu4bapbCTQ849I3RMGlrQ8Qdvu2S1dThu4opefg4=
Received: from PS1PR03MB3384.apcprd03.prod.outlook.com (2603:1096:803:49::13)
 by PUZPR03MB6886.apcprd03.prod.outlook.com (2603:1096:301:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 14:23:32 +0000
Received: from PS1PR03MB3384.apcprd03.prod.outlook.com
 ([fe80::2e82:cce2:3b26:ab6f]) by PS1PR03MB3384.apcprd03.prod.outlook.com
 ([fe80::2e82:cce2:3b26:ab6f%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 14:23:32 +0000
From:   =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        =?utf-8?B?Q2h1bnh1IExpICjmnY7mmKXml60p?= <Chunxu.Li@mediatek.com>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 1/3] ASoC: hdmi-codec: Add event handler for hdmi TX
Thread-Topic: [PATCH v2 1/3] ASoC: hdmi-codec: Add event handler for hdmi TX
Thread-Index: AQHZALKPLtjy9JnSM0qA0l4xMT7+Dq5PjsoAgATmBQCAAbf+AIAC/qmAgAAE8QCABeevAIAAKsUAgAy4s4A=
Date:   Tue, 13 Dec 2022 14:23:32 +0000
Message-ID: <dc50d0b21795acbcc44c77e5fd81e7cb92c65c67.camel@mediatek.com>
References: <20221125094413.4940-1-jiaxin.yu@mediatek.com>
         <20221125094413.4940-2-jiaxin.yu@mediatek.com>
         <Y4Cysgk5Gic5ae9B@sirena.org.uk>
         <18c82f6f723cd97a9d6b9a7ff16c6ed62fd005d6.camel@mediatek.com>
         <Y4Y/vEWe3dw0FPQH@sirena.org.uk>
         <cf9ea98a3263ffb8fc8b542888ad0ad680facfc7.camel@mediatek.com>
         <Y4jHAJgmz/P58Q/C@sirena.org.uk>
         <7023a2c7b471d6888d9079563a6c01f22599201f.camel@mediatek.com>
         <Y43e+EsNCrCpZSIH@sirena.org.uk>
In-Reply-To: <Y43e+EsNCrCpZSIH@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB3384:EE_|PUZPR03MB6886:EE_
x-ms-office365-filtering-correlation-id: 9433ab08-911a-4628-b998-08dadd159cff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dsn+b5SrYoOSrHQ/Isg5Kgl887FFiODvM9SCtNADbUgWM7AMKzK5j9d9yd8tRaUL3jWiz9JEj2RqVF8juqldDLlWxwpWcibOD9D5cugpVpstWNQv6qHygDEwzspqK/VpRdRpcJZXHyx/BnywjBRtiTaB5vANc1qI/2Yf28F+a7kn5TUNWgsEkbYeIASouGp1TaXdFGBsDWax45+CqjchtONRjVl42mMVZsiLlBinAZyZ86knI83ycuA5XtPgi6zk/i7bFg/l4UzOibNO8sS3e1YvSwnN83idGoG90QVDYVFwf3cSyCfGK3yjMpMVstMXZZN6GZcKr4FvPcri4Y6sCb/VOtQVOLRpWlUi1T8xWeVY9XD9nGoBP4VY/RLpai8oQA4bZQmPpil4KhH5GwB1e6LEl2CSTM+jYET9UpIEafqhLEPhI9XBXo1iUF7nYXoGyr9OcIsEc8p/rM0cEDb/9KBNWiKR0HV4C/kycOG63Km3YapSxzHquHAMZKa+QjYYhH3Mlz5mEM94+Fm9IkMAYeyIOHf7I1nrYBFIxWQHt44rZ/EyoRstD5Y4+K83TVfKN6gsnOCEgSXDIMNRcAU5NRNJbwZslvScp29DMk5SpCkiSRdQopZQJYC5CVpEviw2aIePks4tWrFwYYtl8+J7RZV9LGajZW/2UeyjmafIwicZlsIvI9vC6Nz/nv267uWDTrtKXZWxPOamJKhNJe5pLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB3384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199015)(41300700001)(36756003)(5660300002)(85182001)(38070700005)(7416002)(8936002)(86362001)(6512007)(26005)(71200400001)(478600001)(6486002)(76116006)(54906003)(6506007)(64756008)(91956017)(66946007)(66446008)(8676002)(66556008)(66476007)(4326008)(316002)(6916009)(83380400001)(38100700002)(122000001)(2906002)(2616005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3FQaXQrNzFTclRiMVduR01WZVE1OTBHa2hJbGdmVHppZEcxdDlSSElYYjZq?=
 =?utf-8?B?ak80QUZqaHA0SjlxTFJqUUg4YmppYnZ0VW9QaC8vMjRFaFRvaTl0YjI1RHBM?=
 =?utf-8?B?elVhZkhWS1B2ZVRCYXRXaFV1NUc4T3RJTWkzK2ZMR0J3RVQ5TktOTC90NjdT?=
 =?utf-8?B?WmhRNmpDSGJ2MmxWT1l6ZkpnRGJycWh3MklEd1dDOFlmWUUzSk43L1VQL2pa?=
 =?utf-8?B?NlN0REpwdGp0TjJaczFuSE0zYXdwNzZLQVBqVlk0b0FmWlpMK2JYbjR5c09s?=
 =?utf-8?B?MHdnaGlBWTI1bnkyaXh1KzY4ajZUa2cxZ0VJSE1MYnVNVDVTNnB5S3dCemJh?=
 =?utf-8?B?eGRIU253TWhXY2xMbm1oZEsvS1FMVnBjRStaejUyNXA3aUZnK2pla0x3dlZj?=
 =?utf-8?B?Q2k4a2UybDdjaXp3cWxwWlc3VnRGTTBqQnducUZydDJ1djJuakdUSDlOSUpB?=
 =?utf-8?B?M3FQWjVSR1pqY05PaTROd25FL2RidWlXT2d6YU1vL2dybFNPL1ZQdVVVYXdp?=
 =?utf-8?B?SlNFREoydVZyY3VJYXQyWHBtTkF6d1M2UnRuNVJ4NWt6b08zS3hQa1NPZHV1?=
 =?utf-8?B?RFBNZlJwK0Zja0xYWFM1QXZwLytCY2p0OFlaOGJ1VDVaS0FWUG5yaWFzNHJr?=
 =?utf-8?B?bUlyRkhkV3FWTUxkcElNdjN3NWp3NlpuUXAzV3hmdURPaWp1Z2NhRU5IWFVo?=
 =?utf-8?B?cWhMRXJDL3dETUlraWhBWXZNQ1lDZHJyK3lBbEZxWnh2UjJSUmtqV3lQZDlt?=
 =?utf-8?B?akc2cEVPcmdLZjI0RXBFOFhDak5MMlE3a21zQUJjTzEvMCs2M29mZlFEdWVR?=
 =?utf-8?B?dENMNit0akRLWGNnWHRVOC9RSHd3bjE0MmoxMGJpc2xYZ25lb2d1S1FFZGl4?=
 =?utf-8?B?Q3REc3d3OUVDWHQ5M3VyV2xoS3lYS0JwUS9pc2w2YnpKNWRMVFVGWkdlK2tI?=
 =?utf-8?B?dXpsNVFEZHV6Vm5GQXhGS1pFQXE3cEpMQzY3N0hSa3RXN0xLcG5uaVZLRUNJ?=
 =?utf-8?B?MUJFZmhBb1JRS1h6dXpLa3NWMmVsVGVjeUdXUkxaREdVSVZCQXZaNW5RYXVH?=
 =?utf-8?B?WCtKSU9hbGxQTVlXK1hXL1BFeCszWHlDb3YvT001UWttOUNvU0l0MDFPZ2o2?=
 =?utf-8?B?Z1ZuNm5lZGsremNRT3lMYmFkUnN6SWhpcStyT2N2UmJqM3BsWnRRUnRTREFs?=
 =?utf-8?B?eXlMMWFERlhLUkFrV2hpNGlCSWltNCswN08yejU1ZlJaS202RHRlRksrTXBn?=
 =?utf-8?B?SzY2NEhldytXVHJNMkJ3a1Z0TEw2TThja1RBT3F5MjQ4UXpwSkErVGdDU1Iz?=
 =?utf-8?B?dG1pOG5uWGw5c3pGVFBFU1NkWEs0anNXQUxKSlJmeUcweDVlbkxBU0tpd2N2?=
 =?utf-8?B?VXFjYy90UXdQSUs1cU93OUI3MFNQdmlRZ3BjQzhZMitNUUljWFN2N292U2hV?=
 =?utf-8?B?ZmEvV2htamcxLytxNE5lbElRMFR6aHFtWDllRVRxRWtsUndPbGxqeGRNc2xx?=
 =?utf-8?B?WHhzdDRIeFcrQ3dkT2NzMlVwVlNWRmFiRUxlelA0MGphTlBabmFIV05CaW9T?=
 =?utf-8?B?K1J2U3FPaXJPY0NxKzh2UGszV0E1OEplc3dRQjM4NisrYlpyemZnTW1MKzJY?=
 =?utf-8?B?a1grUmNhSTZoZ1dZZjljWXVhWGg1SUMrd0ZNRHFoSjlNb0Eza3BMdWJvTmxn?=
 =?utf-8?B?UUcwcnYrSGdtNDMrc2dyeHlIOEhHYzNhMWZVZjhyeUdyc3d5YURab2F0MW1L?=
 =?utf-8?B?RDk0TFIwdXJLbitUNmpXdDFjVEtDWjZibDBXczA2YldtT3krMHNtZ2U5Tjkx?=
 =?utf-8?B?Z2JKS1F2WHdoVCtDRGpJVnJtR2tlMXg5Q0xSUm5XenBBb1FsWk1iditzbU8v?=
 =?utf-8?B?ODQ3UWphc3ZjbU5vNk5QeTZ0MFB1WStWcEc0Z1hJKzhOMFMrTkhwb0l4Vk9s?=
 =?utf-8?B?cmR6b2I4NUlHeWJoQ2JqNC9FQnBBT1FGeVlWdzRLOXRIQ280V0l1NWpCVDc5?=
 =?utf-8?B?V2xZYVhheEhMVXdPUmxWM2hmWmtERTBWTFMyMHdYdHpXQm04VFhaeWsyMEpN?=
 =?utf-8?B?VDdBZW83VTNrTkFPakhzdmx2dS9vbVdCU2JxSGpGZVNGek1FL2VjdGlRbDU3?=
 =?utf-8?B?cERQZ0VjWG5kSGxvK216ZjZqV01PZjU2N3ZncTRWZVl2b1ZHY2hSWTE4NDNS?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E896478E124A2C4E8EF51690A6EA8C90@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB3384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9433ab08-911a-4628-b998-08dadd159cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 14:23:32.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVkPx/SvT6WfTEexcN91irfV/088MTAUC/qmaO9vYnP9UQNmTiSfp1Mhlp8g6rD+6SzS1hNm7fZOaYhIkdwBSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEyLTA1IGF0IDEyOjA3ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBNb24sIERlYyAwNSwgMjAyMiBhdCAwOTozNDoxN0FNICswMDAwLCBKaWF4aW4gWXUgKOS/nuWu
tumRqykgd3JvdGU6DQo+IA0KPiA+IDEuIEkgaGF2ZSBhZGRlZCBhIERBUE0gd2lkZ2V0IHRoYXQg
aXMgIlNEQiIsIHdoZW4gd2Ugb3BlbiBvciBjbG9zZQ0KPiA+IEhETUkNCj4gPiBQSU5fU1dJVENI
LCB0aGUgY2FsbGJhY2sgJ2hkbWlfdHhfZXZlbnQnIHJlZ2lzdGVyZWQgaW4gdGhlIHdpZGdldA0K
PiA+IHdpbGwNCj4gPiBiZSB0cmlnZ2VyZWQuIE1heWJlIHlvdSBtZWFuIEkgc2hvdWxkbid0IHVz
ZQ0KPiA+IFNORFJWX1BDTV9UUklHR0VSX1NUQVJUDQo+ID4gYW5kIFNORFJWX1BDTV9UUklHR0VS
X1NUT1A/DQo+IA0KPiBObywgSSBtZWFuIHRoYXQgaWYgeW91IHdhbnQgdG8gY29udHJvbCB0aGUg
ZW5hYmxlIGFuZCBkaXNhYmxlIG9mIHRoZQ0KPiBvdXRwdXQgcGF0aCB5b3Ugc2hvdWxkIGltcGxl
bWVudCBhIERBUE0gd2lkZ2V0Lg0KPiANCk1heSBJIGFzayB3aGljaCBkcml2ZXIgZmlsZSB0byBh
ZGQgYSBuZXcgREFQTSB3aWRnZXQ/IElzIGl0IHRoZSBicmlkZ2UNCmljIGRyaXZlciBsaWtlIGl0
NjUwNS5jPyBPciBpcyBpdCBsaW5rZSB0aGUgIlNEQiIgYWRkZWQgaW4gdGhpcyBwYXRjaD8NCg0K
PiA+IDIuIElmIEkgZG9uJ3QgdXNlIGhjZC5vcHMtPnRyaWdnZXIgbm90aWZpZXMgdGhlIGJyaWRn
ZSBpYyBkcml2ZXIgdG8NCj4gPiBzd2l0Y2ggdGhlIGF1ZGlvLCB3aGljaCBvcHMgc2hvdWxkIEkg
dXNlPw0KPiA+IEkgYWN0dWFsbHkgd2FudCB0byBrbm93IGhkbWktY29kZWMuYyBhbmQgaXQ2NTA1
LmMgZXhjZXB0DQo+ID4gaGRtaV9jb2RlY19vcHMsIGlzIHRoZXJlIGFueSBvdGhlciB3YXkgdG8g
Y29tbXVuaWNhdGU/DQo+IA0KPiBMaWtlIEkgc2FpZCB5b3Ugc2hvdWxkIHVzZSB0aGUgZXZlbnQg
b24gdGhlIERBUE0gd2lkZ2V0LiAgVGhpcyB3aWxsDQo+IHJlcXVpcmUgcHJvdmlkaW5nIG9wZXJh
dGlvbnMgZm9yIHRoZSBldmVudHMgdG8gdGhlIGRyaXZlcnMuDQpZZXMsIEkgc2hvdWxkIGFkZCBh
IG5ldyBzZXQgb2YgZXZlbnRzLCBzdWNoIGFzOg0KDQplbnVtIHsNCiAgICBIRE1JX0NPREVDX1RS
SUdHRVJfRVZFTlRfU1RPUCwNCiAgICBIRE1JX0NPREVDX1RSSUdHRVJfRVZFTlRfU1RBUlQsDQog
ICAgSERNSV9DT0RFQ19UUklHR0VSX0VWRU5UX1NVU1BFTkQsDQogICAgSERNSV9DT0RFQ19UUklH
R0VSX0VWRU5UX1JFU1VNRSwNCn0NCg0KVGhlbiBwcm92aWRlIGhhbmRsZXMgZm9yIHRoZXNlIGV2
ZW50cyBpbiB0aGUgaXQ2NTA1IGRyaXZlci4gQW0gSSByaWdodD8NCg0KDQpUaGFua3MsDQpKaWF4
aW4uWXUNCg==
