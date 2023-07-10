Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0053174CAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGJECh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjGJECb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:02:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578D4E0
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 21:02:28 -0700 (PDT)
X-UUID: 92dc081c1ed611eeb20a276fd37b9834-20230710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9PU36NOryvmkjEFHEjViOFMRV+RBSvhT8r3XIxeAhyU=;
        b=Lmsf71s6hi+CkepiYOzWG23VKF+sopR3rJ+c8qsmio5CT1C1cfQHCWuaIJgPWLeCJFtMjHQsFN1En4XJE+vKbrzIH6q0GW2zcN+Cf16J+sHoMy+l7aoWtm4LJzJqVkd9Sa9lp4X5sNV/2tASGrzQAbLuhC3kgWrQZlYiKbGgvAU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:6521b745-2109-4a66-b01f-82d3cada29d9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:52d5bf0d-26a8-467f-b838-f99719a9c083,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 92dc081c1ed611eeb20a276fd37b9834-20230710
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1549602805; Mon, 10 Jul 2023 12:02:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 10 Jul 2023 12:02:21 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 10 Jul 2023 12:02:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VetrbVNgkSKTIN157YWh6lJTfhim+2yiDUC4QfSZVUxayINxSJxqqreMHlGSovOeoZfnyl/jlU+FsHJdYCCtKD1pNTpdh1QT1oPrQtLC7CFLaVbQCpJEB/tQl5UGJu+6KS7o3eEVc+ZfPszCHqkRFb3vc+TniO2NHpHuV4ZH9wvqL/9p3D8TuTQt2x2GBKtbT4KUoaHAMSoomQ++cHUEI2H6Ggnban3YyF/GVP+dM2yOFrDaJR1GQJvk6P9SGVcsjULdxGN2H9sQwLg+k7GyJtQqwOD6nMutV1o3IpgJHSir8V92eoZqQXU4k5Jk7LdNnoZd8qfaQlxDcoCFiLliGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PU36NOryvmkjEFHEjViOFMRV+RBSvhT8r3XIxeAhyU=;
 b=L5nRHpIS7Q/bCOg0WlLpRouCnRLPtGruD/8XWUkIfJcyKv0NcIoV4iy/uCfozA9JWusa2EDKN+wKD0iONW2z2Ml50j/KQKgrt/pBgx6dXY2ZU6rpTJBYsbToE67oIFc8sUBpukq7yoUXnA3+GVoEButrBrzMz2y6zl1UmhZUOBt5UkiDaU4OJplPkm30iOFG+ZyeCl4D8RG8fBSwo4XwLE3VWBdkmlOazIQxYvqZypxMWYPLhrAGbHaIPJRbpAbKdPkjAnRJbHWEoGQkwtWuUknZ/Y8gVF7BjEG5r2SpElejGF5EnNsbzHXHddQRpYSSXla+ZmFp4iESLFBSxrVIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PU36NOryvmkjEFHEjViOFMRV+RBSvhT8r3XIxeAhyU=;
 b=oaZ97RfHZV5R7C7As7z1xQaJ6Al1FnIe6ZTjoVueGYlxk8oX6RPTyOXLys/71fQHr5Vzg+brkrxYVanVtxTRkdJSQw7XbToBs80XMt2oS69Er4Ai2zEp2dd8Ep9fzb5ilWCtdwoA8w92eZ+ruSgLCfndWbtJRS5MhmKced6xajU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB6351.apcprd03.prod.outlook.com (2603:1096:820:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 04:01:18 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%7]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 04:01:18 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 1/4] drm/mediatek: Remove freeing not dynamic allocated
 memory
Thread-Topic: [PATCH v3 1/4] drm/mediatek: Remove freeing not dynamic
 allocated memory
Thread-Index: AQHZpCqL0czFKxm54kOPVf+AKUJ3M6+yfgWA
Date:   Mon, 10 Jul 2023 04:01:18 +0000
Message-ID: <b1eea510c6878f8ce37019e32986fcb4b458ff66.camel@mediatek.com>
References: <20230621102247.10116-1-jason-jh.lin@mediatek.com>
         <20230621102247.10116-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20230621102247.10116-2-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB6351:EE_
