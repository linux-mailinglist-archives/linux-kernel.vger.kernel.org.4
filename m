Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBB6637245
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKXGPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXGPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:15:45 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B860641D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:15:43 -0800 (PST)
X-UUID: 78b54c82bbce4559a62f1d9b2f72bf5c-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2i+stq4IugHhQSDtfGUQHczcdT/Q+F1Ob0MxG0Zutag=;
        b=Y28FirgrBahKYh8+reypjzCSDv4EleyUGmZHUXQjDDKm3E/hT4uscysNA7SgpAzE2sPYggYjPR6/HK/m/HdiMLaK/8O4Z1jHDP3U9KQVuKCyuKswWbSe0UGesAJFd3Abl3LmzWsXn4xa++SR/22lyDpOTjWBH0JYCtb+A6u1zOg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:0a361b00-07c5-45a8-993e-c8e2f6425d1a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:a0a32cf9-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 78b54c82bbce4559a62f1d9b2f72bf5c-20221124
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1879106082; Thu, 24 Nov 2022 14:15:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 24 Nov 2022 14:15:35 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 24 Nov 2022 14:15:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj4JBjXIi71LIQvodHGZIwT7bnymp2j6mm1sg/KqhoSlhTaE+wpALgC8wQ3UE1kafm01MAR9i1P5L9pHVLQ4TXxX9MZe6NWu9CUe2maK8bNBxdjTvlMquql0Buhdam5NBFZkdylEqD65f8JXNQNnqiIbGXVC+cl82dZHozbNsZ0o8pyI09O+Paebq902KuoWOkWk3FBM9dgY9JdWMz437GyqQ7mnbN3JRO/SxGRS27NYcoHuouAaglxSUdtz/DG6WDYXksJav9OPYp3HrkjjQ86ofEJgpRhIbHjjaURlXnbpHiV6TLopMc9gWaJFknzlergVGecg3T+9GS5490aK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i+stq4IugHhQSDtfGUQHczcdT/Q+F1Ob0MxG0Zutag=;
 b=OyA4+xY/H9vNKAYT084oKGnECfE7UXvWJCCPgCBGulo6Q6rT8VugBb2wy0lPUxpTlhP4w0iZ2ex3gMmCMiNgAav6PB3LChSaBczu7dznBRkk0Lt7ePzeEwnUfrqpSkyLLkeE2JMWiaD73LxfdVH2FQ/OwrMkoJJOjYsrQnu9qYZWTgJzcbfw3SGfRp5ydhUoIXQTuoseQzvi+lT/f7TCUb5RoIkxaOaBTtBgQ6qs7pDHPUWDubg7wvebvKhPow6dTPgPYeDXZxY8HW85UbN/mRFRUNCz8Hh+OMH0viI39zCo6g7jrdJvNtINNMheLfhpl+Trqpd2//HtMTQ32AvcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i+stq4IugHhQSDtfGUQHczcdT/Q+F1Ob0MxG0Zutag=;
 b=uZjJsKjY1cOyjqWHo47N/xf4wumx61uhBUyI3vChATyszEYH9SCOEPByBzS1yLQUJJSXNMS0nC4vMIb/7HSFCwsUQSWBe6sjYT593XTdDGYpDhwp6e4dnjMCpxLGRQzpc9e9fvhuqIIqeM078BZgEwQiOavEyZBOepSjgCVm4F8=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by PSAPR03MB5320.apcprd03.prod.outlook.com (2603:1096:301:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 06:15:31 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::af56:be8f:f:85b2]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::af56:be8f:f:85b2%7]) with mapi id 15.20.5857.017; Thu, 24 Nov 2022
 06:15:29 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>
