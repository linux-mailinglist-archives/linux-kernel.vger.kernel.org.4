Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B035FF802
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 04:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJOC1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 22:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJOC1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 22:27:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A671DF14;
        Fri, 14 Oct 2022 19:27:37 -0700 (PDT)
X-UUID: d7feef8e04864ddc8bf20d115506e727-20221015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NVAjBcsd2Etb3mTBMLRHDyfQ88KQ3b6G946hrNYOw0I=;
        b=aG7LhFpCCwoEf8gi0uNdOSjX9VLmIjBjYWyLAoVHhQVV/L1amIouQa9qQKG2PfnqEy72HswLGhHn3JEFcyRIuUzJlJdXQ9vpfkzTa3TY9GWZZAy4aNRUjVCGBBQaKXwHtkHjLqds5oIk35TAQvQ+LhzeYyTynaS1jMAkoUa4MPw=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:4cffa917-18e6-43ce-abac-7370de946566,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:29
X-CID-INFO: VERSION:1.1.11,REQID:4cffa917-18e6-43ce-abac-7370de946566,IP:0,URL
        :25,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
        release,TS:29
X-CID-META: VersionHash:39a5ff1,CLOUDID:50b6d4a3-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:2210151027285B7MAKNB,BulkQuantity:0,Recheck:0,SF:38|16|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d7feef8e04864ddc8bf20d115506e727-20221015
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1824440559; Sat, 15 Oct 2022 10:27:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 15 Oct 2022 10:27:25 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sat, 15 Oct 2022 10:27:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/je9mIfSDKUDDbgGJD0eHVXC7z4BpVWKp1n8i5lVeEMA0RobApOKWHry0A6xOwWUvOPMGjSC63zyM13vn/EJCUHoP+PldrhA/l8oIIGyhKnvvY4iq4TLfNKJLoyH3ITA8kBWzUPbgzf2IBjB+1HzXlC7Bp0UwiGJzS+txMY15Q44WAK9ENuOqNEJcUuouCSH/L3uq0o6tw/cYJDnf+dGaEJwaJiXB4Av2w6BXvzfbVIvzFRj51Y9POxVIKdyDwf9/KMWZZlmTdvrTXwoBuG0Vs7bd0teE/g4Dwf2L2FKA5DqOFsKFQdAnIwv2M0jvJU2eSUX/Dd9L+/iH1R086MJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVAjBcsd2Etb3mTBMLRHDyfQ88KQ3b6G946hrNYOw0I=;
 b=Izwl4cRTwhychzvKkXJnSp/Yee+Uv5ptLyNJM1z/xfbiQtRoT1+wyYjM8b6vGZBKd10Lof2KVUfIwI2OnUopnidjh7R7WR7zr1v6ri0aE2W0o0FnPF5IEUau3qRQuGpYH3FtXx1IvlMEhpOu0fUkn7a/Spzqvj4MXfBMx+bOzLYJgwFjxkKQMYbRZGtyvaXVMZDCViEIPYU5XUhfIwqeMQOYjzWi5USvi3I6v8dKIBxEeNg8BCLuKKJ9FQW4+rL1dH3RMIIIMXdAwMTEgDU4UyMDoX0XsoX8GA99L9nug/fbm9KIVClsJIZF/GAH7aLSbSIhoIYjI2HClkwKsk1GFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVAjBcsd2Etb3mTBMLRHDyfQ88KQ3b6G946hrNYOw0I=;
 b=tCrGpp3kTzIKvQKPEn/ZH8KfaTZAoGRDXBazWLrL/aw0VQUqard5YjxOV76JWeGserNF56oWmp4u9uTolDA7gnsGhlkcMo5YcYQqmY65dZ6hfiIquw2TPAzTHIunvZOrPar19VAysbxuvn9Y1l8//jt7yZ0TBCJikM3N6etdbW4=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SI2PR03MB5628.apcprd03.prod.outlook.com (2603:1096:4:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.8; Sat, 15 Oct
 2022 02:27:20 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::246:65bd:dfb5:b96c]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::246:65bd:dfb5:b96c%7]) with mapi id 15.20.5723.014; Sat, 15 Oct 2022
 02:27:20 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 08/12] ASoC: mediatek: mt8188: add platform driver
