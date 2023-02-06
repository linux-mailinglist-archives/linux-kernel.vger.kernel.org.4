Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E10468B87D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBFJVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBFJVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:21:10 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003501C30E;
        Mon,  6 Feb 2023 01:21:05 -0800 (PST)
X-UUID: 92f65578a5ff11eda06fc9ecc4dadd91-20230206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mVq7w8RM4aqbpYGDmW/8htZ1ZLCWQA88mMm33sL8WsI=;
        b=lvw+L3oq5jafTL+OWIGd1ngE96Ry6NcQ0+Z9grEfdPYk54gXKIqrXs1E2RWB8D9NaQpAfsY4JZQnsckCQMJWYT+Auoz0rkexjZVGLa9OCMKK5s4SKBhP1tICxVWPSC6nEvHKxiW2DcZcD/QsfB+E7vIAzcmiJ4lksJVXLsIVPK0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:9b3eba3c-bed7-44ae-8d48-0e2f187a08c2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:94bf6f56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 92f65578a5ff11eda06fc9ecc4dadd91-20230206
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1892400677; Mon, 06 Feb 2023 17:21:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 6 Feb 2023 17:21:00 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 6 Feb 2023 17:21:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwXG8+VyS8LpQdcz9zYNFFsXCNxGRmLxfkPcG2Ynl1phJc0zQO3S/5mTcEDaUCVM2HiGHpo+CGcocof3xAaWRicNTfEeoFs0c1lRmKzlgziqKRZWT1gbuAUvkoMC+FniXkXBg8kZI2zjLqhrKV85PiKluXUzlDhWlq/YB1ICE3ljWXrbBOcFlWTUcDvR19SfK/GYOOrdhU0u70quVF86M8SCTo4+OEKLYYAgG/rlCIONWYy3Ib8reaEgKXun8/i1fhFnvrSNIWBa2Rp5Ckjm8EEo9le6Ab4/W5xVj38kKwgu6MTfv7VljL6DorkFxMx2ZOs7o1+sF8y4lGO2u6661A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVq7w8RM4aqbpYGDmW/8htZ1ZLCWQA88mMm33sL8WsI=;
 b=b2rHKwTdzd2EQxG7YSkDRBXxpCwXZXJuSZ6o/Zjj1H30+A2Ce68TWsGqNXoy1Wdptz0yUbKY6YpUUFo92FE+Jjrfhouz6HEknNFpd1WMMdp5Gj+3UtsJGhrw69QPXRylORW508cLo+X8JxA8Kp5q9U3QhqMaevXvqMc+ZZ3sXh0W3BH6BppSV8bnAZrt+whHJ2aX58+DQ34hdTjgIk5bcOu3iPQiSNh26xIiz+0rVFkoSrS41yjWCC2HpF48D0f6ZCVkwWydvaKy3b11/hhtMRUfk0mN/aVF/1RftJRGikjlOp4Cr+28TTeegmo4FP+NxNw3Q3KV0Wu94r6WC5Pfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVq7w8RM4aqbpYGDmW/8htZ1ZLCWQA88mMm33sL8WsI=;
 b=tvzdy0lO847W/xlImKn6/MIZQDNcVpFzfyr4b6PKyEhCzXPbM29NzdiZ82PsSGfqSFvrolAOsSfKwuRDJCu0ZMR0cwDc9sdKDycXUC98OzLODnzjzpr1F07I9uFDdjrf6LDw4rhmktWLOkAM1i+rhPVvhZuzop94dr6yy/3IWcQ=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by TYZPR03MB5710.apcprd03.prod.outlook.com (2603:1096:400:8a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 09:20:57 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::ba47:a392:dffd:355f]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::ba47:a392:dffd:355f%7]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 09:20:57 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v6 0/6] add support for MT8195 VPPSYS on MMSYS and MUTEX
Thread-Topic: [PATCH v6 0/6] add support for MT8195 VPPSYS on MMSYS and MUTEX
Thread-Index: AQHZKuwELd0HB9+gFUm1p8I/g4Pd1a67sUUAgAAnegCABeoLAA==
Date:   Mon, 6 Feb 2023 09:20:57 +0000
Message-ID: <1b43b0d6156fdd0c079823698912842a6d4cf65e.camel@mediatek.com>
References: <20230118032122.29956-1-moudy.ho@mediatek.com>
         <cd82e2a1-dbf4-88ee-f658-f695ae9ef56a@gmail.com>
         <41eafd31-558d-613c-69ef-15230a80db5c@gmail.com>