x-ms-office365-filtering-correlation-id: 21f210f1-184f-48de-1db3-08db80fa509d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y7JT08HoTW+P3Brlxxoal3wm1rKN9kuHifXm9arJ4aqpSl8Fsw7D1qk0TvfFlQkUpIo3ozuhnC/HyGd3JAvbxPYwufaq/7F0Lt8EjjvDtwSgX90bzd+ECrmUOU5aHTnxJ5LEhp7DmxsP+XtIw7QU4j91BWxQrPZEkOPJYRhD8xQoEx9vuIloJJj6AbGIqkO3U9ZHGd6BqxwgzcTw4h07yMDKy7aDzxJBGWL33SpJFjrGIyIsSoC5gB2iYn9jKVRyvUZjnTegA+Rt0rLJD7Ar56XuiCqdO+n8zjjmwJ6lGUbLAyhrhjkG3kzyHZC1yG1zTHaPyeLLAGsR0ALeiDRZML8VTdRGOfZhaQ4NWvUzex79kENIZkT/+ntUHAFrlHLGDxC6kN9XFe69msuZJkFMNRy/lhs6QQKI9xLvIV02PqOzxqxE/WFXYkeoUZYSkgijUfepW1tus9ujm4goBfoNOhY2eJpf3I0qiuzXtANbyYXoMD8pcabiifdh6ovmv99rIiguvxdxu2zPAT6QGuglrINQFAfVL1oC0rB/KobcUzs+KIq7b4WLyaNW6eGm5kli3NxFxWS95fQAgimycQL6nnCMKA6CRkvGGaMUO7dBZEIIlmPrcojcjcQxO8ciCLKMqeaBLIM7FxyDoNGmuIivB14QkjLR18AuVR2zEDwacZs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(86362001)(38100700002)(38070700005)(36756003)(85182001)(71200400001)(6486002)(110136005)(54906003)(76116006)(122000001)(6506007)(186003)(26005)(6512007)(2616005)(5660300002)(316002)(2906002)(66556008)(478600001)(66946007)(8676002)(8936002)(83380400001)(4326008)(64756008)(66446008)(66476007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ny9wZHlVMDhDd092UjFjVVprL3VIci91aWNFSnhpb3g5YU9WZzFWTk4xZkNv?=
 =?utf-8?B?eTVlSVBTSi9rL01rdjhUaFFQM1dzK21Gd2tTQkJXcUQrUTA0NDFiS2JjaDFj?=
 =?utf-8?B?RHJzUllqUXhhendwMjJBbmx2K2JOMksrcDlkc2FRT2lXNWVGSGpxYUluYVQv?=
 =?utf-8?B?SW54MG93SGRDM1NhRkNVbDFTTGFjYzhFK2hvaUNiYnVOTkpnM0M3Z1hzdDgr?=
 =?utf-8?B?K2dWMW1XazNUWXZsVDg3NGI0bW9lNkhzUXptbmFNUWJCcHEySFlZQUJkM0xr?=
 =?utf-8?B?WDM2d2hnN1J5MFpZRFJ2RktNMXA5OUpSSEpySjNZRlp6K0Nya21STW9zT2VD?=
 =?utf-8?B?Y2JvWS90WGZxQzVLbzRaREFsbGs4TWREZHVJR3lRK3kxV0NWZ2pqVEZZR3RX?=
 =?utf-8?B?T3BIdFYxRmZ4VEJGanduYndDcE5wTzE0ZisxTjdMS1RrN0I4Q1BtcVl3eHIy?=
 =?utf-8?B?elNobTVOZVNHdnh2R09peXc0NDRETUVHS3hzSEY5WXF6dVNmVVZZVUVuZy9Z?=
 =?utf-8?B?MVNwOHkvRHRUUGYwN1FScGFDZ1JzcFF3R0U0TTJxNjhqMHo5R2VmM20wb0RN?=
 =?utf-8?B?S3ZyNFBpYnIvcS8vK2hLVUt5L052RCtYdmU2Y1A1UE9Pem1rSmZQWkN2VkJL?=
 =?utf-8?B?SEwxL09kbnpJUVUxOVc5a0x0UUNBandpNkxQSVBSUFVySTZ6NnluVHhleERU?=
 =?utf-8?B?MWpoVnA5TjQySFFNcXMzdDcxZWVqQ2s4d2p6Q0w5ZnA4UVhkS2Rlc1lMUG5Q?=
 =?utf-8?B?dERzSmxkemdsZUVSbndCM1hJdERYVU83blNaWHpxYlErMXp1a2tXYktMN2tZ?=
 =?utf-8?B?ZmU5S05CZHRUMWpMWm1teDByTW9xRUlJRWdnM2kwZGtBcEhpQVVpaHBVK3Rz?=
 =?utf-8?B?aWk2U21JdkswMStBQ2JPZjJ2NUJLZVVUN3p5b3QvYkpqdUk2V1Nadno4YTZR?=
 =?utf-8?B?L3BMTm80dlhiOVFJeWFDQUR3Kys0NzVVWGRlN2JuOXNYWGRCWGhIU3hYS3F5?=
 =?utf-8?B?NXUydjJ5S2FSbXduM3lnUitPMG5CbnU0K202ZE1jNDlOeUdnZklWV2QybTBZ?=
 =?utf-8?B?eXNFUm42ek5kczBFdVRNUXg5S0hBT2hENWxhOU1keUM3MlFaNEJKRzN5aGlW?=
 =?utf-8?B?bFVZVFl4MHo1VFArT08wQ2tCQUJTZjhHVnh6SUtNME1uWGVJTW5zYkg5a2dI?=
 =?utf-8?B?VDBqNGpraEI2TWF5aGhGcmhQNGZ1OHBqTXpMWXU2VngwNEY1VzAvUC9hVkxI?=
 =?utf-8?B?ODlCU0hZNUVDMUdhRUN3RDl5ZXhJRjNUeXhLdjY0YWNuckVTVlhnQTZ1QnRI?=
 =?utf-8?B?cGxzNGxkdmxtbUpSdEpVVTFIRFNyT0wwd3lZSTFKbVpqMzJFbDdKRVJ0WXZN?=
 =?utf-8?B?UFdwVmlBcVMzbllGbmYySlJSMktKd3ppS0cwaUFLUnJPb2trdnVLOFE4ci83?=
 =?utf-8?B?YUMwNjJjd3pMY3l1ZXpjK1AvbGRWS24xU2UwOEtCRWI0M0M5djg5ZkQ4NDV5?=
 =?utf-8?B?aEdvOXUxZXBqcG5rQWRTUG03SXhURUZJamZ1aXJ4MWd6VEFYN1YwRE5KVDMy?=
 =?utf-8?B?dFVvV0xzbWpFOVozZ1BJTFRXSmlRVUR1NVJHOS9xcWJuZWhoVi9UdHJnbzhM?=
 =?utf-8?B?OGhpSmMvU2FscnpOc1A4RHZDVVkzR1AwVk1nYncvbFlUcDNkbjd0cFNxdEtz?=
 =?utf-8?B?akpqYVcwSXJzbWZCdnhTc3RTUnZaMGdzUFVXN0Fjc3laSEh3TnNuVEwvSHQy?=
 =?utf-8?B?aUEwRERPZENsekY5cy80WjVjMTFiempvcjJYQ3V4WjBIYzJsUTZoRzRrUHQx?=
 =?utf-8?B?RzluK1FHQ0VSdEpOYlNaQ1VldWtxV3ZlVlplK1dkWjVsOHJBdWIwU0dKYkNO?=
 =?utf-8?B?bGRGMCtEQnhIdW4wLys4d2RZVTBHMk01bFBzVFR4VXVDODJxdS90dEZ1T2VL?=
 =?utf-8?B?U0RkR3FqcERrMHpFWXM2TmVVK0xMRUdSNklVcGZwbWMxWXpGWEJ4ZDlLZ2FT?=
 =?utf-8?B?VU1YbnNDUGtvYUhlbDUxZGxXbHcveHp2YXdWeXdJcHlMSmdCNnBsdUN3RU5x?=
 =?utf-8?B?Zk1Id3BIMFdSajlaQzJFMFFwU3NCVWVZZS83bUhOWHBmUE0wTFR6MWxXUGxQ?=
 =?utf-8?Q?5W/XKZ8tIXzbmHpg5mOig8gn9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5909691BB80A0549A8833F1ECC06E9F5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f210f1-184f-48de-1db3-08db80fa509d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 04:01:18.5383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kW3xg6bCTK2XfDMZl/O1oEZQs2IfhJw79+X0Mr4f4GqBwf33D4F4jJXBIwbIg65VkE8B5evH7tTZDV2eW+0eMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6351
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBXZWQsIDIwMjMtMDYtMjEgYXQgMTg6MjIgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gRml4aW5nIHRoZSBjb3Zlcml0eSBpc3N1ZSBvZjoNCj4gbXRrX2RybV9j
bWRxX3BrdF9kZXN0cm95IGZyZWVzIGFkZHJlc3Mgb2YgbXRrX2NydGMtPmNtZHFfaGFuZGxlDQo+
IA0KPiBTbyByZW1vdmUgdGhlIGZyZWUgZnVuY3Rpb24uDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8
Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBGaXhlczogNzYyNzEyMmZkMWMwICgiZHJtL21l
ZGlhdGVrOiBBZGQgY21kcV9oYW5kbGUgaW4gbXRrX2NydGMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBK
YXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IFJldmlld2VkLWJ5OiBB
bmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9A
Y29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9jcnRjLmMgfCA3ICsrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jDQo+IGluZGV4IGQ0MDE0Mjg0MmY4NS4uOGQ0NGYzZGYxMTZmIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IEBAIC0xMTYsMTAgKzExNiw5IEBA
IHN0YXRpYyBpbnQgbXRrX2RybV9jbWRxX3BrdF9jcmVhdGUoc3RydWN0DQo+IGNtZHFfY2xpZW50
ICpjbGllbnQsIHN0cnVjdCBjbWRxX3BrdCAqDQo+ICAJZG1hX2FkZHJfdCBkbWFfYWRkcjsNCj4g
IA0KPiAgCXBrdC0+dmFfYmFzZSA9IGt6YWxsb2Moc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+IC0JaWYg
KCFwa3QtPnZhX2Jhc2UpIHsNCj4gLQkJa2ZyZWUocGt0KTsNCj4gKwlpZiAoIXBrdC0+dmFfYmFz
ZSkNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+IC0JfQ0KPiArDQo+ICAJcGt0LT5idWZfc2l6ZSA9
IHNpemU7DQo+ICAJcGt0LT5jbCA9ICh2b2lkICopY2xpZW50Ow0KPiAgDQo+IEBAIC0xMjksNyAr
MTI4LDYgQEAgc3RhdGljIGludCBtdGtfZHJtX2NtZHFfcGt0X2NyZWF0ZShzdHJ1Y3QNCj4gY21k
cV9jbGllbnQgKmNsaWVudCwgc3RydWN0IGNtZHFfcGt0ICoNCj4gIAlpZiAoZG1hX21hcHBpbmdf
ZXJyb3IoZGV2LCBkbWFfYWRkcikpIHsNCj4gIAkJZGV2X2VycihkZXYsICJkbWEgbWFwIGZhaWxl
ZCwgc2l6ZT0ldVxuIiwNCj4gKHUzMikodTY0KXNpemUpOw0KPiAgCQlrZnJlZShwa3QtPnZhX2Jh
c2UpOw0KPiAtCQlrZnJlZShwa3QpOw0KPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gIAl9DQo+ICAN
Cj4gQEAgLTE0NSw3ICsxNDMsNiBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NtZHFfcGt0X2Rlc3Ry
b3koc3RydWN0DQo+IGNtZHFfcGt0ICpwa3QpDQo+ICAJZG1hX3VubWFwX3NpbmdsZShjbGllbnQt
PmNoYW4tPm1ib3gtPmRldiwgcGt0LT5wYV9iYXNlLCBwa3QtDQo+ID5idWZfc2l6ZSwNCj4gIAkJ
CSBETUFfVE9fREVWSUNFKTsNCj4gIAlrZnJlZShwa3QtPnZhX2Jhc2UpOw0KPiAtCWtmcmVlKHBr
dCk7DQo+ICB9DQo+ICAjZW5kaWYNCj4gIA0K
