Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9042658A69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiL2ITn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiL2ITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:19:35 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEC7B33;
        Thu, 29 Dec 2022 00:19:18 -0800 (PST)
X-UUID: d4fb3368688b48d59169598c03f4a142-20221229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HNcvfCB+NG7qCX7xJcLcz4gRp3uA+/XJQ+m6KPdjSok=;
        b=M/AOKyzjVCiuUBIiqm1hPZhzyEf4G8KVBtuE3OaROpKZVJGvhwqWcB1IXtWp1fE1q/xOBUncf/BQWwHJYb+iNOVfkZgeTNKBshan6xEN77kn07GRwB9fS3cYoEVl/t/isDFM19NksGCoHbtJIRb3WAqh1UUkvsAmRzWxXhh9J2Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:cc36f8fd-352d-4c6c-89f6-54467938715c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:cc36f8fd-352d-4c6c-89f6-54467938715c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:eda748f4-ff42-4fb0-b929-626456a83c14,B
        ulkID:221228152944ECW7M9HY,BulkQuantity:12,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: d4fb3368688b48d59169598c03f4a142-20221229
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <kyrie.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1818947159; Thu, 29 Dec 2022 16:19:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 29 Dec 2022 16:19:09 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 29 Dec 2022 16:19:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1niFftUSJ51I3c+xJ/lRhC5wPO+kY7O4x6FzKVQgYmKzS+6o7f7drJJFmOMUwloDR0Qhz/xC3vsMyB/qXlBq5ViD5yrdQLKas8I8laCBJEcGSpGuKp3fHhp1mwWSLU1NYgZx1QFeM5WWAW2Q8mDmdol6P/0hxi+6Il9TGqZNiCqGybQ0uAKiLps3vdGjrywk5Tj5fYOstuJBFCEo9P7HNiXhuzLmKvIAEMAJs2dGAhwje0PY0VfGdruNEHBjMLQDShwjfDwuNv9CH1WiD3G81IpbxmGd9HydzJdKFU+B66QPNa4xk7Wd2gbaW6W89I6SQEbbWv1YSWbE0QchY0R1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNcvfCB+NG7qCX7xJcLcz4gRp3uA+/XJQ+m6KPdjSok=;
 b=j180RmnHtZw95LZdYO65qPE0q8rHrnL9yvzN9Rl4MQVdWWnOOfHxrWYvDJoko3U80ZnSKXeUA+1ZyXN5OnlITt+fFfSPJgY635cMid0pu5+dBkbsIMpV2fpNUIqNQw9TN8k81Jzm26rouSCbER9Z744wqq5YW9Xpyv7obuTDkaoPIZTA8tadIfm0jZcQbIebyaLRLeRSEYXlnP5DYYoFc3Ea16DRdFs5pJV92OJ2K1vsdNgyphVuztCGIU8KqnXt3d0OhXNRFwGqbTPsb/YyJkey9n0NJnBaUiWYDnU9otFpWb2wRX7cXkvEBoHvw7mueizEufLqDFjrJ9nQGZ1BJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNcvfCB+NG7qCX7xJcLcz4gRp3uA+/XJQ+m6KPdjSok=;
 b=AH62po6nwO94rWk98n2v+GkCfB/07PgSOfTbqupoLy0pWQcurcKB1CcNRGuSHscBGYIuLEQmjZnfwnDMJNlgfFGvzHXnDrI9e4ec57RiLQjfndG268tXJHD53sgPOjvFqSKQvMPXz65Tr8ElHcVC9JVLNJLbt4QSB0kRwsEmTeo=
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com (2603:1096:301:b9::5)
 by KL1PR03MB6272.apcprd03.prod.outlook.com (2603:1096:820:a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.17; Thu, 29 Dec
 2022 08:19:07 +0000
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::c77c:2f56:104e:3ffd]) by PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::c77c:2f56:104e:3ffd%7]) with mapi id 15.20.5944.016; Thu, 29 Dec 2022
 08:19:07 +0000