Subject: Re: [PATCH v13,2/3] drm: mediatek: Set dpi format in mmsys
Thread-Topic: [PATCH v13,2/3] drm: mediatek: Set dpi format in mmsys
Thread-Index: AQHY500XYLpcYBEehUGGFUdJIRuJha5J3usAgAPqxgA=
Date:   Thu, 24 Nov 2022 06:15:29 +0000
Message-ID: <ca4e55f4d7ab2b7635e9a8fe14ce710c197cf00c.camel@mediatek.com>
References: <1666577099-3859-1-git-send-email-xinlei.lee@mediatek.com>
         <1666577099-3859-3-git-send-email-xinlei.lee@mediatek.com>
         <d7afdf50-0e8c-4954-d3f8-1d8890e70a24@gmail.com>
In-Reply-To: <d7afdf50-0e8c-4954-d3f8-1d8890e70a24@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|PSAPR03MB5320:EE_
x-ms-office365-filtering-correlation-id: b539b3cf-af91-489e-0656-08dacde3495b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4kKTI4v3S9+cm3+pUQR6FwqwX4KzhGK2S5+sYnfZIuPh9lvmIZKQ5ln3itjZpcE8QueNN/XMsMYWFYE/BiiOBD99kYdgRu0sS0LV+HjPayVlRMXaVvmvi5K0SJPsss0ivh10pHdd2r4iHExjGAIvWl+JfuT5CsbYTJpuUsqcaMEiVLT9hN9luftvfLbHq9QsFUWFy+Mqh8JCu+WO4nTpNyXGai2KOZ2Q00xVG5H7g+q2fk1GeEKWe3PNRi9jzZ6ylPBWn5XSQ77NoWYny9KAGQ3c6sIi/Ee5whDaIz+XzW7jK/qIgkzDYruNN5ME2b7TIRa/vUjx9XEfEMy7fzAEOC+Y1BJvSA54IrOgADvoZZLgolK/pVq8i1ekDu68dhiDmoB0V3ZtsyR/oORiHh1DWfOOilXZjmuHC76vikpjcqpn0nT+nyq8dojEqiLLoOXHOuTB+1erJpaPOk4wywvs7rf7SGFAaXSy2WiJTsh65ajzV8hC6XFxAyeesZI0FjqgBqw9DAlg/J0TknU8Zd9Jm2I+6hiFh0ty2CVG+OWTeusHuepj0G6ddtZTI1h9M0VwO22LWhJv8KP3AUQnXwSCSOq8Vj1Z2RFaLzf4V42dWaCu1pnOfz9mTsaaF4l+GKQUt6IGcM+IUCA+mqxG/tQq6k3i5xkPftomDwWhYWc4VWdPhfStWtylBg8nXJDaYBWP56EXC2hK5bT5+2nKmmQAreSTWDicPdoC4T446gBO5j1mIJlcHqnrXX1usEJd9Yy6g/i0wbxfRrPWQpvO5E05Nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199015)(86362001)(2906002)(85182001)(2616005)(36756003)(5660300002)(8936002)(41300700001)(7416002)(4326008)(186003)(4001150100001)(71200400001)(316002)(66574015)(66556008)(66476007)(8676002)(107886003)(53546011)(66446008)(110136005)(54906003)(76116006)(66946007)(64756008)(6506007)(6512007)(921005)(38100700002)(38070700005)(122000001)(91956017)(26005)(478600001)(83380400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek1uVGVleG04b2NGTm9STWVrazlRc2VWMWxtUUljbU4xZU1SOWF4QjdDcmRD?=
 =?utf-8?B?ekZ2c2dkeEtabnJuejcxMVQzRHhqZmFxWnI3VDkzeGo0M0NwZk1tTWFUcDFE?=
 =?utf-8?B?L2NsQlBhdkVSOFRDbm56QjN0NWZLMjVSVWRQY0phSGMvOTNNcEVvajMvMlJZ?=
 =?utf-8?B?c0hxRCtPZEY5dlpWUitzMjVwR0VnWUgzU0xDdUlhUjVmdlVob3VCVURibVN0?=
 =?utf-8?B?ZzlrN0FvSU5vdHZTYndLOEdPYlB5QU4yeWgwb21rSlRRalYzMEdESmtKellE?=
 =?utf-8?B?N2E4R2dYKzhUMDBVZjhiTEZ2YTVKQ2svL29oV0hWSTVxNU5uMGpvMk16RXlC?=
 =?utf-8?B?ekZpNGZsK1Z3MWZmV0hpM0kzWnFnME1rTEtIY3pCZXhsZE93YjdzU1E1ZG5Y?=
 =?utf-8?B?djBFRCtiREF5ekFGempTWWF0S2hnODNDWWhub1dUV2FZb3NjZGorOHVoTVAx?=
 =?utf-8?B?Y1lBYU9kL2hWbnBxVEFwUS9seVVFaFRvZzJGMjBzemMzSGhLZ2EzSG1lYUMr?=
 =?utf-8?B?dXMvNjVsdnA3NW0remF2Qmw2N0dLK3ExbjhXS044L0hRZzdROG41d2s0T3hH?=
 =?utf-8?B?dzBuaEdrNU15Q3d1K3VrdlZqdFU2T2pzbFk0ejlDUHJvU2Z3d2J2c2M4d0RQ?=
 =?utf-8?B?M0RONjRmdU9kOUpHaWdsR2dsenVhclV0eE1lWmVqR0JUVHMyb05aK3ZmVlpR?=
 =?utf-8?B?NjB4WFZmTnkxYnc0QUxWbE1nQkZpR1pZb2tqK0MvRytZeUhhTVJDbFE4THo5?=
 =?utf-8?B?NnppdWg3a25YdHpTZHk3R2thMnBMUWpiZE1CQ0hySXBnQ0RnelhHY09GWWNL?=
 =?utf-8?B?TUNnT0FjcGkzMDZFek02SUpkeEY2Y1F0TFYxVC9RYWV2MVhnNHl5NUVIMmNJ?=
 =?utf-8?B?TkdxcTJaZ2k2YWJESW9kN1I5Y0ZuS1JqWDN2VmV2SU4xaUxwcTFqUzM3NGNM?=
 =?utf-8?B?dnFiZGZZRDgrc1dMNnlEMGw0ZEw5UFlTc3RuSXV5aGpienhDdk15VjUxeEdH?=
 =?utf-8?B?cVlxbFBvQlpBZ044Rm41em9IYVNyeEVPNnZLMnhsNzZ6TFdjc0I2VDFIbi9X?=
 =?utf-8?B?cmFpenRUU2FFSGk2ajdXME5nRHBiS0FIOXM0ZU5aSW1KZ1BheFpLU2lnZ1RT?=
 =?utf-8?B?bXNxSU0zMFhkZWpqTTAwZUJqNGlwR3lwMEE4R1I5RzQreUdqRHR5dlQ5NkZw?=
 =?utf-8?B?bFpLQzBCRFFueFFWR0hINHFjc0xZd2s4K3VZT1QyVGFEaVovL2dqVStmM09F?=
 =?utf-8?B?SFJBTStpSEJ2MkFIODJ4WTl3cmllUGQwWlZnL2ZTRThxWGhtWFl0eDl4NXhh?=
 =?utf-8?B?TjJYcnN1ZElMdndIUGd1cUFFNzN6U1ZqMENXQjE2ck5YSW0xemNNVlZxT0l3?=
 =?utf-8?B?MW5ReFdWaFAvTXEvcG1ETmRrblBCdlRDR1FQOEsxblhCUUE0RFNuVUE5YjZx?=
 =?utf-8?B?U3hSelA2OWVjaEpsbDI5Mnc4TFRvT2ZZYW5SNmNkL0g3c1BEV0J1bTE1OUF5?=
 =?utf-8?B?emExd2Vkby9ZWkxpZkUzNzMwMUNMUmVGTW5rMFZQcWVFc28vaHByK0tibkRs?=
 =?utf-8?B?OENpaWJLNjhnTCtzMUZndHlTaTcxamNvZm9FaUlUWWxoNWdQWkExVDNpMVNB?=
 =?utf-8?B?TVJ3TVltRVlUdW1MeDkvWFlaTkUvSEhETHE0cGJLVFZpb2JRUkZpMCt0MWRS?=
 =?utf-8?B?a3l4RUI2dnFDeXh1T2p3YVJzd240WDlqR2ZmZ29xM0FGNzhRdisvTlVIdkNm?=
 =?utf-8?B?RjNxMlgza3JSUTcxcXpsTmV2VFBIdXlZaEJ5SVdQRk5NU25VdWYrNkhiNjkr?=
 =?utf-8?B?WXFlS1RUZ1ZjZzhBNlZCSFFlUU1wcXBVVFZYUmVYMkQzOWJmdkpqMy9ST0Fi?=
 =?utf-8?B?UXkzRXdhcUdYdlJZVzJXZUxRdExFMzQyQnBCL2tqM3M2RUZKQlZrcDhtc0hF?=
 =?utf-8?B?Y3RMWWRFd0V6WVpUZ1c1N2NvR2JoMEFGRlVQRDJJN3FOMXRJb2xBNEY1N3N0?=
 =?utf-8?B?S1oyeG5NcFBRRGcvVkk1VURFZTdUMENtb2VzbysycEhDOXUvdzdLaGpzTmFQ?=
 =?utf-8?B?WHRXcGNNSnRoTVA1TjRFN0x2N2tZZE1GMEdVK1FTZDZNWUw2eFBwOU1oWERm?=
 =?utf-8?B?eTJyWEpOWmxkR0lkNmtwYTJieitSWUhybUJja3B0cXY2M21uUXRKNUpXVk9C?=
 =?utf-8?Q?99v4erxyqZkQKR6oj5bGdYQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E2303675C3B2441A1A7FD65398E2AC3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b539b3cf-af91-489e-0656-08dacde3495b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 06:15:29.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cpf87ECUcGE1KfSPz7eQYPgrYvQImIs7HSu0h7PYaZ225eQhsrUSwIxEpd32SAALibvx7+e5RXeiz5UFyrNtPjj7zB+AT22obH2RgNqb8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5320
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNClRoYW5rIHlvdSBmb3IgcmVzcG9uZGluZy4NCg0KSXMgdGhlcmUgYW55
dGhpbmcgd2UgY2FuIGRvIGFib3V0IHRoaXM/DQoNCkJlc3QgUmVnYXJkcywNCkFsbGVuDQoNCg0K
T24gTW9uLCAyMDIyLTExLTIxIGF0IDE5OjI2ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjQvMTAvMjAyMiAwNDowNCwgeGlubGVpLmxlZUBtZWRpYXRlay5jb20gd3Jv
dGU6DQo+ID4gRnJvbTogWGlubGVpIExlZSA8eGlubGVpLmxlZUBtZWRpYXRlay5jb20+DQo+ID4g
DQo+ID4gRHBpIG91dHB1dCBuZWVkcyB0byBhZGp1c3QgdGhlIG91dHB1dCBmb3JtYXQgdG8gZHVh
bCBlZGdlIGZvcg0KPiA+IE1UODE4Ni4NCj4gPiANCj4gPiBDby1kZXZlbG9wZWQtYnk6IEppdGFv
IFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaXRhbyBT
aGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWGlubGVpIExl
ZSA8eGlubGVpLmxlZUBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5o
dUBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vIDwNCj4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IE7DrWNvbGFzIEYuIFIuIEEuIFByYWRvIDxuZnJhcHJhZG9AY29sbGFib3Jh
LmNvbT4NCj4gDQo+IEkgcmVhbGl6ZWQgdGhhdCBJIHRvb2sgdGhpcyBwYXRjaCBieSBlcnJvci4g
SSdsbCBkcm9wIGl0IGZyb20gbXkgdHJlZQ0KPiBub3cuDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0
aGlhcw0KPiANCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBp
LmMgfCAxMSArKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cGkuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiA+IGluZGV4
IDYzMGE0ZTMwMWVmNi4uYWQ4N2VjZGRmNThkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RwaS5jDQo+ID4gQEAgLTE1LDYgKzE1LDcgQEANCj4gPiAgICNpbmNsdWRlIDxsaW51
eC9vZl9ncmFwaC5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3BpbmN0cmwvY29uc3VtZXIuaD4N
Cj4gPiAgICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUg
PGxpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC90
eXBlcy5oPg0KPiA+ICAgDQo+ID4gICAjaW5jbHVkZSA8dmlkZW8vdmlkZW9tb2RlLmg+DQo+ID4g
QEAgLTMwLDYgKzMxLDcgQEANCj4gPiAgICNpbmNsdWRlICJtdGtfZGlzcF9kcnYuaCINCj4gPiAg
ICNpbmNsdWRlICJtdGtfZHBpX3JlZ3MuaCINCj4gPiAgICNpbmNsdWRlICJtdGtfZHJtX2RkcF9j
b21wLmgiDQo+ID4gKyNpbmNsdWRlICJtdGtfZHJtX2Rydi5oIg0KPiA+ICAgDQo+ID4gICBlbnVt
IG10a19kcGlfb3V0X2JpdF9udW0gew0KPiA+ICAgCU1US19EUElfT1VUX0JJVF9OVU1fOEJJVFMs
DQo+ID4gQEAgLTY3LDYgKzY5LDcgQEAgc3RydWN0IG10a19kcGkgew0KPiA+ICAgCXN0cnVjdCBk
cm1fY29ubmVjdG9yICpjb25uZWN0b3I7DQo+ID4gICAJdm9pZCBfX2lvbWVtICpyZWdzOw0KPiA+
ICAgCXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKm1tc3lzX2RldjsN
Cj4gPiAgIAlzdHJ1Y3QgY2xrICplbmdpbmVfY2xrOw0KPiA+ICAgCXN0cnVjdCBjbGsgKnBpeGVs
X2NsazsNCj4gPiAgIAlzdHJ1Y3QgY2xrICp0dmRfY2xrOw0KPiA+IEBAIC0xMzUsNiArMTM4LDcg
QEAgc3RydWN0IG10a19kcGlfeWNfbGltaXQgew0KPiA+ICAgICogQHl1djQyMl9lbl9iaXQ6IEVu
YWJsZSBiaXQgb2YgeXV2NDIyLg0KPiA+ICAgICogQGNzY19lbmFibGVfYml0OiBFbmFibGUgYml0
IG9mIENTQy4NCj4gPiAgICAqIEBwaXhlbHNfcGVyX2l0ZXI6IFF1YW50aXR5IG9mIHRyYW5zZmVy
cmVkIHBpeGVscyBwZXINCj4gPiBpdGVyYXRpb24uDQo+ID4gKyAqIEBlZGdlX2NmZ19pbl9tbXN5
czogSWYgdGhlIGVkZ2UgY29uZmlndXJhdGlvbiBmb3IgRFBJJ3Mgb3V0cHV0DQo+ID4gbmVlZHMg
dG8gYmUgc2V0IGluIE1NU1lTLg0KPiA+ICAgICovDQo+ID4gICBzdHJ1Y3QgbXRrX2RwaV9jb25m
IHsNCj4gPiAgIAl1bnNpZ25lZCBpbnQgKCpjYWxfZmFjdG9yKShpbnQgY2xvY2spOw0KPiA+IEBA
IC0xNTMsNiArMTU3LDcgQEAgc3RydWN0IG10a19kcGlfY29uZiB7DQo+ID4gICAJdTMyIHl1djQy
Ml9lbl9iaXQ7DQo+ID4gICAJdTMyIGNzY19lbmFibGVfYml0Ow0KPiA+ICAgCXUzMiBwaXhlbHNf
cGVyX2l0ZXI7DQo+ID4gKwlib29sIGVkZ2VfY2ZnX2luX21tc3lzOw0KPiA+ICAgfTsNCj4gPiAg
IA0KPiA+ICAgc3RhdGljIHZvaWQgbXRrX2RwaV9tYXNrKHN0cnVjdCBtdGtfZHBpICpkcGksIHUz
MiBvZmZzZXQsIHUzMg0KPiA+IHZhbCwgdTMyIG1hc2spDQo+ID4gQEAgLTQ0OSw4ICs0NTQsMTIg
QEAgc3RhdGljIHZvaWQgbXRrX2RwaV9kdWFsX2VkZ2Uoc3RydWN0IG10a19kcGkNCj4gPiAqZHBp
KQ0KPiA+ICAgCQltdGtfZHBpX21hc2soZHBpLCBEUElfT1VUUFVUX1NFVFRJTkcsDQo+ID4gICAJ
CQkgICAgIGRwaS0+b3V0cHV0X2ZtdCA9PQ0KPiA+IE1FRElBX0JVU19GTVRfUkdCODg4XzJYMTJf
TEUgPw0KPiA+ICAgCQkJICAgICBFREdFX1NFTCA6IDAsIEVER0VfU0VMKTsNCj4gPiArCQlpZiAo
ZHBpLT5jb25mLT5lZGdlX2NmZ19pbl9tbXN5cykNCj4gPiArCQkJbXRrX21tc3lzX2RkcF9kcGlf
Zm10X2NvbmZpZyhkcGktPm1tc3lzX2RldiwNCj4gPiBNVEtfRFBJX1JHQjg4OF9ERFJfQ09OKTsN
Cj4gPiAgIAl9IGVsc2Ugew0KPiA+ICAgCQltdGtfZHBpX21hc2soZHBpLCBEUElfRERSX1NFVFRJ
TkcsIEREUl9FTiB8IEREUl80UEhBU0UsDQo+ID4gMCk7DQo+ID4gKwkJaWYgKGRwaS0+Y29uZi0+
ZWRnZV9jZmdfaW5fbW1zeXMpDQo+ID4gKwkJCW10a19tbXN5c19kZHBfZHBpX2ZtdF9jb25maWco
ZHBpLT5tbXN5c19kZXYsDQo+ID4gTVRLX0RQSV9SR0I4ODhfU0RSX0NPTik7DQo+ID4gICAJfQ0K
PiA+ICAgfQ0KPiA+ICAgDQo+ID4gQEAgLTc3OCw4ICs3ODcsMTAgQEAgc3RhdGljIGludCBtdGtf
ZHBpX2JpbmQoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+IHN0cnVjdCBkZXZpY2UgKm1hc3Rlciwg
dm9pZCAqZGF0YSkNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgbXRrX2RwaSAqZHBpID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7DQo+ID4gICAJc3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXYgPSBkYXRh
Ow0KPiA+ICsJc3RydWN0IG10a19kcm1fcHJpdmF0ZSAqcHJpdiA9IGRybV9kZXYtPmRldl9wcml2
YXRlOw0KPiA+ICAgCWludCByZXQ7DQo+ID4gICANCj4gPiArCWRwaS0+bW1zeXNfZGV2ID0gcHJp
di0+bW1zeXNfZGV2Ow0KPiA+ICAgCXJldCA9IGRybV9zaW1wbGVfZW5jb2Rlcl9pbml0KGRybV9k
ZXYsICZkcGktPmVuY29kZXIsDQo+ID4gICAJCQkJICAgICAgRFJNX01PREVfRU5DT0RFUl9UTURT
KTsNCj4gPiAgIAlpZiAocmV0KSB7VFRoYW5rIHlvdSBmb3IgcmVzcG9uZGluZy4NCg==
