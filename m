Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62F374C9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGJCOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJCOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:14:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF29120
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 19:14:44 -0700 (PDT)
X-UUID: 878e9b0a1ec711eeb20a276fd37b9834-20230710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8fbOHbOwW2GyhmDZHHStivp5QdZDOejVyyZQMzUDero=;
        b=gmJk/fvQQS4T9dQPNLzGoS6hte2fsKzSlhZlBU2Zbguy0yp95ptfE3IDXTDEx/Chu16WeeukpGzGzcVsZakjYR90wKE2sChRnGHGFBrCcgCBdDcjTEnRH2Ghi1xzmvxGlGrgA0czDHoNgxEQeZnaSZ8nQkTMHahtzygnwzyk54E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:c9426b6e-2665-444d-9e31-f66cf39797b5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:a1fdcdda-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 878e9b0a1ec711eeb20a276fd37b9834-20230710
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1919591532; Mon, 10 Jul 2023 10:14:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 10 Jul 2023 10:14:41 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 10 Jul 2023 10:14:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBUQ4+kxIjxioMn50KPaG668kT5SFSOU10f8omm9lMsT9GpPQuU44BvjlAkWJQTZxzUoiCosLge2Mlw+Hu0HYcO82Y684eaQHdYHp5xauSWU85S7lr4YesA/wu5aDrRuhzUNZ/eCGVx0xMRKEMT2CON1J685wACdX1FMjjfF4CSSlfCm4flqINF6cmz0GeqGqNWQ+LvdUzBZRDiLgMVwcyewK6T2lgkMV24DihNKah16eFNLLvnXVRvDGPhjUAGPB4zhxInvXl6gq1tBfDhljJLd8KT5vVJVbI9wioKqlAdNoiOw7a06oon308zGNMFHT1b22Yd3ZHhVJT5R1lSLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fbOHbOwW2GyhmDZHHStivp5QdZDOejVyyZQMzUDero=;
 b=BOwYwpLu+l0OQ9mwnShTCwGNir8ITG3+8e3Cp5j9OLdaDG6pOtHfDSllqPtBqiQcGANtMOeEBRh08rnCCD0kLgKU9BtCsn3B5PL/hY7PbF/cPwqBWgCc+tuI0OpoDz75e2NiVznBglRQoH15PBenG1LK6kTPmTj57zpk+RUHnRx09PPjTXbbZlluKNnjyx5M2XCsi6woSCbRsNwgbtmE0pAPP6BYcoemaHpt+YSb6JgSrnPI7FxRII1IQsTI5qLWyR59m39DLCuJ9Yqq376bDxdRl5ySl5CLn75MM+/ZFbCQwCgQ0AbvGVPTguMSFjZ0YK80T55pd1aYzbLlzMZDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fbOHbOwW2GyhmDZHHStivp5QdZDOejVyyZQMzUDero=;
 b=jeEj/jOFsV4M0qx9zZYC0hOFI2NBMN4RR+pF64uMYUPC/OLG0ZuHd7uDy4C+W7IgGRzA6fDKU5zAe8Fpxsl8Pzo3h/5eGz6JZm9hbN1jvkTAIJTt8CvpbPknX5rfDqa7unOj+Cuc3tvbCE6b9HyizG3r6qclCW9BfDkaS/af1nI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6499.apcprd03.prod.outlook.com (2603:1096:400:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:13:38 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%7]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 02:13:38 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
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
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] drm/mediatek: Fix void-pointer-to-enum-cast warning
Thread-Topic: [PATCH v2] drm/mediatek: Fix void-pointer-to-enum-cast warning
Thread-Index: AQHZpBWpvcJHmDbcuk+V1V3BfTuQGq+yYBqA
Date:   Mon, 10 Jul 2023 02:13:38 +0000
Message-ID: <b7769eb121b2241881f2eb3f5756ce8ceb95f862.camel@mediatek.com>
References: <20230621075421.1982-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20230621075421.1982-1-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6499:EE_
x-ms-office365-filtering-correlation-id: 6dfa6c26-2c2b-43f8-4af7-08db80eb4610
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: idb2L1HBe7niSMxNmBHtkkF3iHby7hwFqO+Gz6lD3MvxlAmcG1rTJxIseG+Vg4vCSjKOSmNruBu9yv/maky1gxC32bxxF9AnKtZVDXcSBSfU/fZyXVCDrcSpnV2c1C+J1qmGi3RAduhPQbZXAVxR1g7q89oBXJSmj2IFwp/ySDPztzM3Q0kQMeBbN0SvZW58l7rmP/MTqWQP+p4LHYbblqJvxeATNV1Rbj/njod7X/PP6ba3eqQYvTE3C1YJ0jIugku/T+n/Bm5JBT4KnhiTE0nJXQk3+TVQtzsNFwMGObLM2a3dVB+P2oGpUvudsOOlokxIo292PWE8+Ua2mSSI9a1AEPPgEBl9wwQjV9Iz/aIQXsPLKVUjNTsFNLPMGFl6RIE7bktV/Kwlvx5oxhxflXR2pJ8B8rPGqO2Z1an7HWA7dPoBqTXrQHMvnDDBRSB8/M68CsogXNSi9AGxU/CG7rpoo3fnklmjZrwgIRZ/kqSvOP58RJ+UvOqdYIcu4Kf0WGtDYQ7yZR8aa1ZBt/JgX+xR5ZkDFlGkY6if3ayMvLzKch61wkl9uDOILYIza8mFPh5e0qrTcM7u72HjCrznJEv4WYbojC7NE787pLXZCjl7IjTcIP8iN52ULpC6TgXLbu1tyive4jKMq8Qk3MDuMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(186003)(26005)(6506007)(2616005)(966005)(6512007)(83380400001)(41300700001)(4326008)(64756008)(66446008)(66476007)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(66946007)(478600001)(6486002)(71200400001)(76116006)(110136005)(54906003)(36756003)(85182001)(122000001)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW43L3dId1dMTW42NmVvblFoTUY3VUtER21yaWlFYStlTXZUU0VEZ1ZUYkw0?=
 =?utf-8?B?REI3RU5mZTZaaitneEtwMUd6TytoLzI2S1FOaGgyR3Fzd2oxYjdvWDIrSEtx?=
 =?utf-8?B?anF4Rk1jVDhjRjhHS1VQVFpuV2dSeTZCWitDeiszTVNjMlN3SDJLcXllejNW?=
 =?utf-8?B?WnYwSmVJSEJraXYzTVMwSkZKZ1h0T1lza0wrU3hBZGU5d3puWnEvSHdOZHVj?=
 =?utf-8?B?QnluRWlmcmJTb3hBZEV1NUlWc29HNUlvUDV2MXZ4bUR4QkRsaTVnaTg5ajZW?=
 =?utf-8?B?c1JVWk1OV3FJemNIclZWZWZlbkV4Y2RublY0ZThIMThDVlZrVWNlWnNjRVRI?=
 =?utf-8?B?dDRuM3NRRndjaHlKWlorclpJVVV4ZmdCSzFRcUhHYklsYm9HNmlobWdncTlz?=
 =?utf-8?B?L2hJekcyaExlUjZwWnVqZlZ5eS83QjlWZWpQQnMzYWxrY0JaS1RwRWwzY3ow?=
 =?utf-8?B?WXRpejZUbHpCSjlVYW05S2xEdVNSejJjckhmbHpTbTdML2hZYlJZbnBjQUZk?=
 =?utf-8?B?a2NQMGxOOVNkT2QzMHFIUFhtMU9TWDlGL1EwYTEzQWxFZ3o2b0pFbW9LSTgy?=
 =?utf-8?B?NnZUSlQyVG1tMWNoU0xHYkJkMSswRTlyNzVPcjRRbXFUN3RQRmI0UTFYQ3lB?=
 =?utf-8?B?dm0wT3hvSkt0SmhTd0Nab3J2L0haYW0vdmsxZENBSVNjODNwY2RBSDBGbGs3?=
 =?utf-8?B?TTlwanlzMW9mSE9NNjg2WkJWUXZINzFRczhUVUNsSHY0OWVlTkl1SzVESHpK?=
 =?utf-8?B?TWpORkFEUDdyNkFiZUZWRHVSU3J5YzJ6VWFweGxacUtpTFltbVZIVTc4QjBC?=
 =?utf-8?B?QTYwSUx2UkFxOXdVOHhEWll1QlBadHJlL0hJZ0hzRnhOODlCV1FFa0xjbE81?=
 =?utf-8?B?bE0rb3VTZXRlMmFCWUk4bUQvZ25tNHpWSUhCVi9qL3VtNE9DZkhFL24wWThm?=
 =?utf-8?B?aEh2aS9OZXd6NHh4T2tlcE85LzM1d1IwVUl2S21Welg5K0FERWxINGxWdnIz?=
 =?utf-8?B?WVlGUXZteUpZL0J6LzZEWDBpT0dHakIvSWJoY21MZ2V4WUFINVVsdzdzZzNx?=
 =?utf-8?B?Zm44dlBvenNZdFNCK3l5NW5XdGdNeWt0STNkNVZEZ0UzeEdZVUt3YXQ1RTZS?=
 =?utf-8?B?YWN5ZHBJTkNHSHlrcW5pd1QxeWRLM1l6Yzd0QVA5enNGUG1lYVlLZHloVU91?=
 =?utf-8?B?SVFNOE1Rd01VSHlQUVMwR3k4SDAxWU9uVi9keE9zQkhxenhTa3dFQkcvby9o?=
 =?utf-8?B?RU9KNGQ1OGFpQlhFbUtQVW5WK3pRRjF4RW5KNUtjUGFqaHdtb0ZGUkEzblpR?=
 =?utf-8?B?akVXWDZ0YzFoK0RnbzBiNlU5bVREa1JlRDZoWVIrZjlWckZIWmNrSFJRd013?=
 =?utf-8?B?WjBjWTFBQ21OMDB0eGs2ZGNMQTFYMkQxSzhtUS9PVjVvck5oMEVFUmpPZy92?=
 =?utf-8?B?K3VTWno3aWRRczBXd1VQSDhPa2tuRGthNytIMENGOFgvdzdnREhKUVZ2YW95?=
 =?utf-8?B?Z3ZzcXRzSVpYMUdYQloybHRZSGp1Rk0rb2Y2U3NvNk1HQVZUbkxjZ3kxbEls?=
 =?utf-8?B?WFRUTFR5OVd2M3hnZHFCMlV6ZEp6bWZ4NDJITktMcFM2L3B3bkpQZkRlT0RP?=
 =?utf-8?B?UDlDamIzTFU0RDFuemFHWU1oK29TYXhKbFFsMGlnanA3MVdIKzVFODlqeFAz?=
 =?utf-8?B?QW0vQmp3RWNoandNMHd3dVI0Z215TTZVN2xEVU1EQTU2Y2xHSnFQVW51b3ZM?=
 =?utf-8?B?elFHd0Y4S2trUkMzVGwrSElZR2J1TVdabkQ2aEFKTTBSRFhKQzc3OXpvWS9E?=
 =?utf-8?B?RXJrbS93dWxGSUNHYWU3V0MvSVllQnlKOU5FS2tTY2RWMys2RDlmZmYyVzYr?=
 =?utf-8?B?NXJ4dG00bUx3anZCUEtSUTBCR05hZ0hrb1UyZlhDRGtnQStCU09USGFHQUtQ?=
 =?utf-8?B?Yk9lZVVGQVdodm1LZTZYRitLWlA0NWxQaW83emhGZjZmTzYyM1hSdkpVVUNo?=
 =?utf-8?B?WlhnSjhhR0NNNGMyc1hSZEtrQnozdVhyQlBtb1JEVFNUYWFzQm5sTjZ0TUNR?=
 =?utf-8?B?U2hlakszekswU0RRaWhMMVZrd2IxMjJ6cWQ1SDRhT3FzNlhXUHNsU040MkZm?=
 =?utf-8?Q?DZfMaObQ7F5GkjbncVon6RB6i?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <204A04B71CF2F1479223E77CA263E243@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfa6c26-2c2b-43f8-4af7-08db80eb4610
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 02:13:38.3791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6z1OmWVmUwmLRH/PTS231MUPJOOrJoBziDL5RelNurVad5MQ04mGuxArSJV1dZVzW/b82KZRi+fTlQ4kC0/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBXZWQsIDIwMjMtMDYtMjEgYXQgMTU6NTQgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gMS4gRml4IGJ1aWxkIHdhcm5pbmcgbWVzc2FnZSBpbiBtdGtfZGlzcF9v
dmxfYWRhcHRvci5jDQo+ID4gPiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3Zs
X2FkYXB0b3IuYzo0MTU6MTA6DQo+IA0KPiAgIHdhcm5pbmc6IGNhc3QgdG8gc21hbGxlciBpbnRl
Z2VyIHR5cGUgJ2VudW0NCj4gbXRrX292bF9hZGFwdG9yX2NvbXBfdHlwZScNCj4gICBmcm9tICdj
b25zdCB2b2lkIConIFstV3ZvaWQtcG9pbnRlci10by1lbnVtLWNhc3RdDQo+IA0KPiAgIHR5cGUg
PSAoZW51bSBtdGtfb3ZsX2FkYXB0b3JfY29tcF90eXBlKW9mX2lkLT5kYXRhOw0KPiANCj4gICAg
ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAgICAg
ICAgICAxIHdhcm5pbmcgZ2VuZXJhdGVkLg0KPiANCj4gMi4gQWxzbyBmaXggdGhlIHNhbWUgd2Fy
bmluZyBtZXNzYWdlIGluIG10a19kcm1fZHJ2LmMNCj4gPiA+IGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2Rydi5jOjgzMjoxNToNCj4gDQo+ICAgIHdhcm5pbmc6IGNhc3QgdG8gc21h
bGxlciBpbnRlZ2VyIHR5cGUgJ2VudW0gbXRrX2RkcF9jb21wX3R5cGUnDQo+ICAgIGZyb20gJ2Nv
bnN0IHZvaWQgKicgWy1Xdm9pZC1wb2ludGVyLXRvLWVudW0tY2FzdF0NCj4gDQo+ICAgIGNvbXBf
dHlwZSA9IChlbnVtIG10a19kZHBfY29tcF90eXBlKW9mX2lkLT5kYXRhOw0KPiANCj4gICAgICAg
ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAg
ICAgICAgICAgICAgICAxIHdhcm5pbmcgZ2VuZXJhdGVkLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUg
PGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGlu
IDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiBGaXhlczogNDUzYzMzNjQ2MzJhICgiZHJt
L21lZGlhdGVrOiBBZGQgb3ZsX2FkYXB0b3Igc3VwcG9ydCBmb3INCj4gTVQ4MTk1IikNCj4gUmVw
b3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiBDbG9zZXM6IA0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjMwNTA0MjA1NC5adFdN
RTlPVS1sa3BAaW50ZWwuY29tLw0KPiAtLS0NCj4gVjEgLT4gVjI6IEFkZCBjYXN0aW5nIHRvICh1
aW50cHJ0X3QpIGJlZm9yZSBjYXN0aW5nIGZyb20gKHZvaWQgKikgdG8NCj4gKGVudW0pLg0KPiAt
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jIHwg
MiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgICAgICAgICAg
fCAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
b3ZsX2FkYXB0b3IuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxf
YWRhcHRvci5jDQo+IGluZGV4IGMwYTM4ZjUyMTdlZS4uZjJmNmE1YzAxYTZkIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBA
QCAtNDI2LDcgKzQyNiw3IEBAIHN0YXRpYyBpbnQgb3ZsX2FkYXB0b3JfY29tcF9pbml0KHN0cnVj
dCBkZXZpY2UNCj4gKmRldiwgc3RydWN0IGNvbXBvbmVudF9tYXRjaCAqKm1hDQo+ICAJCQljb250
aW51ZTsNCj4gIAkJfQ0KPiAgDQo+IC0JCXR5cGUgPSAoZW51bSBtdGtfb3ZsX2FkYXB0b3JfY29t
cF90eXBlKW9mX2lkLT5kYXRhOw0KPiArCQl0eXBlID0gKGVudW0NCj4gbXRrX292bF9hZGFwdG9y
X2NvbXBfdHlwZSkodWludHB0cl90KW9mX2lkLT5kYXRhOw0KPiAgCQlpZCA9IG92bF9hZGFwdG9y
X2NvbXBfZ2V0X2lkKGRldiwgbm9kZSwgdHlwZSk7DQo+ICAJCWlmIChpZCA8IDApIHsNCj4gIAkJ
CWRldl93YXJuKGRldiwgIlNraXBwaW5nIHVua25vd24gY29tcG9uZW50DQo+ICVwT0ZcbiIsDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IGluZGV4IDZkY2I0YmEy
NDY2Yy4uODBkM2JjZDMxNWE5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kcnYuYw0KPiBAQCAtODI5LDcgKzgyOSw3IEBAIHN0YXRpYyBpbnQgbXRrX2RybV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCQkJY29udGludWU7DQo+ICAJCX0N
Cj4gIA0KPiAtCQljb21wX3R5cGUgPSAoZW51bSBtdGtfZGRwX2NvbXBfdHlwZSlvZl9pZC0+ZGF0
YTsNCj4gKwkJY29tcF90eXBlID0gKGVudW0gbXRrX2RkcF9jb21wX3R5cGUpKHVpbnRwdHJfdClv
Zl9pZC0NCj4gPmRhdGE7DQo+ICANCj4gIAkJaWYgKGNvbXBfdHlwZSA9PSBNVEtfRElTUF9NVVRF
WCkgew0KPiAgCQkJaW50IGlkOw0K