In-Reply-To: <41eafd31-558d-613c-69ef-15230a80db5c@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|TYZPR03MB5710:EE_
x-ms-office365-filtering-correlation-id: 84d560ba-ac38-42ae-b61e-08db082374b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jE2npbTVj9Y/g0ebrCSdV6FbiFV1PyM4Eb/zeRvhHKASItqonJ1gNzmFAvCELFYBse1hEwNiUnOoEr+uKZhjuPrjjAWYMNz262AV/bFaAujTCS6CbXyz7mJNndLRIfKV6CcNScoZxlLMrk6ITNxmyQyV+baIm2srxjTylOf/oKMHllDJ7yEyi6Nsc7GxHs9yN5j+HtKGj4cJq237sN1VnrhfBONgSUgHJ5e4R0n6NztWZPIgg4EA1Q/O8ff4v8bYdkWgTVGsiR8D61ERCX1JauzMlxwXFso8+dpEEuk8qSnqvbgkbn7ZcLlaWpaOazh4uC3nQz3WNtEZwoIiNotgcISlTHZafLzwsvd4kxIqg64UtRRV2ZEcBUZEgx8YPrvt9808rlQCM7WyEI4EUllZ7vo3SNazdE8oWEQfZRArY/gwvs6J58ukklNjBxehxUWogy1RvIMGXAVoO5Tgrmo83CEK4503stW4Fbl8OmynGiIgAYRgVfBwctiuP2x0VJH6Q1yh3XfpbAPvCb70o2XEH8KCQLX1Pl4Hmc92scZJ0tSZzsSVUsW/C855ZuBOyI1DeeTFPVtkyGXfmrrqSIiFa7mmkdOaA0hm9V5AUWjPq1fOhBzObj8h9KJX75642lhaA3rOQ3aJGd1sbC3jG8TzwKpDmUZNAmPLvpc5DVBumwwFM909oz4yg0daG4KE9Uv/GfSMCEEezjBOJoZ6TImPSATI0FWosgugH01fq+K76xt8pOepDCcUyiijPWDmK6a/IblN2v/cJFMr2kX7/VQTUd8PTtBh45z9jQYB9YKpH1a1/9CDV/zhSqloSvpmp+DSBdukkLDWkqBwmZwxRlom9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(2616005)(38100700002)(122000001)(110136005)(5660300002)(7416002)(316002)(54906003)(83380400001)(38070700005)(36756003)(85182001)(86362001)(8936002)(6486002)(966005)(2906002)(71200400001)(66946007)(66476007)(186003)(6512007)(26005)(478600001)(76116006)(91956017)(8676002)(66446008)(66556008)(4326008)(53546011)(64756008)(6506007)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmJhZHBOWE5vTlBZb1RGUGQzQjlVUENMZXlVY0xPbHlkdEkrNU40THgweXpx?=
 =?utf-8?B?cG50TGxQNXF6bnJmdFB1N205V0cyVlVaSkVuemJnWjIvUkN6bHI0c0dka25Q?=
 =?utf-8?B?TzJneGFNV2JqK1RDUm16Tm5pdk1XK3F6V2RkcHFUS2k5Nk5KM2Q0OWhyeEhK?=
 =?utf-8?B?SlRHQnhhVmJCODZUK0wyN3Y4N3ZNN3RGOU9PR2J3TkhQdzlqY3RxQzlzTDZu?=
 =?utf-8?B?LzQ3Sm9mZGJtbUlvK2RqajBvS0cxTDFwWWt0VXU4YUoyajdPUUdNb2ViYm1V?=
 =?utf-8?B?d1JEWkpFeElIeVFlZzEvTVV0ZmFySitLRDZHazdCSjcwclJKQ0xEZTZxcjdh?=
 =?utf-8?B?Rjl5ekFWTC9LMUR2azBmM0JkdHorazJOOEEyZGQ3dFhiUTNCaHBrMHplY3ho?=
 =?utf-8?B?SU9yYjArWFdFYXd1UnFrbXdUSHpGS2FtNm1VSGRiOVcyTTFVV0ZscHNPRFRk?=
 =?utf-8?B?MjJQaEpLcHJGVXozYmFQaDVRTkJQQnV4RzNhenRWUVVKOGFERUExelJ1Z1VI?=
 =?utf-8?B?MldDdVpjaE94anZSNE80TFA0SGJ4SnJMVGlaS0dSOFZUc3I3bW96NlRuQUZQ?=
 =?utf-8?B?djRpL0FDV1BRQnZ4MGhRRWV6SnRIWUhuQytUL3VCeHhUbVlzT3Q5dlZ2YnpY?=
 =?utf-8?B?NnByM0E5NVk1TUwyRHJYc0hKV3JRZWtvNTMrUTF1bjNMejh4clNwU3Nmb0Vu?=
 =?utf-8?B?QXVNOU1Rd0k4eTcvcTltYUJnalk2UHNMcE1XZE55WDdtSmlvYmdSMXZ6dmZE?=
 =?utf-8?B?UTlCZ2l4ZFZMRlJVT0Qvb1VJSnJOSGRoTUJ6VWw5MFpTd3pXNkJFRW15eEJ2?=
 =?utf-8?B?UmUzZWpuT3JnRU5qNnVZdDROZDVnQjM3NFJ3dWtBVHJvL1dXczJFMTNMVitO?=
 =?utf-8?B?UG84NThhRjNabTZVdm92emkxMGZvUFpoZll3b01GZ0oxV1dmOGVXMUxZZUQr?=
 =?utf-8?B?MWEyNE92YkNhUkRxQ2ZwZEdKVCtONEQveXZBNm01WjZDWXl0ZzJLVGFMREk4?=
 =?utf-8?B?QXR2VDlWemRFOWx1bmlDUmEyVWNvblhFWmovbjdFRCtXOEJpd3VmSm1DTWlm?=
 =?utf-8?B?M092blhXVXQ2czgyVVdmQjkrVG1teW5TSkYrZEVNRk1mWFZhcnA5RGU2ZTNJ?=
 =?utf-8?B?QVFuakRTN3dGOXAvbkZlOUNjelBhVytucjRZVUQ4RitLdFhpYm9qUUx5eVlt?=
 =?utf-8?B?STFyUHNZc05GZTZmOFd5OUtBZGh4dG8xWmNmUVVYT0RDdGxwQ0JNU2l4MENi?=
 =?utf-8?B?d2NIODgvMjdSNzB1WllCWFg0dFRxd0VNbEJMTU0vMnJ1VmxqbDIrTFQrbml2?=
 =?utf-8?B?MmxCcGtQWjBuaWJoNE0xV1l3d2RESjYrRnhOWEVEUDFMR0orQklCd2ZPeVgv?=
 =?utf-8?B?OE01c3Z1VzRZL081VG10ZlBVTHFPU1FEYlNvVTVtM0JYd0lteWtDekhRekhS?=
 =?utf-8?B?a1VGYWJhTGlxSjZmTzIvdUxkMGticEM0QjR2UUFuTGFWVXpBbnZmNWlHVExr?=
 =?utf-8?B?c1dhNkR0Nkd6NGtKTWRlYXpYU1J3VGF4NWg1cGgySjdMN2MxZ3B2U055NW5t?=
 =?utf-8?B?T3E5UEdabGhGMWdXSFJVY293ckJITzZTR2xkOTczRjdnU1BJc3FMK2pSVFhu?=
 =?utf-8?B?L2owWGJzQXpTYTZ2TWVOSmNWQzVJeVIwQm15Qjd1Vk5EeEFhYzFjUVcwZFBW?=
 =?utf-8?B?WEJ3eFZBTW04SThzY0pveEcrbEZMdmQ3aFRwZUd6aTc5NkV4MkRNdU1BVWNY?=
 =?utf-8?B?L1UyZHhVN1prMVJPQVBONkRtR1hkZ2l6TURLTmxVOTErSjZzdTJSVEhXYmE2?=
 =?utf-8?B?S2FXTXFOMlVpdVBTM0NqY1VLazcxT1hRK1lka0tQejQwNHl3K0Z3SG80b29R?=
 =?utf-8?B?MDh0UDRqWnVwc3liaVUvOTNKS2NoY0xJNGZyWCsvSEtyNHJtOVBDU0NrT09I?=
 =?utf-8?B?cXVrU1FCTUg2SjZlbVc4aVUxYUhkc1lrOFZnb0d5WisvY1czQTFRak45Nllu?=
 =?utf-8?B?VVFKSzZQMmVKVXpEUHZTYWNTeEZ0QWNjRVd1ajJsbVdLanVQUnFwK2NzUGg2?=
 =?utf-8?B?TmpISUFodnZGMnlyWEM3aVNuV2d6bGgycW5nNlpxbUl5VUdGYTJ1dklrdEM2?=
 =?utf-8?B?a3RHRzhkTC8rTy9UblFKTWlpQ2x0V1BxMXdYYm0zc3hEcjFGTkJtTGVIMzJu?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37F7CDAFEBE63A46AC248C4B12B11B97@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d560ba-ac38-42ae-b61e-08db082374b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 09:20:57.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qvr/KG7KdVK7AWrQRVOBPMVY8oPBaG8j91HFGwYE1qiAnh+bVZTWxjB9sJ124mn3mk148EPxB+wZJm5qrH2Wmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5710
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTAyIGF0IDE2OjAxICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMDIvMDIvMjAyMyAxMzo0MCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4g
PiBXaG9sZSBzZXJpZXMgcXVldWVkIGZvciB0aGUgbmV4dCBtZXJnZSB3aW5kb3cuDQo+ID4gDQo+
IA0KPiBJIGVuY291bnRlcmVkIHNvbWUgY29tcGlsZSBlcnJvcnMsIHNvIEkgZGVsZXRlZCB0aGUg
d2hvbGUgc2VyaWVzLA0KPiBwbGVhc2UgZml4IGFuZCANCj4gcmVzdWJtaXQuIFRoYW5rcw0KPiAN
Cj4gZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmM6IEluIGZ1bmN0aW9uDQo+ICdtdGtf
bW1zeXNfdnBwX3Jzel9tZXJnZV9jb25maWcnOg0KPiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
bW1zeXMuYzoyNjE6OTogZXJyb3I6IHRvbyBmZXcgYXJndW1lbnRzIHRvDQo+IGZ1bmN0aW9uIA0K
PiAnbXRrX21tc3lzX3VwZGF0ZV9iaXRzJw0KPiAgICAyNjEgfCAgICAgICAgIG10a19tbXN5c191
cGRhdGVfYml0cyhkZXZfZ2V0X2RydmRhdGEoZGV2KSwgcmVnLCB+MCwNCj4gZW5hYmxlKTsNCj4g
ICAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLW1tc3lzLmM6MTI5OjEzOiBub3RlOiBkZWNsYXJlZCBoZXJlDQo+ICAgIDEyOSB8
IHN0YXRpYyB2b2lkIG10a19tbXN5c191cGRhdGVfYml0cyhzdHJ1Y3QgbXRrX21tc3lzICptbXN5
cywNCj4gdTMyIG9mZnNldCwgDQo+IHUzMiBtYXNrLCB1MzIgdmFsLA0KPiAgICAgICAgfCAgICAg
ICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LW1tc3lzLmM6IEluIGZ1bmN0aW9uDQo+ICdtdGtfbW1zeXNfdnBwX3Jzel9kY21fY29uZmlnJzoN
Cj4gZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmM6MjcwOjk6IGVycm9yOiB0b28gZmV3
IGFyZ3VtZW50cyB0bw0KPiBmdW5jdGlvbiANCj4gJ210a19tbXN5c191cGRhdGVfYml0cycNCj4g
ICAgMjcwIHwgICAgICAgICBtdGtfbW1zeXNfdXBkYXRlX2JpdHMoZGV2X2dldF9kcnZkYXRhKGRl
diksDQo+ICAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IGRyaXZlcnMv
c29jL21lZGlhdGVrL210ay1tbXN5cy5jOjEyOToxMzogbm90ZTogZGVjbGFyZWQgaGVyZQ0KPiAg
ICAxMjkgfCBzdGF0aWMgdm9pZCBtdGtfbW1zeXNfdXBkYXRlX2JpdHMoc3RydWN0IG10a19tbXN5
cyAqbW1zeXMsDQo+IHUzMiBvZmZzZXQsIA0KPiB1MzIgbWFzaywgdTMyIHZhbCwNCj4gICAgICAg
IHwgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IGRyaXZlcnMvc29jL21lZGlh
dGVrL210ay1tbXN5cy5jOjI3Mzo5OiBlcnJvcjogdG9vIGZldyBhcmd1bWVudHMgdG8NCj4gZnVu
Y3Rpb24gDQo+ICdtdGtfbW1zeXNfdXBkYXRlX2JpdHMnDQo+ICAgIDI3MyB8ICAgICAgICAgbXRr
X21tc3lzX3VwZGF0ZV9iaXRzKGRldl9nZXRfZHJ2ZGF0YShkZXYpLA0KPiAgICAgICAgfCAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstbW1z
eXMuYzoxMjk6MTM6IG5vdGU6IGRlY2xhcmVkIGhlcmUNCj4gICAgMTI5IHwgc3RhdGljIHZvaWQg
bXRrX21tc3lzX3VwZGF0ZV9iaXRzKHN0cnVjdCBtdGtfbW1zeXMgKm1tc3lzLA0KPiB1MzIgb2Zm
c2V0LCANCj4gdTMyIG1hc2ssIHUzMiB2YWwsDQo+ICAgICAgICB8ICAgICAgICAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn5+fg0KPiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstbW1zeXMuYzoyNzg6
OTogZXJyb3I6IHRvbyBmZXcgYXJndW1lbnRzIHRvDQo+IGZ1bmN0aW9uIA0KPiAnbXRrX21tc3lz
X3VwZGF0ZV9iaXRzJw0KPiAgICAyNzggfCAgICAgICAgIG10a19tbXN5c191cGRhdGVfYml0cyhk
ZXZfZ2V0X2RydmRhdGEoZGV2KSwNCj4gICAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fn4NCj4gZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmM6MTI5OjEzOiBub3RlOiBk
ZWNsYXJlZCBoZXJlDQo+ICAgIDEyOSB8IHN0YXRpYyB2b2lkIG10a19tbXN5c191cGRhdGVfYml0
cyhzdHJ1Y3QgbXRrX21tc3lzICptbXN5cywNCj4gdTMyIG9mZnNldCwgDQo+IHUzMiBtYXNrLCB1
MzIgdmFsLA0KPiAgICAgICAgfCAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4g
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmM6MjgxOjk6IGVycm9yOiB0b28gZmV3IGFy
Z3VtZW50cyB0bw0KPiBmdW5jdGlvbiANCj4gJ210a19tbXN5c191cGRhdGVfYml0cycNCj4gICAg
MjgxIHwgICAgICAgICBtdGtfbW1zeXNfdXBkYXRlX2JpdHMoZGV2X2dldF9kcnZkYXRhKGRldiks
DQo+ICAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IGRyaXZlcnMvc29j
L21lZGlhdGVrL210ay1tbXN5cy5jOjEyOToxMzogbm90ZTogZGVjbGFyZWQgaGVyZQ0KPiAgICAx
MjkgfCBzdGF0aWMgdm9pZCBtdGtfbW1zeXNfdXBkYXRlX2JpdHMoc3RydWN0IG10a19tbXN5cyAq
bW1zeXMsDQo+IHUzMiBvZmZzZXQsIA0KPiB1MzIgbWFzaywgdTMyIHZhbCwNCj4gICAgICAgIHwg
ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0
aGlhcw0KPiANCg0KSGkgTWF0dGhpYXMsDQoNClNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZSwg
dGhlIHY3IHdpdGggY29ycmVjdGlvbnMgaGFzIGJlZW4gc2VudC4NCmh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9NzE5MDUwDQoN
ClJlZ2FyZHMsDQpNb3VkeQ0KDQo+ID4gVGhhbmtzIQ0KPiA+IA0KPiA+IE9uIDE4LzAxLzIwMjMg
MDQ6MjEsIE1vdWR5IEhvIHdyb3RlOg0KPiA+ID4gQ2hhbmdlcyBzaW5jZSB2NToNCj4gPiA+IC0g
RGVwZW5kIG9uIDoNCj4gPiA+ICAgIFsxXSANCj4gPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsv
bGlzdC8/c2VyaWVzPTcxMzAzMV9fOyEhQ1RSTktBOXdNZzBBUmJ3IWh1ZGd1ZDlZUmh0UHhmNmlF
WjlNUk02QzlYVkdPSVBTOFV2emMtVktvUUdaRGdCQkNmLVhxd1NvQksxRmdxd2g1OURVWDNrVWNz
YURNNk9mbU1pT2NMayTCoA0KPiA+ID4gIA0KPiA+ID4gDQo+ID4gPiBDaGFuZ2VzIHNpbmNlIHY0
Og0KPiA+ID4gLSBSZWJhc2Ugb24gbGludXgtbmV4dC4NCj4gPiA+IC0gUmVtb3ZlIE1NU1lTIGZh
bGxiYWNrIGNvbXBhdGlibGUuDQo+ID4gPiAtIE1pZ3JhdGUgTVQ4MTk1IFZQUFNZUzAvMSBmcm9t
IGNsb2NrIHRvIG10ay1tbXN5cyBkcml2ZXIuDQo+ID4gPiANCj4gPiA+IENoYW5nZXMgc2luY2Ug
djM6DQo+ID4gPiAtIFJlYmFzZSBvbiBsaW51eC1uZXh0Lg0KPiA+ID4gDQo+ID4gPiBDaGFuZ2Vz
IHNpbmNlIHYyOg0KPiA+ID4gLSBEZXBlbmQgb24gOg0KPiA+ID4gICAgWzFdIA0KPiA+ID4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9NjgxMDk3X187ISFDVFJOS0E5d01nMEFS
YnchaHVkZ3VkOVlSaHRQeGY2aUVaOU1STTZDOVhWR09JUFM4VXZ6Yy1WS29RR1pEZ0JCQ2YtWHF3
U29CSzFGZ3F3aDU5RFVYM2tVY3NhRE02T2ZwckVFUGd3JMKgDQo+ID4gPiAgDQo+ID4gPiAtIFNw
bGl0IGR0cyBzZXR0aW5ncyBpbnRvIHR3byBwYXRjaGVzIGJhc2VkIG9uIGJlbG9uZ2luZyB0byBN
TVNZUw0KPiA+ID4gb3IgTVVURVguDQo+ID4gPiANCj4gPiA+IENoYW5nZXMgc2luY2UgdjE6DQo+
ID4gPiAtIERlcGVuZCBvbiA6DQo+ID4gPiAgICBbMV0gDQo+ID4gPiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1l
ZGlhdGVrL2xpc3QvP3Nlcmllcz02ODEwOTdfXzshIUNUUk5LQTl3TWcwQVJidyFodWRndWQ5WVJo
dFB4ZjZpRVo5TVJNNkM5WFZHT0lQUzhVdnpjLVZLb1FHWkRnQkJDZi1YcXdTb0JLMUZncXdoNTlE
VVgza1Vjc2FETTZPZnByRUVQZ3ckwqANCj4gPiA+ICANCj4gPiA+IC0gQWRkIGNvbXBhdGlibGUg
bmFtZXMgdG8gVlBQU1lTMCBhbmQgVlBQU1lTMSBpbiBNTVNZUyBiaW5kaW5nDQo+ID4gPiBmaWxl
Lg0KPiA+ID4gLSBGaXggVlBQU1lTJ3MgTU1TWVMgYW5kIE1VVEVYIGR0cyB0byBwYXNzIHRoZSBk
dHNiX2NoZWNrLg0KPiA+ID4gLSBSZW5hbWUgbXRrX21tc3lzX21lcmdlX2NvbmZpZygpIGFuZCBt
dGtfbW1zeXNfcnN6X2RjbV9jb25maWcoKQ0KPiA+ID4gdG8NCj4gPiA+ICAgIG10a19tbXN5c192
cHBfcnN6X21lcmdlX2NvbmZpZygpIGFuZA0KPiA+ID4gbXRrX21tc3lzX3ZwcF9yc3pfZGNtX2Nv
bmZpZygpLg0KPiA+ID4gLSBDbGVhbiB1cCBtdGtfbW1zeXNfdnBwX3Jzel9kY21fY29uZmlnKCku
DQo+ID4gPiAtIEFkZCBhIGNvbW1lbnQgdG8gbXRrX211dGV4X3dyaXRlX21vZCgpIGFuZCBjbGVh
biBpdCB1cCBmb3IgdXNlDQo+ID4gPiBpbiBtb3JlDQo+ID4gPiAgICB0aGFuIDMyIG1vZHMuDQo+
ID4gPiANCj4gPiA+IEhpLA0KPiA+ID4gDQo+ID4gPiBUaGlzIHNlcmllcyBhZGQgc3VwcG9ydCBm
b3IgTVQ4MTk1J3MgdHdvIFZQUFNZUyhWaWRlbyBQcm9jZXNzb3INCj4gPiA+IFBpcGUgU3Vic3lz
dGVtKSwNCj4gPiA+IHVuZGVyIHdoaWNoIHRoZXJlIHdpbGwgYmUgY29ycmVzcG9uZGluZyBNTVNZ
UyBhbmQgTVVURVggc2V0dGluZ3MNCj4gPiA+IHRoYXQNCj4gPiA+IG5lZWQgdG8gYmUgY29uZmln
dXJlZC4NCj4gPiA+IA0KPiA+ID4gTW91ZHkgSG8gKDEpOg0KPiA+ID4gICAgYXJtNjQ6IGR0czog
bWVkaWF0ZWs6IG10ODE5NTogYWRkIE1VVEVYIGNvbmZpZ3VyYXRpb24gZm9yDQo+ID4gPiBWUFBT
WVMNCj4gPiA+IA0KPiA+ID4gUm95LUNXLlllaCAoNSk6DQo+ID4gPiAgICBkdC1iaW5kaW5nczog
c29jOiBtZWRpYXRlazogQWRkIHN1cHBvcnQgZm9yIE1UODE5NSBWUFBTWVMNCj4gPiA+ICAgIGFy
bTY0OiBkdHM6IG1lZGlhdGVrOiBtdDgxOTU6IGFkZCBNTVNZUyBjb25maWd1cmF0aW9uIGZvcg0K
PiA+ID4gVlBQU1lTDQo+ID4gPiAgICBzb2M6IG1lZGlhdGVrOiBtbXN5czogYWRkIGNvbmZpZyBh
cGkgZm9yIFJTWiBzd2l0Y2hpbmcgYW5kIERDTQ0KPiA+ID4gICAgc29jOiBtZWRpYXRlazogbXV0
ZXg6IEFkZCBtdGtfbXV0ZXhfc2V0X21vZCBzdXBwb3J0IHRvIHNldA0KPiA+ID4gTU9EMQ0KPiA+
ID4gICAgc29jOiBtZWRpYXRlazogbXV0ZXg6IHN1cHBvcnQgTVQ4MTk1IFZQUFNZUw0KPiA+ID4g
DQo+ID4gPiAgIC4uLi9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvbWVkaWF0ZWssbXV0ZXgueWFtbCB8
ICAgMSArDQo+ID4gPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2kg
ICAgICB8ICAyNiArKystDQo+ID4gPiAgIGRyaXZlcnMvc29jL21lZGlhdGVrL210ODE5NS1tbXN5
cy5oICAgICAgICAgICB8ICAxMyArKw0KPiA+ID4gICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
bW1zeXMuYyAgICAgICAgICAgICAgfCAgNDIgKysrKysrDQo+ID4gPiAgIGRyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1tdXRleC5jICAgICAgICAgICAgICB8IDEzNQ0KPiA+ID4gKysrKysrKysrKysr
KysrKystDQo+ID4gPiAgIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1tbXN5cy5oICAg
ICAgICB8ICAgNCArDQo+ID4gPiAgIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1tdXRl
eC5oICAgICAgICB8ICAzNSArKysrKw0KPiA+ID4gICA3IGZpbGVzIGNoYW5nZWQsIDI0NSBpbnNl
cnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPiA+IA0K
