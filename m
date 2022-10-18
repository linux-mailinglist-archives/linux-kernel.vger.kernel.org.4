Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D314C6023B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJRFX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJRFXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:23:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D2A89CEE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:23:16 -0700 (PDT)
X-UUID: 2ef743c5e663491999e4cb73d3d15dde-20221018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Vba2RLDvNlhTp2tjdaxhZZ9OEAUQlrmO0aNmeExZCbY=;
        b=UYWer0bglBWxknanqXkmOtnSPb9896/11z+TryNNRfWy3c5lOG6KKb5BhGFoIqZOXwU6EY6zUvQJN00IQrz5nPysOm9/hbiI47yKlEQl0FWDxRoo7toEXnGfcsWB8m5FKNb6tPSYgJrJeLqXtT8q/3mnK4Qp+bLG2iCgXyvn4gg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:3bf7af1f-4666-415c-a100-23dbeacd157e,IP:0,U
        RL:0,TC:0,Content:9,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:9
X-CID-META: VersionHash:39a5ff1,CLOUDID:16851ea4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2ef743c5e663491999e4cb73d3d15dde-20221018
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 936196801; Tue, 18 Oct 2022 13:23:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 18 Oct 2022 13:23:10 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 18 Oct 2022 13:23:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPHqMMpszPf8iGmOz6ePLoyb4QpCpZV8EiXrwksbB6MA2q/jocpjhuAiRkUMt07Esow50uyo4kIElxdB7JOBRVLED3R+7M8cXGXFGKgLCtYC7n/zkLVJARdulTYNvZ/bMno/qD7JB2DgyKCOCkPx+mrDJLMvwIQ6a1akM3t7hTuV6pB4/NAHUqLlLEYoQfB6PSGCViy+j806hHNZAeoBu7KrZ4GDS4m/P5WGJ2cEFDm8LH3mCARtzyOmgrOt3bvv6e2PjIrvMAujdvGibWrsRFHzOhFiFpIpkAknSWaIfzMDZ1vlFZzETNEpxvbHdwJbggSzzSM7f8tZ1XtQCJ6UrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vba2RLDvNlhTp2tjdaxhZZ9OEAUQlrmO0aNmeExZCbY=;
 b=SbXqyhgTxKLW7yMFkzIbb6CBkAeLLIneqCzv6qPZEwXkRdkJ+3YTKWMxLLd90eNxF9Gt2oI+EEN88JWRZjFuZEU1xcj7h9VgO4SLWDJnomNn3G7huQJZuu8+WlaMX0aD3P8OOiD+Ese1t2eQDCY873NhcqX1Ivw9y0Ko2C/AxvMcblZ1hKIhAiIXlJD0R79d+8rWHvLw9gGf/im64T6swTQa43JJVMwU1RSJLHpMnquDA/Nm4NBTX/AXLWF221W1Gn/ybF7UZQUWyJS4KWnG7p2JxeyxlMXy5K7mwk3yaIjvxnhzh5gL2WSYvo3U8sicwwVhTTzhQb6acjLXBIxoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vba2RLDvNlhTp2tjdaxhZZ9OEAUQlrmO0aNmeExZCbY=;
 b=FRkrFAWTmfIaWD2Bv251bGhYP9jnr+FMVUZeb6SQlq63C+27/h710H9+on2AHaojCCdaTDTK6ELnlyo70Y9yjOH/vEe57iCAXBPdmMZzsMSV82Xwi/WOHXhe1K23GbZKbkWdr6DNjmfF60N3UTn73DVe5q6poxv4kwTXa5wTHiQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB5541.apcprd03.prod.outlook.com (2603:1096:301:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.8; Tue, 18 Oct
 2022 05:23:06 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::7559:b2bb:eee0:fac]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::7559:b2bb:eee0:fac%5]) with mapi id 15.20.5746.015; Tue, 18 Oct 2022
 05:23:05 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v10, 1/4] mailbox: mtk-cmdq: Use GCE_CTRL_BY_SW definition
 instead of number
Thread-Topic: [PATCH v10, 1/4] mailbox: mtk-cmdq: Use GCE_CTRL_BY_SW
 definition instead of number
