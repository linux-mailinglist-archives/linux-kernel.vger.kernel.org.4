Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F5F6EC3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 05:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjDXDcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 23:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDXDcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 23:32:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C0319B0;
        Sun, 23 Apr 2023 20:32:12 -0700 (PDT)
X-UUID: 96aab00ae25011eda9a90f0bb45854f4-20230424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=r9QsVWGynBeUZIbDx5N+XNTJUXAUH9k22ebwNSJNLKo=;
        b=k0dLpNNmIpQMMK8ALsHE8/oJzeSz7fkfTSdqOsnJPNuVcER3cOK9Xpm8ehgbHKs8pLK1+r6kNMXROCaLqpla/x0IS61ncxqTRojGCp7rlmbB9GUiatgAR8NMEy7EEZ/ytPbwP3AZ3+jjeNSf57yrVME0kvekPChFfXLX00UaLnM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:502c97e7-344c-4f14-81f1-14bafd42dadf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:00780085-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 96aab00ae25011eda9a90f0bb45854f4-20230424
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1835470973; Mon, 24 Apr 2023 11:32:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Apr 2023 11:32:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 24 Apr 2023 11:32:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxCdsdS/xi7W35bGYFStN3NRkCt5YsJZ/l6Pxz+ArrihlPt92ap+ptwNP+yu6mISlf16D0cMHnyFx0qS293R+oIDcY8KSzV0zJw2ylsFqh25mrdGim5dLj30yho7Q5AzsBQQb8QB6FNAI22S9oyCXbCnjtHIv9u8sonIbj6eiHN6eFMo9O4IKCUN6ERV1IFWnI9d5kjZkcXdfVBrV/0M6T2b96W24hC9fZ49HPSS/ZoERC9n2pIjun5wcVFAA4Fow67d8yJ2uIw+AOLjOebGIMdQOFU3pwNGA3Fekjk1Veu2WLip2KMrCVkOoHiVOIrHZJ7t9ea6PFlWHLDo3o2C4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9QsVWGynBeUZIbDx5N+XNTJUXAUH9k22ebwNSJNLKo=;
 b=TC/gQqaqI2t5blZPB2OZgIRHZ/6Os/zeZoTmSEEKCSDkZwpyZgvqMj0W+eyd/E3gx5mZeEw5WDBAFNwJ/JgamEpqNP32CQSaDFOOxIT+m1OkAgs5bxNGd7hcwvK9iucU+eCbgN+tXARCKJVH1hQ/WmjvtUYaqqf4bsMPXHrqmHDI+AZ4bm8XMph2Ocfiwh7HHCyrTnHzy5i0SWJepb56ntgPnQk8nu/7ugNFIP9OINcKtGDX+cZ90/2Y2fCVi7t970gP2OHyhqBsZw0ToYrFUNXuu0nKVsF0Dmxbd87XDhjvvMPy0gEjTAVgbx3Vudl89M5zdI+xJL+rsKAqpZiqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9QsVWGynBeUZIbDx5N+XNTJUXAUH9k22ebwNSJNLKo=;
 b=voQUc7BHCKlB1PYPTENIxUm0O8uB/HTwR4GCOGsn5wxbUynuk2/H1yAPuXJjTcLXxDQmtS6gJrD4Fl47QngtKEAlpurQkVCD8xdwua89ieLK+aZxa4R+plBUfN3NLOqKNRsR45Zfuz+ox7VBl82OAbyR2/dFVaElxARp/IEMHkI=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYSPR03MB7450.apcprd03.prod.outlook.com (2603:1096:400:417::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 03:31:03 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 03:31:03 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Thread-Topic: [PATCH v2 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Thread-Index: AQHZdDllgLpr6s2YxEKDhVFHJHBCTK81+G+AgAPZgQA=
Date:   Mon, 24 Apr 2023 03:31:03 +0000
Message-ID: <a19a8b8f0156a2542e488f1be13facf45f03ccb2.camel@mediatek.com>
References: <20230421100905.28045-1-trevor.wu@mediatek.com>
         <20230421100905.28045-8-trevor.wu@mediatek.com>
         <5e622e88-5287-1ffc-aa9b-c7c85a661fd9@linaro.org>
In-Reply-To: <5e622e88-5287-1ffc-aa9b-c7c85a661fd9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYSPR03MB7450:EE_
x-ms-office365-filtering-correlation-id: b31acfb8-1d4d-4107-2901-08db447454d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hsXMbgIxN9Zin1E3HjzfBWJu9vU4U3NyY2UpYYy8qFm+Iu+dO/Av+XCqzCpgiXo0ERzS+foN4MG8m9Vj7IjeuWpbPasI3gbQpXCPpRODu+gWj/IZcHu3owRsfqRIifkWYFW2hFs1MRFZuo73KNea98Yo/+VrHEkUJX5vWkWicbjMuX1qW2nwNkiyBLbVJkzp9yO2f03N8RnMxt9yoO5y7qdfRwzo5wqg+1XT6+KWF7GnWA3IHGesBrjBEYYy5hYZJbO2zh5XdWeUtdAymdlzpzLTD6KEOiQaCGavxRpXoov2PVKx6ykV1/TGeC2yOER3WkOmYUvcwA222/1fcJ5bLPRzyAgaE4RRVZWIEkF1tGmGTURfGavII3ZQ3K9ucOsk6IsF7rF6hcuRavew9WW7z7qlWewAtR9EE0BGsSnUMMlGGPYrOs1309ggDOp67ZGXL9vts2DRoj+2igy6T1h9dahXjm5c5lt1f/hhg7GsPtI3Cc2M7PcsXgZukd6GPFtV1hlUvKIk589Z7qLBhotuHebM8LFYbw6YH+5nJm3ekeGw0xI9nMmBO+0zZoHgzSHMmkCSPpWHokWG4R80K3yHBG/LmoYZRGp1igpRosnOwtj0+pTdP6MvGPmPuS4xCFXFJAMpXcm3iHGpkDtynIoLjS54+El6AVgk4NbtQIHlhZUcWTOYwS9Ou5h5qoRP7Pm/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199021)(110136005)(54906003)(6486002)(2616005)(83380400001)(6506007)(53546011)(36756003)(85182001)(6512007)(26005)(186003)(71200400001)(478600001)(8936002)(8676002)(41300700001)(38070700005)(66946007)(66476007)(64756008)(66446008)(66556008)(76116006)(91956017)(4326008)(316002)(2906002)(86362001)(7416002)(5660300002)(38100700002)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTdXVkpEaE1UVzdzYnRidWROTTNwcUZXSGJyUk1rb1N0SEJGQ2dJbGJlNlVa?=
 =?utf-8?B?U1l4K3FRQVhwR1pxaTh0YkZZY3hlZGRlSmo3c0c0dzNZSCtROW5qMnVGcE5x?=
 =?utf-8?B?UGNwVFIwbzk2Vk8vOGxRc0xsYXhCK1Z4L2hsT1F3cjdhZE0xcW12ZDA5eHFQ?=
 =?utf-8?B?RHFXQXc1RHBUVXF3cVlZOTQzdDJVcm1xbkx0WjNIcDZ5Q25jdm5uZUxzZG1Q?=
 =?utf-8?B?blhyWnhhSHk1SlIvSTRtZzFJanNaRHNyb2labG1JVnpXMFRvdkJsNmMyQ1Q2?=
 =?utf-8?B?MW4xdXBJem90dnp3cWgwaHR3NVFQbFFOdW9TRzFvWGFIWlB3QnYvS25qcFZU?=
 =?utf-8?B?UzIydkRhZFU0YXcveldpejFMNXNRMmZEenkzWk5pMCtCVTFuL3JmMXBBc2px?=
 =?utf-8?B?cnNjVkQ5bVpJMmhMdjUyTGN4VHF6eDlRc2lBTDRkL1JqMkp6VUYxb2JwaXY1?=
 =?utf-8?B?MVRHNk5BZFhneWo3bEZGNWlhYmZPY1lla2ZEVmx0V3NHVGRKa1hMcXVudTNz?=
 =?utf-8?B?eVh1RzZjSC9GMzFJc20xSXdCTDNQaElJVC83ZlhyZUFaenA5QWJ3eW5Xc2ZB?=
 =?utf-8?B?VGJmeHpWTlNMTEJVQUxBeUpDdXBRTktYanFKeTdsNUdWbU9RWkFOM1ZRMDBl?=
 =?utf-8?B?cVhVajNiUThJcXAvK1FnWDNlcEk4Z0daUm10OWpjb01tSVhwdUhFcWl6REE4?=
 =?utf-8?B?SitPMzRFUGFqa2hQSUY1b2VwWXB4bjhXb1ZRMlNOMzZWQUljeUdLbDgyc3BE?=
 =?utf-8?B?cStUYjI5WFNja2JzZWE1blFrMHk3OFI2dWg4eS93bjJLVEZ3NkxGYjY5ZCt1?=
 =?utf-8?B?empUT2d3WGQwc2gzbFlHOU0wdS9XY2FpRzZ3TGJBRm9iUlB6RUVLTk1GRHR4?=
 =?utf-8?B?WnhsZDFmZlcwODFudVl4dnRUMlNUOWVGeEV4MmpFcUd2ZmxwNlRJd0NyRVJR?=
 =?utf-8?B?VCtJSjg0L0pqb0VjaVJMN2c5Y0F1cVV5TWMwbWlFdVZnZmdHWlhqVVNIODlX?=
 =?utf-8?B?Y2x1bGtLblNZVDFjOG11eXdSd0w3L3hkcTBvWWFNek4wVEh3QnBMTTlnYUdO?=
 =?utf-8?B?ZTJ2aWIzRVQwTmpUdG0xaXZnK1pOakw2TFE0bnA1c3hQR0lIcUE5WFNReWI0?=
 =?utf-8?B?cnRMeDlZcXNwcGJ4VnZ5KytLNWtXcHZ0ZFVlKzRUTFR4VEJGU3QxZG9XTWY0?=
 =?utf-8?B?TU1jTkJTMm9QYkhhbDFyNHF6YVV0S3BHZGZFWE45S3IvbU5qZmJiM0JDbUZo?=
 =?utf-8?B?TWMwR2s4dGlMbzJvM2FXOWdtZWVEZHowOWl4RUhRLzg4TUtLU01pRjJPbHAr?=
 =?utf-8?B?WlJ1OE1rcm9iRHpQT05obStzV2pydjhHckU4UWNLeHUyeERTdmtOUDVWNnhv?=
 =?utf-8?B?SDBmTWpaV2cway9Ga0lLd0VYQzliOFE1Unk0WUZjN3Y5VkVoRmJER211SGNm?=
 =?utf-8?B?MHlvb3NSVTdib2t0YXVFK0NtZk43UGhaQ0tKL2Q4a1JHWlNPM0JlTERYeEov?=
 =?utf-8?B?TzRQZG1sdERVMkliaGtVQ0Q1cUZ4anFJMWJOMFN2SVRZYVpSRHVQN1NNa1Nn?=
 =?utf-8?B?TVZWWnVjMTJLTU16WHdDUkdUREJiR3RHM0lJL1JORzFkbVl4c01BZVBCZHo0?=
 =?utf-8?B?aGJYUUtNMiswM0dYOGZLSUdCYWowVzcyZmdVdThEN2E5dCttYTBTamhFQjRu?=
 =?utf-8?B?c29SdjFTVFlSMm9WY1ozTFZXWnUydnVQRzJ6TjlIVS8vcDBDS0dPaklvNTU0?=
 =?utf-8?B?NnhDNzJPdkxsMStLMFZaMUNpeVhSd2ZMMjEzRkJ2Z1d2YWFtYkRxQm5saW9q?=
 =?utf-8?B?a2hjSDdSbktOTHlsOUxQcTRLcVNkTHBOOVFXYzRIRk8zV2tyd3AwUzJBT3JT?=
 =?utf-8?B?YjBkcUJNTndtOExLSW8zYlQ4K1RGRExabmVIazlmbU5xQzQ4TWZpc21EUXRO?=
 =?utf-8?B?bWlsUHpsbkxvNStDbDNUNXNXM09TUzNDRUUwTVFOOGkyMmJXWm9JTGsySllM?=
 =?utf-8?B?WElnZzI4Y1BtL2tjbkEvMjIvSmEyR0RBalFiNGdhMkFrS0xWOElhQnVvaXBU?=
 =?utf-8?B?d1ljdGxFQlB5SnFWMXBicXdlZENqQlErbjNDODg4Vk5rL2FsYnBuQmQyanNK?=
 =?utf-8?B?T0wzNVczRGRwWStVRGFBNjhacStBeG5qNTdtSlNWNGV3cnBPN2NNRUVsN3Br?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B011B9DDC048844BB52FD940E2A3FD3F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31acfb8-1d4d-4107-2901-08db447454d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 03:31:03.3144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npyUtsDqRbI9Q6UKyYXTcUgQ2zMIJp3FZPJ9M3tYWAl0RNF95kVLrSIDgJapFCB4eR5If9bzv/+EJW+zn6yGnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7450
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTIxIGF0IDE4OjQzICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAyMS8wNC8yMDIzIDEyOjA5LCBUcmV2b3IgV3Ugd3JvdGU6DQo+ID4gQXNzaWdu
IHRvcF9hMXN5c19ocCBjbG9jayB0byAyNk0sIGFuZCBhZGQgYXBsbDFfZDQgdG8gY2xvY2tzIGZv
cg0KPiA+IHN3aXRjaGluZw0KPiA+IHRoZSBwYXJlbnQgb2YgdG9wX2Exc3lzX2hwIGR5bmFtaWNh
bGx5DQo+ID4gT24gdGhlIG90aGVyIGhhbmQsICJtZWRpYXRlayxpbmZyYWNmZyIgaXMgaW5jbHVk
ZWQgZm9yIGJ1cw0KPiA+IHByb3RlY3Rpb24uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJl
dm9yIFd1IDx0cmV2b3Iud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGlu
Z3Mvc291bmQvbWVkaWF0ZWssbXQ4MTg4LWFmZS55YW1sICAgICAgfCAxNg0KPiA+ICsrKysrKysr
KysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC1hZmUueWFtbA0KPiA+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC1hZmUueWFt
bA0KPiA+IGluZGV4IDgyY2NiMzJmMDhmMi4uODEyZTA3MDJjYTM2IDEwMDY0NA0KPiA+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxODgt
DQo+ID4gYWZlLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc291bmQvbWVkaWF0ZWssbXQ4MTg4LQ0KPiA+IGFmZS55YW1sDQo+ID4gQEAgLTI5LDYgKzI5
LDEwIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy9waGFuZGxlDQo+ID4gICAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgb2Yg
dGhlIG1lZGlhdGVrIHRvcGNrZ2VuIGNvbnRyb2xsZXINCj4gPiANCj4gPiArICBtZWRpYXRlayxp
bmZyYWNmZzoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25z
L3BoYW5kbGUNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBvZiB0aGUgbWVkaWF0
ZWsgaW5mcmFjZmcgY29udHJvbGxlcg0KPiA+ICsNCj4gPiAgICBwb3dlci1kb21haW5zOg0KPiA+
ICAgICAgbWF4SXRlbXM6IDENCj4gPiANCj4gPiBAQCAtNTIsNiArNTYsNyBAQCBwcm9wZXJ0aWVz
Og0KPiA+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBtdXggZm9yIGkyc2kxX21jaw0KPiA+ICAgICAg
ICAtIGRlc2NyaXB0aW9uOiBtdXggZm9yIGkyc2kyX21jaw0KPiA+ICAgICAgICAtIGRlc2NyaXB0
aW9uOiBhdWRpbyAyNm0gY2xvY2sNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogYXVkaW8gcGxs
MSBkaXZpZGUgNA0KPiA+IA0KPiA+ICAgIGNsb2NrLW5hbWVzOg0KPiA+ICAgICAgaXRlbXM6DQo+
ID4gQEAgLTczLDYgKzc4LDcgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgLSBjb25zdDogaTJz
aTFfbV9zZWwNCj4gPiAgICAgICAgLSBjb25zdDogaTJzaTJfbV9zZWwNCj4gPiAgICAgICAgLSBj
b25zdDogYWRzcF9hdWRpb18yNm0NCj4gPiArICAgICAgLSBjb25zdDogYXBsbDFfZDQNCj4gPiAN
Cj4gPiAgICBtZWRpYXRlayxldGRtLWluMS1jb3dvcmstc291cmNlOg0KPiA+ICAgICAgJHJlZjog
L3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gQEAgLTE0Nyw2ICsx
NTMsOCBAQCByZXF1aXJlZDoNCj4gPiAgICAtIHBvd2VyLWRvbWFpbnMNCj4gPiAgICAtIGNsb2Nr
cw0KPiA+ICAgIC0gY2xvY2stbmFtZXMNCj4gPiArICAtIGFzc2lnbmVkLWNsb2Nrcw0KPiA+ICsg
IC0gYXNzaWduZWQtY2xvY2stcGFyZW50cw0KPiANCj4gWW91IHdlcmUgZXhwbGFpbmluZyBpdCBs
YXN0IHRpbWUsIGJ1dCBpdCBkaWQgbm90IHNvbHZlIG15IGNvbmNlcm5zLg0KPiBSZXF1aXJpbmcg
dGhlc2UgcHJvcGVydGllcyBtZWFucyB0aGF0IHlvdXIgaGFyZHdhcmUgYm9vdHMgd2l0aA0KPiBp
bmNvcnJlY3QNCj4gY2xvY2sgcGFyZW50cywgaW5jbHVkaW5nIHJlc3VsdCBvZiBhbnkgZmlybXdh
cmUsIGFuZCB0aGVyZSBpcyBubyB3YXkNCj4gaXQNCj4gY2FuIGNvcnJlY3RseSB3b3JrIHdpdGhv
dXQgcmVwYXJlbnRpbmcuIFdoYXQncyBtb3JlLCB0aGlzIG1lYW5zIHRoYXQNCj4geW91ciBjbG9j
ayBoaWVyYXJjaHkgZG9lcyBub3QgaW5jbHVkZSB0aGVzZSBjbG9ja3MgZm9yIHNvbWUgcmVhc29u
LA0KPiBlLmcuDQo+IHlvdSBuZWVkIHRvIHJlcGFyZW50IHBhcmVudHMgb2Ygc29tZSBwYXJlbnQg
b2YgeW91ciBjbG9jayBpbnB1dCwNCj4gb3RoZXJ3aXNlIGRldmljZSBjYW5ub3Qgd29yay4gQ2Fu
bm90IHdvcmsgbmV2ZXIgZXZlci4NCj4gDQo+IElzIHRoaXMgdGhlIGNhc2U/DQoNClRoYW5rcyBm
b3IgeW91ciBkZXRhaWxlZCBleHBsYW5hdGlvbi4NCkkganVzdCB0cmllZCB0byBpbml0aWFsaXpl
IHRoZSBjbG9jayB0byBhbm90aGVyIGNsb2NrIHBhcmVudCBmb3IgcG93ZXINCnNhdmluZywgc28g
dGhpcyBpcyBub3QgdGhlIGNhc2UuIEluIG90aGVyIHdvcmRzLCBpdCdzIG5vdCBhICJtdXN0IGJl
Ig0KcHJvcGVydHkuIEkgd2lsbCByZW1vdmUgdGhlbSBpbiBWMy4NCg0KVGhhbmtzLA0KVHJldm9y
DQoNCj4gDQo+IEhhdmUgaW4gbWluZCB0aGF0IGJpbmRpbmdzIGFyZSB1c2VkIGFsc28gYnkgb3Ro
ZXIgT1MgYW5kIHByb2plY3RzLA0KPiBsaWtlDQo+IGJvb3Rsb2FkZXJzLCBmaXJtd2FyZSBldGMu
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg==