From:   =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>
To:     "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>,
        =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?WGlhIEppYW5nICjmsZ/pnJ4p?= <Xia.Jiang@mediatek.com>
Subject: Re: [V2] media: jpeg: Fix multi-hw judgement
Thread-Topic: [V2] media: jpeg: Fix multi-hw judgement
Thread-Index: AQHZEQHzckg8C/GLFkqeWepbendq8q6DTiYAgAFMRIA=
Date:   Thu, 29 Dec 2022 08:19:07 +0000
Message-ID: <0846a7d726135d28f1da2a94eaa4c978754f9d2f.camel@mediatek.com>
References: <20221216035247.18816-1-irui.wang@mediatek.com>
         <Y6w2wG2MlIiHlkr/@debian.me>
In-Reply-To: <Y6w2wG2MlIiHlkr/@debian.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB6186:EE_|KL1PR03MB6272:EE_
x-ms-office365-filtering-correlation-id: 168974d9-e7e2-4cdd-9632-08dae9755b05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jLoluS0dvGzpaQuGygPE7db216/8vdt9I+ZRsKlnVyvyxsUSl/T+nFYbMEhymQrwEUcnUTocbVeo/kPkNGHOeY1r+UaiYVhR4YYuTjT5r9eRzj4RI4OlsNYvlGEa8BxVnUJvZXbQSS0Ly3dEa1grFyCSIV/3FJygZjUFCCKgNvUr5nI2XyCCMR8A6hlLHPsv7YPDVwuiSBlbShaS/2sB76a9RLN9Q4oQ13uqDYvGPdiGEpdcYYuXlznvB573inOyvA85e0/MuFHg/ybwBCy7P64JeVWgW9jCR90hc5TvY/Yb5fhgB8THC/BSnndgkN/0WEACNzz5ZJUAfCKTwG+9QdHvwEEOqWr8EmtWg5i/EnykE6JV0uv638merGRixVyMgOFEqTM2VyZwTCluv7v5xgIB9lnQ+a1nNujsGhH9AjYgqaKNT3QHOXXec1EPZDDx1i4nq8kVIbvQOcxkHvXrthQnkdu1+8kxOYinHjICHKWJIuzlZOW0o+Cza5C+F2kVyCA9cms2b8fwuUSXAoeteXSFqUJn2Cnzv+ZACtwoNm1a2UZ8oUG56HX0p4+FZX7Ss+eyavN18q8vmvc1pyhWdGHOGRwrIi4ARRe6lZHQCww3LzIpLEI/IGkWnkqhiiTvIcBYDmBzJysD5DshfncdsU4F1ie17HRHwOlXgA/6aXd6W/vO/kh53Z3Cdh9mGTFT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6186.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(122000001)(36756003)(85182001)(41300700001)(5660300002)(8936002)(7416002)(4744005)(2906002)(8676002)(64756008)(76116006)(66446008)(91956017)(66946007)(66476007)(66556008)(86362001)(4001150100001)(4326008)(54906003)(71200400001)(6506007)(110136005)(316002)(38070700005)(38100700002)(478600001)(6486002)(83380400001)(26005)(186003)(107886003)(6512007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG1lVXBTd3BPTmRXUFdkUE1pYzR6Vi92cy9HOFJMSytMQm90WHZVVzBkOXRi?=
 =?utf-8?B?L2dMTXNVSVVJWFJ0Z0l6ZW1TUi8vNmhyblRON3NqNGcxb0dGRWJLYkRkUXZo?=
 =?utf-8?B?cUIxVSthdVhBOTBxMi94a3pLMHNwZWlISGtQMzN1OGlLRnYxNXBkdnUxV0lm?=
 =?utf-8?B?d1g4cmdOUzdIUHJiT1Rab2NzK3NlaXJWRTg5bDl0UjdWcHFiU2hzL2JlcVdh?=
 =?utf-8?B?U2VjSFlGUUFBR3ZnY1hRRERTdVIxZ1NzVkU3WU9ZL1AzYXpaUFp6MU1SMWV2?=
 =?utf-8?B?WjR6QVJnOUFhRThGYXljY3RiMnpLUWVTSDFER0VFN2Z1RjlvYXR3Z21MR0RT?=
 =?utf-8?B?QVlUSTBpQXF5WklBclpvalF4bWl2MU83ZW5xZ1FaOURUUFlqTFEydEg4cTd5?=
 =?utf-8?B?NlF6cDFtNU8xclRudkE3V2haaGNIbEJGNWkrQWQ2YWh6eEU5cTFvSmJQekM1?=
 =?utf-8?B?QXU3WVFjUVJOZExqQzh1V0I2WHcvRU9XSU1wMVlnVjNqbjRaOEdMdkZjanpa?=
 =?utf-8?B?SXZTNk9acDJveXhHTW1Ea1kzRGJRaEltSVIwQUt6eXBrOURiVjNWei9pWVlJ?=
 =?utf-8?B?ejRlSng1R3hXaUpUcVpWNUJMOFlDREhPcVpDM1h1MkNtSlNvYXR4Sm9JWTFI?=
 =?utf-8?B?NmFPdXFHNlJrYU5ZNGFlbm0yeVkvcDVLbEpUNzBmeFEvcGU4Q1J4Qm5WMG52?=
 =?utf-8?B?U09oc1dFSWZVdXI4WXlvbDFqdWRkYld6NWhlempRU1JYbUdlNktCN1hiZVBE?=
 =?utf-8?B?aVRHMnpLeFY2NTdIazR5MDhYeTgrSnJrd2J2d0dUdjlwaVFxSkpXcVNIVlhk?=
 =?utf-8?B?MnlVWE5TRGUvemdlOGlha3RWdVhtVEJxM1RVTVdyNE0yNFFUVWNLTUxSeTdU?=
 =?utf-8?B?b1hST0twVHptSVlmeDFVQlhiRmpqMFk4RWs2MXV3Zkx2NTh0QWtObnYvME9m?=
 =?utf-8?B?VVIzbGdrOW4xUG4xbm9HK2VsNU4yY294VDZZeElUR01qNE1HQmRtRU0vWjd0?=
 =?utf-8?B?d3gzWHdPMHBnOW9rN2tqUE9TcmdEb244UHBtSzFGQlNKWW1CQkFOMHdzWHRQ?=
 =?utf-8?B?UGNyMWZ6U0hSdzNzT0loaEJLcnpDUHh5QVcwOTlBUkhvdUxjUEFlRWsvN3o1?=
 =?utf-8?B?TXlTZWRVMUhjRWo2MjV3UlBKUWdqOWw1a3NwZmtreTlJNWtHeXJKeFp1Wmhn?=
 =?utf-8?B?bS96QzQ3Lzgza0FuaFViSTZFb0wvUC9yQnI4MzZ3U2tRazRrV0toeHlkUmkx?=
 =?utf-8?B?UFhxNURWUE9qK1JUSXczcVA5djFrSFBpaE1SY1Q4dHc3d24rQmloLzZhdzMw?=
 =?utf-8?B?SXFZcnNLVkVlVnZRMk5zTGtiVWNIQUkwUkhrRG1FcXdTanpBOHBaaXUrK1oz?=
 =?utf-8?B?b0Z2WkkzOGVxcktDSjAzcmxMR1hVWlBQekNaUklWYnFNQjUvWjJ2UzBob05C?=
 =?utf-8?B?ZUQrT09OaUJJaTVrWkRPaUtjaVBGNVhWN0IwWkhGbWtrc2NLNTZ0bFNPR2d0?=
 =?utf-8?B?Vlo3azdzR0lrZ0ZKVmh2Vk9aclo0cjMra0t6WGNMUVBXUElsOXdXRzJhVzdP?=
 =?utf-8?B?TWo2MlZqcWZiWXZrK2IxWFBoa2xPOUg5ZE9nSW96R0svbzJnTS9TS2o4RCs0?=
 =?utf-8?B?M0VxS1RHZTE3VW8wTGtQQWZsU21iTjgwbVVUSFNpTGxyYVhnenNMTVNmRFBr?=
 =?utf-8?B?aTdpRldNbDhCOVRCVnYvWFpzYUhKTDZJMk9RWWhrWFNhTGVrS1dUYjFyRCtY?=
 =?utf-8?B?dkMxTEZ4WWJhRXErR3FRbXo0dUd2WTVVNXBxWXE4NE5PaTBKUjZrV01SWTZU?=
 =?utf-8?B?MmFuekJWeGN6TUd1MzRCMWFrRXlMb2REL1BoTlF6YXZTMGNsc1NmeDRRMjhG?=
 =?utf-8?B?Z0dCZmI0UjBubU1FM0VKaFc5eDg5SFZGbmlFYmVMMERxY3B5Y1ExcnJpTFRr?=
 =?utf-8?B?bGRZVGo5Vk9HNUdsUzR6R3ZuWDdGRjhzREl6TFZ2bXZDeFZiVThyelVyU0lG?=
 =?utf-8?B?aHp3aCtBMXpZYW1kR0IvRGhCeHJlaEtVTFNxV3VvRllFa0Z4QnNIaHFzb29E?=
 =?utf-8?B?WFp6WWtPdDVxblJid2dSRzR0STRQQ1dERTkvb0E0VWgrSVFvWWlMU0xwYjlE?=
 =?utf-8?B?OVFwcXBEVXRBTDh4VlNFWUpsN3pncEprYVlFZ3VMS2tML2tCbVNNR2ZFVGhD?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A6CAF3B00E31F4CBD65FB32CB5AB042@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6186.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168974d9-e7e2-4cdd-9632-08dae9755b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2022 08:19:07.3728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fot7Pl21WBBVc/BvC+vOUnQGemL7SZkqBECJMkcQgdhxOvzwtM4+lbk0TY+T1B3Gz7yZvusm4WvGaMvLImZ7NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6272
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTEyLTI4IGF0IDE5OjI5ICswNzAwLCBCYWdhcyBTYW5qYXlhIHdyb3RlOg0K
PiBPbiBGcmksIERlYyAxNiwgMjAyMiBhdCAxMTo1Mjo0N0FNICswODAwLCBJcnVpIFdhbmcgd3Jv
dGU6DQo+ID4gRnJvbToga3lyaWUgd3UgPGt5cmllLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiANCj4g
PiBzb21lIGNoaXBzIGhhdmUgbXVsdGktaHcsIGJ1dCBvdGhlcnMgaGF2ZSBvbmx5IG9uZSwNCj4g
PiBtb2RpZnkgdGhlIGNvbmRpdGlvbiBvZiBtdWx0aS1odyBqdWRnZW1lbnQNCj4gDQo+IG5pdDog
cy9qdWRnZW1lbnQvY29uZGl0aW9uYWwgYmxvY2svIC4uLg0KPiANCj4gPiAtCWlmIChsaXN0X2Vt
cHR5KCZwZGV2LT5kZXYuZGV2cmVzX2hlYWQpKSB7DQo+ID4gKwlpZiAoIWpwZWctPnZhcmlhbnQt
Pmh3X2FyY2gpIHsNCj4gDQo+IC4uLiBsaWtlIGhlcmUgKGlmIGJsb2NrKS4NCj4gDQo+IFRoYW5r
cy4NCg0KSGkgQmFnYXMsDQoNCkkgY2FuJ3QgZ2V0IHlvdXIgc3VnZ2VzdGlvbiBleGFjdGx5Lg0K
RG8geW91IG1lYW4gdG8gY2hhbmdlIGlmICguLi4pIGFzIGZvbGxvd3M6DQppZiAoanBlZy0+dmFy
aWFudC0+aHdfYXJjaCkNCj4gDQoNClRoYW5rcy4NCg0KUmVnYXJkcywNCkt5cmllLg0K