Thread-Index: AQHY3JwTvWwzZJS/fkiQM3QHOmeeBK4Tqi6A
Date:   Tue, 18 Oct 2022 05:23:05 +0000
Message-ID: <fe7a8c3f922113c2d28a34f0ff68e57e073561f5.camel@mediatek.com>
References: <20221010085023.7621-1-yongqiang.niu@mediatek.com>
         <20221010085023.7621-2-yongqiang.niu@mediatek.com>
In-Reply-To: <20221010085023.7621-2-yongqiang.niu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB5541:EE_
x-ms-office365-filtering-correlation-id: 22ed40fc-fc0d-468d-eb88-08dab0c8d62c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LULyqDTkGm/gml1xIefJDsGDzHrLJ8obSvaXvMzPeYW5u5POTag8nbFxeTuyFDG6xFBRs9ZJw1Os31ZJMjG8K142E9YGwV7rrjbY5o0peCSdLIad/kcmTfIg/m2sc/w6DApCctztNpNd+4pjGxW7gXWz/LuL8Bk61j61wcCAbok8zHlPoQ5VE5cHnL6ZdAZfK+bsTH8gJNnE8xgAj1CjQVh+8Yyxqyxxu7eDICtu8qLIayrq6idzEsCHpqI8u/EZfNH+4fwVlbj35F0B5KFEeWlBNDgRNKNf4az9+/ekhLTgdv3n6ytKTaMffL87PpGg2kbE9mv/VsO4tJBckBw569D7ulkq2s5ofNsE00QlridDRq2lCO+yUoZ9NWkjRMLudqriR0sIinHreId5AdS2rs44rh6VoKy4nIiVZiPXHDSDpsyvLapDsGJ0wTO2Cfy8lhWHYS4N/gzr16BnT+7iW1aI+qjKxVmvXqBziIDe4YCo5TVk7Lrskj3oesktQx469tIGPVW42jxNbRyWoRLRm8I5tByTo6g5MS/8aqS7W822ILsQXtcuftnQ4S20U0zKEHgX3orgDhOSdDspCNJkB3jo00owLhyJ8oTSKDW8bRK6lx33WmQrzOmEkQr5gZYAYtN7xTMPC6I3SyciCDFgZIFgwKm1O+bUrudiGx6ZF8kFWewfx3cz6bLf/BkvH2HUjjfC8/WHfPFwoXdva+FAhj1M9nIlkCX09VCSF4HVJbM+8sdY1R+BUpamfpKUCTpr12WTvMLSmpZCp2Idi3Hl3fe42CpgZtnqGmuuIA+aBUe9wQoFaEwNcYKiTR0Yf+Qr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199015)(38100700002)(36756003)(85182001)(86362001)(122000001)(38070700005)(2906002)(4001150100001)(186003)(6486002)(5660300002)(15650500001)(6512007)(6506007)(2616005)(26005)(83380400001)(54906003)(478600001)(316002)(8936002)(110136005)(76116006)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(71200400001)(66946007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWhoWEF1eno3dXR5MmxpQTEvQ1hEaGk5Vkx6NXFYK1hrS20va1RCYjhqUFZv?=
 =?utf-8?B?M1B4TlJOdUFyaXM2cElxRlgwOTNGTTBEazM1Vm5NclQzMUMrZ29oVlBveXQr?=
 =?utf-8?B?UjhKNk5jMkxEeC91eFNmaGNTUXhnVzMyOUdjeG1rMkM1SWdPbEhUTE5Edy94?=
 =?utf-8?B?K0xQNnpJMWFxS0ovcDlBL0l3NmgxMW1TNlJzbXVSalAwOXhKeElLSElzdkxa?=
 =?utf-8?B?ZDBJZ3FZTWdLYXNrLzBoeHM1ZDVScVZlZTRiUTQ3MUZEdEUzRU9Hc2dJRW9D?=
 =?utf-8?B?SThGdkRGdFpTRWpPZHY5VlNpTkVJbXZXQXBmUFZaTjBxSlU0bXovanQ2VUJy?=
 =?utf-8?B?ZHFKUjhlMmM3V3E5QlBZYk5kbFVlWVJVbEtnbFdvcmJ6MlZXOGtPWjJTcGpm?=
 =?utf-8?B?UERwdE5zQ0NhZVE0c3Y0QUZxSzVwMU9WQnpTajhJanlnd0lEV3lIbVNCUFN2?=
 =?utf-8?B?YVk3eUh5eEROdEJVeEZETEFIWjNBbERxRGlGRlVwQ21vR05hSWVOQmF6ZGFo?=
 =?utf-8?B?Wk5DbE9TZzlmZGJYOWIzZGxUWUZxMHUwQzYvazVJMUtYQmRGT0tQTGVKTDU5?=
 =?utf-8?B?OTd2WTFJbUh1dlJuNGQrVlFuTGh1d1duY0tSb1BNWUpmN2p1ZEZ5dFIvV0Zt?=
 =?utf-8?B?NWRyL2dIZVZXTlBMcjdqOWk0ak4xWitCVmpFS0xrM1RCM1Z3bS9kMmtRTTlt?=
 =?utf-8?B?SXoydjNUdDZHb1E0ZHRRN25rbFptRUVDTkpSam5zU3JqTStrYzFpUHJySFd6?=
 =?utf-8?B?YTdLY2RtY1h4aXZDNm4vT3BUcmNCTnptYW5SUXNmY1BZQ2diVjQwWFE0WXdD?=
 =?utf-8?B?bW9zMjd4aEtZK1ltckM2cUxiMXgzMjQwTld5YUlKZFRTbndST2JUQnNiTW9x?=
 =?utf-8?B?WkNjVEE3UFlnYi9BZmhmZ1RwNmFxR2p2Zm83RHVtNUNGRTZrLys3RHkyOTFT?=
 =?utf-8?B?SkI4Y0tnT2xGYjVUR3RhUDZoaDE0U1dqeHFMNEZBTjdIOWJIQzRiMU84d3RZ?=
 =?utf-8?B?RzkvbWd5cFQ1a2UwMm1uOVlBem9GVXJRK2U3SzNZWHppMHIwd2JIS3ZMRjg4?=
 =?utf-8?B?ZWdOTDZtb2VUdC9pTU5Ld0Q4TTl5LzJiajZmVW55UWZxZHJNRzVLVkl4cGxp?=
 =?utf-8?B?Zk4vVG5TZ3lkdC8zdER0dFVCUE5za1JtaUc2eElFT2lKcGoyeHJHUEFUS0dk?=
 =?utf-8?B?bS9GSmVIRjM3UThPRUZ4Qk1pVElZKy9NWEo3eEdLVDg4cWZVZDRpeVd2T2xF?=
 =?utf-8?B?ZDd4cUdWd2lUYkdFTnpkcVdqRHM3bjdOdWdDa1lMZ29LZkFOVjBkSUpGQjdr?=
 =?utf-8?B?RGlwYWxnZUFJRWh1L1N6SFVqMW91aVRPK2I2Y2ZDUkZDOFBmS0V2WmhqOUFV?=
 =?utf-8?B?SEl3L2RCcG01UTVya0o0Z0JJMEdOVDBDTUtmTlJSU01hbXRGZEo2WEtxVXZZ?=
 =?utf-8?B?aEJ1anhkdU94VzlGQlBBNExZbVJpQlU2aHhoR1lsK2t5RitobFF6VDJRdjZU?=
 =?utf-8?B?bm5TZUwvQVdTZWRya3Z1ZG9vbnlmUzhFUHpOVUFiV1hpMS9yV3FMOTZQYmJ4?=
 =?utf-8?B?QXhwMWlWWDNKWXYrVDJSWkNJQlVrYmkwNUFuOWVpVmw3QUl3d2tZNlJRNzRm?=
 =?utf-8?B?eEJJd05MZUpEUnp0Q3Q5cUZqY0x1N3NoaWxaZHQ0Myt2SDArMHl6SEZWT3F3?=
 =?utf-8?B?V25pSmw0ay9KN04vK1NUNmxaUXNFOXF5MTNHeE5wTjF1cWVaTVY0eC9QeTFo?=
 =?utf-8?B?OXlpdmNtQ0pMRkNZRlRiYm5TSnpFeUR6b0JxT1pWQ2VvVGZkY3hoZUx1L0F6?=
 =?utf-8?B?bHh0c3hOL0ZqZm42Qmh4YndYNFFXOERXNTcydUF1TTFBV3QvQ3FUYmhzS1FH?=
 =?utf-8?B?YkFWdGpWZVErRFJHcCthMVNiaHd2bjc2YVlKMGVobVZIK3BnYUVkY2pIWHhQ?=
 =?utf-8?B?NFQzV2ZFT3lIWEhKUmE4QUhmRjEzdVJOb3JPeXhnNWM4TGlhcmxsbldkdFVo?=
 =?utf-8?B?Qi9FUU54QU9sWEFMM2JuTlhLanlYZitrK3N4N0w0aFlUZEFrRzg4V3RVdWFm?=
 =?utf-8?B?NGRDVms2NnJJOTBIQzlnOVAvdStxQ3hWam1aRjNnUmVSb29FRjRZbkJWbzU1?=
 =?utf-8?Q?y2wKxudbd7Yrtj6P1K5LHUSGm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3CC38913A90EB479A212741A4B13558@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ed40fc-fc0d-468d-eb88-08dab0c8d62c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 05:23:05.9093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y03RPrey63EyC6R4/zkraH3Bv7Hwh2J18OPwff1MmY61gWxkwZLDL7W3f8dPNuBr8BNnRowTxeypGuzFFrbDKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5541
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gTW9uLCAyMDIyLTEwLTEwIGF0IDE2OjUwICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBVc2UgR0NFX0NUUkxfQllfU1cgZGVmaW5pdGlvbiBpbnN0ZWFk
IG9mIG51bWJlcg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRl
ay5jb20+DQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFu
Z2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmMNCj4gaW5kZXggOTQ2NWY5MDgxNTE1Li5jM2NiMjRmNTE2OTkgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gKysrIGIvZHJpdmVy
cy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBAQCAtMzgsNiArMzgsNyBAQA0KPiAgI2Rl
ZmluZSBDTURRX1RIUl9QUklPUklUWQkJMHg0MA0KPiAgDQo+ICAjZGVmaW5lIEdDRV9HQ1RMX1ZB
TFVFCQkJMHg0OA0KPiArI2RlZmluZSBHQ0VfQ1RSTF9CWV9TVwkJCQlHRU5NQVNLKDIsIDApDQo+
ICANCj4gICNkZWZpbmUgQ01EUV9USFJfQUNUSVZFX1NMT1RfQ1lDTEVTCTB4MzIwMA0KPiAgI2Rl
ZmluZSBDTURRX1RIUl9FTkFCTEVECQkweDENCj4gQEAgLTEyOSw3ICsxMzAsOCBAQCBzdGF0aWMg
dm9pZCBjbWRxX2luaXQoc3RydWN0IGNtZHEgKmNtZHEpDQo+ICANCj4gIAlXQVJOX09OKGNsa19i
dWxrX2VuYWJsZShjbWRxLT5nY2VfbnVtLCBjbWRxLT5jbG9ja3MpKTsNCj4gIAlpZiAoY21kcS0+
Y29udHJvbF9ieV9zdykNCj4gLQkJd3JpdGVsKDB4NywgY21kcS0+YmFzZSArIEdDRV9HQ1RMX1ZB
TFVFKTsNCj4gKwkJd3JpdGVsKEdDRV9DVFJMX0JZX1NXLCBjbWRxLT5iYXNlICsgR0NFX0dDVExf
VkFMVUUpOw0KPiArDQo+ICAJd3JpdGVsKENNRFFfVEhSX0FDVElWRV9TTE9UX0NZQ0xFUywgY21k
cS0+YmFzZSArDQo+IENNRFFfVEhSX1NMT1RfQ1lDTEVTKTsNCj4gIAlmb3IgKGkgPSAwOyBpIDw9
IENNRFFfTUFYX0VWRU5UOyBpKyspDQo+ICAJCXdyaXRlbChpLCBjbWRxLT5iYXNlICsgQ01EUV9T
WU5DX1RPS0VOX1VQREFURSk7DQo=