Thread-Topic: [PATCH 08/12] ASoC: mediatek: mt8188: add platform driver
Thread-Index: AQHY1N0E4TAVmPuXsEGI3cvUVfYPj639/+WAgAKys4CADh75gA==
Date:   Sat, 15 Oct 2022 02:27:20 +0000
Message-ID: <1f7176b1873088cedb975e96bc16c089d80f16c7.camel@mediatek.com>
References: <20220930145701.18790-1-trevor.wu@mediatek.com>
         <20220930145701.18790-9-trevor.wu@mediatek.com>
         <50e12f7a-bf15-9f27-0606-5d23b310bf2d@collabora.com>
         <3c29ee7116597caf5469bab813ece3bb45723b84.camel@mediatek.com>
In-Reply-To: <3c29ee7116597caf5469bab813ece3bb45723b84.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SI2PR03MB5628:EE_
x-ms-office365-filtering-correlation-id: 4738ace5-1401-4d52-ddfb-08daae54c96b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0iaFihIU/TJTsM8HZp7ZHYUu0YI5pQUOivWG7yhI1F01l4LDXyWCFwAwQzubxsclUkt/Rk0zOSrb+7IyB5HwW1PjLenfvDgIsvWHGN20oK3i783Bm9RmMWEu19BuyiIimQCF/vJAEtwZBITCs1sWzP9dT4klwVJwQuTxGX9KRBD9YCajbjohcX64xIiEDQ8GM+/zYahMnX4gkTvBEve+ViKZ1YtYSGRi4ujhivCU1XTGxJxp+iYbf0HSnpJ+1bKICKFTDWJcUDVaY+o3RV5l9E3KB8AB2aaZtxFxGlYS7oRePuW2CmTnFPqSnyM92W4IvtFtmEzUx92/BOnOsNxjLbY8GNSjDQE6ZvfKkjaiFsIngiO2RozGgtirbC4BgE+CND/KjajlEIF/LgHYd9Dbj9RtDsDzh7x1gBJRMUyv4oInkYGzyMBeonZB7Us5+VPmdd644FNF6Cb+Syp5Ni4i/xSKPEdSUlHEdHVREPZNmOn3b60yxuH3che0IuF7p04F2o4v0bvRfmSFKsRshgypR5WxocS3NgM7YHhhYMERnHiiqfo8T7gaylai2LPDjylWPMmXUo5yJYl6OUv3KnXYH+46HJYtDo6ayxI4hcglgb3Njve2W+HzQccc3IKLj/fPtokpfYz4IdusG7V+ZCBml6cT4ABCfBudnsU577eMIyTjtlmfFot3nmFGyy12tW0yJ1J2yHnjcSbXqSRBwUJuk/OLikajmQE5x78O3vj0KHAJW5R7S48GR6FUXWW+QYV6rYo5yNNvZY+SOclLoyVbOOj2h4chzlYc1rVmDeJB9sOEk75CVvDJgVRtJTQsONqLo+I/RCyeCsmbxV5AyI0VMHEEzFCnKjiuCj+PmSnn6Xw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199015)(85182001)(6486002)(54906003)(316002)(6506007)(2906002)(186003)(122000001)(83380400001)(110136005)(4326008)(2616005)(91956017)(66446008)(36756003)(66556008)(66476007)(8676002)(38100700002)(66946007)(76116006)(64756008)(966005)(478600001)(38070700005)(5660300002)(71200400001)(86362001)(26005)(6512007)(41300700001)(8936002)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d01KZ3B5Z2x3U0ZLWjNGNEZSUmhNSEdrdnA4emtpL0lyRlU1SVUzTGdlOERH?=
 =?utf-8?B?cEk1SHJHcnlPRHNtTjFvVjJhZ3FWM1E3ekJ3WUR0UUp3QzhIRVZUSjhiQTUv?=
 =?utf-8?B?TklEUUpaaXZCVk5mVUpuam5oL0pRT2F0dFR5bTV0SXVjUXh0dUkyZ1JwRCtp?=
 =?utf-8?B?MExCV01TWlF6R3ZTVHE3N2Q4T3VYUVh3ZE9UemhrKzNhLzVsVDdkQ2NmbExU?=
 =?utf-8?B?WXlQNmVqK1hhVkxxT1NwQnQ1N0ZxVkxqUXVTRTlCU1Y3WXI4aDRXOW9ZZm5W?=
 =?utf-8?B?TTZRU0FZWmJyNlNqSHd5QmVGNW92UDZzTTgzUGI0aGJHbTkyNitYSDRWRnFq?=
 =?utf-8?B?RnFySFIvOW1VQzNRWklWY1hqektXbUhVN2ZCY3ZCZjZVUUh2Njd4TkxWR21Y?=
 =?utf-8?B?bDZWQ2lBRVgrNHk1WFdtUjVpWWdnQUxwWk8rQSt6RjJrSGpXZnpRd3NHOFBZ?=
 =?utf-8?B?UDU0cnNtNE1HRVBrVGNoWGFvUGZGbk5DMTdXa01sR0Y3eDBXNUZJdThtRTUw?=
 =?utf-8?B?Vkx2NFZtRFBOZjN6eCtSUFllK3dYRFk2TW1nZmEvSVVPRjIwcFpzQ1A4Y1hW?=
 =?utf-8?B?YXlCVTBWTFg1Q0lrNFV3dHRoWVBJSmtnaFJHSS95ZHd6S1hWcE04TEFzb0pI?=
 =?utf-8?B?bmVOdzFzc01BT013Y0JFRjRoSUtZSEdtNTNFR2pUOVpvMkx3Y2ZGZXpySGw2?=
 =?utf-8?B?M1BXbHBZQlNwZkVoTU53eERTa1kwbnRVMEc2YlkzK0ZZczNrNkl6VnZ3STNu?=
 =?utf-8?B?cDBRYWRjMFRFRDcySDFqNStEMm82eUh3SkdoUmpnVUswd1dYS2hLaWg1OHZO?=
 =?utf-8?B?VUlwRVgxdUE3d2pVb1c3aHMxdmxEWjF2dEhwb1BOM1RFb2QvMkhLYjBMYzgr?=
 =?utf-8?B?WGJLakVVbVZ5TmtTdEFzNmhhTFZIZ04xMFJPbjgwd3BrMnY2S08vQ1JkZmMr?=
 =?utf-8?B?U2tmcjZJaXRpUXpzZVM3WDhiM05XcUVyMWo2OHRob3FaQkd0WVkwelUxTVdN?=
 =?utf-8?B?YjhCeGZ4aXovYnAybGZsYmF6aHFOV0Jwc0YxdDBhSHFrU3dJT3MvTVEyYU85?=
 =?utf-8?B?dzNLSUlraFRzY1I5WEszeEpMNDJQRDR1bzJWdFAxcnZqZ3pKdjZlMnhBOFFx?=
 =?utf-8?B?ajR4cFVlZVg3ck5VRXpTRzE3NTRvNWc1a0R2K3V5cndXQ1A0U2dmVG5aTlJM?=
 =?utf-8?B?T0t3NjFncEtTWmphcm9sK1B4UUw1WG4zYmhKVExJb0RSYTFLOFdZb3BJU1F5?=
 =?utf-8?B?OThkYjdSdGx2a1M5WkYvak9MWi9rM3NXbDhuejRQUFhzZjNJdWxQUzl3ajda?=
 =?utf-8?B?QmxqZGpscE84MEowV1N1c2gyMWFpS2hQUEpGK211L1FJRGpod0hxVmR5ejZi?=
 =?utf-8?B?NWdGS25IemlwRmhiRHRieGxTQVJwM1Q2dVRPSkhQMUFwTlREaDFHNGlYMVNt?=
 =?utf-8?B?UjhsL2VudHZibENmTnlzOWQrK1FtOFZGZXBYTjFPdEhSenNCMFpCaU8vSTdt?=
 =?utf-8?B?dXBwMjJ0NnVtUXpqeG5BV0IvSE0rckNSaFRQMVNka3ZZcjFPVjVCQXBRaXZZ?=
 =?utf-8?B?MUxBZjFXVlNCUzkzMy9uK3cvTTArMlI5djFsd0gzckRFMk42ZmlLTlZzU2lI?=
 =?utf-8?B?Y3lNbTNFSWdwRWl5bnNtb20yb1NiV1ozZzhDV2twTDF2WkZmYm5NeHdxREtN?=
 =?utf-8?B?RXdQaFdOcVlkVkdOSG1VNjRjZk9GanJWdGFOVjVGeUpoZzV6TkZORzhWNHFD?=
 =?utf-8?B?bVlBQjBxTXBYT2FSWmpCb3pKRUJmRkVEOHFtLzN4bFQ1MjVUS2E2SHpTSkpP?=
 =?utf-8?B?d3Z5bmxnblYwNFA1K09aakJWdkxRa05sVHJqYnA0QjlrcGt5VHFTM3QxVWwr?=
 =?utf-8?B?SmY1bVByTTJmNGQ0QWlyK0JKOXlTY3V2ZkpWZGc2b1lZQ1FkNldXcnFuVnpT?=
 =?utf-8?B?dW1HS0hzT0lMZTduc1VOT0VzMU9XSXV2REM4OWozOGdROHV6YURNcmxSTGE0?=
 =?utf-8?B?MUdPUzdUY0w3YXlLc1pJTERKYXV4MHVrYUdMM2J4TE9mcFZRTGRuUkF0MWtF?=
 =?utf-8?B?VnRVN1NoQVZzMGgyR2U2REptVXFNLy9lNWJEMzFkUzFLYTlmNmlDOEJiSlg0?=
 =?utf-8?B?bVVuczhVK0xhTEt3Z0hIeXdDSzhJTU11VzBMVUYzZ2RDNjJWR25EZ0o3eTFN?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F2DF42C7729C24B8DA6607ECC6AE881@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4738ace5-1401-4d52-ddfb-08daae54c96b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 02:27:20.5965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOo2P4DC45msSe5e06Ia25HwjOoYjSjbP0WatzNano/U5YiZ10sV0Qh9feuRUm2bUZqzztsYvN7qxdvXOrtR/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5628
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTA2IGF0IDEwOjQ4ICswODAwLCBUcmV2b3IgV3Ugd3JvdGU6DQo+IE9u
IFR1ZSwgMjAyMi0xMC0wNCBhdCAxMTozNiArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gd3JvdGU6DQoNCi4uc25pcA0KPiANCj4gPiA+IA0KPiA+ID4gKyNpbmNsdWRlICJtdDgxODgt
YWZlLWNvbW1vbi5oIg0KPiA+ID4gKyNpbmNsdWRlICJtdDgxODgtYWZlLWNsay5oIg0KPiA+ID4g
KyNpbmNsdWRlICJtdDgxODgtcmVnLmgiDQo+ID4gPiArI2luY2x1ZGUgIi4uL2NvbW1vbi9tdGst
YWZlLXBsYXRmb3JtLWRyaXZlci5oIg0KPiA+ID4gKyNpbmNsdWRlICIuLi9jb21tb24vbXRrLWFm
ZS1mZS1kYWkuaCINCj4gPiA+ICsNCj4gPiA+ICsjZGVmaW5lIE1US19TSVBfQVVESU9fQ09OVFJP
TCBNVEtfU0lQX1NNQ19DTUQoMHg1MTcpDQo+ID4gDQo+ID4gVGhpcyBkZWZpbml0aW9uIGdvZXMg
dG8gaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrX3NpcF9zdmMuaA0KPiA+IA0KPiANCj4g
SGkgQW5nZWxvLA0KPiANCj4gSWYgSSBtb3ZlIHRoZSBkZWZpbml0aW9uIHRvDQo+ICJpbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9tdGtfc2lwX3N2Yy5oIiwNCj4gSSBzaG91bGQgc3VibWl0IGl0
IHRvIGFub3RoZXIgdHJlZS4NCj4gSW4gdGhlIGNhc2UsIGRvIHlvdSBoYXZlIGFueSBzdWdnZXN0
aW9uIHRvIGhhbmRsZSB0aGUgZGVwZW5kZW50DQo+IHByb2JsZW0/DQo+IA0KPiA+ID4gKw0KPiA+
ID4gDQoNCkhpIEFuZ2VsbywNCg0KSSBmb3VuZCBvaHRlciBNVEsgZHJpdmVyc1sxXVsyXSBhbHNv
IHB1dCB0aGUgZGVmaW5pdGlvbiB1bmRlciBtb2R1bGUNCmRyaXZlciBpbnN0ZWQgb2YgbXRrX3Np
cF9zdmMuaC4NCg0KSSBzdGlsbCBwcmVmZXIgdG8gcHV0IHRoZSBkZWZpbml0aW9uIHVuZGVyIHNv
dW5kL3NvYy9tZWRpYXRlayBpbiBjYXNlDQpvZiBkZXBlbmRlbmN5IHByb2JsZW0sIGJ1dCBJIHdp
bGwgbW92ZSBpdCB0bw0Kc291bmQvc29jL21lZGlhdGVrL2NvbW1vbi9tdGstYWZlLWJhc2UuaCBp
biB2MiBiZWNhc3VlIHRoaXMgaXMgY29tbW9uDQpmb3IgTVRLIHNvdW5kIGRyaXZlci4NCg0KVGhh
bmtzLA0KVHJldm9yDQoNClsxXSANCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvdHJlZS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwLmM/aD1uZXh0LTIwMjIxMDE0I24zNw0KDQpbMl0gDQpodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvdWZzL2hvc3QvdWZzLW1l
ZGlhdGVrLmgjTDgzDQo=
